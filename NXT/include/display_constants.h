/** \file display_constants.h
 * \brief NXC display module constants
 *
 * display_constants.h contains NXC display module constants
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

#ifndef DISPLAY_CONSTANTS_H
#define DISPLAY_CONSTANTS_H

/** @addtogroup DisplayModuleConstants
 * @{
 */
/** @defgroup LineConstants Line number constants
 * Line numbers for use with DrawText system function.
 * \sa SysDrawText(), TextOut(), NumOut()
 * @{
 */
#define LCD_LINE8  0 /*!< The 8th line of the LCD screen */
#define LCD_LINE7  8 /*!< The 7th line of the LCD screen */
#define LCD_LINE6 16 /*!< The 6th line of the LCD screen */
#define LCD_LINE5 24 /*!< The 5th line of the LCD screen */
#define LCD_LINE4 32 /*!< The 4th line of the LCD screen */
#define LCD_LINE3 40 /*!< The 3rd line of the LCD screen */
#define LCD_LINE2 48 /*!< The 2nd line of the LCD screen */
#define LCD_LINE1 56 /*!< The 1st line of the LCD screen */
/** @} */  // end of LineConstants group
/** @} */  // end of DisplayModuleConstants group

#endif // DISPLAY_CONSTANTS_H
