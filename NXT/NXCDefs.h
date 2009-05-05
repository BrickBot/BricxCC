/*
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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * Workfile:: NXCDefs.h
 * Date:: 2009-05-01
 * Revision:: 49
 *
 * Contains declarations for the NXC NXT API resources
 *
 */
#ifndef NXCDEFS_H
#define NXCDEFS_H

#include "NBCCommon.h"

/*
#define and &&
#define and_eq &=
#define bitand &
#define bitor |
#define compl ~
#define not !
#define not_eq !=
#define or ||
#define or_eq |=
#define xor ^
#define xor_eq ^=
*/

#define u8 unsigned char
#define s8 char
#define u16 unsigned int
#define s16 int
#define u32 unsigned long
#define s32 long

#define S1 0
#define S2 1
#define S3 2
#define S4 3

#define SENSOR_1 Sensor(S1)
#define SENSOR_2 Sensor(S2)
#define SENSOR_3 Sensor(S3)
#define SENSOR_4 Sensor(S4)

#define SENSOR_TYPE_NONE            IN_TYPE_NO_SENSOR
#define SENSOR_TYPE_TOUCH           IN_TYPE_SWITCH
#define SENSOR_TYPE_TEMPERATURE     IN_TYPE_TEMPERATURE
#define SENSOR_TYPE_LIGHT           IN_TYPE_REFLECTION
#define SENSOR_TYPE_ROTATION        IN_TYPE_ANGLE
#define SENSOR_TYPE_LIGHT_ACTIVE    IN_TYPE_LIGHT_ACTIVE
#define SENSOR_TYPE_LIGHT_INACTIVE  IN_TYPE_LIGHT_INACTIVE
#define SENSOR_TYPE_SOUND_DB        IN_TYPE_SOUND_DB
#define SENSOR_TYPE_SOUND_DBA       IN_TYPE_SOUND_DBA
#define SENSOR_TYPE_CUSTOM          IN_TYPE_CUSTOM
#define SENSOR_TYPE_LOWSPEED        IN_TYPE_LOWSPEED
#define SENSOR_TYPE_LOWSPEED_9V     IN_TYPE_LOWSPEED_9V
#define SENSOR_TYPE_HIGHSPEED       IN_TYPE_HISPEED

#if __FIRMWARE_VERSION > 107
#define SENSOR_TYPE_COLORFULL       IN_TYPE_COLORFULL
#define SENSOR_TYPE_COLORRED        IN_TYPE_COLORRED
#define SENSOR_TYPE_COLORGREEN      IN_TYPE_COLORGREEN
#define SENSOR_TYPE_COLORBLUE       IN_TYPE_COLORBLUE
#define SENSOR_TYPE_COLORNONE       IN_TYPE_COLORNONE
#define SENSOR_TYPE_COLOREXIT       IN_TYPE_COLOREXIT
#endif

#define SENSOR_MODE_RAW		IN_MODE_RAW
#define SENSOR_MODE_BOOL	IN_MODE_BOOLEAN
#define SENSOR_MODE_EDGE	IN_MODE_TRANSITIONCNT
#define SENSOR_MODE_PULSE	IN_MODE_PERIODCOUNTER
#define SENSOR_MODE_PERCENT	IN_MODE_PCTFULLSCALE
#define SENSOR_MODE_CELSIUS	IN_MODE_CELSIUS
#define SENSOR_MODE_FAHRENHEIT	IN_MODE_FAHRENHEIT
#define SENSOR_MODE_ROTATION	IN_MODE_ANGLESTEP

#define _SENSOR_CFG(_type,_mode)	(((_type)<<8)+(_mode))
#define SENSOR_TOUCH		_SENSOR_CFG(SENSOR_TYPE_TOUCH, SENSOR_MODE_BOOL)
#define SENSOR_LIGHT		_SENSOR_CFG(SENSOR_TYPE_LIGHT, SENSOR_MODE_PERCENT)
#define SENSOR_ROTATION		_SENSOR_CFG(SENSOR_TYPE_ROTATION, SENSOR_MODE_ROTATION)
#define SENSOR_CELSIUS		_SENSOR_CFG(SENSOR_TYPE_TEMPERATURE, SENSOR_MODE_CELSIUS)
#define SENSOR_FAHRENHEIT	_SENSOR_CFG(SENSOR_TYPE_TEMPERATURE, SENSOR_MODE_FAHRENHEIT)
#define	SENSOR_PULSE		_SENSOR_CFG(SENSOR_TYPE_TOUCH, SENSOR_MODE_PULSE)
#define SENSOR_EDGE		_SENSOR_CFG(SENSOR_TYPE_TOUCH, SENSOR_MODE_EDGE)

#define SetSensor(_sensor, _tm) { SetSensorType(_sensor, _tm>>8); SetSensorMode(_sensor, _tm&0xff); }

#if __FIRMWARE_VERSION > 107
#define SetSensorColorFull(_port) asm { __SetSensorColorFull(_port) }
#define SetSensorColorRed(_port) asm { __SetSensorColorRed(_port) }
#define SetSensorColorGreen(_port) asm { __SetSensorColorGreen(_port) }
#define SetSensorColorBlue(_port) asm { __SetSensorColorBlue(_port) }
#define SetSensorColorNone(_port) asm { __SetSensorColorNone(_port) }

#define ReadSensorColorRaw(_port, _rawVals) asm { __ReadSensorColorRaw(_port, _rawVals, __RETVAL__) }
#define ReadSensorColorEx(_port, _colorval, _raw, _norm, _scaled) asm { __ReadSensorColorEx(_port, _colorval, _raw, _norm, _scaled, __RETVAL__) }
#endif

#define PlayTone(_f, _d) PlayToneEx(_f, _d, 4, 0)
#define PlayFile(_f) PlayFileEx(_f, 4, 0)
#define ClearScreen() asm { PointOutEx(200, 200, TRUE) }
#define FlattenVar(_value) asm { flatten __STRRETVAL__, _value }
#define UnflattenVar(_str, _value) asm { unflatten _value, __RETVAL__, _str, _value }
#define ArrayBuild(_aout, ...) asm { arrbuild _aout, __VA_ARGS__ }


// input fields
#define Sensor(_p) asm { ReadSensor(_p, __RETVAL__) }
#define SensorValue(_p) Sensor(_p)
#define SensorUS(_p) asm { ReadSensorUS(_p, __RETVAL__) }
#define SensorType(_p) GetInput(_p, Type)
#define SensorMode(_p) GetInput(_p, InputMode)
#define SensorRaw(_p) GetInput(_p, RawValue)
#define SensorNormalized(_p) GetInput(_p, NormalizedValue)
#define SensorScaled(_p) GetInput(_p, ScaledValue)
#define SensorInvalid(_p) GetInput(_p, InvalidData)
#define SensorValueBool(_p) SensorBoolean(_p)
#define SensorValueRaw(_p) SensorRaw(_p)


// output fields
#define MotorMode(_p) GetOutput(_p, OutputMode)
#define MotorPower(_p) GetOutput(_p, Power)
#define MotorActualSpeed(_p) GetOutput(_p, ActualSpeed)
#define MotorTachoCount(_p) GetOutput(_p, TachoCount)
#define MotorTachoLimit(_p) GetOutput(_p, TachoLimit)
#define MotorRunState(_p) GetOutput(_p, RunState)
#define MotorTurnRatio(_p) GetOutput(_p, TurnRatio)
#define MotorRegulation(_p) GetOutput(_p, RegMode)
#define MotorOverload(_p) GetOutput(_p, Overload)
#define MotorRegPValue(_p) GetOutput(_p, RegPValue)
#define MotorRegIValue(_p) GetOutput(_p, RegIValue)
#define MotorRegDValue(_p) GetOutput(_p, RegDValue)
#define MotorBlockTachoCount(_p) GetOutput(_p, BlockTachoCount)
#define MotorRotationCount(_p) GetOutput(_p, RotationCount)

#define until(_c) while(!(_c))

#define StopAllTasks() Stop(true)
#define StartTask(_t) start _t
#define StopTask(_t) stop _t

#define FreeMemory() asm { GetFreeMemory(__RETVAL__) }
#define BatteryLevel() asm { GetBatteryLevel(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundState() asm { GetSoundState(__RETVAL__, __TMPBYTE__) }
#define SoundFlags() asm { GetSoundState(__TMPBYTE__, __RETVAL__) }
#define StopSound() asm { __setSoundState(SOUND_STATE_STOP, 0, __RETVAL__) }
#define PowerDown() asm { SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_POWERDOWN) }
#define SleepNow() PowerDown()
#define RebootInFirmwareMode() asm { SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_BOOT) }
#define CurrentTick() asm { gettick __RETVAL__ }
#define FirstTick() asm { GetFirstTick(__RETVAL__) }
#define ResetSleepTimer() asm { acquire __KeepAliveMutex \
  syscall KeepAlive, __KeepAliveArgs \
  mov __RETVAL__, __KeepAliveArgs.Result \
  release __KeepAliveMutex }

#define IOMA(_n) asm { mov __RETVAL__, _n }
#define SetIOMA(_n, _val) asm { mov _n, _val }

#define ByteArrayToStr(_asrc) asm { arrtostr __STRRETVAL__, _asrc }
#define ByteArrayToStrEx(_asrc, _sout) asm { arrtostr _sout, _asrc }
#define StrToByteArray(_ssrc, _aout) asm { strtoarr _aout, _ssrc }
#define ArrayLen(_asrc) asm { arrsize __RETVAL__, _asrc }
#define ArrayInit(_aout, _val, _cnt) asm { arrinit _aout, _val, _cnt }
#define ArraySubset(_aout, _asrc, _idx, _len) asm { arrsubset _aout, _asrc, _idx, _len }

#define GetLSInputBuffer(_p, _offset, _cnt, _data) asm { __getLSInputBuffer(_p, _offset, _cnt, _data) }
#define GetLSOutputBuffer(_p, _offset, _cnt, _data) asm { __getLSOutputBuffer(_p, _offset, _cnt, _data) }
#define GetDisplayNormal(_x, _line, _cnt, _data) asm { __getDisplayNormal(_x, _line, _cnt, _data) }
#define GetDisplayPopup(_x, _line, _cnt, _data) asm { __getDisplayPopup(_x, _line, _cnt, _data) }
#define GetBTInputBuffer(_offset, _cnt, _data) asm { __getBTInputBuffer(_offset, _cnt, _data) }
#define GetBTOutputBuffer(_offset, _cnt, _data) asm { __getBTOutputBuffer(_offset, _cnt, _data) }
#define GetHSInputBuffer(_offset, _cnt, _data) asm { __getHSInputBuffer(_offset, _cnt, _data) }
#define GetHSOutputBuffer(_offset, _cnt, _data) asm { __getHSOutputBuffer(_offset, _cnt, _data) }
#define GetUSBInputBuffer(_offset, _cnt, _data) asm { __getUSBInputBuffer(_offset, _cnt, _data) }
#define GetUSBOutputBuffer(_offset, _cnt, _data) asm { __getUSBOutputBuffer(_offset, _cnt, _data) }
#define GetUSBPollBuffer(_offset, _cnt, _data) asm { __getUSBPollBuffer(_offset, _cnt, _data) }

#define BTDeviceName(_p) asm { GetBTDeviceName(_p, __STRRETVAL__) }
#define BTConnectionName(_p) asm { GetBTConnectionName(_p, __STRRETVAL__) }
#define BTConnectionPinCode(_p) asm { GetBTConnectionPinCode(_p, __STRRETVAL__) }
#define BrickDataName() asm { GetBrickDataName(__STRRETVAL__) }

#define GetBTDeviceAddress(_p, _data) asm { __getBTDeviceAddress(_p, _data) }
#define GetBTConnectionAddress(_p, _data) asm { __getBTConnectionAddress(_p, _data) }
#define GetBrickDataAddress(_data) asm { GetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _data) }

#define SoundFrequency() asm { GetSoundFrequency(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundDuration() asm { GetSoundDuration(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundSampleRate() asm { GetSoundSampleRate(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define SoundMode() asm { GetSoundMode(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SoundVolume() asm { GetSoundVolume(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define ButtonPressCount(_b) asm { GetButtonPressCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonLongPressCount(_b) asm { GetButtonLongPressCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonShortReleaseCount(_b) asm { GetButtonShortReleaseCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonLongReleaseCount(_b) asm { GetButtonLongReleaseCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonReleaseCount(_b) asm { GetButtonReleaseCount(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define ButtonState(_b) asm { GetButtonState(_b, __TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define CommandFlags() asm { GetCommandFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define UIState() asm { GetUIState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define UIButton() asm { GetUIButton(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define VMRunState() asm { GetVMRunState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BatteryState() asm { GetBatteryState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BluetoothState() asm { GetBluetoothState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define UsbState() asm { GetUsbState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SleepTimeout() asm { GetSleepTimeout(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SleepTime() SleepTimeout()
#define SleepTimer() asm { GetSleepTimer(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define RechargeableBattery() asm { GetRechargeableBattery(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define Volume() asm { GetVolume(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define OnBrickProgramPointer() asm { GetOnBrickProgramPointer(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define AbortFlag() asm { GetAbortFlag(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LongAbort() AbortFlag()

#define CustomSensorZeroOffset(_p) asm { GetInCustomZeroOffset(_p, __TMPWORD__) __RETURN__ __TMPWORD__ }
#define CustomSensorPercentFullScale(_p) asm { GetInCustomPercentFullScale(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define CustomSensorActiveStatus(_p) asm { GetInCustomActiveStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SensorBoolean(_p) asm { GetInSensorBoolean(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SensorDigiPinsDirection(_p) asm { GetInDigiPinsDirection(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SensorDigiPinsStatus(_p) asm { GetInDigiPinsStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define SensorDigiPinsOutputLevel(_p) asm { GetInDigiPinsOutputLevel(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }

#if __FIRMWARE_VERSION > 107

#define ColorCalibration(_p, _np, _nc) asm { GetInColorCalibration(_p, _np, _nc, __TMPLONG__) __RETURN__ __TMPLONG__ }
#define ColorCalLimits(_p, _np) asm { GetInColorCalLimits(_p, _np, __TMPWORD__) __RETURN__ __TMPWORD__ }
#define ColorADRaw(_p, _nc) asm { GetInColorADRaw(_p, _nc, __TMPWORD__) __RETURN__ __TMPWORD__ } 
#define ColorSensorRaw(_p, _nc) asm { GetInColorSensorRaw(_p, _nc, __TMPWORD__) __RETURN__ __TMPWORD__ }
#define ColorSensorValue(_p, _nc) asm { GetInColorSensorValue(_p, _nc, __TMPWORD__) __RETURN__ __TMPWORD__ }
#define ColorBoolean(_p, _nc) asm { GetInColorBoolean(_p, _nc, __TMPBYTE__) __RETURN__ __TMPBYTE__ } 
#define ColorCalibrationState(_p) asm { GetInColorCalibrationState(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }

#endif

#define MotorPwnFreq() asm { GetOutPwnFreq(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define LSInputBufferInPtr(_p) asm { GetLSInputBufferInPtr(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSInputBufferOutPtr(_p) asm { GetLSInputBufferOutPtr(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSInputBufferBytesToRx(_p) asm { GetLSInputBufferBytesToRx(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSOutputBufferInPtr(_p) asm { GetLSOutputBufferInPtr(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSOutputBufferOutPtr(_p) asm { GetLSOutputBufferOutPtr(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSOutputBufferBytesToRx(_p) asm { GetLSOutputBufferBytesToRx(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSMode(_p) asm { GetLSMode(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSChannelState(_p) asm { GetLSChannelState(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSErrorType(_p) asm { GetLSErrorType(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSState() asm { GetLSState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define LSSpeed() asm { GetLSSpeed(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#define DisplayEraseMask() asm { GetDisplayEraseMask(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayUpdateMask() asm { GetDisplayUpdateMask(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayDisplay() asm { GetDisplayDisplay(__TMPLONG__) __RETURN__ __TMPLONG__ }
#define DisplayFlags() asm { GetDisplayFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define DisplayTextLinesCenterFlags() asm { GetDisplayTextLinesCenterFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define DisplayContrast() asm { GetDisplayContrast(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#endif

#define BTDeviceClass(_p) asm { GetBTDeviceClass(_p, __TMPLONG__) __RETURN__ __TMPLONG__ }
#define BTDeviceStatus(_p) asm { GetBTDeviceStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTConnectionClass(_p) asm { GetBTConnectionClass(_p, __TMPLONG__) __RETURN__ __TMPLONG__ }
#define BTConnectionHandleNum(_p) asm { GetBTConnectionHandleNum(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTConnectionStreamStatus(_p) asm { GetBTConnectionStreamStatus(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTConnectionLinkQuality(_p) asm { GetBTConnectionLinkQuality(_p, __TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BrickDataBluecoreVersion() asm { GetBrickDataBluecoreVersion(__TMPWORD__) __RETURN__ __TMPWORD__ }
#define BrickDataBtStateStatus() asm { GetBrickDataBtStateStatus(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BrickDataBtHardwareStatus() asm { GetBrickDataBtHardwareStatus(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BrickDataTimeoutValue() asm { GetBrickDataTimeoutValue(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTInputBufferInPtr() asm { GetBTInputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTInputBufferOutPtr() asm { GetBTInputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTOutputBufferInPtr() asm { GetBTOutputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTOutputBufferOutPtr() asm { GetBTOutputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSInputBufferInPtr() asm { GetHSInputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSInputBufferOutPtr() asm { GetHSInputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSOutputBufferInPtr() asm { GetHSOutputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSOutputBufferOutPtr() asm { GetHSOutputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBInputBufferInPtr() asm { GetUSBInputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBInputBufferOutPtr() asm { GetUSBInputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBOutputBufferInPtr() asm { GetUSBOutputBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBOutputBufferOutPtr() asm { GetUSBOutputBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBPollBufferInPtr() asm { GetUSBPollBufferInPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBPollBufferOutPtr() asm { GetUSBPollBufferOutPtr(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTDeviceCount() asm { GetBTDeviceCount(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define BTDeviceNameCount() asm { GetBTDeviceNameCount(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSFlags() asm { GetHSFlags(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSSpeed() asm { GetHSSpeed(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSState() asm { GetHSState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define USBState() asm { GetUSBState(__TMPBYTE__) __RETURN__ __TMPBYTE__ }
#define HSMode() asm { GetHSMode(__TMPWORD__) __RETURN__ __TMPWORD__ }

#define SetSoundFrequency(_n) asm { __setSoundFrequency(_n) }
#define SetSoundDuration(_n) asm { __setSoundDuration(_n) }
#define SetSoundSampleRate(_n) asm { __setSoundSampleRate(_n) }
#define SetSoundFlags(_n) asm { __setSoundFlags(_n) }
#define SetSoundModuleState(_n) asm { __setSoundModuleState(_n) }
#define SetSoundMode(_n) asm { __setSoundMode(_n) }
#define SetSoundVolume(_n) asm { __setSoundVolume(_n) }

#define SetButtonPressCount(_b, _n) asm { __setButtonPressCount(_b, _n) }
#define SetButtonLongPressCount(_b, _n) asm { __setButtonLongPressCount(_b, _n) }
#define SetButtonShortReleaseCount(_b, _n) asm { __setButtonShortReleaseCount(_b, _n) }
#define SetButtonLongReleaseCount(_b, _n) asm { __setButtonLongReleaseCount(_b, _n) }
#define SetButtonReleaseCount(_b, _n) asm { __setButtonReleaseCount(_b, _n) }
#define SetButtonState(_b, _n) asm { __setButtonState(_b, _n) }

#define SetCommandFlags(_n) asm { __setCommandFlags(_n) }
#define SetUIState(_n) asm { __setUIState(_n) }
#define SetUIButton(_n) asm { __setUIButton(_n) }
#define SetVMRunState(_n) asm { __setVMRunState(_n) }
#define SetBatteryState(_n) asm { __setBatteryState(_n) }
#define SetBluetoothState(_n) asm { __setBluetoothState(_n) }
#define SetUsbState(_n) asm { __setUsbState(_n) }
#define SetSleepTimeout(_n) asm { __setSleepTimeout(_n) }
#define SetSleepTime(_n) SetSleepTimeout(_n)
#define SetSleepTimer(_n) asm { __setSleepTimer(_n) }
#define SetVolume(_n) asm { __setVolume(_n) }
#define SetOnBrickProgramPointer(_n) asm { __setOnBrickProgramPointer(_n) }
#define ForceOff(_n) asm { __forceOff(_n) }
#define SetAbortFlag(_n) asm { __setAbortFlag(_n) }
#define SetLongAbort(_n) do { \
  if (_n) { \
    asm { __setAbortFlag(BTNSTATE_LONG_PRESSED_EV) } \
  } else { \
    asm { __setAbortFlag(BTNSTATE_PRESSED_EV) } \
  } \
} while(false)

#define SetCustomSensorZeroOffset(_p, _n) asm { __setInCustomZeroOffset(_p, _n) }
#define SetCustomSensorPercentFullScale(_p, _n) asm { __setInCustomPercentFullScale(_p, _n) }
#define SetCustomSensorActiveStatus(_p, _n) asm { __setInCustomActiveStatus(_p, _n) }
#define SetSensorBoolean(_p, _n) asm { __setInSensorBoolean(_p, _n) }
#define SetSensorDigiPinsDirection(_p, _n) asm { __setInDigiPinsDirection(_p, _n) }
#define SetSensorDigiPinsStatus(_p, _n) asm { __setInDigiPinsStatus(_p, _n) }
#define SetSensorDigiPinsOutputLevel(_p, _n) asm { __setInDigiPinsOutputLevel(_p, _n) }

#define SetMotorPwnFreq(_n) asm { __setOutPwnFreq(_n) }

#define SetLSInputBuffer(_p, _offset, _cnt, _data) asm { __setLSInputBuffer(_p, _offset, _cnt, _data) }

#define SetLSInputBufferInPtr(_p, _n) asm { __setLSInputBufferInPtr(_p, _n) }
#define SetLSInputBufferOutPtr(_p, _n) asm { __setLSInputBufferOutPtr(_p, _n) }
#define SetLSInputBufferBytesToRx(_p, _n) asm { __setLSInputBufferBytesToRx(_p, _n) }

#define SetLSOutputBuffer(_p, _offset, _cnt, _data) asm { __setLSOutputBuffer(_p, _offset, _cnt, _data) }

#define SetLSOutputBufferInPtr(_p, _n) asm { __setLSOutputBufferInPtr(_p, _n) }
#define SetLSOutputBufferOutPtr(_p, _n) asm { __setLSOutputBufferOutPtr(_p, _n) }
#define SetLSOutputBufferBytesToRx(_p, _n) asm { __setLSOutputBufferBytesToRx(_p, _n) }
#define SetLSMode(_p, _n) asm { __setLSMode(_p, _n) }
#define SetLSChannelState(_p, _n) asm { __setLSChannelState(_p, _n) }
#define SetLSErrorType(_p, _n) asm { __setLSErrorType(_p, _n) }
#define SetLSState(_n) asm { __setLSState(_n) }
#define SetLSSpeed(_n) asm { __setLSSpeed(_n) }

#define SpawnProgram(_fname) asm { __spawnProgram(_fname) }

#define SetDisplayEraseMask(_n) asm { __setDisplayEraseMask(_n) }
#define SetDisplayUpdateMask(_n) asm { __setDisplayUpdateMask(_n) }
#define SetDisplayDisplay(_n) asm { __setDisplayDisplay(_n) }
#define SetDisplayFlags(_n) asm { __setDisplayFlags(_n) }
#define SetDisplayTextLinesCenterFlags(_n) asm { __setDisplayTextLinesCenterFlags(_n) }

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define SetDisplayContrast(_n) asm { __setDisplayContrast(_n) }
#endif

#define SetDisplayNormal(_x, _line, _cnt, _data) asm { __setDisplayNormal(_x, _line, _cnt, _data) }
#define SetDisplayPopup(_x, _line, _cnt, _data) asm { __setDisplayPopup(_x, _line, _cnt, _data) }

#define SetBTDeviceName(_p, _str) asm { __setBTDeviceName(_p, _str) }
#define SetBTDeviceAddress(_p, _addr) asm { __setBTDeviceAddress(_p, _addr) }
#define SetBTConnectionName(_p, _str) asm { __setBTConnectionName(_p, _str) }
#define SetBTConnectionPinCode(_p, _code) asm { __setBTConnectionPinCode(_p, _code) }
#define SetBTConnectionAddress(_p, _addr) asm { __setBTConnectionAddress(_p, _addr) }
#define SetBrickDataName(_str) asm { SetCommModuleBytes(CommOffsetBrickDataName, 16, _str) }
#define SetBrickDataAddress(_addr) asm { SetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _addr) }

#define SetBTDeviceClass(_p, _n) asm { __setBTDeviceClass(_p, _n) }
#define SetBTDeviceStatus(_p, _n) asm { __setBTDeviceStatus(_p, _n) }
#define SetBTConnectionClass(_p, _n) asm { __setBTConnectionClass(_p, _n) }
#define SetBTConnectionHandleNum(_p, _n) asm { __setBTConnectionHandleNum(_p, _n) }
#define SetBTConnectionStreamStatus(_p, _n) asm { __setBTConnectionStreamStatus(_p, _n) }
#define SetBTConnectionLinkQuality(_p, _n) asm { __setBTConnectionLinkQuality(_p, _n) }
#define SetBrickDataBluecoreVersion(_n) asm { __setBrickDataBluecoreVersion(_n) }
#define SetBrickDataBtStateStatus(_n) asm { __setBrickDataBtStateStatus(_n) }
#define SetBrickDataBtHardwareStatus(_n) asm { __setBrickDataBtHardwareStatus(_n) }
#define SetBrickDataTimeoutValue(_n) asm { __setBrickDataTimeoutValue(_n) }

#define SetBTInputBuffer(_offset, _cnt, _data) asm { __setBTInputBuffer(_offset, _cnt, _data) }

#define SetBTInputBufferInPtr(_n) asm { __setBTInputBufferInPtr(_n) }
#define SetBTInputBufferOutPtr(_n) asm { __setBTInputBufferOutPtr(_n) }

#define SetBTOutputBuffer(_offset, _cnt, _data) asm { __setBTOutputBuffer(_offset, _cnt, _data) }

#define SetBTOutputBufferInPtr(_n) asm { __setBTOutputBufferInPtr(_n) }
#define SetBTOutputBufferOutPtr(_n) asm { __setBTOutputBufferOutPtr(_n) }

#define SetHSInputBuffer(_offset, _cnt, _data) asm { __setHSInputBuffer(_offset, _cnt, _data) }

#define SetHSInputBufferInPtr(_n) asm { __setHSInputBufferInPtr(_n) }
#define SetHSInputBufferOutPtr(_n) asm { __setHSInputBufferOutPtr(_n) }

#define SetHSOutputBuffer(_offset, _cnt, _data) asm { __setHSOutputBuffer(_offset, _cnt, _data) }

#define SetHSOutputBufferInPtr(_n) asm { __setHSOutputBufferInPtr(_n) }
#define SetHSOutputBufferOutPtr(_n) asm { __setHSOutputBufferOutPtr(_n) }

#define SetUSBInputBuffer(_offset, _cnt, _data) asm { __setUSBInputBuffer(_offset, _cnt, _data) }

#define SetUSBInputBufferInPtr(_n) asm { __setUSBInputBufferInPtr(_n) }
#define SetUSBInputBufferOutPtr(_n) asm { __setUSBInputBufferOutPtr(_n) }

#define SetUSBOutputBuffer(_offset, _cnt, _data) asm { __setUSBOutputBuffer(_offset, _cnt, _data) }

#define SetUSBOutputBufferInPtr(_n) asm { __setUSBOutputBufferInPtr(_n) }
#define SetUSBOutputBufferOutPtr(_n) asm { __setUSBOutputBufferOutPtr(_n) }

#define SetUSBPollBuffer(_offset, _cnt, _data) asm { __setUSBPollBuffer(_offset, _cnt, _data) }

#define SetUSBPollBufferInPtr(_n) asm { __setUSBPollBufferInPtr(_n) }
#define SetUSBPollBufferOutPtr(_n) asm { __setUSBPollBufferOutPtr(_n) }
#define SetBTDeviceCount(_n) asm { __setBTDeviceCount(_n) }
#define SetBTDeviceNameCount(_n) asm { __setBTDeviceNameCount(_n) } 
#define SetHSFlags(_n) asm { __setHSFlags(_n) }
#define SetHSSpeed(_n) asm { __setHSSpeed(_n) }
#define SetHSState(_n) asm { __setHSState(_n) }
#define SetUSBState(_n) asm { __setUSBState(_n) }


#define CreateFile(_fname, _fsize, _handle) asm { __createFile(_fname, _fsize, _handle, __RETVAL__) }
#define OpenFileAppend(_fname, _fsize, _handle) asm { __openFileAppend(_fname, _fsize, _handle, __RETVAL__) }
#define OpenFileRead(_fname, _fsize, _handle) asm { __openFileRead(_fname, _fsize, _handle, __RETVAL__) }
#define CloseFile(_handle) asm { __closeFile(_handle, __RETVAL__) }
#define ResolveHandle(_fname, _handle, _writeable) asm { __resolveHandle(_fname, _handle, _writeable, __RETVAL__) }
#define RenameFile(_oldname, _newname) asm { __renameFile(_oldname, _newname, __RETVAL__) }
#define DeleteFile(_fname) asm { __deleteFile(_fname, __RETVAL__) }
#define ResizeFile(_fname, _newsize) asm { __fileResize(_fname, _newsize, __RETVAL__) }

#ifdef __ENHANCED_FIRMWARE
#define CreateFileLinear(_fname, _fsize, _handle) asm { __createFileLinear(_fname, _fsize, _handle, __RETVAL__) }
#define CreateFileNonLinear(_fname, _fsize, _handle) asm { __createFileNonLinear(_fname, _fsize, _handle, __RETVAL__) }
#define OpenFileReadLinear(_fname, _fsize, _handle) asm { __openFileReadLinear(_fname, _fsize, _handle, __RETVAL__) }
#define FindFirstFile(_fname, _handle) asm { __findFirstFile(_fname, _handle, __RETVAL__) }
#define FindNextFile(_fname, _handle) asm { __findNextFile(_fname, _handle, __RETVAL__) }
#endif

#define Read(_handle, _n) asm { __readValue(_handle, _n, __RETVAL__) }
#define ReadLn(_handle, _n) asm { __readLnValue(_handle, _n, __RETVAL__) }
#define ReadBytes(_handle, _len, _buf) asm { __readBytes(_handle, _len, _buf, __RETVAL__) }
#define ReadLnString(_handle, _output) asm { __readLnString(_handle, _output, __RETVAL__) }

#define Write(_handle, _n) asm { __writeValue(_handle, _n, __RETVAL__) }
#define WriteLn(_handle, _n) asm { __writeLnValue(_handle, _n, __RETVAL__) }
#define WriteString(_handle, _str, _cnt) asm { __writeString(_handle, _str, _cnt, __RETVAL__) }
#define WriteLnString(_handle, _str, _cnt) asm { __writeLnString(_handle, _str, _cnt, __RETVAL__) }
#define WriteBytes(_handle, _buf, _cnt) asm { __writeBytes(_handle, _buf, _cnt, __RETVAL__) }
#define WriteBytesEx(_handle, _len, _buf) asm { __writeBytesEx(_handle, _len, _buf, __RETVAL__) }

// stdio functions

#define fclose(_handle) CloseFile(_handle)
#define remove(_filename) DeleteFile(_filename)
#define rename(_old, _new) RenameFile(_old, _new)
#define fgetc(_handle) asm { \
  __readValue(_handle, __FReadTmpByte, __RETVAL__) \
  mov __RETVAL__, __FReadTmpByte \
 }
#define getc(_handle) fgetc(_handle)


/*
  char* fgets(char* str, int num, FILE*); read num bytes from file into str.  Appends null.  Newline stops reading
#define fgets(_output, _num, _handle) ReadLnString(_handle, _output) // not quite right
  int fgetc(FILE*); // EOF if failure, otherwise the character read from stream

  int feof(FILE*);   // non-zero if EOF, 0 otherwise
  int fflush(FILE*); // EOF if failure, 0 otherwise
  long int ftell(FILE*); // -1 if failure, otherwise the file position
  FILE* fopen(char* filename, char* mode); // open file
  int fprintf(FILE*, char* format, ...); // write to file
  int fputc(int ch, FILE*); // write chracter to file. Returns character written or EOF if error occurs
  int putc(int ch, FILE*); // ditto
  int fputs(char* str, FILE*); // write string to file (not including null); return EOF if error or non-negative value if success
  size_t fread(ptr, size, count, FILE*); // read blocks of data from file; returns number of blocks read
  int fseek(FILE*, offset, origin); // zero if success, non-zero if failure
  size_t fwrite(ptr, size, count, FILE*); // write blocks of data to stream; returns number of blocks written
  int getchar(void); // read character from stdin (returns which button was pressed) 
  int printf(char* format, ...);
  int putchar(int character); // write character to stdout
  void rewind(FILE*); // same as seeking to start of file (and clears error indicator)
  int sprintf(char* str, char* format, ...); // write formatted data to string

*/


#define SendMessage(_queue, _msg) asm { __sendMessage(_queue, _msg, __RETVAL__) }
#define ReceiveMessage(_queue, _clear, _msg) asm { __receiveMessage(_queue, _clear, _msg, __RETVAL__) }

#define LowspeedStatus(_port, _bready) asm { __lowspeedStatus(_port, _bready, __RETVAL__) }
#define LowspeedCheckStatus(_port) asm { __lowspeedStatus(_port, __TMPBYTE__, __RETVAL__) }
#define LowspeedBytesReady(_port) asm { __lowspeedStatus(_port, __RETVAL__, __TMPBYTE__) }
#define LowspeedWrite(_port, _retlen, _buffer) asm { __lowspeedWrite(_port, _retlen, _buffer, __RETVAL__) }
#define LowspeedRead(_port, _buflen, _buffer) asm { __lowspeedRead(_port, _buflen, _buffer, __RETVAL__) }

#define I2CStatus(_port, _bready) LowspeedStatus(_port, _bready)
#define I2CCheckStatus(_port) LowspeedCheckStatus(_port)
#define I2CBytesReady(_port) LowspeedBytesReady(_port)
#define I2CWrite(_port, _retlen, _buffer) LowspeedWrite(_port, _retlen, _buffer)
#define I2CRead(_port, _buflen, _buffer) LowspeedRead(_port, _buflen, _buffer)

#define I2CBytes(_port, _inbuf, _count, _outbuf) asm { ReadI2CBytes(_port, _inbuf, _count, _outbuf, __RETVAL__) }

#define BluetoothStatus(_conn) asm { __bluetoothStatus(_conn, __RETVAL__) }
#define BluetoothWrite(_conn, _buffer) asm { __bluetoothWrite(_conn, _buffer, __RETVAL__) }

#define SendRemoteBool(_conn, _queue, _bval) asm { __sendRemoteBool(_conn, _queue, _bval, __RETVAL__) }
#define SendRemoteNumber(_conn, _queue, _val) asm { __sendRemoteNumber(_conn, _queue, _val, __RETVAL__) }
#define SendRemoteString(_conn, _queue, _str) asm { __sendRemoteString(_conn, _queue, _str, __RETVAL__) }

#define SendResponseBool(_queue, _bval) asm { __sendResponseBool(_queue, _bval, __RETVAL__) }
#define SendResponseNumber(_queue, _val) asm { __sendResponseNumber(_queue, _val, __RETVAL__) }
#define SendResponseString(_queue, _msg) asm { __sendResponseString(_queue, _msg, __RETVAL__) }

#define ReceiveRemoteBool(_queue, _clear, _bval) asm { __receiveRemoteBool(_queue, _clear, _bval, __RETVAL__) }
#define ReceiveRemoteNumber(_queue, _clear, _val) asm { __receiveRemoteNumber(_queue, _clear, _val, __RETVAL__) }
#define ReceiveRemoteString(_queue, _clear, _str) asm { __receiveMessage(_queue, _clear, _str, __RETVAL__) }
#define ReceiveRemoteMessageEx(_queue, _clear, _str, _val, _bval) asm { __receiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, __RETVAL__) }

#define RemoteMessageRead(_conn, _queue) asm { __remoteMessageRead(_conn, _queue, __RETVAL__) }
#define RemoteMessageWrite(_conn, _queue, _msg) asm { __sendRemoteString(_conn, _queue, _msg, __RETVAL__) }
#define RemoteStartProgram(_conn, _filename) asm { __remoteStartProgram(_conn, _filename, __RETVAL__) }
#define RemoteStopProgram(_conn) asm { __bluetoothWrite(_conn, __DCStopProgramPacket, __RETVAL__) }
#define RemotePlaySoundFile(_conn, _filename, _bloop) asm { __remotePlaySoundFile(_conn, _filename, _bloop, __RETVAL__) }
#define RemotePlayTone(_conn, _frequency, _duration) asm { __remotePlayTone(_conn, _frequency, _duration, __RETVAL__) }
#define RemoteStopSound(_conn) asm { __bluetoothWrite(_conn, __DCStopSoundPacket, __RETVAL__) }
#define RemoteKeepAlive(_conn) asm { __bluetoothWrite(_conn, __DCKeepAlivePacket, __RETVAL__) }
#define RemoteResetScaledValue(_conn, _port) asm { __remoteResetScaledValue(_conn, _port, __RETVAL__) }
#define RemoteResetMotorPosition(_conn, _port, _brelative) asm { __remoteResetMotorPosition(_conn, _port, _brelative, __RETVAL__) }
#define RemoteSetInputMode(_conn, _port, _type, _mode) asm { __remoteSetInputMode(_conn, _port, _type, _mode, __RETVAL__) }
#define RemoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit) \
  asm { __remoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, __RETVAL__) }


#ifdef __ENHANCED_FIRMWARE

#define RS485Status(_sendingData, _dataAvail) asm { __RS485Status(_sendingData, _dataAvail) }
#define RS485SendingData() asm { __RS485Status(__RETVAL__, __TMPBYTE__) }
#define RS485DataAvailable() asm { __RS485Status(__TMPBYTE__, __RETVAL__) }
#define RS485Write(_buffer) asm { __RS485Write(_buffer, __RETVAL__) }
#define RS485Read(_buffer) asm { __RS485Read(_buffer, __RETVAL__) }

#if __FIRMWARE_VERSION > 107

#define RS485Control(_cmd, _baud, _mode) asm { __RS485Control(_cmd, _baud, _mode, __RETVAL__) }
#define RS485Uart(_baud, _mode) asm { __RS485Control(HS_CTRL_UART, _baud, _mode, __RETVAL__) }
#define RS485Init() asm { __RS485Control(HS_CTRL_INIT, 0, 0, __RETVAL__) }
#define RS485Exit() asm { __RS485Control(HS_CTRL_EXIT, 0, 0, __RETVAL__) }

#else

#define RS485Control(_cmd, _baud) asm { __RS485Control(_cmd, _baud, __RETVAL__) }
#define RS485Uart(_baud) asm { __RS485Control(HS_CTRL_UART, _baud, __RETVAL__) }
#define RS485Init() asm { __RS485Control(HS_CTRL_INIT, 0, __RETVAL__) }
#define RS485Exit() asm { __RS485Control(HS_CTRL_EXIT, 0, __RETVAL__) }

#endif

#define SendRS485Bool(_bval) asm { __sendRS485Bool(_bval, __RETVAL__) }
#define SendRS485Number(_val) asm { __sendRS485Number(_val, __RETVAL__) }
#define SendRS485String(_str) asm { __sendRS485String(_str, __RETVAL__) }

#endif


#if __FIRMWARE_VERSION > 107

#define Sqrt(_X) asm { sqrt __FLTRETVAL__, _X }

#ifdef __ENHANCED_FIRMWARE
#define Sin(_X) asm { sin __FLTRETVAL__, _X }
#define Cos(_X) asm { cos __FLTRETVAL__, _X }
#define Asin(_X) asm { asin __FLTRETVAL__, _X }
#define Acos(_X) asm { acos __FLTRETVAL__, _X }
#define Atan(_X) asm { atan __FLTRETVAL__, _X }
#define Ceil(_X) asm { ceil __FLTRETVAL__, _X }
#define Exp(_X) asm { exp __FLTRETVAL__, _X }
#define Floor(_X) asm { floor __FLTRETVAL__, _X }
#define Tan(_X) asm { tan __FLTRETVAL__, _X }
#define Tanh(_X) asm { tanh __FLTRETVAL__, _X }
#define Cosh(_X) asm { cosh __FLTRETVAL__, _X }
#define Sinh(_X) asm { sinh __FLTRETVAL__, _X }
#define Log(_X) asm { log __FLTRETVAL__, _X }
#define Log10(_X) asm { log10 __FLTRETVAL__, _X }
#define Atan2(_X,_Y) asm { atan2 __FLTRETVAL__, _X, _Y }
#define Pow(_X,_Y) asm { pow __FLTRETVAL__, _X, _Y }
#define Trunc(_X) asm { trunc __RETVAL__, _X }
#define Frac(_X) asm { frac __FLTRETVAL__, _X }
#define MulDiv32(_A,_B,_C) asm { muldiv __RETVAL__, _A, _B, _C }
#endif

#else

// math functions written by Tamas Sorosy (www.sorosy.com)

// X is any integer; Y is the sqrt value (0->max); if X<0, Y is the sqrt value of absolute X
#define Sqrt(_X) asm { __SQRT(_X,__RETVAL__) }

// X is any integer in degrees; Y is 100* the sin value (-100->100)
#define Sin(_X) asm { __SIN(_X,__RETVAL__) }

// X is any integer in degrees; Y is 100* the cos value (-100->100)
#define Cos(_X) asm { __COS(_X,__RETVAL__) }

// X is 100* the sin value (-100->100); Y is -90->90; Y is 101 if X is outside -100->100 range
#define Asin(_X) asm { __ASIN(_X,__RETVAL__) }

// X is 100* the cos value (-100->100); Y is 0->180; Y is -11 if X is outside -100->100 range
#define Acos(_X) asm { __ACOS(_X,__RETVAL__) }

#endif

#define bcd2dec(_bcd) asm { \
  compchk EQ, sizeof(_bcd), 1 \
  __bcd2dec(_bcd, __RETVAL__) \
}

// standard syscall structures

struct LocationType {
  int X;
  int Y;
};

struct SizeType {
  int Width;
  int Height;
};

// FileOpenRead, FileOpenWrite, FileOpenAppend, FileOpenReadLinear, FileOpenWriteLinear, FileOpenWriteNonLinear
struct FileOpenType {
  unsigned int Result;
  byte FileHandle;
  string Filename;
  unsigned long Length;
};

// FileRead, FileWrite
struct FileReadWriteType {
  unsigned int Result;
  byte FileHandle;
  string Buffer;
  unsigned long Length;
};

// FileClose
struct FileCloseType {
  unsigned int Result;
  byte FileHandle;
};

// FileResolveHandle
struct FileResolveHandleType {
  unsigned int Result;
  byte FileHandle;
  bool WriteHandle;
  string Filename;
};

// FileRename
struct FileRenameType {
  unsigned int Result;
  string OldFilename;
  string NewFilename;
};

// FileDelete
struct FileDeleteType {
  unsigned int Result;
  string Filename;
};

// SoundPlayFile
struct SoundPlayFileType {
  char Result;
  string Filename;
  bool Loop;
  byte SoundLevel;
};

// SoundPlayTone
struct SoundPlayToneType {
  char Result;
  unsigned int Frequency;
  unsigned int Duration;
  bool Loop;
  byte SoundLevel;
};

// SoundGetState
struct SoundGetStateType {
  byte State;
  byte Flags;
};

// SoundSetState
struct SoundSetStateType {
  byte Result;
  byte State;
  byte Flags;
};

// DrawText
struct DrawTextType {
  char Result;
  LocationType Location;
  string Text;
  unsigned long Options;
};

// DrawPoint
struct DrawPointType {
  char Result;
  LocationType Location;
  unsigned long Options;
};

// DrawLine
struct DrawLineType {
  char Result;
  LocationType StartLoc;
  LocationType EndLoc;
  unsigned long Options;
};

// DrawCircle
struct DrawCircleType {
  char Result;
  LocationType Center;
  byte Size;
  unsigned long Options;
};

// DrawRect
struct DrawRectType {
  char Result;
  LocationType Location;
  SizeType Size;
  unsigned long Options;
};

// DrawGraphic
struct DrawGraphicType {
  char Result;
  LocationType Location;
  string Filename;
  long Variables[];
  unsigned long Options;
};

// SetScreenMode
struct SetScreenModeType {
  char Result;
  unsigned long ScreenMode;
};

// ReadButton
struct ReadButtonType {
  char Result;
  byte Index;
  bool Pressed;
  byte Count;
  bool Reset; // reset count after reading?
};

// CommLSWrite
struct CommLSWriteType {
  char Result;
  byte Port;
  byte Buffer[];
  byte ReturnLen;
};

// CommLSRead
struct CommLSReadType {
  char Result;
  byte Port;
  byte Buffer[];
  byte BufferLen;
};

// CommLSCheckStatus
struct CommLSCheckStatusType {
  char Result;
  byte Port;
  byte BytesReady;
};

// RandomNumber
struct RandomNumberType {
  int Result;
};

// GetStartTick
struct GetStartTickType {
  unsigned long Result;
};

// MessageWrite
struct MessageWriteType {
  char Result;
  byte QueueID;
  string Message;
};

// MessageRead
struct MessageReadType {
  char Result;
  byte QueueID;
  bool Remove;
  string Message;
};

// CommBTCheckStatus
struct CommBTCheckStatusType {
  char Result;
  byte Connection;
};

// CommBTWrite
struct CommBTWriteType {
  char Result;
  byte Connection;
  byte Buffer[];
};

// KeepAlive
struct KeepAliveType {
  unsigned long Result;
};

// IOMapRead
struct IOMapReadType {
  char Result;
  string ModuleName;
  unsigned int Offset;
  unsigned int Count;
  byte Buffer[];
};

// IOMapWrite
struct IOMapWriteType {
  char Result;
  string ModuleName;
  unsigned int Offset;
  byte Buffer[];
};

#ifdef __ENHANCED_FIRMWARE
// IOMapReadByID
struct IOMapReadByIDType {
  char Result;
  unsigned long ModuleID;
  unsigned int Offset;
  unsigned int Count;
  byte Buffer[];
};

// IOMapWriteByID
struct IOMapWriteByIDType {
  char Result;
  unsigned long ModuleID;
  unsigned int Offset;
  byte Buffer[];
};

// DisplayExecuteFunction
struct DisplayExecuteFunctionType {
  byte Status;
  byte Cmd;
  byte On;
  byte X1;
  byte Y1;
  byte X2;
  byte Y2;
};

// CommExecuteFunction
struct CommExecuteFunctionType {
  unsigned int Result;
  byte Cmd;
  byte Param1;
  byte Param2;
  byte Param3;
  string Name;
  unsigned int RetVal;
};

// LoaderExecuteFunction
struct LoaderExecuteFunctionType {
  unsigned int Result;
  byte Cmd;
  string Filename;
  byte Buffer[];
  unsigned long Length;
};

// FileFindFirst, FileFindNext
struct FileFindType {
 unsigned int Result;
 byte FileHandle;
 string Filename;
 unsigned long Length;
};

// CommHSControl
struct CommHSControlType {
 char Result;
 byte Command;
 byte BaudRate;
#if __FIRMWARE_VERSION > 107
 unsigned int Mode;
#endif
};

// CommHSCheckStatus
struct CommHSCheckStatusType {
 bool SendingData;
 bool DataAvailable;
};

// CommHSRead, CommHSWrite
struct CommHSReadWriteType {
 char Status;
 byte Buffer[];
};

// CommLSWriteEx
struct CommLSWriteExType {
 char Result;
 byte Port;
 byte Buffer[];
 byte ReturnLen;
 byte NoRestartOnRead;
};

#if __FIRMWARE_VERSION > 107
//FileSeek
struct FileSeekType {
 unsigned int Result;
 byte FileHandle;
 byte Origin;
 long Length;
};

//FileResize
struct FileResizeType {
 unsigned int Result;
 byte FileHandle;
 unsigned int NewSize;
};

// DrawGraphicArray
struct DrawGraphicArrayType {
 char Result;
 LocationType Location;
 byte Data[];
 long Variables[];
 unsigned long Options;
};

struct DrawPolygonType {
 char Result;
 LocationType Points[];
 unsigned long Options;
};

// DrawEllipse
struct DrawEllipseType {
 char Result;
 LocationType Center;
 byte SizeX;
 byte SizeY;
 unsigned long Options;
};

// DrawFont
struct DrawFontType {
 char Result;
 LocationType Location;
 string Filename;
 string Text;
 unsigned long Options;
};

#endif
#endif

#if __FIRMWARE_VERSION > 107

// ColorSensorRead
struct ColorSensorReadType {
 char Result;
 byte Port;
 int ColorValue;
 unsigned int RawArray[];
 unsigned int NormalizedArray[];
 int ScaledArray[];
 bool Invalid;
};

// DatalogWrite
struct DatalogWriteType {
 char Result;
 byte Message[];
};

// DatalogGetTimes
struct DatalogGetTimesType {
 unsigned long SyncTime;
 unsigned long SyncTick;
};

// SetSleepTimeout
struct SetSleepTimeoutType {
 char Result;
 unsigned long TheSleepTimeout;
};

// CommBTOnOff
struct CommBTOnOffType {
 char Result;
 bool PowerState;
};

// CommBTConnection
struct CommBTConnectionType {
 char Result;
 byte Action;
 string Name;
 byte ConnectionSlot;
};

//cCmdWrapReadSemData
//ArgV[0]: return data, U8
//ArgV[1]: which (0=used, 1=request), U8

//cCmdWrapWriteSemData
//ArgV[0]: return data, U8
//ArgV[1]: which (0=used, 1=request), U8
//ArgV[2]: newValue, U8
//ArgV[3]: action (0= OR, 1= AND), U8

//cCmdWrapUpdateCalibCacheInfo
//ArgV[0]: return data, U8
//ArgV[1]: nm, UBYTE array CStr
//ArgV[2]: min, U16
//ArgV[3]: max , U16

//cCmdWrapComputeCalibValue
//ArgV[0]: return data, U8
//ArgV[1]: nm, UBYTE array CStr
//ArgV[2]: raw, U16 ref in out

// ListFiles
struct ListFilesType {
 char Result;
 string Pattern;
 string FileList[];
};

#endif


#define SysCall(_func, _args) asm { syscall _func, _args }

#define SysFileOpenRead(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenRead, _args \
}
#define SysFileOpenWrite(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenWrite, _args \
}
#define SysFileOpenAppend(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenAppend, _args \
}
#define SysFileRead(_args) asm { \
  compchktype _args, FileReadWriteType \
  syscall FileRead, _args \
}
#define SysFileWrite(_args) asm { \
  compchktype _args, FileReadWriteType \
  syscall FileWrite, _args \
}
#define SysFileClose(_args) asm { \
  compchktype _args, FileCloseType \
  syscall FileClose, _args \
}
#define SysFileResolveHandle(_args) asm { \
  compchktype _args, FileResolveHandleType \
  syscall FileResolveHandle, _args \
}
#define SysFileRename(_args) asm { \
  compchktype _args, FileRenameType \
  syscall FileRename, _args \
}
#define SysFileDelete(_args) asm { \
  compchktype _args, FileDeleteType \
  syscall FileDelete, _args \
}
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
#define SysDrawText(_args) asm { \
  compchktype _args, DrawTextType \
  syscall DrawText, _args \
}
#define SysDrawPoint(_args) asm { \
  compchktype _args, DrawPointType \
  syscall DrawPoint, _args \
}
#define SysDrawLine(_args) asm { \
  compchktype _args, DrawLineType \
  syscall DrawLine, _args \
}
#define SysDrawCircle(_args) asm { \
  compchktype _args, DrawCircleType \
  syscall DrawCircle, _args \
}
#define SysDrawRect(_args) asm { \
  compchktype _args, DrawRectType \
  syscall DrawRect, _args \
}
#define SysDrawGraphic(_args) asm { \
  compchktype _args, DrawGraphicType \
  syscall DrawGraphic, _args \
}
#define SysSetScreenMode(_args) asm { \
  compchktype _args, SetScreenModeType \
  syscall SetScreenMode, _args \
}
#define SysReadButton(_args) asm { \
  compchktype _args, ReadButtonType \
  syscall ReadButton, _args \
}
#define SysCommLSWrite(_args) asm { \
  compchktype _args, CommLSWriteType \
  syscall CommLSWrite, _args \
}
#define SysCommLSRead(_args) asm { \
  compchktype _args, CommLSReadType \
  syscall CommLSRead, _args \
}
#define SysCommLSCheckStatus(_args) asm { \
  compchktype _args, CommLSCheckStatusType \
  syscall CommLSCheckStatus, _args \
}
#define SysRandomNumber(_args) asm { \
  compchktype _args, RandomNumberType \
  syscall RandomNumber, _args \
}
#define SysGetStartTick(_args) asm { \
  compchktype _args, GetStartTickType \
  syscall GetStartTick, _args \
}
#define SysMessageWrite(_args) asm { \
  compchktype _args, MessageWriteType \
  syscall MessageWrite, _args \
}
#define SysMessageRead(_args) asm { \
  compchktype _args, MessageReadType \
  syscall MessageRead, _args \
}
#define SysCommBTWrite(_args) asm { \
  compchktype _args, CommBTWriteType \
  syscall CommBTWrite, _args \
}
#define SysCommBTCheckStatus(_args) asm { \
  compchktype _args, CommBTCheckStatusType \
  syscall CommBTCheckStatus, _args \
}
#define SysKeepAlive(_args) asm { \
  compchktype _args, KeepAliveType \
  syscall KeepAlive, _args \
}
#define SysIOMapRead(_args) asm { \
  compchktype _args, IOMapReadType \
  syscall IOMapRead, _args \
}
#define SysIOMapWrite(_args) asm { \
  compchktype _args, IOMapWriteType \
  syscall IOMapWrite, _args \
}

#ifdef __ENHANCED_FIRMWARE
#define SysIOMapReadByID(_args) asm { \
  compchktype _args, IOMapReadByIDType \
  syscall IOMapReadByID, _args \
}
#define SysIOMapWriteByID(_args) asm { \
  compchktype _args, IOMapWriteByIDType \
  syscall IOMapWriteByID, _args \
}
#define SysDisplayExecuteFunction(_args) asm { \
  compchktype _args, DisplayExecuteFunctionType \
  syscall DisplayExecuteFunction, _args \
}
#define SysCommExecuteFunction(_args) asm { \
  compchktype _args, CommExecuteFunctionType \
  syscall CommExecuteFunction, _args \
}
#define SysLoaderExecuteFunction(_args) asm { \
  compchktype _args, LoaderExecuteFunctionType \
  syscall LoaderExecuteFunction, _args \
}
#define SysFileFindFirst(_args) asm { \
  compchktype _args, FileFindType \
  syscall FileFindFirst, _args \
}
#define SysFileFindNext(_args) asm { \
  compchktype _args, FileFindType \
  syscall FileFindNext, _args \
}
#define SysFileOpenWriteLinear(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenWriteLinear, _args \
}
#define SysFileOpenWriteNonLinear(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenWriteNonLinear, _args \
}
#define SysFileOpenReadLinear(_args) asm { \
  compchktype _args, FileOpenType \
  syscall FileOpenReadLinear, _args \
}
#define SysCommHSControl(_args) asm { \
  compchktype _args, CommHSControlType \
  syscall CommHSControl, _args \
}
#define SysCommHSCheckStatus(_args) asm { \
  compchktype _args, CommHSCheckStatusType \
  syscall CommHSCheckStatus, _args \
}
#define SysCommHSRead(_args) asm { \
  compchktype _args, CommHSReadWriteType \
  syscall CommHSRead, _args \
}
#define SysCommHSWrite(_args) asm { \
  compchktype _args, CommHSReadWriteType \
  syscall CommHSWrite, _args \
}
#define SysCommLSWriteEx(_args) asm { \
  compchktype _args, CommLSWriteExType \
  syscall CommLSWriteEx, _args \
}

#if __FIRMWARE_VERSION > 107

#define SysFileSeek(_args) asm { \
  compchktype _args, FileSeekType \
  syscall FileSeek, _args \
}

#define SysFileResize(_args) asm { \
  compchktype _args, FileResizeType \
  syscall FileResize, _args \
}
#define SysDrawGraphicArray(_args) asm { \
  compchktype _args, DrawGraphicArrayType \
  syscall DrawGraphicArray, _args \
}
#define SysDrawPolygon(_args) asm { \
  compchktype _args, DrawPolygonType \
  syscall DrawPolygon, _args \
}
#define SysDrawEllipse(_args) asm { \
  compchktype _args, DrawEllipseType \
  syscall DrawEllipse, _args \
}
#define SysDrawFont(_args) asm { \
  compchktype _args, DrawFontType \
  syscall DrawFont, _args \
}

#endif
#endif

#if __FIRMWARE_VERSION > 107

#define SysColorSensorRead(_args) asm { \
  compchktype _args, ColorSensorReadType \
  syscall ColorSensorRead, _args \
}
#define SysDatalogWrite(_args) asm { \
  compchktype _args, DatalogWriteType \
  syscall DatalogWrite, _args \
}
#define SysDatalogGetTimes(_args) asm { \
  compchktype _args, DatalogGetTimesType \
  syscall DatalogGetTimes, _args \
}
#define SysSetSleepTimeout(_args) asm { \
  compchktype _args, SetSleepTimeoutType \
  syscall SetSleepTimeoutVal, _args \
}
#define SysCommBTOnOff(_args) asm { \
  compchktype _args, CommBTOnOffType \
  syscall CommBTOnOff, _args \
}
#define SysCommBTConnection(_args) asm { \
  compchktype _args, CommBTConnectionType \
  syscall CommBTConnection, _args \
}
#define SysListFiles(_args) asm { \
  compchktype _args, ListFilesType \
  syscall ListFiles, _args \
}

#endif


// HiTechnic API functions

#define SetSensorHTEOPD(_p, _bStd) \
  SetSensorType(_p, (_bStd) ? IN_TYPE_LIGHT_INACTIVE : IN_TYPE_LIGHT_ACTIVE); \
  SetSensorMode(_p, IN_MODE_RAW); \
  ResetSensor(_p);

#define SensorHTEOPD(_p) asm { \
  getin __RETVAL__, _p, RawValue \
  sub __RETVAL__, 1023, __RETVAL__ \
}

#define SetSensorHTGyro(_p) \
  SetSensorType(_p, IN_TYPE_LIGHT_INACTIVE); \
  SetSensorMode(_p, IN_MODE_RAW); \
  ResetSensor(_p);

#define SensorHTGyro(_p, _offset) asm { \
  getin __RETVAL__, _p, RawValue \
  sub __RETVAL__, __RETVAL__, 600 \
  sub __RETVAL__, __RETVAL__, _offset \
}

#define HTPowerFunctionCommand(_port, _channel, _outa, _outb) asm { __HTPFComboDirect(_port, _channel, _outa, _outb, __RETVAL__) }
#define HTPFComboDirect(_port, _channel, _outa, _outb) asm { __HTPFComboDirect(_port, _channel, _outa, _outb, __RETVAL__) }
#define HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont) asm { __HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, __RETVAL__) }
#define HTPFSingleOutputCST(_port, _channel, _out, _func) asm { __HTPFSingleOutput(_port, _channel, _out, _func, TRUE, __RETVAL__) }
#define HTPFSingleOutputPWM(_port, _channel, _out, _func) asm { __HTPFSingleOutput(_port, _channel, _out, _func, FALSE, __RETVAL__) }
#define HTPFComboPWM(_port, _channel, _outa, _outb) asm { __HTPFComboPWM(_port, _channel, _outa, _outb, __RETVAL__) }
#define HTPFTrain(_port, _channel, _func) asm { __HTIRTrain(_port, _channel, _func, TRUE, __RETVAL__) }
#define HTIRTrain(_port, _channel, _func) asm { __HTIRTrain(_port, _channel, _func, FALSE, __RETVAL__) }
#define HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2) asm { __HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, __RETVAL__) }
#define HTPFRepeat(_port, _count, _delay) asm { __HTPFRepeatLastCommand(_port, _count, _delay, __RETVAL__) }

#define HTRCXSetIRLinkPort(_port) asm { __HTRCXSetIRLinkPort(_port) }
#define HTRCXPoll(_src, _value) asm { __HTRCXPoll(_src, _value, __RETVAL__) }
#define HTRCXBatteryLevel() asm { __HTRCXBatteryLevel(__RETVAL__) }
#define HTRCXPing() asm { __HTRCXOpNoArgs(RCX_PingOp) }
#define HTRCXDeleteTasks() asm { __HTRCXOpNoArgs(RCX_DeleteTasksOp) }
#define HTRCXStopAllTasks() asm { __HTRCXOpNoArgs(RCX_StopAllTasksOp) }
#define HTRCXPBTurnOff() asm { __HTRCXOpNoArgs(RCX_PBTurnOffOp) }
#define HTRCXDeleteSubs() asm { __HTRCXOpNoArgs(RCX_DeleteSubsOp) }
#define HTRCXClearSound() asm { __HTRCXOpNoArgs(RCX_ClearSoundOp) }
#define HTRCXClearMsg() asm { __HTRCXOpNoArgs(RCX_ClearMsgOp) }
#define HTRCXMuteSound() asm { __HTRCXOpNoArgs(RCX_MuteSoundOp) }
#define HTRCXUnmuteSound() asm { __HTRCXOpNoArgs(RCX_UnmuteSoundOp) }
#define HTRCXClearAllEvents() asm { __HTRCXOpNoArgs(RCX_ClearAllEventsOp) }
#define HTRCXSetOutput(_outputs, _mode) asm { __HTRCXSetOutput(_outputs, _mode) }
#define HTRCXSetDirection(_outputs, _dir) asm { __HTRCXSetDirection(_outputs, _dir) }
#define HTRCXSetPower(_outputs, _pwrsrc, _pwrval) asm { __HTRCXSetPower(_outputs, _pwrsrc, _pwrval) }
#define HTRCXOn(_outputs) asm { __HTRCXSetOutput(_outputs, RCX_OUT_ON) }
#define HTRCXOff(_outputs) asm { __HTRCXSetOutput(_outputs, RCX_OUT_OFF) }
#define HTRCXFloat(_outputs) asm { __HTRCXSetOutput(_outputs, RCX_OUT_FLOAT) }
#define HTRCXToggle(_outputs) asm { __HTRCXSetDirection(_outputs, RCX_OUT_TOGGLE) }
#define HTRCXFwd(_outputs) asm { __HTRCXSetDirection(_outputs, RCX_OUT_FWD) }
#define HTRCXRev(_outputs) asm { __HTRCXSetDirection(_outputs, RCX_OUT_REV) }
#define HTRCXOnFwd(_outputs) asm { __HTRCXOnFwd(_outputs) }
#define HTRCXOnRev(_outputs) asm { __HTRCXOnRev(_outputs) }
#define HTRCXOnFor(_outputs, _ms) asm { __HTRCXOnFor(_outputs, _ms) }
#define HTRCXSetTxPower(_pwr) asm { __HTRCXSetTxPower(_pwr) }
#define HTRCXPlaySound(_snd) asm { __HTRCXPlaySound(_snd) }
#define HTRCXDeleteTask(_t) asm { __HTRCXDeleteTask(_t) }
#define HTRCXStartTask(_t) asm { __HTRCXStartTask(_t) }
#define HTRCXStopTask(_t) asm { __HTRCXStopTask(_t) }
#define HTRCXSelectProgram(_prog) asm { __HTRCXSelectProgram(_prog) }
#define HTRCXClearTimer(_timer) asm { __HTRCXClearTimer(_timer) }
#define HTRCXSetSleepTime(_t) asm { __HTRCXSetSleepTime(_t) }
#define HTRCXDeleteSub(_s) asm { __HTRCXDeleteSub(_s) }
#define HTRCXClearSensor(_port) asm { __HTRCXClearSensor(_port) }
#define HTRCXPlayToneVar(_varnum, _duration) asm { __HTRCXPlayToneVar(_varnum, _duration) }
#define HTRCXSetWatch(_hours, _minutes) asm { __HTRCXSetWatch(_hours, _minutes) }
#define HTRCXSetSensorType(_port, _type) asm { __HTRCXSetSensorType(_port, _type) }
#define HTRCXSetSensorMode(_port, _mode) asm { __HTRCXSetSensorMode(_port, _mode) }
#define HTRCXCreateDatalog(_size) asm { __HTRCXCreateDatalog(_size) }
#define HTRCXAddToDatalog(_src, _value) asm { __HTRCXAddToDatalog(_src, _value) }
#define HTRCXSendSerial(_first, _count) asm { __HTRCXSendSerial(_first, _count) }
#define HTRCXRemote(_cmd) asm { __HTRCXRemote(_cmd) }
#define HTRCXEvent(_src, _value) asm { __HTRCXEvent(_src, _value) }
#define HTRCXPlayTone(_freq, _duration) asm { __HTRCXPlayTone(_freq, _duration) }
#define HTRCXSelectDisplay(_src, _value) asm { __HTRCXSelectDisplay(_src, _value) }
#define HTRCXPollMemory(_address) asm { __HTRCXPollMemory(_address, __RETVAL__) }
#define HTRCXSetEvent(_evt, _src, _type) asm { __HTRCXSetEvent(_evt, _src, _type) }
#define HTRCXSetGlobalOutput(_outputs, _mode) asm { __HTRCXSetGlobalOutput(_outputs, _mode) }
#define HTRCXSetGlobalDirection(_outputs, _dir) asm { __HTRCXSetGlobalDirection(_outputs, _dir) }
#define HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) asm { __HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) }
#define HTRCXEnableOutput(_outputs) asm { __HTRCXSetGlobalOutput(_outputs, RCX_OUT_ON) }
#define HTRCXDisableOutput(_outputs) asm { __HTRCXSetGlobalOutput(_outputs, RCX_OUT_OFF) }
#define HTRCXInvertOutput(_outputs) asm { __HTRCXSetGlobalDirection(_outputs, RCX_OUT_REV) }
#define HTRCXObvertOutput(_outputs) asm { __HTRCXSetGlobalDirection(_outputs, RCX_OUT_FWD) }
#define HTRCXIncCounter(_counter) asm { __HTRCXIncCounter(_counter) }
#define HTRCXDecCounter(_counter) asm { __HTRCXDecCounter(_counter) }
#define HTRCXClearCounter(_counter) asm { __HTRCXClearCounter(_counter) }
#define HTRCXSetPriority(_p) asm { __HTRCXSetPriority(_p) }
#define HTRCXSetMessage(_msg) asm { __HTRCXSetMessage(_msg) }

#define HTScoutCalibrateSensor() asm { __HTRCXOpNoArgs(RCX_LSCalibrateOp) }
#define HTScoutMuteSound() asm { __HTScoutMuteSound() }
#define HTScoutUnmuteSound() asm { __HTScoutUnmuteSound() }
#define HTScoutSelectSounds(_grp) asm { __HTScoutSelectSounds(_grp) }
#define HTScoutSetLight(_x) asm { __HTScoutSetLight(_x) }
#define HTScoutSetSensorClickTime(_src, _value) asm { __HTScoutSetSensorClickTime(_src, _value) }
#define HTScoutSetSensorHysteresis(_src, _value) asm { __HTScoutSetSensorHysteresis(_src, _value) }
#define HTScoutSetSensorLowerLimit(_src, _value) asm { __HTScoutSetSensorLowerLimit(_src, _value) }
#define HTScoutSetSensorUpperLimit(_src, _value) asm { __HTScoutSetSensorUpperLimit(_src, _value) }
#define HTScoutSetEventFeedback(_src, _value) asm { __HTScoutSetEventFeedback(_src, _value) }
#define HTScoutSendVLL(_src, _value) asm { __HTScoutSendVLL(_src, _value) }
#define HTScoutSetScoutMode(_mode) asm { __HTScoutSetScoutMode(_mode) }

#define SensorHTCompass(_port) asm { ReadSensorHTCompass(_port, __RETVAL__) }
#define ReadSensorHTAccel(_port, _x, _y, _z) asm { __ReadSensorHTAccel(_port, _x, _y, _z, __RETVAL__) }
#define ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue) asm { __ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTRawColor(_port, _Red, _Green, _Blue) asm { __ReadSensorHTRawColor(_port, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue) asm { __ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, __RETVAL__) }
#define ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9) asm { __ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, __RETVAL__) }
#define SensorHTIRSeekerDir(_port) asm { ReadSensorHTIRSeekerDir(_port, __RETVAL__) }
#define SensorHTColorNum(_port) asm { ReadSensorHTColorNum(_port, __RETVAL__) }
#define ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) asm { __ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) }
#define SensorHTIRSeeker2Addr(_port, _addr) asm { ReadSensorHTIRSeeker2Addr(_port, _addr, __RETVAL__) }
#define SensorHTIRSeeker2DCDir(_port) asm { ReadSensorHTIRSeeker2Addr(_port, HTIR2_ADDR_DCDIR, __RETVAL__) }
#define SensorHTIRSeeker2ACDir(_port) asm { ReadSensorHTIRSeeker2Addr(_port, HTIR2_ADDR_ACDIR, __RETVAL__) }
#define ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg) asm { __ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, __RETVAL__) }
#define ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9) asm { __ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, __RETVAL__) }
#define SetHTIRSeeker2Mode(_port, _mode) asm { __SetHTIRSeeker2Mode(_port, _mode, __RETVAL__) }



// Mindsensors API functions

#define SetSensorMSPressure(_p) \
  SetSensorType(_p, IN_TYPE_REFLECTION) \
  SetSensorMode(_p, IN_MODE_RAW) \
  ResetSensor(_p)
	
#define SensorMSPressure(_p) asm { \
  getin __RETVAL__, _p, RawValue \
  sub __RETVAL__, 1024, __RETVAL__ \
  div __RETVAL__, __RETVAL__, 25 \
}

#define SensorMSPressureRaw(_p) asm { getin __RETVAL__, _p, RawValue }

#define SensorMSCompass(_port) asm { ReadSensorMSCompass(_port, __RETVAL__) }
#define SensorMSCompassEx(_port, _addr) asm { ReadSensorMSCompassEx(_port, _addr, __RETVAL__) }
#define ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year) asm { __ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, __RETVAL__) }
#define ReadSensorMSTilt(_port, _x, _y, _z) asm { __ReadSensorMSTiltEx(_port, 0x02, _x, _y, _z, __RETVAL__) }
#define ReadSensorMSTiltEx(_port, _addr, _x, _y, _z) asm { __ReadSensorMSTiltEx(_port, _addr, _x, _y, _z, __RETVAL__) }
#define ReadSensorMSAccel(_port, _x, _y, _z) asm { __ReadSensorMSAccelEx(_port, 0x02, _x, _y, _z, __RETVAL__) }
#define ReadSensorMSAccelEx(_port, _addr, _x, _y, _z) asm { __ReadSensorMSAccelEx(_port, _addr, _x, _y, _z, __RETVAL__) }

#define MSSendCommandEx(_port, _addr, _cmd) asm { __MSSendCmd(_port, _addr, _cmd, __RETVAL__) }
#define MSSendCommand(_port, _cmd) asm { __MSSendCmd(_port, 0x02, _cmd, __RETVAL__) }
#define MSReadValueEx(_port, _addr, _reg, _bytes) asm { __MSReadValue(_port, _addr, _reg, _bytes, __RETVAL__, __TMPBYTE__) }
#define MSReadValue(_port, _reg, _bytes) asm { __MSReadValue(_port, 0x02, _reg, _bytes, __RETVAL__, __TMPBYTE__) }

#define DISTNxGP2D12(_port) asm { __MSSendCmd(_port, 0x02, DIST_CMD_GP2D12, __RETVAL__) }
#define DISTNxGP2D120(_port) asm { __MSSendCmd(_port, 0x02, DIST_CMD_GP2D120, __RETVAL__) }
#define DISTNxGP2YA21(_port) asm { __MSSendCmd(_port, 0x02, DIST_CMD_GP2YA21, __RETVAL__) }
#define DISTNxGP2YA02(_port) asm { __MSSendCmd(_port, 0x02, DIST_CMD_GP2YA02, __RETVAL__) }
#define DISTNxEnergize(_port) asm { __MSSendCmd(_port, 0x02, MS_CMD_ENERGIZED, __RETVAL__) }
#define DISTNxDistance(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_DIST, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxVoltage(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_VOLT, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxModuleType(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_MODULE_TYPE, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxNumPoints(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_NUM_POINTS, 1, __RETVAL__, __TMPBYTE__) }
#define DISTNxMinDistance(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_DIST_MIN, 2, __RETVAL__, __TMPBYTE__) }
#define DISTNxMaxDistance(_port) asm { __MSReadValue(_port, 0x02, DIST_REG_DIST_MAX, 2, __RETVAL__, __TMPBYTE__) }

#define SetSensorMSDRODActive(_p) \
  SetSensorType(_p, IN_TYPE_LIGHT_ACTIVE) \
  SetSensorMode(_p, IN_MODE_PCTFULLSCALE) \
  ResetSensor(_p)

#define SetSensorMSDRODInactive(_p) \
  SetSensorType(_p, IN_TYPE_LIGHT_INACTIVE) \
  SetSensorMode(_p, IN_MODE_PCTFULLSCALE) \
  ResetSensor(_p)

#define SensorMSDROD(_p) asm { getin __RETVAL__, _p, NormalizedValue }

#define PSPNxEnergize(_port) asm { __MSSendCmd(_port, 0x02, MS_CMD_ENERGIZED, __RETVAL__) }

#define ReadSensorMSPlayStationEx(_port, _addr, _b1, _b2, _xleft, _yleft, _xright, _yright) asm { __ReadSensorMSPlayStationEx(_port, _addr, _b1, _b2, _xleft, _yleft, _xright, _yright, __RETVAL__) }
#define ReadSensorMSPlayStation(_port, _b1, _b2, _xleft, _yleft, _xright, _yright) ReadSensorMSPlayStationEx(_port, 0x02, _b1, _b2, _xleft, _yleft, _xright, _yright)

#define NRLink2400(_port) asm { __MSSendCmd(_port, 0x02, NRLINK_CMD_2400, __RETVAL__) }
#define NRLink4800(_port) asm { __MSSendCmd(_port, 0x02, NRLINK_CMD_4800, __RETVAL__) }
#define NRLinkFlush(_port) asm { __MSSendCmd(_port, 0x02, NRLINK_CMD_FLUSH, __RETVAL__) }
#define NRLinkIRLong(_port) asm { __MSSendCmd(_port, 0x02, NRLINK_CMD_IR_LONG, __RETVAL__) }
#define NRLinkIRShort(_port) asm { __MSSendCmd(_port, 0x02, NRLINK_CMD_IR_SHORT, __RETVAL__) }
#define NRLinkTxRaw(_port) asm { __MSSendCmd(_port, 0x02, NRLINK_CMD_TX_RAW, __RETVAL__) }
#define NRLinkSetRCX(_port) asm { __MSSendCmd(_port, 0x02, NRLINK_CMD_SET_RCX, __RETVAL__) }
#define NRLinkSetTrain(_port) asm { __MSSendCmd(_port, 0x02, NRLINK_CMD_SET_TRAIN, __RETVAL__) }
#define NRLinkSetPF(_port) asm { __MSSendCmd(_port, 0x02, NRLINK_CMD_SET_PF, __RETVAL__) }

#define RunNRLinkMacroEx(_port, _addr, _macro) __RunNRLinkMacroEx(_port, _addr, _macro, __RETVAL__)
#define RunNRLinkMacro(_port, _macro) __RunNRLinkMacroEx(_port, 0x02, _macro, __RETVAL__)

#define NRLinkStatusEx(_port, _addr) asm { ReadNRLinkStatusEx(_port, _addr, __RETVAL__) } 
#define NRLinkStatus(_port) asm { ReadNRLinkStatusEx(_port, 0x02, __RETVAL__) } 

#define WriteNRLinkBytesEx(_port, _addr, _bytes) asm { __WriteNRLinkBytes(_port, _addr, _bytes, __RETVAL__) }
#define WriteNRLinkBytes(_port, _bytes) asm { __WriteNRLinkBytes(_port, 0x02, _bytes, __RETVAL__) }

#define ReadNRLinkBytesEx(_port, _addr, _bytes) asm { __ReadNRLinkBytes(_port, _addr, _bytes, __RETVAL__) }
#define ReadNRLinkBytes(_port, _bytes) asm { __ReadNRLinkBytes(_port, 0x02, _bytes, __RETVAL__) }

#define MSPFComboDirectEx(_port, _addr, _channel, _outa, _outb) asm { __MSPFComboDirect(_port, _addr, _channel, _outa, _outb, __RETVAL__) }
#define MSPFComboDirect(_port, _channel, _outa, _outb) asm { __MSPFComboDirect(_port, 0x02, _channel, _outa, _outb, __RETVAL__) }
#define MSPFSinglePinEx(_port, _addr, _channel, _out, _pin, _func, _cont) asm { __MSPFSinglePin(_port, _addr, _channel, _out, _pin, _func, _cont, __RETVAL__) }
#define MSPFSinglePin(_port, _channel, _out, _pin, _func, _cont) asm { __MSPFSinglePin(_port, 0x02, _channel, _out, _pin, _func, _cont, __RETVAL__) }
#define MSPFSingleOutputCSTEx(_port, _addr, _channel, _out, _func) asm { __MSPFSingleOutput(_port, _addr, _channel, _out, _func, TRUE, __RETVAL__) }
#define MSPFSingleOutputCST(_port, _channel, _out, _func) asm { __MSPFSingleOutput(_port, 0x02, _channel, _out, _func, TRUE, __RETVAL__) }
#define MSPFSingleOutputPWMEx(_port, _addr, _channel, _out, _func) asm { __MSPFSingleOutput(_port, _addr, _channel, _out, _func, FALSE, __RETVAL__) }
#define MSPFSingleOutputPWM(_port, _channel, _out, _func) asm { __MSPFSingleOutput(_port, 0x02, _channel, _out, _func, FALSE, __RETVAL__) }
#define MSPFComboPWMEx(_port, _addr, _channel, _outa, _outb) asm { __MSPFComboPWM(_port, _addr, _channel, _outa, _outb, __RETVAL__) }
#define MSPFComboPWM(_port, _channel, _outa, _outb) asm { __MSPFComboPWM(_port, 0x02, _channel, _outa, _outb, __RETVAL__) }
#define MSPFTrainEx(_port, _addr, _channel, _func) asm { __MSIRTrain(_port, _addr, _channel, _func, TRUE, __RETVAL__) }
#define MSPFTrain(_port, _channel, _func) asm { __MSIRTrain(_port, 0x02, _channel, _func, TRUE, __RETVAL__) }
#define MSIRTrainEx(_port, _addr, _channel, _func) asm { __MSIRTrain(_port, _addr, _channel, _func, FALSE, __RETVAL__) }
#define MSIRTrain(_port, _channel, _func) asm { __MSIRTrain(_port, 0x02, _channel, _func, FALSE, __RETVAL__) }
#define MSPFRawOutputEx(_port, _addr, _nibble0, _nibble1, _nibble2) asm { __MSPFRawOutput(_port, _addr, _nibble0, _nibble1, _nibble2, __RETVAL__) }
#define MSPFRawOutput(_port, _nibble0, _nibble1, _nibble2) asm { __MSPFRawOutput(_port, 0x02, _nibble0, _nibble1, _nibble2, __RETVAL__) }
#define MSPFRepeatEx(_port, _addr, _count, _delay) asm { __MSPFRepeatLastCommand(_port, _addr, _count, _delay, __RETVAL__) }
#define MSPFRepeat(_port, _count, _delay) asm { __MSPFRepeatLastCommand(_port, 0x02, _count, _delay, __RETVAL__) }

#define MSRCXSetNRLinkEx(_port, _addr) asm { __MSRCXSetNRLink(_port, _addr) }
#define MSRCXSetNRLinkPort(_port) asm { __MSRCXSetNRLink(_port, 0x02) }
#define MSRCXPoll(_src, _value) asm { __MSRCXPoll(_src, _value, __RETVAL__) }
#define MSRCXBatteryLevel() asm { __MSRCXBatteryLevel(__RETVAL__) }
#define MSRCXPing() asm { __MSRCXOpNoArgs(RCX_PingOp) }
#define MSRCXDeleteTasks() asm { __MSRCXOpNoArgs(RCX_DeleteTasksOp) }
#define MSRCXStopAllTasks() asm { __MSRCXOpNoArgs(RCX_StopAllTasksOp) }
#define MSRCXPBTurnOff() asm { __MSRCXOpNoArgs(RCX_PBTurnOffOp) }
#define MSRCXDeleteSubs() asm { __MSRCXOpNoArgs(RCX_DeleteSubsOp) }
#define MSRCXClearSound() asm { __MSRCXOpNoArgs(RCX_ClearSoundOp) }
#define MSRCXClearMsg() asm { __MSRCXOpNoArgs(RCX_ClearMsgOp) }
#define MSRCXMuteSound() asm { __MSRCXOpNoArgs(RCX_MuteSoundOp) }
#define MSRCXUnmuteSound() asm { __MSRCXOpNoArgs(RCX_UnmuteSoundOp) }
#define MSRCXClearAllEvents() asm { __MSRCXOpNoArgs(RCX_ClearAllEventsOp) }
#define MSRCXSetOutput(_outputs, _mode) asm { __MSRCXSetOutput(_outputs, _mode) }
#define MSRCXSetDirection(_outputs, _dir) asm { __MSRCXSetDirection(_outputs, _dir) }
#define MSRCXSetPower(_outputs, _pwrsrc, _pwrval) asm { __MSRCXSetPower(_outputs, _pwrsrc, _pwrval) }
#define MSRCXOn(_outputs) asm { __MSRCXSetOutput(_outputs, RCX_OUT_ON) }
#define MSRCXOff(_outputs) asm { __MSRCXSetOutput(_outputs, RCX_OUT_OFF) }
#define MSRCXFloat(_outputs) asm { __MSRCXSetOutput(_outputs, RCX_OUT_FLOAT) }
#define MSRCXToggle(_outputs) asm { __MSRCXSetDirection(_outputs, RCX_OUT_TOGGLE) }
#define MSRCXFwd(_outputs) asm { __MSRCXSetDirection(_outputs, RCX_OUT_FWD) }
#define MSRCXRev(_outputs) asm { __MSRCXSetDirection(_outputs, RCX_OUT_REV) }
#define MSRCXOnFwd(_outputs) asm { __MSRCXOnFwd(_outputs) }
#define MSRCXOnRev(_outputs) asm { __MSRCXOnRev(_outputs) }
#define MSRCXOnFor(_outputs, _ms) asm { __MSRCXOnFor(_outputs, _ms) }
#define MSRCXSetTxPower(_pwr) asm { __MSRCXSetTxPower(_pwr) }
#define MSRCXPlaySound(_snd) asm { __MSRCXPlaySound(_snd) }
#define MSRCXDeleteTask(_t) asm { __MSRCXDeleteTask(_t) }
#define MSRCXStartTask(_t) asm { __MSRCXStartTask(_t) }
#define MSRCXStopTask(_t) asm { __MSRCXStopTask(_t) }
#define MSRCXSelectProgram(_prog) asm { __MSRCXSelectProgram(_prog) }
#define MSRCXClearTimer(_timer) asm { __MSRCXClearTimer(_timer) }
#define MSRCXSetSleepTime(_t) asm { __MSRCXSetSleepTime(_t) }
#define MSRCXDeleteSub(_s) asm { __MSRCXDeleteSub(_s) }
#define MSRCXClearSensor(_port) asm { __MSRCXClearSensor(_port) }
#define MSRCXPlayToneVar(_varnum, _duration) asm { __MSRCXPlayToneVar(_varnum, _duration) }
#define MSRCXSetWatch(_hours, _minutes) asm { __MSRCXSetWatch(_hours, _minutes) }
#define MSRCXSetSensorType(_port, _type) asm { __MSRCXSetSensorType(_port, _type) }
#define MSRCXSetSensorMode(_port, _mode) asm { __MSRCXSetSensorMode(_port, _mode) }
#define MSRCXCreateDatalog(_size) asm { __MSRCXCreateDatalog(_size) }
#define MSRCXAddToDatalog(_src, _value) asm { __MSRCXAddToDatalog(_src, _value) }
#define MSRCXSendSerial(_first, _count) asm { __MSRCXSendSerial(_first, _count) }
#define MSRCXRemote(_cmd) asm { __MSRCXRemote(_cmd) }
#define MSRCXEvent(_src, _value) asm { __MSRCXEvent(_src, _value) }
#define MSRCXPlayTone(_freq, _duration) asm { __MSRCXPlayTone(_freq, _duration) }
#define MSRCXSelectDisplay(_src, _value) asm { __MSRCXSelectDisplay(_src, _value) }
#define MSRCXPollMemory(_address) asm { __MSRCXPollMemory(_address, __RETVAL__) }
#define MSRCXSetEvent(_evt, _src, _type) asm { __MSRCXSetEvent(_evt, _src, _type) }
#define MSRCXSetGlobalOutput(_outputs, _mode) asm { __MSRCXSetGlobalOutput(_outputs, _mode) }
#define MSRCXSetGlobalDirection(_outputs, _dir) asm { __MSRCXSetGlobalDirection(_outputs, _dir) }
#define MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) asm { __MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) }
#define MSRCXEnableOutput(_outputs) asm { __MSRCXSetGlobalOutput(_outputs, RCX_OUT_ON) }
#define MSRCXDisableOutput(_outputs) asm { __MSRCXSetGlobalOutput(_outputs, RCX_OUT_OFF) }
#define MSRCXInvertOutput(_outputs) asm { __MSRCXSetGlobalDirection(_outputs, RCX_OUT_REV) }
#define MSRCXObvertOutput(_outputs) asm { __MSRCXSetGlobalDirection(_outputs, RCX_OUT_FWD) }
#define MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) asm { __MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) }
#define MSRCXSetVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SetVarOp, _varnum, _src, _value) }
#define MSRCXSumVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SumVarOp, _varnum, _src, _value) }
#define MSRCXSubVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SubVarOp, _varnum, _src, _value) }
#define MSRCXDivVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_DivVarOp, _varnum, _src, _value) }
#define MSRCXMulVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_MulVarOp, _varnum, _src, _value) }
#define MSRCXSgnVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_SgnVarOp, _varnum, _src, _value) }
#define MSRCXAbsVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_AbsVarOp, _varnum, _src, _value) }
#define MSRCXAndVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_AndVarOp, _varnum, _src, _value) }
#define MSRCXOrVar(_varnum, _src, _value) asm { __MSRCXVarOp(RCX_OrVarOp, _varnum, _src, _value) }
#define MSRCXSet(_dstsrc, _dstval, _src, _value) asm { __MSRCXSet(_dstsrc, _dstval, _src, _value) }
#define MSRCXUnlock() asm { __MSRCXUnlock() }
#define MSRCXReset() asm { __MSRCXReset() }
#define MSRCXBoot() asm { __MSRCXBoot() }
#define MSRCXSetUserDisplay(_src, _value, _precision) asm { __MSRCXSetUserDisplay(_src, _value, _precision) }
#define MSRCXIncCounter(_counter) asm { __MSRCXIncCounter(_counter) }
#define MSRCXDecCounter(_counter) asm { __MSRCXDecCounter(_counter) }
#define MSRCXClearCounter(_counter) asm { __MSRCXClearCounter(_counter) }
#define MSRCXSetPriority(_p) asm { __MSRCXSetPriority(_p) }
#define MSRCXSetMessage(_msg) asm { __MSRCXSetMessage(_msg) }

#define MSScoutCalibrateSensor() asm { __MSRCXOpNoArgs(RCX_LSCalibrateOp) }
#define MSScoutMuteSound() asm { __MSScoutMuteSound() }
#define MSScoutUnmuteSound() asm { __MSScoutUnmuteSound() }
#define MSScoutSelectSounds(_grp) asm { __MSScoutSelectSounds(_grp) }
#define MSScoutSetLight(_x) asm { __MSScoutSetLight(_x) }
#define MSScoutSetCounterLimit(_ctr, _src, _value) asm { __MSScoutSetCounterLimit(_ctr, _src, _value) }
#define MSScoutSetTimerLimit(_tmr, _src, _value) asm { __MSScoutSetTimerLimit(_tmr, _src, _value) }
#define MSScoutSetSensorClickTime(_src, _value) asm { __MSScoutSetSensorClickTime(_src, _value) }
#define MSScoutSetSensorHysteresis(_src, _value) asm { __MSScoutSetSensorHysteresis(_src, _value) }
#define MSScoutSetSensorLowerLimit(_src, _value) asm { __MSScoutSetSensorLowerLimit(_src, _value) }
#define MSScoutSetSensorUpperLimit(_src, _value) asm { __MSScoutSetSensorUpperLimit(_src, _value) }
#define MSScoutSetEventFeedback(_src, _value) asm { __MSScoutSetEventFeedback(_src, _value) }
#define MSScoutSendVLL(_src, _value) asm { __MSScoutSendVLL(_src, _value) }
#define MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) asm { __MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) }
#define MSScoutSetScoutMode(_mode) asm { __MSScoutSetScoutMode(_mode) }

// RIC Macro wrappers
#define RICSetValue(_data, _idx, _newval) _data[(_idx)] = (_newval)&0xFF; _data[(_idx)+1] = (_newval)>>8

#endif // NXCDEFS_H
