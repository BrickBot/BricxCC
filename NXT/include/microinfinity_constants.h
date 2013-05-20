/** \file microinfinity_constants.h
 * \brief The NBC/NXC microinfinity constants
 *
 * microinfinity_constants.h contains the NBC/NXC microinfinity constants
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

#ifndef MICROINFINITY_CONSTANTS_H
#define MICROINFINITY_CONSTANTS_H

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup MicroinfinityAPI
 * @{
 */
/** @defgroup MIConstants Microinfinity device constants
 * Constants that are for use with Microinfinity devices.
 * @{
 */
/** @defgroup XG1300LConstants Microinfinity CruizCore XG1300L sensor constants
 * Constants that are for use with the CruizCore XG1300L sensor.
 * @{
 */

#define MI_ADDR_XG1300L      0x02 /*!< XG1300L I2C address */

#define XG1300L_REG_ANGLE    0x42 /*!< Read accumulated angle (2 bytes little endian) in 1/100s of degrees. */
#define XG1300L_REG_TURNRATE 0x44 /*!< Read rate of turn (2 bytes little endian) in 1/100s of degrees/second. */
#define XG1300L_REG_XAXIS    0x46 /*!< Read x-axis acceleration (2 bytes little endian) in m/s^2 scaled by 100/ACC_RANGE*2, where ACC_RANGE is 2, 4, or 8. */
#define XG1300L_REG_YAXIS    0x48 /*!< Read y-axis acceleration (2 bytes little endian) in m/s^2 scaled by 100/ACC_RANGE*2, where ACC_RANGE is 2, 4, or 8. */
#define XG1300L_REG_ZAXIS    0x4A /*!< Read z-axis acceleration (2 bytes little endian) in m/s^2 scaled by 100/ACC_RANGE*2, where ACC_RANGE is 2, 4, or 8. */

#define XG1300L_REG_RESET    0x60 /*!< Reset the XG1300L device. */
#define XG1300L_REG_2G       0x61 /*!< Select +/- 2G accelerometer range. */
#define XG1300L_REG_4G       0x62 /*!< Select +/- 4G accelerometer range. */
#define XG1300L_REG_8G       0x63 /*!< Select +/- 8G accelerometer range. */

/** @defgroup XG1300LScaleConstants Microinfinity CruizCore XG1300L
 * sensor scale factor constants
 * Constants for setting the scale factor of the CruizCore XG1300L sensor.
 * @{
 */
#define XG1300L_SCALE_2G     0x01 /*!< Select +/- 2G accelerometer range. */
#define XG1300L_SCALE_4G     0x02 /*!< Select +/- 4G accelerometer range. */
#define XG1300L_SCALE_8G     0x04 /*!< Select +/- 8G accelerometer range. */
/** @} */  // end of XG1300LScaleConstants group

/** @} */  // end of XG1300LConstants group
/** @} */  // end of MIConstants group
/** @} */  // end of MicroinfinityAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // MICROINFINITY_CONSTANTS_H
