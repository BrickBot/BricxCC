/** \file nxcgps.h
 * \brief NXC GPS API
 *
 * nxcgps.h contains the NXC GPS library API
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
#ifndef NXCGPS_H
#define NXCGPS_H

/** @addtogroup GPSLibrary
 * @{
 */

#include "cmath.h"

//calculate haversine distance for linear distance
float GPSDistance(float lat1, float long1, float lat2, float long2)
{
    float dlong = (long2 - long1) * RADIANS_PER_DEGREE;
    float dlat = (lat2 - lat1) * RADIANS_PER_DEGREE;
    float a = pow(sin(dlat/2.0), 2) + cos(lat1*d2r) * cos(lat2*d2r) * pow(sin(dlong/2.0), 2);
    float c = 2 * atan2(sqrt(a), sqrt(1-a));
    float d = 6367000 * c;

    return d;
}

/** @} */ // end of GPSLibrary group

#endif // NXCGPS_H
