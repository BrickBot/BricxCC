/** \file ricmacro_constants.h
 * \brief The NBC/NXC RCX RIC macro constants
 *
 * ricmacro_constants.h contains the NBC/NXC RIC macro constants
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

#ifndef RICMACRO_CONSTANTS_H
#define RICMACRO_CONSTANTS_H

/** @addtogroup RICMacros
 * @{
 */
/**
 * Output an RIC ImgPoint structure
 * \param _X The X coordinate.
 * \param _Y The Y coordinate.
 */
#define RICImgPoint(_X, _Y) (_X)&0xFF, (_X)>>8, (_Y)&0xFF, (_Y)>>8

/**
 * Output an RIC ImgRect structure
 * \param _Pt An ImgPoint. See \ref RICImgPoint.
 * \param _W The rectangle width.
 * \param _H The rectangle height.
 */
#define RICImgRect(_Pt, _W, _H) _Pt, (_W)&0xFF, (_W)>>8, (_H)&0xFF, (_H)>>8

/**
 * Output an RIC Description opcode
 * \param _Options RIC options.
 * \param _Width The total RIC width.
 * \param _Height The total RIC height.
 */
#define RICOpDescription(_Options, _Width, _Height) 8, 0, 0, 0, (_Options)&0xFF, (_Options)>>8, (_Width)&0xFF, (_Width)>>8, (_Height)&0xFF, (_Height)>>8

/**
 * Output an RIC CopyBits opcode
 * \param _CopyOptions CopyBits copy options.  See \ref DisplayDrawOptionConstants.
 * \param _DataAddr The address of the sprite from which to copy data.
 * \param _SrcRect The rectangular portion of the sprite to copy.  See \ref RICImgRect.
 * \param _DstPoint The LCD coordinate to which to copy the data.  See \ref RICImgPoint.
 */
#define RICOpCopyBits(_CopyOptions, _DataAddr, _SrcRect, _DstPoint) 18, 0, 3, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, (_DataAddr)&0xFF, (_DataAddr)>>8, _SrcRect, _DstPoint

/**
 * Output an RIC Pixel opcode
 * \param _CopyOptions Pixel copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The pixel coordinate. See \ref RICImgPoint.
 * \param _Value The pixel value (unused).
 */
#define RICOpPixel(_CopyOptions, _Point, _Value) 10, 0, 4, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_Value)&0xFF, (_Value)>>8

/**
 * Output an RIC Line opcode
 * \param _CopyOptions Line copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point1 The starting point of the line.  See \ref RICImgPoint.
 * \param _Point2 The ending point of the line.  See \ref RICImgPoint.
 */
#define RICOpLine(_CopyOptions, _Point1, _Point2) 12, 0, 5, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point1, _Point2

/**
 * Output an RIC Rect opcode
 * \param _CopyOptions Rect copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The rectangle's top left corner.  See \ref RICImgPoint.
 * \param _Width The rectangle's width.
 * \param _Height The rectangle's height.
 */
#define RICOpRect(_CopyOptions, _Point, _Width, _Height) 12, 0, 6, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_Width)&0xFF, (_Width)>>8, (_Height)&0xFF, (_Height)>>8

/**
 * Output an RIC Circle opcode
 * \param _CopyOptions Circle copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The circle's center point.  See \ref RICImgPoint.
 * \param _Radius The circle's radius.
 */
#define RICOpCircle(_CopyOptions, _Point, _Radius) 10, 0, 7, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_Radius)&0xFF, (_Radius)>>8

/**
 * Output an RIC NumBox opcode
 * \param _CopyOptions NumBox copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The numbox bottom left corner.  See \ref RICImgPoint.
 * \param _Value The number to draw.
 */
#define RICOpNumBox(_CopyOptions, _Point, _Value) 10, 0, 8, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_Value)&0xFF, (_Value)>>8

/**
 * Output an RIC Sprite opcode
 * \param _DataAddr The address of the sprite.
 * \param _Rows The number of rows of data.
 * \param _BytesPerRow The number of bytes per row.
 * \param _SpriteData The actual sprite data. See \ref RICSpriteData.
 */
#define RICOpSprite(_DataAddr, _Rows, _BytesPerRow, _SpriteData) ((_Rows*_BytesPerRow)+((_Rows*_BytesPerRow)%2)+8)&0xFF, ((_Rows*_BytesPerRow)+((_Rows*_BytesPerRow)%2)+8)>>8, 1, 0, (_DataAddr)&0xFF, (_DataAddr)>>8, (_Rows)&0xFF, (_Rows)>>8, (_BytesPerRow)&0xFF, (_BytesPerRow)>>8, _SpriteData

/**
 * Output RIC sprite data
 */
#define RICSpriteData(...) __VA_ARGS__

/**
 * Output an RIC VarMap opcode
 * \param _DataAddr The address of the varmap.
 * \param _MapCount The number of points in the function.
 * \param _MapFunction The definition of the varmap function.  See \ref RICMapFunction.
 */
#define RICOpVarMap(_DataAddr, _MapCount, _MapFunction) ((_MapCount*4)+6)&0xFF, ((_MapCount*4)+6)>>8, 2, 0, (_DataAddr)&0xFF, (_DataAddr)>>8, (_MapCount)&0xFF, (_MapCount)>>8, _MapFunction

/**
 * Output an RIC map element
 * \param _Domain The map element domain.
 * \param _Range The map element range.
 */
#define RICMapElement(_Domain, _Range) (_Domain)&0xFF, (_Domain)>>8, (_Range)&0xFF, (_Range)>>8

/**
 * Output an RIC VarMap function
 * \param _MapElement An entry in the varmap function.  At least 2 elements are
 * required.  See \ref RICMapElement.
 */
#define RICMapFunction(_MapElement, ...) _MapElement, __VA_ARGS__

/**
 * Output an RIC parameterized argument
 * \param _arg The argument that you want to parameterize.
 */
#define RICArg(_arg) ((_arg)|0x1000)

/**
 * Output an RIC parameterized and mapped argument
 * \param _mapidx The varmap data address.
 * \param _arg The parameterized argument you want to pass through a varmap.
 */
#define RICMapArg(_mapidx, _arg) ((_arg)|0x1000|(((_mapidx)&0xF)<<8))

/**
 * Output an RIC Polygon opcode
 * \param _CopyOptions Polygon copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Count The number of points in the polygon.
 * \param _ThePoints The list of polygon points.  See \ref RICPolygonPoints.
 */
#define RICOpPolygon(_CopyOptions, _Count, _ThePoints)  ((_Count*4)+6)&0xFF, ((_Count*4)+6)>>8, 10, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, (_Count)&0xFF, (_Count)>>8, _ThePoints

/**
 * Output RIC polygon points
 * \param _pPoint1 The first polygon point.  See \ref RICImgPoint.
 * \param _pPoint2 The second polygon point (at least 3 points are required).
 * See \ref RICImgPoint.
 */
#define RICPolygonPoints(_pPoint1, _pPoint2, ...) _pPoint1, _pPoint2, __VA_ARGS__

/**
 * Output an RIC Ellipse opcode
 * \param _CopyOptions Ellipse copy options.  See \ref DisplayDrawOptionConstants.
 * \param _Point The center of the ellipse. See \ref RICImgPoint.
 * \param _RadiusX The x-axis radius of the ellipse.
 * \param _RadiusY The y-axis radius of the ellipse.
 */
#define RICOpEllipse(_CopyOptions, _Point, _RadiusX, _RadiusY) 12, 0, 9, 0, (_CopyOptions)&0xFF, (_CopyOptions)>>8, _Point, (_RadiusX)&0xFF, (_RadiusX)>>8, (_RadiusY)&0xFF, (_RadiusY)>>8

/** @} */  // end of RICMacros group

#endif // RICMACRO_CONSTANTS_H
