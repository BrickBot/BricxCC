/** \file misc_constants.h
 * \brief NBC/NXC miscellaneous constants
 *
 * misc_constants.h contains NBC/NXC miscellaneous constants
 *
 * License:
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHIN WARRANTY OF ANY KIND, either express or implied. See the
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

#ifndef MISC_CONSTANTS_H
#define MISC_CONSTANTS_H

/** @addtogroup MiscConstants
 * @{
 */
#define TRUE  1 /*!< A true value */
#define FALSE 0 /*!< A false value */

#define NA 0xFFFF /*!< The specified argument does not apply (aka unwired) */

/** @defgroup VariableTypeConstants Variable type constants
 * Use these constants for testing a variable type.
 * @{
 */
#define VT_UBYTE     0x01  /*!< Variable type unsigned byte */
#define VT_SBYTE     0x02  /*!< Variable type signed byte */
#define VT_UWORD     0x03  /*!< Variable type unsigned word */
#define VT_SWORD     0x04  /*!< Variable type signed word */
#define VT_ULONG     0x05  /*!< Variable type unsigned long */
#define VT_SLONG     0x06  /*!< Variable type signed long */
#define VT_STRUCT    0x08  /*!< Variable type structure */
#define VT_MUTEX     0x09  /*!< Variable type mutex */
#define VT_FLOAT     0x0A  /*!< Variable type float */

#define VT_A1_UBYTE  0x11  /*!< Variable type 1d array of unsigned byte */
#define VT_A1_SBYTE  0x12  /*!< Variable type 1d array of signed byte */
#define VT_A1_UWORD  0x13  /*!< Variable type 1d array of unsigned word */
#define VT_A1_SWORD  0x14  /*!< Variable type 1d array of signed word */
#define VT_A1_ULONG  0x15  /*!< Variable type 1d array of unsigned long */
#define VT_A1_SLONG  0x16  /*!< Variable type 1d array of signed long */
#define VT_A1_STRUCT 0x17  /*!< Variable type 1d array of structure */
#define VT_A1_FLOAT  0x1A  /*!< Variable type 1d array of float */

#define VT_A2_UBYTE  0x21  /*!< Variable type 2d array of unsigned byte */
#define VT_A2_SBYTE  0x22  /*!< Variable type 2d array of signed byte */
#define VT_A2_UWORD  0x23  /*!< Variable type 2d array of unsigned word */
#define VT_A2_SWORD  0x24  /*!< Variable type 2d array of signed word */
#define VT_A2_ULONG  0x25  /*!< Variable type 2d array of unsigned long */
#define VT_A2_SLONG  0x26  /*!< Variable type 2d array of signed long */
#define VT_A2_STRUCT 0x27  /*!< Variable type 2d array of structure */
#define VT_A2_FLOAT  0x2A  /*!< Variable type 2d array of float */

#define VT_ARRAY_MASK   0xF0  /*!< Variable type array mask */
/** @} */  // end of VariableTypeConstants group

/** @defgroup NXTLimits Data type limits
 * Constants that define various data type limits.
 * @{
 */
#define CHAR_BIT   8           /*!< The number of bits in the char type */
#define SCHAR_MIN  -128        /*!< The minimum value of the signed char type */
#define SCHAR_MAX  127         /*!< The maximum value of the signed char type */
#define UCHAR_MAX  255         /*!< The maximum value of the unsigned char type */
#define CHAR_MIN   -128        /*!< The minimum value of the char type */
#define CHAR_MAX   127         /*!< The maximum value of the char type */
#define SHRT_MIN   -32768      /*!< The minimum value of the short type */
#define SHRT_MAX   32767       /*!< The maximum value of the short type */
#define USHRT_MAX  65535       /*!< The maximum value of the unsigned short type */
#define INT_MIN    -32768      /*!< The minimum value of the int type */
#define INT_MAX    32767       /*!< The maximum value of the int type */
#define UINT_MAX   65535       /*!< The maximum value of the unsigned int type */
#define LONG_MIN   -2147483648 /*!< The minimum value of the long type */
#define LONG_MAX   2147483647  /*!< The maximum value of the long type */
#define ULONG_MAX  4294967295  /*!< The maximum value of the unsigned long type */
#ifdef __ENHANCED_FIRMWARE
#define RAND_MAX   2147483646  /*!< The maximum long random number returned by rand */
#else
#define RAND_MAX   65535       /*!< The maximum unsigned int random number returned by rand */
#endif
/** @} */  // end of NXTLimits group

/** @} */  // end of MiscConstants group

#endif // MISC_CONSTANTS_H
