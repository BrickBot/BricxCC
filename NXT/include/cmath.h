/** \file cmath.h
 * \brief The NXC cmath API
 *
 * cmath.h contains the NXC cmath API
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
#ifndef CMATH_H
#define CMATH_H

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_cmath.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// cmath API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup StandardCAPIFunctions
 * @{
 */

/** @defgroup cmathAPI cmath API
 * Standard C cmath API functions, types, and constants.
 * @{
 */

/**
 * This structure is used for storing three axis values in a single object.
 */
struct VectorType {
  float X;    /*!< The X axis value. */
  float Y;    /*!< The Y axis value. */
  float Z;    /*!< The Z axis value. */
};


#if __FIRMWARE_VERSION > 107

#define PI 3.141593               /*!< A constant for PI */
#define RADIANS_PER_DEGREE PI/180 /*!< Used for converting from degrees to radians */
#define DEGREES_PER_RADIAN 180/PI /*!< Used for converting from radians to degrees */

/**
 * Compute square root.
 * Computes the square root of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sqrt() instead.
 * \param _X Floating point value.
 * \return Square root of _X.
 */
#define Sqrt(_X) asm { sqrt __FLTRETVAL__, _X }

/**
 * Compute square root.
 * Computes the square root of x.
 *
 * \param x Floating point value.
 * \return Square root of x.
 */
inline float sqrt(float x) { asm { sqrt __FLTRETVAL__, x } }

#ifdef __ENHANCED_FIRMWARE

/**
 * Compute sine.
 * Computes the sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sin() instead.
 * \param _X Floating point value.
 * \return Sine of _X.
 */
#define Sin(_X) asm { sin __FLTRETVAL__, _X }

/**
 * Compute cosine.
 * Computes the cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use cos() instead.
 * \param _X Floating point value.
 * \return Cosine of _X.
 */
#define Cos(_X) asm { cos __FLTRETVAL__, _X }

/**
 * Compute arc sine.
 * Computes the arc sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use asin() instead.
 * \param _X Floating point value.
 * \return Arc sine of _X.
 */
#define Asin(_X) asm { asin __FLTRETVAL__, _X }

/**
 * Compute arc cosine.
 * Computes the arc cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use acos() instead.
 * \param _X Floating point value.
 * \return Arc cosine of _X.
 */
#define Acos(_X) asm { acos __FLTRETVAL__, _X }

/**
 * Compute arc tangent.
 * Computes the arc tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use atan() instead.
 * \param _X Floating point value.
 * \return Arc tangent of _X.
 */
#define Atan(_X) asm { atan __FLTRETVAL__, _X }

/**
 * Round up value.
 * Computes the smallest integral value that is not less than _X.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use ceil() instead.
 * \param _X Floating point value.
 * \return The smallest integral value not less than _X.
 */
#define Ceil(_X) asm { ceil __FLTRETVAL__, _X }

/**
 * Compute exponential function .
 * Computes the base-e exponential function of _X, which is the e number
 * raised to the power _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use exp() instead.
 * \param _X Floating point value.
 * \return Exponential value of _X.
 */
#define Exp(_X) asm { exp __FLTRETVAL__, _X }

/**
 * Round down value.
 * Computes the largest integral value that is not greater than _X.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use floor() instead.
 * \param _X Floating point value.
 * \return The largest integral value not greater than _X.
 */
#define Floor(_X) asm { floor __FLTRETVAL__, _X }

/**
 * Compute tangent.
 * Computes the tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use tan() instead.
 * \param _X Floating point value.
 * \return Tangent of _X.
 */
#define Tan(_X) asm { tan __FLTRETVAL__, _X }

/**
 * Compute hyperbolic tangent.
 * Computes the hyperbolic tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use tanh() instead.
 * \param _X Floating point value.
 * \return Hyperbolic tangent of _X.
 */
#define Tanh(_X) asm { tanh __FLTRETVAL__, _X }

/**
 * Compute hyperbolic cosine.
 * Computes the hyperbolic cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use cosh() instead.
 * \param _X Floating point value.
 * \return Hyperbolic cosine of _X.
 */
#define Cosh(_X) asm { cosh __FLTRETVAL__, _X }

/**
 * Compute hyperbolic sine.
 * Computes the hyperbolic sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sinh() instead.
 * \param _X Floating point value.
 * \return Hyperbolic sine of _X.
 */
#define Sinh(_X) asm { sinh __FLTRETVAL__, _X }

/**
 * Compute natural logarithm.
 * Computes the natural logarithm of _X. The natural logarithm is the base-e
 * logarithm, the inverse of the natural exponential function (exp). For
 * base-10 logarithms, a specific function Log10() exists.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use log() instead.
 * \param _X Floating point value.
 * \return Natural logarithm of _X.
 */
#define Log(_X) asm { log __FLTRETVAL__, _X }

/**
 * Compute common logarithm.
 * Computes the common logarithm of _X. The common logarithm is the base-10
 * logarithm. For base-e logarithms, a specific function Log() exists.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use log10() instead.
 * \param _X Floating point value.
 * \return Common logarithm of _X.
 */
#define Log10(_X) asm { log10 __FLTRETVAL__, _X }

/**
 * Compute arc tangent with 2 parameters.
 * Computes the principal value of the arc tangent of _Y/_X, expressed in
 * radians. To compute the value, the function uses the sign of both arguments
 * to determine the quadrant.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use atan2() instead.
 * \param _Y Floating point value representing a y coordinate.
 * \param _X Floating point value representing an x coordinate.
 * \return Arc tangent of _Y/_X, in the interval [-pi,+pi] radians.
 */
#define Atan2(_Y,_X) asm { atan2 __FLTRETVAL__, _Y, _X }

/**
 * Raise to power.
 * Computes _Base raised to the power _Exponent.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use pow() instead.
 * \param _Base Floating point value.
 * \param _Exponent Floating point value.
 * \return The result of raising _Base to the power _Exponent.
 */
#define Pow(_Base,_Exponent) asm { pow __FLTRETVAL__, _Base, _Exponent }

/**
 * Compute integral part.
 * Computes the integral part of _X.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use trunc() instead.
 * \param _X Floating point value.
 * \return Integral part of _X.
 */
#define Trunc(_X) asm { trunc __RETVAL__, _X }

/**
 * Compute fractional part.
 * Computes the fractional part of _X.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use frac() instead.
 * \param _X Floating point value.
 * \return Fractional part of _X.
 */
#define Frac(_X) asm { frac __FLTRETVAL__, _X }

/**
 * Multiply and divide.
 * Multiplies two 32-bit values and then divides the 64-bit result by a third
 * 32-bit value.
 * Only constants or variables allowed (no expressions).
 *
 * \deprecated Use muldiv32() instead.
 * \param _A 32-bit long value.
 * \param _B 32-bit long value.
 * \param _C 32-bit long value.
 * \return The result of multiplying _A times _B and dividing by _C.
 */
#define MulDiv32(_A,_B,_C) asm { muldiv __RETVAL__, _A, _B, _C }

/**
 * Compute sine (degrees).
 * Computes the sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sind() instead.
 * \param _X Floating point value.
 * \return Sine of _X.
 */
#define SinD(_X) asm { sind __FLTRETVAL__, _X }

/**
 * Compute cosine (degrees).
 * Computes the cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use cosd() instead.
 * \param _X Floating point value.
 * \return Cosine of _X.
 */
#define CosD(_X) asm { cosd __FLTRETVAL__, _X }

/**
 * Compute arch sine (degrees).
 * Computes the arc sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use asind() instead.
 * \param _X Floating point value.
 * \return Arc sine of _X.
 */
#define AsinD(_X) asm { asind __FLTRETVAL__, _X }

/**
 * Compute arc cosine (degrees).
 * Computes the arc cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use acosd() instead.
 * \param _X Floating point value.
 * \return Arc cosine of _X.
 */
#define AcosD(_X) asm { acosd __FLTRETVAL__, _X }

/**
 * Compute arc tangent (degrees).
 * Computes the arc tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use atand() instead.
 * \param _X Floating point value.
 * \return Arc tangent of _X.
 */
#define AtanD(_X) asm { atand __FLTRETVAL__, _X }

/**
 * Compute tangent (degrees).
 * Computes the sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use tand() instead.
 * \param _X Floating point value.
 * \return Tangent of _X.
 */
#define TanD(_X) asm { tand __FLTRETVAL__, _X }

/**
 * Compute hyperbolic tangent (degrees).
 * Computes the hyperbolic tangent of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use tanhd() instead.
 * \param _X Floating point value.
 * \return Hyperbolic tangent of _X.
 */
#define TanhD(_X) asm { tanhd __FLTRETVAL__, _X }

/**
 * Compute hyperbolic cosine (degrees).
 * Computes the hyperbolic cosine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use coshd() instead.
 * \param _X Floating point value.
 * \return Hyperbolic cosine of _X.
 */
#define CoshD(_X) asm { coshd __FLTRETVAL__, _X }

/**
 * Compute hyperbolic sine (degrees).
 * Computes the hyperbolic sine of _X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use sinhd() instead.
 * \param _X Floating point value.
 * \return Hyperbolic sine of _X.
 */
#define SinhD(_X) asm { sinhd __FLTRETVAL__, _X }

/**
 * Compute arc tangent with two parameters (degrees).
 * Computes the arc tangent of _Y/_X. Only constants or variables allowed
 * (no expressions).
 *
 * \deprecated Use atan2d() instead.
 * \param _Y Floating point value.
 * \param _X Floating point value.
 * \return Arc tangent of _Y/_X, in the interval [-180,+180] degrees.
 */
#define Atan2D(_Y,_X) asm { atan2d __FLTRETVAL__, _Y, _X }

/**
 * Compute cosine.
 * Computes the cosine of an angle of x radians.
 *
 * \param x Floating point value representing an angle expressed in radians.
 * \return Cosine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float cos(float x) { asm { cos __FLTRETVAL__, x } }

/**
 * Compute sine.
 * Computes the sine of an angle of x radians.
 *
 * \param x Floating point value representing an angle expressed in radians.
 * \return Sine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float sin(float x) { asm { sin __FLTRETVAL__, x } }

/**
 * Compute tangent.
 * Computes the tangent of an angle of x radians.
 *
 * \param x Floating point value representing an angle expressed in radians.
 * \return Tangent of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float tan(float x) { asm { tan __FLTRETVAL__, x } }

/**
 * Compute arc cosine.
 * Computes the principal value of the arc cosine of x, expressed in radians.
 * In trigonometrics, arc cosine is the inverse operation of cosine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc cosine of x, in the interval [0,pi] radians.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float acos(float x) { asm { acos __FLTRETVAL__, x } }

/**
 * Compute arc sine.
 * Computes the principal value of the arc sine of x, expressed in radians.
 * In trigonometrics, arc sine is the inverse operation of sine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc sine of x, in the interval [-pi/2,+pi/2] radians.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float asin(float x) { asm { asin __FLTRETVAL__, x } }

/**
 * Compute arc tangent.
 * Computes the principal value of the arc tangent of x, expressed in radians.
 * In trigonometrics, arc tangent is the inverse operation of tangent. Notice
 * that because of the sign ambiguity, a function cannot determine with
 * certainty in which quadrant the angle falls only by its tangent value.
 * You can use atan2() if you need to determine the quadrant.
 *
 * \sa atan2()
 * \param x Floating point value.
 * \return Arc tangent of x, in the interval [-pi/2,+pi/2] radians.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float atan(float x) { asm { atan __FLTRETVAL__, x } }

/**
 * Compute arc tangent with 2 parameters.
 * Computes the principal value of the arc tangent of y/x, expressed in
 * radians. To compute the value, the function uses the sign of both arguments
 * to determine the quadrant.
 *
 * \sa atan()
 * \param y Floating point value representing a y coordinate.
 * \param x Floating point value representing an x coordinate.
 * \return Arc tangent of y/x, in the interval [-pi,+pi] radians.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float atan2(float y, float x) { asm { atan2 __FLTRETVAL__, y, x } }

/**
 * Compute hyperbolic cosine.
 * Computes the hyperbolic cosine of x, expressed in radians.
 *
 * \param x Floating point value.
 * \return Hyperbolic cosine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float cosh(float x) { asm { cosh __FLTRETVAL__, x } }

/**
 * Compute hyperbolic sine.
 * Computes the hyperbolic sine of x, expressed in radians.
 *
 * \param x Floating point value.
 * \return Hyperbolic sine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float sinh(float x) { asm { sinh __FLTRETVAL__, x } }

/**
 * Compute hyperbolic tangent.
 * Computes the hyperbolic tangent of x, expressed in radians.
 *
 * \param x Floating point value.
 * \return Hyperbolic tangent of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float tanh(float x) { asm { tanh __FLTRETVAL__, x } }

/**
 * Compute exponential function.
 * Computes the base-e exponential function of x, which is the e number
 * raised to the power x.
 *
 * \param x Floating point value.
 * \return Exponential value of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float exp(float x) { asm { exp __FLTRETVAL__, x } }

/**
 * Compute natural logarithm.
 * Computes the natural logarithm of x. The natural logarithm is the base-e
 * logarithm, the inverse of the natural exponential function (exp). For
 * base-10 logarithms, a specific function log10() exists.
 *
 * \sa log10(), exp()
 * \param x Floating point value.
 * \return Natural logarithm of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float log(float x) { asm { log __FLTRETVAL__, x } }

/**
 * Compute common logarithm.
 * Computes the common logarithm of x. The common logarithm is the base-10
 * logarithm. For base-e logarithms, a specific function log() exists.
 *
 * \sa log(), exp()
 * \param x Floating point value.
 * \return Common logarithm of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float log10(float x) { asm { log10 __FLTRETVAL__, x } }

/**
 * Compute integral part.
 * Computes the integral part of x.
 *
 * \param x Floating point value.
 * \return Integral part of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline long trunc(float x) { asm { trunc __RETVAL__, x } }

/**
 * Compute fractional part.
 * Computes the fractional part of x.
 *
 * \param x Floating point value.
 * \return Fractional part of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float frac(float x) { asm { frac __FLTRETVAL__, x } }

/**
 * Raise to power.
 * Computes base raised to the power exponent.
 *
 * \param base Floating point value.
 * \param exponent Floating point value.
 * \return The result of raising base to the power exponent.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float pow(float base, float exponent) { asm { pow __FLTRETVAL__, base, exponent } }

/**
 * Round up value.
 * Computes the smallest integral value that is not less than x.
 *
 * \param x Floating point value.
 * \return The smallest integral value not less than x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float ceil(float x) { asm { ceil __FLTRETVAL__, x } }

/**
 * Round down value.
 * Computes the largest integral value that is not greater than x.
 *
 * \param x Floating point value.
 * \return The largest integral value not greater than x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float floor(float x) { asm { floor __FLTRETVAL__, x } }

/**
 * Multiply and divide.
 * Multiplies two 32-bit values and then divides the 64-bit result by a third
 * 32-bit value.
 *
 * \param a 32-bit long value.
 * \param b 32-bit long value.
 * \param c 32-bit long value.
 * \return The result of multiplying a times b and dividing by c.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline long muldiv32(long a, long b, long c) { asm { muldiv __RETVAL__, a, b, c } }

// degree-based trig functions

/**
 * Compute cosine (degrees).
 * Computes the cosine of an angle of x degrees.
 *
 * \param x Floating point value representing an angle expressed in degrees.
 * \return Cosine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float cosd(float x) { asm { cosd __FLTRETVAL__, x } }

/**
 * Compute sine (degrees).
 * Computes the sine of an angle of x degrees.
 *
 * \param x Floating point value representing an angle expressed in degrees.
 * \return Sine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float sind(float x) { asm { sind __FLTRETVAL__, x } }

/**
 * Compute tangent (degrees).
 * Computes the tangent of an angle of x degrees.
 *
 * \param x Floating point value representing an angle expressed in degrees.
 * \return Tangent of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float tand(float x) { asm { tand __FLTRETVAL__, x } }

/**
 * Compute arc cosine (degrees).
 * Computes the principal value of the arc cosine of x, expressed in degrees.
 * In trigonometrics, arc cosine is the inverse operation of cosine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc cosine of x, in the interval [0,180] degrees.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float acosd(float x) { asm { acosd __FLTRETVAL__, x } }

/**
 * Compute arc sine (degrees).
 * Computes the principal value of the arc sine of x, expressed in degrees.
 * In trigonometrics, arc sine is the inverse operation of sine.
 *
 * \param x Floating point value in the interval [-1,+1].
 * \return Arc sine of x, in the interval [-90,+90] degrees.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float asind(float x) { asm { asind __FLTRETVAL__, x } }

/**
 * Compute arc tangent (degrees).
 * Computes the principal value of the arc tangent of x, expressed in degrees.
 * In trigonometrics, arc tangent is the inverse operation of tangent. Notice
 * that because of the sign ambiguity, a function cannot determine with
 * certainty in which quadrant the angle falls only by its tangent value.
 * You can use atan2d if you need to determine the quadrant.
 *
 * \param x Floating point value.
 * \return Arc tangent of x, in the interval [-90,+90] degrees.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float atand(float x) { asm { atand __FLTRETVAL__, x } }

/**
 * Compute arc tangent with 2 parameters (degrees).
 * Computes the principal value of the arc tangent of y/x, expressed in
 * degrees. To compute the value, the function uses the sign of both arguments
 * to determine the quadrant.
 *
 * \param y Floating point value representing a y coordinate.
 * \param x Floating point value representing an x coordinate.
 * \return Arc tangent of y/x, in the interval [-180,+180] degrees.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float atan2d(float y, float x) { asm { atan2d __FLTRETVAL__, y, x } }

/**
 * Compute hyperbolic cosine (degrees).
 * Computes the hyperbolic cosine of x, expressed in degrees.
 *
 * \param x Floating point value.
 * \return Hyperbolic cosine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float coshd(float x) { asm { coshd __FLTRETVAL__, x } }

/**
 * Compute hyperbolic sine (degrees).
 * Computes the hyperbolic sine of x, expressed in degrees.
 *
 * \param x Floating point value.
 * \return Hyperbolic sine of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float sinhd(float x) { asm { sinhd __FLTRETVAL__, x } }

/**
 * Compute hyperbolic tangent (degrees).
 * Computes the hyperbolic tangent of x, expressed in degrees.
 *
 * \param x Floating point value.
 * \return Hyperbolic tangent of x.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
inline float tanhd(float x) { asm { tanhd __FLTRETVAL__, x } }

#endif

#else

// math functions written by Tamas Sorosy (www.sorosy.com)

// X is any integer; Y is the sqrt value (0->max); if X<0, Y is the sqrt value of absolute X
#define Sqrt(_X) asm { __SQRT(_X,__RETVAL__) }

#endif

#if (__FIRMWARE_VERSION <= 107) || !defined(__ENHANCED_FIRMWARE)

// X is any integer in degrees; Y is 100* the sin value (-100->100)
#define Sin(_X) asm { __SIN(_X,__RETVAL__) }

// X is any integer in degrees; Y is 100* the cos value (-100->100)
#define Cos(_X) asm { __COS(_X,__RETVAL__) }

// X is 100* the sin value (-100->100); Y is -90->90; Y is 101 if X is outside -100->100 range
#define Asin(_X) asm { __ASIN(_X,__RETVAL__) }

// X is 100* the cos value (-100->100); Y is 0->180; Y is -11 if X is outside -100->100 range
#define Acos(_X) asm { __ACOS(_X,__RETVAL__) }

#endif

/**
 * Convert from BCD to decimal
 * Return the decimal equivalent of the binary coded decimal value provided.
 *
 * \param bcd The value you want to convert from bcd to decimal.
 * \return The decimal equivalent of the binary coded decimal byte.
 */
inline byte bcd2dec(byte bcd) { asm { __bcd2dec(bcd, __URETVAL__) } }

#ifdef __DOXYGEN_DOCS

/**
 * Is the value NaN.
 * Returns true if the floating point value is NaN (not a number).
 *
 * \param value A floating point variable.
 * \return Whether the value is NaN.
 */
inline bool isNAN(float value);

/**
 * Sign value.
 * Return the sign of the value argument (-1, 0, or 1). Any scalar type can
 * be passed into this function.
 *
 * \param num The numeric value for which to calculate its sign value.
 * \return -1 if the parameter is negative, 0 if the parameter is zero, or 1 if
 * the parameter is positive.
 */
inline char sign(variant num);

/**
 * VectorCross function.
 * Calculate the cross-product of two vectors.
 *
 * \param a A variable of type VectorType
 * \param b A variable of type VectorType
 * \param out The cross-product vector.
 */
inline void VectorCross(VectorType a, VectorType b, VectorType & out);

/**
 * VectorDot function.
 * Calculate the dot-product of two vectors.
 *
 * \param a A variable of type VectorType
 * \param b A variable of type VectorType
 * \return The dot product of the two vectors.
 */
inline float VectorDot(VectorType a, VectorType b);

/**
 * VectorNormalize function.
 * Normalize the vector.
 *
 * \param a A variable of type VectorType
 */
inline void VectorNormalize(VectorType & a);

#else

#define isNAN(_x) ((_x) != (_x))

#define VectorCross(_a, _b, _out) asm { __VectorCross(_a, _b, _out) }
#define VectorDot(_a, _b) asm { __VectorDot(_a, _b, __FLTRETVAL__) }
#define VectorNormalize(_a) asm { __VectorNormalize(_a) }

#endif

/** @} */ // end of cmathAPI group

/** @} */ // end of StandardCAPIFunctions group

#endif // CMATH_H
