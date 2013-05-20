/** \file nbc_rcxapi.h
 * \brief The NBC RCX API
 *
 * nbc_rcxapi.h contains the NBC RCX API
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

#ifndef NBC_RCXAPI_H
#define NBC_RCXAPI_H

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

dseg segment
  __PFBytes byte[]
  __PFMutex mutex
  __PFNx byte
  __PFPowerFuncMode byte
  __PFTmp byte
  __PFNibbles byte[] 0x00, 0x00, 0x00, 0x00
  __PF_p1 byte
  __PF_p2 byte
  __PF_p3 byte
  __PF_p4 byte
  __PF_p5 byte
  __PFIdx byte
  __PFChToggle byte
  __PFToggles byte[] 0x00, 0x00, 0x00, 0x00
  __RCToggles byte[] 0x00, 0x00, 0x00, 0x00
dseg ends

subroutine __PFApplyToggle
  mov __PFIdx, __PF_p1
  index __PFChToggle, __PFToggles, __PFIdx
  add __PF_p1, __PF_p1, __PFChToggle
  return
ends

subroutine __PFUpdateToggle
  xor __PFChToggle, __PFChToggle, 8
  replace __PFToggles, __PFToggles, __PFIdx, __PFChToggle
  return
ends

subroutine __RCApplyToggle
  mov __PFIdx, __PF_p1
  index __PFChToggle, __RCToggles, __PFIdx
  add __PF_p1, __PF_p1, __PFChToggle
  return
ends

subroutine __RCUpdateToggle
  xor __PFChToggle, __PFChToggle, 8
  replace __RCToggles, __RCToggles, __PFIdx, __PFChToggle
  return
ends

subroutine __PFCalcChecksum
  // RCTrain or Power Function
  brtst EQ, __PFUseIRTrainMode, __PFPowerFuncMode
  index __PFNx, __PFNibbles, NA
  xor __PFTmp, 0xF, __PFNx
  index __PFNx, __PFNibbles, 1
  xor __PFTmp, __PFTmp, __PFNx
  index __PFNx, __PFNibbles, 2
  xor __PFTmp, __PFTmp, __PFNx
  jmp __PFEndPowerFuncModeCheck
__PFUseIRTrainMode:
  index __PFNx, __PFNibbles, NA
  sub __PFTmp, 0xF, __PFNx
  index __PFNx, __PFNibbles, 1
  sub __PFTmp, __PFTmp, __PFNx
  index __PFNx, __PFNibbles, 2
  sub __PFTmp, __PFTmp, __PFNx
__PFEndPowerFuncModeCheck:
  replace __PFNibbles, __PFNibbles, 3, __PFTmp
  return
ends

subroutine __PFComboDirectSub
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  replace __PFNibbles, __PFNibbles, 1, PF_MODE_COMBO_DIRECT
  mul __PF_p3, __PF_p3, 4
  add __PF_p3, __PF_p3, __PF_p2
  replace __PFNibbles, __PFNibbles, 2, __PF_p3
  return
ends

subroutine __PFSinglePinSub
  call __PFApplyToggle
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  set __PF_p1, PF_MODE_SINGLE_PIN_TIME
  brtst EQ, __PFEndIfSPContinuous, __PF_p5
  set __PF_p1, PF_MODE_SINGLE_PIN_CONT
__PFEndIfSPContinuous:
  replace __PFNibbles, __PFNibbles, 1, __PF_p1
  mul __PF_p2, __PF_p2, 8
  mul __PF_p3, __PF_p3, 4
  add __PF_p2, __PF_p2, __PF_p3
  add __PF_p2, __PF_p2, __PF_p4
  replace __PFNibbles, __PFNibbles, 2, __PF_p2
  call __PFUpdateToggle
  return
ends

subroutine __PFSingleOutputSub
  call __PFApplyToggle
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  set __PF_p1, PF_MODE_SINGLE_OUTPUT_PWM
  brtst EQ, __PFEndIfSOCst, __PF_p4
  set __PF_p1, PF_MODE_SINGLE_OUTPUT_CST
__PFEndIfSOCst:
  add __PF_p1, __PF_p1, __PF_p2
  replace __PFNibbles, __PFNibbles, 1, __PF_p1
  replace __PFNibbles, __PFNibbles, 2, __PF_p3
  call __PFUpdateToggle
  return
ends

subroutine __PFComboPWMSub
  add __PF_p1, __PF_p1, PF_MODE_COMBO_PWM
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  replace __PFNibbles, __PFNibbles, 1, __PF_p3
  replace __PFNibbles, __PFNibbles, 2, __PF_p2
  return
ends

subroutine __PFTrainSub
  call __PFApplyToggle
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  replace __PFNibbles, __PFNibbles, 1, PF_MODE_TRAIN
  replace __PFNibbles, __PFNibbles, 2, __PF_p2
  call __PFUpdateToggle
  return
ends

subroutine __RCTrainSub
  call __RCApplyToggle
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  replace __PFNibbles, __PFNibbles, 1, PF_MODE_TRAIN
  replace __PFNibbles, __PFNibbles, 2, __PF_p2
  call __RCUpdateToggle
  return
ends

subroutine __PFRawOutputSub
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  replace __PFNibbles, __PFNibbles, 1, __PF_p2
  replace __PFNibbles, __PFNibbles, 2, __PF_p3
  return
ends

dseg segment

TRCXCommand struct
 Port byte
 Address byte
 ResponseBytes byte
 Command byte[]
 Response byte[]
TRCXCommand ends

  __gRCXCmd TRCXCommand
  __RCXCmdMutex mutex

dseg ends

#endif

#endif // NBC_RCXAPI_H
