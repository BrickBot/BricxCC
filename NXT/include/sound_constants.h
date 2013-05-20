/** \file sound_constants.h
 * \brief NXC Sound module constants
 *
 * sound_constants.h contains NXC Sound module constants
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

#ifndef SOUND_CONSTANTS_H
#define SOUND_CONSTANTS_H

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// SOUND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup SoundModule
 * @{
 */

/** @defgroup SoundModuleConstants Sound module constants
 * Constants that are part of the NXT firmware's Sound module.
 * @{
 */

/** @defgroup SoundFlagsConstants SoundFlags constants
 * Constants for use with the SoundFlags() function.
 * \sa SoundFlags()
 * @{
 */
#define SOUND_FLAGS_IDLE    0x00 /*!< R  - Sound is idle */
#define SOUND_FLAGS_UPDATE  0x01 /*!< W  - Make changes take effect */
#define SOUND_FLAGS_RUNNING 0x02 /*!< R  - Currently processing a tone or file */
/** @} */  // end of SoundFlagsConstants group

/** @defgroup SoundStateConstants SoundState constants
 * Constants for use with the SoundState() function.
 * \sa SoundState()
 * @{
 */
#define SOUND_STATE_IDLE 0x00 /*!< R  - Idle, ready for start sound (SOUND_UPDATE) */
#define SOUND_STATE_FILE 0x02 /*!< R  - Processing a file of sound/melody data */
#define SOUND_STATE_TONE 0x03 /*!< R  - Processing a play tone request */
#define SOUND_STATE_STOP 0x04 /*!< W  - Stop sound immediately and close hardware */
/** @} */  // end of SoundStateConstants group

/** @defgroup SoundModeConstants SoundMode constants
 * Constants for use with the SoundMode() function.
 * \sa SoundMode()
 * @{
 */
#define SOUND_MODE_ONCE 0x00 /*!< W  - Only play file once */
#define SOUND_MODE_LOOP 0x01 /*!< W  - Play file until writing SOUND_STATE_STOP into SoundState */
#define SOUND_MODE_TONE 0x02 /*!< W  - Play tone specified in Frequency for Duration ms */
/** @} */  // end of SoundModeConstants group

/** @defgroup SoundIOMAP Sound module IOMAP offsets
 * Constant offsets into the Sound module IOMAP structure.
 * @{
 */
#define SoundOffsetFreq           0 /*!< RW - Tone frequency [Hz] (2 bytes) */
#define SoundOffsetDuration       2 /*!< RW - Tone duration  [mS] (2 bytes) */
#define SoundOffsetSampleRate     4 /*!< RW - Sound file sample rate [2000..16000] (2 bytes) */
#define SoundOffsetSoundFilename  6 /*!< RW - Sound/melody filename (20 bytes) */
#define SoundOffsetFlags         26 /*!< RW - Play flag  - described above (1 byte) \ref SoundFlagsConstants */
#define SoundOffsetState         27 /*!< RW - Play state - described above (1 byte) \ref SoundStateConstants */
#define SoundOffsetMode          28 /*!< RW - Play mode  - described above (1 byte) \ref SoundModeConstants */
#define SoundOffsetVolume        29 /*!< RW - Sound/melody volume [0..4] 0 = off (1 byte) */
/** @} */  // end of SoundIOMAP group

/** @defgroup SoundMisc Sound module miscellaneous constants
 * Constants defining miscellaneous sound module aspects.
 * @{
 */
#define FREQUENCY_MIN       220       /*!< Minimum frequency [Hz] */
#define FREQUENCY_MAX       14080     /*!< Maximum frequency [Hz] */

#define SAMPLERATE_MIN      2000      /*!< Min sample rate [sps] */
#define SAMPLERATE_DEFAULT  8000      /*!< Default sample rate [sps] */
#define SAMPLERATE_MAX      16000     /*!< Max sample rate [sps] */
/** @} */  // end of SoundMisc group

/** @defgroup ToneConstants Tone constants
 * Constants for use in the  SoundPlayTone() API function.
 * \sa SoundPlayTone()
 * @{
 */
#define TONE_C3      131 /*!< Third octave C */
#define TONE_CS3     139 /*!< Third octave C sharp */
#define TONE_D3      147 /*!< Third octave D */
#define TONE_DS3     156 /*!< Third octave D sharp */
#define TONE_E3      165 /*!< Third octave E */
#define TONE_F3      175 /*!< Third octave F */
#define TONE_FS3     185 /*!< Third octave F sharp */
#define TONE_G3      196 /*!< Third octave G */
#define TONE_GS3     208 /*!< Third octave G sharp */
#define TONE_A3      220 /*!< Third octave A */
#define TONE_AS3     233 /*!< Third octave A sharp */
#define TONE_B3      247 /*!< Third octave B */
#define TONE_C4      262 /*!< Fourth octave C */
#define TONE_CS4     277 /*!< Fourth octave C sharp */
#define TONE_D4      294 /*!< Fourth octave D */
#define TONE_DS4     311 /*!< Fourth octave D sharp */
#define TONE_E4      330 /*!< Fourth octave E */
#define TONE_F4      349 /*!< Fourth octave F */
#define TONE_FS4     370 /*!< Fourth octave F sharp */
#define TONE_G4      392 /*!< Fourth octave G */
#define TONE_GS4     415 /*!< Fourth octave G sharp */
#define TONE_A4      440 /*!< Fourth octave A */
#define TONE_AS4     466 /*!< Fourth octave A sharp */
#define TONE_B4      494 /*!< Fourth octave B */
#define TONE_C5      523 /*!< Fifth octave C */
#define TONE_CS5     554 /*!< Fifth octave C sharp */
#define TONE_D5      587 /*!< Fifth octave D */
#define TONE_DS5     622 /*!< Fifth octave D sharp */
#define TONE_E5      659 /*!< Fifth octave E */
#define TONE_F5      698 /*!< Fifth octave F */
#define TONE_FS5     740 /*!< Fifth octave F sharp */
#define TONE_G5      784 /*!< Fifth octave G */
#define TONE_GS5     831 /*!< Fifth octave G sharp */
#define TONE_A5      880 /*!< Fifth octave A */
#define TONE_AS5     932 /*!< Fifth octave A sharp */
#define TONE_B5      988 /*!< Fifth octave B */
#define TONE_C6     1047 /*!< Sixth octave C */
#define TONE_CS6    1109 /*!< Sixth octave C sharp */
#define TONE_D6     1175 /*!< Sixth octave D */
#define TONE_DS6    1245 /*!< Sixth octave D sharp */
#define TONE_E6     1319 /*!< Sixth octave E */
#define TONE_F6     1397 /*!< Sixth octave F */
#define TONE_FS6    1480 /*!< Sixth octave F sharp */
#define TONE_G6     1568 /*!< Sixth octave G */
#define TONE_GS6    1661 /*!< Sixth octave G sharp */
#define TONE_A6     1760 /*!< Sixth octave A */
#define TONE_AS6    1865 /*!< Sixth octave A sharp */
#define TONE_B6     1976 /*!< Sixth octave B */
#define TONE_C7     2093 /*!< Seventh octave C */
#define TONE_CS7    2217 /*!< Seventh octave C sharp */
#define TONE_D7     2349 /*!< Seventh octave D */
#define TONE_DS7    2489 /*!< Seventh octave D sharp */
#define TONE_E7     2637 /*!< Seventh octave E */
#define TONE_F7     2794 /*!< Seventh octave F */
#define TONE_FS7    2960 /*!< Seventh octave F sharp */
#define TONE_G7     3136 /*!< Seventh octave G */
#define TONE_GS7    3322 /*!< Seventh octave G sharp */
#define TONE_A7     3520 /*!< Seventh octave A */
#define TONE_AS7    3729 /*!< Seventh octave A sharp */
#define TONE_B7     3951 /*!< Seventh octave B */
/** @} */  // end of ToneConstants group

/** @defgroup StandardSoundConstants Standard sound constants
 * Constants for use when playing standard brick sounds.
 * @{
 */
#define SOUND_CLICK       0 /*!< Play the standard key click sound */
#define SOUND_DOUBLE_BEEP 1 /*!< Play the standard double beep sound */
#define SOUND_DOWN        2 /*!< Play the standard sweep down sound */
#define SOUND_UP          3 /*!< Play the standard sweep up sound */
#define SOUND_LOW_BEEP    4 /*!< Play the standard low beep sound */
#define SOUND_FAST_UP     5 /*!< Play the standard fast up sound */
/** @} */  // end of StandardSoundConstants group

/** @} */  // end of SoundModuleConstants group
/** @} */  // end of SoundModule group

#endif // SOUND_CONSTANTS_H
