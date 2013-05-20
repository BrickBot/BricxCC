/** \file posreg.h
 * \brief Documentation for the NXC Position Regulation API
 *
 * posreg.h contains additional documentation for the NXC Position Regulation API
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
#ifndef POSREG_H
#define POSREG_H

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup OutputModule
 * @{
 */
/** @addtogroup OutputModuleFunctions
 * @{
 */

/**
 * Enable absolute position regulation with PID factors.
 * Enable absolute position regulation on the specified output.  Motor is kept
 * regulated as long as this is enabled.
 * Optionally specify proportional, integral, and derivative factors.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 *
 * \param output Desired output port. Can be a constant or a variable, see
 * \ref OutputPortConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants. Default value is \ref PID_3.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants. Default value is \ref PID_1.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants. Default value is \ref PID_1.
 */
inline void PosRegEnable(byte output, byte p = PID_3, byte i = PID_1, byte d = PID_1)
{
    SetOutput(output,
	       OutputModeField, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED,
	       RegModeField, OUT_REGMODE_POS,
	       RunStateField, OUT_RUNSTATE_RUNNING,
	       PowerField, 0,
	       TurnRatioField, 0,
	       RegPValueField, p, RegIValueField, i, RegDValueField, d,
	       UpdateFlagsField, UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+UF_UPDATE_RESET_COUNT);
    Wait(MS_2);
}

/**
 * Change the current value for set angle.
 * Make the absolute position regulation going toward the new provided angle.
 * Returns immediately, but keep regulating.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 *
 * \param output Desired output port. Can be a constant or a variable, see
 * \ref OutputPortConstants.
 * \param angle New set position, in degree. The 0 angle corresponds to the
 * position of the motor when absolute position regulation was first enabled.
 * Can be negative. Can be greater than 360 degree to make several turns.
 */
inline void PosRegSetAngle(byte output, long angle)
{
    SetOutput(output,
	       TachoLimitField, angle,
	       UpdateFlagsField, UF_UPDATE_TACHO_LIMIT);
}

/**
 * Add to the current value for set angle.
 * Add an offset to the current set position. Returns immediately, but keep
 * regulating.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 *
 * \param output Desired output port. Can be a constant or a variable, see
 * \ref OutputPortConstants.
 * \param angle_add Value to add to the current set position, in degree. Can
 * be negative. Can be greater than 360 degree to make several turns.
 */
inline void PosRegAddAngle(byte output, long angle_add)
{
    long current_angle = GetOutput(output, TachoLimitField);
    SetOutput(output,
	       TachoLimitField, current_angle + angle_add,
	       UpdateFlagsField, UF_UPDATE_TACHO_LIMIT);
}

/**
 * Set maximum limits.
 * Set maximum speed and acceleration.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 *
 * \param output Desired output port. Can be a constant or a variable, see
 * \ref OutputPortConstants.
 * \param max_speed Maximum speed, or 0 to disable speed limiting.
 * \param max_acceleration Maximum acceleration, or 0 to disable acceleration
 * limiting. The max_speed parameter should not be 0 if this is not 0.
 */
inline void PosRegSetMax(byte output, byte max_speed, byte max_acceleration)
{
    SetOutput(output,
	       MaxSpeedField, max_speed,
	       MaxAccelerationField, max_acceleration,
	       UpdateFlagsField, UF_UPDATE_PID_VALUES);
    Wait(MS_2);
}

/** @} */ // end of OutputModuleFunctions group
/** @} */ // end of OutputModule group
/** @} */ // end of NXTFirmwareModules group
#endif


#endif // POSREG_H
