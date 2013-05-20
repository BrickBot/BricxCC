/** \file comm.h
 * \brief The NXC comm module API
 *
 * comm.h contains the NXC comm module API
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

#ifndef COMM_H
#define COMM_H

#include "comm_constants.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_comm.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// COMM MODULE /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup CommModule
 * @{
 */
/** @defgroup CommModuleTypes Comm module types
 * Types used by various Comm module functions.
 * @{
 */
/**
 * Parameters for the MessageWrite system call.
 * This structure is used when calling the \ref SysMessageWrite system call
 * function.
 * \sa SysMessageWrite()
 */
struct MessageWriteType {
  char Result;      /*!< The function call result. \ref NO_ERR means it succeeded. */
  byte QueueID;     /*!< The queue identifier. See the \ref MailboxConstants group. */
  string Message;   /*!< The message to write. */
};

/**
 * Parameters for the MessageRead system call.
 * This structure is used when calling the \ref SysMessageRead system call
 * function.
 * \sa SysMessageRead()
 */
struct MessageReadType {
  char Result;       /*!< The function call result. \ref NO_ERR means it succeeded. */
  byte QueueID;     /*!< The queue identifier. See the \ref MailboxConstants group. */
  bool Remove;      /*!< If true, remove the read message from the queue. */
  string Message;   /*!< The contents of the mailbox/queue. */
};

/**
 * Parameters for the CommBTCheckStatus system call.
 * This structure is used when calling the \ref SysCommBTCheckStatus system
 * call function.
 * \sa SysCommBTCheckStatus()
 */
struct CommBTCheckStatusType {
  char Result;       /*!< The function call result. Possible values include
                       \ref ERR_INVALID_PORT, \ref STAT_COMM_PENDING,
                       \ref ERR_COMM_CHAN_NOT_READY, and \ref LDR_SUCCESS. */
  byte Connection;   /*!< The connection to check. */
};

/**
 * Parameters for the CommBTWrite system call.
 * This structure is used when calling the \ref SysCommBTWrite system call
 * function.
 * \sa SysCommBTWrite()
 */
struct CommBTWriteType {
  char Result;       /*!< The function call result.  Possible values include
                       \ref ERR_COMM_CHAN_NOT_READY
                       and \ref STAT_COMM_PENDING (write accepted). */
  byte Connection;   /*!< The connection to use. */
  byte Buffer[];     /*!< The data to write to the connection. */
};

/**
 * The JoystickMessageType structure.
 * This structure is used to contain Joystick values read via the
 * \ref JoystickMessageRead API function.
 */
struct JoystickMessageType {
  byte JoystickDir;      /*!< The joystick direction or position. Ranges from 1 to 9, with the values representing numeric keypad buttons.  8 is up, 2 is down, 5 is center, etc. */
  byte LeftMotor;        /*!< The left motor. See \ref RCXOutputConstants for possible values. */
  byte RightMotor;       /*!< The right motor. See \ref RCXOutputConstants for possible values. */
  byte BothMotors;       /*!< The left and right motors. See \ref RCXOutputConstants for possible values. */
  char LeftSpeed;        /*!< The left motor speed (-100 to 100). */
  char RightSpeed;       /*!< The right motor speed (-100 to 100). */
  unsigned long Buttons; /*!< The joystick buttons pressed state. */
};

/**
 * The JoystickExMessageType structure.
 * This structure is used to contain Joystick values read via the
 * \ref JoystickExMessageRead API function.
 */
struct JoystickExMessageType {
  unsigned long Xpos;          /*!< The x position */
  unsigned long Ypos;          /*!< The y position */
  unsigned long Zpos;          /*!< The z position */
  unsigned long Rpos;         /*!< The rudder/4th axis position */
  unsigned long Upos;         /*!< The 5th axis position */
  unsigned long Vpos;         /*!< The 6th axis position */
  unsigned long Buttons;       /*!< The button states */
  unsigned long ButtonNumber; /*!< The current button number pressed */
  unsigned long POV;          /*!< The point of view state */
};

#ifdef __ENHANCED_FIRMWARE
/**
 * Parameters for the CommExecuteFunction system call.
 * This structure is used when calling the \ref SysCommExecuteFunction system
 * call function.
 *
 * The fields usage depends on the requested command and are documented in the
 * table below. If a field member is shown as 'x' it is ignored by the
 * specified command.
 *
 * <table>
 * <tr><td>Cmd</td>
 *     <td>Meaning</td><td>(Param1,Param2,Param3,Name)</td></tr>
 * <tr><td>INTF_SENDFILE</td>
 *     <td>Send a file over a Bluetooth connection</td><td>(Connection,x,x,Filename)</td></tr>
 * <tr><td>INTF_SEARCH</td>
 *     <td>Search for Bluetooth devices</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_STOPSEARCH</td>
 *     <td>Stop searching for Bluetooth devices</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_CONNECT</td>
 *     <td>Connect to a Bluetooth device</td><td>(DeviceIndex,Connection,x,x)</td></tr>
 * <tr><td>INTF_DISCONNECT</td>
 *     <td>Disconnect a Bluetooth device</td><td>(Connection,x,x,x)</td></tr>
 * <tr><td>INTF_DISCONNECTALL</td>
 *     <td>Disconnect all Bluetooth devices</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_REMOVEDEVICE</td>
 *     <td>Remove device from My Contacts</td><td>(DeviceIndex,x,x,x)</td></tr>
 * <tr><td>INTF_VISIBILITY</td>
 *     <td>Set Bluetooth visibility</td><td>(true/false,x,x,x)</td></tr>
 * <tr><td>INTF_SETCMDMODE</td>
 *     <td>Set command mode</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_OPENSTREAM</td>
 *     <td>Open a stream</td><td>(x,Connection,x,x)</td></tr>
 * <tr><td>INTF_SENDDATA</td>
 *     <td>Send data</td><td>(Length, Connection, WaitForIt, Buffer)</td></tr>
 * <tr><td>INTF_FACTORYRESET</td>
 *     <td>Bluetooth factory reset</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_BTON</td>
 *     <td>Turn Bluetooth on</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_BTOFF</td>
 *     <td>Turn Bluetooth off</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_SETBTNAME</td>
 *     <td>Set Bluetooth name</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_EXTREAD</td>
 *     <td>Handle external? read</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_PINREQ</td>
 *     <td>Handle Blueooth PIN request</td><td>(x,x,x,x)</td></tr>
 * <tr><td>INTF_CONNECTREQ</td>
 *     <td>Handle Bluetooth connect request</td><td>(x,x,x,x)</td></tr>
 * </table>
 *
 * \sa SysCommExecuteFunction()
 */
struct CommExecuteFunctionType {
  unsigned int Result;   /*!< The function call result. Possible values
                              include \ref LoaderErrors. */
  byte Cmd;              /*!< The command to execute. */
  byte Param1;           /*!< The first parameter, see table. */
  byte Param2;           /*!< The second parameter, see table. */
  byte Param3;           /*!< The third parameter, see table. */
  string Name;           /*!< The name parameter, see table. */
  unsigned int RetVal;   /*!< The function call return value. Possible values
                              include \ref LoaderErrors. */
};

/**
 * Parameters for the CommHSControl system call.
 * This structure is used when calling the \ref SysCommHSControl system call
 * function.
 * \sa SysCommHSControl()
 */
struct CommHSControlType {
 char Result;             /*!< The function call result. \todo values? */
 byte Command;            /*!< The hi-speed port configuration command.
                               See \ref CommHiSpeedCtrlConstants. */
 byte BaudRate;           /*!< The hi-speed port baud rate. See \ref CommHiSpeedBaudConstants. */
#if __FIRMWARE_VERSION > 107
 unsigned int Mode;       /*!< The hi-speed port mode. See \ref CommHiSpeedDataBitsConstants,
                               \ref CommHiSpeedStopBitsConstants, \ref CommHiSpeedParityConstants,
                               and \ref CommHiSpeedCombinedConstants. */
#endif
};

/**
 * Parameters for the CommHSCheckStatus system call.
 * This structure is used when calling the \ref SysCommHSCheckStatus system call
 * function.
 * \sa SysCommHSCheckStatus()
 */
struct CommHSCheckStatusType {
 byte SendingData;     /*!< Number of bytes of data currently being sent. */
 byte DataAvailable;   /*!< Number of bytes of data available for reading. */
};

/**
 * Parameters for the CommHSReadWrite system call.
 * This structure is used when calling the \ref SysCommHSRead and
 * \ref SysCommHSWrite system call functions.
 * \sa SysCommHSRead(), SysCommHSWrite()
 */
struct CommHSReadWriteType {
 char Status;    /*!< The result of the function call. */
 byte Buffer[];  /*!< The buffer of data to write or to contain the data read
                      from the hi-speed port. */
#if __FIRMWARE_VERSION > 107
 byte BufferLen; /*!< The size of the output buffer on input.  Determines the
                      maximum number of bytes read from the hi-speed port.
                      This field is not updated during the function call and
                      it is only used for the Read operation. */
#endif
};
#endif

#if __FIRMWARE_VERSION > 107
/**
 * Parameters for the CommBTOnOff system call.
 * This structure is used when calling the \ref SysCommBTOnOff system call
 * function.
 * \sa SysCommBTOnOff()
 */
struct CommBTOnOffType {
#ifdef __ENHANCED_FIRMWARE
 unsigned int Result; /*!< The function call result. */
#else
 char Result;         /*!< The function call result. */
#endif
 bool PowerState;     /*!< If true then turn on bluetooth, otherwise, turn it off. */
};

/**
 * Parameters for the CommBTConnection system call.
 * This structure is used when calling the \ref SysCommBTConnection system call
 * function.
 * \sa SysCommBTConnection()
 */
struct CommBTConnectionType {
#ifdef __ENHANCED_FIRMWARE
 unsigned int Result; /*!< The function call result. */
#else
 char Result;         /*!< The function call result. */
#endif
 byte Action;         /*!< The connection action (connect or disconnect). */
 string Name;         /*!< The name of the device to connect or disconnect. */
 byte ConnectionSlot; /*!< The connection slot to connect or disconnect. */
};
#endif

/** @} */ // end of CommModuleTypes group
/** @defgroup CommModuleFunctions Comm module functions
 * Functions for accessing and modifying Comm module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Read a joystick message from a queue/mailbox.
 * Read a joystick message from a queue/mailbox.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param msg The joystick message that is read from the mailbox. See
 * \ref JoystickMessageType for details.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char JoystickMessageRead(byte queue, JoystickMessageType & msg);

/**
 * Read an extended joystick message from a queue/mailbox.
 * Read an extended joystick message from a queue/mailbox.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param msg The extended joystick message that is read from the mailbox. See
 * \ref JoystickExMessageType for details.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char JoystickExMessageRead(byte queue, JoystickExMessageType & msg);

/**
 * Send a message to a queue/mailbox.
 * Write a message into a local mailbox.
 * 
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param msg The message to write to the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendMessage(byte queue, string msg);

/**
 * Read a message from a queue/mailbox.
 * Read a message from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param msg The message that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveMessage(byte queue, bool clear, string & msg);

/**
 * Check bluetooth status.
 * Check the status of the bluetooth subsystem for the specified connection slot.
 * 
 * \param conn The connection slot (0..3). Connections 0 through 3 are for
 * bluetooth connections.  See \ref CommConnectionConstants.
 * \return The bluetooth status for the specified connection.
 */
inline char BluetoothStatus(byte conn);

/**
 * Write to a bluetooth connection.
 * This method tells the NXT firmware to write the data in the buffer to the
 * device on the specified Bluetooth connection. Use \ref BluetoothStatus to
 * determine when this write request is completed.
 *
 * \param conn The connection slot (0..3). Connections 0 through 3 are for
 * bluetooth connections.  See \ref CommConnectionConstants.
 * \param buffer The data to be written (up to 128 bytes)
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char BluetoothWrite(byte conn, byte buffer[]);

/**
 * Write to a remote connection.
 * This method tells the NXT firmware to write the data in the buffer to the
 * device on the specified connection.  Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param buffer The data to be written (up to 128 bytes)
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning Writing to the RS485 hi-speed connection requires the enhanced
 * NBC/NXC firmware
 */
inline char RemoteConnectionWrite(byte conn, byte buffer[]);

/**
 * Check if remote connection is idle.
 * Check whether a Bluetooth or RS485 hi-speed port connection is idle,
 * i.e., not currently sending data.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \return A boolean value indicating whether the connection is idle or busy.
 *
 * \warning Checking the status of the RS485 hi-speed connection requires the
 * enhanced NBC/NXC firmware
 */
inline bool RemoteConnectionIdle(byte conn);

/**
 * Send a boolean value to a remote mailbox.
 * Send a boolean value on the specified connection to the
 * specified remote mailbox number.  Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param bval The boolean value to send.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendRemoteBool(byte conn, byte queue, bool bval);

/**
 * Send a numeric value to a remote mailbox.
 * Send a numeric value on the specified connection to the
 * specified remote mailbox number.  Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param val The numeric value to send.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendRemoteNumber(byte conn, byte queue, long val);

/**
 * Send a string value to a remote mailbox.
 * Send a string value on the specified connection to the
 * specified remote mailbox number.  Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param str The string value to send.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendRemoteString(byte conn, byte queue, string str);

/**
 * Write a boolean value to a local response mailbox.
 * Write a boolean value to a response mailbox (the mailbox number + 10).
 *
 * \param queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param bval The boolean value to write.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendResponseBool(byte queue, bool bval);

/**
 * Write a numeric value to a local response mailbox.
 * Write a numeric value to a response mailbox (the mailbox number + 10).
 *
 * \param queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param val The numeric value to write.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendResponseNumber(byte queue, long val);

/**
 * Write a string value to a local response mailbox.
 * Write a string value to a response mailbox (the mailbox number + 10).
 *
 * \param queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param str The string value to write.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char SendResponseString(byte queue, string str);

/**
 * Read a boolean value from a queue/mailbox.
 * Read a boolean value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param bval The boolean value that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveRemoteBool(byte queue, bool clear, bool & bval);

/**
 * Read a value from a queue/mailbox.
 * Read a value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.  Output the value in string, number, and
 * boolean form.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param str The string value that is read from the mailbox.
 * \param val The numeric value that is read from the mailbox.
 * \param bval The boolean value that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveRemoteMessageEx(byte queue, bool clear, string & str, long & val, bool & bval);

/**
 * Read a numeric value from a queue/mailbox.
 * Read a numeric value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param val The numeric value that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveRemoteNumber(byte queue, bool clear, long & val);

/**
 * Read a string value from a queue/mailbox.
 * Read a string value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param queue The mailbox number. See \ref MailboxConstants.
 * \param clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param str The string value that is read from the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char ReceiveRemoteString(byte queue, bool clear, string & str);

/** @defgroup CommModuleDCFunctions Direct Command functions
 * Functions for sending direct commands to another NXT.
 * @{
 */

/**
 * Send a KeepAlive message.
 * This method sends a KeepAlive direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteKeepAlive(byte conn);

/**
 * Send a MessageRead message.
 * This method sends a MessageRead direct command to the device on the
 * specified connection. Use \ref RemoteConnectionIdle to determine when this write
 * request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param queue The mailbox to read. See \ref MailboxConstants.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteMessageRead(byte conn, byte queue);

/**
 * Send a MessageWrite message.
 * This method sends a MessageWrite direct command to the device on the
 * specified connection. Use \ref RemoteConnectionIdle to determine when this write
 * request is completed.
 * 
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param queue The mailbox to write. See \ref MailboxConstants.
 * \param msg The message to write to the mailbox.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteMessageWrite(byte conn, byte queue, string msg);

/**
 * Send a PlaySoundFile message.
 * Send the PlaySoundFile direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param filename The name of the sound file to play.
 * \param bloop A boolean value indicating whether to loop the sound file or not.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemotePlaySoundFile(byte conn, string filename, bool bloop);

/**
 * Send a PlayTone message.
 * Send the PlayTone direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param frequency The frequency of the tone.
 * \param duration The duration of the tone.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemotePlayTone(byte conn, unsigned int frequency, unsigned int duration);

/**
 * Send a ResetMotorPosition message.
 * Send the ResetMotorPosition direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param port The output port to reset.
 * \param brelative A flag indicating whether the counter to reset is relative.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteResetMotorPosition(byte conn, byte port, bool brelative);

/**
 * Send a ResetScaledValue message.
 * Send the ResetScaledValue direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param port The input port to reset.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteResetScaledValue(byte conn, byte port);

/**
 * Send a SetInputMode message.
 * Send the SetInputMode direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param port The input port to configure. See \ref InPorts.
 * \param type The sensor type. See \ref SensorTypes.
 * \param mode The sensor mode. See \ref SensorModes.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteSetInputMode(byte conn, byte port, byte type, byte mode);

/**
 * Send a SetOutputMode message.
 * Send the SetOutputMode direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param port The output port to configure. See \ref OutputPortConstants.
 * \param speed The motor speed. (-100..100)
 * \param mode The motor mode. See \ref OutModeConstants.
 * \param regmode The motor regulation mode. See \ref OutRegModeConstants.
 * \param turnpct The motor synchronized turn percentage. (-100..100)
 * \param runstate The motor run state. See \ref OutRunStateConstants.
 * \param tacholimit The motor tachometer limit.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteSetOutputState(byte conn, byte port, char speed, byte mode, byte regmode, char turnpct, byte runstate, unsigned long tacholimit);

/**
 * Send a StartProgram message.
 * Send the StartProgram direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param filename The name of the program to start running.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteStartProgram(byte conn, string filename);

/**
 * Send a StopProgram message.
 * Send the StopProgram direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteStopProgram(byte conn);

/**
 * Send a StopSound message.
 * Send the StopSound direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteStopSound(byte conn);

#ifdef __ENHANCED_FIRMWARE

/**
 * Send a GetOutputState message.
 * Send the GetOutputState direct command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param params The input and output parameters for the function call. See \ref OutputStateType.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetOutputState(byte conn, OutputStateType & params);

/**
 * Send a GetInputValues message.
 * Send the GetInputValues direct command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param params The input and output parameters for the function call. See \ref InputValuesType.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetInputValues(byte conn, InputValuesType & params);

/**
 * Send a GetBatteryLevel message.
 * Send the GetBatteryLevel direct command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param value The battery level value.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetBatteryLevel(byte conn, int & value);

/**
 * Send a LowspeedGetStatus message.
 * This method sends a LowspeedGetStatus direct command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param value The count of available bytes to read.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteLowspeedGetStatus(byte conn, byte & value);

/**
 * Send a LowspeedRead message.
 * Send the LowspeedRead direct command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param port The input port from which to read I2C data. See \ref InPorts.
 * \param bread The number of bytes read.
 * \param data A byte array containing the data read from the I2C device.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteLowspeedRead(byte conn, byte port, byte & bread, byte & data[]);

/**
 * Send a GetCurrentProgramName message.
 * This method sends a GetCurrentProgramName direct command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param name The current program name.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetCurrentProgramName(byte conn, string & name);

/**
 * Send a DatalogRead message.
 * Send the DatalogRead direct command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param remove Remove the datalog message from the queue after reading it (true or false).
 * \param cnt The number of bytes read from the datalog.
 * \param log A byte array containing the datalog contents.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteDatalogRead(byte conn, bool remove, byte & cnt, byte & log[]);

/**
 * Send a GetContactCount message.
 * This method sends a GetContactCount direct command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param cnt The number of contacts.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetContactCount(byte conn, byte & cnt);

/**
 * Send a GetContactName message.
 * Send the GetContactName direct command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param idx The index of the contact.
 * \param name The name of the specified contact.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetContactName(byte conn, byte idx, string & name);

/**
 * Send a GetConnectionCount message.
 * This method sends a GetConnectionCount direct command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param cnt The number of connections.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetConnectionCount(byte conn, byte & cnt);

/**
 * Send a GetConnectionName message.
 * Send the GetConnectionName direct command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param idx The index of the connection.
 * \param name The name of the specified connection.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetConnectionName(byte conn, byte idx, string & name);

/**
 * Send a GetProperty message.
 * Send the GetProperty direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param property The property to read. See \ref RCPropertyConstants.
 * \param value The property value.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetProperty(byte conn, byte property, variant & value);

#endif

/**
 * Send a ResetTachoCount message.
 * Send the ResetTachoCount direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param port The output port to reset the tachometer count on. See \ref OutputPortConstants.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteResetTachoCount(byte conn, byte port);

/**
 * Send a DatalogSetTimes message.
 * Send the DatalogSetTimes direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param synctime The datalog sync time.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteDatalogSetTimes(byte conn, long synctime);

/**
 * Send a SetProperty message.
 * Send the SetProperty direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param prop The property to set. See \ref RCPropertyConstants.
 * \param value The new property value.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteSetProperty(byte conn, byte prop, variant value);

/**
 * Send a LowspeedWrite message.
 * Send the LowspeedWrite direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param port The I2C port. See \ref InPorts.
 * \param txlen The number of bytes you are writing to the I2C device.
 * \param rxlen The number of bytes want to read from the I2C device.
 * \param data A byte array containing the data you are writing to the device.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteLowspeedWrite(byte conn, byte port, byte txlen, byte rxlen, byte data[]);

/** @} */ // end of CommModuleDCFunctions group

/** @defgroup CommModuleSCFunctions System Command functions
 * Functions for sending system commands to another NXT.
 * @{
 */

#ifdef __ENHANCED_FIRMWARE

/**
 * Send an OpenRead message.
 * Send the OpenRead system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param filename The name of the file to open for reading.
 * \param handle The handle of the file.
 * \param size The size of the file.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteOpenRead(byte conn, string filename, byte & handle, long & size);

/**
 * Send an OpenAppendData message.
 * Send the OpenAppendData system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param filename The name of the file to open for appending.
 * \param handle The handle of the file.
 * \param size The size of the file.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteOpenAppendData(byte conn, string filename, byte & handle, long & size);

/**
 * Send a DeleteFile message.
 * Send the DeleteFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param filename The name of the file to delete.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteDeleteFile(byte conn, string filename);

/**
 * Send a FindFirstFile message.
 * Send the FindFirstFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param mask The filename mask for the files you want to find.
 * \param handle The handle of the found file.
 * \param name The name of the found file.
 * \param size The size of the found file.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteFindFirstFile(byte conn, string mask, byte & handle, string & name, long & size);

/**
 * Send a GetFirmwareVersion message.
 * This method sends a GetFirmwareVersion system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param pmin The protocol minor version byte.
 * \param pmaj The protocol major version byte.
 * \param fmin The firmware minor version byte.
 * \param fmaj The firmware major version byte.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetFirmwareVersion(byte conn, byte & pmin, byte & pmaj, byte & fmin, byte & fmaj);

/**
 * Send a GetBluetoothAddress message.
 * This method sends a GetBluetoothAddress system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param btaddr The bluetooth address of the remote device.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetBluetoothAddress(byte conn, byte & btaddr[]);

/**
 * Send a GetDeviceInfo message.
 * This method sends a GetDeviceInfo system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param name The name of the remote device.
 * \param btaddr The bluetooth address of the remote device.
 * \param btsignal The signal strength of each connection on the remote device.
 * \param freemem The number of bytes of free flash memory on the remote device.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteGetDeviceInfo(byte conn, string & name, byte & btaddr[], byte & btsignal[], long & freemem);

/**
 * Send a DeleteUserFlash message.
 * This method sends a DeleteUserFlash system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteDeleteUserFlash(byte conn);

/**
 * Send an OpenWrite message.
 * Send the OpenWrite system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param filename The name of the file to open for writing (i.e., create the file).
 * \param size The size for the new file.
 * \param handle The handle of the new file.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteOpenWrite(byte conn, string filename, long size, byte & handle);

/**
 * Send an OpenWriteLinear message.
 * Send the OpenWriteLinear system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param filename The name of the file to open for writing (i.e., create the file).
 * \param size The size for the new file.
 * \param handle The handle of the new file.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteOpenWriteLinear(byte conn, string filename, long size, byte & handle);

/**
 * Send an OpenWriteData message.
 * Send the OpenWriteData system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param filename The name of the file to open for writing (i.e., create the file).
 * \param size The size for the new file.
 * \param handle The handle of the new file.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteOpenWriteData(byte conn, string filename, long size, byte & handle);

/**
 * Send a CloseFile message.
 * Send the CloseFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param handle The handle of the file to close.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteCloseFile(byte conn, byte handle);

/**
 * Send a FindNextFile message.
 * Send the FindNextFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param handle The handle returned by the last \ref FindFirstFile or FindNextFile call.
 * \param name The name of the next found file.
 * \param size The size of the next found file.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteFindNextFile(byte conn, byte & handle, string & name, long & size);

/**
 * Send a PollCommandLength message.
 * Send the PollCommandLength system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param bufnum The poll buffer you want to query (0=USBPoll, 1=HiSpeed).
 * \param length The number of bytes available for polling.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemotePollCommandLength(byte conn, byte bufnum, byte & length);

/**
 * Send a Write message.
 * Send the Write system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param handle The handle of the file you are writing to.
 * \param numbytes The number of bytes actually written.
 * \param data A byte array containing the data you are writing.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteWrite(byte conn, byte & handle, int & numbytes, byte data[]);

/**
 * Send a Read message.
 * Send the Read system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param handle The handle of the file you are reading from.
 * \param numbytes The number of bytes you want to read. Returns the number of
 * bytes actually read.
 * \param data A byte array containing the response data.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteRead(byte conn, byte & handle, int & numbytes, byte & data[]);

/**
 * Send an IOMapRead message.
 * Send the IOMapRead system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param id The ID of the module from which to read data.
 * \param offset The offset into the IOMap structure from which to read.
 * \param numbytes The number of bytes of data to read. Returns the number of
 * bytes actually read.
 * \param data A byte array containing the response data.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteIOMapRead(byte conn, long id, int offset, int & numbytes, byte & data[]);

/**
 * Send a PollCommand message.
 * Send the PollCommand system command on the specified connection slot to
 * write the data provided.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param bufnum The buffer from which to read data (0=USBPoll, 1=HiSpeed).
 * \param len The number of bytes to read.  Returns the number of
 * bytes actually read.
 * \param data A byte array containing the response data.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemotePollCommand(byte conn, byte bufnum, byte & len, byte & data[]);

/**
 * Send a RenameFile message.
 * Send the RenameFile system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param oldname The old filename.
 * \param newname The new filename.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteRenameFile(byte conn, string oldname, string newname);

#endif

/**
 * Send a BluetoothFactoryReset message.
 * This method sends a BluetoothFactoryReset system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.  This command cannot be sent over a bluetooth connection.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteBluetoothFactoryReset(byte conn);

/**
 * Send an IOMapWrite value message.
 * Send the IOMapWrite system command on the specified connection slot to
 * write the value provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param id The ID of the module to which to write data.
 * \param offset The offset into the IOMap structure to which to write.
 * \param value A scalar variable containing the value you are writing to the IOMap structure.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteIOMapWriteValue(byte conn, long id, int offset, variant value);

/**
 * Send an IOMapWrite bytes message.
 * Send the IOMapWrite system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param id The ID of the module to which to write data.
 * \param offset The offset into the IOMap structure to which to write.
 * \param data A byte array containing the data you are writing to the IOMap structure.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteIOMapWriteBytes(byte conn, long id, int offset, byte data[]);

/**
 * Send a SetBrickName message.
 * Send the SetBrickName system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param name The new brick name.
 * \return A char value indicating whether the function call succeeded or not.
 */
inline char RemoteSetBrickName(byte conn, string name);

/** @} */ // end of CommModuleSCFunctions group


/**
 * Use the RS485 port.
 * Configure port 4 for RS485 usage.
 *
 */
inline void UseRS485(void);

#ifdef __ENHANCED_FIRMWARE

/**
 * Control the RS485 port.
 * Control the RS485 hi-speed port using the specified parameters.
 *
 * \param cmd The control command to send to the port. See \ref CommHiSpeedCtrlConstants.
 * \param baud The baud rate for the RS485 port. See \ref CommHiSpeedBaudConstants.
 * \param mode The RS485 port mode (data bits, stop bits, parity).  See \ref
 * CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants, \ref
 * CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Control(byte cmd, byte baud, unsigned int mode);

/**
 * Check for RS485 available data.
 * Check the RS485 hi-speed port for available data.
 *
 * \return The number of bytes of data available for reading.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline byte RS485DataAvailable(void);

/**
 * Initialize RS485 port.
 * Initialize the RS485 UART port to its default values.  The baud rate is
 * set to 921600 and the mode is set to 8N1 (8 data bits, no parity, 1 stop bit).
 * Data cannot be sent or received over the RS485 port until the port is
 * configured as as a hi-speed port, the port is turned on, and the UART is
 * initialized.
 *
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Initialize(void);

/**
 * Disable RS485.
 * Turn off the RS485 port.
 *
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Disable(void);

/**
 * Enable RS485.
 * Turn on the RS485 hi-speed port so that it can be used.
 *
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Enable(void);

/**
 * Read RS485 data.
 * Read data from the RS485 hi-speed port.
 *
 * \param buffer A byte array that will contain the data read from the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Read(byte & buffer[]);

/**
 * Read limited RS485 data.
 * Read a limited number of bytes of data from the RS485 hi-speed port.
 *
 * \param buffer A byte array that will contain the data read from the RS485 port.
 * \param buflen The number of bytes you want to read.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+.
 */
inline char RS485ReadEx(byte & buffer[], byte buflen);

/**
 * Is RS485 sending data.
 * Check whether the RS485 is actively sending data.
 *
 * \return The number of bytes of data being sent.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline byte RS485SendingData(void);

/**
 * Check RS485 status.
 * Check the status of the RS485 hi-speed port.
 *
 * \param sendingData The number of bytes of data being sent.
 * \param dataAvail The number of bytes of data available for reading.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void RS485Status(byte & sendingData, byte & dataAvail);

/**
 * Configure RS485 UART.
 * Configure the RS485 UART parameters, including baud rate, data bits,
 * stop bits, and parity.
 *
 * \param baud The baud rate for the RS485 port. See \ref CommHiSpeedBaudConstants.
 * \param mode The RS485 port mode (data bits, stop bits, parity).  See \ref
 * CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants, \ref
 * CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Uart(byte baud, unsigned int mode);

/**
 * Write RS485 data.
 * Write data to the RS485 hi-speed port.
 *
 * \param buffer A byte array containing the data to write to the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char RS485Write(byte buffer[]);

/**
 * Write RS485 boolean.
 * Write a boolean value to the RS485 hi-speed port.
 *
 * \param bval A boolean value to write over the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char SendRS485Bool(bool bval);

/**
 * Write RS485 numeric.
 * Write a numeric value to the RS485 hi-speed port.
 *
 * \param val A numeric value to write over the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char SendRS485Number(long val);

/**
 * Write RS485 string.
 * Write a string value to the RS485 hi-speed port.
 *
 * \param str A string value to write over the RS485 port.
 * \return A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline char SendRS485String(string str);

#endif

/**
 * Get bluetooth input buffer data.
 * This method reads count bytes of data from the Bluetooth input buffer and
 * writes it to the buffer provided.
 *
 * \param offset A constant offset into the bluetooth input buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the bluetooth input buffer.
 */
inline void GetBTInputBuffer(const byte offset, byte cnt, byte & data[]);

/**
 * Get bluetooth output buffer data.
 * This method reads count bytes of data from the Bluetooth output buffer and
 * writes it to the buffer provided.
 * 
 * \param offset A constant offset into the bluetooth output buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the bluetooth output buffer.
 */
inline void GetBTOutputBuffer(const byte offset, byte cnt, byte & data[]);

/**
 * Get hi-speed port input buffer data.
 * This method reads count bytes of data from the hi-speed port input buffer and
 * writes it to the buffer provided.
 * 
 * \param offset A constant offset into the hi-speed port input buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the hi-speed port input buffer.
 */
inline void GetHSInputBuffer(const byte offset, byte cnt, byte & data[]);

/**
 * Get hi-speed port output buffer data.
 * This method reads count bytes of data from the hi-speed port output buffer and
 * writes it to the buffer provided.
 * 
 * \param offset A constant offset into the hi-speed port output buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the hi-speed port output buffer.
 */
inline void GetHSOutputBuffer(const byte offset, byte cnt, byte & data[]);

/**
 * Get usb input buffer data.
 * This method reads count bytes of data from the usb input buffer and
 * writes it to the buffer provided.
 * 
 * \param offset A constant offset into the usb input buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the usb input buffer.
 */
inline void GetUSBInputBuffer(const byte offset, byte cnt, byte & data[]);

/**
 * Get usb output buffer data.
 * This method reads count bytes of data from the usb output buffer and
 * writes it to the buffer provided.
 * \param offset A constant offset into the usb output buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the usb output buffer.
 */
inline void GetUSBOutputBuffer(const byte offset, byte cnt, byte & data[]);

/**
 * Get usb poll buffer data.
 * This method reads count bytes of data from the usb poll buffer and
 * writes it to the buffer provided.
 * \param offset A constant offset into the usb poll buffer.
 * \param cnt The number of bytes to read.
 * \param data The byte array reference which will contain the data read from
 * the usb poll buffer.
 */
inline void GetUSBPollBuffer(const byte offset, byte cnt, byte & data[]);

/**
 * Get bluetooth device name.
 * This method returns the name of the device at the specified index in the
 * Bluetooth device table.
 * \param devidx The device table index.
 * \return The device name of the specified bluetooth device.
 */
inline string BTDeviceName(const byte devidx);

/**
 * Get bluetooth device name.
 * This method returns the name of the device at the specified index in the
 * Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The name of the bluetooth device at the specified connection slot.
 */
inline string BTConnectionName(const byte conn);

/**
 * Get bluetooth device pin code.
 * This method returns the pin code of the device at the specified index in the
 * Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The pin code for the bluetooth device at the specified connection slot.
 */
inline string BTConnectionPinCode(const byte conn);

/**
 * Get NXT name.
 * This method returns the name of the NXT.
 * \return The NXT's bluetooth name.
 */
inline string BrickDataName(void);

/**
 * Get bluetooth device address.
 * This method reads the address of the device at the specified index within
 * the Bluetooth device table and stores it in the data buffer provided.
 * \param devidx The device table index.
 * \param data The byte array reference that will contain the device address.
 */
inline void GetBTDeviceAddress(const byte devidx, byte & data[]);

/**
 * Get bluetooth device address.
 * This method reads the address of the device at the specified index within
 * the Bluetooth connection table and stores it in the data buffer provided.
 * \param conn The connection slot (0..3).
 * \param data The byte array reference that will contain the device address.
 */
inline void GetBTConnectionAddress(const byte conn, byte & data[]);

/**
 * Get NXT address.
 * This method reads the address of the NXT and stores it in the data buffer
 * provided.
 * \param data The byte array reference that will contain the device address.
 */
inline void GetBrickDataAddress(byte & data[]);

/**
 * Get bluetooth device class.
 * This method returns the class of the device at the specified index within
 * the Bluetooth device table.
 * \param devidx The device table index.
 * \return The device class of the specified bluetooth device.
 */
inline long BTDeviceClass(const byte devidx);

/**
 * Get bluetooth device status.
 * This method returns the status of the device at the specified index within
 * the Bluetooth device table.
 * \param devidx The device table index.
 * \return The status of the specified bluetooth device.
 */
inline byte BTDeviceStatus(const byte devidx);

/**
 * Get bluetooth device class.
 * This method returns the class of the device at the specified index within
 * the Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The class of the bluetooth device at the specified connection slot.
 */
inline long BTConnectionClass(const byte conn);

/**
 * Get bluetooth device handle number.
 * This method returns the handle number of the device at the specified index within
 * the Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The handle number of the bluetooth device at the specified connection slot.
 */
inline byte BTConnectionHandleNum(const byte conn);

/**
 * Get bluetooth device stream status.
 * This method returns the stream status of the device at the specified index within
 * the Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The stream status of the bluetooth device at the specified connection slot.
 */
inline byte BTConnectionStreamStatus(const byte conn);

/**
 * Get bluetooth device link quality.
 * This method returns the link quality of the device at the specified index within
 * the Bluetooth connection table.
 * \param conn The connection slot (0..3).
 * \return The link quality of the specified connection slot (unimplemented).
 * \warning This function is not implemented at the firmware level.
 */
inline byte BTConnectionLinkQuality(const byte conn);

/**
 * Get NXT bluecore version.
 * This method returns the bluecore version of the NXT.
 * \return The NXT's bluecore version number.
 */
inline int BrickDataBluecoreVersion(void);

/**
 * Get NXT bluetooth state status.
 * This method returns the Bluetooth state status of the NXT.
 * \return The NXT's bluetooth state status.
 */
inline byte BrickDataBtStateStatus(void);

/**
 * Get NXT bluetooth hardware status.
 * This method returns the Bluetooth hardware status of the NXT.
 * \return The NXT's bluetooth hardware status.
 */
inline byte BrickDataBtHardwareStatus(void);

/**
 * Get NXT bluetooth timeout value.
 * This method returns the Bluetooth timeout value of the NXT.
 * \return The NXT's bluetooth timeout value.
 */
inline byte BrickDataTimeoutValue(void);

/**
 * Get bluetooth input buffer in-pointer.
 * This method returns the value of the input pointer of the Bluetooth input
 * buffer.
 * \return The bluetooth input buffer's in-pointer value.
 */
inline byte BTInputBufferInPtr(void);

/**
 * Get bluetooth input buffer out-pointer.
 * This method returns the value of the output pointer of the Bluetooth input
 * buffer.
 * \return The bluetooth input buffer's out-pointer value.
 */
inline byte BTInputBufferOutPtr(void);

/**
 * Get bluetooth output buffer in-pointer.
 * This method returns the value of the input pointer of the Bluetooth output
 * buffer.
 * \return The bluetooth output buffer's in-pointer value.
 */
inline byte BTOutputBufferInPtr(void);

/**
 * Get bluetooth output buffer out-pointer.
 * This method returns the value of the output pointer of the Bluetooth output
 * buffer.
 * \return The bluetooth output buffer's out-pointer value.
 */
inline byte BTOutputBufferOutPtr(void);

/**
 * Get hi-speed port input buffer in-pointer.
 * This method returns the value of the input pointer of the hi-speed port input
 * buffer.
 * \return The hi-speed port input buffer's in-pointer value.
 */
inline byte HSInputBufferInPtr(void);

/**
 * Get hi-speed port input buffer out-pointer.
 * This method returns the value of the output pointer of the hi-speed port input
 * buffer.
 * \return The hi-speed port input buffer's out-pointer value.
 */
inline byte HSInputBufferOutPtr(void);

/**
 * Get hi-speed port output buffer in-pointer.
 * This method returns the value of the input pointer of the hi-speed port output
 * buffer.
 * \return The hi-speed port output buffer's in-pointer value.
 */
inline byte HSOutputBufferInPtr(void);

/**
 * Get hi-speed port output buffer out-pointer.
 * This method returns the value of the output pointer of the hi-speed port output
 * buffer.
 * \return The hi-speed port output buffer's out-pointer value.
 */
inline byte HSOutputBufferOutPtr(void);

/**
 * Get usb port input buffer in-pointer.
 * This method returns the value of the input pointer of the usb port input
 * buffer.
 * \return The USB port input buffer's in-pointer value.
 */
inline byte USBInputBufferInPtr(void);

/**
 * Get usb port input buffer out-pointer.
 * This method returns the value of the output pointer of the usb port input
 * buffer.
 * \return The USB port input buffer's out-pointer value.
 */
inline byte USBInputBufferOutPtr(void);

/**
 * Get usb port output buffer in-pointer.
 * This method returns the value of the input pointer of the usb port output
 * buffer.
 * \return The USB port output buffer's in-pointer value.
 */
inline byte USBOutputBufferInPtr(void);

/**
 * Get usb port output buffer out-pointer.
 * This method returns the value of the output pointer of the usb port output
 * buffer.
 * \return The USB port output buffer's out-pointer value.
 */
inline byte USBOutputBufferOutPtr(void);

/**
 * Get usb port poll buffer in-pointer.
 * This method returns the value of the input pointer of the usb port poll
 * buffer.
 * \return The USB port poll buffer's in-pointer value.
 */
inline byte USBPollBufferInPtr(void);

/**
 * Get usb port poll buffer out-pointer.
 * This method returns the value of the output pointer of the usb port poll
 * buffer.
 * \return The USB port poll buffer's out-pointer value.
 */
inline byte USBPollBufferOutPtr(void);

/**
 * Get bluetooth device count.
 * This method returns the number of devices defined within the Bluetooth
 * device table.
 * \return The count of known bluetooth devices.
 */
inline byte BTDeviceCount(void);

/**
 * Get bluetooth device name count.
 * This method returns the number of device names defined within the Bluetooth
 * device table. This usually has the same value as BTDeviceCount but it can
 * differ in some instances.
 * \return The count of known bluetooth device names.
 */
inline byte BTDeviceNameCount(void);

/**
 * Get hi-speed port flags.
 * This method returns the value of the hi-speed port flags.
 * \return The hi-speed port flags. See \ref CommHiSpeedFlagsConstants.
 */
inline byte HSFlags(void);

/**
 * Get hi-speed port speed.
 * This method returns the value of the hi-speed port speed (baud rate).
 * \return The hi-speed port speed (baud rate).  See \ref CommHiSpeedBaudConstants.
 */
inline byte HSSpeed(void);

/**
 * Get hi-speed port state.
 * This method returns the value of the hi-speed port state.
 * \return The hi-speed port state. See \ref CommHiSpeedStateConstants.
 */
inline byte HSState(void);

/**
 * Get hi-speed port address.
 * This method returns the value of the hi-speed port address.
 * \return The hi-speed port address. See \ref CommHiSpeedAddressConstants.
 */
inline byte HSAddress(void);

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)

/**
 * Get hi-speed port mode.
 * This method returns the value of the hi-speed port mode.
 * \return The hi-speed port mode (data bits, stop bits, parity).  See
 * \ref CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants,
 * \ref CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline int HSMode(void);

/**
 * Get Bluetooth data mode.
 * This method returns the value of the Bluetooth data mode.
 * \return The Bluetooth data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline int BTDataMode(void);

/**
 * Get hi-speed port datamode.
 * This method returns the value of the hi-speed port data mode.
 * \return The hi-speed port data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline int HSDataMode(void);

#endif

/**
 * Get USB state.
 * This method returns the value of the USB state.
 * \return The USB state.
 */
inline byte USBState(void);

/**
 * Set bluetooth input buffer data.
 * Write cnt bytes of data to the bluetooth input buffer at offset.
 * \param offset A constant offset into the input buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetBTInputBuffer(const byte offset, byte cnt, byte data[]);

/**
 * Set bluetooth input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param n The new in-pointer value (0..127).
 */
inline void SetBTInputBufferInPtr(byte n);

/**
 * Set bluetooth input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param n The new out-pointer value (0..127).
 */
inline void SetBTInputBufferOutPtr(byte n);

/**
 * Set bluetooth output buffer data.
 * Write cnt bytes of data to the bluetooth output buffer at offset.
 * \param offset A constant offset into the output buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetBTOutputBuffer(const byte offset, byte cnt, byte data[]);

/**
 * Set bluetooth output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param n The new in-pointer value (0..127).
 */
inline void SetBTOutputBufferInPtr(byte n);

/**
 * Set bluetooth output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param n The new out-pointer value (0..127).
 */
inline void SetBTOutputBufferOutPtr(byte n);

/**
 * Set hi-speed port input buffer data.
 * Write cnt bytes of data to the hi-speed port input buffer at offset.
 * \param offset A constant offset into the input buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetHSInputBuffer(const byte offset, byte cnt, byte data[]);

/**
 * Set hi-speed port input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param n The new in-pointer value (0..127).
 */
inline void SetHSInputBufferInPtr(byte n);

/**
 * Set hi-speed port input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param n The new out-pointer value (0..127).
 */
inline void SetHSInputBufferOutPtr(byte n);

/**
 * Set hi-speed port output buffer data.
 * Write cnt bytes of data to the hi-speed port output buffer at offset.
 * \param offset A constant offset into the output buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetHSOutputBuffer(const byte offset, byte cnt, byte data[]);

/**
 * Set hi-speed port output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param n The new in-pointer value (0..127).
 */
inline void SetHSOutputBufferInPtr(byte n);

/**
 * Set hi-speed port output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param n The new out-pointer value (0..127).
 */
inline void SetHSOutputBufferOutPtr(byte n);

/**
 * Set USB input buffer data.
 * Write cnt bytes of data to the USB input buffer at offset.
 * \param offset A constant offset into the input buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetUSBInputBuffer(const byte offset, byte cnt, byte data[]);

/**
 * Set USB input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param n The new in-pointer value (0..63).
 */
inline void SetUSBInputBufferInPtr(byte n);

/**
 * Set USB input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param n The new out-pointer value (0..63).
 */
inline void SetUSBInputBufferOutPtr(byte n);

/**
 * Set USB output buffer data.
 * Write cnt bytes of data to the USB output buffer at offset.
 * \param offset A constant offset into the output buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetUSBOutputBuffer(const byte offset, byte cnt, byte data[]);

/**
 * Set USB output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param n The new in-pointer value (0..63).
 */
inline void SetUSBOutputBufferInPtr(byte n);

/**
 * Set USB output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param n The new out-pointer value (0..63).
 */
inline void SetUSBOutputBufferOutPtr(byte n);

/**
 * Set USB poll buffer data.
 * Write cnt bytes of data to the USB poll buffer at offset.
 * \param offset A constant offset into the poll buffer
 * \param cnt The number of bytes to write
 * \param data A byte array containing the data to write
 */
inline void SetUSBPollBuffer(const byte offset, byte cnt, byte data[]);

/**
 * Set USB poll buffer in-pointer.
 * Set the value of the poll buffer in-pointer.
 * \param n The new in-pointer value (0..63).
 */
inline void SetUSBPollBufferInPtr(byte n);

/**
 * Set USB poll buffer out-pointer.
 * Set the value of the poll buffer out-pointer.
 * \param n The new out-pointer value (0..63).
 */
inline void SetUSBPollBufferOutPtr(byte n);

/**
 * Set hi-speed port flags.
 * This method sets the value of the hi-speed port flags.
 * \param hsFlags The hi-speed port flags. See \ref CommHiSpeedFlagsConstants.
 */
inline void SetHSFlags(byte hsFlags);

/**
 * Set hi-speed port speed.
 * This method sets the value of the hi-speed port speed (baud rate).
 * \param hsSpeed The hi-speed port speed (baud rate).  See \ref CommHiSpeedBaudConstants.
 */
inline void SetHSSpeed(byte hsSpeed);

/**
 * Set hi-speed port state.
 * This method sets the value of the hi-speed port state.
 * \param hsState The hi-speed port state. See \ref CommHiSpeedStateConstants.
 */
inline void SetHSState(byte hsState);

/**
 * Set hi-speed port address.
 * This method sets the value of the hi-speed port address.
 * \param hsAddress The hi-speed port address. See \ref CommHiSpeedAddressConstants.
 */
inline void SetHSAddress(byte hsAddress);

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)

/**
 * Set hi-speed port mode.
 * This method sets the value of the hi-speed port mode.
 * \param hsMode The hi-speed port mode (data bits, stop bits, parity).  See
 * \ref CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants,
 * \ref CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SetHSMode(unsigned int hsMode) { asm { __setHSMode(_n) } }

/**
 * Set Bluetooth data mode.
 * This method sets the value of the Bluetooth data mode.
 * \param dataMode The Bluetooth data mode.  See \ref CommDataModeConstants. Must be a constant.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SetBTDataMode(const byte dataMode);

/**
 * Set hi-speed port data mode.
 * This method sets the value of the hi-speed port data mode.
 * \param dataMode The hi-speed port data mode.  See \ref CommDataModeConstants. Must be a constant.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
inline void SetHSDataMode(const byte dataMode);

#endif

/**
 * Set USB state.
 * This method sets the value of the USB state.
 * \param usbState The USB state.
 */
inline void SetUSBState(byte usbState);

/**
 * Write message.
 * This function lets you write a message to a queue (aka mailbox) using the
 * values specified via the \ref MessageWriteType structure.
 *
 * \param args The MessageWriteType structure containing the needed parameters.
 */
void SysMessageWrite(MessageWriteType & args);

/**
 * Read message.
 * This function lets you read a message from a queue (aka mailbox) using the
 * values specified via the \ref MessageReadType structure.
 *
 * \param args The MessageReadType structure containing the needed parameters.
 */
void SysMessageRead(MessageReadType & args);

/**
 * Write data to a Bluetooth connection.
 * This function lets you write to a Bluetooth connection using the values
 * specified via the \ref CommBTWriteType structure.
 *
 * \param args The CommBTWriteType structure containing the needed parameters.
 */
void SysCommBTWrite(CommBTWriteType & args);

/**
 * Check Bluetooth connection status.
 * This function lets you check the status of a Bluetooth connection using the
 * values specified via the \ref CommBTCheckStatusType structure.
 *
 * \param args The CommBTCheckStatusType structure containing the needed
 * parameters.
 */
void SysCommBTCheckStatus(CommBTCheckStatusType & args);

#ifdef __ENHANCED_FIRMWARE
/**
 * Execute any Comm module command.
 * This function lets you directly execute the Comm module's primary function
 * using the values specified via the \ref CommExecuteFunctionType structure.
 *
 * \param args The CommExecuteFunctionType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommExecuteFunction(CommExecuteFunctionType & args);

/**
 * Control the hi-speed port.
 * This function lets you control the hi-speed port
 * using the values specified via the \ref CommHSControlType structure.
 *
 * \param args The CommHSControlType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommHSControl(CommHSControlType & args);

/**
 * Check the hi-speed port status.
 * This function lets you check the hi-speed port status
 * using the values specified via the \ref CommHSCheckStatusType structure.
 *
 * \param args The CommHSCheckStatusType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommHSCheckStatus(CommHSCheckStatusType & args);

/**
 * Read from the hi-speed port.
 * This function lets you read from the hi-speed port
 * using the values specified via the \ref CommHSReadWriteType structure.
 *
 * \param args The CommHSReadWriteType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommHSRead(CommHSReadWriteType & args);

/**
 * Write to the hi-speed port.
 * This function lets you write to the hi-speed port
 * using the values specified via the \ref CommHSReadWriteType structure.
 *
 * \param args The CommHSReadWriteType structure containing the needed
 * parameters.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline void SysCommHSWrite(CommHSReadWriteType & args);

#endif

#if __FIRMWARE_VERSION > 107
/**
 * Turn on or off the bluetooth subsystem.
 * This function lets you turn on or off the bluetooth subsystem
 * using the values specified via the \ref CommBTOnOffType structure.
 *
 * \param args The CommBTOnOffType structure containing the needed
 * parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysCommBTOnOff(CommBTOnOffType & args);

/**
 * Connect or disconnect a bluetooth device.
 * This function lets you connect or disconnect a bluetooth device
 * using the values specified via the \ref CommBTConnectionType structure.
 *
 * \param args The CommBTConnectionType structure containing the needed
 * parameters.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
inline void SysCommBTConnection(CommBTConnectionType & args);

#endif

/*
// these functions really cannot be used for any useful purpose (read-only)
inline void SetBTDeviceName(const byte devidx, string str);
inline void SetBTDeviceAddress(const byte devidx, const byte btaddr[]);
inline void SetBTConnectionName(const byte conn, string str);
inline void SetBTConnectionPinCode(const byte conn, const byte code[]);
inline void SetBTConnectionAddress(const byte conn, const byte btaddr[]);
inline void SetBrickDataName(string str);
inline void SetBrickDataAddress(const byte p, byte btaddr[]);
inline void SetBTDeviceClass(const byte devidx, unsigned long class);
inline void SetBTDeviceStatus(const byte devidx, const byte status);
inline void SetBTConnectionClass(const byte conn, unsigned long class);
inline void SetBTConnectionHandleNum(const byte conn, const byte handleNum);
inline void SetBTConnectionStreamStatus(const byte conn, const byte status);
inline void SetBTConnectionLinkQuality(const byte conn, const byte quality);
inline void SetBrickDataBluecoreVersion(int version);
inline void SetBrickDataBtStateStatus(byte status);
inline void SetBrickDataBtHardwareStatus(byte status);
inline void SetBrickDataTimeoutValue(const byte timeout);
inline void SetBTDeviceCount(byte count);
inline void SetBTDeviceNameCount(byte count);
*/

#else

#define __DoReadJoystick(_queue, _arg) \
  acquire __MRMutex \
  mov __MRArgs.QueueID, _queue \
  set __MRArgs.Remove, TRUE \
  syscall MessageRead, __MRArgs \
  brtst NEQ, __RRM_Err##__I__, __MRArgs.Result \
  unflatten _arg, __RRNErr, __MRArgs.Message, _arg \
  __RRM_Err##__I__: \
  __IncI__ \
  mov __RETVAL__, __MRArgs.Result \
  release __MRMutex

#define JoystickMessageRead(_queue, _jmt) asm { \
  compchktype _jmt, JoystickMessageType \
  __DoReadJoystick(_queue, _jmt) \
}

#define JoystickExMessageRead(_queue, _jemt) asm { \
  compchktype _jemt, JoystickExMessageType \
  __DoReadJoystick(_queue, _jemt) \
}

#define SendMessage(_queue, _msg) asm { __sendMessage(_queue, _msg, __RETVAL__) }
#define ReceiveMessage(_queue, _clear, _msg) asm { __receiveMessage(_queue, _clear, _msg, __RETVAL__) }

#define BluetoothStatus(_conn) asm { __bluetoothStatus(_conn, __RETVAL__) }
#define BluetoothWrite(_conn, _buffer) asm { __bluetoothWrite(_conn, _buffer, __RETVAL__) }
#define RemoteConnectionWrite(_conn, _buffer) asm { __connectionRawWrite(_conn, _buffer, __RETVAL__) }
#define RemoteConnectionIdle(_conn) asm { __remoteConnectionIdle(_conn, __RETVAL__) }

#define SendRemoteBool(_conn, _queue, _bval) asm { __sendRemoteBool(_conn, _queue, _bval, __RETVAL__) }
#define SendRemoteNumber(_conn, _queue, _val) asm { __sendRemoteNumber(_conn, _queue, _val, __RETVAL__) }
#define SendRemoteString(_conn, _queue, _str) asm { __sendRemoteString(_conn, _queue, _str, __RETVAL__) }

#define SendResponseBool(_queue, _bval) asm { __sendResponseBool(_queue, _bval, __RETVAL__) }
#define SendResponseNumber(_queue, _val) asm { __sendResponseNumber(_queue, _val, __RETVAL__) }
#define SendResponseString(_queue, _msg) asm { __sendResponseString(_queue, _msg, __RETVAL__) }

#define ReceiveRemoteBool(_queue, _clear, _bval) asm { __receiveRemoteBool(_queue, _clear, _bval, __RETVAL__) }
#define ReceiveRemoteNumber(_queue, _clear, _val) asm { __receiveRemoteNumber(_queue, _clear, _val, __RETVAL__) }
#define ReceiveRemoteString(_queue, _clear, _str) asm { __receiveMessage(_queue, _clear, _str, __RETVAL__) }
#define ReceiveRemoteMessageEx(_queue, _clear, _str, _val, _bval) asm { __receiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, __RETVAL__) }

#define RemoteMessageRead(_conn, _queue) asm { __remoteMessageRead(_conn, _queue, __RETVAL__) }
#define RemoteMessageWrite(_conn, _queue, _msg) asm { __sendRemoteString(_conn, _queue, _msg, __RETVAL__) }
#define RemoteStartProgram(_conn, _filename) asm { __remoteStartProgram(_conn, _filename, __RETVAL__) }
#define RemoteStopProgram(_conn) asm { __connectionSCDCWrite(_conn, __DCStopProgramPacket, __RETVAL__) }
#define RemotePlaySoundFile(_conn, _filename, _bloop) asm { __remotePlaySoundFile(_conn, _filename, _bloop, __RETVAL__) }
#define RemotePlayTone(_conn, _frequency, _duration) asm { __remotePlayTone(_conn, _frequency, _duration, __RETVAL__) }
#define RemoteStopSound(_conn) asm { __connectionSCDCWrite(_conn, __DCStopSoundPacket, __RETVAL__) }
#define RemoteKeepAlive(_conn) asm { __connectionSCDCWrite(_conn, __DCKeepAlivePacket, __RETVAL__) }
#define RemoteResetScaledValue(_conn, _port) asm { __remoteResetScaledValue(_conn, _port, __RETVAL__) }
#define RemoteResetMotorPosition(_conn, _port, _brelative) asm { __remoteResetMotorPosition(_conn, _port, _brelative, __RETVAL__) }
#define RemoteSetInputMode(_conn, _port, _type, _mode) asm { __remoteSetInputMode(_conn, _port, _type, _mode, __RETVAL__) }
#define RemoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit) asm { __remoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, __RETVAL__) }
#define RemoteResetTachoCount(_conn, _port) asm { __remoteResetTachoCount(_conn, _port, __RETVAL__) }
#define RemoteDatalogSetTimes(_conn, _synctime) asm { __remoteDatalogSetTimes(_conn, _synctime, __RETVAL__) }
#define RemoteSetProperty(_conn, _prop, _value) asm { __remoteSetProperty(_conn, _prop, _value, __RETVAL__) }
#define RemoteLowspeedWrite(_conn, _port, _txlen, _rxlen, _data) asm { __remoteLowspeedWrite(_conn, _port, _txlen, _rxlen, _data, __RETVAL__) }

#ifdef __ENHANCED_FIRMWARE
#define RemoteGetOutputState(_conn, _params) asm { \
  compchktype _params, OutputStateType \
  __remoteGetOutputState(_conn, _params, __RETVAL__) \
}
#define RemoteGetInputValues(_conn, _params) asm { \
  compchktype _params, InputValuesType \
  __remoteGetInputValues(_conn, _params, __RETVAL__) \
}
#define RemoteGetBatteryLevel(_conn, _value) asm { __remoteGetBatteryLevel(_conn, _value, __RETVAL__) }
#define RemoteLowspeedGetStatus(_conn, _value) asm { __remoteLowspeedGetStatus(_conn, _value, __RETVAL__) }
#define RemoteLowspeedRead(_conn, _port, _bread, _data) asm { __remoteLowspeedRead(_conn, _port, _bread, _data, __RETVAL__) }
#define RemoteGetCurrentProgramName(_conn, _name) asm { __remoteGetCurrentProgramName(_conn, _name, __RETVAL__) }
#define RemoteDatalogRead(_conn, _remove, _cnt, _log) asm { __remoteDatalogRead(_conn, _remove, _cnt, _log, __RETVAL__) }
#define RemoteGetContactCount(_conn, _cnt) asm { __remoteGetContactCount(_conn, _cnt, __RETVAL__) }
#define RemoteGetContactName(_conn, _idx, _name) asm { __remoteGetContactName(_conn, _idx, _name, __RETVAL__) }
#define RemoteGetConnectionCount(_conn, _cnt) asm { __remoteGetConnectionCount(_conn, _cnt, __RETVAL__) }
#define RemoteGetConnectionName(_conn, _idx, _name) asm { __remoteGetConnectionName(_conn, _idx, _name, __RETVAL__) }

#define RemoteGetProperty(_conn, _property, _value) asm { __remoteGetProperty(_conn, _property, _value, __RETVAL__) }

#else

#define RemoteGetOutputState(_conn, _port) asm { __remoteGetOutputState(_conn, _port, __RETVAL__) }
#define RemoteGetInputValues(_conn, _port) asm { __remoteGetInputValues(_conn, _port, __RETVAL__) }
#define RemoteGetBatteryLevel(_conn) asm { __remoteGetBatteryLevel(_conn, __RETVAL__) }
#define RemoteLowspeedGetStatus(_conn) asm { __remoteLowspeedGetStatus(_conn, __RETVAL__) }
#define RemoteLowspeedRead(_conn, _port) asm { __remoteLowspeedRead(_conn, _port, __RETVAL__) }
#define RemoteGetCurrentProgramName(_conn) asm { __remoteGetCurrentProgramName(_conn, __RETVAL__) }
#define RemoteDatalogRead(_conn, _remove) asm { __remoteDatalogRead(_conn, _remove, __RETVAL__) }
#define RemoteGetContactCount(_conn) asm { __remoteGetContactCount(_conn, __RETVAL__) }
#define RemoteGetContactName(_conn, _idx) asm { __remoteGetContactName(_conn, _idx, __RETVAL__) }
#define RemoteGetConnectionCount(_conn) asm { __remoteGetConnectionCount(_conn, __RETVAL__) }
#define RemoteGetConnectionName(_conn, _idx) asm { __remoteGetConnectionName(_conn, _idx, __RETVAL__) }
#define RemoteGetProperty(_conn, _property) asm { __remoteGetProperty(_conn, _property, __RETVAL__) }

#endif

#ifdef __ENHANCED_FIRMWARE

#define RemoteOpenRead(_conn, _filename, _handle, _size) asm { __remoteOpenRead(_conn, _filename, _handle, _size, __RETVAL__) }
#define RemoteOpenWrite(_conn, _filename, _size, _handle) asm { __remoteOpenWrite(_conn, _filename, _size, _handle, __RETVAL__) }
#define RemoteRead(_conn, _handle, _numbytes, _data) asm { __remoteRead(_conn, _handle, _numbytes, _data, __RETVAL__) }
#define RemoteWrite(_conn, _handle, _numbytes, _data) asm { __remoteWrite(_conn, _handle, _numbytes, _data, __RETVAL__) }
#define RemoteCloseFile(_conn, _handle) asm { __remoteCloseFile(_conn, _handle, __RETVAL__) }
#define RemoteDeleteFile(_conn, _filename) asm { __remoteDeleteFile(_conn, _filename, __RETVAL__) }
#define RemoteDeleteUserFlash(_conn) asm { __remoteDeleteUserFlash(_conn, __RETVAL__) }
#define RemoteFindFirstFile(_conn, _mask, _handle, _name, _size) asm { __remoteFindFirstFile(_conn, _mask, _handle, _name, _size, __RETVAL__) }
#define RemoteFindNextFile(_conn, _handle, _name, _size) asm { __remoteFindNextFile(_conn, _handle, _name, _size, __RETVAL__) }
#define RemoteGetFirmwareVersion(_conn, _pmin, _pmaj, _fmin, _fmaj) asm { __remoteGetFirmwareVersion(_conn, _pmin, _pmaj, _fmin, _fmaj, __RETVAL__) }
#define RemoteOpenWriteLinear(_conn, _filename, _size, _handle) asm { __remoteOpenWriteLinear(_conn, _filename, _size, _handle, __RETVAL__) }
#define RemoteOpenWriteData(_conn, _filename, _size, _handle) asm { __remoteOpenWriteData(_conn, _filename, _size, _handle, __RETVAL__) }
#define RemoteOpenAppendData(_conn, _filename, _handle, _size) asm { __remoteOpenAppendData(_conn, _filename, _handle, _size, __RETVAL__) }
#define RemoteGetDeviceInfo(_conn, _name, _btaddr, _btsignal, _freemem) asm { __remoteGetDeviceInfo(_conn, _name, _btaddr, _btsignal, _freemem, __RETVAL__) }
#define RemotePollCommandLength(_conn, _bufnum, _length) asm { __remotePollCommandLength(_conn, _bufnum, _length, __RETVAL__) }
#define RemotePollCommand(_conn, _bufnum, _len, _data) asm { __remotePollCommand(_conn, _bufnum, _len, _data, __RETVAL__) }
#define RemoteIOMapRead(_conn, _id, _offset, _numbytes, _data) asm { __remoteIOMapRead(_conn, _id, _offset, _numbytes, _data, __RETVAL__) }
#define RemoteGetBluetoothAddress(_conn, _btaddr) asm { __remoteGetBluetoothAddress(_conn, _btaddr, __RETVAL__) }

#define RemoteRenameFile(_conn, _oldname, _newname) asm { __remoteRenameFile(_conn, _oldname, _newname, __RETVAL__) }

#else

#define RemoteOpenRead(_conn, _filename) asm { __remoteOpenRead(_conn, _filename, __RETVAL__) }
#define RemoteOpenWrite(_conn, _filename, _size) asm { __remoteOpenWrite(_conn, _filename, _size, __RETVAL__) }
#define RemoteRead(_conn, _handle, _numbytes) asm { __remoteRead(_conn, _handle, _numbytes, __RETVAL__) }
#define RemoteWrite(_conn, _handle, _data) asm { __remoteWrite(_conn, _handle, _data, __RETVAL__) }
#define RemoteCloseFile(_conn, _handle) asm { __remoteCloseFile(_conn, _handle, __RETVAL__) }
#define RemoteDeleteFile(_conn, _filename) asm { __remoteDeleteFile(_conn, _filename, __RETVAL__) }
#define RemoteDeleteUserFlash(_conn) asm { __connectionSCDCWrite(_conn, __SCDeleteUserFlashPacket, __RETVAL__) }
#define RemoteFindFirstFile(_conn, _mask) asm { __remoteFindFirstFile(_conn, _mask, __RETVAL__) }
#define RemoteFindNextFile(_conn, _handle) asm { __remoteFindNextFile(_conn, _handle, __RETVAL__) }
#define RemoteGetFirmwareVersion(_conn) asm { __connectionSCDCWrite(_conn, __SCGetFirmwareVerPacket, __RETVAL__) }
#define RemoteOpenWriteLinear(_conn, _filename, _size) asm { __remoteOpenWriteLinear(_conn, _filename, _size, __RETVAL__) }
#define RemoteOpenWriteData(_conn, _filename, _size) asm { __remoteOpenWriteData(_conn, _filename, _size, __RETVAL__) }
#define RemoteOpenAppendData(_conn, _filename) asm { __remoteOpenAppendData(_conn, _filename, __RETVAL__) }
#define RemoteGetDeviceInfo(_conn) asm { __connectionSCDCWrite(_conn, __SCGetDeviceInfoPacket, __RETVAL__) }
#define RemotePollCommandLength(_conn, _bufnum) asm { __remotePollCommandLength(_conn, _bufnum, __RETVAL__) }
#define RemotePollCommand(_conn, _bufnum, _len) asm { __remotePollCommand(_conn, _bufnum, _len, __RETVAL__) }
#define RemoteIOMapRead(_conn, _id, _offset, _numbytes) asm { __remoteIOMapRead(_conn, _id, _offset, _numbytes, __RETVAL__) }
#define RemoteGetBluetoothAddress(_conn) asm { __connectionSCDCWrite(_conn, __SCBTGetAddressPacket, __RETVAL__) }

#endif

#define RemoteBluetoothFactoryReset(_conn) asm { __connectionSCDCWrite(_conn, __SCBTFactoryResetPacket, __RETVAL__) }
#define RemoteIOMapWriteValue(_conn, _id, _offset, _value) asm { __remoteIOMapWriteValue(_conn, _id, _offset, _value, __RETVAL__) }
#define RemoteIOMapWriteBytes(_conn, _id, _offset, _data) asm { __remoteIOMapWriteBytes(_conn, _id, _offset, _data, __RETVAL__) }
#define RemoteSetBrickName(_conn, _name) asm { __remoteSetBrickName(_conn, _name, __RETVAL__) }

#define UseRS485() asm { __UseRS485() }

#ifdef __ENHANCED_FIRMWARE

#define RS485Status(_sendingData, _dataAvail) asm { __RS485Status(_sendingData, _dataAvail) }
#define RS485SendingData() asm { __RS485Status(__RETVAL__, __TMPBYTE__) }
#define RS485DataAvailable() asm { __RS485Status(__TMPBYTE__, __RETVAL__) }
#define RS485Write(_buffer) asm { __RS485Write(_buffer, __RETVAL__) }
#define RS485Read(_buffer) asm { __RS485Read(_buffer, __RETVAL__) }

#if __FIRMWARE_VERSION > 107

#define RS485ReadEx(_buffer, _buflen) asm { __RS485ReadEx(_buffer, _buflen, __RETVAL__) }
#define RS485Control(_cmd, _baud, _mode) asm { __RS485Control(_cmd, _baud, _mode, __RETVAL__) }
#define RS485Uart(_baud, _mode) asm { __RS485Control(HS_CTRL_UART, _baud, _mode, __RETVAL__) }
#define RS485Initialize() asm { __RS485Control(HS_CTRL_UART, HS_BAUD_DEFAULT, HS_MODE_DEFAULT, __RETVAL__) }
#define RS485Enable() asm { __RS485Control(HS_CTRL_INIT, HS_BAUD_DEFAULT, HS_MODE_DEFAULT, __RETVAL__) }
#define RS485Disable() asm { __RS485Control(HS_CTRL_EXIT, HS_BAUD_DEFAULT, HS_MODE_DEFAULT, __RETVAL__) }

#else

#define RS485Control(_cmd, _baud) asm { __RS485Control(_cmd, _baud, __RETVAL__) }
#define RS485Uart(_baud) asm { __RS485Control(HS_CTRL_UART, _baud, __RETVAL__) }
#define RS485Initialize() asm { __RS485Control(HS_CTRL_UART, HS_BAUD_DEFAULT, __RETVAL__) }
#define RS485Enable() asm { __RS485Control(HS_CTRL_INIT, HS_BAUD_DEFAULT, __RETVAL__) }
#define RS485Disable() asm { __RS485Control(HS_CTRL_EXIT, HS_BAUD_DEFAULT, __RETVAL__) }

#endif

#define SendRS485Bool(_bval) asm { __sendRS485Bool(_bval, __RETVAL__) }
#define SendRS485Number(_val) asm { __sendRS485Number(_val, __RETVAL__) }
#define SendRS485String(_str) asm { __sendRS485String(_str, __RETVAL__) }

#endif

#define GetBTInputBuffer(_offset, _cnt, _data) asm { __getBTInputBuffer(_offset, _cnt, _data) }
#define GetBTOutputBuffer(_offset, _cnt, _data) asm { __getBTOutputBuffer(_offset, _cnt, _data) }
#define GetHSInputBuffer(_offset, _cnt, _data) asm { __getHSInputBuffer(_offset, _cnt, _data) }
#define GetHSOutputBuffer(_offset, _cnt, _data) asm { __getHSOutputBuffer(_offset, _cnt, _data) }
#define GetUSBInputBuffer(_offset, _cnt, _data) asm { __getUSBInputBuffer(_offset, _cnt, _data) }
#define GetUSBOutputBuffer(_offset, _cnt, _data) asm { __getUSBOutputBuffer(_offset, _cnt, _data) }
#define GetUSBPollBuffer(_offset, _cnt, _data) asm { __getUSBPollBuffer(_offset, _cnt, _data) }

#define BTDeviceName(_p) asm { GetBTDeviceName(_p, __STRRETVAL__) }
#define BTConnectionName(_p) asm { GetBTConnectionName(_p, __STRRETVAL__) }
#define BTConnectionPinCode(_p) asm { GetBTConnectionPinCode(_p, __STRRETVAL__) }
#define BrickDataName() asm { GetBrickDataName(__STRRETVAL__) }

#define GetBTDeviceAddress(_p, _data) asm { __getBTDeviceAddress(_p, _data) }
#define GetBTConnectionAddress(_p, _data) asm { __getBTConnectionAddress(_p, _data) }
#define GetBrickDataAddress(_data) asm { __getCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _data) }

#define BTDeviceClass(_p) asm { GetBTDeviceClass(_p, __TMPLONG__) __RETURN__ __TMPLONG__ }
#define BTDeviceStatus(_p) asm { GetBTDeviceStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTConnectionClass(_p) asm { GetBTConnectionClass(_p, __TMPLONG__) __RETURN__ __TMPLONG__ }
#define BTConnectionHandleNum(_p) asm { GetBTConnectionHandleNum(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTConnectionStreamStatus(_p) asm { GetBTConnectionStreamStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTConnectionLinkQuality(_p) asm { GetBTConnectionLinkQuality(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BrickDataBluecoreVersion() asm { GetBrickDataBluecoreVersion(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define BrickDataBtStateStatus() asm { GetBrickDataBtStateStatus(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BrickDataBtHardwareStatus() asm { GetBrickDataBtHardwareStatus(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BrickDataTimeoutValue() asm { GetBrickDataTimeoutValue(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTInputBufferInPtr() asm { GetBTInputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTInputBufferOutPtr() asm { GetBTInputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTOutputBufferInPtr() asm { GetBTOutputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTOutputBufferOutPtr() asm { GetBTOutputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSInputBufferInPtr() asm { GetHSInputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSInputBufferOutPtr() asm { GetHSInputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSOutputBufferInPtr() asm { GetHSOutputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSOutputBufferOutPtr() asm { GetHSOutputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBInputBufferInPtr() asm { GetUSBInputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBInputBufferOutPtr() asm { GetUSBInputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBOutputBufferInPtr() asm { GetUSBOutputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBOutputBufferOutPtr() asm { GetUSBOutputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBPollBufferInPtr() asm { GetUSBPollBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBPollBufferOutPtr() asm { GetUSBPollBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTDeviceCount() asm { GetBTDeviceCount(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTDeviceNameCount() asm { GetBTDeviceNameCount(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSFlags() asm { GetHSFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSSpeed() asm { GetHSSpeed(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSState() asm { GetHSState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBState() asm { GetUSBState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSAddress() asm { GetHSAddress(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)
#define HSMode() asm { GetHSMode(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define BTDataMode() asm { GetBTDataMode(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSDataMode() asm { GetHSDataMode(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#endif

#define SetBTDeviceName(_p, _str) asm { __setBTDeviceName(_p, _str) }
#define SetBTDeviceAddress(_p, _btaddr) asm { __setBTDeviceAddress(_p, _btaddr) }
#define SetBTConnectionName(_p, _str) asm { __setBTConnectionName(_p, _str) }
#define SetBTConnectionPinCode(_p, _code) asm { __setBTConnectionPinCode(_p, _code) }
#define SetBTConnectionAddress(_p, _btaddr) asm { __setBTConnectionAddress(_p, _btaddr) }
#define SetBrickDataName(_str) SetCommModuleBytes(CommOffsetBrickDataName, 16, _str)
#define SetBrickDataAddress(_btaddr) SetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _btaddr)

#define SetBTDeviceClass(_p, _n) asm { __setBTDeviceClass(_p, _n) }
#define SetBTDeviceStatus(_p, _n) asm { __setBTDeviceStatus(_p, _n) }
#define SetBTConnectionClass(_p, _n) asm { __setBTConnectionClass(_p, _n) }
#define SetBTConnectionHandleNum(_p, _n) asm { __setBTConnectionHandleNum(_p, _n) }
#define SetBTConnectionStreamStatus(_p, _n) asm { __setBTConnectionStreamStatus(_p, _n) }
#define SetBTConnectionLinkQuality(_p, _n) asm { __setBTConnectionLinkQuality(_p, _n) }
#define SetBrickDataBluecoreVersion(_n) asm { __setBrickDataBluecoreVersion(_n) }
#define SetBrickDataBtStateStatus(_n) asm { __setBrickDataBtStateStatus(_n) }
#define SetBrickDataBtHardwareStatus(_n) asm { __setBrickDataBtHardwareStatus(_n) }
#define SetBrickDataTimeoutValue(_n) asm { __setBrickDataTimeoutValue(_n) }

#define SetBTDeviceCount(_n) asm { __setBTDeviceCount(_n) }
#define SetBTDeviceNameCount(_n) asm { __setBTDeviceNameCount(_n) }

#define SetBTInputBuffer(_offset, _cnt, _data) asm { __setBTInputBuffer(_offset, _cnt, _data) }

#define SetBTInputBufferInPtr(_n) asm { __setBTInputBufferInPtr(_n) }
#define SetBTInputBufferOutPtr(_n) asm { __setBTInputBufferOutPtr(_n) }

#define SetBTOutputBuffer(_offset, _cnt, _data) asm { __setBTOutputBuffer(_offset, _cnt, _data) }

#define SetBTOutputBufferInPtr(_n) asm { __setBTOutputBufferInPtr(_n) }
#define SetBTOutputBufferOutPtr(_n) asm { __setBTOutputBufferOutPtr(_n) }

#define SetHSInputBuffer(_offset, _cnt, _data) asm { __setHSInputBuffer(_offset, _cnt, _data) }

#define SetHSInputBufferInPtr(_n) asm { __setHSInputBufferInPtr(_n) }
#define SetHSInputBufferOutPtr(_n) asm { __setHSInputBufferOutPtr(_n) }

#define SetHSOutputBuffer(_offset, _cnt, _data) asm { __setHSOutputBuffer(_offset, _cnt, _data) }

#define SetHSOutputBufferInPtr(_n) asm { __setHSOutputBufferInPtr(_n) }
#define SetHSOutputBufferOutPtr(_n) asm { __setHSOutputBufferOutPtr(_n) }

#define SetUSBInputBuffer(_offset, _cnt, _data) asm { __setUSBInputBuffer(_offset, _cnt, _data) }

#define SetUSBInputBufferInPtr(_n) asm { __setUSBInputBufferInPtr(_n) }
#define SetUSBInputBufferOutPtr(_n) asm { __setUSBInputBufferOutPtr(_n) }

#define SetUSBOutputBuffer(_offset, _cnt, _data) asm { __setUSBOutputBuffer(_offset, _cnt, _data) }

#define SetUSBOutputBufferInPtr(_n) asm { __setUSBOutputBufferInPtr(_n) }
#define SetUSBOutputBufferOutPtr(_n) asm { __setUSBOutputBufferOutPtr(_n) }

#define SetUSBPollBuffer(_offset, _cnt, _data) asm { __setUSBPollBuffer(_offset, _cnt, _data) }

#define SetUSBPollBufferInPtr(_n) asm { __setUSBPollBufferInPtr(_n) }
#define SetUSBPollBufferOutPtr(_n) asm { __setUSBPollBufferOutPtr(_n) }

#define SetHSFlags(_n) asm { __setHSFlags(_n) }
#define SetHSSpeed(_n) asm { __setHSSpeed(_n) }
#define SetHSState(_n) asm { __setHSState(_n) }
#define SetUSBState(_n) asm { __setUSBState(_n) }
#define SetHSAddress(_n) asm { __setHSAddress(_n) }

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)
#define SetBTDataMode(_n) asm { __setBTDataMode(_n) }
#define SetHSDataMode(_n) asm { __setHSDataMode(_n) }
#endif

#define SysMessageWrite(_args) asm { \
  compchktype _args, MessageWriteType \
  syscall MessageWrite, _args \
}
#define SysMessageRead(_args) asm { \
  compchktype _args, MessageReadType \
  syscall MessageRead, _args \
}
#define SysCommBTWrite(_args) asm { \
  compchktype _args, CommBTWriteType \
  syscall CommBTWrite, _args \
}
#define SysCommBTCheckStatus(_args) asm { \
  compchktype _args, CommBTCheckStatusType \
  syscall CommBTCheckStatus, _args \
}
#ifdef __ENHANCED_FIRMWARE
#define SysCommExecuteFunction(_args) asm { \
  compchktype _args, CommExecuteFunctionType \
  syscall CommExecuteFunction, _args \
}
#define SysCommHSControl(_args) asm { \
  compchktype _args, CommHSControlType \
  syscall CommHSControl, _args \
}
#define SysCommHSCheckStatus(_args) asm { \
  compchktype _args, CommHSCheckStatusType \
  syscall CommHSCheckStatus, _args \
}
#define SysCommHSRead(_args) asm { \
  compchktype _args, CommHSReadWriteType \
  syscall CommHSRead, _args \
}
#define SysCommHSWrite(_args) asm { \
  compchktype _args, CommHSReadWriteType \
  syscall CommHSWrite, _args \
}
#endif
#if __FIRMWARE_VERSION > 107
#define SysCommBTOnOff(_args) asm { \
  compchktype _args, CommBTOnOffType \
  syscall CommBTOnOff, _args \
}
#define SysCommBTConnection(_args) asm { \
  compchktype _args, CommBTConnectionType \
  syscall CommBTConnection, _args \
}
#endif

#endif
/** @} */ // end of CommModuleFunctions group
/** @} */ // end of CommModule group
/** @} */ // end of NXTFirmwareModules group

#endif // COMM_H
