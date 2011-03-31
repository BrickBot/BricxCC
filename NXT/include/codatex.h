/** \file codatex.h
 * \brief The NXC Codatex API
 *
 * codatex.h contains the NXC Codatex API
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

#ifndef CODATEX_H
#define CODATEX_H

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Codatex API ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup CodatexAPI
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * RFIDInit function.
 * Initialize the Codatex RFID sensor.
 *
 * \param port The port to which the Codatex RFID sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \return The boolean function call result.
 */
inline bool RFIDInit(const byte & port);

/**
 * RFIDMode function.
 * Configure the Codatex RFID sensor mode.
 *
 * \param port The port to which the Codatex RFID sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param mode The RFID sensor mode.  See the \ref CTRFIDModeConstants group.
 * \return The boolean function call result.
 */
inline bool RFIDMode(const byte & port, const byte & mode);

/**
 * RFIDStatus function.
 * Read the Codatex RFID sensor status.
 *
 * \param port The port to which the Codatex RFID sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \return The RFID sensor status.
 */
inline byte RFIDStatus(const byte & port);

/**
 * RFIDRead function.
 * Read the Codatex RFID sensor value.
 *
 * \param port The port to which the Codatex RFID sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param output The five bytes of RFID data.
 * \return The boolean function call result.
 */
inline bool RFIDRead(const byte & port, byte & output[]);

/**
 * RFIDStop function.
 * Stop the Codatex RFID sensor.
 *
 * \param port The port to which the Codatex RFID sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \return The boolean function call result.
 */
inline bool RFIDStop(const byte & port);

/**
 * RFIDReadSingle function.
 * Set the Codatex RFID sensor into single mode and read the RFID data.
 *
 * \param port The port to which the Codatex RFID sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param output The five bytes of RFID data.
 * \return The boolean function call result.
 */
inline bool RFIDReadSingle(const byte & port, byte & output[]);

/**
 * RFIDReadContinuous function.
 * Set the Codatex RFID sensor into continuous mode, if necessary, and read
 * the RFID data.
 *
 * \param port The port to which the Codatex RFID sensor is attached. See the
 * \ref InPorts group. You may use a constant or a variable.
 * \param output The five bytes of RFID data.
 * \return The boolean function call result.
 */
inline bool RFIDReadContinuous(const byte & port, byte & output[]);

#else

#define RFIDInit(_port) asm { __RFIDInit(_port, __RETVAL__) }
#define RFIDMode(_port, _mode) asm { __RFIDMode(_port, _mode, __RETVAL__) }
#define RFIDStatus(_port) asm { __RFIDStatus(_port, __RETVAL__) }
#define RFIDRead(_port, _output) asm { __RFIDRead(_port, _output, __RETVAL__) }
#define RFIDStop(_port) asm { __RFIDStop(_port, __RETVAL__) }
#define RFIDReadSingle(_port, _output) asm { __RFIDReadSingle(_port, _output, __RETVAL__) }
#define RFIDReadContinuous(_port, _output) asm { __RFIDReadContinuous(_port, _output, __RETVAL__) }

#endif

/** @} */ // end of CodatexAPI group

#endif // CODATEX_H
