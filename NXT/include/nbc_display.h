/** \file nbc_display.h
 * \brief The NBC display module API
 *
 * nbc_display.h contains the NBC display module API
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

#ifndef NBC_DISPLAY_H
#define NBC_DISPLAY_H

#include "display_constants.h"
#include "nbc_command.h"

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// DISPLAY MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup DisplayModule
 * @{
 */
/** @defgroup DisplayModuleFunctions Display module functions
 * Functions for accessing and modifying display module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

dseg segment
TLocation	struct
 X		sword
 Y		sword
TLocation	ends

TSize	struct
 Width	sword
 Height	sword
TSize	ends

// DrawText
TDrawText	struct
 Result		sbyte
 Location	TLocation
 Text		byte[]
 Options	dword
TDrawText	ends

// DrawPoint
TDrawPoint	struct
 Result		sbyte
 Location	TLocation
 Options	dword
TDrawPoint	ends

// DrawLine
TDrawLine	struct
 Result		sbyte
 StartLoc	TLocation
 EndLoc		TLocation
 Options	dword
TDrawLine	ends

// DrawCircle
TDrawCircle	struct
 Result		sbyte
 Center		TLocation
 Size		byte
 Options	dword
TDrawCircle	ends

// DrawRect
TDrawRect	struct
 Result		sbyte
 Location	TLocation
 Size		TSize
 Options	dword
TDrawRect	ends

// DrawGraphic
TDrawGraphic	struct
 Result		sbyte
 Location	TLocation
 Filename	byte[]
 Variables	sdword[]
 Options	dword
TDrawGraphic	ends

// SetScreenMode
TSetScreenMode	struct
 Result		sbyte
 ScreenMode	dword
TSetScreenMode	ends

#ifdef __ENHANCED_FIRMWARE
TDisplayExecuteFunction struct
  Status byte
  Cmd    byte
  On     byte
  X1     byte
  Y1     byte
  X2     byte
  Y2     byte
TDisplayExecuteFunction ends
#endif

  __TextOutArgs TDrawText
  __NumOutArgs TDrawText
  __PointOutArgs TDrawPoint
  __LineOutArgs TDrawLine
  __RectOutArgs TDrawRect
  __CircleOutArgs TDrawCircle
  __GraphicOutArgs TDrawGraphic

  __TextOutMutex mutex
  __NumOutMutex mutex
  __PointOutMutex mutex
  __LineOutMutex mutex
  __RectOutMutex mutex
  __CircleOutMutex mutex
  __GraphicOutMutex mutex
  __GraphicOutEmptyVars sdword[]
  __BlankLine byte[] '                    '
dseg ends

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

dseg segment
// DrawGraphicArray
TDrawGraphicArray	struct
 Result		sbyte
 Location	TLocation
 Data		byte[]
 Variables	sdword[]
 Options	dword
TDrawGraphicArray	ends

// DrawPolygon
TDrawPolygon	struct
 Result		sbyte
 Points		TLocation[]
 Options	dword
TDrawPolygon	ends

// DrawEllipse
TDrawEllipse	struct
 Result		sbyte
 Center		TLocation
 SizeX		byte
 SizeY		byte
 Options	dword
TDrawEllipse	ends

// DrawFont
TDrawFont	struct
 Result		sbyte
 Location	TLocation
 Filename	byte[]
 Text		byte[]
 Options	dword
TDrawFont	ends

  __GraphicArrayOutArgs TDrawGraphicArray
  __PolyOutArgs TDrawPolygon
  __EllipseOutArgs TDrawEllipse
  __FontOutArgs TDrawFont

  __PolyOutMutex mutex
  __EllipseOutMutex mutex
  __FontOutMutex mutex
dseg ends

#endif

dseg segment
  __displayModuleOffsetMutex mutex
  __displayModuleOffset word
dseg ends

#define __TextOutEx(_x,_y,_txt,_options) \
  acquire __TextOutMutex \
  mov __TextOutArgs.Location.X,_x \
  mov __TextOutArgs.Location.Y,_y \
  mov __TextOutArgs.Options,_options \
  mov __TextOutArgs.Text,_txt \
  syscall DrawText,__TextOutArgs \
  release __TextOutMutex

#define __NumOutEx(_x,_y,_num,_options) \
  acquire __NumOutMutex \
  mov __NumOutArgs.Location.X,_x \
  mov __NumOutArgs.Location.Y,_y \
  mov __NumOutArgs.Options,_options \
  numtostr __NumOutArgs.Text,_num \
  syscall DrawText,__NumOutArgs \
  release __NumOutMutex

#define __PointOutEx(_x,_y,_options) \
  acquire __PointOutMutex \
  mov __PointOutArgs.Location.X,_x \
  mov __PointOutArgs.Location.Y,_y \
  mov __PointOutArgs.Options,_options \
  syscall DrawPoint,__PointOutArgs \
  release __PointOutMutex

#define __LineOutEx(_x1,_y1,_x2,_y2,_options) \
  acquire __LineOutMutex \
  mov __LineOutArgs.StartLoc.X,_x1 \
  mov __LineOutArgs.StartLoc.Y,_y1 \
  mov __LineOutArgs.EndLoc.X,_x2 \
  mov __LineOutArgs.EndLoc.Y,_y2 \
  mov __LineOutArgs.Options,_options \
  syscall DrawLine,__LineOutArgs \
  release __LineOutMutex

#define __RectOutEx(_x,_y,_w,_h,_options) \
  acquire __RectOutMutex \
  mov __RectOutArgs.Location.X,_x \
  mov __RectOutArgs.Location.Y,_y \
  mov __RectOutArgs.Size.Width,_w \
  mov __RectOutArgs.Size.Height,_h \
  mov __RectOutArgs.Options,_options \
  syscall DrawRect,__RectOutArgs \
  release __RectOutMutex

#define __CircleOutEx(_x,_y,_r,_options) \
  acquire __CircleOutMutex \
  mov __CircleOutArgs.Center.X,_x \
  mov __CircleOutArgs.Center.Y,_y \
  mov __CircleOutArgs.Size,_r \
  mov __CircleOutArgs.Options,_options \
  syscall DrawCircle,__CircleOutArgs \
  release __CircleOutMutex

#define __GraphicOutEx(_x,_y,_file,_vars,_options) \
  acquire __GraphicOutMutex \
  mov __GraphicOutArgs.Location.X,_x \
  mov __GraphicOutArgs.Location.Y,_y \
  mov __GraphicOutArgs.Filename,_file \
  mov __GraphicOutArgs.Variables,_vars \
  mov __GraphicOutArgs.Options,_options \
  syscall DrawGraphic,__GraphicOutArgs \
  release __GraphicOutMutex

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __GraphicArrayOutEx(_x,_y,_data,_vars,_options) \
  acquire __GraphicOutMutex \
  mov __GraphicArrayOutArgs.Location.X,_x \
  mov __GraphicArrayOutArgs.Location.Y,_y \
  mov __GraphicArrayOutArgs.Data,_data \
  mov __GraphicArrayOutArgs.Variables,_vars \
  mov __GraphicArrayOutArgs.Options,_options \
  syscall DrawGraphicArray,__GraphicArrayOutArgs \
  release __GraphicOutMutex

#define __PolyOutEx(_points,_options) \
  acquire __PolyOutMutex \
  mov __PolyOutArgs.Points,_points \
  mov __PolyOutArgs.Options,_options \
  syscall DrawPolygon,__PolyOutArgs \
  release __PolyOutMutex

#define __EllipseOutEx(_x,_y,_rX,_rY,_options) \
  acquire __EllipseOutMutex \
  mov __EllipseOutArgs.Center.X,_x \
  mov __EllipseOutArgs.Center.Y,_y \
  mov __EllipseOutArgs.SizeX,_rX \
  mov __EllipseOutArgs.SizeY,_rY \
  mov __EllipseOutArgs.Options,_options \
  syscall DrawEllipse,__EllipseOutArgs \
  release __EllipseOutMutex

#define __FontTextOutEx(_x,_y,_fnt,_txt,_options) \
  acquire __FontOutMutex \
  mov __FontOutArgs.Location.X,_x \
  mov __FontOutArgs.Location.Y,_y \
  mov __FontOutArgs.Options,_options \
  mov __FontOutArgs.Filename,_fnt \
  mov __FontOutArgs.Text,_txt \
  syscall DrawFont,__FontOutArgs \
  release __FontOutMutex

#define __FontNumOutEx(_x,_y,_fnt,_num,_options) \
  acquire __FontOutMutex \
  mov __FontOutArgs.Location.X,_x \
  mov __FontOutArgs.Location.Y,_y \
  mov __FontOutArgs.Options,_options \
  mov __FontOutArgs.Filename,_fnt \
  numtostr __FontOutArgs.Text,_num \
  syscall DrawFont,__FontOutArgs \
  release __FontOutMutex

#endif

#define __GetDisplayEraseMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  __getDisplayModuleValue(DisplayOffsetEraseMask, _n)

#define __GetDisplayUpdateMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  __getDisplayModuleValue(DisplayOffsetUpdateMask, _n)

#define __GetDisplayFont(_n) \
  compchk EQ, sizeof(_n), 4 \
  __getDisplayModuleValue(DisplayOffsetPFont, _n)

#define __GetDisplayDisplay(_n) \
  compchk EQ, sizeof(_n), 4 \
  __getDisplayModuleValue(DisplayOffsetDisplay, _n)

#define __GetDisplayFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getDisplayModuleValue(DisplayOffsetFlags, _n)

#define __GetDisplayTextLinesCenterFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getDisplayModuleValue(DisplayOffsetTextLinesCenterFlags, _n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __GetDisplayContrast(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getDisplayModuleValue(DisplayOffsetContrast, _n)

#define __setDisplayEraseMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  __SetDisplayModuleValue(DisplayOffsetEraseMask, _n)

#define __setDisplayUpdateMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  __SetDisplayModuleValue(DisplayOffsetUpdateMask, _n)

#define __setDisplayFont(_n) \
  compchk EQ, sizeof(_n), 4 \
  __SetDisplayModuleValue(DisplayOffsetPFont, _n)

#define __setDisplayDisplay(_n) \
  compchk EQ, sizeof(_n), 4 \
  __SetDisplayModuleValue(DisplayOffsetDisplay, _n)

#define __setDisplayFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetDisplayModuleValue(DisplayOffsetFlags, _n)

#define __setDisplayTextLinesCenterFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetDisplayModuleValue(DisplayOffsetTextLinesCenterFlags, _n)

#define __setDisplayContrast(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetDisplayModuleValue(DisplayOffsetContrast, _n)

#endif

#define __getDisplayNormal(_x, _line, _cnt, _data) \
  compif EQ, isconst(_line+_x), TRUE \
  compchk LT, _line, 0x08 \
  compchk GTEQ, _line, 0x00 \
  __getDisplayModuleBytes(DisplayOffsetNormal(_line,_x), _cnt, _data) \
  compelse \
  acquire __displayModuleOffsetMutex \
  mul __displayModuleOffset, _line, 100 \
  add __displayModuleOffset, __displayModuleOffset, _x \
  add __displayModuleOffset, __displayModuleOffset, 119 \
  __getDisplayModuleBytes(__displayModuleOffset, _cnt, _data) \
  release __displayModuleOffsetMutex \
  compend

#define __getDisplayPopup(_x, _line, _cnt, _data) \
  compif EQ, isconst(_line+_x), TRUE \
  compchk LT, _line, 0x08 \
  compchk GTEQ, _line, 0x00 \
  __getDisplayModuleBytes(DisplayOffsetPopup(_line,_x), _cnt, _data) \
  compelse \
  acquire __displayModuleOffsetMutex \
  mul __displayModuleOffset, _line, 100 \
  add __displayModuleOffset, __displayModuleOffset, _x \
  add __displayModuleOffset, __displayModuleOffset, 919 \
  __getDisplayModuleBytes(__displayModuleOffset, _cnt, _data) \
  release __displayModuleOffsetMutex \
  compend

#define __setDisplayNormal(_x, _line, _cnt, _data) \
  compif EQ, isconst(_line+_x), TRUE \
  compchk LT, _line, 0x08 \
  compchk GTEQ, _line, 0x00 \
  __SetDisplayModuleBytes(DisplayOffsetNormal(_line,_x), _cnt, _data) \
  compelse \
  acquire __displayModuleOffsetMutex \
  mul __displayModuleOffset, _line, 100 \
  add __displayModuleOffset, __displayModuleOffset, _x \
  add __displayModuleOffset, __displayModuleOffset, 119 \
  __SetDisplayModuleBytes(__displayModuleOffset, _cnt, _data) \
  release __displayModuleOffsetMutex \
  compend

#define __setDisplayPopup(_x, _line, _cnt, _data) \
  compif EQ, isconst(_line+_x), TRUE \
  compchk LT, _line, 0x08 \
  compchk GTEQ, _line, 0x00 \
  __SetDisplayModuleBytes(DisplayOffsetPopup(_line,_x), _cnt, _data) \
  compelse \
  acquire __displayModuleOffsetMutex \
  mul __displayModuleOffset, _line, 100 \
  add __displayModuleOffset, __displayModuleOffset, _x \
  add __displayModuleOffset, __displayModuleOffset, 919 \
  __SetDisplayModuleBytes(__displayModuleOffset, _cnt, _data) \
  release __displayModuleOffsetMutex \
  compend


#endif

/**
 * Clear a line on the LCD screen.
 * This function lets you clear a single line on the NXT LCD.
 * \param _line The line you want to clear. See \ref LineConstants.
 */
#define ClearLine(_line) __TextOutEx(0, _line, __BlankLine, 0)

/**
 * Draw a point with drawing options.
 * This function lets you draw a point on the screen at x, y.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawPoint
 *
 * \param _x The x value for the point.
 * \param _y The y value for the point.
 * \param _options The optional drawing options.
 */
#define PointOutEx(_x,_y,_options) __PointOutEx(_x,_y,_options)

/**
 * Draw a point.
 * This function lets you draw
 a point on the screen at x, y.
 * \sa TDrawPoint
 *
 * \param _x The x value for the point.
 * \param _y The y value for the point.
 */
#define PointOut(_x,_y) __PointOutEx(_x,_y,0)

/**
 * Clear LCD screen.
 * This function lets you clear the NXT LCD to a blank screen.
 */
#define ClearScreen() __PointOutEx(200, 200, 1)

/**
 * Draw a line with drawing options.
 * This function lets you draw a line on the screen from x1, y1 to x2, y2.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawLine
 *
 * \param _x1 The x value for the start of the line.
 * \param _y1 The y value for the start of the line.
 * \param _x2 The x value for the end of the line.
 * \param _y2 The y value for the end of the line.
 * \param _options The optional drawing options.
 */
#define LineOutEx(_x1,_y1,_x2,_y2,_options) __LineOutEx(_x1,_y1,_x2,_y2,_options)

/**
 * Draw a line.
 * This function lets you draw a line on the screen from x1, y1 to x2, y2.
 * \sa TDrawLine
 *
 * \param _x1 The x value for the start of the line.
 * \param _y1 The y value for the start of the line.
 * \param _x2 The x value for the end of the line.
 * \param _y2 The y value for the end of the line.
 */
#define LineOut(_x1,_y1,_x2,_y2) __LineOutEx(_x1,_y1,_x2,_y2,0)

/**
 * Draw a rectangle with drawing options.
 * This function lets you draw a rectangle on the screen at x, y with the
 * specified width and height.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawRect
 *
 * \param _x The x value for the top left corner of the rectangle.
 * \param _y The y value for the top left corner of the rectangle.
 * \param _w The width of the rectangle.
 * \param _h The height of the rectangle.
 * \param _options The optional drawing options.
 */
#define RectOutEx(_x,_y,_w,_h,_options) __RectOutEx(_x,_y,_w,_h,_options)

/**
 * Draw a rectangle.
 * This function lets you draw a rectangle on the screen at x, y with the
 * specified width and height.
 * \sa TDrawRect
 *
 * \param _x The x value for the top left corner of the rectangle.
 * \param _y The y value for the top left corner of the rectangle.
 * \param _w The width of the rectangle.
 * \param _h The height of the rectangle.
 */
#define RectOut(_x,_y,_w,_h) __RectOutEx(_x,_y,_w,_h,0)

/**
 * Draw a circle with drawing options.
 * This function lets you draw a circle on the screen with its center at the
 * specified x and y location, using the specified radius. Also specify
 * drawing options. Valid display option constants are listed in the
 * \ref DisplayDrawOptionConstants group.
 * \sa TDrawCircle
 *
 * \param _x The x value for the center of the circle.
 * \param _y The y value for the center of the circle.
 * \param _r The radius of the circle.
 * \param _options The optional drawing options.
 */
#define CircleOutEx(_x,_y,_r,_options) __CircleOutEx(_x,_y,_r,_options)

/**
 * Draw a circle.
 * This function lets you draw a circle on the screen with its center at the
 * specified x and y location, using the specified radius.
 * \sa TDrawCircle
 *
 * \param _x The x value for the center of the circle.
 * \param _y The y value for the center of the circle.
 * \param _r The radius of the circle.
 */
#define CircleOut(_x,_y,_r) __CircleOutEx(_x,_y,_r,0)

/**
 * Draw a number with drawing options.
 * Draw a numeric value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawText
 *
 * \param _x The x value for the start of the number output.
 * \param _y The text line number for the number output.
 * \param _num The value to output to the LCD screen. Any numeric type is supported.
 * \param _options The optional drawing options.
 */
#define NumOutEx(_x,_y,_num,_options) __NumOutEx(_x,_y,_num,_options)

/**
 * Draw a number.
 * Draw a numeric value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * \sa TDrawText
 *
 * \param _x The x value for the start of the number output.
 * \param _y The text line number for the number output.
 * \param _num The value to output to the LCD screen. Any numeric type is supported.
 */
#define NumOut(_x,_y,_num) __NumOutEx(_x,_y,_num,0)

/**
 * Draw text.
 * Draw a text value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawText
 *
 * \param _x The x value for the start of the text output.
 * \param _y The text line number for the text output.
 * \param _txt The text to output to the LCD screen.
 * \param _options The optional drawing options.
 */
#define TextOutEx(_x,_y,_txt,_options) __TextOutEx(_x,_y,_txt,_options)

/**
 * Draw text.
 * Draw a text value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * \sa TDrawText
 *
 * \param _x The x value for the start of the text output.
 * \param _y The text line number for the text output.
 * \param _txt The text to output to the LCD screen.
 */
#define TextOut(_x,_y,_txt) __TextOutEx(_x,_y,_txt,0)

/**
 * Draw a graphic image with parameters and drawing options.
 * Draw a graphic image file on the screen at the specified x and y location using
 * an array of parameters. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa TDrawGraphic
 *
 * \param _x The x value for the position of the graphic image.
 * \param _y The y value for the position of the graphic image.
 * \param _file The filename of the RIC graphic image.
 * \param _vars The byte array of parameters.
 * \param _options The drawing options.
 */
#define GraphicOutEx(_x,_y,_file,_vars,_options) __GraphicOutEx(_x,_y,_file,_vars,_options)

/**
 * Draw a graphic image.
 * Draw a graphic image file on the screen at the specified x and y location.
 * If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa TDrawGraphic
 *
 * \param _x The x value for the position of the graphic image.
 * \param _y The y value for the position of the graphic image.
 * \param _file The filename of the RIC graphic image.
 */
#define GraphicOut(_x,_y,_file) __GraphicOutEx(_x,_y,_file,__GraphicOutEmptyVars,0)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

/**
 * Draw a graphic image from byte array with parameters and drawing options.
 * Draw a graphic image byte array on the screen at the specified x and y
 * location using an array of parameters and drawing options.
 * Valid display option constants are listed in the
 * \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa TDrawGraphicArray
 *
 * \param _x The x value for the position of the graphic image.
 * \param _y The y value for the position of the graphic image.
 * \param _data The byte array of the RIC graphic image.
 * \param _vars The byte array of parameters.
 * \param _options The drawing options.
 */
#define GraphicArrayOutEx(_x,_y,_data,_vars,_options) __GraphicArrayOutEx(_x,_y,_data,_vars,_options)

/**
 * Draw a graphic image from byte array.
 * Draw a graphic image byte array on the screen at the specified x and y
 * location. If the file cannot be found then nothing will be drawn and no
 * errors will be reported.
 * \sa TDrawGraphicArray
 *
 * \param _x The x value for the position of the graphic image.
 * \param _y The y value for the position of the graphic image.
 * \param _data The byte array of the RIC graphic image.
 */
#define GraphicArrayOut(_x,_y,_data) __GraphicArrayOutEx(_x,_y,_data,__GraphicOutEmptyVars,0)

/**
 * Draw an ellipse with drawing options.
 * This function lets you draw an ellipse on the screen with its center at the
 * specified x and y location, using the specified radii. Also specify
 * drawing options. Valid display option constants are listed in the
 * \ref DisplayDrawOptionConstants group.
 * \sa SysDrawEllipse, DrawEllipseType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the center of the ellipse.
 * \param _y The y value for the center of the ellipse.
 * \param _rX The x axis radius.
 * \param _rY The y axis radius.
 * \param _options The drawing options.
 */
#define EllipseOutEx(_x,_y,_rX,_rY,_options) __EllipseOutEx(_x,_y,_rX,_rY,_options)

/**
 * Draw an ellipse.
 * This function lets you draw an ellipse on the screen with its center at the
 * specified x and y location, using the specified radii.
 * \sa TDrawEllipse
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the center of the ellipse.
 * \param _y The y value for the center of the ellipse.
 * \param _rX The x axis radius.
 * \param _rY The y axis radius.
 */
#define EllipseOut(_x,_y,_rX,_rY) __EllipseOutEx(_x,_y,_rX,_rY,0)

/**
 * Draw a polygon with drawing options.
 * This function lets you draw a polygon on the screen using an array of points.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawPolygon
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _points An array of \ref TLocation points that define the polygon.
 * \param _options The drawing options.
 */
#define PolyOutEx(_points,_options) __PolyOutEx(_points,_options)

/**
 * Draw a polygon.
 * This function lets you draw a polygon on the screen using an array of points.
 * \sa TDrawPolygon
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _points An array of LocationType points that define the polygon.
 */
#define PolyOut(_points) __PolyOutEx(_points,0)

/**
 * Draw text with font and drawing options.
 * Draw a text value on the screen at the specified x and y location using
 * a custom RIC font. Also specify drawing options. Valid display option
 * constants are listed in the \ref DisplayDrawOptionConstants group.  See the
 * \ref DisplayFontDrawOptionConstants for options specific to the font
 * drawing functions.
 * \sa FontNumOut, TDrawFont
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the start of the text output.
 * \param _y The y value for the start of the text output.
 * \param _fnt The filename of the RIC font.
 * \param _txt The text to output to the LCD screen.
 * \param _options The drawing options.
 */
#define FontTextOutEx(_x,_y,_fnt,_txt,_options) __FontTextOutEx(_x,_y,_fnt,_txt,_options)

/**
 * Draw text with font.
 * Draw a text value on the screen at the specified x and y location using
 * a custom RIC font.
 * \sa FontNumOut, TDrawFont
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the start of the text output.
 * \param _y The y value for the start of the text output.
 * \param _fnt The filename of the RIC font.
 * \param _txt The text to output to the LCD screen.
 */
#define FontTextOut(_x,_y,_fnt,_txt) __FontTextOutEx(_x,_y,_fnt,_txt,0)

/**
 * Draw a number with font and drawing options.
 * Draw a numeric value on the screen at the specified x and y location using
 * a custom RIC font. Also specify drawing options. Valid display option
 * constants are listed in the \ref DisplayDrawOptionConstants group.  See the
 * \ref DisplayFontDrawOptionConstants for options specific to the font
 * drawing functions.
 * \sa FontTextOut, TDrawFont
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the start of the number output.
 * \param _y The y value for the start of the number output.
 * \param _fnt The filename of the RIC font.
 * \param _num The value to output to the LCD screen. Any numeric type is supported.
 * \param _options The optional drawing options.
 */
#define FontNumOutEx(_x,_y,_fnt,_num,_options) __FontNumOutEx(_x,_y,_fnt,_num,_options)

/**
 * Draw a number with font.
 * Draw a numeric value on the screen at the specified x and y location using
 * a custom RIC font.
 * \sa FontTextOut, TDrawFont
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the start of the number output.
 * \param _y The y value for the start of the number output.
 * \param _fnt The filename of the RIC font.
 * \param _num The value to output to the LCD screen. Any numeric type is supported.
 */
#define FontNumOut(_x,_y,_fnt,_num) __FontNumOutEx(_x,_y,_fnt,_num,0)

#endif

/**
 * Read the display erase mask value.
 * This function lets you read the current display erase mask value.
 * \param _n The current display erase mask value.
 */
#define GetDisplayEraseMask(_n) __GetDisplayEraseMask(_n)

/**
 * Read the display update mask value.
 * This function lets you read the current display update mask value.
 * \param _n The current display update mask.
 */
#define GetDisplayUpdateMask(_n) __GetDisplayUpdateMask(_n)

/**
 * Read the display font memory address.
 * This function lets you read the current display font memory address.
 * \param _n The current display font memory address.
 */
#define GetDisplayFont(_n) __GetDisplayFont(_n)

/**
 * Read the display memory address.
 * This function lets you read the current display memory address.
 * \param _n The current display memory address.
 */
#define GetDisplayDisplay(_n) __GetDisplayDisplay(_n)

/**
 * Read the display flags.
 * This function lets you read the current display flags.
 * Valid flag values are listed in the \ref DisplayFlagsGroup group.
 * \param _n The current display flags.
 */
#define GetDisplayFlags(_n) __GetDisplayFlags(_n)

/**
 * Read the display text lines center flags.
 * This function lets you read the current display text lines center flags.
 * \param _n The current display text lines center flags.
 */
#define GetDisplayTextLinesCenterFlags(_n) __GetDisplayTextLinesCenterFlags(_n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Read the display contrast setting.
 * This function lets you read the current display contrast setting.
 * \param _n The current display contrast (byte).
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define GetDisplayContrast(_n) __GetDisplayContrast(_n)
#endif

/**
 * Read pixel data from the normal display buffer.
 * Read "cnt" bytes from the normal display memory into the data array. Start
 * reading from the specified x, line coordinate. Each byte of data read from
 * screen memory is a vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param _x The desired x position from which to read pixel data.
 * \param _line The desired line from which to read pixel data.
 * \param _cnt The number of bytes of pixel data to read.
 * \param _data The array of bytes into which pixel data is read.
 */
#define GetDisplayNormal(_x, _line, _cnt, _data) __getDisplayNormal(_x, _line, _cnt, _data)

/**
 * Read pixel data from the popup display buffer.
 * Read "cnt" bytes from the popup display memory into the data array. Start
 * reading from the specified x, line coordinate. Each byte of data read from
 * screen memory is a vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param _x The desired x position from which to read pixel data.
 * \param _line The desired line from which to read pixel data.
 * \param _cnt The number of bytes of pixel data to read.
 * \param _data The array of bytes into which pixel data is read.
 */
#define GetDisplayPopup(_x, _line, _cnt, _data) __getDisplayPopup(_x, _line, _cnt, _data)

/**
 * Set the display font memory address.
 * This function lets you set the current display font memory address.
 *
 * \param _n The new display font memory address.
 */
#define SetDisplayFont(_n) __setDisplayFont(_n)

/**
 * Set the display memory address.
 * This function lets you set the current display memory address.
 *
 * \param _n The new display memory address.
 */
#define SetDisplayDisplay(_n) __setDisplayDisplay(_n)

/**
 * Set the display erase mask.
 * This function lets you set the current display erase mask.
 *
 * \param _n The new display erase mask.
 */
#define SetDisplayEraseMask(_n) __setDisplayEraseMask(_n)

/**
 * Set the display flags.
 * This function lets you set the current display flags.
 *
 * \param _n The new display flags. See \ref DisplayFlagsGroup.
 */
#define SetDisplayFlags(_n) __setDisplayFlags(_n)

/**
 * Set the display text lines center flags.
 * This function lets you set the current display text lines center flags.
 *
 * \param _n The new display text lines center flags.
 */
#define SetDisplayTextLinesCenterFlags(_n) __setDisplayTextLinesCenterFlags(_n)

/**
 * Set the display update mask.
 * This function lets you set the current display update mask.
 *
 * \param _n The new display update mask.
 */
#define SetDisplayUpdateMask(_n) __setDisplayUpdateMask(_n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Set the display contrast.
 * This function lets you set the display contrast setting.
 *
 * \param _n The desired display contrast.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define SetDisplayContrast(_n) __setDisplayContrast(_n)
#endif

/**
 * Write pixel data to the normal display buffer.
 * Write "cnt" bytes to the normal display memory from the data array. Start
 * writing at the specified x, line coordinate. Each byte of data is a
 * vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param _x The desired x position where you wish to write pixel data.
 * \param _line The desired line where you wish to write pixel data.
 * \param _cnt The number of bytes of pixel data to write.
 * \param _data The array of bytes from which pixel data is read.
 */
#define SetDisplayNormal(_x, _line, _cnt, _data) __setDisplayNormal(_x, _line, _cnt, _data)

/**
 * Write pixel data to the popup display buffer.
 * Write "cnt" bytes to the popup display memory from the data array. Start
 * writing at the specified x, line coordinate. Each byte of data is a
 * vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param _x The desired x position where you wish to write pixel data.
 * \param _line The desired line where you wish to write pixel data.
 * \param _cnt The number of bytes of pixel data to write.
 * \param _data The array of bytes from which pixel data is read.
 */
#define SetDisplayPopup(_x, _line, _cnt, _data) __setDisplayPopup(_x, _line, _cnt, _data)

/** @} */ // end of DisplayModuleFunctions group
/** @} */ // end of DisplayModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_DISPLAY_H
