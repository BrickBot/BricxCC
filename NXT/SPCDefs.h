/** \file SPCDefs.h
 * \brief Constants, macros, and API functions for SPC
 *
 * SPCDefs.h contains declarations for the SPC API resources
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
 * \version 3
 */
#ifndef SPCDEFS_H
#define SPCDEFS_H

/** @addtogroup MiscConstants
 * @{
 */
 
#define TRUE  1 /*!< A true value */
#define FALSE 0 /*!< A false value */

#define SERIAL_BUFFER_SIZE 255 /*!< Serial port receive and send buffer size */

/** @defgroup SPROLimits Data type limits
 * Constants that define various data type limits.
 * @{
 */
#define CHAR_BIT   32         /*!< The number of bits in the char type */
#define LONG_MIN  -2147483648 /*!< The minimum value of the long type */
#define SCHAR_MIN -2147483648 /*!< The minimum value of the signed char type */
#define INT_MIN   -2147483648 /*!< The minimum value of the int type */
#define CHAR_MIN  -2147483648 /*!< The minimum value of the char type */
#define LONG_MAX   2147483647 /*!< The maximum value of the long type */
#define SCHAR_MAX  2147483647 /*!< The maximum value of the signed char type */
#define INT_MAX    2147483647 /*!< The maximum value of the int type */
#define CHAR_MAX   2147483647 /*!< The maximum value of the char type */
/** @} */  // end of SPROLimits group

/** @} */  // end of MiscConstants group

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

/** @addtogroup LEDCtrlConstants
 * @{
 */
#define LED_BLUE 0x02 /*!< Turn on the blue onboard LED. */
#define LED_RED  0x01 /*!< Turn on the red onboard LED. */
/** @} */  // end of LEDCtrlConstants group

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

/** @defgroup SlotConstants Program slot constants
 * Constants for use with the Run() function.
 * \sa Run()
 * @{
 */
#define SLOT1 0 /*!< Program slot 1. */
#define SLOT2 1 /*!< Program slot 2. */
#define SLOT3 2 /*!< Program slot 3. */
#define SLOT4 3 /*!< Program slot 4. */
#define SLOT5 4 /*!< Program slot 5. */
#define SLOT6 5 /*!< Program slot 6. */
#define SLOT7 6 /*!< Program slot 7. */
/** @} */  // end of SlotConstants group

/** @defgroup LogStatusConstants Log status constants
 * Constants for use with the stat() function.
 * \sa stat()
 * @{
 */
#define LOG_STATUS_OPEN    2 /*!< Log file is open. */
#define LOG_STATUS_BUSY    1 /*!< Log file is busy. */
#define LOG_STATUS_CLOSED  0 /*!< Log file is closed. */
/** @} */  // end of LogStatusConstants group

/** @defgroup TimeConstants Time constants
 * Constants for use with the Wait() function.
 * \sa Wait()
 * @{
 */
#define MS_1        1 /*!< 1 millisecond */
#define MS_2        2 /*!< 2 milliseconds */
#define MS_3        3 /*!< 3 milliseconds */
#define MS_4        4 /*!< 4 milliseconds */
#define MS_5        5 /*!< 5 milliseconds */
#define MS_6        6 /*!< 6 milliseconds */
#define MS_7        7 /*!< 7 milliseconds */
#define MS_8        8 /*!< 8 milliseconds */
#define MS_9        9 /*!< 9 milliseconds */
#define MS_10      10 /*!< 10 milliseconds */
#define MS_20      20 /*!< 20 milliseconds */
#define MS_30      30 /*!< 30 milliseconds */
#define MS_40      40 /*!< 40 milliseconds */
#define MS_50      50 /*!< 50 milliseconds */
#define MS_60      60 /*!< 60 milliseconds */
#define MS_70      70 /*!< 70 milliseconds */
#define MS_80      80 /*!< 80 milliseconds */
#define MS_90      90 /*!< 90 milliseconds */
#define MS_100    100 /*!< 100 milliseconds */
#define MS_150    150 /*!< 150 milliseconds */
#define MS_200    200 /*!< 200 milliseconds */
#define MS_250    250 /*!< 250 milliseconds */
#define MS_300    300 /*!< 300 milliseconds */
#define MS_350    350 /*!< 350 milliseconds */
#define MS_400    400 /*!< 400 milliseconds */
#define MS_450    450 /*!< 450 milliseconds */
#define MS_500    500 /*!< 500 milliseconds */
#define MS_600    600 /*!< 600 milliseconds */
#define MS_700    700 /*!< 700 milliseconds */
#define MS_800    800 /*!< 800 milliseconds */
#define MS_900    900 /*!< 900 milliseconds */
#define SEC_1    1000 /*!< 1 second */
#define SEC_2    2000 /*!< 2 seconds */
#define SEC_3    3000 /*!< 3 seconds */
#define SEC_4    4000 /*!< 4 seconds */
#define SEC_5    5000 /*!< 5 seconds */
#define SEC_6    6000 /*!< 6 seconds */
#define SEC_7    7000 /*!< 7 seconds */
#define SEC_8    8000 /*!< 8 seconds */
#define SEC_9    9000 /*!< 9 seconds */
#define SEC_10  10000 /*!< 10 seconds */
#define SEC_15  15000 /*!< 15 seconds */
#define SEC_20  20000 /*!< 20 seconds */
#define SEC_30  30000 /*!< 30 seconds */
#define MIN_1   60000 /*!< 1 minute */

#define NOTE_WHOLE   1000            /*!< The duration of a whole note (ms) */
#define NOTE_HALF    (NOTE_WHOLE/2)  /*!< The duration of a half note (ms) */
#define NOTE_QUARTER (NOTE_WHOLE/4)  /*!< The duration of a quarter note (ms) */
#define NOTE_EIGHT   (NOTE_WHOLE/8)  /*!< The duration of an eighth note (ms) */
#define NOTE_SIXTEEN (NOTE_WHOLE/16) /*!< The duration of an sixteenth note (ms) */
/** @} */  // end of TimeConstants group

/** @defgroup ToneConstants Tone constants
 * Constants for use with the analog output frequency fields.
 * \sa DAC0Frequency, DAC1Frequency
 * @{
 */
#define TONE_C3      131 /*!< Third octave C */
#define TONE_CS3     139 /*!< Third octave C sharp */
#define TONE_D3      147 /*!< Third octave D */
#define TONE_DS3     156 /*!< Third octave D sharp */
#define TONE_E3      165 /*!< Third octave E */
#define TONE_F3      175 /*!< Third octave F */
#define TONE_FS3     185 /*!< Third octave F sharp */
#define TONE_G3      196 /*!< Third octave G */
#define TONE_GS3     208 /*!< Third octave G sharp */
#define TONE_A3      220 /*!< Third octave A */
#define TONE_AS3     233 /*!< Third octave A sharp */
#define TONE_B3      247 /*!< Third octave B */
#define TONE_C4      262 /*!< Fourth octave C */
#define TONE_CS4     277 /*!< Fourth octave C sharp */
#define TONE_D4      294 /*!< Fourth octave D */
#define TONE_DS4     311 /*!< Fourth octave D sharp */
#define TONE_E4      330 /*!< Fourth octave E */
#define TONE_F4      349 /*!< Fourth octave F */
#define TONE_FS4     370 /*!< Fourth octave F sharp */
#define TONE_G4      392 /*!< Fourth octave G */
#define TONE_GS4     415 /*!< Fourth octave G sharp */
#define TONE_A4      440 /*!< Fourth octave A */
#define TONE_AS4     466 /*!< Fourth octave A sharp */
#define TONE_B4      494 /*!< Fourth octave B */
#define TONE_C5      523 /*!< Fifth octave C */
#define TONE_CS5     554 /*!< Fifth octave C sharp */
#define TONE_D5      587 /*!< Fifth octave D */
#define TONE_DS5     622 /*!< Fifth octave D sharp */
#define TONE_E5      659 /*!< Fifth octave E */
#define TONE_F5      698 /*!< Fifth octave F */
#define TONE_FS5     740 /*!< Fifth octave F sharp */
#define TONE_G5      784 /*!< Fifth octave G */
#define TONE_GS5     831 /*!< Fifth octave G sharp */
#define TONE_A5      880 /*!< Fifth octave A */
#define TONE_AS5     932 /*!< Fifth octave A sharp */
#define TONE_B5      988 /*!< Fifth octave B */
#define TONE_C6     1047 /*!< Sixth octave C */
#define TONE_CS6    1109 /*!< Sixth octave C sharp */
#define TONE_D6     1175 /*!< Sixth octave D */
#define TONE_DS6    1245 /*!< Sixth octave D sharp */
#define TONE_E6     1319 /*!< Sixth octave E */
#define TONE_F6     1397 /*!< Sixth octave F */
#define TONE_FS6    1480 /*!< Sixth octave F sharp */
#define TONE_G6     1568 /*!< Sixth octave G */
#define TONE_GS6    1661 /*!< Sixth octave G sharp */
#define TONE_A6     1760 /*!< Sixth octave A */
#define TONE_AS6    1865 /*!< Sixth octave A sharp */
#define TONE_B6     1976 /*!< Sixth octave B */
#define TONE_C7     2093 /*!< Seventh octave C */
#define TONE_CS7    2217 /*!< Seventh octave C sharp */
#define TONE_D7     2349 /*!< Seventh octave D */
#define TONE_DS7    2489 /*!< Seventh octave D sharp */
#define TONE_E7     2637 /*!< Seventh octave E */
#define TONE_F7     2794 /*!< Seventh octave F */
#define TONE_FS7    2960 /*!< Seventh octave F sharp */
#define TONE_G7     3136 /*!< Seventh octave G */
#define TONE_GS7    3322 /*!< Seventh octave G sharp */
#define TONE_A7     3520 /*!< Seventh octave A */
#define TONE_AS7    3729 /*!< Seventh octave A sharp */
#define TONE_B7     3951 /*!< Seventh octave B */
/** @} */  // end of ToneConstants group

#ifdef __DOXYGEN_DOCS

/** @defgroup spcapi SuperPro C API
 * Functions which comprise the SuperPro C application programming interface.
 * @{
 */

/**
 * Wait some milliseconds.
 * Make a task sleep for specified amount of time (in 1000ths of a second).
 *
 * \param ms The number of milliseconds to sleep.
 */
inline void Wait(long ms);

/**
 * Yield to another task.
 * Make a task yield to another concurrently running task.
 */
inline void Yield(void);

/**
 * Stop all tasks.
 * Stop all currently running tasks. This will halt the program completely,
 * so any code following this command will be ignored.
 */
inline void StopAllTasks(void);

/**
 * Stop the running program.
 * Stop the running program if bvalue is true. This will halt the program
 * completely, so any code following this command will be ignored.
 * \param bvalue If this value is true the program will stop executing.
 */
inline void Stop(bool bvalue);

/**
 * Exit to another task.
 * Immediately exit the current task and start executing the specified task.
 * \param newTask The task to start executing after exiting the current task.
 */
inline void ExitTo(task newTask);

/**
 * Start a task.
 * Start the specified task.
 * \param t The task to start.
 */
inline void StartTask(task t);

/**
 * Calculate the size of a variable.
 * Calculate the number of bytes required to store the contents of the
 * variable passed into the function.
 *
 * \param value The variable.
 * \return The number of bytes occupied by the variable.
 */
inline int SizeOf(variant & value);

/**
 * Read a value from a file.
 * Read a value from the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * variable. The type of the value parameter determines the number of bytes of
 * data read.
 *
 * \return The function call result.
 */
inline int read(void);

/**
 * Write value to file.
 * Write a value to the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * constant, a constant expression, or a variable. The type of the value
 * parameter determines the number of bytes of data written.
 *
 * \param value The value to write to the file.
 * \return The function call result.
 */
inline int write(const int value);

/**
 * Compute square root.
 * Computes the square root of x.
 *
 * \param x integer value.
 * \return Square root of x.
 */
inline int sqrt(int x);

/**
 * Absolute value.
 * Return the absolute value of the value argument. Any scalar type can
 * be passed into this function.
 *
 * \param num The numeric value.
 * \return The absolute value of num. The return type matches the input type.
 */
inline int abs(int num);

/**
 * Sign value.
 * Return the sign of the value argument (-1, 0, or 1). Any scalar type can
 * be passed into this function.
 *
 * \param num The numeric value for which to calculate its sign value.
 * \return -1 if the parameter is negative, 0 if the parameter is zero, or 1 if
 * the parameter is positive.
 */
inline char sign(int num);

/**
 * Close file.
 * Close the log file.
 *
 * \return The result code.
 */
inline int close(void);

/**
 * Open file.
 * Opens the log file. The operations that are allowed
 * on the stream and how these are performed are defined by the mode parameter.
 *
 * \param mode The file access mode. Valid values are "r" - opens the existing
 * log file for reading, "w" - creates a new log file and opens it for writing.
 * \return The result code.
 */
inline byte open(const char * mode);

/**
 * Write character to debug device.
 * Writes a character to the debug device.
 * If there are no errors, the same character that has been written is
 * returned.
 *
 * \param ch The character to be written.
 * \return The character written to the file.
 */
inline char putchar(const char ch);

/**
 * Write string to debug device.
 * Writes the string to the debug device. The null terminating
 * character at the end of the string is not written. If there are
 * no errors, a non-negative value is returned.
 *
 * \param str The string of characters to be written.
 * \return The result code.
 */
inline int puts(const char * str);

/**
 * Print formatted data to debug device.
 * Writes to the debug device a sequence of data formatted as the
 * format argument specifies. After the format parameter, the function
 * expects a variable number of parameters.
 *
 * \param format A constant string literal specifying the desired format.
 *
 */
inline void printf(const char * format, ...);

/**
 * Abort current process.
 * Aborts the process with an abnormal program termination.
 * The function never returns to its caller.
 */
inline void abort(void);

/**
 * Read the current system tick.
 * This function lets you current system tick count.
 *
 * \return The current system tick count.
 */
inline long CurrentTick(void);

/**
 * Pop a value off the stack.
 * Pop a 32-bit integer value off the top of the stack.
 *
 * \return The value popped off the top of the stack.
 */
inline int pop(void);

/**
 * Push a value onto the stack.
 * Push a 32-bit integer value onto the top of the stack.
 *
 * \param value The value you want to push onto the stack.
 * \return The value pushed onto the stack.
 */
inline int push(int value);

/**
 * Rotate left.
 * Rotate the specified variable one bit left through carry.
 *
 * \param value The value to rotate left one bit.
 */
inline void RotateLeft(int & value);

/**
 * Rotate right.
 * Rotate the specified variable one bit right through carry.
 *
 * \param value The value to rotate right one bit.
 */
inline void RotateRight(int & value);

/**
 * Run another program.
 * Run the program in the specified slot. The current program will terminate.
 *
 * \param slot The constant slot number for the program you want to execute.
 * See \ref SlotConstants.
 */
inline void Run(const int slot);

/**
 * Check log file status.
 * Check the status of the system log file.
 *
 * \return The log file status. See \ref LogStatusConstants.
 */
inline int stat(void);

/**
 * Stop all processes.
 * Stop all running tasks except for the main task.
 */
inline void StopProcesses(void);

/** @} */  // end of spcapi group

#else

#define until(_c) while(!(_c))

#define Yield() Wait(1)
#define StopAllTasks() Stop(true)
#define StartTask(_t) start _t
#define abort() Stop(true)
#define CurrentTick() SystemClock


#endif

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// ctype API ///////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup ctypeAPI ctype API
 * Standard C ctype API functions.
 * @{
 */
/**
 * Check if character is uppercase letter.
 * Checks if parameter c is an uppercase alphabetic letter.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is an uppercase alphabetic
 * letter, otherwise it returns 0 (false).
 */
inline int isupper(int c) { return ((c >= 'A') && (c <= 'Z')); }

/**
 * Check if character is lowercase letter.
 * Checks if parameter c is an lowercase alphabetic letter.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is an lowercase alphabetic
 * letter, otherwise it returns 0 (false).
 */
inline int islower(int c) { return ((c >= 'a') && (c <= 'z')); }

/**
 * Check if character is alphabetic.
 * Checks if parameter c is either an uppercase or lowercase letter.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is an alphabetic letter,
 * otherwise it returns 0 (false).
 */
inline int isalpha(int c) { return isupper(c) || islower(c); }

/**
 * Check if character is decimal digit.
 * Checks if parameter c is a decimal digit character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a decimal digit, otherwise
 * it returns 0 (false).
 */
inline int isdigit(int c) { return ((c >= '0') && (c <= '9')); }

/**
 * Check if character is alphanumeric.
 * Checks if parameter c is either a decimal digit or an uppercase or
 * lowercase letter. The result is true if either isalpha or isdigit would
 * also return true.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is either a digit or a
 * letter, otherwise it returns 0 (false).
 */
inline int isalnum(int c) { return isalpha(c) || isdigit(c); }

/**
 * Check if character is a white-space.
 * Checks if parameter c is a white-space character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a white-space character,
 * otherwise it returns 0 (false).
 */
inline int isspace(int c) { return (c == 0x20) || ((c >= 0x09) && (c <= 0x0d)); }

/**
 * Check if character is a control character.
 * Checks if parameter c is a control character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a control character,
 * otherwise it returns 0 (false).
 */
inline int iscntrl(int c) { return (c <= 0x1f) || (c == 0x7f); }

/**
 * Check if character is printable.
 * Checks if parameter c is a printable character (i.e., not a control
 * character).
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a printable character,
 * otherwise it returns 0 (false).
 */
inline int isprint(int c) { return !iscntrl(c); }

/**
 * Check if character has graphical representation.
 * Checks if parameter c is a character with a graphical representation.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c has a graphical representation,
 * otherwise it returns 0 (false).
 */
inline int isgraph(int c) { return (c != 0x20) && isprint(c); }

/**
 * Check if character is a punctuation.
 * Checks if parameter c is a punctuation character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a punctuation character,
 * otherwise it returns 0 (false).
 */
inline int ispunct(int c) { return isgraph(c) && !isalnum(c); }

/**
 * Check if character is hexadecimal digit.
 * Checks if parameter c is a hexadecimal digit character.
 *
 * \param c Character to be checked.
 * \return Returns a non-zero value (true) if c is a hexadecimal digit
 * character, otherwise it returns 0 (false).
 */
inline int isxdigit(int c) {  return isdigit(c) || ((c >= 'A') && (c <= 'F')) || ((c >= 'a') && (c <= 'f')); }

/**
 * Convert lowercase letter to uppercase.
 * Converts parameter c to its uppercase equivalent if c is a lowercase
 * letter and has an uppercase equivalent. If no such conversion is possible,
 * the value returned is c unchanged.
 *
 * \param c Lowercase letter character to be converted.
 * \return The uppercase equivalent to c, if such value exists, or c
 * (unchanged) otherwise..
 */
inline int toupper(int c) { if (islower(c)) c -= 32; return c; }

/**
 * Convert uppercase letter to lowercase.
 * Converts parameter c to its lowercase equivalent if c is an uppercase
 * letter and has a lowercase equivalent. If no such conversion is possible,
 * the value returned is c unchanged.
 *
 * \param c Uppercase letter character to be converted.
 * \return The lowercase equivalent to c, if such value exists, or c
 * (unchanged) otherwise..
 */
inline int tolower(int c) { if (isupper(c)) c += 32; return c; }

/** @} */ // end of ctypeAPI group


#endif // SPCDEFS_H
