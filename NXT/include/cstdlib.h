/** \file cstdlib.h
 * \brief The NXC cstdlib API
 *
 * cstdlib.h contains the NXC cstdlib API
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

#ifndef CSTDLIB_H
#define CSTDLIB_H

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// cstdlib API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @defgroup cstdlibAPI cstdlib API
 * Standard C cstdlib API functions and types.
 * @{
 */

/** @defgroup cstdlibAPITypes cstdlib API types
 * Standard C cstdlib API types.
 * @{
 */

/**
 * Parameters for the RandomNumber system call.
 * This structure is used when calling the \ref SysRandomNumber system call
 * function.
 * \sa SysRandomNumber()
 */
struct RandomNumberType {
  int Result; /*!< The random number. */
};

/**
 * Output type of the div function.
 * div_t structure.
 * Structure used to represent the value of an integral division performed
 * by div. It has two members of the same type, defined in either order as:
 * int quot; int rem;.
 * \sa div()
 */
struct div_t {
  int quot;  /*!< Represents the quotient of the integral division operation
                  performed by div, which is the integer of lesser magnitude
                  that is nearest to the algebraic quotient. */
  int rem;   /*!< Represents the remainder of the integral division operation
                  performed by div, which is the integer resulting from
                  subtracting quot to the numerator of the operation. */
};

/**
 * Output type of the ldiv function.
 * Structure used to represent the value of an integral division performed
 * by ldiv. It has two members of the same type, defined in either order as:
 * long quot; long rem;.
 * \sa ldiv()
 */
struct ldiv_t {
  long quot;  /*!< Represents the quotient of the integral division operation
                  performed by div, which is the integer of lesser magnitude
                  that is nearest to the algebraic quotient. */
  long rem;   /*!< Represents the remainder of the integral division operation
                  performed by div, which is the integer resulting from
                  subtracting quot to the numerator of the operation. */
};

/** @} */ // end of cstdlibAPITypes group

#ifdef __DOXYGEN_DOCS

/**
 * Abort current process.
 * Aborts the process with an abnormal program termination.
 * The function never returns to its caller.
 */
inline void abort();

/**
 * Absolute value.
 * Return the absolute value of the value argument. Any scalar type can
 * be passed into this function.
 *
 * \param num The numeric value.
 * \return The absolute value of num. The return type matches the input type.
 */
inline variant abs(variant num);

/**
 * Generate random number.
 * Returns a pseudo-random integral number in the range 0 to \ref RAND_MAX.
 *
 * \return An integer value between 0 and RAND_MAX.
 */
inline unsigned int rand();

/**
 * Generate random number.
 * Return a signed or unsigned 16-bit random number. If the optional argument n
 * is not provided the function will return a signed value.  Otherwise the
 * returned value will range between 0 and n (exclusive).
 *
 * \param n The maximum unsigned value desired (optional).
 * \return A random number
 */
inline int Random(unsigned int n = 0);

/**
 * Draw a random number.
 * This function lets you obtain a random number via the \ref RandomNumberType
 * structure.
 *
 * \param args The RandomNumberType structure receiving results.
 */
inline void SysRandomNumber(RandomNumberType & args);

#else

#define abort() Stop(true)
#define rand() Random(RAND_MAX)

#define SysRandomNumber(_args) asm { \
  compchktype _args, RandomNumberType \
  syscall RandomNumber, _args \
}

#endif

/**
 * Convert string to integer.
 * Parses the string str interpreting its content as an integral number,
 * which is returned as an int value.
 *
 * The function first discards as many whitespace characters as necessary
 * until the first non-whitespace character is found. Then, starting from
 * this character, takes an optional initial plus or minus sign followed by as
 * many numerical digits as possible, and interprets them as a numerical value.
 *
 * The string can contain additional characters after those that form the
 * integral number, which are ignored and have no effect on the behavior of
 * this function.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid integral number, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of an integral number.
 * \return On success, the function returns the converted integral number
 * as an int value. If no valid conversion could be performed a zero value
 * is returned.
 */
inline int atoi(const string & str) { return StrToNum(str); }

/**
 * Convert string to long integer.
 * Parses the string str interpreting its content as an integral number,
 * which is returned as a long int value.
 *
 * The function first discards as many whitespace characters as necessary
 * until the first non-whitespace character is found. Then, starting from
 * this character, takes an optional initial plus or minus sign followed by as
 * many numerical digits as possible, and interprets them as a numerical value.
 *
 * The string can contain additional characters after those that form the
 * integral number, which are ignored and have no effect on the behavior of
 * this function.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid integral number, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of an integral number.
 * \return On success, the function returns the converted integral number
 * as a long int value. If no valid conversion could be performed a zero value
 * is returned.
 */
inline long atol(const string & str) { return StrToNum(str); }

/**
 * Absolute value.
 * Return the absolute value of parameter n.
 *
 * \param n Integral value.
 * \return The absolute value of n.
 */
inline long labs(long n) { return abs(n); }

#if __FIRMWARE_VERSION > 107
/**
 * Convert string to float.
 * Parses the string str interpreting its content as a floating point number
 * and returns its value as a float.
 *
 * The function first discards as many whitespace characters as necessary until
 * the first non-whitespace character is found. Then, starting from this
 * character, takes as many characters as possible that are valid following a
 * syntax resembling that of floating point literals, and interprets them as a
 * numerical value. The rest of the string after the last valid character is
 * ignored and has no effect on the behavior of this function.
 *
 * A valid floating point number for atof is formed by a succession of:
 * - An optional plus or minus sign
 * - A sequence of digits, optionally containing a decimal-point character
 * - An optional exponent part, which itself consists on an 'e' or 'E'
 * character followed by an optional sign and a sequence of digits.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid floating-point number as just defined, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of a floating-point number.
 * \return On success, the function returns the converted floating point number
 * as a float value. If no valid conversion could be performed a zero value
 * (0.0) is returned.
 */
inline float atof(const string & str) {
  float result;
  asm { strtonum result, __TMPWORD__, str, NA, NA }
  return result;
}

/**
 * Convert string to float.
 * Parses the string str interpreting its content as a floating point number
 * and returns its value as a float.
 *
 * The function first discards as many whitespace characters as necessary until
 * the first non-whitespace character is found. Then, starting from this
 * character, takes as many characters as possible that are valid following a
 * syntax resembling that of floating point literals, and interprets them as a
 * numerical value. A string containing the rest of the string after the last
 * valid character is stored in endptr.
 *
 * A valid floating point number for atof is formed by a succession of:
 * - An optional plus or minus sign
 * - A sequence of digits, optionally containing a decimal-point character
 * - An optional exponent part, which itself consists on an 'e' or 'E'
 * character followed by an optional sign and a sequence of digits.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid floating-point number as just defined, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of a floating-point number.
 * \param endptr Reference to a string, whose value is set by the function to
 * the remaining characters in str after the numerical value.
 * \return On success, the function returns the converted floating point number
 * as a float value. If no valid conversion could be performed a zero value
 * (0.0) is returned.
 */
inline float strtod(const string & str, string & endptr) {
  float result;
  int offsetpast;
  asm {
    strtonum result, offsetpast, str, NA, NA
    strsubset endptr, str, offsetpast, NA
  }
  return result;
}
#endif

/**
 * Convert string to long integer.
 * Parses the C string str interpreting its content as an integral number of
 * the specified base, which is returned as a long int value.
 *
 * The function first discards as many whitespace characters as necessary
 * until the first non-whitespace character is found. Then, starting from this
 * character, takes as many characters as possible that are valid following a
 * syntax that depends on the base parameter, and interprets them as a
 * numerical value. A string containing the rest of the characters following the
 * integer representation in str is stored in endptr.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid integral number, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String beginning with the representation of an integral number.
 * \param endptr Reference to a string, whose value is set by the function to
 * the remaining characters in str after the numerical value.
 * \param base Optional and ignored if specified.
 * \return On success, the function returns the converted integral number
 * as a long int value. If no valid conversion could be performed a zero value
 * is returned.
 * \warning Only base = 10 is currently supported.
 */
inline long strtol(const string & str, string & endptr, int base = 10) {
  long result;
  int offsetpast;
  asm {
    strtonum result, offsetpast, str, NA, NA
    strsubset endptr, str, offsetpast, NA
  }
  return result;
}

/**
 * Convert string to unsigned long integer.
 * Parses the C string str interpreting its content as an unsigned integral
 * number of the specified base, which is returned as an unsigned long int value.
 *
 * The function first discards as many whitespace characters as necessary
 * until the first non-whitespace character is found. Then, starting from this
 * character, takes as many characters as possible that are valid following a
 * syntax that depends on the base parameter, and interprets them as a
 * numerical value. A string containing the rest of the characters following the
 * integer representation in str is stored in endptr.
 *
 * If the first sequence of non-whitespace characters in str does not form a
 * valid integral number, or if no such sequence exists
 * because either str is empty or contains only whitespace characters, no
 * conversion is performed.
 *
 * \param str String containing the representation of an unsigned integral number.
 * \param endptr Reference to a string, whose value is set by the function to
 * the remaining characters in str after the numerical value.
 * \param base Optional and ignored if specified.
 * \return On success, the function returns the converted integral number
 * as an unsigned long int value. If no valid conversion could be performed a
 * zero value is returned.
 * \warning Only base = 10 is currently supported.
 */
inline long strtoul(const string & str, string & endptr, int base = 10) {
  unsigned long result;
  int offsetpast;
  asm {
    strtonum result, offsetpast, str, NA, NA
    strsubset endptr, str, offsetpast, NA
  }
  return result;
}

/**
 * Integral division.
 * Returns the integral quotient and remainder of the division of numerator by
 * denominator as a structure of type div_t, which has two members:
 * quot and rem.
 *
 * \param numer Numerator.
 * \param denom Denominator.
 * \return The result is returned by value in a structure defined in cstdlib,
 * which has two members. For div_t, these are, in either order:
 * int quot; int rem.
 */
inline div_t div(int numer, int denom) {
  div_t result;
  result.quot = numer / denom;
  result.rem  = numer % denom;
  return result;
}

/**
 * Integral division.
 * Returns the integral quotient and remainder of the division of numerator by
 * denominator as a structure of type ldiv_t, which has two members:
 * quot and rem.
 *
 * \param numer Numerator.
 * \param denom Denominator.
 * \return The result is returned by value in a structure defined in cstdlib,
 * which has two members. For ldiv_t, these are, in either order:
 * long quot; long rem.
 */
inline ldiv_t ldiv(long numer, long denom) {
  ldiv_t result;
  result.quot = numer / denom;
  result.rem  = numer % denom;
  return result;
}

/** @} */ // end of cstdlibAPI group

#endif // CSTDLIB_H
