/** \file nbc_output.h
 * \brief The NBC output module API
 *
 * nbc_output.h contains the NBC output module API
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
 * \date 2013-03-03
 * \version 3
 */

#ifndef NBC_OUTPUT_H
#define NBC_OUTPUT_H

#include "output_constants.h"

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// OUTPUT MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup OutputModule
 * @{
 */
/** @defgroup OutputModuleFunctions Output module functions
 * Functions for accessing and modifying output module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0


// motor arrays (compiler will optimize these out if they are not used)
dseg segment
  __OUT_AB byte[] OUT_A, OUT_B
  __OUT_AC byte[] OUT_A, OUT_C
  __OUT_BC byte[] OUT_B, OUT_C
  __OUT_ABC byte[] OUT_A, OUT_B, OUT_C
  __OnRev_Tmp sbyte
  __OnRevMutex mutex
dseg ends

dseg segment
  __rotateMutex0 mutex
  __rotateMutex1 mutex
  __rotateMutex2 mutex
dseg ends

dseg segment
// variables for rotate motor subroutine (0)
  __rotate_power0 byte
  __rotate_angle0 slong
  __rotate_ports0 byte[]
  __rotate_firstPort0 byte
  __rotate_sync0 byte
  __rotate_stop0 byte
  __rotate_turnpct0 sbyte
  __rotate_theUF0 byte
  __rotate_theOM0 byte
  __rotate_theRM0 byte
  __rotate_theRS0 byte
  __rotate_theRVP0 byte
  __rotate_theRVI0 byte
  __rotate_theRVD0 byte
  __rotate_rs0 byte
  __rotate_OldRotCount0 sword
  __rotate_RotCount0 sword
  __rotate_thePower0 sbyte
  __rotate_theAngle0 ulong
  __rotate_theTurnPct0 sbyte
  __rotate_then0 dword
  __rotate_now0 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (1)
  __rotate_power1 byte
  __rotate_angle1 slong
  __rotate_ports1 byte[]
  __rotate_firstPort1 byte
  __rotate_sync1 byte
  __rotate_stop1 byte
  __rotate_turnpct1 sbyte
  __rotate_theUF1 byte
  __rotate_theOM1 byte
  __rotate_theRM1 byte
  __rotate_theRS1 byte
  __rotate_theRVP1 byte
  __rotate_theRVI1 byte
  __rotate_theRVD1 byte
  __rotate_rs1 byte
  __rotate_OldRotCount1 sword
  __rotate_RotCount1 sword
  __rotate_thePower1 sbyte
  __rotate_theAngle1 ulong
  __rotate_theTurnPct1 sbyte
  __rotate_then1 dword
  __rotate_now1 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (2)
  __rotate_power2 byte
  __rotate_angle2 slong
  __rotate_ports2 byte[]
  __rotate_firstPort2 byte
  __rotate_sync2 byte
  __rotate_stop2 byte
  __rotate_turnpct2 sbyte
  __rotate_theUF2 byte
  __rotate_theOM2 byte
  __rotate_theRM2 byte
  __rotate_theRS2 byte
  __rotate_theRVP2 byte
  __rotate_theRVI2 byte
  __rotate_theRVD2 byte
  __rotate_rs2 byte
  __rotate_OldRotCount2 sword
  __rotate_RotCount2 sword
  __rotate_thePower2 sbyte
  __rotate_theAngle2 ulong
  __rotate_theTurnPct2 sbyte
  __rotate_then2 dword
  __rotate_now2 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (3)
  __rotate_power3 byte
  __rotate_angle3 slong
  __rotate_ports3 byte[]
  __rotate_firstPort3 byte
  __rotate_sync3 byte
  __rotate_stop3 byte
  __rotate_turnpct3 sbyte
  __rotate_theUF3 byte
  __rotate_theOM3 byte
  __rotate_theRM3 byte
  __rotate_theRS3 byte
  __rotate_theRVP3 byte
  __rotate_theRVI3 byte
  __rotate_theRVD3 byte
  __rotate_rs3 byte
  __rotate_OldRotCount3 sword
  __rotate_RotCount3 sword
  __rotate_thePower3 sbyte
  __rotate_theAngle3 ulong
  __rotate_theTurnPct3 sbyte
  __rotate_then3 dword
  __rotate_now3 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (4)
  __rotate_power4 byte
  __rotate_angle4 slong
  __rotate_ports4 byte[]
  __rotate_firstPort4 byte
  __rotate_sync4 byte
  __rotate_stop4 byte
  __rotate_turnpct4 sbyte
  __rotate_theUF4 byte
  __rotate_theOM4 byte
  __rotate_theRM4 byte
  __rotate_theRS4 byte
  __rotate_theRVP4 byte
  __rotate_theRVI4 byte
  __rotate_theRVD4 byte
  __rotate_rs4 byte
  __rotate_OldRotCount4 sword
  __rotate_RotCount4 sword
  __rotate_thePower4 sbyte
  __rotate_theAngle4 ulong
  __rotate_theTurnPct4 sbyte
  __rotate_then4 dword
  __rotate_now4 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (5)
  __rotate_power5 byte
  __rotate_angle5 slong
  __rotate_ports5 byte[]
  __rotate_firstPort5 byte
  __rotate_sync5 byte
  __rotate_stop5 byte
  __rotate_turnpct5 sbyte
  __rotate_theUF5 byte
  __rotate_theOM5 byte
  __rotate_theRM5 byte
  __rotate_theRS5 byte
  __rotate_theRVP5 byte
  __rotate_theRVI5 byte
  __rotate_theRVD5 byte
  __rotate_rs5 byte
  __rotate_OldRotCount5 sword
  __rotate_RotCount5 sword
  __rotate_thePower5 sbyte
  __rotate_theAngle5 ulong
  __rotate_theTurnPct5 sbyte
  __rotate_then5 dword
  __rotate_now5 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (6)
  __rotate_power6 byte
  __rotate_angle6 slong
  __rotate_ports6 byte[]
  __rotate_firstPort6 byte
  __rotate_sync6 byte
  __rotate_stop6 byte
  __rotate_turnpct6 sbyte
  __rotate_theUF6 byte
  __rotate_theOM6 byte
  __rotate_theRM6 byte
  __rotate_theRS6 byte
  __rotate_theRVP6 byte
  __rotate_theRVI6 byte
  __rotate_theRVD6 byte
  __rotate_rs6 byte
  __rotate_OldRotCount6 sword
  __rotate_RotCount6 sword
  __rotate_thePower6 sbyte
  __rotate_theAngle6 ulong
  __rotate_theTurnPct6 sbyte
  __rotate_then6 dword
  __rotate_now6 dword
dseg ends

#define UF_UPDATE_ONFWD 0x28

// API macros
#define __resetMotorCounter0(_val) setout OUT_A, UpdateFlagsField, _val
#define __resetMotorCounter1(_val) setout OUT_B, UpdateFlagsField, _val
#define __resetMotorCounter2(_val) setout OUT_C, UpdateFlagsField, _val
#define __resetMotorCounter3(_val) setout __OUT_AB, UpdateFlagsField, _val
#define __resetMotorCounter4(_val) setout __OUT_AC, UpdateFlagsField, _val
#define __resetMotorCounter5(_val) setout __OUT_BC, UpdateFlagsField, _val
#define __resetMotorCounter6(_val) setout __OUT_ABC, UpdateFlagsField, _val

#define __resetTachoCount(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlagsField, RESET_COUNT \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_COUNT) \
  compend

#define __resetBlockTachoCount(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlagsField, RESET_BLOCK_COUNT \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_BLOCK_COUNT) \
  compend

#define __resetRotationCount(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlagsField, RESET_ROTATION_COUNT \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_ROTATION_COUNT) \
  compend

#define __resetAllTachoCounts(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlagsField, RESET_ALL \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_ALL) \
  compend

#define __onFwdExPIDAll(_ports, _pwr, _reset, _p, _i, _d) setout _ports, PowerField, _pwr, OutputModeField, OUT_MODE_MOTORON+OUT_MODE_BRAKE, RegModeField, OUT_REGMODE_IDLE, RunStateField, OUT_RUNSTATE_RUNNING, TurnRatioField, 0, TachoLimitField, 0, RegPValueField, _p, RegIValueField, _i, RegDValueField, _d, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __onFwdExPID0(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(OUT_A, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID1(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(OUT_B, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID2(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(OUT_C, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID3(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_AB, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID4(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_AC, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID5(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_BC, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID6(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_ABC, _pwr, _reset, _p, _i, _d)

#define __coastExAll(_ports, _reset) setout _ports, PowerField, 0, OutputModeField, OUT_MODE_BRAKE, RegModeField, OUT_REGMODE_IDLE, RunStateField, OUT_RUNSTATE_IDLE, TurnRatioField, 0, TachoLimitField, 0, RegPValueField, PID_3, RegIValueField, PID_1, RegDValueField, PID_1, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __coastEx0(_reset) __coastExAll(OUT_A, _reset)
#define __coastEx1(_reset) __coastExAll(OUT_B, _reset)
#define __coastEx2(_reset) __coastExAll(OUT_C, _reset)
#define __coastEx3(_reset) __coastExAll(__OUT_AB, _reset)
#define __coastEx4(_reset) __coastExAll(__OUT_AC, _reset)
#define __coastEx5(_reset) __coastExAll(__OUT_BC, _reset)
#define __coastEx6(_reset) __coastExAll(__OUT_ABC, _reset)

#define __offExAll(_ports, _reset) setout _ports, PowerField, 0, OutputModeField, OUT_MODE_MOTORON+OUT_MODE_BRAKE, RegModeField, OUT_REGMODE_IDLE, RunStateField, OUT_RUNSTATE_RUNNING, TurnRatioField, 0, TachoLimitField, 0, RegPValueField, PID_3, RegIValueField, PID_1, RegDValueField, PID_1, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __offEx0(_reset) __offExAll(OUT_A, _reset)
#define __offEx1(_reset) __offExAll(OUT_B, _reset)
#define __offEx2(_reset) __offExAll(OUT_C, _reset)
#define __offEx3(_reset) __offExAll(__OUT_AB, _reset)
#define __offEx4(_reset) __offExAll(__OUT_AC, _reset)
#define __offEx5(_reset) __offExAll(__OUT_BC, _reset)
#define __offEx6(_reset) __offExAll(__OUT_ABC, _reset)

#define __onFwdRegExPIDAll(_ports, _pwr, _regmode, _reset, _p, _i, _d) setout _ports, PowerField, _pwr, OutputModeField, OUT_MODE_MOTORON+OUT_MODE_REGULATED+OUT_MODE_BRAKE, RegModeField, _regmode, RunStateField, OUT_RUNSTATE_RUNNING, TurnRatioField, 0, TachoLimitField, 0, RegPValueField, _p, RegIValueField, _i, RegDValueField, _d, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __onFwdRegExPID0(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(OUT_A, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID1(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(OUT_B, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID2(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(OUT_C, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID3(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_AB, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID4(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_AC, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID5(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_BC, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID6(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_ABC, _pwr, _regmode, _reset, _p, _i, _d)

#define __onFwdSyncExPIDAll(_ports, _pwr, _turnpct, _reset, _p, _i, _d) setout _ports, PowerField, _pwr, OutputModeField, OUT_MODE_MOTORON+OUT_MODE_REGULATED+OUT_MODE_BRAKE, RegModeField, OUT_REGMODE_SYNC, TurnRatioField, _turnpct, RunStateField, OUT_RUNSTATE_RUNNING, TachoLimitField, 0, RegPValueField, _p, RegIValueField, _i, RegDValueField, _d, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __onFwdSyncExPID0(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(OUT_A, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID1(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(OUT_B, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID2(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(OUT_C, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID3(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_AB, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID4(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_AC, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID5(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_BC, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID6(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_ABC, _pwr, _turnpct, _reset, _p, _i, _d)

#define __rotateMotorExPID0(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   arrbuild __rotate_ports0, OUT_A \
   mov __rotate_power0, _pwr \
   mov __rotate_angle0, _angle \
   mov __rotate_turnpct0, _turnpct \
   mov __rotate_sync0, _bSync \
   mov __rotate_stop0, _bStop \
   mov __rotate_theRVP0, _p \
   mov __rotate_theRVI0, _i \
   mov __rotate_theRVD0, _d \
   call __RotateMotor0 \
   release __rotateMutex0

#define __rotateMotorExPID1(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex1 \
   arrbuild __rotate_ports1, OUT_B \
   mov __rotate_power1, _pwr \
   mov __rotate_angle1, _angle \
   mov __rotate_turnpct1, _turnpct \
   mov __rotate_sync1, _bSync \
   mov __rotate_stop1, _bStop \
   mov __rotate_theRVP1, _p \
   mov __rotate_theRVI1, _i \
   mov __rotate_theRVD1, _d \
   call __RotateMotor1 \
   release __rotateMutex1

#define __rotateMotorExPID2(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex2 \
   arrbuild __rotate_ports2, OUT_C \
   mov __rotate_power2, _pwr \
   mov __rotate_angle2, _angle \
   mov __rotate_turnpct2, _turnpct \
   mov __rotate_sync2, _bSync \
   mov __rotate_stop2, _bStop \
   mov __rotate_theRVP2, _p \
   mov __rotate_theRVI2, _i \
   mov __rotate_theRVD2, _d \
   call __RotateMotor2 \
   release __rotateMutex2

#define __rotateMotorExPID3(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   acquire __rotateMutex1 \
   mov __rotate_ports3, __OUT_AB \
   mov __rotate_power3, _pwr \
   mov __rotate_angle3, _angle \
   mov __rotate_turnpct3, _turnpct \
   mov __rotate_sync3, _bSync \
   mov __rotate_stop3, _bStop \
   mov __rotate_theRVP3, _p \
   mov __rotate_theRVI3, _i \
   mov __rotate_theRVD3, _d \
   call __RotateMotor3 \
   release __rotateMutex1 \
   release __rotateMutex0

#define __rotateMotorExPID4(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   acquire __rotateMutex2 \
   mov __rotate_ports4, __OUT_AC \
   mov __rotate_power4, _pwr \
   mov __rotate_angle4, _angle \
   mov __rotate_turnpct4, _turnpct \
   mov __rotate_sync4, _bSync \
   mov __rotate_stop4, _bStop \
   mov __rotate_theRVP4, _p \
   mov __rotate_theRVI4, _i \
   mov __rotate_theRVD4, _d \
   call __RotateMotor4 \
   release __rotateMutex2 \
   release __rotateMutex0

#define __rotateMotorExPID5(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex1 \
   acquire __rotateMutex2 \
   mov __rotate_ports5, __OUT_BC \
   mov __rotate_power5, _pwr \
   mov __rotate_angle5, _angle \
   mov __rotate_turnpct5, _turnpct \
   mov __rotate_sync5, _bSync \
   mov __rotate_stop5, _bStop \
   mov __rotate_theRVP5, _p \
   mov __rotate_theRVI5, _i \
   mov __rotate_theRVD5, _d \
   call __RotateMotor5 \
   release __rotateMutex2 \
   release __rotateMutex1

#define __rotateMotorExPID6(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   acquire __rotateMutex1 \
   acquire __rotateMutex2 \
   mov __rotate_ports6, __OUT_ABC \
   mov __rotate_power6, _pwr \
   mov __rotate_angle6, _angle \
   mov __rotate_turnpct6, _turnpct \
   mov __rotate_sync6, _bSync \
   mov __rotate_stop6, _bStop \
   mov __rotate_theRVP6, _p \
   mov __rotate_theRVI6, _i \
   mov __rotate_theRVD6, _d \
   call __RotateMotor6 \
   release __rotateMutex2 \
   release __rotateMutex1 \
   release __rotateMutex0

#define __rotateMotorExPIDVar(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   acquire __rotateMutex1 \
   acquire __rotateMutex2 \
   arrbuild __rotate_ports6, _ports \
   mov __rotate_power6, _pwr \
   mov __rotate_angle6, _angle \
   mov __rotate_turnpct6, _turnpct \
   mov __rotate_sync6, _bSync \
   mov __rotate_stop6, _bStop \
   mov __rotate_theRVP6, _p \
   mov __rotate_theRVI6, _i \
   mov __rotate_theRVD6, _d \
   call __RotateMotorVar \
   release __rotateMutex2 \
   release __rotateMutex1 \
   release __rotateMutex0

subroutine __RotateMotor0
  brtst EQ, __rotate_Done0, __rotate_angle0
  sign __rotate_thePower0, __rotate_angle0
  abs __rotate_theAngle0, __rotate_angle0
  mul __rotate_thePower0, __rotate_thePower0, __rotate_power0 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF0, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync0, __rotate_sync0
  set __rotate_theOM0, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM0, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct0, __rotate_turnpct0
  brtst EQ, __rotate_Start0, __rotate_theTurnPct0
  add __rotate_theUF0, __rotate_theUF0, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start0
__rotate_NoSync0:
  set __rotate_theOM0, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM0, OUT_REGMODE_IDLE
  set __rotate_theTurnPct0, 0
__rotate_Start0:
  set __rotate_theRS0, OUT_RUNSTATE_RUNNING
  setout __rotate_ports0, OutputModeField, __rotate_theOM0, RegModeField, __rotate_theRM0, TachoLimitField, __rotate_theAngle0, RunStateField, __rotate_theRS0, RegPValueField, __rotate_theRVP0, RegIValueField, __rotate_theRVI0, RegDValueField, __rotate_theRVD0, PowerField, __rotate_thePower0, TurnRatioField, __rotate_turnpct0, UpdateFlagsField, __rotate_theUF0

  wait 0 // let the motor(s) start turning

  // Waits till the angle is reached
  index __rotate_firstPort0, __rotate_ports0, NA
__rotate_Running0:
  getout __rotate_power0, __rotate_firstPort0, PowerField
  brtst EQ, __rotate_doneRunning0, __rotate_power0
  getout __rotate_rs0, __rotate_firstPort0, RunStateField
  brcmp EQ, __rotate_Running0, __rotate_rs0, OUT_RUNSTATE_RUNNING
__rotate_doneRunning0:
  brtst EQ, __rotate_Reset0, __rotate_stop0 // skip the speed regulation phase if __rotate_stop is false

  // Regulates for speed = 0
  set __rotate_theOM0, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF0, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports0, OutputModeField, __rotate_theOM0, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS0, PowerField, 0, TurnRatioField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF0

  wait 0 // let the firmware stop the motor(s)

  // Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount0, __rotate_firstPort0, TachoCountField
__rotate_Stabilize0:
  mov __rotate_OldRotCount0, __rotate_RotCount0
  wait 50
  // check rotation
  getout __rotate_RotCount0, __rotate_firstPort0, TachoCountField
  brcmp NEQ, __rotate_Stabilize0, __rotate_OldRotCount0, __rotate_RotCount0

  // now remove the brake
  set __rotate_theOM0, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports0, RegModeField, __rotate_theRM0, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM0, UpdateFlagsField, UF_UPDATE_MODE
  wait 0 // let the firmware release the motor(s)

__rotate_Reset0:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done0, __rotate_theTurnPct0
  setout __rotate_ports0, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done0:
  return
ends

subroutine __RotateMotor1
  brtst EQ, __rotate_Done1, __rotate_angle1
  sign __rotate_thePower1, __rotate_angle1
  abs __rotate_theAngle1, __rotate_angle1
  mul __rotate_thePower1, __rotate_thePower1, __rotate_power1 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF1, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync1, __rotate_sync1
  set __rotate_theOM1, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM1, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct1, __rotate_turnpct1
  brtst EQ, __rotate_Start1, __rotate_theTurnPct1
  add __rotate_theUF1, __rotate_theUF1, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start1
__rotate_NoSync1:
  set __rotate_theOM1, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM1, OUT_REGMODE_IDLE
  set __rotate_theTurnPct1, 0
__rotate_Start1:
  set __rotate_theRS1, OUT_RUNSTATE_RUNNING
  setout __rotate_ports1, OutputModeField, __rotate_theOM1, RegModeField, __rotate_theRM1, TachoLimitField, __rotate_theAngle1, RunStateField, __rotate_theRS1, RegPValueField, __rotate_theRVP1, RegIValueField, __rotate_theRVI1, RegDValueField, __rotate_theRVD1, PowerField, __rotate_thePower1, TurnRatioField, __rotate_turnpct1, UpdateFlagsField, __rotate_theUF1

  wait 0 // let the motor(s) start turning

  // Waits till the angle is reached
  index __rotate_firstPort1, __rotate_ports1, NA
__rotate_Running1:
  getout __rotate_power1, __rotate_firstPort1, PowerField
  brtst EQ, __rotate_doneRunning1, __rotate_power1
  getout __rotate_rs1, __rotate_firstPort1, RunStateField
  brcmp EQ, __rotate_Running1, __rotate_rs1, OUT_RUNSTATE_RUNNING
__rotate_doneRunning1:
  brtst EQ, __rotate_Reset1, __rotate_stop1 // skip the speed regulation phase if __rotate_stop is false

  // Regulates for speed = 0
  set __rotate_theOM1, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF1, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports1, OutputModeField, __rotate_theOM1, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS1, PowerField, 0, TurnRatioField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF1

  wait 0 // let the firmware stop the motor(s)

  // Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount1, __rotate_firstPort1, TachoCountField
__rotate_Stabilize1:
  mov __rotate_OldRotCount1, __rotate_RotCount1
  wait 50
  // check rotation
  getout __rotate_RotCount1, __rotate_firstPort1, TachoCountField
  brcmp NEQ, __rotate_Stabilize1, __rotate_OldRotCount1, __rotate_RotCount1

  // now remove the brake
  set __rotate_theOM1, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports1, RegModeField, __rotate_theRM1, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM1, UpdateFlagsField, UF_UPDATE_MODE
  wait 0 // let the firmware release the motor(s)

__rotate_Reset1:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done1, __rotate_theTurnPct1
  setout __rotate_ports1, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done1:
  return
ends

subroutine __RotateMotor2
  brtst EQ, __rotate_Done2, __rotate_angle2
  sign __rotate_thePower2, __rotate_angle2
  abs __rotate_theAngle2, __rotate_angle2
  mul __rotate_thePower2, __rotate_thePower2, __rotate_power2 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF2, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync2, __rotate_sync2
  set __rotate_theOM2, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM2, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct2, __rotate_turnpct2
  brtst EQ, __rotate_Start2, __rotate_theTurnPct2
  add __rotate_theUF2, __rotate_theUF2, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start2
__rotate_NoSync2:
  set __rotate_theOM2, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM2, OUT_REGMODE_IDLE
  set __rotate_theTurnPct2, 0
__rotate_Start2:
  set __rotate_theRS2, OUT_RUNSTATE_RUNNING
  setout __rotate_ports2, OutputModeField, __rotate_theOM2, RegModeField, __rotate_theRM2, TachoLimitField, __rotate_theAngle2, RunStateField, __rotate_theRS2, RegPValueField, __rotate_theRVP2, RegIValueField, __rotate_theRVI2, RegDValueField, __rotate_theRVD2, PowerField, __rotate_thePower2, TurnRatioField, __rotate_turnpct2, UpdateFlagsField, __rotate_theUF2

  wait 0 // let the motor(s) start turning

  // Waits till the angle is reached
  index __rotate_firstPort2, __rotate_ports2, NA
__rotate_Running2:
  getout __rotate_power2, __rotate_firstPort2, PowerField
  brtst EQ, __rotate_doneRunning2, __rotate_power2
  getout __rotate_rs2, __rotate_firstPort2, RunStateField
  brcmp EQ, __rotate_Running2, __rotate_rs2, OUT_RUNSTATE_RUNNING
__rotate_doneRunning2:
  brtst EQ, __rotate_Reset2, __rotate_stop2 // skip the speed regulation phase if __rotate_stop is false

  // Regulates for speed = 0
  set __rotate_theOM2, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF2, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports2, OutputModeField, __rotate_theOM2, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS2, PowerField, 0, TurnRatioField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF2

  wait 0 // let the firmware stop the motor(s)

  // Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount2, __rotate_firstPort2, TachoCountField
__rotate_Stabilize2:
  mov __rotate_OldRotCount2, __rotate_RotCount2
  wait 50
  // check rotation
  getout __rotate_RotCount2, __rotate_firstPort2, TachoCountField
  brcmp NEQ, __rotate_Stabilize2, __rotate_OldRotCount2, __rotate_RotCount2

  // now remove the brake
  set __rotate_theOM2, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports2, RegModeField, __rotate_theRM2, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM2, UpdateFlagsField, UF_UPDATE_MODE
  wait 0 // let the firmware release the motor(s)

__rotate_Reset2:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done2, __rotate_theTurnPct2
  setout __rotate_ports2, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done2:
  return
ends

subroutine __RotateMotor3
  brtst EQ, __rotate_Done3, __rotate_angle3
  sign __rotate_thePower3, __rotate_angle3
  abs __rotate_theAngle3, __rotate_angle3
  mul __rotate_thePower3, __rotate_thePower3, __rotate_power3 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF3, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync3, __rotate_sync3
  set __rotate_theOM3, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM3, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct3, __rotate_turnpct3
  brtst EQ, __rotate_Start3, __rotate_theTurnPct3
  add __rotate_theUF3, __rotate_theUF3, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start3
__rotate_NoSync3:
  set __rotate_theOM3, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM3, OUT_REGMODE_IDLE
  set __rotate_theTurnPct3, 0
__rotate_Start3:
  set __rotate_theRS3, OUT_RUNSTATE_RUNNING
  setout __rotate_ports3, OutputModeField, __rotate_theOM3, RegModeField, __rotate_theRM3, TachoLimitField, __rotate_theAngle3, RunStateField, __rotate_theRS3, RegPValueField, __rotate_theRVP3, RegIValueField, __rotate_theRVI3, RegDValueField, __rotate_theRVD3, PowerField, __rotate_thePower3, TurnRatioField, __rotate_turnpct3, UpdateFlagsField, __rotate_theUF3

  wait 0 // let the motor(s) start turning

  // Waits till the angle is reached
  index __rotate_firstPort3, __rotate_ports3, NA
__rotate_Running3:
  getout __rotate_power3, __rotate_firstPort3, PowerField
  brtst EQ, __rotate_doneRunning3, __rotate_power3
  getout __rotate_rs3, __rotate_firstPort3, RunStateField
  brcmp EQ, __rotate_Running3, __rotate_rs3, OUT_RUNSTATE_RUNNING
__rotate_doneRunning3:
  brtst EQ, __rotate_Reset3, __rotate_stop3 // skip the speed regulation phase if __rotate_stop is false

  // Regulates for speed = 0
  set __rotate_theOM3, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF3, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports3, OutputModeField, __rotate_theOM3, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS3, PowerField, 0, TurnRatioField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF3

  wait 0 // let the firmware stop the motor(s)

  // Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount3, __rotate_firstPort3, TachoCountField
__rotate_Stabilize3:
  mov __rotate_OldRotCount3, __rotate_RotCount3
  wait 50
  // check rotation
  getout __rotate_RotCount3, __rotate_firstPort3, TachoCountField
  brcmp NEQ, __rotate_Stabilize3, __rotate_OldRotCount3, __rotate_RotCount3

  // now remove the brake
  set __rotate_theOM3, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports3, RegModeField, __rotate_theRM3, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM3, UpdateFlagsField, UF_UPDATE_MODE
  wait 0 // let the firmware release the motor(s)

__rotate_Reset3:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done3, __rotate_theTurnPct3
  setout __rotate_ports3, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done3:
  return
ends

subroutine __RotateMotor4
  brtst EQ, __rotate_Done4, __rotate_angle4
  sign __rotate_thePower4, __rotate_angle4
  abs __rotate_theAngle4, __rotate_angle4
  mul __rotate_thePower4, __rotate_thePower4, __rotate_power4 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF4, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync4, __rotate_sync4
  set __rotate_theOM4, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM4, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct4, __rotate_turnpct4
  brtst EQ, __rotate_Start4, __rotate_theTurnPct4
  add __rotate_theUF4, __rotate_theUF4, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start4
__rotate_NoSync4:
  set __rotate_theOM4, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM4, OUT_REGMODE_IDLE
  set __rotate_theTurnPct4, 0
__rotate_Start4:
  set __rotate_theRS4, OUT_RUNSTATE_RUNNING
  setout __rotate_ports4, OutputModeField, __rotate_theOM4, RegModeField, __rotate_theRM4, TachoLimitField, __rotate_theAngle4, RunStateField, __rotate_theRS4, RegPValueField, __rotate_theRVP4, RegIValueField, __rotate_theRVI4, RegDValueField, __rotate_theRVD4, PowerField, __rotate_thePower4, TurnRatioField, __rotate_turnpct4, UpdateFlagsField, __rotate_theUF4

  wait 0 // let the motor(s) start turning

  // Waits till the angle is reached
  index __rotate_firstPort4, __rotate_ports4, NA
__rotate_Running4:
  getout __rotate_power4, __rotate_firstPort4, PowerField
  brtst EQ, __rotate_doneRunning4, __rotate_power4
  getout __rotate_rs4, __rotate_firstPort4, RunStateField
  brcmp EQ, __rotate_Running4, __rotate_rs4, OUT_RUNSTATE_RUNNING
__rotate_doneRunning4:
  brtst EQ, __rotate_Reset4, __rotate_stop4 // skip the speed regulation phase if __rotate_stop is false

  // Regulates for speed = 0
  set __rotate_theOM4, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF4, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports4, OutputModeField, __rotate_theOM4, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS4, PowerField, 0, TurnRatioField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF4

  wait 0 // let the firmware stop the motor(s)

  // Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount4, __rotate_firstPort4, TachoCountField
__rotate_Stabilize4:
  mov __rotate_OldRotCount4, __rotate_RotCount4
  wait 50
  // check rotation
  getout __rotate_RotCount4, __rotate_firstPort4, TachoCountField
  brcmp NEQ, __rotate_Stabilize4, __rotate_OldRotCount4, __rotate_RotCount4

  // now remove the brake
  set __rotate_theOM4, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports4, RegModeField, __rotate_theRM4, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM4, UpdateFlagsField, UF_UPDATE_MODE
  wait 0 // let the firmware release the motor(s)

__rotate_Reset4:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done4, __rotate_theTurnPct4
  setout __rotate_ports4, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done4:
  return
ends

subroutine __RotateMotor5
  brtst EQ, __rotate_Done5, __rotate_angle5
  sign __rotate_thePower5, __rotate_angle5
  abs __rotate_theAngle5, __rotate_angle5
  mul __rotate_thePower5, __rotate_thePower5, __rotate_power5 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF5, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync5, __rotate_sync5
  set __rotate_theOM5, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM5, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct5, __rotate_turnpct5
  brtst EQ, __rotate_Start5, __rotate_theTurnPct5
  add __rotate_theUF5, __rotate_theUF5, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start5
__rotate_NoSync5:
  set __rotate_theOM5, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM5, OUT_REGMODE_IDLE
  set __rotate_theTurnPct5, 0
__rotate_Start5:
  set __rotate_theRS5, OUT_RUNSTATE_RUNNING
  setout __rotate_ports5, OutputModeField, __rotate_theOM5, RegModeField, __rotate_theRM5, TachoLimitField, __rotate_theAngle5, RunStateField, __rotate_theRS5, RegPValueField, __rotate_theRVP5, RegIValueField, __rotate_theRVI5, RegDValueField, __rotate_theRVD5, PowerField, __rotate_thePower5, TurnRatioField, __rotate_turnpct5, UpdateFlagsField, __rotate_theUF5

  wait 0 // let the motor(s) start turning

  // Waits till the angle is reached
  index __rotate_firstPort5, __rotate_ports5, NA
__rotate_Running5:
  getout __rotate_power5, __rotate_firstPort5, PowerField
  brtst EQ, __rotate_doneRunning5, __rotate_power5
  getout __rotate_rs5, __rotate_firstPort5, RunStateField
  brcmp EQ, __rotate_Running5, __rotate_rs5, OUT_RUNSTATE_RUNNING
__rotate_doneRunning5:
  brtst EQ, __rotate_Reset5, __rotate_stop5 // skip the speed regulation phase if __rotate_stop is false

  // Regulates for speed = 0
  set __rotate_theOM5, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF5, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports5, OutputModeField, __rotate_theOM5, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS5, PowerField, 0, TurnRatioField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF5

  wait 0 // let the firmware stop the motor(s)

  // Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount5, __rotate_firstPort5, TachoCountField
__rotate_Stabilize5:
  mov __rotate_OldRotCount5, __rotate_RotCount5
  wait 50
  // check rotation
  getout __rotate_RotCount5, __rotate_firstPort5, TachoCountField
  brcmp NEQ, __rotate_Stabilize5, __rotate_OldRotCount5, __rotate_RotCount5

  // now remove the brake
  set __rotate_theOM5, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports5, RegModeField, __rotate_theRM5, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM5, UpdateFlagsField, UF_UPDATE_MODE
  wait 0 // let the firmware release the motor(s)

__rotate_Reset5:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done5, __rotate_theTurnPct5
  setout __rotate_ports5, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done5:
  return
ends

subroutine __RotateMotor6
  brtst EQ, __rotate_Done6, __rotate_angle6
  sign __rotate_thePower6, __rotate_angle6
  abs __rotate_theAngle6, __rotate_angle6
  mul __rotate_thePower6, __rotate_thePower6, __rotate_power6 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF6, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync6, __rotate_sync6
  set __rotate_theOM6, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM6, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct6, __rotate_turnpct6
  brtst EQ, __rotate_Start6, __rotate_theTurnPct6
  add __rotate_theUF6, __rotate_theUF6, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start6
__rotate_NoSync6:
  set __rotate_theOM6, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM6, OUT_REGMODE_IDLE
  set __rotate_theTurnPct6, 0
__rotate_Start6:
  set __rotate_theRS6, OUT_RUNSTATE_RUNNING
  setout __rotate_ports6, OutputModeField, __rotate_theOM6, RegModeField, __rotate_theRM6, TachoLimitField, __rotate_theAngle6, RunStateField, __rotate_theRS6, RegPValueField, __rotate_theRVP6, RegIValueField, __rotate_theRVI6, RegDValueField, __rotate_theRVD6, PowerField, __rotate_thePower6, TurnRatioField, __rotate_turnpct6, UpdateFlagsField, __rotate_theUF6

  wait 0 // let the motor(s) start turning

  // Waits till the angle is reached
  index __rotate_firstPort6, __rotate_ports6, NA
__rotate_Running6:
  getout __rotate_power6, __rotate_firstPort6, PowerField
  brtst EQ, __rotate_doneRunning6, __rotate_power6
  getout __rotate_rs6, __rotate_firstPort6, RunStateField
  brcmp EQ, __rotate_Running6, __rotate_rs6, OUT_RUNSTATE_RUNNING
__rotate_doneRunning6:
  brtst EQ, __rotate_Reset6, __rotate_stop6 // skip the speed regulation phase if __rotate_stop is false

  // Regulates for speed = 0
  set __rotate_theOM6, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF6, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports6, OutputModeField, __rotate_theOM6, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS6, PowerField, 0, TurnRatioField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF6

  wait 0 // let the firmware stop the motor(s)

  // Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount6, __rotate_firstPort6, TachoCountField
__rotate_Stabilize6:
  mov __rotate_OldRotCount6, __rotate_RotCount6
  wait 50
  // check rotation
  getout __rotate_RotCount6, __rotate_firstPort6, TachoCountField
  brcmp NEQ, __rotate_Stabilize6, __rotate_OldRotCount6, __rotate_RotCount6

  // now remove the brake
  set __rotate_theOM6, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports6, RegModeField, __rotate_theRM6, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM6, UpdateFlagsField, UF_UPDATE_MODE
  wait 0 // let the firmware release the motor(s)

__rotate_Reset6:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done6, __rotate_theTurnPct6
  setout __rotate_ports6, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done6:
  return
ends

subroutine __RotateMotorVar
/*
  _ports should be an array but it might be an integer from 0..6
  (OUT_A, OUT_B, OUT_C, OUT_AB, OUT_AC, OUT_BC, OUT_ABC)
  This subroutine converts, if necessary, an array containing a single byte
  > 2 into an array containing multiple bytes and then falls through to
  the RotateMotor6 subroutine.  It uses __rotate_rs6 as a temporary variable
*/
  arrsize __rotate_rs6, __rotate_ports6 // what is the size of the array?
  brcmp GT, __rmvCallSub, __rotate_rs6, 1 // fall through if size > 1
  // only one element in the array.  What is its value?
  index __rotate_rs6, __rotate_ports6, NA // grab the first element
  brcmp LT, __rmvCallSub, __rotate_rs6, 3 // if it is less than 3 just call the subroutine
  brcmp GT, __rmvExit, __rotate_rs6, 6 // if it is greater than 6 abort
  // start with 3
  mov __rotate_ports6, __OUT_AB
  brcmp EQ, __rmvCallSub, __rotate_rs6, 3
  mov __rotate_ports6, __OUT_AC
  brcmp EQ, __rmvCallSub, __rotate_rs6, 4
  mov __rotate_ports6, __OUT_BC
  brcmp EQ, __rmvCallSub, __rotate_rs6, 5
  mov __rotate_ports6, __OUT_ABC
__rmvCallSub:
  call __RotateMotor6
__rmvExit:
  return
ends

#define __OnFwdEx(_ports, _pwr, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdExPIDAll(_ports, _pwr, _reset, PID_3, PID_1, PID_1) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdExPID##_ports(_pwr, _reset, PID_3, PID_1, PID_1) \
  compend

#define __OnRevEx(_ports, _pwr, _reset) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdEx(_ports, __OnRev_Tmp, _reset) \
  release __OnRevMutex

#define __OnFwdExPID(_ports, _pwr, _reset, _p, _i, _d) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdExPIDAll(_ports, _pwr, _reset, _p, _i, _d) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdExPID##_ports(_pwr, _reset, _p, _i, _d) \
  compend

#define __OnRevExPID(_ports, _pwr, _reset, _p, _i, _d) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdExPID(_ports, __OnRev_Tmp, _reset, _p, _i, _d) \
  release __OnRevMutex

#define __CoastEx(_ports, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __coastExAll(_ports, _reset) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __coastEx##_ports(_reset) \
  compend

#define __OffEx(_ports, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __offExAll(_ports, _reset) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __offEx##_ports(_reset) \
  compend

#define __OnFwdRegEx(_ports, _pwr, _regmode, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdRegExPIDAll(_ports, _pwr, _regmode, _reset, PID_3, PID_1, PID_1) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdRegExPID##_ports(_pwr, _regmode, _reset, PID_3, PID_1, PID_1) \
  compend

#define __OnRevRegEx(_ports, _pwr, _regmode, _reset) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdRegEx(_ports, __OnRev_Tmp, _regmode, _reset) \
  release __OnRevMutex

#define __OnFwdRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdRegExPIDAll(_ports, _pwr, _regmode, _reset, _p, _i, _d) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdRegExPID##_ports(_pwr, _regmode, _reset, _p, _i, _d) \
  compend

#define __OnRevRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdRegExPID(_ports, __OnRev_Tmp, _regmode, _reset, _p, _i, _d) \
  release __OnRevMutex

#define __OnFwdSyncEx(_ports, _pwr, _turnpct, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdSyncExPIDAll(_ports, _pwr, _turnpct, _reset, PID_3, PID_1, PID_1) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdSyncExPID##_ports(_pwr, _turnpct, _reset, PID_3, PID_1, PID_1) \
  compend

#define __OnRevSyncEx(_ports, _pwr, _turnpct, _reset) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdSyncEx(_ports, __OnRev_Tmp, _turnpct, _reset) \
  release __OnRevMutex

#define __OnFwdSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdSyncExPIDAll(_ports, _pwr, _turnpct, _reset, _p, _i, _d) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdSyncExPID##_ports(_pwr, _turnpct, _reset, _p, _i, _d) \
  compend

#define __OnRevSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdSyncExPID(_ports, __OnRev_Tmp, _turnpct, _reset, _p, _i, _d) \
  release __OnRevMutex

#define __RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   compif EQ, isconst(_ports), FALSE \
   __rotateMotorExPIDVar(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   compelse \
   compchk LT, _ports, 0x07 \
   compchk GTEQ, _ports, 0x00 \
   __rotateMotorExPID##_ports(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   compend

#define __GetOutPwnFreq(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetOutputModuleValue(OutputOffsetRegulationTime, _n)

#define __GetOutRegulationTime(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetOutputModuleValue(OutputOffsetRegulationTime, _n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __GetOutRegulationOptions(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetOutputModuleValue(OutputOffsetRegulationOptions, _n)

#endif

#define __setOutPwnFreq(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetOutputModuleValue(OutputOffsetRegulationTime, _n)

#define __setOutRegulationTime(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetOutputModuleValue(OutputOffsetRegulationTime, _n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __setOutRegulationOptions(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetOutputModuleValue(OutputOffsetRegulationOptions, _n)

#endif

#endif

/**
 * Reset tachometer counter.
 * Reset the tachometer count and tachometer limit goal for the specified
 * outputs.
 *
 * \param _p Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
#define ResetTachoCount(_p) __resetTachoCount(_p)

/**
 * Reset block-relative counter.
 * Reset the block-relative position counter for the specified outputs.
 *
 * \param _p Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
#define ResetBlockTachoCount(_p) __resetBlockTachoCount(_p)

/**
 * Reset program-relative counter.
 * Reset the program-relative position counter for the specified outputs.
 *
 * \param _p Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
#define ResetRotationCount(_p) __resetRotationCount(_p)

/**
 * Reset all tachometer counters.
 * Reset all three position counters and reset the current tachometer limit
 * goal for the specified outputs.
 *
 * \param _p Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
#define ResetAllTachoCounts(_p) __resetAllTachoCounts(_p)

/**
 * Run motors forward and reset counters.
 * Set outputs to forward direction and turn them on.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnFwdEx(_ports, _pwr, _reset) __OnFwdEx(_ports, _pwr, _reset)

/**
 * Run motors backward and reset counters.
 * Set outputs to reverse direction and turn them on.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnRevEx(_ports, _pwr, _reset) __OnRevEx(_ports, _pwr, _reset)

/**
 * Run motors forward and reset counters.
 * Set outputs to forward direction and turn them on.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdExPID(_ports, _pwr, _reset, _p, _i, _d) __OnFwdExPID(_ports, _pwr, _reset, _p, _i, _d)

/**
 * Run motors backward and reset counters.
 * Set outputs to reverse direction and turn them on.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevExPID(_ports, _pwr, _reset, _p, _i, _d) __OnRevExPID(_ports, _pwr, _reset, _p, _i, _d)

/**
 * Run motors forward.
 * Set outputs to forward direction and turn them on.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 */
#define OnFwd(_ports, _pwr) OnFwdEx(_ports, _pwr, RESET_BLOCKANDTACHO)

/**
 * Run motors backward.
 * Set outputs to reverse direction and turn them on.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 */
#define OnRev(_ports, _pwr) OnRevEx(_ports, _pwr, RESET_BLOCKANDTACHO)

/**
 * Coast motors and reset counters.
 * Turn off the specified outputs, making them coast to a stop.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define CoastEx(_ports, _reset) __CoastEx(_ports, _reset)

/**
 * Turn motors off and reset counters.
 * Turn the specified outputs off (with braking).
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OffEx(_ports, _reset) __OffEx(_ports, _reset)

/**
 * Coast motors.
 * Turn off the specified outputs, making them coast to a stop.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
#define Coast(_ports) CoastEx(_ports, RESET_BLOCKANDTACHO)

/**
 * Turn motors off.
 * Turn the specified outputs off (with braking).
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
#define Off(_ports) OffEx(_ports, RESET_BLOCKANDTACHO)

/**
 * Float motors.
 * Make outputs float. Float is an alias for Coast.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
#define Float(_ports) Coast(_ports)

/**
 * Run motors forward regulated and reset counters.
 * Run the specified outputs forward using the specified regulation mode.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnFwdRegEx(_ports, _pwr, _regmode, _reset) __OnFwdRegEx(_ports, _pwr, _regmode, _reset)

/**
 * Run motors backward regulated and reset counters.
 * Run the specified outputs in reverse using the specified regulation mode.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnRevRegEx(_ports, _pwr, _regmode, _reset) __OnRevRegEx(_ports, _pwr, _regmode, _reset)

/**
 * Run motors forward regulated and reset counters with PID factors.
 * Run the specified outputs forward using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) __OnFwdRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d)

/**
 * Run motors backward regulated and reset counters with PID factors.
 * Run the specified outputs in reverse using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) __OnRevRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d)

/**
 * Run motors forward regulated.
 * Run the specified outputs forward using the specified regulation mode.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 */
#define OnFwdReg(_ports, _pwr, _regmode) OnFwdRegEx(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO)

/**
 * Run motors forward regulated.
 * Run the specified outputs in reverse using the specified regulation mode.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 */
#define OnRevReg(_ports, _pwr, _regmode) OnRevRegEx(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO)

/**
 * Run motors forward regulated with PID factors.
 * Run the specified outputs forward using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdRegPID(_ports, _pwr, _regmode, _p, _i, _d) OnFwdRegExPID(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO, _p, _i, _d)

/**
 * Run motors reverse regulated with PID factors.
 * Run the specified outputs in reverse using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevRegPID(_ports, _pwr, _regmode, _p, _i, _d) OnRevRegExPID(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO, _p, _i, _d)

/**
 * Run motors forward synchronised and reset counters.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnFwdSyncEx(_ports, _pwr, _turnpct, _reset) __OnFwdSyncEx(_ports, _pwr, _turnpct, _reset)

/**
 * Run motors backward synchronised and reset counters.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnRevSyncEx(_ports, _pwr, _turnpct, _reset) __OnRevSyncEx(_ports, _pwr, _turnpct, _reset)

/**
 * Run motors forward synchronised and reset counters with PID factors.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) __OnFwdSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d)

/**
 * Run motors backward synchronised and reset counters with PID factors.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) __OnRevSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d)

/**
 * Run motors forward synchronised.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 */
#define OnFwdSync(_ports, _pwr, _turnpct) OnFwdSyncEx(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO)

/**
 * Run motors backward synchronised.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 */
#define OnRevSync(_ports, _pwr, _turnpct) OnRevSyncEx(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO)

/**
 * Run motors forward synchronised with PID factors.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdSyncPID(_ports, _pwr, _turnpct, _p, _i, _d) OnFwdSyncExPID(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO, _p, _i, _d)

/**
 * Run motors backward synchronised with PID factors.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevSyncPID(_ports, _pwr, _turnpct, _p, _i, _d) OnRevSyncExPID(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO, _p, _i, _d)

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _angle Angle limit, in degree. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _bSync Synchronise two motors. Should be set to true if a non-zero
 * turn percent is specified or no turning will occur.
 * \param _bStop Specify whether the motor(s) should brake at the end of the
 * rotation.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   __RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d)

// default PID values are 96, 32, 32 (PID_3, PID_1, PID_1)

/**
 * Rotate motor with PID factors.
 * Run the specified outputs forward for the specified number of degrees.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _angle Angle limit, in degree. Can be negative to reverse direction.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define RotateMotorPID(_ports, _pwr, _angle, _p, _i, _d) \
   __RotateMotorExPID(_ports, _pwr, _angle, 0, FALSE, TRUE, _p, _i, _d)

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _angle Angle limit, in degree. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _bSync Synchronise two motors. Should be set to true if a non-zero
 * turn percent is specified or no turning will occur.
 * \param _bStop Specify whether the motor(s) should brake at the end of the
 * rotation.
 */
#define RotateMotorEx(_ports, _pwr, _angle, _turnpct, _bSync, _bStop) \
   __RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, PID_3, PID_1, PID_1)

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _angle Angle limit, in degree. Can be negative to reverse direction.
 */
#define RotateMotor(_ports, _pwr, _angle) \
   __RotateMotorExPID(_ports, _pwr, _angle, 0, FALSE, TRUE, PID_3, PID_1, PID_1)

/**
 * Set motor regulation frequency.
 * Set the motor regulation frequency to the specified number of milliseconds.
 * \param _n The motor regulation frequency in milliseconds
 */
#define SetOutPwnFreq(_n) __setOutPwnFreq(_n)

/**
 * Get motor regulation frequency.
 * Get the current motor regulation frequency.
 * \param _n The motor regulation frequency in milliseconds
 */
#define GetOutPwnFreq(_n) __GetOutPwnFreq(_n)

/**
 * Set motor regulation time.
 * Set the motor regulation time to the specified number of milliseconds.
 * \param _n The motor regulation time in milliseconds
 */
#define SetOutRegulationTime(_n) __setOutRegulationTime(_n)

/**
 * Get motor regulation time.
 * Get the current motor regulation time.
 * \param _n The motor regulation time in milliseconds
 */
#define GetOutRegulationTime(_n) __GetOutRegulationTime(_n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Set motor regulation options.
 * Set the motor regulation options.
 * \param _n The motor regulation options
 */
#define SetOutRegulationOptions(_n) __setOutRegulationOptions(_n)

/**
 * Get motor regulation options.
 * Get the current motor regulation options.
 * \param _n The motor regulation options
 */
#define GetOutRegulationOptions(_n) __GetOutRegulationOptions(_n)
#endif

/** @} */ // end of OutputModuleFunctions group
/** @} */ // end of OutputModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_OUTPUT_H
