/** \file nbcgl_constants.h
 * \brief Constants for the NBC/NXC graphics library API
 *
 * nbcgl_constants.h contains constants for the NBC/NXC graphics library API
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
#ifndef NBCGL_CONSTANTS_H
#define NBCGL_CONSTANTS_H

/** @addtogroup GraphicsLibrary
 * @{
 */
/*------------------------------------------------------------------------------
; File          : nbcGL.nbc
; Description   : Data and subroutines for a very simple 3D engine.
; Programmed by : Arno van der Vegt, avandervegt@home.nl
;-----------------------------------------------------------------------------*/

/** @defgroup GLConstantsBeginModes Graphics library begin modes
 * Constants that are used to specify the polygon surface begin mode.
 * @{
 */
#define GL_POLYGON             1 /*!< Use polygon mode. */
#define GL_LINE                2 /*!< Use line mode. */
#define GL_POINT               3 /*!< Use point mode. */
#define GL_CIRCLE              4 /*!< Use circle mode. */
/** @} */  // end of GLConstantsBeginModes group

/** @defgroup GLConstantsActions Graphics library actions
 * Constants that are used to specify a graphics library action.
 * @{
 */
#define GL_TRANSLATE_X       1 /*!< Translate along the X axis. */
#define GL_TRANSLATE_Y       2 /*!< Translate along the Y axis. */
#define GL_TRANSLATE_Z       3 /*!< Translate along the Z axis. */
#define GL_ROTATE_X          4 /*!< Rotate around the X axis. */
#define GL_ROTATE_Y          5 /*!< Rotate around the Y axis. */
#define GL_ROTATE_Z          6 /*!< Rotate around the Z axis. */
#define GL_SCALE_X           7 /*!< Scale along the X axis. */
#define GL_SCALE_Y           8 /*!< Scale along the Y axis. */
#define GL_SCALE_Z           9 /*!< Scale along the Z axis. */
/** @} */  // end of GLConstantsSettings group

/** @defgroup GLConstantsSettings Graphics library settings
 * Constants that are used to configure the graphics library settings.
 * @{
 */
#define GL_CIRCLE_SIZE          1 /*!< Set the circle size. */
#define GL_CULL_MODE            2 /*!< Set the cull mode.  */
#define GL_CAMERA_DEPTH         3 /*!< Set the camera depth. */
#define GL_ZOOM_FACTOR          4 /*!< Set the zoom factor. */
/** @} */  // end of GLConstantsSettings group

/** @defgroup GLConstantsCullMode Graphics library cull mode
 * Constants to use when setting the graphics library cull mode.
 * @{
 */
#define GL_CULL_BACK           2 /*!< Cull lines in back. */
#define GL_CULL_FRONT          3 /*!< Cull lines in front. */
#define GL_CULL_NONE           4 /*!< Do not cull any lines. */
/** @} */  // end of GLConstantsCullMode group

/** @} */  // end of GraphicsLibrary group

#endif // NBCGL_CONSTANTS_H
