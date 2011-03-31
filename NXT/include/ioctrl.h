/** \file ioctrl.h
 * \brief The NXC ioctrl module API
 *
 * ioctrl.h contains the NXC ioctrl module API
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
 * \date 2011-03-17
 * \version 1
 */

#ifndef IOCTRL_H
#define IOCTRL_H

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// IOCTRL MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
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

/**
 * Power down the NXT.
 * This function powers down the NXT.
 * The running program will terminate as a result of this action.
 */
inline void PowerDown() {
  SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_POWERDOWN);
}

/**
 * Put the brick to sleep immediately.
 * This function lets you immediately put the NXT to sleep.
 * The running program will terminate as a result of this action.
 */
inline void SleepNow() {
  SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_POWERDOWN);
}

/**
 * Reboot the NXT in firmware download mode.
 * This function lets you reboot the NXT into SAMBA or firmware download mode.
 * The running program will terminate as a result of this action.
 */
inline void RebootInFirmwareMode() {
  SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_BOOT);
}

/** @} */ // end of IOCtrlModuleFunctions group
/** @} */ // end of IOCtrlModule group
/** @} */ // end of NXTFirmwareModules group

#endif // IOCTRL_H
