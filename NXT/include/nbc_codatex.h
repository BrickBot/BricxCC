/** \file nbc_codatex.h
 * \brief The NBC Codatex API
 *
 * nbc_codatex.h contains the NBC Codatex API
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

#ifndef NBC_CODATEX_H
#define NBC_CODATEX_H

#include "codatex_constants.h"
#include "nbc_lowspeed.h"

///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// Codatex API ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup CodatexAPI
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

dseg segment
  __RLSBbufRFIDInit byte[] 0x04, 0x32
  __RLSBbufRFIDData byte[] 0x04, 0x42
  __RFIDCount byte
  __RFIDCont_Port byte
  __RFIDCont_Result byte
  __RFIDCont_Output byte[]
  __RFIDmutex mutex
dseg ends

#define __RFIDInit(_port, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufRFIDInit \
  set __RLSBytesCountVar, 0 \
  set __RLSPadVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufRFIDInit \
  set __RLSBytesCount##_port, 0 \
  set __RLSPad##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

#define __RFIDMode(_port, _mode, _result) __I2CSendCmd(_port, 0x04, _mode, _result)
#define __RFIDStatus(_port, _result) __I2CReadValue(_port, 0x04, 0x32, 1, _result, __RDSD_LSStatus)
#define __RFIDRead(_port, _output, _result) \
  set __RFIDCount, 5 \
  __ReadI2CBytes(_port, __RLSBbufRFIDData, __RFIDCount, _output, _result)

#define __RFIDStop(_port, _result) \
  __RFIDInit(_port, _result) \
  wait 10 \
  __RFIDMode(_port, RFID_MODE_STOP, _result)

#define __RFIDReadSingle(_port, _output, _result) \
  __RFIDInit(_port, _result) \
  wait 15 \
  __RFIDMode(_port, RFID_MODE_SINGLE, _result) \
  wait 250 \
  __RFIDRead(_port, _output, _result)

#define __RFIDReadContinuous(_port, _output, _result) \
  acquire __RFIDmutex \
  mov __RFIDCont_Port, _port \
  call __RFIDReadContinuousSub \
  mov _output, __RFIDCont_Output \
  mov _result, __RFIDCont_Result \
  release __RFIDmutex

subroutine __RFIDReadContinuousSub
  __RFIDInit(__RFIDCont_Port, __RFIDCont_Result)
  wait 15
  __RFIDStatus(__RFIDCont_Port, __RFIDCont_Result)
  brtst GT, __RFIDCont_Endif, __RFIDCont_Result
  __RFIDMode(__RFIDCont_Port, RFID_MODE_CONTINUOUS, __RFIDCont_Result)
  wait 250
__RFIDCont_Endif:
  __RFIDRead(__RFIDCont_Port, __RFIDCont_Output, __RFIDCont_Result)
  return
ends

#endif

// Codatex RFID functions

/**
 * RFIDInit function.
 * Initialize the Codatex RFID sensor.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The boolean function call result.
 */
#define RFIDInit(_port, _result) __RFIDInit(_port, _result)

/**
 * RFIDMode function.
 * Configure the Codatex RFID sensor mode.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _mode The RFID sensor mode.  See the \ref CTRFIDModeConstants group.
 * \param _result The boolean function call result.
 */
#define RFIDMode(_port, _mode, _result) __RFIDMode(_port, _mode, _result)

/**
 * RFIDStatus function.
 * Read the Codatex RFID sensor status.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The RFID sensor status.
 */
#define RFIDStatus(_port, _result) __RFIDStatus(_port, _result)

/**
 * RFIDRead function.
 * Read the Codatex RFID sensor value.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _output The five bytes of RFID data.
 * \param _result The boolean function call result.
 */
#define RFIDRead(_port, _output, _result) __RFIDRead(_port, _output, _result)

/**
 * RFIDStop function.
 * Stop the Codatex RFID sensor.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The boolean function call result.
 */
#define RFIDStop(_port, _result) __RFIDStop(_port, _result)

/**
 * RFIDReadSingle function.
 * Set the Codatex RFID sensor into single mode and read the RFID data.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _output The five bytes of RFID data.
 * \param _result The boolean function call result.
 */
#define RFIDReadSingle(_port, _output, _result) __RFIDReadSingle(_port, _output, _result)

/**
 * RFIDReadContinuous function.
 * Set the Codatex RFID sensor into continuous mode, if necessary, and read
 * the RFID data.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _output The five bytes of RFID data.
 * \param _result The boolean function call result.
 */
#define RFIDReadContinuous(_port, _output, _result) __RFIDReadContinuous(_port, _output, _result)

/** @} */  // end of CodatexAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // NBC_CODATEX_H
