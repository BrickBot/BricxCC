/** \file iomap_constants.h
 * \brief The NBC/NXC IOMap data address constants
 *
 * iomap_constants.h contains the NBC/NXC IOMap data address constants
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

#ifndef IOMAP_CONSTANTS_H
#define IOMAP_CONSTANTS_H

#if __FIRMWARE_VERSION <= 107
/** @defgroup IOMapAddressConstants Direct IOMap data addresses
 * Constants for use in direct IOMap addressing (1.0x only).
 * @{
 */
#define IO_BASE    0xC000
#define MOD_INPUT  0x0000
#define MOD_OUTPUT 0x0200
#define IO_IN_FPP  6
#define IO_OUT_FPP 15

#define InputIOType(p)            (IO_BASE+MOD_INPUT+TypeField+((p)*IO_IN_FPP))
#define InputIOInputMode(p)       (IO_BASE+MOD_INPUT+InputModeField+((p)*IO_IN_FPP))
#define InputIORawValue(p)        (IO_BASE+MOD_INPUT+RawValueField+((p)*IO_IN_FPP))
#define InputIONormalizedValue(p) (IO_BASE+MOD_INPUT+NormalizedValueField+((p)*IO_IN_FPP))
#define InputIOScaledValue(p)     (IO_BASE+MOD_INPUT+ScaledValueField+((p)*IO_IN_FPP))
#define InputIOInvalidData(p)     (IO_BASE+MOD_INPUT+InvalidDataField+((p)*IO_IN_FPP))

#define OutputIOUpdateFlags(p)     (IO_BASE+MOD_OUTPUT+UpdateFlagsField+((p)*IO_OUT_FPP))
#define OutputIOOutputMode(p)      (IO_BASE+MOD_OUTPUT+OutputModeField+((p)*IO_OUT_FPP))
#define OutputIOPower(p)           (IO_BASE+MOD_OUTPUT+PowerField+((p)*IO_OUT_FPP))
#define OutputIOActualSpeed(p)     (IO_BASE+MOD_OUTPUT+ActualSpeedField+((p)*IO_OUT_FPP))
#define OutputIOTachoCount(p)      (IO_BASE+MOD_OUTPUT+TachoCountField+((p)*IO_OUT_FPP))
#define OutputIOTachoLimit(p)      (IO_BASE+MOD_OUTPUT+TachoLimitField+((p)*IO_OUT_FPP))
#define OutputIORunState(p)        (IO_BASE+MOD_OUTPUT+RunStateField+((p)*IO_OUT_FPP))
#define OutputIOTurnRatio(p)       (IO_BASE+MOD_OUTPUT+TurnRatioField+((p)*IO_OUT_FPP))
#define OutputIORegMode(p)         (IO_BASE+MOD_OUTPUT+RegModeField+((p)*IO_OUT_FPP))
#define OutputIOOverload(p)        (IO_BASE+MOD_OUTPUT+OverloadField+((p)*IO_OUT_FPP))
#define OutputIORegPValue(p)       (IO_BASE+MOD_OUTPUT+RegPValueField+((p)*IO_OUT_FPP))
#define OutputIORegIValue(p)       (IO_BASE+MOD_OUTPUT+RegIValueField+((p)*IO_OUT_FPP))
#define OutputIORegDValue(p)       (IO_BASE+MOD_OUTPUT+RegDValueField+((p)*IO_OUT_FPP))
#define OutputIOBlockTachoCount(p) (IO_BASE+MOD_OUTPUT+BlockTachoCountField+((p)*IO_OUT_FPP))
#define OutputIORotationCount(p)   (IO_BASE+MOD_OUTPUT+RotationCountField+((p)*IO_OUT_FPP))

#define InputIOType0             0xc000
#define InputIOInputMode0        0xc001
#define InputIORawValue0         0xc002
#define InputIONormalizedValue0  0xc003
#define InputIOScaledValue0      0xc004
#define InputIOInvalidData0      0xc005
#define InputIOType1             0xc006
#define InputIOInputMode1        0xc007
#define InputIORawValue1         0xc008
#define InputIONormalizedValue1  0xc009
#define InputIOScaledValue1      0xc00a
#define InputIOInvalidData1      0xc00b
#define InputIOType2             0xc00c
#define InputIOInputMode2        0xc00d
#define InputIORawValue2         0xc00e
#define InputIONormalizedValue2  0xc00f
#define InputIOScaledValue2      0xc010
#define InputIOInvalidData2      0xc011
#define InputIOType3             0xc012
#define InputIOInputMode3        0xc013
#define InputIORawValue3         0xc014
#define InputIONormalizedValue3  0xc015
#define InputIOScaledValue3      0xc016
#define InputIOInvalidData3      0xc017
// output IO Map addresses
#define OutputIOUpdateFlags0     0xc200
#define OutputIOOutputMode0      0xc201
#define OutputIOPower0           0xc202
#define OutputIOActualSpeed0     0xc203
#define OutputIOTachoCount0      0xc204
#define OutputIOTachoLimit0      0xc205
#define OutputIORunState0        0xc206
#define OutputIOTurnRatio0       0xc207
#define OutputIORegMode0         0xc208
#define OutputIOOverload0        0xc209
#define OutputIORegPValue0       0xc20a
#define OutputIORegIValue0       0xc20b
#define OutputIORegDValue0       0xc20c
#define OutputIOBlockTachoCount0 0xc20d
#define OutputIORotationCount0   0xc20e
#define OutputIOUpdateFlags1     0xc20f
#define OutputIOOutputMode1      0xc210
#define OutputIOPower1           0xc211
#define OutputIOActualSpeed1     0xc212
#define OutputIOTachoCount1      0xc213
#define OutputIOTachoLimit1      0xc214
#define OutputIORunState1        0xc215
#define OutputIOTurnRatio1       0xc216
#define OutputIORegMode1         0xc217
#define OutputIOOverload1        0xc218
#define OutputIORegPValue1       0xc219
#define OutputIORegIValue1       0xc21a
#define OutputIORegDValue1       0xc21b
#define OutputIOBlockTachoCount1 0xc21c
#define OutputIORotationCount1   0xc21d
#define OutputIOUpdateFlags2     0xc21e
#define OutputIOOutputMode2      0xc21f
#define OutputIOPower2           0xc220
#define OutputIOActualSpeed2     0xc221
#define OutputIOTachoCount2      0xc222
#define OutputIOTachoLimit2      0xc223
#define OutputIORunState2        0xc224
#define OutputIOTurnRatio2       0xc225
#define OutputIORegMode2         0xc226
#define OutputIOOverload2        0xc227
#define OutputIORegPValue2       0xc228
#define OutputIORegIValue2       0xc229
#define OutputIORegDValue2       0xc22a
#define OutputIOBlockTachoCount2 0xc22b
#define OutputIORotationCount2   0xc22c
/** @} */  // end of IOMapAddressConstants group
#endif

#endif // IOMAP_CONSTANTS_H
