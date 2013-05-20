/** \file cstring.h
 * \brief The NXC cstring API
 *
 * cstring.h contains the NXC cstring API
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
 * \date 2013-03-03
 * \version 3
 */

#ifndef CSTRING_H
#define CSTRING_H

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_cstring.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// cstring API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup StandardCAPIFunctions
 * @{
 */

/** @defgroup cstringAPI cstring API
 * Standard C cstring API functions.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Convert string to number.
 * Return the numeric value specified by the string passed to the function.
 * If the content of the string is not a numeric value then this function
 * returns zero. The input string parameter
 * may be a variable, constant, or expression.
 *
 * \param str String beginning with the representation of a number.
 * \param str A string.
 * \return A number.
 */
inline variant StrToNum(string str);

/**
 * Get string length.
 * Return the length of the specified string. The length of a string does
 * not include the null terminator at the end of the string. The input
 * string parameter may be a variable, constant, or expression.
 *
 * \param str A string.
 * \return The length of the string.
 */
inline unsigned int StrLen(string str);

/**
 * Extract a character from a string.
 * Return the numeric value of the character in the specified string at the
 * specified index. The input string parameter
 * may be a variable, constant, or expression.
 *
 * \param str A string.
 * \param idx The index of the character to retrieve.
 * \return The numeric value of the character at the specified index.
 */
inline byte StrIndex(string str, unsigned int idx);

/**
 * Convert number to string.
 * Return the string representation of the specified numeric value.
 *
 * \param num A number.
 * \return The string representation of the parameter num.
 */
inline string NumToStr(variant num);

/**
 * Concatenate strings.
 * Return a string which is the result of concatenating all of the
 * string arguments together. This function accepts
 * any number of parameters which may be string variables, constants,
 * or expressions.
 *
 * \param str1 The first string.
 * \param str2 The second string.
 * \param strN The Nth string.
 * \return The concatenated string.
 */
inline string StrCat(string str1, string str2, string strN);

/**
 * Extract a portion of a string.
 * Return a sub-string from the specified input string starting at idx and
 * including the specified number of characters. The input string parameter
 * may be a variable, constant, or expression.
 *
 * \param str A string.
 * \param idx The starting point of the sub-string.
 * \param len The length of the sub-string.
 * \return The sub-string extracted from parameter str.
 */
inline string SubStr(string str, unsigned int idx, unsigned int len);

/**
 * Flatten a number to a string.
 * Return a string containing the byte representation of the specified value.
 *
 * \param num A number.
 * \return A string containing the byte representation of the parameter num.
 */
inline string Flatten(variant num);

/**
 * Replace a portion of a string.
 * Return a string with the part of the string replaced (starting at the
 * specified index) with the contents of the new string value provided in
 * the third argument. The input string parameters
 * may be variables, constants, or expressions.
 *
 * \param str A string.
 * \param idx The starting point for the replace operation.
 * \param strnew The replacement string.
 * \return The modified string.
 */
inline string StrReplace(string str, unsigned int idx, string strnew);

/**
 * Format a number.
 * Return the formatted string using the format and value. Use a standard
 * numeric sprintf format specifier within the format string. The input string
 * parameter may be a variable, constant, or expression.
 *
 * \param fmt The string format containing a sprintf numeric format specifier.
 * \param num A number.
 * \return A string containing the formatted numeric value.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline string FormatNum(string fmt, variant num);

/**
 * Format a value.
 * Return the formatted string using the format and value. Use a standard
 * numeric sprintf format specifier within the format string. The input string
 * parameter may be a variable, constant, or expression.
 *
 * \param fmt The string format containing a sprintf format specifier.
 * \param val Any numeric or string value.
 * \return A string containing the formatted value.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline string FormatVal(string fmt, variant val);

/**
 * Flatten any data to a string.
 * Return a string containing the byte representation of the specified value.
 *
 * \sa UnflattenVar
 * \param x Any NXC datatype.
 * \return A string containing the byte representation of the parameter x.
 */
inline string FlattenVar(variant x);

/**
 * Unflatten a string into a data type.
 * Convert a string containing the byte representation of the specified
 * variable back into the original variable type.
 *
 * \sa FlattenVar, Flatten
 * \param str A string containing flattened data.
 * \param x A variable reference where the unflattened data is stored.
 * \return A boolean value indicating whether the operation succeeded or not.
 */
inline int UnflattenVar(string str, variant & x);

#else

#define FlattenVar(_value) asm { flatten __STRRETVAL__, _value }
#define UnflattenVar(_str, _value) asm { \
  unflatten _value, __RETVAL__, _str, _value \
  not __RETVAL__, __RETVAL__ \
}


#endif

/**
 * Find substring position.
 * Returns the index value of the first character in a specified substring
 * that occurs in a given string.  Pos searches for Substr within S and
 * returns an integer value that is the index of the first character of
 * Substr within S. Pos is case-sensitive. If Substr is not found, Pos
 * returns negative one.
 *
 * \param Substr A substring to search for in another string.
 * \param S A string that might contain the specified substring.
 * \return The position of the substring in the specified string or -1 if it is
 * not found.
 */
inline int Pos(string Substr, string S) { asm { __doPos(Substr, S, __RETVAL__) } }

/**
 * Convert a byte array to a string.
 * Convert the specified array to a string by appending a null terminator to
 * the end of the array elements. The array must be a one-dimensional array
 * of byte.
 *
 * \sa StrToByteArray, ByteArrayToStrEx
 * \param data A byte array.
 * \return A string containing data and a null terminator byte.
 */
inline string ByteArrayToStr(byte data[]) { asm { arrtostr __STRBUFFER__, data } }

/**
 * Convert a byte array to a string.
 * Convert the specified array to a string by appending a null terminator to
 * the end of the array elements. The array must be a one-dimensional array
 * of byte.
 *
 * \sa StrToByteArray, ByteArrayToStr
 * \param data A byte array.
 * \param str A string variable reference which, on output, will contain
 * data and a null terminator byte.
 */
inline void ByteArrayToStrEx(byte data[], string & str) { asm { arrtostr str, data } }

/**
 * Convert a string to a byte array.
 * Convert the specified string to an array of byte by removing the null
 * terminator at the end of the string. The output array variable must be a
 * one-dimensional array of byte.
 *
 * \sa ByteArrayToStr, ByteArrayToStrEx
 * \param str A string
 * \param data A byte array reference which, on output, will contain str
 * without its null terminator.
 */
inline void StrToByteArray(string str, byte & data[]) { asm { strtoarr data, str } }

/**
 * Copy a portion of a string.
 * Returns a substring of a string.
 *
 * \param str A string
 * \param idx The starting index of the substring.
 * \param len The length of the substring.
 * \return The specified substring.
 */
inline string Copy(string str, unsigned int idx, unsigned int len) {
  asm { strsubset __STRBUFFER__, str, idx, len  }
}

/**
 * Copy a portion from the middle of a string.
 * Returns the substring of a specified length that appears at a specified
 * position in a string.
 *
 * \param str A string
 * \param idx The starting index of the substring.
 * \param len The length of the substring.
 * \return The substring of a specified length that appears at a specified
 * position in a string.
 */
inline string MidStr(string str, unsigned int idx, unsigned int len) {
  asm { strsubset __STRBUFFER__, str, idx, len  }
}

/**
 * Copy a portion from the end of a string.
 * Returns the substring of a specified length that appears at the end of a string.
 *
 * \param str A string
 * \param size The size or length of the substring.
 * \return The substring of a specified length that appears at the end of a string.
 */
inline string RightStr(string str, unsigned int size) {
  unsigned int idx;
  asm {
    strlen idx, str
    sub idx, idx, size
    strsubset __STRBUFFER__, str, idx, size
  }
}

/**
 * Copy a portion from the start of a string.
 * Returns the substring of a specified length that appears at the start of a string.
 *
 * \param str A string
 * \param size The size or length of the substring.
 * \return The substring of a specified length that appears at the start of a string.
 */
inline string LeftStr(string str, unsigned int size) {
  asm { strsubset __STRBUFFER__, str, 0, size  }
}

// cstring functions

/**
 * Get string length.
 * Return the length of the specified string. The length of a string does
 * not include the null terminator at the end of the string.
 *
 * \param str A string.
 * \return The length of the string.
 */
inline int strlen(const string & str) { asm { strlen __RETVAL__, str } }

/**
 * Concatenate strings.
 * Appends a copy of the source string to the destination string. The
 * terminating null character in destination is overwritten by the first
 * character of source, and a new null-character is appended at the end of
 * the new string formed by the concatenation of both in destination. The
 * destination string is returned.
 *
 * \param dest The destination string.
 * \param src The string to be appended.
 * \return The destination string.
 */
inline string strcat(string & dest, const string & src) {
  asm {
    strcat __STRBUFFER__, dest, src
    mov dest, __STRBUFFER__
  }
}

/**
 * Append characters from string.
 * Appends the first num characters of source to destination, plus a
 * terminating null-character. If the length of the string in source is less
 * than num, only the content up to the terminating null-character is copied.
 * The destination string is returned.
 *
 * \param dest The destination string.
 * \param src The string to be appended.
 * \param num The maximum number of characters to be appended.
 * \return The destination string.
 */
inline string strncat(string & dest, const string & src, unsigned int num) {
  asm {
    strsubset __STRRETVAL__, src, 0, num
    strcat __STRBUFFER__, dest, __STRRETVAL__
    mov dest, __STRBUFFER__
  }
}

/**
 * Copy string.
 * Copies the string pointed by source into the array pointed by destination,
 * including the terminating null character. The destination string is returned.
 *
 * \param dest The destination string.
 * \param src The string to be appended.
 * \return The destination string.
 */
inline string strcpy(string & dest, const string & src) {
  asm {
    mov __STRBUFFER__, src
    mov dest, __STRBUFFER__
  }
}

/**
 * Copy characters from string.
 * Copies the first num characters of source to destination. The destination
 * string is returned.
 *
 * \param dest The destination string.
 * \param src The string to be appended.
 * \param num The maximum number of characters to be appended.
 * \return The destination string.
 */
inline string strncpy(string & dest, const string & src, unsigned int num) {
  asm {
    strsubset dest, src, 0, num
    mov __STRBUFFER__, dest
  }
}

/**
 * Compare two strings.
 * Compares the string str1 to the string str2.
 *
 * \param str1 A string to be compared.
 * \param str2 A string to be compared.
 * \return Returns an integral value indicating the relationship between the
 * strings. A zero value indicates that both strings are equal. A value
 * greater than zero indicates that the first character that does not match
 * has a greater value in str1 than in str2. A value less than zero indicates
 * the opposite.
 */
inline int strcmp(const string & str1, const string & str2) {
  int result = -1;
  if (str1 == str2)
    result = 0;
  else if (str1 > str2)
    result = 1;
  return result;
}

/**
 * Compare characters of two strings.
 * Compares up to num characters of the string str1 to those of the string str2.
 *
 * \param str1 A string to be compared.
 * \param str2 A string to be compared.
 * \param num The maximum number of characters to be compared.
 * \return Returns an integral value indicating the relationship between the
 * strings. A zero value indicates that the characters compared in both
 * strings are all equal. A value greater than zero indicates that the first
 * character that does not match has a greater value in str1 than in str2. A
 * value less than zero indicates the opposite.
 */
inline int strncmp(const string & str1, const string & str2, unsigned int num) {
  string sub1, sub2;
  asm {
    strsubset sub1, str1, 0, num
    strsubset sub2, str2, 0, num
  }
  int result = -1;
  if (sub1 == sub2)
    result = 0;
  else if (sub1 > sub2)
    result = 1;
  return result;
}

#ifdef __DOXYGEN_DOCS

/**
 * Copy memory.
 * Copies memory contents from the source to the destination. The num
 * argument is ignored.
 *
 * \param dest The destination variable.
 * \param src The source variable.
 * \param num The number of bytes to copy (ignored).
 */
inline void memcpy(variant dest, variant src, byte num);

/**
 * Move memory.
 * Moves memory contents from the source to the destination. The num
 * argument is ignored.
 *
 * \param dest The destination variable.
 * \param src The source variable.
 * \param num The number of bytes to copy (ignored).
 */
inline void memmove(variant dest, variant src, byte num);

/**
 * Compare two blocks of memory.
 * Compares the variant ptr1 to the variant ptr2. Returns an integral value
 * indicating the relationship between the variables. The num argument is
 * ignored.
 *
 * \param ptr1 A variable to be compared.
 * \param ptr2 A variable to be compared.
 * \param num The number of bytes to compare (ignored).
 */
inline char memcmp(variant ptr1, variant ptr2, byte num);

/**
 * Get the absolute address of a variable.
 * Get the absolute address of a variable and return it to the calling routine
 * as an unsigned long value.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param data A variable whose address you wish to get.
 * \return The absolute address of the variable.
 */
inline unsigned long addressOf(variant data);

/**
 * Get the relative address of a variable.
 * Get the relative address of a variable and return it to the calling routine
 * as an unsigned long value.  The relative address is an offset from the
 * Command module's MemoryPool address.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param data A variable whose address you wish to get.
 * \return The relative address of the variable.
 */
inline unsigned long reladdressOf(variant data);

/**
 * Get the absolute or relative address of a variable.
 * Get the absolute or relative address of a variable and return it to the
 * calling routine as an unsigned long value. The relative address is an
 * offset from the Command module's MemoryPool address.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param data A variable whose address you wish to get.
 * \param relative A boolean flag indicating whether you want to get the
 * relative or absolute address.
 * \return The absolute or relative address of the variable.
 */
inline unsigned long addressOfEx(variant data, bool relative);

#else

#define memcpy(_dest, _src, _num) asm { mov _dest, _src }
#define memmove(_dest, _src, _num) asm { mov _dest, _src }
#define memcmp(_ptr1, _ptr2, _num) ( (_ptr1 == _ptr2) ? 0 : ( (_ptr1 > _ptr2) ? 1 : -1 ) )

#define addressOf(_data) asm { addrof __URETVAL__, _data, 0 }
#define reladdressOf(_data) asm { addrof __URETVAL__, _data, 1 }
#define addressOfEx(_data, _rel) asm { addrof __URETVAL__, _data, _rel }

#endif

/*
void * memchr (void * ptr, int value, size_t num ); // Locate character in block of memory
char * strchr (       char * str, int character ); // Locate first occurrence of character in string
size_t strcspn ( const char * str1, const char * str2 ); // Get span until character in string
char * strpbrk ( const char *, const char * ); // Locate character in string
char * strrchr ( const char *, int ); // Locate last occurrence of character in string
size_t strspn ( const char * str1, const char * str2 ); // Get span of character set in string
char * strtok ( char * str, const char * delimiters ); // Split string into tokens
char * strstr ( const char *, const char * ); // Locate substring

void * memset ( void * ptr, byte value, size_t num ); // Fill block of memory (something like replace)
*/



/** @} */ // end of cstringAPI group


/** @} */ // end of StandardCAPIFunctions group

#endif // CSTRING_H
