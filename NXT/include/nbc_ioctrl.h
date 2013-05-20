/** \file nbc_ioctrl.h
 * \brief The NBC ioctrl module API
 *
 * nbc_ioctrl.h contains the NBC ioctrl module API
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

#ifndef NBC_IOCTRL_H
#define NBC_IOCTRL_H

#include "ioctrl_constants.h"
#include "nbc_command.h"

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// IOCTRL MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup IOCtrlModule
 * @{
 */
/** @defgroup IOCtrlModuleFunctions IOCtrl module functions
 * Functions for accessing and modifying IOCtrl module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

#endif

/**
 * Power down the NXT.
 * This function powers down the NXT.
 * The running program will terminate as a result of this action.
 */
#define PowerDown SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_POWERDOWN)

/**
 * Reboot the NXT in firmware download mode.
 * This function lets you reboot the NXT into SAMBA or firmware download mode.
 * The running program will terminate as a result of this action.
 */
#define RebootInFirmwareMode SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_BOOT)

/** @} */ // end of IOCtrlModuleFunctions group
/** @} */ // end of IOCtrlModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_IOCTRL_H
