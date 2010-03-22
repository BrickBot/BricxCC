/** \file NXCAPIDocs.h
 * \brief Additional documentation for the NXC API
 *
 * NXCAPIDocs.h contains additional documentation for the NXC API
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
 * \date 2010-03-04
 * \version 1
 */
#ifndef NXCAPIDOCS_H
#define NXCAPIDOCS_H

/** @defgroup NXTFirmwareModules NXT Firmware Modules
 * Documentation common to all NXT firmware modules.
 */

/** @defgroup InputModule Input module
 * Constants and functions related to the Input module.
 *
 * The NXT input module encompasses all sensor inputs except for digital
 * I2C (LowSpeed) sensors.
 *
 * There are four sensors, which internally are numbered 0, 1, 2, and 3.
 * This is potentially confusing since they are externally labeled on the NXT
 * as sensors 1, 2, 3, and 4. To help mitigate this confusion, the sensor port
 * names \ref S1, \ref S2, \ref S3, and \ref S4 have been defined.  See \ref InPorts.
 * These sensor names may be used in any function that requires a sensor port
 * as an argument. Alternatively, the NBC port name constants
 * \ref IN_1, \ref IN_2, \ref IN_3, and \ref IN_4 may also be used when
 * a sensor port is required. See \ref NBCInputPortConstants.
 * Sensor value names SENSOR_1, SENSOR_2, SENSOR_3, and SENSOR_4 have also
 * been defined. These names may also be used whenever a program wishes to
 * read the current value of the analog sensor:
 * \code
 * x = SENSOR_1; // read sensor and store value in x
 * \endcode
 */

/** @defgroup InputModuleConstants Input module constants
 * Constants that are part of the NXT firmware's Input module.
 */

/** @defgroup OutputModule Output module
 * Constants and functions related to the Output module.
 */

/** @defgroup OutputModuleConstants Output module constants
 * Constants that are part of the NXT firmware's Output module.
 */

/** @defgroup CommandModule Command module
 * Constants and functions related to the Command module.
 */

/** @defgroup CommandModuleConstants Command module constants
 * Constants that are part of the NXT firmware's Command module.
 */

/** @defgroup CommModule Comm module
 * Constants and functions related to the Comm module.
 */

/** @defgroup ButtonModule Button module
 * Constants and functions related to the Button module.
 */

/** @defgroup IOCtrlModule IOCtrl module
 * Constants and functions related to the IOCtrl module.
 */

/** @defgroup LoaderModule Loader module
 * Constants and functions related to the Loader module.
 */

/** @defgroup SoundModule Sound module
 * Constants and functions related to the Sound module.
 */

/** @defgroup UiModule Ui module
 * Constants and functions related to the Ui module.
 */

/** @defgroup LowSpeedModule Low Speed module
 * Constants and functions related to the Low Speed module.
 */

/** @defgroup DisplayModule Display module
 * Constants and functions related to the Display module.
 */

/** @defgroup HiTechnicAPI HiTechnic API Functions
 * Functions for accessing and modifying HiTechnic devices.
 */

/** @defgroup MindSensorsAPI MindSensors API Functions
 * Functions for accessing and modifying MindSensors devices.
 */

/** @defgroup RICMacros RIC Macro Wrappers
 * Macro wrappers for use in defining RIC byte arrays.
 */

/** @defgroup ModuleNameConstants NXT firmware module names
 * Constant string names for all the NXT firmware modules.
 */
 
/** @defgroup ModuleIDConstants NXT firmware module IDs
 * Constant numeric IDs for all the NXT firmware modules.
 */

/** @defgroup MiscConstants Miscellaneous NBC/NXC constants
 * Miscellaneous constants for use in NBC and NXC.
 */

/** @defgroup ThirdPartyDevices Third-party NXT devices
 * Documentation for NXT devices made by companies other than LEGO such
 * as HiTechnic, mindsensors.com, and CodaTex.
 */

/** @defgroup StandardCAPIFunctions Standard-C API functions
 * Documentation for various Standard-C library routines.
 */

#include "NXCDefs.h"

#endif // NXCAPIDOCS_H
