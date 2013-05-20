/** \file nbc_cstdlib.h
 * \brief The NBC cstdlib API
 *
 * nbc_cstdlib.h contains the NBC cstdlib API
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

#ifndef NBC_CSTDLIB_H
#define NBC_CSTDLIB_H

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// cstdlib API //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup StandardCAPIFunctions
 * @{
 */

/** @defgroup cstdlibAPI cstdlib API
 * Standard C cstdlib API functions.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

// redefine this so we do not have to include commmand_constants.h
#define RandomNumber 24

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
// redefine this so we do not have to include commmand_constants.h
#define RandomEx 99
#endif

dseg segment
// RandomNumber
TRandomNumber	struct
 Result		sword
TRandomNumber	ends

  __RandomTmp dword
  __RandomArgs TRandomNumber
  __RandomMutex mutex

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
// RandomEx
TRandomEx	struct
 Seed   long
 ReSeed byte
TRandomEx	ends

  __RandomExArgs TRandomEx
  __RandomExMutex mutex
#endif
ends


#define __Random(_arg, _max) \
  acquire __RandomMutex \
  syscall RandomNumber, __RandomArgs \
  add __RandomTmp, __RandomArgs.Result, 32768 \
  mul __RandomTmp, __RandomTmp, _max \
  div __RandomTmp, __RandomTmp, 65536 \
  mov _arg, __RandomTmp \
  release __RandomMutex

#define __SignedRandom(_arg) \
  acquire __RandomMutex \
  syscall RandomNumber, __RandomArgs \
  mov _arg, __RandomArgs.Result \
  release __RandomMutex

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __SeedRandomEx(_seedin, _out) \
  acquire __RandomExMutex \
  set __RandomExArgs.ReSeed, TRUE \
  mov __RandomExArgs.Seed, _seedin \
  syscall RandomEx, __RandomExArgs \
  set __RandomExArgs.ReSeed, FALSE \
  mov _out, __RandomExArgs.Seed \
  release __RandomExMutex

#define __RandomEx(_out) \
  acquire __RandomExMutex \
  syscall RandomEx, __RandomExArgs \
  mov _out, __RandomExArgs.Seed \
  release __RandomExMutex

#endif

#endif

/**
 * Generate an unsigned random number.
 * Return an unsigned 16-bit random number. The
 * returned value will range between 0 and n (exclusive).
 *
 * \param _arg An unsigned random number.
 * \param _max The maximum unsigned value desired.
 */
#define Random(_arg, _max) __Random(_arg, _max)

/**
 * Generate signed random number.
 * Return a signed 16-bit random number.
 *
 * \param _arg A signed random number
 */
#define SignedRandom(_arg) __SignedRandom(_arg)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Seed the random number generator.
 * Provide the random number generator with a new seed value.
 *
 * \param _seed The new random number generator seed. A value of zero
 * causes the seed to be based on the current time value.  A value less
 * than zero causes the seed to be restored to the last specified seed.
 *
 * \param _out The new seed value (useful if you pass in 0 or -1).
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 */
#define srand(_seed, _out) __SeedRandomEx(_seed, _out)

/**
 * Generate random number.
 * Returns a pseudo-random integral number in the range 0 to \ref RAND_MAX.
 *
 * This number is generated by an algorithm that returns a sequence of
 * apparently non-related numbers each time it is called.
 *
 * \param _out An integer value between 0 and \ref RAND_MAX (inclusive).
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+
 */
#define rand(_out) __RandomEx(_out)

#endif

/** @} */ // end of cstdlibAPI group

/** @} */ // end of StandardCAPIFunctions group

#endif // NBC_CSTDLIB_H
