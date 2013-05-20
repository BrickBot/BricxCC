/** \file lowspeed_constants.h
 * \brief NXC Lowspeed module constants
 *
 * lowspeed_constants.h contains NXC Lowspeed module constants
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

#ifndef LOWSPEED_CONSTANTS_H
#define LOWSPEED_CONSTANTS_H

/** @addtogroup LowSpeedModule
 * @{
 */
/** @defgroup LowSpeedModuleConstants LowSpeed module constants
 * Constants that are part of the NXT firmware's LowSpeed module.
 * @{
 */
/** @defgroup LowSpeedStateConstants LSState constants
 * Constants for the low speed module LSState function. These values are
 * combined together using a bitwise OR operation.
 * \sa LSState()
 * @{
 */
#define COM_CHANNEL_NONE_ACTIVE  0x00 /*!< None of the low speed channels are active */
#define COM_CHANNEL_ONE_ACTIVE   0x01 /*!< Low speed channel 1 is active */
#define COM_CHANNEL_TWO_ACTIVE   0x02 /*!< Low speed channel 2 is active */
#define COM_CHANNEL_THREE_ACTIVE 0x04 /*!< Low speed channel 3 is active */
#define COM_CHANNEL_FOUR_ACTIVE  0x08 /*!< Low speed channel 4 is active */
/** @} */  // end of LowSpeedStateConstants group

/** @defgroup LowSpeedChannelStateConstants LSChannelState constants
 * Constants for the low speed module LSChannelState function.
 * \sa LSChannelState()
 * @{
 */
#define LOWSPEED_IDLE          0 /*!< Channel is idle */
#define LOWSPEED_INIT          1 /*!< Channel is being initialized */
#define LOWSPEED_LOAD_BUFFER   2 /*!< Channel buffer is loading */
#define LOWSPEED_COMMUNICATING 3 /*!< Channel is actively communicating */
#define LOWSPEED_ERROR         4 /*!< Channel is in an error state */
#define LOWSPEED_DONE          5 /*!< Channel is done communicating */
/** @} */  // end of LowSpeedChannelStateConstants group

/** @defgroup LowSpeedModeConstants LSMode constants
 * Constants for the low speed module LSMode function.
 * \sa LSMode()
 * @{
 */
#define LOWSPEED_TRANSMITTING   1 /*!< Lowspeed port is in transmitting mode */
#define LOWSPEED_RECEIVING      2 /*!< Lowspeed port is in receiving mode */
#define LOWSPEED_DATA_RECEIVED  3 /*!< Lowspeed port is in data received mode */
/** @} */  // end of LowSpeedModeConstants group

/** @defgroup LowSpeedErrorTypeConstants LSErrorType constants
 * Constants for the low speed module LSErrorType function.
 * \sa LSErrorType()
 * @{
 */
#define LOWSPEED_NO_ERROR     0 /*!< Lowspeed port has no error */
#define LOWSPEED_CH_NOT_READY 1 /*!< Lowspeed port is not ready */
#define LOWSPEED_TX_ERROR     2 /*!< Lowspeed port encountered an error while transmitting data */
#define LOWSPEED_RX_ERROR     3 /*!< Lowspeed port encountered an error while receiving data */
/** @} */  // end of LowSpeedErrorTypeConstants group

/** @defgroup LowSpeedIOMAP Low speed module IOMAP offsets
 * Constant offsets into the low speed module IOMAP structure.
 * @{
 */
#define LowSpeedOffsetInBufBuf(p)       (((p)*19)+0)  /*!< RW - Input buffer data buffer field offset (16 bytes) */
#define LowSpeedOffsetInBufInPtr(p)     (((p)*19)+16) /*!< RW - Input buffer in pointer field offset (1 byte) */
#define LowSpeedOffsetInBufOutPtr(p)    (((p)*19)+17) /*!< RW - Input buffer out pointer field offset (1 byte) */
#define LowSpeedOffsetInBufBytesToRx(p) (((p)*19)+18) /*!< RW - Input buffer bytes to receive field offset (1 byte) */

#define LowSpeedOffsetOutBufBuf(p)       (((p)*19)+76) /*!< RW - Output buffer data buffer field offset (16 bytes) */
#define LowSpeedOffsetOutBufInPtr(p)     (((p)*19)+92) /*!< RW - Output buffer in pointer field offset (1 byte) */
#define LowSpeedOffsetOutBufOutPtr(p)    (((p)*19)+93) /*!< RW - Output buffer out pointer field offset (1 byte) */
#define LowSpeedOffsetOutBufBytesToRx(p) (((p)*19)+94) /*!< RW - Output buffer bytes to receive field offset (1 byte) */

#define LowSpeedOffsetMode(p)            ((p)+152) /*!< R - Lowspeed port mode (1 byte) */
#define LowSpeedOffsetChannelState(p)    ((p)+156) /*!< R - Lowspeed channgel state (1 byte) */
#define LowSpeedOffsetErrorType(p)       ((p)+160) /*!< R - Lowspeed port error type (1 byte) */

#define LowSpeedOffsetState            164 /*!< R - Lowspeed state (all channels) */
#define LowSpeedOffsetSpeed            165 /*!< R - Lowspeed speed (unused) */

#ifdef __ENHANCED_FIRMWARE
#define LowSpeedOffsetNoRestartOnRead  166 /*!< RW - Lowspeed option for no restart on read (all channels) (NBC/NXC) */
#endif
/** @} */  // end of LowSpeedIOMAP group

/** @defgroup LowSpeedNoRestartConstants LSNoRestartOnRead constants
 * Constants for the low speed module LSNoRestartOnRead and
 * SetLSNoRestartOnRead functions. These values are combined with a bitwise
 * OR operation.
 * \sa LSNoRestartOnRead(), SetLSNoRestartOnRead()
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#ifdef __ENHANCED_FIRMWARE
#define LSREAD_RESTART_ALL     0x00 /*!< Restart on read for all channels (default) */
#define LSREAD_NO_RESTART_1    0x01 /*!< No restart on read for channel 1 */
#define LSREAD_NO_RESTART_2    0x02 /*!< No restart on read for channel 2 */
#define LSREAD_NO_RESTART_3    0x04 /*!< No restart on read for channel 3 */
#define LSREAD_NO_RESTART_4    0x08 /*!< No restart on read for channel 4 */
#define LSREAD_RESTART_NONE    0x0F /*!< No restart on read for all channels */
#define LSREAD_NO_RESTART_MASK 0x10 /*!< No restart mask */
#endif
/** @} */  // end of LowSpeedNoRestartConstants group

/** @defgroup GenericI2CConstants Standard I2C constants
 * Constants for use with standard I2C devices.
 * @{
 */
#define I2C_ADDR_DEFAULT  0x02 /*!< Standard NXT I2C device address */
#define I2C_REG_VERSION   0x00 /*!< Standard NXT I2C version register */
#define I2C_REG_VENDOR_ID 0x08 /*!< Standard NXT I2C vendor ID register */
#define I2C_REG_DEVICE_ID 0x10 /*!< Standard NXT I2C device ID register */
#define I2C_REG_CMD       0x41 /*!< Standard NXT I2C device command register */
/** @} */  // end of GenericI2CConstants group

/** @defgroup LEGOI2CAddressConstants LEGO I2C address constants
 * Constants for LEGO I2C device addresses.
 * @{
 */
#define LEGO_ADDR_US         0x02 /*!< The LEGO ultrasonic sensor's I2C address */
#define LEGO_ADDR_TEMP       0x98 /*!< The LEGO temperature sensor's I2C address */
#define LEGO_ADDR_EMETER     0x04 /*!< The LEGO e-meter sensor's I2C address */
/** @} */  // end of LEGOI2CAddressConstants group

/** @defgroup USI2CConstants Ultrasonic sensor constants
 * Constants for use with the ultrasonic sensor.
 * @{
 */
#define US_CMD_OFF           0x00 /*!< Command to turn off the ultrasonic sensor */
#define US_CMD_SINGLESHOT    0x01 /*!< Command to put the ultrasonic sensor into single shot mode */
#define US_CMD_CONTINUOUS    0x02 /*!< Command to put the ultrasonic sensor into continuous polling mode (default) */
#define US_CMD_EVENTCAPTURE  0x03 /*!< Command to put the ultrasonic sensor into event capture mode */
#define US_CMD_WARMRESET     0x04 /*!< Command to warm reset the ultrasonic sensor */

#define US_REG_CM_INTERVAL   0x40 /*!< The register address used to store the CM interval */
#define US_REG_ACTUAL_ZERO   0x50 /*!< The register address used to store the actual zero value */
#define US_REG_SCALE_FACTOR  0x51 /*!< The register address used to store the scale factor value */
#define US_REG_SCALE_DIVISOR 0x52 /*!< The register address used to store the scale divisor value */

#define US_REG_FACTORY_ACTUAL_ZERO   0x11 /*!< The register address containing the factory setting for the actual zero value */
#define US_REG_FACTORY_SCALE_FACTOR  0x12 /*!< The register address containing the factory setting for the scale factor value */
#define US_REG_FACTORY_SCALE_DIVISOR 0x13 /*!< The register address containing the factory setting for the scale divisor value */
#define US_REG_MEASUREMENT_UNITS     0x14 /*!< The register address containing the measurement units (degrees C or F) */
/** @} */  // end of USI2CConstants group

/** @defgroup TempI2CConstants LEGO temperature sensor constants
 * Constants for use with the LEGO temperature sensor.
 * @{
 */
// R1/R0
#define TEMP_RES_9BIT      0x00 /*!< Set the temperature conversion resolution to 9 bit */
#define TEMP_RES_10BIT     0x20 /*!< Set the temperature conversion resolution to 10 bit */
#define TEMP_RES_11BIT     0x40 /*!< Set the temperature conversion resolution to 11 bit */
#define TEMP_RES_12BIT     0x60 /*!< Set the temperature conversion resolution to 12 bit */
// SD (shutdown mode)
#define TEMP_SD_CONTINUOUS 0x00 /*!< Set the sensor mode to continuous */
#define TEMP_SD_SHUTDOWN   0x01 /*!< Set the sensor mode to shutdown. The device will shut down after the current conversion is completed. */
// TM (thermostat mode)
#define TEMP_TM_COMPARATOR 0x00 /*!< Set the thermostat mode to comparator */
#define TEMP_TM_INTERRUPT  0x02 /*!< Set the thermostat mode to interrupt */
// OS (one shot)
#define TEMP_OS_ONESHOT    0x80 /*!< Set the sensor into oneshot mode. When the device is in shutdown mode this will start a single temperature conversion. The device returns to shutdown mode when it completes. */
// F1/F0 (fault queue)
#define TEMP_FQ_1          0x00 /*!< Set fault queue to 1 fault before alert */
#define TEMP_FQ_2          0x08 /*!< Set fault queue to 2 faults before alert */
#define TEMP_FQ_4          0x10 /*!< Set fault queue to 4 faults before alert */
#define TEMP_FQ_6          0x18 /*!< Set fault queue to 6 faults before alert */
// POL (polarity)
#define TEMP_POL_LOW       0x00 /*!< Set polarity of ALERT pin to be active LOW */
#define TEMP_POL_HIGH      0x04 /*!< Set polarity of ALERT pin to be active HIGH */

#define TEMP_REG_TEMP      0x00 /*!< The register where temperature values can be read */
#define TEMP_REG_CONFIG    0x01 /*!< The register for reading/writing sensor configuration values */
#define TEMP_REG_TLOW      0x02 /*!< The register for reading/writing a user-defined low temperature limit */
#define TEMP_REG_THIGH     0x03 /*!< The register for reading/writing a user-defined high temperature limit */
/** @} */  // end of TempI2CConstants group

/** @defgroup EMeterI2CConstants E-Meter sensor constants
 * Constants for use with the e-meter sensor.
 * @{
 */
#define EMETER_REG_VIN    0x0a /*!< The register address for voltage in */
#define EMETER_REG_AIN    0x0c /*!< The register address for amps in */
#define EMETER_REG_VOUT   0x0e /*!< The register address for voltage out */
#define EMETER_REG_AOUT   0x10 /*!< The register address for amps out */
#define EMETER_REG_JOULES 0x12 /*!< The register address for joules */
#define EMETER_REG_WIN    0x14 /*!< The register address for watts in */
#define EMETER_REG_WOUT   0x16 /*!< The register address for watts out */
/** @} */  // end of EMeterI2CConstants group

/** @defgroup I2COptionConstants I2C option constants
 * Constants for the SetI2COptions function. These values are combined with a bitwise
 * OR operation.
 * \sa SetI2COptions()
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define I2C_OPTION_STANDARD  0x00 /*!< Standard I2C speed */
#define I2C_OPTION_NORESTART 0x04 /*!< Use no restart on I2C read */
#define I2C_OPTION_FAST      0x08 /*!< Fast I2C speed */
#endif
/** @} */  // end of I2COptionConstants group


/** @} */  // end of LowSpeedModuleConstants group
/** @} */  // end of LowSpeedModule group

#endif // LOWSPEED_CONSTANTS_H
