/** \file button_constants.h
 * \brief NXC Button module constants
 *
 * button_constants.h contains NXC Button module constants
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

#ifndef BUTTON_CONSTANTS_H
#define BUTTON_CONSTANTS_H

/** @addtogroup ButtonModule
 * @{
 */
/** @defgroup ButtonModuleConstants Button module constants
 * Constants that are part of the NXT firmware's Button module.
 * @{
 */
/** @defgroup ButtonNameConstants Button name constants
 * Constants to specify which button to use with button module functions.
 * \sa ButtonPressed(), ButtonState(), ButtonCount(), ReadButtonEx(),
 * SysReadButton(), ReadButtonType
 * @{
 */
#define BTN1 0 /*!< The exit button. */
#define BTN2 1 /*!< The right button. */
#define BTN3 2 /*!< The left button. */
#define BTN4 3 /*!< The enter button. */

#define BTNEXIT   BTN1 /*!< The exit button. */
#define BTNRIGHT  BTN2 /*!< The right button. */
#define BTNLEFT   BTN3 /*!< The left button. */
#define BTNCENTER BTN4 /*!< The enter button. */

#define NO_OF_BTNS 4 /*!< The number of NXT buttons. */
/** @} */  // end of ButtonNameConstants group

/** @defgroup ButtonStateConstants ButtonState constants
 * Constants for use with the ButtonState() function. The _EV values can be
 * combined together using a bitwise OR operation.
 * \sa ButtonState()
 * @{
 */
#define BTNSTATE_PRESSED_EV         0x01 /*!< Button is in the pressed state. */
#define BTNSTATE_SHORT_RELEASED_EV  0x02 /*!< Button is in the short released state. */
#define BTNSTATE_LONG_PRESSED_EV    0x04 /*!< Button is in the long pressed state. */
#define BTNSTATE_LONG_RELEASED_EV   0x08 /*!< Button is in the long released state. */
#define BTNSTATE_PRESSED_STATE      0x80 /*!< A bitmask for the button pressed state */
#define BTNSTATE_NONE               0x10 /*!< The default button state. */
/** @} */  // end of ButtonStateConstants group

/** @defgroup ButtonIOMAP Button module IOMAP offsets
 * Constant offsets into the Button module IOMAP structure.
 * @{
 */
#define ButtonOffsetPressedCnt(b)   (((b)*8)+0) /*!< Offset to the PressedCnt field. This field stores the press count. */
#define ButtonOffsetLongPressCnt(b) (((b)*8)+1) /*!< Offset to the LongPressCnt field. This field stores the long press count.*/
#define ButtonOffsetShortRelCnt(b)  (((b)*8)+2) /*!< Offset to the ShortRelCnt field. This field stores the short release count. */
#define ButtonOffsetLongRelCnt(b)   (((b)*8)+3) /*!< Offset to the LongRelCnt field. This field stores the long release count. */
#define ButtonOffsetRelCnt(b)       (((b)*8)+4) /*!< Offset to the RelCnt field. This field stores the release count. */
#define ButtonOffsetState(b)        ((b)+32)    /*!< Offset to the State field. This field stores the current button state. */
/** @} */  // end of ButtonIOMAP group
/** @} */  // end of ButtonModuleConstants group
/** @} */  // end of ButtonModule group

#endif // BUTTON_CONSTANTS_H
