/** \file output.h
 * \brief The NXC output module API
 *
 * output.h contains the NXC output module API
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

#ifndef OUTPUT_H
#define OUTPUT_H

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// OUTPUT MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup OutputModule
 * @{
 */
/** @defgroup OutputModuleTypes Output module types
 * Types used by various output module functions.
 * @{
 */

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Parameters for the \ref RemoteGetOutputState function.
 * This structure is used when calling the \ref RemoteGetOutputState function.
 * Choose the sensor port (\ref OutputPortConstants) and after calling the function
 * read the output status values from the various structure fields.
 */
struct OutputStateType {
  byte Port;                /*!< The output port. See the \ref OutputPortConstants group. */
  char Power;               /*!< The output power level (-100..100). */
  byte Mode;                /*!< The output mode. See \ref OutModeConstants group. */
  byte RegMode;             /*!< The output regulation mode. See \ref OutRegModeConstants group. */
  char TurnRatio;           /*!< The output turning ratio (-100..100). */
  byte RunState;            /*!< The output run state. See \ref OutRunStateConstants group. */
  unsigned long TachoLimit; /*!< The tachometer limit. */
  long TachoCount;          /*!< The current tachometer count. */
  long BlockTachoCount;     /*!< The current block tachometer count. */
  long RotationCount;       /*!< The current rotation count. */
};

#endif

/** @} */ // end of OutputModuleTypes group

/** @defgroup OutputModuleFunctions Output module functions
 * Functions for accessing and modifying output module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Set motor regulation frequency.
 * Set the motor regulation frequency in milliseconds. By default this is set
 * to 100ms.
 * \param n The motor regulation frequency.
 */
inline void SetMotorPwnFreq(byte n);

/**
 * Set regulation time.
 * Set the motor regulation time in milliseconds. By default this is set
 * to 100ms.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 *
 * \param n The motor regulation time.
 */
inline void SetMotorRegulationTime(byte n);

/**
 * Set regulation options.
 * Set the motor regulation options.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 *
 * \param n The motor regulation options.
 */
inline void SetMotorRegulationOptions(byte n);

/**
 * Run motors forward synchronised with PID factors.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnFwdSyncPID(byte outputs, char pwr, char turnpct, byte p, byte i, byte d);

/**
 * Run motors forward synchronised and reset counters with PID factors.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnFwdSyncExPID(byte outputs, char pwr, char turnpct, const byte reset, byte p, byte i, byte d);

/**
 * Run motors backward synchronised with PID factors.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnRevSyncPID(byte outputs, char pwr, char turnpct, byte p, byte i, byte d);

/**
 * Run motors backward synchronised and reset counters with PID factors.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnRevSyncExPID(byte outputs, char pwr, char turnpct, const byte reset, byte p, byte i, byte d);

/**
 * Run motors forward regulated with PID factors.
 * Run the specified outputs forward using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnFwdRegPID(byte outputs, char pwr, byte regmode, byte p, byte i, byte d);

/**
 * Run motors forward regulated and reset counters with PID factors.
 * Run the specified outputs forward using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnFwdRegExPID(byte outputs, char pwr, byte regmode, const byte reset, byte p, byte i, byte d);

/**
 * Run motors reverse regulated with PID factors.
 * Run the specified outputs in reverse using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnRevRegPID(byte outputs, char pwr, byte regmode, byte p, byte i, byte d);

/**
 * Run motors backward regulated and reset counters with PID factors.
 * Run the specified outputs in reverse using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void OnRevRegExPID(byte outputs, char pwr, byte regmode, const byte reset, byte p, byte i, byte d);

/**
 * Turn motors off.
 * Turn the specified outputs off (with braking).
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
inline void Off(byte outputs);

/**
 * Turn motors off and reset counters.
 * Turn the specified outputs off (with braking).
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OffEx(byte outputs, const byte reset);

/**
 * Coast motors.
 * Turn off the specified outputs, making them coast to a stop.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
inline void Coast(byte outputs);

/**
 * Coast motors and reset counters.
 * Turn off the specified outputs, making them coast to a stop.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void CoastEx(byte outputs, const byte reset);

/**
 * Float motors.
 * Make outputs float. Float is an alias for Coast.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
inline void Float(byte outputs);

/**
 * Run motors forward.
 * Set outputs to forward direction and turn them on.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 */
inline void OnFwd(byte outputs, char pwr);

/**
 * Run motors forward and reset counters.
 * Set outputs to forward direction and turn them on.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnFwdEx(byte outputs, char pwr, const byte reset);

/**
 * Run motors backward.
 * Set outputs to reverse direction and turn them on.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 */
inline void OnRev(byte outputs, char pwr);

/**
 * Run motors backward and reset counters.
 * Set outputs to reverse direction and turn them on.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnRevEx(byte outputs, char pwr, const byte reset);

/**
 * Run motors forward regulated.
 * Run the specified outputs forward using the specified regulation mode.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 */
inline void OnFwdReg(byte outputs, char pwr, byte regmode);

/**
 * Run motors forward regulated and reset counters.
 * Run the specified outputs forward using the specified regulation mode.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnFwdRegEx(byte outputs, char pwr, byte regmode, const byte reset);

/**
 * Run motors forward regulated.
 * Run the specified outputs in reverse using the specified regulation mode.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 */
inline void OnRevReg(byte outputs, char pwr, byte regmode);

/**
 * Run motors backward regulated and reset counters.
 * Run the specified outputs in reverse using the specified regulation mode.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param regmode Regulation mode, see \ref OutRegModeConstants.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnRevRegEx(byte outputs, char pwr, byte regmode, const byte reset);

/**
 * Run motors forward synchronised.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 */
inline void OnFwdSync(byte outputs, char pwr, char turnpct);

/**
 * Run motors forward synchronised and reset counters.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnFwdSyncEx(byte outputs, char pwr, char turnpct, const byte reset);

/**
 * Run motors backward synchronised.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 */
inline void OnRevSync(byte outputs, char pwr, char turnpct);

/**
 * Run motors backward synchronised and reset counters.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
inline void OnRevSyncEx(byte outputs, char pwr, char turnpct, const byte reset);

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param angle Angle limit, in degree. Can be negative to reverse direction.
 */
inline void RotateMotor(byte outputs, char pwr, long angle);

/**
 * Rotate motor with PID factors.
 * Run the specified outputs forward for the specified number of degrees.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param angle Angle limit, in degree. Can be negative to reverse direction.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void RotateMotorPID(byte outputs, char pwr, long angle, byte p, byte i, byte d);

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param angle Angle limit, in degree. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param sync Synchronise two motors. Should be set to true if a non-zero
 * turn percent is specified or no turning will occur.
 * \param stop Specify whether the motor(s) should brake at the end of the
 * rotation.
 */
inline void RotateMotorEx(byte outputs, char pwr, long angle, char turnpct, bool sync, bool stop);

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 * Specify proportional, integral, and derivative factors.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param angle Angle limit, in degree. Can be negative to reverse direction.
 * \param turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param sync Synchronise two motors. Should be set to true if a non-zero
 * turn percent is specified or no turning will occur.
 * \param stop Specify whether the motor(s) should brake at the end of the
 * rotation.
 * \param p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
inline void RotateMotorExPID(byte outputs, char pwr, long angle, char turnpct, bool sync, bool stop, byte p, byte i, byte d);

/**
 * Reset tachometer counter.
 * Reset the tachometer count and tachometer limit goal for the specified
 * outputs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
inline void ResetTachoCount(byte outputs);

/**
 * Reset block-relative counter.
 * Reset the block-relative position counter for the specified outputs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
inline void ResetBlockTachoCount(byte outputs);

/**
 * Reset program-relative counter.
 * Reset the program-relative position counter for the specified outputs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
inline void ResetRotationCount(byte outputs);

/**
 * Reset all tachometer counters.
 * Reset all three position counters and reset the current tachometer limit
 * goal for the specified outputs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
inline void ResetAllTachoCounts(byte outputs);

/**
 * Set output fields.
 * Set the specified field of the outputs to the value provided. The field
 * must be a valid output field constant. This function takes a variable
 * number of field/value pairs.
 *
 * \param outputs Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 * \param field1 The 1st output port field to access, this should be a constant, see
 * \ref OutputFieldConstants.
 * \param val1 Value to set for the 1st field.
 * \param fieldN The Nth output port field to access, this should be a constant, see
 * \ref OutputFieldConstants.
 * \param valN The value to set for the Nth field.
 */
inline void SetOutput(byte outputs, byte field1, variant val1, ..., byte fieldN, variant valN);

/**
 * Get output field value.
 * Get the value of the specified field for the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \param field Output port field to access, this should be a constant, see
 * \ref OutputFieldConstants.
 * \return The requested output field value.
 */
inline variant GetOutput(byte output, const byte field);

/**
 * Get motor mode.
 * Get the mode of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The mode of the specified output.
 */
inline byte MotorMode(byte output);

/**
 * Get motor power level.
 * Get the power level of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The power level of the specified output.
 */
inline char MotorPower(byte output);

/**
 * Get motor actual speed.
 * Get the actual speed value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The actual speed value of the specified output.
 */
inline char MotorActualSpeed(byte output);

/**
 * Get motor tachometer counter.
 * Get the tachometer count value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The tachometer count value of the specified output.
 */
inline long MotorTachoCount(byte output);

/**
 * Get motor tachometer limit.
 * Get the tachometer limit value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The tachometer limit value of the specified output.
 */
inline long MotorTachoLimit(byte output);

/**
 * Get motor run state.
 * Get the RunState value of the specified output, see \ref
 * OutRunStateConstants.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The RunState value of the specified output.
 */
inline byte MotorRunState(byte output);

/**
 * Get motor turn ratio.
 * Get the turn ratio value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The turn ratio value of the specified output.
 */
inline char MotorTurnRatio(byte output);

/**
 * Get motor regulation mode.
 * Get the regulation value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The regulation value of the specified output.
 */
inline byte MotorRegulation(byte output);

/**
 * Get motor overload status.
 * Get the overload value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The overload value of the specified output.
 */
inline bool MotorOverload(byte output);

/**
 * Get motor P value.
 * Get the proportional PID value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The proportional PID value of the specified output.
 */
inline byte MotorRegPValue(byte output);

/**
 * Get motor I value.
 * Get the integral PID value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The integral PID value of the specified output.
 */
inline byte MotorRegIValue(byte output);

/**
 * Get motor D value.
 * Get the derivative PID value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The derivative PID value of the specified output.
 */
inline byte MotorRegDValue(byte output);

/**
 * Get motor block-relative counter.
 * Get the block-relative position counter value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The block-relative position counter value of the specified output.
 */
inline long MotorBlockTachoCount(byte output);

/**
 * Get motor program-relative counter.
 * Get the program-relative position counter value of the specified output.
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The program-relative position counter value of the specified output.
 */
inline long MotorRotationCount(byte output);

/**
 * Get motor options.
 * Get the options value of the specified output.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The options value of the specified output.
 */
inline byte MotorOutputOptions(byte output);

/**
 * Get motor max speed.
 * Get the max speed value of the specified output.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The max speed value of the specified output.
 */
inline byte MotorMaxSpeed(byte output);

/**
 * Get motor max acceleration.
 * Get the max acceleration value of the specified output.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 *
 * \param output Desired output port. Can be \ref OUT_A, \ref OUT_B, \ref
 * OUT_C or a variable containing one of these values, see \ref
 * OutputPortConstants.
 * \return The max acceleration value of the specified output.
 */
inline byte MotorMaxAcceleration(byte output);

/**
 * Get motor regulation frequency.
 * Get the current motor regulation frequency in milliseconds.
 * \return The motor regulation frequency.
 */
inline byte MotorPwnFreq();

/**
 * Get motor regulation time.
 * Get the current motor regulation time in milliseconds.
 * \return The motor regulation time.
 */
inline byte MotorRegulationTime();

/**
 * Get motor regulation options.
 * Get the current motor regulation options.
 * \return The motor regulation options.
 */
inline byte MotorRegulationOptions();

#else

// output fields
#define MotorMode(_p) GetOutput(_p, OutputMode)
#define MotorPower(_p) GetOutput(_p, Power)
#define MotorActualSpeed(_p) GetOutput(_p, ActualSpeed)
#define MotorTachoCount(_p) GetOutput(_p, TachoCount)
#define MotorTachoLimit(_p) GetOutput(_p, TachoLimit)
#define MotorRunState(_p) GetOutput(_p, RunState)
#define MotorTurnRatio(_p) GetOutput(_p, TurnRatio)
#define MotorRegulation(_p) GetOutput(_p, RegMode)
#define MotorOverload(_p) GetOutput(_p, Overload)
#define MotorRegPValue(_p) GetOutput(_p, RegPValue)
#define MotorRegIValue(_p) GetOutput(_p, RegIValue)
#define MotorRegDValue(_p) GetOutput(_p, RegDValue)
#define MotorBlockTachoCount(_p) GetOutput(_p, BlockTachoCount)
#define MotorRotationCount(_p) GetOutput(_p, RotationCount)

#define MotorPwnFreq() asm { GetOutPwnFreq(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SetMotorPwnFreq(_n) asm { __setOutPwnFreq(_n) }
#define MotorRegulationTime() asm { GetOutRegulationTime(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SetMotorRegulationTime(_n) asm { __setOutRegulationTime(_n) }

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define MotorOutputOptions(_p) GetOutput(_p, OutputOptions)
#define MotorMaxSpeed(_p) GetOutput(_p, MaxSpeed)
#define MotorMaxAcceleration(_p) GetOutput(_p, MaxAcceleration)
#define MotorRegulationOptions() asm { GetOutRegulationOptions(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SetMotorRegulationOptions(_n) asm { __setOutRegulationOptions(_n) }
#endif

#endif

/** @} */ // end of OutputModuleFunctions group
/** @} */ // end of OutputModule group
/** @} */ // end of NXTFirmwareModules group

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

#endif // OUTPUT_H
