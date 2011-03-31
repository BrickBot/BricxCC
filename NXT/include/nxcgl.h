/** \file nxcgl.h
 * \brief Documentation for the NXC graphics library API
 *
 * nxcgl.h contains additional documentation for the NXC graphics library API
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
 * \date 2011-03-16
 * \version 1
 */
#ifndef NXCGL_H
#define NXCGL_H

/** @addtogroup GraphicsLibrary
 * @{
 */
//------------------------------------------------------------------------------
// File          : nbcGL.nbc
// Description   : Data and subroutines for a very simple 3D engine.
// Programmed by : Arno van der Vegt, legoasimo@gmail.com
//------------------------------------------------------------------------------

/**
 * Initialize graphics library.
 * Setup all the necessary data for the graphics library to function. Call this
 * function before any other graphics library routine.
 */
inline void glInit() { asm { __glInit() } }

/**
 * Set graphics library options.
 * Adjust graphic library settings for circle size and cull mode.
 *
 * \param glType The setting type.  See \ref GLConstantsSettings.
 * \param glValue The setting value. For culling modes see \ref GLConstantsCullMode.
 */
inline void glSet(int glType, int glValue) { asm { __glSet(glType, glValue) } }

/**
 * Begin defining an object.
 * Start the process of defining a graphics library object using low level
 * functions such as \ref glBegin, \ref glAddVertex, and \ref glEnd.
 *
 * \return The object index of the new object being created.
 */
inline int glBeginObject() { asm { __glBeginObject(__RETVAL__) } }

/**
 * Stop defining an object.
 * Finish the process of defining a graphics library object.  Call this function
 * after you have completed the object definition.
 */
inline void glEndObject() { asm { __glEndObject() } }

/**
 * Perform an object action.
 * Execute the specified action on the specified object.
 *
 * \param glObjectId The object id.
 * \param glAction The action to perform on the object. See \ref GLConstantsActions.
 * \param glValue The setting value.
 */
inline void glObjectAction(int glObjectId, int glAction, int glValue) {
  asm { __glObjectAction(glObjectId, glAction, glValue) }
}

/**
 * Add a vertex to an object.
 * Add a vertex to an object currently being defined.  This function should
 * only be used between \ref glBegin and \ref glEnd which are themselves
 * nested within a \ref glBeginObject and \ref glEndObject pair.
 *
 * \param glX The X axis coordinate.
 * \param glY The Y axis coordinate.
 * \param glZ The Z axis coordinate.
 */
inline void glAddVertex(int glX, int glY, int glZ) {
  asm { __glAddVertex(glX, glY, glZ) }
}

/**
 * Begin a new polygon for the current object.
 * Start defining a polygon surface for the current graphics object using
 * the specified begin mode.
 *
 * \param glBeginMode The desired mode.  See \ref GLConstantsBeginModes.
 */
inline void glBegin(int glBeginMode) { asm { __glBegin(glBeginMode) } }

/**
 * Finish a polygon for the current object.
 * Stop defining a polgyon surface for the current graphics object.
 */
inline void glEnd() { asm { __glEnd() } }

/**
 * Begin a new render.
 * Start the process of rendering the existing graphic objects.
 */
inline void glBeginRender() { asm { __glBeginRender() } }

/**
 * Call a graphic object.
 * Tell the graphics library that you want it to include the specified
 * object in the render.
 *
 * \param glObjectId The desired object id.
 */
inline void glCallObject(int glObjectId) { asm { __glCallObject(glObjectId) } }

/**
 * Finish the current render.
 * Rotate the vertex list, clear the screen, and draw the rendered objects
 * to the LCD.
 */
inline void glFinishRender() { asm { __glFinishRender() } }

/**
 * Set the X axis angle.
 * Set the X axis angle to the specified value.
 *
 * \param glValue The new X axis angle.
 */
inline void glSetAngleX(int glValue) { asm { __glSetAngleX(glValue) } }

/**
 * Add to the X axis angle.
 * Add the specified value to the existing X axis angle.
 *
 * \param glValue The value to add to the X axis angle.
 */
inline void glAddToAngleX(int glValue) { asm { __glAddToAngleX(glValue) } }

/**
 * Set the Y axis angle.
 * Set the Y axis angle to the specified value.
 *
 * \param glValue The new Y axis angle.
 */
inline void glSetAngleY(int glValue) { asm { __glSetAngleY(glValue) } }

/**
 * Add to the Y axis angle.
 * Add the specified value to the existing Y axis angle.
 *
 * \param glValue The value to add to the Y axis angle.
 */
inline void glAddToAngleY(int glValue) { asm { __glAddToAngleY(glValue) } }

/**
 * Set the Z axis angle.
 * Set the Z axis angle to the specified value.
 *
 * \param glValue The new Z axis angle.
 */
inline void glSetAngleZ(int glValue) { asm { __glSetAngleZ(glValue) } }

/**
 * Add to the Z axis angle.
 * Add the specified value to the existing Z axis angle.
 *
 * \param glValue The value to add to the Z axis angle.
 */
inline void glAddToAngleZ(int glValue) { asm { __glAddToAngleZ(glValue) } }

/**
 * Table-based sine scaled by 32768.
 * Return the sine of the specified angle in degrees.  The result is scaled
 * by 32768.
 *
 * \param glAngle The angle in degrees.
 * \return The sine value scaled by 32768.
 */
inline int glSin32768(int glAngle) { asm { __glSin32768(__RETVAL__, glAngle) } }

/**
 * Table-based cosine scaled by 32768.
 * Return the cosine of the specified angle in degrees.  The result is scaled
 * by 32768.
 *
 * \param glAngle The angle in degrees.
 * \return The cosine value scaled by 32768.
 */
inline int glCos32768(int glAngle) { asm { __glCos32768(__RETVAL__, glAngle) } }

/**
 * Create a 3D box.
 * Define a 3D box using the specified begin mode for all faces. The center
 * of the box is at the origin of the XYZ axis with width, height, and depth
 * specified via the glSizeX, glSizeY, and glSizeZ parameters.
 *
 * \param glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param glSizeX The X axis size (width).
 * \param glSizeY The Y axis size (height).
 * \param glSizeZ The Z axis size (depth).
 */
inline int glBox(int glMode, int glSizeX, int glSizeY, int glSizeZ) {
  asm { __glBox(glMode, glSizeX, glSizeY, glSizeZ, __RETVAL__) }
}

/**
 * Create a 3D cube.
 * Define a 3D cube using the specified begin mode for all faces. The center
 * of the box is at the origin of the XYZ axis with equal width, height, and depth
 * specified via the glSize parameter.
 *
 * \param glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param glSize The cube's width, height, and depth.
 */
inline int glCube(int glMode, int glSize) {
  asm { __glBox(glMode, glSize, glSize, glSize, __RETVAL__) }
}

/**
 * Create a 3D pyramid.
 * Define a 3D pyramid using the specified begin mode for all faces. The center
 * of the pyramid is at the origin of the XYZ axis with width, height, and depth
 * specified via the glSizeX, glSizeY, and glSizeZ parameters.
 *
 * \param glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param glSizeX The X axis size (width).
 * \param glSizeY The Y axis size (height).
 * \param glSizeZ The Z axis size (depth).
 */
inline int glPyramid(int glMode, int glSizeX, int glSizeY, int glSizeZ) {
  asm { __glPyramid(glMode, glSizeX, glSizeY, glSizeZ, __RETVAL__) }
}

/** @} */ // end of GraphicsLibrary group

#endif // NXCGL_H
