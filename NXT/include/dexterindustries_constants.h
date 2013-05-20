/** \file dexterindustries_constants.h
 * \brief The NBC/NXC Dexter Industries constants
 *
 * dexterindustries_constants.h contains the NBC/NXC Dexter Industries constants
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

#ifndef DEXTERINDUSTRIES_CONSTANTS_H
#define DEXTERINDUSTRIES_CONSTANTS_H

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup DexterIndustriesAPI
 * @{
 */
/** @defgroup DIConstants Dexter Industries device constants
 * Constants that are for use with Dexter Industries devices.
 * @{
 */
/** @defgroup DIGPSConstants Dexter Industries GPS sensor constants
 * Constants that are for use with the Dexter Industries GPS sensor.
 * @{
 */

#define DI_ADDR_DGPS          0x06 /*!< Dexter Industries DGPS I2C address */

#define DGPS_REG_TIME         0x00 /*!< Read time in UTC (hhmmss). */
#define DGPS_REG_STATUS       0x01 /*!< Read status of the GPS (0 - invalid signal, 1 - valid signal). */
#define DGPS_REG_LATITUDE     0x02 /*!< Read integer latitude.(dddddddd; Positive = North; Negative = South). */
#define DGPS_REG_LONGITUDE    0x04 /*!< Read integer longitude (ddddddddd; Positive = East; Negative = West). */
#define DGPS_REG_VELOCITY     0x06 /*!< Read velocity in cm/s. */
#define DGPS_REG_HEADING      0x07 /*!< Read heading in degrees. */
#define DGPS_REG_DISTANCE     0x08 /*!< Read distance to current waypoint in meters. */
#define DGPS_REG_WAYANGLE     0x09 /*!< Read angle to current waypoint in degrees. */
#define DGPS_REG_LASTANGLE    0x0A /*!< Read angle travelled since last request, resets the request coordinates on the GPS sensor, sends the angle of travel since last reset. */
#define DGPS_REG_SETLATITUDE  0x0B /*!< Set waypoint latitude as a 4 byte integer. */
#define DGPS_REG_SETLONGITUDE 0x0C /*!< Set waypoint longitude as a 4 byte integer. */

/** @} */  // end of DIGPSConstants group

/** @defgroup DIIMUConstants Dexter Industries IMU sensor constants
 * Constants that are for use with the Dexter Industries IMU sensor.
 * @{
 */

#define DI_ADDR_GYRO     0xD2  /*!< Dexter Industries DIMU Gyro I2C address */
#define DI_ADDR_ACCL     0x3A  /*!< Dexter Industries DIMU Accelerometer I2C address */

/** @defgroup DIIMUGyroRegisterConstants Dexter Industries IMU Gyro register constants
 * Constants that define the Dexter Industries IMU Gyro registers.
 * @{
 */

#define DIGYRO_REG_WHOAMI    0x0F  /*!< Gyro device identification register (read only) */
#define DIGYRO_REG_CTRL1     0x20  /*!< Gyro control register 1 */
#define DIGYRO_REG_CTRL2     0x21  /*!< Gyro control register 2 */
#define DIGYRO_REG_CTRL3     0x22  /*!< Gyro control register 3 */
#define DIGYRO_REG_CTRL4     0x23  /*!< Gyro control register 4 */
#define DIGYRO_REG_CTRL5     0x24  /*!< Gyro control register 5 */
#define DIGYRO_REG_REFERENCE 0x25  /*!< Gyro reference register - stores the reference value used for interrupt generation */
#define DIGYRO_REG_OUTTEMP   0x26  /*!< Gyro temperature register (read only) - stores temperature data */
#define DIGYRO_REG_STATUS    0x27  /*!< Gyro status register (read only) */
#define DIGYRO_REG_XLOW      0x28  /*!< Gyro x-axis low byte register (read only) */
#define DIGYRO_REG_XHIGH     0x29  /*!< Gyro x-axis high byte register (read only) */
#define DIGYRO_REG_YLOW      0x2A  /*!< Gyro y-axis low byte register (read only) */
#define DIGYRO_REG_YHIGH     0x2B  /*!< Gyro y-axis high byte register (read only) */
#define DIGYRO_REG_ZLOW      0x2C  /*!< Gyro z-axis low byte register (read only) */
#define DIGYRO_REG_ZHIGH     0x2D  /*!< Gyro z-axis high byte register (read only) */
#define DIGYRO_REG_FIFOCTRL  0x2E  /*!< Gyro FIFO control register */
#define DIGYRO_REG_FIFOSRC   0x2F  /*!< Gyro FIFO source register (read only) */
#define DIGYRO_REG_INT1_CFG  0x30  /*!< Gyro interrupt 1 config register */
#define DIGYRO_REG_INT1_SRC  0x31  /*!< Gyro interrupt 1 source register */
#define DIGYRO_REG_INT1_XHI  0x32  /*!< Gyro interrupt 1 x-axis high threshold register */
#define DIGYRO_REG_INT1_XLO  0x33  /*!< Gyro interrupt 1 x-axis low threshold register */
#define DIGYRO_REG_INT1_YHI  0x34  /*!< Gyro interrupt 1 y-axis high threshold register */
#define DIGYRO_REG_INT1_YLO  0x35  /*!< Gyro interrupt 1 y-axis low threshold register */
#define DIGYRO_REG_INT1_ZHI  0x36  /*!< Gyro interrupt 1 z-axis high threshold register */
#define DIGYRO_REG_INT1_ZLO  0x37  /*!< Gyro interrupt 1 z-axis low threshold register */
#define DIGYRO_REG_INT1_DUR  0x38  /*!< Gyro interrupt 1 duration register */

#define DIGYRO_REG_CTRL1AUTO 0xA0  /*!< Gyro control register 1 - auto increment write */
#define DIGYRO_REG_TEMPAUTO  0xA6  /*!< Gyro temperature register - read burst mode (read only) */
#define DIGYRO_REG_XLOWBURST 0xA8  /*!< Gyro x-axis low byte register - read burst mode (read only) */
#define DIGYRO_REG_YLOWBURST 0xAA  /*!< Gyro y-axis low byte register - read burst mode (read only) */
#define DIGYRO_REG_ZLOWBURST 0xAC  /*!< Gyro y-axis low byte register - read burst mode (read only) */


/** @} */  // end of DIIMUGyroRegisterConstants group

/** @defgroup DIIMUGyroCtrl1Constants Dexter Industries IMU Gyro control register 1 constants
 * Constants that are for use with the Dexter Industries IMU Gyro sensor's control register 1.
 * @{
 */

#define DIGYRO_CTRL1_XENABLE      0x01 /*!< Gyro enable X axis */
#define DIGYRO_CTRL1_YENABLE      0x02 /*!< Gyro enable Y axis */
#define DIGYRO_CTRL1_ZENABLE      0x04 /*!< Gyro enable Z axis */
#define DIGYRO_CTRL1_POWERDOWN    0x00 /*!< Gyro enable power down mode */
#define DIGYRO_CTRL1_NORMAL       0x08 /*!< Gyro disable power down mode */
#define DIGYRO_CTRL1_BANDWIDTH_1  0x00 /*!< Gyro LPF2 cut-off frequency bandwidth level 1 (12.5hz, 12.5hz, 20hz, 30hz) */
#define DIGYRO_CTRL1_BANDWIDTH_2  0x10 /*!< Gyro LPF2 cut-off frequency bandwidth level 2 (12.5hz, 25hz, 50hz, 70hz) */
#define DIGYRO_CTRL1_BANDWIDTH_3  0x20 /*!< Gyro LPF2 cut-off frequency bandwidth level 3 (20hz, 25hz, 50hz, 110hz) */
#define DIGYRO_CTRL1_BANDWIDTH_4  0x30 /*!< Gyro LPF2 cut-off frequency bandwidth level 4 (30hz, 35hz, 50hz, 110hz) */
#define DIGYRO_CTRL1_DATARATE_100 0x00 /*!< Gyro output data rate 100 hz */
#define DIGYRO_CTRL1_DATARATE_200 0x40 /*!< Gyro output data rate 200 hz */
#define DIGYRO_CTRL1_DATARATE_400 0x80 /*!< Gyro output data rate 400 hz */
#define DIGYRO_CTRL1_DATARATE_800 0xC0 /*!< Gyro output data rate 800 hz */

/** @} */  // end of DIIMUGyroCtrl1Constants group

/** @defgroup DIIMUGyroCtrl2Constants Dexter Industries IMU Gyro control register 2 constants
 * Constants that are for use with the Dexter Industries IMU Gyro sensor's control register 2.
 * @{
 */

#define DIGYRO_CTRL2_CUTOFF_FREQ_8   0x00 /*!< Gyro high pass filter cutoff frequency 8 hz */
#define DIGYRO_CTRL2_CUTOFF_FREQ_4   0x01 /*!< Gyro high pass filter cutoff frequency 4 hz */
#define DIGYRO_CTRL2_CUTOFF_FREQ_2   0x02 /*!< Gyro high pass filter cutoff frequency 2 hz */
#define DIGYRO_CTRL2_CUTOFF_FREQ_1   0x03 /*!< Gyro high pass filter cutoff frequency 1 hz */
#define DIGYRO_CTRL2_CUTOFF_FREQ_05  0x04 /*!< Gyro high pass filter cutoff frequency 0.5 hz */
#define DIGYRO_CTRL2_CUTOFF_FREQ_02  0x05 /*!< Gyro high pass filter cutoff frequency 0.2 hz */
#define DIGYRO_CTRL2_CUTOFF_FREQ_01  0x06 /*!< Gyro high pass filter cutoff frequency 0.1 hz */
#define DIGYRO_CTRL2_CUTOFF_FREQ_005 0x07 /*!< Gyro high pass filter cutoff frequency 0.05 hz */
#define DIGYRO_CTRL2_CUTOFF_FREQ_002 0x08 /*!< Gyro high pass filter cutoff frequency 0.02 hz */
#define DIGYRO_CTRL2_CUTOFF_FREQ_001 0x09 /*!< Gyro high pass filter cutoff frequency 0.01 hz */
#define DIGYRO_CTRL2_HPMODE_RESET    0x00 /*!< Gyro high pass filter reset mode */
#define DIGYRO_CTRL2_HPMODE_REFSIG   0x10 /*!< Gyro high pass filter reference signal mode */
#define DIGYRO_CTRL2_HPMODE_NORMAL   0x20 /*!< Gyro high pass filter normal mode */
#define DIGYRO_CTRL2_HPMODE_AUTOINT  0x30 /*!< Gyro high pass filter autoreset on interrupt event mode */

/** @} */  // end of DIIMUGyroCtrl2Constants group

/** @defgroup DIIMUGyroCtrl3Constants Dexter Industries IMU Gyro control register 3 constants
 * Constants that are for use with the Dexter Industries IMU Gyro sensor's control register 3.
 * @{
 */

#define DIGYRO_CTRL3_INT1_ENABLE    0x80 /*!< Gyro interrupt enable on INT1 pin */
#define DIGYRO_CTRL3_INT1_BOOT      0x40 /*!< Gyro boot status available on INT1 */
#define DIGYRO_CTRL3_INT1_LOWACTIVE 0x20 /*!< Gyro interrupt active low on INT1 */
#define DIGYRO_CTRL3_OPENDRAIN      0x10 /*!< Gyro use open drain rather than push-pull */
#define DIGYRO_CTRL3_INT2_DATAREADY 0x08 /*!< Gyro data ready on DRDY/INT2 */
#define DIGYRO_CTRL3_INT2_WATERMARK 0x04 /*!< Gyro FIFO watermark interrupt on DRDY/INT2 */
#define DIGYRO_CTRL3_INT2_OVERRUN   0x02 /*!< Gyro FIFO overrun interrupt on DRDY/INT2 */
#define DIGYRO_CTRL3_INT2_EMPTY     0x01 /*!< Gyro FIFO empty interrupt on DRDY/INT2 */

/** @} */  // end of DIIMUGyroCtrl3Constants group

/** @defgroup DIIMUGyroCtrl4Constants Dexter Industries IMU Gyro control register 4 constants
 * Constants that are for use with the Dexter Industries IMU Gyro sensor's control register 4.
 * @{
 */

#define DIGYRO_CTRL4_BLOCKDATA  0x80 /*!< Gyro block data update - output registers are not updated until MSB and LSB reading */
#define DIGYRO_CTRL4_BIGENDIAN  0x40 /*!< Gyro use big endian - MSB/LSB rather than LSB/MSB in output registers */
#define DIGYRO_CTRL4_SCALE_250  0x00 /*!< Gyro 250 degrees per second scale */
#define DIGYRO_CTRL4_SCALE_500  0x10 /*!< Gyro 500 degrees per second scale */
#define DIGYRO_CTRL4_SCALE_2000 0x30 /*!< Gyro 2000 degrees per second scale */

/** @} */  // end of DIIMUGyroCtrl4Constants group

/** @defgroup DIIMUGyroCtrl5Constants Dexter Industries IMU Gyro control register 5 constants
 * Constants that are for use with the Dexter Industries IMU Gyro sensor's control register 5.
 * @{
 */

#define DIGYRO_CTRL5_REBOOTMEM  0x80 /*!< Gyro reboot memory content */
#define DIGYRO_CTRL5_FIFOENABLE 0x40 /*!< Gyro enable FIFO */
#define DIGYRO_CTRL5_HPENABLE   0x10 /*!< Gyro enable high pass filter */
#define DIGYRO_CTRL5_OUT_SEL_1  0x00 /*!< Gyro data in data registers and FIFO are not high-pass filtered */
#define DIGYRO_CTRL5_OUT_SEL_2  0x01 /*!< Gyro data in data registers and FIFO are high-pass filtered */
#define DIGYRO_CTRL5_OUT_SEL_3  0x02 /*!< Gyro data in data registers and FIFO are low-pass filtered by LPF2 */
#define DIGYRO_CTRL5_INT1_SEL_1 0x00 /*!< Gyro non-high-pass-filtered data are used for interrupt generation */
#define DIGYRO_CTRL5_INT1_SEL_2 0x04 /*!< Gyro high-pass-filtered data are used for interrupt generation */
#define DIGYRO_CTRL5_INT1_SEL_3 0x08 /*!< Gyro low-pass-filtered data are used for interrupt generation */

/** @} */  // end of DIIMUGyroCtrl5Constants group

/** @defgroup DIIMUGyroFifoCtrlConstants Dexter Industries IMU Gyro FIFO control register onstants
 * Constants that are for use with the Dexter Industries IMU Gyro sensor's FIFO control register.
 * @{
 */

#define DIGYRO_FIFOCTRL_BYPASS        0x00 /*!< Gyro FIFO bypass mode */
#define DIGYRO_FIFOCTRL_FIFO          0x20 /*!< Gyro FIFO mode */
#define DIGYRO_FIFOCTRL_STREAM        0x40 /*!< Gyro FIFO stream mode */
#define DIGYRO_FIFOCTRL_STREAM2FIFO   0x60 /*!< Gyro FIFO stream-to-FIFO mode */
#define DIGYRO_FIFOCTRL_BYPASS2STREAM 0x80 /*!< Gyro FIFO bypass-to-stream mode */

#define DIGYRO_FIFOCTRL_WATERMARK_MASK 0x1F /*!< Gyro FIFO threshold. Watermark level setting mask (values from 0x00 to 0x1F) */

/** @} */  // end of DIIMUGyroFifoCtrlConstants group

/** @defgroup DIIMUGyroStatusConstants Dexter Industries IMU Gyro status register constants
 * Constants that are for use with the Dexter Industries IMU Gyro sensor's status register.
 * @{
 */

#define DIGYRO_STATUS_XDATA   0x01 /*!< Gyro X-axis new data available */
#define DIGYRO_STATUS_YDATA   0x02 /*!< Gyro Y-axis new data available */
#define DIGYRO_STATUS_ZDATA   0x04 /*!< Gyro Z-axis new data available */
#define DIGYRO_STATUS_XYZDATA 0x08 /*!< Gyro X, Y, or Z-axis new data available - a new set of data is available */
#define DIGYRO_STATUS_XOVER   0x10 /*!< Gyro X-axis data overrun - new data for the X-axis has overwritten the previous one */
#define DIGYRO_STATUS_YOVER   0x20 /*!< Gyro Y-axis data overrun - new data for the Y-axis has overwritten the previous one */
#define DIGYRO_STATUS_ZOVER   0x40 /*!< Gyro Z-axis data overrun - new data for the Z-axis has overwritten the previous one */
#define DIGYRO_STATUS_XYZOVER 0x80 /*!< Gyro X, Y, or Z-axis data overrun - new data has overwritten the previous one before it was read */

/** @} */  // end of DIIMUGyroStatusConstants group

/** @defgroup DIIMUAcclRegisterConstants Dexter Industries IMU Accelerometer register constants
 * Constants that define the Dexter Industries IMU Accelerometer registers.
 * @{
 */

#define DIACCL_REG_XLOW       0x00  /*!< Accelerometer x-axis low byte register (read only) */
#define DIACCL_REG_XHIGH      0x01  /*!< Accelerometer x-axis high byte register (read only) */
#define DIACCL_REG_YLOW       0x02  /*!< Accelerometer y-axis low byte register (read only) */
#define DIACCL_REG_YHIGH      0x03  /*!< Accelerometer y-axis high byte register (read only) */
#define DIACCL_REG_ZLOW       0x04  /*!< Accelerometer z-axis low byte register (read only) */
#define DIACCL_REG_ZHIGH      0x05  /*!< Accelerometer z-axis high byte register (read only) */
#define DIACCL_REG_X8         0x06  /*!< Accelerometer x-axis 8-bit register (read only) */
#define DIACCL_REG_Y8         0x07  /*!< Accelerometer x-axis 8-bit register (read only) */
#define DIACCL_REG_Z8         0x08  /*!< Accelerometer x-axis 8-bit register (read only) */
#define DIACCL_REG_STATUS     0x09  /*!< Accelerometer status register (read only) */
#define DIACCL_REG_DETECTSRC  0x0A  /*!< Accelerometer detection source register (read only) */
#define DIACCL_REG_OUTTEMP    0x0B  /*!< Accelerometer temperature output register (read only) */
#define DIACCL_REG_I2CADDR    0x0D  /*!< Accelerometer I2C address register (read only) */
#define DIACCL_REG_USERINFO   0x0E  /*!< Accelerometer user information register (read only) */
#define DIACCL_REG_WHOAMI     0x0F  /*!< Accelerometer device identification register (read only) */
#define DIACCL_REG_XLOWDRIFT  0x10  /*!< Accelerometer x-axis offset drift low byte register (read/write) */
#define DIACCL_REG_XHIGHDRIFT 0x11  /*!< Accelerometer x-axis offset drift high byte register (read/write) */
#define DIACCL_REG_YLOWDRIFT  0x12  /*!< Accelerometer y-axis offset drift low byte register (read/write) */
#define DIACCL_REG_YHIGHDRIFT 0x13  /*!< Accelerometer y-axis offset drift high byte register (read/write) */
#define DIACCL_REG_ZLOWDRIFT  0x14  /*!< Accelerometer z-axis offset drift low byte register (read/write) */
#define DIACCL_REG_ZHIGHDRIFT 0x15  /*!< Accelerometer z-axis offset drift high byte register (read/write) */
#define DIACCL_REG_MODECTRL   0x16  /*!< Accelerometer mode control register (read/write) */
#define DIACCL_REG_INTLATCH   0x17  /*!< Accelerometer interrupt latch reset register (read/write) */
#define DIACCL_REG_CTRL1      0x18  /*!< Accelerometer control register 1 (read/write) */
#define DIACCL_REG_CTRL2      0x19  /*!< Accelerometer control register 1 (read/write) */
#define DIACCL_REG_LVLDETTHR  0x1A  /*!< Accelerometer level detection threshold limit value register (read/write) */
#define DIACCL_REG_PLSDETTHR  0x1B  /*!< Accelerometer pulse detection threshold limit value register (read/write) */
#define DIACCL_REG_PLSDURVAL  0x1C  /*!< Accelerometer pulse duration value register (read/write) */
#define DIACCL_REG_LATENCYTM  0x1D  /*!< Accelerometer latency time value register (read/write) */
#define DIACCL_REG_TIMEWINDOW 0x1E  /*!< Accelerometer time window for 2nd pulse value register (read/write) */

/** @} */  // end of DIIMUAcclRegisterConstants group

/** @defgroup DIIMUAccelStatusConstants Dexter Industries IMU Accelerometer status register constants
 * Constants that are for use with the Dexter Industries IMU Accelerometer sensor's status register.
 * @{
 */

#define DIACCL_STATUS_DATAREADY 0x01  /*!< Accelerometer data is ready */
#define DIACCL_STATUS_DATAOVER  0x02  /*!< Accelerometer data is overwritten */
#define DIACCL_STATUS_PARITYERR 0x04  /*!< Accelerometer parity error is detected in trim data */

/** @} */  // end of DIIMUGyroStatusConstants group

/** @defgroup DIIMUAccelModeConstants Dexter Industries IMU Accelerometer mode control register constants
 * Constants that are for use with the Dexter Industries IMU Accelerometer sensor's mode control register.
 * @{
 */

#define DIACCL_MODE_STANDBY   0x00  /*!< Accelerometer standby mode */
#define DIACCL_MODE_MEASURE   0x01  /*!< Accelerometer measurement mode */
#define DIACCL_MODE_LVLDETECT 0x02  /*!< Accelerometer level detect mode */
#define DIACCL_MODE_PLSDETECT 0x03  /*!< Accelerometer pulse detect mode */
#define DIACCL_MODE_GLVL8     0x00  /*!< Accelerometer 8G measurement range */
#define DIACCL_MODE_GLVL2     0x04  /*!< Accelerometer 2G measurement range */
#define DIACCL_MODE_GLVL4     0x08  /*!< Accelerometer 4G measurement range */

/** @} */  // end of DIIMUAccelModeConstants group

/** @defgroup DIIMUAccelInterruptLatchConstants Dexter Industries IMU Accelerometer interrupt latch reset register constants
 * Constants that are for use with the Dexter Industries IMU Accelerometer sensor's interrupt latch reset register.
 * @{
 */

#define DIACCL_INTERRUPT_LATCH_CLEAR1 0x01  /*!< Accelerometer clear interrupt 1 */
#define DIACCL_INTERRUPT_LATCH_CLEAR2 0x02  /*!< Accelerometer clear interrupt 2 */

/** @} */  // end of DIIMUAccelInterruptLatchConstants group

/** @defgroup DIIMUAccelCtrl1Constants Dexter Industries IMU Accelerometer control register 1 constants
 * Constants that are for use with the Dexter Industries IMU Accelerometer sensor's control register 1.
 * @{
 */

#define DIACCL_CTRL1_INT2TOINT1 0x01  /*!< Accelerometer INT2 pin is routed to INT1 bit in Detection Source Register ($0A) and INT1 pin is routed to INT2 bit in Detection Source Register ($0A) */
#define DIACCL_CTRL1_LEVELPULSE 0x00  /*!< Accelerometer INT1 register is detecting Level while INT2 is detecting pulse */
#define DIACCL_CTRL1_PULSELEVEL 0x02  /*!< Accelerometer INT1 Register is detecting Pulse while INT2 is detecting Level */
#define DIACCL_CTRL1_PULSEPULSE 0x04  /*!< Accelerometer INT1 Register is detecting a Single Pulse and INT2 is detecting Single Pulse (if 2nd Time Window = 0) or if there is a latency time window and second time window > 0 then INT2 will detect the double pulse only. */
#define DIACCL_CTRL1_NO_XDETECT 0x08  /*!< Accelerometer disable x-axis detection. */
#define DIACCL_CTRL1_NO_YDETECT 0x10  /*!< Accelerometer disable y-axis detection. */
#define DIACCL_CTRL1_NO_ZDETECT 0x20  /*!< Accelerometer disable z-axis detection. */
#define DIACCL_CTRL1_THRESH_INT 0x40  /*!< Accelerometer threshold value can be an integer. */
#define DIACCL_CTRL1_FILT_BW125 0x80  /*!< Accelerometer digital filter band width is 125 Hz. */

/** @} */  // end of DIIMUAccelCtrl1Constants group

/** @defgroup DIIMUAccelCtrl2Constants Dexter Industries IMU Accelerometer control register 2 constants
 * Constants that are for use with the Dexter Industries IMU Accelerometer sensor's control register 2.
 * @{
 */

#define DIACCL_CTRL2_LVLPOL_NEGAND 0x01  /*!< Accelerometer level detection polarity is negative and detecting condition is AND all 3 axes */
#define DIACCL_CTRL2_DETPOL_NEGAND 0x02  /*!< Accelerometer pulse detection polarity is negative and detecting condition is AND all 3 axes */
#define DIACCL_CTRL2_DRIVE_STRONG  0x04  /*!< Accelerometer strong drive strength on SDA/SDO pin */

/** @} */  // end of DIIMUAccelCtrl2Constants group

/** @} */  // end of DIIMUConstants group

/** @} */  // end of DIConstants group
/** @} */  // end of DexterIndustriesAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // DEXTERINDUSTRIES_CONSTANTS_H
