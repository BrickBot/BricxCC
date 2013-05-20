/** \file codatex_constants.h
 * \brief The NBC/NXC Codatex constants
 *
 * codatex_constants.h contains the NBC/NXC Codatex constants
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

#ifndef CODATEX_CONSTANTS_H
#define CODATEX_CONSTANTS_H

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup CodatexAPI
 * @{
 */
/** @defgroup CodatexConstants Codatex device constants
 * Constants that are for use with Codatex devices.
 * @{
 */
/** @defgroup CTRFIDConstants Codatex RFID sensor constants
 * Constants that are for use with the Codatex RFID sensor device.
 * @{
 */
/** @defgroup CTRFIDModeConstants Codatex RFID sensor modes
 * Constants that are for configuring the Codatex RFID sensor mode.
 * @{
 */
#define RFID_MODE_STOP       0  /*!< Stop the RFID device */
#define RFID_MODE_SINGLE     1  /*!< Configure the RFID device for a single reading */
#define RFID_MODE_CONTINUOUS 2  /*!< Configure the RFID device for continuous reading */
/** @} */  // end of CTRFIDModeConstants group

#define CT_ADDR_RFID     0x04   /*!< RFID I2C address */

#define CT_REG_STATUS    0x32   /*!< RFID status register */
#define CT_REG_MODE      0x41   /*!< RFID mode register */
#define CT_REG_DATA      0x42   /*!< RFID data register */

/** @} */  // end of CTRFIDConstants group
/** @} */  // end of CodatexConstants group
/** @} */  // end of CodatexAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // CODATEX_CONSTANTS_H
