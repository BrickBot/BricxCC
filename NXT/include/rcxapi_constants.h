/** \file rcxapi_constants.h
 * \brief The NBC/NXC RCX API constants
 *
 * rcxapi_constants.h contains the NBC/NXC RCX API constants
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

#ifndef RCXAPI_CONSTANTS_H
#define RCXAPI_CONSTANTS_H

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @defgroup RCXAPIConstants RCX constants
 * Constants that are for use with devices that communicate with the RCX or
 * Scout programmable bricks via IR such as the HiTechnic IRLink or the
 * MindSensors nRLink.
 * @{
 */
/** @defgroup RCXOutputConstants RCX output constants
 * Constants for use when choosing RCX outputs.
 * @{
 */
#define RCX_OUT_A   0x01 /*!< RCX Output A */
#define RCX_OUT_B   0x02 /*!< RCX Output B */
#define RCX_OUT_C   0x04 /*!< RCX Output C */
#define RCX_OUT_AB  0x03 /*!< RCX Outputs A and B */
#define RCX_OUT_AC  0x05 /*!< RCX Outputs A and C */
#define RCX_OUT_BC  0x06 /*!< RCX Outputs B and C */
#define RCX_OUT_ABC 0x07 /*!< RCX Outputs A, B, and C */
/** @} */  // end of RCXOutputConstants group

/** @defgroup RCXOutputMode RCX output mode constants
 * Constants for use when configuring RCX output mode.
 * @{
 */
#define RCX_OUT_FLOAT 0    /*!< Set RCX output to float */
#define RCX_OUT_OFF   0x40 /*!< Set RCX output to off */
#define RCX_OUT_ON    0x80 /*!< Set RCX output to on */
/** @} */  // end of RCXOutputMode group

/** @defgroup RCXOutputDirection RCX output direction constants
 * Constants for use when configuring RCX output direction.
 * @{
 */
#define RCX_OUT_REV    0    /*!< Set RCX output direction to reverse */
#define RCX_OUT_TOGGLE 0x40 /*!< Set RCX output direction to toggle */
#define RCX_OUT_FWD    0x80 /*!< Set RCX output direction to forward */
/** @} */  // end of RCXOutputConstants group

/** @defgroup RCXOutputPower RCX output power constants
 * Constants for use when configuring RCX output power.
 * @{
 */
#define RCX_OUT_LOW  0 /*!< Set RCX output power level to low */
#define RCX_OUT_HALF 3 /*!< Set RCX output power level to half */
#define RCX_OUT_FULL 7 /*!< Set RCX output power level to full */
/** @} */  // end of RCXOutputPower group

/** @defgroup RCXRemoteConstants RCX IR remote constants
 * Constants for use when simulating RCX IR remote messages.
 * @{
 */
#define RCX_RemoteKeysReleased 0x0000 /*!< All remote keys have been released */
#define RCX_RemotePBMessage1   0x0100 /*!< Send PB message 1 */
#define RCX_RemotePBMessage2   0x0200 /*!< Send PB message 2 */
#define RCX_RemotePBMessage3   0x0400 /*!< Send PB message 3 */
#define RCX_RemoteOutAForward  0x0800 /*!< Set output A forward */
#define RCX_RemoteOutBForward  0x1000 /*!< Set output B forward */
#define RCX_RemoteOutCForward  0x2000 /*!< Set output C forward */
#define RCX_RemoteOutABackward 0x4000 /*!< Set output A backward */
#define RCX_RemoteOutBBackward 0x8000 /*!< Set output B backward */
#define RCX_RemoteOutCBackward 0x0001 /*!< Set output C backward */
#define RCX_RemoteSelProgram1  0x0002 /*!< Select program 1 */
#define RCX_RemoteSelProgram2  0x0004 /*!< Select program 2 */
#define RCX_RemoteSelProgram3  0x0008 /*!< Select program 3 */
#define RCX_RemoteSelProgram4  0x0010 /*!< Select program 4 */
#define RCX_RemoteSelProgram5  0x0020 /*!< Select program 5 */
#define RCX_RemoteStopOutOff   0x0040 /*!< Stop and turn off outputs */
#define RCX_RemotePlayASound   0x0080 /*!< Play a sound */
/** @} */  // end of RCXRemoteConstants group

/** @defgroup ScoutConstants Scout constants
 * Constants for use when controlling the Scout brick.
 * @{
 */
/** @defgroup ScoutLightConstants Scout light constants
 * Constants for use when controlling the Scout light settings.
 * @{
 */
#define SCOUT_LIGHT_ON        0x80 /*!< Turn on the scout light */
#define SCOUT_LIGHT_OFF       0    /*!< Turn off the scout light */
/** @} */  // end of ScoutLightConstants group

/** @defgroup ScoutSoundConstants Scout sound constants
 * Constants for use when playing standard Scout sounds.
 * @{
 */
#define SCOUT_SOUND_REMOTE           6 /*!< Play the Scout remote sound */
#define SCOUT_SOUND_ENTERSA          7 /*!< Play the Scout enter standalone sound */
#define SCOUT_SOUND_KEYERROR         8 /*!< Play the Scout key error sound */
#define SCOUT_SOUND_NONE             9 /*!< Play the Scout none sound */
#define SCOUT_SOUND_TOUCH1_PRES     10 /*!< Play the Scout touch 1 pressed sound */
#define SCOUT_SOUND_TOUCH1_REL      11 /*!< Play the Scout touch 1 released sound */
#define SCOUT_SOUND_TOUCH2_PRES     12 /*!< Play the Scout touch 2 pressed sound */
#define SCOUT_SOUND_TOUCH2_REL      13 /*!< Play the Scout touch 2 released sound */
#define SCOUT_SOUND_ENTER_BRIGHT    14 /*!< Play the Scout enter bright sound */
#define SCOUT_SOUND_ENTER_NORMAL    15 /*!< Play the Scout enter normal sound */
#define SCOUT_SOUND_ENTER_DARK      16 /*!< Play the Scout enter dark sound */
#define SCOUT_SOUND_1_BLINK         17 /*!< Play the Scout 1 blink sound */
#define SCOUT_SOUND_2_BLINK         18 /*!< Play the Scout 2 blink sound */
#define SCOUT_SOUND_COUNTER1        19 /*!< Play the Scout counter 1 sound */
#define SCOUT_SOUND_COUNTER2        20 /*!< Play the Scout counter 2 sound */
#define SCOUT_SOUND_TIMER1          21 /*!< Play the Scout timer 1 sound */
#define SCOUT_SOUND_TIMER2          22 /*!< Play the Scout timer 2 sound */
#define SCOUT_SOUND_TIMER3          23 /*!< Play the Scout timer 3 sound */
#define SCOUT_SOUND_MAIL_RECEIVED   24 /*!< Play the Scout mail received sound */
#define SCOUT_SOUND_SPECIAL1        25 /*!< Play the Scout special 1 sound */
#define SCOUT_SOUND_SPECIAL2        26 /*!< Play the Scout special 2 sound */
#define SCOUT_SOUND_SPECIAL3        27 /*!< Play the Scout special 3 sound */
/** @} */  // end of ScoutSoundConstants group

/** @defgroup ScoutSndSetConstants Scout sound set constants
 * Constants for use when choosing standard Scout sound sets.
 * @{
 */
#define SCOUT_SNDSET_NONE           0 /*!< Set sound set to none */
#define SCOUT_SNDSET_BASIC          1 /*!< Set sound set to basic */
#define SCOUT_SNDSET_BUG            2 /*!< Set sound set to bug */
#define SCOUT_SNDSET_ALARM          3 /*!< Set sound set to alarm */
#define SCOUT_SNDSET_RANDOM         4 /*!< Set sound set to random */
#define SCOUT_SNDSET_SCIENCE        5 /*!< Set sound set to science */
/** @} */  // end of ScoutSndSetConstants group

/** @defgroup ScoutModeConstants Scout mode constants
 * Constants for use when setting the scout mode.
 * @{
 */
#define SCOUT_MODE_STANDALONE       0 /*!< Enter stand alone mode */
#define SCOUT_MODE_POWER            1 /*!< Enter power mode */
/** @} */  // end of ScoutModeConstants group

/** @defgroup ScoutMotionRuleConstants Scout motion rule constants
 * Constants for use when setting the scout motion rule.
 * @{
 */
#define SCOUT_MR_NO_MOTION          0 /*!< Motion rule none */
#define SCOUT_MR_FORWARD            1 /*!< Motion rule forward */
#define SCOUT_MR_ZIGZAG             2 /*!< Motion rule zigzag */
#define SCOUT_MR_CIRCLE_RIGHT       3 /*!< Motion rule circle right */
#define SCOUT_MR_CIRCLE_LEFT        4 /*!< Motion rule circle left */
#define SCOUT_MR_LOOP_A             5 /*!< Motion rule loop A */
#define SCOUT_MR_LOOP_B             6 /*!< Motion rule loop B */
#define SCOUT_MR_LOOP_AB            7 /*!< Motion rule loop A then B */
/** @} */  // end of ScoutMotionRuleConstants group

/** @defgroup ScoutTouchRuleConstants Scout touch rule constants
 * Constants for use when setting the scout touch rule.
 * @{
 */
#define SCOUT_TR_IGNORE             0 /*!< Touch rule ignore */
#define SCOUT_TR_REVERSE            1 /*!< Touch rule reverse */
#define SCOUT_TR_AVOID              2 /*!< Touch rule avoid */
#define SCOUT_TR_WAIT_FOR           3 /*!< Touch rule wait for */
#define SCOUT_TR_OFF_WHEN           4 /*!< Touch rule off when */
/** @} */  // end of ScoutTouchRuleConstants group

/** @defgroup ScoutLightRuleConstants Scout light rule constants
 * Constants for use when setting the scout light rule.
 * @{
 */
#define SCOUT_LR_IGNORE             0 /*!< Light rule ignore */
#define SCOUT_LR_SEEK_LIGHT         1 /*!< Light rule seek light */
#define SCOUT_LR_SEEK_DARK          2 /*!< Light rule seek dark */
#define SCOUT_LR_AVOID              3 /*!< Light rule avoid */
#define SCOUT_LR_WAIT_FOR           4 /*!< Light rule wait for */
#define SCOUT_LR_OFF_WHEN           5 /*!< Light rule off when */
/** @} */  // end of ScoutLightRuleConstants group

/** @defgroup ScoutTransmitRuleConstants Scout transmit rule constants
 * Constants for use when setting the scout transmit rule.
 * @{
 */
#define SCOUT_TGS_SHORT             0 /*!< Transmit level short */
#define SCOUT_TGS_MEDIUM            1 /*!< Transmit level medium */
#define SCOUT_TGS_LONG              2 /*!< Transmit level long */
/** @} */  // end of ScoutTransmitRuleConstants group

/** @defgroup ScoutSpecialEffectConstants Scout special effect constants
 * Constants for use when setting the scout special effect.
 * @{
 */
#define SCOUT_FXR_NONE              0 /*!< No special effects */
#define SCOUT_FXR_BUG               1 /*!< Bug special effects */
#define SCOUT_FXR_ALARM             2 /*!< Alarm special effects */
#define SCOUT_FXR_RANDOM            3 /*!< Random special effects */
#define SCOUT_FXR_SCIENCE           4 /*!< Science special effects */
/** @} */  // end of ScoutSpecialEffectConstants group
/** @} */  // end of ScoutConstants group

/** @defgroup RCXSourceConstants RCX and Scout source constants
 * Constants for use when specifying RCX and Scout sources.
 * @{
 */
#define RCX_VariableSrc             0  /*!< The RCX variable source */
#define RCX_TimerSrc                1  /*!< The RCX timer source */
#define RCX_ConstantSrc             2  /*!< The RCX constant value source */
#define RCX_OutputStatusSrc         3  /*!< The RCX output status source */
#define RCX_RandomSrc               4  /*!< The RCX random number source */
#define RCX_ProgramSlotSrc          8  /*!< The RCX program slot source */
#define RCX_InputValueSrc           9  /*!< The RCX input value source */
#define RCX_InputTypeSrc            10 /*!< The RCX input type source */
#define RCX_InputModeSrc            11 /*!< The RCX input mode source */
#define RCX_InputRawSrc             12 /*!< The RCX input raw source */
#define RCX_InputBooleanSrc         13 /*!< The RCX input boolean source */
#define RCX_WatchSrc                14 /*!< The RCX watch source */
#define RCX_MessageSrc              15 /*!< The RCX message source */
#define RCX_GlobalMotorStatusSrc    17 /*!< The RCX global motor status source */
#define RCX_ScoutRulesSrc           18 /*!< The Scout rules source */
#define RCX_ScoutLightParamsSrc     19 /*!< The Scout light parameters source */
#define RCX_ScoutTimerLimitSrc      20 /*!< The Scout timer limit source */
#define RCX_CounterSrc              21 /*!< The RCX counter source */
#define RCX_ScoutCounterLimitSrc    22 /*!< The Scout counter limit source */
#define RCX_TaskEventsSrc           23 /*!< The RCX task events source */
#define RCX_ScoutEventFBSrc         24 /*!< The Scout event feedback source */
#define RCX_EventStateSrc           25 /*!< The RCX event static source */
#define RCX_TenMSTimerSrc           26 /*!< The RCX 10ms timer source */
#define RCX_ClickCounterSrc         27 /*!< The RCX event click counter source */
#define RCX_UpperThresholdSrc       28 /*!< The RCX event upper threshold source */
#define RCX_LowerThresholdSrc       29 /*!< The RCX event lower threshold source */
#define RCX_HysteresisSrc           30 /*!< The RCX event hysteresis source */
#define RCX_DurationSrc             31 /*!< The RCX event duration source */
#define RCX_UARTSetupSrc            33 /*!< The RCX UART setup source */
#define RCX_BatteryLevelSrc         34 /*!< The RCX battery level source */
#define RCX_FirmwareVersionSrc      35 /*!< The RCX firmware version source */
#define RCX_IndirectVarSrc          36 /*!< The RCX indirect variable source */
#define RCX_DatalogSrcIndirectSrc   37 /*!< The RCX indirect datalog source source */
#define RCX_DatalogSrcDirectSrc     38 /*!< The RCX direct datalog source source */
#define RCX_DatalogValueIndirectSrc 39 /*!< The RCX indirect datalog value source */
#define RCX_DatalogValueDirectSrc   40 /*!< The RCX direct datalog value source */
#define RCX_DatalogRawIndirectSrc   41 /*!< The RCX indirect datalog raw source */
#define RCX_DatalogRawDirectSrc     42 /*!< The RCX direct datalog raw source */
/** @} */  // end of RCXSourceConstants group

/** @defgroup RCXOpcodeConstants RCX and Scout opcode constants
 * Constants for use when specifying RCX and Scout opcodes.
 * @{
 */
#define RCX_PingOp           0x10 /*!< Ping the brick */
#define RCX_BatteryLevelOp   0x30 /*!< Read the battery level */
#define RCX_DeleteTasksOp    0x40 /*!< Delete tasks */
#define RCX_StopAllTasksOp   0x50 /*!< Stop all tasks */
#define RCX_PBTurnOffOp      0x60 /*!< Turn off the brick */
#define RCX_DeleteSubsOp     0x70 /*!< Delete subroutines */
#define RCX_ClearSoundOp     0x80 /*!< Clear sound */
#define RCX_ClearMsgOp       0x90 /*!< Clear message */
#define RCX_LSCalibrateOp    0xc0 /*!< Calibrate the light sensor */
#define RCX_MuteSoundOp      0xd0 /*!< Mute sound */
#define RCX_UnmuteSoundOp    0xe0 /*!< Unmute sound */
#define RCX_ClearAllEventsOp 0x06 /*!< Clear all events */
#define RCX_OnOffFloatOp     0x21 /*!< Control motor state - on, off, float */
#define RCX_IRModeOp         0x31 /*!< Set the IR transmit mode */
#define RCX_PlaySoundOp      0x51 /*!< Play a sound */
#define RCX_DeleteTaskOp     0x61 /*!< Delete a task */
#define RCX_StartTaskOp      0x71 /*!< Start a task */
#define RCX_StopTaskOp       0x81 /*!< Stop a task */
#define RCX_SelectProgramOp  0x91 /*!< Select a program slot */
#define RCX_ClearTimerOp     0xa1 /*!< Clear a timer */
#define RCX_AutoOffOp        0xb1 /*!< Set auto off timer */
#define RCX_DeleteSubOp      0xc1 /*!< Delete a subroutine */
#define RCX_ClearSensorOp    0xd1 /*!< Clear a sensor */
#define RCX_OutputDirOp      0xe1 /*!< Set the motor direction */
#define RCX_PlayToneVarOp    0x02 /*!< Play a tone using a variable */
#define RCX_PollOp           0x12 /*!< Poll a source/value combination */
#define RCX_SetWatchOp       0x22 /*!< Set the watch source/value */
#define RCX_InputTypeOp      0x32 /*!< Set the input type */
#define RCX_InputModeOp      0x42 /*!< Set the input mode */
#define RCX_SetDatalogOp     0x52 /*!< Set the datalog size */
#define RCX_DatalogOp        0x62 /*!< Datalog the specified source/value*/
#define RCX_SendUARTDataOp   0xc2 /*!< Send data via IR using UART settings */
#define RCX_RemoteOp         0xd2 /*!< Execute simulated remote control buttons */
#define RCX_VLLOp            0xe2 /*!< Send visual light link (VLL) data */
#define RCX_DirectEventOp    0x03 /*!< Fire an event */
#define RCX_OutputPowerOp    0x13 /*!< Set the motor power level */
#define RCX_PlayToneOp       0x23 /*!< Play a tone */
#define RCX_DisplayOp        0x33 /*!< Set LCD display value */
#define RCX_PollMemoryOp     0x63 /*!< Poll a memory location */
#define RCX_SetFeedbackOp    0x83 /*!< Set Scout feedback */
#define RCX_SetEventOp       0x93 /*!< Set an event */
#define RCX_GOutputPowerOp   0xa3 /*!< Set global motor power levels */
#define RCX_LSUpperThreshOp  0xb3 /*!< Set the light sensor upper threshold */
#define RCX_LSLowerThreshOp  0xc3 /*!< Set the light sensor lower threshold */
#define RCX_LSHysteresisOp   0xd3 /*!< Set the light sensor hysteresis */
#define RCX_LSBlinkTimeOp    0xe3 /*!< Set the light sensor blink time */
#define RCX_CalibrateEventOp 0x04 /*!< Calibrate event */
#define RCX_SetVarOp         0x14 /*!< Set function */
#define RCX_SumVarOp         0x24 /*!< Sum function */
#define RCX_SubVarOp         0x34 /*!< Subtract function */
#define RCX_DivVarOp         0x44 /*!< Divide function */
#define RCX_MulVarOp         0x54 /*!< Multiply function */
#define RCX_SgnVarOp         0x64 /*!< Sign function */
#define RCX_AbsVarOp         0x74 /*!< Absolute value function */
#define RCX_AndVarOp         0x84 /*!< AND function */
#define RCX_OrVarOp          0x94 /*!< OR function */
#define RCX_UploadDatalogOp  0xa4 /*!< Upload datalog contents */
#define RCX_SetTimerLimitOp  0xc4 /*!< Set timer limit */
#define RCX_SetCounterOp     0xd4 /*!< Set counter value */
#define RCX_SetSourceValueOp 0x05 /*!< Set a source/value*/
#define RCX_UnlockOp         0x15 /*!< Unlock the brick */
#define RCX_BootModeOp       0x65 /*!< Set into book mode */
#define RCX_UnlockFirmOp     0xa5 /*!< Unlock the firmware */
#define RCX_ScoutRulesOp     0xd5 /*!< Set Scout rules */
#define RCX_ViewSourceValOp  0xe5 /*!< View a source/value */
#define RCX_ScoutOp          0x47 /*!< Scout opcode */
#define RCX_SoundOp          0x57 /*!< Sound opcode */
#define RCX_GOutputModeOp    0x67 /*!< Set global motor mode */
#define RCX_GOutputDirOp     0x77 /*!< Set global motor direction */
#define RCX_LightOp          0x87 /*!< Light opcode */
#define RCX_IncCounterOp     0x97 /*!< Increment a counter */
#define RCX_DecCounterOp     0xa7 /*!< Decrement a counter */
#define RCX_ClearCounterOp   0xb7 /*!< Clear a counter */
#define RCX_SetPriorityOp    0xd7 /*!< Set task priority */
#define RCX_MessageOp        0xf7 /*!< Set message */
/** @} */  // end of RCXOpcodeConstants group
/** @} */  // end of RCXAPIConstants group

/** @} */ // end of ThirdPartyDevices group

#endif // RCXAPI_CONSTANTS_H
