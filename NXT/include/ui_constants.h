/** \file ui_constants.h
 * \brief NXC UI module constants
 *
 * ui_constants.h contains NXC UI module constants
 *
 * License:
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHIN WARRANTY OF ANY KIND, either express or implied. See the
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

#ifndef UI_CONSTANTS_H
#define UI_CONSTANTS_H

/** @addtogroup UiModule
 * @{
 */
/** @defgroup UiModuleConstants Ui module constants
 * Constants that are part of the NXT firmware's Ui module.
 * @{
 */
/** @defgroup UiFlagsConstants CommandFlags constants
 * Constants for use with the CommandFlags() function.
 * \sa CommandFlags()
 * @{
 */
#define UI_FLAGS_UPDATE                   0x01 /*!< W  - Make changes take effect */
#define UI_FLAGS_DISABLE_LEFT_RIGHT_ENTER 0x02 /*!< RW - Disable left, right and enter button */
#define UI_FLAGS_DISABLE_EXIT             0x04 /*!< RW - Disable exit button */
#define UI_FLAGS_REDRAW_STATUS            0x08 /*!< W  - Redraw entire status line */
#define UI_FLAGS_RESET_SLEEP_TIMER        0x10 /*!< W  - Reset sleep timeout timer */
#define UI_FLAGS_EXECUTE_LMS_FILE         0x20 /*!< W  - Execute LMS file in "LMSfilename" (Try It) */
#define UI_FLAGS_BUSY                     0x40 /*!< R  - UI busy running or datalogging (popup disabled) */
#define UI_FLAGS_ENABLE_STATUS_UPDATE     0x80 /*!< W  - Enable status line to be updated */
/** @} */  // end of UiFlagsConstants group

/** @defgroup UiStateConstants UIState constants
 * Constants for use with the UIState() function.
 * \sa UIState()
 * @{
 */
#define UI_STATE_INIT_DISPLAY       0 /*!< RW - Init display and load font, menu etc. */
#define UI_STATE_INIT_LOW_BATTERY   1 /*!< R  - Low battery voltage at power on */
#define UI_STATE_INIT_INTRO         2 /*!< R  - Display intro */
#define UI_STATE_INIT_WAIT          3 /*!< RW - Wait for initialization end */
#define UI_STATE_INIT_MENU          4 /*!< RW - Init menu system */
#define UI_STATE_NEXT_MENU          5 /*!< RW - Next menu icons ready for drawing */
#define UI_STATE_DRAW_MENU          6 /*!< RW - Execute function and draw menu icons */
#define UI_STATE_TEST_BUTTONS       7 /*!< RW - Wait for buttons to be pressed */
#define UI_STATE_LEFT_PRESSED       8 /*!< RW - Load selected function and next menu id */
#define UI_STATE_RIGHT_PRESSED      9 /*!< RW - Load selected function and next menu id */
#define UI_STATE_ENTER_PRESSED     10 /*!< RW - Load selected function and next menu id */
#define UI_STATE_EXIT_PRESSED      11 /*!< RW - Load selected function and next menu id */
#define UI_STATE_CONNECT_REQUEST   12 /*!< RW - Request for connection accept */
#define UI_STATE_EXECUTE_FILE      13 /*!< RW - Execute file in "LMSfilename" */
#define UI_STATE_EXECUTING_FILE    14 /*!< R  - Executing file in "LMSfilename" */
#define UI_STATE_LOW_BATTERY       15 /*!< R  - Low battery at runtime */
#define UI_STATE_BT_ERROR          16 /*!< R  - BT error */
/** @} */  // end of UiStateConstants group

/** @defgroup UiButtonConstants UIButton constants
 * Constants for use with the UIButton() function.
 * \sa UIButton()
 * @{
 */
#define UI_BUTTON_NONE             0 /*!< R  - Button inserted are executed */
#define UI_BUTTON_LEFT             1 /*!< W  - Insert left arrow button */
#define UI_BUTTON_ENTER            2 /*!< W  - Insert enter button */
#define UI_BUTTON_RIGHT            3 /*!< W  - Insert right arrow button */
#define UI_BUTTON_EXIT             4 /*!< W  - Insert exit button */
/** @} */  // end of UiButtonConstants group

/** @defgroup UiBluetoothStateConstants BluetoothState constants
 * Constants for use with the BluetoothState() function.
 * \sa BluetoothState()
 * @{
 */
#define UI_BT_STATE_VISIBLE        0x01 /*!< RW - BT visible */
#define UI_BT_STATE_CONNECTED      0x02 /*!< RW - BT connected to something */
#define UI_BT_STATE_OFF            0x04 /*!< RW - BT power off */
#define UI_BT_ERROR_ATTENTION      0x08 /*!< W  - BT error attention */
#define UI_BT_CONNECT_REQUEST      0x40 /*!< RW - BT get connect accept in progress */
#define UI_BT_PIN_REQUEST          0x80 /*!< RW - BT get pin code */
/** @} */  // end of UiBluetoothStateConstants group

/** @defgroup UiVMRunStateConstants VM run state constants
 * Constants for use with the VMRunState() function.
 * \sa VMRunState()
 * @{
 */
#define UI_VM_IDLE        0 /*!< VM_IDLE: Just sitting around.  Request to run program will lead to ONE of the VM_RUN* states. */
#define UI_VM_RUN_FREE    1 /*!< VM_RUN_FREE: Attempt to run as many instructions as possible within our timeslice */
#define UI_VM_RUN_SINGLE  2 /*!< VM_RUN_SINGLE: Run exactly one instruction per timeslice */
#define UI_VM_RUN_PAUSE   3 /*!< VM_RUN_PAUSE: Program still "active", but someone has asked us to pause */
#define UI_VM_RESET1      4 /*!< VM_RESET1: Initialize state variables and some I/O devices -- executed when programs end */
#define UI_VM_RESET2      5 /*!< VM_RESET2: Final clean up and return to IDLE */
/** @} */  // end of UiVMRunStateConstants group

/** @defgroup UiIOMAP Ui module IOMAP offsets
 * Constant offsets into the Ui module IOMAP structure.
 * @{
 */
#define UIOffsetPMenu            0 /*!< W  - Pointer to menu file (4 bytes) */
#define UIOffsetBatteryVoltage   4 /*!< R  - Battery voltage in millivolts (2 bytes) */
#define UIOffsetLMSfilename      6 /*!< W  - LMS filename to execute (Try It) (20 bytes) */
#define UIOffsetFlags           26 /*!< RW - Update command flags  (flags enumerated above) (1 byte) */
#define UIOffsetState           27 /*!< RW - UI state              (states enumerated above) (1 byte) */
#define UIOffsetButton          28 /*!< RW - Insert button         (buttons enumerated above) (1 byte) */
#define UIOffsetRunState        29 /*!< W  - VM Run state          (0 = stopped, 1 = running) (1 byte) */
#define UIOffsetBatteryState    30 /*!< W  - Battery state         (0..4 capacity) (1 byte) */
#define UIOffsetBluetoothState  31 /*!< W  - Bluetooth state       (0=on, 1=visible, 2=conn, 3=conn.visible, 4=off, 5=dfu) (1 byte) */
#define UIOffsetUsbState        32 /*!< W  - Usb state             (0=disconnected, 1=connected, 2=working) (1 byte) */
#define UIOffsetSleepTimeout    33 /*!< RW - Sleep timeout time    (min) (1 byte) */
#define UIOffsetSleepTimer      34 /*!< RW - Sleep timer           (min) (1 byte) */
#define UIOffsetRechargeable    35 /*!< R  - Rechargeable battery  (0 = no, 1 = yes) (1 byte) */
#define UIOffsetVolume          36 /*!< RW - Volume used in UI     (0 - 4) (1 byte) */
#define UIOffsetError           37 /*!< W  - Error code (1 byte) */
#define UIOffsetOBPPointer      38 /*!< W  - Actual OBP step       (0 - 4) (1 byte) */
#define UIOffsetForceOff        39 /*!< W  - Force off             (> 0 = off) (1 byte) */
#define UIOffsetAbortFlag       40 /*!< RW - Long Abort            (true == use long press to abort) (1 byte) */
/** @} */  // end of UiIOMAP group

/** @} */  // end of UiModuleConstants group
/** @} */  // end of UiModule group

#endif // UI_CONSTANTS_H
