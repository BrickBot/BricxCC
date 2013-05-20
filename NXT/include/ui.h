/** \file ui.h
 * \brief The NXC ui module API
 *
 * ui.h contains the NXC ui module API
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

#ifndef UI_H
#define UI_H

#include "ui_constants.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_ui.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// UI MODULE //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup UiModule
 * @{
 */
/** @defgroup UiModuleTypes Ui module types
 * Types used by various Ui module functions.
 * @{
 */

#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the SetSleepTimeout system call.
 * This structure is used when calling the \ref SysSetSleepTimeout system call
 * function.
 * \sa SysSetSleepTimeout()
 */
struct SetSleepTimeoutType {
 char Result;                     /*!< The result of the system call function. */
 unsigned long TheSleepTimeoutMS; /*!< The new sleep timeout value in milliseconds. */
};
#endif

/** @} */ // end of UiModuleTypes group
/** @defgroup UiModuleFunctions Ui module functions
 * Functions for accessing and modifying Ui module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Get command flags.
 * Return the command flags.
 * \return Command flags. See \ref UiFlagsConstants
 */
inline byte CommandFlags(void);

/**
 * Get UI module state.
 * Return the user interface state.
 * \return The UI module state. See \ref UiStateConstants.
 */
inline byte UIState(void);

/**
 * Read UI button.
 * Return user interface button information.
 * \return A UI button value.  See \ref UiButtonConstants.
 */
inline byte UIButton(void);

/**
 * Read VM run state.
 * Return VM run state information.
 * \return VM run state. See \ref UiVMRunStateConstants.
 */
inline byte VMRunState(void);

/**
 * Get battery state.
 * Return battery state information (0..4).
 * \return The battery state (0..4)
 */
inline byte BatteryState(void);

/**
 * Get bluetooth state.
 * Return the bluetooth state.
 * \return The bluetooth state. See \ref UiBluetoothStateConstants.
 */
inline byte BluetoothState(void);

/**
 * Get UI module USB state.
 * This method returns the UI module USB state.
 * \return The UI module USB state.  (0=disconnected, 1=connected, 2=working)
 */
inline byte UsbState(void);

/**
 * Read sleep timeout.
 * Return the number of minutes that the NXT will remain on before
 * it automatically shuts down.
 * \return The sleep timeout value
 */
inline byte SleepTimeout(void);

/**
 * Read sleep time.
 * Return the number of minutes that the NXT will remain on before
 * it automatically shuts down.
 * \return The sleep time value
 * \sa SleepTimeout
 */
inline byte SleepTime(void);

/**
 * Read sleep timer.
 * Return the number of minutes left in the countdown to zero from the
 * original SleepTimeout value. When the SleepTimer value reaches zero the
 * NXT will shutdown.
 * \return The sleep timer value
 */
inline byte SleepTimer(void);

/**
 * Read battery type.
 * Return whether the NXT has a rechargeable battery installed or not.
 * \return Whether the battery is rechargeable or not. (false = no, true = yes)
 */
inline bool RechargeableBattery(void);

/**
 * Read volume.
 * Return the user interface volume level. Valid values are from 0 to 4.
 * \return The UI module volume. (0..4)
 */
inline byte Volume(void);

/**
 * Read the on brick program pointer value.
 * Return the current OBP (on-brick program) step
 *
 * \return On brick program pointer (step).
 */
inline byte OnBrickProgramPointer(void);

/**
 * Read abort flag.
 * Return the enhanced NBC/NXC firmware's abort flag.
 *
 * \return The current abort flag value.  See \ref ButtonStateConstants.
 * \warning This function requires the enhanced NBC/NXC firmware.
*/
inline byte AbortFlag(void);

/**
 * Read long abort setting.
 * Return the enhanced NBC/NXC firmware's long abort setting.
 *
 * \sa AbortFlag
 * \return The current abort flag value.  See \ref ButtonStateConstants.
 * \warning This function requires the enhanced NBC/NXC firmware.
*/
inline byte LongAbort(void);

/**
 * Get battery Level.
 * Return the battery level in millivolts.
 * \return The battery level
 */
inline unsigned int BatteryLevel(void);

/**
 * Set command flags.
 * Set the command flags.
 *
 * \param cmdFlags The new command flags. See \ref UiFlagsConstants.
 */
inline void SetCommandFlags(const byte cmdFlags);

/**
 * Set UI button.
 * Set user interface button information.
 *
 * \param btn A user interface button value. See \ref UiButtonConstants.
 */
inline void SetUIButton(byte btn);

/**
 * Set UI state.
 * Set the user interface state.
 *
 * \param state A user interface state value. See \ref UiStateConstants.
 */
inline void SetUIState(byte state);

/**
 * Set VM run state.
 * Set VM run state information.
 *
 * \param vmRunState The desired VM run state. See \ref UiVMRunStateConstants.
 *
 * \warning It is not a good idea to change the VM run state from within a
 * running program unless you know what you are doing.
 */
inline void SetVMRunState(const byte vmRunState);

/**
 * Set battery state.
 * Set battery state information.
 *
 * \param state The desired battery state (0..4).
 */
inline void SetBatteryState(byte state);

/**
 * Set bluetooth state.
 * Set the Bluetooth state.
 *
 * \param state The desired bluetooth state. See \ref UiBluetoothStateConstants.
 */
inline void SetBluetoothState(byte state);

/**
 * Set sleep timeout.
 * Set the NXT sleep timeout value to the specified number of minutes.
 *
 * \param n The minutes to wait before sleeping.
 */
inline void SetSleepTimeout(const byte n);

/**
 * Set sleep time.
 * Set the NXT sleep timeout value to the specified number of minutes.
 *
 * \param n The minutes to wait before sleeping.
 * \sa SetSleepTimeout, SleepTimeout
 */
inline void SetSleepTime(const byte n);

/**
 * Set the sleep timer.
 * Set the system sleep timer to the specified number of minutes.
 *
 * \param n The minutes left on the timer.
 */
inline void SetSleepTimer(const byte n);

/**
 * Set volume.
 * Set the user interface volume level. Valid values are from 0 to 4.
 *
 * \param volume The new volume level.
 */
inline void SetVolume(byte volume);

/**
 * Set on-brick program pointer.
 * Set the current OBP (on-brick program) step.
 *
 * \param obpStep The new on-brick program step.
 */
inline void SetOnBrickProgramPointer(byte obpStep);

/**
 * Turn off NXT.
 * Force the NXT to turn off if the specified value is greater than zero.
 * \param num If greater than zero the NXT will turn off.
*/
inline void ForceOff(byte num);

/**
 * Set abort flag.
 * Set the enhanced NBC/NXC firmware's program abort flag. By default the
 * running program can be interrupted by a short press of the escape button.
 * You can change this to any other button state flag.
 *
 * \param abortFlag The new abort flag value. See \ref ButtonStateConstants
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SetAbortFlag(byte abortFlag);

/**
 * Set long abort.
 * Set the enhanced NBC/NXC firmware's long abort setting (true or false). If
 * set to true then a program has access the escape button. Aborting a program
 * requires a long press of the escape button.
 *
 * \param longAbort If true then require a long press of the escape button
 * to abort a program, otherwise a short press will abort it.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SetLongAbort(bool longAbort);

#if __FIRMWARE_VERSION > 107
/**
 * Set system sleep timeout.
 * This function lets you set the system sleep timeout value given the parameters you
 * pass in via the \ref SetSleepTimeoutType structure.
 *
 * \param args The SetSleepTimeoutType structure containing the required parameters.
 * 
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysSetSleepTimeout(SetSleepTimeoutType & args);
#endif

#else

#define CommandFlags() asm { GetCommandFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define UIState() asm { GetUIState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define UIButton() asm { GetUIButton(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define VMRunState() asm { GetVMRunState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BatteryState() asm { GetBatteryState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BluetoothState() asm { GetBluetoothState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define UsbState() asm { GetUsbState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SleepTimeout() asm { GetSleepTimeout(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SleepTime() SleepTimeout()
#define SleepTimer() asm { GetSleepTimer(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define RechargeableBattery() asm { GetRechargeableBattery(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define Volume() asm { GetVolume(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define OnBrickProgramPointer() asm { GetOnBrickProgramPointer(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define AbortFlag() asm { GetAbortFlag(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LongAbort() AbortFlag()
#define BatteryLevel() asm { GetBatteryLevel(__TMPWORD__) __RETURN__ __TMPWORD__ }

#define SetCommandFlags(_n) asm { __setCommandFlags(_n) }
#define SetUIState(_n) asm { __setUIState(_n) }
#define SetUIButton(_n) asm { __setUIButton(_n) }
#define SetVMRunState(_n) asm { __setVMRunState(_n) }
#define SetBatteryState(_n) asm { __setBatteryState(_n) }
#define SetBluetoothState(_n) asm { __setBluetoothState(_n) }
#define SetUsbState(_n) asm { __setUsbState(_n) }
#define SetSleepTimeout(_n) asm { __setSleepTimeout(_n) }
#define SetSleepTime(_n) SetSleepTimeout(_n)
#define SetSleepTimer(_n) asm { __setSleepTimer(_n) }
#define SetVolume(_n) asm { __setVolume(_n) }
#define SetOnBrickProgramPointer(_n) asm { __setOnBrickProgramPointer(_n) }
#define ForceOff(_n) asm { __forceOff(_n) }
#define SetAbortFlag(_n) asm { __setAbortFlag(_n) }
#define SetLongAbort(_n) do { \
  if (_n) { \
    asm { __setAbortFlag(BTNSTATE_LONG_PRESSED_EV) } \
  } else { \
    asm { __setAbortFlag(BTNSTATE_PRESSED_EV) } \
  } \
} while(false)

#if __FIRMWARE_VERSION > 107
#define SysSetSleepTimeout(_args) asm { \
  compchktype _args, SetSleepTimeoutType \
  syscall SetSleepTimeoutVal, _args \
}
#endif

#endif
/** @} */ // end of UiModuleFunctions group
/** @} */ // end of UiModule group
/** @} */ // end of NXTFirmwareModules group

#endif // UI_H
