/** \file nbc_button.h
 * \brief The NBC button module API
 *
 * nbc_button.h contains the NBC button module API
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

#ifndef NBC_BUTTON_H
#define NBC_BUTTON_H

#include "button_constants.h"
#include "command_constants.h"
#include "nbc_command.h"

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// BUTTON MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup ButtonModule
 * @{
 */
/** @defgroup ButtonModuleFunctions Button module functions
 * Functions for accessing and modifying Button module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

dseg segment
// ReadButton
TReadButton	struct
 Result		sbyte
 Index		byte
 Pressed	byte
 Count		byte
 Reset		byte
TReadButton	ends

  __RBtnArgs TReadButton
  __RBtnMutex mutex
ends

#define __ReadButtonEx(_idx, _reset, _pressed, _count, _result) \
  acquire __RBtnMutex \
  mov __RBtnArgs.Index, _idx \
  mov __RBtnArgs.Reset, _reset \
  syscall ReadButton, __RBtnArgs \
  mov _pressed, __RBtnArgs.Pressed \
  mov _count, __RBtnArgs.Count \
  mov _result, __RBtnArgs.Result \
  release __RBtnMutex

dseg segment
  __btnModuleOffsetMutex mutex
  __btnModuleOffset word
dseg ends

#define __GetButtonPressCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __getButtonModuleValue(ButtonOffsetPressedCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  __getButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonLongPressCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __getButtonModuleValue(ButtonOffsetLongPressCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 1 \
  __getButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonShortReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __getButtonModuleValue(ButtonOffsetShortRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 2 \
  __getButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonLongReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __getButtonModuleValue(ButtonOffsetLongRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 3 \
  __getButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __getButtonModuleValue(ButtonOffsetRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 4 \
  __getButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonState(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __getButtonModuleValue(ButtonOffsetState(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  add __btnModuleOffset, _b, 32 \
  __getButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonPressCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __SetButtonModuleValue(ButtonOffsetPressedCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  __SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonLongPressCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __SetButtonModuleValue(ButtonOffsetLongPressCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 1 \
  __SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonShortReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __SetButtonModuleValue(ButtonOffsetShortRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 2 \
  __SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonLongReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __SetButtonModuleValue(ButtonOffsetLongRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 3 \
  __SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __SetButtonModuleValue(ButtonOffsetRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 4 \
  __SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonState(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  __SetButtonModuleValue(ButtonOffsetState(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  add __btnModuleOffset, _b, 32 \
  __SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#endif
/**
 * Read button information.
 * Read the specified button. Set the pressed and count parameters with the
 * current state of the button. Optionally reset the press count after
 * reading it.
 *
 * \param _idx The button to check. See \ref ButtonNameConstants.
 * \param _reset Whether or not to reset the press counter.
 * \param _pressed The button pressed state.
 * \param _count The button press count.
 * \param _result The function call result.
 */
#define ReadButtonEx(_idx, _reset, _pressed, _count, _result) \
  __ReadButtonEx(_idx, _reset, _pressed, _count, _result)

/**
 * Get button press count.
 * Return the press count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button press count.
 */
#define GetButtonPressCount(_b, _n) __GetButtonPressCount(_b, _n)

/**
 * Get button long press count.
 * Return the long press count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button long press count.
 */
#define GetButtonLongPressCount(_b, _n) __GetButtonLongPressCount(_b, _n)

/**
 * Get button short release count.
 * Return the short release count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button short release count.
 */
#define GetButtonShortReleaseCount(_b, _n) __GetButtonShortReleaseCount(_b, _n)

/**
 * Get button long release count.
 * Return the long release count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button long release count.
 */
#define GetButtonLongReleaseCount(_b, _n) __GetButtonLongReleaseCount(_b, _n)

/**
 * Get button release count.
 * Return the release count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button release count.
*/
#define GetButtonReleaseCount(_b, _n) __GetButtonReleaseCount(_b, _n)

/**
 * Get button state.
 * Return the state of the specified button. See \ref ButtonStateConstants.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button state.
 */
#define GetButtonState(_b, _n) __GetButtonState(_b, _n)

/**
 * Set button press count.
 * Set the press count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new press count value.
 */
#define SetButtonPressCount(_b, _n) __setButtonPressCount(_b, _n)

/**
 * Set button long press count.
 * Set the long press count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new long press count value.
 */
#define SetButtonLongPressCount(_b, _n) __setButtonLongPressCount(_b, _n)

/**
 * Set button short release count.
 * Set the short release count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new short release count value.
 */
#define SetButtonShortReleaseCount(_b, _n) __setButtonShortReleaseCount(_b, _n)

/**
 * Set button long release count.
 * Set the long release count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new long release count value.
 */
#define SetButtonLongReleaseCount(_b, _n) __setButtonLongReleaseCount(_b, _n)

/**
 * Set button release count.
 * Set the release count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new release count value.
 */
#define SetButtonReleaseCount(_b, _n) __setButtonReleaseCount(_b, _n)

/**
 * Set button state.
 * Set the state of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The new button state. See \ref ButtonStateConstants.
*/
#define SetButtonState(_b, _n) __setButtonState(_b, _n)

/** @} */ // end of ButtonModuleFunctions group
/** @} */ // end of ButtonModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_BUTTON_H
