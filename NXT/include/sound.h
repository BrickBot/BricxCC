/** \file sound.h
 * \brief The NXC sound module API
 *
 * sound.h contains the NXC sound module API
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

#ifndef SOUND_H
#define SOUND_H

#include "sound_constants.h"

#ifndef __DOXYGEN_DOCS
asm { asminclude "nbc_sound.h" }
#endif

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// SOUND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup SoundModule
 * @{
 */
/** @defgroup SoundModuleTypes Sound module types
 * Types used by various sound module functions.
 * @{
 */

/**
 * Type used with the PlayTones API function.
 * An array of this structure is used when calling the \ref PlayTones
 * API function.
 * \sa PlayTones()
 */
struct Tone {
  unsigned int Frequency; /*!< The tone frequency. See the \ref ToneConstants group. */
  unsigned int Duration;  /*!< The tone duration in milliseconds. See the \ref TimeConstants group. */
};

/**
 * Parameters for the SoundPlayFile system call.
 * This structure is used when calling the \ref SysSoundPlayFile system call
 * function.
 * \sa SysSoundPlayFile()
 */
struct SoundPlayFileType {
  char Result;       /*!< The function call result, always \ref NO_ERR. */
  string Filename;   /*!< The name of the file to play. */
  bool Loop;         /*!< If true, loops at end of file. */
  byte SoundLevel;   /*!< The sound level. Valid values range from 0 to 4. */
};

/**
 * Parameters for the SoundPlayTone system call.
 * This structure is used when calling the \ref SysSoundPlayTone system call
 * function.
 * \sa SysSoundPlayTone()
 */
struct SoundPlayToneType {
  char Result;              /*!< The function call result, always \ref NO_ERR. */
  unsigned int Frequency;   /*!< The tone frequency. See the \ref ToneConstants group. */
  unsigned int Duration;    /*!< The tone duration in milliseconds. See the \ref TimeConstants group. */
  bool Loop;                /*!< If true, loops forever. */
  byte SoundLevel;          /*!< The sound level. Valid values range from 0 to 4. */
};

/**
 * Parameters for the SoundGetState system call.
 * This structure is used when calling the \ref SysSoundGetState system call
 * function.
 * \sa SysSoundGetState()
 */
struct SoundGetStateType {
  byte State;   /*!< The returned sound state. See the \ref SoundStateConstants group. */
  byte Flags;   /*!< The returned sound flags. See the \ref SoundFlagsConstants group. */
};

/**
 * Parameters for the SoundSetState system call.
 * This structure is used when calling the \ref SysSoundSetState system call
 * function.
 * \sa SysSoundSetState()
 */
struct SoundSetStateType {
  byte Result;   /*!< The function call result, same as State. */
  byte State;    /*!< The new sound state. See the \ref SoundStateConstants group. */
  byte Flags;    /*!< The new sound flags. See the \ref SoundFlagsConstants group. */
};

/** @} */ // end of SoundModuleTypes group

/** @defgroup SoundModuleFunctions Sound module functions
 * Functions for accessing and modifying sound module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS

/**
 * Play a file.
 * Play the specified file. The filename may be any valid string expression.
 * The sound file can either be an RSO file containing PCM or compressed ADPCM
 * samples or it can be an NXT melody (RMD) file containing frequency and
 * duration values.
 *
 * \param filename The name of the sound or melody file to play.
 */
inline char PlayFile(string filename);

/**
 * Play a file with extra options.
 * Play the specified file. The filename may be any valid string expression.
 * Volume should be a number from 0 (silent) to 4 (loudest). Play the file
 * repeatedly if loop is true.
 * The sound file can either be an RSO file containing PCM or compressed ADPCM
 * samples or it can be an NXT melody (RMD) file containing frequency and
 * duration values.
 *
 * \param filename The name of the sound or melody file to play.
 * \param volume The desired tone volume.
 * \param loop A boolean flag indicating whether to play the file repeatedly.
 * \param sr An optional sample rate at which to play the sound file. A value
 * of zero means to use the sample rate specified in the sound file header.
 */
inline char PlayFileEx(string filename, byte volume, bool loop, unsigned int sr = 0);

/**
 * Play a tone.
 * Play a single tone of the specified frequency and duration. The frequency is
 * in Hz (see the \ref ToneConstants group). The duration is in 1000ths of a
 * second (see the \ref TimeConstants group). The tone is played at the loudest
 * sound level supported by the firmware and it is not looped.
 *
 * \param frequency The desired tone frequency, in Hz.
 * \param duration The desired tone duration, in ms.
 */
inline char PlayTone(unsigned int frequency, unsigned int duration);

/**
 * Play a tone with extra options.
 * Play a single tone of the specified frequency, duration, and volume. The
 * frequency is in Hz (see the \ref ToneConstants group). The duration is in
 * 1000ths of a second (see the \ref TimeConstants group). Volume should be a
 * number from 0 (silent) to 4 (loudest). Play the tone repeatedly if loop is
 * true.
 *
 * \param frequency The desired tone frequency, in Hz.
 * \param duration The desired tone duration, in ms.
 * \param volume The desired tone volume.
 * \param loop A boolean flag indicating whether to play the tone repeatedly.
 */
inline char PlayToneEx(unsigned int frequency, unsigned int duration, byte volume, bool loop);

/**
 * Get sound module state.
 * Return the current sound module state. See the \ref SoundStateConstants group.
 *
 * \sa SetSoundModuleState(), SysSoundSetState(), SysSoundGetState()
 * \return The current sound module state.
 */
inline byte SoundState();

/**
 * Get sound module flags.
 * Return the current sound module flags. See the \ref SoundFlagsConstants group.
 *
 * \sa SetSoundFlags(), SysSoundSetState(), SysSoundGetState()
 * \return The current sound module flags.
 */
inline byte SoundFlags();

/**
 * Stop sound.
 * Stop playing of the current tone or file.
 *
 * \return The result \todo ?.
 */
inline byte StopSound();

/**
 * Get sound frequency.
 * Return the current sound frequency.
 *
 * \sa SetSoundFrequency()
 * \return The current sound frequency.
 */
inline unsigned int SoundFrequency();

/**
 * Get sound duration.
 * Return the current sound duration.
 *
 * \sa SetSoundDuration()
 * \return The current sound duration.
 */
inline unsigned int SoundDuration();

/**
 * Get sample rate.
 * Return the current sound sample rate.
 *
 * \sa SetSoundSampleRate()
 * \return The current sound sample rate.
 */
inline unsigned int SoundSampleRate();

/**
 * Get sound mode.
 * Return the current sound mode.  See the \ref SoundModeConstants group.
 *
 * \sa SetSoundMode()
 * \return The current sound mode.
 */
inline byte SoundMode();

/**
 * Get volume.
 * Return the current sound volume.
 *
 * \sa SetSoundVolume()
 * \return The current sound volume.
 */
inline byte SoundVolume();

/**
 * Set sound duration.
 * Set the sound duration.
 *
 * \sa SoundDuration()
 * \param duration The new sound duration
 */
inline void SetSoundDuration(unsigned int duration);

/**
 * Set sound module flags.
 * Set the sound module flags. See the \ref SoundFlagsConstants group.
 *
 * \sa SetSoundFlags(), SysSoundSetState(), SysSoundGetState()
 * \param flags The new sound module flags
 */
inline void SetSoundFlags(byte flags);

/**
 * Set sound frequency.
 * Set the sound frequency.
 *
 * \sa SoundFrequency()
 * \param frequency The new sound frequency
 */
inline void SetSoundFrequency(unsigned int frequency);

/**
 * Set sound mode.
 * Set the sound mode.  See the \ref SoundModeConstants group.
 *
 * \sa SoundMode()
 * \param mode The new sound mode
 */
inline void SetSoundMode(byte mode);

/**
 * Set sound module state.
 * Set the sound module state. See the \ref SoundStateConstants group.
 *
 * \sa SoundState(), SysSoundSetState(), SysSoundGetState()
 * \param state The new sound state
 */
inline void SetSoundModuleState(byte state);

/**
 * Set sample rate.
 * Set the sound sample rate.
 *
 * \sa SoundSampleRate()
 * \param sampleRate The new sample rate
 */
inline void SetSoundSampleRate(unsigned int sampleRate);

/**
 * Set sound volume.
 * Set the sound volume.
 *
 * \sa SoundVolume()
 * \param volume The new volume
 */
inline void SetSoundVolume(byte volume);

/**
 * Play sound file.
 * This function lets you play a sound file given the parameters you pass in
 * via the \ref SoundPlayFileType structure. The sound file can either be an
 * RSO file containing PCM or compressed ADPCM samples or it can be an NXT
 * melody (RMD) file containing frequency and duration values.
 *
 * \param args The SoundPlayFileType structure containing the needed
 * parameters.
 */
inline void SysSoundPlayFile(SoundPlayFileType & args);

/**
 * Play tone.
 * This function lets you play a tone given the parameters you pass in via the
 * \ref SoundPlayToneType structure.
 *
 * \param args The SoundPlayToneType structure containing the needed
 * parameters.
 */
inline void SysSoundPlayTone(SoundPlayToneType & args);

/**
 * Get sound state.
 * This function lets you retrieve information about the sound module state
 * via the \ref SoundGetStateType structure.
 *
 * \param args The SoundGetStateType structure containing the needed
 * parameters.
 */
inline void SysSoundGetState(SoundGetStateType & args);

/**
 * Set sound state.
 * This function lets you set sound module state settings via the \ref
 * SoundSetStateType structure.
 *
 * \param args The SoundSetStateType structure containing the needed
 * parameters.
 */
inline void SysSoundSetState(SoundSetStateType & args);

#else

#define PlayTone(_f, _d) PlayToneEx(_f, _d, 4, 0)
#define PlayFile(_f) PlayFileEx(_f, 4, 0)

#define SoundState() asm { GetSoundState(__RETVAL__, __TMPBYTE__) }
#define SoundFlags() asm { GetSoundState(__TMPBYTE__, __RETVAL__) }
#define StopSound() asm { __setSoundState(SOUND_STATE_STOP, 0, __RETVAL__) }

#define SoundFrequency() asm { GetSoundFrequency(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundDuration() asm { GetSoundDuration(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundSampleRate() asm { GetSoundSampleRate(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundMode() asm { GetSoundMode(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SoundVolume() asm { GetSoundVolume(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define SetSoundFrequency(_n) asm { __setSoundFrequency(_n) }
#define SetSoundDuration(_n) asm { __setSoundDuration(_n) }
#define SetSoundSampleRate(_n) asm { __setSoundSampleRate(_n) }
#define SetSoundFlags(_n) asm { __setSoundFlags(_n) }
#define SetSoundModuleState(_n) asm { __setSoundModuleState(_n) }
#define SetSoundMode(_n) asm { __setSoundMode(_n) }
#define SetSoundVolume(_n) asm { __setSoundVolume(_n) }

#define SysSoundPlayFile(_args) asm { \
  compchktype _args, SoundPlayFileType \
  syscall SoundPlayFile, _args \
}
#define SysSoundPlayTone(_args) asm { \
  compchktype _args, SoundPlayToneType \
  syscall SoundPlayTone, _args \
}
#define SysSoundGetState(_args) asm { \
  compchktype _args, SoundGetStateType \
  syscall SoundGetState, _args \
}
#define SysSoundSetState(_args) asm { \
  compchktype _args, SoundSetStateType \
  syscall SoundSetState, _args \
}

#endif

/**
 * Play a system sound.
 * Play a sound that mimics the RCX system sounds using one of the
 * \ref RCXSoundConstants.
 * <TABLE BORDER=1>
 * <TR><TH>aCode</TH><TH>Resulting Sound</TH></TR>
 * <TR><TD>\ref SOUND_CLICK</TD><TD>key click sound</TD></TR>
 * <TR><TD>\ref SOUND_DOUBLE_BEEP</TD><TD>double beep</TD></TR>
 * <TR><TD>\ref SOUND_DOWN</TD><TD>sweep down</TD></TR>
 * <TR><TD>\ref SOUND_UP</TD><TD>sweep up</TD></TR>
 * <TR><TD>\ref SOUND_LOW_BEEP</TD><TD>error sound</TD></TR>
 * <TR><TD>\ref SOUND_FAST_UP</TD><TD>fast sweep up</TD></TR>
 * </TABLE>
 * \param aCode The system sound to play.  See \ref RCXSoundConstants.
 */
void PlaySound(const int &aCode)
{
    if (aCode == SOUND_CLICK)
        PlayTone(600, MS_200);
    else if (aCode == SOUND_DOUBLE_BEEP)
    {
        PlayTone(600, MS_150);
        asm { wait MS_200 };
        PlayTone(600, MS_150);
        asm { wait MS_150 };
    }
    else if (aCode == SOUND_UP)
        for (int i = 4; i < 8; i++)
        {
            PlayTone(TONE_C5 * i / 4, MS_100);
            asm { wait MS_100 };
        }
    else if (aCode == SOUND_DOWN)
        for (int i = 7; i > 3; i--)
        {
            PlayTone(TONE_C5 * i / 4, MS_100);
            asm { wait MS_100 };
        }
    else if (aCode == SOUND_LOW_BEEP)
    {
        PlayTone(100, MS_500);
        asm { wait MS_500 };
    }
    else if (aCode == SOUND_FAST_UP)
        for (int i = 4; i < 8; i++)
        {
            PlayTone(TONE_C5 * i / 4, MS_50);
            asm { wait MS_50 };
        }
}

/**
 * Play multiple tones.
 * Play a series of tones contained in the tones array.  Each element
 * in the array is an instance of the \ref Tone structure, containing
 * a frequency and a duration.
 *
 * \param tones The array of tones to play.
 */
void PlayTones(Tone tones[])
{
  for (int i = 0; i <  asm { arrsize __RETVAL__, tones }; i++) {
    Tone tmp = tones[i];
    PlayTone(tmp.Frequency, tmp.Duration);
    asm { waitv tmp.Duration };
  }
}

/** @} */ // end of SoundModuleFunctions group
/** @} */ // end of SoundModule group
/** @} */ // end of NXTFirmwareModules group

#endif // SOUND_H
