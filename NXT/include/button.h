/** \file button.h
 * \brief The NXC button module API
 *
 * button.h contains the NXC button module API
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

#ifndef BUTTON_H
#define BUTTON_H

#include "button_constants.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_button.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// BUTTON MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup NXTFirmwareModules
 * @{
 */

/** @addtogroup ButtonModule
 * @{
 */

/** @defgroup ButtonModuleTypes Button module types
 * Types used by various Button module functions.
 * @{
 */

/**
 * Parameters for the ReadButton system call.
 * This structure is used when calling the \ref SysReadButton system call
 * function.
 * \sa SysReadButton()
 */
struct ReadButtonType {
  char Result;   /*!< The function call result, \ref ERR_INVALID_PORT or \ref NO_ERR. */
  byte Index;    /*!< The requested button index. See the \ref ButtonNameConstants group. */
  bool Pressed;  /*!< The returned button state. */
  byte Count;    /*!< The returned button pressed count. */
  bool Reset;    /*!< If true, the count is reset after reading. */
};
/** @} */ // end of ButtonModuleTypes group

/** @defgroup ButtonModuleFunctions Button module functions
 * Functions for accessing and modifying Button module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Check for button press.
 * This function checks whether the specified button is pressed or not. You may
 * optionally reset the press count.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \param resetCount Whether or not to reset the press counter.
 * \return A boolean value indicating whether the button is pressed or not.
 */
inline bool ButtonPressed(const byte btn, bool resetCount = false);

/**
 * Get button press count.
 * Return the number of times the specified button has been pressed since
 * the last time the button press count was reset. Optionally clear the count
 * after reading it.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \param resetCount Whether or not to reset the press counter.
 * \return The button press count.
 */
inline byte ButtonCount(const byte btn, bool resetCount = false);

/**
 * Read button information.
 * Read the specified button. Set the pressed and count parameters with the
 * current state of the button. Optionally reset the press count after
 * reading it.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \param reset Whether or not to reset the press counter.
 * \param pressed The button pressed state.
 * \param count The button press count.
 * \return The function call result.
 */
inline char ReadButtonEx(const byte btn, bool reset, bool & pressed, unsigned int & count);

/**
 * Get button press count.
 * Return the press count of the specified button.
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button press count.
 */
inline byte ButtonPressCount(const byte btn);

/**
 * Get button long press count.
 * Return the long press count of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button long press count.
 */
inline byte ButtonLongPressCount(const byte btn);

/**
 * Get button short release count.
 * Return the short release count of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button short release count.
 */
inline byte ButtonShortReleaseCount(const byte btn);

/**
 * Get button long release count.
 * Return the long release count of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button long release count.
 */
inline byte ButtonLongReleaseCount(const byte btn);

/**
 * Get button release count.
 * Return the release count of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button release count.
*/
inline byte ButtonReleaseCount(const byte btn);

/**
 * Get button state.
 * Return the state of the specified button. See \ref ButtonStateConstants.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \return The button state.
 */
inline byte ButtonState(const byte btn);

/**
 * Set button long press count.
 * Set the long press count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new long press count value.
 */
inline void SetButtonLongPressCount(const byte btn, const byte n);

/**
 * Set button long release count.
 * Set the long release count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new long release count value.
 */
inline void SetButtonLongReleaseCount(const byte btn, const byte n);

/**
 * Set button press count.
 * Set the press count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new press count value.
 */
inline void SetButtonPressCount(const byte btn, const byte n);

/**
 * Set button release count.
 * Set the release count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new release count value.
 */
inline void SetButtonReleaseCount(const byte btn, const byte n);

/**
 * Set button short release count.
 * Set the short release count of the specified button.
 *
 * \param btn The button number. See \ref ButtonNameConstants.
 * \param n The new short release count value.
 */
inline void SetButtonShortReleaseCount(const byte btn, const byte n);

/**
 * Set button state.
 * Set the state of the specified button.
 *
 * \param btn The button to check. See \ref ButtonNameConstants.
 * \param state The new button state. See \ref ButtonStateConstants.
*/
inline void SetButtonState(const byte btn, const byte state);

/**
 * Read button.
 * This function lets you read button state information via the \ref
 * ReadButtonType structure.
 *
 * \param args The ReadButtonType structure containing the needed parameters.
 */
inline void SysReadButton(ReadButtonType & args);

#else

#define ButtonPressCount(_b) asm { GetButtonPressCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonLongPressCount(_b) asm { GetButtonLongPressCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonShortReleaseCount(_b) asm { GetButtonShortReleaseCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonLongReleaseCount(_b) asm { GetButtonLongReleaseCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonReleaseCount(_b) asm { GetButtonReleaseCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonState(_b) asm { GetButtonState(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SetButtonPressCount(_b, _n) asm { __setButtonPressCount(_b, _n) }
#define SetButtonLongPressCount(_b, _n) asm { __setButtonLongPressCount(_b, _n) }
#define SetButtonShortReleaseCount(_b, _n) asm { __setButtonShortReleaseCount(_b, _n) }
#define SetButtonLongReleaseCount(_b, _n) asm { __setButtonLongReleaseCount(_b, _n) }
#define SetButtonReleaseCount(_b, _n) asm { __setButtonReleaseCount(_b, _n) }
#define SetButtonState(_b, _n) asm { __setButtonState(_b, _n) }

#define SysReadButton(_args) asm { \
  compchktype _args, ReadButtonType \
  syscall ReadButton, _args \
}
#endif
/** @} */ // end of ButtonModuleFunctions group
/** @} */ // end of ButtonModule group
/** @} */ // end of NXTFirmwareModules group

#endif // BUTTON_H
