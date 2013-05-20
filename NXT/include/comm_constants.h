/** \file comm_constants.h
 * \brief NXC Command module constants
 *
 * comm_constants.h contains NXC Command module constants
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

#ifndef COMM_CONSTANTS_H
#define COMM_CONSTANTS_H

/** @addtogroup CommModule
 * @{
 */
/** @defgroup CommModuleConstants Comm module constants
 * Constants that are part of the NXT firmware's Comm module.
 * @{
 */
/** @defgroup CommMiscConstants Miscellaneous Comm module constants
 * Miscellaneous constants related to the Comm module.
 * @{
 */
#define SIZE_OF_USBBUF                64  /*!< Size of USB Buffer in bytes */
#define USB_PROTOCOL_OVERHEAD         2   /*!< Size of USB Overhead in bytes -- Command type byte + Command*/
#define SIZE_OF_USBDATA               62  /*!< Size of USB Buffer available for data */
#define SIZE_OF_HSBUF                 128 /*!< Size of High Speed Port 4 buffer */
#define SIZE_OF_BTBUF                 128 /*!< Size of Bluetooth buffer*/

#define BT_CMD_BYTE                   1  /*!< Size of Bluetooth command*/
#define SIZE_OF_BT_DEVICE_TABLE       30 /*!< Size of Bluetooth device table */
#define SIZE_OF_BT_CONNECT_TABLE      4  /*!< Size of Bluetooth connection table -- Index 0 is always incoming connection */
#define SIZE_OF_BT_NAME               16 /*!< Size of Bluetooth name */
#define SIZE_OF_BRICK_NAME            8  /*!< Size of NXT Brick name */
#define SIZE_OF_CLASS_OF_DEVICE       4  /*!< Size of class of device */
#define SIZE_OF_BT_PINCODE            16 /*!< Size of Bluetooth PIN */
#define SIZE_OF_BDADDR                7  /*!< Size of Bluetooth Address*/
#define MAX_BT_MSG_SIZE               60000 /*!< Max Bluetooth Message Size */

#define BT_DEFAULT_INQUIRY_MAX        0   /*!< Bluetooth default inquiry Max (0 == unlimited)*/
#define BT_DEFAULT_INQUIRY_TIMEOUT_LO 15  /*!< Bluetooth inquiry timeout (15*1.28 sec = 19.2 sec) */
/** @} */  // end of CommMiscConstants group

/** @defgroup CommJoystickConstants Joystick message constants
 * Constants for reading joystick information
 * @{
 */
#define JOY_BTN_01 0x00000001 /*!< Joystick button 1 */
#define JOY_BTN_02 0x00000002 /*!< Joystick button 2 */
#define JOY_BTN_03 0x00000004 /*!< Joystick button 3 */
#define JOY_BTN_04 0x00000008 /*!< Joystick button 4 */
#define JOY_BTN_05 0x00000010 /*!< Joystick button 5 */
#define JOY_BTN_06 0x00000020 /*!< Joystick button 6 */
#define JOY_BTN_07 0x00000040 /*!< Joystick button 7 */
#define JOY_BTN_08 0x00000080 /*!< Joystick button 8 */
#define JOY_BTN_09 0x00000100 /*!< Joystick button 9 */
#define JOY_BTN_10 0x00000200 /*!< Joystick button 10 */
#define JOY_BTN_11 0x00000400 /*!< Joystick button 11 */
#define JOY_BTN_12 0x00000800 /*!< Joystick button 12 */
#define JOY_BTN_13 0x00001000 /*!< Joystick button 13 */
#define JOY_BTN_14 0x00002000 /*!< Joystick button 14 */
#define JOY_BTN_15 0x00004000 /*!< Joystick button 15 */
#define JOY_BTN_16 0x00008000 /*!< Joystick button 16 */
#define JOY_BTN_17 0x00010000 /*!< Joystick button 17 */
#define JOY_BTN_18 0x00020000 /*!< Joystick button 18 */
#define JOY_BTN_19 0x00040000 /*!< Joystick button 19 */
#define JOY_BTN_20 0x00080000 /*!< Joystick button 20 */
#define JOY_BTN_21 0x00100000 /*!< Joystick button 21 */
#define JOY_BTN_22 0x00200000 /*!< Joystick button 22 */
#define JOY_BTN_23 0x00400000 /*!< Joystick button 23 */
#define JOY_BTN_24 0x00800000 /*!< Joystick button 24 */
#define JOY_BTN_25 0x01000000 /*!< Joystick button 25 */
#define JOY_BTN_26 0x02000000 /*!< Joystick button 26 */
#define JOY_BTN_27 0x04000000 /*!< Joystick button 27 */
#define JOY_BTN_28 0x08000000 /*!< Joystick button 28 */
#define JOY_BTN_29 0x10000000 /*!< Joystick button 29 */
#define JOY_BTN_30 0x20000000 /*!< Joystick button 30 */
#define JOY_BTN_31 0x40000000 /*!< Joystick button 31 */
#define JOY_BTN_32 0x80000000 /*!< Joystick button 32 */

#define JOY_POV_FORWARD  0     /*!< Joystick POV forward */
#define JOY_POV_TOPRIGHT 4500  /*!< Joystick POV top right */
#define JOY_POV_RIGHT    9000  /*!< Joystick POV right */
#define JOY_POV_BOTRIGHT 13500 /*!< Joystick POV bottom right */
#define JOY_POV_BACKWARD 18000 /*!< Joystick POV backward */
#define JOY_POV_BOTLEFT  22500 /*!< Joystick POV bottom left */
#define JOY_POV_LEFT     27000 /*!< Joystick POV left */
#define JOY_POV_TOPLEFT  31500 /*!< Joystick POV top left */
#define JOY_POV_CENTERED 65535 /*!< Joystick POV centered */
/** @} */ // end of CommJoystickConstants group

/** @defgroup CommBtStateConstants Bluetooth State constants
 * Constants related to the bluetooth state.
 * @{
 */
#define BT_ARM_OFF              0 /*!< BtState constant bluetooth off */
#define BT_ARM_CMD_MODE         1 /*!< BtState constant bluetooth command mode */
#define BT_ARM_DATA_MODE        2 /*!< BtState constant bluetooth data mode */
/** @} */  // end of CommBtStateConstants group

/** @defgroup CommDataModeConstants Data mode constants
 * Constants related to the bluetooth and hi-speed data modes.
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define DATA_MODE_NXT    0x00 /*!< Use NXT data mode */
#define DATA_MODE_GPS    0x01 /*!< Use GPS data mode */
#define DATA_MODE_RAW    0x02 /*!< Use RAW data mode */
#define DATA_MODE_MASK   0x07 /*!< A mask for the data mode bits. */
#define DATA_MODE_UPDATE 0x08 /*!< Indicates that the data mode has been changed. */
/** @} */  // end of CommDataModeConstants group

/** @defgroup CommBtStateStatusConstants Bluetooth state status constants
 * Constants related to the bluetooth state status.
 * @{
 */
#define BT_BRICK_VISIBILITY     0x01 /*!< BtStateStatus brick visibility bit */
#define BT_BRICK_PORT_OPEN      0x02 /*!< BtStateStatus port open bit */
#define BT_CONNECTION_0_ENABLE  0x10 /*!< BtStateStatus connection 0 enable/disable bit */
#define BT_CONNECTION_1_ENABLE  0x20 /*!< BtStateStatus connection 1 enable/disable bit */
#define BT_CONNECTION_2_ENABLE  0x40 /*!< BtStateStatus connection 2 enable/disable bit */
#define BT_CONNECTION_3_ENABLE  0x80 /*!< BtStateStatus connection 3 enable/disable bit */
/** @} */  // end of CommBtStateStatusConstants group

/** @defgroup CommConnectionConstants Remote connection constants
 * Constants for specifying remote connection slots.
 * @{
 */
#define CONN_BT0    0x0 /*!< Bluetooth connection 0 */
#define CONN_BT1    0x1 /*!< Bluetooth connection 1 */
#define CONN_BT2    0x2 /*!< Bluetooth connection 2 */
#define CONN_BT3    0x3 /*!< Bluetooth connection 3 */
#define CONN_HS4    0x4 /*!< RS485 (hi-speed) connection (port 4, all devices) */
#define CONN_HS_ALL 0x4 /*!< RS485 (hi-speed) connection (port 4, all devices) */
#define CONN_HS_1   0x5 /*!< RS485 (hi-speed) connection (port 4, device address 1) */
#define CONN_HS_2   0x6 /*!< RS485 (hi-speed) connection (port 4, device address 2) */
#define CONN_HS_3   0x7 /*!< RS485 (hi-speed) connection (port 4, device address 3) */
#define CONN_HS_4   0x8 /*!< RS485 (hi-speed) connection (port 4, device address 4) */
#define CONN_HS_5   0x9 /*!< RS485 (hi-speed) connection (port 4, device address 5) */
#define CONN_HS_6   0xa /*!< RS485 (hi-speed) connection (port 4, device address 6) */
#define CONN_HS_7   0xb /*!< RS485 (hi-speed) connection (port 4, device address 7) */
#define CONN_HS_8   0xc /*!< RS485 (hi-speed) connection (port 4, device address 8) */
/** @} */  // end of CommConnectionConstants group

/** @defgroup CommBtHwStatusConstants Bluetooth hardware status constants
 * Constants related to the bluetooth hardware status.
 * @{
 */
#define BT_ENABLE               0x00 /*!< BtHwStatus bluetooth enable */
#define BT_DISABLE              0x01 /*!< BtHwStatus bluetooth disable */
/** @} */  // end of CommBtHwStatusConstants group

/** @defgroup CommHiSpeedConstants Hi-speed port constants
 * Constants related to the hi-speed port.
 * @{
 */
/** @defgroup CommHiSpeedFlagsConstants Hi-speed port flags constants
 * Constants related to the hi-speed port flags.
 * @{
 */
#define HS_UPDATE        1 /*!< HsFlags high speed update required */
/** @} */  // end of CommHiSpeedFlagsConstants group

/** @defgroup CommHiSpeedStateConstants Hi-speed port state constants
 * Constants related to the hi-speed port state.
 * @{
 */
#define HS_INITIALISE       1 /*!< HsState initialize */
#define HS_INIT_RECEIVER    2 /*!< HsState initialize receiver */
#define HS_SEND_DATA        3 /*!< HsState send data */
#define HS_DISABLE          4 /*!< HsState disable */
#define HS_ENABLE           5 /*!< HsState enable */
#define HS_DEFAULT          6 /*!< HsState default */
#define HS_BYTES_REMAINING 16 /*!< HsState bytes remaining to be sent */
/** @} */  // end of CommHiSpeedStateConstants group

#ifdef __ENHANCED_FIRMWARE

/** @defgroup CommHiSpeedCtrlConstants Hi-speed port SysCommHSControl constants
 * Constants for use with the SysCommHSControl API function.
 * \sa SysCommHSControl()
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define HS_CTRL_INIT 0 /*!< Enable the high speed port */
#define HS_CTRL_UART 1 /*!< Setup the high speed port UART configuration */
#define HS_CTRL_EXIT 2 /*!< Ddisable the high speed port */
/** @} */  // end of CommHiSpeedCtrlConstants group

#if __FIRMWARE_VERSION > 107

/** @defgroup CommHiSpeedBaudConstants Hi-speed port baud rate constants
 * Constants for configuring the hi-speed port baud rate (HsSpeed).
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define HS_BAUD_1200     0 /*!< HsSpeed 1200 Baud */
#define HS_BAUD_2400     1 /*!< HsSpeed 2400 Baud */
#define HS_BAUD_3600     2 /*!< HsSpeed 3600 Baud */
#define HS_BAUD_4800     3 /*!< HsSpeed 4800 Baud */
#define HS_BAUD_7200     4 /*!< HsSpeed 7200 Baud */
#define HS_BAUD_9600     5 /*!< HsSpeed 9600 Baud */
#define HS_BAUD_14400    6 /*!< HsSpeed 14400 Baud */
#define HS_BAUD_19200    7 /*!< HsSpeed 19200 Baud */
#define HS_BAUD_28800    8 /*!< HsSpeed 28800 Baud */
#define HS_BAUD_38400    9 /*!< HsSpeed 38400 Baud */
#define HS_BAUD_57600   10 /*!< HsSpeed 57600 Baud */
#define HS_BAUD_76800   11 /*!< HsSpeed 76800 Baud */
#define HS_BAUD_115200  12 /*!< HsSpeed 115200 Baud */
#define HS_BAUD_230400  13 /*!< HsSpeed 230400 Baud */
#define HS_BAUD_460800  14 /*!< HsSpeed 460800 Baud */
#define HS_BAUD_921600  15 /*!< HsSpeed 921600 Baud */
#define HS_BAUD_DEFAULT 15 /*!< HsSpeed default Baud (921600) */
/** @} */  // end of CommHiSpeedBaudConstants group


/** @defgroup CommHiSpeedModeConstants Hi-speed port UART mode constants
 * Constants referring to HsMode UART configuration settings
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define HS_MODE_UART_RS485 0x0    /*!< HsMode UART in default or RS485 mode */
#define HS_MODE_UART_RS232 0x1    /*!< HsMode UART in normal or RS232 mode */

#define HS_MODE_MASK 0x3EC0        /*!< HsMode mode mask */
#define HS_UART_MASK 0x000F        /*!< HsMode UART mask */

#define HS_MODE_DEFAULT HS_MODE_8N1 /*!< HsMode default mode (8 data bits, no parity, 1 stop bit) */

/** @defgroup CommHiSpeedDataBitsConstants Hi-speed port data bits constants
 * Constants referring to HsMode (number of data bits)
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define HS_MODE_5_DATA 0x0000 /*!< HsMode 5 data bits */
#define HS_MODE_6_DATA 0x0040 /*!< HsMode 6 data bits */
#define HS_MODE_7_DATA 0x0080 /*!< HsMode 7 data bits */
#define HS_MODE_8_DATA 0x00C0 /*!< HsMode 8 data bits */
/** @} */  // end of CommHiSpeedDataBitsConstants group

/** @defgroup CommHiSpeedStopBitsConstants Hi-speed port stop bits constants
 * Constants referring to HsMode (number of stop bits)
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define HS_MODE_10_STOP 0x0000 /*!< HsMode 1 stop bit */
#define HS_MODE_15_STOP 0x1000 /*!< HsMode 1.5 stop bits */
#define HS_MODE_20_STOP 0x2000 /*!< HsMode 2 stop bits */
/** @} */  // end of CommHiSpeedStopBitsConstants group

/** @defgroup CommHiSpeedParityConstants Hi-speed port parity constants
 * Constants referring to HsMode (parity)
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define HS_MODE_E_PARITY 0x0000 /*!< HsMode Even parity */
#define HS_MODE_O_PARITY 0x0200 /*!< HsMode Odd parity */
#define HS_MODE_S_PARITY 0x0400 /*!< HsMode Space parity */
#define HS_MODE_M_PARITY 0x0600 /*!< HsMode Mark parity */
#define HS_MODE_N_PARITY 0x0800 /*!< HsMode No parity */
/** @} */  // end of CommHiSpeedParityConstants group

/** @defgroup CommHiSpeedCombinedConstants Hi-speed port combined UART constants
 * Constants that combine data bits, parity, and stop bits into a single value.
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define HS_MODE_8N1 (HS_MODE_8_DATA|HS_MODE_N_PARITY|HS_MODE_10_STOP) /*!< HsMode 8 data bits, no parity, 1 stop bit */
#define HS_MODE_7E1 (HS_MODE_7_DATA|HS_MODE_E_PARITY|HS_MODE_10_STOP) /*!< HsMode 7 data bits, even parity, 1 stop bit */
/** @} */  // end of CommHiSpeedCombinedConstants group
/** @} */  // end of CommHiSpeedModeConstants group


/** @defgroup CommHiSpeedAddressConstants Hi-speed port address constants
 * Constants that are used to specify the Hi-speed (RS-485) port device address.
 * \warning These options require the enhanced NBC/NXC firmware
 * @{
 */
#define HS_ADDRESS_ALL 0 /*!< HsAddress all devices */
#define HS_ADDRESS_1   1 /*!< HsAddress device address 1 */
#define HS_ADDRESS_2   2 /*!< HsAddress device address 2 */
#define HS_ADDRESS_3   3 /*!< HsAddress device address 3 */
#define HS_ADDRESS_4   4 /*!< HsAddress device address 4 */
#define HS_ADDRESS_5   5 /*!< HsAddress device address 5 */
#define HS_ADDRESS_6   6 /*!< HsAddress device address 6 */
#define HS_ADDRESS_7   7 /*!< HsAddress device address 7 */
#define HS_ADDRESS_8   8 /*!< HsAddress device address 8 */
/** @} */  // end of CommHiSpeedAddressConstants group

#endif
#endif
/** @} */  // end of CommHiSpeedConstants group

/** @defgroup CommDeviceStatusConstants Device status constants
 * Constants refering to DeviceStatus within DeviceTable
 * @{
 */
#define BT_DEVICE_EMPTY   0x00 /*!< Bluetooth device table empty */
#define BT_DEVICE_UNKNOWN 0x01 /*!< Bluetooth device unknown */
#define BT_DEVICE_KNOWN   0x02 /*!< Bluetooth device known */
#define BT_DEVICE_NAME    0x40 /*!< Bluetooth device name */
#define BT_DEVICE_AWAY    0x80 /*!< Bluetooth device away */
/** @} */  // end of CommDeviceStatusConstants group

/** @defgroup CommInterfaceConstants Comm module interface function constants
 * Constants for all the Comm module interface functions executable via SysCommExecuteFunction.
 * \sa SysCommExecuteFunction()
 * @{
 */
#define INTF_SENDFILE      0 /*!< Send a file via bluetooth to another device */
#define INTF_SEARCH        1 /*!< Search for bluetooth devices */
#define INTF_STOPSEARCH    2 /*!< Stop searching for bluetooth devices */
#define INTF_CONNECT       3 /*!< Connect to one of the known devices */
#define INTF_DISCONNECT    4 /*!< Disconnect from one of the connected devices */
#define INTF_DISCONNECTALL 5 /*!< Disconnect all devices */
#define INTF_REMOVEDEVICE  6 /*!< Remove a device from the known devices table */
#define INTF_VISIBILITY    7 /*!< Set the bluetooth visibility on or off */
#define INTF_SETCMDMODE    8 /*!< Set bluetooth into command mode */
#define INTF_OPENSTREAM    9 /*!< Open a bluetooth stream */
#define INTF_SENDDATA      10 /*!< Send data over a bluetooth connection */
#define INTF_FACTORYRESET  11 /*!< Reset bluetooth settings to factory values */
#define INTF_BTON          12 /*!< Turn on the bluetooth radio */
#define INTF_BTOFF         13 /*!< Turn off the bluetooth radio */
#define INTF_SETBTNAME     14 /*!< Set the bluetooth name */
#define INTF_EXTREAD       15 /*!< External read request */
#define INTF_PINREQ        16 /*!< Bluetooth PIN request */
#define INTF_CONNECTREQ    17 /*!< Connection request from another device */

#if __FIRMWARE_VERSION > 107
#define INTF_CONNECTBYNAME 18 /*!< Connect to a bluetooth device by name */
#endif
/** @} */  // end of CommInterfaceConstants group

/** @defgroup CommStatusCodesConstants Comm module status code constants
 * Constants for Comm module status codes.
 * @{
 */
#define LR_SUCCESS        0x50 /*!< Bluetooth list result success */
#define LR_COULD_NOT_SAVE 0x51 /*!< Bluetooth list result could not save */
#define LR_STORE_IS_FULL  0x52 /*!< Bluetooth list result store is full */
#define LR_ENTRY_REMOVED  0x53 /*!< Bluetooth list result entry removed */
#define LR_UNKNOWN_ADDR   0x54 /*!< Bluetooth list result unknown address */

#define USB_CMD_READY     0x01 /*!< A constant representing usb direct command */
#define BT_CMD_READY      0x02 /*!< A constant representing bluetooth direct command */
#define HS_CMD_READY      0x04 /*!< A constant representing high speed direct command */
/** @} */  // end of CommStatusCodesConstants group

/** @defgroup CommIOMAP Comm module IOMAP offsets
 * Constant offsets into the Comm module IOMAP structure.
 * @{
 */
#define CommOffsetPFunc    0 /*!< Offset to the Comm module first function pointer (4 bytes) */
#define CommOffsetPFuncTwo 4 /*!< Offset to the Comm module second function pointer (4 bytes) */
// BtDeviceTable[30] (930 bytes)
#define CommOffsetBtDeviceTableName(p)           (((p)*31)+8) /*!< Offset to BT device table name (16 bytes) */
#define CommOffsetBtDeviceTableClassOfDevice(p)  (((p)*31)+24) /*!< Offset to Bluetooth device table device class (4 bytes) */
#define CommOffsetBtDeviceTableBdAddr(p)         (((p)*31)+28) /*!< Offset to Bluetooth device table address (7 bytes) */
#define CommOffsetBtDeviceTableDeviceStatus(p)   (((p)*31)+35) /*!< Offset to Bluetooth device table status (1 byte) */
//  BDCONNECTTABLE BtConnectTable[4]; (188 bytes)
#define CommOffsetBtConnectTableName(p)          (((p)*47)+938) /*!< Offset to Bluetooth connect table name (16 bytes) */
#define CommOffsetBtConnectTableClassOfDevice(p) (((p)*47)+954) /*!< Offset to Bluetooth connect table device class (4 bytes) */
#define CommOffsetBtConnectTablePinCode(p)       (((p)*47)+958) /*!< Offset to Bluetooth connect table pin code (16 bytes) */
#define CommOffsetBtConnectTableBdAddr(p)        (((p)*47)+974) /*!< Offset to Bluetooth connect table address (7 bytes) */
#define CommOffsetBtConnectTableHandleNr(p)      (((p)*47)+981) /*!< Offset to Bluetooth connect table handle (1 byte) */
#define CommOffsetBtConnectTableStreamStatus(p)  (((p)*47)+982) /*!< Offset to Bluetooth connect table stream status (1 byte) */
#define CommOffsetBtConnectTableLinkQuality(p)   (((p)*47)+983) /*!< Offset to Bluetooth connect table link quality (1 byte) */
//General brick data
//  BRICKDATA      BrickData; (31 bytes)
#define CommOffsetBrickDataName            1126 /*!< Offset to brick name (16 bytes) */
#define CommOffsetBrickDataBluecoreVersion 1142 /*!< Offset to Bluecore version (2 bytes) */
#define CommOffsetBrickDataBdAddr          1144 /*!< Offset to Bluetooth address (7 bytes) */
#define CommOffsetBrickDataBtStateStatus   1151 /*!< Offset to BtStateStatus (1 byte) */
#define CommOffsetBrickDataBtHwStatus      1152 /*!< Offset to BtHwStatus (1 byte) */
#define CommOffsetBrickDataTimeOutValue    1153 /*!< Offset to data timeout value (1 byte) */
//  BTBUF          BtInBuf; (132 bytes)
#define CommOffsetBtInBufBuf       1157 /*!< Offset to Bluetooth input buffer data (128 bytes) */
#define CommOffsetBtInBufInPtr     1285 /*!< Offset to Bluetooth input buffer front pointer (1 byte) */
#define CommOffsetBtInBufOutPtr    1286 /*!< Offset to Bluetooth output buffer back pointer (1 byte) */
//  BTBUF          BtOutBuf; (132 bytes)
#define CommOffsetBtOutBufBuf      1289 /*!< Offset to Bluetooth output buffer offset data (128 bytes) */
#define CommOffsetBtOutBufInPtr    1417 /*!< Offset to Bluetooth output buffer front pointer (1 byte) */
#define CommOffsetBtOutBufOutPtr   1418 /*!< Offset to Bluetooth output buffer back pointer (1 byte) */
// HI Speed related entries
//  HSBUF          HsInBuf; (132 bytes)
#define CommOffsetHsInBufBuf       1421 /*!< Offset to High Speed input buffer data (128 bytes) */
#define CommOffsetHsInBufInPtr     1549 /*!< Offset to High Speed input buffer front pointer (1 byte) */
#define CommOffsetHsInBufOutPtr    1550 /*!< Offset to High Speed input buffer back pointer (1 byte) */
//  HSBUF          HsOutBuf; (132 bytes)
#define CommOffsetHsOutBufBuf      1553 /*!< Offset to High Speed output buffer data (128 bytes) */
#define CommOffsetHsOutBufInPtr    1681 /*!< Offset to High Speed output buffer front pointer (1 byte) */
#define CommOffsetHsOutBufOutPtr   1682 /*!< Offset to High Speed output buffer back pointer (1 byte) */
// USB related entries
//  USBBUF         UsbInBuf; (68 bytes)
#define CommOffsetUsbInBufBuf        1685 /*!< Offset to Usb input buffer data (64 bytes) */
#define CommOffsetUsbInBufInPtr      1749 /*!< Offset to Usb input buffer front pointer (1 byte) */
#define CommOffsetUsbInBufOutPtr     1750 /*!< Offset to Usb input buffer back pointer (1 byte) */
//  USBBUF         UsbOutBuf; (68 bytes)
#define CommOffsetUsbOutBufBuf       1753 /*!< Offset to Usb output buffer data (64 bytes) */
#define CommOffsetUsbOutBufInPtr     1817 /*!< Offset to Usb output buffer front pointer (1 byte) */
#define CommOffsetUsbOutBufOutPtr    1818 /*!< Offset to Usb output buffer back pointer (1 byte) */
//  USBBUF         UsbPollBuf; (68 bytes)
#define CommOffsetUsbPollBufBuf      1821 /*!< Offset to Usb Poll buffer data (64 bytes) */
#define CommOffsetUsbPollBufInPtr    1885 /*!< Offset to Usb Poll buffer front pointer (1 byte) */
#define CommOffsetUsbPollBufOutPtr   1886 /*!< Offset to Usb Poll buffer back pointer (1 byte) */

#define CommOffsetBtDeviceCnt      1889 /*!< Offset to Bluetooth device count (1 byte) */
#define CommOffsetBtDeviceNameCnt  1890 /*!< Offset to Bluetooth device name count (1 byte) */
#define CommOffsetHsFlags          1891 /*!< Offset to High Speed flags (1 byte) */
#define CommOffsetHsSpeed          1892 /*!< Offset to High Speed speed (1 byte) */
#define CommOffsetHsState          1893 /*!< Offset to High Speed state (1 byte) */
#define CommOffsetUsbState         1894 /*!< Offset to Usb State (1 byte) */
#define CommOffsetHsAddress        1895 /*!< Offset to High Speed address (1 byte) */
#ifdef __ENHANCED_FIRMWARE
#define CommOffsetHsMode           1896 /*!< Offset to High Speed mode (2 bytes) */
#define CommOffsetBtDataMode       1898 /*!< Offset to Bluetooth data mode (1 byte) */
#define CommOffsetHsDataMode       1899 /*!< Offset to High Speed data mode (1 byte) */
#endif
/** @} */  // end of CommIOMAP group

/** @defgroup RCPropertyConstants Property constants
 * Use these constants for specifying the property for the GetProperty
 * and SetProperty direct commands.
 * @{
 */
#define RC_PROP_BTONOFF       0x0  /*!< Set/get whether bluetooth is on or off */
#define RC_PROP_SOUND_LEVEL   0x1  /*!< Set/get the NXT sound level */
#define RC_PROP_SLEEP_TIMEOUT 0x2  /*!< Set/get the NXT sleep timeout value (times 60000) */
#define RC_PROP_DEBUGGING     0xF  /*!< Set/get enhanced firmware debugging information (NBC/NXC) */
/** @} */  // end of RCPropertyConstants group

/** @} */  // end of CommModuleConstants group
/** @} */  // end of CommModule group

#endif // COMM_CONSTANTS_H
