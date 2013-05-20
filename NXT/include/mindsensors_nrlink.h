/** \file mindsensors_nrlink.h
 * \brief The NXC mindsensors.com NRLink API
 *
 * mindsensors_nrlink.h contains the NXC mindsensors.com NRLink API
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

#ifndef MINDSENSORS_NRLINK_H
#define MINDSENSORS_NRLINK_H

#include "mindsensors_constants.h"
#include "rcxapi_constants.h"

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup MindSensorsAPI
 * @{
 */

///////////////////////////////////////////////////////////////////////////////
//////////////////////////// MindSensors NRLINK API ///////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup MindSensorsNRLinkAPI
 * @{
 */

/**
 * Configure NRLink in 2400 baud mode.
 * Configure the mindsensors NRLink device in 2400 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLink2400(const byte port, const byte i2caddr);

/**
 * Configure NRLink in 4800 baud mode.
 * Configure the mindsensors NRLink device in 4800 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLink4800(const byte port, const byte i2caddr);

/**
 * Flush NRLink buffers.
 * Flush the mindsensors NRLink device buffers. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkFlush(const byte port, const byte i2caddr);

/**
 * Configure NRLink in IR long mode.
 * Configure the mindsensors NRLink device in IR long mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkIRLong(const byte port, const byte i2caddr);

/**
 * Configure NRLink in IR short mode.
 * Configure the mindsensors NRLink device in IR short mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkIRShort(const byte port, const byte i2caddr);

/**
 * Configure NRLink in power function mode.
 * Configure the mindsensors NRLink device in power function mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkSetPF(const byte port, const byte i2caddr);

/**
 * Configure NRLink in RCX mode.
 * Configure the mindsensors NRLink device in RCX mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkSetRCX(const byte port, const byte i2caddr);

/**
 * Configure NRLink in IR train mode.
 * Configure the mindsensors NRLink device in IR train mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkSetTrain(const byte port, const byte i2caddr);

/**
 * Configure NRLink in raw IR transmit mode.
 * Configure the mindsensors NRLink device in raw IR transmit mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The function call result.
 */
inline char NRLinkTxRaw(const byte port, const byte i2caddr);

/**
 * Read NRLink status.
 * Read the status of the mindsensors NRLink device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \return The mindsensors NRLink status.
 */
inline byte NRLinkStatus(const byte port, const byte i2caddr);

/**
 * Run NRLink macro.
 * Run the specified mindsensors NRLink device macro. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param macro The address of the macro to execute.
 * \return The function call result.
 */
inline char RunNRLinkMacro(const byte port, const byte i2caddr, const byte macro);

/**
 * Write data to NRLink.
 * Write data to the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param data A byte array containing the data to write.
 * \return The function call result.
 */
inline char WriteNRLinkBytes(const byte port, const byte i2caddr, const byte data[]);

/**
 * Read data from NRLink.
 * Read data from the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param data A byte array that will contain the data read from the device on output.
 * \return The function call result.
 */
inline bool ReadNRLinkBytes(const byte port, const byte i2caddr, byte & data[]);

/**
 * MSIRTrain function.
 * Control an IR Train receiver set to the specified channel using the
 * mindsensors NRLink device. Valid function values are \ref TRAIN_FUNC_STOP,
 * \ref TRAIN_FUNC_INCR_SPEED, \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT.
 * Valid channels are \ref TRAIN_CHANNEL_1 through \ref TRAIN_CHANNEL_3 and
 * \ref TRAIN_CHANNEL_ALL. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The IR Train channel.  See \ref IRTrainChannels.
 * \param func The IR Train function. See \ref IRTrainFuncs
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSIRTrain(const byte port, const byte i2caddr, const byte channel, const byte func);

/**
 * MSPFComboDirect function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the mindsensors NRLink device. Commands for outa and outb are
 * PF_CMD_STOP, PF_CMD_REV, PF_CMD_FWD, and \ref PF_CMD_BRAKE. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param outb The Power Function command for output B. See \ref PFCmdConstants.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFComboDirect(const byte port, const byte i2caddr, const byte channel, const byte outa, const byte outb);

/**
 * MSPFComboPWM function.
 * Control the speed of both outputs on a Power Function receiver set to the
 * specified channel using the mindsensors NRLink device. Valid output values
 * are \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param outa The Power Function PWM command for output A. See \ref PFPWMOptions.
 * \param outb The Power Function PWM command for output B. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFComboPWM(const byte port, const byte i2caddr, const byte channel, const byte outa, const byte outb);

/**
 * MSPFRawOutput function.
 * Control a Power Function receiver set to the specified channel using the
 * mindsensors NRLink device. Build the raw data stream using the 3 nibbles
 * (4 bit values). The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param nibble0 The first raw data nibble.
 * \param nibble1 The second raw data nibble.
 * \param nibble2 The third raw data nibble.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFRawOutput(const byte port, const byte i2caddr, const byte nibble0, const byte nibble1, const byte nibble2);

/**
 * MSPFRepeat function.
 * Repeat sending the last Power Function command using the mindsensors
 * NRLink device. Specify the number of times to repeat the command and the
 * number of milliseconds of delay between each repetition. The port must be
 * configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param count The number of times to repeat the command.
 * \param delay The number of milliseconds to delay between each repetition.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFRepeat(const byte port, const byte i2caddr, const byte count, const unsigned int delay);

/**
 * MSPFSingleOutputCST function.
 * Control a single output on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are \ref PF_CST_CLEAR1_CLEAR2,
 * \ref PF_CST_SET1_CLEAR2, \ref PF_CST_CLEAR1_SET2, \ref PF_CST_SET1_SET2,
 * \ref PF_CST_INCREMENT_PWM, \ref PF_CST_DECREMENT_PWM, \ref PF_CST_FULL_FWD,
 * \ref PF_CST_FULL_REV, and \ref PF_CST_TOGGLE_DIR. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function CST function. See \ref PFCSTOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSingleOutputCST(const byte port, const byte i2caddr, const byte channel, const byte out, const byte func);

/**
 * MSPFSingleOutputPWM function.
 * Control the speed of a single output on a Power Function receiver set to
 * the specified channel using the mindsensors NRLink device. Select the
 * desired output using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are
 * \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param func The Power Function PWM function. See \ref PFPWMOptions.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSingleOutputPWM(const byte port, const byte i2caddr, const byte channel, const byte out, const byte func);

/**
 * MSPFSinglePin function.
 * Control a single pin on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B.  Select the desired pin using \ref PF_PIN_C1 or
 * \ref PF_PIN_C2. Valid functions are \ref PF_FUNC_NOCHANGE, \ref PF_FUNC_CLEAR,
 * \ref PF_FUNC_SET, and \ref PF_FUNC_TOGGLE. Valid channels are \ref PF_CHANNEL_1 through
 * \ref PF_CHANNEL_4. Specify whether the mode by passing true (continuous) or
 * false (timeout) as the final parameter. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param out The Power Function output. See \ref PFOutputs.
 * \param pin The Power Function pin. See \ref PFPinConstants.
 * \param func The Power Function single pin function. See \ref PFPinFuncs.
 * \param cont Control whether the mode is continuous or timeout.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFSinglePin(const byte port, const byte i2caddr, const byte channel, const byte out, const byte pin, const byte func, bool cont);

/**
 * MSPFTrain function.
 * Control both outputs on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device as if it were an IR Train
 * receiver. Valid function values are \ref TRAIN_FUNC_STOP, \ref TRAIN_FUNC_INCR_SPEED,
 * \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param channel The Power Function channel.  See \ref PFChannelConstants.
 * \param func The Power Function train function. See \ref IRTrainFuncs.
 * \return The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
inline char MSPFTrain(const byte port, const byte i2caddr, const byte channel, const byte func);

/**
 * MSRCXSetIRLinkPort function.
 * Set the global port in advance of using the MSRCX* and MSScout* API
 * functions for sending RCX and Scout messages over the mindsensors NRLink
 * device. The port must be configured as a Lowspeed port before using any of
 * the mindsensors RCX and Scout NRLink functions.
 *
 * \param port The sensor port. See \ref InPorts.
 * \param i2caddr The sensor I2C address. See sensor documentation for this value.
 */
inline void MSRCXSetNRLinkPort(const byte port, const byte i2caddr);

/**
 * MSRCXBatteryLevel function.
 * Send the BatteryLevel command to an RCX to read the current battery level.
 *
 * \return The RCX battery level.
 */
inline int MSRCXBatteryLevel(void);

/**
 * MSRCXPoll function.
 * Send the Poll command to an RCX to read a signed 2-byte value at the
 * specified source and value combination.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 * \return The value read from the specified port and value.
 */
inline int MSRCXPoll(const byte src, const byte value);

/**
 * MSRCXPollMemory function.
 * Send the PollMemory command to an RCX.
 *
 * \param address The RCX memory address.
 * \return The value read from the specified address.
 */
inline int MSRCXPollMemory(const unsigned int address);

/**
 * MSRCXAbsVar function.
 * Send the AbsVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXAbsVar(const byte varnum, const byte byte src, const unsigned int value);

/**
 * MSRCXAddToDatalog function.
 * Send the AddToDatalog command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXAddToDatalog(const byte src, const unsigned int value);

/**
 * MSRCXAndVar function.
 * Send the AndVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXAndVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXBoot function.
 * Send the Boot command to an RCX.
 */
inline void MSRCXBoot(void);

/**
 * MSRCXCalibrateEvent function.
 * Send the CalibrateEvent command to an RCX.
 *
 * \param evt The event number.
 * \param low The low threshold.
 * \param hi The high threshold.
 * \param hyst The hysterisis value.
 */
inline void MSRCXCalibrateEvent(const byte evt, const byte low, const byte hi, const byte hyst);

/**
 * MSRCXClearAllEvents function.
 * Send the ClearAllEvents command to an RCX.
 */
inline void MSRCXClearAllEvents(void);

/**
 * MSRCXClearCounter function.
 * Send the ClearCounter command to an RCX.
 *
 * \param counter The counter to clear.
 */
inline void MSRCXClearCounter(const byte counter);

/**
 * MSRCXClearMsg function.
 * Send the ClearMsg command to an RCX.
 */
inline void MSRCXClearMsg(void);

/**
 * MSRCXClearSensor function.
 * Send the ClearSensor command to an RCX.
 *
 * \param port The RCX port number.
 */
inline void MSRCXClearSensor(const byte port);

/**
 * MSRCXClearSound function.
 * Send the ClearSound command to an RCX.
 */
inline void MSRCXClearSound(void);

/**
 * MSRCXClearTimer function.
 * Send the ClearTimer command to an RCX.
 *
 * \param timer The timer to clear.
 */
inline void MSRCXClearTimer(const byte timer);

/**
 * MSRCXCreateDatalog function.
 * Send the CreateDatalog command to an RCX.
 *
 * \param size The new datalog size.
 */
inline void MSRCXCreateDatalog(const unsigned int size);

/**
 * MSRCXDecCounter function.
 * Send the DecCounter command to an RCX.
 *
 * \param counter The counter to decrement.
 */
inline void MSRCXDecCounter(const byte counter);

/**
 * MSRCXDeleteSub function.
 * Send the DeleteSub command to an RCX.
 *
 * \param s The subroutine number to delete.
 */
inline void MSRCXDeleteSub(const byte s);

/**
 * MSRCXDeleteSubs function.
 * Send the DeleteSubs command to an RCX.
 */
inline void MSRCXDeleteSubs(void);

/**
 * MSRCXDeleteTask function.
 * Send the DeleteTask command to an RCX.
 *
 * \param t The task number to delete.
 */
inline void MSRCXDeleteTask(const byte t);

/**
 * MSRCXDeleteTasks function.
 * Send the DeleteTasks command to an RCX.
 */
inline void MSRCXDeleteTasks(void);

/**
 * MSRCXDisableOutput function.
 * Send the DisableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to disable. See \ref RCXOutputConstants.
 */
inline void MSRCXDisableOutput(const byte outputs);

/**
 * MSRCXDivVar function.
 * Send the DivVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXDivVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXEnableOutput function.
 * Send the EnableOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to enable. See \ref RCXOutputConstants.
 */
inline void MSRCXEnableOutput(const byte outputs);

/**
 * MSRCXEvent function.
 * Send the Event command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXEvent(const byte src, const unsigned int value);

/**
 * MSRCXFloat function.
 * Send commands to an RCX to float the specified outputs.
 *
 * \param outputs The RCX output(s) to float. See \ref RCXOutputConstants.
 */
inline void MSRCXFloat(const byte outputs);

/**
 * MSRCXFwd function.
 * Send commands to an RCX to set the specified outputs to the forward direction.
 *
 * \param outputs The RCX output(s) to set forward. See \ref RCXOutputConstants.
 */
inline void MSRCXFwd(const byte outputs);

/**
 * MSRCXIncCounter function.
 * Send the IncCounter command to an RCX.
 *
 * \param counter The counter to increment.
 */
inline void MSRCXIncCounter(const byte counter);

/**
 * MSRCXInvertOutput function.
 * Send the InvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to invert. See \ref RCXOutputConstants.
 */
inline void MSRCXInvertOutput(const byte outputs);

/**
 * MSRCXMulVar function.
 * Send the MulVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXMulVar(const byte varnum, const byte src, unsigned int value);

/**
 * MSRCXMuteSound function.
 * Send the MuteSound command to an RCX.
 */
inline void MSRCXMuteSound(void);

/**
 * MSRCXObvertOutput function.
 * Send the ObvertOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to obvert. See \ref RCXOutputConstants.
 */
inline void MSRCXObvertOutput(const byte outputs);

/**
 * MSRCXOff function.
 * Send commands to an RCX to turn off the specified outputs.
 *
 * \param outputs The RCX output(s) to turn off. See \ref RCXOutputConstants.
 */
inline void MSRCXOff(const byte outputs);

/**
 * MSRCXOn function.
 * Send commands to an RCX to turn on the specified outputs.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 */
inline void MSRCXOn(const byte outputs);

/**
 * MSRCXOnFor function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction for the specified duration.
 *
 * \param outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 * \param ms The number of milliseconds to leave the outputs on
 */
inline void MSRCXOnFor(const byte outputs, const unsigned int ms);

/**
 * MSRCXOnFwd function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction.
 *
 * \param outputs The RCX output(s) to turn on in the forward direction. See \ref RCXOutputConstants.
 */
inline void MSRCXOnFwd(const byte outputs);

/**
 * MSRCXOnRev function.
 * Send commands to an RCX to turn on the specified outputs in the reverse direction.
 *
 * \param outputs The RCX output(s) to turn on in the reverse direction. See \ref RCXOutputConstants.
 */
inline void MSRCXOnRev(const byte outputs);

/**
 * MSRCXOrVar function.
 * Send the OrVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXOrVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXPBTurnOff function.
 * Send the PBTurnOff command to an RCX.
 */
inline void MSRCXPBTurnOff(void);

/**
 * MSRCXPing function.
 * Send the Ping command to an RCX.
 */
inline void MSRCXPing(void);

/**
 * MSRCXPlaySound function.
 * Send the PlaySound command to an RCX.
 *
 * \param snd The sound number to play.
 */
inline void MSRCXPlaySound(const byte snd);

/**
 * MSRCXPlayTone function.
 * Send the PlayTone command to an RCX.
 *
 * \param freq The frequency of the tone to play.
 * \param duration The duration of the tone to play.
 */
inline void MSRCXPlayTone(const unsigned int freq, const byte duration);

/**
 * MSRCXPlayToneVar function.
 * Send the PlayToneVar command to an RCX.
 *
 * \param varnum The variable containing the tone frequency to play.
 * \param duration The duration of the tone to play.
 */
inline void MSRCXPlayToneVar(const byte varnum, const byte duration);

/**
 * MSRCXRemote function.
 * Send the Remote command to an RCX.
 *
 * \param cmd The RCX IR remote command to send. See \ref RCXRemoteConstants.
 */
inline void MSRCXRemote(unsigned int cmd);

/**
 * MSRCXReset function.
 * Send the Reset command to an RCX.
 */
inline void MSRCXReset(void);

/**
 * MSRCXRev function.
 * Send commands to an RCX to set the specified outputs to the reverse direction.
 *
 * \param outputs The RCX output(s) to reverse direction. See \ref RCXOutputConstants.
 */
inline void MSRCXRev(const byte outputs);

/**
 * MSRCXSelectDisplay function.
 * Send the SelectDisplay command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSelectDisplay(const byte src, const unsigned int value);

/**
 * MSRCXSelectProgram function.
 * Send the SelectProgram command to an RCX.
 *
 * \param prog The program number to select.
 */
inline void MSRCXSelectProgram(const byte prog);

/**
 * MSRCXSendSerial function.
 * Send the SendSerial command to an RCX.
 *
 * \param first The first byte address.
 * \param count The number of bytes to send.
 */
inline void MSRCXSendSerial(const byte first, const byte count);

/**
 * MSRCXSet function.
 * Send the Set command to an RCX.
 *
 * \param dstsrc The RCX destination source.  See \ref RCXSourceConstants.
 * \param dstval The RCX destination value.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSet(const byte dstsrc, const byte dstval, const byte src, unsigned int value);

/**
 * MSRCXSetDirection function.
 * Send the SetDirection command to an RCX to configure the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to set direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void MSRCXSetDirection(const byte outputs, const byte dir);

/**
 * MSRCXSetEvent function.
 * Send the SetEvent command to an RCX.
 *
 * \param evt The event number to set.
 * \param src The RCX source. See \ref RCXSourceConstants.
 * \param type The event type.
 */
inline void MSRCXSetEvent(const byte evt, const byte src, const byte type);

/**
 * MSRCXSetGlobalDirection function.
 * Send the SetGlobalDirection command to an RCX.
 *
 * \param outputs The RCX output(s) to set global direction. See \ref RCXOutputConstants.
 * \param dir The RCX output direction. See \ref RCXOutputDirection.
 */
inline void MSRCXSetGlobalDirection(const byte outputs, const byte dir);

/**
 * MSRCXSetGlobalOutput function.
 * Send the SetGlobalOutput command to an RCX.
 *
 * \param outputs The RCX output(s) to set global mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void MSRCXSetGlobalOutput(const byte outputs, const byte mode);

/**
 * MSRCXSetMaxPower function.
 * Send the SetMaxPower command to an RCX.
 *
 * \param outputs The RCX output(s) to set max power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void MSRCXSetMaxPower(const byte outputs, const byte pwrsrc, const byte pwrval);

/**
 * MSRCXSetMessage function.
 * Send the SetMessage command to an RCX.
 *
 * \param msg The numeric message to send.
 */
inline void MSRCXSetMessage(const byte msg);

/**
 * MSRCXSetOutput function.
 * Send the SetOutput command to an RCX to configure the mode of the specified outputs
 *
 * \param outputs The RCX output(s) to set mode. See \ref RCXOutputConstants.
 * \param mode The RCX output mode. See \ref RCXOutputMode.
 */
inline void MSRCXSetOutput(const byte outputs, const byte mode);

/**
 * MSRCXSetPower function.
 * Send the SetPower command to an RCX to configure the power level of the specified outputs.
 *
 * \param outputs The RCX output(s) to set power. See \ref RCXOutputConstants.
 * \param pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param pwrval The RCX value.
 */
inline void MSRCXSetPower(const byte outputs, const byte pwrsrc, const byte pwrval);

/**
 * MSRCXSetPriority function.
 * Send the SetPriority command to an RCX.
 *
 * \param p The new task priority.
 */
inline void MSRCXSetPriority(const byte p);

/**
 * MSRCXSetSensorMode function.
 * Send the SetSensorMode command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param mode The RCX sensor mode.
 */
inline void MSRCXSetSensorMode(const byte port, const byte mode);

/**
 * MSRCXSetSensorType function.
 * Send the SetSensorType command to an RCX.
 *
 * \param port The RCX sensor port.
 * \param type The RCX sensor type.
 */
inline void MSRCXSetSensorType(const byte port, const byte type);

/**
 * MSRCXSetSleepTime function.
 * Send the SetSleepTime command to an RCX.
 *
 * \param t The new sleep time value.
 */
inline void MSRCXSetSleepTime(const byte t);

/**
 * MSRCXSetTxPower function.
 * Send the SetTxPower command to an RCX.
 *
 * \param pwr The IR transmit power level.
 */
inline void MSRCXSetTxPower(const byte pwr);

/**
 * MSRCXSetUserDisplay function.
 * Send the SetUserDisplay command to an RCX.
 *
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 * \param precision The number of digits of precision.
 */
inline void MSRCXSetUserDisplay(const byte src, const unsigned int value, const byte precision);

/**
 * MSRCXSetVar function.
 * Send the SetVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSetVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXSetWatch function.
 * Send the SetWatch command to an RCX.
 *
 * \param hours The new watch time hours value.
 * \param minutes The new watch time minutes value.
 */
inline void MSRCXSetWatch(const byte hours, const byte minutes);

/**
 * MSRCXSgnVar function.
 * Send the SgnVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSgnVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXStartTask function.
 * Send the StartTask command to an RCX.
 *
 * \param t The task number to start.
 */
inline void MSRCXStartTask(const byte t);

/**
 * MSRCXStopAllTasks function.
 * Send the StopAllTasks command to an RCX.
 */
inline void MSRCXStopAllTasks(void);

/**
 * MSRCXStopTask function.
 * Send the StopTask command to an RCX.
 *
 * \param t The task number to stop.
 */
inline void MSRCXStopTask(const byte t);

/**
 * MSRCXSubVar function.
 * Send the SubVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSubVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXSumVar function.
 * Send the SumVar command to an RCX.
 *
 * \param varnum The variable number to change.
 * \param src The RCX source.  See \ref RCXSourceConstants.
 * \param value The RCX value.
 */
inline void MSRCXSumVar(const byte varnum, const byte src, const unsigned int value);

/**
 * MSRCXToggle function.
 * Send commands to an RCX to toggle the direction of the specified outputs.
 *
 * \param outputs The RCX output(s) to toggle. See \ref RCXOutputConstants.
 */
inline void MSRCXToggle(const byte outputs);

/**
 * MSRCXUnlock function.
 * Send the Unlock command to an RCX.
 */
inline void MSRCXUnlock(void);

/**
 * MSRCXUnmuteSound function.
 * Send the UnmuteSound command to an RCX.
 */
inline void MSRCXUnmuteSound(void);

/**
 * MSScoutCalibrateSensor function.
 * Send the CalibrateSensor command to a Scout.
 */
inline void MSScoutCalibrateSensor(void);

/**
 * MSScoutMuteSound function.
 * Send the MuteSound command to a Scout.
 */
inline void MSScoutMuteSound(void);

/**
 * MSScoutSelectSounds function.
 * Send the SelectSounds command to a Scout.
 *
 * \param grp The Scout sound group to select.
 */
inline void MSScoutSelectSounds(const byte grp);

/**
 * MSScoutSendVLL function.
 * Send the SendVLL command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSendVLL(const byte src, const unsigned int value);

/**
 * MSScoutSetCounterLimit function.
 * Send the SetCounterLimit command to a Scout.
 *
 * \param ctr The counter for which to set the limit.
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetCounterLimit(const byte ctr, const byte src, const unsigned int value);

/**
 * MSScoutSetEventFeedback function.
 * Send the SetEventFeedback command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetEventFeedback(const byte src, const unsigned int value);

/**
 * MSScoutSetLight function.
 * Send the SetLight command to a Scout.
 *
 * \param x Set the light on or off using this value. See \ref ScoutLightConstants.
 */
inline void MSScoutSetLight(const byte x);

/**
 * MSScoutSetScoutMode function.
 * Send the SetScoutMode command to a Scout.
 *
 * \param mode Set the scout mode. See \ref ScoutModeConstants.
*/
inline void MSScoutSetScoutMode(const byte mode);

/**
 * MSScoutSetScoutRules function.
 * Send the SetScoutRules command to a Scout.
 *
 * \param m Scout motion rule. See \ref ScoutMotionRuleConstants.
 * \param t Scout touch rule. See \ref ScoutTouchRuleConstants.
 * \param l Scout light rule. See \ref ScoutLightRuleConstants.
 * \param tm Scout transmit rule. See \ref ScoutTransmitRuleConstants.
 * \param fx Scout special effects rule. See \ref ScoutSpecialEffectConstants.
 */
inline void MSScoutSetScoutRules(const byte m, const byte t, const byte l, const byte tm, const byte fx);

/**
 * MSScoutSetSensorClickTime function.
 * Send the SetSensorClickTime command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorClickTime(const byte src, const unsigned int value);

/**
 * MSScoutSetSensorHysteresis function.
 * Send the SetSensorHysteresis command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorHysteresis(const byte src, const unsigned int value);

/**
 * MSScoutSetSensorLowerLimit function.
 * Send the SetSensorLowerLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorLowerLimit(const byte src, const unsigned int value);

/**
 * MSScoutSetSensorUpperLimit function.
 * Send the SetSensorUpperLimit command to a Scout.
 *
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetSensorUpperLimit(const byte src, const unsigned int value);

/**
 * MSScoutSetTimerLimit function.
 * Send the SetTimerLimit command to a Scout.
 *
 * \param tmr The timer for which to set a limit.
 * \param src The Scout source.  See \ref RCXSourceConstants.
 * \param value The Scout value.
 */
inline void MSScoutSetTimerLimit(const byte tmr, const byte src, const unsigned int value);

/**
 * MSScoutUnmuteSound function.
 * Send the UnmuteSound command to a Scout.
 */
inline void MSScoutUnmuteSound(void);

#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

#define NRLink2400(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_2400, __RETVAL__) }
#define NRLink4800(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_4800, __RETVAL__) }
#define NRLinkFlush(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_FLUSH, __RETVAL__) }
#define NRLinkIRLong(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_IR_LONG, __RETVAL__) }
#define NRLinkIRShort(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_IR_SHORT, __RETVAL__) }
#define NRLinkTxRaw(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_TX_RAW, __RETVAL__) }
#define NRLinkSetRCX(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_RCX, __RETVAL__) }
#define NRLinkSetTrain(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_TRAIN, __RETVAL__) }
#define NRLinkSetPF(_port, _i2caddr) asm { __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_PF, __RETVAL__) }

#define RunNRLinkMacro(_port, _i2caddr, _macro) asm { __RunNRLinkMacro(_port, _i2caddr, _macro, __RETVAL__) }

#define NRLinkStatus(_port, _i2caddr) asm { __ReadNRLinkStatus(_port, _i2caddr, __RETVAL__, __TMPBYTE__) }

#define WriteNRLinkBytes(_port, _i2caddr, _bytes) asm { __WriteNRLinkBytes(_port, _i2caddr, _bytes, __RETVAL__) }
#define ReadNRLinkBytes(_port, _i2caddr, _bytes) asm { __ReadNRLinkBytes(_port, _i2caddr, _bytes, __RETVAL__) }

#define MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb) asm { __MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb, __RETVAL__) }
#define MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont) asm { __MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont, __RETVAL__) }
#define MSPFSingleOutputCST(_port, _i2caddr, _channel, _out, _func) asm { __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, TRUE, __RETVAL__) }
#define MSPFSingleOutputPWM(_port, _i2caddr, _channel, _out, _func) asm { __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, FALSE, __RETVAL__) }
#define MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb) asm { __MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb, __RETVAL__) }
#define MSPFTrain(_port, _i2caddr, _channel, _func) asm { __MSIRTrain(_port, _i2caddr, _channel, _func, TRUE, __RETVAL__) }
#define MSIRTrain(_port, _i2caddr, _channel, _func) asm { __MSIRTrain(_port, _i2caddr, _channel, _func, FALSE, __RETVAL__) }
#define MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2) asm { __MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2, __RETVAL__) }
#define MSPFRepeat(_port, _i2caddr, _count, _delay) asm { __MSPFRepeatLastCommand(_port, _i2caddr, _count, _delay, __RETVAL__) }

#define MSRCXSetNRLinkPort(_port, _i2caddr) asm { __MSRCXSetNRLink(_port, _i2caddr) }
#define MSRCXPoll(_src, _value) asm { __MSRCXPoll(_src, _value, __RETVAL__) }
#define MSRCXBatteryLevel() asm { __MSRCXBatteryLevel(__RETVAL__) }
#define MSRCXPing() asm { __MSRCXOpNoArgs(RCX_PingOp) }
#define MSRCXDeleteTasks() asm { __MSRCXOpNoArgs(RCX_DeleteTasksOp) }
#define MSRCXStopAllTasks() asm { __MSRCXOpNoArgs(RCX_StopAllTasksOp) }
#define MSRCXPBTurnOff() asm { __MSRCXOpNoArgs(RCX_PBTurnOffOp) }
#define MSRCXDeleteSubs() asm { __MSRCXOpNoArgs(RCX_DeleteSubsOp) }
#define MSRCXClearSound() asm { __MSRCXOpNoArgs(RCX_ClearSoundOp) }
#define MSRCXClearMsg() asm { __MSRCXOpNoArgs(RCX_ClearMsgOp) }
#define MSRCXMuteSound() asm { __MSRCXOpNoArgs(RCX_MuteSoundOp) }
#define MSRCXUnmuteSound() asm { __MSRCXOpNoArgs(RCX_UnmuteSoundOp) }
#define MSRCXClearAllEvents() asm { __MSRCXOpNoArgs(RCX_ClearAllEventsOp) }
#define MSRCXSetOutput(_outputs, _mode) asm { __MSRCXSetOutput(_outputs, _mode) }
#define MSRCXSetDirection(_outputs, _dir) asm { __MSRCXSetDirection(_outputs, _dir) }
#define MSRCXSetPower(_outputs, _pwrsrc, _pwrval) asm { __MSRCXSetPower(_outputs, _pwrsrc, _pwrval) }
#define MSRCXOn(_outputs) asm { __MSRCXSetOutput(_outputs, RCX_OUT_ON) }
#define MSRCXOff(_outputs) asm { __MSRCXSetOutput(_outputs, RCX_OUT_OFF) }
#define MSRCXFloat(_outputs) asm { __MSRCXSetOutput(_outputs, RCX_OUT_FLOAT) }
#define MSRCXToggle(_outputs) asm { __MSRCXSetDirection(_outputs, RCX_OUT_TOGGLE) }
#define MSRCXFwd(_outputs) asm { __MSRCXSetDirection(_outputs, RCX_OUT_FWD) }
#define MSRCXRev(_outputs) asm { __MSRCXSetDirection(_outputs, RCX_OUT_REV) }
#define MSRCXOnFwd(_outputs) asm { __MSRCXOnFwd(_outputs) }
#define MSRCXOnRev(_outputs) asm { __MSRCXOnRev(_outputs) }
#define MSRCXOnFor(_outputs, _ms) asm { __MSRCXOnFor(_outputs, _ms) }
#define MSRCXSetTxPower(_pwr) asm { __MSRCXSetTxPower(_pwr) }
#define MSRCXPlaySound(_snd) asm { __MSRCXPlaySound(_snd) }
#define MSRCXDeleteTask(_t) asm { __MSRCXDeleteTask(_t) }
#define MSRCXStartTask(_t) asm { __MSRCXStartTask(_t) }
#define MSRCXStopTask(_t) asm { __MSRCXStopTask(_t) }
#define MSRCXSelectProgram(_prog) asm { __MSRCXSelectProgram(_prog) }
#define MSRCXClearTimer(_timer) asm { __MSRCXClearTimer(_timer) }
#define MSRCXSetSleepTime(_t) asm { __MSRCXSetSleepTime(_t) }
#define MSRCXDeleteSub(_s) asm { __MSRCXDeleteSub(_s) }
#define MSRCXClearSensor(_port) asm { __MSRCXClearSensor(_port) }
#define MSRCXPlayToneVar(_varnum, _duration) asm { __MSRCXPlayToneVar(_varnum, _duration) }
#define MSRCXSetWatch(_hours, _minutes) asm { __MSRCXSetWatch(_hours, _minutes) }
#define MSRCXSetSensorType(_port, _type) asm { __MSRCXSetSensorType(_port, _type) }
#define MSRCXSetSensorMode(_port, _mode) asm { __MSRCXSetSensorMode(_port, _mode) }
#define MSRCXCreateDatalog(_size) asm { __MSRCXCreateDatalog(_size) }
#define MSRCXAddToDatalog(_src, _value) asm { __MSRCXAddToDatalog(_src, _value) }
#define MSRCXSendSerial(_first, _count) asm { __MSRCXSendSerial(_first, _count) }
#define MSRCXRemote(_cmd) asm { __MSRCXRemote(_cmd) }
#define MSRCXEvent(_src, _value) asm { __MSRCXEvent(_src, _value) }
#define MSRCXPlayTone(_freq, _duration) asm { __MSRCXPlayTone(_freq, _duration) }
#define MSRCXSelectDisplay(_src, _value) asm { __MSRCXSelectDisplay(_src, _value) }
#define MSRCXPollMemory(_memaddress) asm { __MSRCXPollMemory(_memaddress, __RETVAL__) }
#define MSRCXSetEvent(_evt, _src, _type) asm { __MSRCXSetEvent(_evt, _src, _type) }
#define MSRCXSetGlobalOutput(_outputs, _mode) asm { __MSRCXSetGlobalOutput(_outputs, _mode) }
#define MSRCXSetGlobalDirection(_outputs, _dir) asm { __MSRCXSetGlobalDirection(_outputs, _dir) }
#define MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) asm { __MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) }
#define MSRCXEnableOutput(_outputs) asm { __MSRCXSetGlobalOutput(_outputs, RCX_OUT_ON) }
#define MSRCXDisableOutput(_outputs) asm { __MSRCXSetGlobalOutput(_outputs, RCX_OUT_OFF) }
#define MSRCXInvertOutput(_outputs) asm { __MSRCXSetGlobalDirection(_outputs, RCX_OUT_REV) }
#define MSRCXObvertOutput(_outputs) asm { __MSRCXSetGlobalDirection(_outputs, RCX_OUT_FWD) }
#define MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) asm { __MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) }
#define MSRCXSetVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SetVarOp, _varnum, _src, _value) }
#define MSRCXSumVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SumVarOp, _varnum, _src, _value) }
#define MSRCXSubVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SubVarOp, _varnum, _src, _value) }
#define MSRCXDivVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_DivVarOp, _varnum, _src, _value) }
#define MSRCXMulVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_MulVarOp, _varnum, _src, _value) }
#define MSRCXSgnVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SgnVarOp, _varnum, _src, _value) }
#define MSRCXAbsVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_AbsVarOp, _varnum, _src, _value) }
#define MSRCXAndVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_AndVarOp, _varnum, _src, _value) }
#define MSRCXOrVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_OrVarOp, _varnum, _src, _value) }
#define MSRCXSet(_dstsrc, _dstval, _src, _value) asm { __MSRCXSet(_dstsrc, _dstval, _src, _value) }
#define MSRCXUnlock() asm { __MSRCXUnlock() }
#define MSRCXReset() asm { __MSRCXReset() }
#define MSRCXBoot() asm { __MSRCXBoot() }
#define MSRCXSetUserDisplay(_src, _value, _precision) asm { __MSRCXSetUserDisplay(_src, _value, _precision) }
#define MSRCXIncCounter(_counter) asm { __MSRCXIncCounter(_counter) }
#define MSRCXDecCounter(_counter) asm { __MSRCXDecCounter(_counter) }
#define MSRCXClearCounter(_counter) asm { __MSRCXClearCounter(_counter) }
#define MSRCXSetPriority(_p) asm { __MSRCXSetPriority(_p) }
#define MSRCXSetMessage(_msg) asm { __MSRCXSetMessage(_msg) }

#define MSScoutCalibrateSensor() asm { __MSRCXOpNoArgs(RCX_LSCalibrateOp) }
#define MSScoutMuteSound() asm { __MSScoutMuteSound() }
#define MSScoutUnmuteSound() asm { __MSScoutUnmuteSound() }
#define MSScoutSelectSounds(_grp) asm { __MSScoutSelectSounds(_grp) }
#define MSScoutSetLight(_x) asm { __MSScoutSetLight(_x) }
#define MSScoutSetCounterLimit(_ctr, _src, _value) asm { __MSScoutSetCounterLimit(_ctr, _src, _value) }
#define MSScoutSetTimerLimit(_tmr, _src, _value) asm { __MSScoutSetTimerLimit(_tmr, _src, _value) }
#define MSScoutSetSensorClickTime(_src, _value) asm { __MSScoutSetSensorClickTime(_src, _value) }
#define MSScoutSetSensorHysteresis(_src, _value) asm { __MSScoutSetSensorHysteresis(_src, _value) }
#define MSScoutSetSensorLowerLimit(_src, _value) asm { __MSScoutSetSensorLowerLimit(_src, _value) }
#define MSScoutSetSensorUpperLimit(_src, _value) asm { __MSScoutSetSensorUpperLimit(_src, _value) }
#define MSScoutSetEventFeedback(_src, _value) asm { __MSScoutSetEventFeedback(_src, _value) }
#define MSScoutSendVLL(_src, _value) asm { __MSScoutSendVLL(_src, _value) }
#define MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) asm { __MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) }
#define MSScoutSetScoutMode(_mode) asm { __MSScoutSetScoutMode(_mode) }

#endif

/** @} */ // end of MindSensorsNRLinkAPI group

/** @} */ // end of MindSensorsAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // MINDSENSORS_NRLINK_H