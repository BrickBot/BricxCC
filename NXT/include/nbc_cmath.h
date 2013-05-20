/** \file nbc_cmath.h
 * \brief The NBC cmath API
 *
 * nbc_cmath.h contains the NBC cmath API
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
#ifndef NBC_CMATH_H
#define NBC_CMATH_H

///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// cmath API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup StandardCAPIFunctions
 * @{
 */

/** @defgroup cmathAPI cmath API
 * Standard C cmath API functions.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

#if defined(__ENHANCED_FIRMWARE)

#define __SQRT(_X,_R) sqrt _R, _X
#define __SIN(_X,_R) sin _R, _X
#define __COS(_X,_R) cos _R, _X
#define __ASIN(_X,_R) asin _R, _X
#define __ACOS(_X,_R) acos _R, _X

#else

#if (__FIRMWARE_VERSION > 107)
#define __SQRT(_X,_R) sqrt _R, _X
#else
#define __SQRT(_X,_R) \
  acquire __sqrtMutex \
  mov __sqrtValue, _X \
  call __sqrtSub \
  mov _R, __sqrtResult \
  release __sqrtMutex
#endif

#define __SIN(_X,_R) \
  acquire __sinMutex \
  mov __sinValue, _X \
  call __sinSub \
  mov _R, __sinResult \
  release __sinMutex

#define __COS(_X,_R) \
  acquire __sinMutex \
  mov __sinValue, _X \
  add __sinValue, __sinValue, 90 \
  call __sinSub \
  mov _R, __sinResult \
  release __sinMutex

#define __ASIN(_X,_R) \
  acquire __asinMutex \
  mov __asinValue, _X \
  call __asinSub \
  mov _R, __asinResult \
  release __asinMutex

#define __ACOS(_X,_R) \
  acquire __asinMutex \
  mov __asinValue, _X \
  call __asinSub \
  sub _R, 90, __asinResult \
  release __asinMutex

#endif

// data segment
dseg segment

  // sin/cos related tables
  __sin_table sword[] 0,2,3,5,7,9,10,12,14,16,17,19,21,22,24,26,28,29,31,33,34,36,37,39,41,42,44,45,47,48,50,52,53,54,56,57,59,60,62,63,64,66,67,68,69,71,72,73,74,75,77,78,79,80,81,82,83,84,85,86,87,87,88,89,90,91,91,92,93,93,94,95,95,96,96,97,97,97,98,98,98,99,99,99,99,100,100,100,100,100,100
  __asin_table sdword[] 0,1,1,2,2,3,3,4,5,5,6,6,7,7,8,9,9,10,10,11,12,12,13,13,14,14,15,16,16,17,17,18,19,19,20,20,21,22,22,23,24,24,25,25,26,27,27,28,29,29,30,31,31,32,33,33,34,35,35,36,37,38,38,39,40,41,41,42,43,44,44,45,46,47,48,49,49,50,51,52,53,54,55,56,57,58,59,60,62,63,64,66,67,68,70,72,74,76,79,82,90

  // mutexes
  __sqrtMutex mutex
  __sinMutex mutex
  __asinMutex mutex

  // sqrt variables
  __sqrtPairs byte[]  0, 0, 0, 0, 0, 0
  __sqrtPaircount sbyte
  __sqrtValue dword
  __sqrtResult dword
  __sqrtP dword
  __sqrtR dword
  __sqrtM dword
  __sqrtN dword

  // sin variables
  __sinValue sdword
  __sinResult sdword
  __sinValueNeg byte

  // asin variables
  __asinValue sdword
  __asinResult sdword
dseg ends

subroutine __sinSub
  // move the sin to + angle
  set __sinValueNeg, FALSE
  brtst GTEQ, __sinValuePos, __sinValue

  neg __sinValue, __sinValue
  set __sinValueNeg, TRUE

__sinValuePos:
  // get the 360 mod and check which quarter the sin falls into
  mod __sinValue, __sinValue, 360
  brcmp GT, __sinQ4, __sinValue, 270
  brcmp GT, __sinQ3, __sinValue, 180
  brcmp GT, __sinQ2, __sinValue, 90

  // 1st quarter
  index __sinResult, __sin_table, __sinValue
  jmp __sinAlmostDone

__sinQ2:
  // 2nd quarter
  sub __sinValue, 180, __sinValue
  index __sinResult, __sin_table, __sinValue
  jmp __sinAlmostDone

__sinQ3:
  // 3rd quarter
  sub __sinValue, __sinValue, 180
  index __sinResult, __sin_table, __sinValue
  neg __sinResult, __sinResult
  jmp __sinAlmostDone

__sinQ4:
  // 4th quarter
  sub __sinValue, 360, __sinValue
  index __sinResult, __sin_table, __sinValue
  neg __sinResult, __sinResult
  jmp __sinAlmostDone

__sinAlmostDone:

  // if the incoming angle was <0, need to negate the result because sin(-x)=-sin(x)
  brcmp EQ, __sinDone, __sinValueNeg, FALSE
  neg __sinResult, __sinResult

__sinDone:
  return
ends


subroutine __asinSub
  // input sin value should be -1 -> 1
  brcmp GT, __asinValueBad, __asinValue, 100
  brcmp LT, __asinValueBad, __asinValue, -100

  // check if it's 0->-1
  brtst LT, __asinValueNeg, __asinValue

  // value 0->1
  index __asinResult, __asin_table, __asinValue
  jmp __asinDone

__asinValueNeg:
  // value 0->-1
  neg __asinValue, __asinValue
  index __asinResult, __asin_table, __asinValue
  neg __asinResult, __asinResult
  jmp __asinDone

__asinValueBad:
  set __asinResult, 101

__asinDone:
  return
ends

subroutine __sqrtSub
  // if the input value is 0, we're done
  set __sqrtResult, 0
  brtst EQ, __sqrtDone, __sqrtValue

  // init the paircount array
  mov __sqrtPaircount, 0
  replace __sqrtPairs, __sqrtPairs, 0, 0
  replace __sqrtPairs, __sqrtPairs, 1, 0
  replace __sqrtPairs, __sqrtPairs, 2, 0
  replace __sqrtPairs, __sqrtPairs, 3, 0
  replace __sqrtPairs, __sqrtPairs, 4, 0

__sqrtPairsLoop:
  brtst EQ, __sqrtPairsOK, __sqrtValue
  mod __sqrtN, __sqrtValue, 100
  replace __sqrtPairs, __sqrtPairs, __sqrtPaircount, __sqrtN
  div __sqrtValue, __sqrtValue, 100
  add __sqrtPaircount, __sqrtPaircount, 1

  jmp __sqrtPairsLoop

__sqrtPairsOK:
  // get the leftmost pair
  index __sqrtP, __sqrtPairs, __sqrtPaircount
  set __sqrtResult, 1

  // find the sqrt for the leftmost pair (1-9), if 0 we're not here!
__sqrtFirstLoop:
  mul __sqrtN, __sqrtResult, __sqrtResult
  brcmp GT, __sqrtFirstOK, __sqrtN, __sqrtP
  add __sqrtResult, __sqrtResult, 1
  jmp __sqrtFirstLoop

__sqrtFirstOK:
  sub __sqrtResult, __sqrtResult, 1
  // got the sqrt of the first pair in sqrtResult

  mul __sqrtN, __sqrtResult, __sqrtResult
  sub __sqrtM, __sqrtP, __sqrtN

  // in loop we get 1 new digit in sqrtResult for each pair
__sqrtBigLoop:
  sub __sqrtPaircount, __sqrtPaircount, 1

  brtst LT, __sqrtDone, __sqrtPaircount

  mul __sqrtM, __sqrtM, 100
  index __sqrtP, __sqrtPairs, __sqrtPaircount
  add __sqrtM, __sqrtM, __sqrtP

  // find the next digit
  set __sqrtN, 1

__sqrtDigitLoop:
  mul __sqrtR, __sqrtResult, 20
  add __sqrtR, __sqrtR, __sqrtN
  mul __sqrtR, __sqrtR, __sqrtN

  brcmp GT, __sqrtDigitDone, __sqrtR, __sqrtM

  add __sqrtN, __sqrtN, 1
  jmp __sqrtDigitLoop

__sqrtDigitDone:
  sub __sqrtN, __sqrtN, 1
  // got the next digit

  // calculate the new value to continue with
  mul __sqrtR, __sqrtResult, 20
  add __sqrtR, __sqrtR, __sqrtN
  mul __sqrtR, __sqrtR, __sqrtN
  sub __sqrtM, __sqrtM, __sqrtR

  // add the new digit to the end of the result in sqrtResult
  mul __sqrtResult, __sqrtResult, 10
  add __sqrtResult, __sqrtResult, __sqrtN

  jmp __sqrtBigLoop

__sqrtDone:
  return
ends

dseg segment
  __bcd2DecTens byte
  __bcd2DecOnes byte
  __bcd2DecMutex mutex
dseg ends

#define __bcd2dec(_bcd, _result) \
  acquire __bcd2DecMutex \
  div __bcd2DecTens, _bcd, 16 \
  mod __bcd2DecOnes, _bcd, 16 \
  mul _result, __bcd2DecTens, 10 \
  add _result, _result, __bcd2DecOnes \
  release __bcd2DecMutex

dseg segment

TVector struct
  X float
  Y float
  Z float
TVector ends

  __tmp_vc1 float
  __tmp_vc2 float
dseg ends

#define __VectorCross(_a, _b, _out) \
  mul __tmp_vc1, _a.Y, _b.Z \
  mul __tmp_vc2, _a.Z, _b.Y \
  sub _out.X, __tmp_vc1, __tmp_vc2 \
  mul __tmp_vc1, _a.Z, _b.X \
  mul __tmp_vc2, _a.X, _b.Z \
  sub _out.Y, __tmp_vc1, __tmp_vc2 \
  mul __tmp_vc1, _a.X, _b.Y \
  mul __tmp_vc2, _a.Y, _b.X \
  sub _out.Z, __tmp_vc1, __tmp_vc2

#define __VectorDot(_a, _b, _out) \
  mul _out, _a.X, _b.X \
  mul __tmp_vc1, _a.Y, _b.Y \
  add _out, _out, __tmp_vc1 \
  mul __tmp_vc1, _a.Z, _b.Z \
  add _out, _out, __tmp_vc1

#define __VectorNormalize(_a) \
  __VectorDot(_a, _a, __tmp_vc1) \
  sqrt __tmp_vc1, __tmp_vc1 \
  div _a.X, _a.X, __tmp_vc1 \
  div _a.Y, _a.Y, __tmp_vc1 \
  div _a.Z, _a.Z, __tmp_vc1


// standard firmware math functions written by Tamas Sorosy (www.sorosy.com)

// X is any integer, Y is the sqrt value (0->max), if X<0, Y is the sqrt value of absolute X
#define Sqrt(_X,_R) __SQRT(_X,_R)

// X is any integer in degrees, Y is 100* the sin value (-100->100)
#define Sin(_X,_R) __SIN(_X,_R)

// X is any integer in degrees, Y is 100* the cos value (-100->100)
#define Cos(_X,_R) __COS(_X,_R)

// X is 100* the sin value (-100->100), Y is -90->90, Y is 101 if X is outside -100->100 range
#define Asin(_X,_R) __ASIN(_X,_R)

// X is 100* the cos value (-100->100), Y is 0->180, Y is -11 if X is outside -100->100 range
#define Acos(_X,_R) __ACOS(_X,_R)

#endif

/**
 * Convert from BCD to decimal
 * Return the decimal equivalent of the binary coded decimal value provided.
 *
 * \param _bcd The value you want to convert from bcd to decimal.
 * \param _result The decimal equivalent of the binary coded decimal byte.
 */
#define bcd2dec(_bcd, _result) __bcd2dec(_bcd, _result)

/**
 * VectorCross function.
 * Calculate the cross-product of two vectors.
 *
 * \param _a A variable of type TVector
 * \param _b A variable of type TVector
 * \param _out The cross-product vector.
 */
#define VectorCross(_a, _b, _out) __VectorCross(_a, _b, _out)

/**
 * VectorDot function.
 * Calculate the dot-product of two vectors.
 *
 * \param _a A variable of type TVector
 * \param _b A variable of type TVector
 * \param _out The dot product of the two vectors.
 */
#define VectorDot(_a, _b, _out) __VectorDot(_a, _b, _out)

/**
 * VectorNormalize function.
 * Normalize the vector.
 *
 * \param _a A variable of type TVector
 */
#define VectorNormalize(_a) __VectorNormalize(_a)

/** @} */ // end of cmathAPI group

/** @} */ // end of StandardCAPIFunctions group

#endif // NBC_CMATH_H
