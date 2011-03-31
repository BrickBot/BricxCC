/** \file display.h
 * \brief The NXC display module API
 *
 * display.h contains the NXC display module API
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

#ifndef DISPLAY_H
#define DISPLAY_H

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// DISPLAY MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup DisplayModule
 * @{
 */
/** @defgroup DisplayModuleTypes Display module types
 * Types used by various display module functions.
 * @{
 */
/**
 * A point on the NXT LCD screen.
 * This structure is by other system call structures to specify an X, Y
 * LCD screen coordinate.
 * \sa DrawTextType, DrawPointType, DrawLineType, DrawCircleType, DrawRectType,
 * DrawGraphicType, DrawGraphicArrayType, DrawPolygonType, DrawEllipseType,
 * DrawFontType
 */
struct LocationType {
  int X;  /*!< The X coordinate. Valid range is from 0 to 99 inclusive.  */
  int Y;  /*!< The Y coordinate. Valid range is from 0 to 63 inclusive.
               For text drawing this value must be a multiple of 8. */
};

/**
 * Width and height dimensions for the DrawRect system call.
 * This structure is by the \ref DrawRectType to specify a width and
 * height for a rectangle.
 * \sa DrawRectType
 */
struct SizeType {
  int Width;  /*!< The rectangle width. */
  int Height; /*!< The rectangle height. */
};

/**
 * Parameters for the DrawText system call.
 * This structure is used when calling the \ref SysDrawText system call function.
 * It lets you specify the text to draw, the LCD line and horizontal position using the
 * \ref LocationType structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawText()
 */
struct DrawTextType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The location in X, LCD line number coordinates. */
  string Text;             /*!< The text to draw on the LCD. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawPoint system call.
 * This structure is used when calling the \ref SysDrawPoint system call
 * function.
 * It lets you specify the pixel to draw using the
 * \ref LocationType structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawPoint()
 */
struct DrawPointType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The point location on screen. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawLine system call.
 * This structure is used when calling the \ref SysDrawLine system call
 * function.
 * It lets you specify the end points of the line to draw using two
 * \ref LocationType structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawLine()
 */
struct DrawLineType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType StartLoc;   /*!< The location of the starting point. */
  LocationType EndLoc;     /*!< The location of the ending point. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawCircle system call.
 * This structure is used when calling the \ref SysDrawCircle system call
 * function.
 * It lets you specify the center of the circle to draw using the
 * \ref LocationType structure member, the radius, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawCircle()
 */
struct DrawCircleType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Center;     /*!< The location of the circle center. */
  byte Size;               /*!< The circle radius. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawRect system call.
 * This structure is used when calling the \ref SysDrawRect system call
 * function.
 * It lets you specify the corner of the rectangle using the \ref LocationType structure member,
 * the width and height of the rectangle using the \ref SizeType structure member,
 * as well as drawing options defined in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawRect()
 */
struct DrawRectType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The top left corner location. */
  SizeType Size;           /*!< The width and height of the rectangle. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawGraphic system call.
 * This structure is used when calling the \ref SysDrawGraphic system call
 * function.
 * It lets you specify the screen location at which to draw the image using the
 * \ref LocationType structure member, the filename of the graphic image, the
 * image parameters (if needed), as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawGraphic()
 */
struct DrawGraphicType {
  char Result;             /*!< The function call result. Possible values include
                             \ref LoaderErrors, \ref ERR_FILE, and \ref NO_ERR. */
  LocationType Location;   /*!< The location on screen. */
  string Filename;         /*!< The RIC file name. */
  long Variables[];         /*!< The variables passed as RIC arguments. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the SetScreenMode system call.
 * This structure is used when calling the \ref SysSetScreenMode system call
 * function.
 * \sa SysSetScreenMode()
 */
struct SetScreenModeType {
  char Result;                /*!< The function call result, always \ref NO_ERR. */
  unsigned long ScreenMode;   /*!< The requested screen mode.

                                The standard NXT firmware only supports
                                setting the ScreenMode to \ref SCREEN_MODE_RESTORE.

                                If you install the NBC/NXC enhanced standard
                                NXT firmware this system function also
                                supports setting the ScreenMode to
                                \ref SCREEN_MODE_CLEAR. */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the DisplayExecuteFunction system call.
 * This structure is used when calling the \ref SysDisplayExecuteFunction
 * system call function.
 *
 * The fields usage depends on the requested command and are documented in the
 * table below. If a field member is shown as 'x' it is ignored by the
 * specified display command.
 *
 * <table>
 * <tr><td>Cmd</td>
 *     <td>Meaning</td><td>Expected parameters</td></tr>
 * <tr><td>DISPLAY_ERASE_ALL</td>
 *     <td>erase entire screen</td><td>()</td></tr>
 * <tr><td>DISPLAY_PIXEL</td>
 *     <td>set pixel (on/off)</td><td>(true/false,X1,Y1,x,x)</td></tr>
 * <tr><td>DISPLAY_HORIZONTAL_LINE</td>
 *     <td>draw horizontal line</td><td>(true/false,X1,Y1,X2,x)</td></tr>
 * <tr><td>DISPLAY_VERTICAL_LINE</td>
 *     <td>draw vertical line</td><td>(true/false,X1,Y1,x,Y2)</td></tr>
 * <tr><td>DISPLAY_CHAR</td>
 *     <td>draw char (actual font)</td><td>(true/false,X1,Y1,Char,x)</td></tr>
 * <tr><td>DISPLAY_ERASE_LINE</td>
 *     <td>erase a single line</td><td>(x,LINE,x,x,x)</td></tr>
 * <tr><td>DISPLAY_FILL_REGION</td>
 *     <td>fill screen region</td><td>(true/false,X1,Y1,X2,Y2)</td></tr>
 * <tr><td>DISPLAY_FILLED_FRAME</td>
 *     <td>draw a frame (on / off)</td><td>(true/false,X1,Y1,X2,Y2)</td></tr>
 * </table>
 *
 * \sa SysDisplayExecuteFunction()
 */
struct DisplayExecuteFunctionType {
  byte Status;   /*!< The function call result, always \ref NO_ERR. */
  byte Cmd;      /*!< The command to execute. */
  bool On;       /*!< The On parameter, see table. */
  byte X1;       /*!< The X1 parameter, see table. */
  byte Y1;       /*!< The Y1 parameter, see table. */
  byte X2;       /*!< The X2 parameter, see table. */
  byte Y2;       /*!< The Y2 parameter, see table. */
};

#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the DrawGraphicArray system call.
 * This structure is used when calling the \ref SysDrawGraphicArray system call
 * function.
 * It lets you specify the screen location at which to draw the image using the
 * \ref LocationType structure member, the graphic image data array, the
 * image parameters (if needed), as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawGraphicArray()
 */
struct DrawGraphicArrayType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;  /*!< The location on screen. */
  byte Data[];            /*!< A byte array containing the RIC opcodes. \ref RICMacros */
  long Variables[];       /*!< The variables passed as RIC arguments. */
  unsigned long Options;  /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawPolygon system call.
 * This structure is used when calling the \ref SysDrawPolygon system call
 * function.
 * It lets you specify the points of the polygon to draw using the
 * \ref LocationType array structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawPolygon()
 */
struct DrawPolygonType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Points[];  /*!< An array of LocationType structures which define the polygon's shape. */
  unsigned long Options;  /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawEllipse system call.
 * This structure is used when calling the \ref SysDrawEllipse system call
 * function.
 * It lets you specify the center of the ellipse using the
 * \ref LocationType structure member, the x and y axis radii,
 * as well as drawing options defined in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawEllipse()
 */
struct DrawEllipseType {
  char Result;            /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Center;    /*!< The location of the ellipse center. */
  byte SizeX;             /*!< The horizontal ellipse radius. */
  byte SizeY;             /*!< The vertical ellipse radius. */
  unsigned long Options;  /*!< The options to use when writing to the LCD. \ref DisplayDrawOptionConstants */
};

/**
 * Parameters for the DrawFont system call.
 * This structure is used when calling the \ref SysDrawFont system call function.
 * It lets you specify the text to draw, the LCD line and horizontal position using the
 * \ref LocationType structure member, as well as drawing options defined
 * in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawFont()
 */
struct DrawFontType {
  char Result;             /*!< The function call result. \ref NO_ERR means it succeeded. */
  LocationType Location;   /*!< The location in X, LCD line number coordinates. */
  string Filename;         /*!< The filename of the RIC-based font file. */
  string Text;             /*!< The text to draw on the LCD. */
  unsigned long Options;   /*!< The options to use when writing to the LCD.
                             \ref DisplayDrawOptionConstants */
};
#endif
#endif
/** @} */ // end of DisplayModuleTypes group

/** @defgroup DisplayModuleFunctions Display module functions
 * Functions for accessing and modifying display module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Reset LCD screen.
 * This function lets you restore the standard NXT running program screen.
 */
inline void ResetScreen();

/**
 * Draw a circle.
 * This function lets you draw a circle on the screen with its center at the
 * specified x and y location, using the specified radius. Optionally specify
 * drawing options. If this argument is not specified it defaults to \ref DRAW_OPT_NORMAL.
 * Valid display option constants are listed in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawCircle, DrawCircleType
 *
 * \param x The x value for the center of the circle.
 * \param y The y value for the center of the circle.
 * \param radius The radius of the circle.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char CircleOut(int x, int y, byte radius, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a line.
 * This function lets you draw a line on the screen from x1, y1 to x2, y2.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawLine, DrawLineType
 *
 * \param x1 The x value for the start of the line.
 * \param y1 The y value for the start of the line.
 * \param x2 The x value for the end of the line.
 * \param y2 The y value for the end of the line.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char LineOut(int x1, int y1, int x2, int y2, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a point.
 * This function lets you draw a point on the screen at x, y.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawPoint, DrawPointType
 *
 * \param x The x value for the point.
 * \param y The y value for the point.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char PointOut(int x, int y, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a rectangle.
 * This function lets you draw a rectangle on the screen at x, y with the
 * specified width and height.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawRect, DrawRectType
 *
 * \param x The x value for the top left corner of the rectangle.
 * \param y The y value for the top left corner of the rectangle.
 * \param width The width of the rectangle.
 * \param height The height of the rectangle.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char RectOut(int x, int y, int width, int height, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw text.
 * Draw a text value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawText, DrawTextType
 *
 * \param x The x value for the start of the text output.
 * \param y The text line number for the text output.
 * \param str The text to output to the LCD screen.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char TextOut(int x, int y, string str, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a number.
 * Draw a numeric value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawText, DrawTextType
 *
 * \param x The x value for the start of the number output.
 * \param y The text line number for the number output.
 * \param value The value to output to the LCD screen. Any numeric type is supported.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char NumOut(int x, int y, variant value, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw an ellipse.
 * This function lets you draw an ellipse on the screen with its center at the
 * specified x and y location, using the specified radii. Optionally specify
 * drawing options. If this argument is not specified it defaults to \ref DRAW_OPT_NORMAL.
 * Valid display option constants are listed in the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawEllipse, DrawEllipseType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param x The x value for the center of the ellipse.
 * \param y The y value for the center of the ellipse.
 * \param radiusX The x axis radius.
 * \param radiusY The y axis radius.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char EllipseOut(int x, int y, byte radiusX, byte radiusY, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a polygon.
 * This function lets you draw a polygon on the screen using an array of points.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa SysDrawPolygon, DrawPolygonType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param points An array of LocationType points that define the polygon.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char PolyOut(LocationType points[], unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw text with font.
 * Draw a text value on the screen at the specified x and y location using
 * a custom RIC font. Optionally specify drawing options. If this argument is
 * not specified it defaults to \ref DRAW_OPT_NORMAL. Valid display option
 * constants are listed in the \ref DisplayDrawOptionConstants group.  See the
 * \ref DisplayFontDrawOptionConstants for options specific to the font
 * drawing functions.
 * \sa FontNumOut, SysDrawFont, DrawFontType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param x The x value for the start of the text output.
 * \param y The y value for the start of the text output.
 * \param filename The filename of the RIC font.
 * \param str The text to output to the LCD screen.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char FontTextOut(int x, int y, string filename, string str, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a number with font.
 * Draw a numeric value on the screen at the specified x and y location using
 * a custom RIC font. Optionally specify drawing options. If this argument is
 * not specified it defaults to \ref DRAW_OPT_NORMAL. Valid display option
 * constants are listed in the \ref DisplayDrawOptionConstants group.  See the
 * \ref DisplayFontDrawOptionConstants for options specific to the font
 * drawing functions.
 * \sa FontTextOut, SysDrawFont, DrawFontType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param x The x value for the start of the number output.
 * \param y The y value for the start of the number output.
 * \param filename The filename of the RIC font.
 * \param value The value to output to the LCD screen. Any numeric type is supported.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char FontNumOut(int x, int y, string filename, variant value, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a graphic image.
 * Draw a graphic image file on the screen at the specified x and y location.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa SysDrawGraphic, DrawGraphicType
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param filename The filename of the RIC graphic image.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicOut(int x, int y, string filename, unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a graphic image from byte array.
 * Draw a graphic image byte array on the screen at the specified x and y location.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa SysDrawGraphicArray, DrawGraphicArrayType
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param data The byte array of the RIC graphic image.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicArrayOut(int x, int y, byte data[], unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a graphic image with parameters.
 * Draw a graphic image file on the screen at the specified x and y location using
 * an array of parameters.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa SysDrawGraphic, DrawGraphicType
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param filename The filename of the RIC graphic image.
 * \param vars The byte array of parameters.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicOutEx(int x, int y, string filename, byte vars[], unsigned long options=DRAW_OPT_NORMAL);

/**
 * Draw a graphic image from byte array with parameters.
 * Draw a graphic image byte array on the screen at the specified x and y location
 * using an array of parameters.
 * Optionally specify drawing options. If this argument is not specified it
 * defaults to \ref DRAW_OPT_NORMAL. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa SysDrawGraphicArray, DrawGraphicArrayType
 *
 * \param x The x value for the position of the graphic image.
 * \param y The y value for the position of the graphic image.
 * \param data The byte array of the RIC graphic image.
 * \param vars The byte array of parameters.
 * \param options The optional drawing options.
 * \return The result of the drawing operation.
 */
inline char GraphicArrayOutEx(int x, int y, byte data[], byte vars[], unsigned long options=DRAW_OPT_NORMAL);

/**
 * Read pixel data from the normal display buffer.
 * Read "cnt" bytes from the normal display memory into the data array. Start
 * reading from the specified x, line coordinate. Each byte of data read from
 * screen memory is a vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param x The desired x position from which to read pixel data.
 * \param line The desired line from which to read pixel data.
 * \param cnt The number of bytes of pixel data to read.
 * \param data The array of bytes into which pixel data is read.
 */
inline void GetDisplayNormal(const byte x, const byte line, unsigned int cnt, byte & data[]);

/**
 * Write pixel data to the normal display buffer.
 * Write "cnt" bytes to the normal display memory from the data array. Start
 * writing at the specified x, line coordinate. Each byte of data is a
 * vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param x The desired x position where you wish to write pixel data.
 * \param line The desired line where you wish to write pixel data.
 * \param cnt The number of bytes of pixel data to write.
 * \param data The array of bytes from which pixel data is read.
 */
inline void SetDisplayNormal(const byte x, const byte line, unsigned int cnt, byte data[]);

/**
 * Read pixel data from the popup display buffer.
 * Read "cnt" bytes from the popup display memory into the data array. Start
 * reading from the specified x, line coordinate. Each byte of data read from
 * screen memory is a vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param x The desired x position from which to read pixel data.
 * \param line The desired line from which to read pixel data.
 * \param cnt The number of bytes of pixel data to read.
 * \param data The array of bytes into which pixel data is read.
 */
inline void GetDisplayPopup(const byte x, const byte line, unsigned int cnt, byte & data[]);

/**
 * Write pixel data to the popup display buffer.
 * Write "cnt" bytes to the popup display memory from the data array. Start
 * writing at the specified x, line coordinate. Each byte of data is a
 * vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param x The desired x position where you wish to write pixel data.
 * \param line The desired line where you wish to write pixel data.
 * \param cnt The number of bytes of pixel data to write.
 * \param data The array of bytes from which pixel data is read.
 */
inline void SetDisplayPopup(const byte x, const byte line, unsigned int cnt, byte data[]);

/**
 * Read the display erase mask value.
 * This function lets you read the current display erase mask value.
 * \return The current display erase mask value.
 */
inline unsigned long DisplayEraseMask();


/**
 * Read the display update mask value.
 * This function lets you read the current display update mask value.
 * \return The current display update mask.
 */
inline unsigned long DisplayUpdateMask();

/**
 * Read the display font memory address.
 * This function lets you read the current display font memory address.
 * \return The current display font memory address.
 */
inline unsigned long DisplayFont();

/**
 * Read the display memory address.
 * This function lets you read the current display memory address.
 * \return The current display memory address.
 */
inline unsigned long DisplayDisplay();

/**
 * Read the display flags.
 * This function lets you read the current display flags.
 * Valid flag values are listed in the \ref DisplayFlagsGroup group.
 * \return The current display flags.
 */
inline byte DisplayFlags();

/**
 * Read the display text lines center flags.
 * This function lets you read the current display text lines center flags.
 * \return The current display text lines center flags.
 */
inline byte DisplayTextLinesCenterFlags();

/**
 * Draw text.
 * This function lets you draw text on the NXT LCD given the parameters you
 * pass in via the \ref DrawTextType structure.
 *
 * \param args The DrawTextType structure containing the drawing parameters.
 */
inline void SysDrawText(DrawTextType & args);

/**
 * Draw a point.
 * This function lets you draw a pixel on the NXT LCD given the parameters you
 * pass in via the \ref DrawPointType structure.
 *
 * \param args The DrawPointType structure containing the drawing parameters.
 */
inline void SysDrawPoint(DrawPointType & args);

/**
 * Draw a line.
 * This function lets you draw a line on the NXT LCD given the parameters you
 * pass in via the \ref DrawLineType structure.
 *
 * \param args The DrawLineType structure containing the drawing parameters.
 */
inline void SysDrawLine(DrawLineType & args);

/**
 * Draw a circle.
 * This function lets you draw a circle on the NXT LCD given the parameters you pass
 * in via the \ref DrawCircleType structure.
 *
 * \param args The DrawCircleType structure containing the drawing parameters.
 */
inline void SysDrawCircle(DrawCircleType & args);

/**
 * Draw a rectangle.
 * This function lets you draw a rectangle on the NXT LCD given the parameters
 * you pass in via the \ref DrawRectType structure.
 *
 * \param args The DrawRectType structure containing the drawing parameters.
 */
inline void SysDrawRect(DrawRectType & args);

/**
 * Draw a graphic (RIC file).
 * This function lets you draw a graphic image (RIC file) on the NXT LCD given
 * the parameters you pass in via the \ref DrawGraphicType structure.
 *
 * \param args The DrawGraphicType structure containing the drawing parameters.
 */
inline void SysDrawGraphic(DrawGraphicType & args);

/**
 * Set the screen mode.
 * This function lets you set the screen mode of the NXT LCD given the
 * parameters you pass in via the \ref DrawTextType structure.
 *
 * \param args The SetScreenModeType structure containing the screen mode parameters.
 */
inline void SysSetScreenMode(SetScreenModeType & args);

#ifdef __ENHANCED_FIRMWARE

/**
 * Execute any Display module command.
 * This function lets you directly execute the Display module's primary
 * drawing function using the values specified via the \ref
 * DisplayExecuteFunctionType structure.
 *
 * \param args The DisplayExecuteFunctionType structure containing the drawing parameters.
 */
inline void SysDisplayExecuteFunction(DisplayExecuteFunctionType & args);


#if __FIRMWARE_VERSION > 107

/**
 * Read the display contrast setting.
 * This function lets you read the current display contrast setting.
 * \return The current display contrast (byte).
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline byte DisplayContrast();

/**
 * Draw a graphic image from a byte array.
 * This function lets you draw a graphic image on the NXT LCD given the parameters you pass
 * in via the \ref DrawGraphicArrayType structure.
 *
 * \param args The DrawGraphicArrayType structure containing the drawing parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysDrawGraphicArray(DrawGraphicArrayType & args);

/**
 * Draw a polygon.
 * This function lets you draw a polygon on the NXT LCD given the parameters you pass
 * in via the \ref DrawPolygonType structure.
 *
 * \param args The DrawPolygonType structure containing the drawing parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysDrawPolygon(DrawPolygonType & args);

/**
 * Draw an ellipse.
 * This function lets you draw an ellipse on the NXT LCD given the parameters you pass
 * in via the \ref DrawEllipseType structure.
 *
 * \param args The DrawEllipseType structure containing the drawing parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysDrawEllipse(DrawEllipseType & args);

/**
 * Draw text using a custom font.
 * This function lets you draw text on the NXT LCD using a custom font
 * with parameters you pass in via the \ref DrawFontType structure.
 *
 * \param args The DrawFontType structure containing the drawing parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SysDrawFont(DrawFontType & args);

#endif
#endif

#else

#define GetDisplayNormal(_x, _line, _cnt, _data) asm { __getDisplayNormal(_x, _line, _cnt, _data) }
#define GetDisplayPopup(_x, _line, _cnt, _data) asm { __getDisplayPopup(_x, _line, _cnt, _data) }

#define DisplayEraseMask() asm { GetDisplayEraseMask(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayUpdateMask() asm { GetDisplayUpdateMask(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayFont() asm { GetDisplayFont(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayDisplay() asm { GetDisplayDisplay(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayFlags() asm { GetDisplayFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define DisplayTextLinesCenterFlags() asm { GetDisplayTextLinesCenterFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SetDisplayNormal(_x, _line, _cnt, _data) asm { __setDisplayNormal(_x, _line, _cnt, _data) }
#define SetDisplayPopup(_x, _line, _cnt, _data) asm { __setDisplayPopup(_x, _line, _cnt, _data) }

#define SysDrawText(_args) asm { \
  compchktype _args, DrawTextType \
  syscall DrawText, _args \
}
#define SysDrawPoint(_args) asm { \
  compchktype _args, DrawPointType \
  syscall DrawPoint, _args \
}
#define SysDrawLine(_args) asm { \
  compchktype _args, DrawLineType \
  syscall DrawLine, _args \
}
#define SysDrawCircle(_args) asm { \
  compchktype _args, DrawCircleType \
  syscall DrawCircle, _args \
}
#define SysDrawRect(_args) asm { \
  compchktype _args, DrawRectType \
  syscall DrawRect, _args \
}
#define SysDrawGraphic(_args) asm { \
  compchktype _args, DrawGraphicType \
  syscall DrawGraphic, _args \
}
#define SysSetScreenMode(_args) asm { \
  compchktype _args, SetScreenModeType \
  syscall SetScreenMode, _args \
}

#ifdef __ENHANCED_FIRMWARE

#define SysDisplayExecuteFunction(_args) asm { \
  compchktype _args, DisplayExecuteFunctionType \
  syscall DisplayExecuteFunction, _args \
}

#if __FIRMWARE_VERSION > 107

#define DisplayContrast() asm { GetDisplayContrast(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SysDrawGraphicArray(_args) asm { \
  compchktype _args, DrawGraphicArrayType \
  syscall DrawGraphicArray, _args \
}
#define SysDrawPolygon(_args) asm { \
  compchktype _args, DrawPolygonType \
  syscall DrawPolygon, _args \
}
#define SysDrawEllipse(_args) asm { \
  compchktype _args, DrawEllipseType \
  syscall DrawEllipse, _args \
}
#define SysDrawFont(_args) asm { \
  compchktype _args, DrawFontType \
  syscall DrawFont, _args \
}
#endif
#endif
#endif

/**
 * Clear LCD screen.
 * This function lets you clear the NXT LCD to a blank screen.
 */
inline void ClearScreen() { asm { PointOutEx(200, 200, TRUE) } }

/**
 * Clear a line on the LCD screen.
 * This function lets you clear a single line on the NXT LCD.
 * \param line The line you want to clear. See \ref LineConstants.
 */
inline void ClearLine(byte line) { asm { TextOutEx(0, line, __BlankLine, 0) } }

/**
 * Set the display font memory address.
 * This function lets you set the current display font memory address.
 * 
 * \param fontaddr The new display font memory address.
 */
inline void SetDisplayFont(unsigned long fontaddr) { asm { __setDisplayFont(fontaddr) } }

/**
 * Set the display memory address.
 * This function lets you set the current display memory address.
 * 
 * \param dispaddr The new display memory address.
 */
inline void SetDisplayDisplay(unsigned long dispaddr) { asm { __setDisplayDisplay(dispaddr) } }

/**
 * Set the display erase mask.
 * This function lets you set the current display erase mask.
 * 
 * \param eraseMask The new display erase mask.
 */
inline void SetDisplayEraseMask(unsigned long eraseMask) { asm { __setDisplayEraseMask(eraseMask) } }

/**
 * Set the display flags.
 * This function lets you set the current display flags.
 *
 * \param flags The new display flags. See \ref DisplayFlagsGroup.
 */
inline void SetDisplayFlags(byte flags) { asm { __setDisplayFlags(flags) } }

/**
 * Set the display text lines center flags.
 * This function lets you set the current display text lines center flags.
 *
 * \param ctrFlags The new display text lines center flags.
 */
inline void SetDisplayTextLinesCenterFlags(byte ctrFlags) { asm { __setDisplayTextLinesCenterFlags(ctrFlags) } }

/**
 * Set the display update mask.
 * This function lets you set the current display update mask.
 *
 * \param updateMask The new display update mask.
 */
inline void SetDisplayUpdateMask(unsigned long updateMask) { asm { __setDisplayUpdateMask(updateMask) } }

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)
/**
 * Set the display contrast.
 * This function lets you set the display contrast setting.
 *
 * \param contrast The desired display contrast.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SetDisplayContrast(byte contrast) { asm { __setDisplayContrast(contrast) } }

#endif

/** @} */ // end of DisplayModuleFunctions group
/** @} */ // end of DisplayModule group
/** @} */ // end of NXTFirmwareModules group

#endif // DISPLAY_H
