/** \file pflink_constants.h
 * \brief The NBC/NXC Power Function constants
 *
 * pflink_constants.h contains the NBC/NXC Power Function constants
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

#ifndef PFLINK_CONSTANTS_H
#define PFLINK_CONSTANTS_H

/** @addtogroup ThirdPartyDevices
 * @{
 */

/** @defgroup HTIRLinkPFConstants HiTechnic/mindsensors Power Function/IR Train constants
 * Constants that are for use with the HiTechnic IRLink or mindsensors nRLink
 * in Power Function or IR Train mode.
 * @{
 */
/** @defgroup PFCmdConstants Power Function command constants
 * Constants that are for sending Power Function commands.
 * @{
 */
#define PF_CMD_STOP  0 /*!< Power function command stop */
#define PF_CMD_FLOAT 0 /*!< Power function command float (same as stop) */
#define PF_CMD_FWD   1 /*!< Power function command forward */
#define PF_CMD_REV   2 /*!< Power function command reverse */
#define PF_CMD_BRAKE 3 /*!< Power function command brake */
/** @} */  // end of PFCmdConstants group

/** @defgroup PFChannelConstants Power Function channel constants
 * Constants that are for specifying Power Function channels.
 * @{
 */
#define PF_CHANNEL_1 0 /*!< Power function channel 1 */
#define PF_CHANNEL_2 1 /*!< Power function channel 2 */
#define PF_CHANNEL_3 2 /*!< Power function channel 3 */
#define PF_CHANNEL_4 3 /*!< Power function channel 4 */
/** @} */  // end of PFChannelConstants group

/** @defgroup PFModeConstants Power Function mode constants
 * Constants that are for choosing Power Function modes.
 * @{
 */
#define PF_MODE_TRAIN             0 /*!< Power function mode IR Train */
#define PF_MODE_COMBO_DIRECT      1 /*!< Power function mode combo direct */
#define PF_MODE_SINGLE_PIN_CONT   2 /*!< Power function mode single pin continuous */
#define PF_MODE_SINGLE_PIN_TIME   3 /*!< Power function mode single pin timed */
#define PF_MODE_COMBO_PWM         4 /*!< Power function mode combo pulse width modulation (PWM) */
#define PF_MODE_SINGLE_OUTPUT_PWM 4 /*!< Power function mode single output pulse width modulation (PWM) */
#define PF_MODE_SINGLE_OUTPUT_CST 6 /*!< Power function mode single output clear, set, toggle (CST) */
/** @} */  // end of PFModeConstants group

/** @defgroup IRTrainFuncs PF/IR Train function constants
 * Constants that are for sending PF/IR Train functions.
 * @{
 */
#define TRAIN_FUNC_STOP         0 /*!< PF/IR Train function stop */
#define TRAIN_FUNC_INCR_SPEED   1 /*!< PF/IR Train function increment speed */
#define TRAIN_FUNC_DECR_SPEED   2 /*!< PF/IR Train function decrement speed */
#define TRAIN_FUNC_TOGGLE_LIGHT 4 /*!< PF/IR Train function toggle light */
/** @} */  // end of IRTrainFuncs group

/** @defgroup IRTrainChannels IR Train channel constants
 * Constants that are for specifying IR Train channels.
 * @{
 */
#define TRAIN_CHANNEL_1   0 /*!< IR Train channel 1 */
#define TRAIN_CHANNEL_2   1 /*!< IR Train channel 2 */
#define TRAIN_CHANNEL_3   2 /*!< IR Train channel 3 */
#define TRAIN_CHANNEL_ALL 3 /*!< IR Train channel all */
/** @} */  // end of IRTrainChannels group

/** @defgroup PFOutputs Power Function output constants
 * Constants that are for choosing a Power Function output.
 * @{
 */
#define PF_OUT_A 0 /*!< Power function output A */
#define PF_OUT_B 1 /*!< Power function output B */
/** @} */  // end of PFOutputs group

/** @defgroup PFPinConstants Power Function pin constants
 * Constants that are for choosing a Power Function pin.
 * @{
 */
#define PF_PIN_C1 0 /*!< Power function pin C1 */
#define PF_PIN_C2 1 /*!< Power function pin C2 */
/** @} */  // end of PFOutputs group

/** @defgroup PFPinFuncs Power Function single pin function constants
 * Constants that are for sending Power Function single pin functions.
 * @{
 */
#define PF_FUNC_NOCHANGE 0 /*!< Power function single pin - no change */
#define PF_FUNC_CLEAR    1 /*!< Power function single pin - clear */
#define PF_FUNC_SET      2 /*!< Power function single pin - set */
#define PF_FUNC_TOGGLE   3 /*!< Power function single pin - toggle */
/** @} */  // end of PFCSTFuncs group

/** @defgroup PFCSTOptions Power Function CST options constants
 * Constants that are for specifying Power Function CST options.
 * @{
 */
#define PF_CST_CLEAR1_CLEAR2 0 /*!< Power function CST clear 1 and clear 2 */
#define PF_CST_SET1_CLEAR2   1 /*!< Power function CST set 1 and clear 2*/
#define PF_CST_CLEAR1_SET2   2 /*!< Power function CST clear 1 and set 2 */
#define PF_CST_SET1_SET2     3 /*!< Power function CST set 1 and set 2 */
#define PF_CST_INCREMENT_PWM 4 /*!< Power function CST increment PWM */
#define PF_CST_DECREMENT_PWM 5 /*!< Power function CST decrement PWM */
#define PF_CST_FULL_FWD      6 /*!< Power function CST full forward */
#define PF_CST_FULL_REV      7 /*!< Power function CST full reverse */
#define PF_CST_TOGGLE_DIR    8 /*!< Power function CST toggle direction*/
/** @} */  // end of PFCSTOptions group

/** @defgroup PFPWMOptions Power Function PWM option constants
 * Constants that are for specifying Power Function PWM options.
 * @{
 */
#define PF_PWM_FLOAT 0  /*!< Power function PWM float */
#define PF_PWM_FWD1  1  /*!< Power function PWM foward level 1 */
#define PF_PWM_FWD2  2  /*!< Power function PWM foward level 2 */
#define PF_PWM_FWD3  3  /*!< Power function PWM foward level 3 */
#define PF_PWM_FWD4  4  /*!< Power function PWM foward level 4 */
#define PF_PWM_FWD5  5  /*!< Power function PWM foward level 5 */
#define PF_PWM_FWD6  6  /*!< Power function PWM foward level 6 */
#define PF_PWM_FWD7  7  /*!< Power function PWM foward level 7 */
#define PF_PWM_BRAKE 8  /*!< Power function PWM brake */
#define PF_PWM_REV7  9  /*!< Power function PWM reverse level 7  */
#define PF_PWM_REV6  10 /*!< Power function PWM reverse level 6 */
#define PF_PWM_REV5  11 /*!< Power function PWM reverse level 5 */
#define PF_PWM_REV4  12 /*!< Power function PWM reverse level 4 */
#define PF_PWM_REV3  13 /*!< Power function PWM reverse level 3 */
#define PF_PWM_REV2  14 /*!< Power function PWM reverse level 2 */
#define PF_PWM_REV1  15 /*!< Power function PWM reverse level 1 */
/** @} */  // end of PFPWMOptions group
/** @} */  // end of HTIRLinkPFConstants group

/** @} */ // end of ThirdPartyDevices group

#endif // PFLINK_CONSTANTS_H
