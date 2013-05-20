/** \file output_constants.h
 * \brief NXC Output module constants
 *
 * output_constants.h contains NXC Output module constants
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

#ifndef OUTPUT_CONSTANTS_H
#define OUTPUT_CONSTANTS_H

/** @addtogroup OutputModule
 * @{
 */
/** @addtogroup OutputModuleConstants
 * @{
 */
/** @defgroup OutputPortConstants Output port constants
 * Output port constants are used when calling motor control API functions.
 * @{
 */
#define OUT_A   0x00 /*!< Output port A */
#define OUT_B   0x01 /*!< Output port B */
#define OUT_C   0x02 /*!< Output port C */
#define OUT_AB  0x03 /*!< Output ports A and B */
#define OUT_AC  0x04 /*!< Output ports A and C */
#define OUT_BC  0x05 /*!< Output ports B and C */
#define OUT_ABC 0x06 /*!< Output ports A, B, and C */
/** @} */  // end of OutputPortConstants group

/** @defgroup PIDConstants PID constants
 * PID constants are for adjusting the Proportional, Integral, and Derivative
 * motor controller parameters.
 * \sa RotateMotorExPID(), RotateMotorPID(), OnFwdExPID(), OnRevExPID(),
 * \sa OnFwdRegExPID(), OnRevRegExPID(), OnFwdRegPID(), OnRevRegPID(),
 * \sa OnFwdSyncExPID(), OnRevSyncExPID(), OnFwdSyncPID(), OnRevSyncPID()
 * @{
 */
#define PID_0   0 /*!< PID zero */
#define PID_1  32 /*!< PID one */
#define PID_2  64 /*!< PID two */
#define PID_3  96 /*!< PID three */
#define PID_4 128 /*!< PID four */
#define PID_5 160 /*!< PID five */
#define PID_6 192 /*!< PID six */
#define PID_7 224 /*!< PID seven */
/** @} */  // end of PIDConstants group

/** @defgroup OutUFConstants Output port update flag constants
 * Use these constants to specify which motor values need to be updated.
 * Update flag constants can be combined with bitwise OR.
 * \sa SetOutput()
 * @{
 */
#define UF_UPDATE_MODE                 0x01 /*!< Commits changes to the \ref OutputModeField output property */
#define UF_UPDATE_SPEED                0x02 /*!< Commits changes to the \ref PowerField output property */
#define UF_UPDATE_TACHO_LIMIT          0x04 /*!< Commits changes to the \ref TachoLimitField output property */
#define UF_UPDATE_RESET_COUNT          0x08 /*!< Resets all rotation counters, cancels the current goal, and resets the rotation error-correction system */
#define UF_UPDATE_PID_VALUES           0x10 /*!< Commits changes to the PID motor regulation properties */
#define UF_UPDATE_RESET_BLOCK_COUNT    0x20 /*!< Resets the NXT-G block-relative rotation counter */
#define UF_UPDATE_RESET_ROTATION_COUNT 0x40 /*!< Resets the program-relative (user) rotation counter */
#define UF_PENDING_UPDATES             0x80 /*!< Are there any pending motor updates? */
/** @} */  // end of OutUFConstants group

/** @defgroup TachoResetConstants Tachometer counter reset flags
 * Use these constants to specify which of the three tachometer counters
 * should be reset. Reset constants can be combined with bitwise OR.
 * \sa OnFwdEx(), OnRevEx(), etc...
 * @{
 */
#define RESET_NONE           0x00 /*!< No counters will be reset */
#define RESET_COUNT          0x08 /*!< Reset the internal tachometer counter */
#define RESET_BLOCK_COUNT    0x20 /*!< Reset the NXT-G block tachometer counter */
#define RESET_ROTATION_COUNT 0x40 /*!< Reset the rotation counter */
#define RESET_BLOCKANDTACHO  0x28 /*!< Reset both the internal counter and the NXT-G block counter */
#define RESET_ALL            0x68 /*!< Reset all three tachometer counters */
/** @} */  // end of TachoResetConstants group

/** @defgroup OutModeConstants Output port mode constants
 * Use these constants to configure the desired mode for the
 * specified motor(s): coast, motoron, brake, or regulated. Mode constants
 * can be combined with bitwise OR.
 * \sa SetOutput()
 * @{
 */
#define OUT_MODE_COAST     0x00 /*!< No power and no braking so motors rotate freely. */
#define OUT_MODE_MOTORON   0x01 /*!< Enables PWM power to the outputs given the power setting */
#define OUT_MODE_BRAKE     0x02 /*!< Uses electronic braking to outputs */
#define OUT_MODE_REGULATED 0x04 /*!< Enables active power regulation using the regulation mode value */
#define OUT_MODE_REGMETHOD 0xF0 /*!< Mask for unimplemented regulation mode */
/** @} */  // end of OutModeConstants group

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/** @defgroup OutOptionConstants Output port option constants
 * Use these constants to configure the desired options for the
 * specified motor(s): hold at limit and ramp down to limit. Option constants
 * can be combined with bitwise OR.
 * \warning These options require the enhanced NBC/NXC firmware version 1.31+
 * \sa SetOutput()
 * @{
 */
#define OUT_OPTION_HOLDATLIMIT     0x10 /*!< Option to have the firmware hold the motor when it reaches the tachometer limit */
#define OUT_OPTION_RAMPDOWNTOLIMIT 0x20 /*!< Option to have the firmware rampdown the motor power as it approaches the tachometer limit */
/** @} */  // end of OutOptionConstants group

/** @defgroup OutRegOptionConstants Output regulation option constants
 * Use these constants to configure the desired options for
 * position regulation.
 * \warning These options require the enhanced NBC/NXC firmware version 1.31+
 * @{
 */
#define OUT_REGOPTION_NO_SATURATION 0x01 /*!< Do not limit intermediary regulation results */
/** @} */  // end of OutRegOptionConstants group
#endif

/** @defgroup OutRunStateConstants Output port run state constants
 * Use these constants to configure the desired run state for the
 * specified motor(s): idle, rampup, running, rampdown, or hold.
 * \sa SetOutput()
 * @{
 */
#define OUT_RUNSTATE_IDLE     0x00 /*!< Disable all power to motors. */
#define OUT_RUNSTATE_RAMPUP   0x10 /*!< Enable ramping up from a current power to a new (higher) power over a specified \ref TachoLimitField goal. */
#define OUT_RUNSTATE_RUNNING  0x20 /*!< Enable power to motors at the specified power level. */
#define OUT_RUNSTATE_RAMPDOWN 0x40 /*!< Enable ramping down from a current power to a new (lower) power over a specified \ref TachoLimitField goal. */
#define OUT_RUNSTATE_HOLD     0x60 /*!< Set motor run state to hold at the current position. */
/** @} */  // end of OutRunStateConstants group

/** @defgroup OutRegModeConstants Output port regulation mode constants
 * Use these constants to configure the desired regulation mode for the
 * specified motor(s): none, speed regulation, multi-motor synchronization,
 * or position regulation (requires the enhanced NBC/NXC firmware version 1.31+).
 * \sa SetOutput()
 * @{
 */
#define OUT_REGMODE_IDLE  0 /*!< No motor regulation. */
#define OUT_REGMODE_SPEED 1 /*!< Regulate a motor's speed (aka power). */
#define OUT_REGMODE_SYNC  2 /*!< Synchronize the rotation of two motors. */
#define OUT_REGMODE_POS   4 /*!< Regulate a motor's position. */
/** @} */  // end of OutRegModeConstants group

/** @defgroup OutputFieldConstants Output field constants
 * Constants for use with SetOutput() and GetOutput().
 * \sa SetOutput(), GetOutput()
 * @{
 */
/** Update flags field. Contains a combination of the update flag constants. Read/write.
 *  Use \ref UF_UPDATE_MODE, \ref UF_UPDATE_SPEED, \ref UF_UPDATE_TACHO_LIMIT, and \ref UF_UPDATE_PID_VALUES
 *  along with other fields to commit changes to the state of outputs. Set the appropriate
 *  flags after setting one or more of the output fields in order for the changes to actually
 *  go into affect. */
#define UpdateFlagsField     0
/** Mode field. Contains a combination of the output mode constants. Read/write.
 *  The \ref OUT_MODE_MOTORON bit must be set in order for power to be applied to the motors.
 *  Add \ref OUT_MODE_BRAKE to enable electronic braking. Braking means that the output voltage
 *  is not allowed to float between active PWM pulses. It improves the accuracy of motor
 *  output but uses more battery power.
 *  To use motor regulation include \ref OUT_MODE_REGULATED in the \ref OutputModeField value. Use
 *  \ref UF_UPDATE_MODE with \ref UpdateFlagsField to commit changes to this field. */
#define OutputModeField      1
/** Power field. Contains the desired power level (-100 to 100). Read/write.
 *  Specify the power level of the output. The absolute value of PowerField is a percentage of the
 *  full power of the motor. The sign of PowerField controls the rotation direction. Positive values
 *  tell the firmware to turn the motor forward, while negative values turn the motor backward.
 *  Use \ref UF_UPDATE_SPEED with \ref UpdateFlagsField to commit changes to this field. */
#define PowerField           2
/** Actual speed field. Contains the actual power level (-100 to 100). Read only.
 *  Return the percent of full power the firmware is applying to the output. This may vary from the
 *  PowerField value when auto-regulation code in the firmware responds to a load on the output. */
#define ActualSpeedField     3
/** Internal tachometer count field. Contains the current internal tachometer count. Read only.
 *  Return the internal position counter value for the specified output. The internal count is reset
 *  automatically when a new goal is set using the \ref TachoLimitField and the \ref UF_UPDATE_TACHO_LIMIT flag.
 *  Set the \ref UF_UPDATE_RESET_COUNT flag in \ref UpdateFlagsField to reset TachoCountField and cancel any \ref TachoLimitField.
 *  The sign of TachoCountField indicates the motor rotation direction. */
#define TachoCountField      4
/** Tachometer limit field. Contains the current tachometer limit. Read/write.
 *  Specify the number of degrees the motor should rotate.
 *  Use \ref UF_UPDATE_TACHO_LIMIT with the \ref UpdateFlagsField field to commit changes to the TachoLimitField.
 *  The value of this field is a relative distance from the current motor position at the moment when
 *  the \ref UF_UPDATE_TACHO_LIMIT flag is processed. */
#define TachoLimitField      5
/** Run state field. Contains one of the run state constants. Read/write.
 *  Use this field to specify the running state of an output. Set the RunStateField to \ref OUT_RUNSTATE_RUNNING
 *  to enable power to any output. Use \ref OUT_RUNSTATE_RAMPUP to enable automatic ramping to a new \ref PowerField
 *  level greater than the current \ref PowerField level. Use \ref OUT_RUNSTATE_RAMPDOWN to enable automatic ramping
 *  to a new \ref PowerField level less than the current \ref PowerField level.
 *  Both the rampup and rampdown bits must be used in conjunction with appropriate \ref TachoLimitField and \ref PowerField
 *  values. In this case the firmware smoothly increases or decreases the actual power to the new \ref PowerField
 *  level over the total number of degrees of rotation specified in \ref TachoLimitField. */
#define RunStateField        6
/** Turn ratio field. Contains the current turn ratio. Only applicable when synchronizing multiple motors. Read/write.
 *  Use this field to specify a proportional turning ratio. This field must be used in conjunction with other
 *  field values: \ref OutputModeField must include \ref OUT_MODE_MOTORON and \ref OUT_MODE_REGULATED, \ref RegModeField must be set to
 *  \ref OUT_REGMODE_SYNC, \ref RunStateField must not be \ref OUT_RUNSTATE_IDLE, and \ref PowerField must be non-zero.
 *  There are only three valid combinations of left and right motors for use with TurnRatioField: \ref OUT_AB, \ref OUT_BC,
 *  and \ref OUT_AC. In each of these three options the first motor listed is considered to be the left motor and
 *  the second motor is the right motor, regardless of the physical configuration of the robot.
 *  Negative turn ratio values shift power toward the left motor while positive values shift power toward the
 *  right motor. An absolute value of 50 usually results in one motor stopping. An absolute value of 100 usually
 *  results in two motors turning in opposite directions at equal power. */
#define TurnRatioField       7
/** Regulation mode field. Contains one of the regulation mode constants. Read/write.
 *  This field specifies the regulation mode to use with the specified port(s). It is ignored if
 *  the \ref OUT_MODE_REGULATED bit is not set in the \ref OutputModeField field. Unlike \ref OutputModeField, RegModeField is
 *  not a bitfield. Only one regulation mode value can be set at a time.
 *  Speed regulation means that the firmware tries to maintain a certain speed based on the \ref PowerField setting. The
 *  firmware adjusts the PWM duty cycle if the motor is affected by a physical load. This adjustment is
 *  reflected by the value of the \ref ActualSpeedField property. When using speed regulation, do not set \ref PowerField to its
 *  maximum value since the firmware cannot adjust to higher power levels in that situation.
 *  Synchronization means the firmware tries to keep two motors in sync regardless of physical loads. Use
 *  this mode to maintain a straight path for a mobile robot automatically. Also use this mode with the
 *  \ref TurnRatioField property to provide proportional turning.
 *  Set \ref OUT_REGMODE_SYNC on at least two motor ports in order for synchronization to function. Setting
 *  \ref OUT_REGMODE_SYNC on all three motor ports will result in only the first two (\ref OUT_A and \ref OUT_B) being
 *  synchronized. */
#define RegModeField         8
/** Overload field. Contains a boolean value which is TRUE if the motor is overloaded. Read only.
 *  This field will have a value of 1 (true) if the firmware speed regulation cannot overcome a physical
 *  load on the motor. In other words, the motor is turning more slowly than expected.
 *  If the motor speed can be maintained in spite of loading then this field value is zero (false).
 *  In order to use this field the motor must have a non-idle \ref RunStateField, an \ref OutputModeField which includes
 *  \ref OUT_MODE_MOTORON and \ref OUT_MODE_REGULATED, and its \ref RegModeField must be set to \ref OUT_REGMODE_SPEED. */
#define OverloadField        9
/** Proportional field. Contains the proportional constant for the PID motor controller. Read/write.
 *  This field specifies the proportional term used in the internal proportional-integral-derivative
 *  (PID) control algorithm.
 *  Set \ref UF_UPDATE_PID_VALUES to commit changes to RegPValue, RegIValue, and RegDValue simultaneously. */
#define RegPValueField       10
/** Integral field. Contains the integral constant for the PID motor controller. Read/write.
 *  This field specifies the integral term used in the internal proportional-integral-derivative
 *  (PID) control algorithm.
 *  Set \ref UF_UPDATE_PID_VALUES to commit changes to RegPValue, RegIValue, and RegDValue simultaneously. */
#define RegIValueField       11
/** Derivative field. Contains the derivative constant for the PID motor controller. Read/write.
 *  This field specifies the derivative term used in the internal proportional-integral-derivative
 *  (PID) control algorithm.
 *  Set \ref UF_UPDATE_PID_VALUES to commit changes to RegPValue, RegIValue, and RegDValue simultaneously. */
#define RegDValueField       12
/** NXT-G block tachometer count field. Contains the current NXT-G block tachometer count. Read only.
 *  Return the block-relative position counter value for the specified port.
 *  Refer to the \ref UpdateFlagsField description for information about how to use block-relative
 *  position counts.
 *  Set the \ref UF_UPDATE_RESET_BLOCK_COUNT flag in \ref UpdateFlagsField to request that the firmware
 *  reset the BlockTachoCountField.
 *  The sign of BlockTachoCountField indicates the direction of rotation. Positive values indicate
 *  forward rotation and negative values indicate reverse rotation. Forward and reverse depend on
 *  the orientation of the motor. */
#define BlockTachoCountField 13
/** Rotation counter field. Contains the current rotation count. Read only.
 *  Return the program-relative position counter value for the specified port.
 *  Refer to the \ref UpdateFlagsField description for information about how to use program-relative
 *  position counts.
 *  Set the \ref UF_UPDATE_RESET_ROTATION_COUNT flag in \ref UpdateFlagsField to request that the firmware reset
 *  the RotationCountField.
 *  The sign of RotationCountField indicates the direction of rotation. Positive values indicate forward
 *  rotation and negative values indicate reverse rotation. Forward and reverse depend on the
 *  orientation of the motor. */
#define RotationCountField   14
#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/** Options field. Contains a combination of the output options constants. Read/write.
 *  Set options for how the output module will act when a tachometer limit is reached. Option
 *  constants can be combined with bitwise OR.  Use OUT_OPTION_HOLDATLIMIT to have the output
 *  module hold the motor when it reaches the tachometer limit.  Use OUT_OPTION_RAMPDOWNTOLIMIT
 *  to have the output module ramp down the motor power as it approaches the tachometer limit.
 *  \warning This option requires the enhanced NBC/NXC firmware version 1.31+
 */
#define OutputOptionsField   15
/** MaxSpeed field. Contains the current max speed value. Read/write.
 *  Set the maximum speed to be used during position regulation.
 *  \warning This option requires the enhanced NBC/NXC firmware version 1.31+
 */
#define MaxSpeedField   16
/** MaxAcceleration field. Contains the current max acceleration value. Read/write.
 *  Set the maximum acceleration to be used during position regulation.
 *  \warning This option requires the enhanced NBC/NXC firmware version 1.31+
 */
#define MaxAccelerationField   17
#endif
/** @} */  // end of OutputFieldConstants group

/** @defgroup OutputIOMAP Output module IOMAP offsets
 * Constant offsets into the Output module IOMAP structure.
 * @{
 */
#define OutputOffsetTachoCount(p)        (((p)*32)+0)  /*!< R  - Holds current number of counts, since last reset, updated every 1 mS (4 bytes) slong */
#define OutputOffsetBlockTachoCount(p)   (((p)*32)+4)  /*!< R  - Holds current number of counts for the current output block (4 bytes) slong */
#define OutputOffsetRotationCount(p)     (((p)*32)+8)  /*!< R  - Holds current number of counts for the rotation counter to the output (4 bytes) slong */
#define OutputOffsetTachoLimit(p)        (((p)*32)+12) /*!< RW - Holds number of counts to travel, 0 => Run forever (4 bytes) ulong */
#define OutputOffsetMotorRPM(p)          (((p)*32)+16) /*!< Not updated, will be removed later !! (2 bytes) sword */
#define OutputOffsetFlags(p)             (((p)*32)+18) /*!< RW - Holds flags for which data should be updated (1 byte) ubyte */
#define OutputOffsetMode(p)              (((p)*32)+19) /*!< RW - Holds motor mode: Run, Break, regulated, ... (1 byte) ubyte */
#define OutputOffsetSpeed(p)             (((p)*32)+20) /*!< RW - Holds the wanted speed (1 byte) sbyte */
#define OutputOffsetActualSpeed(p)       (((p)*32)+21) /*!< R  - Holds the current motor speed (1 byte) sbyte */
#define OutputOffsetRegPParameter(p)     (((p)*32)+22) /*!< RW - Holds the P-constant used in the regulation (1 byte) ubyte */
#define OutputOffsetRegIParameter(p)     (((p)*32)+23) /*!< RW - Holds the I-constant used in the regulation (1 byte) ubyte */
#define OutputOffsetRegDParameter(p)     (((p)*32)+24) /*!< RW - Holds the D-constant used in the regulation (1 byte) ubyte */
#define OutputOffsetRunState(p)          (((p)*32)+25) /*!< RW - Holds the current motor run state in the output module (1 byte) ubyte */
#define OutputOffsetRegMode(p)           (((p)*32)+26) /*!< RW - Tells which regulation mode should be used (1 byte) ubyte */
#define OutputOffsetOverloaded(p)        (((p)*32)+27) /*!< R  - True if the motor has been overloaded within speed control regulation (1 byte) ubyte */
#define OutputOffsetSyncTurnParameter(p) (((p)*32)+28) /*!< RW - Holds the turning parameter need within MoveBlock (1 byte) sbyte */
#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define OutputOffsetOptions(p)           (((p)*32)+29) /*!< RW - holds extra motor options related to the tachometer limit (1 byte) ubyte  (enhanced NBC/NXC firmware only) */
#define OutputOffsetMaxSpeed(p)          (((p)*32)+30) /*!< RW - holds the maximum speed for position regulation (1 byte) sbyte  (enhanced NBC/NXC firmware only) */
#define OutputOffsetMaxAccel(p)          (((p)*32)+31) /*!< RW - holds the maximum acceleration for position regulation (1 byte) sbyte  (enhanced NBC/NXC firmware only) */
#endif
#define OutputOffsetRegulationTime       96 /*!< use for frequency of checking regulation mode (1 byte) ubyte (enhanced NBC/NXC firmware only) */
#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define OutputOffsetRegulationOptions    97 /*!< use for position regulation options (1 byte) ubyte (enhanced NBC/NXC firmware only) */
#endif
/** @} */  // end of OutputIOMAP group
/** @} */  // end of OutputModuleConstants group
/** @} */  // end of OutputModule group

#endif // OUTPUT_CONSTANTS_H
