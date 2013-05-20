/** \file ricmacro.h
 * \brief The NXC RIC macro API
 *
 * ricmacro.h contains the NXC RIC macro API
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

#ifndef RICMACRO_H
#define RICMACRO_H

/** @addtogroup RICMacros
 * @{
 */
/**
 * Set the value of an element in an RIC data array.
 * \param _data The RIC data array
 * \param _idx The array index to update
 * \param _newval The new value to write into the RIC data array
 */
#define RICSetValue(_data, _idx, _newval) _data[(_idx)] = (_newval)&0xFF; _data[(_idx)+1] = (_newval)>>8
/** @} */ // end of RICMacros group

#endif // RICMACRO_H
