/** \file hitechnic_constants.h
 * \brief The NBC/NXC HiTechnic constants
 *
 * hitechnic_constants.h contains the NBC/NXC HiTechnic constants
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

#ifndef HITECHNIC_CONSTANTS_H
#define HITECHNIC_CONSTANTS_H

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @addtogroup HiTechnicAPI
 * @{
 */
/** @defgroup HiTechnicConstants HiTechnic device constants
 * Constants that are for use with HiTechnic devices.
 * @{
 */

#define HT_ADDR_IRSEEKER   0x02 /*!< HiTechnic IRSeeker I2C address */
#define HT_ADDR_IRSEEKER2  0x10 /*!< HiTechnic IRSeeker2 I2C address */
#define HT_ADDR_IRRECEIVER 0x02 /*!< HiTechnic IRReceiver I2C address */
#define HT_ADDR_COMPASS    0x02 /*!< HiTechnic Compass I2C address */
#define HT_ADDR_ACCEL      0x02 /*!< HiTechnic Accel I2C address */
#define HT_ADDR_COLOR      0x02 /*!< HiTechnic Color I2C address */
#define HT_ADDR_COLOR2     0x02 /*!< HiTechnic Color2 I2C address */
#define HT_ADDR_IRLINK     0x02 /*!< HiTechnic IRLink I2C address */
#define HT_ADDR_ANGLE      0x02 /*!< HiTechnic Angle I2C address */
#define HT_ADDR_BAROMETRIC 0x02 /*!< HiTechnic Barometric I2C address */
#define HT_ADDR_PROTOBOARD 0x02 /*!< HiTechnic Prototype board I2C address */
#define HT_ADDR_SUPERPRO   0x10 /*!< HiTechnic SuperPro board I2C address */
#define HT_ADDR_PIR        0x02 /*!< HiTechnic PIR (Passive Infrared) I2C address */

/** @defgroup HTIRSeeker2Constants HiTechnic IRSeeker2 constants
 * Constants that are for use with the HiTechnic IRSeeker2 device.
 * @{
 */
#define HTIR2_MODE_1200 0 /*!< Set IRSeeker2 to 1200 mode */
#define HTIR2_MODE_600  1 /*!< Set IRSeeker2 to 600 mode */

#define HTIR2_REG_MODE  0x41 /*!< IRSeeker2 mode register */
#define HTIR2_REG_DCDIR 0x42 /*!< IRSeeker2 DC direction register */
#define HTIR2_REG_DC01  0x43 /*!< IRSeeker2 DC 01 register */
#define HTIR2_REG_DC02  0x44 /*!< IRSeeker2 DC 02 register */
#define HTIR2_REG_DC03  0x45 /*!< IRSeeker2 DC 03 register */
#define HTIR2_REG_DC04  0x46 /*!< IRSeeker2 DC 04 register */
#define HTIR2_REG_DC05  0x47 /*!< IRSeeker2 DC 05 register */
#define HTIR2_REG_DCAVG 0x48 /*!< IRSeeker2 DC average register */
#define HTIR2_REG_ACDIR 0x49 /*!< IRSeeker2 AC direction register */
#define HTIR2_REG_AC01  0x4A /*!< IRSeeker2 AC 01 register */
#define HTIR2_REG_AC02  0x4B /*!< IRSeeker2 AC 02 register */
#define HTIR2_REG_AC03  0x4C /*!< IRSeeker2 AC 03 register */
#define HTIR2_REG_AC04  0x4D /*!< IRSeeker2 AC 04 register */
#define HTIR2_REG_AC05  0x4E /*!< IRSeeker2 AC 05 register */
/** @} */  // end of HTIRSeeker2Constants group

/** @defgroup HTIRReceiverConstants HiTechnic IRReceiver constants
 * Constants that are for use with the HiTechnic IRReceiver device.
 * @{
 */
#define HT_CH1_A 0 /*!< Use IRReceiver channel 1 output A */
#define HT_CH1_B 1 /*!< Use IRReceiver channel 1 output B */
#define HT_CH2_A 2 /*!< Use IRReceiver channel 2 output A */
#define HT_CH2_B 3 /*!< Use IRReceiver channel 2 output B */
#define HT_CH3_A 4 /*!< Use IRReceiver channel 3 output A */
#define HT_CH3_B 5 /*!< Use IRReceiver channel 3 output B */
#define HT_CH4_A 6 /*!< Use IRReceiver channel 4 output A */
#define HT_CH4_B 7 /*!< Use IRReceiver channel 4 output B */
/** @} */  // end of HTIRSeeker2Constants group

/** @defgroup HTColor2Constants HiTechnic Color2 constants
 * Constants that are for use with the HiTechnic Color2 device.
 * @{
 */
#define HT_CMD_COLOR2_ACTIVE  0x00 /*!< Set the Color2 sensor to active mode */
#define HT_CMD_COLOR2_PASSIVE 0x01 /*!< Set the Color2 sensor to passive mode */
#define HT_CMD_COLOR2_RAW     0x03 /*!< Set the Color2 sensor to raw mode */
#define HT_CMD_COLOR2_50HZ    0x35 /*!< Set the Color2 sensor to 50Hz mode */
#define HT_CMD_COLOR2_60HZ    0x36 /*!< Set the Color2 sensor to 60Hz mode */
#define HT_CMD_COLOR2_BLCAL   0x42 /*!< Set the Color2 sensor to black level calibration mode */
#define HT_CMD_COLOR2_WBCAL   0x43 /*!< Set the Color2 sensor to white level calibration mode */
#define HT_CMD_COLOR2_FAR     0x46 /*!< Set the Color2 sensor to far mode */
#define HT_CMD_COLOR2_LED_HI  0x48 /*!< Set the Color2 sensor to LED high mode */
#define HT_CMD_COLOR2_LED_LOW 0x4C /*!< Set the Color2 sensor to LED low mode */
#define HT_CMD_COLOR2_NEAR    0x4E /*!< Set the Color2 sensor to near mode */
/** @} */  // end of HTColor2Constants group

/** @defgroup HTAngleConstants HiTechnic Angle sensor constants
 * Constants that are for use with the HiTechnic Angle sensor device.
 * @{
 */
#define HTANGLE_MODE_NORMAL    0x00 /*!< Normal angle measurement mode */
#define HTANGLE_MODE_CALIBRATE 0x43 /*!< Resets 0 degree position to current shaft angle */
#define HTANGLE_MODE_RESET     0x52 /*!< Resets the accumulated angle */

#define HTANGLE_REG_MODE  0x41 /*!< Angle mode register */
#define HTANGLE_REG_DCDIR 0x42 /*!< Angle current angle (2 degree increments) register */
#define HTANGLE_REG_DC01  0x43 /*!< Angle current angle (1 degree adder) register */
#define HTANGLE_REG_DC02  0x44 /*!< Angle 32 bit accumulated angle, high byte register */
#define HTANGLE_REG_DC03  0x45 /*!< Angle 32 bit accumulated angle, mid byte register */
#define HTANGLE_REG_DC04  0x46 /*!< Angle 32 bit accumulated angle, mid byte register */
#define HTANGLE_REG_DC05  0x47 /*!< Angle 32 bit accumulated angle, low byte register */
#define HTANGLE_REG_DCAVG 0x48 /*!< Angle 16 bit revolutions per minute, high byte register */
#define HTANGLE_REG_ACDIR 0x49 /*!< Angle 16 bit revolutions per minute, low byte register */
/** @} */  // end of HTAngleConstants group

/** @defgroup HTBarometricConstants HiTechnic Barometric sensor constants
 * Constants that are for use with the HiTechnic Barometric sensor device.
 * @{
 */
#define HTBAR_REG_COMMAND     0x40 /*!< Barometric sensor command register */
#define HTBAR_REG_TEMPERATURE 0x42 /*!< Barometric sensor temperature register (2 bytes msb/lsb) */
#define HTBAR_REG_PRESSURE    0x44 /*!< Barometric sensor pressure register (2 bytes msb/lsb) */
#define HTBAR_REG_CALIBRATION 0x46 /*!< Barometric sensor calibration register (2 bytes msb/lsb) */
/** @} */  // end of HTBarometricConstants group

/** @defgroup HTProtoConstants HiTechnic Prototype board constants
 * Constants that are for use with the HiTechnic Prototype board.
 * @{
 */
#define HTPROTO_REG_A0    0x42 /*!< Prototype board analog 0 register (2 bytes msb/lsb) */
#define HTPROTO_REG_A1    0x44 /*!< Prototype board analog 1 register (2 bytes msb/lsb) */
#define HTPROTO_REG_A2    0x46 /*!< Prototype board analog 2 register (2 bytes msb/lsb) */
#define HTPROTO_REG_A3    0x48 /*!< Prototype board analog 3 register (2 bytes msb/lsb) */
#define HTPROTO_REG_A4    0x4A /*!< Prototype board analog 4 register (2 bytes msb/lsb) */
#define HTPROTO_REG_DIN   0x4C /*!< Prototype board digital pin input register (6 bits) */
#define HTPROTO_REG_DOUT  0x4D /*!< Prototype board digital pin output register (6 bits) */
#define HTPROTO_REG_DCTRL 0x4E /*!< Prototype board digital pin control register (6 bits) */
#define HTPROTO_REG_SRATE 0x4F /*!< Prototype board sample rate register */

/** @defgroup HTProtoAnalogInputConstants HiTechnic Prototype board analog input constants
 * Constants that are for use with reading the HiTechnic Prototype board analog input values.
 * @{
 */
#define HTPROTO_A0 0x42 /*!< Read Prototype board analog input 0 */
#define HTPROTO_A1 0x44 /*!< Read Prototype board analog input 1 */
#define HTPROTO_A2 0x46 /*!< Read Prototype board analog input 2 */
#define HTPROTO_A3 0x48 /*!< Read Prototype board analog input 3 */
#define HTPROTO_A4 0x4A /*!< Read Prototype board analog input 4 */
/** @} */  // end of HTProtoAnalogInputConstants group
/** @} */  // end of HTProtoConstants group

/** @defgroup HTSuperProConstants HiTechnic SuperPro constants
 * Constants that are for use with the HiTechnic SuperPro board.
 * @{
 */

#define HTSPRO_REG_CTRL         0x40 /*!< SuperPro program control register */
#define HTSPRO_REG_A0           0x42 /*!< SuperPro analog 0 register (10 bits) */
#define HTSPRO_REG_A1           0x44 /*!< SuperPro analog 1 register (10 bits) */
#define HTSPRO_REG_A2           0x46 /*!< SuperPro analog 2 register (10 bits) */
#define HTSPRO_REG_A3           0x48 /*!< SuperPro analog 3 register (10 bits) */
#define HTSPRO_REG_DIN          0x4C /*!< SuperPro digital pin input register (8 bits) */
#define HTSPRO_REG_DOUT         0x4D /*!< SuperPro digital pin output register (8 bits) */
#define HTSPRO_REG_DCTRL        0x4E /*!< SuperPro digital pin control register (8 bits) */
#define HTSPRO_REG_STROBE       0x50 /*!< SuperPro strobe control register */
#define HTSPRO_REG_LED          0x51 /*!< SuperPro LED control register */
#define HTSPRO_REG_DAC0_MODE    0x52 /*!< SuperPro analog output 0 mode register */
#define HTSPRO_REG_DAC0_FREQ    0x53 /*!< SuperPro analog output 0 frequency register (2 bytes msb/lsb) */
#define HTSPRO_REG_DAC0_VOLTAGE 0x55 /*!< SuperPro analog output 0 voltage register (10 bits) */
#define HTSPRO_REG_DAC1_MODE    0x57 /*!< SuperPro analog output 1 mode register */
#define HTSPRO_REG_DAC1_FREQ    0x58 /*!< SuperPro analog output 1 frequency register (2 bytes msb/lsb) */
#define HTSPRO_REG_DAC1_VOLTAGE 0x5A /*!< SuperPro analog output 1 voltage register (10 bits) */
#define HTSPRO_REG_DLADDRESS    0x60 /*!< SuperPro download address register (2 bytes msb/lsb) */
#define HTSPRO_REG_DLDATA       0x62 /*!< SuperPro download data register (8 bytes) */
#define HTSPRO_REG_DLCHKSUM     0x6A /*!< SuperPro download checksum register */
#define HTSPRO_REG_DLCONTROL    0x6B /*!< SuperPro download control register */
#define HTSPRO_REG_MEMORY_20    0x80 /*!< SuperPro memory address 0x20 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_21    0x84 /*!< SuperPro memory address 0x21 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_22    0x88 /*!< SuperPro memory address 0x22 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_23    0x8C /*!< SuperPro memory address 0x23 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_24    0x90 /*!< SuperPro memory address 0x24 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_25    0x94 /*!< SuperPro memory address 0x25 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_26    0x98 /*!< SuperPro memory address 0x26 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_27    0x9C /*!< SuperPro memory address 0x27 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_28    0xA0 /*!< SuperPro memory address 0x28 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_29    0xA4 /*!< SuperPro memory address 0x29 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_2A    0xA8 /*!< SuperPro memory address 0x2A register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_2B    0xAC /*!< SuperPro memory address 0x2B register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_2C    0xB0 /*!< SuperPro memory address 0x2C register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_2D    0xB4 /*!< SuperPro memory address 0x2D register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_2E    0xB8 /*!< SuperPro memory address 0x2E register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_2F    0xBC /*!< SuperPro memory address 0x2F register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_30    0xC0 /*!< SuperPro memory address 0x30 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_31    0xC4 /*!< SuperPro memory address 0x31 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_32    0xC8 /*!< SuperPro memory address 0x32 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_33    0xCC /*!< SuperPro memory address 0x33 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_34    0xD0 /*!< SuperPro memory address 0x34 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_35    0xD4 /*!< SuperPro memory address 0x35 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_36    0xD8 /*!< SuperPro memory address 0x36 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_37    0xDC /*!< SuperPro memory address 0x37 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_38    0xE0 /*!< SuperPro memory address 0x38 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_39    0xE4 /*!< SuperPro memory address 0x39 register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_3A    0xE8 /*!< SuperPro memory address 0x3A register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_3B    0xEC /*!< SuperPro memory address 0x3B register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_3C    0xF0 /*!< SuperPro memory address 0x3C register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_3D    0xF4 /*!< SuperPro memory address 0x3D register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_3E    0xF8 /*!< SuperPro memory address 0x3E register (4 bytes msb/lsb) */
#define HTSPRO_REG_MEMORY_3F    0xFC /*!< SuperPro memory address 0x3F register (4 bytes msb/lsb) */

/** @defgroup HTSProAnalogInputConstants HiTechnic SuperPro analog input index constants
 * Constants that are for use with reading the HiTechnic SuperPro analog input values.
 * @{
 */
#define HTSPRO_A0 0x42 /*!< Read SuperPro analog input 0 */
#define HTSPRO_A1 0x44 /*!< Read SuperPro analog input 1 */
#define HTSPRO_A2 0x46 /*!< Read SuperPro analog input 2 */
#define HTSPRO_A3 0x48 /*!< Read SuperPro analog input 3 */
/** @} */  // end of HTSProAnalogInputConstants group

/** @defgroup HTSProDACIndexConstants HiTechnic SuperPro analog output index constants
 * Constants that are for use with configuraing the HiTechnic SuperPro analog outputs.
 * @{
 */
#define HTSPRO_DAC0 0x52 /*!< Set SuperPro analog output 0 configuration */
#define HTSPRO_DAC1 0x57 /*!< Set SuperPro analog output 1 configuration */
/** @} */  // end of HTSProDACIndexConstants group


/** @addtogroup LEDCtrlConstants
 * @{
 */
#define LED_BLUE 0x02 /*!< Turn on the blue onboard LED. */
#define LED_RED  0x01 /*!< Turn on the red onboard LED. */
#define LED_NONE 0x00 /*!< Turn off the onboard LEDs. */
/** @} */  // end of LEDCtrlConstants group

/** @addtogroup DacModeConstants
 * @{
 */
#define DAC_MODE_DCOUT        0 /*!< Steady (DC) voltage output. */
#define DAC_MODE_SINEWAVE     1 /*!< Sine wave output. */
#define DAC_MODE_SQUAREWAVE   2 /*!< Square wave output. */
#define DAC_MODE_SAWPOSWAVE   3 /*!< Positive going sawtooth output. */
#define DAC_MODE_SAWNEGWAVE   4 /*!< Negative going sawtooth output. */
#define DAC_MODE_TRIANGLEWAVE 5 /*!< Triangle wave output. */
#define DAC_MODE_PWMVOLTAGE   6 /*!< PWM square wave output. */
#define DAC_MODE_RESTART_MASK 0x80 /*!< Add mask to DAC mode constants to force waveform generation from the start of the wave table. */
/** @} */  // end of DacModeConstants group

/** @addtogroup DigitalPinConstants
 * @{
 */
#define DIGI_PIN0 0x01 /*!< Access digital pin 0 (B0) */
#define DIGI_PIN1 0x02 /*!< Access digital pin 1 (B1) */
#define DIGI_PIN2 0x04 /*!< Access digital pin 2 (B2) */
#define DIGI_PIN3 0x08 /*!< Access digital pin 3 (B3) */
#define DIGI_PIN4 0x10 /*!< Access digital pin 4 (B4) */
#define DIGI_PIN5 0x20 /*!< Access digital pin 5 (B5) */
#define DIGI_PIN6 0x40 /*!< Access digital pin 6 (B6) */
#define DIGI_PIN7 0x80 /*!< Access digital pin 7 (B7) */
/** @} */  // end of DigitalPinConstants group

/** @addtogroup StrobeCtrlConstants
 * @{
 */
#define STROBE_S0    0x01 /*!< Access strobe 0 pin (S0) */
#define STROBE_S1    0x02 /*!< Access strobe 1 pin (S1) */
#define STROBE_S2    0x04 /*!< Access strobe 2 pin (S2) */
#define STROBE_S3    0x08 /*!< Access strobe 3 pin (S3) */
#define STROBE_READ  0x10 /*!< Access read pin (RD) */
#define STROBE_WRITE 0x20 /*!< Access write pin (WR) */
/** @} */  // end of StrobeCtrlConstants group

/** @} */  // end of HTSuperProConstants group

/** @defgroup HTPIRConstants HiTechnic PIR sensor constants
 * Constants that are for use with the HiTechnic PIR sensor device.
 * @{
 */
#define HTPIR_REG_DEADBAND 0x41 /*!< PIR sensor deadband register */
#define HTPIR_REG_READING  0x42 /*!< PIR sensor value register (signed byte) */
/** @} */  // end of HTPIRConstants group

/** @} */  // end of HiTechnicConstants group
/** @} */  // end of HiTechnicAPI group

/** @} */ // end of ThirdPartyDevices group

#endif // HITECHNIC_CONSTANTS_H
