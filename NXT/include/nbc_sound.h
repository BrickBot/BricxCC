/** \file nbc_sound.h
 * \brief The NBC sound module API
 *
 * nbc_sound.h contains the NBC sound module API
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

#ifndef NBC_SOUND_H
#define NBC_SOUND_H

#include "sound_constants.h"
#include "nbc_command.h"

///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// SOUND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////

/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup SoundModule
 * @{
 */
/** @defgroup SoundModuleFunctions Sound module functions
 * Functions for accessing and modifying sound module features.
 * @{
 */

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else

// redefine these so we do not need to include misc_constants.h
#define TRUE 1
#define FALSE 0

dseg segment
// SoundPlayFile
TSoundPlayFile	struct
 Result		sbyte
 Filename	byte[]
 Loop		byte
 Volume		byte
TSoundPlayFile	ends

// SoundPlayTone
TSoundPlayTone	struct
 Result		sbyte
 Frequency	word
 Duration	word
 Loop		byte
 Volume		byte
TSoundPlayTone	ends

// SoundGetState
TSoundGetState	struct
 State		byte
 Flags		byte
TSoundGetState	ends

// SoundSetState
TSoundSetState	struct
 Result		byte
 State		byte
 Flags		byte
TSoundSetState	ends

// PlayFileEx
TPlayFileEx struct
 SampleRate word
 Filename	byte[]
 Flags		byte
 State		byte
 Mode		byte
 Volume		byte
TPlayFileEx ends

  __PlayToneTmp TSoundPlayTone
  __PlayFileTmp TPlayFileEx
  __SGSArgs TSoundGetState
  __SSSArgs TSoundSetState

  __PlayFileMutex mutex
  __PlayToneMutex mutex
  __SGSMutex mutex
  __SSSMutex mutex
ends

#define __PlayToneEx(_freq,_dur,_vol,_loop) \
  acquire __PlayToneMutex \
  mov __PlayToneTmp.Frequency, _freq \
  mov __PlayToneTmp.Duration, _dur \
  mov __PlayToneTmp.Volume, _vol \
  mov __PlayToneTmp.Loop, _loop \
  syscall SoundPlayTone, __PlayToneTmp \
  release __PlayToneMutex

#define __PlayFileEx(_file,_vol,_loop,_sr) \
  acquire __PlayFileMutex \
  mov __PlayFileTmp.SampleRate, _sr \
  arrinit __PlayFileTmp.Filename, 0, 20 \
  replace __PlayFileTmp.Filename, __PlayFileTmp.Filename, NA, _file \
  mov __PlayFileTmp.Volume, _vol \
  set __PlayFileTmp.Flags, SOUND_FLAGS_UPDATE \
  brtst EQ, __PFE_EndIf##__I__, _loop \
  set __PlayFileTmp.Mode, SOUND_MODE_LOOP \
  __PFE_EndIf##__I__: \
  __IncI__ \
  __SetSoundModuleValue(SoundOffsetSampleRate, __PlayFileTmp) \
  release __PlayFileMutex

#define __setSoundState(_state, _flags, _result) \
  acquire __SSSMutex \
  mov __SSSArgs.State, _state \
  mov __SSSArgs.Flags, _flags \
  syscall SoundSetState, __SSSArgs \
  mov _result, __SSSArgs.Result \
  release __SSSMutex

#define __GetSoundState(_state, _flags) \
  acquire __SGSMutex \
  syscall SoundGetState, __SGSArgs \
  mov _state, __SGSArgs.State \
  mov _flags, __SGSArgs.Flags \
  release __SGSMutex

#define __GetSoundFrequency(_n) \
  compchk EQ, sizeof(_n), 2 \
  __getSoundModuleValue(SoundOffsetFreq, _n)

#define __GetSoundDuration(_n) \
  compchk EQ, sizeof(_n), 2 \
  __getSoundModuleValue(SoundOffsetDuration, _n)

#define __GetSoundSampleRate(_n) \
  compchk EQ, sizeof(_n), 2 \
  __getSoundModuleValue(SoundOffsetSampleRate, _n)

#define __GetSoundMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getSoundModuleValue(SoundOffsetMode, _n)

#define __GetSoundVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  __getSoundModuleValue(SoundOffsetVolume, _n)

#define __setSoundFrequency(_n) \
  compchk EQ, sizeof(_n), 2 \
  __SetSoundModuleValue(SoundOffsetFreq, _n)

#define __setSoundDuration(_n) \
  compchk EQ, sizeof(_n), 2 \
  __SetSoundModuleValue(SoundOffsetDuration, _n)

#define __setSoundSampleRate(_n) \
  compchk EQ, sizeof(_n), 2 \
  __SetSoundModuleValue(SoundOffsetSampleRate, _n)

#define __setSoundFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetSoundModuleValue(SoundOffsetFlags, _n)

#define __setSoundModuleState(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetSoundModuleValue(SoundOffsetState, _n)

#define __setSoundMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetSoundModuleValue(SoundOffsetMode, _n)

#define __setSoundVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  __SetSoundModuleValue(SoundOffsetVolume, _n)

#endif

/**
 * Play a tone with extra options.
 * Play a single tone of the specified frequency, duration, and volume. The
 * frequency is in Hz (see the \ref ToneConstants group). The duration is in
 * 1000ths of a second (see the \ref TimeConstants group). Volume should be a
 * number from 0 (silent) to 4 (loudest). Play the tone repeatedly if loop is
 * true.
 *
 * \param _freq The desired tone frequency, in Hz.
 * \param _dur The desired tone duration, in ms.
 * \param _vol The desired tone volume.
 * \param _loop A boolean flag indicating whether to play the tone repeatedly.
 */
#define PlayToneEx(_freq,_dur,_vol,_loop) __PlayToneEx(_freq,_dur,_vol,_loop)

/**
 * Play a tone.
 * Play a single tone of the specified frequency and duration. The frequency is
 * in Hz (see the \ref ToneConstants group). The duration is in 1000ths of a
 * second (see the \ref TimeConstants group). The tone is played at the loudest
 * sound level supported by the firmware and it is not looped.
 *
 * \param _freq The desired tone frequency, in Hz.
 * \param _dur The desired tone duration, in ms.
 */
#define PlayTone(_freq,_dur) __PlayToneEx(_freq,_dur,4,0)

/**
 * Play a file.
 * Play the specified file. The filename may be any valid string expression.
 * The sound file can either be an RSO file containing PCM or compressed ADPCM
 * samples or it can be an NXT melody (RMD) file containing frequency and
 * duration values.
 *
 * \param _file The name of the sound or melody file to play.
 */
#define PlayFile(_file) __PlayFileEx(_file,4,0,0)

/**
 * Play a file with extra options.
 * Play the specified file. The filename may be any valid string expression.
 * Volume should be a number from 0 (silent) to 4 (loudest). Play the file
 * repeatedly if loop is true.
 * The sound file can either be an RSO file containing PCM or compressed ADPCM
 * samples or it can be an NXT melody (RMD) file containing frequency and
 * duration values.
 *
 * \param _file The name of the sound or melody file to play.
 * \param _vol The desired tone volume.
 * \param _loop A boolean flag indicating whether to play the file repeatedly.
 * \param _sr A sample rate at which to play the file.
 */
#define PlayFileEx(_file,_vol,_loop,_sr) __PlayFileEx(_file,_vol,_loop,_sr)

/**
 * Get sound module state and flags.
 * Return the current sound module state and flags.
 * See the \ref SoundStateConstants group.
 *
 * \sa SetSoundState
 * \param _state The current sound module state.
 * \param _flags The current sound module flags.
 */
#define GetSoundState(_state, _flags) __GetSoundState(_state, _flags)

/**
 * Set sound module state and flags.
 * Set the sound module state and flags.
 * See the \ref SoundStateConstants group.
 *
 * \sa GetSoundState
 * \param _state The sound module state.
 * \param _flags The sound module flags.
 * \param _result The function call result.
 */
#define SetSoundState(_state, _flags, _result) __setSoundState(_state, _flags, _result)

/**
 * Get sound frequency.
 * Return the current sound frequency.
 *
 * \sa SetSoundFrequency
 * \param _n The current sound frequency.
 */
#define GetSoundFrequency(_n) __GetSoundFrequency(_n)

/**
 * Get sound duration.
 * Return the current sound duration.
 *
 * \sa SetSoundDuration
 * \param _n The current sound duration.
 */
#define GetSoundDuration(_n) __GetSoundDuration(_n)

/**
 * Get sample rate.
 * Return the current sound sample rate.
 *
 * \sa SetSoundSampleRate
 * \param _n The current sound sample rate.
 */
#define GetSoundSampleRate(_n) __GetSoundSampleRate(_n)

/**
 * Get sound mode.
 * Return the current sound mode.  See the \ref SoundModeConstants group.
 *
 * \sa SetSoundMode
 * \param _n The current sound mode.
 */
#define GetSoundMode(_n) __GetSoundMode(_n)

/**
 * Get volume.
 * Return the current sound volume.
 *
 * \sa SetSoundVolume
 * \param _n The current sound volume.
 */
#define GetSoundVolume(_n) __GetSoundVolume(_n)

/**
 * Set sound duration.
 * Set the sound duration.
 *
 * \sa GetSoundDuration
 * \param _n The new sound duration
 */
#define SetSoundDuration(_n) __setSoundDuration(_n)

/**
 * Set sound module flags.
 * Set the sound module flags. See the \ref SoundFlagsConstants group.
 *
 * \param _n The new sound module flags
 */
#define SetSoundFlags(_n) __setSoundFlags(_n)

/**
 * Set sound frequency.
 * Set the sound frequency.
 *
 * \sa GetSoundFrequency
 * \param _n The new sound frequency
 */
#define SetSoundFrequency(_n) __setSoundFrequency(_n)

/**
 * Set sound mode.
 * Set the sound mode.  See the \ref SoundModeConstants group.
 *
 * \sa GetSoundMode
 * \param _n The new sound mode
 */
#define SetSoundMode(_n) __setSoundMode(_n)

/**
 * Set sound module state.
 * Set the sound module state. See the \ref SoundStateConstants group.
 *
 * \sa GetSoundState
 * \param _n The new sound state
 */
#define SetSoundModuleState(_n) __setSoundModuleState(_n)

/**
 * Set sample rate.
 * Set the sound sample rate.
 *
 * \sa GetSoundSampleRate
 * \param _n The new sample rate
 */
#define SetSoundSampleRate(_n) __setSoundSampleRate(_n)

/**
 * Set sound volume.
 * Set the sound volume.
 *
 * \sa GetSoundVolume
 * \param _n The new volume
 */
#define SetSoundVolume(_n) __setSoundVolume(_n)

/** @} */ // end of SoundModuleFunctions group
/** @} */ // end of SoundModule group
/** @} */ // end of NXTFirmwareModules group

#endif // NBC_SOUND_H
