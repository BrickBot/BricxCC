/** \file nbc_cstring.h
 * \brief The NBC cstring API
 *
 * nbc_cstring.h contains the NBC cstring API
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
 * \date 2013-03-02
 * \version 1
 */

#ifndef NBC_CSTRING_H
#define NBC_CSTRING_H


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
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

dseg segment
  __Pos_i sword
  __Pos_l1 sword
  __Pos_lDelta sword
  __Pos_tmpstr byte[]
  __Pos_s2 byte[]
  __Pos_s1 byte[]
  __Pos_Result sword
  __Pos_Mutex mutex
dseg ends

subroutine __PosSubroutine
	arrsize __Pos_l1, __Pos_s1
	sub __Pos_l1, __Pos_l1, 1
	arrsize __Pos_lDelta, __Pos_s2
	sub __Pos_lDelta, __Pos_lDelta, __Pos_l1
	set __Pos_i, 0
__Pos_Repeat:
	sub __Pos_lDelta, __Pos_lDelta, 1
	brtst 0, __Pos_RepeatEnd, __Pos_lDelta
	strsubset __Pos_tmpstr, __Pos_s2, __Pos_i, __Pos_l1
	cmp 4, __Pos_Result, __Pos_s1, __Pos_tmpstr
	brtst 4, __Pos_RepeatAgain, __Pos_Result
    mov __Pos_Result, __Pos_i
	return
__Pos_RepeatAgain:
	add __Pos_i, __Pos_i, 1
	jmp __Pos_Repeat
__Pos_RepeatEnd:
	set __Pos_Result, -1
	return
ends

#define __doPos(_s1, _s2, _result) \
  acquire __Pos_Mutex \
  mov __Pos_s1, _s1 \
  mov __Pos_s2, _s2 \
  call __PosSubroutine \
  mov _result, __Pos_Result \
  release __Pos_Mutex \

#endif



/** @} */ // end of cstringAPI group

/** @} */ // end of StandardCAPIFunctions group

#endif // NBC_CSTRING_H
