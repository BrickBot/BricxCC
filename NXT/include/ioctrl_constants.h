/** \file ioctrl_constants.h
 * \brief NXC IOCtrl module constants
 *
 * ioctrl_constants.h contains NXC IOCtrl module constants
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

#ifndef IOCTRL_CONSTANTS_H
#define IOCTRL_CONSTANTS_H

/** @addtogroup IOCtrlModule
 * @{
 */
/** @defgroup IOCtrlModuleConstants IOCtrl module constants
 * Constants that are part of the NXT firmware's IOCtrl module.
 * @{
 */
/** @defgroup IOCtrlPO PowerOn constants
 * Use these constants to power down the NXT or boot it into SAMBA
 * (aka firmware download) mode.
 * @{
 */
#define IOCTRL_POWERDOWN  0x5A00 /*!< Power down the NXT */
#define IOCTRL_BOOT       0xA55A /*!< Reboot the NXT into SAMBA mode */
/** @} */  // end of IOCtrlPO group

/** @defgroup IOCtrlIOMAP IOCtrl module IOMAP offsets
 * Constant offsets into the IOCtrl module IOMAP structure.
 * @{
 */
#define IOCtrlOffsetPowerOn 0 /*!< Offset to power on field */
/** @} */  // end of IOCtrlIOMAP group

/** @} */  // end of IOCtrlModuleConstants group
/** @} */  // end of IOCtrlModule group

#endif // IOCTRL_CONSTANTS_H
