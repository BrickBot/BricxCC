/** \file nbc_mindsensors.h
 * \brief The NBC mindsensors.com API
 *
 * nbc_mindsensors.h contains the NBC mindsensors.com API
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

#ifndef NBC_MINDSENSORS_H
#define NBC_MINDSENSORS_H

#include "input_constants.h"
#include "mindsensors_constants.h"
#include "nbc_input.h"
#include "nbc_lowspeed.h"

/** @addtogroup ThirdPartyDevices
 * @{
 */

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// MindSensors API ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup MindSensorsAPI
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

#define __SetSensorMSPressure(_port) \
  setin IN_TYPE_REFLECTION, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorMSDRODActive(_port) \
  setin IN_TYPE_LIGHT_ACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorMSDRODInactive(_port) \
  setin IN_TYPE_LIGHT_INACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorNXTSumoEyesLong(_port) \
  setin IN_TYPE_LIGHT_INACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port) \
  wait 275

#define __SetSensorNXTSumoEyesShort(_port) \
  setin IN_TYPE_LIGHT_ACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port) \
  wait 275

#define __SetSensorMSTouchMux(_port) \
  setin IN_TYPE_LIGHT_INACTIVE, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __ReadSensorMSPressure(_port, _value) \
  getin _value, _port, RawValueField \
  sub _value, 1024, _value \
  div _value, _value, 25

#define __ReadSensorMSPressureRaw(_port, _value) \
  getin _value, _port, RawValueField

#define __ReadSensorMSDROD(_port, _value) \
  getin _value, _port, NormalizedValueField

#define __ReadSensorNXTSumoEyes(_port, _value) \
  getin _value, _port, NormalizedValueField \
  mul _value, _value, 100 \
  div _value, _value, 1023

#define __ReadSensorMSCompass(_port, _i2caddr, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, 0x42 \
  set __RLSBytesCountVar, 2 \
  set __RLSPadVar, 2 \
  call __ReadLSBytesVar \
  index _value, __RLSReadBufVar, 1 \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  mul _value, _value, 256 \
  add _value, _value, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, 0x42 \
  set __RLSBytesCount##_port, 2 \
  set __RLSPad##_port, 2 \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, 1 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  mul _value, _value, 256 \
  add _value, _value, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, 0xD0, 0x00 \
  set __RLSBytesCountVar, 8 \
  set __RLSPadVar, 8 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _sec, __RLSReadBufVar, NA \
  index _min, __RLSReadBufVar, 1 \
  index _hrs, __RLSReadBufVar, 2 \
  index _dow, __RLSReadBufVar, 3 \
  index _date, __RLSReadBufVar, 4 \
  index _month, __RLSReadBufVar, 5 \
  index _year, __RLSReadBufVar, 6 \
  bcd2dec(_sec, _sec) \
  bcd2dec(_min, _min) \
  bcd2dec(_hrs, _hrs) \
  bcd2dec(_dow, _dow) \
  bcd2dec(_date, _date) \
  bcd2dec(_month, _month) \
  bcd2dec(_year, _year) \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, 0xD0, 0x00 \
  set __RLSBytesCount##_port, 8 \
  set __RLSPad##_port, 8 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _sec, __RLSReadBuf##_port, NA \
  index _min, __RLSReadBuf##_port, 1 \
  index _hrs, __RLSReadBuf##_port, 2 \
  index _dow, __RLSReadBuf##_port, 3 \
  index _date, __RLSReadBuf##_port, 4 \
  index _month, __RLSReadBuf##_port, 5 \
  index _year, __RLSReadBuf##_port, 6 \
  bcd2dec(_sec, _sec) \
  bcd2dec(_min, _min) \
  bcd2dec(_hrs, _hrs) \
  bcd2dec(_dow, _dow) \
  bcd2dec(_date, _date) \
  bcd2dec(_month, _month) \
  bcd2dec(_year, _year) \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, 0x42  \
  set __RLSBytesCountVar, 3 \
  set __RLSPadVar, 3 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _x, __RLSReadBufVar, NA \
  index _y, __RLSReadBufVar, 1 \
  index _z, __RLSReadBufVar, 2 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, 0x42 \
  set __RLSBytesCount##_port, 3 \
  set __RLSPad##_port, 3 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _x, __RLSReadBuf##_port, NA \
  index _y, __RLSReadBuf##_port, 1 \
  index _z, __RLSReadBuf##_port, 2 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, 0x45 \
  set __RLSBytesCountVar, 6 \
  set __RLSPadVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _x, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul __RLSBytesCountVar, __RLSBytesCountVar, 256 \
  add _x, _x, __RLSBytesCountVar \
  index _y, __RLSReadBufVar, 2 \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  mul __RLSBytesCountVar, __RLSBytesCountVar, 256 \
  add _y, _y, __RLSBytesCountVar \
  index _z, __RLSReadBufVar, 4 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  mul __RLSBytesCountVar, __RLSBytesCountVar, 256 \
  add _z, _z, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, 0x45 \
  set __RLSBytesCount##_port, 6 \
  set __RLSPad##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _x, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul __RLSBytesCount##_port, __RLSBytesCount##_port, 256 \
  add _x, _x, __RLSBytesCount##_port \
  index _y, __RLSReadBuf##_port, 2 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  mul __RLSBytesCount##_port, __RLSBytesCount##_port, 256 \
  add _y, _y, __RLSBytesCount##_port \
  index _z, __RLSReadBuf##_port, 4 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  mul __RLSBytesCount##_port, __RLSBytesCount##_port, 256 \
  add _z, _z, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  set __RLSPadVar, 0 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, PFMATE_REG_CHANNEL, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB  \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  arrbuild __RLSReadBufVar, _i2caddr, PFMATE_REG_CMD, PFMATE_CMD_GO  \
  set __RLSBytesCountVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  set __RLSPad##_port, 0 \
  arrbuild __RLSReadBuf##_port, _i2caddr, PFMATE_REG_CHANNEL, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB  \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, PFMATE_REG_CMD, PFMATE_CMD_GO  \
  set __RLSBytesCount##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

#define __PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  set __RLSPadVar, 0 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, PFMATE_REG_CHANNEL, _channel, 0x00, _b1, _b2  \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  arrbuild __RLSReadBufVar, _i2caddr, PFMATE_REG_CMD, PFMATE_CMD_RAW  \
  set __RLSBytesCountVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  set __RLSPad##_port, 0 \
  arrbuild __RLSReadBuf##_port, _i2caddr, PFMATE_REG_CHANNEL, _channel, 0x00, _b1, _b2  \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, PFMATE_REG_CMD, PFMATE_CMD_RAW  \
  set __RLSBytesCount##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

#define __NXTServoInit(_port, _i2caddr, _servo, _result) \
  __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_INIT, _result) \
  __I2CSendCmd(_port, _i2caddr, _servo+1, _result)

#define __NXTServoGotoMacroAddress(_port, _i2caddr, _macro, _result) \
  __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_GOTO, _result) \
  __I2CSendCmd(_port, _i2caddr, _macro, _result)

#define __NXTServoEditMacro(_port, _i2caddr, _result) \
  __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_EDIT1, _result) \
  __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_EDIT2, _result)

#define __NXTHIDLoadCharacter(_port, _i2caddr, _modifier, _character, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, _modifier, _character \
  set __RLSBytesCountVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, _modifier, _character \
  set __RLSBytesCount##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorMSPlayStation(_port, _i2caddr, _b1, _b2, _xleft, _yleft, _xright, _yright, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, PSP_REG_BTNSET1 \
  set __RLSBytesCountVar, 6 \
  set __RLSPadVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _b1, __RLSReadBufVar, NA \
  index _b2, __RLSReadBufVar, 1 \
  index _xleft, __RLSReadBufVar, 2 \
  index _yleft, __RLSReadBufVar, 3 \
  index _xright, __RLSReadBufVar, 4 \
  index _yright, __RLSReadBufVar, 5 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, PSP_REG_BTNSET1 \
  set __RLSBytesCount##_port, 6 \
  set __RLSPad##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _b1, __RLSReadBuf##_port, NA \
  index _b2, __RLSReadBuf##_port, 1 \
  index _xleft, __RLSReadBuf##_port, 2 \
  index _yleft, __RLSReadBuf##_port, 3 \
  index _xright, __RLSReadBuf##_port, 4 \
  index _yright, __RLSReadBuf##_port, 5 \
  release __RLSBmutex##_port \
  compend

#endif

/**
 * Read mindsensors compass value.
 * Return the Mindsensors Compass sensor value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The mindsensors compass value
 */
#define ReadSensorMSCompass(_port, _i2caddr, _value) __ReadSensorMSCompass(_port, _i2caddr, _value)

/**
 * Read mindsensors DROD value.
 * Return the Mindsensors DROD sensor value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The mindsensors DROD value
 */
#define ReadSensorMSDROD(_port, _value) __ReadSensorMSDROD(_port, _value)

/**
 * Configure a mindsensors DROD active sensor.
 * Configure the specified port for an active mindsensors DROD sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorMSDRODActive(_port) __SetSensorMSDRODActive(_port)

/**
 * Configure a mindsensors DROD inactive sensor.
 * Configure the specified port for an inactive mindsensors DROD sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorMSDRODInactive(_port) __SetSensorMSDRODInactive(_port)

/**
 * Read mindsensors NXTSumoEyes value.
 * Return the Mindsensors NXTSumoEyes sensor value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The mindsensors NXTSumoEyes value
 */
#define ReadSensorNXTSumoEyes(_port, _value) __ReadSensorNXTSumoEyes(_port, _value)

/**
 * Configure a mindsensors NXTSumoEyes long range sensor.
 * Configure the specified port for a long range mindsensors NXTSumoEyes sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorNXTSumoEyesLong(_port) __SetSensorNXTSumoEyesLong(_port)

/**
 * Configure a mindsensors NXTSumoEyes short range sensor.
 * Configure the specified port for a short range mindsensors NXTSumoEyes sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorNXTSumoEyesShort(_port) __SetSensorNXTSumoEyesShort(_port)

/**
 * Read mindsensors raw pressure value.
 * Return the Mindsensors pressure sensor raw value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The mindsensors raw pressure value
 */
#define ReadSensorMSPressureRaw(_port, _value) __ReadSensorMSPressureRaw(_port, _value)

/**
 * Read mindsensors processed pressure value.
 * Return the Mindsensors pressure sensor processed value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The mindsensors processed pressure value
 */
#define ReadSensorMSPressure(_port, _value) __ReadSensorMSPressure(_port, _value)

/**
 * Configure a mindsensors pressure sensor.
 * Configure the specified port for a mindsensors pressure sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorMSPressure(_port) __SetSensorMSPressure(_port)

/**
 * Configure a mindsensors touch sensor multiplexer.
 * Configure the specified port for a mindsensors touch sensor multiplexer.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorMSTouchMux(_port) __SetSensorMSTouchMux(_port)

/**
 * Read mindsensors acceleration values.
 * Read X, Y, and Z axis acceleration values from the mindsensors Accelerometer
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _x The output x-axis acceleration.
 * \param _y The output y-axis acceleration.
 * \param _z The output z-axis acceleration.
 * \param _result The function call result.
 */
#define ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z, _result) __ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z, _result)

/**
 * Read mindsensors playstation controller values.
 * Read playstation controller values from the mindsensors playstation
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _b1 The button set 1 values. See \ref MSPSPNXBtnSet1.
 * \param _b2 The button set 2 values. See \ref MSPSPNXBtnSet2.
 * \param _xleft The left joystick x value.
 * \param _yleft The left joystick y value.
 * \param _xright The right joystick x value.
 * \param _yright The right joystick y value.
 * \param _result The function call result.
 */
#define ReadSensorMSPlayStation(_port, _i2caddr, _b1, _b2, _xleft, _yleft, _xright, _yright, _result) \
  __ReadSensorMSPlayStation(_port, _i2caddr, _b1, _b2, _xleft, _yleft, _xright, _yright, _result)

/**
 * Read mindsensors RTClock values.
 * Read real-time clock values from the Mindsensors RTClock sensor. Returns
 * a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _sec The seconds.
 * \param _min The minutes.
 * \param _hrs The hours.
 * \param _dow The day of week number.
 * \param _date The day.
 * \param _month The month.
 * \param _year The year.
 * \param _result The function call result.
 */
#define ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, _result) \
  __ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, _result)

/**
 * Read mindsensors tilt values.
 * Read X, Y, and Z axis tilt values from the mindsensors tilt
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _x The output x-axis tilt.
 * \param _y The output y-axis tilt.
 * \param _z The output z-axis tilt.
 * \param _result The function call result.
 */
#define ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z, _result) __ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z, _result)

/**
 * Send PFMate command.
 * Send a PFMate command to the power function IR receiver.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The power function IR receiver channel. See the \ref PFMateChannelConstants group.
 * \param _motors The motor(s) to control. See the \ref PFMateMotorConstants group.
 * \param _cmdA The power function command for motor A. See the \ref PFCmdConstants group.
 * \param _spdA The power function speed for motor A.
 * \param _cmdB The power function command for motor B. See the \ref PFCmdConstants group.
 * \param _spdB The power function speed for motor B.
 * \param _result The function call result.
 */
#define PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB, _result) \
  __PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB, _result)

/**
 * Send raw PFMate command.
 * Send a raw PFMate command to the power function IR receiver.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The power function IR receiver channel. See the \ref PFMateChannelConstants group.
 * \param _b1 Raw byte 1.
 * \param _b2 Raw byte 2.
 * \param _result The function call result.
 */
#define PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2, _result) \
  __PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2, _result)

/**
 * Read a mindsensors device value.
 * Read a one, two, or four byte value from a mindsensors sensor. The value must be
 * stored with the least signficant byte (LSB) first (i.e., little endian). Returns a boolean value
 * indicating whether or not the operation completed successfully. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _reg The device register to read.
 * \param _bytes The number of bytes to read. Only 1, 2, or 4 byte values are supported.
 * \param _out The value read from the device.
 * \param _result The function call result.
 */
#define MSReadValue(_port, _i2caddr, _reg, _bytes, _out, _result) __I2CReadValue(_port, _i2caddr, _reg, _bytes, _out, _result)

/**
 * Turn on power to device.
 * Turn the power on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define MSEnergize(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, MS_CMD_ENERGIZED, _result)

/**
 * Turn off power to device.
 * Turn power off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define MSDeenergize(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, MS_CMD_DEENERGIZED, _result)

/**
 * Turn on mindsensors ADPA mode.
 * Turn ADPA mode on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define MSADPAOn(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, MS_CMD_ADPA_ON, _result)

/**
 * Turn off mindsensors ADPA mode.
 * Turn ADPA mode off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define MSADPAOff(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, MS_CMD_ADPA_OFF, _result)

/**
 * Configure DIST-Nx as GP2D12.
 * Configure the mindsensors DIST-Nx sensor as GP2D12. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define DISTNxGP2D12(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2D12, _result)

/**
 * Configure DIST-Nx as GP2D120.
 * Configure the mindsensors DIST-Nx sensor as GP2D120. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define DISTNxGP2D120(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2D120, _result)

/**
 * Configure DIST-Nx as GP2YA02.
 * Configure the mindsensors DIST-Nx sensor as GP2YA02. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define DISTNxGP2YA02(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2YA02, _result)

/**
 * Configure DIST-Nx as GP2YA21.
 * Configure the mindsensors DIST-Nx sensor as GP2YA21. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define DISTNxGP2YA21(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2YA21, _result)

/**
 * Read DIST-Nx distance value.
 * Read the mindsensors DIST-Nx sensor's distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The distance value.
 * \param _result The function call result.
 */
#define ReadDISTNxDistance(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, DIST_REG_DIST, 2, _out, _result)

/**
 * Read DIST-Nx maximum distance value.
 * Read the mindsensors DIST-Nx sensor's maximum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The maximum distance value.
 * \param _result The function call result.
 */
#define ReadDISTNxMaxDistance(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, DIST_REG_DIST_MAX, 2, _out, _result)

/**
 * Read DIST-Nx minimum distance value.
 * Read the mindsensors DIST-Nx sensor's minimum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The minimum distance value.
 * \param _result The function call result.
 */
#define ReadDISTNxMinDistance(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, DIST_REG_DIST_MIN, 2, _out, _result)

/**
 * Read DIST-Nx module type value.
 * Read the mindsensors DIST-Nx sensor's module type value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The module type value.
 * \param _result The function call result.
 */
#define ReadDISTNxModuleType(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, DIST_REG_MODULE_TYPE, 1, _out, _result)

/**
 * Read DIST-Nx num points value.
 * Read the mindsensors DIST-Nx sensor's num points value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The num points value.
 * \param _result The function call result.
 */
#define ReadDISTNxNumPoints(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, DIST_REG_NUM_POINTS, 1, _out, _result)

/**
 * Read DIST-Nx voltage value.
 * Read the mindsensors DIST-Nx sensor's voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The voltage value.
 * \param _result The function call result.
 */
#define ReadDISTNxVoltage(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, DIST_REG_VOLT, 2, _out, _result)

/**
 * Calibrate ACCL-Nx X-axis.
 * Calibrate the mindsensors ACCL-Nx sensor X-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateX(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_X_CAL, _result)

/**
 * Stop calibrating ACCL-Nx X-axis.
 * Stop calibrating the mindsensors ACCL-Nx sensor X-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateXEnd(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_X_CAL_END, _result)

/**
 * Calibrate ACCL-Nx Y-axis.
 * Calibrate the mindsensors ACCL-Nx sensor Y-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateY(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Y_CAL, _result)

/**
 * Stop calibrating ACCL-Nx Y-axis.
 * Stop calibrating the mindsensors ACCL-Nx sensor Y-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateYEnd(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Y_CAL_END, _result)

/**
 * Calibrate ACCL-Nx Z-axis.
 * Calibrate the mindsensors ACCL-Nx sensor Z-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateZ(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Z_CAL, _result)

/**
 * Stop calibrating ACCL-Nx Z-axis.
 * Stop calibrating the mindsensors ACCL-Nx sensor Z-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateZEnd(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Z_CAL_END, _result)

/**
 * Reset ACCL-Nx calibration.
 * Reset the mindsensors ACCL-Nx sensor calibration to factory settings. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxResetCalibration(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_RESET_CAL, _result)

/**
 * Set ACCL-Nx sensitivity.
 * Reset the mindsensors ACCL-Nx sensor calibration to factory settings. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _slevel The sensitivity level. See \ref MSACCLNxSLevel.
 * \param _result The function call result.
 */
#define SetACCLNxSensitivity(_port, _i2caddr, _slevel, _result) __I2CSendCmd(_port, _i2caddr, _slevel, _result)

/**
 * Read ACCL-Nx sensitivity value.
 * Read the mindsensors ACCL-Nx sensitivity value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The sensitivity value.
 * \param _result The function call result.
 */
#define ReadACCLNxSensitivity(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, ACCL_REG_sENS_LVL, 1, _out, _result)

/**
 * Read ACCL-Nx X offset value.
 * Read the mindsensors ACCL-Nx sensor's X offset value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The X offset value.
 * \param _result The function call result.
 */
#define ReadACCLNxXOffset(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, ACCL_REG_X_OFFSET, 2, _out, _result)

/**
 * Read ACCL-Nx X range value.
 * Read the mindsensors ACCL-Nx sensor's X range value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The X range value.
 * \param _result The function call result.
 */
#define ReadACCLNxXRange(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, ACCL_REG_X_RANGE, 2, _out, _result)

/**
 * Read ACCL-Nx Y offset value.
 * Read the mindsensors ACCL-Nx sensor's Y offset value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The Y offset value.
 * \param _result The function call result.
 */
#define ReadACCLNxYOffset(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, ACCL_REG_Y_OFFSET, 2, _out, _result)

/**
 * Read ACCL-Nx Y range value.
 * Read the mindsensors ACCL-Nx sensor's Y range value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The Y range value.
 * \param _result The function call result.
 */
#define ReadACCLNxYRange(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, ACCL_REG_Y_RANGE, 2, _out, _result)

/**
 * Read ACCL-Nx Z offset value.
 * Read the mindsensors ACCL-Nx sensor's Z offset value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The Z offset value.
 * \param _result The function call result.
 */
#define ReadACCLNxZOffset(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, ACCL_REG_Z_OFFSET, 2, _out, _result)

/**
 * Read ACCL-Nx Z range value.
 * Read the mindsensors ACCL-Nx sensor's Z range value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The Z range value.
 * \param _result The function call result.
 */
#define ReadACCLNxZRange(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, ACCL_REG_Z_RANGE, 2, _out, _result)

/**
 * Configure PSP-Nx in digital mode.
 * Configure the mindsensors PSP-Nx device in digital mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define PSPNxDigital(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, PSP_CMD_DIGITAL, _result)

/**
 * Configure PSP-Nx in analog mode.
 * Configure the mindsensors PSP-Nx device in analog mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define PSPNxAnalog(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, PSP_CMD_ANALOG, _result)

/**
 * Read NXTServo servo position value.
 * Read the mindsensors NXTServo device's servo position value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _out The specified servo's position value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTServoPosition(_port, _i2caddr, _servo, _out, _result) __I2CReadValue(_port, _i2caddr, NXTSERVO_REG_S1_POS+(_servo*2), 2, _out, _result)

/**
 * Read NXTServo servo speed value.
 * Read the mindsensors NXTServo device's servo speed value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _out The specified servo's speed value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTServoSpeed(_port, _i2caddr, _servo, _out, _result) __I2CReadValue(_port, _i2caddr, NXTSERVO_REG_S1_SPEED+_servo, 1, _out, _result)

/**
 * Read NXTServo battery voltage value.
 * Read the mindsensors NXTServo device's battery voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTServo battery voltage.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTServoBatteryVoltage(_port, _i2caddr, _out, _result) __I2CReadValue(_port, _i2caddr, NXTSERVO_REG_VOLTAGE, 1, _out, _result)

/**
 * Set NXTServo servo motor speed.
 * Set the speed of a servo motor controlled by the NXTServo device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _speed The servo speed. (0..255)
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTServoSpeed(_port, _i2caddr, _servo, _speed, _result) __I2CWriteToRegister(_port, _i2caddr, NXTSERVO_REG_S1_SPEED+_servo, _speed, _result)

/**
 * Set NXTServo servo motor quick position.
 * Set the quick position of a servo motor controlled by the NXTServo device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _qpos The servo quick position. See \ref NXTServoQPos group.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTServoQuickPosition(_port, _i2caddr, _servo, _qpos, _result) __I2CWriteToRegister(_port, _i2caddr, NXTSERVO_REG_S1_QPOS+_servo, _qpos, _result)

/**
 * Set NXTServo servo motor position.
 * Set the position of a servo motor controlled by the NXTServo device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _pos The servo position. See \ref NXTServoPos group.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTServoPosition(_port, _i2caddr, _servo, _pos, _result) __I2CWriteLEIntToRegister(_port, _i2caddr, _reg, _pos, _result)

/**
 * Reset NXTServo properties.
 * Reset NXTServo device properties to factory defaults.
 * Initial position = 1500.  Initial speed = 0. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoReset(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_RESET, _result)

/**
 * Halt NXTServo macro.
 * Halt a macro executing on the NXTServo device. This command re-initializes
 * the macro environment.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoHaltMacro(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_HALT, _result)

/**
 * Resume NXTServo macro.
 * Resume a macro executing on the NXTServo device. This command resumes
 * executing a macro where it was paused last, using the same environment.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoResumeMacro(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_RESUME, _result)

/**
 * Pause NXTServo macro.
 * Pause a macro executing on the NXTServo device. This command will pause the
 * currently executing macro, and save the environment for subsequent resumption.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoPauseMacro(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_PAUSE, _result)

/**
 * Initialize NXTServo servo properties.
 * Store the initial speed and position properties of the servo motor 'n'.
 * Current speed and position values of the nth servo is read from the
 * servo speed register and servo position register and written to permanent
 * memory.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoInit(_port, _i2caddr, _servo, _result) __NXTServoInit(_port, _i2caddr, _servo, _result)

/**
 * Goto NXTServo macro address.
 * Run the macro found at the specified EEPROM macro address. This command
 * re-initializes the macro environment.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _macro The EEPROM macro address.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoGotoMacroAddress(_port, _i2caddr, _macro, _result) __NXTServoGotoMacroAddress(_port, _i2caddr, _macro, _result)

/**
 * Edit NXTServo macro.
 * Put the NXTServo device into macro edit mode. This operation changes the
 * I2C address of the device to 0x40.  Macros are written to EEPROM addresses
 * between 0x21 and 0xFF. Use \ref NXTServoQuitEdit to return the device to
 * its normal operation mode.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoEditMacro(_port, _i2caddr, _result) __NXTServoEditMacro(_port, _i2caddr, _result)

/**
 * Quit NXTServo macro edit mode.
 * Stop editing NXTServo device macro EEPROM memory. Use \ref NXTServoEditMacro
 * to start editing a macro.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoQuitEdit(_port, _result) __I2CWriteToRegister(_port, MS_ADDR_NXTSERVO_EM, NXTSERVO_EM_REG_CMD, NXTSERVO_EM_CMD_QUIT, _result)

/**
 * Set NXTHID into ASCII data mode.
 * Set the NXTHID device into ASCII data mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTHIDAsciiMode(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTHID_CMD_ASCII, _result)

/**
 * Set NXTHID into direct data mode.
 * Set the NXTHID device into direct data mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTHIDDirectMode(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTHID_CMD_DIRECT, _result)

/**
 * Transmit NXTHID character.
 * Transmit a single character to a computer using the NXTHID device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTHIDTransmit(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTHID_CMD_TRANSMIT, _result)

/**
 * Load NXTHID character.
 * Load a character into the NXTHID device.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _modifier The key modifier.
 * \param _character The character.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTHIDLoadCharacter(_port, _i2caddr, _modifier, _character, _result) \
  __NXTHIDLoadCharacter(_port, _i2caddr, _modifier, _character, _result)

/**
 * Reset NXTPowerMeter counters.
 * Reset the NXTPowerMeter counters back to zero. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTPowerMeterResetCounters(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTPM_CMD_RESET, _result)

/**
 * Read NXTPowerMeter present current.
 * Read the mindsensors NXTPowerMeter device's present current value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter present current.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterPresentCurrent(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_CURRENT, 2, _out, _result)

/**
 * Read NXTPowerMeter present voltage.
 * Read the mindsensors NXTPowerMeter device's present voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter present voltage.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterPresentVoltage(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_VOLTAGE, 2, _out, _result)

/**
 * Read NXTPowerMeter capacity used.
 * Read the mindsensors NXTPowerMeter device's capacity used since the last reset command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter capacity used value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterCapacityUsed(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_CAPACITY, 2, _out, _result)

/**
 * Read NXTPowerMeter present power.
 * Read the mindsensors NXTPowerMeter device's present power value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter present power value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterPresentPower(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_POWER, 2, _out, _result)

/**
 * Read NXTPowerMeter total power consumed.
 * Read the mindsensors NXTPowerMeter device's total power consumed since the last reset command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter total power consumed value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterTotalPowerConsumed(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_POWER, 4, _out, _result)

/**
 * Read NXTPowerMeter maximum current.
 * Read the mindsensors NXTPowerMeter device's maximum current value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter maximum current value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterMaxCurrent(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_MAXCURRENT, 2, _out, _result)

/**
 * Read NXTPowerMeter minimum current.
 * Read the mindsensors NXTPowerMeter device's minimum current value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter minimum current value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterMinCurrent(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_MINCURRENT, 2, _out, _result)

/**
 * Read NXTPowerMeter maximum voltage.
 * Read the mindsensors NXTPowerMeter device's maximum voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter maximum voltage value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterMaxVoltage(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_MAXVOLTAGE, 2, _out, _result)

/**
 * Read NXTPowerMeter minimum voltage.
 * Read the mindsensors NXTPowerMeter device's minimum voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter minimum voltage value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterMinVoltage(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_MINVOLTAGE, 2, _out, _result)

/**
 * Read NXTPowerMeter elapsed time.
 * Read the mindsensors NXTPowerMeter device's elapsed time since the last reset command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter elapsed time value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterElapsedTime(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_TIME, 4, _out, _result)

/**
 * Read NXTPowerMeter error count.
 * Read the mindsensors NXTPowerMeter device's error count value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter error count value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterErrorCount(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTPM_REG_ERRORCOUNT, 2, _out, _result)

/**
 * Powerdown NXTLineLeader device.
 * Put the NXTLineLeader to sleep so that it does not consume power when it is
 * not required. The device wakes up on its own when any I2C communication
 * happens or you can specifically wake it up by using the \ref NXTLineLeaderPowerUp
 * command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderPowerDown(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_POWERDOWN, _result)

/**
 * Powerup NXTLineLeader device.
 * Wake up the NXTLineLeader device so that it can be used. The device can be
 * put to sleep using the \ref NXTLineLeaderPowerDown command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderPowerUp(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_POWERUP, _result)

/**
 * Invert NXTLineLeader colors.
 * Invert color sensing so that the device can detect a white line on a
 * black background.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderInvert(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_INVERT, _result)

/**
 * Reset NXTLineLeader color inversion.
 * Reset the NXTLineLeader color detection back to its default state (black
 * line on a white background).
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderReset(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_RESET, _result)

/**
 * Take NXTLineLeader line snapshot.
 * Takes a snapshot of the line under the sensor and tracks that position in
 * subsequent tracking operations.  This function also will set color inversion
 * if it sees a white line on a black background.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderSnapshot(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_SNAPSHOT, _result)

/**
 * Calibrate NXTLineLeader white color.
 * Store calibration data for the white color.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderCalibrateWhite(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_WHITE, _result)

/**
 * Calibrate NXTLineLeader black color.
 * Store calibration data for the black color.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderCalibrateBlack(_port, _i2caddr, _result) \
  __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_BLACK, _result)

/**
 * Read NXTLineLeader steering.
 * Read the mindsensors NXTLineLeader device's steering value. This is the power
 * returned by the sensor to correct your course.  Add this value to your left
 * motor and subtract it from your right motor.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTLineLeader steering value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTLineLeaderSteering(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTLL_REG_STEERING, 1, _out, _result)

/**
 * Read NXTLineLeader average.
 * Read the mindsensors NXTLineLeader device's average value. The
 * average is a weighted average of the bits set to 1 based on the position.
 * The left most bit has a weight of 10, second bit has a weight of 20, and so
 * forth. When all 8 sensors are over a black surface the average will be 45.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTLineLeader average value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTLineLeaderAverage(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTLL_REG_AVERAGE, 1, _out, _result)

/**
 * Read NXTLineLeader result.
 * Read the mindsensors NXTLineLeader device's result value. This is a single
 * byte showing the 8 sensor's readings. Each bit corresponding to the sensor
 * where the line is seen is set to 1, otherwise it is set to 0.
 * When all 8 sensors are over a black surface the result will be 255 (b11111111).
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTLineLeader result value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTLineLeaderResult(_port, _i2caddr, _out, _result) \
  __I2CReadValue(_port, _i2caddr, NXTLL_REG_RESULT, 1, _out, _result)

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
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new setpoint value (10..80).
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderSetpoint(_port, _i2caddr, _value, _result) \
  __I2CWriteToRegister(_port, _i2caddr, NXTLL_REG_SETPOINT, _value, _result)

/**
 * Write NXTLineLeader Kp value.
 * Write a Kp value to the NXTLineLeader device. This value divided by PID
 * Factor for Kp is the Proportional value for the PID control. Suggested value
 * is 25 with a divisor factor of 32 (which is also a factory default), start
 * with this value, and tune it to meet your needs. Value ranges
 * between 0 and 255.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Kp value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKpValue(_port, _i2caddr, _value, _result) \
  __I2CWriteToRegister(_port, _i2caddr, NXTLL_REG_KP_VALUE, _value, _result)

/**
 * Write NXTLineLeader Ki value.
 * Write a Ki value to the NXTLineLeader device. This value divided by PID
 * Factor for Ki is the Integral value for the PID control. Suggested value
 * is 0 with a divisor factor of 32 (which is also a factory default), start
 * with this value, and tune it to meet your needs. Value ranges
 * between 0 and 255.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Ki value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKiValue(_port, _i2caddr, _value, _result) \
  __I2CWriteToRegister(_port, _i2caddr, NXTLL_REG_KI_VALUE, _value, _result)

/**
 * Write NXTLineLeader Kd value.
 * Write a Kd value to the NXTLineLeader device. This value divided by PID
 * Factor for Kd is the Derivative value for the PID control. Suggested value
 * is 8 with a divisor factor of 32 (which is also a factory default), start
 * with this value, and tune it to meet your needs. Value ranges
 * between 0 and 255.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Kd value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKdValue(_port, _i2caddr, _value, _result) \
  __I2CWriteToRegister(_port, _i2caddr, NXTLL_REG_KD_VALUE, _value, _result)

/**
 * Write NXTLineLeader Kp factor.
 * Write a Kp divisor factor to the NXTLineLeader device. Value ranges between
 * 1 and 255. Change this value if you need more granularities in Kp value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Kp factor.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKpFactor(_port, _i2caddr, _value, _result) \
  __I2CWriteToRegister(_port, _i2caddr, NXTLL_REG_KP_FACTOR, _value, _result)

/**
 * Write NXTLineLeader Ki factor.
 * Write a Ki divisor factor to the NXTLineLeader device. Value ranges between
 * 1 and 255. Change this value if you need more granularities in Ki value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Ki factor.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKiFactor(_port, _i2caddr, _value, _result) \
  __I2CWriteToRegister(_port, _i2caddr, NXTLL_REG_KI_FACTOR, _value, _result)

/**
 * Write NXTLineLeader Kd factor.
 * Write a Kd divisor factor to the NXTLineLeader device. Value ranges between
 * 1 and 255. Change this value if you need more granularities in Kd value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Kd factor.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKdFactor(_port, _i2caddr, _value, _result) \
  __I2CWriteToRegister(_port, _i2caddr, NXTLL_REG_KD_FACTOR, _value, _result)

// nbc_mindsensors_nrlink.h

/** @} */ // end of MindSensorsAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // NBC_MINDSENSORS_H
