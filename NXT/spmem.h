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
 * Portions created by John Hansen are Copyright (C) 2009-2011 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * \author John Hansen (bricxcc_at_comcast.net)
 * \date 2011-08-11
 * \version 1
 */

#ifndef SPMEM_H
#define SPMEM_H

#define ADChannel0     @0x00  /*!< Return the current signal level for analog channel 0. Value ranges from 0 to 1023.  Updated every millisecond. */
#define ADChannel1     @0x01  /*!< Return the current signal level for analog channel 1. Value ranges from 0 to 1023.  Updated every millisecond. */
#define ADChannel2     @0x02  /*!< Return the current signal level for analog channel 2. Value ranges from 0 to 1023.  Updated every millisecond. */
#define ADChannel3     @0x03  /*!< Return the current signal level for analog channel 3. Value ranges from 0 to 1023.  Updated every millisecond. */

#define DigitalIn      @0x08  /*!< Return the level of any of the 8 digital signals. */
#define DigitalOut     @0x09  /*!< Set the level of any of the 8 digital signals. */
#define DigitalControl @0x0A  /*!< Set the mode of any of the 8 digital signals. 1 == output, 0 == input. */
#define StrobeControl  @0x0B  /*!< Controls the operation of the six strobe outputs (S0, S1, S2, S3, RD, and WR). See \ref StrobeCtrlConstants for valid values. */

#define Timer0         @0x0C  /*!< Timer 0. Counts down until it reaches zero (per millisecond). */
#define Timer1         @0x0D  /*!< Timer 1. Counts down until it reaches zero (per millisecond). */
#define Timer2         @0x0E  /*!< Timer 2. Counts down until it reaches zero (per millisecond). */
#define Timer3         @0x0F  /*!< Timer 3. Counts down until it reaches zero (per millisecond). */

#define SerialInCount  @0x10  /*!< Enables a user program to check if any data is available to be read from the serial port. */
#define SerialInByte   @0x11  /*!< Read a byte from the serial port. Reading this value removes the byte from the input buffer.  Serial port input data is stored in a 255 byte temporary buffer. */
#define SerialOutCount @0x12  /*!< Enables a user program to check how many bytes are waiting to be sent out the serial port. */
#define SerialOutByte  @0x13  /*!< Write a byte to the serial port. Serial port output data is stored in a 255 byte temporary buffer. Do not write to this address if SerialCount is 255. */

#define DAC0Mode       @0x18  /*!< Control the operation of the DAC0 analog output. See \ref DacModeConstants for valid values. */
#define DAC0Frequency  @0x19  /*!< Control the frequency of the DAC0 analog output. */
#define DAC0Voltage    @0x1A  /*!< Control the voltage of the DAC0 analog output. */

#define DAC1Mode       @0x1B  /*!< Control the operation of the DAC1 analog output. See \ref DacModeConstants for valid values. */
#define DAC1Frequency  @0x1C  /*!< Control the frequency of the DAC1 analog output. */
#define DAC1Voltage    @0x1D  /*!< Control the voltage of the DAC1 analog output. */

#define LEDControl     @0x1E  /*!< Control the operation of the two onboard LDEs (red and blue).  See \ref LEDCtrlConstants for valid values. */

#define SystemClock    @0x1F  /*!< Counts up continuously at one count per millisecond. */

#endif // SPMEM_H
