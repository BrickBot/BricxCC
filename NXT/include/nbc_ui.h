/** \file nbc_ui.h
 * \brief The NBC ui module API
 *
 * nbc_ui.h contains the NBC ui module API
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

#ifndef NBC_UI_H
#define NBC_UI_H

#include "ui_constants.h"
#include "nbc_command.h"

///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// UI MODULE //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup UiModule
 * @{
 */
/** @defgroup UiModuleFunctions Ui module functions
 * Functions for accessing and modifying Ui module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

#define __setCommandFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetFlags, _n)

#define __setUIState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetState, _n)

#define __setUIButton(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetButton, _n)

#define __setVMRunState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetRunState, _n)

#define __setBatteryState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetBatteryState, _n)

#define __setBluetoothState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetBluetoothState, _n)

#define __setUsbState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetUsbState, _n)

#define __setSleepTimeout(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetSleepTimeout, _n)

#define __setSleepTimer(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetSleepTimer, _n)

#define __setVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetVolume, _n)

#define __setOnBrickProgramPointer(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetOBPPointer, _n)

#define __forceOff(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetForceOff, _n)

#define __setAbortFlag(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetUIModuleValue(UIOffsetAbortFlag, _n)

#define __GetBatteryLevel(_n) \
  compchk EQ, sizeof(_n), 2 \
  __getUIModuleValue(UIOffsetBatteryVoltage, _n)

#define __GetCommandFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetFlags, _n)

#define __GetUIState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetState, _n)

#define __GetUIButton(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetButton, _n)

#define __GetVMRunState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetRunState, _n)

#define __GetBatteryState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetBatteryState, _n)

#define __GetBluetoothState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetBluetoothState, _n)

#define __GetUsbState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetUsbState, _n)

#define __GetSleepTimeout(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetSleepTimeout, _n)

#define __GetSleepTimer(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetSleepTimer, _n)

#define __GetRechargeableBattery(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetRechargeable, _n)

#define __GetVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetVolume, _n)

#define __GetOnBrickProgramPointer(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetOBPPointer, _n)

#define __GetAbortFlag(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getUIModuleValue(UIOffsetAbortFlag, _n)

#endif

/**
 * Set command flags.
 * Set the command flags.
 *
 * \param _n The new command flags. See \ref UiFlagsConstants.
 */
#define SetCommandFlags(_n) __setCommandFlags(_n)

/**
 * Set UI state.
 * Set the user interface state.
 *
 * \param _n A user interface state value. See \ref UiStateConstants.
 */
#define SetUIState(_n) __setUIState(_n)

/**
 * Set UI button.
 * Set user interface button information.
 *
 * \param _n A user interface button value. See \ref UiButtonConstants.
 */
#define SetUIButton(_n) __setUIButton(_n)

/**
 * Set VM run state.
 * Set VM run state information.
 *
 * \param _n The desired VM run state. See \ref UiVMRunStateConstants.
 */
#define SetVMRunState(_n) __setVMRunState(_n)

/**
 * Set battery state.
 * Set battery state information.
 *
 * \param _n The desired battery state (0..4).
 */
#define SetBatteryState(_n) __setBatteryState(_n)

/**
 * Set bluetooth state.
 * Set the Bluetooth state.
 *
 * \param _n The desired bluetooth state. See \ref UiBluetoothStateConstants.
 */
#define SetBluetoothState(_n) __setBluetoothState(_n)

/**
 * Set Usb state.
 * This method sets the value of the Usb state.
 * \param _n The Usb state.
 */
#define SetUsbState(_n) __setUsbState(_n)

/**
 * Set sleep timeout.
 * Set the NXT sleep timeout value to the specified number of minutes.
 *
 * \param _n The minutes to wait before sleeping.
 */
#define SetSleepTimeout(_n) __setSleepTimeout(_n)

/**
 * Set the sleep timer.
 * Set the system sleep timer to the specified number of minutes.
 *
 * \param _n The minutes left on the timer.
 */
#define SetSleepTimer(_n) __setSleepTimer(_n)

/**
 * Set volume.
 * Set the user interface volume level. Valid values are from 0 to 4.
 *
 * \param _n The new volume level.
 */
#define SetVolume(_n) __setVolume(_n)

/**
 * Set on-brick program pointer.
 * Set the current OBP (on-brick program) step.
 *
 * \param _n The new on-brick program step.
 */
#define SetOnBrickProgramPointer(_n) __setOnBrickProgramPointer(_n)

/**
 * Turn off NXT.
 * Force the NXT to turn off if the specified value is greater than zero.
 * \param _n If greater than zero the NXT will turn off.
*/
#define ForceOff(_n) __forceOff(_n)

/**
 * Set abort flag.
 * Set the enhanced NBC/NXC firmware's program abort flag. By default the
 * running program can be interrupted by a short press of the escape button.
 * You can change this to any other button state flag.
 *
 * \param _n The new abort flag value. See \ref ButtonStateConstants
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SetAbortFlag(_n) __setAbortFlag(_n)

/**
 * Get battery Level.
 * Return the battery level in millivolts.
 * \param _n The battery level
 */
#define GetBatteryLevel(_n) __GetBatteryLevel(_n)

/**
 * Get command flags.
 * Return the command flags.
 * \param _n Command flags. See \ref UiFlagsConstants
 */
#define GetCommandFlags(_n) __GetCommandFlags(_n)

/**
 * Get UI module state.
 * Return the user interface state.
 * \param _n The UI module state. See \ref UiStateConstants.
 */
#define GetUIState(_n) __GetUIState(_n)

/**
 * Read UI button.
 * Return user interface button information.
 * \param _n A UI button value.  See \ref UiButtonConstants.
 */
#define GetUIButton(_n) __GetUIButton(_n)

/**
 * Read VM run state.
 * Return VM run state information.
 * \param _n VM run state. See \ref UiVMRunStateConstants.
 */
#define GetVMRunState(_n) __GetVMRunState(_n)

/**
 * Get battery state.
 * Return battery state information (0..4).
 * \param _n The battery state (0..4)
 */
#define GetBatteryState(_n) __GetBatteryState(_n)

/**
 * Get bluetooth state.
 * Return the bluetooth state.
 * \param _n The bluetooth state. See \ref UiBluetoothStateConstants.
 */
#define GetBluetoothState(_n) __GetBluetoothState(_n)

/**
 * Get UI module USB state.
 * This method returns the UI module USB state.
 * \param _n The UI module USB state.  (0=disconnected, 1=connected, 2=working)
 */
#define GetUsbState(_n) __GetUsbState(_n)

/**
 * Read sleep timeout.
 * Return the number of minutes that the NXT will remain on before
 * it automatically shuts down.
 * \param _n The sleep timeout value
 */
#define GetSleepTimeout(_n) __GetSleepTimeout(_n)

/**
 * Read sleep timer.
 * Return the number of minutes left in the countdown to zero from the
 * original SleepTimeout value. When the SleepTimer value reaches zero the
 * NXT will shutdown.
 * \param _n The sleep timer value
 */
#define GetSleepTimer(_n) __GetSleepTimer(_n)

/**
 * Read battery type.
 * Return whether the NXT has a rechargeable battery installed or not.
 * \param _n Whether the battery is rechargeable or not. (false = no, true = yes)
 */
#define GetRechargeableBattery(_n) __GetRechargeableBattery(_n)

/**
 * Read volume.
 * Return the user interface volume level. Valid values are from 0 to 4.
 * \param _n The UI module volume. (0..4)
 */
#define GetVolume(_n) __GetVolume(_n)

/**
 * Read the on brick program pointer value.
 * Return the current OBP (on-brick program) step
 *
 * \param _n On brick program pointer (step).
 */
#define GetOnBrickProgramPointer(_n) __GetOnBrickProgramPointer(_n)

/**
 * Read abort flag.
 * Return the enhanced NBC/NXC firmware's abort flag.
 *
 * \param _n The current abort flag value.  See \ref ButtonStateConstants.
 * \warning This function requires the enhanced NBC/NXC firmware.
*/
#define GetAbortFlag(_n) __GetAbortFlag(_n)

/** @} */ // end of UiModuleFunctions group
/** @} */ // end of UiModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_UI_H
