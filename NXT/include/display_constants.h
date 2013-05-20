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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2013-02-21
 * \version 2
 */

#ifndef DISPLAY_CONSTANTS_H
#define DISPLAY_CONSTANTS_H

/** @addtogroup DisplayModule
 * @{
 */

/** @defgroup DisplayModuleConstants Display module constants
 * Constants that are part of the NXT firmware's Display module.
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


/** @defgroup DisplayExecuteFunctionConstants DisplayExecuteFunction constants
 * Constants that are for use with the DisplayExecuteFunction system call.
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define DISPLAY_ERASE_ALL       0x00     /*!< W - erase entire screen     (CMD,x,x,x,x,x) */
#define DISPLAY_PIXEL           0x01     /*!< W - set pixel (on/off)      (CMD,TRUE/FALSE,X,Y,x,x) */
#define DISPLAY_HORIZONTAL_LINE 0x02     /*!< W - draw horizontal line    (CMD,TRUE/FALSE,X1,Y1,X2,x) */
#define DISPLAY_VERTICAL_LINE   0x03     /*!< W - draw vertical line      (CMD,TRUE/FALSE,X1,Y1,x,Y2) */
#define DISPLAY_CHAR            0x04     /*!< W - draw char (actual font) (CMD,TRUE,X1,Y1,Char,x) */
#define DISPLAY_ERASE_LINE      0x05     /*!< W - erase a single line     (CMD,x,LINE,x,x,x) */
#define DISPLAY_FILL_REGION     0x06     /*!< W - fill screen region      (CMD,TRUE/FALSE,X1,Y1,X2,Y2) */
#define DISPLAY_FRAME           0x07     /*!< W - draw a frame (on/off)   (CMD,TRUE/FALSE,X1,Y1,X2,Y2) */
/** @} */  // end of DisplayExecuteFunctionConstants group

/** @defgroup DisplayDrawOptionConstants Drawing option constants
 * Constants that are for specifying drawing options in several display module API functions.
 * Bits 0 & 1 (values 0,1,2,3) control screen clearing behaviour (Not within RIC files).
 * Bit 2 (value 4) controls the NOT operation, i.e. draw in white or invert text/graphics.
 * Bits 3 & 4 (values 0,8,16,24) control pixel logical combinations (COPY/AND/OR/XOR).
 * Bit 5 (value 32) controls shape filling, or overrides text/graphic bitmaps with set pixels.
 * These may be ORed together for the full instruction
 * (e.g., DRAW_OPT_NORMAL|DRAW_OPT_LOGICAL_XOR)
 * These operations are resolved into the separate, common parameters
 * defined in 'c_display.iom' before any drawing function is called.
 * Note that when drawing a RIC file, the initial 'DrawingOptions' parameter
 * supplied in the drawing instruction controls screen clearing, but nothing else.
 * The 'CopyOptions' parameter from each instruction in the RIC file then controls
 * graphic operations, but the screen-clearing bits are ignored.
 * \sa TextOut(), NumOut(), PointOut(), LineOut(), CircleOut(), RectOut(),
 * PolyOut(), EllipseOut(), FontTextOut(), FontNumOut(), GraphicOut(),
 * GraphicArrayOut()
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define DRAW_OPT_NORMAL                     (0x0000) /*!< Normal drawing */
#define DRAW_OPT_CLEAR_WHOLE_SCREEN         (0x0001) /*!< Clear the entire screen before drawing */
#define DRAW_OPT_CLEAR_EXCEPT_STATUS_SCREEN (0x0002) /*!< Clear the screen except for the status line before drawing */

#define DRAW_OPT_CLEAR_PIXELS               (0x0004) /*!< Clear pixels while drawing (aka draw in white) */
#define DRAW_OPT_CLEAR                      (0x0004) /*!< Clear pixels while drawing (aka draw in white) */
#define DRAW_OPT_INVERT                     (0x0004) /*!< Invert text or graphics */

#define DRAW_OPT_LOGICAL_COPY               (0x0000) /*!< Draw pixels using a logical copy operation */
#define DRAW_OPT_LOGICAL_AND                (0x0008) /*!< Draw pixels using a logical AND operation */
#define DRAW_OPT_LOGICAL_OR                 (0x0010) /*!< Draw pixels using a logical OR operation */
#define DRAW_OPT_LOGICAL_XOR                (0x0018) /*!< Draw pixels using a logical XOR operation */

#define DRAW_OPT_FILL_SHAPE                 (0x0020) /*!< Fill the shape while drawing (rectangle, circle, ellipses, and polygon) */

#define DRAW_OPT_CLEAR_SCREEN_MODES         (0x0003) /*!< Bit mask for the clear screen modes */
#define DRAW_OPT_LOGICAL_OPERATIONS         (0x0018) /*!< Bit mask for the logical drawing operations */

#define DRAW_OPT_POLYGON_POLYLINE           (0x0400) /*!< When drawing polygons, do not close (i.e., draw a polyline instead) */

#define DRAW_OPT_CLEAR_LINE                 (0x0800) /*!< When drawing text, clear the entire line before drawing the text */
#define DRAW_OPT_CLEAR_EOL                  (0x1000) /*!< When drawing text, clear to the end of the line after drawing the text */

/** @defgroup DisplayFontDrawOptionConstants Font drawing option constants
 * These addition drawing option constants are only for use when drawing
 * text and numbers on the LCD using an RIC-based font.
 * \sa FontTextOut(), FontNumOut()
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define DRAW_OPT_FONT_DIRECTIONS            (0x01C0) /*!< Bit mask for the font direction bits */

#define DRAW_OPT_FONT_WRAP       (0x0200) /*!< Option to have text wrap in \ref FontNumOut and \ref FontTextOut calls */

#define DRAW_OPT_FONT_DIR_L2RB   (0x0000) /*!< Font left to right bottom align */
#define DRAW_OPT_FONT_DIR_L2RT   (0x0040) /*!< Font left to right top align */
#define DRAW_OPT_FONT_DIR_R2LB   (0x0080) /*!< Font right to left bottom align */
#define DRAW_OPT_FONT_DIR_R2LT   (0x00C0) /*!< Font right to left top align */
#define DRAW_OPT_FONT_DIR_B2TL   (0x0100) /*!< Font bottom to top left align */
#define DRAW_OPT_FONT_DIR_B2TR   (0x0140) /*!< Font bottom to top right align */
#define DRAW_OPT_FONT_DIR_T2BL   (0x0180) /*!< Font top to bottom left align */
#define DRAW_OPT_FONT_DIR_T2BR   (0x01C0) /*!< Font top to bottom right align */
/** @} */  // end of DisplayFontDrawOptionConstants group
/** @} */  // end of DisplayDrawOptionConstants group

/** @defgroup DisplayFlagsGroup Display flags
 * Constants that are for use with the display flags functions.
 * \sa SetDisplayFlags(), DisplayFlags()
 * @{
 */
#define DISPLAY_ON               0x01     /*!< W  - Display on */
#define DISPLAY_REFRESH          0x02     /*!< W  - Enable refresh */
#define DISPLAY_POPUP            0x08     /*!< W  - Use popup display memory */
#define DISPLAY_REFRESH_DISABLED 0x40     /*!< R  - Refresh disabled */
#define DISPLAY_BUSY             0x80     /*!< R  - Refresh in progress */
/** @} */  // end of DisplayFlagsGroup group

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/** @defgroup DisplayContrastConstants Display contrast constants
 * Constants that are for use with the display contrast API functions.
 * \sa SetDisplayContrast(), DisplayContrast()
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define DISPLAY_CONTRAST_DEFAULT 0x5A /*!< Default display contrast value */
#define DISPLAY_CONTRAST_MAX     0x7F /*!< Maximum display contrast value */
/** @} */  // end of DisplayContrastConstants group
#endif

#define SCREEN_MODE_RESTORE 0x00 /*!< Restore the screen \sa SetScreenMode() */
#define SCREEN_MODE_CLEAR   0x01 /*!< Clear the screen \sa SetScreenMode() */

#define DISPLAY_HEIGHT 64  /*!< The height of the LCD screen in pixels */
#define DISPLAY_WIDTH  100 /*!< The width of the LCD screen in pixels */

#define DISPLAY_MENUICONS_Y       40 /*!< Display menu icons y value */
#define DISPLAY_MENUICONS_X_OFFS  7  /*!< Display menu icons x offset */
#define DISPLAY_MENUICONS_X_DIFF  31 /*!< Display menu icons x delta */

/** @defgroup DisplayTextLineConstants Text line constants
 * Constants that are for use with getting/setting display data.
 * \sa SetDisplayNormal(), GetDisplayNormal(), SetDisplayPopup(), GetDisplayPopup()
 * @{
 */
#define TEXTLINE_1 0 /*!< Text line 1 */
#define TEXTLINE_2 1 /*!< Text line 2 */
#define TEXTLINE_3 2 /*!< Text line 3 */
#define TEXTLINE_4 3 /*!< Text line 4 */
#define TEXTLINE_5 4 /*!< Text line 5 */
#define TEXTLINE_6 5 /*!< Text line 6 */
#define TEXTLINE_7 6 /*!< Text line 7 */
#define TEXTLINE_8 7 /*!< Text line 8 */
#define TEXTLINES  8 /*!< The number of text lines on the LCD */
/** @} */  // end of DisplayTextLineConstants group

// Used in macro "MENUICON_BIT"
#define MENUICON_LEFT   0 /*!< Left icon */
#define MENUICON_CENTER 1 /*!< Center icon */
#define MENUICON_RIGHT  2 /*!< Right icon */
#define MENUICONS       3 /*!< The number of menu icons */

// Used in macro "SPECIAL_BIT"
#define FRAME_SELECT 0   /*!< Center icon select frame */
#define STATUSTEXT   1   /*!< Status text (BT name) */
#define MENUTEXT     2   /*!< Center icon text */
#define STEPLINE     3   /*!< Step collection lines */
#define TOPLINE      4   /*!< Top status underline */
#define SPECIALS     5   /*!< The number of special bit values */

// Used in macro "STATUSICON_BIT"
#define STATUSICON_BLUETOOTH 0 /*!< BlueTooth status icon collection */
#define STATUSICON_USB       1 /*!< USB status icon collection */
#define STATUSICON_VM        2 /*!< VM status icon collection */
#define STATUSICON_BATTERY   3 /*!< Battery status icon collection */
#define STATUSICONS          4 /*!< The number of status icons */

// Used in macro "SCREEN_BIT"
#define SCREEN_BACKGROUND 0 /*!< Entire screen */
#define SCREEN_LARGE      1 /*!< Entire screen except status line */
#define SCREEN_SMALL      2 /*!< Screen between menu icons and status line */
#define SCREENS           3 /*!< The number of screen bits */

// Used in macro "BITMAP_BIT"
#define BITMAP_1 0 /*!< Bitmap 1 */
#define BITMAP_2 1 /*!< Bitmap 2 */
#define BITMAP_3 2 /*!< Bitmap 3 */
#define BITMAP_4 3 /*!< Bitmap 4 */
#define BITMAPS  4 /*!< The number of bitmap bits */

// Used in macro "STEPICON_BIT"
#define STEPICON_1 0 /*!< Left most step icon */
#define STEPICON_2 1 /*!< Step icon #2 */
#define STEPICON_3 2 /*!< Step icon #3 */
#define STEPICON_4 3 /*!< Step icon #4 */
#define STEPICON_5 4 /*!< Right most step icon */
#define STEPICONS  5 /*!< The number of step icons */

/** @defgroup DisplayIOMAP Display module IOMAP offsets
 * Constant offsets into the display module IOMAP structure.
 * @{
 */
#define DisplayOffsetPFunc          0             /*!< Simple draw entry */
#define DisplayOffsetEraseMask      4             /*!< Section erase mask   (executed first) */
#define DisplayOffsetUpdateMask     8             /*!< Section update mask  (executed next) */
#define DisplayOffsetPFont          12            /*!< Pointer to font file */
#define DisplayOffsetPTextLines(p)  (((p)*4)+16)  /*!< Pointer to text strings */
#define DisplayOffsetPStatusText    48            /*!< Pointer to status text string */
#define DisplayOffsetPStatusIcons   52            /*!< Pointer to status icon collection file */
#define DisplayOffsetPScreens(p)    (((p)*4)+56)  /*!< Pointer to screen bitmap file */
#define DisplayOffsetPBitmaps(p)    (((p)*4)+68)  /*!< Pointer to free bitmap files */
#define DisplayOffsetPMenuText      84            /*!< Pointer to menu icon text (NULL == none) */
#define DisplayOffsetPMenuIcons(p)  (((p)*4)+88)  /*!< Pointer to menu icon images (NULL == none) */
#define DisplayOffsetPStepIcons     100           /*!< Pointer to step icon collection file */
#define DisplayOffsetDisplay        104           /*!< Display content copied to physical display every 17 mS */
#define DisplayOffsetStatusIcons(p) ((p)+108)     /*!< Index in status icon collection file (index = 0 -> none) */
#define DisplayOffsetStepIcons(p)   ((p)+112)     /*!< Index in step icon collection file (index = 0 -> none) */
#define DisplayOffsetFlags          117           /*!< Update flags enumerated above */
#define DisplayOffsetTextLinesCenterFlags 118     /*!< Mask to center TextLines */
#define DisplayOffsetNormal(l,w)    (((l)*100)+(w)+119) /*!< Raw display memory for normal screen */
#define DisplayOffsetPopup(l,w)     (((l)*100)+(w)+919) /*!< Raw display memory for popup screen */

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define DisplayOffsetContrast       1719 /*!< Adjust the display contrast with this field (NBC/NXC) */
#endif
/** @} */  // end of DisplayIOMAP group
/** @} */  // end of DisplayModuleConstants group
/** @} */  // end of DisplayModule group

#endif // DISPLAY_CONSTANTS_H
