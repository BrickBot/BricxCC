/** \file nbc_input.h
 * \brief The NBC input module API
 *
 * nbc_input.h contains the NBC input module API
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

#ifndef NBC_INPUT_H
#define NBC_INPUT_H

#include "input_constants.h"
#include "nbc_command.h"

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// INPUT MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup InputModule
 * @{
 */
/** @defgroup InputModuleFunctions Input module functions
 * Functions for accessing and modifying input module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0



dseg segment
  __SensorInvalidTmp byte
dseg ends

dseg segment
  __ResetSensorMutex mutex
  __ResetSensorPort byte
  __ResetSensorTmp byte
dseg ends

subroutine __ResetSensorSubroutine
  setin TRUE, __ResetSensorPort, InvalidDataField
__SensorStillInvalid:
  getin	__ResetSensorTmp, __ResetSensorPort, InvalidDataField
  brtst	NEQ, __SensorStillInvalid, __ResetSensorTmp
  return
ends

#define __ResetSensor(_port) \
  acquire __ResetSensorMutex \
  mov __ResetSensorPort, _port \
  call __ResetSensorSubroutine \
  release __ResetSensorMutex

#define __SetSensorTouch(_port) \
  setin IN_TYPE_SWITCH, _port, TypeField \
  setin IN_MODE_BOOLEAN, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorLight(_port) \
  setin IN_TYPE_LIGHT_ACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorSound(_port) \
  setin IN_TYPE_SOUND_DB, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorLowspeed(_port) \
  setin IN_TYPE_LOWSPEED_9V, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#if __FIRMWARE_VERSION > 107

#define __SetSensorColorFull(_port) \
  setin IN_TYPE_COLORFULL, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorColorRed(_port) \
  setin IN_TYPE_COLORRED, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorColorGreen(_port) \
  setin IN_TYPE_COLORGREEN, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorColorBlue(_port) \
  setin IN_TYPE_COLORBLUE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorColorNone(_port) \
  setin IN_TYPE_COLORNONE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#endif

#if __FIRMWARE_VERSION > 107

dseg segment

// ColorSensorRead
TColorSensorRead	struct
 Result			sbyte
 Port			byte
 ColorValue		sword
 RawArray		word[]
 NormalizedArray	word[]
 ScaledArray		sword[]
 Invalid		byte
TColorSensorRead	ends

  __ColorSensorReadArgs TColorSensorRead
  __ColorSensorReadMutex mutex
dseg ends

#define __ReadSensorColorRaw(_port, _rawVals, _result) \
  acquire __ColorSensorReadMutex \
  mov __ColorSensorReadArgs.Port,_port \
  syscall ColorSensorRead,__ColorSensorReadArgs \
  mov _rawVals, __ColorSensorReadArgs.RawArray \
  tst EQ, _result, __ColorSensorReadArgs.Result \
  release __ColorSensorReadMutex

#define __ReadSensorColorEx(_port, _colorval, _rawVals, _normVals, _scaledVals, _result) \
  acquire __ColorSensorReadMutex \
  mov __ColorSensorReadArgs.Port,_port \
  syscall ColorSensorRead,__ColorSensorReadArgs \
  mov _colorval, __ColorSensorReadArgs.ColorValue \
  mov _rawVals, __ColorSensorReadArgs.RawArray \
  mov _normVals, __ColorSensorReadArgs.NormalizedArray \
  mov _scaledVals, __ColorSensorReadArgs.ScaledArray \
  tst EQ, _result, __ColorSensorReadArgs.Result \
  release __ColorSensorReadMutex

#endif

dseg segment
  __inputModuleOffsetMutex mutex
  __inputModuleOffset word
  __inputModuleOffsetTmp word
dseg ends

#define __GetInCustomZeroOffset(_p, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetCustomZeroOffset(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInSensorBoolean(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetSensorBoolean(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 10 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInDigiPinsDirection(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetDigiPinsDir(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 11 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInDigiPinsStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetDigiPinsIn(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 12 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInDigiPinsOutputLevel(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetDigiPinsOut(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 13 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInCustomPercentFullScale(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetCustomPctFullScale(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 14 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInCustomActiveStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetCustomActiveStatus(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 15 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#if __FIRMWARE_VERSION > 107

#define __GetInColorCalibration(_p, _np, _nc, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p+_np+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _np, INPUT_NO_OF_POINTS \
  compchk GTEQ, _np, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorCalibration(_p, _np, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _np, 16 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  mul __inputModuleOffsetTmp, _nc, 4 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 80 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorCalLimits(_p, _np, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p+_np), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _np, 0x02 \
  compchk GTEQ, _np, 0x00 \
  GetInputModuleValue(InputOffsetColorCalLimits(_p, _np), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _np, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 128 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorADRaw(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorADRaw(_p, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _nc, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 132 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorSensorRaw(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorSensorRaw(_p, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _nc, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 140 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorSensorValue(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorSensorValue(_p, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _nc, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 148 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorBoolean(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorBoolean(_p, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _nc, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 156 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorCalibrationState(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetColorCalibrationState(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  add __inputModuleOffset, __inputModuleOffset, 160 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#endif

#define __setInCustomZeroOffset(_p, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetCustomZeroOffset(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInSensorBoolean(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetSensorBoolean(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 10 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInDigiPinsDirection(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetDigiPinsDir(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 11 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInDigiPinsStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetDigiPinsIn(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 12 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInDigiPinsOutputLevel(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetDigiPinsOut(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 13 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInCustomPercentFullScale(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetCustomPctFullScale(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 14 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInCustomActiveStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetCustomActiveStatus(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 15 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#endif

/**
 * Set sensor type.
 * Set a sensor's type, which must be one of the predefined sensor type
 * constants.  After changing the type or the mode of a sensor
 * port you must call \ref ResetSensor to give the firmware time to reconfigure
 * the sensor port.
 * \sa SetSensorMode()
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 * \param _t The desired sensor type.  See \ref NBCSensorTypeConstants.
 */
#define SetSensorType(_port,_t) setin _t, _port, TypeField

/**
 * Set sensor mode.
 * Set a sensor's mode, which should be one of the predefined sensor mode
 * constants. A slope parameter for boolean conversion, if desired, may be
 * added to the mode. After changing the type or the mode of a sensor
 * port you must call \ref ResetSensor to give the firmware time to reconfigure
 * the sensor port.
 * \sa SetSensorType()
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 * \param _m The desired sensor mode. See \ref NBCSensorModeConstants.
 */
#define SetSensorMode(_port,_m) setin _m, _port, InputModeField

/**
 * Read sensor scaled value.
 * Return the processed sensor reading for a sensor on the specified port.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants. A variable whose value is
 * the desired sensor port may also be used.
 * \param _value The sensor's scaled value.
 */
#define ReadSensor(_port,_value) getin _value, _port, ScaledValueField

/**
 * Clear a sensor value.
 * Clear the value of a sensor - only affects sensors that are configured
 * to measure a cumulative quantity such as rotation or a pulse count.
 * \param _port The port to clear. See \ref NBCInputPortConstants.
 */
#define ClearSensor(_port) setin 0, _port, ScaledValueField

/**
 * Configure a touch sensor.
 * Configure the sensor on the specified port as a touch sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorTouch(_port) __SetSensorTouch(_port)

/**
 * Configure a light sensor.
 * Configure the sensor on the specified port as an NXT light sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorLight(_port) __SetSensorLight(_port)

/**
 * Configure a sound sensor.
 * Configure the sensor on the specified port as a sound sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorSound(_port) __SetSensorSound(_port)

/**
 * Configure an I2C sensor.
 * Configure the sensor on the specified port as a 9V powered I2C digital sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorLowspeed(_port) __SetSensorLowspeed(_port)

/**
 * Configure an ultrasonic sensor.
 * Configure the sensor on the specified port as an ultrasonic sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorUltrasonic(_port) __SetSensorLowspeed(_port)

/**
 * Configure an EMeter sensor.
 * Configure the sensor on the specified port as an EMeter sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorEMeter(_port) __SetSensorLowspeed(_port)

/**
 * Configure a temperature sensor.
 * Configure the sensor on the specified port as a temperature sensor. Use this
 * to setup the temperature sensor rather than \ref SetSensorLowspeed so that
 * the sensor is properly configured in 12-bit conversion mode.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorTemperature(_port) \
  __SetSensorLowspeed(_port) \
  __I2CWriteToRegister(_port, LEGO_ADDR_TEMP, TEMP_REG_CONFIG, TEMP_RES_12BIT, __WDSC_LSStatus)


#if __FIRMWARE_VERSION > 107

/**
 * Configure an NXT 2.0 full color sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in full color mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorFull(_port) __SetSensorColorFull(_port)

/**
 * Configure an NXT 2.0 red light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in red light mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorRed(_port) __SetSensorColorRed(_port)

/**
 * Configure an NXT 2.0 green light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in green light mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorGreen(_port) __SetSensorColorGreen(_port)

/**
 * Configure an NXT 2.0 blue light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in blue light mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorBlue(_port) __SetSensorColorBlue(_port)

/**
 * Configure an NXT 2.0 no light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in no light mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorNone(_port) __SetSensorColorNone(_port)

#endif

/**
 * Reset the sensor port.
 * Sets the invalid data flag on the specified port and waits for it to
 * become valid again. After changing the type or the mode of a sensor
 * port you must call this function to give the firmware time to reconfigure
 * the sensor port.
 * \param _port The port to reset. See \ref NBCInputPortConstants.
 */
#define ResetSensor(_port) __ResetSensor(_port)

#if __FIRMWARE_VERSION > 107

/**
 * Read LEGO color sensor raw values.
 * This function lets you read the LEGO color sensor. It returns an array
 * containing raw color values for red, green, blue, and none indices.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _rawVals An array containing four raw color values. See \ref InputColorIdxConstants.
 * \param _result The function call result.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define ReadSensorColorRaw(_port, _rawVals, _result) __ReadSensorColorRaw(_port, _rawVals, _result)

/**
 * Read LEGO color sensor extra.
 * This function lets you read the LEGO color sensor. It returns the color value,
 * and three arrays containing raw, normalized, and scaled color values for
 * red, green, blue, and none indices.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _colorval The color value. See \ref InputColorValueConstants.
 * \param _rawVals An array containing four raw color values. See \ref InputColorIdxConstants.
 * \param _normVals An array containing four normalized color values. See \ref InputColorIdxConstants.
 * \param _scaledVals An array containing four scaled color values. See \ref InputColorIdxConstants.
 * \param _result The function call result.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define ReadSensorColorEx(_port, _colorval, _rawVals, _normVals, _scaledVals, _result) \
   __ReadSensorColorEx(_port, _colorval, _rawVals, _normVals, _scaledVals, _result)

#endif

/**
 * Get the custom sensor zero offset.
 * Return the custom sensor zero offset value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _n The custom sensor zero offset.
 */
#define GetInCustomZeroOffset(_p, _n) __GetInCustomZeroOffset(_p, _n)

/**
 * Read sensor boolean value.
 * Return the boolean value of a sensor on the specified port. Boolean
 * conversion is either done based on preset cutoffs, or a slope parameter
 * specified by calling SetSensorMode.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The sensor's boolean value.
 */
#define GetInSensorBoolean(_p, _n) __GetInSensorBoolean(_p, _n)

/**
 * Read sensor digital pins direction.
 * Return the digital pins direction value of a sensor on the specified port.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The sensor's digital pins direction.
 */
#define GetInDigiPinsDirection(_p, _n) __GetInDigiPinsDirection(_p, _n)

/**
 * Read sensor digital pins status.
 * Return the digital pins status value of a sensor on the specified port.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The sensor's digital pins status.
 */
#define GetInDigiPinsStatus(_p, _n) __GetInDigiPinsStatus(_p, _n)

/**
 * Read sensor digital pins output level.
 * Return the digital pins output level value of a sensor on the specified port.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The sensor's digital pins output level.
 */
#define GetInDigiPinsOutputLevel(_p, _n) __GetInDigiPinsOutputLevel(_p, _n)

/**
 * Get the custom sensor percent full scale.
 * Return the custom sensor percent full scale value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _n The custom sensor percent full scale.
 */
#define GetInCustomPercentFullScale(_p, _n) __GetInCustomPercentFullScale(_p, _n)

/**
 * Get the custom sensor active status.
 * Return the custom sensor active status value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _n The custom sensor active status.
*/
#define GetInCustomActiveStatus(_p, _n) __GetInCustomActiveStatus(_p, _n)

#if __FIRMWARE_VERSION > 107

/**
 * Read a LEGO color sensor calibration point value.
 * This function lets you directly access a specific LEGO color calibration point value.
 * The port, point, and color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _np The calibration point. See \ref InputColorCalibrationConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The calibration point value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorCalibration(_p, _np, _nc, _n) __GetInColorCalibration(_p, _np, _nc, _n)

/**
 * Read a LEGO color sensor calibration limit value.
 * This function lets you directly access a specific LEGO color calibration limit value.
 * The port and the point must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _np The calibration point. See \ref InputColorCalibrationConstants. Must be a constant.
 * \param _n The calibration limit value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorCalLimits(_p, _np, _n) __GetInColorCalLimits(_p, _np, _n)

/**
 * Read a LEGO color sensor AD raw value.
 * This function lets you directly access a specific LEGO color sensor AD raw value. Both the
 * port and the color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The AD raw value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorADRaw(_p, _nc, _n) __GetInColorADRaw(_p, _nc, _n)

/**
 * Read a LEGO color sensor raw value.
 * This function lets you directly access a specific LEGO color sensor raw value. Both the
 * port and the color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The raw value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorSensorRaw(_p, _nc, _n) __GetInColorSensorRaw(_p, _nc, _n)

/**
 * Read a LEGO color sensor scaled value.
 * This function lets you directly access a specific LEGO color sensor scaled value. Both the
 * port and the color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The scaled value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorSensorValue(_p, _nc, _n) __GetInColorSensorValue(_p, _nc, _n)

/**
 * Read a LEGO color sensor boolean value.
 * This function lets you directly access a specific LEGO color sensor boolean value. Both the
 * port and the color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The boolean value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorBoolean(_p, _nc, _n) __GetInColorBoolean(_p, _nc, _n)

/**
 * Read LEGO color sensor calibration state.
 * This function lets you directly access the LEGO color calibration state.
 * The port must be a constant.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The calibration state.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorCalibrationState(_p, _n) __GetInColorCalibrationState(_p, _n)

#endif

/**
 * Set custom zero offset.
 * Sets the zero offset value of a custom sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new zero offset value.
 */
#define SetInCustomZeroOffset(_p, _n) __setInCustomZeroOffset(_p, _n)

/**
 * Set sensor boolean value.
 * Sets the boolean value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new boolean value.
 */
#define SetInSensorBoolean(_p, _n) __setInSensorBoolean(_p, _n)

/**
 * Set digital pins direction.
 * Sets the digital pins direction value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new digital pins direction value.
 */
#define SetInDigiPinsDirection(_p, _n) __setInDigiPinsDirection(_p, _n)

/**
 * Set digital pins status.
 * Sets the digital pins status value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new digital pins status value.
 */
#define SetInDigiPinsStatus(_p, _n) __setInDigiPinsStatus(_p, _n)

/**
 * Set digital pins output level.
 * Sets the digital pins output level value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new digital pins output level value.
 */
#define SetInDigiPinsOutputLevel(_p, _n) __setInDigiPinsOutputLevel(_p, _n)

/**
 * Set percent full scale.
 * Sets the percent full scale value of a custom sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new percent full scale value.
 */
#define SetInCustomPercentFullScale(_p, _n) __setInCustomPercentFullScale(_p, _n)

/**
 * Set active status.
 * Sets the active status value of a custom sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new active status value.
 */
#define SetInCustomActiveStatus(_p, _n) __setInCustomActiveStatus(_p, _n)

/** @} */ // end of InputModuleFunctions group
/** @} */ // end of InputModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_INPUT_H
