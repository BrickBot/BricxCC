/** \file NXCDefs.h
 * \brief Constants, macros, and API functions for NXC
 *
 * NXCDefs.h contains declarations for the NXC NXT API resources
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
 * \date 2010-06-10
 * \version 75
 */
#ifndef NXCDEFS_H
#define NXCDEFS_H

#include "NBCCommon.h"

/** @addtogroup MiscConstants
 * @{
 */
/** @defgroup TypeAliases Type aliases
 *  Short type aliases indicating signed/unsigned and bit count for each type.
 *  @{
 */
#define u8 unsigned char  /*!< Unsigned 8 bit type */
#define s8 char           /*!< Signed 8 bit type */
#define u16 unsigned int  /*!< Unsigned 16 bit type */
#define s16 int           /*!< Signed 16 bit type */
#define u32 unsigned long /*!< Unsigned 32 bit type */
#define s32 long          /*!< Signed 32 bit type */
/** @} */  // end of TypeAliases group
/** @} */  // end of MiscConstants group


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
#define SENSOR_LIGHT		_SENSOR_CFG(SENSOR_TYPE_LIGHT, SENSOR_MODE_PERCENT)          /*!< Light sensor in percent mode */
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
inline void SetSensorType(const byte & port, byte type) { asm { setin type, port, Type } }
/** \example ex_SetSensorType.nxc
 * This is an example of how to use the \ref SetSensorType function.
 */

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
inline void SetSensorMode(const byte & port, byte mode) { asm { setin mode, port, InputMode } }
/** \example ex_SetSensorMode.nxc
 * This is an example of how to use the \ref SetSensorMode function.
 */

/**
 * Clear a sensor value.
 * Clear the value of a sensor - only affects sensors that are configured
 * to measure a cumulative quantity such as rotation or a pulse count.
 * \param port The port to clear. See \ref InPorts.
 */
inline void ClearSensor(const byte & port) { asm { setin 0, port, ScaledValue } }
/** \example ex_ClearSensor.nxc
 * This is an example of how to use the \ref ClearSensor function.
 */

/**
 * Reset the sensor port.
 * Sets the invalid data flag on the specified port and waits for it to
 * become valid again. After changing the type or the mode of a sensor
 * port you must call this function to give the firmware time to reconfigure
 * the sensor port.
 * \param port The port to reset. See \ref InPorts.
 */
inline void ResetSensor(const byte & port) { asm { __ResetSensor(port) } }
/** \example ex_ResetSensor.nxc
 * This is an example of how to use the \ref ResetSensor function.
 */

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
    setin config>>8, port, Type
    setin config&0xff, port, InputMode
    __ResetSensor(port)
  }
}
/** \example ex_SetSensor.nxc
 * This is an example of how to use the \ref SetSensor function.
 */

/**
 * Configure a touch sensor.
 * Configure the sensor on the specified port as a touch sensor.
 * \param port The port to configure. See \ref InPorts.
 */
inline void SetSensorTouch(const byte & port) { asm { __SetSensorTouch(port) } }
/** \example ex_SetSensorTouch.nxc
 * This is an example of how to use the \ref SetSensorTouch function.
 */

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
/** \example ex_SetSensorLight.nxc
 * This is an example of how to use the \ref SetSensorLight function.
 */

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
/** \example ex_SetSensorSound.nxc
 * This is an example of how to use the \ref SetSensorSound function.
 */

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
/** \example ex_SetSensorLowspeed.nxc
 * This is an example of how to use the \ref SetSensorLowspeed function.
 */

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
/** \example ex_SetSensorColorFull.nxc
 * This is an example of how to use the \ref SetSensorColorFull function.
 */

/**
 * Configure an NXT 2.0 red light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in red light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. See \ref InPorts.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SetSensorColorRed(const byte & port) { asm { __SetSensorColorRed(port) } }
/** \example ex_SetSensorColorRed.nxc
 * This is an example of how to use the \ref SetSensorColorRed function.
 */

/**
 * Configure an NXT 2.0 green light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in green light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. See \ref InPorts.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SetSensorColorGreen(const byte & port) { asm { __SetSensorColorGreen(port) } }
/** \example ex_SetSensorColorGreen.nxc
 * This is an example of how to use the \ref SetSensorColorGreen function.
 */

/**
 * Configure an NXT 2.0 blue light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in blue light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. See \ref InPorts.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SetSensorColorBlue(const byte & port) { asm { __SetSensorColorBlue(port) } }
/** \example ex_SetSensorColorBlue.nxc
 * This is an example of how to use the \ref SetSensorColorBlue function.
 */

/**
 * Configure an NXT 2.0 no light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in no light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. See \ref InPorts.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SetSensorColorNone(const byte & port) { asm { __SetSensorColorNone(port) } }
/** \example ex_SetSensorColorNone.nxc
 * This is an example of how to use the \ref SetSensorColorNone function.
 */

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
/** \example ex_GetInput.nxc
 * This is an example of how to use the \ref GetInput function.
 */

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
/** \example ex_SetInput.nxc
 * This is an example of how to use the \ref SetInput function.
 */

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
/** \example ex_Sensor.nxc
 * This is an example of how to use the \ref Sensor function.
 */

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
/** \example ex_SensorBoolean.nxc
 * This is an example of how to use the \ref SensorBoolean function.
 */

/**
 * Read sensor digital pins direction.
 * Return the digital pins direction value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \return The sensor's digital pins direction.
 */
inline byte SensorDigiPinsDirection(const byte port);
/** \example ex_SensorDigiPinsDirection.nxc
 * This is an example of how to use the \ref SensorDigiPinsDirection function.
 */

/**
 * Read sensor digital pins output level.
 * Return the digital pins output level value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \return The sensor's digital pins output level.
 */
inline byte SensorDigiPinsOutputLevel(const byte port);
/** \example ex_SensorDigiPinsOutputLevel.nxc
 * This is an example of how to use the \ref SensorDigiPinsOutputLevel function.
 */

/**
 * Read sensor digital pins status.
 * Return the digital pins status value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \return The sensor's digital pins status.
 */
inline byte SensorDigiPinsStatus(const byte port);
/** \example ex_SensorDigiPinsStatus.nxc
 * This is an example of how to use the \ref SensorDigiPinsStatus function.
 */

/**
 * Read sensor invalid data flag.
 * Return the value of the InvalidData flag of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's invalid data flag.
 */
inline bool SensorInvalid(const byte & port);
/** \example ex_SensorInvalid.nxc
 * This is an example of how to use the \ref SensorInvalid function.
 */

/**
 * Read sensor mode.
 * Return the mode of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's mode. See \ref SensorModes.
 */
inline byte SensorMode(const byte & port);
/** \example ex_SensorMode.nxc
 * This is an example of how to use the \ref SensorMode function.
 */

/**
 * Read sensor normalized value.
 * Return the normalized value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's normalized value.
 */
inline unsigned int SensorNormalized(const byte & port);
/** \example ex_SensorNormalized.nxc
 * This is an example of how to use the \ref SensorNormalized function.
 */

/**
 * Read sensor raw value.
 * Return the raw value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's raw value.
 */
inline unsigned int SensorRaw(const byte & port);
/** \example ex_SensorRaw.nxc
 * This is an example of how to use the \ref SensorRaw function.
 */

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
/** \example ex_SensorScaled.nxc
 * This is an example of how to use the \ref SensorScaled function.
 */

/**
 * Read sensor type.
 * Return the type of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's type. See \ref SensorTypes.
 */
inline byte SensorType(const byte & port);
/** \example ex_SensorType.nxc
 * This is an example of how to use the \ref SensorType function.
 */

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
/** \example ex_SensorValue.nxc
 * This is an example of how to use the \ref SensorValue function.
 */
 
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
/** \example ex_SensorValueBool.nxc
 * This is an example of how to use the \ref SensorValueBool function.
 */
 
/**
 * Read sensor raw value.
 * Return the raw value of a sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts. A variable whose value is
 * the desired sensor port may also be used.
 * \return The sensor's raw value.
 */
inline unsigned int SensorValueRaw(const byte & port);
/** \example ex_SensorValueRaw.nxc
 * This is an example of how to use the \ref SensorValueRaw function.
 */

/**
 * Get the custom sensor active status.
 * Return the custom sensor active status value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The custom sensor active status.
*/
inline byte CustomSensorActiveStatus(const byte port);
/** \example ex_CustomSensorActiveStatus.nxc
 * This is an example of how to use the \ref CustomSensorActiveStatus function.
 */

/**
 * Get the custom sensor percent full scale.
 * Return the custom sensor percent full scale value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The custom sensor percent full scale.
 */
inline byte CustomSensorPercentFullScale(const byte port);
/** \example ex_CustomSensorPercentFullScale.nxc
 * This is an example of how to use the \ref CustomSensorPercentFullScale function.
 */

/**
 * Get the custom sensor zero offset.
 * Return the custom sensor zero offset value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The custom sensor zero offset.
 */
inline unsigned int CustomSensorZeroOffset(const byte port);
/** \example ex_CustomSensorZeroOffset.nxc
 * This is an example of how to use the \ref CustomSensorZeroOffset function.
 */

/**
 * Set active status.
 * Sets the active status value of a custom sensor.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param activeStatus The new active status value.
 */
inline void SetCustomSensorActiveStatus(const byte port, const byte & activeStatus);
/** \example ex_SetCustomSensorActiveStatus.nxc
 * This is an example of how to use the \ref SetCustomSensorActiveStatus function.
 */

/**
 * Set percent full scale.
 * Sets the percent full scale value of a custom sensor.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param pctFullScale The new percent full scale value.
 */
inline void SetCustomSensorPercentFullScale(const byte port, const byte & pctFullScale);
/** \example ex_SetCustomSensorPercentFullScale.nxc
 * This is an example of how to use the \ref SetCustomSensorPercentFullScale function.
 */

/**
 * Set percent zero offset.
 * Sets the zero offset value of a custom sensor.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param zeroOffset The new zero offset value.
 */
inline void SetCustomSensorZeroOffset(const byte port, const int & zeroOffset);
/** \example ex_SetCustomSensorZeroOffset.nxc
 * This is an example of how to use the \ref SetCustomSensorZeroOffset function.
 */

/**
 * Set sensor boolean value.
 * Sets the boolean value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param value The new boolean value.
 */
inline void SetSensorBoolean(const byte port, const bool & value);
/** \example ex_SetSensorBoolean.nxc
 * This is an example of how to use the \ref SetSensorBoolean function.
 */

/**
 * Set digital pins direction.
 * Sets the digital pins direction value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param direction The new digital pins direction value.
 */
inline void SetSensorDigiPinsDirection(const byte port, const byte & direction);
/** \example ex_SetSensorDigiPinsDirection.nxc
 * This is an example of how to use the \ref SetSensorDigiPinsDirection function.
 */

/**
 * Set digital pins output level.
 * Sets the digital pins output level value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param outputLevel The new digital pins output level value.
 */
inline void SetSensorDigiPinsOutputLevel(const byte port, const byte & outputLevel);
/** \example ex_SetSensorDigiPinsOutputLevel.nxc
 * This is an example of how to use the \ref SetSensorDigiPinsOutputLevel function.
 */

/**
 * Set digital pins status.
 * Sets the digital pins status value of a sensor.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param status The new digital pins status value.
 */
inline void SetSensorDigiPinsStatus(const byte port, const byte & status);
/** \example ex_SetSensorDigiPinsStatus.nxc
 * This is an example of how to use the \ref SetSensorDigiPinsStatus function.
 */


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
/** \example ex_SysColorSensorRead.nxc
 * This is an example of how to use the \ref SysColorSensorRead function.
 */

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
/** \example ex_ReadSensorColorEx.nxc
 * This is an example of how to use the \ref ReadSensorColorEx function.
 */

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
/** \example ex_ReadSensorColorRaw.nxc
 * This is an example of how to use the \ref ReadSensorColorRaw function.
 */

/**
 * Read a LEGO color sensor AD raw value.
 * This function lets you directly access a specific LEGO color sensor AD raw value. Both the
 * port and the color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param color The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \return The AD raw value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline unsigned int ColorADRaw(const byte port, const byte color);
/** \example ex_ColorADRaw.nxc
 * This is an example of how to use the \ref ColorADRaw function.
 */

/**
 * Read a LEGO color sensor boolean value.
 * This function lets you directly access a specific LEGO color sensor boolean value. Both the
 * port and the color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param color The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \return The boolean value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline bool ColorBoolean(const byte port, const byte color);
/** \example ex_ColorBoolean.nxc
 * This is an example of how to use the \ref ColorBoolean function.
 */

/**
 * Read a LEGO color sensor calibration point value.
 * This function lets you directly access a specific LEGO color calibration point value.
 * The port, point, and color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param point The calibration point. See \ref InputColorCalibrationConstants. Must be a constant.
 * \param color The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \return The calibration point value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline long ColorCalibration(const byte port, const byte point, const byte color);
/** \example ex_ColorCalibration.nxc
 * This is an example of how to use the \ref ColorCalibration function.
 */

/**
 * Read LEGO color sensor calibration state.
 * This function lets you directly access the LEGO color calibration state.
 * The port must be a constant.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \return The calibration state.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline byte ColorCalibrationState(const byte port);
/** \example ex_ColorCalibrationState.nxc
 * This is an example of how to use the \ref ColorCalibrationState function.
 */

/**
 * Read a LEGO color sensor calibration limit value.
 * This function lets you directly access a specific LEGO color calibration limit value.
 * The port and the point must be constants.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param point The calibration point. See \ref InputColorCalibrationConstants. Must be a constant.
 * \return The calibration limit value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline unsigned int ColorCalLimits(const byte port, const byte point);
/** \example ex_ColorCalLimits.nxc
 * This is an example of how to use the \ref ColorCalLimits function.
 */

/**
 * Read a LEGO color sensor raw value.
 * This function lets you directly access a specific LEGO color sensor raw value. Both the
 * port and the color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param color The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \return The raw value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline unsigned int ColorSensorRaw(const byte port, const byte color);
/** \example ex_ColorSensorRaw.nxc
 * This is an example of how to use the \ref ColorSensorRaw function.
 */

/**
 * Read a LEGO color sensor scaled value.
 * This function lets you directly access a specific LEGO color sensor scaled value. Both the
 * port and the color index must be constants.
 *
 * \param port The sensor port. See \ref InPorts. Must be a constant.
 * \param color The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \return The scaled value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline unsigned int ColorSensorValue(const byte port, const byte color);
/** \example ex_ColorSensorValue.nxc
 * This is an example of how to use the \ref ColorSensorValue function.
 */

#endif

#else

// input fields
#define Sensor(_p) asm { ReadSensor(_p, __RETVAL__) }
#define SensorValue(_p) Sensor(_p)
#define SensorType(_p) GetInput(_p, Type)
#define SensorMode(_p) GetInput(_p, InputMode)
#define SensorRaw(_p) GetInput(_p, RawValue)
#define SensorNormalized(_p) GetInput(_p, NormalizedValue)
#define SensorScaled(_p) GetInput(_p, ScaledValue)
#define SensorInvalid(_p) GetInput(_p, InvalidData)
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

#endif

#endif
/** @} */ // end of InputModuleFunctions group
/** @} */ // end of InputModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// OUTPUT MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup OutputModule
 * @{
 */
/** @defgroup OutputModuleFunctions Output module functions
 * Functions for accessing and modifying output module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Set motor PWM frequency.
 * Set the motor pulse width modulation frequency.
 */
inline void SetMotorPwnFreq(byte n);
/** \example ex_setmotorpwnfreq.nxc
 * This is an example of how to use the SetMotorPwnFreq function.
 */

/**
 * Run motors forward synchronised with PID factors.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnFwdSyncPID(byte outputs, char pwr, char turnpct, byte p, byte i, byte d);
/** \example ex_onfwdsyncpid.nxc
 * This is an example of how to use the OnFwdSyncPID function.
 */

/**
 * Run motors forward synchronised and reset counters with PID factors.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnFwdSyncExPID(byte outputs, char pwr, char turnpct, const byte reset, byte p, byte i, byte d);
/** \example ex_onfwdsyncexpid.nxc
 * This is an example of how to use the OnFwdSyncExPID function.
 */

/**
 * Run motors backward synchronised with PID factors.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnRevSyncPID(byte outputs, char pwr, char turnpct, byte p, byte i, byte d);
/** \example ex_onrevsyncpid.nxc
 * This is an example of how to use the OnRevSyncPID function.
 */

/**
 * Run motors backward synchronised and reset counters with PID factors.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnRevSyncExPID(byte outputs, char pwr, char turnpct, const byte reset, byte p, byte i, byte d);
/** \example ex_onrevsyncexpid.nxc
 * This is an example of how to use the OnRevSyncExPID function.
 */

/**
 * Run motors forward regulated with PID factors.
 * Run the specified outputs forward using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnFwdRegPID(byte outputs, char pwr, byte regmode, byte p, byte i, byte d);
/** \example ex_onfwdregpid.nxc
 * This is an example of how to use the OnFwdRegPID function.
 */

/**
 * Run motors forward regulated and reset counters with PID factors.
 * Run the specified outputs forward using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnFwdRegExPID(byte outputs, char pwr, byte regmode, const byte reset, byte p, byte i, byte d);
/** \example ex_onfwdregexpid.nxc
 * This is an example of how to use the OnFwdRegExPID function.
 */

/**
 * Run motors reverse regulated with PID factors.
 * Run the specified outputs in reverse using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnRevRegPID(byte outputs, char pwr, byte regmode, byte p, byte i, byte d);
/** \example ex_onrevregpid.nxc
 * This is an example of how to use the OnRevRegPID function.
 */

/**
 * Run motors backward regulated and reset counters with PID factors.
 * Run the specified outputs in reverse using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnRevRegExPID(byte outputs, char pwr, byte regmode, const byte reset, byte p, byte i, byte d);
/** \example ex_onrevregexpid.nxc
 * This is an example of how to use the OnRevRegExPID function.
 */

/**
 * Turn motors off.
 * Turn the specified outputs off (with braking).
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
inline void Off(byte outputs);
/** \example ex_off.nxc
 * This is an example of how to use the \ref Off function.
 */

/**
 * Turn motors off and reset counters.
 * Turn the specified outputs off (with braking).
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OffEx(byte outputs, const byte reset);
/** \example ex_offex.nxc
 * This is an example of how to use the \ref OffEx function.
 */

/**
 * Coast motors.
 * Turn off the specified outputs, making them coast to a stop.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
inline void Coast(byte outputs);
/** \example ex_coast.nxc
 * This is an example of how to use the \ref Coast function.
 */

/**
 * Coast motors and reset counters.
 * Turn off the specified outputs, making them coast to a stop.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void CoastEx(byte outputs, const byte reset);
/** \example ex_coastex.nxc
 * This is an example of how to use the \ref CoastEx function.
 */

/**
 * Float motors.
 * Make outputs float. Float is an alias for Coast.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
inline void Float(byte outputs);
/** \example ex_float.nxc
 * This is an example of how to use the \ref Float function.
 */

/**
 * Run motors forward.
 * Set outputs to forward direction and turn them on.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 */
inline void OnFwd(byte outputs, char pwr);
/** \example ex_onfwd.nxc
 * This is an example of how to use the \ref OnFwd function.
 */

/**
 * Run motors forward and reset counters.
 * Set outputs to forward direction and turn them on.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnFwdEx(byte outputs, char pwr, const byte reset);
/** \example ex_onfwdex.nxc
 * This is an example of how to use the \ref OnFwdEx function.
 */

/**
 * Run motors backward.
 * Set outputs to reverse direction and turn them on.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 */
inline void OnRev(byte outputs, char pwr);
/** \example ex_onrev.nxc
 * This is an example of how to use the \ref OnRev function.
 */

/**
 * Run motors backward and reset counters.
 * Set outputs to reverse direction and turn them on.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnRevEx(byte outputs, char pwr, const byte reset);
/** \example ex_onrevex.nxc
 * This is an example of how to use the \ref OnRevEx function.
 */

/**
 * Run motors forward regulated.
 * Run the specified outputs forward using the specified regulation mode.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 */
inline void OnFwdReg(byte outputs, char pwr, byte regmode);
/** \example ex_onfwdreg.nxc
 * This is an example of how to use the \ref OnFwdReg function.
 */

/**
 * Run motors forward regulated and reset counters.
 * Run the specified outputs forward using the specified regulation mode.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnFwdRegEx(byte outputs, char pwr, byte regmode, const byte reset);
/** \example ex_onfwdregex.nxc
 * This is an example of how to use the \ref OnFwdRegEx function.
 */

/**
 * Run motors forward regulated.
 * Run the specified outputs in reverse using the specified regulation mode.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 */
inline void OnRevReg(byte outputs, char pwr, byte regmode);
/** \example ex_onrevreg.nxc
 * This is an example of how to use the \ref OnRevReg function.
 */

/**
 * Run motors backward regulated and reset counters.
 * Run the specified outputs in reverse using the specified regulation mode.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnRevRegEx(byte outputs, char pwr, byte regmode, const byte reset);
/** \example ex_onrevregex.nxc
 * This is an example of how to use the \ref OnRevRegEx function.
 */

/**
 * Run motors forward synchronised.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 */
inline void OnFwdSync(byte outputs, char pwr, char turnpct);
/** \example ex_onfwdsync.nxc
 * This is an example of how to use the \ref OnFwdSync function.
 */

/**
 * Run motors forward synchronised and reset counters.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnFwdSyncEx(byte outputs, char pwr, char turnpct, const byte reset);
/** \example ex_onfwdsyncex.nxc
 * This is an example of how to use the \ref OnFwdSyncEx function.
 */

/**
 * Run motors backward synchronised.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 */
inline void OnRevSync(byte outputs, char pwr, char turnpct);
/** \example ex_onrevsync.nxc
 * This is an example of how to use the \ref OnRevSync function.
 */

/**
 * Run motors backward synchronised and reset counters.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnRevSyncEx(byte outputs, char pwr, char turnpct, const byte reset);
/** \example ex_onrevsyncex.nxc
 * This is an example of how to use the \ref OnRevSyncEx function.
 */

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param angle Angle limit, in degree. Can be negative to reverse direction.
 */
inline void RotateMotor(byte outputs, char pwr, long angle);
/** \example ex_rotatemotor.nxc
 * This is an example of how to use the \ref RotateMotor function.
 */

/**
 * Rotate motor with PID factors.
 * Run the specified outputs forward for the specified number of degrees.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param angle Angle limit, in degree. Can be negative to reverse direction.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void RotateMotorPID(byte outputs, char pwr, long angle, byte p, byte i, byte d);
/** \example ex_rotatemotorpid.nxc
 * This is an example of how to use the \ref RotateMotorPID function.
 */

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param angle Angle limit, in degree. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param sync Synchronise two motors. Should be set to true if a non-zero
 * turn percent is specified or no turning will occur.
 * \param stop Specify whether the motor(s) should brake at the end of the
 * rotation.
 */
inline void RotateMotorEx(byte outputs, char pwr, long angle, char turnpct, bool sync, bool stop);
/** \example ex_rotatemotorex.nxc
 * This is an example of how to use the \ref RotateMotorEx function.
 */

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param angle Angle limit, in degree. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param sync Synchronise two motors. Should be set to true if a non-zero
 * turn percent is specified or no turning will occur.
 * \param stop Specify whether the motor(s) should brake at the end of the
 * rotation.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void RotateMotorExPID(byte outputs, char pwr, long angle, char turnpct, bool sync, bool stop, byte p, byte i, byte d);
/** \example ex_rotatemotorexpid.nxc
 * This is an example of how to use the \ref RotateMotorExPID function.
 */

/**
 * Reset tachometer counter.
 * Reset the tachometer count and tachometer limit goal for the specified
 * outputs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
inline void ResetTachoCount(byte outputs);
/** \example ex_resettachocount.nxc
 * This is an example of how to use the \ref ResetTachoCount function.
 */

/**
 * Reset block-relative counter.
 * Reset the block-relative position counter for the specified outputs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
inline void ResetBlockTachoCount(byte outputs);
/** \example ex_resetblocktachocount.nxc
 * This is an example of how to use the \ref ResetBlockTachoCount function.
 */

/**
 * Reset program-relative counter.
 * Reset the program-relative position counter for the specified outputs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
inline void ResetRotationCount(byte outputs);
/** \example ex_resetrotationcount.nxc
 * This is an example of how to use the \ref ResetRotationCount function.
 */

/**
 * Reset all tachometer counters.
 * Reset all three position counters and reset the current tachometer limit
 * goal for the specified outputs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
inline void ResetAllTachoCounts(byte outputs);
/** \example ex_resetalltachocounts.nxc
 * This is an example of how to use the \ref ResetAllTachoCounts function.
 */

/**
 * Set output fields.
 * Set the specified field of the outputs to the value provided. The field
 * must be a valid output field constant. This function takes a variable
 * number of field/value pairs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 * \param field1 The 1st output port field to access, this should be a constant, see
 * \ref OutputFieldConstants.
 * \param val1 Value to set for the 1st field.
 * \param fieldN The Nth output port field to access, this should be a constant, see
 * \ref OutputFieldConstants.
 * \param valN The value to set for the Nth field.
 */
inline void SetOutput(byte outputs, byte field1, variant val1, ..., byte fieldN, variant valN);
/** \example ex_setoutput.nxc
 * This is an example of how to use the \ref SetOutput function.
 */

/**
 * Get output field value.
 * Get the value of the specified field for the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \param field Output port field to access, this should be a constant, see
 * \ref OutputFieldConstants.
 */
inline variant GetOutput(byte output, const byte field);
/** \example ex_getoutput.nxc
 * This is an example of how to use the \ref GetOutput function.
 */

/**
 * Get motor mode.
 * Get the mode of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline byte MotorMode(byte output);
/** \example ex_motormode.nxc
 * This is an example of how to use the \ref MotorMode function.
 */

/**
 * Get motor power level.
 * Get the power level of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline char MotorPower(byte output);
/** \example ex_motorpower.nxc
 * This is an example of how to use the \ref MotorPower function.
 */

/**
 * Get motor actual speed.
 * Get the actual speed value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline char MotorActualSpeed(byte output);
/** \example ex_motoractualspeed.nxc
 * This is an example of how to use the \ref MotorActualSpeed function.
 */

/**
 * Get motor tachometer counter.
 * Get the tachometer count value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline long MotorTachoCount(byte output);
/** \example ex_motortachocount.nxc
 * This is an example of how to use the \ref MotorTachoCount function.
 */

/**
 * Get motor tachometer limit.
 * Get the tachometer limit value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline long MotorTachoLimit(byte output);
/** \example ex_motortacholimit.nxc
 * This is an example of how to use the \ref MotorTachoLimit function.
 */

/**
 * Get motor run state.
 * Get the RunState value of the specified output, see \ref
 * OutRunStateConstants.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline byte MotorRunState(byte output);
/** \example ex_motorrunstate.nxc
 * This is an example of how to use the \ref MotorRunState function.
 */

/**
 * Get motor turn ratio.
 * Get the turn ratio value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline char MotorTurnRatio(byte output);
/** \example ex_motorturnratio.nxc
 * This is an example of how to use the \ref MotorTurnRatio function.
 */

/**
 * Get motor regulation mode.
 * Get the regulation value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline byte MotorRegulation(byte output);
/** \example ex_motorregulation.nxc
 * This is an example of how to use the \ref MotorRegulation function.
 */

/**
 * Get motor overload status.
 * Get the overload value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline bool MotorOverload(byte output);
/** \example ex_motoroverload.nxc
 * This is an example of how to use the \ref MotorOverload function.
 */

/**
 * Get motor P value.
 * Get the proportional PID value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline byte MotorRegPValue(byte output);
/** \example ex_motorregpvalue.nxc
 * This is an example of how to use the \ref MotorRegPValue function.
 */

/**
 * Get motor I value.
 * Get the integral PID value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline byte MotorRegIValue(byte output);
/** \example ex_motorregivalue.nxc
 * This is an example of how to use the \ref MotorRegIValue function.
 */

/**
 * Get motor D value.
 * Get the derivative PID value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline byte MotorRegDValue(byte output);
/** \example ex_motorregdvalue.nxc
 * This is an example of how to use the \ref MotorRegDValue function.
 */

/**
 * Get motor block-relative counter.
 * Get the block-relative position counter value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline long MotorBlockTachoCount(byte output);
/** \example ex_motorblocktachocount.nxc
 * This is an example of how to use the \ref MotorBlockTachoCount function.
 */

/**
 * Get motor program-relative counter.
 * Get the program-relative position counter value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 */
inline long MotorRotationCount(byte output);
/** \example ex_motorrotationcount.nxc
 * This is an example of how to use the \ref MotorRotationCount function.
 */

/**
 * Get motor PWN frequency.
 * Get the current motor pulse width modulation frequency.
 */
inline byte MotorPwnFreq();
/** \example ex_motorpwnfreq.nxc
 * This is an example of how to use the \ref MotorPwnFreq function.
 */

#else

// output fields
#define MotorMode(_p) GetOutput(_p, OutputMode)
#define MotorPower(_p) GetOutput(_p, Power)
#define MotorActualSpeed(_p) GetOutput(_p, ActualSpeed)
#define MotorTachoCount(_p) GetOutput(_p, TachoCount)
#define MotorTachoLimit(_p) GetOutput(_p, TachoLimit)
#define MotorRunState(_p) GetOutput(_p, RunState)
#define MotorTurnRatio(_p) GetOutput(_p, TurnRatio)
#define MotorRegulation(_p) GetOutput(_p, RegMode)
#define MotorOverload(_p) GetOutput(_p, Overload)
#define MotorRegPValue(_p) GetOutput(_p, RegPValue)
#define MotorRegIValue(_p) GetOutput(_p, RegIValue)
#define MotorRegDValue(_p) GetOutput(_p, RegDValue)
#define MotorBlockTachoCount(_p) GetOutput(_p, BlockTachoCount)
#define MotorRotationCount(_p) GetOutput(_p, RotationCount)

#define MotorPwnFreq() asm { GetOutPwnFreq(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SetMotorPwnFreq(_n) asm { __setOutPwnFreq(_n) }

#endif

/** @} */ // end of OutputModuleFunctions group
/** @} */ // end of OutputModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// DISPLAY MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup DisplayModule
 * @{
 */
/** @defgroup DisplayModuleTypes Display module types
 * Types used by various display module functions.
 * @{
 */
/**
 * A point on the NXT LCD screen.
 * This structure is by other system call structures to specify an X, Y
 * LCD screen coordinate.
 * \sa DrawTextType, DrawPointType, DrawLineType, DrawCircleType, DrawRectType,
 * DrawGraphicType, DrawGraphicArrayType, DrawPolygonType, DrawEllipseType,
 * DrawFontType
 */
struct LocationType {
  int X;  /*!< The X coordinate. Valid range is from 0 to 99 inclusive.  */
  int Y;  /*!< The Y coordinate. Valid range is from 0 to 63 inclusive.
               For text drawing this value must be a multiple of 8. */
};

/**
 * Width and height dimensions for the DrawRect system call.
 * This structure is by the \ref DrawRectType to specify a width and
 * height for a rectangle.
 * \sa DrawRectType
 */
struct SizeType {
  int Width;  /*!< The rectangle width. */
  int Height; /*!< The rectangle height. */
};

/**
 * Parameters for the DrawText system call.
 * This structure is used when calling the \ref SysDrawText system call function.
 * It lets you specify the text to draw, the LCD line and horizontal position using the
 * \ref LocationType structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawText()
 */
struct DrawTextType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The location in X, LCD line number coordinates. */
  string Text;             /*!< The text to draw on the LCD. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawPoint system call.
 * This structure is used when calling the \ref SysDrawPoint system call
 * function.
 * It lets you specify the pixel to draw using the
 * \ref LocationType structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawPoint()
 */
struct DrawPointType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The point location on screen. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawLine system call.
 * This structure is used when calling the \ref SysDrawLine system call
 * function.
 * It lets you specify the end points of the line to draw using two
 * \ref LocationType structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawLine()
 */
struct DrawLineType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType StartLoc;   /*!< The location of the starting point. */
  LocationType EndLoc;     /*!< The location of the ending point. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawCircle system call.
 * This structure is used when calling the \ref SysDrawCircle system call
 * function.
 * It lets you specify the center of the circle to draw using the
 * \ref LocationType structure member, the radius, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawCircle()
 */
struct DrawCircleType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Center;     /*!< The location of the circle center. */
  byte Size;               /*!< The circle radius. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawRect system call.
 * This structure is used when calling the \ref SysDrawRect system call
 * function.
 * It lets you specify the corner of the rectangle using the \ref LocationType structure member,
 * the width and height of the rectangle using the \ref SizeType structure member,
 * as well as drawing options defined in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawRect()
 */
struct DrawRectType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The top left corner location. */
  SizeType Size;           /*!< The width and height of the rectangle. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawGraphic system call.
 * This structure is used when calling the \ref SysDrawGraphic system call
 * function.
 * It lets you specify the screen location at which to draw the image using the
 * \ref LocationType structure member, the filename of the graphic image, the
 * image parameters (if needed), as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawGraphic()
 */
struct DrawGraphicType {
  char Result;             /*!< The function call result. Possible values include
                             \ref LoaderErrors, \ref ERR_FILE, and \ref NO_ERR. */
  LocationType Location;   /*!< The location on screen. */
  string Filename;         /*!< The RIC file name. */
  long Variables[];         /*!< The variables passed as RIC arguments. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the SetScreenMode system call.
 * This structure is used when calling the \ref SysSetScreenMode system call
 * function.
 * \sa SysSetScreenMode()
 */
struct SetScreenModeType {
  char Result;                /*!< The function call result, always \ref NO_ERR. */
  unsigned long ScreenMode;   /*!< The requested screen mode.

                                The standard NXT firmware only supports
                                setting the ScreenMode to \ref SCREEN_MODE_RESTORE.

                                If you install the NBC/NXC enhanced standard
                                NXT firmware this system function also
                                supports setting the ScreenMode to
                                \ref SCREEN_MODE_CLEAR. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the DisplayExecuteFunction system call.
 * This structure is used when calling the \ref SysDisplayExecuteFunction
 * system call function.
 *
 * The fields usage depends on the requested command and are documented in the
 * table below. If a field member is shown as 'x' it is ignored by the
 * specified display command.
 *
 * <table>
 * <tr><td>Cmd</td>
 *     <td>Meaning</td><td>Expected parameters</td></tr>
 * <tr><td>DISPLAY_ERASE_ALL</td>
 *     <td>erase entire screen</td><td>()</td></tr>
 * <tr><td>DISPLAY_PIXEL</td>
 *     <td>set pixel (on/off)</td><td>(true/false,X1,Y1,x,x)</td></tr>
 * <tr><td>DISPLAY_HORIZONTAL_LINE</td>
 *     <td>draw horizontal line</td><td>(true/false,X1,Y1,X2,x)</td></tr>
 * <tr><td>DISPLAY_VERTICAL_LINE</td>
 *     <td>draw vertical line</td><td>(true/false,X1,Y1,x,Y2)</td></tr>
 * <tr><td>DISPLAY_CHAR</td>
 *     <td>draw char (actual font)</td><td>(true/false,X1,Y1,Char,x)</td></tr>
 * <tr><td>DISPLAY_ERASE_LINE</td>
 *     <td>erase a single line</td><td>(x,LINE,x,x,x)</td></tr>
 * <tr><td>DISPLAY_FILL_REGION</td>
 *     <td>fill screen region</td><td>(true/false,X1,Y1,X2,Y2)</td></tr>
 * <tr><td>DISPLAY_FILLED_FRAME</td>
 *     <td>draw a frame (on / off)</td><td>(true/false,X1,Y1,X2,Y2)</td></tr>
 * </table>
 *
 * \sa SysDisplayExecuteFunction()
 */
struct DisplayExecuteFunctionType {
  byte Status;   /*!< The function call result, always \ref NO_ERR. */
  byte Cmd;      /*!< The command to execute. */
  bool On;       /*!< The On parameter, see table. */
  byte X1;       /*!< The X1 parameter, see table. */
  byte Y1;       /*!< The Y1 parameter, see table. */
  byte X2;       /*!< The X2 parameter, see table. */
  byte Y2;       /*!< The Y2 parameter, see table. */
};

#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the DrawGraphicArray system call.
 * This structure is used when calling the \ref SysDrawGraphicArray system call
 * function.
 * It lets you specify the screen location at which to draw the image using the
 * \ref LocationType structure member, the graphic image data array, the
 * image parameters (if needed), as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawGraphicArray()
 */
struct DrawGraphicArrayType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;  /*!< The location on screen. */
  byte Data[];            /*!< A byte array containing the RIC opcodes. \ref RICMacros */
  long Variables[];       /*!< The variables passed as RIC arguments. */
  unsigned long Options;  /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawPolygon system call.
 * This structure is used when calling the \ref SysDrawPolygon system call
 * function.
 * It lets you specify the points of the polygon to draw using the
 * \ref LocationType array structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawPolygon()
 */
struct DrawPolygonType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Points[];  /*!< An array of LocationType structures which define the polygon's shape. */
  unsigned long Options;  /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawEllipse system call.
 * This structure is used when calling the \ref SysDrawEllipse system call
 * function.
 * It lets you specify the center of the ellipse using the
 * \ref LocationType structure member, the x and y axis radii,
 * as well as drawing options defined in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawEllipse()
 */
struct DrawEllipseType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Center;    /*!< The location of the ellipse center. */
  byte SizeX;             /*!< The horizontal ellipse radius. */
  byte SizeY;             /*!< The vertical ellipse radius. */
  unsigned long Options;  /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawFont system call.
 * This structure is used when calling the \ref SysDrawFont system call function.
 * It lets you specify the text to draw, the LCD line and horizontal position using the
 * \ref LocationType structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawFont()
 */
struct DrawFontType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The location in X, LCD line number coordinates. */
  string Filename;         /*!< The filename of the RIC-based font file. */
  string Text;             /*!< The text to draw on the LCD. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};
#endif
#endif
/** @} */ // end of DisplayModuleTypes group

/** @defgroup DisplayModuleFunctions Display module functions
 * Functions for accessing and modifying display module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Reset LCD screen.
 * This function lets you restore the standard NXT running program screen.
 */
inline void ResetScreen();
/** \example ex_ResetScreen.nxc
 * This is an example of how to use the \ref ResetScreen function.
 */

/**
 * Draw a circle.
 * This function lets you draw a circle on the screen with its center at the
 * specified x and y location, using the specified radius. Optionally specify
 * drawing options. If this argument is not specified it defaults to \ref DRAW_OPT_NORMAL.
 * Valid display option constants are listed in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawCircle, DrawCircleType
 *
 * \param x The x value for the center of the circle.
 * \param y The y value for the center of the circle.
 * \param radius The radius of the circle.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char CircleOut(int x, int y, byte radius, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_CircleOut.nxc
 * This is an example of how to use the \ref CircleOut, \ref Random, and
 * \ref Wait functions.
 */

/**
 * Draw a line.
 * This function lets you draw a line on the screen from x1, y1 to x2, y2.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawLine, DrawLineType
 *
 * \param x1 The x value for the start of the line.
 * \param y1 The y value for the start of the line.
 * \param x2 The x value for the end of the line.
 * \param y2 The y value for the end of the line.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char LineOut(int x1, int y1, int x2, int y2, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_LineOut.nxc
 * This is an example of how to use the \ref LineOut function.
 */

/**
 * Draw a point.
 * This function lets you draw a point on the screen at x, y.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawPoint, DrawPointType
 *
 * \param x The x value for the point.
 * \param y The y value for the point.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char PointOut(int x, int y, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_PointOut.nxc
 * This is an example of how to use the \ref PointOut function.
 */

/**
 * Draw a rectangle.
 * This function lets you draw a rectangle on the screen at x, y with the
 * specified width and height.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawRect, DrawRectType
 *
 * \param x The x value for the top left corner of the rectangle.
 * \param y The y value for the top left corner of the rectangle.
 * \param width The width of the rectangle.
 * \param height The height of the rectangle.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char RectOut(int x, int y, int width, int height, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_RectOut.nxc
 * This is an example of how to use the \ref RectOut function.
 */

/**
 * Draw text.
 * Draw a text value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawText, DrawTextType
 *
 * \param x The x value for the start of the text output.
 * \param y The text line number for the text output.
 * \param str The text to output to the LCD screen.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char TextOut(int x, int y, string str, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_TextOut.nxc
 * This is an example of how to use the \ref TextOut function.
 */

/**
 * Draw a number.
 * Draw a numeric value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawText, DrawTextType
 *
 * \param x The x value for the start of the number output.
 * \param y The text line number for the number output.
 * \param value The value to output to the LCD screen. Any numeric type is supported.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char NumOut(int x, int y, variant value, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_NumOut.nxc
 * This is an example of how to use the \ref NumOut function.
 */

/**
 * Draw an ellipse.
 * This function lets you draw an ellipse on the screen with its center at the
 * specified x and y location, using the specified radii. Optionally specify
 * drawing options. If this argument is not specified it defaults to \ref DRAW_OPT_NORMAL.
 * Valid display option constants are listed in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawEllipse, DrawEllipseType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param x The x value for the center of the ellipse.
 * \param y The y value for the center of the ellipse.
 * \param radiusX The x axis radius.
 * \param radiusY The y axis radius.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char EllipseOut(int x, int y, byte radiusX, byte radiusY, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_EllipseOut.nxc
 * This is an example of how to use the \ref EllipseOut and \ref Random functions.
 */

/**
 * Draw a polygon.
 * This function lets you draw a polygon on the screen using an array of points.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawPolygon, DrawPolygonType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param points An array of LocationType points that define the polygon.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char PolyOut(LocationType points[], unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_PolyOut.nxc
 * This is an example of how to use the \ref PolyOut function.
 */

/**
 * Draw text with font.
 * Draw a text value on the screen at the specified x and y location using
 * a custom RIC font. Optionally specify drawing options. If this argument is
 * not specified it defaults to \ref DRAW_OPT_NORMAL. Valid display option
 * constants are listed in the \ref DisplayDrawOptionConstants group.  See the
 * \ref DisplayFontDrawOptionConstants for options specific to the font
 * drawing functions.
 * \sa FontNumOut, SysDrawFont, DrawFontType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param x The x value for the start of the text output.
 * \param y The y value for the start of the text output.
 * \param filename The filename of the RIC font.
 * \param str The text to output to the LCD screen.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char FontTextOut(int x, int y, string filename, string str, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispftout.nxc
 * This is an example of how to use the \ref FontTextOut, \ref SysDrawFont,
 * \ref Wait, and \ref ClearScreen functions.
 */

/**
 * Draw a number with font.
 * Draw a numeric value on the screen at the specified x and y location using
 * a custom RIC font. Optionally specify drawing options. If this argument is
 * not specified it defaults to \ref DRAW_OPT_NORMAL. Valid display option
 * constants are listed in the \ref DisplayDrawOptionConstants group.  See the
 * \ref DisplayFontDrawOptionConstants for options specific to the font
 * drawing functions.
 * \sa FontTextOut, SysDrawFont, DrawFontType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param x The x value for the start of the number output.
 * \param y The y value for the start of the number output.
 * \param filename The filename of the RIC font.
 * \param value The value to output to the LCD screen. Any numeric type is supported.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char FontNumOut(int x, int y, string filename, variant value, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispfnout.nxc
 * This is an example of how to use the \ref FontNumOut function.
 */

/**
 * Draw a graphic image.
 * Draw a graphic image file on the screen at the specified x and y location.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa SysDrawGraphic, DrawGraphicType
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param filename The filename of the RIC graphic image.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicOut(int x, int y, string filename, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_GraphicOut.nxc
 * This is an example of how to use the \ref GraphicOut function.
 */
/** \example ex_dispgout.nxc
 * This is an example of how to use the \ref GraphicOut, \ref SysCall,
 * \ref TextOut, \ref CurrentTick, \ref NumOut, \ref Wait, and
 * \ref ClearScreen functions. It also demonstrates how to use the
 * \ref DrawGraphicArrayType structure.
 */

/**
 * Draw a graphic image from byte array.
 * Draw a graphic image byte array on the screen at the specified x and y location.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa SysDrawGraphicArray, DrawGraphicArrayType
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param data The byte array of the RIC graphic image.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicArrayOut(int x, int y, byte data[], unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispgaout.nxc
 * This is an example of how to use the \ref GraphicArrayOut, \ref NumOut, and
 * \ref Wait function.
 * It also demonstrates how to use the \ref RICOpSprite,
 * \ref RICSpriteData, \ref RICOpCopyBits, \ref RICImgRect, and
 * \ref RICImgPoint macros.
 */

/**
 * Draw a graphic image with parameters.
 * Draw a graphic image file on the screen at the specified x and y location using
 * an array of parameters.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa SysDrawGraphic, DrawGraphicType
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param filename The filename of the RIC graphic image.
 * \param vars The byte array of parameters.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicOutEx(int x, int y, string filename, byte vars[], unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_GraphicOutEx.nxc
 * This is an example of how to use the \ref GraphicOutEx function.
 */
/** \example ex_dispgoutex.nxc
 * This is an example of how to use the \ref GraphicOutEx and \ref Wait functions.
 */

/**
 * Draw a graphic image from byte array with parameters.
 * Draw a graphic image byte array on the screen at the specified x and y location
 * using an array of parameters.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa SysDrawGraphicArray, DrawGraphicArrayType
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param data The byte array of the RIC graphic image.
 * \param vars The byte array of parameters.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicArrayOutEx(int x, int y, byte data[], byte vars[], unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispgaoutex.nxc
 * This is an example of how to use the \ref GraphicArrayOutEx and \ref Wait functions.
 * It also demonstrates how to use the \ref RICOpDescription, \ref RICOpSprite,
 * \ref RICSpriteData, \ref RICOpCopyBits, \ref RICImgRect, and
 * \ref RICImgPoint macros.
 */

/**
 * Read pixel data from the normal display buffer.
 * Read "cnt" bytes from the normal display memory into the data array. Start
 * reading from the specified x, line coordinate. Each byte of data read from
 * screen memory is a vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param x The desired x position from which to read pixel data.
 * \param line The desired line from which to read pixel data.
 * \param cnt The number of bytes of pixel data to read.
 * \param data The array of bytes into which pixel data is read.
 */
inline void GetDisplayNormal(const byte x, const byte line, unsigned int cnt, byte & data[]);
/** \example ex_GetDisplayNormal.nxc
 * This is an example of how to use the \ref GetDisplayNormal function.
 */

/**
 * Write pixel data to the normal display buffer.
 * Write "cnt" bytes to the normal display memory from the data array. Start
 * writing at the specified x, line coordinate. Each byte of data is a
 * vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param x The desired x position where you wish to write pixel data.
 * \param line The desired line where you wish to write pixel data.
 * \param cnt The number of bytes of pixel data to write.
 * \param data The array of bytes from which pixel data is read.
 */
inline void SetDisplayNormal(const byte x, const byte line, unsigned int cnt, byte data[]);
/** \example ex_SetDisplayNormal.nxc
 * This is an example of how to use the \ref SetDisplayNormal function.
 */

/**
 * Read pixel data from the popup display buffer.
 * Read "cnt" bytes from the popup display memory into the data array. Start
 * reading from the specified x, line coordinate. Each byte of data read from
 * screen memory is a vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param x The desired x position from which to read pixel data.
 * \param line The desired line from which to read pixel data.
 * \param cnt The number of bytes of pixel data to read.
 * \param data The array of bytes into which pixel data is read.
 */
inline void GetDisplayPopup(const byte x, const byte line, unsigned int cnt, byte & data[]);
/** \example ex_GetDisplayPopup.nxc
 * This is an example of how to use the \ref GetDisplayPopup function.
 */

/**
 * Write pixel data to the popup display buffer.
 * Write "cnt" bytes to the popup display memory from the data array. Start
 * writing at the specified x, line coordinate. Each byte of data is a
 * vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param x The desired x position where you wish to write pixel data.
 * \param line The desired line where you wish to write pixel data.
 * \param cnt The number of bytes of pixel data to write.
 * \param data The array of bytes from which pixel data is read.
 */
inline void SetDisplayPopup(const byte x, const byte line, unsigned int cnt, byte data[]);
/** \example ex_SetDisplayPopup.nxc
 * This is an example of how to use the \ref SetDisplayPopup function.
 */

/**
 * Read the display erase mask value.
 * This function lets you read the current display erase mask value.
 * \return The current display erase mask value.
 */
inline unsigned long DisplayEraseMask();
/** \example ex_DisplayEraseMask.nxc
 * This is an example of how to use the \ref DisplayEraseMask function.
 */

/** \example ex_dispmisc.nxc
 * This is an example of how to use the \ref DisplayEraseMask, \ref DisplayUpdateMask, \ref DisplayDisplay,
 * \ref DisplayFlags, \ref DisplayTextLinesCenterFlags functions,
 * \ref SetDisplayEraseMask, \ref SetDisplayUpdateMask, \ref SetDisplayDisplay,
 * \ref SetDisplayFlags, and \ref SetDisplayTextLinesCenterFlags functions,
 */

/**
 * Read the display update mask value.
 * This function lets you read the current display update mask value.
 * \return The current display update mask.
 */
inline unsigned long DisplayUpdateMask();
/** \example ex_DisplayUpdateMask.nxc
 * This is an example of how to use the \ref DisplayUpdateMask function.
 */

/**
 * Read the display font memory address.
 * This function lets you read the current display font memory address.
 * \return The current display font memory address.
 */
inline unsigned long DisplayFont();
/** \example ex_DisplayFont.nxc
 * This is an example of how to use the \ref DisplayFont function.
 */

/**
 * Read the display memory address.
 * This function lets you read the current display memory address.
 * \return The current display memory address.
 */
inline unsigned long DisplayDisplay();
/** \example ex_DisplayDisplay.nxc
 * This is an example of how to use the \ref DisplayDisplay function.
 */

/**
 * Read the display flags.
 * This function lets you read the current display flags.
 * Valid flag values are listed in the \ref DisplayFlagsGroup group.
 * \return The current display flags.
 */
inline byte DisplayFlags();
/** \example ex_DisplayFlags.nxc
 * This is an example of how to use the \ref DisplayFlags function.
 */

/**
 * Read the display text lines center flags.
 * This function lets you read the current display text lines center flags.
 * \return The current display text lines center flags.
 */
inline byte DisplayTextLinesCenterFlags();
/** \example ex_DisplayTextLinesCenterFlags.nxc
 * This is an example of how to use the \ref DisplayTextLinesCenterFlags function.
 */

/**
 * Draw text.
 * This function lets you draw text on the NXT LCD given the parameters you
 * pass in via the \ref DrawTextType structure.
 *
 * \param args The DrawTextType structure containing the drawing parameters.
 */
inline void SysDrawText(DrawTextType & args);
/** \example ex_sysdrawtext.nxc
 * This is an example of how to use the \ref SysDrawText function along with the
 * \ref DrawTextType structure.
 */

/**
 * Draw a point.
 * This function lets you draw a pixel on the NXT LCD given the parameters you
 * pass in via the \ref DrawPointType structure.
 *
 * \param args The DrawPointType structure containing the drawing parameters.
 */
inline void SysDrawPoint(DrawPointType & args);
/** \example ex_sysdrawpoint.nxc
 * This is an example of how to use the \ref SysDrawPoint function along with the
 * \ref DrawPointType structure.
 */

/**
 * Draw a line.
 * This function lets you draw a line on the NXT LCD given the parameters you
 * pass in via the \ref DrawLineType structure.
 *
 * \param args The DrawLineType structure containing the drawing parameters.
 */
inline void SysDrawLine(DrawLineType & args);
/** \example ex_sysdrawline.nxc
 * This is an example of how to use the \ref SysDrawLine function along with the
 * \ref DrawLineType structure.
 */

/**
 * Draw a circle.
 * This function lets you draw a circle on the NXT LCD given the parameters you pass
 * in via the \ref DrawCircleType structure.
 *
 * \param args The DrawCircleType structure containing the drawing parameters.
 */
inline void SysDrawCircle(DrawCircleType & args);
/** \example ex_sysdrawcircle.nxc
 * This is an example of how to use the \ref SysDrawCircle function along with
 * the \ref DrawCircleType structure.
 */

/**
 * Draw a rectangle.
 * This function lets you draw a rectangle on the NXT LCD given the parameters
 * you pass in via the \ref DrawRectType structure.
 *
 * \param args The DrawRectType structure containing the drawing parameters.
 */
inline void SysDrawRect(DrawRectType & args);
/** \example ex_sysdrawrect.nxc
 * This is an example of how to use the \ref SysDrawRect function along with the
 * \ref DrawRectType structure.
 */

/**
 * Draw a graphic (RIC file).
 * This function lets you draw a graphic image (RIC file) on the NXT LCD given
 * the parameters you pass in via the \ref DrawGraphicType structure.
 *
 * \param args The DrawGraphicType structure containing the drawing parameters.
 */
inline void SysDrawGraphic(DrawGraphicType & args);
/** \example ex_sysdrawgraphic.nxc
 * This is an example of how to use the \ref SysDrawGraphic function along with the
 * \ref DrawGraphicType structure.
 */

/**
 * Set the screen mode.
 * This function lets you set the screen mode of the NXT LCD given the
 * parameters you pass in via the \ref DrawTextType structure.
 *
 * \param args The SetScreenModeType structure containing the screen mode parameters.
 */
inline void SysSetScreenMode(SetScreenModeType & args);
/** \example ex_syssetscreenmode.nxc
 * This is an example of how to use the \ref SysSetScreenMode function along with
 * the \ref SetScreenModeType structure.
 */

#ifdef __ENHANCED_FIRMWARE

/**
 * Execute any Display module command.
 * This function lets you directly execute the Display module's primary
 * drawing function using the values specified via the \ref
 * DisplayExecuteFunctionType structure.
 *
 * \param args The DisplayExecuteFunctionType structure containing the drawing parameters.
 */
inline void SysDisplayExecuteFunction(DisplayExecuteFunctionType & args);
/** \example ex_sysdisplayexecutefunction.nxc
 * This is an example of how to use the \ref SysDisplayExecuteFunction function
 * along with the \ref DisplayExecuteFunctionType structure.
 */
/** \example ex_dispfunc.nxc
 * This is an example of how to use the \ref SysDisplayExecuteFunction and \ref Wait functions
 * along with the \ref DisplayExecuteFunctionType structure.
 */


#if __FIRMWARE_VERSION > 107

/**
 * Read the display contrast setting.
 * This function lets you read the current display contrast setting.
 * \return The current display contrast (byte).
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline byte DisplayContrast();
/** \example ex_contrast.nxc
 * This is an example of how to use the \ref DisplayContrast and \ref SetDisplayContrast functions.
 */

/**
 * Draw a graphic image from a byte array.
 * This function lets you draw a graphic image on the NXT LCD given the parameters you pass
 * in via the \ref DrawGraphicArrayType structure.
 *
 * \param args The DrawGraphicArrayType structure containing the drawing parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysDrawGraphicArray(DrawGraphicArrayType & args);
/** \example ex_sysdrawgraphicarray.nxc
 * This is an example of how to use the \ref SysDrawGraphicArray function along with the \ref DrawGraphicArrayType structure.
 */

/**
 * Draw a polygon.
 * This function lets you draw a polygon on the NXT LCD given the parameters you pass
 * in via the \ref DrawPolygonType structure.
 *
 * \param args The DrawPolygonType structure containing the drawing parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysDrawPolygon(DrawPolygonType & args);
/** \example ex_sysdrawpolygon.nxc
 * This is an example of how to use the \ref SysDrawPolygon function along
 * with the \ref DrawPolygonType structure.
 */

/**
 * Draw an ellipse.
 * This function lets you draw an ellipse on the NXT LCD given the parameters you pass
 * in via the \ref DrawEllipseType structure.
 *
 * \param args The DrawEllipseType structure containing the drawing parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysDrawEllipse(DrawEllipseType & args);
/** \example ex_sysdrawellipse.nxc
 * This is an example of how to use the \ref SysDrawEllipse function along
 * with the \ref DrawEllipseType structure.
 */

/**
 * Draw text using a custom font.
 * This function lets you draw text on the NXT LCD using a custom font
 * with parameters you pass in via the \ref DrawFontType structure.
 *
 * \param args The DrawFontType structure containing the drawing parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysDrawFont(DrawFontType & args);
/** \example ex_sysdrawfont.nxc
 * This is an example of how to use the \ref SysDrawFont function along
 * with the \ref DrawFontType structure.
 */
#endif
#endif

#else

#define GetDisplayNormal(_x, _line, _cnt, _data) asm { __getDisplayNormal(_x, _line, _cnt, _data) }
#define GetDisplayPopup(_x, _line, _cnt, _data) asm { __getDisplayPopup(_x, _line, _cnt, _data) }

#define DisplayEraseMask() asm { GetDisplayEraseMask(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayUpdateMask() asm { GetDisplayUpdateMask(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayFont() asm { GetDisplayFont(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayDisplay() asm { GetDisplayDisplay(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayFlags() asm { GetDisplayFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define DisplayTextLinesCenterFlags() asm { GetDisplayTextLinesCenterFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SetDisplayNormal(_x, _line, _cnt, _data) asm { __setDisplayNormal(_x, _line, _cnt, _data) }
#define SetDisplayPopup(_x, _line, _cnt, _data) asm { __setDisplayPopup(_x, _line, _cnt, _data) }

#define SysDrawText(_args) asm { \
  compchktype _args, DrawTextType \
  syscall DrawText, _args \
}
#define SysDrawPoint(_args) asm { \
  compchktype _args, DrawPointType \
  syscall DrawPoint, _args \
}
#define SysDrawLine(_args) asm { \
  compchktype _args, DrawLineType \
  syscall DrawLine, _args \
}
#define SysDrawCircle(_args) asm { \
  compchktype _args, DrawCircleType \
  syscall DrawCircle, _args \
}
#define SysDrawRect(_args) asm { \
  compchktype _args, DrawRectType \
  syscall DrawRect, _args \
}
#define SysDrawGraphic(_args) asm { \
  compchktype _args, DrawGraphicType \
  syscall DrawGraphic, _args \
}
#define SysSetScreenMode(_args) asm { \
  compchktype _args, SetScreenModeType \
  syscall SetScreenMode, _args \
}

#ifdef __ENHANCED_FIRMWARE

#define SysDisplayExecuteFunction(_args) asm { \
  compchktype _args, DisplayExecuteFunctionType \
  syscall DisplayExecuteFunction, _args \
}

#if __FIRMWARE_VERSION > 107

#define DisplayContrast() asm { GetDisplayContrast(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SysDrawGraphicArray(_args) asm { \
  compchktype _args, DrawGraphicArrayType \
  syscall DrawGraphicArray, _args \
}
#define SysDrawPolygon(_args) asm { \
  compchktype _args, DrawPolygonType \
  syscall DrawPolygon, _args \
}
#define SysDrawEllipse(_args) asm { \
  compchktype _args, DrawEllipseType \
  syscall DrawEllipse, _args \
}
#define SysDrawFont(_args) asm { \
  compchktype _args, DrawFontType \
  syscall DrawFont, _args \
}
#endif
#endif
#endif

/**
 * Clear LCD screen.
 * This function lets you clear the NXT LCD to a blank screen.
 */
inline void ClearScreen() { asm { PointOutEx(200, 200, TRUE) } }
/** \example ex_ClearScreen.nxc
 * This is an example of how to use the \ref ClearScreen and \ref Wait functions.
 */

/**
 * Clear a line on the LCD screen.
 * This function lets you clear a single line on the NXT LCD.
 */
inline void ClearLine(byte line) { asm { TextOutEx(0, line, __BlankLine, 0) } }
/** \example ex_ClearLine.nxc
 * This is an example of how to use the \ref TextOut, \ref ClearLine, and
 * \ref Wait functions.
 */

/**
 * Set the display font memory address.
 * This function lets you set the current display font memory address.
 * 
 * \param addr The new display font memory address.
 */
inline void SetDisplayFont(unsigned long addr) { asm { __setDisplayFont(addr) } }
/** \example ex_SetDisplayFont.nxc
 * This is an example of how to use the \ref SetDisplayFont function.
 */

/**
 * Set the display memory address.
 * This function lets you set the current display memory address.
 * 
 * \param addr The new display memory address.
 */
inline void SetDisplayDisplay(unsigned long addr) { asm { __setDisplayDisplay(addr) } }
/** \example ex_SetDisplayDisplay.nxc
 * This is an example of how to use the \ref SetDisplayDisplay function.
 */

/**
 * Set the display erase mask.
 * This function lets you set the current display erase mask.
 * 
 * \param eraseMask The new display erase mask.
 */
inline void SetDisplayEraseMask(unsigned long eraseMask) { asm { __setDisplayEraseMask(eraseMask) } }
/** \example ex_SetDisplayEraseMask.nxc
 * This is an example of how to use the \ref SetDisplayEraseMask function.
 */

/**
 * Set the display flags.
 * This function lets you set the current display flags.
 *
 * \param flags The new display flags. See \ref DisplayFlagsGroup.
 */
inline void SetDisplayFlags(byte flags) { asm { __setDisplayFlags(flags) } }
/** \example ex_SetDisplayFlags.nxc
 * This is an example of how to use the \ref SetDisplayFlags function.
 */

/**
 * Set the display text lines center flags.
 * This function lets you set the current display text lines center flags.
 *
 * \param ctrFlags The new display text lines center flags.
 */
inline void SetDisplayTextLinesCenterFlags(byte ctrFlags) { asm { __setDisplayTextLinesCenterFlags(ctrFlags) } }
/** \example ex_SetDisplayTextLinesCenterFlags.nxc
 * This is an example of how to use the \ref SetDisplayTextLinesCenterFlags function.
 */

/**
 * Set the display update mask.
 * This function lets you set the current display update mask.
 *
 * \param updateMask The new display update mask.
 */
inline void SetDisplayUpdateMask(unsigned long updateMask) { asm { __setDisplayUpdateMask(updateMask) } }
/** \example ex_SetDisplayUpdateMask.nxc
 * This is an example of how to use the \ref SetDisplayUpdateMask function.
 */

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)
/**
 * Set the display contrast.
 * This function lets you set the display contrast setting.
 *
 * \param contrast The desired display contrast.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SetDisplayContrast(byte contrast) { asm { __setDisplayContrast(contrast) } }
/** \example ex_SetDisplayContrast.nxc
 * This is an example of how to use the \ref SetDisplayContrast function.
 */
#endif

/** @} */ // end of DisplayModuleFunctions group
/** @} */ // end of DisplayModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// SOUND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup SoundModule
 * @{
 */
/** @defgroup SoundModuleTypes Sound module types
 * Types used by various sound module functions.
 * @{
 */

/**
 * Type used with the PlayTones API function.
 * An array of this structure is used when calling the \ref PlayTones
 * API function.
 * \sa PlayTones()
 */
struct Tone {
  unsigned int Frequency; /*!< The tone frequency. See the \ref ToneConstants group. */
  unsigned int Duration;  /*!< The tone duration in milliseconds. See the \ref TimeConstants group. */
};

/**
 * Parameters for the SoundPlayFile system call.
 * This structure is used when calling the \ref SysSoundPlayFile system call
 * function.
 * \sa SysSoundPlayFile()
 */
struct SoundPlayFileType {
  char Result;       /*!< The function call result, always \ref NO_ERR. */
  string Filename;   /*!< The name of the file to play. */
  bool Loop;         /*!< If true, loops at end of file. */
  byte SoundLevel;   /*!< The sound level. Valid values range from 0 to 4. */
};

/**
 * Parameters for the SoundPlayTone system call.
 * This structure is used when calling the \ref SysSoundPlayTone system call
 * function.
 * \sa SysSoundPlayTone()
 */
struct SoundPlayToneType {
  char Result;              /*!< The function call result, always \ref NO_ERR. */
  unsigned int Frequency;   /*!< The tone frequency. See the \ref ToneConstants group. */
  unsigned int Duration;    /*!< The tone duration in milliseconds. See the \ref TimeConstants group. */
  bool Loop;                /*!< If true, loops forever. */
  byte SoundLevel;          /*!< The sound level. Valid values range from 0 to 4. */
};

/**
 * Parameters for the SoundGetState system call.
 * This structure is used when calling the \ref SysSoundGetState system call
 * function.
 * \sa SysSoundGetState()
 */
struct SoundGetStateType {
  byte State;   /*!< The returned sound state. See the \ref SoundStateConstants group. */
  byte Flags;   /*!< The returned sound flags. See the \ref SoundFlagsConstants group. */
};

/**
 * Parameters for the SoundSetState system call.
 * This structure is used when calling the \ref SysSoundSetState system call
 * function.
 * \sa SysSoundSetState()
 */
struct SoundSetStateType {
  byte Result;   /*!< The function call result, same as State. */
  byte State;    /*!< The new sound state. See the \ref SoundStateConstants group. */
  byte Flags;    /*!< The new sound flags. See the \ref SoundFlagsConstants group. */
};

/** @} */ // end of SoundModuleTypes group

/** @defgroup SoundModuleFunctions Sound module functions
 * Functions for accessing and modifying sound module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Play a file.
 * Play the specified file. The filename may be any valid string expression.
 * The sound file can either be an RSO file containing PCM or compressed ADPCM
 * samples or it can be an NXT melody (RMD) file containing frequency and
 * duration values.
 *
 * \param filename The name of the sound or melody file to play.
 */
inline char PlayFile(string filename);
/** \example ex_PlayFile.nxc
 * This is an example of how to use the \ref PlayFile function.
 */

/**
 * Play a file with extra options.
 * Play the specified file. The filename may be any valid string expression.
 * Volume should be a number from 0 (silent) to 4 (loudest). Play the file
 * repeatedly if loop is true.
 * The sound file can either be an RSO file containing PCM or compressed ADPCM
 * samples or it can be an NXT melody (RMD) file containing frequency and
 * duration values.
 *
 * \param filename The name of the sound or melody file to play.
 * \param volume The desired tone volume.
 * \param loop A boolean flag indicating whether to play the file repeatedly.
 */
inline char PlayFileEx(string filename, byte volume, bool loop);
/** \example ex_PlayFileEx.nxc
 * This is an example of how to use the \ref PlayFileEx function.
 */

/**
 * Play a tone.
 * Play a single tone of the specified frequency and duration. The frequency is
 * in Hz (see the \ref ToneConstants group). The duration is in 1000ths of a
 * second (see the \ref TimeConstants group). The tone is played at the loudest
 * sound level supported by the firmware and it is not looped.
 *
 * \param frequency The desired tone frequency, in Hz.
 * \param duration The desired tone duration, in ms.
 */
inline char PlayTone(unsigned int frequency, unsigned int duration);
/** \example ex_PlayTone.nxc
 * This is an example of how to use the \ref PlayTone function.
 */

/**
 * Play a tone with extra options.
 * Play a single tone of the specified frequency, duration, and volume. The
 * frequency is in Hz (see the \ref ToneConstants group). The duration is in
 * 1000ths of a second (see the \ref TimeConstants group). Volume should be a
 * number from 0 (silent) to 4 (loudest). Play the tone repeatedly if loop is
 * true.
 *
 * \param frequency The desired tone frequency, in Hz.
 * \param duration The desired tone duration, in ms.
 * \param volume The desired tone volume.
 * \param loop A boolean flag indicating whether to play the tone repeatedly.
 */
inline char PlayToneEx(unsigned int frequency, unsigned int duration, byte volume, bool loop);
/** \example ex_PlayToneEx.nxc
 * This is an example of how to use the \ref PlayToneEx function.
 */

/**
 * Get sound module state.
 * Return the current sound module state. See the \ref SoundStateConstants group.
 *
 * \sa SetSoundModuleState(), SysSoundSetState(), SysSoundGetState()
 * \return The current sound module state.
 */
inline byte SoundState();
/** \example ex_SoundState.nxc
 * This is an example of how to use the \ref SoundState function.
 */

/**
 * Get sound module flags.
 * Return the current sound module flags. See the \ref SoundFlagsConstants group.
 *
 * \sa SetSoundFlags(), SysSoundSetState(), SysSoundGetState()
 * \return The current sound module flags.
 */
inline byte SoundFlags();
/** \example ex_SoundFlags.nxc
 * This is an example of how to use the \ref SoundFlags function.
 */

/**
 * Stop sound.
 * Stop playing of the current tone or file.
 *
 * \return The result \todo ?.
 */
inline byte StopSound();
/** \example ex_StopSound.nxc
 * This is an example of how to use the \ref StopSound function.
 */

/**
 * Get sound frequency.
 * Return the current sound frequency.
 *
 * \sa SetSoundFrequency()
 * \return The current sound frequency.
 */
inline unsigned int SoundFrequency();
/** \example ex_SoundFrequency.nxc
 * This is an example of how to use the \ref SoundFrequency function.
 */

/**
 * Get sound duration.
 * Return the current sound duration.
 *
 * \sa SetSoundDuration()
 * \return The current sound duration.
 */
inline unsigned int SoundDuration();
/** \example ex_SoundDuration.nxc
 * This is an example of how to use the \ref SoundDuration function.
 */

/**
 * Get sample rate.
 * Return the current sound sample rate.
 *
 * \sa SetSoundSampleRate()
 * \return The current sound sample rate.
 */
inline unsigned int SoundSampleRate();
/** \example ex_SoundSampleRate.nxc
 * This is an example of how to use the \ref SoundSampleRate function.
 */

/**
 * Get sound mode.
 * Return the current sound mode.  See the \ref SoundModeConstants group.
 *
 * \sa SetSoundMode()
 * \return The current sound mode.
 */
inline byte SoundMode();
/** \example ex_SoundMode.nxc
 * This is an example of how to use the \ref SoundMode function.
 */

/**
 * Get volume.
 * Return the current sound volume.
 *
 * \sa SetSoundVolume()
 * \return The current sound volume.
 */
inline byte SoundVolume();
/** \example ex_SoundVolume.nxc
 * This is an example of how to use the \ref SoundVolume function.
 */

/**
 * Set sound duration.
 * Set the sound duration.
 *
 * \sa SoundDuration()
 * \param duration The new sound duration
 */
inline void SetSoundDuration(unsigned int duration);
/** \example ex_SetSoundDuration.nxc
 * This is an example of how to use the \ref SetSoundDuration function.
 */

/**
 * Set sound module flags.
 * Set the sound module flags. See the \ref SoundFlagsConstants group.
 *
 * \sa SetSoundFlags(), SysSoundSetState(), SysSoundGetState()
 * \param flags The new sound module flags
 */
inline void SetSoundFlags(byte flags);
/** \example ex_SetSoundFlags.nxc
 * This is an example of how to use the \ref SetSoundFlags function.
 */

/**
 * Set sound frequency.
 * Set the sound frequency.
 *
 * \sa SoundFrequency()
 * \param frequency The new sound frequency
 */
inline void SetSoundFrequency(unsigned int frequency);
/** \example ex_SetSoundFrequency.nxc
 * This is an example of how to use the \ref SetSoundFrequency function.
 */

/**
 * Set sound mode.
 * Set the sound mode.  See the \ref SoundModeConstants group.
 *
 * \sa SoundMode()
 * \param mode The new sound mode
 */
inline void SetSoundMode(byte mode);
/** \example ex_SetSoundMode.nxc
 * This is an example of how to use the \ref SetSoundMode function.
 */

/**
 * Set sound module state.
 * Set the sound module state. See the \ref SoundStateConstants group.
 *
 * \sa SoundState(), SysSoundSetState(), SysSoundGetState()
 * \param state The new sound state
 */
inline void SetSoundModuleState(byte state);
/** \example ex_SetSoundModuleState.nxc
 * This is an example of how to use the \ref SetSoundModuleState function.
 */

/**
 * Set sample rate.
 * Set the sound sample rate.
 *
 * \sa SoundSampleRate()
 * \param sampleRate The new sample rate
 */
inline void SetSoundSampleRate(unsigned int sampleRate);
/** \example ex_SetSoundSampleRate.nxc
 * This is an example of how to use the \ref SetSoundSampleRate function.
 */

/**
 * Set sound volume.
 * Set the sound volume.
 *
 * \sa SoundVolume()
 * \param volume The new volume
 */
inline void SetSoundVolume(byte volume);
/** \example ex_SetSoundVolume.nxc
 * This is an example of how to use the \ref SetSoundVolume function.
 */

/**
 * Play sound file.
 * This function lets you play a sound file given the parameters you pass in
 * via the \ref SoundPlayFileType structure. The sound file can either be an
 * RSO file containing PCM or compressed ADPCM samples or it can be an NXT
 * melody (RMD) file containing frequency and duration values.
 *
 * \param args The SoundPlayFileType structure containing the needed
 * parameters.
 */
inline void SysSoundPlayFile(SoundPlayFileType & args);
/** \example ex_syssoundplayfile.nxc
 * This is an example of how to use the \ref SysSoundPlayFile function along with
 * the \ref SoundPlayFileType structure.
 */

/**
 * Play tone.
 * This function lets you play a tone given the parameters you pass in via the
 * \ref SoundPlayToneType structure.
 *
 * \param args The SoundPlayToneType structure containing the needed
 * parameters.
 */
inline void SysSoundPlayTone(SoundPlayToneType & args);
/** \example ex_syssoundplaytone.nxc
 * This is an example of how to use the \ref SysSoundPlayTone function along with
 * the \ref SoundPlayToneType structure.
 */

/**
 * Get sound state.
 * This function lets you retrieve information about the sound module state
 * via the \ref SoundGetStateType structure.
 *
 * \param args The SoundGetStateType structure containing the needed
 * parameters.
 */
inline void SysSoundGetState(SoundGetStateType & args);
/** \example ex_syssoundgetstate.nxc
 * This is an example of how to use the \ref SysSoundGetState function along with
 * the \ref SoundGetStateType structure.
 */

/**
 * Set sound state.
 * This function lets you set sound module state settings via the \ref
 * SoundSetStateType structure.
 *
 * \param args The SoundSetStateType structure containing the needed
 * parameters.
 */
inline void SysSoundSetState(SoundSetStateType & args);
/** \example ex_syssoundsetstate.nxc
 * This is an example of how to use the \ref SysSoundSetState function along with
 * the \ref SoundSetStateType structure.
 */

#else

#define PlayTone(_f, _d) PlayToneEx(_f, _d, 4, 0)
#define PlayFile(_f) PlayFileEx(_f, 4, 0)

#define SoundState() asm { GetSoundState(__RETVAL__, __TMPBYTE__) }
#define SoundFlags() asm { GetSoundState(__TMPBYTE__, __RETVAL__) }
#define StopSound() asm { __setSoundState(SOUND_STATE_STOP, 0, __RETVAL__) }

#define SoundFrequency() asm { GetSoundFrequency(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundDuration() asm { GetSoundDuration(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundSampleRate() asm { GetSoundSampleRate(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundMode() asm { GetSoundMode(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SoundVolume() asm { GetSoundVolume(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SetSoundFrequency(_n) asm { __setSoundFrequency(_n) }
#define SetSoundDuration(_n) asm { __setSoundDuration(_n) }
#define SetSoundSampleRate(_n) asm { __setSoundSampleRate(_n) }
#define SetSoundFlags(_n) asm { __setSoundFlags(_n) }
#define SetSoundModuleState(_n) asm { __setSoundModuleState(_n) }
#define SetSoundMode(_n) asm { __setSoundMode(_n) }
#define SetSoundVolume(_n) asm { __setSoundVolume(_n) }

#define SysSoundPlayFile(_args) asm { \
  compchktype _args, SoundPlayFileType \
  syscall SoundPlayFile, _args \
}
#define SysSoundPlayTone(_args) asm { \
  compchktype _args, SoundPlayToneType \
  syscall SoundPlayTone, _args \
}
#define SysSoundGetState(_args) asm { \
  compchktype _args, SoundGetStateType \
  syscall SoundGetState, _args \
}
#define SysSoundSetState(_args) asm { \
  compchktype _args, SoundSetStateType \
  syscall SoundSetState, _args \
}

#endif

/**
 * Play a system sound.
 * Play a sound that mimics the RCX system sounds using one of the
 * \ref RCXSoundConstants.
 * <TABLE BORDER=1>
 * <TR><TH>aCode</TH><TH>Resulting Sound</TH></TR>
 * <TR><TD>\ref SOUND_CLICK</TD><TD>key click sound</TD></TR>
 * <TR><TD>\ref SOUND_DOUBLE_BEEP</TD><TD>double beep</TD></TR>
 * <TR><TD>\ref SOUND_DOWN</TD><TD>sweep down</TD></TR>
 * <TR><TD>\ref SOUND_UP</TD><TD>sweep up</TD></TR>
 * <TR><TD>\ref SOUND_LOW_BEEP</TD><TD>error sound</TD></TR>
 * <TR><TD>\ref SOUND_FAST_UP</TD><TD>fast sweep up</TD></TR>
 * </TABLE>
 * \param aCode The system sound to play.  See \ref RCXSoundConstants.
 */
void PlaySound(const int &aCode)
{
    if (aCode == SOUND_CLICK)
        PlayTone(600, MS_200);
    else if (aCode == SOUND_DOUBLE_BEEP)
    {
        PlayTone(600, MS_150);
        asm { wait MS_200 };
        PlayTone(600, MS_150);
        asm { wait MS_150 };
    }
    else if (aCode == SOUND_UP)
        for (int i = 4; i < 8; i++)
        {
            PlayTone(TONE_C5 * i / 4, MS_100);
            asm { wait MS_100 };
        }
    else if (aCode == SOUND_DOWN)
        for (int i = 7; i > 3; i--)
        {
            PlayTone(TONE_C5 * i / 4, MS_100);
            asm { wait MS_100 };
        }
    else if (aCode == SOUND_LOW_BEEP)
    {
        PlayTone(100, MS_500);
        asm { wait MS_500 };
    }
    else if (aCode == SOUND_FAST_UP)
        for (int i = 4; i < 8; i++)
        {
            PlayTone(TONE_C5 * i / 4, MS_50);
            asm { wait MS_50 };
        }
}
/** \example ex_playsound.nxc
 * This is an example of how to use the \ref PlaySound function.
 */

/**
 * Play multiple tones.
 * Play a series of tones contained in the tones array.  Each element
 * in the array is an instance of the \ref Tone structure, containing
 * a frequency and a duration.
 *
 * \param tones The array of tones to play.
 */
void PlayTones(Tone tones[])
{
  for (int i = 0; i <  asm { arrsize __RETVAL__, tones }; i++) {
    Tone tmp = tones[i];
    PlayTone(tmp.Frequency, tmp.Duration);
    asm { waitv tmp.Duration };
  }
}
/** \example ex_playtones.nxc
 * This is an example of how to use the \ref PlayTones function along with
 * the \ref Tone structure.
 */

/** @} */ // end of SoundModuleFunctions group
/** @} */ // end of SoundModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// LOWSPEED MODULE ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup LowSpeedModule
 * @{
 */
/** @defgroup LowSpeedModuleTypes LowSpeed module types
 * Types used by various low speed module functions.
 * @{
 */
/**
 * Parameters for the CommLSWrite system call.
 * This structure is used when calling the \ref SysCommLSWrite system call
 * function.
 * \sa SysCommLSWrite()
 */
struct CommLSWriteType {
  char Result;      /*!< The function call result. Possible values include
                      \ref ERR_COMM_CHAN_INVALID, \ref ERR_COMM_CHAN_NOT_READY,
                      \ref ERR_INVALID_SIZE, and \ref NO_ERR. */
  byte Port;        /*!< The port to which the I2C device is connected. */
  byte Buffer[];    /*!< The buffer containing data to be written to the I2C device. */
  byte ReturnLen;   /*!< The number of bytes that you want to read from the I2C device
                      after writing the data.  If no read is planned set this to zero. */
};

/**
 * Parameters for the CommLSRead system call.
 * This structure is used when calling the \ref SysCommLSRead system call
 * function.
 * \sa SysCommLSRead()
 */
struct CommLSReadType {
  char Result;      /*!< The function call result. Possible values include
                      \ref ERR_COMM_BUS_ERR, \ref ERR_COMM_CHAN_INVALID,
                      \ref ERR_COMM_CHAN_NOT_READY, \ref ERR_INVALID_SIZE,
                      \ref STAT_COMM_PENDING, and \ref NO_ERR. */
  byte Port;        /*!< The port to which the I2C device is connected. */
  byte Buffer[];    /*!< The buffer used to store the bytes read from the I2C device. */
  byte BufferLen;   /*!< The size of the output buffer on input.  This field is not updated during the function call. */
};

/**
 * Parameters for the CommLSCheckStatus system call.
 * This structure is used when calling the \ref SysCommLSCheckStatus system
 * call function.
 * \sa SysCommLSCheckStatus()
 */
struct CommLSCheckStatusType {
  char Result;       /*!< The function call result. Possible values include
                       \ref ERR_COMM_BUS_ERR, \ref ERR_COMM_CHAN_INVALID,
                       \ref ERR_COMM_CHAN_NOT_READY, \ref STAT_COMM_PENDING,
                       and \ref NO_ERR. */
  byte Port;         /*!< The port to which the I2C device is connected. */
  byte BytesReady;   /*!< The number of bytes ready to read from the specified port. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the CommLSWriteEx system call.
 * This structure is used when calling the \ref SysCommLSWriteEx system call
 * function.
 * \sa SysCommLSWriteEx()
 */
struct CommLSWriteExType {
  char Result;          /*!< The function call result. Possible values include
                      \ref ERR_COMM_CHAN_INVALID, \ref ERR_COMM_CHAN_NOT_READY,
                      \ref ERR_INVALID_SIZE, and \ref NO_ERR. */
  byte Port;            /*!< The port to which the I2C device is connected. */
  byte Buffer[];        /*!< The buffer written to the I2C device. */
  byte ReturnLen;       /*!< The number of bytes that you want to read from the I2C device. */
  bool NoRestartOnRead; /*!< Should a restart occur before reading from the device? */
};
#endif

/** @} */ // end of LowSpeedModuleTypes group

/** @defgroup LowSpeedModuleFunctions LowSpeed module functions
 * Functions for accessing and modifying low speed module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Read ultrasonic sensor value.
 * Return the ultrasonic sensor distance value. Since an
 * ultrasonic sensor is an I2C digital sensor its value cannot be read using
 * the standard Sensor(n) value.
 * The port must be configured as a Lowspeed port before using this function.
 * \param port The port to which the ultrasonic sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \return The ultrasonic sensor distance value (0..255)
 */
inline byte SensorUS(const byte port);
/** \example ex_sensorus.nxc
 * This is an example of how to use the \ref SensorUS function.
 */

/**
 * Read multiple ultrasonic sensor values.
 * Return eight ultrasonic sensor distance values.
 * \param port The port to which the ultrasonic sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param values An array of bytes that will contain the 8 distance values
 * read from the ultrasonic sensor.
 * \return A status code indicating whether the read completed successfully or not.
 * See \ref CommLSReadType for possible Result values.
 */
inline char ReadSensorUSEx(const byte port, byte & values[]);
/** \example ex_readsensorusex.nxc
 * This is an example of how to use the \ref ReadSensorUSEx function.
 */

/**
 * Read I2C register.
 * Read a single byte from an I2C device register.
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param reg The I2C device register from which to read a single byte.
 * \param out The single byte read from the I2C device.
 * \return A status code indicating whether the read completed successfully or not.
 * See \ref CommLSReadType for possible Result values.
 */
inline char ReadI2CRegister(byte port, byte reg, byte & out);
/** \example ex_readi2cregister.nxc
 * This is an example of how to use the \ref ReadI2CRegister function.
 */

/**
 * Write I2C register.
 * Write a single byte to an I2C device register.
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param reg The I2C device register to which to write a single byte.
 * \param val The byte to write to the I2C device.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline char WriteI2CRegister(byte port, byte reg, byte val);
/** \example ex_writei2cregister.nxc
 * This is an example of how to use the \ref WriteI2CRegister function.
 */

/**
 * Get lowspeed status.
 * This method checks the status of the I2C communication on the specified
 * port. If the last operation on this port was a successful LowspeedWrite
 * call that requested response data from the device then bytesready will
 * be set to the number of bytes in the internal read buffer.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param bytesready The number of bytes available to be read from the internal I2C buffer.
 * The maximum number of bytes that can be read is 16.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref LowspeedRead or \ref LowspeedWrite while LowspeedStatus returns
 * \ref STAT_COMM_PENDING.
 * \sa I2CStatus, I2CRead, I2CWrite, I2CCheckStatus, I2CBytesReady, LowspeedRead,
 * LowspeedWrite, and LowspeedCheckStatus
 */
inline long LowspeedStatus(const byte port, byte & bytesready);
/** \example ex_lowspeedstatus.nxc
 * This is an example of how to use the \ref LowspeedStatus function.
 */

/**
 * Check lowspeed status.
 * This method checks the status of the I2C communication on the specified
 * port.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref LowspeedRead or \ref LowspeedWrite while LowspeedCheckStatus returns
 * \ref STAT_COMM_PENDING.
 * \sa I2CCheckStatus, I2CRead, I2CWrite, I2CStatus, I2CBytesReady, LowspeedRead,
 * LowspeedWrite, and LowspeedStatus
 */
inline long LowspeedCheckStatus(const byte port);
/** \example ex_LowspeedCheckStatus.nxc
 * This is an example of how to use the \ref LowspeedCheckStatus function.
 */

/**
 * Get lowspeed bytes ready.
 * This method checks the number of bytes that are ready to be read on the
 * specified port. If the last operation on this port was a successful
 * LowspeedWrite call that requested response data from the device then the
 * return value will be the number of bytes in the internal read buffer.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \return The number of bytes available to be read from the internal I2C buffer.
 * The maximum number of bytes that can be read is 16.
 * \sa I2CCheckStatus, I2CRead, I2CWrite, I2CStatus, I2CBytesReady, LowspeedRead,
 * LowspeedWrite, and LowspeedStatus
 */
inline byte LowspeedBytesReady(const byte port);
/** \example ex_LowspeedBytesReady.nxc
 * This is an example of how to use the \ref LowspeedBytesReady function.
 */

/**
 * Write lowspeed data.
 * This method starts a transaction to write the bytes contained in the array
 * buffer to the I2C device on the specified port. It also tells the I2C device
 * the number of bytes that should be included in the response. The maximum
 * number of bytes that can be written or read is 16.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param retlen The number of bytes that should be returned by the I2C device.
 * \param buffer A byte array containing the address of the I2C device, the I2C
 * device register at which to write data, and up to 14 bytes of data to be
 * written at the specified register.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSWriteType for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa I2CCheckStatus, I2CRead, I2CWrite, I2CStatus, I2CBytesReady, LowspeedRead,
 * LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
inline long LowspeedWrite(const byte port, byte retlen, byte buffer[]);
/** \example ex_LowspeedWrite.nxc
 * This is an example of how to use the \ref LowspeedWrite function.
 */

/**
 * Read lowspeed data.
 * Read the specified number of bytes from the I2C device on the specified
 * port and store the bytes read in the byte array buffer provided.  The maximum
 * number of bytes that can be written or read is 16.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param buflen The initial size of the output buffer.
 * \param buffer A byte array that contains the data read from the internal I2C
 * buffer.  If the return value is negative then the output buffer will be empty.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSReadType for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa I2CCheckStatus, I2CRead, I2CWrite, I2CStatus, I2CBytesReady, LowspeedWrite,
 * LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
inline long LowspeedRead(const byte port, byte buflen, byte & buffer[]);
/** \example ex_LowspeedRead.nxc
 * This is an example of how to use the \ref LowspeedRead function.
 */

/**
 * Get I2C status.
 * This method checks the status of the I2C communication on the specified
 * port. If the last operation on this port was a successful I2CWrite
 * call that requested response data from the device then bytesready will
 * be set to the number of bytes in the internal read buffer.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param bytesready The number of bytes available to be read from the internal I2C buffer.
 * The maximum number of bytes that can be read is 16.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSCheckStatusType for possible return values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref I2CRead or \ref I2CWrite while I2CStatus returns
 * \ref STAT_COMM_PENDING.
 * \sa I2CCheckStatus, I2CRead, I2CWrite, LowspeedStatus, LowspeedRead,
 * LowspeedWrite, and LowspeedCheckStatus
 */
inline long I2CStatus(const byte port, byte & bytesready);
/** \example ex_I2CStatus.nxc
 * This is an example of how to use the \ref I2CStatus function.
 */

/**
 * Check I2C status.
 * This method checks the status of the I2C communication on the specified
 * port.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref I2CRead or \ref I2CWrite while this function returns
 * \ref STAT_COMM_PENDING.
 * \sa I2CStatus, I2CRead, I2CWrite, LowspeedStatus, LowspeedRead,
 * LowspeedWrite, and LowspeedCheckStatus
 */
inline long I2CCheckStatus(const byte port);
/** \example ex_I2CCheckStatus.nxc
 * This is an example of how to use the \ref I2CCheckStatus function.
 */

/**
 * Get I2C bytes ready.
 * This method checks the number of bytes that are ready to be read on the
 * specified port. If the last operation on this port was a successful
 * I2CWrite call that requested response data from the device then the
 * return value will be the number of bytes in the internal read buffer.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \return The number of bytes available to be read from the internal I2C buffer.
 * The maximum number of bytes that can be read is 16.
 * \sa I2CCheckStatus, I2CRead, I2CWrite, I2CStatus, LowspeedBytesReady, LowspeedRead,
 * LowspeedWrite, and LowspeedStatus
 */
inline byte I2CBytesReady(const byte port);
/** \example ex_I2CBytesReady.nxc
 * This is an example of how to use the \ref I2CBytesReady function.
 */

/**
 * Write I2C data.
 * This method starts a transaction to write the bytes contained in the array
 * buffer to the I2C device on the specified port. It also tells the I2C device
 * the number of bytes that should be included in the response. The maximum
 * number of bytes that can be written or read is 16.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param retlen The number of bytes that should be returned by the I2C device.
 * \param buffer A byte array containing the address of the I2C device, the I2C
 * device register at which to write data, and up to 14 bytes of data to be
 * written at the specified register.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSWriteType for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa I2CCheckStatus, I2CRead, I2CStatus, I2CBytesReady, LowspeedRead, LowspeedWrite,
 * LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
inline long I2CWrite(const byte port, byte retlen, byte buffer[]);
/** \example ex_i2cwrite.nxc
 * This is an example of how to use the \ref I2CWrite function.
 */

/**
 * Read I2C data.
 * Read the specified number of bytes from the I2C device on the specified
 * port and store the bytes read in the byte array buffer provided.  The maximum
 * number of bytes that can be written or read is 16.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param buflen The initial size of the output buffer.
 * \param buffer A byte array that contains the data read from the internal I2C
 * buffer.  If the return value is negative then the output buffer will be empty.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSReadType for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa I2CCheckStatus, I2CWrite, I2CStatus, I2CBytesReady, LowspeedRead, LowspeedWrite,
 * LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
inline long I2CRead(const byte port, byte buflen, byte & buffer[]);
/** \example ex_I2CRead.nxc
 * This is an example of how to use the \ref I2CRead function.
 */

/**
 * Perform an I2C write/read transaction.
 * This method writes the bytes contained in the input buffer (inbuf) to the
 * I2C device on the specified port, checks for the specified number of bytes
 * to be ready for reading, and then tries to read the specified number (count)
 * of bytes from the I2C device into the output buffer (outbuf).
 *
 * This is a higher-level wrapper around the three main I2C functions. It also
 * maintains a "last good read" buffer and returns values from that buffer if
 * the I2C communication transaction fails.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param inbuf A byte array containing the address of the I2C device, the I2C
 * device register at which to write data, and up to 14 bytes of data to be
 * written at the specified register.
 * \param count The number of bytes that should be returned by the I2C device.
 * On output count is set to the number of bytes in outbuf.
 * \param outbuf A byte array that contains the data read from the internal I2C
 * buffer.
 * \return Returns true or false indicating whether the I2C transaction
 * succeeded or failed.
 * \sa I2CCheckStatus, I2CWrite, I2CStatus, I2CBytesReady, I2CRead, LowspeedRead, LowspeedWrite,
 * LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
inline long I2CBytes(const byte port, byte inbuf[], byte & count, byte & outbuf[]);
/** \example ex_I2CBytes.nxc
 * This is an example of how to use the \ref I2CBytes function.
 */

/**
 * Read I2C device information.
 * Read standard I2C device information: version, vendor, and device ID. The
 * I2C device must use address 0x02.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param info A value indicating the type of device information you are requesting.
 * See \ref GenericI2CConstants.
 * \return A string containing the requested device information.
 * \sa I2CDeviceInfoEx
 */
inline string I2CDeviceInfo(byte port, byte info);
/** \example ex_I2CDeviceInfo.nxc
 * This is an example of how to use the \ref I2CDeviceInfo function.
 */

/**
 * Read I2C device information extra.
 * Read standard I2C device information: version, vendor, and device ID. The
 * I2C device uses the specified address.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param addr The I2C device address.
 * \param info A value indicating the type of device information you are requesting.
 * See \ref GenericI2CConstants.
 * \return A string containing the requested device information.
 * \sa I2CDeviceInfo
 */
inline string I2CDeviceInfoEx(byte port, byte addr, byte info);
/** \example ex_I2CDeviceInfoEx.nxc
 * This is an example of how to use the \ref I2CDeviceInfoEx function.
 */

/**
 * Read I2C device version.
 * Read standard I2C device version. The I2C device must use address 0x02.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \return A string containing the device version.
 * \sa I2CVersionEx
 */
inline string I2CVersion(byte port);
/** \example ex_I2CVersion.nxc
 * This is an example of how to use the \ref I2CVersion function.
 */

/**
 * Read I2C device version extra.
 * Read standard I2C device version. The I2C device uses the specified address.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param addr The I2C device address.
 * \return A string containing the device version.
 * \sa I2CVersion
 */
inline string I2CVersionEx(byte port, byte addr);
/** \example ex_I2CVersionEx.nxc
 * This is an example of how to use the \ref I2CVersionEx function.
 */

/**
 * Read I2C device vendor.
 * Read standard I2C device vendor. The I2C device must use address 0x02.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \return A string containing the device vendor.
 * \sa I2CVendorIdEx
 */
inline string I2CVendorId(byte port);
/** \example ex_I2CVendorId.nxc
 * This is an example of how to use the \ref I2CVendorId function.
 */

/**
 * Read I2C device vendor extra.
 * Read standard I2C device vendor. The I2C device uses the specified address.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param addr The I2C device address.
 * \return A string containing the device vendor.
 * \sa I2CVendorId
 */
inline string I2CVendorIdEx(byte port, byte addr);
/** \example ex_I2CVendorIdEx.nxc
 * This is an example of how to use the \ref I2CVendorIdEx function.
 */

/**
 * Read I2C device identifier.
 * Read standard I2C device identifier. The I2C device must use address 0x02.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \return A string containing the device identifier.
 * \sa I2CDeviceIdEx
 */
inline string I2CDeviceId(byte port);
/** \example ex_I2CDeviceId.nxc
 * This is an example of how to use the \ref I2CDeviceId function.
 */

/**
 * Read I2C device identifier extra.
 * Read standard I2C device identifier. The I2C device uses the specified address.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param addr The I2C device address.
 * \return A string containing the device identifier.
 * \sa I2CDeviceId
 */
inline string I2CDeviceIdEx(byte port, byte addr);
/** \example ex_I2CDeviceIdEx.nxc
 * This is an example of how to use the \ref I2CDeviceIdEx function.
 */

/**
 * Send an I2C command.
 * Send a command to an I2C device at the standard command register: \ref I2C_REG_CMD.
 * The I2C device must use address 0x02.
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param cmd The command to send to the I2C device.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline long I2CSendCommand(byte port, byte cmd);
/** \example ex_I2CSendCommand.nxc
 * This is an example of how to use the \ref I2CSendCommand function.
 */

/**
 * Send an I2C command extra.
 * Send a command to an I2C device at the standard command register: \ref I2C_REG_CMD.
 * The I2C device uses the specified address.
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param addr The I2C device address.
 * \param cmd The command to send to the I2C device.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSCheckStatusType for possible Result values.
 */
inline long I2CSendCommandEx(byte port, byte addr, byte cmd);
/** \example ex_I2CSendCommandEx.nxc
 * This is an example of how to use the \ref I2CSendCommandEx function.
 */

/** @defgroup LowLevelLowSpeedModuleFunctions Low level LowSpeed module functions
 * Low level functions for accessing low speed module features.
 * @{
 */

/**
 * Get I2C input buffer data.
 * This method reads count bytes of data from the I2C input buffer for the
 * specified port and writes it to the buffer provided.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \param offset A constant offset into the I2C input buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the I2C input buffer.
 */
inline void GetLSInputBuffer(const byte port, const byte offset, byte cnt, byte & data[]);
/** \example ex_GetLSInputBuffer.nxc
 * This is an example of how to use the \ref GetLSInputBuffer function.
 */

/**
 * Get I2C output buffer data.
 * This method reads cnt bytes of data from the I2C output buffer for the
 * specified port and writes it to the buffer provided.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \param offset A constant offset into the I2C output buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the I2C output buffer.
 */
inline void GetLSOutputBuffer(const byte port, const byte offset, byte cnt, byte & data[]);
/** \example ex_GetLSOutputBuffer.nxc
 * This is an example of how to use the \ref GetLSOutputBuffer function.
 */

/**
 * Get I2C input buffer in-pointer.
 * This method returns the value of the input pointer of the I2C input
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C input buffer's in-pointer value.
 */
inline byte LSInputBufferInPtr(const byte port);
/** \example ex_LSInputBufferInPtr.nxc
 * This is an example of how to use the \ref LSInputBufferInPtr function.
 */

/**
 * Get I2C input buffer out-pointer.
 * This method returns the value of the output pointer of the I2C input
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C input buffer's out-pointer value.
 */
inline byte LSInputBufferOutPtr(const byte port);
/** \example ex_LSInputBufferOutPtr.nxc
 * This is an example of how to use the \ref LSInputBufferOutPtr function.
 */

/**
 * Get I2C input buffer bytes to rx.
 * This method returns the value of the bytes to rx field of the I2C input
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C input buffer's bytes to rx value.
 */
inline byte LSInputBufferBytesToRx(const byte port);
/** \example ex_LSInputBufferBytesToRx.nxc
 * This is an example of how to use the \ref LSInputBufferBytesToRx function.
 */

/**
 * Get I2C output buffer in-pointer.
 * This method returns the value of the input pointer of the I2C output
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C output buffer's in-pointer value.
 */
inline byte LSOutputBufferInPtr(const byte port);
/** \example ex_LSOutputBufferInPtr.nxc
 * This is an example of how to use the \ref LSOutputBufferInPtr function.
 */

/**
 * Get I2C output buffer out-pointer.
 * This method returns the value of the output pointer of the I2C output
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C output buffer's out-pointer value.
 */
inline byte LSOutputBufferOutPtr(const byte port);
/** \example ex_LSOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref LSOutputBufferOutPtr function.
 */

/**
 * Get I2C output buffer bytes to rx.
 * This method returns the value of the bytes to rx field of the I2C output
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C output buffer's bytes to rx value.
 */
inline byte LSOutputBufferBytesToRx(const byte port);
/** \example ex_LSOutputBufferBytesToRx.nxc
 * This is an example of how to use the \ref LSOutputBufferBytesToRx function.
 */

/**
 * Get I2C mode.
 * This method returns the value of the I2C mode for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C port mode. See \ref LowSpeedModeConstants.
 */
inline byte LSMode(const byte port);
/** \example ex_LSMode.nxc
 * This is an example of how to use the \ref LSMode function.
 */

/**
 * Get I2C channel state.
 * This method returns the value of the I2C channel state for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C port channel state. See \ref LowSpeedChannelStateConstants.
 */
inline byte LSChannelState(const byte port);
/** \example ex_LSChannelState.nxc
 * This is an example of how to use the \ref LSChannelState function.
 */

/**
 * Get I2C error type.
 * This method returns the value of the I2C error type for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C port error type. See \ref LowSpeedErrorTypeConstants.
 */
inline byte LSErrorType(const byte port);
/** \example ex_LSErrorType.nxc
 * This is an example of how to use the \ref LSErrorType function.
 */

/**
 * Get I2C state.
 * This method returns the value of the I2C state.
 * \return The I2C state. See \ref LowSpeedStateConstants.
 */
inline byte LSState();
/** \example ex_LSState.nxc
 * This is an example of how to use the \ref LSState function.
 */

/**
 * Get I2C speed.
 * This method returns the value of the I2C speed.
 * \return The I2C speed.
 * \warning This function is unimplemented within the firmware.
 */
inline byte LSSpeed();
/** \example ex_LSSpeed.nxc
 * This is an example of how to use the \ref LSSpeed function.
 */

#ifdef __ENHANCED_FIRMWARE
/**
 * Get I2C no restart on read setting.
 * This method returns the value of the I2C no restart on read field.
 * \return The I2C no restart on read field. See \ref LowSpeedNoRestartConstants.
 */
inline byte LSNoRestartOnRead();
/** \example ex_LSNoRestartOnRead.nxc
 * This is an example of how to use the \ref LSNoRestartOnRead function.
 */

#endif

/*
// these low speed module IOMap fields are essentially read-only
inline void SetLSInputBuffer(const byte port, const byte offset, byte cnt, byte data[]);
inline void SetLSInputBufferInPtr(const byte port, byte n);
inline void SetLSInputBufferOutPtr(const byte port, byte n);
inline void SetLSInputBufferBytesToRx(const byte port, byte n);
inline void SetLSOutputBuffer(const byte port, const byte offset, byte cnt, byte data[]);
inline void SetLSOutputBufferInPtr(const byte port, byte n);
inline void SetLSOutputBufferOutPtr(const byte port, n);
inline void SetLSOutputBufferBytesToRx(const byte port, byte n);
inline void SetLSMode(const byte port, const byte mode);
inline void SetLSChannelState(const byte port, const byte chState);
inline void SetLSErrorType(const byte port, const byte errType);
inline void SetLSState(const byte lsState);
inline void SetLSSpeed(const byte lsSpeed);
#ifdef __ENHANCED_FIRMWARE
inline void SetLSNoRestartOnRead(const byte lsNoRestart);
#endif
*/

/** @} */ // end of LowLevelLowSpeedModuleFunctions group

/** @defgroup LowSpeedModuleSystemCallFunctions LowSpeed module system call functions
 * System call functions for accessing low speed module features.
 * @{
 */

/**
 * Write to a Lowspeed sensor.
 * This function lets you write to an I2C (Lowspeed) sensor using the values
 * specified via the \ref CommLSWriteType structure.
 *
 * \param args The CommLSWriteType structure containing the needed parameters.
 */
inline void SysCommLSWrite(CommLSWriteType & args);
/** \example ex_syscommlswrite.nxc
 * This is an example of how to use the \ref SysCommLSWrite function along with the
 * \ref CommLSWriteType structure.
 */

/**
 * Read from a Lowspeed sensor.
 * This function lets you read from an I2C (Lowspeed) sensor using the values
 * specified via the \ref CommLSReadType structure.
 *
 * \param args The CommLSReadType structure containing the needed parameters.
 */
inline void SysCommLSRead(CommLSReadType & args);
/** \example ex_syscommlsread.nxc
 * This is an example of how to use the \ref SysCommLSRead function along with the
 * \ref CommLSReadType structure.
 */

/**
 * Check Lowspeed sensor status.
 * This function lets you check the status of an I2C (Lowspeed) sensor
 * transaction using the values specified via the \ref CommLSCheckStatusType
 * structure.
 *
 * \param args The CommLSCheckStatusType structure containing the needed
 * parameters.
 */
inline void SysCommLSCheckStatus(CommLSCheckStatusType & args);
/** \example ex_syscommlscheckstatus.nxc
 * This is an example of how to use the \ref SysCommLSCheckStatus function along
 * with the \ref CommLSCheckStatusType structure.
 */

#ifdef __ENHANCED_FIRMWARE
/**
 * Write to a Lowspeed sensor (extra).
 * This function lets you write to an I2C (Lowspeed) sensor using the values
 * specified via the \ref CommLSWriteExType structure. This is the same as the
 * SysCommLSWrite function except that you also can specify whether or not the
 * Lowspeed module should issue a restart command to the I2C device before
 * beginning to read data from the device.
 *
 * \param args The CommLSWriteExType structure containing the desired parameters.
 */
inline void SysCommLSWriteEx(CommLSWriteExType & args);
/** \example ex_syscommlswriteex.nxc
 * This is an example of how to use the \ref SysCommLSWriteEx function along with the
 * \ref CommLSWriteExType structure.
 */
#endif

/** @} */ // end of LowSpeedModuleSystemCallFunctions group

#else

// ultrasonic sensor
#define SensorUS(_p) asm { ReadSensorUS(_p, __RETVAL__) }
#define ReadSensorUSEx(_port, _values) asm { __ReadSensorUSEx(_port, _values, __RETVAL__) }

#define ReadI2CRegister(_port, _reg, _out) asm { __MSReadValue(_port, 0x02, _reg, 1, _out, __RETVAL__) }
#define WriteI2CRegister(_port, _reg, _val) asm { __MSWriteToRegister(_port, 0x02, _reg, _val, __RETVAL__) }

#define LowspeedStatus(_port, _bready) asm { __lowspeedStatus(_port, _bready, __RETVAL__) }
#define LowspeedCheckStatus(_port) asm { __lowspeedStatus(_port, __TMPBYTE__, __RETVAL__) }
#define LowspeedBytesReady(_port) asm { __lowspeedStatus(_port, __RETVAL__, __TMPBYTE__) }
#define LowspeedWrite(_port, _retlen, _buffer) asm { __lowspeedWrite(_port, _retlen, _buffer, __RETVAL__) }
#define LowspeedRead(_port, _buflen, _buffer) asm { __lowspeedRead(_port, _buflen, _buffer, __RETVAL__) }

#define I2CStatus(_port, _bready) LowspeedStatus(_port, _bready)
#define I2CCheckStatus(_port) LowspeedCheckStatus(_port)
#define I2CBytesReady(_port) LowspeedBytesReady(_port)
#define I2CWrite(_port, _retlen, _buffer) LowspeedWrite(_port, _retlen, _buffer)
#define I2CRead(_port, _buflen, _buffer) LowspeedRead(_port, _buflen, _buffer)

#define I2CBytes(_port, _inbuf, _count, _outbuf) asm { ReadI2CBytes(_port, _inbuf, _count, _outbuf, __RETVAL__) }

#define I2CDeviceInfoEx(_port, _addr, _info) asm { ReadI2CDeviceInfoEx(_port, _addr, _info, __STRRETVAL__) }
#define I2CDeviceInfo(_port, _info) asm { ReadI2CDeviceInfoEx(_port, 0x02, _info, __STRRETVAL__) }
#define I2CVersionEx(_port, _addr) asm { ReadI2CDeviceInfoEx(_port, _addr, I2C_REG_VERSION, __STRRETVAL__) }
#define I2CVersion(_port) asm { ReadI2CDeviceInfoEx(_port, 0x02, I2C_REG_VERSION, __STRRETVAL__) }
#define I2CVendorIdEx(_port, _addr) asm { ReadI2CDeviceInfoEx(_port, _addr, I2C_REG_VENDOR_ID, __STRRETVAL__) }
#define I2CVendorId(_port) asm { ReadI2CDeviceInfoEx(_port, 0x02, I2C_REG_VENDOR_ID, __STRRETVAL__) }
#define I2CDeviceIdEx(_port, _addr) asm { ReadI2CDeviceInfoEx(_port, _addr, I2C_REG_DEVICE_ID, __STRRETVAL__) }
#define I2CDeviceId(_port) asm { ReadI2CDeviceInfoEx(_port, 0x02, I2C_REG_DEVICE_ID, __STRRETVAL__) }

#define I2CSendCommandEx(_port, _addr, _cmd) asm { __I2CSendCmd(_port, _addr, _cmd, __RETVAL__) }
#define I2CSendCommand(_port, _cmd) asm { __I2CSendCmd(_port, 0x02, _cmd, __RETVAL__) }

#define GetLSInputBuffer(_p, _offset, _cnt, _data) asm { __getLSInputBuffer(_p, _offset, _cnt, _data) }
#define GetLSOutputBuffer(_p, _offset, _cnt, _data) asm { __getLSOutputBuffer(_p, _offset, _cnt, _data) }

#define LSInputBufferInPtr(_p) asm { GetLSInputBufferInPtr(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSInputBufferOutPtr(_p) asm { GetLSInputBufferOutPtr(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSInputBufferBytesToRx(_p) asm { GetLSInputBufferBytesToRx(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSOutputBufferInPtr(_p) asm { GetLSOutputBufferInPtr(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSOutputBufferOutPtr(_p) asm { GetLSOutputBufferOutPtr(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSOutputBufferBytesToRx(_p) asm { GetLSOutputBufferBytesToRx(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSMode(_p) asm { GetLSMode(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSChannelState(_p) asm { GetLSChannelState(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSErrorType(_p) asm { GetLSErrorType(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSState() asm { GetLSState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSSpeed() asm { GetLSSpeed(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#ifdef __ENHANCED_FIRMWARE
#define LSNoRestartOnRead(_n) asm { GetLSNoRestartOnRead(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#endif

#define SetLSInputBuffer(_p, _offset, _cnt, _data) asm { __setLSInputBuffer(_p, _offset, _cnt, _data) }

#define SetLSInputBufferInPtr(_p, _n) asm { __setLSInputBufferInPtr(_p, _n) }
#define SetLSInputBufferOutPtr(_p, _n) asm { __setLSInputBufferOutPtr(_p, _n) }
#define SetLSInputBufferBytesToRx(_p, _n) asm { __setLSInputBufferBytesToRx(_p, _n) }

#define SetLSOutputBuffer(_p, _offset, _cnt, _data) asm { __setLSOutputBuffer(_p, _offset, _cnt, _data) }

#define SetLSOutputBufferInPtr(_p, _n) asm { __setLSOutputBufferInPtr(_p, _n) }
#define SetLSOutputBufferOutPtr(_p, _n) asm { __setLSOutputBufferOutPtr(_p, _n) }
#define SetLSOutputBufferBytesToRx(_p, _n) asm { __setLSOutputBufferBytesToRx(_p, _n) }
#define SetLSMode(_p, _n) asm { __setLSMode(_p, _n) }
#define SetLSChannelState(_p, _n) asm { __setLSChannelState(_p, _n) }
#define SetLSErrorType(_p, _n) asm { __setLSErrorType(_p, _n) }
#define SetLSState(_n) asm { __setLSState(_n) }
#define SetLSSpeed(_n) asm { __setLSSpeed(_n) }
#ifdef __ENHANCED_FIRMWARE
#define SetLSNoRestartOnRead(_n) asm { __setLSNoRestartOnRead(_n) }
#endif

#define SysCommLSWrite(_args) asm { \
  compchktype _args, CommLSWriteType \
  syscall CommLSWrite, _args \
}
#define SysCommLSRead(_args) asm { \
  compchktype _args, CommLSReadType \
  syscall CommLSRead, _args \
}
#define SysCommLSCheckStatus(_args) asm { \
  compchktype _args, CommLSCheckStatusType \
  syscall CommLSCheckStatus, _args \
}
#ifdef __ENHANCED_FIRMWARE
#define SysCommLSWriteEx(_args) asm { \
  compchktype _args, CommLSWriteExType \
  syscall CommLSWriteEx, _args \
}
#endif

#endif

/** @} */ // end of LowSpeedModuleFunctions group
/** @} */ // end of LowSpeedModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// IOCTRL MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup IOCtrlModule
 * @{
 */
/** @defgroup IOCtrlModuleTypes IOCtrl module types
 * Types used by various IOCtrl module functions.
 * @{
 */
/** @} */ // end of IOCtrlModuleTypes group
/** @defgroup IOCtrlModuleFunctions IOCtrl module functions
 * Functions for accessing and modifying IOCtrl module features.
 * @{
 */

/**
 * Power down the NXT.
 * This function powers down the NXT.
 * The running program will terminate as a result of this action.
 */
inline void PowerDown() {
  asm { SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_POWERDOWN) }
}
/** \example ex_powerdown.nxc
 * This is an example of how to use the \ref PowerDown functions.
 */

/**
 * Put the brick to sleep immediately.
 * This function lets you immediately put the NXT to sleep.
 * The running program will terminate as a result of this action.
 */
inline void SleepNow() {
  asm { SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_POWERDOWN) }
}
/** \example ex_sleepnow.nxc
 * This is an example of how to use the \ref SleepNow functions.
 */

/**
 * Reboot the NXT in firmware download mode.
 * This function lets you reboot the NXT into SAMBA or firmware download mode.
 * The running program will terminate as a result of this action.
 */
inline void RebootInFirmwareMode() {
  asm { SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_BOOT) }
}
/** \example ex_rebootinfirmwaremode.nxc
 * This is an example of how to use the \ref RebootInFirmwareMode functions.
 */

/** @} */ // end of IOCtrlModuleFunctions group
/** @} */ // end of IOCtrlModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// COMMAND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup CommandModule
 * @{
 */
/** @defgroup CommandModuleTypes Command module types
 * Types used by various Command module functions.
 * @{
 */

/**
 * Parameters for the GetStartTick system call.
 * This structure is used when calling the \ref SysGetStartTick system call
 * function.
 * \sa SysGetStartTick()
 */
struct GetStartTickType {
  unsigned long Result;   /*!< The returned tick value. */
};

/**
 * Parameters for the KeepAlive system call.
 * This structure is used when calling the \ref SysKeepAlive system call
 * function.
 * \sa SysKeepAlive()
 */
struct KeepAliveType {
  unsigned long Result;   /*!< The current sleep timeout in milliseconds. */
};

/**
 * Parameters for the IOMapRead system call.
 * This structure is used when calling the \ref SysIOMapRead system call
 * function.
 * \sa SysIOMapRead()
 */
struct IOMapReadType {
  char Result;           /*!< The function call result. \ref NO_ERR means it succeeded. */
  string ModuleName;     /*!< The name of the module to read from. See the \ref ModuleNameConstants group. */
  unsigned int Offset;   /*!< The offset in the module IOMap where to start reading. */
  unsigned int Count;    /*!< The number of bytes to read. */
  byte Buffer[];         /*!< The buffer used to store read bytes. */
};

/**
 * Parameters for the IOMapWrite system call.
 * This structure is used when calling the \ref SysIOMapWrite system call
 * function.
 * \sa SysIOMapWrite()
 */
struct IOMapWriteType {
  char Result;           /*!< The function call result. \ref NO_ERR means it succeeded. */
  string ModuleName;     /*!< The name of the module to write to. See the \ref ModuleNameConstants group. */
  unsigned int Offset;   /*!< The offset in the module IOMap where to start writing. */
  byte Buffer[];         /*!< The buffer containing bytes to write. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the IOMapReadByID system call.
 * This structure is used when calling the \ref SysIOMapReadByID system call
 * function.
 * \sa SysIOMapReadByID()
 */
struct IOMapReadByIDType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  unsigned long ModuleID; /*!< The identifier of the module to read from. See the \ref ModuleIDConstants group. */
  unsigned int Offset;    /*!< The offset in the module IOMap where to start reading. */
  unsigned int Count;     /*!< The number of bytes to read. */
  byte Buffer[];          /*!< The buffer used to store read bytes. */
};

/**
 * Parameters for the IOMapWriteByID system call.
 * This structure is used when calling the \ref SysIOMapWriteByID system call
 * function.
 * \sa SysIOMapWriteByID()
 */
struct IOMapWriteByIDType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  unsigned long ModuleID; /*!< The identifier of the module to write to. See the \ref ModuleIDConstants group. */
  unsigned int Offset;    /*!< The offset in the module IOMap where to start writing. */
  byte Buffer[];          /*!< The buffer containing bytes to write. */
};

#endif

#if __FIRMWARE_VERSION > 107

/**
 * Parameters for the DatalogWrite system call.
 * This structure is used when calling the \ref SysDatalogWrite system call
 * function.
 * \sa SysDatalogWrite()
 */
struct DatalogWriteType {
 char Result;     /*!< The function call result. \ref NO_ERR means it succeeded. */
 byte Message[];  /*!< A buffer containing data to write to the datalog. */
};

/**
 * Parameters for the DatalogGetTimes system call.
 * This structure is used when calling the \ref SysDatalogGetTimes system call
 * function.
 * \sa SysDatalogGetTimes()
 */
struct DatalogGetTimesType {
 unsigned long SyncTime;  /*!< The datalog synchronized time. */
 unsigned long SyncTick;  /*!< The datalog synchronized tick. */
};

/**
 * Parameters for the ReadSemData system call.
 * This structure is used when calling the \ref SysReadSemData system call
 * function.
 * \sa SysReadSemData()
 */
struct ReadSemDataType {
  byte SemData;  /*!< The semaphore data returned by the function call. */
  bool Request;  /*!< Which semaphore am I reading from, usage or request? */
};

/**
 * Parameters for the WriteSemData system call.
 * This structure is used when calling the \ref SysWriteSemData system call
 * function.
 * \sa SysWriteSemData()
 */
struct WriteSemDataType {
  byte SemData;   /*!< The modified semaphore data returned by the function call. */
  bool Request;   /*!< Which semaphore am I writing to, usage or request? */
  byte NewVal;    /*!< The new semaphore data. */
  bool ClearBits; /*!< Should I clear existing bits? */
};

/**
 * Parameters for the UpdateCalibCacheInfo system call.
 * This structure is used when calling the \ref SysUpdateCalibCacheInfo system call
 * function.
 * \sa SysUpdateCalibCacheInfo()
 */
struct UpdateCalibCacheInfoType {
  byte Result;          /*!< The function call result. \todo ?. */
  string Name;          /*!< The name of the sensor calibration cache. \todo ?. */
  unsigned int MinVal;  /*!< The minimum calibrated value. */
  unsigned int MaxVal;  /*!< The maximum calibrated value. */
};

/**
 * Parameters for the ComputeCalibValue system call.
 * This structure is used when calling the \ref SysComputeCalibValue system call
 * function.
 * \sa SysComputeCalibValue()
 */
struct ComputeCalibValueType {
  byte Result;          /*!< The function call result. \todo ?. */
  string Name;          /*!< The name of the sensor calibration cache. \todo ?. */
  unsigned int RawVal;  /*!< The raw value. \todo ?. */
};

#endif
/** @} */ // end of CommandModuleTypes group

/** @defgroup CommandModuleFunctions Command module functions
 * Functions for accessing and modifying Command module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Read the current system tick.
 * This function lets you current system tick count.
 *
 * \return The current system tick count.
 */
inline unsigned long CurrentTick();
/** \example ex_CurrentTick.nxc
 * This is an example of how to use the \ref CurrentTick function.
 */
/** \example util_rpm.nxc
 * This is an example of how to use the \ref CurrentTick and \ref MotorRotationCount functions.
 */
 
/**
 * Get the first tick.
 * Return an unsigned 32-bit value, which is the system timing value
 * (called a "tick") in milliseconds at the time that the program began
 * running.
 *
 * \return The tick count at the start of program execution.
 */
inline unsigned long FirstTick();
/** \example ex_FirstTick.nxc
 * This is an example of how to use the \ref FirstTick function.
 */

/**
 * Reset the sleep timer.
 * This function lets you reset the sleep timer.
 *
 * \return The result of resetting the sleep timer.
 */
inline long ResetSleepTimer();
/** \example ex_ResetSleepTimer.nxc
 * This is an example of how to use the \ref ResetSleepTimer function.
 */

//inline void SpawnProgram(string fname); // not ready to be documented

/**
 * Call any system function.
 * This generic macro can be used to call any system function. No type
 * checking is performed so you need to make sure you use the correct
 * structure type given the selected system function ID. This is, however, the
 * fastest possible way to call a system function in NXC.
 *
 * Valid function ID constants are defined in the \ref SysCallConstants group.
 *
 * \param funcID The function ID constant corresponding to the function to be
 * called.
 * \param args The structure containing the needed parameters.
 */
inline void SysCall(byte funcID, variant & args);
/** \example ex_syscall.nxc
 * This is an example of how to use the \ref SysCall function.
 */

/**
 * Get start tick.
 * This function lets you obtain the tick value at the time your program began
 * executing via the \ref GetStartTickType structure.
 *
 * \param args The GetStartTickType structure receiving results.
 */
inline void SysGetStartTick(GetStartTickType & args);
/** \example ex_sysgetstarttick.nxc
 * This is an example of how to use the \ref SysGetStartTick function along with
 * the \ref GetStartTickType structure.
 */

/**
 * Keep alive.
 * This function lets you reset the sleep timer via the \ref KeepAliveType
 * structure.
 *
 * \param args The KeepAliveType structure receiving results.
 */
inline void SysKeepAlive(KeepAliveType & args);
/** \example ex_syskeepalive.nxc
 * This is an example of how to use the \ref SysKeepAlive function along with the
 * \ref KeepAliveType structure.
 */

/**
 * Read from IOMap by name.
 * This function lets you read data from a firmware module's IOMap using the
 * values specified via the \ref IOMapReadType structure.
 *
 * \param args The IOMapReadType structure containing the needed parameters.
 */
inline void SysIOMapRead(IOMapReadType & args);
/** \example ex_sysiomapread.nxc
 * This is an example of how to use the \ref SysIOMapRead function along with the
 * \ref IOMapReadType structure.
 */

/**
 * Write to IOMap by name.
 * This function lets you write data to a firmware module's IOMap using the
 * values specified via the \ref IOMapWriteType structure.
 *
 * \param args The IOMapWriteType structure containing the needed parameters.
 */
inline void SysIOMapWrite(IOMapWriteType & args);
/** \example ex_sysiomapwrite.nxc
 * This is an example of how to use the \ref SysIOMapWrite function along with the
 * \ref IOMapWriteType structure.
 */

#ifdef __ENHANCED_FIRMWARE
/**
 * Read from IOMap by identifier.
 * This function lets you read data from a firmware module's IOMap using the
 * values specified via the \ref IOMapReadByIDType structure. This function
 * can be as much as three times faster than using SysIOMapRead since it does
 * not have to do a string lookup using the ModuleName.
 *
 * \param args The IOMapReadByIDType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysIOMapReadByID(IOMapReadByIDType & args);
/** \example ex_sysiomapreadbyid.nxc
 * This is an example of how to use the \ref SysIOMapReadByID function along with
 * the \ref IOMapReadByIDType structure.
 */

/**
 * Write to IOMap by identifier.
 * This function lets you write data to a firmware module's IOMap using the
 * values specified via the \ref IOMapWriteByIDType structure. This function
 * can be as much as three times faster than using SysIOMapWrite since it does
 * not have to do a string lookup using the ModuleName.
 *
 * \param args The IOMapWriteByIDType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysIOMapWriteByID(IOMapWriteByIDType & args);
/** \example ex_sysiomapwritebyid.nxc
 * This is an example of how to use the \ref SysIOMapWriteByID function along with
 * the \ref IOMapWriteByIDType structure.
 */

#endif
#if __FIRMWARE_VERSION > 107
/**
 * Write to the datalog.
 * This function lets you write to the datalog using the
 * values specified via the \ref DatalogWriteType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The DatalogWriteType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysDatalogWrite(DatalogWriteType & args);
/** \example ex_SysDatalogWrite.nxc
 * This is an example of how to use the \ref SysDatalogWrite function along
 * with the \ref DatalogWriteType structure.
 */

/**
 * Get datalog times.
 * This function lets you get datalog times using the
 * values specified via the \ref DatalogGetTimesType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The DatalogGetTimesType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysDatalogGetTimes(DatalogGetTimesType & args);
/** \example ex_SysDatalogGetTimes.nxc
 * This is an example of how to use the \ref SysDatalogGetTimes function along
 * with the \ref DatalogGetTimesType structure.
 */

/**
 * Read semaphore data.
 * This function lets you read global motor semaphore data using the
 * values specified via the \ref ReadSemDataType structure.
 *
 * \param args The ReadSemDataType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysReadSemData(ReadSemDataType & args);
/** \example ex_SysReadSemData.nxc
 * This is an example of how to use the \ref SysReadSemData function along with
 * the \ref ReadSemDataType structure.
 */

/**
 * Write semaphore data.
 * This function lets you write global motor semaphore data using the
 * values specified via the \ref WriteSemDataType structure.
 *
 * \param args The WriteSemDataType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysWriteSemData(WriteSemDataType & args);
/** \example ex_SysWriteSemData.nxc
 * This is an example of how to use the \ref SysWriteSemData function along
 * with the \ref WriteSemDataType structure.
 */

/**
 * Update calibration cache information.
 * This function lets you update calibration cache information using the
 * values specified via the \ref UpdateCalibCacheInfoType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The UpdateCalibCacheInfoType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysUpdateCalibCacheInfo(UpdateCalibCacheInfoType & args);
/** \example ex_SysUpdateCalibCacheInfo.nxc
 * This is an example of how to use the \ref SysUpdateCalibCacheInfo function
 * along with the \ref UpdateCalibCacheInfoType structure.
 */

/**
 * Compute calibration values.
 * This function lets you compute calibration values using the
 * values specified via the \ref ComputeCalibValueType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The ComputeCalibValueType structure containing the needed parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysComputeCalibValue(ComputeCalibValueType & args);
/** \example ex_SysComputeCalibValue.nxc
 * This is an example of how to use the \ref SysComputeCalibValue function
 * along with the \ref ComputeCalibValueType structure.
 */

#endif

#else

#define CurrentTick() asm { gettick __RETVAL__ }
#define FirstTick() asm { GetFirstTick(__RETVAL__) }
#define ResetSleepTimer() asm { acquire __KeepAliveMutex \
  syscall KeepAlive, __KeepAliveArgs \
  mov __RETVAL__, __KeepAliveArgs.Result \
  release __KeepAliveMutex }

#define SpawnProgram(_fname) asm { __spawnProgram(_fname) }

#define SysCall(_func, _args) asm { syscall _func, _args }

#define SysGetStartTick(_args) asm { \
  compchktype _args, GetStartTickType \
  syscall GetStartTick, _args \
}

#define SysKeepAlive(_args) asm { \
  compchktype _args, KeepAliveType \
  syscall KeepAlive, _args \
}

#define SysIOMapRead(_args) asm { \
  compchktype _args, IOMapReadType \
  syscall IOMapRead, _args \
}
#define SysIOMapWrite(_args) asm { \
  compchktype _args, IOMapWriteType \
  syscall IOMapWrite, _args \
}

#ifdef __ENHANCED_FIRMWARE
#define SysIOMapReadByID(_args) asm { \
  compchktype _args, IOMapReadByIDType \
  syscall IOMapReadByID, _args \
}
#define SysIOMapWriteByID(_args) asm { \
  compchktype _args, IOMapWriteByIDType \
  syscall IOMapWriteByID, _args \
}
#endif
#if __FIRMWARE_VERSION > 107

#define SysDatalogWrite(_args) asm { \
  compchktype _args, DatalogWriteType \
  syscall DatalogWrite, _args \
}
#define SysDatalogGetTimes(_args) asm { \
  compchktype _args, DatalogGetTimesType \
  syscall DatalogGetTimes, _args \
}
#define SysReadSemData(_args) asm { \
  compchktype _args, ReadSemDataType \
  syscall ReadSemData, _args \
}
#define SysWriteSemData(_args) asm { \
  compchktype _args, WriteSemDataType \
  syscall WriteSemData, _args \
}
#define SysUpdateCalibCacheInfo(_args) asm { \
  compchktype _args, UpdateCalibCacheInfoType \
  syscall UpdateCalibCacheInfo, _args \
}
#define SysComputeCalibValue(_args) asm { \
  compchktype _args, ComputeCalibValueType \
  syscall ComputeCalibValue, _args \
}
#endif

#define until(_c) while(!(_c))

#endif

/**
 * Wait some milliseconds.
 * Make a task sleep for specified amount of time (in 1000ths of a second).
 *
 * \param ms The number of milliseconds to sleep.
 */
inline void Wait(unsigned long ms) { asm { waitv ms } }
/** \example ex_wait.nxc
 * This is an example of how to use the \ref Wait function.
 */

/**
 * Yield to another task.
 * Make a task yield to another concurrently running task.
 */
inline void Yield() { asm { wait 1 } }
/** \example ex_yield.nxc
 * This is an example of how to use the \ref Yield function.
 */

/**
 * Stop all tasks.
 * Stop all currently running tasks. This will halt the program completely,
 * so any code following this command will be ignored.
 */
inline void StopAllTasks() { Stop(true); }
/** \example ex_stopalltasks.nxc
 * This is an example of how to use the \ref StopAllTasks function.
 */


#ifdef __DOXYGEN_DOCS
/**
 * Stop the running program.
 * Stop the running program if bvalue is true. This will halt the program
 * completely, so any code following this command will be ignored.
 * \param bvalue If this value is true the program will stop executing.
 */
inline void Stop(bool bvalue);
/** \example ex_stop.nxc
 * This is an example of how to use the \ref Stop function.
 */

/**
 * Exit to another task.
 * Immediately exit the current task and start executing the specified task.
 * \param newTask The task to start executing after exiting the current task.
 */
inline void ExitTo(task newTask);
/** \example alternating_tasks.nxc
 * This is an example of how to use the \ref ExitTo function.
 */

/**
 * Declare tasks that this task precedes.
 * Schedule the listed tasks for execution once the current task has
 * completed executing. The tasks will all execute simultaneously unless other
 * dependencies prevent them from doing so. This statement should be used once
 * within a task - preferably at the start of the task definition. Any number
 * of tasks may be listed in the Precedes statement.
 * \param task1 The first task to start executing after the current task ends.
 * \param task2 The second task to start executing after the current task ends.
 * \param taskN The last task to start executing after the current task ends.
 */
inline void Precedes(task task1, task task2, ..., task taskN);
/** \example ex_Precedes.nxc
 * This is an example of how to use the \ref Precedes statement.
 */

/**
 * Declare tasks that this task follows.
 * Schedule this task to follow the specified tasks so that it will execute
 * once any of the specified tasks has completed executing. This statement
 * should occur once within a task - preferably at the start of the task
 * definition. If multiple tasks declare that they follow the same task then
 * they will all execute simultaneously unless other dependencies prevent them
 * from doing so. Any number of tasks may be listed in the Follows statement.
 * \param task1 The first task that this task follows.
 * \param task2 The second task that this task follows.
 * \param taskN The last task that this task follows.
 */
inline void Follows(task task1, task task2, ..., task taskN);
/** \example ex_Follows.nxc
 * This is an example of how to use the \ref Follows statement.
 */

/**
 * Acquire a mutex.
 * Acquire the specified mutex variable. If another task already has acquired
 * the mutex then the current task will be suspended until the mutex is
 * released by the other task. This function is used to ensure that the current
 * task has exclusive access to a shared resource, such as the display or a
 * motor. After the current task has finished using the shared resource the
 * program should call Release to allow other tasks to acquire the mutex.
 * \param m The mutex to acquire.
 */
inline void Acquire(mutex m);
/** \example ex_Acquire.nxc
 * This is an example of how to use the \ref Acquire function.
 */

/**
 * Acquire a mutex.
 * Release the specified mutex variable. Use this to relinquish a mutex so
 * that it can be acquired by another task. Release should always be called
 * after a matching call to Acquire and as soon as possible after a shared
 * resource is no longer needed.
 * \param m The mutex to release.
 */
inline void Release(mutex m);
/** \example ex_Release.nxc
 * This is an example of how to use the \ref Release function.
 */

/**
 * Start a task.
 * Start the specified task.
 * \param t The task to start.
 */
inline void StartTask(task t);
/** \example ex_starttask.nxc
 * This is an example of how to use the \ref StartTask function.
 */

/**
 * Stop a task.
 * Stop the specified task.
 * \param t The task to stop.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void StopTask(task t);
/** \example ex_stoptask.nxc
 * This is an example of how to use the \ref StopTask function.
 */

/** @defgroup ArrayFunctions Array API functions
 * Functions for use with NXC array types.
 * @{
 */

/**
 * Build an array.
 * Build a new array from the specified source(s). The sources can be of any
 * type so long as the number of dimensions is equal to or one less than the
 * number of dimensions in the output array and the type is compatible with
 * the type of the output array. If a source is an array with the same number
 * of dimensions as the output array then all of its elements are added to
 * the output array.
 * \param aout The output array to build.
 * \param src1 The first source to build into the output array.
 * \param src2 The second source to build into the output array.
 * \param srcN The first source to build into the output array.
 */
inline void ArrayBuild(variant & aout[], variant src1, variant src2, ..., variant srcN);
/** \example ex_arraybuild.nxc
 * This is an example of how to use the \ref ArrayBuild function.
 */

/**
 * Get array length.
 * Return the length of the specified array. Any type of array of up to four
 * dimensions can be passed into this function.
 * \param data The array whose length you need to read.
 * \return The length of the specified array.
 */
inline unsigned int ArrayLen(variant data[]);
/** \example ex_arraylen.nxc
 * This is an example of how to use the \ref ArrayLen function.
 */

/**
 * Initialize an array.
 * Initialize the array to contain count elements with each element equal to
 * the value provided. To initialize a multi-dimensional array, the value
 * should be an array of N-1 dimensions, where N is the number of dimensions
 * in the array being initialized.
 * \param aout The output array to initialize.
 * \param value The value to initialize each element to.
 * \param count The number of elements to create in the output array.
 */
inline void ArrayInit(variant & aout[], variant value, unsigned int count);
/** \example ex_arrayinit.nxc
 * This is an example of how to use the \ref ArrayInit function.
 */

/**
 * Copy an array subset.
 * Copy a subset of the source array starting at the specified index and
 * containing the specified number of elements into the destination array.
 * \param aout The output array containing the subset.
 * \param asrc The input array from which to copy a subset.
 * \param idx The start index of the array subset.
 * \param len The length of the array subset.
 */
inline void ArraySubset(variant & aout[], variant asrc[], unsigned int idx, unsigned int len);
/** \example ex_arraysubset.nxc
 * This is an example of how to use the \ref ArraySubset function.
 */

#ifdef __ENHANCED_FIRMWARE

/**
 * Calculate the sum of the elements in a numeric array.
 * This function calculates the sum of all or a subset of the elements in the
 * numeric src array.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The sum of len elements from the src numeric array (starting from idx).
 */
inline variant ArraySum(const variant & src[], unsigned int idx, unsigned int len);
/** \example ex_ArraySum.nxc
 * This is an example of how to use the \ref ArraySum function.
 */

/**
 * Calculate the mean of the elements in a numeric array.
 * This function calculates the mean of all or a subset of the elements in the
 * numeric src array.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The mean value of len elements from the src numeric array (starting from idx).
 */
inline variant ArrayMean(const variant & src[], unsigned int idx, unsigned int len);
/** \example ex_ArrayMean.nxc
 * This is an example of how to use the \ref ArrayMean function.
 */

/**
 * Calculate the sum of the squares of the elements in a numeric array.
 * This function calculates the sum of the squares of all or a subset of the elements in the
 * numeric src array.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The sum of the squares of len elements from the src numeric array (starting from idx).
 */
inline variant ArraySumSqr(const variant & src[], unsigned int idx, unsigned int len);
/** \example ex_ArraySumSqr.nxc
 * This is an example of how to use the \ref ArraySumSqr function.
 */

/**
 * Calculate the standard deviation of the elements in a numeric array.
 * This function calculates the standard deviation of all or a subset of the elements in the
 * numeric src array.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The standard deviation of len elements from the src numeric array (starting from idx).
 */
inline variant ArrayStd(const variant & src[], unsigned int idx, unsigned int len);
/** \example ex_ArrayStd.nxc
 * This is an example of how to use the \ref ArrayStd function.
 */

/**
 * Calculate the minimum of the elements in a numeric array.
 * This function calculates the minimum of all or a subset of the elements in the
 * numeric src array.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The minimum of len elements from the src numeric array (starting from idx).
 */
inline variant ArrayMin(const variant & src[], unsigned int idx, unsigned int len);
/** \example ex_ArrayMin.nxc
 * This is an example of how to use the \ref ArrayMin function.
 */

/**
 * Calculate the maximum of the elements in a numeric array.
 * This function calculates the maximum of all or a subset of the elements in the
 * numeric src array.
 *
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the calculation. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 * \return The maximum of len elements from the src numeric array (starting from idx).
 */
inline variant ArrayMax(const variant & src[], unsigned int idx, unsigned int len);
/** \example ex_ArrayMax.nxc
 * This is an example of how to use the \ref ArrayMax function.
 */

/**
 * Sort the elements in a numeric array.
 * This function sorts all or a subset of the elements in the
 * numeric src array in ascending order and saves the results in the
 * numeric dest array.
 *
 * \param dest The destination numeric array.
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the sorting process. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 */
inline void ArraySort(variant & dest[], const variant & src[], unsigned int idx, unsigned int len);
/** \example ex_ArraySort.nxc
 * This is an example of how to use the \ref ArraySort function.
 */

/**
 * Operate on numeric arrays.
 * This function lets you perform various operations on numeric arrays.
 *
 * \param op  The array operation. See \ref ArrayOpConstants.
 * \param dest The destination variant type (scalar or array, depending on the operation).
 * \param src The source numeric array.
 * \param idx The index of the start of the array subset to process. Pass
 * \ref NA to start with the first element.
 * \param len The number of elements to include in the specified process. Pass
 * \ref NA to include the rest of the elements in the src array (from idx to
 * the end of the array).
 */
inline void ArrayOp(const byte op, variant & dest, const variant & src[], unsigned int idx, unsigned int len);
/** \example ex_ArrayOp.nxc
 * This is an example of how to use the \ref ArrayOp function.
 */

#endif

/** @} */ // end of ArrayFunctions group

#else

#define StartTask(_t) start _t
#define StopTask(_t) stop _t

#if __FIRMWARE_VERSION <= 107
#define IOMA(_n) asm { mov __RETVAL__, _n }
#define SetIOMA(_n, _val) asm { mov _n, _val }
#endif

#define ArrayBuild(_aout, ...) asm { arrbuild _aout, __VA_ARGS__ }
#define ArrayLen(_asrc) asm { arrsize __RETVAL__, _asrc }
#define ArrayInit(_aout, _val, _cnt) asm { arrinit _aout, _val, _cnt }
#define ArraySubset(_aout, _asrc, _idx, _len) asm { arrsubset _aout, _asrc, _idx, _len }

#ifdef __ENHANCED_FIRMWARE
#define ArraySum(_src, _idx, _len) asm { arrop OPARR_SUM, __RETVAL__, _src, _idx, _len }
#define ArrayMean(_src, _idx, _len) asm { arrop OPARR_MEAN, __RETVAL__, _src, _idx, _len }
#define ArraySumSqr(_src, _idx, _len) asm { arrop OPARR_SUMSQR, __RETVAL__, _src, _idx, _len }
#define ArrayStd(_src, _idx, _len) asm { arrop OPARR_STD, __RETVAL__, _src, _idx, _len }
#define ArrayMin(_src, _idx, _len) asm { arrop OPARR_MIN, __RETVAL__, _src, _idx, _len }
#define ArrayMax(_src, _idx, _len) asm { arrop OPARR_MAX, __RETVAL__, _src, _idx, _len }
#define ArraySort(_dest, _src, _idx, _len) asm { arrop OPARR_SORT, _dest, _src, _idx, _len }
#define ArrayOp(_op, _dest, _src, _idx, _len) asm { arrop _op, _dest, _src, _idx, _len }
#endif

#endif
/** @} */ // end of CommandModuleFunctions group
/** @} */ // end of CommandModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// COMM MODULE /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup CommModule
 * @{
 */
/** @defgroup CommModuleTypes Comm module types
 * Types used by various Comm module functions.
 * @{
 */
/**
 * Parameters for the MessageWrite system call.
 * This structure is used when calling the \ref SysMessageWrite system call
 * function.
 * \sa SysMessageWrite()
 */
struct MessageWriteType {
  char Result;      /*!< The function call result. \ref NO_ERR means it succeeded. */
  byte QueueID;     /*!< The queue identifier. See the \ref MailboxConstants group. */
  string Message;   /*!< The message to write. */
};

/**
 * Parameters for the MessageRead system call.
 * This structure is used when calling the \ref SysMessageRead system call
 * function.
 * \sa SysMessageRead()
 */
struct MessageReadType {
  char Result;       /*!< The function call result. \ref NO_ERR means it succeeded. */
  byte QueueID;     /*!< The queue identifier. See the \ref MailboxConstants group. */
  bool Remove;      /*!< If true, remove the read message from the queue. */
  string Message;   /*!< The contents of the mailbox/queue. */
};

/**
 * Parameters for the CommBTCheckStatus system call.
 * This structure is used when calling the \ref SysCommBTCheckStatus system
 * call function.
 * \sa SysCommBTCheckStatus()
 */
struct CommBTCheckStatusType {
  char Result;       /*!< The function call result. Possible values include
                       \ref ERR_INVALID_PORT, \ref STAT_COMM_PENDING,
                       \ref ERR_COMM_CHAN_NOT_READY, and \ref LDR_SUCCESS. */
  byte Connection;   /*!< The connection to check. */
};

/**
 * Parameters for the CommBTWrite system call.
 * This structure is used when calling the \ref SysCommBTWrite system call
 * function.
 * \sa SysCommBTWrite()
 */
struct CommBTWriteType {
  char Result;       /*!< The function call result.  Possible values include
                       \ref ERR_COMM_CHAN_NOT_READY
                       and \ref STAT_COMM_PENDING (write accepted). */
  byte Connection;   /*!< The connection to use. */
  byte Buffer[];     /*!< The data to write to the connection. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the CommExecuteFunction system call.
 * This structure is used when calling the \ref SysCommExecuteFunction system
 * call function.
 *
 * The fields usage depends on the requested command and are documented in the
 * table below. If a field member is shown as 'x' it is ignored by the
 * specified command.
 *
 * <table>
 * <tr><td>Cmd</td>
 *     <td>Meaning</td><td>(Param1,Param2,Param3,Name)</td></tr>
 * <tr><td>INTF_SENDFILE</td>
 *     <td>Send a file over a Bluetooth connection</td><td>(Connection,x,x,Filename)</td></tr>
 * <tr><td>INTF_SEARCH</td>
 *     <td>Search for Bluetooth devices</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_STOPSEARCH</td>
 *     <td>Stop searching for Bluetooth devices</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_CONNECT</td>
 *     <td>Connect to a Bluetooth device</td><td>(DeviceIndex,Connection,x,x)</td></tr>
 * <tr><td>INTF_DISCONNECT</td>
 *     <td>Disconnect a Bluetooth device</td><td>(Connection,x,x,x)</td></tr>
 * <tr><td>INTF_DISCONNECTALL</td>
 *     <td>Disconnect all Bluetooth devices</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_REMOVEDEVICE</td>
 *     <td>Remove device from My Contacts</td><td>(DeviceIndex,x,x,x)</td></tr>
 * <tr><td>INTF_VISIBILITY</td>
 *     <td>Set Bluetooth visibility</td><td>(true/false,x,x,x)</td></tr>
 * <tr><td>INTF_SETCMDMODE</td>
 *     <td>Set command mode</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_OPENSTREAM</td>
 *     <td>Open a stream</td><td>(x,Connection,x,x)</td></tr>
 * <tr><td>INTF_SENDDATA</td>
 *     <td>Send data</td><td>(Length, Connection, WaitForIt, Buffer)</td></tr>
 * <tr><td>INTF_FACTORYRESET</td>
 *     <td>Bluetooth factory reset</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_BTON</td>
 *     <td>Turn Bluetooth on</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_BTOFF</td>
 *     <td>Turn Bluetooth off</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_SETBTNAME</td>
 *     <td>Set Bluetooth name</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_EXTREAD</td>
 *     <td>Handle external? read</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_PINREQ</td>
 *     <td>Handle Blueooth PIN request</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_CONNECTREQ</td>
 *     <td>Handle Bluetooth connect request</td><td>(x,x,x,x)</td></tr>
 * </table>
 *
 * \sa SysCommExecuteFunction()
 */
struct CommExecuteFunctionType {
  unsigned int Result;   /*!< The function call result. Possible values
                           include \ref LoaderErrors. */
  byte Cmd;              /*!< The command to execute. */
  byte Param1;           /*!< The first parameter, see table. */
  byte Param2;           /*!< The second parameter, see table. */
  byte Param3;           /*!< The third parameter, see table. */
  string Name;           /*!< The name parameter, see table. */
  unsigned int RetVal;   /*!< The function call return value. Possible values
                           include \ref LoaderErrors. */
};

/**
 * Parameters for the CommHSControl system call.
 * This structure is used when calling the \ref SysCommHSControl system call
 * function.
 * \sa SysCommHSControl()
 */
struct CommHSControlType {
 char Result;             /*!< The function call result. \todo values? */
 byte Command;            /*!< The hi-speed port configuration command.
                               See \ref CommHiSpeedCtrlConstants. */
 byte BaudRate;           /*!< The hi-speed port baud rate. See \ref CommHiSpeedBaudConstants. */
#if __FIRMWARE_VERSION > 107
 unsigned int Mode;       /*!< The hi-speed port mode. See \ref CommHiSpeedDataBitsConstants,
                               \ref CommHiSpeedStopBitsConstants, \ref CommHiSpeedParityConstants,
                               and \ref CommHiSpeedCombinedConstants. */
#endif
};

/**
 * Parameters for the CommHSCheckStatus system call.
 * This structure is used when calling the \ref SysCommHSCheckStatus system call
 * function.
 * \sa SysCommHSCheckStatus()
 */
struct CommHSCheckStatusType {
 bool SendingData;     /*!< Is data currently being sent? */
 bool DataAvailable;   /*!< Is data available for reading? */
};

/**
 * Parameters for the CommHSReadWrite system call.
 * This structure is used when calling the \ref SysCommHSRead and
 * \ref SysCommHSWrite system call functions.
 * \sa SysCommHSRead(), SysCommHSWrite()
 */
struct CommHSReadWriteType {
 char Status;    /*!< The result of the function call. */
 byte Buffer[];  /*!< The buffer of data to write or to contain the data read
                      from the hi-speed port. */
};
#endif

#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the CommBTOnOff system call.
 * This structure is used when calling the \ref SysCommBTOnOff system call
 * function.
 * \sa SysCommBTOnOff()
 */
struct CommBTOnOffType {
#ifdef __ENHANCED_FIRMWARE
 unsigned int Result; /*!< The function call result. */
#else
 char Result;         /*!< The function call result. */
#endif
 bool PowerState;     /*!< If true then turn on bluetooth, otherwise, turn it off. */
};

/**
 * Parameters for the CommBTConnection system call.
 * This structure is used when calling the \ref SysCommBTConnection system call
 * function.
 * \sa SysCommBTConnection()
 */
struct CommBTConnectionType {
#ifdef __ENHANCED_FIRMWARE
 unsigned int Result; /*!< The function call result. */
#else
 char Result;         /*!< The function call result. */
#endif
 byte Action;         /*!< The connection action (connect or disconnect). */
 string Name;         /*!< The name of the device to connect or disconnect. */
 byte ConnectionSlot; /*!< The connection slot to connect or disconnect. */
};
#endif

/** @} */ // end of CommModuleTypes group
/** @defgroup CommModuleFunctions Comm module functions
 * Functions for accessing and modifying Comm module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Send a message to a queue/mailbox.
 * Write a message into a local mailbox.
 * 
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param msg The message to write to the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendMessage(byte queue, string msg);
/** \example ex_sendmessage.nxc
 * This is an example of how to use the \ref SendMessage function.
 */

/**
 * Read a message from a queue/mailbox.
 * Read a message from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param msg The message that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveMessage(byte queue, bool clear, string & msg);
/** \example ex_receivemessage.nxc
 * This is an example of how to use the \ref ReceiveMessage function.
 */

/**
 * Check bluetooth status.
 * Check the status of the bluetooth subsystem for the specified connection slot.
 * 
 * \param conn The connection slot (0..3).
 * \return The bluetooth status for the specified connection.
 */
inline char BluetoothStatus(const byte conn);
/** \example ex_bluetoothstatus.nxc
 * This is an example of how to use the \ref BluetoothStatus function.
 */

/**
 * Write to a bluetooth connection.
 * This method tells the NXT firmware to write the data in the buffer to the
 * device on the specified Bluetooth connection. Use \ref BluetoothStatus to
 * determine when this write request is completed.
 * 
 * \param conn The connection slot (0..3).
 * \param buffer The data to be written (up to 128 bytes)
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char BluetoothWrite(const byte conn, byte buffer[]);
/** \example ex_bluetoothwrite.nxc
 * This is an example of how to use the \ref BluetoothWrite function.
 */

/**
 * Send a boolean value to a remote mailbox.
 * Send a boolean value via bluetooth on the specified connection to the
 * specified remote mailbox number.
 *
 * \param conn The connection slot (0..3).
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param bval The boolean value to send.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendRemoteBool(byte conn, byte queue, bool bval);
/** \example ex_sendremotebool.nxc
 * This is an example of how to use the \ref SendRemoteBool function.
 */

/**
 * Send a numeric value to a remote mailbox.
 * Send a numeric value via bluetooth on the specified connection to the
 * specified remote mailbox number.
 *
 * \param conn The connection slot (0..3).
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param val The numeric value to send.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendRemoteNumber(byte conn, byte queue, long val);
/** \example ex_SendRemoteNumber.nxc
 * This is an example of how to use the \ref SendRemoteNumber function.
 */

/**
 * Send a string value to a remote mailbox.
 * Send a string value via bluetooth on the specified connection to the
 * specified remote mailbox number.
 *
 * \param conn The connection slot (0..3).
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param str The string value to send.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendRemoteString(byte conn, byte queue, string str);
/** \example ex_SendRemoteString.nxc
 * This is an example of how to use the \ref SendRemoteString function.
 */

/**
 * Write a boolean value to a local response mailbox.
 * Write a boolean value to a response mailbox (the mailbox number + 10).
 *
 * \param queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param bval The boolean value to write.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendResponseBool(byte queue, bool bval);
/** \example ex_SendResponseBool.nxc
 * This is an example of how to use the \ref SendResponseBool function.
 */

/**
 * Write a numeric value to a local response mailbox.
 * Write a numeric value to a response mailbox (the mailbox number + 10).
 *
 * \param queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param val The numeric value to write.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendResponseNumber(byte queue, long val);
/** \example ex_SendResponseNumber.nxc
 * This is an example of how to use the \ref SendResponseNumber function.
 */

/**
 * Write a string value to a local response mailbox.
 * Write a string value to a response mailbox (the mailbox number + 10).
 *
 * \param queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param str The string value to write.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendResponseString(byte queue, string str);
/** \example ex_SendResponseString.nxc
 * This is an example of how to use the \ref SendResponseString function.
 */

/**
 * Read a boolean value from a queue/mailbox.
 * Read a boolean value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param bval The boolean value that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveRemoteBool(byte queue, bool clear, bool & bval);
/** \example ex_ReceiveRemoteBool.nxc
 * This is an example of how to use the \ref ReceiveRemoteBool function.
 */

/**
 * Read a value from a queue/mailbox.
 * Read a value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.  Output the value in string, number, and
 * boolean form.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param str The string value that is read from the mailbox.
 * \param val The numeric value that is read from the mailbox.
 * \param bval The boolean value that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveRemoteMessageEx(byte queue, bool clear, string & str, long & val, bool & bval);
/** \example ex_ReceiveRemoteMessageEx.nxc
 * This is an example of how to use the \ref ReceiveRemoteMessageEx function.
 */

/**
 * Read a numeric value from a queue/mailbox.
 * Read a numeric value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param val The numeric value that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveRemoteNumber(byte queue, bool clear, long & val);
/** \example ex_ReceiveRemoteNumber.nxc
 * This is an example of how to use the \ref ReceiveRemoteNumber function.
 */

/**
 * Read a string value from a queue/mailbox.
 * Read a string value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param str The string value that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveRemoteString(byte queue, bool clear, string & str);
/** \example ex_ReceiveRemoteString.nxc
 * This is an example of how to use the \ref ReceiveRemoteString function.
 */

/**
 * Send a KeepAlive message.
 * This method sends a KeepAlive direct command to the device on the specified
 * connection. Use \ref BluetoothStatus to determine when this write request is
 * completed.
 * 
 * \param conn The connection slot (0..3).
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteKeepAlive(byte conn);
/** \example ex_RemoteKeepAlive.nxc
 * This is an example of how to use the \ref RemoteKeepAlive function.
 */

/**
 * Send a MessageRead message.
 * This method sends a MessageRead direct command to the device on the
 * specified connection. Use \ref BluetoothStatus to determine when this write
 * request is completed.
 *
 * \param conn The connection slot (0..3).
 * \param queue The mailbox to read. See \ref MailboxConstants.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteMessageRead(byte conn, byte queue);
/** \example ex_RemoteMessageRead.nxc
 * This is an example of how to use the \ref RemoteMessageRead function.
 */

/**
 * Send a MessageWrite message.
 * This method sends a MessageWrite direct command to the device on the
 * specified connection. Use \ref BluetoothStatus to determine when this write
 * request is completed.
 * 
 * \param conn The connection slot (0..3).
 * \param queue The mailbox to write. See \ref MailboxConstants.
 * \param msg The message to write to the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteMessageWrite(byte conn, byte queue, string msg);
/** \example ex_RemoteMessageWrite.nxc
 * This is an example of how to use the \ref RemoteMessageWrite function.
 */

/**
 * Send a PlaySoundFile message.
 * Send the PlaySoundFile direct command on the specified connection slot.
 * Use \ref BluetoothStatus to determine when this write request is completed.
 *
 * \param conn The connection slot (0..3).
 * \param filename The name of the sound file to play.
 * \param bloop A boolean value indicating whether to loop the sound file or not.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemotePlaySoundFile(byte conn, string filename, bool bloop);
/** \example ex_RemotePlaySoundFile.nxc
 * This is an example of how to use the \ref RemotePlaySoundFile function.
 */

/**
 * Send a PlayTone message.
 * Send the PlayTone direct command on the specified connection slot.
 * Use \ref BluetoothStatus to determine when this write request is completed.
 *
 * \param conn The connection slot (0..3).
 * \param frequency The frequency of the tone.
 * \param duration The duration of the tone.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemotePlayTone(byte conn, unsigned int frequency, unsigned int duration);
/** \example ex_RemotePlayTone.nxc
 * This is an example of how to use the \ref RemotePlayTone function.
 */

/**
 * Send a ResetMotorPosition message.
 * Send the ResetMotorPosition direct command on the specified connection slot.
 * Use \ref BluetoothStatus to determine when this write request is completed.
 *
 * \param conn The connection slot (0..3).
 * \param port The output port to reset.
 * \param brelative A flag indicating whether the counter to reset is relative.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteResetMotorPosition(byte conn, byte port, bool brelative);
/** \example ex_RemoteResetMotorPosition.nxc
 * This is an example of how to use the \ref RemoteResetMotorPosition function.
 */

/**
 * Send a ResetScaledValue message.
 * Send the ResetScaledValue direct command on the specified connection slot.
 * Use \ref BluetoothStatus to determine when this write request is completed.
 *
 * \param conn The connection slot (0..3).
 * \param port The input port to reset.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteResetScaledValue(byte conn, byte port);
/** \example ex_RemoteResetScaledValue.nxc
 * This is an example of how to use the \ref RemoteResetScaledValue function.
 */

/**
 * Send a SetInputMode message.
 * Send the SetInputMode direct command on the specified connection slot.
 * Use \ref BluetoothStatus to determine when this write request is completed.
 *
 * \param conn The connection slot (0..3).
 * \param port The input port to configure. See \ref InPorts.
 * \param type The sensor type. See \ref SensorTypes.
 * \param mode The sensor mode. See \ref SensorModes.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteSetInputMode(byte conn, byte port, byte type, byte mode);
/** \example ex_RemoteSetInputMode.nxc
 * This is an example of how to use the \ref RemoteSetInputMode function.
 */

/**
 * Send a SetOutputMode message.
 * Send the SetOutputMode direct command on the specified connection slot.
 * Use \ref BluetoothStatus to determine when this write request is completed.
 *
 * \param conn The connection slot (0..3).
 * \param port The output port to configure. See \ref OutputPortConstants.
 * \param speed The motor speed. (-100..100)
 * \param mode The motor mode. See \ref OutModeConstants.
 * \param regmode The motor regulation mode. See \ref OutRegModeConstants.
 * \param turnpct The motor synchronized turn percentage. (-100..100)
 * \param runstate The motor run state. See \ref OutRunStateConstants.
 * \param tacholimit The motor tachometer limit.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteSetOutputState(byte conn, byte port, char speed, byte mode, byte regmode, char turnpct, byte runstate, unsigned long tacholimit);
/** \example ex_RemoteSetOutputState.nxc
 * This is an example of how to use the \ref RemoteSetOutputState function.
 */

/**
 * Send a StartProgram message.
 * Send the StartProgram direct command on the specified connection slot.
 * Use \ref BluetoothStatus to determine when this write request is completed.
 *
 * \param conn The connection slot (0..3).
 * \param filename The name of the program to start running.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteStartProgram(byte conn, string filename);
/** \example ex_RemoteStartProgram.nxc
 * This is an example of how to use the \ref RemoteStartProgram function.
 */

/**
 * Send a StopProgram message.
 * Send the StopProgram direct command on the specified connection slot.
 * Use \ref BluetoothStatus to determine when this write request is completed.
 *
 * \param conn The connection slot (0..3).
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteStopProgram(byte conn);
/** \example ex_RemoteStopProgram.nxc
 * This is an example of how to use the \ref RemoteStopProgram function.
 */

/**
 * Send a StopSound message.
 * Send the StopSound direct command on the specified connection slot.
 * Use \ref BluetoothStatus to determine when this write request is completed.
 *
 * \param conn The connection slot (0..3).
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteStopSound(byte conn);
/** \example ex_RemoteStopSound.nxc
 * This is an example of how to use the \ref RemoteStopSound function.
 */

#ifdef __ENHANCED_FIRMWARE

/**
 * Control the RS485 port.
 * Control the RS485 hi-speed port using the specified parameters.
 *
 * \param cmd The control command to send to the port. See \ref CommHiSpeedCtrlConstants.
 * \param baud The baud rate for the RS485 port. See \ref CommHiSpeedBaudConstants.
 * \param mode The RS485 port mode (data bits, stop bits, parity).  See \ref
 * CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants, \ref
 * CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Control(byte cmd, byte baud, unsigned int mode);
/** \example ex_RS485Control.nxc
 * This is an example of how to use the \ref RS485Control function.
 */

/**
 * Check for RS485 available data.
 * Check the RS485 hi-speed port for available data.
 * 
 * \return A value indicating whether data is available or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline bool RS485DataAvailable(void);
/** \example ex_RS485DataAvailable.nxc
 * This is an example of how to use the \ref RS485DataAvailable function.
 */

/**
 * Exit RS485.
 * Turn off the RS485 port.
 * 
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Exit(void);
/** \example ex_RS485Exit.nxc
 * This is an example of how to use the \ref RS485Exit function.
 */

/**
 * Initialize RS485.
 * Initialize the RS485 hi-speed port so that it can be used.
 * 
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Init(void);
/** \example ex_RS485Init.nxc
 * This is an example of how to use the \ref RS485Init function.
 */

/**
 * Read RS485 data.
 * Read data from the RS485 hi-speed port.
 * 
 * \param buffer A byte array that will contain the data read from the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Read(byte & buffer[]);
/** \example ex_RS485Read.nxc
 * This is an example of how to use the \ref RS485Read function.
 */

/**
 * Is RS485 sending data.
 * Check whether the RS485 is actively sending data.
 * 
 * \return A value indicating whether data is being sent or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline bool RS485SendingData(void);
/** \example ex_RS485SendingData.nxc
 * This is an example of how to use the \ref RS485SendingData function.
 */

/**
 * Check RS485 status.
 * Check the status of the RS485 hi-speed port.
 * 
 * \param sendingData A boolean value set to true on output if data is being sent.
 * \param dataAvail A boolean value set to true on output if data is available to be read.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void RS485Status(bool & sendingData, bool & dataAvail);
/** \example ex_RS485Status.nxc
 * This is an example of how to use the \ref RS485Status function.
 */

/**
 * Configure RS485 UART.
 * Configure the RS485 UART parameters, including baud rate, data bits,
 * stop bits, and parity.
 * 
 * \param baud The baud rate for the RS485 port. See \ref CommHiSpeedBaudConstants.
 * \param mode The RS485 port mode (data bits, stop bits, parity).  See \ref
 * CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants, \ref
 * CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Uart(byte baud, unsigned int mode);
/** \example ex_RS485Uart.nxc
 * This is an example of how to use the \ref RS485Uart function.
 */

/**
 * Write RS485 data.
 * Write data to the RS485 hi-speed port.
 * 
 * \param buffer A byte array containing the data to write to the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Write(byte buffer[]);
/** \example ex_RS485Write.nxc
 * This is an example of how to use the \ref RS485Write function.
 */

/**
 * Write RS485 boolean.
 * Write a boolean value to the RS485 hi-speed port.
 * 
 * \param bval A boolean value to write over the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char SendRS485Bool(bool bval);
/** \example ex_SendRS485Bool.nxc
 * This is an example of how to use the \ref SendRS485Bool function.
 */

/**
 * Write RS485 numeric.
 * Write a numeric value to the RS485 hi-speed port.
 * 
 * \param val A numeric value to write over the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char SendRS485Number(long val);
/** \example ex_SendRS485Number.nxc
 * This is an example of how to use the \ref SendRS485Number function.
 */

/**
 * Write RS485 string.
 * Write a string value to the RS485 hi-speed port.
 * 
 * \param str A string value to write over the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char SendRS485String(string str);
/** \example ex_SendRS485String.nxc
 * This is an example of how to use the \ref SendRS485String function.
 */

#endif

/**
 * Get bluetooth input buffer data.
 * This method reads count bytes of data from the Bluetooth input buffer and
 * writes it to the buffer provided.
 * 
 * \param offset A constant offset into the bluetooth input buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the bluetooth input buffer.
 */
inline void GetBTInputBuffer(const byte offset, byte cnt, byte & data[]);
/** \example ex_GetBTInputBuffer.nxc
 * This is an example of how to use the \ref GetBTInputBuffer function.
 */

/**
 * Get bluetooth output buffer data.
 * This method reads count bytes of data from the Bluetooth output buffer and
 * writes it to the buffer provided.
 * 
 * \param offset A constant offset into the bluetooth output buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the bluetooth output buffer.
 */
inline void GetBTOutputBuffer(const byte offset, byte cnt, byte & data[]);
/** \example ex_GetBTOutputBuffer.nxc
 * This is an example of how to use the \ref GetBTOutputBuffer function.
 */

/**
 * Get hi-speed port input buffer data.
 * This method reads count bytes of data from the hi-speed port input buffer and
 * writes it to the buffer provided.
 * 
 * \param offset A constant offset into the hi-speed port input buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the hi-speed port input buffer.
 */
inline void GetHSInputBuffer(const byte offset, byte cnt, byte & data[]);
/** \example ex_GetHSInputBuffer.nxc
 * This is an example of how to use the \ref GetHSInputBuffer function.
 */

/**
 * Get hi-speed port output buffer data.
 * This method reads count bytes of data from the hi-speed port output buffer and
 * writes it to the buffer provided.
 * 
 * \param offset A constant offset into the hi-speed port output buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the hi-speed port output buffer.
 */
inline void GetHSOutputBuffer(const byte offset, byte cnt, byte & data[]);
/** \example ex_GetHSOutputBuffer.nxc
 * This is an example of how to use the \ref GetHSOutputBuffer function.
 */

/**
 * Get usb input buffer data.
 * This method reads count bytes of data from the usb input buffer and
 * writes it to the buffer provided.
 * 
 * \param offset A constant offset into the usb input buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the usb input buffer.
 */
inline void GetUSBInputBuffer(const byte offset, byte cnt, byte & data[]);
/** \example ex_GetUSBInputBuffer.nxc
 * This is an example of how to use the \ref GetUSBInputBuffer function.
 */

/**
 * Get usb output buffer data.
 * This method reads count bytes of data from the usb output buffer and
 * writes it to the buffer provided.
 * \param offset A constant offset into the usb output buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the usb output buffer.
 */
inline void GetUSBOutputBuffer(const byte offset, byte cnt, byte & data[]);
/** \example ex_GetUSBOutputBuffer.nxc
 * This is an example of how to use the \ref GetUSBOutputBuffer function.
 */

/**
 * Get usb poll buffer data.
 * This method reads count bytes of data from the usb poll buffer and
 * writes it to the buffer provided.
 * \param offset A constant offset into the usb poll buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the usb poll buffer.
 */
inline void GetUSBPollBuffer(const byte offset, byte cnt, byte & data[]);
/** \example ex_GetUSBPollBuffer.nxc
 * This is an example of how to use the \ref GetUSBPollBuffer function.
 */

/**
 * Get bluetooth device name.
 * This method returns the name of the device at the specified index in the
 * Bluetooth device table.
 * \param devidx The device table index.
 * \return The device name of the specified bluetooth device.
 */
inline string BTDeviceName(const byte devidx);
/** \example ex_BTDeviceName.nxc
 * This is an example of how to use the \ref BTDeviceName function.
 */

/**
 * Get bluetooth device name.
 * This method returns the name of the device at the specified index in the
 * Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The name of the bluetooth device at the specified connection slot.
 */
inline string BTConnectionName(const byte conn);
/** \example ex_BTConnectionName.nxc
 * This is an example of how to use the \ref BTConnectionName function.
 */

/**
 * Get bluetooth device pin code.
 * This method returns the pin code of the device at the specified index in the
 * Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The pin code for the bluetooth device at the specified connection slot.
 */
inline string BTConnectionPinCode(const byte conn);
/** \example ex_BTConnectionPinCode.nxc
 * This is an example of how to use the \ref BTConnectionPinCode function.
 */

/**
 * Get NXT name.
 * This method returns the name of the NXT.
 * \return The NXT's bluetooth name.
 */
inline string BrickDataName(void);
/** \example ex_BrickDataName.nxc
 * This is an example of how to use the \ref BrickDataName function.
 */

/**
 * Get bluetooth device address.
 * This method reads the address of the device at the specified index within
 * the Bluetooth device table and stores it in the data buffer provided.
 * \param devidx The device table index.
 * \param data The byte array reference that will contain the device address.
 */
inline void GetBTDeviceAddress(const byte devidx, byte & data[]);
/** \example ex_GetBTDeviceAddress.nxc
 * This is an example of how to use the \ref GetBTDeviceAddress function.
 */

/**
 * Get bluetooth device address.
 * This method reads the address of the device at the specified index within
 * the Bluetooth connection table and stores it in the data buffer provided.
 * \param conn The connection slot (0..3).
 * \param data The byte array reference that will contain the device address.
 */
inline void GetBTConnectionAddress(const byte conn, byte & data[]);
/** \example ex_GetBTConnectionAddress.nxc
 * This is an example of how to use the \ref GetBTConnectionAddress function.
 */

/**
 * Get NXT address.
 * This method reads the address of the NXT and stores it in the data buffer
 * provided.
 * \param data The byte array reference that will contain the device address.
 */
inline void GetBrickDataAddress(byte & data[]);
/** \example ex_GetBrickDataAddress.nxc
 * This is an example of how to use the \ref GetBrickDataAddress function.
 */

/**
 * Get bluetooth device class.
 * This method returns the class of the device at the specified index within
 * the Bluetooth device table.
 * \param devidx The device table index.
 * \return The device class of the specified bluetooth device.
 */
inline long BTDeviceClass(const byte devidx);
/** \example ex_BTDeviceClass.nxc
 * This is an example of how to use the \ref BTDeviceClass function.
 */

/**
 * Get bluetooth device status.
 * This method returns the status of the device at the specified index within
 * the Bluetooth device table.
 * \param devidx The device table index.
 * \return The status of the specified bluetooth device.
 */
inline byte BTDeviceStatus(const byte devidx);
/** \example ex_BTDeviceStatus.nxc
 * This is an example of how to use the \ref BTDeviceStatus function.
 */

/**
 * Get bluetooth device class.
 * This method returns the class of the device at the specified index within
 * the Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The class of the bluetooth device at the specified connection slot.
 */
inline long BTConnectionClass(const byte conn);
/** \example ex_BTConnectionClass.nxc
 * This is an example of how to use the \ref BTConnectionClass function.
 */

/**
 * Get bluetooth device handle number.
 * This method returns the handle number of the device at the specified index within
 * the Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The handle number of the bluetooth device at the specified connection slot.
 */
inline byte BTConnectionHandleNum(const byte conn);
/** \example ex_BTConnectionHandleNum.nxc
 * This is an example of how to use the \ref BTConnectionHandleNum function.
 */

/**
 * Get bluetooth device stream status.
 * This method returns the stream status of the device at the specified index within
 * the Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The stream status of the bluetooth device at the specified connection slot.
 */
inline byte BTConnectionStreamStatus(const byte conn);
/** \example ex_BTConnectionStreamStatus.nxc
 * This is an example of how to use the \ref BTConnectionStreamStatus function.
 */

/**
 * Get bluetooth device link quality.
 * This method returns the link quality of the device at the specified index within
 * the Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The link quality of the specified connection slot (unimplemented).
 * \warning This function is not implemented at the firmware level.
 */
inline byte BTConnectionLinkQuality(const byte conn);
/** \example ex_BTConnectionLinkQuality.nxc
 * This is an example of how to use the \ref BTConnectionLinkQuality function.
 */

/**
 * Get NXT bluecore version.
 * This method returns the bluecore version of the NXT.
 * \return The NXT's bluecore version number.
 */
inline int BrickDataBluecoreVersion(void);
/** \example ex_BrickDataBluecoreVersion.nxc
 * This is an example of how to use the \ref BrickDataBluecoreVersion function.
 */

/**
 * Get NXT bluetooth state status.
 * This method returns the Bluetooth state status of the NXT.
 * \return The NXT's bluetooth state status.
 */
inline byte BrickDataBtStateStatus(void);
/** \example ex_BrickDataBtStateStatus.nxc
 * This is an example of how to use the \ref BrickDataBtStateStatus function.
 */

/**
 * Get NXT bluetooth hardware status.
 * This method returns the Bluetooth hardware status of the NXT.
 * \return The NXT's bluetooth hardware status.
 */
inline byte BrickDataBtHardwareStatus(void);
/** \example ex_BrickDataBtHardwareStatus.nxc
 * This is an example of how to use the \ref BrickDataBtHardwareStatus function.
 */

/**
 * Get NXT bluetooth timeout value.
 * This method returns the Bluetooth timeout value of the NXT.
 * \return The NXT's bluetooth timeout value.
 */
inline byte BrickDataTimeoutValue(void);
/** \example ex_BrickDataTimeoutValue.nxc
 * This is an example of how to use the \ref BrickDataTimeoutValue function.
 */

/**
 * Get bluetooth input buffer in-pointer.
 * This method returns the value of the input pointer of the Bluetooth input
 * buffer.
 * \return The bluetooth input buffer's in-pointer value.
 */
inline byte BTInputBufferInPtr(void);
/** \example ex_BTInputBufferInPtr.nxc
 * This is an example of how to use the \ref BTInputBufferInPtr function.
 */

/**
 * Get bluetooth input buffer out-pointer.
 * This method returns the value of the output pointer of the Bluetooth input
 * buffer.
 * \return The bluetooth input buffer's out-pointer value.
 */
inline byte BTInputBufferOutPtr(void);
/** \example ex_BTInputBufferOutPtr.nxc
 * This is an example of how to use the \ref BTInputBufferOutPtr function.
 */

/**
 * Get bluetooth output buffer in-pointer.
 * This method returns the value of the input pointer of the Bluetooth output
 * buffer.
 * \return The bluetooth output buffer's in-pointer value.
 */
inline byte BTOutputBufferInPtr(void);
/** \example ex_BTOutputBufferInPtr.nxc
 * This is an example of how to use the \ref BTOutputBufferInPtr function.
 */

/**
 * Get bluetooth output buffer out-pointer.
 * This method returns the value of the output pointer of the Bluetooth output
 * buffer.
 * \return The bluetooth output buffer's out-pointer value.
 */
inline byte BTOutputBufferOutPtr(void);
/** \example ex_BTOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref BTOutputBufferOutPtr function.
 */

/**
 * Get hi-speed port input buffer in-pointer.
 * This method returns the value of the input pointer of the hi-speed port input
 * buffer.
 * \return The hi-speed port input buffer's in-pointer value.
 */
inline byte HSInputBufferInPtr(void);
/** \example ex_HSInputBufferInPtr.nxc
 * This is an example of how to use the \ref HSInputBufferInPtr function.
 */

/**
 * Get hi-speed port input buffer out-pointer.
 * This method returns the value of the output pointer of the hi-speed port input
 * buffer.
 * \return The hi-speed port input buffer's out-pointer value.
 */
inline byte HSInputBufferOutPtr(void);
/** \example ex_HSInputBufferOutPtr.nxc
 * This is an example of how to use the \ref HSInputBufferOutPtr function.
 */

/**
 * Get hi-speed port output buffer in-pointer.
 * This method returns the value of the input pointer of the hi-speed port output
 * buffer.
 * \return The hi-speed port output buffer's in-pointer value.
 */
inline byte HSOutputBufferInPtr(void);
/** \example ex_HSOutputBufferInPtr.nxc
 * This is an example of how to use the \ref HSOutputBufferInPtr function.
 */

/**
 * Get hi-speed port output buffer out-pointer.
 * This method returns the value of the output pointer of the hi-speed port output
 * buffer.
 * \return The hi-speed port output buffer's out-pointer value.
 */
inline byte HSOutputBufferOutPtr(void);
/** \example ex_HSOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref HSOutputBufferOutPtr function.
 */

/**
 * Get usb port input buffer in-pointer.
 * This method returns the value of the input pointer of the usb port input
 * buffer.
 * \return The USB port input buffer's in-pointer value.
 */
inline byte USBInputBufferInPtr(void);
/** \example ex_USBInputBufferInPtr.nxc
 * This is an example of how to use the \ref USBInputBufferInPtr function.
 */

/**
 * Get usb port input buffer out-pointer.
 * This method returns the value of the output pointer of the usb port input
 * buffer.
 * \return The USB port input buffer's out-pointer value.
 */
inline byte USBInputBufferOutPtr(void);
/** \example ex_USBInputBufferOutPtr.nxc
 * This is an example of how to use the \ref USBInputBufferOutPtr function.
 */

/**
 * Get usb port output buffer in-pointer.
 * This method returns the value of the input pointer of the usb port output
 * buffer.
 * \return The USB port output buffer's in-pointer value.
 */
inline byte USBOutputBufferInPtr(void);
/** \example ex_USBOutputBufferInPtr.nxc
 * This is an example of how to use the \ref USBOutputBufferInPtr function.
 */

/**
 * Get usb port output buffer out-pointer.
 * This method returns the value of the output pointer of the usb port output
 * buffer.
 * \return The USB port output buffer's out-pointer value.
 */
inline byte USBOutputBufferOutPtr(void);
/** \example ex_USBOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref USBOutputBufferOutPtr function.
 */

/**
 * Get usb port poll buffer in-pointer.
 * This method returns the value of the input pointer of the usb port poll
 * buffer.
 * \return The USB port poll buffer's in-pointer value.
 */
inline byte USBPollBufferInPtr(void);
/** \example ex_USBPollBufferInPtr.nxc
 * This is an example of how to use the \ref USBPollBufferInPtr function.
 */

/**
 * Get usb port poll buffer out-pointer.
 * This method returns the value of the output pointer of the usb port poll
 * buffer.
 * \return The USB port poll buffer's out-pointer value.
 */
inline byte USBPollBufferOutPtr(void);
/** \example ex_USBPollBufferOutPtr.nxc
 * This is an example of how to use the \ref USBPollBufferOutPtr function.
 */

/**
 * Get bluetooth device count.
 * This method returns the number of devices defined within the Bluetooth
 * device table.
 * \return The count of known bluetooth devices.
 */
inline byte BTDeviceCount(void);
/** \example ex_BTDeviceCount.nxc
 * This is an example of how to use the \ref BTDeviceCount function.
 */

/**
 * Get bluetooth device name count.
 * This method returns the number of device names defined within the Bluetooth
 * device table. This usually has the same value as BTDeviceCount but it can
 * differ in some instances.
 * \return The count of known bluetooth device names.
 */
inline byte BTDeviceNameCount(void);
/** \example ex_BTDeviceNameCount.nxc
 * This is an example of how to use the \ref BTDeviceNameCount function.
 */

/**
 * Get hi-speed port flags.
 * This method returns the value of the hi-speed port flags.
 * \return The hi-speed port flags. See \ref CommHiSpeedFlagsConstants.
 */
inline byte HSFlags(void);
/** \example ex_HSFlags.nxc
 * This is an example of how to use the \ref HSFlags function.
 */

/**
 * Get hi-speed port speed.
 * This method returns the value of the hi-speed port speed (baud rate).
 * \return The hi-speed port speed (baud rate).  See \ref CommHiSpeedBaudConstants.
 */
inline byte HSSpeed(void);
/** \example ex_HSSpeed.nxc
 * This is an example of how to use the \ref HSSpeed function.
 */

/**
 * Get hi-speed port state.
 * This method returns the value of the hi-speed port state.
 * \return The hi-speed port state. See \ref CommHiSpeedStateConstants.
 */
inline byte HSState(void);
/** \example ex_HSState.nxc
 * This is an example of how to use the \ref HSState function.
 */

/**
 * Get hi-speed port mode.
 * This method returns the value of the hi-speed port mode.
 * \return The hi-speed port mode (data bits, stop bits, parity).  See
 * \ref CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants,
 * \ref CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 */
inline int HSMode(void);
/** \example ex_HSMode.nxc
 * This is an example of how to use the \ref HSMode function.
 */

/**
 * Get USB state.
 * This method returns the value of the USB state.
 * \return The USB state.
 */
inline byte USBState(void);
/** \example ex_USBState.nxc
 * This is an example of how to use the \ref USBState function.
 */

/**
 * Set bluetooth input buffer data.
 * Write cnt bytes of data to the bluetooth input buffer at offset.
 * \param offset A constant offset into the input buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetBTInputBuffer(const byte offset, byte cnt, byte data[]);
/** \example ex_SetBTInputBuffer.nxc
 * This is an example of how to use the \ref SetBTInputBuffer function.
 */

/**
 * Set bluetooth input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param n The new in-pointer value (0..127).
 */
inline void SetBTInputBufferInPtr(byte n);
/** \example ex_SetBTInputBufferInPtr.nxc
 * This is an example of how to use the \ref SetBTInputBufferInPtr function.
 */

/**
 * Set bluetooth input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param n The new out-pointer value (0..127).
 */
inline void SetBTInputBufferOutPtr(byte n);
/** \example ex_SetBTInputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetBTInputBufferOutPtr function.
 */

/**
 * Set bluetooth output buffer data.
 * Write cnt bytes of data to the bluetooth output buffer at offset.
 * \param offset A constant offset into the output buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetBTOutputBuffer(const byte offset, byte cnt, byte data[]);
/** \example ex_SetBTOutputBuffer.nxc
 * This is an example of how to use the \ref SetBTOutputBuffer function.
 */

/**
 * Set bluetooth output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param n The new in-pointer value (0..127).
 */
inline void SetBTOutputBufferInPtr(byte n);
/** \example ex_SetBTOutputBufferInPtr.nxc
 * This is an example of how to use the \ref SetBTOutputBufferInPtr function.
 */

/**
 * Set bluetooth output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param n The new out-pointer value (0..127).
 */
inline void SetBTOutputBufferOutPtr(byte n);
/** \example ex_SetBTOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetBTOutputBufferOutPtr function.
 */

/**
 * Set hi-speed port input buffer data.
 * Write cnt bytes of data to the hi-speed port input buffer at offset.
 * \param offset A constant offset into the input buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetHSInputBuffer(const byte offset, byte cnt, byte data[]);
/** \example ex_SetHSInputBuffer.nxc
 * This is an example of how to use the \ref SetHSInputBuffer function.
 */

/**
 * Set hi-speed port input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param n The new in-pointer value (0..127).
 */
inline void SetHSInputBufferInPtr(byte n);
/** \example ex_SetHSInputBufferInPtr.nxc
 * This is an example of how to use the \ref SetHSInputBufferInPtr function.
 */

/**
 * Set hi-speed port input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param n The new out-pointer value (0..127).
 */
inline void SetHSInputBufferOutPtr(byte n);
/** \example ex_SetHSInputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetHSInputBufferOutPtr function.
 */

/**
 * Set hi-speed port output buffer data.
 * Write cnt bytes of data to the hi-speed port output buffer at offset.
 * \param offset A constant offset into the output buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetHSOutputBuffer(const byte offset, byte cnt, byte data[]);
/** \example ex_SetHSOutputBuffer.nxc
 * This is an example of how to use the \ref SetHSOutputBuffer function.
 */

/**
 * Set hi-speed port output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param n The new in-pointer value (0..127).
 */
inline void SetHSOutputBufferInPtr(byte n);
/** \example ex_SetHSOutputBufferInPtr.nxc
 * This is an example of how to use the \ref SetHSOutputBufferInPtr function.
 */

/**
 * Set hi-speed port output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param n The new out-pointer value (0..127).
 */
inline void SetHSOutputBufferOutPtr(byte n);
/** \example ex_SetHSOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetHSOutputBufferOutPtr function.
 */

/**
 * Set USB input buffer data.
 * Write cnt bytes of data to the USB input buffer at offset.
 * \param offset A constant offset into the input buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetUSBInputBuffer(const byte offset, byte cnt, byte data[]);
/** \example ex_SetUSBInputBuffer.nxc
 * This is an example of how to use the \ref SetUSBInputBuffer function.
 */

/**
 * Set USB input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param n The new in-pointer value (0..63).
 */
inline void SetUSBInputBufferInPtr(byte n);
/** \example ex_SetUSBInputBufferInPtr.nxc
 * This is an example of how to use the \ref SetUSBInputBufferInPtr function.
 */

/**
 * Set USB input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param n The new out-pointer value (0..63).
 */
inline void SetUSBInputBufferOutPtr(byte n);
/** \example ex_SetUSBInputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetUSBInputBufferOutPtr function.
 */

/**
 * Set USB output buffer data.
 * Write cnt bytes of data to the USB output buffer at offset.
 * \param offset A constant offset into the output buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetUSBOutputBuffer(const byte offset, byte cnt, byte data[]);
/** \example ex_SetUSBOutputBuffer.nxc
 * This is an example of how to use the \ref SetUSBOutputBuffer function.
 */

/**
 * Set USB output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param n The new in-pointer value (0..63).
 */
inline void SetUSBOutputBufferInPtr(byte n);
/** \example ex_SetUSBOutputBufferInPtr.nxc
 * This is an example of how to use the \ref SetUSBOutputBufferInPtr function.
 */

/**
 * Set USB output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param n The new out-pointer value (0..63).
 */
inline void SetUSBOutputBufferOutPtr(byte n);
/** \example ex_SetUSBOutputBufferOutPtr.nxc
 * This is an example of how to use the \ref SetUSBOutputBufferOutPtr function.
 */

/**
 * Set USB poll buffer data.
 * Write cnt bytes of data to the USB poll buffer at offset.
 * \param offset A constant offset into the poll buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetUSBPollBuffer(const byte offset, byte cnt, byte data[]);
/** \example ex_SetUSBPollBuffer.nxc
 * This is an example of how to use the \ref SetUSBPollBuffer function.
 */

/**
 * Set USB poll buffer in-pointer.
 * Set the value of the poll buffer in-pointer.
 * \param n The new in-pointer value (0..63).
 */
inline void SetUSBPollBufferInPtr(byte n);
/** \example ex_SetUSBPollBufferInPtr.nxc
 * This is an example of how to use the \ref SetUSBPollBufferInPtr function.
 */

/**
 * Set USB poll buffer out-pointer.
 * Set the value of the poll buffer out-pointer.
 * \param n The new out-pointer value (0..63).
 */
inline void SetUSBPollBufferOutPtr(byte n);
/** \example ex_SetUSBPollBufferOutPtr.nxc
 * This is an example of how to use the \ref SetUSBPollBufferOutPtr function.
 */

/**
 * Set hi-speed port flags.
 * This method sets the value of the hi-speed port flags.
 * \param hsFlags The hi-speed port flags. See \ref CommHiSpeedFlagsConstants.
 */
inline void SetHSFlags(const byte hsFlags);
/** \example ex_SetHSFlags.nxc
 * This is an example of how to use the \ref SetHSFlags function.
 */

/**
 * Set hi-speed port speed.
 * This method sets the value of the hi-speed port speed (baud rate).
 * \param hsSpeed The hi-speed port speed (baud rate).  See \ref CommHiSpeedBaudConstants.
 */
inline void SetHSSpeed(const byte hsSpeed);
/** \example ex_SetHSSpeed.nxc
 * This is an example of how to use the \ref SetHSSpeed function.
 */

/**
 * Set hi-speed port state.
 * This method sets the value of the hi-speed port state.
 * \param hsState The hi-speed port state. See \ref CommHiSpeedStateConstants.
 */
inline void SetHSState(const byte hsState);
/** \example ex_SetHSState.nxc
 * This is an example of how to use the \ref SetHSState function.
 */

/**
 * Set hi-speed port mode.
 * This method sets the value of the hi-speed port mode.
 * \param hsMode The hi-speed port mode (data bits, stop bits, parity).  See
 * \ref CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants,
 * \ref CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 */
inline void SetHSMode(const unsigned int hsMode);
/** \example ex_SetHSMode.nxc
 * This is an example of how to use the \ref SetHSMode function.
 */

/**
 * Set USB state.
 * This method sets the value of the USB state.
 * \param usbState The USB state.
 */
inline void SetUSBState(byte usbState);
/** \example ex_SetUSBState.nxc
 * This is an example of how to use the \ref SetUSBState function.
 */

/**
 * Write message.
 * This function lets you write a message to a queue (aka mailbox) using the
 * values specified via the \ref MessageWriteType structure.
 *
 * \param args The MessageWriteType structure containing the needed parameters.
 */
void SysMessageWrite(MessageWriteType & args);
/** \example ex_sysmessagewrite.nxc
 * This is an example of how to use the \ref SysMessageWrite function along with
 * the \ref MessageWriteType structure.
 */

/**
 * Read message.
 * This function lets you read a message from a queue (aka mailbox) using the
 * values specified via the \ref MessageReadType structure.
 *
 * \param args The MessageReadType structure containing the needed parameters.
 */
void SysMessageRead(MessageReadType & args);
/** \example ex_sysmessageread.nxc
 * This is an example of how to use the \ref SysMessageRead function along with the
 * \ref MessageReadType structure.
 */

/**
 * Write data to a Bluetooth connection.
 * This function lets you write to a Bluetooth connection using the values
 * specified via the \ref CommBTWriteType structure.
 *
 * \param args The CommBTWriteType structure containing the needed parameters.
 */
void SysCommBTWrite(CommBTWriteType & args);
/** \example ex_syscommbtwrite.nxc
 * This is an example of how to use the \ref SysCommBTWrite function along with the
 * \ref CommBTWriteType structure.
 */

/**
 * Check Bluetooth connection status.
 * This function lets you check the status of a Bluetooth connection using the
 * values specified via the \ref CommBTCheckStatusType structure.
 *
 * \param args The CommBTCheckStatusType structure containing the needed
 * parameters.
 */
void SysCommBTCheckStatus(CommBTCheckStatusType & args);
/** \example ex_syscommbtcheckstatus.nxc
 * This is an example of how to use the \ref SysCommBTCheckStatus function along
 * with the \ref CommBTCheckStatusType structure.
 */

#ifdef __ENHANCED_FIRMWARE
/**
 * Execute any Comm module command.
 * This function lets you directly execute the Comm module's primary function
 * using the values specified via the \ref CommExecuteFunctionType structure.
 *
 * \param args The CommExecuteFunctionType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommExecuteFunction(CommExecuteFunctionType & args);
/** \example ex_syscommexecutefunction.nxc
 * This is an example of how to use the \ref SysCommExecuteFunction function along
 * with the \ref CommExecuteFunctionType structure.
 */

/**
 * Control the hi-speed port.
 * This function lets you control the hi-speed port
 * using the values specified via the \ref CommHSControlType structure.
 *
 * \param args The CommHSControlType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommHSControl(CommHSControlType & args);
/** \example ex_SysCommHSControl.nxc
 * This is an example of how to use the \ref SysCommHSControl function along
 * with the \ref CommHSControlType structure.
 */

/**
 * Check the hi-speed port status.
 * This function lets you check the hi-speed port status
 * using the values specified via the \ref CommHSCheckStatusType structure.
 *
 * \param args The CommHSCheckStatusType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommHSCheckStatus(CommHSCheckStatusType & args);
/** \example ex_SysCommHSCheckStatus.nxc
 * This is an example of how to use the \ref SysCommHSCheckStatus function along
 * with the \ref CommHSCheckStatusType structure.
 */

/**
 * Read from the hi-speed port.
 * This function lets you read from the hi-speed port
 * using the values specified via the \ref CommHSReadWriteType structure.
 *
 * \param args The CommHSReadWriteType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommHSRead(CommHSReadWriteType & args);
/** \example ex_SysCommHSRead.nxc
 * This is an example of how to use the \ref SysCommHSRead function along
 * with the \ref CommHSReadWriteType structure.
 */

/**
 * Write to the hi-speed port.
 * This function lets you write to the hi-speed port
 * using the values specified via the \ref CommHSReadWriteType structure.
 *
 * \param args The CommHSReadWriteType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommHSWrite(CommHSReadWriteType & args);
/** \example ex_SysCommHSWrite.nxc
 * This is an example of how to use the \ref SysCommHSWrite function along
 * with the \ref CommHSReadWriteType structure.
 */

#endif

#if __FIRMWARE_VERSION > 107
/**
 * Turn on or off the bluetooth subsystem.
 * This function lets you turn on or off the bluetooth subsystem
 * using the values specified via the \ref CommBTOnOffType structure.
 *
 * \param args The CommBTOnOffType structure containing the needed
 * parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysCommBTOnOff(CommBTOnOffType & args);
/** \example ex_SysCommBTOnOff.nxc
 * This is an example of how to use the \ref SysCommBTOnOff function along
 * with the \ref CommBTOnOffType structure.
 */

/**
 * Connect or disconnect a bluetooth device.
 * This function lets you connect or disconnect a bluetooth device
 * using the values specified via the \ref CommBTConnectionType structure.
 *
 * \param args The CommBTConnectionType structure containing the needed
 * parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysCommBTConnection(CommBTConnectionType & args);
/** \example ex_SysCommBTConnection.nxc
 * This is an example of how to use the \ref SysCommBTConnection function along
 * with the \ref CommBTConnectionType structure.
 */

#endif

/*
// these functions really cannot be used for any useful purpose (read-only)
inline void SetBTDeviceName(const byte devidx, string str);
inline void SetBTDeviceAddress(const byte devidx, const byte addr[]);
inline void SetBTConnectionName(const byte conn, string str);
inline void SetBTConnectionPinCode(const byte conn, const byte code[]);
inline void SetBTConnectionAddress(const byte conn, const byte addr[]);
inline void SetBrickDataName(string str);
inline void SetBrickDataAddress(const byte p, byte addr[]);
inline void SetBTDeviceClass(const byte devidx, unsigned long class);
inline void SetBTDeviceStatus(const byte devidx, const byte status);
inline void SetBTConnectionClass(const byte conn, unsigned long class);
inline void SetBTConnectionHandleNum(const byte conn, const byte handleNum);
inline void SetBTConnectionStreamStatus(const byte conn, const byte status);
inline void SetBTConnectionLinkQuality(const byte conn, const byte quality);
inline void SetBrickDataBluecoreVersion(int version);
inline void SetBrickDataBtStateStatus(byte status);
inline void SetBrickDataBtHardwareStatus(byte status);
inline void SetBrickDataTimeoutValue(const byte timeout);
inline void SetBTDeviceCount(byte count);
inline void SetBTDeviceNameCount(byte count);
*/

#else

#define SendMessage(_queue, _msg) asm { __sendMessage(_queue, _msg, __RETVAL__) }
#define ReceiveMessage(_queue, _clear, _msg) asm { __receiveMessage(_queue, _clear, _msg, __RETVAL__) }

#define BluetoothStatus(_conn) asm { __bluetoothStatus(_conn, __RETVAL__) }
#define BluetoothWrite(_conn, _buffer) asm { __bluetoothWrite(_conn, _buffer, __RETVAL__) }

#define SendRemoteBool(_conn, _queue, _bval) asm { __sendRemoteBool(_conn, _queue, _bval, __RETVAL__) }
#define SendRemoteNumber(_conn, _queue, _val) asm { __sendRemoteNumber(_conn, _queue, _val, __RETVAL__) }
#define SendRemoteString(_conn, _queue, _str) asm { __sendRemoteString(_conn, _queue, _str, __RETVAL__) }

#define SendResponseBool(_queue, _bval) asm { __sendResponseBool(_queue, _bval, __RETVAL__) }
#define SendResponseNumber(_queue, _val) asm { __sendResponseNumber(_queue, _val, __RETVAL__) }
#define SendResponseString(_queue, _msg) asm { __sendResponseString(_queue, _msg, __RETVAL__) }

#define ReceiveRemoteBool(_queue, _clear, _bval) asm { __receiveRemoteBool(_queue, _clear, _bval, __RETVAL__) }
#define ReceiveRemoteNumber(_queue, _clear, _val) asm { __receiveRemoteNumber(_queue, _clear, _val, __RETVAL__) }
#define ReceiveRemoteString(_queue, _clear, _str) asm { __receiveMessage(_queue, _clear, _str, __RETVAL__) }
#define ReceiveRemoteMessageEx(_queue, _clear, _str, _val, _bval) asm { __receiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, __RETVAL__) }

#define RemoteMessageRead(_conn, _queue) asm { __remoteMessageRead(_conn, _queue, __RETVAL__) }
#define RemoteMessageWrite(_conn, _queue, _msg) asm { __sendRemoteString(_conn, _queue, _msg, __RETVAL__) }
#define RemoteStartProgram(_conn, _filename) asm { __remoteStartProgram(_conn, _filename, __RETVAL__) }
#define RemoteStopProgram(_conn) asm { __bluetoothWrite(_conn, __DCStopProgramPacket, __RETVAL__) }
#define RemotePlaySoundFile(_conn, _filename, _bloop) asm { __remotePlaySoundFile(_conn, _filename, _bloop, __RETVAL__) }
#define RemotePlayTone(_conn, _frequency, _duration) asm { __remotePlayTone(_conn, _frequency, _duration, __RETVAL__) }
#define RemoteStopSound(_conn) asm { __bluetoothWrite(_conn, __DCStopSoundPacket, __RETVAL__) }
#define RemoteKeepAlive(_conn) asm { __bluetoothWrite(_conn, __DCKeepAlivePacket, __RETVAL__) }
#define RemoteResetScaledValue(_conn, _port) asm { __remoteResetScaledValue(_conn, _port, __RETVAL__) }
#define RemoteResetMotorPosition(_conn, _port, _brelative) asm { __remoteResetMotorPosition(_conn, _port, _brelative, __RETVAL__) }
#define RemoteSetInputMode(_conn, _port, _type, _mode) asm { __remoteSetInputMode(_conn, _port, _type, _mode, __RETVAL__) }
#define RemoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit) \
  asm { __remoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, __RETVAL__) }


#ifdef __ENHANCED_FIRMWARE

#define RS485Status(_sendingData, _dataAvail) asm { __RS485Status(_sendingData, _dataAvail) }
#define RS485SendingData() asm { __RS485Status(__RETVAL__, __TMPBYTE__) }
#define RS485DataAvailable() asm { __RS485Status(__TMPBYTE__, __RETVAL__) }
#define RS485Write(_buffer) asm { __RS485Write(_buffer, __RETVAL__) }
#define RS485Read(_buffer) asm { __RS485Read(_buffer, __RETVAL__) }

#if __FIRMWARE_VERSION > 107

#define RS485Control(_cmd, _baud, _mode) asm { __RS485Control(_cmd, _baud, _mode, __RETVAL__) }
#define RS485Uart(_baud, _mode) asm { __RS485Control(HS_CTRL_UART, _baud, _mode, __RETVAL__) }
#define RS485Init() asm { __RS485Control(HS_CTRL_INIT, 0, 0, __RETVAL__) }
#define RS485Exit() asm { __RS485Control(HS_CTRL_EXIT, 0, 0, __RETVAL__) }

#else

#define RS485Control(_cmd, _baud) asm { __RS485Control(_cmd, _baud, __RETVAL__) }
#define RS485Uart(_baud) asm { __RS485Control(HS_CTRL_UART, _baud, __RETVAL__) }
#define RS485Init() asm { __RS485Control(HS_CTRL_INIT, 0, __RETVAL__) }
#define RS485Exit() asm { __RS485Control(HS_CTRL_EXIT, 0, __RETVAL__) }

#endif

#define SendRS485Bool(_bval) asm { __sendRS485Bool(_bval, __RETVAL__) }
#define SendRS485Number(_val) asm { __sendRS485Number(_val, __RETVAL__) }
#define SendRS485String(_str) asm { __sendRS485String(_str, __RETVAL__) }

#endif

#define GetBTInputBuffer(_offset, _cnt, _data) asm { __getBTInputBuffer(_offset, _cnt, _data) }
#define GetBTOutputBuffer(_offset, _cnt, _data) asm { __getBTOutputBuffer(_offset, _cnt, _data) }
#define GetHSInputBuffer(_offset, _cnt, _data) asm { __getHSInputBuffer(_offset, _cnt, _data) }
#define GetHSOutputBuffer(_offset, _cnt, _data) asm { __getHSOutputBuffer(_offset, _cnt, _data) }
#define GetUSBInputBuffer(_offset, _cnt, _data) asm { __getUSBInputBuffer(_offset, _cnt, _data) }
#define GetUSBOutputBuffer(_offset, _cnt, _data) asm { __getUSBOutputBuffer(_offset, _cnt, _data) }
#define GetUSBPollBuffer(_offset, _cnt, _data) asm { __getUSBPollBuffer(_offset, _cnt, _data) }

#define BTDeviceName(_p) asm { GetBTDeviceName(_p, __STRRETVAL__) }
#define BTConnectionName(_p) asm { GetBTConnectionName(_p, __STRRETVAL__) }
#define BTConnectionPinCode(_p) asm { GetBTConnectionPinCode(_p, __STRRETVAL__) }
#define BrickDataName() asm { GetBrickDataName(__STRRETVAL__) }

#define GetBTDeviceAddress(_p, _data) asm { __getBTDeviceAddress(_p, _data) }
#define GetBTConnectionAddress(_p, _data) asm { __getBTConnectionAddress(_p, _data) }
#define GetBrickDataAddress(_data) asm { GetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _data) }

#define BTDeviceClass(_p) asm { GetBTDeviceClass(_p, __TMPLONG__) __RETURN__ __TMPLONG__ }
#define BTDeviceStatus(_p) asm { GetBTDeviceStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTConnectionClass(_p) asm { GetBTConnectionClass(_p, __TMPLONG__) __RETURN__ __TMPLONG__ }
#define BTConnectionHandleNum(_p) asm { GetBTConnectionHandleNum(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTConnectionStreamStatus(_p) asm { GetBTConnectionStreamStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTConnectionLinkQuality(_p) asm { GetBTConnectionLinkQuality(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BrickDataBluecoreVersion() asm { GetBrickDataBluecoreVersion(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define BrickDataBtStateStatus() asm { GetBrickDataBtStateStatus(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BrickDataBtHardwareStatus() asm { GetBrickDataBtHardwareStatus(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BrickDataTimeoutValue() asm { GetBrickDataTimeoutValue(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTInputBufferInPtr() asm { GetBTInputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTInputBufferOutPtr() asm { GetBTInputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTOutputBufferInPtr() asm { GetBTOutputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTOutputBufferOutPtr() asm { GetBTOutputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSInputBufferInPtr() asm { GetHSInputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSInputBufferOutPtr() asm { GetHSInputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSOutputBufferInPtr() asm { GetHSOutputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSOutputBufferOutPtr() asm { GetHSOutputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBInputBufferInPtr() asm { GetUSBInputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBInputBufferOutPtr() asm { GetUSBInputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBOutputBufferInPtr() asm { GetUSBOutputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBOutputBufferOutPtr() asm { GetUSBOutputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBPollBufferInPtr() asm { GetUSBPollBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBPollBufferOutPtr() asm { GetUSBPollBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTDeviceCount() asm { GetBTDeviceCount(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTDeviceNameCount() asm { GetBTDeviceNameCount(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSFlags() asm { GetHSFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSSpeed() asm { GetHSSpeed(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSState() asm { GetHSState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBState() asm { GetUSBState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSMode() asm { GetHSMode(__TMPWORD__) __RETURN__ __TMPWORD__ }

#define SetBTDeviceName(_p, _str) asm { __setBTDeviceName(_p, _str) }
#define SetBTDeviceAddress(_p, _addr) asm { __setBTDeviceAddress(_p, _addr) }
#define SetBTConnectionName(_p, _str) asm { __setBTConnectionName(_p, _str) }
#define SetBTConnectionPinCode(_p, _code) asm { __setBTConnectionPinCode(_p, _code) }
#define SetBTConnectionAddress(_p, _addr) asm { __setBTConnectionAddress(_p, _addr) }
#define SetBrickDataName(_str) asm { SetCommModuleBytes(CommOffsetBrickDataName, 16, _str) }
#define SetBrickDataAddress(_addr) asm { SetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _addr) }

#define SetBTDeviceClass(_p, _n) asm { __setBTDeviceClass(_p, _n) }
#define SetBTDeviceStatus(_p, _n) asm { __setBTDeviceStatus(_p, _n) }
#define SetBTConnectionClass(_p, _n) asm { __setBTConnectionClass(_p, _n) }
#define SetBTConnectionHandleNum(_p, _n) asm { __setBTConnectionHandleNum(_p, _n) }
#define SetBTConnectionStreamStatus(_p, _n) asm { __setBTConnectionStreamStatus(_p, _n) }
#define SetBTConnectionLinkQuality(_p, _n) asm { __setBTConnectionLinkQuality(_p, _n) }
#define SetBrickDataBluecoreVersion(_n) asm { __setBrickDataBluecoreVersion(_n) }
#define SetBrickDataBtStateStatus(_n) asm { __setBrickDataBtStateStatus(_n) }
#define SetBrickDataBtHardwareStatus(_n) asm { __setBrickDataBtHardwareStatus(_n) }
#define SetBrickDataTimeoutValue(_n) asm { __setBrickDataTimeoutValue(_n) }

#define SetBTDeviceCount(_n) asm { __setBTDeviceCount(_n) }
#define SetBTDeviceNameCount(_n) asm { __setBTDeviceNameCount(_n) }

#define SetBTInputBuffer(_offset, _cnt, _data) asm { __setBTInputBuffer(_offset, _cnt, _data) }

#define SetBTInputBufferInPtr(_n) asm { __setBTInputBufferInPtr(_n) }
#define SetBTInputBufferOutPtr(_n) asm { __setBTInputBufferOutPtr(_n) }

#define SetBTOutputBuffer(_offset, _cnt, _data) asm { __setBTOutputBuffer(_offset, _cnt, _data) }

#define SetBTOutputBufferInPtr(_n) asm { __setBTOutputBufferInPtr(_n) }
#define SetBTOutputBufferOutPtr(_n) asm { __setBTOutputBufferOutPtr(_n) }

#define SetHSInputBuffer(_offset, _cnt, _data) asm { __setHSInputBuffer(_offset, _cnt, _data) }

#define SetHSInputBufferInPtr(_n) asm { __setHSInputBufferInPtr(_n) }
#define SetHSInputBufferOutPtr(_n) asm { __setHSInputBufferOutPtr(_n) }

#define SetHSOutputBuffer(_offset, _cnt, _data) asm { __setHSOutputBuffer(_offset, _cnt, _data) }

#define SetHSOutputBufferInPtr(_n) asm { __setHSOutputBufferInPtr(_n) }
#define SetHSOutputBufferOutPtr(_n) asm { __setHSOutputBufferOutPtr(_n) }

#define SetUSBInputBuffer(_offset, _cnt, _data) asm { __setUSBInputBuffer(_offset, _cnt, _data) }

#define SetUSBInputBufferInPtr(_n) asm { __setUSBInputBufferInPtr(_n) }
#define SetUSBInputBufferOutPtr(_n) asm { __setUSBInputBufferOutPtr(_n) }

#define SetUSBOutputBuffer(_offset, _cnt, _data) asm { __setUSBOutputBuffer(_offset, _cnt, _data) }

#define SetUSBOutputBufferInPtr(_n) asm { __setUSBOutputBufferInPtr(_n) }
#define SetUSBOutputBufferOutPtr(_n) asm { __setUSBOutputBufferOutPtr(_n) }

#define SetUSBPollBuffer(_offset, _cnt, _data) asm { __setUSBPollBuffer(_offset, _cnt, _data) }

#define SetUSBPollBufferInPtr(_n) asm { __setUSBPollBufferInPtr(_n) }
#define SetUSBPollBufferOutPtr(_n) asm { __setUSBPollBufferOutPtr(_n) }

#define SetHSFlags(_n) asm { __setHSFlags(_n) }
#define SetHSSpeed(_n) asm { __setHSSpeed(_n) }
#define SetHSState(_n) asm { __setHSState(_n) }
#define SetUSBState(_n) asm { __setUSBState(_n) }
#define SetHSMode(_n) asm { __setHSMode(_n) }

#define SysMessageWrite(_args) asm { \
  compchktype _args, MessageWriteType \
  syscall MessageWrite, _args \
}
#define SysMessageRead(_args) asm { \
  compchktype _args, MessageReadType \
  syscall MessageRead, _args \
}
#define SysCommBTWrite(_args) asm { \
  compchktype _args, CommBTWriteType \
  syscall CommBTWrite, _args \
}
#define SysCommBTCheckStatus(_args) asm { \
  compchktype _args, CommBTCheckStatusType \
  syscall CommBTCheckStatus, _args \
}
#ifdef __ENHANCED_FIRMWARE
#define SysCommExecuteFunction(_args) asm { \
  compchktype _args, CommExecuteFunctionType \
  syscall CommExecuteFunction, _args \
}
#define SysCommHSControl(_args) asm { \
  compchktype _args, CommHSControlType \
  syscall CommHSControl, _args \
}
#define SysCommHSCheckStatus(_args) asm { \
  compchktype _args, CommHSCheckStatusType \
  syscall CommHSCheckStatus, _args \
}
#define SysCommHSRead(_args) asm { \
  compchktype _args, CommHSReadWriteType \
  syscall CommHSRead, _args \
}
#define SysCommHSWrite(_args) asm { \
  compchktype _args, CommHSReadWriteType \
  syscall CommHSWrite, _args \
}
#endif
#if __FIRMWARE_VERSION > 107
#define SysCommBTOnOff(_args) asm { \
  compchktype _args, CommBTOnOffType \
  syscall CommBTOnOff, _args \
}
#define SysCommBTConnection(_args) asm { \
  compchktype _args, CommBTConnectionType \
  syscall CommBTConnection, _args \
}
#endif

#endif
/** @} */ // end of CommModuleFunctions group
/** @} */ // end of CommModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// BUTTON MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup ButtonModule
 * @{
 */
/** @defgroup ButtonModuleTypes Button module types
 * Types used by various Button module functions.
 * @{
 */
/**
 * Parameters for the ReadButton system call.
 * This structure is used when calling the \ref SysReadButton system call
 * function.
 * \sa SysReadButton()
 */
struct ReadButtonType {
  char Result;   /*!< The function call result, \ref ERR_INVALID_PORT or \ref NO_ERR. */
  byte Index;    /*!< The requested button index. See the \ref ButtonNameConstants group. */
  bool Pressed;  /*!< The returned button state. */
  byte Count;    /*!< The returned button pressed count. */
  bool Reset;    /*!< If true, the count is reset after reading. */
};
/** @} */ // end of ButtonModuleTypes group
/** @defgroup ButtonModuleFunctions Button module functions
 * Functions for accessing and modifying Button module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Check for button press.
 * This function checks whether the specified button is pressed or not. You may
 * optionally reset the press count.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \param resetCount Whether or not to reset the press counter.
 * \return A boolean value indicating whether the button is pressed or not.
 */
inline bool ButtonPressed(const byte btn, bool resetCount);
/** \example ex_ButtonPressed.nxc
 * This is an example of how to use the \ref ButtonPressed function.
 */

/**
 * Get button press count.
 * Return the number of times the specified button has been pressed since
 * the last time the button press count was reset. Optionally clear the count
 * after reading it.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \param resetCount Whether or not to reset the press counter.
 * \return The button press count.
 */
inline byte ButtonCount(const byte btn, bool resetCount);
/** \example ex_ButtonCount.nxc
 * This is an example of how to use the \ref ButtonCount function.
 */

/**
 * Read button information.
 * Read the specified button. Set the pressed and count parameters with the
 * current state of the button. Optionally reset the press count after
 * reading it.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \param reset Whether or not to reset the press counter.
 * \param pressed The button pressed state.
 * \param count The button press count.
 * \return The function call result.
 */
inline char ReadButtonEx(const byte btn, bool reset, bool & pressed, unsigned int & count);
/** \example ex_ReadButtonEx.nxc
 * This is an example of how to use the \ref ReadButtonEx function.
 */

/**
 * Get button press count.
 * Return the press count of the specified button.
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button press count.
 */
inline byte ButtonPressCount(const byte btn);
/** \example ex_ButtonPressCount.nxc
 * This is an example of how to use the \ref ButtonPressCount function.
 */

/**
 * Get button long press count.
 * Return the long press count of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button long press count.
 */
inline byte ButtonLongPressCount(const byte btn);
/** \example ex_ButtonLongPressCount.nxc
 * This is an example of how to use the \ref ButtonLongPressCount function.
 */

/**
 * Get button short release count.
 * Return the short release count of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button short release count.
 */
inline byte ButtonShortReleaseCount(const byte btn);
/** \example ex_ButtonShortReleaseCount.nxc
 * This is an example of how to use the \ref ButtonShortReleaseCount function.
 */

/**
 * Get button long release count.
 * Return the long release count of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button long release count.
 */
inline byte ButtonLongReleaseCount(const byte btn);
/** \example ex_ButtonLongReleaseCount.nxc
 * This is an example of how to use the \ref ButtonLongReleaseCount function.
 */

/**
 * Get button release count.
 * Return the release count of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button release count.
*/
inline byte ButtonReleaseCount(const byte btn);
/** \example ex_ButtonReleaseCount.nxc
 * This is an example of how to use the \ref ButtonReleaseCount function.
 */

/**
 * Get button state.
 * Return the state of the specified button. See \ref ButtonStateConstants.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button state.
 */
inline byte ButtonState(const byte btn);
/** \example ex_ButtonState.nxc
 * This is an example of how to use the \ref ButtonState function.
 */

/**
 * Set button long press count.
 * Set the long press count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new long press count value.
 */
inline void SetButtonLongPressCount(const byte btn, const byte n);
/** \example ex_SetButtonLongPressCount.nxc
 * This is an example of how to use the \ref SetButtonLongPressCount function.
 */

/**
 * Set button long release count.
 * Set the long release count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new long release count value.
 */
inline void SetButtonLongReleaseCount(const byte btn, const byte n);
/** \example ex_SetButtonLongReleaseCount.nxc
 * This is an example of how to use the \ref SetButtonLongReleaseCount function.
 */

/**
 * Set button press count.
 * Set the press count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new press count value.
 */
inline void SetButtonPressCount(const byte btn, const byte n);
/** \example ex_SetButtonPressCount.nxc
 * This is an example of how to use the \ref SetButtonPressCount function.
 */

/**
 * Set button release count.
 * Set the release count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new release count value.
 */
inline void SetButtonReleaseCount(const byte btn, const byte n);
/** \example ex_SetButtonReleaseCount.nxc
 * This is an example of how to use the \ref SetButtonReleaseCount function.
 */

/**
 * Set button short release count.
 * Set the short release count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new short release count value.
 */
inline void SetButtonShortReleaseCount(const byte btn, const byte n);
/** \example ex_SetButtonShortReleaseCount.nxc
 * This is an example of how to use the \ref SetButtonShortReleaseCount function.
 */

/**
 * Set button state.
 * Set the state of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \param state The new button state. See \ref ButtonStateConstants.
*/
inline void SetButtonState(const byte btn, const byte state);
/** \example ex_SetButtonState.nxc
 * This is an example of how to use the \ref SetButtonState function.
 */

/**
 * Read button.
 * This function lets you read button state information via the \ref
 * ReadButtonType structure.
 *
 * \param args The ReadButtonType structure containing the needed parameters.
 */
inline void SysReadButton(ReadButtonType & args);
/** \example ex_sysreadbutton.nxc
 * This is an example of how to use the \ref SysReadButton function along with the
 * \ref ReadButtonType structure.
 */

#else

#define ButtonPressCount(_b) asm { GetButtonPressCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonLongPressCount(_b) asm { GetButtonLongPressCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonShortReleaseCount(_b) asm { GetButtonShortReleaseCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonLongReleaseCount(_b) asm { GetButtonLongReleaseCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonReleaseCount(_b) asm { GetButtonReleaseCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonState(_b) asm { GetButtonState(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SetButtonPressCount(_b, _n) asm { __setButtonPressCount(_b, _n) }
#define SetButtonLongPressCount(_b, _n) asm { __setButtonLongPressCount(_b, _n) }
#define SetButtonShortReleaseCount(_b, _n) asm { __setButtonShortReleaseCount(_b, _n) }
#define SetButtonLongReleaseCount(_b, _n) asm { __setButtonLongReleaseCount(_b, _n) }
#define SetButtonReleaseCount(_b, _n) asm { __setButtonReleaseCount(_b, _n) }
#define SetButtonState(_b, _n) asm { __setButtonState(_b, _n) }

#define SysReadButton(_args) asm { \
  compchktype _args, ReadButtonType \
  syscall ReadButton, _args \
}
#endif
/** @} */ // end of ButtonModuleFunctions group
/** @} */ // end of ButtonModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// UI MODULE //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup UiModule
 * @{
 */
/** @defgroup UiModuleTypes Ui module types
 * Types used by various Ui module functions.
 * @{
 */

#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the SetSleepTimeout system call.
 * This structure is used when calling the \ref SysSetSleepTimeout system call
 * function.
 * \sa SysSetSleepTimeout()
 */
struct SetSleepTimeoutType {
 char Result;                     /*!< The result of the system call function. */
 unsigned long TheSleepTimeoutMS; /*!< The new sleep timeout value in milliseconds. */
};
#endif

/** @} */ // end of UiModuleTypes group
/** @defgroup UiModuleFunctions Ui module functions
 * Functions for accessing and modifying Ui module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Get command flags.
 * Return the command flags.
 * \return Command flags. See \ref UiFlagsConstants
 */
inline byte CommandFlags(void);
/** \example ex_CommandFlags.nxc
 * This is an example of how to use the \ref CommandFlags function.
 */

/**
 * Get UI module state.
 * Return the user interface state.
 * \return The UI module state. See \ref UiStateConstants.
 */
inline byte UIState(void);
/** \example ex_UIState.nxc
 * This is an example of how to use the \ref UIState function.
 */

/**
 * Read UI button.
 * Return user interface button information.
 * \return A UI button value.  See \ref UiButtonConstants.
 */
inline byte UIButton(void);
/** \example ex_UIButton.nxc
 * This is an example of how to use the \ref UIButton function.
 */

/**
 * Read VM run state.
 * Return VM run state information.
 * \return VM run state. See \ref UiVMRunStateConstants.
 */
inline byte VMRunState(void);
/** \example ex_VMRunState.nxc
 * This is an example of how to use the \ref VMRunState function.
 */

/**
 * Get battery state.
 * Return battery state information (0..4).
 * \return The battery state (0..4)
 */
inline byte BatteryState(void);
/** \example ex_BatteryState.nxc
 * This is an example of how to use the \ref BatteryState function.
 */

/**
 * Get bluetooth state.
 * Return the bluetooth state.
 * \return The bluetooth state. See \ref UiBluetoothStateConstants.
 */
inline byte BluetoothState(void);
/** \example ex_BluetoothState.nxc
 * This is an example of how to use the \ref BluetoothState function.
 */

/**
 * Get UI module USB state.
 * This method returns the UI module USB state.
 * \return The UI module USB state.  (0=disconnected, 1=connected, 2=working)
 */
inline byte UsbState(void);
/** \example ex_UiUsbState.nxc
 * This is an example of how to use the \ref UsbState function.
 */

/**
 * Read sleep timeout.
 * Return the number of minutes that the NXT will remain on before
 * it automatically shuts down.
 * \return The sleep timeout value
 */
inline byte SleepTimeout(void);
/** \example ex_SleepTimeout.nxc
 * This is an example of how to use the \ref SleepTimeout function.
 */

/**
 * Read sleep time.
 * Return the number of minutes that the NXT will remain on before
 * it automatically shuts down.
 * \return The sleep time value
 * \sa SleepTimeout
 */
inline byte SleepTime(void);
/** \example ex_SleepTime.nxc
 * This is an example of how to use the \ref SleepTime function.
 */

/**
 * Read sleep timer.
 * Return the number of minutes left in the countdown to zero from the
 * original SleepTimeout value. When the SleepTimer value reaches zero the
 * NXT will shutdown.
 * \return The sleep timer value
 */
inline byte SleepTimer(void);
/** \example ex_SleepTimer.nxc
 * This is an example of how to use the \ref SleepTimer function.
 */

/**
 * Read battery type.
 * Return whether the NXT has a rechargeable battery installed or not.
 * \return Whether the battery is rechargeable or not. (false = no, true = yes)
 */
inline bool RechargeableBattery(void);
/** \example ex_RechargeableBattery.nxc
 * This is an example of how to use the \ref RechargeableBattery function.
 */

/**
 * Read volume.
 * Return the user interface volume level. Valid values are from 0 to 4.
 * \return The UI module volume. (0..4)
 */
inline byte Volume(void);
/** \example ex_Volume.nxc
 * This is an example of how to use the \ref Volume function.
 */

/**
 * Read the on brick program pointer value.
 * Return the current OBP (on-brick program) step
 *
 * \return On brick program pointer (step).
 */
inline byte OnBrickProgramPointer(void);
/** \example ex_OnBrickProgramPointer.nxc
 * This is an example of how to use the \ref OnBrickProgramPointer function.
 */

/**
 * Read abort flag.
 * Return the enhanced NBC/NXC firmware's abort flag.
 *
 * \return The current abort flag value.  See \ref ButtonStateConstants.
 * \warning This function requires the enhanced NBC/NXC firmware.
*/
inline byte AbortFlag(void);
/** \example ex_AbortFlag.nxc
 * This is an example of how to use the \ref AbortFlag function.
 */

/**
 * Read long abort setting.
 * Return the enhanced NBC/NXC firmware's long abort setting.
 *
 * \sa AbortFlag
 * \return The current abort flag value.  See \ref ButtonStateConstants.
 * \warning This function requires the enhanced NBC/NXC firmware.
*/
inline byte LongAbort(void);
/** \example ex_LongAbort.nxc
 * This is an example of how to use the \ref LongAbort function.
 */

/**
 * Get battery Level.
 * Return the battery level in millivolts.
 * \return The battery level
 */
inline unsigned int BatteryLevel(void);
/** \example util_battery_1.nxc
 * This is an example of how to use the \ref BatteryLevel function.
 */
/** \example util_battery_2.nxc
 * This is an example of how to use the \ref BatteryLevel function.
 */

/**
 * Set command flags.
 * Set the command flags.
 *
 * \param cmdFlags The new command flags. See \ref UiFlagsConstants.
 */
inline void SetCommandFlags(const byte cmdFlags);
/** \example ex_SetCommandFlags.nxc
 * This is an example of how to use the \ref SetCommandFlags function.
 */

/**
 * Set UI button.
 * Set user interface button information.
 *
 * \param btn A user interface button value. See \ref UiButtonConstants.
 */
inline void SetUIButton(byte btn);
/** \example ex_SetUIButton.nxc
 * This is an example of how to use the \ref SetUIButton function.
 */

/**
 * Set UI state.
 * Set the user interface state.
 *
 * \param state A user interface state value. See \ref UiStateConstants.
 */
inline void SetUIState(byte state);
/** \example ex_SetUIState.nxc
 * This is an example of how to use the \ref SetUIState function.
 */
 
/**
 * Set VM run state.
 * Set VM run state information.
 *
 * \param vmRunState The desired VM run state. See \ref UiVMRunStateConstants.
 */
inline void SetVMRunState(const byte vmRunState);
/** \example ex_SetVMRunState.nxc
 * This is an example of how to use the \ref SetVMRunState function.
 */

/**
 * Set battery state.
 * Set battery state information.
 *
 * \param state The desired battery state (0..4).
 */
inline void SetBatteryState(byte state);
/** \example ex_SetBatteryState.nxc
 * This is an example of how to use the \ref SetBatteryState function.
 */

/**
 * Set bluetooth state.
 * Set the Bluetooth state.
 *
 * \param state The desired bluetooth state. See \ref UiBluetoothStateConstants.
 */
inline void SetBluetoothState(byte state);
/** \example ex_SetBluetoothState.nxc
 * This is an example of how to use the \ref SetBluetoothState function.
 */

/**
 * Set sleep timeout.
 * Set the NXT sleep timeout value to the specified number of minutes.
 *
 * \param n The minutes to wait before sleeping.
 */
inline void SetSleepTimeout(const byte n);
/** \example ex_SetSleepTimeout.nxc
 * This is an example of how to use the \ref SetSleepTimeout function.
 */

/**
 * Set sleep time.
 * Set the NXT sleep timeout value to the specified number of minutes.
 *
 * \param n The minutes to wait before sleeping.
 * \sa SetSleepTimeout, SleepTimeout
 */
inline void SetSleepTime(const byte n);
/** \example ex_SetSleepTime.nxc
 * This is an example of how to use the \ref SetSleepTime function.
 */

/**
 * Set the sleep timer.
 * Set the system sleep timer to the specified number of minutes.
 *
 * \param n The minutes left on the timer.
 */
inline void SetSleepTimer(const byte n);
/** \example ex_SetSleepTimer.nxc
 * This is an example of how to use the \ref SetSleepTimer function.
 */

/**
 * Set volume.
 * Set the user interface volume level. Valid values are from 0 to 4.
 *
 * \param volume The new volume level.
 */
inline void SetVolume(byte volume);
/** \example ex_SetVolume.nxc
 * This is an example of how to use the \ref SetVolume function.
 */

/**
 * Set on-brick program pointer.
 * Set the current OBP (on-brick program) step.
 *
 * \param obpStep The new on-brick program step.
 */
inline void SetOnBrickProgramPointer(byte obpStep);
/** \example ex_SetOnBrickProgramPointer.nxc
 * This is an example of how to use the \ref SetOnBrickProgramPointer function.
 */

/**
 * Turn off NXT.
 * Force the NXT to turn off if the specified value is greater than zero.
 * \param num If greater than zero the NXT will turn off.
*/
inline void ForceOff(byte num);
/** \example ex_ForceOff.nxc
 * This is an example of how to use the \ref ForceOff function.
 */

/**
 * Set abort flag.
 * Set the enhanced NBC/NXC firmware's program abort flag. By default the
 * running program can be interrupted by a short press of the escape button.
 * You can change this to any other button state flag.
 *
 * \param abortFlag The new abort flag value. See \ref ButtonStateConstants
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SetAbortFlag(byte abortFlag);
/** \example ex_SetAbortFlag.nxc
* This is an example of how to use the \ref SetAbortFlag function.
*/

/**
 * Set long abort.
 * Set the enhanced NBC/NXC firmware's long abort setting (true or false). If
 * set to true then a program has access the escape button. Aborting a program
 * requires a long press of the escape button.
 *
 * \param longAbort If true then require a long press of the escape button
 * to abort a program, otherwise a short press will abort it.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SetLongAbort(bool longAbort);
/** \example ex_SetLongAbort.nxc
* This is an example of how to use the \ref SetLongAbort function.
*/

#if __FIRMWARE_VERSION > 107
/**
 * Set system sleep timeout.
 * This function lets you set the system sleep timeout value given the parameters you
 * pass in via the \ref SetSleepTimeoutType structure.
 *
 * \param args The SetSleepTimeoutType structure containing the required parameters.
 * 
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysSetSleepTimeout(SetSleepTimeoutType & args);
/** \example ex_SysSetSleepTimeout.nxc
* This is an example of how to use the \ref SysSetSleepTimeout function.
*/
#endif

#else

#define CommandFlags() asm { GetCommandFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define UIState() asm { GetUIState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define UIButton() asm { GetUIButton(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define VMRunState() asm { GetVMRunState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BatteryState() asm { GetBatteryState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BluetoothState() asm { GetBluetoothState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define UsbState() asm { GetUsbState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SleepTimeout() asm { GetSleepTimeout(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SleepTime() SleepTimeout()
#define SleepTimer() asm { GetSleepTimer(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define RechargeableBattery() asm { GetRechargeableBattery(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define Volume() asm { GetVolume(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define OnBrickProgramPointer() asm { GetOnBrickProgramPointer(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define AbortFlag() asm { GetAbortFlag(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LongAbort() AbortFlag()
#define BatteryLevel() asm { GetBatteryLevel(__TMPWORD__) __RETURN__ __TMPWORD__ }

#define SetCommandFlags(_n) asm { __setCommandFlags(_n) }
#define SetUIState(_n) asm { __setUIState(_n) }
#define SetUIButton(_n) asm { __setUIButton(_n) }
#define SetVMRunState(_n) asm { __setVMRunState(_n) }
#define SetBatteryState(_n) asm { __setBatteryState(_n) }
#define SetBluetoothState(_n) asm { __setBluetoothState(_n) }
#define SetUsbState(_n) asm { __setUsbState(_n) }
#define SetSleepTimeout(_n) asm { __setSleepTimeout(_n) }
#define SetSleepTime(_n) SetSleepTimeout(_n)
#define SetSleepTimer(_n) asm { __setSleepTimer(_n) }
#define SetVolume(_n) asm { __setVolume(_n) }
#define SetOnBrickProgramPointer(_n) asm { __setOnBrickProgramPointer(_n) }
#define ForceOff(_n) asm { __forceOff(_n) }
#define SetAbortFlag(_n) asm { __setAbortFlag(_n) }
#define SetLongAbort(_n) do { \
  if (_n) { \
    asm { __setAbortFlag(BTNSTATE_LONG_PRESSED_EV) } \
  } else { \
    asm { __setAbortFlag(BTNSTATE_PRESSED_EV) } \
  } \
} while(false)

#if __FIRMWARE_VERSION > 107
#define SysSetSleepTimeout(_args) asm { \
  compchktype _args, SetSleepTimeoutType \
  syscall SetSleepTimeoutVal, _args \
}
#endif

#endif
/** @} */ // end of UiModuleFunctions group
/** @} */ // end of UiModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// LOADER MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup LoaderModule
 * @{
 */
/** @defgroup LoaderModuleTypes Loader module types
 * Types used by various Loader module functions.
 * @{
 */
/**
 * Parameters for the FileOpen system call.
 * This structure is used when calling the \ref SysFileOpenAppend, \ref
 * SysFileOpenRead, \ref SysFileOpenWrite, \ref SysFileOpenReadLinear,
 * \ref SysFileOpenWriteLinear and \ref SysFileOpenWriteNonLinear system call
 * functions.
 * \sa SysFileOpenAppend(), SysFileOpenRead(), SysFileOpenWrite(),
 * SysFileOpenReadLinear(), SysFileOpenWriteLinear()
 */
struct FileOpenType {
  unsigned int Result;    /*!< The function call result. Possible values
                            include \ref LoaderErrors. */
  byte FileHandle;        /*!< The returned file handle to use for subsequent
                            file operations. */
  string Filename;        /*!< The name of the file to open or create. */
  unsigned long Length;   /*!< For SysFileOpenWrite(),
                            SysFileOpenWriteLinear() and
                            SysFileOpenWriteNonLinear(): the desired maximum
                            file capacity.

                            For SysFileOpenAppend(), SysFileOpenRead() and
                            SysFileOpenReadLinear(): the returned available
                            length in the file. */
};

/**
 * Parameters for the FileReadWrite system call.
 * This structure is used when calling the \ref SysFileRead and \ref SysFileWrite
 * system call functions.
 * \sa SysFileRead() and SysFileWrite()
 */
struct FileReadWriteType {
  unsigned int Result;    /*!< The function call result. Possible values
                            include \ref LoaderErrors. */
  byte FileHandle;        /*!< The file handle to access. */
  string Buffer;          /*!< The buffer to store read bytes or containing
                            bytes to write. */
  unsigned long Length;   /*!< The number of bytes to read or the returned
                            number of bytes written. */
};

/**
 * Parameters for the FileClose system call.
 * This structure is used when calling the \ref SysFileClose system call function.
 * \sa SysFileClose()
 */
struct FileCloseType {
  unsigned int Result;   /*!< The function call result. Possible values
                           include \ref LoaderErrors. */
  byte FileHandle;       /*!< The file handle to close. */
};

/**
 * Parameters for the FileResolveHandle system call.
 * This structure is used when calling the \ref SysFileResolveHandle system
 * call function.
 * \sa SysFileResolveHandle()
 */
struct FileResolveHandleType {
  unsigned int Result;   /*!< The function call result. Possible values
                           include \ref LDR_HANDLEALREADYCLOSED and \ref LDR_SUCCESS. */
  byte FileHandle;       /*!< The returned resolved file handle. */
  bool WriteHandle;      /*!< True if the returned handle is a write handle. */
  string Filename;       /*!< The name of the file for which to resolve a handle. */
};

/**
 * Parameters for the FileRename system call.
 * This structure is used when calling the \ref SysFileRename system call
 * function.
 * \sa SysFileRename()
 */
struct FileRenameType {
  unsigned int Result;   /*!< The function call result. Possible values
                           include \ref LoaderErrors. */
  string OldFilename;    /*!< The name of the file to be renamed. */
  string NewFilename;    /*!< The new name to give to the file. */
};

/**
 * Parameters for the FileDelete system call.
 * This structure is used when calling the \ref SysFileDelete system call
 * function.
 * \sa SysFileDelete()
 */
struct FileDeleteType {
  unsigned int Result;   /*!< The function call result. Possible values
                           include \ref LoaderErrors. */
  string Filename;       /*!< The name of the file to delete. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the LoaderExecuteFunction system call.
 * This structure is used when calling the \ref SysLoaderExecuteFunction
 * system call function.
 *
 * The fields usage depends on the requested command and are documented in the
 * table below.
 *
 * <table>
 * <tr><td>Cmd</td>
 *     <td>Meaning</td><td>Expected Parameters</td></tr>
 * <tr><td>LDR_CMD_OPENREAD</td>
 *     <td>Open a file for reading</td><td>(Filename, Length)</td></tr>
 * <tr><td>LDR_CMD_OPENWRITE</td>
 *     <td>Create a file</td><td>(Filename, Length)</td></tr>
 * <tr><td>LDR_CMD_READ</td>
 *     <td>Read from a file</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_WRITE</td>
 *     <td>Write to a file</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_CLOSE</td>
 *     <td>Close a file</td><td>(Filename)</td></tr>
 * <tr><td>LDR_CMD_DELETE</td>
 *     <td>Delete a file</td><td>(Filename)</td></tr>
 * <tr><td>LDR_CMD_FINDFIRST</td>
 *     <td>Start iterating files</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_FINDNEXT</td>
 *     <td>Continue iterating files</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_OPENWRITELINEAR</td>
 *     <td>Create a linear file</td><td>(Filename, Length)</td></tr>
 * <tr><td>LDR_CMD_OPENREADLINEAR</td>
 *     <td>Read a linear file</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_OPENAPPENDDATA</td>
 *     <td>Open a file for writing</td><td>(Filename, Length)</td></tr>
 * <tr><td>LDR_CMD_FINDFIRSTMODULE</td>
 *     <td>Start iterating modules</td><td>(Filename, Buffer)</td></tr>
 * <tr><td>LDR_CMD_FINDNEXTMODULE</td>
 *     <td>Continue iterating modules</td><td>(Buffer)</td></tr>
 * <tr><td>LDR_CMD_CLOSEMODHANDLE</td>
 *     <td>Close module handle</td><td>()</td></tr>
 * <tr><td>LDR_CMD_IOMAPREAD</td>
 *     <td>Read IOMap data</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_IOMAPWRITE</td>
 *     <td>Write IOMap data</td><td>(Filename, Buffer, Length)</td></tr>
 * <tr><td>LDR_CMD_DELETEUSERFLASH</td>
 *     <td>Delete all files</td><td>()</td></tr>
 * <tr><td>LDR_CMD_RENAMEFILE</td>
 *     <td>Rename file</td><td>(Filename, Buffer, Length)</td></tr>
 * </table>
 *
 * \sa SysLoaderExecuteFunction()
 */
struct LoaderExecuteFunctionType {
  unsigned int Result;    /*!< The function call result. Possible values
                            include \ref LoaderErrors. */
  byte Cmd;               /*!< The command to execute. */
  string Filename;        /*!< The Filename parameter, see table. */
  byte Buffer[];          /*!< The Buffer parameter, see table. */
  unsigned long Length;   /*!< The Length parameter, see table. */
};

/**
 * Parameters for the FileFind system call.
 * This structure is used when calling the \ref SysFileFindFirst and \ref
 * SysFileFindNext system call functions.
 * \sa SysFileFindFirst() and SysFileFindNext()
 */
struct FileFindType {
  unsigned int Result;    /*!< The function call result. Possible values
                            include \ref LoaderErrors. */
  byte FileHandle;        /*!< The returned file handle to be used to continue
                            iterations. Close it after usage. */
  string Filename;        /*!< The pattern to match file name, then the
                            returned found file name. */
  unsigned long Length;   /*!< The found file length. */
};

#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the FileSeek system call.
 * This structure is used when calling the \ref SysFileSeek system call function.
 * \sa SysFileSeek()
 */
struct FileSeekType {
 unsigned int Result; /*!< The function call result. Possible values include
                        \ref LoaderErrors. */
 byte FileHandle;     /*!< The handle of the file to seek in. */
 byte Origin;         /*!< The origin of the file seek operation. See \ref fseekConstants. */
 long Length;         /*!< The offset from the origin to seek to. */
};

/**
 * Parameters for the FileResize system call.
 * This structure is used when calling the \ref SysFileResize system call function.
 * \sa SysFileResize()
 */
struct FileResizeType {
 unsigned int Result;   /*!< The function call result. Possible values include
                         \ref LoaderErrors. */
 byte FileHandle;       /*!< The handle of the file to resize. */
 unsigned int NewSize;  /*!< The new file size. */
};

#endif
#endif
#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the ListFiles system call.
 * This structure is used when calling the \ref SysListFiles system call function.
 * \sa SysListFiles()
 */
struct ListFilesType {
 char Result;       /*!< The function call result. Possible values include
                         \ref LoaderErrors. */
 string Pattern;    /*!< The file search pattern. */
 string FileList[]; /*!< An array of strings containing the list of filenames
                         that matched the file search pattern. */
};
#endif
/** @} */ // end of LoaderModuleTypes group
/** @defgroup LoaderModuleFunctions Loader module functions
 * Functions for accessing and modifying Loader module features.
 * @{
 */
#ifdef __DOXYGEN_DOCS

/**
 * Get free flash memory.
 * Get the number of bytes of flash memory that are available for use.
 * \return The number of bytes of unused flash memory.
 */
inline unsigned int FreeMemory(void);
/** \example ex_FreeMemory.nxc
 * This is an example of how to use the \ref FreeMemory function.
 */

/**
 * Create a file.
 * Create a new file with the specified filename and size and open it for
 * writing. The file handle is returned in the last parameter, which must be a
 * variable. The loader result code is returned as the value of the function
 * call. The filename and size parameters must be constants, constant
 * expressions, or variables. A file created with a size of zero bytes cannot
 * be written to since the NXC file writing functions do not grow the file if
 * its capacity is exceeded during a write attempt.
 *
 * \param fname The name of the file to create.
 * \param fsize The size of the file.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int CreateFile(string fname, unsigned int fsize, byte & handle);
/** \example ex_CreateFile.nxc
 * This is an example of how to use the \ref CreateFile function.
 */

/**
 * Open a file for appending.
 * Open an existing file with the specified filename for writing. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call.
 * The filename parameter must be a constant or a variable.
 *
 * \param fname The name of the file to open.
 * \param fsize The size of the file returned by the function.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int OpenFileAppend(string fname, unsigned int & fsize, byte & handle);
/** \example ex_OpenFileAppend.nxc
 * This is an example of how to use the \ref OpenFileAppend function.
 */

/**
 * Open a file for reading.
 * Open an existing file with the specified filename for reading. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param fname The name of the file to open.
 * \param fsize The size of the file returned by the function.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int OpenFileRead(string fname, unsigned int & fsize, byte & handle);
/** \example ex_OpenFileRead.nxc
 * This is an example of how to use the \ref OpenFileRead function.
 */

/**
 * Close a file.
 * Close the file associated with the specified file handle. The loader
 * result code is returned as the value of the function call. The handle
 * parameter must be a constant or a variable.
 *
 * \param handle The file handle.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int CloseFile(byte handle);
/** \example ex_CloseFile.nxc
 * This is an example of how to use the \ref CloseFile function.
 */

/**
 * Resolve a handle.
 * Resolve a file handle from the specified filename. The file handle is
 * returned in the second parameter, which must be a variable. A boolean
 * value indicating whether the handle can be used to write to the file or
 * not is returned in the last parameter, which must be a variable. The
 * loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param filename The name of the file for which to resolve a handle.
 * \param handle The file handle output from the function call.
 * \param writeable A boolean flag indicating whether the handle is
 * to a file open for writing (true) or reading (false).
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ResolveHandle(string filename, byte & handle, bool & writeable);
/** \example ex_ResolveHandle.nxc
 * This is an example of how to use the \ref ResolveHandle function.
 */

/**
 * Rename a file.
 * Rename a file from the old filename to the new filename. The loader
 * result code is returned as the value of the function call. The filename
 * parameters must be constants or variables.
 */
inline unsigned int RenameFile(string oldname, string newname);
/** \example ex_RenameFile.nxc
 * This is an example of how to use the \ref RenameFile function.
 */

/**
 * Delete a file.
 * Delete the specified file. The loader result code is returned as the
 * value of the function call. The filename parameter must be a constant or a
 * variable.
 *
 * \param fname The name of the file to delete.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int DeleteFile(string fname);
/** \example ex_DeleteFile.nxc
 * This is an example of how to use the \ref DeleteFile function.
 */

/**
 * Resize a file.
 * Resize the specified file. The loader result code is returned as the
 * value of the function call. The filename parameter must be a constant or a
 * variable.
 *
 * \param fname The name of the file to resize.
 * \param newsize The new size for the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ResizeFile(string fname, const unsigned int newsize);
/** \example ex_ResizeFile.nxc
 * This is an example of how to use the \ref ResizeFile function.
 */

#ifdef __ENHANCED_FIRMWARE
/**
 * Create a linear file.
 * Create a new linear file with the specified filename and size and open it for
 * writing. The file handle is returned in the last parameter, which must be a
 * variable. The loader result code is returned as the value of the function
 * call. The filename and size parameters must be constants, constant
 * expressions, or variables. A file created with a size of zero bytes cannot
 * be written to since the NXC file writing functions do not grow the file if
 * its capacity is exceeded during a write attempt.
 *
 * \param fname The name of the file to create.
 * \param fsize The size of the file.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int CreateFileLinear(string fname, unsigned int fsize, byte & handle);
/** \example ex_CreateFileLinear.nxc
 * This is an example of how to use the \ref CreateFileLinear function.
 */

/**
 * Create a non-linear file.
 * Create a new non-linear file with the specified filename and size and open it for
 * writing. The file handle is returned in the last parameter, which must be a
 * variable. The loader result code is returned as the value of the function
 * call. The filename and size parameters must be constants, constant
 * expressions, or variables. A file created with a size of zero bytes cannot
 * be written to since the NXC file writing functions do not grow the file if
 * its capacity is exceeded during a write attempt.
 *
 * \param fname The name of the file to create.
 * \param fsize The size of the file.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int CreateFileNonLinear(string fname, unsigned int fsize, byte & handle);
/** \example ex_CreateFileNonLinear.nxc
 * This is an example of how to use the \ref CreateFileNonLinear function.
 */

/**
 * Open a linear file for reading.
 * Open an existing linear file with the specified filename for reading. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param fname The name of the file to open.
 * \param fsize The size of the file returned by the function.
 * \param handle The file handle output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int OpenFileReadLinear(string fname, unsigned int & fsize, byte & handle);
/** \example ex_OpenFileReadLinear.nxc
 * This is an example of how to use the \ref OpenFileReadLinear function.
 */

/**
 * Start searching for files.
 * This function lets you begin iterating through files stored on the NXT.
 *
 * \param fname On input this contains the filename pattern you are searching
 * for. On output this contains the name of the first file found that matches
 * the pattern.
 * \param handle The search handle input to and output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int FindFirstFile(string & fname, byte & handle);
/** \example ex_FindFirstFile.nxc
 * This is an example of how to use the \ref FindFirstFile function.
 */

/**
 * Continue searching for files.
 * This function lets you continue iterating through files stored on the NXT.
 *
 * \param fname On output this contains the name of the next file found that
 * matches the pattern used when the search began by calling \ref FindFirstFile.
 * \param handle The search handle input to and output from the function call.
 * \return The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline unsigned int FindNextFile(string & fname, byte & handle);
/** \example ex_FindNextFile.nxc
 * This is an example of how to use the \ref FindNextFile function.
 */

#endif

/**
 * Read a value from a file.
 * Read a value from the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * variable. The type of the value parameter determines the number of bytes of
 * data read.
 *
 * \param handle The file handle. 
 * \param value The variable to store the data read from the file.
 * \return The function call result. See \ref LoaderErrors. 
 */
inline unsigned int Read(byte handle, variant & value);
/** \example ex_Read.nxc
 * This is an example of how to use the \ref Read function.
 */

/**
 * Read a value from a file plus line ending.
 * Read a value from the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * variable. The type of the value parameter determines the number of bytes
 * of data read. The ReadLn function reads two additional bytes from the
 * file which it assumes are a carriage return and line feed pair.
 *
 * \param handle The file handle.
 * \param value The variable to store the data read from the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ReadLn(byte handle, variant & value);
/** \example ex_ReadLn.nxc
 * This is an example of how to use the \ref ReadLn function.
 */

/**
 * Read bytes from a file.
 * Read the specified number of bytes from the file associated with the
 * specified handle. The handle parameter must be a variable. The length
 * parameter must be a variable. The buf parameter must be an array or a
 * string variable. The actual number of bytes read is returned in the
 * length parameter.
 *
 * \param handle The file handle.
 * \param length The number of bytes to read. Returns the number of bytes actually read.
 * \param buf The byte array where the data is stored on output.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ReadBytes(byte handle, unsigned int & length, byte & buf[]);
/** \example ex_ReadBytes.nxc
 * This is an example of how to use the \ref ReadBytes function.
 */

/**
 * Read a string from a file plus line ending.
 * Read a string from the file associated with the specified handle.
 * The handle parameter must be a variable. The output parameter must be a
 * variable. Appends bytes to the output variable until a line ending (CRLF)
 * is reached. The line ending is also read but it is not appended to the
 * output parameter.
 *
 * \param handle The file handle.
 * \param output The variable to store the string read from the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int ReadLnString(byte handle, string & output);

/**
 * Write value to file.
 * Write a value to the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * constant, a constant expression, or a variable. The type of the value
 * parameter determines the number of bytes of data written.
 *
 * \param handle The file handle.
 * \param value The value to write to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int Write(byte handle, const variant & value);
/** \example ex_Write.nxc
 * This is an example of how to use the \ref Write function.
 */

/**
 * Write bytes to file.
 * Write the contents of the data array to the file associated with the
 * specified handle. The handle parameter must be a variable. The cnt
 * parameter must be a variable. The data parameter must be a byte array. The
 * actual number of bytes written is returned in the cnt parameter.
 *
 * \param handle The file handle.
 * \param buf The byte array or string containing the data to write.
 * \param cnt The number of bytes actually written to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteBytes(byte handle, const byte & buf[], unsigned int & cnt);
/** \example ex_WriteBytes.nxc
 * This is an example of how to use the \ref WriteBytes function.
 */

/**
 * Write bytes to a file with limit.
 * Write the specified number of bytes to the file associated with the
 * specified handle. The handle parameter must be a variable. The len
 * parameter must be a variable. The buf parameter must be a byte array or a
 * string variable or string constant. The actual number of bytes written is
 * returned in the len parameter.
 *
 * \param handle The file handle.
 * \param len The maximum number of bytes to write on input.  Returns the
 * actual number of bytes written.
 * \param buf The byte array or string containing the data to write.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteBytesEx(byte handle, unsigned int & len, const byte & buf[]);
/** \example ex_WriteBytesEx.nxc
 * This is an example of how to use the \ref WriteBytesEx function.
 */

/**
 * Write a value and new line to a file.
 * Write a value to the file associated with the specified handle. The
 * handle parameter must be a variable. The value parameter must be a constant,
 * a constant expression, or a variable. The type of the value parameter
 * determines the number of bytes of data written. This function also
 * writes a carriage return and a line feed to the file following the numeric
 * data.
 *
 * \param handle The file handle.
 * \param value The value to write to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteLn(byte handle, const variant & value);
/** \example ex_WriteLn.nxc
 * This is an example of how to use the \ref WriteLn function.
 */

/**
 * Write string and new line to a file.
 * Write the string to the file associated with the specified handle. The
 * handle parameter must be a variable. The count parameter must be a variable.
 * The str parameter must be a string variable or string constant. This
 * function also writes a carriage return and a line feed to the file following
 * the string data. The total number of bytes written is returned in the
 * cnt parameter.
 *
 * \param handle The file handle.
 * \param str The string to write to the file.
 * \param cnt The number of bytes actually written to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteLnString(byte handle, const string & str, unsigned int & cnt);
/** \example ex_WriteLnString.nxc
 * This is an example of how to use the \ref WriteLnString function.
 */

/**
 * Write string to a file.
 * Write the string to the file associated with the specified handle. The
 * handle parameter must be a variable. The count parameter must be a variable.
 * The str parameter must be a string variable or string constant. The actual
 * number of bytes written is returned in the cnt parameter.
 *
 * \param handle The file handle.
 * \param str The string to write to the file.
 * \param cnt The number of bytes actually written to the file.
 * \return The function call result. See \ref LoaderErrors.
 */
inline unsigned int WriteString(byte handle, const string & str, unsigned int & cnt);
/** \example ex_WriteString.nxc
 * This is an example of how to use the \ref WriteString function.
 */

/**
 * Open file for reading.
 * This function lets you open an existing file for reading using the values
 * specified via the \ref FileOpenType structure.
 *
 * The number of bytes that can be read from the file is returned via the
 * Length member.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 */
inline void SysFileOpenRead(FileOpenType & args);
/** \example ex_sysfileopenread.nxc
 * This is an example of how to use the \ref SysFileOpenRead function along with
 * the \ref FileOpenType structure.
 */

/**
 * Open and create file for writing.
 * This function lets you create a file that you can write to using the values
 * specified via the \ref FileOpenType structure.
 *
 * The desired maximum file capacity in bytes is specified via the Length
 * member.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 */
inline void SysFileOpenWrite(FileOpenType & args);
/** \example ex_sysfileopenwrite.nxc
 * This is an example of how to use the \ref SysFileOpenWrite function along with
 * the \ref FileOpenType structure.
 */

/**
 * Open file for writing at end of file.
 * This function lets you open an existing file that you can write to using
 * the values specified via the \ref FileOpenType structure.
 *
 * The available length remaining in the file is returned via the Length
 * member.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 */
inline void SysFileOpenAppend(FileOpenType & args);
/** \example ex_sysfileopenappend.nxc
 * This is an example of how to use the \ref SysFileOpenAppend function along with
 * the \ref FileOpenType structure.
 */

/**
 * Read from file.
 * This function lets you read from a file using the values specified via the
 * \ref FileReadWriteType structure.
 *
 * \param args The FileReadWriteType structure containing the needed
 * parameters.
 */
inline void SysFileRead(FileReadWriteType & args);
/** \example ex_sysfileread.nxc
 * This is an example of how to use the \ref SysFileRead function along with the
 * \ref FileReadWriteType structure.
 */

/**
 * File write.
 * This function lets you write to a file using the values specified via the
 * \ref FileReadWriteType structure.
 *
 * \param args The FileReadWriteType structure containing the needed
 * parameters.
 */
inline void SysFileWrite(FileReadWriteType & args);
/** \example ex_sysfilewrite.nxc
 * This is an example of how to use the \ref SysFileWrite function along with the
 * \ref FileReadWriteType structure.
 */

/**
 * Close file handle.
 * This function lets you close a file using the values specified via the \ref
 * FileCloseType structure.
 *
 * \param args The FileCloseType structure containing the needed parameters.
 */
inline void SysFileClose(FileCloseType & args);
/** \example ex_sysfileclose.nxc
 * This is an example of how to use the \ref SysFileClose function along with the
 * \ref FileCloseType structure.
 */

/**
 * File resolve handle.
 * This function lets you resolve the handle of a file using the values
 * specified via the \ref FileResolveHandleType structure.  This will find a
 * previously opened file handle.
 *
 * \param args The FileResolveHandleType structure containing the needed
 * parameters.
 */
inline void SysFileResolveHandle(FileResolveHandleType & args);
/** \example ex_sysfileresolvehandle.nxc
 * This is an example of how to use the \ref SysFileResolveHandle function along
 * with the \ref FileResolveHandleType structure.
 */

/**
 * Rename file.
 * This function lets you rename a file using the values specified via the
 * \ref FileRenameType structure.
 *
 * \param args The FileRenameType structure containing the needed parameters.
 */
inline void SysFileRename(FileRenameType & args);
/** \example ex_sysfilerename.nxc
 * This is an example of how to use the \ref SysFileRename function along with the
 * \ref FileRenameType structure.
 */

/**
 * Delete file.
 * This function lets you delete a file using the values specified via the
 * \ref FileDeleteType structure.
 *
 * \param args The FileDeleteType structure containing the needed parameters.
 */
inline void SysFileDelete(FileDeleteType & args);
/** \example ex_sysfiledelete.nxc
 * This is an example of how to use the \ref SysFileDelete function along with the
 * \ref FileDeleteType structure.
 */

#ifdef __ENHANCED_FIRMWARE
/**
 * Execute any Loader module command.
 * This function lets you directly execute the Loader module's primary
 * function using the values specified via the \ref LoaderExecuteFunctionType
 * structure.
 *
 * \param args The LoaderExecuteFunctionType structure containing the needed
 * parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysLoaderExecuteFunction(LoaderExecuteFunctionType & args);
/** \example ex_sysloaderexecutefunction.nxc
 * This is an example of how to use the \ref SysLoaderExecuteFunction function
 * along with the \ref LoaderExecuteFunctionType structure.
 */

/**
 * Start finding files.
 * This function lets you begin iterating through files stored on the NXT.
 *
 * \param args The FileFindType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileFindFirst(FileFindType & args);
/** \example ex_sysfilefindfirst.nxc
 * This is an example of how to use the \ref SysFileFindFirst function along with
 * the \ref FileFindType structure.
 */

/**
 * Continue finding files.
 * This function lets you continue iterating through files stored on the NXT.
 *
 * \param args The FileFindType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileFindNext(FileFindType & args);
/** \example ex_sysfilefindnext.nxc
 * This is an example of how to use the \ref SysFileFindNext function along with
 * the \ref FileFindType structure.
 */

/**
 * Open and create linear file for writing.
 * This function lets you create a linear file that you can write to using the
 * values specified via the \ref FileOpenType structure.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileOpenWriteLinear(FileOpenType & args);
/** \example ex_sysfileopenwritelinear.nxc
 * This is an example of how to use the \ref SysFileOpenWriteLinear function along
 * with the \ref FileOpenType structure.
 */

/**
 * Open and create non-linear file for writing.
 * This function lets you create a non-linear linear file that you can write
 * to using the values specified via the \ref FileOpenType structure.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileOpenWriteNonLinear(FileOpenType & args);
/** \example ex_sysfileopenwritenonlinear.nxc
 * This is an example of how to use the \ref SysFileOpenWriteNonLinear function
 * along with the \ref FileOpenType structure.
 */

/**
 * Open linear file for reading.
 * This function lets you open an existing linear file for reading using the
 * values specified via the \ref FileOpenType structure.
 *
 * \param args The FileOpenType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileOpenReadLinear(FileOpenType & args);
/** \example ex_sysfileopenreadlinear.nxc
 * This is an example of how to use the \ref SysFileOpenReadLinear function along
 * with the \ref FileOpenType structure.
 */

#if __FIRMWARE_VERSION > 107
/**
 * Seek to file position.
 * This function lets you seek to a specific file position using the
 * values specified via the \ref FileSeekType structure.
 *
 * \param args The FileSeekType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 */
inline void SysFileSeek(FileSeekType & args);
/** \example ex_sysfileseek.nxc
 * This is an example of how to use the \ref SysFileSeek function along
 * with the \ref FileSeekType structure.
 */

/**
 * Resize a file.
 * This function lets you resize a file using the
 * values specified via the \ref FileResizeType structure.
 *
 * \param args The FileResizeType structure containing the needed parameters.
 *
 * \warning This function requires the extended firmware.
 * It has not yet been implemented at the firmware level.
 */
inline void SysFileResize(FileResizeType & args);
/** \example ex_sysfileresize.nxc
 * This is an example of how to use the \ref SysFileResize function along
 * with the \ref FileResizeType structure.
 */

#endif
#endif
#if __FIRMWARE_VERSION > 107
/**
 * List files.
 * This function lets you retrieve a list of files on the NXT using the
 * values specified via the \ref ListFilesType structure.
 *
 * \param args The ListFilesType structure containing the needed parameters.
 */
inline void SysListFiles(ListFilesType & args);
/** \example ex_syslistfiles.nxc
 * This is an example of how to use the \ref SysListFiles function along
 * with the \ref ListFilesType structure.
 */

#endif

#else

#define FreeMemory() asm { GetFreeMemory(__RETVAL__) }

#define CreateFile(_fname, _fsize, _handle) asm { __createFile(_fname, _fsize, _handle, __RETVAL__) }
#define OpenFileAppend(_fname, _fsize, _handle) asm { __openFileAppend(_fname, _fsize, _handle, __RETVAL__) }
#define OpenFileRead(_fname, _fsize, _handle) asm { __openFileRead(_fname, _fsize, _handle, __RETVAL__) }
#define CloseFile(_handle) asm { __closeFile(_handle, __RETVAL__) }
#define ResolveHandle(_fname, _handle, _writeable) asm { __resolveHandle(_fname, _handle, _writeable, __RETVAL__) }
#define RenameFile(_oldname, _newname) asm { __renameFile(_oldname, _newname, __RETVAL__) }
#define DeleteFile(_fname) asm { __deleteFile(_fname, __RETVAL__) }
#define ResizeFile(_fname, _newsize) asm { __fileResize(_fname, _newsize, __RETVAL__) }

#ifdef __ENHANCED_FIRMWARE
#define CreateFileLinear(_fname, _fsize, _handle) asm { __createFileLinear(_fname, _fsize, _handle, __RETVAL__) }
#define CreateFileNonLinear(_fname, _fsize, _handle) asm { __createFileNonLinear(_fname, _fsize, _handle, __RETVAL__) }
#define OpenFileReadLinear(_fname, _fsize, _handle) asm { __openFileReadLinear(_fname, _fsize, _handle, __RETVAL__) }
#define FindFirstFile(_fname, _handle) asm { __findFirstFile(_fname, _handle, __RETVAL__) }
#define FindNextFile(_fname, _handle) asm { __findNextFile(_fname, _handle, __RETVAL__) }
#endif

#define Read(_handle, _n) asm { __readValue(_handle, _n, __RETVAL__) }
#define ReadLn(_handle, _n) asm { __readLnValue(_handle, _n, __RETVAL__) }
#define ReadBytes(_handle, _len, _buf) asm { __readBytes(_handle, _len, _buf, __RETVAL__) }
#define ReadLnString(_handle, _output) asm { __readLnString(_handle, _output, __RETVAL__) }

#define Write(_handle, _n) asm { __writeValue(_handle, _n, __RETVAL__) }
#define WriteLn(_handle, _n) asm { __writeLnValue(_handle, _n, __RETVAL__) }
#define WriteString(_handle, _str, _cnt) asm { __writeString(_handle, _str, _cnt, __RETVAL__) }
#define WriteLnString(_handle, _str, _cnt) asm { __writeLnString(_handle, _str, _cnt, __RETVAL__) }
#define WriteBytes(_handle, _buf, _cnt) asm { __writeBytes(_handle, _buf, _cnt, __RETVAL__) }
#define WriteBytesEx(_handle, _len, _buf) asm { __writeBytesEx(_handle, _len, _buf, __RETVAL__) }

#define SysFileOpenRead(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenRead, _args \
}
#define SysFileOpenWrite(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenWrite, _args \
}
#define SysFileOpenAppend(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenAppend, _args \
}
#define SysFileRead(_args) asm { \
  compchktype _args, FileReadWriteType \
  syscall FileRead, _args \
}
#define SysFileWrite(_args) asm { \
  compchktype _args, FileReadWriteType \
  syscall FileWrite, _args \
}
#define SysFileClose(_args) asm { \
  compchktype _args, FileCloseType \
  syscall FileClose, _args \
}
#define SysFileResolveHandle(_args) asm { \
  compchktype _args, FileResolveHandleType \
  syscall FileResolveHandle, _args \
}
#define SysFileRename(_args) asm { \
  compchktype _args, FileRenameType \
  syscall FileRename, _args \
}
#define SysFileDelete(_args) asm { \
  compchktype _args, FileDeleteType \
  syscall FileDelete, _args \
}

#ifdef __ENHANCED_FIRMWARE
#define SysLoaderExecuteFunction(_args) asm { \
  compchktype _args, LoaderExecuteFunctionType \
  syscall LoaderExecuteFunction, _args \
}
#define SysFileFindFirst(_args) asm { \
  compchktype _args, FileFindType \
  syscall FileFindFirst, _args \
}
#define SysFileFindNext(_args) asm { \
  compchktype _args, FileFindType \
  syscall FileFindNext, _args \
}
#define SysFileOpenWriteLinear(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenWriteLinear, _args \
}
#define SysFileOpenWriteNonLinear(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenWriteNonLinear, _args \
}
#define SysFileOpenReadLinear(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenReadLinear, _args \
}
#if __FIRMWARE_VERSION > 107
#define SysFileSeek(_args) asm { \
  compchktype _args, FileSeekType \
  syscall FileSeek, _args \
}
#define SysFileResize(_args) asm { \
  compchktype _args, FileResizeType \
  syscall FileResize, _args \
}
#endif
#endif
#if __FIRMWARE_VERSION > 107
#define SysListFiles(_args) asm { \
  compchktype _args, ListFilesType \
  syscall ListFiles, _args \
}
#endif

#endif

/** @} */ // end of LoaderModuleFunctions group
/** @} */ // end of LoaderModule group
/** @} */ // end of NXTFirmwareModules group


/** @addtogroup ThirdPartyDevices
 * @{
 */

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
    getin __RETVAL__, port, RawValue
    sub __RETVAL__, __RETVAL__, 600
    sub __RETVAL__, __RETVAL__, offset
  }
}
/** \example ex_SensorHTGyro.nxc
 * This is an example of how to use the \ref SensorHTGyro function.
 */

/**
 * Read HiTechnic EOPD sensor.
 * Read the HiTechnic EOPD sensor on the specified port.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The EOPD sensor reading.
 */
inline int SensorHTEOPD(const byte & port) {
  asm {
    getin __RETVAL__, port, RawValue
    sub __RETVAL__, 1023, __RETVAL__
  }
}
/** \example ex_SensorHTEOPD.nxc
 * This is an example of how to use the \ref SensorHTEOPD function.
 */

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
/** \example ex_SetSensorHTEOPD.nxc
 * This is an example of how to use the \ref SetSensorHTEOPD function.
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
/** \example ex_SetSensorHTGyro.nxc
 * This is an example of how to use the \ref SetSensorHTGyro function.
 */

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
/** \example ex_SensorHTColorNum.nxc
 * This is an example of how to use the \ref SensorHTColorNum function.
 */

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
/** \example ex_SensorHTCompass.nxc
 * This is an example of how to use the \ref SensorHTCompass function.
 */

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
/** \example ex_SensorHTIRSeekerDir.nxc
 * This is an example of how to use the \ref SensorHTIRSeekerDir function.
 */

/**
 * Read HiTechnic IRSeeker2 register.
 * Read a register value from the HiTechnic IR Seeker2 on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The register address. See \ref HTIRSeeker2Constants.
 * \return The IRSeeker2 register value.
 */
inline int SensorHTIRSeeker2Addr(const byte & port, const byte addr);
/** \example ex_SensorHTIRSeeker2Addr.nxc
 * This is an example of how to use the \ref SensorHTIRSeeker2Addr function.
 */

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
/** \example ex_SensorHTIRSeeker2DCDir.nxc
 * This is an example of how to use the \ref SensorHTIRSeeker2DCDir function.
 */

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
/** \example ex_SensorHTIRSeeker2ACDir.nxc
 * This is an example of how to use the \ref SensorHTIRSeeker2ACDir function.
 */

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
/** \example ex_SetHTColor2Mode.nxc
 * This is an example of how to use the \ref SetHTColor2Mode function.
 */

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
/** \example ex_SetHTIRSeeker2Mode.nxc
 * This is an example of how to use the \ref SetHTIRSeeker2Mode function.
 */

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
/** \example ex_ReadSensorHTAccel.nxc
 * This is an example of how to use the \ref ReadSensorHTAccel function.
 */

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
/** \example ex_ReadSensorHTColor.nxc
 * This is an example of how to use the \ref ReadSensorHTColor function.
 */

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
/** \example ex_ReadSensorHTIRSeeker.nxc
 * This is an example of how to use the \ref ReadSensorHTIRSeeker function.
 */

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
/** \example ex_ReadSensorHTNormalizedColor.nxc
 * This is an example of how to use the \ref ReadSensorHTNormalizedColor function.
 */

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
/** \example ex_ReadSensorHTRawColor.nxc
 * This is an example of how to use the \ref ReadSensorHTRawColor function.
 */

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
/** \example ex_ReadSensorHTColor2Active.nxc
 * This is an example of how to use the \ref ReadSensorHTColor2Active function.
 */

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
/** \example ex_ReadSensorHTNormalizedColor2Active.nxc
 * This is an example of how to use the \ref ReadSensorHTNormalizedColor2Active function.
 */

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
/** \example ex_ReadSensorHTRawColor2.nxc
 * This is an example of how to use the \ref ReadSensorHTRawColor2 function.
 */

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
/** \example ex_ReadSensorHTIRReceiver.nxc
 * This is an example of how to use the \ref ReadSensorHTIRReceiver function.
 */

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
/** \example ex_ReadSensorHTIRReceiverEx.nxc
 * This is an example of how to use the \ref ReadSensorHTIRReceiverEx function.
 */

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
/** \example ex_ReadSensorHTIRSeeker2AC.nxc
 * This is an example of how to use the \ref ReadSensorHTIRSeeker2AC function.
 */

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
/** \example ex_ReadSensorHTIRSeeker2DC.nxc
 * This is an example of how to use the \ref ReadSensorHTIRSeeker2DC function.
 */

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
/** \example ex_ReadSensorHTTouchMultiplexer.nxc
 * This is an example of how to use the \ref ReadSensorHTTouchMultiplexer function.
 */

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
/** \example ex_HTIRTrain.nxc
 * This is an example of how to use the \ref HTIRTrain function.
 */

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
/** \example ex_HTPFComboDirect.nxc
 * This is an example of how to use the \ref HTPFComboDirect function.
 */

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
/** \example ex_HTPFComboPWM.nxc
 * This is an example of how to use the \ref HTPFComboPWM function.
 */

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
/** \example ex_HTPFRawOutput.nxc
 * This is an example of how to use the \ref HTPFRawOutput function.
 */

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
/** \example ex_HTPFRepeat.nxc
 * This is an example of how to use the \ref HTPFRepeat function.
 */

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
/** \example ex_HTPFSingleOutputCST.nxc
 * This is an example of how to use the \ref HTPFSingleOutputCST function.
 */

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
/** \example ex_HTPFSingleOutputPWM.nxc
 * This is an example of how to use the \ref HTPFSingleOutputPWM function.
 */

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
/** \example ex_HTPFSinglePin.nxc
 * This is an example of how to use the \ref HTPFSinglePin function.
 */

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
/** \example ex_HTPFTrain.nxc
 * This is an example of how to use the \ref HTPFTrain function.
 */

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
/** \example ex_HTRCXSetIRLinkPort.nxc
 * This is an example of how to use the \ref HTRCXSetIRLinkPort function.
 */

/**
 * HTRCXBatteryLevel function.
 * Send the BatteryLevel command to an RCX to read the current battery level.
 *
 * \return The RCX battery level.
 */
inline int HTRCXBatteryLevel(void);
/** \example ex_HTRCXBatteryLevel.nxc
 * This is an example of how to use the \ref HTRCXBatteryLevel function.
 */

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
/** \example ex_HTRCXPoll.nxc
 * This is an example of how to use the \ref HTRCXPoll function.
 */

/**
 * HTRCXPollMemory function.
 * Send the PollMemory command to an RCX.
 *
 * \param address The RCX memory address.
 * \return The value read from the specified address.
 */
inline int HTRCXPollMemory(const unsigned int address);
/** \example ex_HTRCXPollMemory.nxc
 * This is an example of how to use the \ref HTRCXPollMemory function.
 */

/**
 * HTRCXAddToDatalog function.
 * Send the AddToDatalog command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void HTRCXAddToDatalog(const byte src, const unsigned int value);
/** \example ex_HTRCXAddToDatalog.nxc
 * This is an example of how to use the \ref HTRCXAddToDatalog function.
 */

/**
 * HTRCXClearAllEvents function.
 * Send the ClearAllEvents command to an RCX.
 */
inline void HTRCXClearAllEvents(void);
/** \example ex_HTRCXClearAllEvents.nxc
 * This is an example of how to use the \ref HTRCXClearAllEvents function.
 */

/**
 * HTRCXClearCounter function.
 * Send the ClearCounter command to an RCX.
 *
 * \param counter The counter to clear.
 */
inline void HTRCXClearCounter(const byte counter);
/** \example ex_HTRCXClearCounter.nxc
 * This is an example of how to use the \ref HTRCXClearCounter function.
 */

/**
 * HTRCXClearMsg function.
 * Send the ClearMsg command to an RCX.
 */
inline void HTRCXClearMsg(void);
/** \example ex_HTRCXClearMsg.nxc
 * This is an example of how to use the \ref HTRCXClearMsg function.
 */

/**
 * HTRCXClearSensor function.
 * Send the ClearSensor command to an RCX.
 *
 * \param port The RCX port number.
 */
inline void HTRCXClearSensor(const byte port);
/** \example ex_HTRCXClearSensor.nxc
 * This is an example of how to use the \ref HTRCXClearSensor function.
 */

/**
 * HTRCXClearSound function.
 * Send the ClearSound command to an RCX.
 */
inline void HTRCXClearSound(void);
/** \example ex_HTRCXClearSound.nxc
 * This is an example of how to use the \ref HTRCXClearSound function.
 */

/**
 * HTRCXClearTimer function.
 * Send the ClearTimer command to an RCX.
 *
 * \param timer The timer to clear.
 */
inline void HTRCXClearTimer(const byte timer);
/** \example ex_HTRCXClearTimer.nxc
 * This is an example of how to use the \ref HTRCXClearTimer function.
 */

/**
 * HTRCXCreateDatalog function.
 * Send the CreateDatalog command to an RCX.
 *
 * \param size The new datalog size.
 */
inline void HTRCXCreateDatalog(const unsigned int size);
/** \example ex_HTRCXCreateDatalog.nxc
 * This is an example of how to use the \ref HTRCXCreateDatalog function.
 */

/**
 * HTRCXDecCounter function.
 * Send the DecCounter command to an RCX.
 *
 * \param counter The counter to decrement.
 */
inline void HTRCXDecCounter(const byte counter);
/** \example ex_HTRCXDecCounter.nxc
 * This is an example of how to use the \ref HTRCXDecCounter function.
 */

/**
 * HTRCXDeleteSub function.
 * Send the DeleteSub command to an RCX.
 *
 * \param s The subroutine number to delete.
 */
inline void HTRCXDeleteSub(const byte s);
/** \example ex_HTRCXDeleteSub.nxc
 * This is an example of how to use the \ref HTRCXDeleteSub function.
 */

/**
 * HTRCXDeleteSubs function.
 * Send the DeleteSubs command to an RCX.
 */
inline void HTRCXDeleteSubs(void);
/** \example ex_HTRCXDeleteSubs.nxc
 * This is an example of how to use the \ref HTRCXDeleteSubs function.
 */

/**
 * HTRCXDeleteTask function.
 * Send the DeleteTask command to an RCX.
 *
 * \param t The task number to delete.
 */
inline void HTRCXDeleteTask(const byte t);
/** \example ex_HTRCXDeleteTask.nxc
 * This is an example of how to use the \ref HTRCXDeleteTask function.
 */

/**
 * HTRCXDeleteTasks function.
 * Send the DeleteTasks command to an RCX.
 */
inline void HTRCXDeleteTasks(void);
/** \example ex_HTRCXDeleteTasks.nxc
 * This is an example of how to use the \ref HTRCXDeleteTasks function.
 */

/**
 * HTRCXDisableOutput function.
 * Send the DisableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to disable. See \ref RCXOutputConstants.
 */
inline void HTRCXDisableOutput(const byte outputs);
/** \example ex_HTRCXDisableOutput.nxc
 * This is an example of how to use the \ref HTRCXDisableOutput function.
 */

/**
 * HTRCXEnableOutput function.
 * Send the EnableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to enable. See \ref RCXOutputConstants.
 */
inline void HTRCXEnableOutput(const byte outputs);
/** \example ex_HTRCXEnableOutput.nxc
 * This is an example of how to use the \ref HTRCXEnableOutput function.
 */

/**
 * HTRCXEvent function.
 * Send the Event command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void HTRCXEvent(const byte src, const unsigned int value);
/** \example ex_HTRCXEvent.nxc
 * This is an example of how to use the \ref HTRCXEvent function.
 */

/**
 * HTRCXFloat function.
 * Send commands to an RCX to float the specified outputs.
 *
 * \param outputs The RCX output(s) to float. See \ref RCXOutputConstants.
 */
inline void HTRCXFloat(const byte outputs);
/** \example ex_HTRCXFloat.nxc
 * This is an example of how to use the \ref HTRCXFloat function.
 */

/**
 * HTRCXFwd function.
 * Send commands to an RCX to set the specified outputs to the forward direction.
 *
 * \param outputs The RCX output(s) to set forward. See \ref RCXOutputConstants.
 */
inline void HTRCXFwd(const byte outputs);
/** \example ex_HTRCXFwd.nxc
 * This is an example of how to use the \ref HTRCXFwd function.
 */

/**
 * HTRCXIncCounter function.
 * Send the IncCounter command to an RCX.
 *
 * \param counter The counter to increment.
 */
inline void HTRCXIncCounter(const byte counter);
/** \example ex_HTRCXIncCounter.nxc
 * This is an example of how to use the \ref HTRCXIncCounter function.
 */

/**
 * HTRCXInvertOutput function.
 * Send the InvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to invert. See \ref RCXOutputConstants.
 */
inline void HTRCXInvertOutput(const byte outputs);
/** \example ex_HTRCXInvertOutput.nxc
 * This is an example of how to use the \ref HTRCXInvertOutput function.
 */

/**
 * HTRCXMuteSound function.
 * Send the MuteSound command to an RCX.
 */
inline void HTRCXMuteSound(void);
/** \example ex_HTRCXMuteSound.nxc
 * This is an example of how to use the \ref HTRCXMuteSound function.
 */

/**
 * HTRCXObvertOutput function.
 * Send the ObvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to obvert. See \ref RCXOutputConstants.
 */
inline void HTRCXObvertOutput(const byte outputs);
/** \example ex_HTRCXObvertOutput.nxc
 * This is an example of how to use the \ref HTRCXObvertOutput function.
 */

/**
 * HTRCXOff function.
 * Send commands to an RCX to turn off the specified outputs.
 *
 * \param outputs The RCX output(s) to turn off. See \ref RCXOutputConstants.
 */
inline void HTRCXOff(const byte outputs);
/** \example ex_HTRCXOff.nxc
 * This is an example of how to use the \ref HTRCXOff function.
 */

/**
 * HTRCXOn function.
 * Send commands to an RCX to turn on the specified outputs.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 */
inline void HTRCXOn(const byte outputs);
/** \example ex_HTRCXOn.nxc
 * This is an example of how to use the \ref HTRCXOn function.
 */

/**
 * HTRCXOnFor function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction for the specified duration.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 * \param ms The number of milliseconds to leave the outputs on
 */
inline void HTRCXOnFor(const byte outputs, const unsigned int ms);
/** \example ex_HTRCXOnFor.nxc
 * This is an example of how to use the \ref HTRCXOnFor function.
 */

/**
 * HTRCXOnFwd function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction.
 *
 * \param outputs The RCX output(s) to turn on in the forward direction. See \ref RCXOutputConstants.
 */
inline void HTRCXOnFwd(const byte outputs);
/** \example ex_HTRCXOnFwd.nxc
 * This is an example of how to use the \ref HTRCXOnFwd function.
 */

/**
 * HTRCXOnRev function.
 * Send commands to an RCX to turn on the specified outputs in the reverse direction.
 *
 * \param outputs The RCX output(s) to turn on in the reverse direction. See \ref RCXOutputConstants.
 */
inline void HTRCXOnRev(const byte outputs);
/** \example ex_HTRCXOnRev.nxc
 * This is an example of how to use the \ref HTRCXOnRev function.
 */

/**
 * HTRCXPBTurnOff function.
 * Send the PBTurnOff command to an RCX.
 */
inline void HTRCXPBTurnOff(void);
/** \example ex_HTRCXPBTurnOff.nxc
 * This is an example of how to use the \ref HTRCXPBTurnOff function.
 */

/**
 * HTRCXPing function.
 * Send the Ping command to an RCX.
 */
inline void HTRCXPing(void);
/** \example ex_HTRCXPing.nxc
 * This is an example of how to use the \ref HTRCXPing function.
 */

/**
 * HTRCXPlaySound function.
 * Send the PlaySound command to an RCX.
 *
 * \param snd The sound number to play.
 */
inline void HTRCXPlaySound(const byte snd);
/** \example ex_HTRCXPlaySound.nxc
 * This is an example of how to use the \ref HTRCXPlaySound function.
 */

/**
 * HTRCXPlayTone function.
 * Send the PlayTone command to an RCX.
 *
 * \param freq The frequency of the tone to play.
 * \param duration The duration of the tone to play.
 */
inline void HTRCXPlayTone(const unsigned int freq, const byte duration);
/** \example ex_HTRCXPlayTone.nxc
 * This is an example of how to use the \ref HTRCXPlayTone function.
 */

/**
 * HTRCXPlayToneVar function.
 * Send the PlayToneVar command to an RCX.
 *
 * \param varnum The variable containing the tone frequency to play.
 * \param duration The duration of the tone to play.
 */
inline void HTRCXPlayToneVar(const byte varnum, const byte duration);
/** \example ex_HTRCXPlayToneVar.nxc
 * This is an example of how to use the \ref HTRCXPlayToneVar function.
 */

/**
 * HTRCXRemote function.
 * Send the Remote command to an RCX.
 *
 * \param cmd The RCX IR remote command to send. See \ref RCXRemoteConstants.
 */
inline void HTRCXRemote(unsigned int cmd);
/** \example ex_HTRCXRemote.nxc
 * This is an example of how to use the \ref HTRCXRemote function.
 */

/**
 * HTRCXRev function.
 * Send commands to an RCX to set the specified outputs to the reverse direction.
 *
 * \param outputs The RCX output(s) to reverse direction. See \ref RCXOutputConstants.
 */
inline void HTRCXRev(const byte outputs);
/** \example ex_HTRCXRev.nxc
 * This is an example of how to use the \ref HTRCXRev function.
 */

/**
 * HTRCXSelectDisplay function.
 * Send the SelectDisplay command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void HTRCXSelectDisplay(const byte src, const unsigned int value);
/** \example ex_HTRCXSelectDisplay.nxc
 * This is an example of how to use the \ref HTRCXSelectDisplay function.
 */

/**
 * HTRCXSelectProgram function.
 * Send the SelectProgram command to an RCX.
 *
 * \param prog The program number to select.
 */
inline void HTRCXSelectProgram(const byte prog);
/** \example ex_HTRCXSelectProgram.nxc
 * This is an example of how to use the \ref HTRCXSelectProgram function.
 */

/**
 * HTRCXSendSerial function.
 * Send the SendSerial command to an RCX.
 *
 * \param first The first byte address.
 * \param count The number of bytes to send.
 */
inline void HTRCXSendSerial(const byte first, const byte count);
/** \example ex_HTRCXSendSerial.nxc
 * This is an example of how to use the \ref HTRCXSendSerial function.
 */

/**
 * HTRCXSetDirection function.
 * Send the SetDirection command to an RCX to configure the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to set direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void HTRCXSetDirection(const byte outputs, const byte dir);
/** \example ex_HTRCXSetDirection.nxc
 * This is an example of how to use the \ref HTRCXSetDirection function.
 */

/**
 * HTRCXSetEvent function.
 * Send the SetEvent command to an RCX.
 *
 * \param evt The event number to set.
 * \param src The RCX source. See \ref RCXSourceConstants.
 * \param type The event type.
 */
inline void HTRCXSetEvent(const byte evt, const byte src, const byte type);
/** \example ex_HTRCXSetEvent.nxc
 * This is an example of how to use the \ref HTRCXSetEvent function.
 */

/**
 * HTRCXSetGlobalDirection function.
 * Send the SetGlobalDirection command to an RCX.
 *
 * \param outputs The RCX output(s) to set global direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void HTRCXSetGlobalDirection(const byte outputs, const byte dir);
/** \example ex_HTRCXSetGlobalDirection.nxc
 * This is an example of how to use the \ref HTRCXSetGlobalDirection function.
 */

/**
 * HTRCXSetGlobalOutput function.
 * Send the SetGlobalOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to set global mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void HTRCXSetGlobalOutput(const byte outputs, const byte mode);
/** \example ex_HTRCXSetGlobalOutput.nxc
 * This is an example of how to use the \ref HTRCXSetGlobalOutput function.
 */

/**
 * HTRCXSetMaxPower function.
 * Send the SetMaxPower command to an RCX.
 *
 * \param outputs The RCX output(s) to set max power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void HTRCXSetMaxPower(const byte outputs, const byte pwrsrc, const byte pwrval);
/** \example ex_HTRCXSetMaxPower.nxc
 * This is an example of how to use the \ref HTRCXSetMaxPower function.
 */

/**
 * HTRCXSetMessage function.
 * Send the SetMessage command to an RCX.
 *
 * \param msg The numeric message to send.
 */
inline void HTRCXSetMessage(const byte msg);
/** \example ex_HTRCXSetMessage.nxc
 * This is an example of how to use the \ref HTRCXSetMessage function.
 */

/**
 * HTRCXSetOutput function.
 * Send the SetOutput command to an RCX to configure the mode of the specified outputs
 *
 * \param outputs The RCX output(s) to set mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void HTRCXSetOutput(const byte outputs, const byte mode);
/** \example ex_HTRCXSetOutput.nxc
 * This is an example of how to use the \ref HTRCXSetOutput function.
 */

/**
 * HTRCXSetPower function.
 * Send the SetPower command to an RCX to configure the power level of the specified outputs.
 *
 * \param outputs The RCX output(s) to set power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void HTRCXSetPower(const byte outputs, const byte pwrsrc, const byte pwrval);
/** \example ex_HTRCXSetPower.nxc
 * This is an example of how to use the \ref HTRCXSetPower function.
 */

/**
 * HTRCXSetPriority function.
 * Send the SetPriority command to an RCX.
 *
 * \param p The new task priority.
 */
inline void HTRCXSetPriority(const byte p);
/** \example ex_HTRCXSetPriority.nxc
 * This is an example of how to use the \ref HTRCXSetPriority function.
 */

/**
 * HTRCXSetSensorMode function.
 * Send the SetSensorMode command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param mode The RCX sensor mode.
 */
inline void HTRCXSetSensorMode(const byte port, const byte mode);
/** \example ex_HTRCXSetSensorMode.nxc
 * This is an example of how to use the \ref HTRCXSetSensorMode function.
 */

/**
 * HTRCXSetSensorType function.
 * Send the SetSensorType command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param type The RCX sensor type.
 */
inline void HTRCXSetSensorType(const byte port, const byte type);
/** \example ex_HTRCXSetSensorType.nxc
 * This is an example of how to use the \ref HTRCXSetSensorType function.
 */

/**
 * HTRCXSetSleepTime function.
 * Send the SetSleepTime command to an RCX.
 *
 * \param t The new sleep time value.
 */
inline void HTRCXSetSleepTime(const byte t);
/** \example ex_HTRCXSetSleepTime.nxc
 * This is an example of how to use the \ref HTRCXSetSleepTime function.
 */

/**
 * HTRCXSetTxPower function.
 * Send the SetTxPower command to an RCX.
 *
 * \param pwr The IR transmit power level.
 */
inline void HTRCXSetTxPower(const byte pwr);
/** \example ex_HTRCXSetTxPower.nxc
 * This is an example of how to use the \ref HTRCXSetTxPower function.
 */

/**
 * HTRCXSetWatch function.
 * Send the SetWatch command to an RCX.
 *
 * \param hours The new watch time hours value.
 * \param minutes The new watch time minutes value.
 */
inline void HTRCXSetWatch(const byte hours, const byte minutes);
/** \example ex_HTRCXSetWatch.nxc
 * This is an example of how to use the \ref HTRCXSetWatch function.
 */

/**
 * HTRCXStartTask function.
 * Send the StartTask command to an RCX.
 *
 * \param t The task number to start.
 */
inline void HTRCXStartTask(const byte t);
/** \example ex_HTRCXStartTask.nxc
 * This is an example of how to use the \ref HTRCXStartTask function.
 */

/**
 * HTRCXStopAllTasks function.
 * Send the StopAllTasks command to an RCX.
 */
inline void HTRCXStopAllTasks(void);
/** \example ex_HTRCXStopAllTasks.nxc
 * This is an example of how to use the \ref HTRCXStopAllTasks function.
 */

/**
 * HTRCXStopTask function.
 * Send the StopTask command to an RCX.
 *
 * \param t The task number to stop.
 */
inline void HTRCXStopTask(const byte t);
/** \example ex_HTRCXStopTask.nxc
 * This is an example of how to use the \ref HTRCXStopTask function.
 */

/**
 * HTRCXToggle function.
 * Send commands to an RCX to toggle the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to toggle. See \ref RCXOutputConstants.
 */
inline void HTRCXToggle(const byte outputs);
/** \example ex_HTRCXToggle.nxc
 * This is an example of how to use the \ref HTRCXToggle function.
 */

/**
 * HTRCXUnmuteSound function.
 * Send the UnmuteSound command to an RCX.
 */
inline void HTRCXUnmuteSound(void);
/** \example ex_HTRCXUnmuteSound.nxc
 * This is an example of how to use the \ref HTRCXUnmuteSound function.
 */

/**
 * HTScoutCalibrateSensor function.
 * Send the CalibrateSensor command to a Scout.
 */
inline void HTScoutCalibrateSensor(void);
/** \example ex_HTScoutCalibrateSensor.nxc
 * This is an example of how to use the \ref HTScoutCalibrateSensor function.
 */

/**
 * HTScoutMuteSound function.
 * Send the MuteSound command to a Scout.
 */
inline void HTScoutMuteSound(void);
/** \example ex_HTScoutMuteSound.nxc
 * This is an example of how to use the \ref HTScoutMuteSound function.
 */

/**
 * HTScoutSelectSounds function.
 * Send the SelectSounds command to a Scout.
 *
 * \param grp The Scout sound group to select.
 */
inline void HTScoutSelectSounds(const byte grp);
/** \example ex_HTScoutSelectSounds.nxc
 * This is an example of how to use the \ref HTScoutSelectSounds function.
 */

/**
 * HTScoutSendVLL function.
 * Send the SendVLL command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSendVLL(const byte src, const unsigned int value);
/** \example ex_HTScoutSendVLL.nxc
 * This is an example of how to use the \ref HTScoutSendVLL function.
 */

/**
 * HTScoutSetEventFeedback function.
 * Send the SetEventFeedback command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetEventFeedback(const byte src, const unsigned int value);
/** \example ex_HTScoutSetEventFeedback.nxc
 * This is an example of how to use the \ref HTScoutSetEventFeedback function.
 */

/**
 * HTScoutSetLight function.
 * Send the SetLight command to a Scout.
 *
 * \param x Set the light on or off using this value. See \ref ScoutLightConstants.
 */
inline void HTScoutSetLight(const byte x);
/** \example ex_HTScoutSetLight.nxc
 * This is an example of how to use the \ref HTScoutSetLight function.
 */

/**
 * HTScoutSetScoutMode function.
 * Send the SetScoutMode command to a Scout.
 *
 * \param mode Set the scout mode. See \ref ScoutModeConstants.
*/
inline void HTScoutSetScoutMode(const byte mode);
/** \example ex_HTScoutSetScoutMode.nxc
 * This is an example of how to use the \ref HTScoutSetScoutMode function.
 */

/**
 * HTScoutSetSensorClickTime function.
 * Send the SetSensorClickTime command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetSensorClickTime(const byte src, const unsigned int value);
/** \example ex_HTScoutSetSensorClickTime.nxc
 * This is an example of how to use the \ref HTScoutSetSensorClickTime function.
 */

/**
 * HTScoutSetSensorHysteresis function.
 * Send the SetSensorHysteresis command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetSensorHysteresis(const byte src, const unsigned int value);
/** \example ex_HTScoutSetSensorHysteresis.nxc
 * This is an example of how to use the \ref HTScoutSetSensorHysteresis function.
 */

/**
 * HTScoutSetSensorLowerLimit function.
 * Send the SetSensorLowerLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetSensorLowerLimit(const byte src, const unsigned int value);
/** \example ex_HTScoutSetSensorLowerLimit.nxc
 * This is an example of how to use the \ref HTScoutSetSensorLowerLimit function.
 */

/**
 * HTScoutSetSensorUpperLimit function.
 * Send the SetSensorUpperLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void HTScoutSetSensorUpperLimit(const byte src, const unsigned int value);
/** \example ex_HTScoutSetSensorUpperLimit.nxc
 * This is an example of how to use the \ref HTScoutSetSensorUpperLimit function.
 */

/**
 * HTScoutUnmuteSound function.
 * Send the UnmuteSound command to a Scout.
 */
inline void HTScoutUnmuteSound(void);
/** \example ex_HTScoutUnmuteSound.nxc
 * This is an example of how to use the \ref HTScoutUnmuteSound function.
 */

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
#define SensorHTIRSeeker2Addr(_port, _addr) asm { ReadSensorHTIRSeeker2Addr(_port, _addr, __RETVAL__) }
#define SensorHTIRSeeker2DCDir(_port) asm { ReadSensorHTIRSeeker2Addr(_port, HTIR2_ADDR_DCDIR, __RETVAL__) }
#define SensorHTIRSeeker2ACDir(_port) asm { ReadSensorHTIRSeeker2Addr(_port, HTIR2_ADDR_ACDIR, __RETVAL__) }
#define ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg) asm { __ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, __RETVAL__) }
#define ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9) asm { __ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, __RETVAL__) }
#define SetHTIRSeeker2Mode(_port, _mode) asm { __SetHTIRSeeker2Mode(_port, _mode, __RETVAL__) }

#define SetHTColor2Mode(_port, _mode) asm { __SetHTColor2Mode(_port, _mode, __RETVAL__) }
#define ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White) asm { __ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, __RETVAL__) }
#define ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue) asm { __ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White) asm { __ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, __RETVAL__) }
#define ReadSensorHTIRReceiver(_port, _pfdata) asm { __ReadSensorHTIRReceiver(_port, _pfdata, __RETVAL__) } 
#define ReadSensorHTIRReceiverEx(_port, _reg, _pfchar) asm { __ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, __RETVAL__) } 

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
#define HTRCXPollMemory(_address) asm { __HTRCXPollMemory(_address, __RETVAL__) }
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


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// MindSensors API ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup MindSensorsAPI
 * @{
 */

/**
 * Configure a mindsensors pressure sensor.
 * Configure the specified port for a mindsensors pressure sensor.
 * \param port The port to configure. See \ref InPorts.
 */
inline void SetSensorMSPressure(const byte & port ) {
  SetSensorType(port, SENSOR_TYPE_LIGHT);
  SetSensorMode(port, SENSOR_MODE_RAW);
  ResetSensor(port);
}
/** \example ex_SetSensorMSPressure.nxc
 * This is an example of how to use the \ref SetSensorMSPressure function.
 */

/**
 * Configure a mindsensors DROD sensor.
 * Configure the specified port for a mindsensors DROD sensor.
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
/** \example ex_SetSensorMSDROD.nxc
 * This is an example of how to use the \ref SetSensorMSDROD function.
 */

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
    getin __RETVAL__, port, RawValue
    sub __RETVAL__, 1024, __RETVAL__
    div __RETVAL__, __RETVAL__, 25
  }
}
/** \example ex_SensorMSPressure.nxc
 * This is an example of how to use the \ref SensorMSPressure function.
 */

#ifdef __DOXYGEN_DOCS

/**
 * Read mindsensors compass value.
 * Return the Mindsensors Compass sensor value.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The mindsensors compass value
 */
inline int SensorMSCompass(const byte & port);
/** \example ex_SensorMSCompass.nxc
 * This is an example of how to use the \ref SensorMSCompass function.
 */

/**
 * Read mindsensors compass value.
 * Return the Mindsensors Compass sensor value.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The mindsensors compass value
 */
inline int SensorMSCompassEx(const byte & port, const byte addr);
/** \example ex_SensorMSCompassEx.nxc
 * This is an example of how to use the \ref SensorMSCompassEx function.
 */

/**
 * Read mindsensors DROD value.
 * Return the Mindsensors DROD sensor value.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The mindsensors DROD value
 */
inline int SensorMSDROD(const byte & port);
/** \example ex_SensorMSDROD.nxc
 * This is an example of how to use the \ref SensorMSDROD function.
 */

/**
 * Read mindsensors raw pressure value.
 * Return the Mindsensors pressure sensor raw value.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The mindsensors raw pressure value
 */
inline int SensorMSPressureRaw(const byte & port);
/** \example ex_SensorMSPressureRaw.nxc
 * This is an example of how to use the \ref SensorMSPressureRaw function.
 */

/**
 * Read mindsensors acceleration values.
 * Read X, Y, and Z axis acceleration values from the mindsensors Accelerometer
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
inline bool ReadSensorMSAccel(const byte port, int & x, int & y, int & z);
/** \example ex_ReadSensorMSAccel.nxc
 * This is an example of how to use the \ref ReadSensorMSAccel function.
 */

/**
 * Read mindsensors acceleration values.
 * Read X, Y, and Z axis acceleration values from the mindsensors Accelerometer
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param x The output x-axis acceleration.
 * \param y The output y-axis acceleration.
 * \param z The output z-axis acceleration.
 * \return The function call result.
 */
inline bool ReadSensorMSAccelEx(const byte port, const byte addr, int & x, int & y, int & z);
/** \example ex_ReadSensorMSAccelEx.nxc
 * This is an example of how to use the \ref ReadSensorMSAccelEx function.
 */

/**
 * Read mindsensors playstation controller values.
 * Read playstation controller values from the mindsensors playstation
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param btnset1 The button set 1 values. See \ref MSPSPNXBtnSet1.
 * \param btnset2 The button set 2 values. See \ref MSPSPNXBtnSet2.
 * \param xleft The left joystick x value.
 * \param yleft The left joystick y value.
 * \param xright The right joystick x value.
 * \param yright The right joystick y value.
 * \return The function call result.
 */
inline bool ReadSensorMSPlayStation(const byte port, byte & btnset1, byte & btnset2, byte & xleft, byte & yleft, byte & xright, byte & yright);
/** \example ex_ReadSensorMSPlayStation.nxc
 * This is an example of how to use the \ref ReadSensorMSPlayStation function.
 */

/**
 * Read mindsensors playstation controller values.
 * Read playstation controller values from the mindsensors playstation
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param btnset1 The button set 1 values. See \ref MSPSPNXBtnSet1.
 * \param btnset2 The button set 2 values. See \ref MSPSPNXBtnSet2.
 * \param xleft The left joystick x value.
 * \param yleft The left joystick y value.
 * \param xright The right joystick x value.
 * \param yright The right joystick y value.
 * \return The function call result.
 */
inline bool ReadSensorMSPlayStationEx(const byte port, const byte addr, byte & btnset1, byte & btnset2, byte & xleft, byte & yleft, byte & xright, byte & yright);
/** \example ex_ReadSensorMSPlayStationEx.nxc
 * This is an example of how to use the \ref ReadSensorMSPlayStationEx function.
 */

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
/** \example ex_ReadSensorMSRTClock.nxc
 * This is an example of how to use the \ref ReadSensorMSRTClock function.
 */

/**
 * Read mindsensors tilt values.
 * Read X, Y, and Z axis tilt values from the mindsensors tilt
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param x The output x-axis tilt.
 * \param y The output y-axis tilt.
 * \param z The output z-axis tilt.
 * \return The function call result.
 */
inline bool ReadSensorMSTilt(const byte port, byte & x, byte & y, byte & z);
/** \example ex_ReadSensorMSTilt.nxc
 * This is an example of how to use the \ref ReadSensorMSTilt function.
 */

/**
 * Read mindsensors tilt values.
 * Read X, Y, and Z axis tilt values from the mindsensors tilt
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param x The output x-axis tilt.
 * \param y The output y-axis tilt.
 * \param z The output z-axis tilt.
 * \return The function call result.
 */
inline bool ReadSensorMSTiltEx(const byte port, const byte addr, byte & x, byte & y, byte & z);
/** \example ex_ReadSensorMSTiltEx.nxc
 * This is an example of how to use the \ref ReadSensorMSTiltEx function.
 */

/**
 * Read a mindsensors device value.
 * Read a one or two byte value from a mindsensors sensor. The value must be
 * stored with the least signficant byte (LSB) first. Returns a boolean value
 * indicating whether or not the operation completed successfully. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param reg The device register to read.
 * \param numbytes The number of bytes to read. Only 1 or 2 byte values are supported.
 * \return The function call result.
 */
inline int MSReadValue(const byte port, const byte reg, const byte numbytes);
/** \example ex_MSReadValue.nxc
 * This is an example of how to use the \ref MSReadValue function.
 */

/**
 * Read a mindsensors device value.
 * Read a one or two byte value from a mindsensors sensor. The value must be
 * stored with the least signficant byte (LSB) first. Returns a boolean value
 * indicating whether or not the operation completed successfully. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param reg The device register to read.
 * \param numbytes The number of bytes to read. Only 1 or 2 byte values are supported.
 * \return The function call result.
 */
inline int MSReadValueEx(const byte port, const byte addr, const byte reg, const byte numbytes);
/** \example ex_MSReadValueEx.nxc
 * This is an example of how to use the \ref MSReadValueEx function.
 */

/**
 * Turn on power to device.
 * Turn the power on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char MSEnergize(const byte port);
/** \example ex_MSEnergize.nxc
 * This is an example of how to use the \ref MSEnergize function.
 */

/**
 * Turn on power to device.
 * Turn the power on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char MSEnergizeEx(const byte port, const byte addr);
/** \example ex_MSEnergizeEx.nxc
 * This is an example of how to use the \ref MSEnergizeEx function.
 */

/**
 * Turn off power to device.
 * Turn power off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char MSDeenergize(const byte port);
/** \example ex_MSDeenergize.nxc
 * This is an example of how to use the \ref MSDeenergize function.
 */

/**
 * Turn off power to device.
 * Turn power off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char MSDeenergizeEx(const byte port, const byte addr);
/** \example ex_MSDeenergizeEx.nxc
 * This is an example of how to use the \ref MSDeenergizeEx function.
 */

/**
 * Turn on mindsensors ADPA mode.
 * Turn ADPA mode on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char MSADPAOn(const byte port);
/** \example ex_MSADPAOn.nxc
 * This is an example of how to use the \ref MSADPAOn function.
 */

/**
 * Turn on mindsensors ADPA mode.
 * Turn ADPA mode on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char MSADPAOnEx(const byte port, const byte addr);
/** \example ex_MSADPAOnEx.nxc
 * This is an example of how to use the \ref MSADPAOnEx function.
 */

/**
 * Turn off mindsensors ADPA mode.
 * Turn ADPA mode off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char MSADPAOff(const byte port);
/** \example ex_MSADPAOff.nxc
 * This is an example of how to use the \ref MSADPAOff function.
 */

/**
 * Turn off mindsensors ADPA mode.
 * Turn ADPA mode off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char MSADPAOffEx(const byte port, const byte addr);
/** \example ex_MSADPAOffEx.nxc
 * This is an example of how to use the \ref MSADPAOffEx function.
 */

/**
 * Configure DISTNx as GP2D12.
 * Configure the mindsensors DISTNx sensor as GP2D12. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char DISTNxGP2D12(const byte port);
/** \example ex_DISTNxGP2D12.nxc
 * This is an example of how to use the \ref DISTNxGP2D12 function.
 */

/**
 * Configure DISTNx as GP2D12.
 * Configure the mindsensors DISTNx sensor as GP2D12. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char DISTNxGP2D12Ex(const byte port, const byte addr);
/** \example ex_DISTNxGP2D12Ex.nxc
 * This is an example of how to use the \ref DISTNxGP2D12Ex function.
 */

/**
 * Configure DISTNx as GP2D120.
 * Configure the mindsensors DISTNx sensor as GP2D120. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char DISTNxGP2D120(const byte port);
/** \example ex_DISTNxGP2D120.nxc
 * This is an example of how to use the \ref DISTNxGP2D120 function.
 */

/**
 * Configure DISTNx as GP2D120.
 * Configure the mindsensors DISTNx sensor as GP2D120. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char DISTNxGP2D120Ex(const byte port, const byte addr);
/** \example ex_DISTNxGP2D120Ex.nxc
 * This is an example of how to use the \ref DISTNxGP2D120Ex function.
 */

/**
 * Configure DISTNx as GP2YA02.
 * Configure the mindsensors DISTNx sensor as GP2YA02. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char DISTNxGP2YA02(const byte port);
/** \example ex_DISTNxGP2YA02.nxc
 * This is an example of how to use the \ref DISTNxGP2YA02 function.
 */

/**
 * Configure DISTNx as GP2YA02.
 * Configure the mindsensors DISTNx sensor as GP2YA02. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char DISTNxGP2YA02Ex(const byte port, const byte addr);
/** \example ex_DISTNxGP2YA02Ex.nxc
 * This is an example of how to use the \ref DISTNxGP2YA02Ex function.
 */

/**
 * Configure DISTNx as GP2YA21.
 * Configure the mindsensors DISTNx sensor as GP2YA21. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char DISTNxGP2YA21(const byte port);
/** \example ex_DISTNxGP2YA21.nxc
 * This is an example of how to use the \ref DISTNxGP2YA21 function.
 */

/**
 * Configure DISTNx as GP2YA21.
 * Configure the mindsensors DISTNx sensor as GP2YA21. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char DISTNxGP2YA21Ex(const byte port, const byte addr);
/** \example ex_DISTNxGP2YA21Ex.nxc
 * This is an example of how to use the \ref DISTNxGP2YA21Ex function.
 */

/**
 * Read DISTNx distance value.
 * Read the mindsensors DISTNx distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The distance value.
 */
inline int DISTNxDistance(const byte port);
/** \example ex_DISTNxDistance.nxc
 * This is an example of how to use the \ref DISTNxDistance function.
 */

/**
 * Read DISTNx distance value.
 * Read the mindsensors DISTNx sensor's distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The distance value.
 */
inline int DISTNxDistanceEx(const byte port, const byte addr);
/** \example ex_DISTNxDistanceEx.nxc
 * This is an example of how to use the \ref DISTNxDistanceEx function.
 */

/**
 * Read DISTNx maximum distance value.
 * Read the mindsensors DISTNx sensor's maximum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The maximum distance value.
 */
inline int DISTNxMaxDistance(const byte port);
/** \example ex_DISTNxMaxDistance.nxc
 * This is an example of how to use the \ref DISTNxMaxDistance function.
 */

/**
 * Read DISTNx maximum distance value.
 * Read the mindsensors DISTNx sensor's maximum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The maximum distance value.
 */
inline int DISTNxMaxDistanceEx(const byte port, const byte addr);
/** \example ex_DISTNxMaxDistanceEx.nxc
 * This is an example of how to use the \ref DISTNxMaxDistanceEx function.
 */

/**
 * Read DISTNx minimum distance value.
 * Read the mindsensors DISTNx sensor's minimum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The distance value.
 */
inline int DISTNxMinDistance(const byte port);
/** \example ex_DISTNxMinDistance.nxc
 * This is an example of how to use the \ref DISTNxMinDistance function.
 */

/**
 * Read DISTNx minimum distance value.
 * Read the mindsensors DISTNx sensor's minimum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The distance value.
 */
inline int DISTNxMinDistanceEx(const byte port, const byte addr);
/** \example ex_DISTNxMinDistanceEx.nxc
 * This is an example of how to use the \ref DISTNxMinDistanceEx function.
 */

/**
 * Read DISTNx module type value.
 * Read the mindsensors DISTNx sensor's module type value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The module type value.
 */
inline byte DISTNxModuleType(const byte port);
/** \example ex_DISTNxModuleType.nxc
 * This is an example of how to use the \ref DISTNxModuleType function.
 */

/**
 * Read DISTNx module type value.
 * Read the mindsensors DISTNx sensor's module type value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The module type value.
 */
inline byte DISTNxModuleTypeEx(const byte port, const byte addr);
/** \example ex_DISTNxModuleTypeEx.nxc
 * This is an example of how to use the \ref DISTNxModuleTypeEx function.
 */

/**
 * Read DISTNx num points value.
 * Read the mindsensors DISTNx sensor's num points value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The num points value.
 */
inline byte DISTNxNumPoints(const byte port);
/** \example ex_DISTNxNumPoints.nxc
 * This is an example of how to use the \ref DISTNxNumPoints function.
 */

/**
 * Read DISTNx num points value.
 * Read the mindsensors DISTNx sensor's num points value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The num points value.
 */
inline byte DISTNxNumPointsEx(const byte port, const byte addr);
/** \example ex_DISTNxNumPointsEx.nxc
 * This is an example of how to use the \ref DISTNxNumPointsEx function.
 */

/**
 * Read DISTNx voltage value.
 * Read the mindsensors DISTNx sensor's voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The voltage value.
 */
inline int DISTNxVoltage(const byte port);
/** \example ex_DISTNxVoltage.nxc
 * This is an example of how to use the \ref DISTNxVoltage function.
 */

/**
 * Read DISTNx voltage value.
 * Read the mindsensors DISTNx sensor's voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The voltage value.
 */
inline int DISTNxVoltageEx(const byte port, const byte addr);
/** \example ex_DISTNxVoltageEx.nxc
 * This is an example of how to use the \ref DISTNxVoltageEx function.
 */

/**
 * Configure PSPNx in digital mode.
 * Configure the mindsensors PSPNx device in digital mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char PSPNxDigital(const byte & port);
/** \example ex_PSPNxDigital.nxc
 * This is an example of how to use the \ref PSPNxDigital function.
 */

/**
 * Configure PSPNx in digital mode.
 * Configure the mindsensors PSPNx device in digital mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char PSPNxDigitalEx(const byte & port, const byte & addr);
/** \example ex_PSPNxDigitalEx.nxc
 * This is an example of how to use the \ref PSPNxDigitalEx function.
 */

/**
 * Configure PSPNx in analog mode.
 * Configure the mindsensors PSPNx device in analog mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char PSPNxAnalog(const byte & port);
/** \example ex_PSPNxAnalog.nxc
 * This is an example of how to use the \ref PSPNxAnalog function.
 */

/**
 * Configure PSPNx in analog mode.
 * Configure the mindsensors PSPNx device in analog mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char PSPNxAnalogEx(const byte & port, const byte & addr);
/** \example ex_PSPNxAnalogEx.nxc
 * This is an example of how to use the \ref PSPNxAnalogEx function.
 */

/**
 * Configure NRLink in 2400 baud mode.
 * Configure the mindsensors NRLink device in 2400 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char NRLink2400(const byte port);
/** \example ex_NRLink2400.nxc
 * This is an example of how to use the \ref NRLink2400 function.
 */

/**
 * Configure NRLink in 2400 baud mode.
 * Configure the mindsensors NRLink device in 2400 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLink2400Ex(const byte port, const byte addr);
/** \example ex_NRLink2400Ex.nxc
 * This is an example of how to use the \ref NRLink2400Ex function.
 */

/**
 * Configure NRLink in 4800 baud mode.
 * Configure the mindsensors NRLink device in 4800 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char NRLink4800(const byte port);
/** \example ex_NRLink4800.nxc
 * This is an example of how to use the \ref NRLink4800 function.
 */

/**
 * Configure NRLink in 4800 baud mode.
 * Configure the mindsensors NRLink device in 4800 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLink4800Ex(const byte port, const byte addr);
/** \example ex_NRLink4800Ex.nxc
 * This is an example of how to use the \ref NRLink4800Ex function.
 */

/**
 * Flush NRLink buffers.
 * Flush the mindsensors NRLink device buffers. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char NRLinkFlush(const byte port);
/** \example ex_NRLinkFlush.nxc
 * This is an example of how to use the \ref NRLinkFlush function.
 */

/**
 * Flush NRLink buffers.
 * Flush the mindsensors NRLink device buffers. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkFlushEx(const byte port, const byte addr);
/** \example ex_NRLinkFlushEx.nxc
 * This is an example of how to use the \ref NRLinkFlushEx function.
 */

/**
 * Configure NRLink in IR long mode.
 * Configure the mindsensors NRLink device in IR long mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char NRLinkIRLong(const byte port);
/** \example ex_NRLinkIRLong.nxc
 * This is an example of how to use the \ref NRLinkIRLong function.
 */

/**
 * Configure NRLink in IR long mode.
 * Configure the mindsensors NRLink device in IR long mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkIRLongEx(const byte port, const byte addr);
/** \example ex_NRLinkIRLongEx.nxc
 * This is an example of how to use the \ref NRLinkIRLongEx function.
 */

/**
 * Configure NRLink in IR short mode.
 * Configure the mindsensors NRLink device in IR short mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char NRLinkIRShort(const byte port);
/** \example ex_NRLinkIRShort.nxc
 * This is an example of how to use the \ref NRLinkIRShort function.
 */

/**
 * Configure NRLink in IR short mode.
 * Configure the mindsensors NRLink device in IR short mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkIRShortEx(const byte port, const byte addr);
/** \example ex_NRLinkIRShortEx.nxc
 * This is an example of how to use the \ref NRLinkIRShortEx function.
 */

/**
 * Configure NRLink in power function mode.
 * Configure the mindsensors NRLink device in power function mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char NRLinkSetPF(const byte port);
/** \example ex_NRLinkSetPF.nxc
 * This is an example of how to use the \ref NRLinkSetPF function.
 */

/**
 * Configure NRLink in power function mode.
 * Configure the mindsensors NRLink device in power function mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkSetPFEx(const byte port, const byte addr);
/** \example ex_NRLinkSetPFEx.nxc
 * This is an example of how to use the \ref NRLinkSetPFEx function.
 */

/**
 * Configure NRLink in RCX mode.
 * Configure the mindsensors NRLink device in RCX mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char NRLinkSetRCX(const byte port);
/** \example ex_NRLinkSetRCX.nxc
 * This is an example of how to use the \ref NRLinkSetRCX function.
 */

/**
 * Configure NRLink in RCX mode.
 * Configure the mindsensors NRLink device in RCX mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkSetRCXEx(const byte port, const byte addr);
/** \example ex_NRLinkSetRCXEx.nxc
 * This is an example of how to use the \ref NRLinkSetRCXEx function.
 */

/**
 * Configure NRLink in IR train mode.
 * Configure the mindsensors NRLink device in IR train mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char NRLinkSetTrain(const byte port);
/** \example ex_NRLinkSetTrain.nxc
 * This is an example of how to use the \ref NRLinkSetTrain function.
 */

/**
 * Configure NRLink in IR train mode.
 * Configure the mindsensors NRLink device in IR train mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkSetTrainEx(const byte port, const byte addr);
/** \example ex_NRLinkSetTrainEx.nxc
 * This is an example of how to use the \ref NRLinkSetTrainEx function.
 */

/**
 * Configure NRLink in raw IR transmit mode.
 * Configure the mindsensors NRLink device in raw IR transmit mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The function call result.
 */
inline char NRLinkTxRaw(const byte port);
/** \example ex_NRLinkTxRaw.nxc
 * This is an example of how to use the \ref NRLinkTxRaw function.
 */

/**
 * Configure NRLink in raw IR transmit mode.
 * Configure the mindsensors NRLink device in raw IR transmit mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkTxRawEx(const byte port, const byte addr);
/** \example ex_NRLinkTxRawEx.nxc
 * This is an example of how to use the \ref NRLinkTxRawEx function.
 */

/**
 * Read NRLink status.
 * Read the status of the mindsensors NRLink device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \return The mindsensors NRLink status.
 */
inline byte NRLinkStatus(const byte port);
/** \example ex_NRLinkStatus.nxc
 * This is an example of how to use the \ref NRLinkStatus function.
 */

/**
 * Read NRLink status.
 * Read the status of the mindsensors NRLink device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \return The mindsensors NRLink status.
 */
inline byte NRLinkStatusEx(const byte port, const byte addr);
/** \example ex_NRLinkStatusEx.nxc
 * This is an example of how to use the \ref NRLinkStatusEx function.
 */

/**
 * Run NRLink macro.
 * Run the specified mindsensors NRLink device macro. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param macro The address of the macro to execute.
 * \return The function call result.
 */
inline char RunNRLinkMacro(const byte port, const byte macro);
/** \example ex_RunNRLinkMacro.nxc
 * This is an example of how to use the \ref RunNRLinkMacro function.
 */

/**
 * Run NRLink macro.
 * Run the specified mindsensors NRLink device macro. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param macro The address of the macro to execute.
 * \return The function call result.
 */
inline char RunNRLinkMacroEx(const byte port, const byte addr, const byte macro);
/** \example ex_RunNRLinkMacroEx.nxc
 * This is an example of how to use the \ref RunNRLinkMacroEx function.
 */

/**
 * Write data to NRLink.
 * Write data to the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param data A byte array containing the data to write.
 * \return The function call result.
 */
inline char WriteNRLinkBytes(const byte port, const byte data[]);
/** \example ex_WriteNRLinkBytes.nxc
 * This is an example of how to use the \ref WriteNRLinkBytes function.
 */

/**
 * Write data to NRLink.
 * Write data to the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param data A byte array containing the data to write.
 * \return The function call result.
 */
inline char WriteNRLinkBytesEx(const byte port, const byte addr, const byte data[]);
/** \example ex_WriteNRLinkBytesEx.nxc
 * This is an example of how to use the \ref WriteNRLinkBytesEx function.
 */

/**
 * Read data from NRLink.
 * Read data from the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param data A byte array that will contain the data read from the device on output.
 * \return The function call result.
 */
inline bool ReadNRLinkBytes(const byte port, byte & data[]);
/** \example ex_ReadNRLinkBytes.nxc
 * This is an example of how to use the \ref ReadNRLinkBytes function.
 */

/**
 * Read data from NRLink.
 * Read data from the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param data A byte array that will contain the data read from the device on output.
 * \return The function call result.
 */
inline bool ReadNRLinkBytesEx(const byte port, const byte addr, byte & data[]);
/** \example ex_ReadNRLinkBytesEx.nxc
 * This is an example of how to use the \ref ReadNRLinkBytesEx function.
 */

/**
 * MSIRTrain function.
 * Control an IR Train receiver set to the specified channel using the
 * mindsensors NRLink device. Valid func values are \ref TRAIN_FUNC_STOP,
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
inline char MSIRTrain(const byte port, const byte channel, const byte func);
/** \example ex_MSIRTrain.nxc
 * This is an example of how to use the \ref MSIRTrain function.
 */

/**
 * MSIRTrainEx function.
 * Control an IR Train receiver set to the specified channel using the
 * mindsensors NRLink device. Valid function values are \ref TRAIN_FUNC_STOP,
 * \ref TRAIN_FUNC_INCR_SPEED, \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT.
 * Valid channels are \ref TRAIN_CHANNEL_1 through \ref TRAIN_CHANNEL_3 and
 * \ref TRAIN_CHANNEL_ALL. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param channel The IR Train channel.  See \ref IRTrainChannels.
 * \param func The IR Train function. See \ref IRTrainFuncs
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSIRTrainEx(const byte port, const byte addr, const byte channel, const byte func);
/** \example ex_MSIRTrainEx.nxc
 * This is an example of how to use the \ref MSIRTrainEx function.
 */

/**
 * MSPFComboDirect function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the mindsensors NRLink device. Commands for outa and outb are
 * \ref PF_CMD_STOP, \ref PF_CMD_REV, \ref PF_CMD_FWD, and \ref PF_CMD_BRAKE. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param outb The Power Function command for output B. See \ref PFCmdConstants.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFComboDirect(const byte port, const byte channel, const byte outa, const byte outb);
/** \example ex_MSPFComboDirect.nxc
 * This is an example of how to use the \ref MSPFComboDirect function.
 */

/**
 * MSPFComboDirectEx function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the mindsensors NRLink device. Commands for outa and outb are
 * PF_CMD_STOP, PF_CMD_REV, PF_CMD_FWD, and \ref PF_CMD_BRAKE. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param outb The Power Function command for output B. See \ref PFCmdConstants.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFComboDirectEx(const byte port, const byte addr, const byte channel, const byte outa, const byte outb);
/** \example ex_MSPFComboDirectEx.nxc
 * This is an example of how to use the \ref MSPFComboDirectEx function.
 */

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
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function PWM command for output A. See \ref PFPWMOptions.
 * \param outb The Power Function PWM command for output B. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFComboPWM(const byte port, const byte channel, const byte outa, const byte outb);
/** \example ex_MSPFComboPWM.nxc
 * This is an example of how to use the \ref MSPFComboPWM function.
 */

/**
 * MSPFComboPWMEx function.
 * Control the speed of both outputs on a Power Function receiver set to the
 * specified channel using the mindsensors NRLink device. Valid output values
 * are \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function PWM command for output A. See \ref PFPWMOptions.
 * \param outb The Power Function PWM command for output B. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFComboPWMEx(const byte port, const byte addr, const byte channel, const byte outa, const byte outb);
/** \example ex_MSPFComboPWMEx.nxc
 * This is an example of how to use the \ref MSPFComboPWMEx function.
 */

/**
 * MSPFRawOutput function.
 * Control a Power Function receiver set to the specified channel using the
 * mindsensors NRLink device. Build the raw data stream using the 3 nibbles
 * (4 bit values). The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param nibble0 The first raw data nibble.
 * \param nibble1 The second raw data nibble.
 * \param nibble2 The third raw data nibble.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFRawOutput(const byte port, const byte nibble0, const byte nibble1, const byte nibble2);
/** \example ex_MSPFRawOutput.nxc
 * This is an example of how to use the \ref MSPFRawOutput function.
 */

/**
 * MSPFRawOutputEx function.
 * Control a Power Function receiver set to the specified channel using the
 * mindsensors NRLink device. Build the raw data stream using the 3 nibbles
 * (4 bit values). The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param nibble0 The first raw data nibble.
 * \param nibble1 The second raw data nibble.
 * \param nibble2 The third raw data nibble.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFRawOutputEx(const byte port, const byte addr, const byte nibble0, const byte nibble1, const byte nibble2);
/** \example ex_MSPFRawOutputEx.nxc
 * This is an example of how to use the \ref MSPFRawOutputEx function.
 */

/**
 * MSPFRepeat function.
 * Repeat sending the last Power Function command using the mindsensors
 * NRLink device. Specify the number of times to repeat the command and the
 * number of milliseconds of delay between each repetition. The port must be
 * configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param count The number of times to repeat the command.
 * \param delay The number of milliseconds to delay between each repetition.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFRepeat(const byte port, const byte count, const unsigned int delay);
/** \example ex_MSPFRepeat.nxc
 * This is an example of how to use the \ref MSPFRepeat function.
 */

/**
 * MSPFRepeatEx function.
 * Repeat sending the last Power Function command using the mindsensors
 * NRLink device. Specify the number of times to repeat the command and the
 * number of milliseconds of delay between each repetition. The port must be
 * configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param count The number of times to repeat the command.
 * \param delay The number of milliseconds to delay between each repetition.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
*/
inline char MSPFRepeatEx(const byte port, const byte addr, const byte count, const unsigned int delay);
/** \example ex_MSPFRepeatEx.nxc
 * This is an example of how to use the \ref MSPFRepeatEx function.
 */

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
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function CST function. See \ref PFCSTOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSingleOutputCST(const byte port, const byte channel, const byte out, const byte func);
/** \example ex_MSPFSingleOutputCST.nxc
 * This is an example of how to use the \ref MSPFSingleOutputCST function.
 */

/**
 * MSPFSingleOutputCSTEx function.
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
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function CST function. See \ref PFCSTOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSingleOutputCSTEx(const byte port, const byte addr, const byte channel, const byte out, const byte func);
/** \example ex_MSPFSingleOutputCSTEx.nxc
 * This is an example of how to use the \ref MSPFSingleOutputCSTEx function.
 */

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
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function PWM function. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSingleOutputPWM(const byte port, const byte channel, const byte out, const byte func);
/** \example ex_MSPFSingleOutputPWM.nxc
 * This is an example of how to use the \ref MSPFSingleOutputPWM function.
 */

/**
 * MSPFSingleOutputPWMEx function.
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
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function PWM function. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSingleOutputPWMEx(const byte port, const byte addr, const byte channel, const byte out, const byte func);
/** \example ex_MSPFSingleOutputPWMEx.nxc
 * This is an example of how to use the \ref MSPFSingleOutputPWMEx function.
 */

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
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param pin The Power Function pin. See \ref PFPinConstants.
 * \param func The Power Function single pin function. See \ref PFPinFuncs.
 * \param cont Control whether the mode is continuous or timeout.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSinglePin(const byte port, const byte channel, const byte out, const byte pin, const byte func, bool cont);
/** \example ex_MSPFSinglePin.nxc
 * This is an example of how to use the \ref MSPFSinglePin function.
 */

/**
 * MSPFSinglePinEx function.
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
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param pin The Power Function pin. See \ref PFPinConstants.
 * \param func The Power Function single pin function. See \ref PFPinFuncs.
 * \param cont Control whether the mode is continuous or timeout.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSinglePinEx(const byte port, const byte addr, const byte channel, const byte out, const byte pin, const byte func, bool cont);
/** \example ex_MSPFSinglePinEx.nxc
 * This is an example of how to use the \ref MSPFSinglePinEx function.
 */

/**
 * MSPFTrain function.
 * Control both outputs on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device as if it were an IR Train
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
inline char MSPFTrain(const byte port, const byte channel, const byte func);
/** \example ex_MSPFTrain.nxc
 * This is an example of how to use the \ref MSPFTrain function.
 */

/**
 * MSPFTrainEx function.
 * Control both outputs on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device as if it were an IR Train
 * receiver. Valid function values are \ref TRAIN_FUNC_STOP, \ref TRAIN_FUNC_INCR_SPEED,
 * \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param func The Power Function train function. See \ref IRTrainFuncs.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFTrainEx(const byte port, const byte addr, const byte channel, const byte func);
/** \example ex_MSPFTrainEx.nxc
 * This is an example of how to use the \ref MSPFTrainEx function.
 */

/**
 * MSRCXSetIRLinkPort function.
 * Set the global port in advance of using the MSRCX* and MSScout* API
 * functions for sending RCX and Scout messages over the mindsensors NRLink
 * device. The port must be configured as a Lowspeed port before using any of
 * the mindsensors RCX and Scout NRLink functions.
 *
 * \param port The sensor port. See \ref InPorts.
 */
inline void MSRCXSetNRLinkPort(const byte port);
/** \example ex_MSRCXSetNRLinkPort.nxc
 * This is an example of how to use the \ref MSRCXSetNRLinkPort function.
 */

/**
 * MSRCXSetIRLinkPortEx function.
 * Set the global port in advance of using the MSRCX* and MSScout* API
 * functions for sending RCX and Scout messages over the mindsensors NRLink
 * device. The port must be configured as a Lowspeed port before using any of
 * the mindsensors RCX and Scout NRLink functions.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param addr The sensor I2C address. See sensor documentation for this value.
 */
inline void MSRCXSetNRLinkPortEx(const byte port, const byte addr);
/** \example ex_MSRCXSetNRLinkPortEx.nxc
 * This is an example of how to use the \ref MSRCXSetNRLinkPortEx function.
 */

/**
 * MSRCXBatteryLevel function.
 * Send the BatteryLevel command to an RCX to read the current battery level.
 *
 * \return The RCX battery level.
 */
inline int MSRCXBatteryLevel(void);
/** \example ex_MSRCXBatteryLevel.nxc
 * This is an example of how to use the \ref MSRCXBatteryLevel function.
 */

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
/** \example ex_MSRCXPoll.nxc
 * This is an example of how to use the \ref MSRCXPoll function.
 */

/**
 * MSRCXPollMemory function.
 * Send the PollMemory command to an RCX.
 *
 * \param address The RCX memory address.
 * \return The value read from the specified address.
 */
inline int MSRCXPollMemory(const unsigned int address);
/** \example ex_MSRCXPollMemory.nxc
 * This is an example of how to use the \ref MSRCXPollMemory function.
 */

/**
 * MSRCXAbsVar function.
 * Send the AbsVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXAbsVar(const byte varnum, const byte byte src, const unsigned int value);
/** \example ex_MSRCXAbsVar.nxc
 * This is an example of how to use the \ref MSRCXAbsVar function.
 */

/**
 * MSRCXAddToDatalog function.
 * Send the AddToDatalog command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXAddToDatalog(const byte src, const unsigned int value);
/** \example ex_MSRCXAddToDatalog.nxc
 * This is an example of how to use the \ref MSRCXAddToDatalog function.
 */

/**
 * MSRCXAndVar function.
 * Send the AndVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXAndVar(const byte varnum, const byte src, const unsigned int value);
/** \example ex_MSRCXAndVar.nxc
 * This is an example of how to use the \ref MSRCXAndVar function.
 */

/**
 * MSRCXBoot function.
 * Send the Boot command to an RCX.
 */
inline void MSRCXBoot(void);
/** \example ex_MSRCXBoot.nxc
 * This is an example of how to use the \ref MSRCXBoot function.
 */

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
/** \example ex_MSRCXCalibrateEvent.nxc
 * This is an example of how to use the \ref MSRCXCalibrateEvent function.
 */

/**
 * MSRCXClearAllEvents function.
 * Send the ClearAllEvents command to an RCX.
 */
inline void MSRCXClearAllEvents(void);
/** \example ex_MSRCXClearAllEvents.nxc
 * This is an example of how to use the \ref MSRCXClearAllEvents function.
 */

/**
 * MSRCXClearCounter function.
 * Send the ClearCounter command to an RCX.
 *
 * \param counter The counter to clear.
 */
inline void MSRCXClearCounter(const byte counter);
/** \example ex_MSRCXClearCounter.nxc
 * This is an example of how to use the \ref MSRCXClearCounter function.
 */

/**
 * MSRCXClearMsg function.
 * Send the ClearMsg command to an RCX.
 */
inline void MSRCXClearMsg(void);
/** \example ex_MSRCXClearMsg.nxc
 * This is an example of how to use the \ref MSRCXClearMsg function.
 */

/**
 * MSRCXClearSensor function.
 * Send the ClearSensor command to an RCX.
 *
 * \param port The RCX port number.
 */
inline void MSRCXClearSensor(const byte port);
/** \example ex_MSRCXClearSensor.nxc
 * This is an example of how to use the \ref MSRCXClearSensor function.
 */

/**
 * MSRCXClearSound function.
 * Send the ClearSound command to an RCX.
 */
inline void MSRCXClearSound(void);
/** \example ex_MSRCXClearSound.nxc
 * This is an example of how to use the \ref MSRCXClearSound function.
 */

/**
 * MSRCXClearTimer function.
 * Send the ClearTimer command to an RCX.
 *
 * \param timer The timer to clear.
 */
inline void MSRCXClearTimer(const byte timer);
/** \example ex_MSRCXClearTimer.nxc
 * This is an example of how to use the \ref MSRCXClearTimer function.
 */

/**
 * MSRCXCreateDatalog function.
 * Send the CreateDatalog command to an RCX.
 *
 * \param size The new datalog size.
 */
inline void MSRCXCreateDatalog(const unsigned int size);
/** \example ex_MSRCXCreateDatalog.nxc
 * This is an example of how to use the \ref MSRCXCreateDatalog function.
 */

/**
 * MSRCXDecCounter function.
 * Send the DecCounter command to an RCX.
 *
 * \param counter The counter to decrement.
 */
inline void MSRCXDecCounter(const byte counter);
/** \example ex_MSRCXDecCounter.nxc
 * This is an example of how to use the \ref MSRCXDecCounter function.
 */

/**
 * MSRCXDeleteSub function.
 * Send the DeleteSub command to an RCX.
 *
 * \param s The subroutine number to delete.
 */
inline void MSRCXDeleteSub(const byte s);
/** \example ex_MSRCXDeleteSub.nxc
 * This is an example of how to use the \ref MSRCXDeleteSub function.
 */

/**
 * MSRCXDeleteSubs function.
 * Send the DeleteSubs command to an RCX.
 */
inline void MSRCXDeleteSubs(void);
/** \example ex_MSRCXDeleteSubs.nxc
 * This is an example of how to use the \ref MSRCXDeleteSubs function.
 */

/**
 * MSRCXDeleteTask function.
 * Send the DeleteTask command to an RCX.
 *
 * \param t The task number to delete.
 */
inline void MSRCXDeleteTask(const byte t);
/** \example ex_MSRCXDeleteTask.nxc
 * This is an example of how to use the \ref MSRCXDeleteTask function.
 */

/**
 * MSRCXDeleteTasks function.
 * Send the DeleteTasks command to an RCX.
 */
inline void MSRCXDeleteTasks(void);
/** \example ex_MSRCXDeleteTasks.nxc
 * This is an example of how to use the \ref MSRCXDeleteTasks function.
 */

/**
 * MSRCXDisableOutput function.
 * Send the DisableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to disable. See \ref RCXOutputConstants.
 */
inline void MSRCXDisableOutput(const byte outputs);
/** \example ex_MSRCXDisableOutput.nxc
 * This is an example of how to use the \ref MSRCXDisableOutput function.
 */

/**
 * MSRCXDivVar function.
 * Send the DivVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXDivVar(const byte varnum, const byte src, const unsigned int value);
/** \example ex_MSRCXDivVar.nxc
 * This is an example of how to use the \ref MSRCXDivVar function.
 */

/**
 * MSRCXEnableOutput function.
 * Send the EnableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to enable. See \ref RCXOutputConstants.
 */
inline void MSRCXEnableOutput(const byte outputs);
/** \example ex_MSRCXEnableOutput.nxc
 * This is an example of how to use the \ref MSRCXEnableOutput function.
 */

/**
 * MSRCXEvent function.
 * Send the Event command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXEvent(const byte src, const unsigned int value);
/** \example ex_MSRCXEvent.nxc
 * This is an example of how to use the \ref MSRCXEvent function.
 */

/**
 * MSRCXFloat function.
 * Send commands to an RCX to float the specified outputs.
 *
 * \param outputs The RCX output(s) to float. See \ref RCXOutputConstants.
 */
inline void MSRCXFloat(const byte outputs);
/** \example ex_MSRCXFloat.nxc
 * This is an example of how to use the \ref MSRCXFloat function.
 */

/**
 * MSRCXFwd function.
 * Send commands to an RCX to set the specified outputs to the forward direction.
 *
 * \param outputs The RCX output(s) to set forward. See \ref RCXOutputConstants.
 */
inline void MSRCXFwd(const byte outputs);
/** \example ex_MSRCXFwd.nxc
 * This is an example of how to use the \ref MSRCXFwd function.
 */

/**
 * MSRCXIncCounter function.
 * Send the IncCounter command to an RCX.
 *
 * \param counter The counter to increment.
 */
inline void MSRCXIncCounter(const byte counter);
/** \example ex_MSRCXIncCounter.nxc
 * This is an example of how to use the \ref MSRCXIncCounter function.
 */

/**
 * MSRCXInvertOutput function.
 * Send the InvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to invert. See \ref RCXOutputConstants.
 */
inline void MSRCXInvertOutput(const byte outputs);
/** \example ex_MSRCXInvertOutput.nxc
 * This is an example of how to use the \ref MSRCXInvertOutput function.
 */

/**
 * MSRCXMulVar function.
 * Send the MulVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXMulVar(const byte varnum, const byte src, unsigned int value);
/** \example ex_MSRCXMulVar.nxc
 * This is an example of how to use the \ref MSRCXMulVar function.
 */

/**
 * MSRCXMuteSound function.
 * Send the MuteSound command to an RCX.
 */
inline void MSRCXMuteSound(void);
/** \example ex_MSRCXMuteSound.nxc
 * This is an example of how to use the \ref MSRCXMuteSound function.
 */

/**
 * MSRCXObvertOutput function.
 * Send the ObvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to obvert. See \ref RCXOutputConstants.
 */
inline void MSRCXObvertOutput(const byte outputs);
/** \example ex_MSRCXObvertOutput.nxc
 * This is an example of how to use the \ref MSRCXObvertOutput function.
 */

/**
 * MSRCXOff function.
 * Send commands to an RCX to turn off the specified outputs.
 *
 * \param outputs The RCX output(s) to turn off. See \ref RCXOutputConstants.
 */
inline void MSRCXOff(const byte outputs);
/** \example ex_MSRCXOff.nxc
 * This is an example of how to use the \ref MSRCXOff function.
 */

/**
 * MSRCXOn function.
 * Send commands to an RCX to turn on the specified outputs.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 */
inline void MSRCXOn(const byte outputs);
/** \example ex_MSRCXOn.nxc
 * This is an example of how to use the \ref MSRCXOn function.
 */

/**
 * MSRCXOnFor function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction for the specified duration.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 * \param ms The number of milliseconds to leave the outputs on
 */
inline void MSRCXOnFor(const byte outputs, const unsigned int ms);
/** \example ex_MSRCXOnFor.nxc
 * This is an example of how to use the \ref MSRCXOnFor function.
 */

/**
 * MSRCXOnFwd function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction.
 *
 * \param outputs The RCX output(s) to turn on in the forward direction. See \ref RCXOutputConstants.
 */
inline void MSRCXOnFwd(const byte outputs);
/** \example ex_MSRCXOnFwd.nxc
 * This is an example of how to use the \ref MSRCXOnFwd function.
 */

/**
 * MSRCXOnRev function.
 * Send commands to an RCX to turn on the specified outputs in the reverse direction.
 *
 * \param outputs The RCX output(s) to turn on in the reverse direction. See \ref RCXOutputConstants.
 */
inline void MSRCXOnRev(const byte outputs);
/** \example ex_MSRCXOnRev.nxc
 * This is an example of how to use the \ref MSRCXOnRev function.
 */

/**
 * MSRCXOrVar function.
 * Send the OrVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXOrVar(const byte varnum, const byte src, const unsigned int value);
/** \example ex_MSRCXOrVar.nxc
 * This is an example of how to use the \ref MSRCXOrVar function.
 */

/**
 * MSRCXPBTurnOff function.
 * Send the PBTurnOff command to an RCX.
 */
inline void MSRCXPBTurnOff(void);
/** \example ex_MSRCXPBTurnOff.nxc
 * This is an example of how to use the \ref MSRCXPBTurnOff function.
 */

/**
 * MSRCXPing function.
 * Send the Ping command to an RCX.
 */
inline void MSRCXPing(void);
/** \example ex_MSRCXPing.nxc
 * This is an example of how to use the \ref MSRCXPing function.
 */

/**
 * MSRCXPlaySound function.
 * Send the PlaySound command to an RCX.
 *
 * \param snd The sound number to play.
 */
inline void MSRCXPlaySound(const byte snd);
/** \example ex_MSRCXPlaySound.nxc
 * This is an example of how to use the \ref MSRCXPlaySound function.
 */

/**
 * MSRCXPlayTone function.
 * Send the PlayTone command to an RCX.
 *
 * \param freq The frequency of the tone to play.
 * \param duration The duration of the tone to play.
 */
inline void MSRCXPlayTone(const unsigned int freq, const byte duration);
/** \example ex_MSRCXPlayTone.nxc
 * This is an example of how to use the \ref MSRCXPlayTone function.
 */

/**
 * MSRCXPlayToneVar function.
 * Send the PlayToneVar command to an RCX.
 *
 * \param varnum The variable containing the tone frequency to play.
 * \param duration The duration of the tone to play.
 */
inline void MSRCXPlayToneVar(const byte varnum, const byte duration);
/** \example ex_MSRCXPlayToneVar.nxc
 * This is an example of how to use the \ref MSRCXPlayToneVar function.
 */

/**
 * MSRCXRemote function.
 * Send the Remote command to an RCX.
 *
 * \param cmd The RCX IR remote command to send. See \ref RCXRemoteConstants.
 */
inline void MSRCXRemote(unsigned int cmd);
/** \example ex_MSRCXRemote.nxc
 * This is an example of how to use the \ref MSRCXRemote function.
 */

/**
 * MSRCXReset function.
 * Send the Reset command to an RCX.
 */
inline void MSRCXReset(void);
/** \example ex_MSRCXReset.nxc
 * This is an example of how to use the \ref MSRCXReset function.
 */

/**
 * MSRCXRev function.
 * Send commands to an RCX to set the specified outputs to the reverse direction.
 *
 * \param outputs The RCX output(s) to reverse direction. See \ref RCXOutputConstants.
 */
inline void MSRCXRev(const byte outputs);
/** \example ex_MSRCXRev.nxc
 * This is an example of how to use the \ref MSRCXRev function.
 */

/**
 * MSRCXSelectDisplay function.
 * Send the SelectDisplay command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSelectDisplay(const byte src, const unsigned int value);
/** \example ex_MSRCXSelectDisplay.nxc
 * This is an example of how to use the \ref MSRCXSelectDisplay function.
 */

/**
 * MSRCXSelectProgram function.
 * Send the SelectProgram command to an RCX.
 *
 * \param prog The program number to select.
 */
inline void MSRCXSelectProgram(const byte prog);
/** \example ex_MSRCXSelectProgram.nxc
 * This is an example of how to use the \ref MSRCXSelectProgram function.
 */

/**
 * MSRCXSendSerial function.
 * Send the SendSerial command to an RCX.
 *
 * \param first The first byte address.
 * \param count The number of bytes to send.
 */
inline void MSRCXSendSerial(const byte first, const byte count);
/** \example ex_MSRCXSendSerial.nxc
 * This is an example of how to use the \ref MSRCXSendSerial function.
 */

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
/** \example ex_MSRCXSet.nxc
 * This is an example of how to use the \ref MSRCXSet function.
 */

/**
 * MSRCXSetDirection function.
 * Send the SetDirection command to an RCX to configure the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to set direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void MSRCXSetDirection(const byte outputs, const byte dir);
/** \example ex_MSRCXSetDirection.nxc
 * This is an example of how to use the \ref MSRCXSetDirection function.
 */

/**
 * MSRCXSetEvent function.
 * Send the SetEvent command to an RCX.
 *
 * \param evt The event number to set.
 * \param src The RCX source. See \ref RCXSourceConstants.
 * \param type The event type.
 */
inline void MSRCXSetEvent(const byte evt, const byte src, const byte type);
/** \example ex_MSRCXSetEvent.nxc
 * This is an example of how to use the \ref MSRCXSetEvent function.
 */

/**
 * MSRCXSetGlobalDirection function.
 * Send the SetGlobalDirection command to an RCX.
 *
 * \param outputs The RCX output(s) to set global direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void MSRCXSetGlobalDirection(const byte outputs, const byte dir);
/** \example ex_MSRCXSetGlobalDirection.nxc
 * This is an example of how to use the \ref MSRCXSetGlobalDirection function.
 */

/**
 * MSRCXSetGlobalOutput function.
 * Send the SetGlobalOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to set global mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void MSRCXSetGlobalOutput(const byte outputs, const byte mode);
/** \example ex_MSRCXSetGlobalOutput.nxc
 * This is an example of how to use the \ref MSRCXSetGlobalOutput function.
 */

/**
 * MSRCXSetMaxPower function.
 * Send the SetMaxPower command to an RCX.
 *
 * \param outputs The RCX output(s) to set max power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void MSRCXSetMaxPower(const byte outputs, const byte pwrsrc, const byte pwrval);
/** \example ex_MSRCXSetMaxPower.nxc
 * This is an example of how to use the \ref MSRCXSetMaxPower function.
 */

/**
 * MSRCXSetMessage function.
 * Send the SetMessage command to an RCX.
 *
 * \param msg The numeric message to send.
 */
inline void MSRCXSetMessage(const byte msg);
/** \example ex_MSRCXSetMessage.nxc
 * This is an example of how to use the \ref MSRCXSetMessage function.
 */

/**
 * MSRCXSetOutput function.
 * Send the SetOutput command to an RCX to configure the mode of the specified outputs
 *
 * \param outputs The RCX output(s) to set mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void MSRCXSetOutput(const byte outputs, const byte mode);
/** \example ex_MSRCXSetOutput.nxc
 * This is an example of how to use the \ref MSRCXSetOutput function.
 */

/**
 * MSRCXSetPower function.
 * Send the SetPower command to an RCX to configure the power level of the specified outputs.
 *
 * \param outputs The RCX output(s) to set power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void MSRCXSetPower(const byte outputs, const byte pwrsrc, const byte pwrval);
/** \example ex_MSRCXSetPower.nxc
 * This is an example of how to use the \ref MSRCXSetPower function.
 */

/**
 * MSRCXSetPriority function.
 * Send the SetPriority command to an RCX.
 *
 * \param p The new task priority.
 */
inline void MSRCXSetPriority(const byte p);
/** \example ex_MSRCXSetPriority.nxc
 * This is an example of how to use the \ref MSRCXSetPriority function.
 */

/**
 * MSRCXSetSensorMode function.
 * Send the SetSensorMode command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param mode The RCX sensor mode.
 */
inline void MSRCXSetSensorMode(const byte port, const byte mode);
/** \example ex_MSRCXSetSensorMode.nxc
 * This is an example of how to use the \ref MSRCXSetSensorMode function.
 */

/**
 * MSRCXSetSensorType function.
 * Send the SetSensorType command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param type The RCX sensor type.
 */
inline void MSRCXSetSensorType(const byte port, const byte type);
/** \example ex_MSRCXSetSensorType.nxc
 * This is an example of how to use the \ref MSRCXSetSensorType function.
 */

/**
 * MSRCXSetSleepTime function.
 * Send the SetSleepTime command to an RCX.
 *
 * \param t The new sleep time value.
 */
inline void MSRCXSetSleepTime(const byte t);
/** \example ex_MSRCXSetSleepTime.nxc
 * This is an example of how to use the \ref MSRCXSetSleepTime function.
 */

/**
 * MSRCXSetTxPower function.
 * Send the SetTxPower command to an RCX.
 *
 * \param pwr The IR transmit power level.
 */
inline void MSRCXSetTxPower(const byte pwr);
/** \example ex_MSRCXSetTxPower.nxc
 * This is an example of how to use the \ref MSRCXSetTxPower function.
 */

/**
 * MSRCXSetUserDisplay function.
 * Send the SetUserDisplay command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 * \param precision The number of digits of precision.
 */
inline void MSRCXSetUserDisplay(const byte src, const unsigned int value, const byte precision);
/** \example ex_MSRCXSetUserDisplay.nxc
 * This is an example of how to use the \ref MSRCXSetUserDisplay function.
 */

/**
 * MSRCXSetVar function.
 * Send the SetVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSetVar(const byte varnum, const byte src, const unsigned int value);
/** \example ex_MSRCXSetVar.nxc
 * This is an example of how to use the \ref MSRCXSetVar function.
 */

/**
 * MSRCXSetWatch function.
 * Send the SetWatch command to an RCX.
 *
 * \param hours The new watch time hours value.
 * \param minutes The new watch time minutes value.
 */
inline void MSRCXSetWatch(const byte hours, const byte minutes);
/** \example ex_MSRCXSetWatch.nxc
 * This is an example of how to use the \ref MSRCXSetWatch function.
 */

/**
 * MSRCXSgnVar function.
 * Send the SgnVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSgnVar(const byte varnum, const byte src, const unsigned int value);
/** \example ex_MSRCXSgnVar.nxc
 * This is an example of how to use the \ref MSRCXSgnVar function.
 */

/**
 * MSRCXStartTask function.
 * Send the StartTask command to an RCX.
 *
 * \param t The task number to start.
 */
inline void MSRCXStartTask(const byte t);
/** \example ex_MSRCXStartTask.nxc
 * This is an example of how to use the \ref MSRCXStartTask function.
 */

/**
 * MSRCXStopAllTasks function.
 * Send the StopAllTasks command to an RCX.
 */
inline void MSRCXStopAllTasks(void);
/** \example ex_MSRCXStopAllTasks.nxc
 * This is an example of how to use the \ref MSRCXStopAllTasks function.
 */

/**
 * MSRCXStopTask function.
 * Send the StopTask command to an RCX.
 *
 * \param t The task number to stop.
 */
inline void MSRCXStopTask(const byte t);
/** \example ex_MSRCXStopTask.nxc
 * This is an example of how to use the \ref MSRCXStopTask function.
 */

/**
 * MSRCXSubVar function.
 * Send the SubVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSubVar(const byte varnum, const byte src, const unsigned int value);
/** \example ex_MSRCXSubVar.nxc
 * This is an example of how to use the \ref MSRCXSubVar function.
 */

/**
 * MSRCXSumVar function.
 * Send the SumVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSumVar(const byte varnum, const byte src, const unsigned int value);
/** \example ex_MSRCXSumVar.nxc
 * This is an example of how to use the \ref MSRCXSumVar function.
 */

/**
 * MSRCXToggle function.
 * Send commands to an RCX to toggle the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to toggle. See \ref RCXOutputConstants.
 */
inline void MSRCXToggle(const byte outputs);
/** \example ex_MSRCXToggle.nxc
 * This is an example of how to use the \ref MSRCXToggle function.
 */

/**
 * MSRCXUnlock function.
 * Send the Unlock command to an RCX.
 */
inline void MSRCXUnlock(void);
/** \example ex_MSRCXUnlock.nxc
 * This is an example of how to use the \ref MSRCXUnlock function.
 */

/**
 * MSRCXUnmuteSound function.
 * Send the UnmuteSound command to an RCX.
 */
inline void MSRCXUnmuteSound(void);
/** \example ex_MSRCXUnmuteSound.nxc
 * This is an example of how to use the \ref MSRCXUnmuteSound function.
 */

/**
 * MSScoutCalibrateSensor function.
 * Send the CalibrateSensor command to a Scout.
 */
inline void MSScoutCalibrateSensor(void);
/** \example ex_MSScoutCalibrateSensor.nxc
 * This is an example of how to use the \ref MSScoutCalibrateSensor function.
 */

/**
 * MSScoutMuteSound function.
 * Send the MuteSound command to a Scout.
 */
inline void MSScoutMuteSound(void);
/** \example ex_MSScoutMuteSound.nxc
 * This is an example of how to use the \ref MSScoutMuteSound function.
 */

/**
 * MSScoutSelectSounds function.
 * Send the SelectSounds command to a Scout.
 *
 * \param grp The Scout sound group to select.
 */
inline void MSScoutSelectSounds(const byte grp);
/** \example ex_MSScoutSelectSounds.nxc
 * This is an example of how to use the \ref MSScoutSelectSounds function.
 */

/**
 * MSScoutSendVLL function.
 * Send the SendVLL command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSendVLL(const byte src, const unsigned int value);
/** \example ex_MSScoutSendVLL.nxc
 * This is an example of how to use the \ref MSScoutSendVLL function.
 */

/**
 * MSScoutSetCounterLimit function.
 * Send the SetCounterLimit command to a Scout.
 *
 * \param ctr The counter for which to set the limit.
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetCounterLimit(const byte ctr, const byte src, const unsigned int value);
/** \example ex_MSScoutSetCounterLimit.nxc
 * This is an example of how to use the \ref MSScoutSetCounterLimit function.
 */

/**
 * MSScoutSetEventFeedback function.
 * Send the SetEventFeedback command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetEventFeedback(const byte src, const unsigned int value);
/** \example ex_MSScoutSetEventFeedback.nxc
 * This is an example of how to use the \ref MSScoutSetEventFeedback function.
 */

/**
 * MSScoutSetLight function.
 * Send the SetLight command to a Scout.
 *
 * \param x Set the light on or off using this value. See \ref ScoutLightConstants.
 */
inline void MSScoutSetLight(const byte x);
/** \example ex_MSScoutSetLight.nxc
 * This is an example of how to use the \ref MSScoutSetLight function.
 */

/**
 * MSScoutSetScoutMode function.
 * Send the SetScoutMode command to a Scout.
 *
 * \param mode Set the scout mode. See \ref ScoutModeConstants.
*/
inline void MSScoutSetScoutMode(const byte mode);
/** \example ex_MSScoutSetScoutMode.nxc
 * This is an example of how to use the \ref MSScoutSetScoutMode function.
 */

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
/** \example ex_MSScoutSetScoutRules.nxc
 * This is an example of how to use the \ref MSScoutSetScoutRules function.
 */

/**
 * MSScoutSetSensorClickTime function.
 * Send the SetSensorClickTime command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorClickTime(const byte src, const unsigned int value);
/** \example ex_MSScoutSetSensorClickTime.nxc
 * This is an example of how to use the \ref MSScoutSetSensorClickTime function.
 */

/**
 * MSScoutSetSensorHysteresis function.
 * Send the SetSensorHysteresis command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorHysteresis(const byte src, const unsigned int value);
/** \example ex_MSScoutSetSensorHysteresis.nxc
 * This is an example of how to use the \ref MSScoutSetSensorHysteresis function.
 */

/**
 * MSScoutSetSensorLowerLimit function.
 * Send the SetSensorLowerLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorLowerLimit(const byte src, const unsigned int value);
/** \example ex_MSScoutSetSensorLowerLimit.nxc
 * This is an example of how to use the \ref MSScoutSetSensorLowerLimit function.
 */

/**
 * MSScoutSetSensorUpperLimit function.
 * Send the SetSensorUpperLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorUpperLimit(const byte src, const unsigned int value);
/** \example ex_MSScoutSetSensorUpperLimit.nxc
 * This is an example of how to use the \ref MSScoutSetSensorUpperLimit function.
 */

/**
 * MSScoutSetTimerLimit function.
 * Send the SetTimerLimit command to a Scout.
 *
 * \param tmr The timer for which to set a limit.
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetTimerLimit(const byte tmr, const byte src, const unsigned int value);
/** \example ex_MSScoutSetTimerLimit.nxc
 * This is an example of how to use the \ref MSScoutSetTimerLimit function.
 */

/**
 * MSScoutUnmuteSound function.
 * Send the UnmuteSound command to a Scout.
 */
inline void MSScoutUnmuteSound(void);
/** \example ex_MSScoutUnmuteSound.nxc
 * This is an example of how to use the \ref MSScoutUnmuteSound function.
 */

#else

#define SensorMSPressureRaw(_p) asm { getin __RETVAL__, _p, RawValue }

#define SensorMSCompass(_port) asm { ReadSensorMSCompass(_port, __RETVAL__) }
#define SensorMSCompassEx(_port, _addr) asm { ReadSensorMSCompassEx(_port, _addr, __RETVAL__) }

#define ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year) asm { __ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, __RETVAL__) }

#define ReadSensorMSTilt(_port, _x, _y, _z) asm { __ReadSensorMSTiltEx(_port, 0x02, _x, _y, _z, __RETVAL__) }
#define ReadSensorMSTiltEx(_port, _addr, _x, _y, _z) asm { __ReadSensorMSTiltEx(_port, _addr, _x, _y, _z, __RETVAL__) }

#define ReadSensorMSAccel(_port, _x, _y, _z) asm { __ReadSensorMSAccelEx(_port, 0x02, _x, _y, _z, __RETVAL__) }
#define ReadSensorMSAccelEx(_port, _addr, _x, _y, _z) asm { __ReadSensorMSAccelEx(_port, _addr, _x, _y, _z, __RETVAL__) }

#define MSReadValueEx(_port, _addr, _reg, _bytes) asm { __MSReadValue(_port, _addr, _reg, _bytes, __RETVAL__, __TMPBYTE__) }
#define MSReadValue(_port, _reg, _bytes) asm { __MSReadValue(_port, 0x02, _reg, _bytes, __RETVAL__, __TMPBYTE__) }

#define MSEnergize(_port) asm { __I2CSendCmd(_port, 0x02, MS_CMD_ENERGIZED, __RETVAL__) }
#define MSEnergizeEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, MS_CMD_ENERGIZED, __RETVAL__) }
#define MSDeenergize(_port) asm { __I2CSendCmd(_port, 0x02, MS_CMD_DEENERGIZED, __RETVAL__) }
#define MSDeenergizeEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, MS_CMD_DEENERGIZED, __RETVAL__) }
#define MSADPAOn(_port) asm { __I2CSendCmd(_port, 0x02, MS_CMD_ADPA_ON, __RETVAL__) }
#define MSADPAOnEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, MS_CMD_ADPA_ON, __RETVAL__) }
#define MSADPAOff(_port) asm { __I2CSendCmd(_port, 0x02, MS_CMD_ADPA_OFF, __RETVAL__) }
#define MSADPAOffEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, MS_CMD_ADPA_OFF, __RETVAL__) }

#define DISTNxGP2D12(_port) asm { __I2CSendCmd(_port, 0x02, DIST_CMD_GP2D12, __RETVAL__) }
#define DISTNxGP2D120(_port) asm { __I2CSendCmd(_port, 0x02, DIST_CMD_GP2D120, __RETVAL__) }
#define DISTNxGP2YA21(_port) asm { __I2CSendCmd(_port, 0x02, DIST_CMD_GP2YA21, __RETVAL__) }
#define DISTNxGP2YA02(_port) asm { __I2CSendCmd(_port, 0x02, DIST_CMD_GP2YA02, __RETVAL__) }
#define DISTNxDistance(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_DIST, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxVoltage(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_VOLT, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxModuleType(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_MODULE_TYPE, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxNumPoints(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_NUM_POINTS, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxMinDistance(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_DIST_MIN, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxMaxDistance(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_DIST_MAX, 2, __RETVAL__, __TMPBYTE__) }

#define DISTNxGP2D12Ex(_port, _addr) asm { __I2CSendCmd(_port, _addr, DIST_CMD_GP2D12, __RETVAL__) }
#define DISTNxGP2D120Ex(_port, _addr) asm { __I2CSendCmd(_port, _addr, DIST_CMD_GP2D120, __RETVAL__) }
#define DISTNxGP2YA21Ex(_port, _addr) asm { __I2CSendCmd(_port, _addr, DIST_CMD_GP2YA21, __RETVAL__) }
#define DISTNxGP2YA02Ex(_port, _addr) asm { __I2CSendCmd(_port, _addr, DIST_CMD_GP2YA02, __RETVAL__) }
#define DISTNxDistanceEx(_port, _addr) asm { __MSReadValue(_port, _addr, DIST_REG_DIST, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxVoltageEx(_port, _addr) asm { __MSReadValue(_port, _addr, DIST_REG_VOLT, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxModuleTypeEx(_port, _addr) asm { __MSReadValue(_port, _addr, DIST_REG_MODULE_TYPE, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxNumPointsEx(_port, _addr) asm { __MSReadValue(_port, _addr, DIST_REG_NUM_POINTS, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxMinDistanceEx(_port, _addr) asm { __MSReadValue(_port, _addr, DIST_REG_DIST_MIN, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxMaxDistanceEx(_port, _addr) asm { __MSReadValue(_port, _addr, DIST_REG_DIST_MAX, 2, __RETVAL__, __TMPBYTE__) }

#define SensorMSDROD(_p) asm { getin __RETVAL__, _p, NormalizedValue }

#define PSPNxDigital(_port) asm { __I2CSendCmd(_port, 0x02, PSP_CMD_DIGITAL, __RETVAL__) }
#define PSPNxDigitalEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, PSP_CMD_DIGITAL, __RETVAL__) }
#define PSPNxAnalog(_port) asm { __I2CSendCmd(_port, 0x02, PSP_CMD_ANALOG, __RETVAL__) }
#define PSPNxAnalogEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, PSP_CMD_ANALOG, __RETVAL__) }

#define ReadSensorMSPlayStationEx(_port, _addr, _b1, _b2, _xleft, _yleft, _xright, _yright) asm { __ReadSensorMSPlayStationEx(_port, _addr, _b1, _b2, _xleft, _yleft, _xright, _yright, __RETVAL__) }
#define ReadSensorMSPlayStation(_port, _b1, _b2, _xleft, _yleft, _xright, _yright) ReadSensorMSPlayStationEx(_port, 0x02, _b1, _b2, _xleft, _yleft, _xright, _yright)

#define NRLink2400(_port) asm { __I2CSendCmd(_port, 0x02, NRLINK_CMD_2400, __RETVAL__) }
#define NRLink4800(_port) asm { __I2CSendCmd(_port, 0x02, NRLINK_CMD_4800, __RETVAL__) }
#define NRLinkFlush(_port) asm { __I2CSendCmd(_port, 0x02, NRLINK_CMD_FLUSH, __RETVAL__) }
#define NRLinkIRLong(_port) asm { __I2CSendCmd(_port, 0x02, NRLINK_CMD_IR_LONG, __RETVAL__) }
#define NRLinkIRShort(_port) asm { __I2CSendCmd(_port, 0x02, NRLINK_CMD_IR_SHORT, __RETVAL__) }
#define NRLinkTxRaw(_port) asm { __I2CSendCmd(_port, 0x02, NRLINK_CMD_TX_RAW, __RETVAL__) }
#define NRLinkSetRCX(_port) asm { __I2CSendCmd(_port, 0x02, NRLINK_CMD_SET_RCX, __RETVAL__) }
#define NRLinkSetTrain(_port) asm { __I2CSendCmd(_port, 0x02, NRLINK_CMD_SET_TRAIN, __RETVAL__) }
#define NRLinkSetPF(_port) asm { __I2CSendCmd(_port, 0x02, NRLINK_CMD_SET_PF, __RETVAL__) }

#define NRLink2400Ex(_port, _addr) asm { __I2CSendCmd(_port, _addr, NRLINK_CMD_2400, __RETVAL__) }
#define NRLink4800Ex(_port, _addr) asm { __I2CSendCmd(_port, _addr, NRLINK_CMD_4800, __RETVAL__) }
#define NRLinkFlushEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, NRLINK_CMD_FLUSH, __RETVAL__) }
#define NRLinkIRLongEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, NRLINK_CMD_IR_LONG, __RETVAL__) }
#define NRLinkIRShortEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, NRLINK_CMD_IR_SHORT, __RETVAL__) }
#define NRLinkTxRawEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, NRLINK_CMD_TX_RAW, __RETVAL__) }
#define NRLinkSetRCXEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, NRLINK_CMD_SET_RCX, __RETVAL__) }
#define NRLinkSetTrainEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, NRLINK_CMD_SET_TRAIN, __RETVAL__) }
#define NRLinkSetPFEx(_port, _addr) asm { __I2CSendCmd(_port, _addr, NRLINK_CMD_SET_PF, __RETVAL__) }

#define RunNRLinkMacroEx(_port, _addr, _macro) asm { __RunNRLinkMacroEx(_port, _addr, _macro, __RETVAL__) }
#define RunNRLinkMacro(_port, _macro) asm { __RunNRLinkMacroEx(_port, 0x02, _macro, __RETVAL__) }

#define NRLinkStatusEx(_port, _addr) asm { ReadNRLinkStatusEx(_port, _addr, __RETVAL__, __TMPBYTE__) }
#define NRLinkStatus(_port) asm { ReadNRLinkStatusEx(_port, 0x02, __RETVAL__, __TMPBYTE__) }

#define WriteNRLinkBytesEx(_port, _addr, _bytes) asm { __WriteNRLinkBytes(_port, _addr, _bytes, __RETVAL__) }
#define WriteNRLinkBytes(_port, _bytes) asm { __WriteNRLinkBytes(_port, 0x02, _bytes, __RETVAL__) }

#define ReadNRLinkBytesEx(_port, _addr, _bytes) asm { __ReadNRLinkBytes(_port, _addr, _bytes, __RETVAL__) }
#define ReadNRLinkBytes(_port, _bytes) asm { __ReadNRLinkBytes(_port, 0x02, _bytes, __RETVAL__) }

#define MSPFComboDirectEx(_port, _addr, _channel, _outa, _outb) asm { __MSPFComboDirect(_port, _addr, _channel, _outa, _outb, __RETVAL__) }
#define MSPFComboDirect(_port, _channel, _outa, _outb) asm { __MSPFComboDirect(_port, 0x02, _channel, _outa, _outb, __RETVAL__) }
#define MSPFSinglePinEx(_port, _addr, _channel, _out, _pin, _func, _cont) asm { __MSPFSinglePin(_port, _addr, _channel, _out, _pin, _func, _cont, __RETVAL__) }
#define MSPFSinglePin(_port, _channel, _out, _pin, _func, _cont) asm { __MSPFSinglePin(_port, 0x02, _channel, _out, _pin, _func, _cont, __RETVAL__) }
#define MSPFSingleOutputCSTEx(_port, _addr, _channel, _out, _func) asm { __MSPFSingleOutput(_port, _addr, _channel, _out, _func, TRUE, __RETVAL__) }
#define MSPFSingleOutputCST(_port, _channel, _out, _func) asm { __MSPFSingleOutput(_port, 0x02, _channel, _out, _func, TRUE, __RETVAL__) }
#define MSPFSingleOutputPWMEx(_port, _addr, _channel, _out, _func) asm { __MSPFSingleOutput(_port, _addr, _channel, _out, _func, FALSE, __RETVAL__) }
#define MSPFSingleOutputPWM(_port, _channel, _out, _func) asm { __MSPFSingleOutput(_port, 0x02, _channel, _out, _func, FALSE, __RETVAL__) }
#define MSPFComboPWMEx(_port, _addr, _channel, _outa, _outb) asm { __MSPFComboPWM(_port, _addr, _channel, _outa, _outb, __RETVAL__) }
#define MSPFComboPWM(_port, _channel, _outa, _outb) asm { __MSPFComboPWM(_port, 0x02, _channel, _outa, _outb, __RETVAL__) }
#define MSPFTrainEx(_port, _addr, _channel, _func) asm { __MSIRTrain(_port, _addr, _channel, _func, TRUE, __RETVAL__) }
#define MSPFTrain(_port, _channel, _func) asm { __MSIRTrain(_port, 0x02, _channel, _func, TRUE, __RETVAL__) }
#define MSIRTrainEx(_port, _addr, _channel, _func) asm { __MSIRTrain(_port, _addr, _channel, _func, FALSE, __RETVAL__) }
#define MSIRTrain(_port, _channel, _func) asm { __MSIRTrain(_port, 0x02, _channel, _func, FALSE, __RETVAL__) }
#define MSPFRawOutputEx(_port, _addr, _nibble0, _nibble1, _nibble2) asm { __MSPFRawOutput(_port, _addr, _nibble0, _nibble1, _nibble2, __RETVAL__) }
#define MSPFRawOutput(_port, _nibble0, _nibble1, _nibble2) asm { __MSPFRawOutput(_port, 0x02, _nibble0, _nibble1, _nibble2, __RETVAL__) }
#define MSPFRepeatEx(_port, _addr, _count, _delay) asm { __MSPFRepeatLastCommand(_port, _addr, _count, _delay, __RETVAL__) }
#define MSPFRepeat(_port, _count, _delay) asm { __MSPFRepeatLastCommand(_port, 0x02, _count, _delay, __RETVAL__) }

#define MSRCXSetNRLinkPortEx(_port, _addr) asm { __MSRCXSetNRLink(_port, _addr) }
#define MSRCXSetNRLinkPort(_port) asm { __MSRCXSetNRLink(_port, 0x02) }
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
#define MSRCXPollMemory(_address) asm { __MSRCXPollMemory(_address, __RETVAL__) }
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

/** @} */ // end of ThirdPartyDevices group



/** @addtogroup StandardCAPIFunctions
 * @{
 */

///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// cmath API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup cmathAPI cmath API
 * Standard C cmath API functions.
 * @{
 */
#if __FIRMWARE_VERSION > 107

/**
 * Compute square root.
 * Computes the square root of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sqrt() instead.
 * \param _X Floating point value.
 * \return Square root of _X.
 */
#define Sqrt(_X) asm { sqrt __FLTRETVAL__, _X }

/**
 * Compute square root.
 * Computes the square root of x.
 *
 * \param x Floating point value.
 * \return Square root of x.
 */
inline float sqrt(float x) { asm { sqrt __FLTRETVAL__, x } }
/** \example ex_sqrt.nxc
 * This is an example of how to use the \ref sqrt function.
 */

#ifdef __ENHANCED_FIRMWARE

/**
 * Compute sine.
 * Computes the sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sin() instead.
 * \param _X Floating point value.
 * \return Sine of _X.
 */
#define Sin(_X) asm { sin __FLTRETVAL__, _X }

/**
 * Compute cosine.
 * Computes the cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use cos() instead.
 * \param _X Floating point value.
 * \return Cosine of _X.
 */
#define Cos(_X) asm { cos __FLTRETVAL__, _X }

/**
 * Compute arc sine.
 * Computes the arc sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use asin() instead.
 * \param _X Floating point value.
 * \return Arc sine of _X.
 */
#define Asin(_X) asm { asin __FLTRETVAL__, _X }

/**
 * Compute arc cosine.
 * Computes the arc cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use acos() instead.
 * \param _X Floating point value.
 * \return Arc cosine of _X.
 */
#define Acos(_X) asm { acos __FLTRETVAL__, _X }

/**
 * Compute arc tangent.
 * Computes the arc tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use atan() instead.
 * \param _X Floating point value.
 * \return Arc tangent of _X.
 */
#define Atan(_X) asm { atan __FLTRETVAL__, _X }

/**
 * Round up value.
 * Computes the smallest integral value that is not less than _X.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use ceil() instead.
 * \param _X Floating point value.
 * \return The smallest integral value not less than _X.
 */
#define Ceil(_X) asm { ceil __FLTRETVAL__, _X }

/**
 * Compute exponential function .
 * Computes the base-e exponential function of _X, which is the e number
 * raised to the power _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use exp() instead.
 * \param _X Floating point value.
 * \return Exponential value of _X.
 */
#define Exp(_X) asm { exp __FLTRETVAL__, _X }

/**
 * Round down value.
 * Computes the largest integral value that is not greater than _X.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use floor() instead.
 * \param _X Floating point value.
 * \return The largest integral value not greater than _X.
 */
#define Floor(_X) asm { floor __FLTRETVAL__, _X }

/**
 * Compute tangent.
 * Computes the tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use tan() instead.
 * \param _X Floating point value.
 * \return Tangent of _X.
 */
#define Tan(_X) asm { tan __FLTRETVAL__, _X }

/**
 * Compute hyperbolic tangent.
 * Computes the hyperbolic tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use tanh() instead.
 * \param _X Floating point value.
 * \return Hyperbolic tangent of _X.
 */
#define Tanh(_X) asm { tanh __FLTRETVAL__, _X }

/**
 * Compute hyperbolic cosine.
 * Computes the hyperbolic cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use cosh() instead.
 * \param _X Floating point value.
 * \return Hyperbolic cosine of _X.
 */
#define Cosh(_X) asm { cosh __FLTRETVAL__, _X }

/**
 * Compute hyperbolic sine.
 * Computes the hyperbolic sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sinh() instead.
 * \param _X Floating point value.
 * \return Hyperbolic sine of _X.
 */
#define Sinh(_X) asm { sinh __FLTRETVAL__, _X }

/**
 * Compute natural logarithm.
 * Computes the natural logarithm of _X. The natural logarithm is the base-e
 * logarithm, the inverse of the natural exponential function (exp). For
 * base-10 logarithms, a specific function Log10() exists.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use log() instead.
 * \param _X Floating point value.
 * \return Natural logarithm of _X.
 */
#define Log(_X) asm { log __FLTRETVAL__, _X }

/**
 * Compute common logarithm.
 * Computes the common logarithm of _X. The common logarithm is the base-10
 * logarithm. For base-e logarithms, a specific function Log() exists.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use log10() instead.
 * \param _X Floating point value.
 * \return Common logarithm of _X.
 */
#define Log10(_X) asm { log10 __FLTRETVAL__, _X }

/**
 * Compute arc tangent with 2 parameters.
 * Computes the principal value of the arc tangent of _Y/_X, expressed in
 * radians. To compute the value, the function uses the sign of both arguments
 * to determine the quadrant.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use atan2() instead.
 * \param _Y Floating point value representing a y coordinate.
 * \param _X Floating point value representing an x coordinate.
 * \return Arc tangent of _Y/_X, in the interval [-pi,+pi] radians.
 */
#define Atan2(_Y,_X) asm { atan2 __FLTRETVAL__, _Y, _X }

/**
 * Raise to power.
 * Computes _Base raised to the power _Exponent.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use pow() instead.
 * \param _Base Floating point value.
 * \param _Exponent Floating point value.
 * \return The result of raising _Base to the power _Exponent.
 */
#define Pow(_Base,_Exponent) asm { pow __FLTRETVAL__, _Base, _Exponent }

/**
 * Compute integral part.
 * Computes the integral part of _X.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use trunc() instead.
 * \param _X Floating point value.
 * \return Integral part of _X.
 */
#define Trunc(_X) asm { trunc __RETVAL__, _X }

/**
 * Compute fractional part.
 * Computes the fractional part of _X.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use frac() instead.
 * \param _X Floating point value.
 * \return Fractional part of _X.
 */
#define Frac(_X) asm { frac __FLTRETVAL__, _X }

/**
 * Multiply and divide.
 * Multiplies two 32-bit values and then divides the 64-bit result by a third
 * 32-bit value.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use muldiv32() instead.
 * \param _A 32-bit long value.
 * \param _B 32-bit long value.
 * \param _C 32-bit long value.
 * \return The result of multiplying _A times _B and dividing by _C.
 */
#define MulDiv32(_A,_B,_C) asm { muldiv __RETVAL__, _A, _B, _C }

/**
 * Compute sine (degrees).
 * Computes the sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sind() instead.
 * \param _X Floating point value.
 * \return Sine of _X.
 */
#define SinD(_X) asm { sind __FLTRETVAL__, _X }

/**
 * Compute cosine (degrees).
 * Computes the cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use cosd() instead.
 * \param _X Floating point value.
 * \return Cosine of _X.
 */
#define CosD(_X) asm { cosd __FLTRETVAL__, _X }

/**
 * Compute arch sine (degrees).
 * Computes the arc sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use asind() instead.
 * \param _X Floating point value.
 * \return Arc sine of _X.
 */
#define AsinD(_X) asm { asind __FLTRETVAL__, _X }

/**
 * Compute arc cosine (degrees).
 * Computes the arc cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use acosd() instead.
 * \param _X Floating point value.
 * \return Arc cosine of _X.
 */
#define AcosD(_X) asm { acosd __FLTRETVAL__, _X }

/**
 * Compute arc tangent (degrees).
 * Computes the arc tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use atand() instead.
 * \param _X Floating point value.
 * \return Arc tangent of _X.
 */
#define AtanD(_X) asm { atand __FLTRETVAL__, _X }

/**
 * Compute tangent (degrees).
 * Computes the sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use tand() instead.
 * \param _X Floating point value.
 * \return Tangent of _X.
 */
#define TanD(_X) asm { tand __FLTRETVAL__, _X }

/**
 * Compute hyperbolic tangent (degrees).
 * Computes the hyperbolic tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use tanhd() instead.
 * \param _X Floating point value.
 * \return Hyperbolic tangent of _X.
 */
#define TanhD(_X) asm { tanhd __FLTRETVAL__, _X }

/**
 * Compute hyperbolic cosine (degrees).
 * Computes the hyperbolic cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use coshd() instead.
 * \param _X Floating point value.
 * \return Hyperbolic cosine of _X.
 */
#define CoshD(_X) asm { coshd __FLTRETVAL__, _X }

/**
 * Compute hyperbolic sine (degrees).
 * Computes the hyperbolic sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sinhd() instead.
 * \param _X Floating point value.
 * \return Hyperbolic sine of _X.
 */
#define SinhD(_X) asm { sinhd __FLTRETVAL__, _X }

/**
 * Compute arc tangent with two parameters (degrees).
 * Computes the arc tangent of _Y/_X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use atan2d() instead.
 * \param _Y Floating point value.
 * \param _X Floating point value.
 * \return Arc tangent of _Y/_X.
 */
#define Atan2D(_Y,_X) asm { atan2d __FLTRETVAL__, _Y, _X }

/**
 * Compute cosine.
 * Computes the cosine of an angle of x radians.
 *
 * \param x Floating point value representing an angle expressed in radians.
 * \return Cosine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float cos(float x) { asm { cos __FLTRETVAL__, x } }
/** \example ex_sin_cos.nxc
 * This is an example of how to use the \ref cos function.
 */

/**
 * Compute sine.
 * Computes the sine of an angle of x radians.
 *
 * \param x Floating point value representing an angle expressed in radians.
 * \return Sine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float sin(float x) { asm { sin __FLTRETVAL__, x } }
/** \example ex_sin_cos.nxc
 * This is an example of how to use the \ref sin function.
 */

/**
 * Compute tangent.
 * Computes the tangent of an angle of x radians.
 *
 * \param x Floating point value representing an angle expressed in radians.
 * \return Tangent of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float tan(float x) { asm { tan __FLTRETVAL__, x } }
/** \example ex_tan.nxc
 * This is an example of how to use the \ref tan function.
 */

/**
 * Compute arc cosine.
 * Computes the principal value of the arc cosine of x, expressed in radians.
 * In trigonometrics, arc cosine is the inverse operation of cosine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc cosine of x, in the interval [0,pi] radians.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float acos(float x) { asm { acos __FLTRETVAL__, x } }
/** \example ex_acos.nxc
 * This is an example of how to use the \ref acos function.
 */

/**
 * Compute arc sine.
 * Computes the principal value of the arc sine of x, expressed in radians.
 * In trigonometrics, arc sine is the inverse operation of sine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc sine of x, in the interval [-pi/2,+pi/2] radians.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float asin(float x) { asm { asin __FLTRETVAL__, x } }
/** \example ex_asin.nxc
 * This is an example of how to use the \ref asin function.
 */

/**
 * Compute arc tangent.
 * Computes the principal value of the arc tangent of x, expressed in radians.
 * In trigonometrics, arc tangent is the inverse operation of tangent. Notice
 * that because of the sign ambiguity, a function cannot determine with
 * certainty in which quadrant the angle falls only by its tangent value.
 * You can use atan2() if you need to determine the quadrant.
 *
 * \sa atan2()
 * \param x Floating point value.
 * \return Arc tangent of x, in the interval [-pi/2,+pi/2] radians.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float atan(float x) { asm { atan __FLTRETVAL__, x } }
/** \example ex_atan.nxc
 * This is an example of how to use the \ref atan function.
 */

/**
 * Compute arc tangent with 2 parameters.
 * Computes the principal value of the arc tangent of y/x, expressed in
 * radians. To compute the value, the function uses the sign of both arguments
 * to determine the quadrant.
 *
 * \sa atan()
 * \param y Floating point value representing a y coordinate.
 * \param x Floating point value representing an x coordinate.
 * \return Arc tangent of y/x, in the interval [-pi,+pi] radians.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float atan2(float y, float x) { asm { atan2 __FLTRETVAL__, y, x } }
/** \example ex_atan2.nxc
 * This is an example of how to use the \ref atan2 function.
 */

/**
 * Compute hyperbolic cosine.
 * Computes the hyperbolic cosine of x, expressed in radians.
 *
 * \param x Floating point value.
 * \return Hyperbolic cosine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float cosh(float x) { asm { cosh __FLTRETVAL__, x } }
/** \example ex_cosh.nxc
 * This is an example of how to use the \ref cosh function.
 */

/**
 * Compute hyperbolic sine.
 * Computes the hyperbolic sine of x, expressed in radians.
 *
 * \param x Floating point value.
 * \return Hyperbolic sine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float sinh(float x) { asm { sinh __FLTRETVAL__, x } }
/** \example ex_sinh.nxc
 * This is an example of how to use the \ref sinh function.
 */

/**
 * Compute hyperbolic tangent.
 * Computes the hyperbolic tangent of x, expressed in radians.
 *
 * \param x Floating point value.
 * \return Hyperbolic tangent of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float tanh(float x) { asm { tanh __FLTRETVAL__, x } }
/** \example ex_tanh.nxc
 * This is an example of how to use the \ref tanh function.
 */

/**
 * Compute exponential function.
 * Computes the base-e exponential function of x, which is the e number
 * raised to the power x.
 *
 * \param x Floating point value.
 * \return Exponential value of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float exp(float x) { asm { exp __FLTRETVAL__, x } }
/** \example ex_exp.nxc
 * This is an example of how to use the \ref exp function.
 */

/**
 * Compute natural logarithm.
 * Computes the natural logarithm of x. The natural logarithm is the base-e
 * logarithm, the inverse of the natural exponential function (exp). For
 * base-10 logarithms, a specific function log10() exists.
 *
 * \sa log10(), exp()
 * \param x Floating point value.
 * \return Natural logarithm of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float log(float x) { asm { log __FLTRETVAL__, x } }
/** \example ex_log.nxc
 * This is an example of how to use the \ref log function.
 */

/**
 * Compute common logarithm.
 * Computes the common logarithm of x. The common logarithm is the base-10
 * logarithm. For base-e logarithms, a specific function log() exists.
 *
 * \sa log(), exp()
 * \param x Floating point value.
 * \return Common logarithm of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float log10(float x) { asm { log10 __FLTRETVAL__, x } }
/** \example ex_log10.nxc
 * This is an example of how to use the \ref log10 function.
 */

/**
 * Compute integral part.
 * Computes the integral part of x.
 *
 * \param x Floating point value.
 * \return Integral part of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline long trunc(float x) { asm { trunc __RETVAL__, x } }
/** \example ex_trunc.nxc
 * This is an example of how to use the \ref trunc function.
 */

/**
 * Compute fractional part.
 * Computes the fractional part of x.
 *
 * \param x Floating point value.
 * \return Fractional part of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float frac(float x) { asm { frac __FLTRETVAL__, x } }
/** \example ex_frac.nxc
 * This is an example of how to use the \ref frac function.
 */

/**
 * Raise to power.
 * Computes base raised to the power exponent.
 *
 * \param base Floating point value.
 * \param exponent Floating point value.
 * \return The result of raising base to the power exponent.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float pow(float base, float exponent) { asm { pow __FLTRETVAL__, base, exponent } }
/** \example ex_pow.nxc
 * This is an example of how to use the \ref pow function.
 */

/**
 * Round up value.
 * Computes the smallest integral value that is not less than x.
 *
 * \param x Floating point value.
 * \return The smallest integral value not less than x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float ceil(float x) { asm { ceil __FLTRETVAL__, x } }
/** \example ex_ceil.nxc
 * This is an example of how to use the \ref ceil function.
 */

/**
 * Round down value.
 * Computes the largest integral value that is not greater than x.
 *
 * \param x Floating point value.
 * \return The largest integral value not greater than x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float floor(float x) { asm { floor __FLTRETVAL__, x } }
/** \example ex_floor.nxc
 * This is an example of how to use the \ref floor function.
 */

/**
 * Multiply and divide.
 * Multiplies two 32-bit values and then divides the 64-bit result by a third
 * 32-bit value.
 *
 * \param a 32-bit long value.
 * \param b 32-bit long value.
 * \param c 32-bit long value.
 * \return The result of multiplying a times b and dividing by c.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline long muldiv32(long a, long b, long c) { asm { muldiv __RETVAL__, a, b, c } }
/** \example ex_muldiv32.nxc
 * This is an example of how to use the \ref muldiv32 function.
 */

// degree-based trig functions

/**
 * Compute cosine (degrees).
 * Computes the cosine of an angle of x degrees.
 *
 * \param x Floating point value representing an angle expressed in degrees.
 * \return Cosine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float cosd(float x) { asm { cosd __FLTRETVAL__, x } }
/** \example ex_sind_cosd.nxc
 * This is an example of how to use the \ref cosd function.
 */

/**
 * Compute sine (degrees).
 * Computes the sine of an angle of x degrees.
 *
 * \param x Floating point value representing an angle expressed in degrees.
 * \return Sine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float sind(float x) { asm { sind __FLTRETVAL__, x } }
/** \example ex_sind_cosd.nxc
 * This is an example of how to use the \ref sind function.
 */

/**
 * Compute tangent (degrees).
 * Computes the tangent of an angle of x degrees.
 *
 * \param x Floating point value representing an angle expressed in degrees.
 * \return Tangent of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float tand(float x) { asm { tand __FLTRETVAL__, x } }
/** \example ex_tand.nxc
 * This is an example of how to use the \ref tand function.
 */

/**
 * Compute arc cosine (degrees).
 * Computes the principal value of the arc cosine of x, expressed in degrees.
 * In trigonometrics, arc cosine is the inverse operation of cosine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc cosine of x, in the interval [0,180] degrees.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float acosd(float x) { asm { acosd __FLTRETVAL__, x } }
/** \example ex_acosd.nxc
 * This is an example of how to use the \ref acosd function.
 */

/**
 * Compute arc sine (degrees).
 * Computes the principal value of the arc sine of x, expressed in degrees.
 * In trigonometrics, arc sine is the inverse operation of sine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc sine of x, in the interval [-90,+90] degrees.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float asind(float x) { asm { asind __FLTRETVAL__, x } }
/** \example ex_asind.nxc
 * This is an example of how to use the \ref asind function.
 */

/**
 * Compute arc tangent (degrees).
 * Computes the principal value of the arc tangent of x, expressed in degrees.
 * In trigonometrics, arc tangent is the inverse operation of tangent. Notice
 * that because of the sign ambiguity, a function cannot determine with
 * certainty in which quadrant the angle falls only by its tangent value.
 * You can use atan2d if you need to determine the quadrant.
 *
 * \param x Floating point value.
 * \return Arc tangent of x, in the interval [-90,+90] degrees.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float atand(float x) { asm { atand __FLTRETVAL__, x } }
/** \example ex_atand.nxc
 * This is an example of how to use the \ref atand function.
 */

/**
 * Compute arc tangent with 2 parameters (degrees).
 * Computes the principal value of the arc tangent of y/x, expressed in
 * degrees. To compute the value, the function uses the sign of both arguments
 * to determine the quadrant.
 *
 * \param y Floating point value representing a y coordinate.
 * \param x Floating point value representing an x coordinate.
 * \return Arc tangent of y/x, in the interval [-90,+90] degrees.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float atan2d(float y, float x) { asm { atan2d __FLTRETVAL__, y, x } }
/** \example ex_atan2d.nxc
 * This is an example of how to use the \ref atan2d function.
 */

/**
 * Compute hyperbolic cosine (degrees).
 * Computes the hyperbolic cosine of x, expressed in degrees.
 *
 * \param x Floating point value.
 * \return Hyperbolic cosine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float coshd(float x) { asm { coshd __FLTRETVAL__, x } }

/**
 * Compute hyperbolic sine (degrees).
 * Computes the hyperbolic sine of x, expressed in degrees.
 *
 * \param x Floating point value.
 * \return Hyperbolic sine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float sinhd(float x) { asm { sinhd __FLTRETVAL__, x } }

/**
 * Compute hyperbolic tangent (degrees).
 * Computes the hyperbolic tangent of x, expressed in degrees.
 *
 * \param x Floating point value.
 * \return Hyperbolic tangent of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float tanhd(float x) { asm { tanhd __FLTRETVAL__, x } }

#endif

#else

// math functions written by Tamas Sorosy (www.sorosy.com)

// X is any integer; Y is the sqrt value (0->max); if X<0, Y is the sqrt value of absolute X
#define Sqrt(_X) asm { __SQRT(_X,__RETVAL__) }

#endif

#if (__FIRMWARE_VERSION <= 107) || !defined(__ENHANCED_FIRMWARE)

// X is any integer in degrees; Y is 100* the sin value (-100->100)
#define Sin(_X) asm { __SIN(_X,__RETVAL__) }

// X is any integer in degrees; Y is 100* the cos value (-100->100)
#define Cos(_X) asm { __COS(_X,__RETVAL__) }

// X is 100* the sin value (-100->100); Y is -90->90; Y is 101 if X is outside -100->100 range
#define Asin(_X) asm { __ASIN(_X,__RETVAL__) }

// X is 100* the cos value (-100->100); Y is 0->180; Y is -11 if X is outside -100->100 range
#define Acos(_X) asm { __ACOS(_X,__RETVAL__) }

#endif

/**
 * Convert from BCD to decimal
 * Return the decimal equivalent of the binary coded decimal value provided.
 * \return The decimal equivalent of the binary coded decimal byte
 */
inline byte bcd2dec(byte bcd) { asm { __bcd2dec(bcd, __RETVAL__) } }
/** \example ex_bcd2dec.nxc
 * This is an example of how to use the \ref bcd2dec function.
 */

#ifdef __DOXYGEN_DOCS

/**
 * Is the value NaN.
 * Returns true if the floating point value is NaN (not a number).
 *
 * \param value A floating point variable.
 * \return Whether the value is NaN.
 */
inline bool isNAN(float value);
/** \example ex_isNAN.nxc
 * This is an example of how to use the \ref isNAN function.
 */

/**
 * Sign value.
 * Return the sign of the value argument (-1, 0, or 1). Any scalar type can
 * be passed into this function.
 *
 * \param num The numeric value for which to calculate its sign value.
 * \return -1 if the parameter is negative, 0 if the parameter is zero, or 1 if
 * the parameter is positive.
 */
inline char sign(variant num);
/** \example ex_sign.nxc
 * This is an example of how to use the \ref sign function.
 */

#else

#define isNAN(_x) ((_x) != (_x))

#endif
/** @} */ // end of cmathAPI group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// cstdio API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup cstdioAPI cstdio API
 * Standard C cstdio API functions.
 * @{
 */
/**
 * Close file.
 * Close the file associated with the specified file handle. The loader
 * result code is returned as the value of the function call.
 *
 * \param handle The handle of the file to be closed.
 * \return The loader result code.
 */
inline int fclose(byte handle) { return CloseFile(handle); }
/** \example ex_fclose.nxc
 * This is an example of how to use the \ref fclose function.
 */

/**
 * Remove file.
 * Delete the specified file. The loader result code is returned as the value
 * of the function call.
 *
 * \param filename The name of the file to be deleted.
 * \return The loader result code.
 */
inline int remove(string filename) { return DeleteFile(filename); }
/** \example ex_remove.nxc
 * This is an example of how to use the \ref remove function.
 */

/**
 * Rename file.
 * Rename a file from the old filename to the new filename. The loader
 * result code is returned as the value of the function call.
 *
 * \param old The name of the file to be renamed.
 * \param new The new name for the file.
 * \return The loader result code.
 */
inline int rename(string old, string new) { return RenameFile(old, new); }
/** \example ex_rename.nxc
 * This is an example of how to use the \ref rename function.
 */

/**
 * Get character from file.
 * Returns the character currently pointed to by the internal file position
 * indicator of the file specified by the handle. The internal file position
 * indicator is then advanced by one character to point to the next character.
 * The functions fgetc and getc are equivalent.
 *
 * \param handle The handle of the file from which the character is read.
 * \return The character read from the file.
 */
inline char fgetc(byte handle) {
  char ch;
  asm {
    __readValue(handle, ch, __RETVAL__)
    mov __RETVAL__, ch
  }
}
/** \example ex_fgetc.nxc
 * This is an example of how to use the \ref fgetc function.
 */

/**
 * Get character from file.
 * Returns the character currently pointed to by the internal file position
 * indicator of the file specified by the handle. The internal file position
 * indicator is then advanced by one character to point to the next character.
 * The functions fgetc and getc are equivalent.
 *
 * \param _handle The handle of the file from which the character is read.
 * \return The character read from the file.
 */
#define getc(_handle) fgetc(_handle)
/** \example ex_getc.nxc
 * This is an example of how to use the \ref getc function.
 */

/**
 * Get string from file.
 * Reads characters from a file and stores them as a string into str until
 * (num-1) characters have been read or either a newline or a the End-of-File
 * is reached, whichever comes first. A newline character makes fgets stop
 * reading, but it is considered a valid character and therefore it is
 * included in the string copied to str. A null character is automatically
 * appended in str after the characters read to signal the end of the string.
 * Returns the string parameter.
 *
 * \param str The string where the characters are stored.
 * \param num The maximum number of characters to be read.
 * \param handle The handle of the file from which the characters are read.
 * \return The string read from the file.
 */
inline string fgets(string & str, int num, byte handle) {
  asm { __readLnStringEx(handle, str, num, __RETVAL__) };
  return str;
}
/** \example ex_fgets.nxc
 * This is an example of how to use the \ref fgets function.
 */

/**
 * Check End-of-file indicator.
 * Checks whether the End-of-File indicator associated with the handle is
 * set, returning a value different from zero if it is.
 *
 * \param handle The handle of the file to check.
 * \return Currently always returns 0.
 */
inline int feof(byte handle) { return 0; }
/** \example ex_feof.nxc
 * This is an example of how to use the \ref feof function.
 */

/**
 * Open file.
 * Opens the file whose name is specified in the parameter filename and
 * associates it with a file handle that can be identified in future
 * operations by the handle that is returned. The operations that are allowed
 * on the stream and how these are performed are defined by the mode parameter.
 *
 * \param filename The name of the file to be opened.
 * \param mode The file access mode. Valid values are "r" - opens an existing
 * file for reading, "w" - creates a new file and opens it for writing, and
 * "a" - opens an existing file for appending to the end of the file.
 * \return The handle to the opened file.
 */
byte fopen(string filename, const string mode) {
  byte handle;
  int fsize;
  switch(mode) {
    case "r" :
      OpenFileRead(filename, fsize, handle);
      break;
    case "w" :
      fsize = 1024;
      CreateFile(filename, fsize, handle);
      break;
    case "a" :
      OpenFileAppend(filename, fsize, handle);
      break;
    default:
      handle = NULL;
  }
  return handle;
}
/** \example ex_fopen.nxc
 * This is an example of how to use the \ref fopen function.
 */

/**
 * Flush file.
 * Writes any buffered data to the file. A zero value indicates success.
 *
 * \param handle The handle of the file to be flushed.
 * \return Currently always returns 0.
 */
inline int fflush(byte handle) { return 0; }
/** \example ex_fflush.nxc
 * This is an example of how to use the \ref fflush function.
 */

/**
 * Get current position in file.
 * Returns the current value of the file position indicator of the specified
 * handle.
 *
 * \param handle The handle of the file.
 * \return Currently always returns -1.
 */
inline long ftell(byte handle) { return -1; }
/** \example ex_ftell.nxc
 * This is an example of how to use the \ref ftell function.
 */

/**
 * Write character to file.
 * Writes a character to the file and advances the position indicator.
 * The character is written at the current position of the file as indicated
 * by the internal position indicator, which is then advanced one character.
 * If there are no errors, the same character that has been written is
 * returned. If an error occurs, EOF is returned.
 *
 * \param ch The character to be written.
 * \param handle The handle of the file where the character is to be written.
 * \return The character written to the file.
 */
inline char fputc(char ch, byte handle) {
  if (Write(handle, ch) == LDR_SUCCESS)
    return ch;
  else
    return EOF;
}
/** \example ex_fputc.nxc
 * This is an example of how to use the \ref fputc function.
 */

/**
 * Write character to file.
 * Writes a character to the file and advances the position indicator.
 * The character is written at the current position of the file as indicated
 * by the internal position indicator, which is then advanced one character.
 * If there are no errors, the same character that has been written is
 * returned. If an error occurs, EOF is returned.
 *
 * \param _ch The character to be written.
 * \param _handle The handle of the file where the character is to be written.
 * \return The character written to the file.
 */
#define putc(_ch, _handle) fputc(_ch, _handle)
/** \example ex_putc.nxc
 * This is an example of how to use the \ref putc function.
 */

/**
 * Write string to file.
 * Writes the string to the file specified by the handle. The null terminating
 * character at the end of the string is not written to the file. If there are
 * no errors, a non-negative value is returned. If an error occurs, EOF is
 * returned.
 *
 * \param str The string of characters to be written.
 * \param handle The handle of the file where the string is to be written.
 * \return The number of characters written to the file.
 */
inline int fputs(string str, byte handle) {
  int cnt;
  if (WriteString(handle, str, cnt) == LDR_SUCCESS)
    return cnt;
  else
    return EOF;
}
/** \example ex_fputs.nxc
 * This is an example of how to use the \ref fputs function.
 */
 
#ifdef __ENHANCED_FIRMWARE

#ifdef __DOXYGEN_DOCS

/**
 * Print formatted data to stdout.
 * Writes to the LCD at 0, LCD_LINE1 a sequence of data formatted as the
 * format argument specifies. After the format parameter, the function
 * expects one value argument.
 *
 * \param format A string specifying the desired format.
 * \param value A value to be formatted for writing to the LCD.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void printf(string format, variant value);
/** \example ex_printf.nxc
 * This is an example of how to use the \ref printf function.
 */

/**
 * Write formatted data to file.
 * Writes a sequence of data formatted as the format argument specifies to a
 * file. After the format parameter, the function expects one value
 * argument.
 *
 * \param handle The handle of the file to write to.
 * \param format A string specifying the desired format.
 * \param value A value to be formatted for writing to the file.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void fprintf(byte handle, string format, variant value);
/** \example ex_fprintf.nxc
 * This is an example of how to use the \ref fprintf function.
 */

/**
 * Write formatted data to string.
 * Writes a sequence of data formatted as the format argument specifies to a
 * string. After the format parameter, the function expects one value
 * argument.
 *
 * \param str The string to write to.
 * \param format A string specifying the desired format.
 * \param value A value to be formatted for writing to the string.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void sprintf(string & str, string format, variant value);
/** \example ex_sprintf.nxc
 * This is an example of how to use the \ref sprintf function.
 */

#else

#define printf(_format, _value) { \
  string msg = FormatNum(_format, _value); \
  TextOut(0, LCD_LINE1, msg); \
}
#define fprintf(_handle, _format, _value) { \
  int cnt = fputs(FormatNum(_format, _value), _handle); \
}
#define sprintf(_str, _format, _value) { \
  _str = FormatNum(_format, _value); \
}

#endif

#if __FIRMWARE_VERSION > 107

/** @defgroup fseekConstants fseek origin constants
 * Constants for use in calls to fseek.
 * @{
 */
#define SEEK_SET 0 /*!< Seek from the beginning of the file */
#define SEEK_CUR 1 /*!< Seek from the current file position */
#define SEEK_END 2 /*!< Seek from the end of the file */
/** @} */ // end of fseekConstants group

/**
 * Reposition file position indicator.
 * Sets the position indicator associated with the file to a new position
 * defined by adding offset to a reference position specified by origin.
 *
 * \param handle The handle of the file.
 * \param offset The number of bytes to offset from origin.
 * \param origin Position from where offset is added. It is specified by one
 * of the following constants: SEEK_SET - beginning of file, SEEK_CUR - current
 * position of the file pointer, or SEEK_END - end of file. \ref fseekConstants
 * \return A value of zero if successful or non-zero otherwise. See \ref LoaderErrors.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline int fseek(byte handle, long offset, int origin) {
  FileSeekType fst;
  fst.FileHandle = handle;
  fst.Origin = origin;
  fst.Length = offset;
  SysFileSeek(fst);
  return fst.Result;
}
/** \example ex_fseek.nxc
 * This is an example of how to use the \ref fseek function.
 */

/**
 * Set position indicator to the beginning.
 * Sets the position indicator associated with stream to the beginning of
 * the file.
 *
 * \param handle The handle of the file.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void rewind(byte handle) { fseek(handle, 0, SEEK_SET); }
/** \example ex_rewind.nxc
 * This is an example of how to use the \ref rewind function.
 */

/**
 * Get character from stdin.
 * Returns the next character from the standard input (stdin).
 * It is equivalent to getc with stdin as its argument. On the NXT this means
 * wait for a button press and return the value of the button pressed.
 *
 * \return The pressed button. See \ref ButtonNameConstants.
 *
 */
inline int getchar() {
  int result = -1;
  while (true) {
    if (ButtonPressed(BTN1, false))
      result = BTN1;
    else if (ButtonPressed(BTN2, false))
      result = BTN2;
    else if (ButtonPressed(BTN3, false))
      result = BTN3;
    else if (ButtonPressed(BTN4, false))
      result = BTN4;
    if (result != -1)
      break;
    else
      Yield();
  }
  while(ButtonPressed(result, false));
  return result;
}
/** \example ex_getchar.nxc
 * This is an example of how to use the \ref getchar function.
 */


#endif
#endif

/*
  size_t fread(ptr, size, count, FILE*); // read blocks of data from file; returns number of blocks read
  size_t fwrite(ptr, size, count, FILE*); // write blocks of data to stream; returns number of blocks written
  int putchar(int character); // write character to stdout
*/

/** \example ex_cstdio.nxc
 * This is an example of how to use the cstdio API functions: \ref fopen, \ref fprintf, \ref fputc,
 * \ref fputs, \ref fseek, \ref ftell, \ref fclose, \ref feof, \ref fflush,
 * \ref fgetc, \ref fgets, \ref getc, \ref putc, \ref rewind,
 * \ref printf, \ref sprintf, \ref rename, and \ref remove.
 */


/** @} */ // end of cstdioAPI group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// cstdlib API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup cstdlibAPI cstdlib API
 * Standard C cstdlib API functions and types.
 * @{
 */

/** @defgroup cstdlibAPITypes cstdlib API types
 * Standard C cstdlib API types.
 * @{
 */

/**
 * Parameters for the RandomNumber system call.
 * This structure is used when calling the \ref SysRandomNumber system call
 * function.
 * \sa SysRandomNumber()
 */
struct RandomNumberType {
  int Result; /*!< The random number. */
};

/**
 * Output type of the div function.
 * div_t structure.
 * Structure used to represent the value of an integral division performed
 * by div. It has two members of the same type, defined in either order as:
 * int quot; int rem;.
 * \sa div()
 */
struct div_t {
  int quot;  /*!< Represents the quotient of the integral division operation
                  performed by div, which is the integer of lesser magnitude
                  that is nearest to the algebraic quotient. */
  int rem;   /*!< Represents the remainder of the integral division operation
                  performed by div, which is the integer resulting from
                  subtracting quot to the numerator of the operation. */
};

/**
 * Output type of the ldiv function.
 * Structure used to represent the value of an integral division performed
 * by ldiv. It has two members of the same type, defined in either order as:
 * long quot; long rem;.
 * \sa ldiv()
 */
struct ldiv_t {
  long quot;  /*!< Represents the quotient of the integral division operation
                  performed by div, which is the integer of lesser magnitude
                  that is nearest to the algebraic quotient. */
  long rem;   /*!< Represents the remainder of the integral division operation
                  performed by div, which is the integer resulting from
                  subtracting quot to the numerator of the operation. */
};

/** @} */ // end of cstdlibAPITypes group

#ifdef __DOXYGEN_DOCS

/**
 * Abort current process.
 * Aborts the process with an abnormal program termination.
 * The function never returns to its caller.
 */
inline void abort();
/** \example ex_abort.nxc
 * This is an example of how to use the \ref abort function.
 */

/**
 * Absolute value.
 * Return the absolute value of the value argument. Any scalar type can
 * be passed into this function.
 *
 * \param num The numeric value.
 * \return The absolute value of num. The return type matches the input type.
 */
inline variant abs(variant num);
/** \example ex_abs.nxc
 * This is an example of how to use the \ref abs function.
 */

/**
 * Generate random number.
 * Returns a pseudo-random integral number in the range 0 to \ref RAND_MAX.
 *
 * \return An integer value between 0 and RAND_MAX.
 */
inline unsigned int rand();
/** \example ex_rand.nxc
 * This is an example of how to use the \ref rand function.
 */

/**
 * Generate random number.
 * Return a signed or unsigned 16-bit random number. If the optional argument n
 * is not provided the function will return a signed value.  Otherwise the
 * returned value will range between 0 and n (exclusive).
 *
 * \param n The maximum unsigned value desired (optional).
 * \return A random number
 */
inline int Random(unsigned int n = 0);
/** \example ex_Random.nxc
 * This is an example of how to use the \ref Random function.
 */

/**
 * Draw a random number.
 * This function lets you obtain a random number via the \ref RandomNumberType
 * structure.
 *
 * \param args The RandomNumberType structure receiving results.
 */
inline void SysRandomNumber(RandomNumberType & args);
/** \example ex_sysrandomnumber.nxc
 * This is an example of how to use the \ref SysRandomNumber function along with
 * the \ref RandomNumberType structure.
 */

#else

#define abort() Stop(true)
#define rand() Random(RAND_MAX)

#define SysRandomNumber(_args) asm { \
  compchktype _args, RandomNumberType \
  syscall RandomNumber, _args \
}

#endif

/**
 * Convert string to integer.
 * Parses the string str interpreting its content as an integral number,
 * which is returned as an int value.
 *
 * The function first discards as many whitespace characters as necessary
 * until the first non-whitespace character is found. Then, starting from
 * this character, takes an optional initial plus or minus sign followed by as
 * many numerical digits as possible, and interprets them as a numerical value.
 *
 * The string can contain additional characters after those that form the
 * integral number, which are ignored and have no effect on the behavior of
 * this function.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid integral number, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of an integral number.
 * \return On success, the function returns the converted integral number
 * as an int value. If no valid conversion could be performed a zero value
 * is returned.
 */
inline int atoi(const string str) { return StrToNum(str); }
/** \example ex_atoi.nxc
 * This is an example of how to use the \ref atoi function.
 */

/**
 * Convert string to long integer.
 * Parses the string str interpreting its content as an integral number,
 * which is returned as a long int value.
 *
 * The function first discards as many whitespace characters as necessary
 * until the first non-whitespace character is found. Then, starting from
 * this character, takes an optional initial plus or minus sign followed by as
 * many numerical digits as possible, and interprets them as a numerical value.
 *
 * The string can contain additional characters after those that form the
 * integral number, which are ignored and have no effect on the behavior of
 * this function.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid integral number, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of an integral number.
 * \return On success, the function returns the converted integral number
 * as a long int value. If no valid conversion could be performed a zero value
 * is returned.
 */
inline long atol(const string str) { return StrToNum(str); }
/** \example ex_atol.nxc
 * This is an example of how to use the \ref atol function.
 */

/**
 * Absolute value.
 * Return the absolute value of parameter n.
 *
 * \param n Integral value.
 * \return The absolute value of n.
 */
inline long labs(long n) { return abs(n); }
/** \example ex_labs.nxc
 * This is an example of how to use the \ref labs function.
 */

#if __FIRMWARE_VERSION > 107
/**
 * Convert string to float.
 * Parses the string str interpreting its content as a floating point number
 * and returns its value as a float.
 *
 * The function first discards as many whitespace characters as necessary until
 * the first non-whitespace character is found. Then, starting from this
 * character, takes as many characters as possible that are valid following a
 * syntax resembling that of floating point literals, and interprets them as a
 * numerical value. The rest of the string after the last valid character is
 * ignored and has no effect on the behavior of this function.
 *
 * A valid floating point number for atof is formed by a succession of:
 * - An optional plus or minus sign
 * - A sequence of digits, optionally containing a decimal-point character
 * - An optional exponent part, which itself consists on an 'e' or 'E'
 * character followed by an optional sign and a sequence of digits.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid floating-point number as just defined, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of a floating-point number.
 * \return On success, the function returns the converted floating point number
 * as a float value. If no valid conversion could be performed a zero value
 * (0.0) is returned.
 */
inline float atof(const string str) {
  float result;
  asm { strtonum result, __TMPWORD__, str, NA, NA }
  return result;
}
/** \example ex_atof.nxc
 * This is an example of how to use the \ref atof function.
 */

/**
 * Convert string to float.
 * Parses the string str interpreting its content as a floating point number
 * and returns its value as a float.
 *
 * The function first discards as many whitespace characters as necessary until
 * the first non-whitespace character is found. Then, starting from this
 * character, takes as many characters as possible that are valid following a
 * syntax resembling that of floating point literals, and interprets them as a
 * numerical value. A string containing the rest of the string after the last
 * valid character is stored in endptr.
 *
 * A valid floating point number for atof is formed by a succession of:
 * - An optional plus or minus sign
 * - A sequence of digits, optionally containing a decimal-point character
 * - An optional exponent part, which itself consists on an 'e' or 'E'
 * character followed by an optional sign and a sequence of digits.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid floating-point number as just defined, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of a floating-point number.
 * \param endptr Reference to a string, whose value is set by the function to
 * the remaining characters in str after the numerical value.
 * \return On success, the function returns the converted floating point number
 * as a float value. If no valid conversion could be performed a zero value
 * (0.0) is returned.
 */
inline float strtod(const string & str, string & endptr) {
  float result;
  int offsetpast;
  asm {
    strtonum result, offsetpast, str, NA, NA
    strsubset endptr, str, offsetpast, NA
  }
  return result;
}
/** \example ex_strtod.nxc
 * This is an example of how to use the \ref strtod function.
 */
#endif

/**
 * Convert string to long integer.
 * Parses the C string str interpreting its content as an integral number of
 * the specified base, which is returned as a long int value.
 *
 * The function first discards as many whitespace characters as necessary
 * until the first non-whitespace character is found. Then, starting from this
 * character, takes as many characters as possible that are valid following a
 * syntax that depends on the base parameter, and interprets them as a
 * numerical value. A string containing the rest of the characters following the
 * integer representation in str is stored in endptr.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid integral number, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of an integral number.
 * \param endptr Reference to a string, whose value is set by the function to
 * the remaining characters in str after the numerical value.
 * \param base Optional and ignored if specified.
 * \return On success, the function returns the converted integral number
 * as a long int value. If no valid conversion could be performed a zero value
 * is returned.
 * \warning Only base = 10 is currently supported.
 */
inline long strtol(const string & str, string & endptr, int base = 10) {
  long result;
  int offsetpast;
  asm {
    strtonum result, offsetpast, str, NA, NA
    strsubset endptr, str, offsetpast, NA
  }
  return result;
}
/** \example ex_strtol.nxc
 * This is an example of how to use the \ref strtol function.
 */

/**
 * Convert string to unsigned long integer.
 * Parses the C string str interpreting its content as an unsigned integral
 * number of the specified base, which is returned as an unsigned long int value.
 *
 * The function first discards as many whitespace characters as necessary
 * until the first non-whitespace character is found. Then, starting from this
 * character, takes as many characters as possible that are valid following a
 * syntax that depends on the base parameter, and interprets them as a
 * numerical value. A string containing the rest of the characters following the
 * integer representation in str is stored in endptr.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid integral number, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String containing the representation of an unsigned integral number.
 * \param endptr Reference to a string, whose value is set by the function to
 * the remaining characters in str after the numerical value.
 * \param base Optional and ignored if specified.
 * \return On success, the function returns the converted integral number
 * as an unsigned long int value. If no valid conversion could be performed a
 * zero value is returned.
 * \warning Only base = 10 is currently supported.
 */
inline long strtoul(const string & str, string & endptr, int base = 10) {
  unsigned long result;
  int offsetpast;
  asm {
    strtonum result, offsetpast, str, NA, NA
    strsubset endptr, str, offsetpast, NA
  }
  return result;
}
/** \example ex_strtoul.nxc
 * This is an example of how to use the \ref strtoul function.
 */

/**
 * Integral division.
 * Returns the integral quotient and remainder of the division of numerator by
 * denominator as a structure of type div_t, which has two members:
 * quot and rem.
 *
 * \param numer Numerator.
 * \param denom Denominator.
 * \return The result is returned by value in a structure defined in cstdlib,
 * which has two members. For div_t, these are, in either order:
 * int quot; int rem.
 */
inline div_t div(int numer, int denom) {
  div_t result;
  result.quot = numer / denom;
  result.rem  = numer % denom;
  return result;
}
/** \example ex_div.nxc
 * This is an example of how to use the \ref div function.
 */

/**
 * Integral division.
 * Returns the integral quotient and remainder of the division of numerator by
 * denominator as a structure of type ldiv_t, which has two members:
 * quot and rem.
 *
 * \param numer Numerator.
 * \param denom Denominator.
 * \return The result is returned by value in a structure defined in cstdlib,
 * which has two members. For ldiv_t, these are, in either order:
 * long quot; long rem.
 */
inline ldiv_t ldiv(long numer, long denom) {
  ldiv_t result;
  result.quot = numer / denom;
  result.rem  = numer % denom;
  return result;
}
/** \example ex_ldiv.nxc
 * This is an example of how to use the \ref ldiv function.
 */

/** @} */ // end of cstdlibAPI group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// cstring API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup cstringAPI cstring API
 * Standard C cstring API functions.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Convert string to number.
 * Return the numeric value specified by the string passed to the function.
 * If the content of the string is not a numeric value then this function
 * returns zero. The input string parameter
 * may be a variable, constant, or expression.
 *
 * \param str String beginning with the representation of a number.
 * \param str A string.
 * \return A number.
 */
inline variant StrToNum(string str);
/** \example ex_StrToNum.nxc
 * This is an example of how to use the \ref StrToNum function.
 */

/**
 * Get string length.
 * Return the length of the specified string. The length of a string does
 * not include the null terminator at the end of the string. The input
 * string parameter may be a variable, constant, or expression.
 *
 * \param str A string.
 * \return The length of the string.
 */
inline unsigned int StrLen(string str);
/** \example ex_StrLenOld.nxc
 * This is an example of how to use the \ref StrLen function.
 */

/**
 * Extract a character from a string.
 * Return the numeric value of the character in the specified string at the
 * specified index. The input string parameter
 * may be a variable, constant, or expression.
 *
 * \param str A string.
 * \param idx The index of the character to retrieve.
 * \return The numeric value of the character at the specified index.
 */
inline byte StrIndex(string str, unsigned int idx);
/** \example ex_StrIndex.nxc
 * This is an example of how to use the \ref StrIndex function.
 */

/**
 * Convert number to string.
 * Return the string representation of the specified numeric value.
 *
 * \param num A number.
 * \return The string representation of the parameter num.
 */
inline string NumToStr(variant num);
/** \example ex_NumToStr.nxc
 * This is an example of how to use the \ref NumToStr function.
 */

/**
 * Concatenate strings.
 * Return a string which is the result of concatenating all of the
 * string arguments together. This function accepts
 * any number of parameters which may be string variables, constants,
 * or expressions.
 *
 * \param str1 The first string.
 * \param str2 The second string.
 * \param strN The Nth string.
 * \return The concatenated string.
 */
inline string StrCat(string str1, string str2, string strN);
/** \example ex_StrCatOld.nxc
 * This is an example of how to use the \ref StrCat function.
 */

/**
 * Extract a portion of a string.
 * Return a sub-string from the specified input string starting at idx and
 * including the specified number of characters. The input string parameter
 * may be a variable, constant, or expression.
 *
 * \param str A string.
 * \param idx The starting point of the sub-string.
 * \param len The length of the sub-string.
 * \return The sub-string extracted from parameter str.
 */
inline string SubStr(string str, unsigned int idx, unsigned int len);
/** \example ex_SubStr.nxc
 * This is an example of how to use the \ref SubStr function.
 */

/**
 * Flatten a number to a string.
 * Return a string containing the byte representation of the specified value.
 *
 * \param num A number.
 * \return A string containing the byte representation of the parameter num.
 */
inline string Flatten(variant num);
/** \example ex_Flatten.nxc
 * This is an example of how to use the \ref Flatten function.
 */

/**
 * Replace a portion of a string.
 * Return a string with the part of the string replaced (starting at the
 * specified index) with the contents of the new string value provided in
 * the third argument. The input string parameters
 * may be variables, constants, or expressions.
 *
 * \param str A string.
 * \param idx The starting point for the replace operation.
 * \param strnew The replacement string.
 * \return The modified string.
 */
inline string StrReplace(string str, unsigned int idx, string strnew);
/** \example ex_StrReplace.nxc
 * This is an example of how to use the \ref StrReplace function.
 */

/**
 * Format a number.
 * Return the formatted string using the format and value. Use a standard
 * numeric sprintf format specifier within the format string. The input string
 * parameter may be a variable, constant, or expression.
 *
 * \param fmt The string format containing a sprintf numeric format specifier.
 * \param num A number.
 * \return A string containing the formatted numeric value.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline string FormatNum(string fmt, variant num);
/** \example ex_FormatNum.nxc
 * This is an example of how to use the \ref FormatNum function.
 */

/**
 * Flatten any data to a string.
 * Return a string containing the byte representation of the specified value.
 *
 * \sa UnflattenVar
 * \param x Any NXC datatype.
 * \return A string containing the byte representation of the parameter x.
 */
inline string FlattenVar(variant x);
/** \example ex_FlattenVar.nxc
 * This is an example of how to use the \ref FlattenVar function.
 */

/**
 * Unflatten a string into a data type.
 * Convert a string containing the byte representation of the specified
 * variable back into the original variable type.
 *
 * \sa FlattenVar, Flatten
 * \param str A string containing flattened data.
 * \param x A variable reference where the unflattened data is stored.
 * \return A boolean value indicating whether the operation succeeded or not.
 */
inline int UnflattenVar(string str, variant & x);
/** \example ex_UnflattenVar.nxc
 * This is an example of how to use the \ref UnflattenVar function.
 */

#else

#define FlattenVar(_value) asm { flatten __STRRETVAL__, _value }
#define UnflattenVar(_str, _value) asm { \
  unflatten _value, __RETVAL__, _str, _value \
  not __RETVAL__, __RETVAL__ \
}

#endif

/**
 * Convert a byte array to a string.
 * Convert the specified array to a string by appending a null terminator to
 * the end of the array elements. The array must be a one-dimensional array
 * of byte.
 *
 * \sa StrToByteArray, ByteArrayToStrEx
 * \param data A byte array.
 * \return A string containing data and a null terminator byte.
 */
inline string ByteArrayToStr(byte data[]) { asm { arrtostr __STRBUFFER__, data } }
/** \example ex_ByteArrayToStr.nxc
 * This is an example of how to use the \ref ByteArrayToStr function.
 */

/**
 * Convert a byte array to a string.
 * Convert the specified array to a string by appending a null terminator to
 * the end of the array elements. The array must be a one-dimensional array
 * of byte.
 *
 * \sa StrToByteArray, ByteArrayToStr
 * \param data A byte array.
 * \param str A string variable reference which, on output, will contain
 * data and a null terminator byte.
 */
inline void ByteArrayToStrEx(byte data[], string & str) { asm { arrtostr str, data } }
/** \example ex_ByteArrayToStrEx.nxc
 * This is an example of how to use the \ref ByteArrayToStrEx function.
 */

/**
 * Convert a string to a byte array.
 * Convert the specified string to an array of byte by removing the null
 * terminator at the end of the string. The output array variable must be a
 * one-dimensional array of byte.
 *
 * \sa ByteArrayToStr, ByteArrayToStrEx
 * \param str A string
 * \param data A byte array reference which, on output, will contain str
 * without its null terminator.
 */
inline void StrToByteArray(string str, byte & data[]) { asm { strtoarr data, str } }
/** \example ex_StrToByteArray.nxc
 * This is an example of how to use the \ref StrToByteArray function.
 */

/**
 * Copy a portion of a string.
 * Returns a substring of a string.
 *
 * \param str A string
 * \param idx The starting index of the substring.
 * \param len The length of the substring.
 * \return The specified substring.
 */
inline string Copy(string str, unsigned int idx, unsigned int len) {
  asm { strsubset __STRBUFFER__, str, idx, len  }
}
/** \example ex_Copy.nxc
 * This is an example of how to use the \ref Copy function.
 */

/**
 * Copy a portion from the middle of a string.
 * Returns the substring of a specified length that appears at a specified
 * position in a string.
 *
 * \param str A string
 * \param idx The starting index of the substring.
 * \param len The length of the substring.
 * \return The substring of a specified length that appears at a specified
 * position in a string.
 */
inline string MidStr(string str, unsigned int idx, unsigned int len) {
  asm { strsubset __STRBUFFER__, str, idx, len  }
}
/** \example ex_midstr.nxc
 * This is an example of how to use the \ref MidStr function.
 */

/**
 * Copy a portion from the end of a string.
 * Returns the substring of a specified length that appears at the end of a string.
 *
 * \param str A string
 * \param size The size or length of the substring.
 * \return The substring of a specified length that appears at the end of a string.
 */
inline string RightStr(string str, unsigned int size) {
  unsigned int idx;
  asm {
    strlen idx, str
    sub idx, idx, size
    strsubset __STRBUFFER__, str, idx, size
  }
}
/** \example ex_rightstr.nxc
 * This is an example of how to use the \ref RightStr function.
 */

/**
 * Copy a portion from the start of a string.
 * Returns the substring of a specified length that appears at the start of a string.
 *
 * \param str A string
 * \param size The size or length of the substring.
 * \return The substring of a specified length that appears at the start of a string.
 */
inline string LeftStr(string str, unsigned int size) {
  asm { strsubset __STRBUFFER__, str, 0, size  }
}
/** \example ex_leftstr.nxc
 * This is an example of how to use the \ref LeftStr function.
 */

// cstring functions

/**
 * Get string length.
 * Return the length of the specified string. The length of a string does
 * not include the null terminator at the end of the string.
 *
 * \param str A string.
 * \return The length of the string.
 */
inline int strlen(const string & str) { asm { strlen __RETVAL__, str } }
/** \example ex_strlen.nxc
 * This is an example of how to use the \ref strlen function.
 */

/**
 * Concatenate strings.
 * Appends a copy of the source string to the destination string. The
 * terminating null character in destination is overwritten by the first
 * character of source, and a new null-character is appended at the end of
 * the new string formed by the concatenation of both in destination. The
 * destination string is returned.
 *
 * \param dest The destination string.
 * \param src The string to be appended.
 * \return The destination string.
 */
inline string strcat(string & dest, const string & src) {
  asm {
    strcat __STRBUFFER__, dest, src
    mov dest, __STRBUFFER__
  }
}
/** \example ex_strcat.nxc
 * This is an example of how to use the \ref strcat function.
 */

/**
 * Append characters from string.
 * Appends the first num characters of source to destination, plus a
 * terminating null-character. If the length of the string in source is less
 * than num, only the content up to the terminating null-character is copied.
 * The destination string is returned.
 *
 * \param dest The destination string.
 * \param src The string to be appended.
 * \param num The maximum number of characters to be appended.
 * \return The destination string.
 */
inline string strncat(string & dest, const string & src, unsigned int num) {
  asm {
    strsubset __STRRETVAL__, src, 0, num
    strcat __STRBUFFER__, dest, __STRRETVAL__
    mov dest, __STRBUFFER__
  }
}
/** \example ex_strncat.nxc
 * This is an example of how to use the \ref strncat function.
 */

/**
 * Copy string.
 * Copies the string pointed by source into the array pointed by destination,
 * including the terminating null character. The destination string is returned.
 *
 * \param dest The destination string.
 * \param src The string to be appended.
 * \return The destination string.
 */
inline string strcpy(string & dest, const string & src) {
  asm {
    mov __STRBUFFER__, src
    mov dest, __STRBUFFER__
  }
}
/** \example ex_strcpy.nxc
 * This is an example of how to use the \ref strcpy function.
 */

/**
 * Copy characters from string.
 * Copies the first num characters of source to destination. The destination
 * string is returned.
 *
 * \param dest The destination string.
 * \param src The string to be appended.
 * \param num The maximum number of characters to be appended.
 * \return The destination string.
 */
inline string strncpy(string & dest, const string & src, unsigned int num) {
  asm {
    strsubset dest, src, 0, num
    mov __STRBUFFER__, dest
  }
}
/** \example ex_strncpy.nxc
 * This is an example of how to use the \ref strncpy function.
 */

/**
 * Compare two strings.
 * Compares the string str1 to the string str2.
 *
 * \param str1 A string to be compared.
 * \param str2 A string to be compared.
 * \return Returns an integral value indicating the relationship between the
 * strings. A zero value indicates that both strings are equal. A value
 * greater than zero indicates that the first character that does not match
 * has a greater value in str1 than in str2. A value less than zero indicates
 * the opposite.
 */
inline int strcmp(const string & str1, const string & str2) {
  int result = -1;
  if (str1 == str2)
    result = 0;
  else if (str1 > str2)
    result = 1;
  return result;
}
/** \example ex_strcmp.nxc
 * This is an example of how to use the \ref strcmp function.
 */

/**
 * Compare characters of two strings.
 * Compares up to num characters of the string str1 to those of the string str2.
 *
 * \param str1 A string to be compared.
 * \param str2 A string to be compared.
 * \param num The maximum number of characters to be compared.
 * \return Returns an integral value indicating the relationship between the
 * strings. A zero value indicates that the characters compared in both
 * strings are all equal. A value greater than zero indicates that the first
 * character that does not match has a greater value in str1 than in str2. A
 * value less than zero indicates the opposite.
 */
inline int strncmp(const string & str1, const string & str2, unsigned int num) {
  string sub1, sub2;
  asm {
    strsubset sub1, str1, 0, num
    strsubset sub2, str2, 0, num
  }
  int result = -1;
  if (sub1 == sub2)
    result = 0;
  else if (sub1 > sub2)
    result = 1;
  return result;
}
/** \example ex_strncmp.nxc
 * This is an example of how to use the \ref strncmp function.
 */

#ifdef __DOXYGEN_DOCS

/**
 * Copy memory.
 * Copies memory contents from the source to the destination. The num
 * argument is ignored.
 *
 * \param dest The destination variable.
 * \param src The source variable.
 * \param num The number of bytes to copy (ignored).
 */
inline void memcpy(variant dest, variant src, byte num);
/** \example ex_memcpy.nxc
 * This is an example of how to use the \ref memcpy function.
 */

/**
 * Move memory.
 * Moves memory contents from the source to the destination. The num
 * argument is ignored.
 *
 * \param dest The destination variable.
 * \param src The source variable.
 * \param num The number of bytes to copy (ignored).
 */
inline void memmove(variant dest, variant src, byte num);
/** \example ex_memmove.nxc
 * This is an example of how to use the \ref memmove function.
 */

/**
 * Compare two blocks of memory.
 * Compares the variant ptr1 to the variant ptr2. Returns an integral value
 * indicating the relationship between the variables. The num argument is
 * ignored.
 *
 * \param ptr1 A variable to be compared.
 * \param ptr2 A variable to be compared.
 * \param num The number of bytes to compare (ignored).
 */
inline char memcmp(variant ptr1, variant ptr2, byte num);
/** \example ex_memcmp.nxc
 * This is an example of how to use the \ref memcmp function.
 */

/**
 * Get the absolute address of a variable.
 * Get the absolute address of a variable and return it to the calling routine
 * as an unsigned long value.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param data A variable whose address you wish to get.
 * \return The absolute address of the variable.
 */
inline unsigned long addr(variant data);
/** \example ex_addr.nxc
 * This is an example of how to use the \ref addr function.
 */

/**
 * Get the relative address of a variable.
 * Get the relative address of a variable and return it to the calling routine
 * as an unsigned long value.  The relative address is an offset from the
 * Command module's MemoryPool address.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param data A variable whose address you wish to get.
 * \return The relative address of the variable.
 */
inline unsigned long reladdr(variant data);
/** \example ex_reladdr.nxc
 * This is an example of how to use the \ref reladdr function.
 */

/**
 * Get the absolute or relative address of a variable.
 * Get the absolute or relative address of a variable and return it to the
 * calling routine as an unsigned long value. The relative address is an
 * offset from the Command module's MemoryPool address.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param data A variable whose address you wish to get.
 * \param relative A boolean flag indicating whether you want to get the
 * relative or absolute address.
 * \return The absolute or relative address of the variable.
 */
inline unsigned long addrex(variant data, bool relative);
/** \example ex_addrex.nxc
 * This is an example of how to use the \ref addrex function.
 */

#else

#define memcpy(_dest, _src, _num) asm { mov _dest, _src }
#define memmove(_dest, _src, _num) asm { mov _dest, _src }
#define memcmp(_ptr1, _ptr2, _num) ( (_ptr1 == _ptr2) ? 0 : ( (_ptr1 > _ptr2) ? 1 : -1 ) )

#define addr(_data) asm { addrof __URETVAL__, _data, 0 }
#define reladdr(_data) asm { addrof __URETVAL__, _data, 1 }
#define addrex(_data, _rel) asm { \
  addrof __URETVAL__, _data, _rel \
}

#endif

/*
void * memchr (void * ptr, int value, size_t num ); // Locate character in block of memory
char * strchr (       char * str, int character ); // Locate first occurrence of character in string
size_t strcspn ( const char * str1, const char * str2 ); // Get span until character in string
char * strpbrk ( const char *, const char * ); // Locate character in string
char * strrchr ( const char *, int ); // Locate last occurrence of character in string
size_t strspn ( const char * str1, const char * str2 ); // Get span of character set in string
char * strtok ( char * str, const char * delimiters ); // Split string into tokens
char * strstr ( const char *, const char * ); // Locate substring

void * memset ( void * ptr, byte value, size_t num ); // Fill block of memory (something like replace)
*/

/** \example ex_string.nxc
 * This is an example of how to use the string API functions: \ref StrToNum, \ref StrLen,
 * \ref StrIndex, \ref NumToStr, \ref StrCat, \ref SubStr, \ref Flatten,
 * \ref StrReplace, \ref FormatNum, \ref FlattenVar, \ref UnflattenVar,
 * \ref ByteArrayToStr, \ref ByteArrayToStrEx, and \ref StrToByteArray.
 */

/** \example ex_cstring.nxc
 * This is an example of how to use the cstring API functions: \ref strcat, \ref strcmp, \ref strcpy,
 * \ref strlen, \ref strncat, \ref strncmp, \ref strncpy, \ref memcpy,
 * \ref memmove, and \ref memcmp.
 */

/** @} */ // end of cstringAPI group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// ctype API ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup ctypeAPI ctype API
 * Standard C ctype API functions.
 * @{
 */
/**
 * Check if character is uppercase letter.
 * Checks if parameter c is an uppercase alphabetic letter.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is an uppercase alphabetic
 * letter, otherwise it returns 0 (false).
 */
inline int isupper(int c) { return ((c >= 'A') && (c <= 'Z')); }
/** \example ex_isupper.nxc
 * This is an example of how to use the \ref isupper function.
 */

/**
 * Check if character is lowercase letter.
 * Checks if parameter c is an lowercase alphabetic letter.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is an lowercase alphabetic
 * letter, otherwise it returns 0 (false).
 */
inline int islower(int c) { return ((c >= 'a') && (c <= 'z')); }
/** \example ex_islower.nxc
 * This is an example of how to use the \ref islower function.
 */

/**
 * Check if character is alphabetic.
 * Checks if parameter c is either an uppercase or lowercase letter.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is an alphabetic letter,
 * otherwise it returns 0 (false).
 */
inline int isalpha(int c) { return isupper(c) || islower(c); }
/** \example ex_isalpha.nxc
 * This is an example of how to use the \ref isalpha function.
 */

/**
 * Check if character is decimal digit.
 * Checks if parameter c is a decimal digit character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a decimal digit, otherwise
 * it returns 0 (false).
 */
inline int isdigit(int c) { return ((c >= '0') && (c <= '9')); }
/** \example ex_isdigit.nxc
 * This is an example of how to use the \ref isdigit function.
 */

/**
 * Check if character is alphanumeric.
 * Checks if parameter c is either a decimal digit or an uppercase or
 * lowercase letter. The result is true if either isalpha or isdigit would
 * also return true.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is either a digit or a
 * letter, otherwise it returns 0 (false).
 */
inline int isalnum(int c) { return isalpha(c) || isdigit(c); }
/** \example ex_isalnum.nxc
 * This is an example of how to use the \ref isalnum function.
 */

/**
 * Check if character is a white-space.
 * Checks if parameter c is a white-space character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a white-space character,
 * otherwise it returns 0 (false).
 */
inline int isspace(int c) { return (c == 0x20) || ((c >= 0x09) && (c <= 0x0d)); }
/** \example ex_isspace.nxc
 * This is an example of how to use the \ref isspace function.
 */

/**
 * Check if character is a control character.
 * Checks if parameter c is a control character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a control character,
 * otherwise it returns 0 (false).
 */
inline int iscntrl(int c) { return (c <= 0x1f) || (c == 0x7f); }
/** \example ex_iscntrl.nxc
 * This is an example of how to use the \ref iscntrl function.
 */

/**
 * Check if character is printable.
 * Checks if parameter c is a printable character (i.e., not a control
 * character).
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a printable character,
 * otherwise it returns 0 (false).
 */
inline int isprint(int c) { return !iscntrl(c); }
/** \example ex_isprint.nxc
 * This is an example of how to use the \ref isprint function.
 */

/**
 * Check if character has graphical representation.
 * Checks if parameter c is a character with a graphical representation.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c has a graphical representation,
 * otherwise it returns 0 (false).
 */
inline int isgraph(int c) { return (c != 0x20) && isprint(c); }
/** \example ex_isgraph.nxc
 * This is an example of how to use the \ref isgraph function.
 */

/**
 * Check if character is a punctuation.
 * Checks if parameter c is a punctuation character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a punctuation character,
 * otherwise it returns 0 (false).
 */
inline int ispunct(int c) { return isgraph(c) && !isalnum(c); }
/** \example ex_ispunct.nxc
 * This is an example of how to use the \ref ispunct function.
 */

/**
 * Check if character is hexadecimal digit.
 * Checks if parameter c is a hexadecimal digit character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a hexadecimal digit
 * character, otherwise it returns 0 (false).
 */
inline int isxdigit(int c) {  return isdigit(c) || ((c >= 'A') && (c <= 'F')) || ((c >= 'a') && (c <= 'f')); }
/** \example ex_isxdigit.nxc
 * This is an example of how to use the \ref isxdigit function.
 */

/**
 * Convert lowercase letter to uppercase.
 * Converts parameter c to its uppercase equivalent if c is a lowercase
 * letter and has an uppercase equivalent. If no such conversion is possible,
 * the value returned is c unchanged.
 *
 * \param c Lowercase letter character to be converted.
 * \return The uppercase equivalent to c, if such value exists, or c
 * (unchanged) otherwise..
 */
inline int toupper(int c) { if (islower(c)) c -= 32; return c; }
/** \example ex_toupper.nxc
 * This is an example of how to use the \ref toupper function.
 */

/**
 * Convert uppercase letter to lowercase.
 * Converts parameter c to its lowercase equivalent if c is an uppercase
 * letter and has a lowercase equivalent. If no such conversion is possible,
 * the value returned is c unchanged.
 *
 * \param c Uppercase letter character to be converted.
 * \return The lowercase equivalent to c, if such value exists, or c
 * (unchanged) otherwise..
 */
inline int tolower(int c) { if (isupper(c)) c += 32; return c; }
/** \example ex_tolower.nxc
 * This is an example of how to use the \ref tolower function.
 */

/** \example ex_ctype.nxc
 * This is an example of how to use the ctype API functions: \ref isupper, \ref islower, \ref isalpha,
 * \ref isdigit, \ref isalnum, \ref isspace, \ref iscntrl, \ref isprint,
 * \ref isgraph, \ref ispunct, \ref isxdigit, \ref toupper, and \ref tolower.
 */

/** @} */ // end of ctypeAPI group

/** @} */ // end of StandardCAPIFunctions group


/** @addtogroup RICMacros
 * @{
 */
/**
 * Set the value of an element in an RIC data array.
 * \param _data The RIC data array
 * \param _idx The array index to update
 * \param _newval The new value to write into the RIC data array
 */
#define RICSetValue(_data, _idx, _newval) _data[(_idx)] = (_newval)&0xFF; _data[(_idx)+1] = (_newval)>>8
/** @} */ // end of RICMacros group

/** @addtogroup GraphicsLibrary
 * @{
 */
//;-----------------------------------------------------------------------------------------
//; File          : nbcGL.nbc
//; Description   : Data and subroutines for a very simple 3D engine.
//; Programmed by : Arno van der Vegt, avandervegt@home.nl
//;-----------------------------------------------------------------------------------------

/**
 * Initialize graphics library.
 * Setup all the necessary data for the graphics library to function. Call this
 * function before any other graphics library routine.
 */
inline void glInit() { asm { __glInit() } }

/**
 * Set graphics library options.
 * Adjust graphic library settings for circle size and cull mode.
 *
 * \param glType The setting type.  See \ref GLConstantsSettings.
 * \param glValue The setting value. For culling modes see \ref GLConstantsCullMode.
 */
inline void glSet(int glType, int glValue) { asm { __glSet(glType, glValue) } }

/**
 * Begin defining an object.
 * Start the process of defining a graphics library object using low level
 * functions such as \ref glBegin, \ref glAddVertex, and \ref glEnd.
 *
 * \return The object index of the new object being created.
 */
inline int glBeginObject() { asm { __glBeginObject(__RETVAL__) } }

/**
 * Stop defining an object.
 * Finish the process of defining a graphics library object.  Call this function
 * after you have completed the object definition.
 */
inline void glEndObject() { asm { __glEndObject() } }

/**
 * Perform an object action.
 * Execute the specified action on the specified object.
 *
 * \param glObjectId The object id.
 * \param glAction The action to perform on the object. See \ref GLConstantsActions.
 * \param glValue The setting value.
 */
inline void glObjectAction(int glObjectId, int glAction, int glValue) {
  asm { __glObjectAction(glObjectId, glAction, glValue) }
}

/**
 * Add a vertex to an object.
 * Add a vertex to an object currently being defined.  This function should
 * only be used between \ref glBegin and \ref glEnd which are themselves
 * nested within a \ref glBeginObject and \ref glEndObject pair.
 *
 * \param glX The X axis coordinate.
 * \param glY The Y axis coordinate.
 * \param glZ The Z axis coordinate.
 */
inline void glAddVertex(int glX, int glY, int glZ) {
  asm { __glAddVertex(glX, glY, glZ) }
}

/**
 * Begin a new polygon for the current object.
 * Start defining a polygon surface for the current graphics object using
 * the specified begin mode.
 *
 * \param glBeginMode The desired mode.  See \ref GLConstantsBeginModes.
 */
inline void glBegin(int glBeginMode) { asm { __glBegin(glBeginMode) } }

/**
 * Finish a polygon for the current object.
 * Stop defining a polgyon surface for the current graphics object.
 */
inline void glEnd() { asm { __glEnd() } }

/**
 * Begin a new render.
 * Start the process of rendering the existing graphic objects.
 */
inline void glBeginRender() { asm { __glBeginRender() } }

/**
 * Call a graphic object.
 * Tell the graphics library that you want it to include the specified
 * object in the render.
 *
 * \param glObjectId The desired object id.
 */
inline void glCallObject(int glObjectId) { asm { __glCallObject(glObjectId) } }

/**
 * Finish the current render.
 * Rotate the vertex list, clear the screen, and draw the rendered objects
 * to the LCD.
 */
inline void glFinishRender() { asm { __glFinishRender() } }

/**
 * Set the X axis angle.
 * Set the X axis angle to the specified value.
 *
 * \param glValue The new X axis angle.
 */
inline void glSetAngleX(int glValue) { asm { __glSetAngleX(glValue) } }

/**
 * Add to the X axis angle.
 * Add the specified value to the existing X axis angle.
 *
 * \param glValue The value to add to the X axis angle.
 */
inline void glAddToAngleX(int glValue) { asm { __glAddToAngleX(glValue) } }

/**
 * Set the Y axis angle.
 * Set the Y axis angle to the specified value.
 *
 * \param glValue The new Y axis angle.
 */
inline void glSetAngleY(int glValue) { asm { __glSetAngleY(glValue) } }

/**
 * Add to the Y axis angle.
 * Add the specified value to the existing Y axis angle.
 *
 * \param glValue The value to add to the Y axis angle.
 */
inline void glAddToAngleY(int glValue) { asm { __glAddToAngleY(glValue) } }

/**
 * Set the Z axis angle.
 * Set the Z axis angle to the specified value.
 *
 * \param glValue The new Z axis angle.
 */
inline void glSetAngleZ(int glValue) { asm { __glSetAngleZ(glValue) } }

/**
 * Add to the Z axis angle.
 * Add the specified value to the existing Z axis angle.
 *
 * \param glValue The value to add to the Z axis angle.
 */
inline void glAddToAngleZ(int glValue) { asm { __glAddToAngleZ(glValue) } }

/**
 * Table-based sine scaled by 32768.
 * Return the sine of the specified angle in degrees.  The result is scaled
 * by 32768.
 *
 * \param glAngle The angle in degrees.
 * \return The sine value scaled by 32768.
 */
inline int glSin32768(int glAngle) { asm { __glSin32768(__RETVAL__, glAngle) } }

/**
 * Table-based cosine scaled by 32768.
 * Return the cosine of the specified angle in degrees.  The result is scaled
 * by 32768.
 *
 * \param glAngle The angle in degrees.
 * \return The cosine value scaled by 32768.
 */
inline int glCos32768(int glAngle) { asm { __glCos32768(__RETVAL__, glAngle) } }

/**
 * Create a 3D box.
 * Define a 3D box using the specified begin mode for all faces. The center
 * of the box is at the origin of the XYZ axis with width, height, and depth
 * specified via the glSizeX, glSizeY, and glSizeZ parameters.
 *
 * \param glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param glSizeX The X axis size (width).
 * \param glSizeY The Y axis size (height).
 * \param glSizeZ The Z axis size (depth).
 */
inline int glBox(int glMode, int glSizeX, int glSizeY, int glSizeZ) {
  asm { __glBox(glMode, glSizeX, glSizeY, glSizeZ, __RETVAL__) }
}

/**
 * Create a 3D cube.
 * Define a 3D cube using the specified begin mode for all faces. The center
 * of the box is at the origin of the XYZ axis with equal width, height, and depth
 * specified via the glSize parameter.
 *
 * \param glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param glSize The cube's width, height, and depth.
 */
inline int glCube(int glMode, int glSize) {
  asm { __glBox(glMode, glSize, glSize, glSize, __RETVAL__) }
}

/**
 * Create a 3D pyramid.
 * Define a 3D pyramid using the specified begin mode for all faces. The center
 * of the pyramid is at the origin of the XYZ axis with width, height, and depth
 * specified via the glSizeX, glSizeY, and glSizeZ parameters.
 *
 * \param glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param glSizeX The X axis size (width).
 * \param glSizeY The Y axis size (height).
 * \param glSizeZ The Z axis size (depth).
 */
inline int glPyramid(int glMode, int glSizeX, int glSizeY, int glSizeZ) {
  asm { __glPyramid(glMode, glSizeX, glSizeY, glSizeZ, __RETVAL__) }
}

/** \example glTranslateDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBox,
 * \ref glSetAngleX, \ref glAddToAngleY, \ref glBeginRender, \ref glSet,
 * \ref glCallObject, \ref glObjectAction, and \ref glFinishRender functions.
 */

/** \example glScaleDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBox,
 * \ref glSetAngleX, \ref glAddToAngleY, \ref glBeginRender,
 * \ref glCallObject, \ref glObjectAction, and \ref glFinishRender functions.
 */

/** \example glRotateDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBox,
 * \ref glSetAngleX, \ref glBeginRender,
 * \ref glCallObject, \ref glObjectAction, and \ref glFinishRender functions.
 */

/** \example glCircleDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBox,
 * \ref glSetAngleX, \ref glBeginRender, \ref glAddToAngleY, \ref glAddToAngleX
 * \ref glCallObject, \ref glSet, and \ref glFinishRender functions.
 */

/** \example glBoxDemo.nxc
 * This is an example of how to use the \ref glInit, \ref glBeginObject,
 * \ref glBegin, \ref glAddVertex, \ref glEnd, \ref glEndObject,
 * \ref glSetAngleX, \ref glBeginRender, \ref glAddToAngleY,
 * \ref glCallObject, and \ref glFinishRender functions.
 */


/** @} */ // end of GraphicsLibrary group

#endif // NXCDEFS_H
