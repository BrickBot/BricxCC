/** \file mindsensors_constants.h
 * \brief The NBC/NXC mindsensors.com constants
 *
 * mindsensors_constants.h contains the NBC/NXC mindsensors.com constants
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

#ifndef MINDSENSORS_CONSTANTS_H
#define MINDSENSORS_CONSTANTS_H

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup MindSensorsAPI
 * @{
 */
/** @defgroup MindSensorsConstants MindSensors device constants
 * Constants that are for use with MindSensors devices.
 * @{
 */
// MindSensors constants
#define MS_CMD_ENERGIZED   0x45 /*!< Energize the MindSensors device */
#define MS_CMD_DEENERGIZED 0x44 /*!< De-energize the MindSensors device */
#define MS_CMD_ADPA_ON     0x4E /*!< Turn MindSensors ADPA mode on */
#define MS_CMD_ADPA_OFF    0x4F /*!< Turn MindSensors ADPA mode off */

#define MS_ADDR_RTCLOCK     0xD0 /*!< MindSensors RTClock I2C address */
#define MS_ADDR_DISTNX      0x02 /*!< MindSensors DIST-Nx I2C address */
#define MS_ADDR_NRLINK      0x02 /*!< MindSensors NRLink I2C address */
#define MS_ADDR_ACCLNX      0x02 /*!< MindSensors ACCL-Nx I2C address */
#define MS_ADDR_CMPSNX      0x02 /*!< MindSensors CMPS-Nx I2C address */
#define MS_ADDR_PSPNX       0x02 /*!< MindSensors PSP-Nx I2C address */
#define MS_ADDR_LINELDR     0x02 /*!< MindSensors LineLdr I2C address */
#define MS_ADDR_NXTCAM      0x02 /*!< MindSensors NXTCam I2C address */
#define MS_ADDR_NXTHID      0x04 /*!< MindSensors NXTHID I2C address */
#define MS_ADDR_NXTSERVO    0xB0 /*!< MindSensors NXTServo I2C address */
#define MS_ADDR_NXTSERVO_EM 0x40 /*!< MindSensors NXTServo in edit macro mode I2C address */
#define MS_ADDR_PFMATE      0x48 /*!< MindSensors PFMate I2C address */
#define MS_ADDR_MTRMUX      0xB4 /*!< MindSensors MTRMux I2C address */
#define MS_ADDR_NXTMMX      0x06 /*!< MindSensors NXTMMX I2C address */
#define MS_ADDR_IVSENS      0x12 /*!< MindSensors IVSens (NXTPowerMeter) I2C address */
#define MS_ADDR_RXMUX       0x7E /*!< MindSensors RXMux I2C address */
#define MS_ADDR_NUMERICPAD  0xB4 /*!< MindSensors NumericPad I2C address */
#define MS_ADDR_TOUCHPANEL  0x04 /*!< MindSensors TouchPanel I2C address */

/** @defgroup MSDistNX MindSensors DIST-Nx constants
 * Constants that are for use with the MindSensors DIST-Nx device.
 * @{
 */
// DIST-Nx Commands
#define DIST_CMD_GP2D12      0x31 /*!< Set the DIST-Nx to GP2D12 mode */
#define DIST_CMD_GP2D120     0x32 /*!< Set the DIST-Nx to GP2D120 mode */
#define DIST_CMD_GP2YA21     0x33 /*!< Set the DIST-Nx to GP2YA21 mode */
#define DIST_CMD_GP2YA02     0x34 /*!< Set the DIST-Nx to GP2YA02 mode */
#define DIST_CMD_CUSTOM      0x35 /*!< Set the DIST-Nx to a custom mode */

// DIST-Nx Registers
#define DIST_REG_DIST          0x42 /*!< The DIST-Nx distance register */
#define DIST_REG_VOLT          0x44 /*!< The DIST-Nx voltage register */
#define DIST_REG_MODULE_TYPE   0x50 /*!< The DIST-Nx module type register */
#define DIST_REG_NUM_POINTS    0x51 /*!< The DIST-Nx number of data points in Custom curve register */
#define DIST_REG_DIST_MIN      0x52 /*!< The DIST-Nx minimum distance register */
#define DIST_REG_DIST_MAX      0x54 /*!< The DIST-Nx maximum distance register */
#define DIST_REG_VOLT1         0x56 /*!< The DIST-Nx voltage 1 register */
#define DIST_REG_DIST1         0x58 /*!< The DIST-Nx distance 1 register */
/** @} */  // end of MSDistNX group

/** @defgroup MSPSPNX MindSensors PSP-Nx constants
 * Constants that are for use with the MindSensors PSP-Nx device.
 * @{
 */
// PSP-Nx commands
#define PSP_CMD_DIGITAL 0x41 /*!< Set the PSP-Nx to digital mode */
#define PSP_CMD_ANALOG  0x73 /*!< Set the PSP-Nx to analog mode */

// PSP-Nx registers
#define PSP_REG_BTNSET1 0x42 /*!< The PSP-Nx button set 1 register */
#define PSP_REG_BTNSET2 0x43 /*!< The PSP-Nx button set 2 register */
#define PSP_REG_XLEFT   0x44 /*!< The PSP-Nx X left register */
#define PSP_REG_YLEFT   0x45 /*!< The PSP-Nx Y left register */
#define PSP_REG_XRIGHT  0x46 /*!< The PSP-Nx X right register */
#define PSP_REG_YRIGHT  0x47 /*!< The PSP-Nx Y right register */

/** @defgroup MSPSPNXBtnSet1 MindSensors PSP-Nx button set 1 constants
 * Constants that are for interpretting MindSensors PSP-Nx button set 1 values.
 * @{
 */
#define PSP_BTNSET1_LEFT     0x80 /*!< The PSP-Nx button set 1 left arrow */
#define PSP_BTNSET1_DOWN     0x40 /*!< The PSP-Nx button set 1 down arrow */
#define PSP_BTNSET1_RIGHT    0x20 /*!< The PSP-Nx button set 1 right arrow */
#define PSP_BTNSET1_UP       0x10 /*!< The PSP-Nx button set 1 up arrow */
#define PSP_BTNSET1_START    0x08 /*!< The PSP-Nx button set 1 start */
#define PSP_BTNSET1_R3       0x04 /*!< The PSP-Nx button set 1 R3 */
#define PSP_BTNSET1_L3       0x02 /*!< The PSP-Nx button set 1 L3 */
#define PSP_BTNSET1_SELECT   0x01 /*!< The PSP-Nx button set 1 select */
/** @} */  // end of MSPSPNXBtnSet1 group

/** @defgroup MSPSPNXBtnSet2 MindSensors PSP-Nx button set 2 constants
 * Constants that are for interpretting MindSensors PSP-Nx button set 2 values.
 * @{
 */
#define PSP_BTNSET2_SQUARE   0x80 /*!< The PSP-Nx button set 2 square */
#define PSP_BTNSET2_CROSS    0x40 /*!< The PSP-Nx button set 2 cross */
#define PSP_BTNSET2_CIRCLE   0x20 /*!< The PSP-Nx button set 2 circle */
#define PSP_BTNSET2_TRIANGLE 0x10 /*!< The PSP-Nx button set 2 triangle */
#define PSP_BTNSET2_R1       0x08 /*!< The PSP-Nx button set 2 R1 */
#define PSP_BTNSET2_L1       0x04 /*!< The PSP-Nx button set 2 L1 */
#define PSP_BTNSET2_R2       0x02 /*!< The PSP-Nx button set 2 R2 */
#define PSP_BTNSET2_L2       0x01 /*!< The PSP-Nx button set 2 L2 */
/** @} */  // end of MSPSPNXBtnSet2 group
/** @} */  // end of MSPSPNX group

/** @defgroup MSNRLink MindSensors nRLink constants
 * Constants that are for use with the MindSensors nRLink device.
 * @{
 */
// NRLink commands
#define NRLINK_CMD_2400      0x44 /*!< Set NRLink to 2400 baud */
#define NRLINK_CMD_FLUSH     0x46 /*!< Flush the NRLink */
#define NRLINK_CMD_4800      0x48 /*!< Set NRLink to 4800 baud */
#define NRLINK_CMD_IR_LONG   0x4C /*!< Set the NRLink to long range IR */
#define NRLINK_CMD_IR_SHORT  0x53 /*!< Set the NRLink to short range IR */
#define NRLINK_CMD_RUN_MACRO 0x52 /*!< Run an NRLink macro */
#define NRLINK_CMD_TX_RAW    0x55 /*!< Set the NRLink to transmit raw bytes */
#define NRLINK_CMD_SET_RCX   0x58 /*!< Set the NRLink to RCX mode */
#define NRLINK_CMD_SET_TRAIN 0x54 /*!< Set the NRLink to IR Train mode */
#define NRLINK_CMD_SET_PF    0x50 /*!< Set the NRLink to Power Function mode */

// NRLink registers
#define NRLINK_REG_BYTES  0x40 /*!< The NRLink bytes register */
#define NRLINK_REG_DATA   0x42 /*!< The NRLink data register */
#define NRLINK_REG_EEPROM 0x50 /*!< The NRLink eeprom register */

/** @} */  // end of MSNRLink group

/** @defgroup MSACCLNx MindSensors ACCL-Nx constants
 * Constants that are for use with the MindSensors ACCL-Nx device.
 * @{
 */
// ACCL-Nx commands
#define ACCL_CMD_X_CAL      0x58 /*!< Acquire X-axis calibration point */
#define ACCL_CMD_Y_CAL      0x59 /*!< Acquire Y-axis calibration point */
#define ACCL_CMD_Z_CAL      0x5a /*!< Acquire Z-axis calibration point */
#define ACCL_CMD_X_CAL_END  0x78 /*!< Acquire X-axis calibration point and end calibration */
#define ACCL_CMD_Y_CAL_END  0x79 /*!< Acquire Y-axis calibration point and end calibration */
#define ACCL_CMD_Z_CAL_END  0x7a /*!< Acquire Z-axis calibration point and end calibration */
#define ACCL_CMD_RESET_CAL  0x52 /*!< Reset to factory calibration */

// ACCL-Nx registers
#define ACCL_REG_SENS_LVL 0x19 /*!< The current sensitivity */
#define ACCL_REG_X_TILT   0x42 /*!< The X-axis tilt data */
#define ACCL_REG_Y_TILT   0x43 /*!< The Y-axis tilt data */
#define ACCL_REG_Z_TILT   0x44 /*!< The Z-axis tilt data */
#define ACCL_REG_X_ACCEL  0x45 /*!< The X-axis acceleration data */
#define ACCL_REG_Y_ACCEL  0x47 /*!< The Y-axis acceleration data */
#define ACCL_REG_Z_ACCEL  0x49 /*!< The Z-axis acceleration data */
#define ACCL_REG_X_OFFSET 0x4b /*!< The X-axis offset */
#define ACCL_REG_X_RANGE  0x4d /*!< The X-axis range */
#define ACCL_REG_Y_OFFSET 0x4f /*!< The Y-axis offset */
#define ACCL_REG_Y_RANGE  0x51 /*!< The Y-axis range */
#define ACCL_REG_Z_OFFSET 0x53 /*!< The Z-axis offset */
#define ACCL_REG_Z_RANGE  0x55 /*!< The Z-axis range */

/** @defgroup MSACCLNxSLevel MindSensors ACCL-Nx sensitivity level constants
 * Constants that are for setting the MindSensors ACCL-Nx sensitivity level.
 * @{
 */
#define ACCL_SENSITIVITY_LEVEL_1 0x31 /*!< The ACCL-Nx sensitivity level 1 */
#define ACCL_SENSITIVITY_LEVEL_2 0x32 /*!< The ACCL-Nx sensitivity level 2 */
#define ACCL_SENSITIVITY_LEVEL_3 0x33 /*!< The ACCL-Nx sensitivity level 3 */
#define ACCL_SENSITIVITY_LEVEL_4 0x34 /*!< The ACCL-Nx sensitivity level 4 */
/** @} */  // end of MSACCLNxSLevel group

/** @} */  // end of MSACCLNx group

/** @defgroup PFMateConstants MindSensors PFMate constants
 * Constants that are for use with the MindSensors PFMate device.
 * @{
 */
#define PFMATE_REG_CMD     0x41 /*!< PFMate command */
#define PFMATE_REG_CHANNEL 0x42 /*!< PF channel? 1, 2, 3, or 4 */
#define PFMATE_REG_MOTORS  0x43 /*!< PF motors? (0 = both, 1 = A, 2 = B) */
#define PFMATE_REG_A_CMD   0x44 /*!< PF command for motor A? (PF_CMD_FLOAT, PF_CMD_FWD, PF_CMD_REV, PF_CMD_BRAKE) */
#define PFMATE_REG_A_SPEED 0x45 /*!< PF speed for motor A? (0-7) */
#define PFMATE_REG_B_CMD   0x46 /*!< PF command for motor B? (PF_CMD_FLOAT, PF_CMD_FWD, PF_CMD_REV, PF_CMD_BRAKE) */
#define PFMATE_REG_B_SPEED 0x47 /*!< PF speed for motor B? (0-7) */

#define PFMATE_CMD_GO      0x47 /*!< Send IR signal to IR receiver */
#define PFMATE_CMD_RAW     0x52 /*!< Send raw IR signal to IR receiver */

/** @defgroup PFMateMotorConstants PFMate motor constants
 * Constants that are for specifying PFMate motors.
 * @{
 */
#define PFMATE_MOTORS_BOTH 0x00 /*!< Control both motors */
#define PFMATE_MOTORS_A    0x01 /*!< Control only motor A */
#define PFMATE_MOTORS_B    0x02 /*!< Control only motor B */
/** @} */  // end of PFMateMotorConstants group

/** @defgroup PFMateChannelConstants PFMate channel constants
 * Constants that are for specifying PFMate channels.
 * @{
 */
#define PFMATE_CHANNEL_1 1 /*!< Power function channel 1 */
#define PFMATE_CHANNEL_2 2 /*!< Power function channel 2 */
#define PFMATE_CHANNEL_3 3 /*!< Power function channel 3 */
#define PFMATE_CHANNEL_4 4 /*!< Power function channel 4 */
/** @} */  // end of PFMateChannelConstants group

/** @} */  // end of PFMateConstants group

/** @defgroup NXTServoConstants MindSensors NXTServo constants
 * Constants that are for use with the MindSensors NXTServo device.
 * @{
 */
/** @defgroup NXTServoRegisters MindSensors NXTServo registers
 * NXTServo device register constants.
 * @{
 */
#define NXTSERVO_REG_VOLTAGE   0x41 /*!< Battery voltage register. (read only) */
#define NXTSERVO_REG_CMD       0x41 /*!< NXTServo command register.  See \ref NXTServoCommands group. (write only) */
// position registers (2 bytes little endian)
#define NXTSERVO_REG_S1_POS    0x42 /*!< NXTServo servo 1 position register. */
#define NXTSERVO_REG_S2_POS    0x44 /*!< NXTServo servo 2 position register. */
#define NXTSERVO_REG_S3_POS    0x46 /*!< NXTServo servo 3 position register. */
#define NXTSERVO_REG_S4_POS    0x48 /*!< NXTServo servo 4 position register. */
#define NXTSERVO_REG_S5_POS    0x4A /*!< NXTServo servo 5 position register. */
#define NXTSERVO_REG_S6_POS    0x4C /*!< NXTServo servo 6 position register. */
#define NXTSERVO_REG_S7_POS    0x4E /*!< NXTServo servo 7 position register. */
#define NXTSERVO_REG_S8_POS    0x50 /*!< NXTServo servo 8 position register. */
// speed registers
#define NXTSERVO_REG_S1_SPEED  0x52 /*!< NXTServo servo 1 speed register. */
#define NXTSERVO_REG_S2_SPEED  0x53 /*!< NXTServo servo 2 speed register. */
#define NXTSERVO_REG_S3_SPEED  0x54 /*!< NXTServo servo 3 speed register. */
#define NXTSERVO_REG_S4_SPEED  0x55 /*!< NXTServo servo 4 speed register. */
#define NXTSERVO_REG_S5_SPEED  0x56 /*!< NXTServo servo 5 speed register. */
#define NXTSERVO_REG_S6_SPEED  0x57 /*!< NXTServo servo 6 speed register. */
#define NXTSERVO_REG_S7_SPEED  0x58 /*!< NXTServo servo 7 speed register. */
#define NXTSERVO_REG_S8_SPEED  0x59 /*!< NXTServo servo 8 speed register. */
// quick position registers
#define NXTSERVO_REG_S1_QPOS   0x5A /*!< NXTServo servo 1 quick position register. (write only) */
#define NXTSERVO_REG_S2_QPOS   0x5B /*!< NXTServo servo 2 quick position register. (write only) */
#define NXTSERVO_REG_S3_QPOS   0x5C /*!< NXTServo servo 3 quick position register. (write only) */
#define NXTSERVO_REG_S4_QPOS   0x5D /*!< NXTServo servo 4 quick position register. (write only) */
#define NXTSERVO_REG_S5_QPOS   0x5E /*!< NXTServo servo 5 quick position register. (write only) */
#define NXTSERVO_REG_S6_QPOS   0x5F /*!< NXTServo servo 6 quick position register. (write only) */
#define NXTSERVO_REG_S7_QPOS   0x60 /*!< NXTServo servo 7 quick position register. (write only) */
#define NXTSERVO_REG_S8_QPOS   0x61 /*!< NXTServo servo 8 quick position register. (write only) */

#define NXTSERVO_EM_REG_CMD          0x00 /*!< NXTServo in macro edit mode command register. */
#define NXTSERVO_EM_REG_EEPROM_START 0x21 /*!< NXTServo in macro edit mode EEPROM start register. */
#define NXTSERVO_EM_REG_EEPROM_END   0xFF /*!< NXTServo in macro edit mode EEPROM end register. */
/** @} */  // end of NXTServoRegisters group

/** @defgroup NXTServoPos MindSensors NXTServo position constants
 * NXTServo device position constants.
 * @{
 */
#define NXTSERVO_POS_CENTER 1500 /*!< Center position for 1500us servos. */
#define NXTSERVO_POS_MIN     500 /*!< Minimum position for 1500us servos. */
#define NXTSERVO_POS_MAX    2500 /*!< Maximum position for 1500us servos. */
/** @} */  // end of NXTServoPos group

/** @defgroup NXTServoQPos MindSensors NXTServo quick position constants
 * NXTServo device quick position constants.
 * @{
 */
#define NXTSERVO_QPOS_CENTER 150 /*!< Center quick position for 1500us servos. */
#define NXTSERVO_QPOS_MIN     50 /*!< Minimum quick position for 1500us servos. */
#define NXTSERVO_QPOS_MAX    250 /*!< Maximum quick position for 1500us servos. */
/** @} */  // end of NXTServoQPos group

/** @defgroup NXTServoNumbers MindSensors NXTServo servo numbers
 * NXTServo device servo number constants.
 * @{
 */
#define NXTSERVO_SERVO_1 0 /*!< NXTServo server number 1. */
#define NXTSERVO_SERVO_2 1 /*!< NXTServo server number 2. */
#define NXTSERVO_SERVO_3 2 /*!< NXTServo server number 3. */
#define NXTSERVO_SERVO_4 3 /*!< NXTServo server number 4. */
#define NXTSERVO_SERVO_5 4 /*!< NXTServo server number 5. */
#define NXTSERVO_SERVO_6 5 /*!< NXTServo server number 6. */
#define NXTSERVO_SERVO_7 6 /*!< NXTServo server number 7. */
#define NXTSERVO_SERVO_8 7 /*!< NXTServo server number 8. */
/** @} */  // end of NXTServoNumbers group

/** @defgroup NXTServoCommands MindSensors NXTServo commands
 * NXTServo device command constants. These are written to the command register
 * to control the device.
 * @{
 */
#define NXTSERVO_CMD_INIT    0x49 /*!< Store the initial speed and position properties of the servo motor 'n'. Current speed and position values of the nth servo is read from the servo speed register and servo position register and written to permanent memory. */
#define NXTSERVO_CMD_RESET   0x53 /*!< Reset servo properties to factory default.  Initial Position of servos to 1500, and speed to 0. */
#define NXTSERVO_CMD_HALT    0x48 /*!< Halt Macro. This command re-initializes the macro environment. */
#define NXTSERVO_CMD_RESUME  0x52 /*!< Resume macro Execution. This command resumes macro where it was paused last, using the same environment. */
#define NXTSERVO_CMD_GOTO    0x47 /*!< Goto EEPROM position x. This command re-initializes the macro environment. */
#define NXTSERVO_CMD_PAUSE   0x50 /*!< Pause Macro. This command will pause the macro, and save the environment for subsequent resumption. */
#define NXTSERVO_CMD_EDIT1   0x45 /*!< Edit Macro (part 1 of 2 character command sequence) */
#define NXTSERVO_CMD_EDIT2   0x4D /*!< Edit Macro (part 2 of 2 character command sequence) */
#define NXTSERVO_EM_CMD_QUIT 0x51 /*!< Exit edit macro mode */
/** @} */  // end of NXTServoCommands group
/** @} */  // end of NXTServoConstants group

/** @defgroup NXTHIDConstants MindSensors NXTHID constants
 * Constants that are for use with the MindSensors NXTHID device.
 * @{
 */
/** @defgroup NXTHIDRegisters MindSensors NXTHID registers
 * NXTHID device register constants.
 * @{
 */
#define NXTHID_REG_CMD       0x41 /*!< NXTHID command register.  See \ref NXTHIDCommands group. */
#define NXTHID_REG_MODIFIER  0x42 /*!< NXTHID modifier register.  See \ref NXTHIDModifiers group. */
#define NXTHID_REG_DATA      0x43 /*!< NXTHID data register. */
/** @} */  // end of NXTHIDRegisters group

/** @defgroup NXTHIDModifiers MindSensors NXTHID modifier keys
 * NXTHID device modifier key constants.
 * @{
 */
#define NXTHID_MOD_NONE        0x00 /*!< NXTHID no modifier. */
#define NXTHID_MOD_LEFT_CTRL   0x01 /*!< NXTHID left control modifier. */
#define NXTHID_MOD_LEFT_SHIFT  0x02 /*!< NXTHID left shift modifier. */
#define NXTHID_MOD_LEFT_ALT    0x04 /*!< NXTHID left alt modifier. */
#define NXTHID_MOD_LEFT_GUI    0x08 /*!< NXTHID left gui modifier. */
#define NXTHID_MOD_RIGHT_CTRL  0x10 /*!< NXTHID right control modifier. */
#define NXTHID_MOD_RIGHT_SHIFT 0x20 /*!< NXTHID right shift modifier. */
#define NXTHID_MOD_RIGHT_ALT   0x40 /*!< NXTHID right alt modifier. */
#define NXTHID_MOD_RIGHT_GUI   0x80 /*!< NXTHID right gui modifier. */
/** @} */  // end of NXTHIDModifiers group

/** @defgroup NXTHIDCommands MindSensors NXTHID commands
 * NXTHID device command constants. These are written to the command register
 * to control the device.
 * @{
 */
#define NXTHID_CMD_ASCII    0x41 /*!< Use ASCII data mode. In ASCII mode no non-printable characters can be sent. */
#define NXTHID_CMD_DIRECT   0x44 /*!< Use direct data mode In direct mode any character can be sent. */
#define NXTHID_CMD_TRANSMIT 0x54 /*!< Transmit data to the host computer. */
/** @} */  // end of NXTHIDCommands group
/** @} */  // end of NXTHIDConstants group

/** @defgroup NXTPowerMeterConstants MindSensors NXTPowerMeter constants
 * Constants that are for use with the MindSensors NXTPowerMeter device.
 * @{
 */
/** @defgroup NXTPowerMeterRegisters MindSensors NXTPowerMeter registers
 * NXTPowerMeter device register constants.
 * @{
 */
#define NXTPM_REG_CMD        0x41 /*!< NXTPowerMeter command register.  See the \ref NXTPowerMeterCommands group. */
#define NXTPM_REG_CURRENT    0x42 /*!< NXTPowerMeter present current in mA register. (2 bytes) */
#define NXTPM_REG_VOLTAGE    0x44 /*!< NXTPowerMeter present voltage in mV register. (2 bytes) */
#define NXTPM_REG_CAPACITY   0x46 /*!< NXTPowerMeter capacity used since last reset register. (2 bytes) */
#define NXTPM_REG_POWER      0x48 /*!< NXTPowerMeter present power register. (2 bytes) */
#define NXTPM_REG_TOTALPOWER 0x4A /*!< NXTPowerMeter total power consumed since last reset register. (4 bytes) */
#define NXTPM_REG_MAXCURRENT 0x4E /*!< NXTPowerMeter max current register. (2 bytes) */
#define NXTPM_REG_MINCURRENT 0x50 /*!< NXTPowerMeter min current register. (2 bytes) */
#define NXTPM_REG_MAXVOLTAGE 0x52 /*!< NXTPowerMeter max voltage register. (2 bytes) */
#define NXTPM_REG_MINVOLTAGE 0x54 /*!< NXTPowerMeter min voltage register. (2 bytes) */
#define NXTPM_REG_TIME       0x56 /*!< NXTPowerMeter time register. (4 bytes) */
#define NXTPM_REG_USERGAIN   0x5A /*!< NXTPowerMeter user gain register. Not yet implemented. (4 bytes) */
#define NXTPM_REG_GAIN       0x5E /*!< NXTPowerMeter gain register. (1 byte) */
#define NXTPM_REG_ERRORCOUNT 0x5F /*!< NXTPowerMeter error count register. (2 bytes) */
/** @} */  // end of NXTPowerMeterRegisters group

/** @defgroup NXTPowerMeterCommands MindSensors NXTPowerMeter commands
 * NXTPowerMeter device command constants. These are written to the command register
 * to control the device.
 * @{
 */
#define NXTPM_CMD_RESET    0x52 /*!< Reset counters. */
/** @} */  // end of NXTPowerMeterCommands group
/** @} */  // end of NXTPowerMeterConstants group

/** @defgroup NXTSumoEyesConstants MindSensors NXTSumoEyes constants
 * Constants that are for use with the MindSensors NXTSumoEyes device.
 * @{
 */
#define NXTSE_ZONE_NONE  0 /*!< Obstacle zone none. */
#define NXTSE_ZONE_FRONT 1 /*!< Obstacle zone front. */
#define NXTSE_ZONE_LEFT  2 /*!< Obstacle zone left. */
#define NXTSE_ZONE_RIGHT 3 /*!< Obstacle zone right. */
/** @} */  // end of NXTSumoEyesConstants group

/** @defgroup NXTLineLeaderConstants MindSensors NXTLineLeader constants
 * Constants that are for use with the MindSensors NXTLineLeader device.
 * @{
 */
/** @defgroup NXTLineLeaderRegisters MindSensors NXTLineLeader registers
 * NXTLineLeader device register constants.
 * @{
 */
#define NXTLL_REG_CMD         0x41 /*!< NXTLineLeader command register.  See the \ref NXTLineLeaderCommands group. */
#define NXTLL_REG_STEERING    0x42 /*!< NXTLineLeader steering register. */
#define NXTLL_REG_AVERAGE     0x43 /*!< NXTLineLeader average result register. */
#define NXTLL_REG_RESULT      0x44 /*!< NXTLineLeader result register (sensor bit values). */
#define NXTLL_REG_SETPOINT    0x45 /*!< NXTLineLeader user settable average (setpoint) register. Default = 45. */
#define NXTLL_REG_KP_VALUE    0x46 /*!< NXTLineLeader Kp value register. Default = 25. */
#define NXTLL_REG_KI_VALUE    0x47 /*!< NXTLineLeader Ki value register. Default = 0. */
#define NXTLL_REG_KD_VALUE    0x48 /*!< NXTLineLeader Kd value register. Default = 8. */
#define NXTLL_REG_CALIBRATED  0x49 /*!< NXTLineLeader calibrated sensor reading registers. 8 bytes. */
#define NXTLL_REG_WHITELIMITS 0x51 /*!< NXTLineLeader white limit registers. 8 bytes. */
#define NXTLL_REG_BLACKLIMITS 0x59 /*!< NXTLineLeader black limit registers. 8 bytes. */
#define NXTLL_REG_KP_FACTOR   0x61 /*!< NXTLineLeader Kp factor register. Default = 32. */
#define NXTLL_REG_KI_FACTOR   0x62 /*!< NXTLineLeader Ki factor register. Default = 32. */
#define NXTLL_REG_KD_FACTOR   0x63 /*!< NXTLineLeader Kd factor register. Default = 32. */
#define NXTLL_REG_WHITEDATA   0x64 /*!< NXTLineLeader white calibration data registers. 8 bytes. */
#define NXTLL_REG_BLACKDATA   0x6C /*!< NXTLineLeader black calibration data registers. 8 bytes. */
#define NXTLL_REG_RAWVOLTAGE  0x74 /*!< NXTLineLeader uncalibrated sensor voltage registers. 16 bytes. */
/** @} */  // end of NXTLineLeaderRegisters group

/** @defgroup NXTLineLeaderCommands MindSensors NXTLineLeader commands
 * NXTLineLeader device command constants. These are written to the command register
 * to control the device.
 * @{
 */
#define NXTLL_CMD_USA       0x41 /*!< USA power frequency. (60hz) */
#define NXTLL_CMD_BLACK     0x42 /*!< Black calibration. */
#define NXTLL_CMD_POWERDOWN 0x44 /*!< Power down the device. */
#define NXTLL_CMD_EUROPEAN  0x45 /*!< European power frequency. (50hz) */
#define NXTLL_CMD_INVERT    0x49 /*!< Invert color. */
#define NXTLL_CMD_POWERUP   0x50 /*!< Power up the device. */
#define NXTLL_CMD_RESET     0x52 /*!< Reset inversion. */
#define NXTLL_CMD_SNAPSHOT  0x53 /*!< Setpoint based on snapshot (automatically sets invert if needed). */
#define NXTLL_CMD_UNIVERSAL 0x55 /*!< Universal power frequency. The sensor auto adjusts for any frequency. This is the default mode. */
#define NXTLL_CMD_WHITE     0x57 /*!< White balance calibration. */
/** @} */  // end of NXTLineLeaderCommands group
/** @} */  // end of NXTLineLeaderConstants group

/** @defgroup NXTNumericPadConstants MindSensors NXTNumericPad constants
 * Constants that are for use with the MindSensors NXTNumericPad device.
 * @{
 */
/** @defgroup NXTNumericPadRegisters MindSensors NXTNumericPad registers
 * NXTNumericPad device register constants.
 * @{
 */
#define NXTNP_REG_BUTTONS  0x00 /*!< NXTNumericPad buttons register. */
/** @} */  // end of NXTNumericPadRegisters group
/** @} */  // end of NXTNumericPadConstants group

/** @defgroup NXTTouchPanelConstants MindSensors NXTTouchPanel constants
 * Constants that are for use with the MindSensors NXTTouchPanel device.
 * @{
 */
/** @defgroup NXTTouchPanelRegisters MindSensors NXTTouchPanel registers
 * NXTTouchPanel device register constants.
 * @{
 */
#define NXTTP_REG_CMD         0x41 /*!< NXTTouchPanel command register.  See the \ref NXTTouchPanelCommands group. */
/** @} */  // end of NXTTouchPanelRegisters group

/** @defgroup NXTTouchPanelCommands MindSensors NXTTouchPanel commands
 * NXTTouchPanel device command constants. These are written to the command register
 * to control the device.
 * @{
 */
#define NXTTP_CMD_USA       0x41 /*!< USA power frequency. (60hz) */
/** @} */  // end of NXTTouchPanelCommands group
/** @} */  // end of NXTTouchPanelConstants group

/** @} */  // end of MindSensorsConstants group
/** @} */  // end of MindSensorsAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // MINDSENSORS_CONSTANTS_H
