/** \file lowspeed.h
 * \brief The NXC lowspeed module API
 *
 * lowspeed.h contains the NXC lowspeed module API
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
 * \date 2013-03-03
 * \version 3
 */

#ifndef LOWSPEED_H
#define LOWSPEED_H

#include "lowspeed_constants.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_lowspeed.h" }
#endif

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
 * This function includes a 15 millisecond wait before reading the sensor value
 * due to the ultrasonic sensor getting into a bad state if you try to read
 * its value more frequently than once every 15 milliseconds.
 * \param port The port to which the ultrasonic sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \return The ultrasonic sensor distance value (0..255)
 */
inline byte SensorUS(const byte port);

/**
 * Read ultrasonic sensor value without wait.
 * Return the ultrasonic sensor distance value. Since an
 * ultrasonic sensor is an I2C digital sensor its value cannot be read using
 * the standard Sensor(n) value.
 * The port must be configured as a Lowspeed port before using this function.
 * Since this function does not include a built-in 15 millisecond wait it
 * will be necessary to write your code so that repeated calls do not occur
 * more frequently than once every 15 milliseconds.
 * \param port The port to which the ultrasonic sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \return The ultrasonic sensor distance value (0..255)
 */
inline byte SensorUS0(const byte port);

/**
 * Read ultrasonic sensor value with specified wait.
 * Return the ultrasonic sensor distance value. Since an
 * ultrasonic sensor is an I2C digital sensor its value cannot be read using
 * the standard Sensor(n) value.
 * The port must be configured as a Lowspeed port before using this function.
 * \param port The port to which the ultrasonic sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param wait The number of milliseconds to wait before querying the sensor.
 * You may use a constant or a variable.
 * \return The ultrasonic sensor distance value (0..255)
 */
inline byte SensorUSWait(const byte port, const byte wait);

/**
 * Read multiple ultrasonic sensor values.
 * Return eight ultrasonic sensor distance values.
 * The port must be configured as a Lowspeed port before using this function.
 * This function includes a 15 millisecond wait before reading the sensor value
 * due to the ultrasonic sensor getting into a bad state if you try to read
 * its value more frequently than once every 15 milliseconds.
 * \param port The port to which the ultrasonic sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param values An array of bytes that will contain the 8 distance values
 * read from the ultrasonic sensor.
 * \return A status code indicating whether the read completed successfully or not.
 * See \ref CommLSReadType for possible result values.
 */
inline char ReadSensorUSEx(const byte port, byte & values[]);

/**
 * Read multiple ultrasonic sensor values without wait.
 * Return eight ultrasonic sensor distance values.
 * The port must be configured as a Lowspeed port before using this function.
 * Since this function does not include a built-in 15 millisecond wait it
 * will be necessary to write your code so that repeated calls do not occur
 * more frequently than once every 15 milliseconds.
 * \param port The port to which the ultrasonic sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param values An array of bytes that will contain the 8 distance values
 * read from the ultrasonic sensor.
 * \return A status code indicating whether the read completed successfully or not.
 * See \ref CommLSReadType for possible result values.
 */
inline char ReadSensorUSEx0(const byte port, byte & values[]);

/**
 * Read multiple ultrasonic sensor values with specified wait.
 * Return eight ultrasonic sensor distance values.
 * The port must be configured as a Lowspeed port before using this function.
 * \param port The port to which the ultrasonic sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param values An array of bytes that will contain the 8 distance values
 * read from the ultrasonic sensor.
 * \param wait The number of milliseconds to wait before querying the sensor.
 * You may use a constant or a variable.
 * \return A status code indicating whether the read completed successfully or not.
 * See \ref CommLSReadType for possible result values.
 */
inline char ReadSensorUSExWait(const byte port, byte & values[], const byte wait);

/**
 * Read the LEGO EMeter values.
 * Read all the LEGO EMeter register values.
 * They must all be read at once to ensure data coherency.
 *
 * \param port The port to which the LEGO EMeter sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param vIn Input voltage
 * \param aIn Input current
 * \param vOut Output voltage
 * \param aOut Output current
 * \param joules The number of joules stored in the EMeter
 * \param wIn The number of watts generated
 * \param wOut The number of watts consumed
 * \return A status code indicating whether the read completed successfully or not.
 * See \ref CommLSReadType for possible result values.
 */
inline char ReadSensorEMeter(const byte & port, float &vIn, float &aIn, float &vOut, float &aOut, int &joules, float &wIn, float &wOut);

/**
 * Configure LEGO Temperature sensor options.
 * Set various LEGO Temperature sensor options.
 *
 * \param port The port to which the temperature sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param config The temperature sensor configuration settings.  See
 * \ref TempI2CConstants for configuration constants that can be ORed or added
 * together.
 * \return A status code indicating whether the read completed successfully or not.
 * See \ref CommLSReadType for possible Result values.
 */
inline char ConfigureTemperatureSensor(const byte & port, const byte & config);

/**
 * Read the LEGO Temperature sensor value.
 * Return the temperature sensor value in degrees celcius. Since a
 * temperature sensor is an I2C digital sensor its value cannot be read using
 * the standard Sensor(n) value.
 * The port must be configured as a temperature sensor port before using this
 * function. Use \ref SetSensorTemperature to configure the port.
 * \param port The port to which the temperature sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \return The temperature sensor value in degrees celcius.
 */
inline float SensorTemperature(const byte & port);

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
 * See \ref CommLSCheckStatusType for possible result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref LowspeedRead or \ref LowspeedWrite while LowspeedStatus returns
 * \ref STAT_COMM_PENDING.
 * \sa I2CStatus, I2CRead, I2CWrite, I2CCheckStatus, I2CBytesReady, LowspeedRead,
 * LowspeedWrite, and LowspeedCheckStatus
 */
inline long LowspeedStatus(const byte port, byte & bytesready);

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
 * See \ref CommLSCheckStatusType for possible result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref LowspeedRead or \ref LowspeedWrite while LowspeedCheckStatus returns
 * \ref STAT_COMM_PENDING.
 * \sa I2CCheckStatus, I2CRead, I2CWrite, I2CStatus, I2CBytesReady, LowspeedRead,
 * LowspeedWrite, and LowspeedStatus
 */
inline long LowspeedCheckStatus(const byte port);

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
 * See \ref CommLSWriteType for possible result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa I2CCheckStatus, I2CRead, I2CWrite, I2CStatus, I2CBytesReady, LowspeedRead,
 * LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
inline long LowspeedWrite(const byte port, byte retlen, byte buffer[]);

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
 * See \ref CommLSReadType for possible result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa I2CCheckStatus, I2CRead, I2CWrite, I2CStatus, I2CBytesReady, LowspeedWrite,
 * LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
inline long LowspeedRead(const byte port, byte buflen, byte & buffer[]);

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
 * See \ref CommLSCheckStatusType for possible result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref I2CRead or \ref I2CWrite while this function returns
 * \ref STAT_COMM_PENDING.
 * \sa I2CStatus, I2CRead, I2CWrite, LowspeedStatus, LowspeedRead,
 * LowspeedWrite, and LowspeedCheckStatus
 */
inline long I2CCheckStatus(const byte port);

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
 * See \ref CommLSWriteType for possible result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa I2CCheckStatus, I2CRead, I2CStatus, I2CBytesReady, LowspeedRead, LowspeedWrite,
 * LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
inline long I2CWrite(const byte port, byte retlen, byte buffer[]);

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
 * See \ref CommLSReadType for possible result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa I2CCheckStatus, I2CWrite, I2CStatus, I2CBytesReady, LowspeedRead, LowspeedWrite,
 * LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
inline long I2CRead(const byte port, byte buflen, byte & buffer[]);

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

/**
 * Read I2C register.
 * Read a single byte from an I2C device register.
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param i2caddr The I2C device address.
 * \param reg The I2C device register from which to read a single byte.
 * \param out The single byte read from the I2C device.
 * \return A status code indicating whether the read completed successfully or not.
 * See \ref CommLSReadType for possible result values.
 */
inline char ReadI2CRegister(byte port, byte i2caddr, byte reg, byte & out);

/**
 * Write I2C register.
 * Write a single byte to an I2C device register.
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param i2caddr The I2C device address.
 * \param reg The I2C device register to which to write a single byte.
 * \param val The byte to write to the I2C device.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline char WriteI2CRegister(byte port, byte i2caddr, byte reg, byte val);

/**
 * Read I2C device information.
 * Read standard I2C device information: version, vendor, and device ID. The
 * I2C device uses the specified address.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param i2caddr The I2C device address.
 * \param info A value indicating the type of device information you are requesting.
 * See \ref GenericI2CConstants.
 * \return A string containing the requested device information.
 */
inline string I2CDeviceInfo(byte port, byte i2caddr, byte info);

/**
 * Read I2C device version.
 * Read standard I2C device version. The I2C device uses the specified address.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param i2caddr The I2C device address.
 * \return A string containing the device version.
 */
inline string I2CVersion(byte port, byte i2caddr);

/**
 * Read I2C device vendor.
 * Read standard I2C device vendor. The I2C device uses the specified address.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param i2caddr The I2C device address.
 * \return A string containing the device vendor.
 */
inline string I2CVendorId(byte port, byte i2caddr);

/**
 * Read I2C device identifier.
 * Read standard I2C device identifier. The I2C device uses the specified address.
 *
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param i2caddr The I2C device address.
 * \return A string containing the device identifier.
 */
inline string I2CDeviceId(byte port, byte i2caddr);

/**
 * Send an I2C command.
 * Send a command to an I2C device at the standard command register: \ref I2C_REG_CMD.
 * The I2C device uses the specified address.
 * \param port The port to which the I2C device is attached. See the
 * \ref InPorts group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param i2caddr The I2C device address.
 * \param cmd The command to send to the I2C device.
 * \return A status code indicating whether the write completed successfully or not.
 * See \ref CommLSCheckStatusType for possible result values.
 */
inline long I2CSendCommand(byte port, byte i2caddr, byte cmd);

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

/**
 * Get I2C input buffer in-pointer.
 * This method returns the value of the input pointer of the I2C input
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C input buffer's in-pointer value.
 */
inline byte LSInputBufferInPtr(const byte port);

/**
 * Get I2C input buffer out-pointer.
 * This method returns the value of the output pointer of the I2C input
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C input buffer's out-pointer value.
 */
inline byte LSInputBufferOutPtr(const byte port);

/**
 * Get I2C input buffer bytes to rx.
 * This method returns the value of the bytes to rx field of the I2C input
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C input buffer's bytes to rx value.
 */
inline byte LSInputBufferBytesToRx(const byte port);

/**
 * Get I2C output buffer in-pointer.
 * This method returns the value of the input pointer of the I2C output
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C output buffer's in-pointer value.
 */
inline byte LSOutputBufferInPtr(const byte port);

/**
 * Get I2C output buffer out-pointer.
 * This method returns the value of the output pointer of the I2C output
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C output buffer's out-pointer value.
 */
inline byte LSOutputBufferOutPtr(const byte port);

/**
 * Get I2C output buffer bytes to rx.
 * This method returns the value of the bytes to rx field of the I2C output
 * buffer for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C output buffer's bytes to rx value.
 */
inline byte LSOutputBufferBytesToRx(const byte port);

/**
 * Get I2C mode.
 * This method returns the value of the I2C mode for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C port mode. See \ref LowSpeedModeConstants.
 */
inline byte LSMode(const byte port);

/**
 * Get I2C channel state.
 * This method returns the value of the I2C channel state for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C port channel state. See \ref LowSpeedChannelStateConstants.
 */
inline byte LSChannelState(const byte port);

/**
 * Get I2C error type.
 * This method returns the value of the I2C error type for the specified port.
 * \param port A constant port number (S1..S4). See \ref InPorts.
 * \return The I2C port error type. See \ref LowSpeedErrorTypeConstants.
 */
inline byte LSErrorType(const byte port);

/**
 * Get I2C state.
 * This method returns the value of the I2C state.
 * \return The I2C state. See \ref LowSpeedStateConstants.
 */
inline byte LSState();

/**
 * Get I2C speed.
 * This method returns the value of the I2C speed.
 * \return The I2C speed.
 * \warning This function is unimplemented within the firmware.
 */
inline byte LSSpeed();

#ifdef __ENHANCED_FIRMWARE
/**
 * Get I2C no restart on read setting.
 * This method returns the value of the I2C no restart on read field.
 * \return The I2C no restart on read field. See \ref LowSpeedNoRestartConstants.
 */
inline byte LSNoRestartOnRead();

#endif

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Set I2C options.
 * This method lets you modify I2C options. Use this function to turn on
 * or off the fast I2C mode and also control whether the standard I2C mode
 * performs a restart prior to the read operation.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 *
 * \param port The port whose I2C options you wish to change. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param options The new option value.  See \ref I2COptionConstants.
 */
inline void SetI2COptions(byte port, byte options);
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

/**
 * Read from a Lowspeed sensor.
 * This function lets you read from an I2C (Lowspeed) sensor using the values
 * specified via the \ref CommLSReadType structure.
 *
 * \param args The CommLSReadType structure containing the needed parameters.
 */
inline void SysCommLSRead(CommLSReadType & args);

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

#endif

/** @} */ // end of LowSpeedModuleSystemCallFunctions group

#else

// ultrasonic sensor
#define SensorUS(_p) asm { __ReadSensorUS(_p, __RETVAL__, 15) }
#define ReadSensorUSEx(_port, _values) asm { __ReadSensorUSEx(_port, _values, __RETVAL__, 15) }

#define SensorUS0(_p) asm { __ReadSensorUS(_p, __RETVAL__, 0) }
#define ReadSensorUSEx0(_port, _values) asm { __ReadSensorUSEx(_port, _values, __RETVAL__, 0) }

#define SensorUSWait(_p, _w) asm { __ReadSensorUS(_p, __RETVAL__, _w) }
#define ReadSensorUSExWait(_port, _values, _w) asm { __ReadSensorUSEx(_port, _values, __RETVAL__, _w) }

#define ReadSensorEMeter(_port, _vIn, _aIn, _vOut, _aOut, _joules, _wIn, _wOut) asm { __ReadSensorEMeter(_port, _vIn, _aIn, _vOut, _aOut, _joules, _wIn, _wOut, __RETVAL__) }

#define ConfigureTemperatureSensor(_port, _config) asm { __TempSendCmd(_port, _config, __RETVAL__) }
#if __FIRMWARE_VERSION > 107
#define SensorTemperature(_port) asm { __ReadSensorTemperature(_port, __FLTRETVAL__) }
#else
#define SensorTemperature(_port) asm { __ReadSensorTemperature(_port, __RETVAL__) }
#endif

#define ReadI2CRegister(_port, _i2caddr, _reg, _out) asm { __I2CReadValue(_port, _i2caddr, _reg, 1, _out, __RETVAL__) }
#define WriteI2CRegister(_port, _i2caddr, _reg, _val) asm { __MSWriteToRegister(_port, _i2caddr, _reg, _val, __RETVAL__) }

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

#define I2CDeviceInfo(_port, _i2caddr, _info) asm { ReadI2CDeviceInfo(_port, _i2caddr, _info, __STRRETVAL__) }
#define I2CVersion(_port, _i2caddr) asm { ReadI2CDeviceInfo(_port, _i2caddr, I2C_REG_VERSION, __STRRETVAL__) }
#define I2CVendorId(_port, _i2caddr) asm { ReadI2CDeviceInfo(_port, _i2caddr, I2C_REG_VENDOR_ID, __STRRETVAL__) }
#define I2CDeviceId(_port, _i2caddr) asm { ReadI2CDeviceInfo(_port, _i2caddr, I2C_REG_DEVICE_ID, __STRRETVAL__) }

#define I2CSendCommand(_port, _i2caddr, _cmd) asm { __I2CSendCmd(_port, _i2caddr, _cmd, __RETVAL__) }

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

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define SetI2COptions(_port, _options) asm { __setI2COptions(_port, _options) }
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

#endif // LOWSPEED_H
