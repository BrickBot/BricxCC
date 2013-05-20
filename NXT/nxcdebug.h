/** \file nxcdebug.h
 * \brief debug API for NXC
 *
 * nxcdebug.h contains declarations for the NXC Debug API resources
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
 * Portions created by John Hansen are Copyright (C) 2012 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2012-02-06
 * \version 1
 */
#ifndef NXCDEBUG_H
#define NXCDEBUG_H

#include "NBCCommon.h"

bool __nxc_DebuggingActive = false;

task __nxc_debug_task()
{
  __nxc_DebuggingActive = true;
  while (__nxc_DebuggingActive)
  {
    // this task writes data to the USBPoll buffer if there is room
    //USBPollBufferInPtr
    //USBPollBufferOutPtr
//inline void SetUSBPollBuffer(const byte offset, byte cnt, byte data[]);
//inline void SetUSBPollBufferInPtr(byte n);
//inline void SetUSBPollBufferOutPtr(byte n);
  }
}

inline void StartDebugging() { if (!__nxc_DebuggingActive) start __nxc_debug_task; }
inline void StopDebugging() { __nxc_DebuggingActive = false; }



#endif // NXCDEBUG_H
