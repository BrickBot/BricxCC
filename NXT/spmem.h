/** \file spmem.h
 * \brief Constants defining superpro shared memory addresses
 *
 * spmem.h contains declarations for superpro shared memory addresses.
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
 * \date 2013-02-16
 * \version 2
 */

#ifndef SPMEM_H
#define SPMEM_H

/** @addtogroup presysconstgrp
 * @{
 */
 
#define ADChannel0     @0x00  /*!< Reads the current voltage on A0 input. Value ranges from 0 to 1023.  Updated every millisecond. Read only. */
#define ADChannel1     @0x01  /*!< Reads the current voltage on A1 input. Value ranges from 0 to 1023.  Updated every millisecond. Read only. */
#define ADChannel2     @0x02  /*!< Reads the current voltage on A2 input. Value ranges from 0 to 1023.  Updated every millisecond. Read only. */
#define ADChannel3     @0x03  /*!< Reads the current voltage on A3 input. Value ranges from 0 to 1023.  Updated every millisecond. Read only. */

#define DigitalIn      @0x08  /*!< Read 8 bits from the digital port B0 - B7. Read only. */
#define DigitalOut     @0x09  /*!< Write 8 bits to the digital port B0 - B7. Read/Write. */
#define DigitalControl @0x0A  /*!< Write 8 bits to the digital control port B0 - B7. Set the mode of any of the 8 digital signals. 1 == output, 0 == input. */
#define StrobeControl  @0x0B  /*!< Write 6 bits to the digital strobe port S0 - WR. Controls the operation of the six strobe outputs (S0, S1, S2, S3, RD, and WR). See \ref StrobeCtrlConstants for valid values. */

#define Timer0         @0x0C  /*!< Read/write countdown timer 0. Counts down until it reaches zero (per millisecond). */
#define Timer1         @0x0D  /*!< Read/write countdown timer 1. Counts down until it reaches zero (per millisecond). */
#define Timer2         @0x0E  /*!< Read/write countdown timer 2. Counts down until it reaches zero (per millisecond). */
#define Timer3         @0x0F  /*!< Read/write countdown timer 3. Counts down until it reaches zero (per millisecond). */

#define SerialInCount  @0x10  /*!< Read the count of serial bytes in the receive queue. Enables a user program to check if any data is available to be read from the serial port. Read only. */
#define SerialInByte   @0x11  /*!< Read the next serial byte from the serial port receive queue. Reading this value removes the byte from the receive queue.  Serial port input data is stored in a 255 byte temporary buffer. Read only. */
#define SerialOutCount @0x12  /*!< Read the count of serial bytes in the send queue. Enables a user program to check how many bytes are waiting to be sent out the serial port. Read only. */
#define SerialOutByte  @0x13  /*!< Write a byte to the serial port send queue. Serial port output data is stored in a 255 byte temporary buffer. Do not write to this address if SerialCount is 255. Write only. */

#define DAC0Mode       @0x18  /*!< Control the operation of the DAC0 analog output (O0). See \ref DacModeConstants for valid values. Read/write. */
#define DAC0Frequency  @0x19  /*!< Control the frequency of the DAC0 analog output (O0). Read/write. */
#define DAC0Voltage    @0x1A  /*!< Control the voltage of the DAC0 analog output (O0). Read/write. */

#define DAC1Mode       @0x1B  /*!< Control the operation of the DAC1 analog output (O1). See \ref DacModeConstants for valid values. Read/write. */
#define DAC1Frequency  @0x1C  /*!< Control the frequency of the DAC1 analog output (O1). Read/write. */
#define DAC1Voltage    @0x1D  /*!< Control the voltage of the DAC1 analog output (O1). Read/write. */

#define LEDControl     @0x1E  /*!< Control the operation of the two onboard LDEs (red and blue).  See \ref LEDCtrlConstants for valid values. Read/write. */

#define SystemClock    @0x1F  /*!< Read the system clock. The system clock counts up continuously at one count per millisecond. Read only. */

/** @} */  // end of presysconstgrp group

/** @addtogroup sharedmemgrp
 * @{
 */

#define SharedMem01    @0x20  /*!< Read/write via I2C at address 0x80 (msb/lsb) */
#define SharedMem02    @0x21  /*!< Read/write via I2C at address 0x84 (msb/lsb) */
#define SharedMem03    @0x22  /*!< Read/write via I2C at address 0x88 (msb/lsb) */
#define SharedMem04    @0x23  /*!< Read/write via I2C at address 0x8C (msb/lsb) */
#define SharedMem05    @0x24  /*!< Read/write via I2C at address 0x90 (msb/lsb) */
#define SharedMem06    @0x25  /*!< Read/write via I2C at address 0x94 (msb/lsb) */
#define SharedMem07    @0x26  /*!< Read/write via I2C at address 0x98 (msb/lsb) */
#define SharedMem08    @0x27  /*!< Read/write via I2C at address 0x9C (msb/lsb) */
#define SharedMem09    @0x28  /*!< Read/write via I2C at address 0xA0 (msb/lsb) */
#define SharedMem10    @0x29  /*!< Read/write via I2C at address 0xA4 (msb/lsb) */
#define SharedMem11    @0x2a  /*!< Read/write via I2C at address 0xA8 (msb/lsb) */
#define SharedMem12    @0x2b  /*!< Read/write via I2C at address 0xAC (msb/lsb) */
#define SharedMem13    @0x2c  /*!< Read/write via I2C at address 0xB0 (msb/lsb) */
#define SharedMem14    @0x2d  /*!< Read/write via I2C at address 0xB4 (msb/lsb) */
#define SharedMem15    @0x2e  /*!< Read/write via I2C at address 0xB8 (msb/lsb) */
#define SharedMem16    @0x2f  /*!< Read/write via I2C at address 0xBC (msb/lsb) */
#define SharedMem17    @0x30  /*!< Read/write via I2C at address 0xC0 (msb/lsb) */
#define SharedMem18    @0x31  /*!< Read/write via I2C at address 0xC4 (msb/lsb) */
#define SharedMem19    @0x32  /*!< Read/write via I2C at address 0xC8 (msb/lsb) */
#define SharedMem20    @0x33  /*!< Read/write via I2C at address 0xCC (msb/lsb) */
#define SharedMem21    @0x34  /*!< Read/write via I2C at address 0xD0 (msb/lsb) */
#define SharedMem22    @0x35  /*!< Read/write via I2C at address 0xD4 (msb/lsb) */
#define SharedMem23    @0x36  /*!< Read/write via I2C at address 0xD8 (msb/lsb) */
#define SharedMem24    @0x37  /*!< Read/write via I2C at address 0xDC (msb/lsb) */
#define SharedMem25    @0x38  /*!< Read/write via I2C at address 0xE0 (msb/lsb) */
#define SharedMem26    @0x39  /*!< Read/write via I2C at address 0xE4 (msb/lsb) */
#define SharedMem27    @0x3a  /*!< Read/write via I2C at address 0xE8 (msb/lsb) */
#define SharedMem28    @0x3b  /*!< Read/write via I2C at address 0xEC (msb/lsb) */
#define SharedMem29    @0x3c  /*!< Read/write via I2C at address 0xF0 (msb/lsb) */
#define SharedMem30    @0x3d  /*!< Read/write via I2C at address 0xF4 (msb/lsb) */
#define SharedMem31    @0x3e  /*!< Read/write via I2C at address 0xF8 (msb/lsb) */
#define SharedMem32    @0x3f  /*!< Read/write via I2C at address 0xFC (msb/lsb) */

/** @} */  // end of sharedmemgrp group

#endif // SPMEM_H
