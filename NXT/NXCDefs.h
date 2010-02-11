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
 * \date 2010-02-05
 * \version 63
 */
#ifndef NXCDEFS_H
#define NXCDEFS_H

/** @defgroup InputModule Input module
 * Constants and functions related to the Input module.
 */

/** @defgroup InputModuleConstants Input module constants
 * Constants that are part of the NXT firmware's Input module.
 */

/** @defgroup OutputModule Output module
 * Constants and functions related to the Output module.
 */

/** @defgroup OutputModuleConstants Output module constants
 * Constants that are part of the NXT firmware's Output module.
 */

/** @defgroup CommandModule Command module
 * Constants and functions related to the Command module.
 */

/** @defgroup CommModule Comm module
 * Constants and functions related to the Comm module.
 */

/** @defgroup ButtonModule Button module
 * Constants and functions related to the Button module.
 */

/** @defgroup IOCtrlModule IOCtrl module
 * Constants and functions related to the IOCtrl module.
 */

/** @defgroup LoaderModule Loader module
 * Constants and functions related to the Loader module.
 */

/** @defgroup SoundModule Sound module
 * Constants and functions related to the Sound module.
 */

/** @defgroup UiModule Ui module
 * Constants and functions related to the Ui module.
 */

/** @defgroup LowSpeedModule Low Speed module
 * Constants and functions related to the Low Speed module.
 */

/** @defgroup DisplayModule Display module
 * Constants and functions related to the Display module.
 */

/** @defgroup HiTechnicAPI HiTechnic API Functions
 * Functions for accessing and modifying HiTechnic devices.
 */

/** @defgroup MindSensorsAPI MindSensors API Functions
 * Functions for accessing and modifying MindSensors devices.
 */

/** @defgroup RICMacros RIC Macro Wrappers
 * Macro wrappers for use in defining RIC byte arrays.
 */

#include "NBCCommon.h"


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


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// INPUT MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


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
#define _SENSOR_CFG(_type,_mode)	(((_type)<<8)+(_mode))                               /*!< Macro for defining SetSensor combined type and mode constants */
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
#define SENSOR_COLORRED		_SENSOR_CFG(SENSOR_TYPE_COLORRED, SENSOR_MODE_RAW)           /*!< NXT 2.0 color sensor (red) in raw mode */
#define SENSOR_COLORGREEN	_SENSOR_CFG(SENSOR_TYPE_COLORGREEN, SENSOR_MODE_RAW)         /*!< NXT 2.0 color sensor (green) in raw mode */
#define SENSOR_COLORBLUE	_SENSOR_CFG(SENSOR_TYPE_COLORBLUE, SENSOR_MODE_RAW)          /*!< NXT 2.0 color sensor (blue) in raw mode */
#define SENSOR_COLORNONE	_SENSOR_CFG(SENSOR_TYPE_COLORNONE, SENSOR_MODE_RAW)          /*!< NXT 2.0 color sensor (none) in raw mode */
#endif
/** @} */ // end of SensorModes group
/** @} */ // end of InputModuleConstants group

/** @defgroup InputModuleTypes Input module types
 * Types used by various input module functions.
 * @{
 */
#if __FIRMWARE_VERSION > 107
/**
 * ColorSensorReadType structure.
 * This structure is used when calling the \ref SysColorSensorRead system call function.
 * Choose the sensor port (S1, S2, S3, or S4) and after calling the function
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
 * constants.
 * \sa SetSensorMode(), SetSensor()
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 * \param type The desired sensor type.
 */
inline void SetSensorType(byte port, byte type) { asm { setin type, port, Type } }

/**
 * Set sensor mode.
 * Set a sensor's mode, which should be one of the predefined sensor mode
 * constants. A slope parameter for boolean conversion, if desired, may be
 * added to the mode.
 * \sa SetSensorType(), SetSensor()
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 * \param mode The desired sensor mode.
 */
inline void SetSensorMode(byte port, byte mode) { asm { setin mode, port, InputMode } }

/**
 * Clear a sensor value.
 * Clear the value of a sensor - only affects sensors that are configured
 * to measure a cumulative quantity such as rotation or a pulse count.
 * \param port The port to clear. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void ClearSensor(byte port) { asm { setin 0, port, ScaledValue } }

/**
 * Reset the sensor port.
 * Sets the invalid data flag on the specified port and waits for it to
 * become valid again.
 * \param port The port to reset. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void ResetSensor(byte port) { asm { __ResetSensor(port) } }

/**
 * Set sensor configuration.
 * Set the type and mode of the given sensor to the specified configuration,
 * which must be a special constant containing both type and mode information.
 * \sa SetSensorType(), SetSensorMode(), and ResetSensor()
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 * \param config The configuration constant containing both the type and mode.
 */
inline void SetSensor(byte port, const byte config) {
  SetSensorType(port, config>>8);
  SetSensorMode(port, config&0xff);
  ResetSensor(port);
}

/**
 * Configure a touch sensor.
 * Configure the sensor on the specified port as a touch sensor.
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void SetSensorTouch(byte port) { asm { __SetSensorTouch(port) } }

/**
 * Configure a light sensor.
 * Configure the sensor on the specified port as a light sensor (active).
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void SetSensorLight(byte port) { asm { __SetSensorLight(port) } }

/**
 * Configure a sound sensor.
 * Configure the sensor on the specified port as a sound sensor (dB scaling).
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void SetSensorSound(byte port) { asm { __SetSensorSound(port) } }

/**
 * Configure an I2C sensor.
 * Configure the sensor on the specified port as an I2C digital sensor
 * (9V powered).
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void SetSensorLowspeed(byte port) { asm { __SetSensorLowspeed(port) } }

#if __FIRMWARE_VERSION > 107

/**
 * Configure an NXT 2.0 full color sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in full color mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void SetSensorColorFull(byte port) { asm { __SetSensorColorFull(port) } }

/**
 * Configure an NXT 2.0 red light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in red light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void SetSensorColorRed(byte port) { asm { __SetSensorColorRed(port) } }

/**
 * Configure an NXT 2.0 green light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in green light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void SetSensorColorGreen(byte port) { asm { __SetSensorColorGreen(port) } }

/**
 * Configure an NXT 2.0 blue light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in blue light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void SetSensorColorBlue(byte port) { asm { __SetSensorColorBlue(port) } }

/**
 * Configure an NXT 2.0 no light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in no light mode. Requires an NXT 2.0 compatible firmware.
 * \param port The port to configure. Use a constant (e.g., S1, S2, S3, or S4) or a variable.
 */
inline void SetSensorColorNone(byte port) { asm { __SetSensorColorNone(port) } }

#endif

//  AddAPIFunction('GetInput', APIF_GETINPUT);
// SetInput(port, field, value)

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
/** @} */ // end of InputModuleFunctions group
/** @} */ // end of InputModule group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// OUTPUT MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup OutputModule
 * @{
 */
/** @defgroup OutputModuleFunctions Output module functions
 * Functions for accessing and modifying output module features.
 * @{
 */
//  AddAPIFunction('GetOutput', APIF_GETOUTPUT);
// SetOutput(ports, field, value [, field, value, ...])

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

//RotateMotor(ports, pwr, angle)
//RotateMotorEx(ports, pwr, angle, turnpct, bSync, bStop)
//RotateMotorPID(ports, pwr, angle, p, i, d)
//RotateMotorExPID(ports, pwr, angle, turnpct, bSync, bStop, p, i, d)
//OnFwdSyncExPID(ports, pwr, turnpct, reset, p, i, d)
//OnRevSyncExPID(ports, pwr, turnpct, reset, p, i, d)
//OnFwdSyncPID(ports, pwr, turnpct, p, i, d)
//OnRevSyncPID(ports, pwr, turnpct, p, i, d)
//OnFwdRegExPID(ports, pwr, regmode, reset, p, i, d)
//OnRevRegExPID(ports, pwr, regmode, reset, p, i, d)
//OnFwdRegPID(ports, pwr, regmode, p, i, d)
//OnRevRegPID(ports, pwr, regmode, p, i, d)
//OnFwdSyncEx(ports, pwr, turnpct, reset)
//OnRevSyncEx(ports, pwr, turnpct, reset)
//OnFwdSync(ports, pwr, turnpct)
//OnRevSync(ports, pwr, turnpct)
//OnFwdRegEx(ports, pwr, regmode, reset)
//OnRevRegEx(ports, pwr, regmode, reset)
//OnFwdReg(ports, pwr, regmode)
//OnRevReg(ports, pwr, regmode)
//OnFwdEx(ports, pwr, reset)
//OnRevEx(ports, pwr, reset)
//OnFwd(ports, pwr)
//OnRev(ports, pwr)
// Off(ports)
// Coast(ports)
// Float(ports)
// OffEx(ports, reset)
// CoastEx(ports, reset)
// ResetTachoCount(ports)
// ResetBlockTachoCount(ports)
// ResetRotationCount(ports)
// ResetAllTachoCounts(ports)

/** @} */ // end of OutputModuleFunctions group
/** @} */ // end of OutputModule group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// DISPLAY MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup DisplayModule
 * @{
 */
/** @defgroup DisplayModuleTypes Display module types
 * Types used by various display module functions.
 * @{
 */
/**
 * LocationType structure.
 * This structure is by other system call structures to specify an X, Y
 * LCD screen coordinate.
 * \sa DrawTextType, DrawPointType, DrawLineType, DrawCircleType, DrawRectType,
 * DrawGraphicType, DrawGraphicArrayType, DrawPolygonType, DrawEllipseType,
 * DrawFontType
 */
struct LocationType {
  int X;  /*!< The X coordinate. Valid range is from 0 to 99 inclusive.  */
  int Y;  /*!< The Y coordinate. Valid range is from 0 to 63 inclusive. For text drawing this value must be a multiple of 8. */
};

/**
 * SizeType structure.
 * This structure is by the \ref DrawRectType to specify a width and
 * height for a rectangle.
 * \sa DrawRectType
 */
struct SizeType {
  int Width;  /*!< The rectangle width. */
  int Height; /*!< The rectangle height. */
};

/**
 * DrawTextType structure.
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
  unsigned long Options;   /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * DrawPointType structure.
 * This structure is used when calling the \ref SysDrawPoint system call
 * function.
 * \sa SysDrawPoint()
 */
struct DrawPointType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The point location on screen. */
  unsigned long Options;   /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * DrawLineType structure.
 * This structure is used when calling the \ref SysDrawLine system call
 * function.
 * \sa SysDrawLine()
 */
struct DrawLineType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType StartLoc;   /*!< The location of the starting point. */
  LocationType EndLoc;     /*!< The location of the ending point. */
  unsigned long Options;   /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * DrawCircleType structure.
 * This structure is used when calling the \ref SysDrawCircle system call
 * function.
 * \sa SysDrawCircle()
 */
struct DrawCircleType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Center;     /*!< The location of the circle center. */
  byte Size;               /*!< The circle radius. */
  unsigned long Options;   /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * DrawRectType structure.
 * This structure is used when calling the \ref SysDrawRect system call
 * function.
 * \sa SysDrawRect()
 */
struct DrawRectType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The top left corner location. */
  SizeType Size;           /*!< The width and height of the rectangle. */
  unsigned long Options;   /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * DrawGraphicType structure.
 * This structure is used when calling the \ref SysDrawGraphic system call
 * function.
 * \sa SysDrawGraphic()
 */
struct DrawGraphicType {
  char Result;             /*!< The function call result. \todo ?. */
  LocationType Location;   /*!< The location on screen. */
  string Filename;         /*!< The RIC file name. */
  int Variables[];         /*!< The variables passed as RIC arguments. \todo add padding? */
  unsigned long Options;   /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * SetScreenModeType structure.
 * This structure is used when calling the \ref SysSetScreenMode system call
 * function.
 * \sa SysSetScreenMode()
 */
struct SetScreenModeType {
  char Result;                /*!< The function call result. \todo ?. */
  unsigned long ScreenMode;   /*!< The requested screen mode.

                                The standard NXT firmware only supports
                                setting the ScreenMode to \ref SCREEN_MODE_RESTORE.

                                If you install the NBC/NXC enhanced standard
                                NXT firmware this system function also
                                supports setting the ScreenMode to
                                \ref SCREEN_MODE_CLEAR.

                                \todo add ref */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * DisplayExecuteFunctionType structure.
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
  byte Status;   /*!< The function call result. \todo ?. */
  byte Cmd;      /*!< The command to execute. */
  bool On;       /*!< The On parameter, see table. */
  byte X1;       /*!< The X1 parameter, see table. */
  byte Y1;       /*!< The Y1 parameter, see table. */
  byte X2;       /*!< The X2 parameter, see table. */
  byte Y2;       /*!< The Y2 parameter, see table. */
};

#if __FIRMWARE_VERSION > 107
// DrawGraphicArray
struct DrawGraphicArrayType {
 char Result;
 LocationType Location;
 byte Data[];
 long Variables[];
 unsigned long Options;
};

struct DrawPolygonType {
 char Result;
 LocationType Points[];
 unsigned long Options;
};

// DrawEllipse
struct DrawEllipseType {
 char Result;
 LocationType Center;
 byte SizeX;
 byte SizeY;
 unsigned long Options;
};

// DrawFont
struct DrawFontType {
 char Result;
 LocationType Location;
 string Filename;
 string Text;
 unsigned long Options;
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
/** \example ex_disprest.nxc
 * How to use the \ref ResetScreen function.
 */

/**
 * Draw a circle.
 * This function lets you draw a circle on the screen with its center at the
 * specified x and y location, using the specified radius. Optionally specify
 * drawing options. If this argument is not specified it defaults to DRAW_OPT_NORMAL.
 * Valid display option constants are listed in the \ref DisplayDrawOptionConstants group.
 *
 * \param x The x value for the center of the circle.
 * \param y The y value for the center of the circle.
 * \param radius The radius of the circle.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char CircleOut(int x, int y, byte radius, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispcout.nxc
 * How to use the \ref CircleOut function.
 */

/**
 * Draw an ellipse.
 * This function lets you draw an ellipse on the screen with its center at the
 * specified x and y location, using the specified radii. Optionally specify
 * drawing options. If this argument is not specified it defaults to DRAW_OPT_NORMAL.
 * Valid display option constants are listed in the \ref DisplayDrawOptionConstants group.
 *
 * \param x The x value for the center of the ellipse.
 * \param y The y value for the center of the ellipse.
 * \param radius1 The x axis radius.
 * \param radius2 The y axis radius.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char EllipseOut(int x, int y, byte radius1, byte radius2, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispeout.nxc
 * How to use the \ref EllipseOut function.
 */

/**
 * Draw a line.
 * This function lets you draw a line on the screen from x1, y1 to x2, y2.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 *
 * \param x1 The x value for the start of the line.
 * \param y1 The y value for the start of the line.
 * \param x2 The x value for the end of the line.
 * \param y2 The y value for the end of the line.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char LineOut(int x1, int y1, int x2, int y2, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_displout.nxc
 * How to use the \ref LineOut function.
 */

/**
 * Draw a point.
 * This function lets you draw a point on the screen at x, y.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 *
 * \param x The x value for the point.
 * \param y The y value for the point.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char PointOut(int x, int y, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_disppout.nxc
 * How to use the \ref PointOut function.
 */

/**
 * Draw a polygon.
 * This function lets you draw a polygon on the screen using an array of points.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 *
 * \param points An array of LocationType points that define the polygon.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char PolyOut(LocationType points[], unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispplout.nxc
 * How to use the \ref PolyOut function.
 */

/**
 * Draw a rectangle.
 * This function lets you draw a rectangle on the screen at x, y with the
 * specified width and height.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 *
 * \param x The x value for the top left corner of the rectangle.
 * \param y The y value for the top left corner of the rectangle.
 * \param width The width of the rectangle.
 * \param height The height of the rectangle.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char RectOut(int x, int y, int width, int height, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_disppout.nxc
 * How to use the \ref LineOut function.
 */


/**
 * Draw text.
 * Draw a text value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 *
 * \param x The x value for the start of the text output.
 * \param y The text line number for the text output.
 * \param str The text to output to the LCD screen.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char TextOut(int x, int y, string str, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_disptout.nxc
 * How to use the \ref TextOut function.
 */

/**
 * Draw a number.
 * Draw a numeric value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 *
 * \param x The x value for the start of the text output.
 * \param y The text line number for the text output.
 * \param value The value to output to the LCD screen. Any numeric type is supported.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char NumOut(int x, int y, variant number, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispnout.nxc
 * How to use the \ref NumOut function.
 */

/**
 * Draw text with font.
 * Draw a text value on the screen at the specified x and y location using
 * a custom RIC font. The y value must be a multiple of 8.  Valid line number
 * constants are listed in the \ref LineConstants group.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 *
 * \param x The x value for the start of the text output.
 * \param y The text line number for the text output.
 * \param filename The filename of the RIC font.
 * \param str The text to output to the LCD screen.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char FontTextOut(int x, int y, string filename, string str, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispftout.nxc
 * How to use the \ref FontTextOut function.
 */

/**
 * Draw a number with font.
 * Draw a numeric value on the screen at the specified x and y location using
 * a custom RIC font. The y value must be a multiple of 8.  Valid line number
 * constants are listed in the \ref LineConstants group.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 *
 * \param x The x value for the start of the text output.
 * \param y The text line number for the text output.
 * \param filename The filename of the RIC font.
 * \param value The value to output to the LCD screen. Any numeric type is supported.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char FontNumOut(int x, int y, string filename, variant number, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispfnout.nxc
 * How to use the \ref FontNumOut function.
 */

/**
 * Draw a graphic image.
 * Draw a graphic image file on the screen at the specified x and y location.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param filename The filename of the RIC graphic image.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicOut(int x, int y, string filename, unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispgout.nxc
 * How to use the \ref GraphicOut function.
 */

/**
 * Draw a graphic image from byte array.
 * Draw a graphic image byte array on the screen at the specified x and y location.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param data The byte array of the RIC graphic image.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicArrayOut(int x, int y, byte data[], unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispgaout.nxc
 * How to use the \ref GraphicArrayOut function.
 */

/**
 * Draw a graphic image with parameters.
 * Draw a graphic image file on the screen at the specified x and y location using
 * an array of parameters.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param filename The filename of the RIC graphic image.
 * \param vars The byte array of parameters.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicOutEx(int x, int y, string filename, byte vars[], unsigned long options=DRAW_OPT_NORMAL);
/** \example ex_dispgoutex.nxc
 * How to use the \ref GraphicOutEx function.
 */

/**
 * Draw a graphic image from byte array with parameters.
 * Draw a graphic image byte array on the screen at the specified x and y location
 * using an array of parameters.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
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
 * How to use the \ref GraphicArrayOutEx function.
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
/** \example ex_getsetdisp.nxc
 * How to read and write pixel data using the \ref GetDisplayNormal, \ref GetDisplayPopup,
 * \ref SetDisplayNormal,  and \ref SetDisplayPopup functions.
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

/**
 * Read the display erase mask value.
 * This function lets you read the current display erase mask value.
 * \return The current display erase mask value.
 */
inline unsigned long DisplayEraseMask();
/** \example ex_dispmisc.nxc
 * How to use the \ref DisplayEraseMask, \ref DisplayUpdateMask, \ref DisplayDisplay,
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

/**
 * Read the display memory address.
 * This function lets you read the current display memory address.
 * \return The current display memory address.
 */
inline unsigned long DisplayDisplay();

/**
 * Read the display flags.
 * This function lets you read the current display flags.
 * Valid flag values are listed in the \ref DisplayFlagsGroup group.
 * \return The current display flags.
 */
inline byte DisplayFlags();

/**
 * Read the display text lines center flags.
 * This function lets you read the current display text lines center flags.
 * \return The current display text lines center flags.
 */
inline byte DisplayTextLinesCenterFlags();

/**
 * Draw text.
 * This function lets you draw text on the NXT LCD given the parameters you
 * pass in via the \ref DrawTextType structure.
 *
 * \param args The DrawTextType structure containing the drawing parameters.
 */
inline void SysDrawText(DrawTextType & args);
/** \example ex_sysdrawtext.nxc
 * This is an example of how to use the SysDrawText function along with the
 * DrawTextType structure.
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
 * This is an example of how to use the SysDrawPoint function along with the
 * DrawPointType structure.
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
 * This is an example of how to use the SysDrawLine function along with the
 * DrawLineType structure.
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
 * How to use the \ref SysDrawCircle function along with the \ref DrawCircleType structure.
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
 * This is an example of how to use the SysDrawRect function along with the
 * DrawRectType structure.
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


#if __FIRMWARE_VERSION > 107

/**
 * Read the display contrast setting.
 * This function lets you read the current display contrast setting.
 * \return The current display contrast (byte).
 */
inline byte DisplayContrast();
/** \example ex_contrast.nxc
 * How to use the \ref DisplayContrast and \ref SetDisplayContrast functions.
 */

/**
 * Draw a graphic image from a byte array.
 * This function lets you draw a graphic image on the NXT LCD given the parameters you pass
 * in via the \ref DrawGraphicArrayType structure.
 *
 * \param args The DrawGraphicArrayType structure containing the drawing parameters.
 */
inline void SysDrawGraphicArray(DrawGraphicArrayType & args);
/** \example ex_drawgarray.nxc
 * How to use the \ref SysDrawGraphicArray function along with the \ref DrawGraphicArrayType structure.
 */

/**
 * Draw a polygon.
 * This function lets you draw a polygon on the NXT LCD given the parameters you pass
 * in via the \ref DrawPolygonType structure.
 *
 * \param args The DrawPolygonType structure containing the drawing parameters.
 */
inline void SysDrawPolygon(DrawPolygonType & args);
/** \example ex_drawpoly.nxc
 * How to use the \ref SysDrawPolygon function along with the \ref DrawPolygonType structure.
 */

/**
 * Draw an ellipse.
 * This function lets you draw an ellipse on the NXT LCD given the parameters you pass
 * in via the \ref DrawEllipseType structure.
 *
 * \param args The DrawEllipseType structure containing the drawing parameters.
 */
inline void SysDrawEllipse(DrawEllipseType & args);
/** \example ex_drawellipse.nxc
 * How to use the \ref SysDrawEllipse function along with the \ref DrawEllipseType structure.
 */

/**
 * Draw text using a custom font.
 * This function lets you draw text on the NXT LCD using a custom font with parameters you pass
 * in via the \ref DrawFontType structure.
 *
 * \param args The DrawFontType structure containing the drawing parameters.
 */
inline void SysDrawFont(DrawFontType & args);
/** \example ex_drawfont.nxc
 * How to use the \ref SysDrawFont function along with the \ref DrawFontType structure.
 */
#endif
#endif

#else

#define GetDisplayNormal(_x, _line, _cnt, _data) asm { __getDisplayNormal(_x, _line, _cnt, _data) }
#define GetDisplayPopup(_x, _line, _cnt, _data) asm { __getDisplayPopup(_x, _line, _cnt, _data) }

#define DisplayEraseMask() asm { GetDisplayEraseMask(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayUpdateMask() asm { GetDisplayUpdateMask(__TMPLONG__) __RETURN__ __TMPLONG__ }
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
/** \example ex_dispcls.nxc
 * How to use the \ref ClearScreen function.
 */

/**
 * Set the display memory address.
 * This function lets you set the current display memory address.
 * \param addr The new display memory address.
 */
inline void SetDisplayDisplay(unsigned long addr) { asm { __setDisplayDisplay(addr) } }

/**
 * Set the display erase mask.
 * This function lets you set the current display erase mask.
 * \param eraseMask The new display erase mask.
 */
inline void SetDisplayEraseMask(unsigned long eraseMask) { asm { __setDisplayEraseMask(eraseMask) } }

/**
 * Set the display flags.
 * This function lets you set the current display flags.
 * Valid flag values are listed in the \ref DisplayFlagsGroup group.
 * \param flags The new display flags.
 */
inline void SetDisplayFlags(byte flags) { asm { __setDisplayFlags(flags) } }

/**
 * Set the display text lines center flags.
 * This function lets you set the current display text lines center flags.
 * \param ctrFlags The new display text lines center flags.
 */
inline void SetDisplayTextLinesCenterFlags(byte ctrFlags) { asm { __setDisplayTextLinesCenterFlags(ctrFlags) } }

/**
 * Set the display update mask.
 * This function lets you set the current display update mask.
 * \param updateMask The new display update mask.
 */
inline void SetDisplayUpdateMask(unsigned long updateMask) { asm { __setDisplayUpdateMask(updateMask) } }

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)
/**
 * Set the display contrast.
 * This function lets you set the display contrast setting.
 * \param contrast The desired display contrast.
 */
inline void SetDisplayContrast(byte contrast) { asm { __setDisplayContrast(contrast) } }
#endif

/** @} */ // end of DisplayModuleFunctions group
/** @} */ // end of DisplayModule group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// SOUND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup SoundModule
 * @{
 */
/** @defgroup SoundModuleTypes Sound module types
 * Types used by various sound module functions.
 * @{
 */
/**
 * SoundPlayFileType structure.
 * This structure is used when calling the \ref SysSoundPlayFile system call
 * function.
 * \sa SysSoundPlayFile()
 */
struct SoundPlayFileType {
  char Result;       /*!< The function call result. \todo ?. */
  string Filename;   /*!< The name of the file to play. */
  bool Loop;         /*!< If true, loops at end of file. */
  byte SoundLevel;   /*!< The sound level. Valid values range from 0 to 4. */
};

/**
 * SoundPlayToneType structure.
 * This structure is used when calling the \ref SysSoundPlayTone system call
 * function.
 * \sa SysSoundPlayTone()
 */
struct SoundPlayToneType {
  char Result;              /*!< The function call result. \todo ?. */
  unsigned int Frequency;   /*!< The tone frequency. See the \ref ToneConstants group. */
  unsigned int Duration;    /*!< The tone duration in milliseconds. See the \ref TimeConstants group. */
  bool Loop;                /*!< If true, loops forever. */
  byte SoundLevel;          /*!< The sound level. Valid values range from 0 to 4. */
};

/**
 * SoundGetStateType structure.
 * This structure is used when calling the \ref SysSoundGetState system call
 * function.
 * \sa SysSoundGetState()
 */
struct SoundGetStateType {
  byte State;   /*!< The returned sound state. See the \ref SoundStateConstants group. */
  byte Flags;   /*!< The returned sound flags. See the \ref SoundFlagsConstants group. */
};

/**
 * SoundSetStateType structure.
 * This structure is used when calling the \ref SysSoundSetState system call
 * function.
 * \sa SysSoundSetState()
 */
struct SoundSetStateType {
  byte Result;   /*!< The function call result. \todo ?. */
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

/**
 * Get sound module state.
 * Return the current sound module state. See the \ref SoundStateConstants group.
 *
 * \sa SetSoundModuleState(), SysSoundSetState(), SysSoundGetState()
 * \return The current sound module state.
 */
inline byte SoundState();

/**
 * Get sound module flags.
 * Return the current sound module flags. See the \ref SoundFlagsConstants group.
 *
 * \sa SetSoundFlags(), SysSoundSetState(), SysSoundGetState()
 * \return The current sound module flags.
 */
inline byte SoundFlags();

/**
 * Stop sound.
 * Stop playing of the current tone or file.
 *
 * \return The result \todo ?.
 */
inline byte StopSound();

/**
 * Get frequency.
 * Return the current sound frequency.
 *
 * \sa SetSoundFrequency()
 * \return The current sound frequency.
 */
inline unsigned int SoundFrequency();

/**
 * Get duration.
 * Return the current sound duration.
 *
 * \sa SetSoundDuration()
 * \return The current sound duration.
 */
inline unsigned int SoundDuration();

/**
 * Get sample rate.
 * Return the current sound sample rate.
 *
 * \sa SetSoundSampleRate()
 * \return The current sound sample rate.
 */
inline unsigned int SoundSampleRate();

/**
 * Get sound mode.
 * Return the current sound mode.  See the \ref SoundModeConstants group.
 *
 * \sa SetSoundMode()
 * \return The current sound mode.
 */
inline byte SoundMode();

/**
 * Get volume.
 * Return the current sound volume.
 *
 * \sa SetSoundVolume()
 * \return The current sound volume.
 */
inline byte SoundVolume();

/**
 * Set duration.
 * Set the sound duration.
 *
 * \sa SoundDuration()
 * \param duration The new sound duration
 */
inline void SetSoundDuration(unsigned int duration);

/**
 * Set sound module flags.
 * Set the sound module flags. See the \ref SoundFlagsConstants group.
 *
 * \sa SetSoundFlags(), SysSoundSetState(), SysSoundGetState()
 * \param flags The new sound module flags
 */
inline void SetSoundFlags(byte flags);

/**
 * Set frequency.
 * Set the sound frequency.
 *
 * \sa SoundFrequency()
 * \param frequency The new frequency
 */
inline void SetSoundFrequency(unsigned int frequency);

/**
 * Set sound mode.
 * Set the sound mode.  See the \ref SoundModeConstants group.
 *
 * \sa SoundMode()
 * \param mode The new sound mode
 */
inline void SetSoundMode(byte mode);

/**
 * Set sound module state.
 * Set the sound module state. See the \ref SoundStateConstants group.
 *
 * \sa SoundState(), SysSoundSetState(), SysSoundGetState()
 * \param state The new sound state
 */
inline void SetSoundModuleState(byte state);

/**
 * Set sample rate.
 * Set the sound sample rate.
 *
 * \sa SoundSampleRate()
 * \param sampleRate The new sample rate
 */
inline void SetSoundSampleRate(unsigned int sampleRate);

/**
 * Set volume.
 * Set the sound volume.
 *
 * \sa SoundVolume()
 * \param volume The new volume
 */
inline void SetSoundVolume(byte volume);

/** \example ex_soundmisc.nxc
 * This is an example of how to use the PlayFile, PlayFileEx, PlayTone,
 * PlayToneEx, SoundState, SoundFlags, StopSound, SoundFrequency,
 * SoundDuration, SoundSampleRate, SoundMode, SoundVolume, SetSoundDuration,
 * SetSoundFlags, SetSoundFrequency, SetSoundMode, SetSoundModuleState,
 * SetSoundSampleRate, and SetSoundVolume.
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
 * This is an example of how to use the SysSoundPlayFile function along with
 * the SoundPlayFileType structure.
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
 * This is an example of how to use the SysSoundPlayTone function along with
 * the SoundPlayToneType structure.
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

/** @} */ // end of SoundModuleFunctions group
/** @} */ // end of SoundModule group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// LOWSPEED MODULE ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup LowSpeedModule
 * @{
 */
/** @defgroup LowSpeedModuleTypes LowSpeed module types
 * Types used by various low speed module functions.
 * @{
 */
/**
 * CommLSWriteType structure.
 * This structure is used when calling the \ref SysCommLSWrite system call
 * function.
 * \sa SysCommLSWrite()
 */
struct CommLSWriteType {
  char Result;      /*!< The function call result. \todo ?. */
  byte Port;        /*!< The port to which the I2C device is connected. */
  byte Buffer[];    /*!< The buffer written to the I2C device. */
  byte ReturnLen;   /*!< The number of bytes that you want to read from the I2C device. */
};

/**
 * CommLSReadType structure.
 * This structure is used when calling the \ref SysCommLSRead system call
 * function.
 * \sa SysCommLSRead()
 */
struct CommLSReadType {
  char Result;      /*!< The function call result. \todo ?. */
  byte Port;        /*!< The port to which the I2C device is connected. */
  byte Buffer[];    /*!< The buffer used to store the bytes read from the I2C device. */
  byte BufferLen;   /*!< The size of the output buffer on input.  This field is not updated during the function call. */
};

/**
 * CommLSCheckStatusType structure.
 * This structure is used when calling the \ref SysCommLSCheckStatus system
 * call function.
 * \sa SysCommLSCheckStatus()
 */
struct CommLSCheckStatusType {
  char Result;       /*!< Returns the I2C status of the specified port. */
  byte Port;         /*!< The port to which the I2C device is connected. */
  byte BytesReady;   /*!< The number of bytes ready to read from the specified port. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * CommLSWriteExType structure.
 * This structure is used when calling the \ref SysCommLSWriteEx system call
 * function.
 * \sa SysCommLSWriteEx()
 */
struct CommLSWriteExType {
  char Result;          /*!< The function call result. \todo ?. */
  byte Port;            /*!< The port to which the I2C device is connected. */
  byte Buffer[];        /*!< The buffer written to the I2C device. */
  byte ReturnLen;       /*!< The number of bytes that you want to read from the I2C device. */
  byte NoRestartOnRead; /*!< Should a restart occur before reading from the device? */
};
#endif

/** @} */ // end of LowSpeedModuleTypes group
/** @defgroup LowSpeedModuleFunctions LowSpeed module functions
 * Functions for accessing and modifying low speed module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

inline byte SensorUS(const byte port);
inline char ReadSensorUSEx(const byte port, byte & values[]);

inline char ReadI2CRegister(byte port, byte reg, byte & out);
inline char WriteI2CRegister(byte port, byte reg, byte val);

inline long LowspeedStatus(const byte port, byte & bready);
inline long LowspeedCheckStatus(const byte port);
inline byte LowspeedBytesReady(const byte port);
inline long LowspeedWrite(const byte port, byte retlen, byte buffer[]);
inline long LowspeedRead(const byte port, byte buflen, byte & buffer[]);

inline long I2CStatus(const byte port, byte & bready);
inline long I2CCheckStatus(const byte port);
inline byte I2CBytesReady(const byte port);
inline long I2CWrite(const byte port, byte retlen, byte buffer[])
inline long I2CRead(const byte port, byte buflen, byte & buffer[])

inline long I2CBytes(const byte port, byte inbuf[], byte & count, byte & outbuf[]);

inline string I2CDeviceInfo(byte port, byte info);
inline string I2CDeviceInfoEx(byte port, byte addr, byte info);
inline string I2CVersion(byte port);
inline string I2CVersionEx(byte port, byte addr);
inline string I2CVendorId(byte port);
inline string I2CVendorIdEx(byte port, byte addr);
inline string I2CDeviceId(byte port);
inline string I2CDeviceIdEx(byte port, byte addr);

inline long I2CSendCommand(byte port, byte cmd);
inline long I2CSendCommandEx(byte port, byte addr, byte cmd);

inline void GetLSInputBuffer(const byte port, const byte offset, byte cnt, byte & data[]);
inline void GetLSOutputBuffer(const byte port, const byte offset, byte cnt, byte & data[]);

inline byte LSInputBufferInPtr(const byte port);
inline byte LSInputBufferOutPtr(const byte port);
inline byte LSInputBufferBytesToRx(const byte port);
inline byte LSOutputBufferInPtr(const byte port);
inline byte LSOutputBufferOutPtr(const byte port);
inline byte LSOutputBufferBytesToRx(const byte port);
inline byte LSMode(const byte port);
inline byte LSChannelState(const byte port);
inline byte LSErrorType(const byte port);
inline byte LSState();
inline byte LSSpeed();
#ifdef __ENHANCED_FIRMWARE
inline byte LSNoRestartOnRead();
#endif

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

/**
 * Write to a Lowspeed sensor.
 * This function lets you write to an I2C (Lowspeed) sensor using the values
 * specified via the \ref CommLSWriteType structure.
 *
 * \param args The CommLSWriteType structure containing the needed parameters.
 */
inline void SysCommLSWrite(CommLSWriteType & args);
/** \example ex_syscommlswrite.nxc
 * This is an example of how to use the SysCommLSWrite function along with the
 * CommLSWriteType structure.
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
 * This is an example of how to use the SysCommLSRead function along with the
 * CommLSReadType structure.
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
 * This is an example of how to use the SysCommLSCheckStatus function along
 * with the CommLSCheckStatusType structure.
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
 * This is an example of how to use the SysCommLSWriteEx function along with the
 * CommLSWriteExType structure.
 */
#endif

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


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// IOCTRL MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


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
#ifdef __DOXYGEN_DOCS

/**
 * Power down the NXT.
 * This function powers down the NXT.
 * The running program will terminate as a result of this action.
 */
inline void PowerDown();

/**
 * Put the brick to sleep immediately.
 * This function lets you immediately put the NXT to sleep.
 * The running program will terminate as a result of this action.
 */
inline void SleepNow();

/**
 * Reboot the NXT in firmware download mode.
 * This function lets you reboot the NXT into SAMBA or firmware download mode.
 * The running program will terminate as a result of this action.
 */
inline void RebootInFirmwareMode();

#else
#define PowerDown() asm { SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_POWERDOWN) }
#define SleepNow() PowerDown()
#define RebootInFirmwareMode() asm { SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_BOOT) }
#endif
/** @} */ // end of IOCtrlModuleFunctions group
/** @} */ // end of IOCtrlModule group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// COMMAND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup CommandModule
 * @{
 */
/** @defgroup CommandModuleTypes Command module types
 * Types used by various Command module functions.
 * @{
 */

/**
 * GetStartTickType structure.
 * This structure is used when calling the \ref SysGetStartTick system call
 * function.
 * \sa SysGetStartTick()
 */
struct GetStartTickType {
  unsigned long Result;   /*!< The returned tick value. */
};

/**
 * KeepAliveType structure.
 * This structure is used when calling the \ref SysKeepAlive system call
 * function.
 * \sa SysKeepAlive()
 */
struct KeepAliveType {
  unsigned long Result;   /*!< The function call result. \todo ?. */
};

/**
 * IOMapReadType structure.
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
 * IOMapWriteType structure.
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
 * IOMapReadByIDType structure.
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
 * IOMapWriteByIDType structure.
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
 * DatalogWriteType structure.
 * This structure is used when calling the \ref SysDatalogWrite system call
 * function.
 * \sa SysDatalogWrite()
 */
struct DatalogWriteType {
 char Result;     /*!< The function call result. \ref NO_ERR means it succeeded. */
 byte Message[];  /*!< A buffer containing data to write to the datalog. */
};

/**
 * DatalogGetTimesType structure.
 * This structure is used when calling the \ref SysDatalogGetTimes system call
 * function.
 * \sa SysDatalogGetTimes()
 */
struct DatalogGetTimesType {
 unsigned long SyncTime;  /*!< The datalog synchronized time. \todo what is this. */
 unsigned long SyncTick;  /*!< The datalog synchronized tick. \todo what is this. */
};

/**
 * ReadSemDataType structure.
 * This structure is used when calling the \ref SysReadSemData system call
 * function.
 * \sa SysReadSemData()
 */
struct ReadSemDataType {
  byte SemData;  /*!< The semaphore data returned by the function call. */
  bool Request;  /*!< Which semaphore am I reading from, usage or request? */
};

/**
 * WriteSemDataType structure.
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
 * UpdateCalibCacheInfoType structure.
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
 * ComputeCalibValueType structure.
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
 * This function lets you obtain the tick value at the time your program began
 * executing via the \ref GetStartTickType structure.
 *
 * \return The current system tick count.
 */
inline unsigned long CurrentTick();
/** \example ex_cmdmmisc.nxc
 * This is an example of how to use the CurrentTick, FirstTick, and
 * ResetSleepTimer functions.
 */

/**
 * Get the first tick.
 * This function lets you obtain the tick value at the time your program began.
 *
 * \return The tick count at the start of program execution.
 */
inline unsigned long FirstTick();

/**
 * Reset the sleep timer.
 * This function lets you reset the sleep timer.
 *
 * \return The result of resetting the sleep timer.
 */
inline long ResetSleepTimer();

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
 * This is an example of how to use the SysCall function.
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
 * This is an example of how to use the SysGetStartTick function along with
 * the GetStartTickType structure.
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
 * This is an example of how to use the SysKeepAlive function along with the
 * KeepAliveType structure.
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
 * This is an example of how to use the SysIOMapRead function along with the
 * IOMapReadType structure.
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
 * This is an example of how to use the SysIOMapWrite function along with the
 * IOMapWriteType structure.
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
 * This is an example of how to use the SysIOMapReadByID function along with
 * the IOMapReadByIDType structure.
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
 * This is an example of how to use the SysIOMapWriteByID function along with
 * the IOMapWriteByIDType structure.
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
 */
inline void SysDatalogWrite(DatalogWriteType & args);
/** \example ex_datalog.nxc
 * This is an example of how to use the SysDatalogWrite and SysDatalogGetTimes
 * functions along with the DatalogWriteType and DatalogGetTimesType structures.
 */

/**
 * Get datalog times.
 * This function lets you get datalog times using the
 * values specified via the \ref DatalogGetTimesType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The DatalogGetTimesType structure containing the needed parameters.
 */
inline void SysDatalogGetTimes(DatalogGetTimesType & args);

/**
 * Read semaphore data.
 * This function lets you read global motor semaphore data using the
 * values specified via the \ref ReadSemDataType structure.
 *
 * \param args The ReadSemDataType structure containing the needed parameters.
 */
inline void SysReadSemData(ReadSemDataType & args);
/** \example ex_SemData.nxc
 * This is an example of how to use the SysWriteSemData and SysReadSemData
 * functions along with the WriteSemDataType and ReadSemDataType structures.
 */

/**
 * Write semaphore data.
 * This function lets you write global motor semaphore data using the
 * values specified via the \ref WriteSemDataType structure.
 *
 * \param args The WriteSemDataType structure containing the needed parameters.
 */
inline void SysWriteSemData(WriteSemDataType & args);

/**
 * Update calibration cache information.
 * This function lets you update calibration cache information using the
 * values specified via the \ref UpdateCalibCacheInfoType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The UpdateCalibCacheInfoType structure containing the needed parameters.
 */
inline void SysUpdateCalibCacheInfo(UpdateCalibCacheInfoType & args);
/** \example ex_SysCalib.nxc
 * This is an example of how to use the SysUpdateCalibCacheInfo and
 * SysComputeCalibValue functions along with the UpdateCalibCacheInfoType and
 * ComputeCalibValueType structures.
 */

/**
 * Compute calibration values.
 * This function lets you compute calibration values using the
 * values specified via the \ref ComputeCalibValueType structure.
 *
 * \todo figure out what this function is intended for
 * \param args The ComputeCalibValueType structure containing the needed parameters.
 */
inline void SysComputeCalibValue(ComputeCalibValueType & args);

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

#endif

#define until(_c) while(!(_c))

/**
 * Wait some milliseconds.
 * Make a task sleep for specified amount of time (in 1000ths of a second).
 *
 * \param ms The number of milliseconds to sleep.
 */
inline void Wait(unsigned long ms) { asm { waitv ms } }
/** \example ex_wait.nxc
 * How to use the \ref Wait function.
 */

/**
 * Yield to another task.
 * Make a task yield to another concurrently running task.
 */
inline void Yield() { asm { wait 1 } }
/** \example ex_yield.nxc
 * How to use the \ref Yield function.
 */

#ifdef __DOXYGEN_DOCS
// Stop(stop?);
// ExitTo(task);
// Precedes(x, y, z, ...);
// Follows(x, y, z);
// Acquire(mutex);
// Release(mutex);
inline void StopAllTasks();

#define StartTask(_t) start _t
#define StopTask(_t) stop _t

#define IOMA(_n) asm { mov __RETVAL__, _n }
#define SetIOMA(_n, _val) asm { mov _n, _val }

#define ArrayBuild(_aout, ...) asm { arrbuild _aout, __VA_ARGS__ }
#define ArrayLen(_asrc) asm { arrsize __RETVAL__, _asrc }
#define ArrayInit(_aout, _val, _cnt) asm { arrinit _aout, _val, _cnt }
#define ArraySubset(_aout, _asrc, _idx, _len) asm { arrsubset _aout, _asrc, _idx, _len }

#else

#define StopAllTasks() Stop(true)
#define StartTask(_t) start _t
#define StopTask(_t) stop _t

#define IOMA(_n) asm { mov __RETVAL__, _n }
#define SetIOMA(_n, _val) asm { mov _n, _val }

#define ArrayBuild(_aout, ...) asm { arrbuild _aout, __VA_ARGS__ }
#define ArrayLen(_asrc) asm { arrsize __RETVAL__, _asrc }
#define ArrayInit(_aout, _val, _cnt) asm { arrinit _aout, _val, _cnt }
#define ArraySubset(_aout, _asrc, _idx, _len) asm { arrsubset _aout, _asrc, _idx, _len }

#endif
/** @} */ // end of CommandModuleFunctions group
/** @} */ // end of CommandModule group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// COMM MODULE /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup CommModule
 * @{
 */
/** @defgroup CommModuleTypes Comm module types
 * Types used by various Comm module functions.
 * @{
 */
/**
 * MessageWriteType structure.
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
 * MessageReadType structure.
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
 * CommBTCheckStatusType structure.
 * This structure is used when calling the \ref SysCommBTCheckStatus system
 * call function.
 * \sa SysCommBTCheckStatus()
 */
struct CommBTCheckStatusType {
  char Result;       /*!< The function call result. Possible values include
                       ERR_INVALID_PORT, STAT_COMM_PENDING,
                       ERR_COMM_CHAN_NOT_READY, and LDR_SUCCESS (0). */
  byte Connection;   /*!< The connection to check. */
};

/**
 * CommBTWriteType structure.
 * This structure is used when calling the \ref SysCommBTWrite system call
 * function.
 * \sa SysCommBTWrite()
 */
struct CommBTWriteType {
  char Result;       /*!< The function call result. \todo ?. */
  byte Connection;   /*!< The connection to use. */
  byte Buffer[];     /*!< The data to write to the connection. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * CommExecuteFunctionType structure.
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
  unsigned int Result;   /*!< The function call result. \todo ?. */
  byte Cmd;              /*!< The command to execute. */
  byte Param1;           /*!< The first parameter, see table. */
  byte Param2;           /*!< The second parameter, see table. */
  byte Param3;           /*!< The third parameter, see table. */
  string Name;           /*!< The name parameter, see table. */
  unsigned int RetVal;   /*!< \todo ?. */
};

// CommHSControl
struct CommHSControlType {
 char Result;
 byte Command;
 byte BaudRate;
#if __FIRMWARE_VERSION > 107
 unsigned int Mode;
#endif
};

// CommHSCheckStatus
struct CommHSCheckStatusType {
 bool SendingData;
 bool DataAvailable;
};

// CommHSRead, CommHSWrite
struct CommHSReadWriteType {
 char Status;
 byte Buffer[];
};
#endif

#if __FIRMWARE_VERSION > 107
// CommBTOnOff
struct CommBTOnOffType {
#ifdef __ENHANCED_FIRMWARE
 unsigned int Result;
#else
 char Result;
#endif
 bool PowerState;
};

// CommBTConnection
struct CommBTConnectionType {
#ifdef __ENHANCED_FIRMWARE
 unsigned int Result;
#else
 char Result;
#endif
 byte Action;
 string Name;
 byte ConnectionSlot;
};
#endif

/** @} */ // end of CommModuleTypes group
/** @defgroup CommModuleFunctions Comm module functions
 * Functions for accessing and modifying Comm module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

inline char SendMessage(byte queue, string msg);
inline char ReceiveMessage(byte queue, bool clear, string & msg);

inline char BluetoothStatus(const byte conn);
inline char BluetoothWrite(const byte conn, byte buffer[]);

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

inline void GetBTInputBuffer(const byte offset, byte cnt, byte & data[]);
inline void GetBTOutputBuffer(const byte offset, byte cnt, byte & data[]);
inline void GetHSInputBuffer(const byte offset, byte cnt, byte & data[]);
inline void GetHSOutputBuffer(const byte offset, byte cnt, byte & data[]);
inline void GetUSBInputBuffer(const byte offset, byte cnt, byte & data[]);
inline void GetUSBOutputBuffer(const byte offset, byte cnt, byte & data[]);
inline void GetUSBPollBuffer(const byte offset, byte cnt, byte & data[]);

inline string BTDeviceName(const byte devidx);
inline string BTConnectionName(const byte conn);
inline string BTConnectionPinCode(const byte conn);
inline string BrickDataName();

inline void GetBTDeviceAddress(const byte devidx, byte & data[]);
inline void GetBTConnectionAddress(const byte conn, byte & data[]);
inline void GetBrickDataAddress(byte & data[]);

inline long BTDeviceClass(const byte devidx);
inline byte BTDeviceStatus(const byte devidx);
inline long BTConnectionClass(const byte conn);
inline byte BTConnectionHandleNum(const byte conn);
inline byte BTConnectionStreamStatus(const byte conn);
inline byte BTConnectionLinkQuality(const byte conn);
inline int BrickDataBluecoreVersion();
inline byte BrickDataBtStateStatus();
inline byte BrickDataBtHardwareStatus();
inline byte BrickDataTimeoutValue();
inline byte BTInputBufferInPtr();
inline byte BTInputBufferOutPtr();
inline byte BTOutputBufferInPtr();
inline byte BTOutputBufferOutPtr();

inline byte HSInputBufferInPtr();
inline byte HSInputBufferOutPtr();
inline byte HSOutputBufferInPtr();
inline byte HSOutputBufferOutPtr();

inline byte USBInputBufferInPtr();
inline byte USBInputBufferOutPtr();
inline byte USBOutputBufferInPtr();
inline byte USBOutputBufferOutPtr();
inline byte USBPollBufferInPtr();
inline byte USBPollBufferOutPtr();

inline byte BTDeviceCount();
inline byte BTDeviceNameCount();

inline byte HSFlags();
inline byte HSSpeed();
inline byte HSState();
inline int HSMode();
inline byte USBState();

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

inline void SetBTInputBuffer(const byte offset, byte cnt, byte data[]);
inline void SetBTInputBufferInPtr(byte n);
inline void SetBTInputBufferOutPtr(byte n);

inline void SetBTOutputBuffer(const byte offset, cnt, byte data[]);
inline void SetBTOutputBufferInPtr(byte n);
inline void SetBTOutputBufferOutPtr(byte n);

inline void SetHSInputBuffer(const byte offset, byte cnt, byte data[]);
inline void SetHSInputBufferInPtr(byte n);
inline void SetHSInputBufferOutPtr(byte n);

inline void SetHSOutputBuffer(const byte offset, byte cnt, byte data[]);
inline void SetHSOutputBufferInPtr(byte n);
inline void SetHSOutputBufferOutPtr(byte n);

inline void SetUSBInputBuffer(const byte offset, byte cnt, byte data[]);
inline void SetUSBInputBufferInPtr(byte n);
inline void SetUSBInputBufferOutPtr(byte n);

inline void SetUSBOutputBuffer(const byte offset, byte cnt, byte data[]);
inline void SetUSBOutputBufferInPtr(byte n);
inline void SetUSBOutputBufferOutPtr(byte n);

inline void SetUSBPollBuffer(const byte offset, byte cnt, byte data[]);
inline void SetUSBPollBufferInPtr(byte n);
inline void SetUSBPollBufferOutPtr(byte n);

inline void SetBTDeviceCount(byte count);
inline void SetBTDeviceNameCount(byte count);

inline void SetHSFlags(const byte hsFlags);
inline void SetHSSpeed(const byte hsSpeed);
inline void SetHSState(const byte hsState);
inline void SetHSMode(const unsigned int hsMode);

inline void SetUSBState(byte usbState);

/**
 * Write message.
 * This function lets you write a message to a queue (aka mailbox) using the
 * values specified via the \ref MessageWriteType structure.
 *
 * \param args The MessageWriteType structure containing the needed parameters.
 */
void SysMessageWrite(MessageWriteType & args);
/** \example ex_sysmessagewrite.nxc
 * This is an example of how to use the SysMessageWrite function along with
 * the MessageWriteType structure.
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
 * This is an example of how to use the SysMessageRead function along with the
 * MessageReadType structure.
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
 * This is an example of how to use the SysCommBTWrite function along with the
 * CommBTWriteType structure.
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
 * This is an example of how to use the SysCommBTCheckStatus function along
 * with the CommBTCheckStatusType structure.
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
 * This is an example of how to use the SysCommExecuteFunction function along
 * with the CommExecuteFunctionType structure.
 */

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
#define SetBTDeviceCount(_n) asm { __setBTDeviceCount(_n) }
#define SetBTDeviceNameCount(_n) asm { __setBTDeviceNameCount(_n) }
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


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// BUTTON MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup ButtonModule
 * @{
 */
/** @defgroup ButtonModuleTypes Button module types
 * Types used by various Button module functions.
 * @{
 */
/**
 * ReadButtonType structure.
 * This structure is used when calling the \ref SysReadButton system call
 * function.
 * \sa SysReadButton()
 */
struct ReadButtonType {
  char Result;   /*!< The function call result. \todo ?. */
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

inline bool ButtonPressed(const byte btn, bool resetCount);
inline byte ButtonCount(const byte btn, bool resetCount);
inline char ReadButtonEx(const byte btn, bool reset, bool & pressed, unsigned int count);
inline byte ButtonPressCount(const byte btn);
inline byte ButtonLongPressCount(const byte btn);
inline byte ButtonShortReleaseCount(const byte btn);
inline byte ButtonLongReleaseCount(const byte btn);
inline byte ButtonReleaseCount(const byte btn);
inline byte ButtonState(const byte btn);

inline void SetButtonLongPressCount(const byte btn, const byte n);
inline void SetButtonLongReleaseCount(const byte btn, const byte n);
inline void SetButtonPressCount(const byte btn, const byte n);
inline void SetButtonReleaseCount(const byte btn, const byte n);
inline void SetButtonShortReleaseCount(const byte btn, const byte n);
inline void SetButtonState(const byte btn, const byte state);

/** \example ex_buttonmisc.nxc
 * This is an example of how to use the ButtonPressed, ButtonCount,
 * ReadButtonEx, ButtonPressCount, ButtonLongPressCount, ButtonShortReleaseCount,
 * ButtonLongReleaseCount, ButtonReleaseCount, ButtonState,
 * SetButtonLongPressCount, SetButtonLongReleaseCount, SetButtonPressCount,
 * SetButtonReleaseCount, SetButtonShortReleaseCount, and SetButtonState.
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
 * This is an example of how to use the SysReadButton function along with the
 * ReadButtonType structure.
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


///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// UI MODULE //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup UiModule
 * @{
 */
/** @defgroup UiModuleTypes Ui module types
 * Types used by various Ui module functions.
 * @{
 */

#if __FIRMWARE_VERSION > 107
// SetSleepTimeout
struct SetSleepTimeoutType {
 char Result;
 unsigned long TheSleepTimeoutMS;
};
#endif

/** @} */ // end of UiModuleTypes group
/** @defgroup UiModuleFunctions Ui module functions
 * Functions for accessing and modifying Ui module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

inline byte UIState();
inline byte UIButton();
inline byte VMRunState();
inline byte BatteryState();
inline byte BluetoothState();
inline byte UsbState();
inline byte SleepTimeout();
inline byte SleepTime(); // SleepTimeout()
inline byte SleepTimer();
inline byte RechargeableBattery();
inline byte Volume();
inline byte OnBrickProgramPointer();
inline byte AbortFlag();
inline byte LongAbort(); // AbortFlag()
inline unsigned int BatteryLevel();

inline void SetCommandFlags(const byte cmdFlags);
inline void SetUIButton(byte btn);
inline void SetUIState(byte state);
inline void SetVMRunState(const byte vmRunState);
inline void SetBatteryState(byte state);
inline void SetBluetoothState(byte state);
inline void SetUsbState(byte usbState);
inline void SetSleepTimeout(const byte n);
inline void SetSleepTime(const byte n); // SetSleepTimeout(n)
inline void SetSleepTimer(const byte n);
inline void SetVolume(byte volume);
inline void SetOnBrickProgramPointer(byte obpStep);
inline void ForceOff(byte num);
inline void SetAbortFlag(byte abortFlag);
inline void SetLongAbort(bool longAbort);

#if __FIRMWARE_VERSION > 107
inline void SysSetSleepTimeout(SetSleepTimeoutType & args);
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


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// LOADER MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup LoaderModule
 * @{
 */
/** @defgroup LoaderModuleTypes Loader module types
 * Types used by various Loader module functions.
 * @{
 */
// FileOpenRead, FileOpenWrite, FileOpenAppend, FileOpenReadLinear, FileOpenWriteLinear, FileOpenWriteNonLinear
struct FileOpenType {
  unsigned int Result;
  byte FileHandle;
  string Filename;
  unsigned long Length;
};

// FileRead, FileWrite
struct FileReadWriteType {
  unsigned int Result;
  byte FileHandle;
  string Buffer;
  unsigned long Length;
};

// FileClose
struct FileCloseType {
  unsigned int Result;
  byte FileHandle;
};

// FileResolveHandle
struct FileResolveHandleType {
  unsigned int Result;
  byte FileHandle;
  bool WriteHandle;
  string Filename;
};

// FileRename
struct FileRenameType {
  unsigned int Result;
  string OldFilename;
  string NewFilename;
};

// FileDelete
struct FileDeleteType {
  unsigned int Result;
  string Filename;
};

#ifdef __ENHANCED_FIRMWARE
/**
 * LoaderExecuteFunctionType structure.
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
  unsigned int Result;    /*!< The function call result. \todo ?. */
  byte Cmd;               /*!< The command to execute. */
  string Filename;        /*!< The Filename parameter, see table. */
  byte Buffer[];          /*!< The Buffer parameter, see table. */
  unsigned long Length;   /*!< The Length parameter, see table. */
};

// FileFindFirst, FileFindNext
struct FileFindType {
 unsigned int Result;
 byte FileHandle;
 string Filename;
 unsigned long Length;
};

#if __FIRMWARE_VERSION > 107
//FileSeek
struct FileSeekType {
 unsigned int Result;
 byte FileHandle;
 byte Origin;
 long Length;
};

//FileResize
struct FileResizeType {
 unsigned int Result;
 byte FileHandle;
 unsigned int NewSize;
};

#endif
#endif
#if __FIRMWARE_VERSION > 107
// ListFiles
struct ListFilesType {
 char Result;
 string Pattern;
 string FileList[];
};
#endif
/** @} */ // end of LoaderModuleTypes group
/** @defgroup LoaderModuleFunctions Loader module functions
 * Functions for accessing and modifying Loader module features.
 * @{
 */
#ifdef __DOXYGEN_DOCS

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
 * This is an example of how to use the SysLoaderExecuteFunction function
 * along with the LoaderExecuteFunctionType structure.
 */

inline void SysFileFindFirst(FileFindType & args);
inline void SysFileFindNext(FileFindType & args);
inline void SysFileOpenWriteLinear(FileOpenType & args);
inline void SysFileOpenWriteNonLinear(FileOpenType & args);
inline void SysFileOpenReadLinear(FileOpenType & args);
#if __FIRMWARE_VERSION > 107
inline void SysFileSeek(FileSeekType & args);
inline void SysFileResize(FileResizeType & args);
#endif
#endif
#if __FIRMWARE_VERSION > 107
inline void SysListFiles(ListFilesType & args);
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


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// HiTechnic API ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup HiTechnicAPI
 * @{
 */

#define SetSensorHTEOPD(_p, _bStd) \
  SetSensorType(_p, (_bStd) ? IN_TYPE_LIGHT_INACTIVE : IN_TYPE_LIGHT_ACTIVE); \
  SetSensorMode(_p, IN_MODE_RAW); \
  ResetSensor(_p);

#define SetSensorHTGyro(_p) \
  SetSensorType(_p, IN_TYPE_LIGHT_INACTIVE); \
  SetSensorMode(_p, IN_MODE_RAW); \
  ResetSensor(_p);

#define SensorHTEOPD(_p) asm { \
  getin __RETVAL__, _p, RawValue \
  sub __RETVAL__, 1023, __RETVAL__ \
}

inline int SensorHTGyro(const byte port, const int offset = 0) {
  asm {
    getin __RETVAL__, port, RawValue
    sub __RETVAL__, __RETVAL__, 600
    sub __RETVAL__, __RETVAL__, offset
  }
}

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

/** @} */ // end of HiTechnicAPI group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// MindSensors API ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup MindSensorsAPI
 * @{
 */

#define SetSensorMSPressure(_p) \
  SetSensorType(_p, IN_TYPE_REFLECTION) \
  SetSensorMode(_p, IN_MODE_RAW) \
  ResetSensor(_p)
	
#define SetSensorMSDRODActive(_p) \
  SetSensorType(_p, IN_TYPE_LIGHT_ACTIVE) \
  SetSensorMode(_p, IN_MODE_PCTFULLSCALE) \
  ResetSensor(_p)

#define SetSensorMSDRODInactive(_p) \
  SetSensorType(_p, IN_TYPE_LIGHT_INACTIVE) \
  SetSensorMode(_p, IN_MODE_PCTFULLSCALE) \
  ResetSensor(_p)

#define SensorMSPressure(_p) asm { \
  getin __RETVAL__, _p, RawValue \
  sub __RETVAL__, 1024, __RETVAL__ \
  div __RETVAL__, __RETVAL__, 25 \
}

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

#define DISTNxGP2D12(_port) asm { __I2CSendCmd(_port, 0x02, DIST_CMD_GP2D12, __RETVAL__) }
#define DISTNxGP2D120(_port) asm { __I2CSendCmd(_port, 0x02, DIST_CMD_GP2D120, __RETVAL__) }
#define DISTNxGP2YA21(_port) asm { __I2CSendCmd(_port, 0x02, DIST_CMD_GP2YA21, __RETVAL__) }
#define DISTNxGP2YA02(_port) asm { __I2CSendCmd(_port, 0x02, DIST_CMD_GP2YA02, __RETVAL__) }
#define DISTNxEnergize(_port) asm { __I2CSendCmd(_port, 0x02, MS_CMD_ENERGIZED, __RETVAL__) }
#define DISTNxDistance(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_DIST, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxVoltage(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_VOLT, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxModuleType(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_MODULE_TYPE, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxNumPoints(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_NUM_POINTS, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxMinDistance(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_DIST_MIN, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxMaxDistance(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_DIST_MAX, 2, __RETVAL__, __TMPBYTE__) }

#define SensorMSDROD(_p) asm { getin __RETVAL__, _p, NormalizedValue }

#define PSPNxEnergize(_port) asm { __I2CSendCmd(_port, 0x02, MS_CMD_ENERGIZED, __RETVAL__) }

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

#define RunNRLinkMacroEx(_port, _addr, _macro) __RunNRLinkMacroEx(_port, _addr, _macro, __RETVAL__)
#define RunNRLinkMacro(_port, _macro) __RunNRLinkMacroEx(_port, 0x02, _macro, __RETVAL__)

#define NRLinkStatusEx(_port, _addr) asm { ReadNRLinkStatusEx(_port, _addr, __RETVAL__) }
#define NRLinkStatus(_port) asm { ReadNRLinkStatusEx(_port, 0x02, __RETVAL__) }

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

#define MSRCXSetNRLinkEx(_port, _addr) asm { __MSRCXSetNRLink(_port, _addr) }
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

/** @} */ // end of MindSensorsAPI group


///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// cmath API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup cmathAPI cmath API Functions
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
 */
inline float cos(float x) { asm { cos __FLTRETVAL__, x } }

/**
 * Compute sine.
 * Computes the sine of an angle of x radians.
 *
 * \param x Floating point value representing an angle expressed in radians.
 * \return Sine of x.
 */
inline float sin(float x) { asm { sin __FLTRETVAL__, x } }

/**
 * Compute tangent.
 * Computes the tangent of an angle of x radians.
 *
 * \param x Floating point value representing an angle expressed in radians.
 * \return Tangent of x.
 */
inline float tan(float x) { asm { tan __FLTRETVAL__, x } }

/**
 * Compute arc cosine.
 * Computes the principal value of the arc cosine of x, expressed in radians.
 * In trigonometrics, arc cosine is the inverse operation of cosine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc cosine of x, in the interval [0,pi] radians.
 */
inline float acos(float x) { asm { acos __FLTRETVAL__, x } }

/**
 * Compute arc sine.
 * Computes the principal value of the arc sine of x, expressed in radians.
 * In trigonometrics, arc sine is the inverse operation of sine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc sine of x, in the interval [-pi/2,+pi/2] radians.
 */
inline float asin(float x) { asm { asin __FLTRETVAL__, x } }

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
 */
inline float atan(float x) { asm { atan __FLTRETVAL__, x } }

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
 */
inline float atan2(float y, float x) { asm { atan2 __FLTRETVAL__, y, x } }

/**
 * Compute hyperbolic cosine.
 * Computes the hyperbolic cosine of x, expressed in radians.
 *
 * \param x Floating point value.
 * \return Hyperbolic cosine of x.
 */
inline float cosh(float x) { asm { cosh __FLTRETVAL__, x } }

/**
 * Compute hyperbolic sine.
 * Computes the hyperbolic sine of x, expressed in radians.
 *
 * \param x Floating point value.
 * \return Hyperbolic sine of x.
 */
inline float sinh(float x) { asm { sinh __FLTRETVAL__, x } }

/**
 * Compute hyperbolic tangent.
 * Computes the hyperbolic tangent of x, expressed in radians.
 *
 * \param x Floating point value.
 * \return Hyperbolic tangent of x.
 */
inline float tanh(float x) { asm { tanh __FLTRETVAL__, x } }

/**
 * Compute exponential function.
 * Computes the base-e exponential function of x, which is the e number
 * raised to the power x.
 *
 * \param x Floating point value.
 * \return Exponential value of x.
 */
inline float exp(float x) { asm { exp __FLTRETVAL__, x } }

/**
 * Compute natural logarithm.
 * Computes the natural logarithm of x. The natural logarithm is the base-e
 * logarithm, the inverse of the natural exponential function (exp). For
 * base-10 logarithms, a specific function log10() exists.
 *
 * \sa log10(), exp()
 * \param x Floating point value.
 * \return Natural logarithm of x.
 */
inline float log(float x) { asm { log __FLTRETVAL__, x } }

/**
 * Compute common logarithm.
 * Computes the common logarithm of x. The common logarithm is the base-10
 * logarithm. For base-e logarithms, a specific function log() exists.
 *
 * \sa log(), exp()
 * \param x Floating point value.
 * \return Common logarithm of x.
 */
inline float log10(float x) { asm { log10 __FLTRETVAL__, x } }

/**
 * Compute integral part.
 * Computes the integral part of x.
 *
 * \param x Floating point value.
 * \return Integral part of x.
 */
inline long trunc(float x) { asm { trunc __RETVAL__, x } }

/**
 * Compute fractional part.
 * Computes the fractional part of x.
 *
 * \param x Floating point value.
 * \return Fractional part of x.
 */
inline float frac(float x) { asm { frac __FLTRETVAL__, x } }

/**
 * Raise to power.
 * Computes base raised to the power exponent.
 *
 * \param base Floating point value.
 * \param exponent Floating point value.
 * \return The result of raising base to the power exponent.
 */
inline float pow(float base, float exponent) { asm { pow __FLTRETVAL__, base, exponent } }

/**
 * Round up value.
 * Computes the smallest integral value that is not less than x.
 *
 * \param x Floating point value.
 * \return The smallest integral value not less than x.
 */
inline float ceil(float x) { asm { ceil __FLTRETVAL__, x } }

/**
 * Round down value.
 * Computes the largest integral value that is not greater than x.
 *
 * \param x Floating point value.
 * \return The largest integral value not greater than x.
 */
inline float floor(float x) { asm { floor __FLTRETVAL__, x } }

/**
 * Multiply and divide.
 * Multiplies two 32-bit values and then divides the 64-bit result by a third
 * 32-bit value.
 *
 * \param a 32-bit long value.
 * \param b 32-bit long value.
 * \param c 32-bit long value.
 * \return The result of multiplying a times b and dividing by c.
 */
inline long muldiv32(long a, long b, long c) { asm { muldiv __RETVAL__, a, b, c } }

// degree-based trig functions

/**
 * Compute cosine (degrees).
 * Computes the cosine of an angle of x degrees.
 *
 * \param x Floating point value representing an angle expressed in degrees.
 * \return Cosine of x.
 */
inline float cosd(float x) { asm { cosd __FLTRETVAL__, x } }

/**
 * Compute sine (degrees).
 * Computes the sine of an angle of x degrees.
 *
 * \param x Floating point value representing an angle expressed in degrees.
 * \return Sine of x.
 */
inline float sind(float x) { asm { sind __FLTRETVAL__, x } }

/**
 * Compute tangent (degrees).
 * Computes the tangent of an angle of x degrees.
 *
 * \param x Floating point value representing an angle expressed in degrees.
 * \return Tangent of x.
 */
inline float tand(float x) { asm { tand __FLTRETVAL__, x } }

/**
 * Compute arc cosine (degrees).
 * Computes the principal value of the arc cosine of x, expressed in degrees.
 * In trigonometrics, arc cosine is the inverse operation of cosine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc cosine of x, in the interval [0,180] degrees.
 */
inline float acosd(float x) { asm { acosd __FLTRETVAL__, x } }

/**
 * Compute arc sine (degrees).
 * Computes the principal value of the arc sine of x, expressed in degrees.
 * In trigonometrics, arc sine is the inverse operation of sine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc sine of x, in the interval [-90,+90] degrees.
 */
inline float asind(float x) { asm { asind __FLTRETVAL__, x } }

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
 */
inline float atand(float x) { asm { atand __FLTRETVAL__, x } }

/**
 * Compute arc tangent with 2 parameters (degrees).
 * Computes the principal value of the arc tangent of y/x, expressed in
 * degrees. To compute the value, the function uses the sign of both arguments
 * to determine the quadrant.
 *
 * \param y Floating point value representing a y coordinate.
 * \param x Floating point value representing an x coordinate.
 * \return Arc tangent of y/x, in the interval [-90,+90] degrees.
 */
inline float atan2d(float y, float x) { asm { atan2d __FLTRETVAL__, y, x } }

/**
 * Compute hyperbolic cosine (degrees).
 * Computes the hyperbolic cosine of x, expressed in degrees.
 *
 * \param x Floating point value.
 * \return Hyperbolic cosine of x.
 */
inline float coshd(float x) { asm { coshd __FLTRETVAL__, x } }

/**
 * Compute hyperbolic sine (degrees).
 * Computes the hyperbolic sine of x, expressed in degrees.
 *
 * \param x Floating point value.
 * \return Hyperbolic sine of x.
 */
inline float sinhd(float x) { asm { sinhd __FLTRETVAL__, x } }

/**
 * Compute hyperbolic tangent (degrees).
 * Computes the hyperbolic tangent of x, expressed in degrees.
 *
 * \param x Floating point value.
 * \return Hyperbolic tangent of x.
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

inline byte bcd2dec(byte bcd) { asm { __bcd2dec(bcd, __RETVAL__) } }

/**
 * RandomNumberType structure.
 * This structure is used when calling the \ref SysRandomNumber system call
 * function.
 * \sa SysRandomNumber()
 */
struct RandomNumberType {
  int Result; /*!< The random number. */
};

#ifdef __DOXYGEN_DOCS

/**
 * Is the value NaN.
 * Returns true if the floating point value is NaN (not a number).
 *
 * \param value A floating point variable.
 * \return Whether the value is NaN.
 */
inline bool isNAN(float value);

/**
 * Absolute value.
 * Return the absolute value of the value argument. Any scalar type can
 * be passed into this function.
 *
 * \param num The numeric value for which to calculate its absolute value.
 * \return The absolute value of the parameter.
 */
inline variant abs(variant num);

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

/**
 * Draw a random number.
 * This function lets you obtain a random number via the \ref RandomNumberType
 * structure.
 *
 * \param args The RandomNumberType structure receiving results.
 */
inline void SysRandomNumber(RandomNumberType & args);
/** \example ex_sysrandomnumber.nxc
 * This is an example of how to use the SysRandomNumber function along with
 * the RandomNumberType structure.
 */

#else

#define isNAN(_x) ((_x) != (_x))

#define SysRandomNumber(_args) asm { \
  compchktype _args, RandomNumberType \
  syscall RandomNumber, _args \
}

#endif
/** @} */ // end of cmathAPI group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// cstdio API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup cstdioAPI cstdio API Functions
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

/**
 * Remove file.
 * Delete the specified file. The loader result code is returned as the value
 * of the function call.
 *
 * \param filename The name of the file to be deleted.
 * \return The loader result code.
 */
inline int remove(string filename) { return DeleteFile(filename); }

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

/**
 * Check End-of-file indicator.
 * Checks whether the End-of-File indicator associated with the handle is
 * set, returning a value different from zero if it is. 
 *
 * \param handle The handle of the file to check.
 * \return Currently always returns 0.
 */
inline int feof(byte handle) { return 0; }

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

/**
 * Flush file.
 * Writes any buffered data to the file. A zero value indicates success. 
 *
 * \param handle The handle of the file to be flushed.
 * \return Currently always returns 0.
 */
inline int fflush(byte handle) { return 0; }

/**
 * Get current position in file.
 * Returns the current value of the file position indicator of the specified
 * handle.
 *
 * \param handle The handle of the file.
 * \return Currently always returns -1.
 */
inline long ftell(byte handle) { return -1; }

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
#ifdef __ENHANCED_FIRMWARE

#ifdef __DOXYGEN_DOCS

/**
 * Print formatted data to stdout.
 * Writes to the LCD at 0, LCD_LINE1 a sequence of data formatted as the
 * format argument specifies. After the format parameter, the function
 * expects one value argument.
 *
 * \param _format A string specifying the desired format.
 * \param _value A value to be formatted for writing to the LCD.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void printf(string format, variant value);

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

/**
 * Write formatted data to string.
 * Writes a sequence of data formatted as the format argument specifies to a
 * string. After the format parameter, the function expects one value
 * argument.
 *
 * \param _str The string to write to.
 * \param _format A string specifying the desired format.
 * \param _value A value to be formatted for writing to the string.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void sprintf(string & str, string format, variant value);

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
 * position of the file pointer, or SEEK_END - end of file.
 * \return A value of zero if successful or non-zero otherwise.
 */
inline int fseek(byte handle, long offset, int origin) {
  FileSeekType fst;
  fst.FileHandle = handle;
  fst.Origin = origin;
  fst.Length = offset;
  SysFileSeek(fst);
  return fst.Result;
}

/**
 * Set position indicator to the beginning.
 * Sets the position indicator associated with stream to the beginning of
 * the file.
 *
 * \param handle The handle of the file.
 */
inline void rewind(byte handle) { fseek(handle, 0, SEEK_SET); }
#endif
#endif

/*
  size_t fread(ptr, size, count, FILE*); // read blocks of data from file; returns number of blocks read
  size_t fwrite(ptr, size, count, FILE*); // write blocks of data to stream; returns number of blocks written
  int getchar(void); // read character from stdin (returns which button was pressed)
  int putchar(int character); // write character to stdout
*/
/** @} */ // end of cstdioAPI group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// cstring API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup cstringAPI cstring API Functions
 * Standard C cstring API functions.
 * @{
 */

#ifdef __DOXYGEN_DOCS

inline variant StrToNum(string str);
inline unsigned int StrLen(string str);
inline byte StrIndex(string str, unsigned int idx);
inline string NumToStr(variant num);
inline string StrCat(string str1, string str2, string str3, string strN);
inline string SubStr(string str, unsigned int idx, unsigned int len);
inline string Flatten(variant num);
inline string StrReplace(string str, unsigned int idx, string strnew);
inline string FormatNum(string fmt, variant number);

inline string FlattenVar(variant x);
inline int UnflattenVar(string str, variant & variable);
inline string ByteArrayToStr(byte data[]);
inline void ByteArrayToStrEx(byte data[], string & str);
inline void StrToByteArray(string str, byte & data[]);

#else

#define FlattenVar(_value) asm { flatten __STRRETVAL__, _value }
#define UnflattenVar(_str, _value) asm { unflatten _value, __RETVAL__, _str, _value }
#define ByteArrayToStr(_asrc) asm { arrtostr __STRRETVAL__, _asrc }
#define ByteArrayToStrEx(_asrc, _sout) asm { arrtostr _sout, _asrc }
#define StrToByteArray(_ssrc, _aout) asm { strtoarr _aout, _ssrc }

#endif

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
  strncpy(sub1, str1, num);
  strncpy(sub2, str2, num);
  int result = -1;
  if (sub1 == sub2)
    result = 0;
  else if (sub1 > sub2)
    result = 1;
  return result;
}

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

/**
 * Compare two blocks of memory.
 * Compares the variant ptr1 to the variant ptr2. Returns an integral value
 * indicating the relationship between the variables. The num argument is
 * ignored.
 *
 * \todo re-implement this function so that it actually works.
 *
 * \param ptr1 A variable to be compared.
 * \param ptr2 A variable to be compared.
 * \param num The number of bytes to compare (ignored).
 */
inline char memcmp(variant ptr1, variant ptr2, byte num);

#else

#define memcpy(_dest, _src, _num) asm { mov _dest, _src }
#define memmove(_dest, _src, _num) asm { mov _dest, _src }
#define memcmp(_ptr1, _ptr2, _num) { \
  asm { mov __RETVAL__, -1 }; \
  if ((_ptr1) == (_ptr2)) { \
    asm { mov __RETVAL__, 0 }; \
  } else if ((_ptr1) > (_ptr2)) { \
    asm { mov __RETVAL__, 1 }; \
  } \
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
/** @} */ // end of cstringAPI group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// ctype API ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup ctypeAPI ctype API Functions
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

/**
 * Check if character is lowercase letter.
 * Checks if parameter c is an lowercase alphabetic letter.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is an lowercase alphabetic
 * letter, otherwise it returns 0 (false).
 */
inline int islower(int c) { return ((c >= 'a') && (c <= 'z')); }

/**
 * Check if character is alphabetic.
 * Checks if parameter c is either an uppercase or lowercase letter.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is an alphabetic letter,
 * otherwise it returns 0 (false).
 */
inline int isalpha(int c) { return isupper(c) || islower(c); }

/**
 * Check if character is decimal digit.
 * Checks if parameter c is a decimal digit character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a decimal digit, otherwise
 * it returns 0 (false).
 */
inline int isdigit(int c) { return ((c >= '0') && (c <= '9')); }

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

/**
 * Check if character is a white-space.
 * Checks if parameter c is a white-space character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a white-space character,
 * otherwise it returns 0 (false).
 */
inline int isspace(int c) { return (c == 0x20) || ((c >= 0x09) && (c <= 0x0d)); }

/**
 * Check if character is a control character.
 * Checks if parameter c is a control character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a control character,
 * otherwise it returns 0 (false).
 */
inline int iscntrl(int c) { return (c <= 0x1f) || (c == 0x7f); }

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

/**
 * Check if character has graphical representation.
 * Checks if parameter c is a character with a graphical representation.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c has a graphical representation,
 * otherwise it returns 0 (false).
 */
inline int isgraph(int c) { return (c != 0x20) && isprint(c); }

/**
 * Check if character is a punctuation.
 * Checks if parameter c is a punctuation character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a punctuation character,
 * otherwise it returns 0 (false).
 */
inline int ispunct(int c) { return isgraph(c) && !isalnum(c); }

/**
 * Check if character is hexadecimal digit.
 * Checks if parameter c is a hexadecimal digit character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a hexadecimal digit
 * character, otherwise it returns 0 (false).
 */
inline int isxdigit(int c) {  return isdigit(c) || ((c >= 'A') && (c <= 'F')) || ((c >= 'a') && (c <= 'f')); }

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

/** @} */ // end of ctypeAPI group

/** @addtogroup RICMacros
 * @{
 */
#define RICSetValue(_data, _idx, _newval) _data[(_idx)] = (_newval)&0xFF; _data[(_idx)+1] = (_newval)>>8
/** @} */ // end of RICMacros group


#endif // NXCDEFS_H
