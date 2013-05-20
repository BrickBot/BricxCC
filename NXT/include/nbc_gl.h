/** \file nbc_gl.h
 * \brief Documentation for the NBC graphics library API
 *
 * nbc_gl.h contains additional documentation for the NBC graphics library API
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
 * \version 1
 */

#ifndef NBC_GL_H
#define NBC_GL_H

#include "gl_constants.h"
#include "nbc_display.h"

///////////////////////////////////////////////////////////////////////////////
////////////////////////// Graphics Library API ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup GraphicsLibrary
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

#define __glInit()                                                                             \
         call     __GL_glInit

#define __glSet(_glType, _glValue)                                                             \
         mov      __GL_glSettingType,         _glType                                          \
         mov      __GL_glSettingValue,        _glValue                                         \
         call     __GL_glSet

#define __glBeginObject(_glObjId)                                                              \
         mov      __GL_object.firstVertex,    __GL_vertexCount                                 \
         mov      __GL_object.lastVertex,     __GL_vertexCount                                 \
         mov      __GL_object.firstPolygon,   __GL_polygonCount                                \
         mov      _glObjId,                   __GL_objectCount

#define __glEndObject()                                                                        \
         call     __GL_glEndObject

#define __glObjectAction(_glObjectId, _glAction, _glValue)                                     \
         mov      __GL_objectIndex,           _glObjectId                                      \
         mov      __GL_action,                _glAction                                        \
         mov      __GL_value,                 _glValue                                         \
         call     __GL_glObjectAction

#define __glAddVertex(_glX, _glY, _glZ)                                                        \
         mov      __GL_vertex0.orig.x,        _glX                                             \
         mov      __GL_vertex0.orig.y,        _glY                                             \
         mov      __GL_vertex0.orig.z,        _glZ                                             \
         call     __GL_glAddVertex

#define __glBegin(_glBeginMode)                                                                \
         mov      __GL_polygon.beginMode,     _glBeginMode                                     \
         mov      __GL_polygon.firstVertex,   __GL_pvDataCount                                 \
         mov      __GL_polygon.lastVertex,    __GL_pvDataCount

#define __glEnd()                                                                              \
         call     __GL_glEnd

#define __glBeginRender()                                                                      \
         call     __GL_glResetObjects

#define __glCallObject(_glObjectId)                                                            \
         mov      __GL_objectIndex,           _glObjectId                                      \
         call     __GL_glCallObject

#define __glFinishRender()                                                                     \
         call     __GL_glRotateVertexList                                                      \
         set      __GL_glDrawPoint.Location.X, 200                                             \
         set      __GL_glDrawPoint.Options,    DRAW_OPT_CLEAR_WHOLE_SCREEN                     \
         syscall  DrawPoint,                   __GL_glDrawPoint                                \
         call     __GL_glRenderObjects

#define __glSetAngleX(_glValue)                                                                \
         add      __GL_angleX,                _glValue,    3600                                \
         mod      __GL_angleX,                __GL_angleX, 360

#define __glAddToAngleX(_glValue)                                                              \
         add      __GL_angleX,                __GL_angleX, _glValue                            \
         add      __GL_angleX,                __GL_angleX, 3600                                \
         mod      __GL_angleX,                __GL_angleX, 360

#define __glSetAngleY(_glValue)                                                                \
         add      __GL_angleY,                _glValue,    3600                                \
         mod      __GL_angleY,                __GL_angleY, 360

#define __glAddToAngleY(_glValue)                                                              \
         add      __GL_angleY,                __GL_angleY, _glValue                            \
         add      __GL_angleY,                __GL_angleY, 3600                                \
         mod      __GL_angleY,                __GL_angleY, 360

#define __glSetAngleZ(_glValue)                                                                \
         add      __GL_angleZ,                _glValue,    3600                                \
         mod      __GL_angleZ,                __GL_angleZ, 360

#define __glAddToAngleZ(_glValue)                                                              \
         add      __GL_angleZ,                __GL_angleZ, _glValue                            \
         add      __GL_angleZ,                __GL_angleZ, 3600                                \
         mod      __GL_angleZ,                __GL_angleZ, 360

#define __glSin32768(_glAngle, _glResult)                                                      \
         mov      __GL_angle,                 _glAngle                                         \
         mod      __GL_angle,                 __GL_angle, 360                                  \
         index    _glResult,                  __GL_SIN_TABLE, __GL_angle

#define __glCos32768(_glAngle, _glResult)                                                      \
         mov      __GL_angle,                 _glAngle                                         \
         add      __GL_angle,                 __GL_angle, 90                                   \
         mod      __GL_angle,                 __GL_angle, 360                                  \
         index    _glResult,                  __GL_SIN_TABLE, __GL_angle

#define __glBox(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId)                               \
         mov      __GL_mode                   _glMode                                          \
         mov      __GL_sizeX                  _glSizeX                                         \
         mov      __GL_sizeY                  _glSizeY                                         \
         mov      __GL_sizeZ                  _glSizeZ                                         \
         call     __GL_glBox                                                                   \
         mov      _glObjId,                   __GL_tmpId

#define __glPyramid(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId)                           \
         mov      __GL_mode                   _glMode                                          \
         mov      __GL_sizeX                  _glSizeX                                         \
         mov      __GL_sizeY                  _glSizeY                                         \
         mov      __GL_sizeZ                  _glSizeZ                                         \
         call     __GL_glPyramid                                                               \
         mov      _glObjId,                   __GL_tmpId

//-----------------------------------------------------------------------------------------
//
// Private definitions...
//
//-----------------------------------------------------------------------------------------
#define __glRangeCheck(_glValue, _glMaxValue, _glErrorMsg)                                     \
         mov      __GL_glRangeValue,          _glValue                                         \
         mov      __GL_glRangeMaxValue,       _glMaxValue                                      \
         mov      __GL_glRangeErrorMsg,       _glErrorMsg                                      \
         call     __GL_glRangeCheck

// Data sizes...
#define __GL_MAX_VERTICES       256
#define __GL_MAX_LINES          256
#define __GL_MAX_POLYGONS       128
#define __GL_MAX_OBJECT_ACTIONS  32
#define __GL_MAX_OBJECTS         16
#define __GL_MAX_PV_DATA        256
#define __GL_MAX_PL_DATA        256

dseg segment
  // Sine table constants...
  __GL_SIN_TABLE sword[] 0,572,1144,1715,2286,2856,3425,3993,4560,5126,5690,6252,6813,7371,7927,   \
 8481,9032,9580,10126,10668,11207,11743,12275,12803,13328,13848,14365,14876,15384,15886,16384,     \
 16877,17364,17847,18324,18795,19261,19720,20174,20622,21063,21498,21926,22348,22763,23170,23571,  \
 23965,24351,24730,25102,25466,25822,26170,26510,26842,27166,27482,27789,28088,28378,28660,28932,  \
 29197,29452,29698,29935,30163,30382,30592,30792,30983,31164,31336,31499,31651,31795,31928,32052,  \
 32166,32270,32365,32449,32524,32588,32643,32688,32723,32748,32763,32767,32763,32748,32723,32688,  \
 32643,32588,32524,32449,32365,32270,32166,32052,31928,31795,31651,31499,31336,31164,30983,30792,  \
 30592,30382,30163,29935,29698,29452,29197,28932,28660,28378,28088,27789,27482,27166,26842,26510,  \
 26170,25822,25466,25102,24730,24351,23965,23571,23170,22763,22348,21926,21498,21063,20622,20174,  \
 19720,19261,18795,18324,17847,17364,16877,16384,15886,15384,14876,14365,13848,13328,12803,12275,  \
 11743,11207,10668,10126,9580,9032,8481,7927,7371,6813,6252,5690,5126,4560,3993,3425,2856,2286,    \
 1715,1144,572,0,-572,-1144,-1715,-2286,-2856,-3425,-3993,-4560,-5126,-5690,-6252,-6813,-7371,     \
 -7927,-8481,-9032,-9580,-10126,-10668,-11207,-11743,-12275,-12803,-13328,-13848,-14365,-14876,    \
 -15384,-15886,-16384,-16877,-17364,-17847,-18324,-18795,-19261,-19720,-20174,-20622,-21063,-21498,\
 -21926,-22348,-22763,-23170,-23571,-23965,-24351,-24730,-25102,-25466,-25822,-26170,-26510,-26842,\
 -27166,-27482,-27789,-28088,-28378,-28660,-28932,-29197,-29452,-29698,-29935,-30163,-30382,-30592,\
 -30792,-30983,-31164,-31336,-31499,-31651,-31795,-31928,-32052,-32166,-32270,-32365,-32449,-32524,\
 -32588,-32643,-32688,-32723,-32748,-32763,-32767,-32763,-32748,-32723,-32688,-32643,-32588,-32524,\
 -32449,-32365,-32270,-32166,-32052,-31928,-31795,-31651,-31499,-31336,-31164,-30983,-30792,-30592,\
 -30382,-30163,-29935,-29698,-29452,-29197,-28932,-28660,-28378,-28088,-27789,-27482,-27166,-26842,\
 -26510,-26170,-25822,-25466,-25102,-24730,-24351,-23965,-23571,-23170,-22763,-22348,-21926,-21498,\
 -21063,-20622,-20174,-19720,-19261,-18795,-18324,-17847,-17364,-16877,-16384,-15886,-15384,-14876,\
 -14365,-13848,-13328,-12803,-12275,-11743,-11207,-10668,-10126,-9580,-9032,-8481,-7927,-7371,     \
 -6813,-6252,-5690,-5126,-4560,-3993,-3425,-2856,-2286,-1715,-1144,-572,0

  // General stuff, copied from NXTDefs.h...
  __GL_glDrawLine        TDrawLine
  __GL_glDrawPoint       TDrawPoint
  __GL_glDrawCircle      TDrawCircle
  __GL_glDrawData        TDrawText

  // settings...
  TGLSettings struct
    cullMode         byte
    circleSize       byte
    camDepth         byte
    zoom             byte
  TGLSettings ends

  __GL_glSettings        TGLSettings
  __GL_glSettingType     byte
  __GL_glSettingValue    byte

  // Vertex data...
  TGLVertex struct
    x                sword
    y                sword
    z                sword
  TGLVertex ends

  TGLScreenVertex struct
    x                sword
    y                sword 
  TGLScreenVertex ends

  TGLRotVertex struct
    orig             TGLVertex
    rot              TGLVertex
    screen           TGLScreenVertex
  TGLRotVertex ends

  __GL_vertexData        TGLRotVertex[]
  __GL_vertex0           TGLRotVertex
  __GL_vertex1           TGLRotVertex
  __GL_vertex2           TGLRotVertex
  __GL_vertexCount       byte
  __GL_vertexIndex       byte
  __GL_vertexOffset      byte

  // Line data...
  TGLLine struct
    firstVertex      byte
    lastVertex       byte
  TGLLine ends

  __GL_lineData          TGLLine[]
  __GL_line              TGLLine
  __GL_lineCount         byte
  __GL_lineIndex         byte
  __GL_lineDone          byte[]

  // Polygon data...
  TGLPolygon struct
    beginMode        byte
    firstVertex      byte
    lastVertex       byte
    firstLine        byte
    lastLine         byte
  TGLPolygon ends

  __GL_polygonData       TGLPolygon[]
  __GL_polygon           TGLPolygon
  __GL_polygonCount      byte
  __GL_polygonIndex      byte

  // Polygon/vertex link...
  __GL_pvData            byte[]
  __GL_pvDataCount       byte

  // Polygon/line link...
  __GL_plData            byte[]
  __GL_plDataCount       byte

  // Object action...
  TGLObjectAction struct
    type             byte
    value            sword //sdword
    lsin             sword //sdword
    lcos             sword //sdword
  TGLObjectAction ends

  __GL_objectAction      TGLObjectAction
  __GL_objectActionData  TGLObjectAction[]
  __GL_objectActionCount byte

  // Object data...
  TObject struct
    firstVertex      byte
    lastVertex       byte
    firstPolygon     byte
    lastPolygon      byte
    firstLine        byte
    lastLine         byte
    render           byte
    
    // settings...
    circleSize       byte
    cullMode         byte

    actionCount      byte
    actionList       byte[]
  TObject ends

  __GL_objectData        TObject[]
  __GL_object            TObject
  __GL_objectCount       byte
  __GL_objectIndex       byte

  // Temp offset...
  __GL_offset            word

  // Counters...
  __GL_i                 word
  __GL_j                 word
  __GL_k                 word
  __GL_l                 word

  // Angles...
  __GL_angleX            sword //sdword
  __GL_angleY            sword //sdword
  __GL_angleZ            sword //sdword

  // Save angles...
  __GL_saveAngleX        sword //sdword
  __GL_saveAngleY        sword //sdword
  __GL_saveAngleZ        sword //sdword

  __GL_sinX              sword //sdword
  __GL_cosX              sword //sdword
  __GL_sinY              sword //sdword
  __GL_cosY              sword //sdword
  __GL_sinZ              sword //sdword
  __GL_cosZ              sword //sdword

  // Temp vars for calculations...
  __GL_a                 sdword
  __GL_b                 sdword
  __GL_c                 sdword
  __GL_d                 sdword
  __GL_e                 sdword
  __GL_f                 sdword

  // Rotated x, y, z coords...
  __GL_xx                sdword
  __GL_yy                sdword
  __GL_zz                sdword

  __GL_camDepth          sdword
  __GL_zoom              sdword
  
  __GL_x0                sdword
  __GL_y0                sdword
  __GL_z0                sdword
  
  __GL_x1                sdword
  __GL_y1                sdword
  __GL_z1                sdword

  __GL_x2                sdword
  __GL_y2                sdword
  __GL_z2                sdword

  // data for filling polygons...
  __GL_buffer            byte[]
  
  __GL_minX              sword
  __GL_maxX              sword
  
  __GL_startY            sword
  __GL_startX            sword
  __GL_endY              sword
  __GL_endX              sword
  
  __GL_deltaY            sword
  __GL_deltaX            sword
  
  __GL_action            byte
  __GL_index             word
  __GL_value             sword //sdword
  __GL_type              sword //sdword
  
  // rangecheck data...
  __GL_glRangeValue      word
  __GL_glRangeMaxValue   word
  __GL_glRangeErrorMsg   byte[]

  __GL_glErrorState      byte FALSE
  __GL_glErrorMsg        byte[]

  __GL_glLinesClipped    byte
dseg ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glRangeCheck
// Description : Check array sizes.
//-----------------------------------------------------------------------------------------
subroutine __GL_glRangeCheck
  // check if there's an already error...
  brcmp    EQ,                     __GL_nbc_gl_range_ok, __GL_glErrorState, TRUE
  // check the range...
  brcmp    LT,                     __GL_nbc_gl_range_ok, __GL_glRangeValue, __GL_glRangeMaxValue
  set      __GL_glErrorState,      TRUE
  mov      __GL_glErrorMsg,        __GL_glRangeErrorMsg
__GL_nbc_gl_range_ok:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glInit
// Description : Initialize vars.
//-----------------------------------------------------------------------------------------
subroutine __GL_glInit
  set      __GL_glSettings.cullMode,   GL_CULL_BACK
  set      __GL_glSettings.circleSize, 4
  set      __GL_glSettings.camDepth,   100
  set      __GL_glSettings.zoom,       0
  arrinit  __GL_vertexData,            __GL_vertex0, __GL_MAX_VERTICES
  set      __GL_vertexCount,           0
  arrinit  __GL_lineData,              __GL_line, __GL_MAX_LINES
  set      __GL_lineCount,             0
  arrinit  __GL_polygonData,           __GL_polygon, __GL_MAX_POLYGONS
  set      __GL_polygonCount,          0
  arrinit  __GL_objectActionData,      __GL_objectAction, __GL_MAX_OBJECT_ACTIONS
  arrinit  __GL_object.actionList,     0, __GL_MAX_OBJECT_ACTIONS
  arrinit  __GL_objectData,            __GL_object, __GL_MAX_OBJECTS
  set      __GL_objectCount,           0
  arrinit  __GL_pvData                 0, __GL_MAX_PV_DATA
  set      __GL_pvDataCount,           0
  arrinit  __GL_plData                 0, __GL_MAX_PL_DATA
  set      __GL_plDataCount            0
  set      __GL_angleX,                0
  set      __GL_angleY,                0
  set      __GL_angleZ,                0
  arrinit  __GL_buffer,                0, 200
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glSet
// Description : Change settings.
//-----------------------------------------------------------------------------------------
subroutine __GL_glSet
  brcmp    EQ,                     __GL_nbc_gl_set_circle_size,  __GL_glSettingType, GL_CIRCLE_SIZE
  brcmp    EQ,                     __GL_nbc_gl_set_cull_mode,    __GL_glSettingType, GL_CULL_MODE
  brcmp    EQ,                     __GL_nbc_gl_set_camera_depth, __GL_glSettingType, GL_CAMERA_DEPTH
  brcmp    EQ,                     __GL_nbc_gl_set_zoom_factor,  __GL_glSettingType, GL_ZOOM_FACTOR
  // unknown setting...
  jmp      __GL_nbc_gl_set_done
__GL_nbc_gl_set_circle_size:
  mov      __GL_glSettings.circleSize, __GL_glSettingValue
  jmp      __GL_nbc_gl_set_done
__GL_nbc_gl_set_cull_mode:
  mov      __GL_glSettings.cullMode,   __GL_glSettingValue
  jmp      __GL_nbc_gl_set_done
__GL_nbc_gl_set_camera_depth:
  mov      __GL_glSettings.camDepth,   __GL_glSettingValue
  jmp      __GL_nbc_gl_set_done
__GL_nbc_gl_set_zoom_factor:
  mov      __GL_glSettings.zoom,       __GL_glSettingValue
__GL_nbc_gl_set_done:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glAddVertex
// Description : Check if there's an existing vertex with the same (x,y,z) coord.
//               If there's an existing vertex found then return the index to that vertex
//               else add the vertex to the list and return the index of the added vertex.
//-----------------------------------------------------------------------------------------
subroutine __GL_glAddVertex
  brcmp    EQ,                      __GL_nbc_gl_add_vertex_error, __GL_glErrorState, TRUE
  // check if the list is empty...
  brcmp    EQ,                      __GL_nbc_gl_empty_vertex_list, __GL_vertexCount, 0
  // loop through the list...
  mov      __GL_i,                  __GL_object.firstVertex
__GL_nbc_gl_find_vertex:
  index    __GL_vertex1,            __GL_vertexData, __GL_i
  brcmp    NEQ,                     __GL_nbc_gl_vertex_not_equal, __GL_vertex1.orig.x, __GL_vertex0.orig.x
  brcmp    NEQ,                     __GL_nbc_gl_vertex_not_equal, __GL_vertex1.orig.y, __GL_vertex0.orig.y
  brcmp    NEQ,                     __GL_nbc_gl_vertex_not_equal, __GL_vertex1.orig.z, __GL_vertex0.orig.z
  mov      __GL_vertexIndex,        __GL_i
  jmp      __GL_nbc_gl_add_vertex_done
__GL_nbc_gl_vertex_not_equal:
  add      __GL_i,                  __GL_i, 1
  brcmp    LT,                      __GL_nbc_gl_find_vertex, __GL_i, __GL_object.lastVertex
__GL_nbc_gl_empty_vertex_list:
  __glRangeCheck(__GL_vertexCount, __GL_MAX_VERTICES, 'Too many vertices')
  brcmp    EQ,                      __GL_nbc_gl_add_vertex_error, __GL_glErrorState, TRUE
  // there's no matching vertex found, add a new vertex to the list...
  replace  __GL_vertexData,         __GL_vertexData, __GL_vertexCount, __GL_vertex0
  mov      __GL_vertexIndex,        __GL_vertexCount
  add      __GL_vertexCount,        __GL_vertexCount, 1
__GL_nbc_gl_add_vertex_done:
  replace  __GL_pvData,             __GL_pvData, __GL_polygon.lastVertex, __GL_vertexIndex
  add      __GL_polygon.lastVertex, __GL_polygon.lastVertex, 1
  add      __GL_pvDataCount,        __GL_pvDataCount, 1
  mov      __GL_object.lastVertex,  __GL_vertexCount
__GL_nbc_gl_add_vertex_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glEnd
// Description : Store the polygon data, call __GL_glAddLines to optimize lines list.
//-----------------------------------------------------------------------------------------
subroutine __GL_glEnd
  brcmp    EQ,                     __GL_nbc_gl_end_error, __GL_glErrorState, TRUE
  call     __GL_glAddLines
  replace  __GL_polygonData,       __GL_polygonData, __GL_polygonCount, __GL_polygon
  add      __GL_polygonCount,      __GL_polygonCount, 1
__GL_nbc_gl_end_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glAddLines
// Description : Add the lines of the polygon and check if the line already exists.
//               Each line should be rendered only once.
//-----------------------------------------------------------------------------------------
subroutine __GL_glAddLines
  brcmp    EQ,                     __GL_nbc_gl_add_lines_error, __GL_glErrorState, TRUE
  mov      __GL_polygon.firstLine, __GL_plDataCount
  // loop through polygon vertex the list...
  mov      __GL_i,                 __GL_polygon.firstVertex
__GL_nbc_gl_find_lines1:
  add      __GL_j,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_find_lines_modj, __GL_j, __GL_polygon.lastVertex
  mov      __GL_j,                 __GL_polygon.firstVertex
  // if the beginMode is GL_LINE then don't close the polygon...
  brcmp    EQ,                     __GL_nbc_gl_add_line_done2, __GL_polygon.beginMode, GL_LINE
__GL_nbc_gl_find_lines_modj:
  index    __GL_a,                 __GL_pvData, __GL_i
  index    __GL_b,                 __GL_pvData, __GL_j
  // check if the list is empty...
  brcmp    EQ,                     __GL_nbc_empty_lines_list, __GL_lineCount, 0
  // loop through the line list to find a matching line...
  mov      __GL_k,                 __GL_object.firstLine
__GL_nbc_gl_find_lines2:
  index    __GL_line,              __GL_lineData, __GL_k
  brcmp    NEQ,                    __GL_nbc_gl_find_line_not_equal1, __GL_a, __GL_line.firstVertex
  brcmp    NEQ,                    __GL_nbc_gl_find_line_not_equal1, __GL_b, __GL_line.lastVertex
  mov      __GL_lineIndex,         __GL_k
  jmp      __GL_nbc_gl_add_line_done1
__GL_nbc_gl_find_line_not_equal1:
  brcmp    NEQ,                    __GL_nbc_gl_find_line_not_equal2, __GL_b, __GL_line.firstVertex
  brcmp    NEQ,                    __GL_nbc_gl_find_line_not_equal2, __GL_a, __GL_line.lastVertex
  mov      __GL_lineIndex,         __GL_k
  jmp      __GL_nbc_gl_add_line_done1
__GL_nbc_gl_find_line_not_equal2:
  add      __GL_k,                 __GL_k, 1
  brcmp    LT,                     __GL_nbc_gl_find_lines2, __GL_k, __GL_lineCount
__GL_nbc_empty_lines_list:
  mov      __GL_line.firstVertex,  __GL_a
  mov      __GL_line.lastVertex,   __GL_b
  __glRangeCheck(__GL_lineCount, __GL_MAX_LINES, 'Too many lines')
  brcmp    EQ,                     __GL_nbc_gl_add_lines_error, __GL_glErrorState, TRUE
  replace  __GL_lineData,          __GL_lineData, __GL_lineCount, __GL_line
  mov      __GL_lineIndex,         __GL_lineCount
  add      __GL_lineCount,         __GL_lineCount, 1
__GL_nbc_gl_add_line_done1:
  __glRangeCheck(__GL_plDataCount, __GL_MAX_PL_DATA, 'Too many poly-lines')
  brcmp    EQ,                     __GL_nbc_gl_add_lines_error, __GL_glErrorState, TRUE
  replace  __GL_plData,            __GL_plData, __GL_plDataCount, __GL_lineIndex
  add      __GL_plDataCount,       __GL_plDataCount, 1
  add      __GL_i,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_find_lines1, __GL_i, __GL_polygon.lastVertex
__GL_nbc_gl_add_line_done2:
  mov      __GL_polygon.lastLine,  __GL_plDataCount
__GL_nbc_gl_add_lines_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glEndObject
// Description : Save the last polygon number, store the object in the objectlist.
//-----------------------------------------------------------------------------------------
subroutine __GL_glEndObject
  brcmp    EQ,                      __GL_nbc_gl_end_object_error, __GL_glErrorState, TRUE
  mov      __GL_object.lastPolygon, __GL_polygonCount
  replace  __GL_objectData,         __GL_objectData, __GL_objectCount, __GL_object
  add      __GL_objectCount,        __GL_objectCount, 1
__GL_nbc_gl_end_object_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glObjectAction
// Description : Add an action to the object...
//-----------------------------------------------------------------------------------------
subroutine __GL_glObjectAction
  index    __GL_object,             __GL_objectData, __GL_objectIndex
  mov      __GL_objectAction.type,  __GL_action
  mov      __GL_objectAction.value, __GL_value
  brcmp    EQ,                      __GL_nbc_gl_action_rotate, __GL_action, GL_ROTATE_X
  brcmp    EQ,                      __GL_nbc_gl_action_rotate, __GL_action, GL_ROTATE_Y
  brcmp    EQ,                      __GL_nbc_gl_action_rotate, __GL_action, GL_ROTATE_Z
  jmp      __GL_nbc_gl_action_no_rotate
__GL_nbc_gl_action_rotate:
  // if the action is a rotation of any kind then grab the sin and cos of the angle
  mod      __GL_value,              __GL_value, 360
  index    __GL_objectAction.lsin,  __GL_SIN_TABLE, __GL_value
  add      __GL_value,              __GL_value, 90
  mod      __GL_value,              __GL_value, 360
  index    __GL_objectAction.lcos,  __GL_SIN_TABLE, __GL_value
__GL_nbc_gl_action_no_rotate:
  __glRangeCheck(__GL_object.actionCount, __GL_MAX_OBJECT_ACTIONS, 'Too many object-actions')
  brcmp    EQ,                      __GL_nbc_gl_add_object_error, __GL_glErrorState, TRUE
  replace  __GL_object.actionList,  __GL_object.actionList, __GL_object.actionCount, __GL_objectActionCount
  add      __GL_object.actionCount, __GL_object.actionCount, 1
  replace  __GL_objectData,         __GL_objectData, __GL_objectIndex, __GL_object
  __glRangeCheck(__GL_objectActionCount, __GL_MAX_OBJECT_ACTIONS, 'Too many object-actions')
  brcmp    EQ,                      __GL_nbc_gl_add_object_error, __GL_glErrorState, TRUE
  replace  __GL_objectActionData,   __GL_objectActionData, __GL_objectActionCount, __GL_objectAction
  add      __GL_objectActionCount,  __GL_objectActionCount, 1
__GL_nbc_gl_add_object_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glRotateObject
// Description : Check the object actions and apply them to the object...
//-----------------------------------------------------------------------------------------
subroutine __GL_glRotateObject
  mov      __GL_i,                 __GL_object.firstVertex
__GL_nbc_gl_apply_next_vertex:
  index    __GL_vertex0,           __GL_vertexData, __GL_i
  mov      __GL_vertex0.rot.x,     __GL_vertex0.orig.x
  mov      __GL_vertex0.rot.y,     __GL_vertex0.orig.y
  mov      __GL_vertex0.rot.z,     __GL_vertex0.orig.z
  brcmp    EQ,                     __GL_nbc_gl_no_actions, __GL_object.actionCount, 0
  set      __GL_j,                 0
__GL_nbc_gl_apply_next_action:
  index    __GL_k,                 __GL_object.actionList, __GL_j
  index    __GL_objectAction,      __GL_objectActionData, __GL_k
  brcmp    EQ,                     __GL_nbc_gl_apply_translate_x, __GL_objectAction.type, GL_TRANSLATE_X
  brcmp    EQ,                     __GL_nbc_gl_apply_translate_y, __GL_objectAction.type, GL_TRANSLATE_Y
  brcmp    EQ,                     __GL_nbc_gl_apply_translate_z, __GL_objectAction.type, GL_TRANSLATE_Z
  brcmp    EQ,                     __GL_nbc_gl_apply_rotate_x,    __GL_objectAction.type, GL_ROTATE_X
  brcmp    EQ,                     __GL_nbc_gl_apply_rotate_y,    __GL_objectAction.type, GL_ROTATE_Y
  brcmp    EQ,                     __GL_nbc_gl_apply_rotate_z,    __GL_objectAction.type, GL_ROTATE_Z
  brcmp    EQ,                     __GL_nbc_gl_apply_scale_x,     __GL_objectAction.type, GL_SCALE_X
  brcmp    EQ,                     __GL_nbc_gl_apply_scale_y,     __GL_objectAction.type, GL_SCALE_Y
  brcmp    EQ,                     __GL_nbc_gl_apply_scale_z,     __GL_objectAction.type, GL_SCALE_Z
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_translate_x:
  add      __GL_vertex0.rot.x,     __GL_vertex0.rot.x, __GL_objectAction.value
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_translate_y:
  add      __GL_vertex0.rot.y,     __GL_vertex0.rot.y, __GL_objectAction.value
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_translate_z:
  add      __GL_vertex0.rot.z,     __GL_vertex0.rot.z, __GL_objectAction.value
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_rotate_x:
  mul      __GL_a,                 __GL_objectAction.lcos, __GL_vertex0.rot.y
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lsin, __GL_vertex0.rot.z
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_c,                 __GL_a, __GL_b
  mul      __GL_a,                 __GL_objectAction.lsin, __GL_vertex0.rot.y
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lcos, __GL_vertex0.rot.z
  shr      __GL_b,                 __GL_b, 15
  add      __GL_d,                 __GL_a, __GL_b
  mov      __GL_vertex0.rot.y,     __GL_c
  mov      __GL_vertex0.rot.z,     __GL_d
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_rotate_y:
  mul      __GL_a,                 __GL_objectAction.lsin, __GL_vertex0.rot.z
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lcos, __GL_vertex0.rot.x
  shr      __GL_b,                 __GL_b, 15
  add      __GL_c,                 __GL_a, __GL_b
  mul      __GL_a,                 __GL_objectAction.lcos, __GL_vertex0.rot.z
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lsin, __GL_vertex0.rot.x
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_d,                 __GL_a, __GL_b
  mov      __GL_vertex0.rot.x,     __GL_c
  mov      __GL_vertex0.rot.z,     __GL_d
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_rotate_z:
  mul      __GL_a,                 __GL_objectAction.lcos, __GL_vertex0.rot.x
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lsin, __GL_vertex0.rot.y
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_c,                 __GL_a, __GL_b
  mul      __GL_a,                 __GL_objectAction.lsin, __GL_vertex0.rot.x
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lcos, __GL_vertex0.rot.y
  shr      __GL_b,                 __GL_b, 15
  add      __GL_d,                 __GL_a, __GL_b
  mov      __GL_vertex0.rot.x,     __GL_c
  mov      __GL_vertex0.rot.y,     __GL_d
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_scale_x:
  mul      __GL_vertex0.rot.x,     __GL_vertex0.rot.x, __GL_objectAction.value
  shr      __GL_vertex0.rot.x,     __GL_vertex0.rot.x, 8
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_scale_y:
  mul      __GL_vertex0.rot.y,     __GL_vertex0.rot.y, __GL_objectAction.value
  shr      __GL_vertex0.rot.y,     __GL_vertex0.rot.y, 8
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_scale_z:
  mul      __GL_vertex0.rot.z,     __GL_vertex0.rot.z, __GL_objectAction.value
  shr      __GL_vertex0.rot.z,     __GL_vertex0.rot.z, 8
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_done:
  add      __GL_j,                 __GL_j, 1
  brcmp    LT,                     __GL_nbc_gl_apply_next_action, __GL_j, __GL_object.actionCount
__GL_nbc_gl_no_actions:
  replace  __GL_vertexData,        __GL_vertexData, __GL_i, __GL_vertex0
  add      __GL_i,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_apply_next_vertex, __GL_i, __GL_object.lastVertex
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glRotateVertexList
// Description : Rotate all the vertices in the vertext list...
//-----------------------------------------------------------------------------------------
subroutine __GL_glRotateVertexList
  // update all object actions first...
  set      __GL_l,                 0
__GL_nbc_gl_rotate_objects:
  index    __GL_object,            __GL_objectData, __GL_l
  brcmp    EQ,                     __GL_nbc_gl_dont_rotate_object, __GL_object.render, FALSE
  call     __GL_glRotateObject
__GL_nbc_gl_dont_rotate_object:
  add      __GL_l,                 __GL_l, 1
  brcmp    LT,                     __GL_nbc_gl_rotate_objects, __GL_l, __GL_objectCount
  mov      __GL_saveAngleX,        __GL_angleX
  mov      __GL_saveAngleY,        __GL_angleY
  index    __GL_sinX,              __GL_SIN_TABLE, __GL_angleX
  add      __GL_angleX,            __GL_angleX, 90
  mod      __GL_angleX,            __GL_angleX, 360
  index    __GL_cosX,              __GL_SIN_TABLE, __GL_angleX
  index    __GL_sinY,              __GL_SIN_TABLE, __GL_angleY
  add      __GL_angleY,            __GL_angleY, 90
  mod      __GL_angleY,            __GL_angleY, 360
  index    __GL_cosY,              __GL_SIN_TABLE, __GL_angleY
  mov      __GL_camDepth,          __GL_glSettings.camDepth
  mov      __GL_zoom,              __GL_glSettings.zoom
  set      __GL_i,                 0
  set      __GL_vertexOffset,      0
__GL_nbc_gl_rotate_loop:
  // get the values from the vertex list...
  index    __GL_vertex0,           __GL_vertexData, __GL_vertexOffset
  mul      __GL_a,                 __GL_vertex0.rot.z, __GL_cosY
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_vertex0.rot.x, __GL_sinY
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_z1,                __GL_a, __GL_b
  mul      __GL_a,                 __GL_vertex0.rot.z, __GL_sinY
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_vertex0.rot.x, __GL_cosY
  shr      __GL_b,                 __GL_b, 15
  add      __GL_xx,                __GL_a, __GL_b
  mul      __GL_a,                 __GL_vertex0.rot.y, __GL_sinX
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_z1, __GL_cosX
  shr      __GL_b,                 __GL_b, 15
  add      __GL_zz,                __GL_a, __GL_b
  add      __GL_zz,                __GL_zz, __GL_zoom
  mul      __GL_a,                 __GL_vertex0.rot.y, __GL_cosX
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_z1, __GL_sinX
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_yy,                __GL_a, __GL_b
  // the actual screen coords...
  add      __GL_zz,                __GL_zz, __GL_camDepth
  mul      __GL_vertex0.screen.x,  __GL_xx, __GL_camDepth
  div      __GL_vertex0.screen.x,  __GL_vertex0.screen.x, __GL_zz
  add      __GL_vertex0.screen.x,  __GL_vertex0.screen.x, 50
  mul      __GL_vertex0.screen.y,  __GL_yy, __GL_camDepth
  div      __GL_vertex0.screen.y,  __GL_vertex0.screen.y, __GL_zz
  sub      __GL_vertex0.screen.y,  32, __GL_vertex0.screen.y
  // save the screen coords...
  replace  __GL_vertexData,        __GL_vertexData, __GL_vertexOffset, __GL_vertex0
  add      __GL_vertexOffset,      __GL_vertexOffset, 1
  add      __GL_i,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_rotate_loop, __GL_i, __GL_vertexCount
  mov      __GL_angleX,            __GL_saveAngleX
  mov      __GL_angleY,            __GL_saveAngleY
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glResetObjects
// Description : Reset the rotate, translate and scale actions for all objects...
//-----------------------------------------------------------------------------------------
subroutine __GL_glResetObjects
  set      __GL_glLinesClipped,     0
  brcmp    EQ,                      __GL_nbc_gl_reset_objects_error, __GL_glErrorState, TRUE
  arrinit  __GL_lineDone,           0, __GL_lineCount
  set      __GL_objectActionCount,  0
  set      __GL_i,                  0
__GL_nbc_gl_reset_actions:
  index    __GL_object,             __GL_objectData, __GL_i
  set      __GL_object.actionCount, 0
  set      __GL_object.render,      FALSE
  replace  __GL_objectData,         __GL_objectData, __GL_i, __GL_object
  add      __GL_i,                  __GL_i, 1
  brcmp    LT,                      __GL_nbc_gl_reset_actions, __GL_i, __GL_objectCount
__GL_nbc_gl_reset_objects_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glCallObject
// Description : Set the render boolean, copy the settings...
//-----------------------------------------------------------------------------------------
subroutine __GL_glCallObject
  brcmp    EQ,                     __GL_nbc_gl_call_object_error, __GL_glErrorState, TRUE
  index    __GL_object,            __GL_objectData, __GL_objectIndex
  set      __GL_object.render,     TRUE
  mov      __GL_object.cullMode,   __GL_glSettings.cullMode
  mov      __GL_object.circleSize, __GL_glSettings.circleSize
  replace  __GL_objectData,        __GL_objectData, __GL_objectIndex, __GL_object
__GL_nbc_gl_call_object_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glDrawObject
// Description : Draw the object, this routine expects the '_object' struct to be set.
//-----------------------------------------------------------------------------------------
subroutine __GL_glDrawObject
  // set once...
  mov      __GL_glDrawLine.Options,     0
  // loop through the polygon list for this object...
  mov      __GL_i,                      __GL_object.firstPolygon
__GL_nbc_gl_draw_polygons:
  // get the information for the polygon...
  index    __GL_polygon,                __GL_polygonData, __GL_i
  brcmp    EQ,                          __GL_nbc_gl_render_polygon, __GL_polygon.beginMode, GL_POLYGON
  brcmp    EQ,                          __GL_nbc_gl_render_line,    __GL_polygon.beginMode, GL_LINE
  brcmp    EQ,                          __GL_nbc_gl_render_point,   __GL_polygon.beginMode, GL_POINT
  brcmp    EQ,                          __GL_nbc_gl_render_circle,  __GL_polygon.beginMode, GL_CIRCLE
  jmp      __GL_nbc_gl_cull_polygon
  //---------------------------------------------------------------------------------------
  // Render a polygon...
  //---------------------------------------------------------------------------------------
__GL_nbc_gl_render_polygon:
  // loop through the vertex list for this polygon...
  mov      __GL_j,                      __GL_polygon.firstVertex
  mov      __GL_k,                      __GL_polygon.lastVertex
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex0,                __GL_vertexData, __GL_vertexOffset
  add      __GL_j,                      __GL_j, 1
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex1,                __GL_vertexData, __GL_vertexOffset
  add      __GL_j,                      __GL_j, 1
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex2,                __GL_vertexData, __GL_vertexOffset
  // check if culling is enabled...
  brcmp    EQ,                          __GL_nbc_gl_no_culling, __GL_object.cullMode, GL_CULL_NONE
  // calculate the culling...
  sub      __GL_a,                      __GL_vertex1.screen.x, __GL_vertex0.screen.x
  sub      __GL_b,                      __GL_vertex2.screen.y, __GL_vertex0.screen.y
  mul      __GL_c,                      __GL_a, __GL_b
  sub      __GL_d,                      __GL_vertex2.screen.x, __GL_vertex0.screen.x
  sub      __GL_e,                      __GL_vertex1.screen.y, __GL_vertex0.screen.y
  mul      __GL_f,                      __GL_d, __GL_e
  // check if culling is enabled...
  brcmp    EQ,                          __GL_nbc_gl_check_front_cull, __GL_object.cullMode, GL_CULL_FRONT
  brcmp    GTEQ,                        __GL_nbc_gl_cull_polygon, __GL_c, __GL_f
  jmp      __GL_nbc_gl_no_culling
__GL_nbc_gl_check_front_cull:
  brcmp    GTEQ,                        __GL_nbc_gl_cull_polygon, __GL_f, __GL_c
__GL_nbc_gl_no_culling:
  //--> render the lines...
  mov      __GL_j,                      __GL_polygon.firstLine
__GL_nbc_gl_draw_lines:
  index    __GL_k,                      __GL_plData, __GL_j
  // render every line only once!
  index    __GL_l,                      __GL_lineDone, __GL_k
  brcmp    EQ,                          __GL_nbc_gl_line_done, __GL_l, 1
  // set the 'done' byte...
  replace  __GL_lineDone,               __GL_lineDone, 1, __GL_l
  index    __GL_line,                   __GL_lineData, __GL_k
  index    __GL_vertex1,                __GL_vertexData, __GL_line.firstVertex
  index    __GL_vertex2,                __GL_vertexData, __GL_line.lastVertex
  // very crude clipping...
  mov      __GL_glDrawLine.StartLoc,    __GL_vertex1.screen
  mov      __GL_glDrawLine.EndLoc,      __GL_vertex2.screen
  syscall  DrawLine,                    __GL_glDrawLine
__GL_nbc_gl_line_done:
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_draw_lines, __GL_j, __GL_polygon.lastLine
  //<-- render the lines...
  jmp      __GL_nbc_gl_cull_polygon
  //---------------------------------------------------------------------------------------
  // Render lines...
  //---------------------------------------------------------------------------------------
__GL_nbc_gl_render_line:
  mov      __GL_j,                      __GL_polygon.firstLine
__GL_nbc_gl_render_lines:
  index    __GL_k,                      __GL_plData, __GL_j
  // render every line only once!
  index    __GL_l,                      __GL_lineDone, __GL_k
  brcmp    EQ,                          __GL_nbc_gl_render_lines_done, __GL_l, 1
  // set the 'done' byte...
  replace  __GL_lineDone,               __GL_lineDone, 1, __GL_l
  index    __GL_line,                   __GL_lineData, __GL_k
  index    __GL_vertex1,                __GL_vertexData, __GL_line.firstVertex
  index    __GL_vertex2,                __GL_vertexData, __GL_line.lastVertex
  mov      __GL_glDrawLine.StartLoc,    __GL_vertex1.screen
  mov      __GL_glDrawLine.EndLoc,      __GL_vertex2.screen
  syscall  DrawLine,                    __GL_glDrawLine
__GL_nbc_gl_render_lines_done:
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_render_lines, __GL_j, __GL_polygon.lastLine
  jmp      __GL_nbc_gl_cull_polygon
  //---------------------------------------------------------------------------------------
  // Render points...
  //---------------------------------------------------------------------------------------
__GL_nbc_gl_render_point:
  set      __GL_glDrawPoint.Options,    0
  mov      __GL_j,                      __GL_polygon.firstVertex
__GL_nbc_gl_render_points:
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex0,                __GL_vertexData, __GL_vertexOffset
  mov      __GL_glDrawPoint.Location,   __GL_vertex0.screen
  syscall  DrawPoint,                   __GL_glDrawPoint
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_render_points, __GL_j, __GL_polygon.lastVertex
  jmp      __GL_nbc_gl_cull_polygon
  //---------------------------------------------------------------------------------------
  // Render circle...
  //---------------------------------------------------------------------------------------
__GL_nbc_gl_render_circle:
  set      __GL_glDrawCircle.Options,   0
  mov      __GL_glDrawCircle.Size,      __GL_object.circleSize
  mov      __GL_j,                      __GL_polygon.firstVertex
__GL_nbc_gl_render_circles:
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex0,                __GL_vertexData, __GL_vertexOffset
  mov      __GL_glDrawCircle.Center,    __GL_vertex0.screen
  syscall  DrawCircle,                  __GL_glDrawCircle
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_render_circles, __GL_j, __GL_polygon.lastVertex
  jmp      __GL_nbc_gl_cull_polygon
__GL_nbc_gl_cull_polygon:
  add      __GL_i,                      __GL_i, 1
  brcmp    LT,                          __GL_nbc_gl_draw_polygons, __GL_i, __GL_object.lastPolygon
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glRenderObjects
// Description : Draw all objects which have been called...
//-----------------------------------------------------------------------------------------
subroutine __GL_glRenderObjects
  brcmp    EQ,                          __GL_nbc_gl_render_objects_error, __GL_glErrorState, TRUE
  set      __GL_objectIndex,            0
__GL_nbc_gl_render_objects:
  // get the information for the object...
  index    __GL_object,                 __GL_objectData, __GL_objectIndex
  brcmp    EQ,                          __GL_nbc_gl_dont_render_object, __GL_object.render, FALSE
  call     __GL_glDrawObject
__GL_nbc_gl_dont_render_object:
  add      __GL_objectIndex,            __GL_objectIndex, 1
  brcmp    LT,                          __GL_nbc_gl_render_objects, __GL_objectIndex, __GL_objectCount
  return
__GL_nbc_gl_render_objects_error:
  // Display the error message...
  set       __GL_glDrawData.Options,    1
  set       __GL_glDrawData.Location.X, 0
  set       __GL_glDrawData.Location.Y, 56
  mov       __GL_glDrawData.Text,       'Error:'
  syscall   DrawText,                   __GL_glDrawData
  set       __GL_glDrawData.Options,    0
  set       __GL_glDrawData.Location.Y, 48
  mov       __GL_glDrawData.Text,       __GL_glErrorMsg
  syscall   DrawText,                   __GL_glDrawData
  return
ends

dseg segment
  __GL_tmpId             byte
  __GL_mode              byte
  __GL_sizeX             sdword
  __GL_sizeY             sdword
  __GL_sizeZ             sdword
  __GL_angle             sdword
dseg ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glBox
// Description : Add a box with the dimensions: _sizeX, _sizeY, _sizeZ.
//               Use mode _mode.
//-----------------------------------------------------------------------------------------
subroutine __GL_glBox
  shr      __GL_x1,                    __GL_sizeX, 1
  neg      __GL_x0,                    __GL_x1
  shr      __GL_y1,                    __GL_sizeY, 1
  neg      __GL_y0,                    __GL_y1
  shr      __GL_z1,                    __GL_sizeZ, 1
  neg      __GL_z0,                    __GL_z1
  __glBeginObject(__GL_tmpId)
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z0)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z0)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z0)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z1)
    __glEnd()

    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z0)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z0)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z0)
    __glEnd()

    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z0)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z0)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z0)
    __glEnd()
  __glEndObject()
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glPyramid
// Description : Add a pyramid with the dimensions: _sizeX, _sizeY, _sizeZ.
//               Use mode _mode.
//-----------------------------------------------------------------------------------------
subroutine __GL_glPyramid
  shr      __GL_x1,                    __GL_sizeX, 1
  neg      __GL_x0,                    __GL_x1
  shr      __GL_z1,                    __GL_sizeZ, 1
  neg      __GL_z0,                    __GL_z1
  neg      __GL_y0,                    __GL_sizeY
  __glBeginObject(__GL_tmpId)
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, 0, __GL_z0)
      __glAddVertex(__GL_x1, 0, __GL_z1)
      __glAddVertex(__GL_x0, 0, __GL_z1)
      __glAddVertex(__GL_x0, 0, __GL_z0)
    __glEnd()

    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, 0,   __GL_z0)
      __glAddVertex(__GL_x0, 0,   __GL_z1)
      __glAddVertex(0,   __GL_y0, 0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, 0,   __GL_z1)
      __glAddVertex(__GL_x1, 0,   __GL_z0)
      __glAddVertex(0,   __GL_y0, 0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, 0,   __GL_z0)
      __glAddVertex(__GL_x0, 0,   __GL_z0)
      __glAddVertex(0,   __GL_y0, 0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, 0,   __GL_z1)
      __glAddVertex(__GL_x1, 0,   __GL_z1)
      __glAddVertex(0,   __GL_y0, 0)
    __glEnd()
  __glEndObject()
  return
ends

#endif

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
#define glInit() __glInit()

/**
 * Set graphics library options.
 * Adjust graphic library settings for circle size and cull mode.
 *
 * \param _glType The setting type.  See \ref GLConstantsSettings.
 * \param _glValue The setting value. For culling modes see \ref GLConstantsCullMode.
 */
#define glSet(_glType, _glValue) __glSet(_glType, _glValue)

/**
 * Begin defining an object.
 * Start the process of defining a graphics library object using low level
 * functions such as \ref glBegin, \ref glAddVertex, and \ref glEnd.
 *
 * \param _glObjId The object index of the new object being created.
 */
#define glBeginObject(_glObjId) __glBeginObject(_glObjId)

/**
 * Stop defining an object.
 * Finish the process of defining a graphics library object.  Call this function
 * after you have completed the object definition.
 */
#define glEndObject() __glEndObject()

/**
 * Perform an object action.
 * Execute the specified action on the specified object.
 *
 * \param _glObjectId The object id.
 * \param _glAction The action to perform on the object. See \ref GLConstantsActions.
 * \param _glValue The setting value.
 */
#define glObjectAction(_glObjectId, _glAction, _glValue) __glObjectAction(_glObjectId, _glAction, _glValue)

/**
 * Add a vertex to an object.
 * Add a vertex to an object currently being defined.  This function should
 * only be used between \ref glBegin and \ref glEnd which are themselves
 * nested within a \ref glBeginObject and \ref glEndObject pair.
 *
 * \param _glX The X axis coordinate.
 * \param _glY The Y axis coordinate.
 * \param _glZ The Z axis coordinate.
 */
#define glAddVertex(_glX, _glY, _glZ) __glAddVertex(_glX, _glY, _glZ)

/**
 * Begin a new polygon for the current object.
 * Start defining a polygon surface for the current graphics object using
 * the specified begin mode.
 *
 * \param _glBeginMode The desired mode.  See \ref GLConstantsBeginModes.
 */
#define glBegin(_glBeginMode) __glBegin(_glBeginMode)

/**
 * Finish a polygon for the current object.
 * Stop defining a polgyon surface for the current graphics object.
 */
#define glEnd() __glEnd()

/**
 * Begin a new render.
 * Start the process of rendering the existing graphic objects.
 */
#define glBeginRender() __glBeginRender()

/**
 * Call a graphic object.
 * Tell the graphics library that you want it to include the specified
 * object in the render.
 *
 * \param _glObjectId The desired object id.
 */
#define glCallObject(_glObjectId) __glCallObject(_glObjectId)

/**
 * Finish the current render.
 * Rotate the vertex list, clear the screen, and draw the rendered objects
 * to the LCD.
 */
#define glFinishRender() __glFinishRender()

/**
 * Set the X axis angle.
 * Set the X axis angle to the specified value.
 *
 * \param _glValue The new X axis angle.
 */
#define glSetAngleX(_glValue) __glSetAngleX(_glValue)

/**
 * Add to the X axis angle.
 * Add the specified value to the existing X axis angle.
 *
 * \param _glValue The value to add to the X axis angle.
 */
#define glAddToAngleX(_glValue) __glAddToAngleX(_glValue)

/**
 * Set the Y axis angle.
 * Set the Y axis angle to the specified value.
 *
 * \param _glValue The new Y axis angle.
 */
#define glSetAngleY(_glValue) __glSetAngleY(_glValue)

/**
 * Add to the Y axis angle.
 * Add the specified value to the existing Y axis angle.
 *
 * \param _glValue The value to add to the Y axis angle.
 */
#define glAddToAngleY(_glValue) __glAddToAngleY(_glValue)

/**
 * Set the Z axis angle.
 * Set the Z axis angle to the specified value.
 *
 * \param _glValue The new Z axis angle.
 */
#define glSetAngleZ(_glValue) __glSetAngleZ(_glValue)

/**
 * Add to the Z axis angle.
 * Add the specified value to the existing Z axis angle.
 *
 * \param _glValue The value to add to the Z axis angle.
 */
#define glAddToAngleZ(_glValue) __glAddToAngleZ(_glValue)

/**
 * Table-based sine scaled by 32768.
 * Return the sine of the specified angle in degrees.  The result is scaled
 * by 32768.
 *
 * \param _glAngle The angle in degrees.
 * \param _glResult The sine value scaled by 32768.
 */
#define glSin32768(_glAngle, _glResult) __glSin32768(_glAngle, _glResult)

/**
 * Table-based cosine scaled by 32768.
 * Return the cosine of the specified angle in degrees.  The result is scaled
 * by 32768.
 *
 * \param _glAngle The angle in degrees.
 * \param _glResult The cosine value scaled by 32768.
 */
#define glCos32768(_glAngle, _glResult) __glCos32768(_glAngle, _glResult)

/**
 * Create a 3D box.
 * Define a 3D box using the specified begin mode for all faces. The center
 * of the box is at the origin of the XYZ axis with width, height, and depth
 * specified via the glSizeX, glSizeY, and glSizeZ parameters.
 *
 * \param _glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param _glSizeX The X axis size (width).
 * \param _glSizeY The Y axis size (height).
 * \param _glSizeZ The Z axis size (depth).
 * \param _glObjId The object ID of the new object.
 */
#define glBox(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId) __glBox(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId)

/**
 * Create a 3D cube.
 * Define a 3D cube using the specified begin mode for all faces. The center
 * of the box is at the origin of the XYZ axis with equal width, height, and depth
 * specified via the glSize parameter.
 *
 * \param _glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param _glSize The cube's width, height, and depth.
 * \param _glObjId The object ID of the new object.
 */
#define glCube(_glMode, _glSize, _glObjId) __glBox(_glMode, _glSize, _glSize, _glSize, _glObjId)

/**
 * Create a 3D pyramid.
 * Define a 3D pyramid using the specified begin mode for all faces. The center
 * of the pyramid is at the origin of the XYZ axis with width, height, and depth
 * specified via the glSizeX, glSizeY, and glSizeZ parameters.
 *
 * \param _glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param _glSizeX The X axis size (width).
 * \param _glSizeY The Y axis size (height).
 * \param _glSizeZ The Z axis size (depth).
 * \param _glObjId The object ID of the new object.
 */
#define glPyramid(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId) __glPyramid(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId)

/** @} */ // end of GraphicsLibrary group

#endif // NBC_GL_H
