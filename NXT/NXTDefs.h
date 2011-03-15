/* NXTDefs.h
 * Constants, macros, and API functions for use in NBC
 *
 * NXTDefs.h contains declarations for the NBC NXT API resources
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
 * Portions created by John Hansen are Copyright (C) 2009-2010 John Hansen.
 * All Rights Reserved.
 *
 * ----------------------------------------------------------------------------
 *
 * author John Hansen (bricxcc_at_comcast.net)
 * date 2011-03-15
 * version 76
 */
#ifndef NXTDEFS__H
#define NXTDEFS__H

#include "NBCCommon.h"

/** @addtogroup cmpconst
 * @{
 */
#define LT   0x00 /*!< The first value is less than the second. */
#define GT   0x01 /*!< The first value is greater than the second. */
#define LTEQ 0x02 /*!< The first value is less than or equal to the second. */
#define GTEQ 0x03 /*!< The first value is greater than or equal to the second. */
#define EQ   0x04 /*!< The first value is equal to the second. */
#define NEQ  0x05 /*!< The first value is not equal to the second. */
/** @} */  // end of cmpconst group

#ifdef __DOXYGEN_DOCS
// nothing to see here
#else
// define structures for various system calls

dseg	segment

TLocation	struct
 X		sword
 Y		sword
TLocation	ends

TSize	struct
 Width	sword
 Height	sword
TSize	ends

// FileOpenRead, FileOpenWrite, FileOpenAppend, FileOpenWriteLinear, FileOpenWriteNonLinear, FileOpenReadLinear
TFileOpen	struct
 Result		word
 FileHandle	byte
 Filename	byte[]
 Length		dword
TFileOpen	ends

// FileRead, FileWrite
TFileReadWrite	struct
 Result		word
 FileHandle	byte
 Buffer		byte[]
 Length		dword
TFileReadWrite	ends

// FileClose
TFileClose	struct
 Result		word
 FileHandle	byte
TFileClose	ends

// FileResolveHandle
TFileResolveHandle	struct
 Result		word
 FileHandle	byte
 WriteHandle	byte
 Filename	byte[]
TFileResolveHandle	ends

// FileRename
TFileRename	struct
 Result		word
 OldFilename	byte[]
 NewFilename	byte[]
TFileRename	ends

// FileDelete
TFileDelete	struct
 Result		word
 Filename	byte[]
TFileDelete	ends

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

// DrawText
TDrawText	struct
 Result		sbyte
 Location	TLocation
 Text		byte[]
 Options	dword
TDrawText	ends

// DrawPoint
TDrawPoint	struct
 Result		sbyte
 Location	TLocation
 Options	dword
TDrawPoint	ends

// DrawLine
TDrawLine	struct
 Result		sbyte
 StartLoc	TLocation
 EndLoc		TLocation
 Options	dword
TDrawLine	ends

// DrawCircle
TDrawCircle	struct
 Result		sbyte
 Center		TLocation
 Size		byte
 Options	dword
TDrawCircle	ends

// DrawRect
TDrawRect	struct
 Result		sbyte
 Location	TLocation
 Size		TSize
 Options	dword
TDrawRect	ends

// DrawGraphic
TDrawGraphic	struct
 Result		sbyte
 Location	TLocation
 Filename	byte[]
 Variables	sdword[]
 Options	dword
TDrawGraphic	ends

// SetScreenMode
TSetScreenMode	struct
 Result		sbyte
 ScreenMode	dword
TSetScreenMode	ends

// ReadButton
TReadButton	struct
 Result		sbyte
 Index		byte
 Pressed	byte
 Count		byte
 Reset		byte
TReadButton	ends

// CommLSWrite
TCommLSWrite	struct
 Result		sbyte
 Port		byte
 Buffer		byte[]
 ReturnLen	byte
TCommLSWrite	ends

// CommLSRead
TCommLSRead	struct
 Result		sbyte
 Port		byte
 Buffer		byte[]
 BufferLen	byte
TCommLSRead	ends

// CommLSCheckStatus
TCommLSCheckStatus	struct
 Result		sbyte
 Port		byte
 BytesReady	byte
TCommLSCheckStatus	ends

// RandomNumber
TRandomNumber	struct
 Result		sword
TRandomNumber	ends

// GetStartTick
TGetStartTick	struct
 Result		dword
TGetStartTick	ends

// MessageWrite
TMessageWrite	struct
 Result		sbyte
 QueueID	byte
 Message	byte[]
TMessageWrite	ends

// MessageRead
TMessageRead	struct
 Result		sbyte
 QueueID	byte
 Remove		byte
 Message	byte[]
TMessageRead	ends

// CommBTCheckStatus
TCommBTCheckStatus	struct
 Result		sbyte
 Connection	byte
TCommBTCheckStatus	ends

// CommBTWrite
TCommBTWrite	struct
 Result		sbyte
 Connection	byte
 Buffer		byte[]
TCommBTWrite	ends

// CommBTRead
TCommBTRead	struct
 Result		sbyte
 Count		byte
 Buffer		byte[]
TCommBTRead	ends

// KeepAlive
TKeepAlive	struct
 Result		dword
TKeepAlive	ends

// IOMapRead
TIOMapRead	struct
 Result		sbyte
 ModuleName	byte[]
 Offset		word
 Count		word
 Buffer		byte[]
TIOMapRead	ends

// IOMapWrite
TIOMapWrite	struct
 Result		sbyte
 ModuleName	byte[]
 Offset		word
 Buffer		byte[]
TIOMapWrite	ends

#ifdef __ENHANCED_FIRMWARE

TIOMapReadByID struct
  Result    sbyte
  ModuleID  long
  Offset    word
  Count     word
  Buffer    byte[]
TIOMapReadByID ends

TIOMapWriteByID struct
  Result   sbyte
  ModuleID long
  Offset   word
  Buffer   byte[]
TIOMapWriteByID ends

TDisplayExecuteFunction struct
  Status byte
  Cmd    byte
  On     byte
  X1     byte
  Y1     byte
  X2     byte
  Y2     byte
TDisplayExecuteFunction ends

TCommExecuteFunction struct
  Result word
  Cmd    byte
  Param1 byte
  Param2 byte
  Param3 byte
  Name   byte[]
  RetVal word
TCommExecuteFunction ends

TLoaderExecuteFunction struct
  Result   word
  Cmd      byte
  Filename byte[]
  Buffer   byte[]
  Length   long
TLoaderExecuteFunction ends

// FileFindFirst, FileFindNext
TFileFind	struct
 Result		word
 FileHandle	byte
 Filename	byte[]
 Length		dword
TFileFind	ends

TCommHSControl	struct
 Result		sbyte
 Command	byte
 BaudRate	byte
#if __FIRMWARE_VERSION > 107
 Mode		word
#endif
TCommHSControl	ends

TCommHSCheckStatus	struct
 SendingData	byte
 DataAvailable	byte
TCommHSCheckStatus	ends

// CommHSRead, CommHSWrite
TCommHSReadWrite	struct
 Status	sbyte
 Buffer	byte[]
TCommHSReadWrite	ends

// CommLSWriteEx
TCommLSWriteEx	struct
 Result		sbyte
 Port		byte
 Buffer		byte[]
 ReturnLen	byte
 NoRestartOnRead	byte
TCommLSWriteEx	ends

#if __FIRMWARE_VERSION > 107
//FileSeek
TFileSeek	struct
 Result		word
 FileHandle	byte
 Origin		byte
 Length		sdword
TFileSeek	ends

//FileResize
TFileResize	struct
 Result		word
 FileHandle	byte
 NewSize	word
TFileResize	ends

// DrawGraphicArray
TDrawGraphicArray	struct
 Result		sbyte
 Location	TLocation
 Data		byte[]
 Variables	sdword[]
 Options	dword
TDrawGraphicArray	ends

// DrawPolygon
TDrawPolygon	struct
 Result		sbyte
 Points		TLocation[]
 Options	dword
TDrawPolygon	ends

// DrawEllipse
TDrawEllipse	struct
 Result		sbyte
 Center		TLocation
 SizeX		byte
 SizeY		byte
 Options	dword
TDrawEllipse	ends

// DrawFont
TDrawFont	struct
 Result		sbyte
 Location	TLocation
 Filename	byte[]
 Text		byte[]
 Options	dword
TDrawFont	ends

// MemoryManager
TMemoryManager struct
 Result        sbyte
 Compact       byte
 PoolSize      word
 DataspaceSize word
TMemoryManager ends

// ReadLastResponse
TReadLastResponse struct
 Result  sbyte
 Clear   byte
 Length  byte
 Command byte
 Buffer	 byte[]
TReadLastResponse ends

// FileTell
TFileTell struct
 Result     sbyte
 FileHandle byte
 Position   dword
TFileTell ends
#endif
#endif

#if __FIRMWARE_VERSION > 107

// ColorSensorRead
TColorSensorRead	struct
 Result			sbyte
 Port			byte
 ColorValue		sword
 RawArray		word[]
 NormalizedArray	word[]
 ScaledArray		sword[]
 Invalid		byte
TColorSensorRead	ends

// DatalogWrite
TDatalogWrite	struct
 Result		sbyte
 Message	byte[]
TDatalogWrite	ends

// DatalogGetTimes
TDatalogGetTimes	struct
 SyncTime	dword
 SyncTick	dword
TDatalogGetTimes	ends

// SetSleepTimeout
TSetSleepTimeout	struct
 Result		sbyte
 TheSleepTimeoutMS	dword
TSetSleepTimeout	ends

// CommBTOnOff
TCommBTOnOff	struct
#ifdef __ENHANCED_FIRMWARE
 Result		word
#else
 Result		sbyte
#endif
 PowerState	byte
TCommBTOnOff	ends

// CommBTConnection
TCommBTConnection	struct
#ifdef __ENHANCED_FIRMWARE
 Result		word
#else
 Result		sbyte
#endif
 Action		byte
 Name		byte[]
 ConnectionSlot	byte
TCommBTConnection	ends

// ReadSemData
TReadSemData struct
 SemData byte
 Request byte
TReadSemData ends

// WriteSemData
TWriteSemData struct
 SemData byte
 Request byte
 NewVal byte
 ClearBits byte
TWriteSemData ends

// UpdateCalibCacheInfo
TUpdateCalibCacheInfo struct
 Result byte
 Name byte[]
 MinVal word
 MaxVal word
TUpdateCalibCacheInfo ends

// ComputeCalibValue
TComputeCalibValue struct
 Result byte
 Name byte[]
 RawVal word
TComputeCalibValue ends

// ListFiles
TListFiles	struct
 Result		sbyte
 Pattern	byte[]
 FileList	byte[][]
TListFiles	ends

#endif

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
TOutputState struct // for use with the RemoteGetOutputState direct command response
  Port            byte
  Power           sbyte
  Mode            byte
  RegMode         byte
  TurnRatio       sbyte
  RunState        byte
  TachoLimit      dword
  TachoCount      sdword
  BlockTachoCount sdword
  RotationCount   sdword
TOutputState ends

TInputValues struct // for use with the RemoteGetInputValues direct command response
  Port            byte
  Valid           byte
  Calibrated      byte
  SensorType      byte
  SensorMode      byte
  RawValue        word
  NormalizedValue word
  ScaledValue     sword
  CalibratedValue sword
TInputValues ends

TInput struct
  CustomZeroOffset   word
  ADRaw              word
  SensorRaw          word
  SensorValue        sword
  SensorType         byte
  SensorMode         byte
  SensorBoolean      byte
  DigiPinsDir        byte
  DigiPinsIn         byte
  DigiPinsOut        byte
  CustomPctFullScale byte
  CustomActiveStatus byte
  InvalidData        byte
TInput ends // 17 bytes

TOutput struct
  TachoCnt          sdword
  BlockTachoCount   sdword
  RotationCount     sdword
  TachoLimit        dword
  MotorRPM          sword
  Flags             byte
  Mode              byte
  Speed             sbyte
  ActualSpeed       sbyte
  RegPParameter     byte
  RegIParameter     byte
  RegDParameter     byte
  RunState          byte
  RegMode           byte
  Overloaded        byte
  SyncTurnParameter sbyte
  Options           byte
TOutput ends // 30 bytes

TButtonCounts struct
  BtnPressedCnt   byte
  BtnLongPressCnt byte
  BtnShortRelCnt  byte
  BtnLongRelCnt   byte
  BtnRelCnt       byte
TButtonCounts ends // 5 bytes

TBluetoothDevice struct
  Name          byte[]
  ClassOfDevice byte[]
  BdAddr        byte[]
  DeviceStatus  byte
TBluetoothDevice ends // 28 bytes

TBluetoothConnection struct
  Name          byte[]
  ClassOfDevice byte[]
  PinCode       byte[]
  BdAddr        byte[]
  HandleNr      byte
  StreamStatus  byte
  LinkQuality   byte
TBluetoothConnection ends // 46 bytes

TBrickData struct
  Name            byte[]
  BluecoreVersion byte[]
  BdAddr          byte[]
  BtStateStatus   byte
  BtHwStatus      byte
  TimeOutValue    byte
TBrickData ends // 28 bytes

#endif

dseg	ends

// motor arrays (compiler will optimize these out if they are not used)
dseg segment
  __OUT_AB byte[] OUT_A, OUT_B
  __OUT_AC byte[] OUT_A, OUT_C
  __OUT_BC byte[] OUT_B, OUT_C
  __OUT_ABC byte[] OUT_A, OUT_B, OUT_C
  __OnRev_Tmp sbyte
  __OnRevMutex mutex
dseg ends

dseg segment
  __rotateMutex0 mutex
  __rotateMutex1 mutex
  __rotateMutex2 mutex
dseg ends

dseg segment
// variables for rotate motor subroutine (0)
  __rotate_power0 byte
  __rotate_angle0 slong
  __rotate_ports0 byte[]
  __rotate_firstPort0 byte
  __rotate_sync0 byte
  __rotate_stop0 byte
  __rotate_turnpct0 sbyte
  __rotate_theUF0 byte
  __rotate_theOM0 byte
  __rotate_theRM0 byte
  __rotate_theRS0 byte
  __rotate_theRVP0 byte
  __rotate_theRVI0 byte
  __rotate_theRVD0 byte
  __rotate_rs0 byte
  __rotate_OldRotCount0 sword
  __rotate_RotCount0 sword
  __rotate_thePower0 sbyte
  __rotate_theAngle0 ulong
  __rotate_theTurnPct0 sbyte
  __rotate_then0 dword
  __rotate_now0 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (1)
  __rotate_power1 byte
  __rotate_angle1 slong
  __rotate_ports1 byte[]
  __rotate_firstPort1 byte
  __rotate_sync1 byte
  __rotate_stop1 byte
  __rotate_turnpct1 sbyte
  __rotate_theUF1 byte
  __rotate_theOM1 byte
  __rotate_theRM1 byte
  __rotate_theRS1 byte
  __rotate_theRVP1 byte
  __rotate_theRVI1 byte
  __rotate_theRVD1 byte
  __rotate_rs1 byte
  __rotate_OldRotCount1 sword
  __rotate_RotCount1 sword
  __rotate_thePower1 sbyte
  __rotate_theAngle1 ulong
  __rotate_theTurnPct1 sbyte
  __rotate_then1 dword
  __rotate_now1 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (2)
  __rotate_power2 byte
  __rotate_angle2 slong
  __rotate_ports2 byte[]
  __rotate_firstPort2 byte
  __rotate_sync2 byte
  __rotate_stop2 byte
  __rotate_turnpct2 sbyte
  __rotate_theUF2 byte
  __rotate_theOM2 byte
  __rotate_theRM2 byte
  __rotate_theRS2 byte
  __rotate_theRVP2 byte
  __rotate_theRVI2 byte
  __rotate_theRVD2 byte
  __rotate_rs2 byte
  __rotate_OldRotCount2 sword
  __rotate_RotCount2 sword
  __rotate_thePower2 sbyte
  __rotate_theAngle2 ulong
  __rotate_theTurnPct2 sbyte
  __rotate_then2 dword
  __rotate_now2 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (3)
  __rotate_power3 byte
  __rotate_angle3 slong
  __rotate_ports3 byte[]
  __rotate_firstPort3 byte
  __rotate_sync3 byte
  __rotate_stop3 byte
  __rotate_turnpct3 sbyte
  __rotate_theUF3 byte
  __rotate_theOM3 byte
  __rotate_theRM3 byte
  __rotate_theRS3 byte
  __rotate_theRVP3 byte
  __rotate_theRVI3 byte
  __rotate_theRVD3 byte
  __rotate_rs3 byte
  __rotate_OldRotCount3 sword
  __rotate_RotCount3 sword
  __rotate_thePower3 sbyte
  __rotate_theAngle3 ulong
  __rotate_theTurnPct3 sbyte
  __rotate_then3 dword
  __rotate_now3 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (4)
  __rotate_power4 byte
  __rotate_angle4 slong
  __rotate_ports4 byte[]
  __rotate_firstPort4 byte
  __rotate_sync4 byte
  __rotate_stop4 byte
  __rotate_turnpct4 sbyte
  __rotate_theUF4 byte
  __rotate_theOM4 byte
  __rotate_theRM4 byte
  __rotate_theRS4 byte
  __rotate_theRVP4 byte
  __rotate_theRVI4 byte
  __rotate_theRVD4 byte
  __rotate_rs4 byte
  __rotate_OldRotCount4 sword
  __rotate_RotCount4 sword
  __rotate_thePower4 sbyte
  __rotate_theAngle4 ulong
  __rotate_theTurnPct4 sbyte
  __rotate_then4 dword
  __rotate_now4 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (5)
  __rotate_power5 byte
  __rotate_angle5 slong
  __rotate_ports5 byte[]
  __rotate_firstPort5 byte
  __rotate_sync5 byte
  __rotate_stop5 byte
  __rotate_turnpct5 sbyte
  __rotate_theUF5 byte
  __rotate_theOM5 byte
  __rotate_theRM5 byte
  __rotate_theRS5 byte
  __rotate_theRVP5 byte
  __rotate_theRVI5 byte
  __rotate_theRVD5 byte
  __rotate_rs5 byte
  __rotate_OldRotCount5 sword
  __rotate_RotCount5 sword
  __rotate_thePower5 sbyte
  __rotate_theAngle5 ulong
  __rotate_theTurnPct5 sbyte
  __rotate_then5 dword
  __rotate_now5 dword
dseg ends

dseg segment
// variables for rotate motor subroutine (6)
  __rotate_power6 byte
  __rotate_angle6 slong
  __rotate_ports6 byte[]
  __rotate_firstPort6 byte
  __rotate_sync6 byte
  __rotate_stop6 byte
  __rotate_turnpct6 sbyte
  __rotate_theUF6 byte
  __rotate_theOM6 byte
  __rotate_theRM6 byte
  __rotate_theRS6 byte
  __rotate_theRVP6 byte
  __rotate_theRVI6 byte
  __rotate_theRVD6 byte
  __rotate_rs6 byte
  __rotate_OldRotCount6 sword
  __rotate_RotCount6 sword
  __rotate_thePower6 sbyte
  __rotate_theAngle6 ulong
  __rotate_theTurnPct6 sbyte
  __rotate_then6 dword
  __rotate_now6 dword
dseg ends

#define UF_UPDATE_ONFWD 0x28

// API macros
#define __resetMotorCounter0(_val) setout OUT_A, UpdateFlagsField, _val
#define __resetMotorCounter1(_val) setout OUT_B, UpdateFlagsField, _val
#define __resetMotorCounter2(_val) setout OUT_C, UpdateFlagsField, _val
#define __resetMotorCounter3(_val) setout __OUT_AB, UpdateFlagsField, _val
#define __resetMotorCounter4(_val) setout __OUT_AC, UpdateFlagsField, _val
#define __resetMotorCounter5(_val) setout __OUT_BC, UpdateFlagsField, _val
#define __resetMotorCounter6(_val) setout __OUT_ABC, UpdateFlagsField, _val

#define __resetTachoCount(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlagsField, RESET_COUNT \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_COUNT) \
  compend

#define __resetBlockTachoCount(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlagsField, RESET_BLOCK_COUNT \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_BLOCK_COUNT) \
  compend

#define __resetRotationCount(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlagsField, RESET_ROTATION_COUNT \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_ROTATION_COUNT) \
  compend

#define __resetAllTachoCounts(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlagsField, RESET_ALL \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_ALL) \
  compend

#define __onFwdExPIDAll(_ports, _pwr, _reset, _p, _i, _d) setout _ports, PowerField, _pwr, OutputModeField, OUT_MODE_MOTORON+OUT_MODE_BRAKE, RegModeField, OUT_REGMODE_IDLE, RunStateField, OUT_RUNSTATE_RUNNING, TurnRatioField, 0, TachoLimitField, 0, RegPValueField, _p, RegIValueField, _i, RegDValueField, _d, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __onFwdExPID0(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(OUT_A, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID1(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(OUT_B, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID2(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(OUT_C, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID3(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_AB, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID4(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_AC, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID5(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_BC, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID6(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_ABC, _pwr, _reset, _p, _i, _d)

#define __coastExAll(_ports, _reset) setout _ports, PowerField, 0, OutputModeField, OUT_MODE_BRAKE, RegModeField, OUT_REGMODE_IDLE, RunStateField, OUT_RUNSTATE_IDLE, TurnRatioField, 0, TachoLimitField, 0, RegPValueField, PID_3, RegIValueField, PID_1, RegDValueField, PID_1, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __coastEx0(_reset) __coastExAll(OUT_A, _reset)
#define __coastEx1(_reset) __coastExAll(OUT_B, _reset)
#define __coastEx2(_reset) __coastExAll(OUT_C, _reset)
#define __coastEx3(_reset) __coastExAll(__OUT_AB, _reset)
#define __coastEx4(_reset) __coastExAll(__OUT_AC, _reset)
#define __coastEx5(_reset) __coastExAll(__OUT_BC, _reset)
#define __coastEx6(_reset) __coastExAll(__OUT_ABC, _reset)

#define __offExAll(_ports, _reset) setout _ports, PowerField, 0, OutputModeField, OUT_MODE_MOTORON+OUT_MODE_BRAKE, RegModeField, OUT_REGMODE_IDLE, RunStateField, OUT_RUNSTATE_RUNNING, TurnRatioField, 0, TachoLimitField, 0, RegPValueField, PID_3, RegIValueField, PID_1, RegDValueField, PID_1, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __offEx0(_reset) __offExAll(OUT_A, _reset)
#define __offEx1(_reset) __offExAll(OUT_B, _reset)
#define __offEx2(_reset) __offExAll(OUT_C, _reset)
#define __offEx3(_reset) __offExAll(__OUT_AB, _reset)
#define __offEx4(_reset) __offExAll(__OUT_AC, _reset)
#define __offEx5(_reset) __offExAll(__OUT_BC, _reset)
#define __offEx6(_reset) __offExAll(__OUT_ABC, _reset)

#define __onFwdRegExPIDAll(_ports, _pwr, _regmode, _reset, _p, _i, _d) setout _ports, PowerField, _pwr, OutputModeField, OUT_MODE_MOTORON+OUT_MODE_REGULATED+OUT_MODE_BRAKE, RegModeField, _regmode, RunStateField, OUT_RUNSTATE_RUNNING, TurnRatioField, 0, TachoLimitField, 0, RegPValueField, _p, RegIValueField, _i, RegDValueField, _d, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __onFwdRegExPID0(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(OUT_A, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID1(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(OUT_B, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID2(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(OUT_C, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID3(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_AB, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID4(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_AC, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID5(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_BC, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID6(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_ABC, _pwr, _regmode, _reset, _p, _i, _d)

#define __onFwdSyncExPIDAll(_ports, _pwr, _turnpct, _reset, _p, _i, _d) setout _ports, PowerField, _pwr, OutputModeField, OUT_MODE_MOTORON+OUT_MODE_REGULATED+OUT_MODE_BRAKE, RegModeField, OUT_REGMODE_SYNC, TurnRatioField, _turnpct, RunStateField, OUT_RUNSTATE_RUNNING, TachoLimitField, 0, RegPValueField, _p, RegIValueField, _i, RegDValueField, _d, UpdateFlagsField, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __onFwdSyncExPID0(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(OUT_A, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID1(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(OUT_B, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID2(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(OUT_C, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID3(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_AB, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID4(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_AC, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID5(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_BC, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID6(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_ABC, _pwr, _turnpct, _reset, _p, _i, _d)

#define __rotateMotorExPID0(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   arrbuild __rotate_ports0, OUT_A \
   mov __rotate_power0, _pwr \
   mov __rotate_angle0, _angle \
   mov __rotate_turnpct0, _turnpct \
   mov __rotate_sync0, _bSync \
   mov __rotate_stop0, _bStop \
   mov __rotate_theRVP0, _p \
   mov __rotate_theRVI0, _i \
   mov __rotate_theRVD0, _d \
   call __RotateMotor0 \
   release __rotateMutex0

#define __rotateMotorExPID1(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex1 \
   arrbuild __rotate_ports1, OUT_B \
   mov __rotate_power1, _pwr \
   mov __rotate_angle1, _angle \
   mov __rotate_turnpct1, _turnpct \
   mov __rotate_sync1, _bSync \
   mov __rotate_stop1, _bStop \
   mov __rotate_theRVP1, _p \
   mov __rotate_theRVI1, _i \
   mov __rotate_theRVD1, _d \
   call __RotateMotor1 \
   release __rotateMutex1

#define __rotateMotorExPID2(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex2 \
   arrbuild __rotate_ports2, OUT_C \
   mov __rotate_power2, _pwr \
   mov __rotate_angle2, _angle \
   mov __rotate_turnpct2, _turnpct \
   mov __rotate_sync2, _bSync \
   mov __rotate_stop2, _bStop \
   mov __rotate_theRVP2, _p \
   mov __rotate_theRVI2, _i \
   mov __rotate_theRVD2, _d \
   call __RotateMotor2 \
   release __rotateMutex2

#define __rotateMotorExPID3(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   acquire __rotateMutex1 \
   mov __rotate_ports3, __OUT_AB \
   mov __rotate_power3, _pwr \
   mov __rotate_angle3, _angle \
   mov __rotate_turnpct3, _turnpct \
   mov __rotate_sync3, _bSync \
   mov __rotate_stop3, _bStop \
   mov __rotate_theRVP3, _p \
   mov __rotate_theRVI3, _i \
   mov __rotate_theRVD3, _d \
   call __RotateMotor3 \
   release __rotateMutex1 \
   release __rotateMutex0

#define __rotateMotorExPID4(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   acquire __rotateMutex2 \
   mov __rotate_ports4, __OUT_AC \
   mov __rotate_power4, _pwr \
   mov __rotate_angle4, _angle \
   mov __rotate_turnpct4, _turnpct \
   mov __rotate_sync4, _bSync \
   mov __rotate_stop4, _bStop \
   mov __rotate_theRVP4, _p \
   mov __rotate_theRVI4, _i \
   mov __rotate_theRVD4, _d \
   call __RotateMotor4 \
   release __rotateMutex2 \
   release __rotateMutex0

#define __rotateMotorExPID5(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex1 \
   acquire __rotateMutex2 \
   mov __rotate_ports5, __OUT_BC \
   mov __rotate_power5, _pwr \
   mov __rotate_angle5, _angle \
   mov __rotate_turnpct5, _turnpct \
   mov __rotate_sync5, _bSync \
   mov __rotate_stop5, _bStop \
   mov __rotate_theRVP5, _p \
   mov __rotate_theRVI5, _i \
   mov __rotate_theRVD5, _d \
   call __RotateMotor5 \
   release __rotateMutex2 \
   release __rotateMutex1

#define __rotateMotorExPID6(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   acquire __rotateMutex1 \
   acquire __rotateMutex2 \
   mov __rotate_ports6, __OUT_ABC \
   mov __rotate_power6, _pwr \
   mov __rotate_angle6, _angle \
   mov __rotate_turnpct6, _turnpct \
   mov __rotate_sync6, _bSync \
   mov __rotate_stop6, _bStop \
   mov __rotate_theRVP6, _p \
   mov __rotate_theRVI6, _i \
   mov __rotate_theRVD6, _d \
   call __RotateMotor6 \
   release __rotateMutex2 \
   release __rotateMutex1 \
   release __rotateMutex0

#define __rotateMotorExPIDVar(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   acquire __rotateMutex0 \
   acquire __rotateMutex1 \
   acquire __rotateMutex2 \
   arrbuild __rotate_ports6, _ports \
   mov __rotate_power6, _pwr \
   mov __rotate_angle6, _angle \
   mov __rotate_turnpct6, _turnpct \
   mov __rotate_sync6, _bSync \
   mov __rotate_stop6, _bStop \
   mov __rotate_theRVP6, _p \
   mov __rotate_theRVI6, _i \
   mov __rotate_theRVD6, _d \
   call __RotateMotorVar \
   release __rotateMutex2 \
   release __rotateMutex1 \
   release __rotateMutex0

subroutine __RotateMotor0
  brtst EQ, __rotate_Done0, __rotate_angle0
  sign __rotate_thePower0, __rotate_angle0
  abs __rotate_theAngle0, __rotate_angle0
  mul __rotate_thePower0, __rotate_thePower0, __rotate_power0 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF0, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync0, __rotate_sync0
  set __rotate_theOM0, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM0, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct0, __rotate_turnpct0
  brtst EQ, __rotate_Start0, __rotate_theTurnPct0
  add __rotate_theUF0, __rotate_theUF0, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start0
__rotate_NoSync0:
  set __rotate_theOM0, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM0, OUT_REGMODE_IDLE
  set __rotate_theTurnPct0, 0
__rotate_Start0:
  set __rotate_theRS0, OUT_RUNSTATE_RUNNING
  setout __rotate_ports0, OutputModeField, __rotate_theOM0, RegModeField, __rotate_theRM0, TachoLimitField, __rotate_theAngle0, RunStateField, __rotate_theRS0, RegPValueField, __rotate_theRVP0, RegIValueField, __rotate_theRVI0, RegDValueField, __rotate_theRVD0, PowerField, __rotate_thePower0, TurnRatioField, __rotate_turnpct0, UpdateFlagsField, __rotate_theUF0

// Waits till angle reached
  index __rotate_firstPort0, __rotate_ports0, NA
__rotate_Running0:
  getout __rotate_power0, __rotate_firstPort0, PowerField
  brtst EQ, __rotate_doneRunning0, __rotate_power0
  getout __rotate_rs0, __rotate_firstPort0, RunStateField
  brcmp EQ, __rotate_Running0, __rotate_rs0, OUT_RUNSTATE_RUNNING
__rotate_doneRunning0:
  brtst EQ, __rotate_Reset0, __rotate_stop0 // skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM0, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF0, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports0, OutputModeField, __rotate_theOM0, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS0, PowerField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF0
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount0, __rotate_firstPort0, RotationCountField
__rotate_Stabilize0:
  mov __rotate_OldRotCount0, __rotate_RotCount0
  wait 50
  // check rotation
  getout __rotate_RotCount0, __rotate_firstPort0, RotationCountField
  brcmp NEQ, __rotate_Stabilize0, __rotate_OldRotCount0, __rotate_RotCount0
  set __rotate_theOM0, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports0, RegModeField, __rotate_theRM0, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM0, UpdateFlagsField, UF_UPDATE_MODE
__rotate_Reset0:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done0, __rotate_theTurnPct0
  setout __rotate_ports0, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done0:
  return
ends

subroutine __RotateMotor1
  brtst EQ, __rotate_Done1, __rotate_angle1
  sign __rotate_thePower1, __rotate_angle1
  abs __rotate_theAngle1, __rotate_angle1
  mul __rotate_thePower1, __rotate_thePower1, __rotate_power1 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF1, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync1, __rotate_sync1
  set __rotate_theOM1, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM1, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct1, __rotate_turnpct1
  brtst EQ, __rotate_Start1, __rotate_theTurnPct1
  add __rotate_theUF1, __rotate_theUF1, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start1
__rotate_NoSync1:
  set __rotate_theOM1, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM1, OUT_REGMODE_IDLE
  set __rotate_theTurnPct1, 0
__rotate_Start1:
  set __rotate_theRS1, OUT_RUNSTATE_RUNNING
  setout __rotate_ports1, OutputModeField, __rotate_theOM1, RegModeField, __rotate_theRM1, TachoLimitField, __rotate_theAngle1, RunStateField, __rotate_theRS1, RegPValueField, __rotate_theRVP1, RegIValueField, __rotate_theRVI1, RegDValueField, __rotate_theRVD1, PowerField, __rotate_thePower1, TurnRatioField, __rotate_turnpct1, UpdateFlagsField, __rotate_theUF1

// Waits till angle reached
  index __rotate_firstPort1, __rotate_ports1, NA
__rotate_Running1:
  getout __rotate_power1, __rotate_firstPort1, PowerField
  brtst EQ, __rotate_doneRunning1, __rotate_power1
  getout __rotate_rs1, __rotate_firstPort1, RunStateField
  brcmp EQ, __rotate_Running1, __rotate_rs1, OUT_RUNSTATE_RUNNING
__rotate_doneRunning1:
  brtst EQ, __rotate_Reset1, __rotate_stop1 // skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM1, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF1, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports1, OutputModeField, __rotate_theOM1, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS1, PowerField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF1
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount1, __rotate_firstPort1, RotationCountField
__rotate_Stabilize1:
  mov __rotate_OldRotCount1, __rotate_RotCount1
  wait 50
  // check rotation
  getout __rotate_RotCount1, __rotate_firstPort1, RotationCountField
  brcmp NEQ, __rotate_Stabilize1, __rotate_OldRotCount1, __rotate_RotCount1
  set __rotate_theOM1, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports1, RegModeField, __rotate_theRM1, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM1, UpdateFlagsField, UF_UPDATE_MODE
__rotate_Reset1:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done1, __rotate_theTurnPct1
  setout __rotate_ports1, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done1:
  return
ends

subroutine __RotateMotor2
  brtst EQ, __rotate_Done2, __rotate_angle2
  sign __rotate_thePower2, __rotate_angle2
  abs __rotate_theAngle2, __rotate_angle2
  mul __rotate_thePower2, __rotate_thePower2, __rotate_power2 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF2, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync2, __rotate_sync2
  set __rotate_theOM2, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM2, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct2, __rotate_turnpct2
  brtst EQ, __rotate_Start2, __rotate_theTurnPct2
  add __rotate_theUF2, __rotate_theUF2, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start2
__rotate_NoSync2:
  set __rotate_theOM2, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM2, OUT_REGMODE_IDLE
  set __rotate_theTurnPct2, 0
__rotate_Start2:
  set __rotate_theRS2, OUT_RUNSTATE_RUNNING
  setout __rotate_ports2, OutputModeField, __rotate_theOM2, RegModeField, __rotate_theRM2, TachoLimitField, __rotate_theAngle2, RunStateField, __rotate_theRS2, RegPValueField, __rotate_theRVP2, RegIValueField, __rotate_theRVI2, RegDValueField, __rotate_theRVD2, PowerField, __rotate_thePower2, TurnRatioField, __rotate_turnpct2, UpdateFlagsField, __rotate_theUF2

// Waits till angle reached
  index __rotate_firstPort2, __rotate_ports2, NA
__rotate_Running2:
  getout __rotate_power2, __rotate_firstPort2, PowerField
  brtst EQ, __rotate_doneRunning2, __rotate_power2
  getout __rotate_rs2, __rotate_firstPort2, RunStateField
  brcmp EQ, __rotate_Running2, __rotate_rs2, OUT_RUNSTATE_RUNNING
__rotate_doneRunning2:
  brtst EQ, __rotate_Reset2, __rotate_stop2 // skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM2, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF2, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports2, OutputModeField, __rotate_theOM2, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS2, PowerField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF2
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount2, __rotate_firstPort2, RotationCountField
__rotate_Stabilize2:
  mov __rotate_OldRotCount2, __rotate_RotCount2
  wait 50
  // check rotation
  getout __rotate_RotCount2, __rotate_firstPort2, RotationCountField
  brcmp NEQ, __rotate_Stabilize2, __rotate_OldRotCount2, __rotate_RotCount2
  set __rotate_theOM2, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports2, RegModeField, __rotate_theRM2, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM2, UpdateFlagsField, UF_UPDATE_MODE
__rotate_Reset2:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done2, __rotate_theTurnPct2
  setout __rotate_ports2, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done2:
  return
ends

subroutine __RotateMotor3
  brtst EQ, __rotate_Done3, __rotate_angle3
  sign __rotate_thePower3, __rotate_angle3
  abs __rotate_theAngle3, __rotate_angle3
  mul __rotate_thePower3, __rotate_thePower3, __rotate_power3 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF3, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync3, __rotate_sync3
  set __rotate_theOM3, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM3, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct3, __rotate_turnpct3
  brtst EQ, __rotate_Start3, __rotate_theTurnPct3
  add __rotate_theUF3, __rotate_theUF3, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start3
__rotate_NoSync3:
  set __rotate_theOM3, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM3, OUT_REGMODE_IDLE
  set __rotate_theTurnPct3, 0
__rotate_Start3:
  set __rotate_theRS3, OUT_RUNSTATE_RUNNING
  setout __rotate_ports3, OutputModeField, __rotate_theOM3, RegModeField, __rotate_theRM3, TachoLimitField, __rotate_theAngle3, RunStateField, __rotate_theRS3, RegPValueField, __rotate_theRVP3, RegIValueField, __rotate_theRVI3, RegDValueField, __rotate_theRVD3, PowerField, __rotate_thePower3, TurnRatioField, __rotate_turnpct3, UpdateFlagsField, __rotate_theUF3

// Waits till angle reached
  index __rotate_firstPort3, __rotate_ports3, NA
__rotate_Running3:
  getout __rotate_power3, __rotate_firstPort3, PowerField
  brtst EQ, __rotate_doneRunning3, __rotate_power3
  getout __rotate_rs3, __rotate_firstPort3, RunStateField
  brcmp EQ, __rotate_Running3, __rotate_rs3, OUT_RUNSTATE_RUNNING
__rotate_doneRunning3:
  brtst EQ, __rotate_Reset3, __rotate_stop3 // skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM3, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF3, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports3, OutputModeField, __rotate_theOM3, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS3, PowerField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF3
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount3, __rotate_firstPort3, RotationCountField
__rotate_Stabilize3:
  mov __rotate_OldRotCount3, __rotate_RotCount3
  wait 50
  // check rotation
  getout __rotate_RotCount3, __rotate_firstPort3, RotationCountField
  brcmp NEQ, __rotate_Stabilize3, __rotate_OldRotCount3, __rotate_RotCount3
  set __rotate_theOM3, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports3, RegModeField, __rotate_theRM3, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM3, UpdateFlagsField, UF_UPDATE_MODE
__rotate_Reset3:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done3, __rotate_theTurnPct3
  setout __rotate_ports3, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done3:
  return
ends

subroutine __RotateMotor4
  brtst EQ, __rotate_Done4, __rotate_angle4
  sign __rotate_thePower4, __rotate_angle4
  abs __rotate_theAngle4, __rotate_angle4
  mul __rotate_thePower4, __rotate_thePower4, __rotate_power4 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF4, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync4, __rotate_sync4
  set __rotate_theOM4, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM4, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct4, __rotate_turnpct4
  brtst EQ, __rotate_Start4, __rotate_theTurnPct4
  add __rotate_theUF4, __rotate_theUF4, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start4
__rotate_NoSync4:
  set __rotate_theOM4, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM4, OUT_REGMODE_IDLE
  set __rotate_theTurnPct4, 0
__rotate_Start4:
  set __rotate_theRS4, OUT_RUNSTATE_RUNNING
  setout __rotate_ports4, OutputModeField, __rotate_theOM4, RegModeField, __rotate_theRM4, TachoLimitField, __rotate_theAngle4, RunStateField, __rotate_theRS4, RegPValueField, __rotate_theRVP4, RegIValueField, __rotate_theRVI4, RegDValueField, __rotate_theRVD4, PowerField, __rotate_thePower4, TurnRatioField, __rotate_turnpct4, UpdateFlagsField, __rotate_theUF4

// Waits till angle reached
  index __rotate_firstPort4, __rotate_ports4, NA
__rotate_Running4:
  getout __rotate_power4, __rotate_firstPort4, PowerField
  brtst EQ, __rotate_doneRunning4, __rotate_power4
  getout __rotate_rs4, __rotate_firstPort4, RunStateField
  brcmp EQ, __rotate_Running4, __rotate_rs4, OUT_RUNSTATE_RUNNING
__rotate_doneRunning4:
  brtst EQ, __rotate_Reset4, __rotate_stop4 // skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM4, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF4, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports4, OutputModeField, __rotate_theOM4, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS4, PowerField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF4
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount4, __rotate_firstPort4, RotationCountField
__rotate_Stabilize4:
  mov __rotate_OldRotCount4, __rotate_RotCount4
  wait 50
  // check rotation
  getout __rotate_RotCount4, __rotate_firstPort4, RotationCountField
  brcmp NEQ, __rotate_Stabilize4, __rotate_OldRotCount4, __rotate_RotCount4
  set __rotate_theOM4, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports4, RegModeField, __rotate_theRM4, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM4, UpdateFlagsField, UF_UPDATE_MODE
__rotate_Reset4:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done4, __rotate_theTurnPct4
  setout __rotate_ports4, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done4:
  return
ends

subroutine __RotateMotor5
  brtst EQ, __rotate_Done5, __rotate_angle5
  sign __rotate_thePower5, __rotate_angle5
  abs __rotate_theAngle5, __rotate_angle5
  mul __rotate_thePower5, __rotate_thePower5, __rotate_power5 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF5, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync5, __rotate_sync5
  set __rotate_theOM5, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM5, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct5, __rotate_turnpct5
  brtst EQ, __rotate_Start5, __rotate_theTurnPct5
  add __rotate_theUF5, __rotate_theUF5, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start5
__rotate_NoSync5:
  set __rotate_theOM5, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM5, OUT_REGMODE_IDLE
  set __rotate_theTurnPct5, 0
__rotate_Start5:
  set __rotate_theRS5, OUT_RUNSTATE_RUNNING
  setout __rotate_ports5, OutputModeField, __rotate_theOM5, RegModeField, __rotate_theRM5, TachoLimitField, __rotate_theAngle5, RunStateField, __rotate_theRS5, RegPValueField, __rotate_theRVP5, RegIValueField, __rotate_theRVI5, RegDValueField, __rotate_theRVD5, PowerField, __rotate_thePower5, TurnRatioField, __rotate_turnpct5, UpdateFlagsField, __rotate_theUF5

// Waits till angle reached
  index __rotate_firstPort5, __rotate_ports5, NA
__rotate_Running5:
  getout __rotate_power5, __rotate_firstPort5, PowerField
  brtst EQ, __rotate_doneRunning5, __rotate_power5
  getout __rotate_rs5, __rotate_firstPort5, RunStateField
  brcmp EQ, __rotate_Running5, __rotate_rs5, OUT_RUNSTATE_RUNNING
__rotate_doneRunning5:
  brtst EQ, __rotate_Reset5, __rotate_stop5 // skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM5, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF5, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports5, OutputModeField, __rotate_theOM5, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS5, PowerField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF5
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount5, __rotate_firstPort5, RotationCountField
__rotate_Stabilize5:
  mov __rotate_OldRotCount5, __rotate_RotCount5
  wait 50
  // check rotation
  getout __rotate_RotCount5, __rotate_firstPort5, RotationCountField
  brcmp NEQ, __rotate_Stabilize5, __rotate_OldRotCount5, __rotate_RotCount5
  set __rotate_theOM5, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports5, RegModeField, __rotate_theRM5, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM5, UpdateFlagsField, UF_UPDATE_MODE
__rotate_Reset5:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done5, __rotate_theTurnPct5
  setout __rotate_ports5, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done5:
  return
ends

subroutine __RotateMotor6
  brtst EQ, __rotate_Done6, __rotate_angle6
  sign __rotate_thePower6, __rotate_angle6
  abs __rotate_theAngle6, __rotate_angle6
  mul __rotate_thePower6, __rotate_thePower6, __rotate_power6 // convert __rotate_power to negative value if __rotate_angle is negative.

  set __rotate_theUF6, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE+UF_UPDATE_PID_VALUES
  brtst EQ, __rotate_NoSync6, __rotate_sync6
  set __rotate_theOM6, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theRM6, OUT_REGMODE_SYNC
  mov __rotate_theTurnPct6, __rotate_turnpct6
  brtst EQ, __rotate_Start6, __rotate_theTurnPct6
  add __rotate_theUF6, __rotate_theUF6, UF_UPDATE_RESET_BLOCK_COUNT
  jmp __rotate_Start6
__rotate_NoSync6:
  set __rotate_theOM6, OUT_MODE_MOTORON+OUT_MODE_BRAKE
  set __rotate_theRM6, OUT_REGMODE_IDLE
  set __rotate_theTurnPct6, 0
__rotate_Start6:
  set __rotate_theRS6, OUT_RUNSTATE_RUNNING
  setout __rotate_ports6, OutputModeField, __rotate_theOM6, RegModeField, __rotate_theRM6, TachoLimitField, __rotate_theAngle6, RunStateField, __rotate_theRS6, RegPValueField, __rotate_theRVP6, RegIValueField, __rotate_theRVI6, RegDValueField, __rotate_theRVD6, PowerField, __rotate_thePower6, TurnRatioField, __rotate_turnpct6, UpdateFlagsField, __rotate_theUF6

// Waits till angle reached
  index __rotate_firstPort6, __rotate_ports6, NA
__rotate_Running6:
  getout __rotate_power6, __rotate_firstPort6, PowerField
  brtst EQ, __rotate_doneRunning6, __rotate_power6
  getout __rotate_rs6, __rotate_firstPort6, RunStateField
  brcmp EQ, __rotate_Running6, __rotate_rs6, OUT_RUNSTATE_RUNNING
__rotate_doneRunning6:
  brtst EQ, __rotate_Reset6, __rotate_stop6 // skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM6, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF6, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports6, OutputModeField, __rotate_theOM6, RegModeField, OUT_REGMODE_SPEED, RunStateField, __rotate_theRS6, PowerField, 0, TachoLimitField, 0, UpdateFlagsField, __rotate_theUF6
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount6, __rotate_firstPort6, RotationCountField
__rotate_Stabilize6:
  mov __rotate_OldRotCount6, __rotate_RotCount6
  wait 50
  // check rotation
  getout __rotate_RotCount6, __rotate_firstPort6, RotationCountField
  brcmp NEQ, __rotate_Stabilize6, __rotate_OldRotCount6, __rotate_RotCount6
  set __rotate_theOM6, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports6, RegModeField, __rotate_theRM6, RunStateField, OUT_RUNSTATE_IDLE, OutputModeField, __rotate_theOM6, UpdateFlagsField, UF_UPDATE_MODE
__rotate_Reset6:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done6, __rotate_theTurnPct6
  setout __rotate_ports6, UpdateFlagsField, UF_UPDATE_RESET_BLOCK_COUNT
__rotate_Done6:
  return
ends

subroutine __RotateMotorVar
/*
  _ports should be an array but it might be an integer from 0..6
  (OUT_A, OUT_B, OUT_C, OUT_AB, OUT_AC, OUT_BC, OUT_ABC)
  This subroutine converts, if necessary, an array containing a single byte
  > 2 into an array containing multiple bytes and then falls through to
  the RotateMotor6 subroutine.  It uses __rotate_rs6 as a temporary variable
*/
  arrsize __rotate_rs6, __rotate_ports6 // what is the size of the array?
  brcmp GT, __rmvCallSub, __rotate_rs6, 1 // fall through if size > 1
  // only one element in the array.  What is its value?
  index __rotate_rs6, __rotate_ports6, NA // grab the first element
  brcmp LT, __rmvCallSub, __rotate_rs6, 3 // if it is less than 3 just call the subroutine
  brcmp GT, __rmvExit, __rotate_rs6, 6 // if it is greater than 6 abort
  // start with 3
  mov __rotate_ports6, __OUT_AB
  brcmp EQ, __rmvCallSub, __rotate_rs6, 3
  mov __rotate_ports6, __OUT_AC
  brcmp EQ, __rmvCallSub, __rotate_rs6, 4
  mov __rotate_ports6, __OUT_BC
  brcmp EQ, __rmvCallSub, __rotate_rs6, 5
  mov __rotate_ports6, __OUT_ABC
__rmvCallSub:
  call __RotateMotor6
__rmvExit:
  return
ends

dseg segment
  __SensorInvalidTmp byte
dseg ends

dseg segment
  __ResetSensorMutex mutex
  __ResetSensorPort byte
  __ResetSensorTmp byte
dseg ends

subroutine __ResetSensorSubroutine
  setin TRUE, __ResetSensorPort, InvalidDataField
__SensorStillInvalid:
  getin	__ResetSensorTmp, __ResetSensorPort, InvalidDataField
  brtst	NEQ, __SensorStillInvalid, __ResetSensorTmp
  return
ends

#define __ResetSensor(_port) \
  acquire __ResetSensorMutex \
  mov __ResetSensorPort, _port \
  call __ResetSensorSubroutine \
  release __ResetSensorMutex

#define __SetSensorTouch(_port) \
  setin IN_TYPE_SWITCH, _port, TypeField \
  setin IN_MODE_BOOLEAN, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorLight(_port) \
  setin IN_TYPE_LIGHT_ACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorSound(_port) \
  setin IN_TYPE_SOUND_DB, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorLowspeed(_port) \
  setin IN_TYPE_LOWSPEED_9V, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#if __FIRMWARE_VERSION > 107

#define __SetSensorColorFull(_port) \
  setin IN_TYPE_COLORFULL, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorColorRed(_port) \
  setin IN_TYPE_COLORRED, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorColorGreen(_port) \
  setin IN_TYPE_COLORGREEN, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorColorBlue(_port) \
  setin IN_TYPE_COLORBLUE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorColorNone(_port) \
  setin IN_TYPE_COLORNONE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#endif

dseg segment
// port 0
  __CLSCSArgs0 TCommLSCheckStatus
  __CLSCSMutex0 mutex
  __CLSWArgs0 TCommLSWrite
  __CLSWMutex0 mutex
  __CLSRArgs0 TCommLSRead
  __CLSRMutex0 mutex
// port 1
  __CLSCSArgs1 TCommLSCheckStatus
  __CLSCSMutex1 mutex
  __CLSWArgs1 TCommLSWrite
  __CLSWMutex1 mutex
  __CLSRArgs1 TCommLSRead
  __CLSRMutex1 mutex
// port 2
  __CLSCSArgs2 TCommLSCheckStatus
  __CLSCSMutex2 mutex
  __CLSWArgs2 TCommLSWrite
  __CLSWMutex2 mutex
  __CLSRArgs2 TCommLSRead
  __CLSRMutex2 mutex
// port 3
  __CLSCSArgs3 TCommLSCheckStatus
  __CLSCSMutex3 mutex
  __CLSWArgs3 TCommLSWrite
  __CLSWMutex3 mutex
  __CLSRArgs3 TCommLSRead
  __CLSRMutex3 mutex
dseg ends

#define __lowspeedStatus(_port, _bready, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSCSMutex0 \
  acquire __CLSCSMutex1 \
  acquire __CLSCSMutex2 \
  acquire __CLSCSMutex3 \
  mov __CLSCSArgs0.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs0 \
  mov _bready, __CLSCSArgs0.BytesReady \
  mov _result, __CLSCSArgs0.Result \
  release __CLSCSMutex0 \
  release __CLSCSMutex1 \
  release __CLSCSMutex2 \
  release __CLSCSMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSCSMutex##_port \
  set __CLSCSArgs##_port.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs##_port \
  mov _bready, __CLSCSArgs##_port.BytesReady \
  mov _result, __CLSCSArgs##_port.Result \
  release __CLSCSMutex##_port \
  compend

#define __lowspeedCheckStatus(_port, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSCSMutex0 \
  acquire __CLSCSMutex1 \
  acquire __CLSCSMutex2 \
  acquire __CLSCSMutex3 \
  mov __CLSCSArgs0.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs0 \
  mov _result, __CLSCSArgs0.Result \
  release __CLSCSMutex0 \
  release __CLSCSMutex1 \
  release __CLSCSMutex2 \
  release __CLSCSMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSCSMutex##_port \
  set __CLSCSArgs##_port.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs##_port \
  mov _result, __CLSCSArgs##_port.Result \
  release __CLSCSMutex##_port \
  compend

#define __lowspeedBytesReady(_port, _bready) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSCSMutex0 \
  acquire __CLSCSMutex1 \
  acquire __CLSCSMutex2 \
  acquire __CLSCSMutex3 \
  mov __CLSCSArgs0.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs0 \
  mov _bready, __CLSCSArgs0.BytesReady \
  release __CLSCSMutex0 \
  release __CLSCSMutex1 \
  release __CLSCSMutex2 \
  release __CLSCSMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSCSMutex##_port \
  set __CLSCSArgs##_port.Port, _port \
  syscall CommLSCheckStatus, __CLSCSArgs##_port \
  mov _bready, __CLSCSArgs##_port.BytesReady \
  release __CLSCSMutex##_port \
  compend

#define __lowspeedWrite(_port, _retlen, _buffer, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  mov __CLSWArgs0.Port, _port \
  mov __CLSWArgs0.ReturnLen, _retlen \
  mov __CLSWArgs0.Buffer, _buffer \
  syscall CommLSWrite, __CLSWArgs0 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  set __CLSWArgs##_port.Port, _port \
  mov __CLSWArgs##_port.ReturnLen, _retlen \
  mov __CLSWArgs##_port.Buffer, _buffer \
  syscall CommLSWrite, __CLSWArgs##_port \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  compend

#define __lowspeedRead(_port, _buflen, _buffer, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSRMutex0 \
  acquire __CLSRMutex1 \
  acquire __CLSRMutex2 \
  acquire __CLSRMutex3 \
  mov __CLSRArgs0.Port, _port \
  mov __CLSRArgs0.BufferLen, _buflen \
  syscall CommLSRead, __CLSRArgs0 \
  mov _buffer, __CLSRArgs0.Buffer \
  mov _result, __CLSRArgs0.Result \
  release __CLSRMutex0 \
  release __CLSRMutex1 \
  release __CLSRMutex2 \
  release __CLSRMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSRMutex##_port \
  set __CLSRArgs##_port.Port, _port \
  mov __CLSRArgs##_port.BufferLen, _buflen \
  syscall CommLSRead, __CLSRArgs##_port \
  mov _buffer, __CLSRArgs##_port.Buffer \
  mov _result, __CLSRArgs##_port.Result \
  release __CLSRMutex##_port \
  compend

dseg segment
  __TextOutMutex mutex
  __TextOutArgs TDrawText
  __BlankLine byte[] '                    '
  __NumOutMutex mutex
  __NumOutArgs TDrawText
  __PointOutArgs TDrawPoint
  __PointOutMutex mutex
  __LineOutArgs TDrawLine
  __LineOutMutex mutex
  __RectOutArgs TDrawRect
  __RectOutMutex mutex
  __CircleOutArgs TDrawCircle
  __CircleOutMutex mutex
  __GraphicOutArgs TDrawGraphic
  __GraphicOutMutex mutex
  __GraphicOutEmptyVars sdword[]
dseg ends

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

dseg segment
  __GraphicArrayOutArgs TDrawGraphicArray
  __PolyOutArgs TDrawPolygon
  __PolyOutMutex mutex
  __EllipseOutArgs TDrawEllipse
  __EllipseOutMutex mutex
  __FontOutMutex mutex
  __FontOutArgs TDrawFont
  __MemMgrMutex mutex
  __MemMgrArgs TMemoryManager
  __ReadLastMutex mutex
  __ReadLastArgs TReadLastResponse
dseg ends

#endif

#if __FIRMWARE_VERSION > 107

dseg segment
  __ColorSensorReadArgs TColorSensorRead
  __ColorSensorReadMutex mutex
dseg ends

#define __ReadSensorColorRaw(_port, _rawVals, _result) \
  acquire __ColorSensorReadMutex \
  mov __ColorSensorReadArgs.Port,_port \
  syscall ColorSensorRead,__ColorSensorReadArgs \
  mov _rawVals, __ColorSensorReadArgs.RawArray \
  tst EQ, _result, __ColorSensorReadArgs.Result \
  release __ColorSensorReadMutex

#define __ReadSensorColorEx(_port, _colorval, _rawVals, _normVals, _scaledVals, _result) \
  acquire __ColorSensorReadMutex \
  mov __ColorSensorReadArgs.Port,_port \
  syscall ColorSensorRead,__ColorSensorReadArgs \
  mov _colorval, __ColorSensorReadArgs.ColorValue \
  mov _rawVals, __ColorSensorReadArgs.RawArray \
  mov _normVals, __ColorSensorReadArgs.NormalizedArray \
  mov _scaledVals, __ColorSensorReadArgs.ScaledArray \
  tst EQ, _result, __ColorSensorReadArgs.Result \
  release __ColorSensorReadMutex

#endif

#define __OnFwdEx(_ports, _pwr, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdExPIDAll(_ports, _pwr, _reset, PID_3, PID_1, PID_1) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdExPID##_ports(_pwr, _reset, PID_3, PID_1, PID_1) \
  compend

#define __OnRevEx(_ports, _pwr, _reset) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdEx(_ports, __OnRev_Tmp, _reset) \
  release __OnRevMutex

#define __OnFwdExPID(_ports, _pwr, _reset, _p, _i, _d) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdExPIDAll(_ports, _pwr, _reset, _p, _i, _d) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdExPID##_ports(_pwr, _reset, _p, _i, _d) \
  compend

#define __OnRevExPID(_ports, _pwr, _reset, _p, _i, _d) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdExPID(_ports, __OnRev_Tmp, _reset, _p, _i, _d) \
  release __OnRevMutex

#define __CoastEx(_ports, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __coastExAll(_ports, _reset) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __coastEx##_ports(_reset) \
  compend

#define __OffEx(_ports, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __offExAll(_ports, _reset) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __offEx##_ports(_reset) \
  compend

#define __OnFwdRegEx(_ports, _pwr, _regmode, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdRegExPIDAll(_ports, _pwr, _regmode, _reset, PID_3, PID_1, PID_1) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdRegExPID##_ports(_pwr, _regmode, _reset, PID_3, PID_1, PID_1) \
  compend

#define __OnRevRegEx(_ports, _pwr, _regmode, _reset) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdRegEx(_ports, __OnRev_Tmp, _regmode, _reset) \
  release __OnRevMutex

#define __OnFwdRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdRegExPIDAll(_ports, _pwr, _regmode, _reset, _p, _i, _d) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdRegExPID##_ports(_pwr, _regmode, _reset, _p, _i, _d) \
  compend

#define __OnRevRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdRegExPID(_ports, __OnRev_Tmp, _regmode, _reset, _p, _i, _d) \
  release __OnRevMutex

#define __OnFwdSyncEx(_ports, _pwr, _turnpct, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdSyncExPIDAll(_ports, _pwr, _turnpct, _reset, PID_3, PID_1, PID_1) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdSyncExPID##_ports(_pwr, _turnpct, _reset, PID_3, PID_1, PID_1) \
  compend

#define __OnRevSyncEx(_ports, _pwr, _turnpct, _reset) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdSyncEx(_ports, __OnRev_Tmp, _turnpct, _reset) \
  release __OnRevMutex

#define __OnFwdSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdSyncExPIDAll(_ports, _pwr, _turnpct, _reset, _p, _i, _d) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdSyncExPID##_ports(_pwr, _turnpct, _reset, _p, _i, _d) \
  compend

#define __OnRevSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  __OnFwdSyncExPID(_ports, __OnRev_Tmp, _turnpct, _reset, _p, _i, _d) \
  release __OnRevMutex

#define __RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   compif EQ, isconst(_ports), FALSE \
   __rotateMotorExPIDVar(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   compelse \
   compchk LT, _ports, 0x07 \
   compchk GTEQ, _ports, 0x00 \
   __rotateMotorExPID##_ports(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   compend

#define __TextOutEx(_x,_y,_txt,_options) \
  acquire __TextOutMutex \
  mov __TextOutArgs.Location.X,_x \
  mov __TextOutArgs.Location.Y,_y \
  mov __TextOutArgs.Options,_options \
  mov __TextOutArgs.Text,_txt \
  syscall DrawText,__TextOutArgs \
  release __TextOutMutex

#define __NumOutEx(_x,_y,_num,_options) \
  acquire __NumOutMutex \
  mov __NumOutArgs.Location.X,_x \
  mov __NumOutArgs.Location.Y,_y \
  mov __NumOutArgs.Options,_options \
  numtostr __NumOutArgs.Text,_num \
  syscall DrawText,__NumOutArgs \
  release __NumOutMutex

#define __PointOutEx(_x,_y,_options) \
  acquire __PointOutMutex \
  mov __PointOutArgs.Location.X,_x \
  mov __PointOutArgs.Location.Y,_y \
  mov __PointOutArgs.Options,_options \
  syscall DrawPoint,__PointOutArgs \
  release __PointOutMutex

#define __LineOutEx(_x1,_y1,_x2,_y2,_options) \
  acquire __LineOutMutex \
  mov __LineOutArgs.StartLoc.X,_x1 \
  mov __LineOutArgs.StartLoc.Y,_y1 \
  mov __LineOutArgs.EndLoc.X,_x2 \
  mov __LineOutArgs.EndLoc.Y,_y2 \
  mov __LineOutArgs.Options,_options \
  syscall DrawLine,__LineOutArgs \
  release __LineOutMutex

#define __RectOutEx(_x,_y,_w,_h,_options) \
  acquire __RectOutMutex \
  mov __RectOutArgs.Location.X,_x \
  mov __RectOutArgs.Location.Y,_y \
  mov __RectOutArgs.Size.Width,_w \
  mov __RectOutArgs.Size.Height,_h \
  mov __RectOutArgs.Options,_options \
  syscall DrawRect,__RectOutArgs \
  release __RectOutMutex

#define __CircleOutEx(_x,_y,_r,_options) \
  acquire __CircleOutMutex \
  mov __CircleOutArgs.Center.X,_x \
  mov __CircleOutArgs.Center.Y,_y \
  mov __CircleOutArgs.Size,_r \
  mov __CircleOutArgs.Options,_options \
  syscall DrawCircle,__CircleOutArgs \
  release __CircleOutMutex

#define __GraphicOutEx(_x,_y,_file,_vars,_options) \
  acquire __GraphicOutMutex \
  mov __GraphicOutArgs.Location.X,_x \
  mov __GraphicOutArgs.Location.Y,_y \
  mov __GraphicOutArgs.Filename,_file \
  mov __GraphicOutArgs.Variables,_vars \
  mov __GraphicOutArgs.Options,_options \
  syscall DrawGraphic,__GraphicOutArgs \
  release __GraphicOutMutex

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __GraphicArrayOutEx(_x,_y,_data,_vars,_options) \
  acquire __GraphicOutMutex \
  mov __GraphicArrayOutArgs.Location.X,_x \
  mov __GraphicArrayOutArgs.Location.Y,_y \
  mov __GraphicArrayOutArgs.Data,_data \
  mov __GraphicArrayOutArgs.Variables,_vars \
  mov __GraphicArrayOutArgs.Options,_options \
  syscall DrawGraphicArray,__GraphicArrayOutArgs \
  release __GraphicOutMutex

#define __PolyOutEx(_points,_options) \
  acquire __PolyOutMutex \
  mov __PolyOutArgs.Points,_points \
  mov __PolyOutArgs.Options,_options \
  syscall DrawPolygon,__PolyOutArgs \
  release __PolyOutMutex

#define __EllipseOutEx(_x,_y,_rX,_rY,_options) \
  acquire __EllipseOutMutex \
  mov __EllipseOutArgs.Center.X,_x \
  mov __EllipseOutArgs.Center.Y,_y \
  mov __EllipseOutArgs.SizeX,_rX \
  mov __EllipseOutArgs.SizeY,_rY \
  mov __EllipseOutArgs.Options,_options \
  syscall DrawEllipse,__EllipseOutArgs \
  release __EllipseOutMutex

#define __FontTextOutEx(_x,_y,_fnt,_txt,_options) \
  acquire __FontOutMutex \
  mov __FontOutArgs.Location.X,_x \
  mov __FontOutArgs.Location.Y,_y \
  mov __FontOutArgs.Options,_options \
  mov __FontOutArgs.Filename,_fnt \
  mov __FontOutArgs.Text,_txt \
  syscall DrawFont,__FontOutArgs \
  release __FontOutMutex

#define __FontNumOutEx(_x,_y,_fnt,_num,_options) \
  acquire __FontOutMutex \
  mov __FontOutArgs.Location.X,_x \
  mov __FontOutArgs.Location.Y,_y \
  mov __FontOutArgs.Options,_options \
  mov __FontOutArgs.Filename,_fnt \
  numtostr __FontOutArgs.Text,_num \
  syscall DrawFont,__FontOutArgs \
  release __FontOutMutex

#define __GetMemoryInfo(_Compact,_PoolSize,_DataspaceSize,_Result) \
  acquire __MemMgrMutex \
  mov __MemMgrArgs.Compact,_Compact \
  syscall MemoryManager,__MemMgrArgs \
  mov _PoolSize, __MemMgrArgs.PoolSize \
  mov _DataspaceSize, __MemMgrArgs.DataspaceSize \
  mov _Result, __MemMgrArgs.Result \
  release __MemMgrMutex

#define __GetLastResponseInfo(_Clear,_Length,_Command,_Buffer,_Result) \
  acquire __ReadLastMutex \
  mov __ReadLastArgs.Clear,_Clear \
  syscall ReadLastResponse,__ReadLastArgs \
  mov _Buffer, __ReadLastArgs.Buffer \
  mov _Length, __ReadLastArgs.Length \
  mov _Command, __ReadLastArgs.Command \
  mov _Result, __ReadLastArgs.Result \
  release __ReadLastMutex


#endif

dseg segment
  __RLSBbufLSWrite1 byte[] 0x02, 0x42
  __RSEMeterLSBuf byte[] 0x04, 0x0A
  __RSTempConfigLSBuf byte[] 0x98, 0x01, 0x60
  __RSTempLSBuf byte[] 0x98, 0x00
  __RSTempRaw slong
dseg ends

#define __ReadI2CBytes(_port, _inbuf, _count, _outbuf, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, _inbuf \
  mov __RLSBytesCountVar, _count \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  mov _count, __RLSBytesCountVar \
  mov _outbuf, __RLSReadBufVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, _inbuf \
  mov __RLSBytesCount##_port, _count \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov _count, __RLSBytesCount##_port \
  mov _outbuf, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorUS(_port, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 1 \
  wait 15 \
  call __ReadLSBytesVar \
  index _value, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 1 \
  wait 15 \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorUSEx(_port, _values, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 8 \
  wait 15 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  mov _values, __RLSReadBufVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 8 \
  wait 15 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov _values, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorEMeter(_port, _vIn, _aIn, _vOut, _aOut, _joules, _wIn, _wOut, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSEMeterLSBuf \
  set __RLSBytesCountVar, 14 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  index _vIn, __RLSReadBufVar, 1 \
  mul _vIn, _vIn, 256 \
  add _vIn, _vIn, __RLSBytesCountVar \
  div _vIn, _vIn, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 2 \
  index _aIn, __RLSReadBufVar, 3 \
  mul _aIn, _aIn, 256 \
  add _aIn, _aIn, __RLSBytesCountVar \
  div _aIn, _aIn, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  index _vOut, __RLSReadBufVar, 5 \
  mul _vOut, _vOut, 256 \
  add _vOut, _vOut, __RLSBytesCountVar \
  div _vOut, _vOut, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 6 \
  index _aOut, __RLSReadBufVar, 7 \
  mul _aOut, _aOut, 256 \
  add _aOut, _aOut, __RLSBytesCountVar \
  div _aOut, _aOut, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 8 \
  index _joules, __RLSReadBufVar, 9 \
  mul _joules, _joules, 256 \
  add _joules, _joules, __RLSBytesCountVar \
  index __RLSBytesCountVar, __RLSReadBufVar, 10 \
  index _wIn, __RLSReadBufVar, 11 \
  mul _wIn, _wIn, 256 \
  add _wIn, _wIn, __RLSBytesCountVar \
  div _wIn, _wIn, 1000 \
  index __RLSBytesCountVar, __RLSReadBufVar, 12 \
  index _wOut, __RLSReadBufVar, 13 \
  mul _wOut, _wOut, 256 \
  add _wOut, _wOut, __RLSBytesCountVar \
  div _wOut, _wOut, 1000 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSEMeterLSBuf \
  set __RLSBytesCount##_port, 14 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  index _vIn, __RLSReadBuf##_port, 1 \
  mul _vIn, _vIn, 256 \
  add _vIn, _vIn, __RLSBytesCount##_port \
  div _vIn, _vIn, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 2 \
  index _aIn, __RLSReadBuf##_port, 3 \
  mul _aIn, _aIn, 256 \
  add _aIn, _aIn, __RLSBytesCount##_port \
  div _aIn, _aIn, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  index _vOut, __RLSReadBuf##_port, 5 \
  mul _vOut, _vOut, 256 \
  add _vOut, _vOut, __RLSBytesCount##_port \
  div _vOut, _vOut, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 6 \
  index _aOut, __RLSReadBuf##_port, 7 \
  mul _aOut, _aOut, 256 \
  add _aOut, _aOut, __RLSBytesCount##_port \
  div _aOut, _aOut, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 8 \
  index _joules, __RLSReadBuf##_port, 9 \
  mul _joules, _joules, 256 \
  add _joules, _joules, __RLSBytesCount##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 10 \
  index _wIn, __RLSReadBuf##_port, 11 \
  mul _wIn, _wIn, 256 \
  add _wIn, _wIn, __RLSBytesCount##_port \
  div _wIn, _wIn, 1000 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 12 \
  index _wOut, __RLSReadBuf##_port, 13 \
  mul _wOut, _wOut, 256 \
  add _wOut, _wOut, __RLSBytesCount##_port \
  div _wOut, _wOut, 1000 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorTemperature(_port, _temp) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSTempLSBuf \
  set __RLSBytesCountVar, 2 \
  call __ReadLSBytesVar \
  index __RSTempRaw, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul __RSTempRaw, __RSTempRaw, 256 \
  add __RSTempRaw, __RSTempRaw, __RLSBytesCountVar \
  mul __RSTempRaw, __RSTempRaw, 10 \
  div __RSTempRaw, __RSTempRaw, 16 \
  div _temp, __RSTempRaw, 16 \
  brcmp LTEQ, __RRT_EndIf##__I__, __RSTempRaw, 20470 \
  sub _temp, _temp, 2560 \
  __RRT_EndIf##__I__: \
  __IncI__ \
  compif EQ, typeof(_temp), 10 \
  div _temp, _temp, 10 \
  compend \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSTempLSBuf \
  set __RLSBytesCount##_port, 2 \
  call __ReadLSBytes##_port \
  index __RSTempRaw, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul __RSTempRaw, __RSTempRaw, 256 \
  add __RSTempRaw, __RSTempRaw, __RLSBytesCount##_port \
  mul __RSTempRaw, __RSTempRaw, 10 \
  div __RSTempRaw, __RSTempRaw, 16 \
  div _temp, __RSTempRaw, 16 \
  brcmp LTEQ, __RRT_EndIf##__I__, __RSTempRaw, 20470 \
  sub _temp, _temp, 2560 \
  __RRT_EndIf##__I__: \
  __IncI__ \
  compif EQ, typeof(_temp), 10 \
  div _temp, _temp, 10 \
  compend \
  release __RLSBmutex##_port \
  compend

subroutine __ReadLSBytes0
  dseg segment
    __RLSBmutex0 mutex
    __RLSLastGoodRead0 byte[] 0x00
    __RLSBResult0 sbyte
    __RLSBytesCount0 byte
    __RLSBIterations0 byte
    __RLSReadBuf0 byte[]
  dseg ends
  __lowspeedWrite(0, __RLSBytesCount0, __RLSReadBuf0, __RLSBResult0)
  brtst EQ, __RLSBReturn0, __RLSBytesCount0 // terminate if zero bytes to read
  arrinit __RLSReadBuf0, 0, __RLSBytesCount0
  brtst NEQ, __RLSBError0, __RLSBResult0 // terminate if not NO_ERR
  set __RLSBIterations0, 4
__RLSBDoCheckStatus0:
  __lowspeedStatus(0, __RLSBytesCount0, __RLSBResult0)
  sub __RLSBIterations0, __RLSBIterations0, 1
  brtst LTEQ, __RLSBError0, __RLSBIterations0
  brtst LT, __RLSBError0, __RLSBResult0 // negative results are absolute errors
  brtst EQ, __RLSBReadyToRead0, __RLSBResult0
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatus0
__RLSBReadyToRead0:
  // Try reading now
  __lowspeedRead(0, __RLSBytesCount0, __RLSReadBuf0, __RLSBResult0)
  brtst NEQ, __RLSBError0, __RLSBResult0 // terminate if not NO_ERR
  mov __RLSLastGoodRead0, __RLSReadBuf0
  jmp __RLSBDone0
__RLSBError0:
  mov __RLSReadBuf0, __RLSLastGoodRead0
__RLSBDone0:
  arrsize __RLSBytesCount0, __RLSReadBuf0
__RLSBReturn0:
  return
ends

subroutine __ReadLSBytes1
  dseg segment
    __RLSBmutex1 mutex
    __RLSLastGoodRead1 byte[] 0x00
    __RLSBResult1 sbyte
    __RLSBytesCount1 byte
    __RLSBIterations1 byte
    __RLSReadBuf1 byte[]
  dseg ends
  __lowspeedWrite(1, __RLSBytesCount1, __RLSReadBuf1, __RLSBResult1)
  brtst EQ, __RLSBReturn1, __RLSBytesCount1 // terminate if zero bytes to read
  arrinit __RLSReadBuf1, 0, __RLSBytesCount1
  brtst NEQ, __RLSBError1, __RLSBResult1 // terminate if not NO_ERR
  set __RLSBIterations1, 4
__RLSBDoCheckStatus1:
  __lowspeedStatus(1, __RLSBytesCount1, __RLSBResult1)
  sub __RLSBIterations1, __RLSBIterations1, 1
  brtst LTEQ, __RLSBError1, __RLSBIterations1
  brtst LT, __RLSBError1, __RLSBResult1 // negative results are absolute errors
  brtst EQ, __RLSBReadyToRead1, __RLSBResult1
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatus1
__RLSBReadyToRead1:
  // Try reading now
  __lowspeedRead(1, __RLSBytesCount1, __RLSReadBuf1, __RLSBResult1)
  brtst NEQ, __RLSBError1, __RLSBResult1 // terminate if not NO_ERR
  mov __RLSLastGoodRead1, __RLSReadBuf1
  jmp __RLSBDone1
__RLSBError1:
  mov __RLSReadBuf1, __RLSLastGoodRead1
__RLSBDone1:
  arrsize __RLSBytesCount1, __RLSReadBuf1
__RLSBReturn1:
  return
ends

subroutine __ReadLSBytes2
  dseg segment
    __RLSBmutex2 mutex
    __RLSLastGoodRead2 byte[] 0x00
    __RLSBResult2 sbyte
    __RLSBytesCount2 byte
    __RLSBIterations2 byte
    __RLSReadBuf2 byte[]
  dseg ends
  __lowspeedWrite(2, __RLSBytesCount2, __RLSReadBuf2, __RLSBResult2)
  brtst EQ, __RLSBReturn2, __RLSBytesCount2 // terminate if zero bytes to read
  arrinit __RLSReadBuf2, 0, __RLSBytesCount2
  brtst NEQ, __RLSBError2, __RLSBResult2 // terminate if not NO_ERR
  set __RLSBIterations2, 4
__RLSBDoCheckStatus2:
  __lowspeedStatus(2, __RLSBytesCount2, __RLSBResult2)
  sub __RLSBIterations2, __RLSBIterations2, 1
  brtst LTEQ, __RLSBError2, __RLSBIterations2
  brtst LT, __RLSBError2, __RLSBResult2 // negative results are absolute errors
  brtst EQ, __RLSBReadyToRead2, __RLSBResult2
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatus2
__RLSBReadyToRead2:
  // Try reading now
  __lowspeedRead(2, __RLSBytesCount2, __RLSReadBuf2, __RLSBResult2)
  brtst NEQ, __RLSBError2, __RLSBResult2 // terminate if not NO_ERR
  mov __RLSLastGoodRead2, __RLSReadBuf2
  jmp __RLSBDone2
__RLSBError2:
  mov __RLSReadBuf2, __RLSLastGoodRead2
__RLSBDone2:
  arrsize __RLSBytesCount2, __RLSReadBuf2
__RLSBReturn2:
  return
ends

subroutine __ReadLSBytes3
  dseg segment
    __RLSBmutex3 mutex
    __RLSLastGoodRead3 byte[] 0x00
    __RLSBResult3 sbyte
    __RLSBytesCount3 byte
    __RLSBIterations3 byte
    __RLSReadBuf3 byte[]
  dseg ends
  __lowspeedWrite(3, __RLSBytesCount3, __RLSReadBuf3, __RLSBResult3)
  brtst EQ, __RLSBReturn3, __RLSBytesCount3 // terminate if zero bytes to read
  arrinit __RLSReadBuf3, 0, __RLSBytesCount3
  brtst NEQ, __RLSBError3, __RLSBResult3 // terminate if not NO_ERR
  set __RLSBIterations3, 4
__RLSBDoCheckStatus3:
  __lowspeedStatus(3, __RLSBytesCount3, __RLSBResult3)
  sub __RLSBIterations3, __RLSBIterations3, 1
  brtst LTEQ, __RLSBError3, __RLSBIterations3
  brtst LT, __RLSBError3, __RLSBResult3 // negative results are absolute errors
  brtst EQ, __RLSBReadyToRead3, __RLSBResult3
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatus3
__RLSBReadyToRead3:
  // Try reading now
  __lowspeedRead(3, __RLSBytesCount3, __RLSReadBuf3, __RLSBResult3)
  brtst NEQ, __RLSBError3, __RLSBResult3 // terminate if not NO_ERR
  mov __RLSLastGoodRead3, __RLSReadBuf3
  jmp __RLSBDone3
__RLSBError3:
  mov __RLSReadBuf3, __RLSLastGoodRead3
__RLSBDone3:
  arrsize __RLSBytesCount3, __RLSReadBuf3
__RLSBReturn3:
  return
ends

subroutine __ReadLSBytesVar
  dseg segment
    __RLSLastGoodReadVar byte[] 0x00
    __RLSBResultVar sbyte
    __RLSBytesCountVar byte
    __RLSBIterationsVar byte
    __RLSReadBufVar byte[]
    __RLSReadPort byte
  dseg ends
  __lowspeedWrite(__RLSReadPort, __RLSBytesCountVar, __RLSReadBufVar, __RLSBResultVar)
  brtst EQ, __RLSBReturnVar, __RLSBytesCountVar // terminate if zero bytes to read
  arrinit __RLSReadBufVar, 0, __RLSBytesCountVar
  brtst NEQ, __RLSBErrorVar, __RLSBResultVar // terminate if not NO_ERR
  set __RLSBIterationsVar, 4
__RLSBDoCheckStatusVar:
  __lowspeedStatus(__RLSReadPort, __RLSBytesCountVar, __RLSBResultVar)
  sub __RLSBIterationsVar, __RLSBIterationsVar, 1
  brtst LTEQ, __RLSBErrorVar, __RLSBIterationsVar
  brtst LT, __RLSBErrorVar, __RLSBResultVar // negative results are absolute errors
  brtst EQ, __RLSBReadyToReadVar, __RLSBResultVar
  // if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatusVar
__RLSBReadyToReadVar:
  // Try reading now
  __lowspeedRead(__RLSReadPort, __RLSBytesCountVar, __RLSReadBufVar, __RLSBResultVar)
  brtst NEQ, __RLSBErrorVar, __RLSBResultVar // terminate if not NO_ERR
  mov __RLSLastGoodReadVar, __RLSReadBufVar
  jmp __RLSBDoneVar
__RLSBErrorVar:
  mov __RLSReadBufVar, __RLSLastGoodReadVar
__RLSBDoneVar:
  arrsize __RLSBytesCountVar, __RLSReadBufVar
__RLSBReturnVar:
  return
ends

dseg segment
  __PlayToneTmp TSoundPlayTone
  __PlayFileTmp TSoundPlayFile
  __PlayFileMutex mutex
  __PlayToneMutex mutex
  __SGSMutex mutex
  __SGSArgs TSoundGetState
  __SSSMutex mutex
  __SSSArgs TSoundSetState
  __RandomTmp dword
  __RandomArgs TRandomNumber
  __RandomMutex mutex
  __KeepAliveArgs TKeepAlive
  __KeepAliveMutex mutex
  __GSTArgs TGetStartTick
  __GSTMutex mutex
  __RBtnMutex mutex
  __RBtnArgs TReadButton
  __IOMRMutex mutex
  __IOMRArgs TIOMapRead
  __IOMRUnflattenErr byte
  __IOMRUnflattenBuf byte[]
dseg ends


#define __PlayToneEx(_freq,_dur,_vol,_loop) \
  acquire __PlayToneMutex \
  mov __PlayToneTmp.Frequency, _freq \
  mov __PlayToneTmp.Duration, _dur \
  mov __PlayToneTmp.Volume, _vol \
  mov __PlayToneTmp.Loop, _loop \
  syscall SoundPlayTone, __PlayToneTmp \
  release __PlayToneMutex

#define __PlayFileEx(_file,_vol,_loop) \
  acquire __PlayFileMutex \
  mov __PlayFileTmp.Filename, _file \
  mov __PlayFileTmp.Volume, _vol \
  mov __PlayFileTmp.Loop, _loop \
  syscall SoundPlayFile, __PlayFileTmp \
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

#define __Random(_arg,_max) \
  acquire __RandomMutex \
  syscall RandomNumber, __RandomArgs \
  mov __RandomTmp, __RandomArgs.Result \
  add __RandomTmp, __RandomTmp, 32768 \
  mul __RandomTmp, __RandomTmp, _max \
  div __RandomTmp, __RandomTmp, 65536 \
  mov _arg, __RandomTmp \
  release __RandomMutex

#define __SignedRandom(_arg) \
  acquire __RandomMutex \
  syscall RandomNumber, __RandomArgs \
  mov _arg, __RandomArgs.Result \
  release __RandomMutex

#define __GetFirstTick(_value) \
  compchk EQ, sizeof(_value), 4 \
  acquire __GSTMutex \
  syscall GetStartTick, __GSTArgs \
  mov _value, __GSTArgs.Result \
  release __GSTMutex

#define __ReadButtonEx(_idx, _reset, _pressed, _count, _result) \
  acquire __RBtnMutex \
  mov __RBtnArgs.Index, _idx \
  mov __RBtnArgs.Reset, _reset \
  syscall ReadButton, __RBtnArgs \
  mov _pressed, __RBtnArgs.Pressed \
  mov _count, __RBtnArgs.Count \
  mov _result, __RBtnArgs.Result \
  release __RBtnMutex

#define __getIOMapBytes(_modName, _offset, _cnt, _arrOut) \
  acquire __IOMRMutex \
  mov __IOMRArgs.ModuleName, _modName \
  mov __IOMRArgs.Offset, _offset \
  mov __IOMRArgs.Count, _cnt \
  syscall IOMapRead, __IOMRArgs \
  mov _arrOut, __IOMRArgs.Buffer \
  release __IOMRMutex

#define __getIOMapValue(_modName, _offset, _n) \
  acquire __IOMRMutex \
  mov __IOMRArgs.ModuleName, _modName \
  mov __IOMRArgs.Offset, _offset \
  set __IOMRArgs.Count, sizeof(_n) \
  syscall IOMapRead, __IOMRArgs \
  arrtostr __IOMRUnflattenBuf, __IOMRArgs.Buffer \
  unflatten _n, __IOMRUnflattenErr, __IOMRUnflattenBuf, _n \
  release __IOMRMutex

#ifdef __ENHANCED_FIRMWARE

dseg segment
  __IOMRBIArgs TIOMapReadByID
dseg ends

#define __getIOMapBytesByID(_modID, _offset, _cnt, _arrOut) \
  acquire __IOMRMutex \
  mov __IOMRBIArgs.ModuleID, _modID \
  mov __IOMRBIArgs.Offset, _offset \
  mov __IOMRBIArgs.Count, _cnt \
  syscall IOMapReadByID, __IOMRBIArgs \
  mov _arrOut, __IOMRBIArgs.Buffer \
  release __IOMRMutex

#define __getIOMapValueByID(_modID, _offset, _n) \
  acquire __IOMRMutex \
  mov __IOMRBIArgs.ModuleID, _modID \
  mov __IOMRBIArgs.Offset, _offset \
  set __IOMRBIArgs.Count, sizeof(_n) \
  syscall IOMapReadByID, __IOMRBIArgs \
  arrtostr __IOMRUnflattenBuf, __IOMRBIArgs.Buffer \
  unflatten _n, __IOMRUnflattenErr, __IOMRUnflattenBuf, _n \
  release __IOMRMutex

#define __getLowSpeedModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytesByID(LowSpeedModuleID, _offset, _cnt, _arrOut)
#define __getDisplayModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytesByID(DisplayModuleID, _offset, _cnt, _arrOut)
#define __getCommModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytesByID(CommModuleID, _offset, _cnt, _arrOut)
#define __getCommandModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytesByID(CommandModuleID, _offset, _cnt, _arrOut)

#else

#define __getLowSpeedModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytes(LowSpeedModuleName, _offset, _cnt, _arrOut)
#define __getDisplayModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytes(DisplayModuleName, _offset, _cnt, _arrOut)
#define __getCommModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytes(CommModuleName, _offset, _cnt, _arrOut)
#define __getCommandModuleBytes(_offset, _cnt, _arrOut) __getIOMapBytes(CommandModuleName, _offset, _cnt, _arrOut)

#endif

#define __GetFreeMemory(_value) \
  compchk EQ, sizeof(_value), 4 \
  GetLoaderModuleValue(LoaderOffsetFreeUserFlash, _value)

#define __GetSoundFrequency(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetSoundModuleValue(SoundOffsetFreq, _n)

#define __GetSoundDuration(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetSoundModuleValue(SoundOffsetDuration, _n)

#define __GetSoundSampleRate(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetSoundModuleValue(SoundOffsetSampleRate, _n)

#define __GetSoundMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetSoundModuleValue(SoundOffsetMode, _n)

#define __GetSoundVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetSoundModuleValue(SoundOffsetVolume, _n)

dseg segment
  __btnModuleOffsetMutex mutex
  __btnModuleOffset word
dseg ends

#define __GetButtonPressCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  GetButtonModuleValue(ButtonOffsetPressedCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  GetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonLongPressCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  GetButtonModuleValue(ButtonOffsetLongPressCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 1 \
  GetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonShortReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  GetButtonModuleValue(ButtonOffsetShortRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 2 \
  GetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonLongReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  GetButtonModuleValue(ButtonOffsetLongRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 3 \
  GetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  GetButtonModuleValue(ButtonOffsetRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 4 \
  GetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetButtonState(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  GetButtonModuleValue(ButtonOffsetState(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  add __btnModuleOffset, _b, 32 \
  GetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __GetBatteryLevel(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetUIModuleValue(UIOffsetBatteryVoltage, _n)

#define __GetCommandFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetFlags, _n)

#define __GetUIState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetState, _n)

#define __GetUIButton(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetButton, _n)

#define __GetVMRunState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetRunState, _n)

#define __GetBatteryState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetBatteryState, _n)

#define __GetBluetoothState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetBluetoothState, _n)

#define __GetUsbState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetUsbState, _n)

#define __GetSleepTimeout(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetSleepTimeout, _n)

#define __GetSleepTimer(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetSleepTimer, _n)

#define __GetRechargeableBattery(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetRechargeable, _n)

#define __GetVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetVolume, _n)

#define __GetOnBrickProgramPointer(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetOBPPointer, _n)

#define __GetAbortFlag(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetAbortFlag, _n)

dseg segment
  __inputModuleOffsetMutex mutex
  __inputModuleOffset word
  __inputModuleOffsetTmp word
dseg ends

#define __GetInCustomZeroOffset(_p, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetCustomZeroOffset(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInSensorBoolean(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetSensorBoolean(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 10 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInDigiPinsDirection(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetDigiPinsDir(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 11 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInDigiPinsStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetDigiPinsIn(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 12 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInDigiPinsOutputLevel(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetDigiPinsOut(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 13 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInCustomPercentFullScale(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetCustomPctFullScale(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 14 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInCustomActiveStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetCustomActiveStatus(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 15 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#if __FIRMWARE_VERSION > 107

#define __GetInColorCalibration(_p, _np, _nc, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p+_np+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _np, INPUT_NO_OF_POINTS \
  compchk GTEQ, _np, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorCalibration(_p, _np, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _np, 16 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  mul __inputModuleOffsetTmp, _nc, 4 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 80 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorCalLimits(_p, _np, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p+_np), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _np, 0x02 \
  compchk GTEQ, _np, 0x00 \
  GetInputModuleValue(InputOffsetColorCalLimits(_p, _np), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _np, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 128 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorADRaw(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorADRaw(_p, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _nc, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 132 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorSensorRaw(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorSensorRaw(_p, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _nc, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 140 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorSensorValue(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorSensorValue(_p, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _nc, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 148 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorBoolean(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p+_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorBoolean(_p, _nc), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  mul __inputModuleOffsetTmp, _nc, 2 \
  add __inputModuleOffset, __inputModuleOffset, __inputModuleOffsetTmp \
  add __inputModuleOffset, __inputModuleOffset, 156 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __GetInColorCalibrationState(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetColorCalibrationState(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 84 \
  add __inputModuleOffset, __inputModuleOffset, 160 \
  GetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#endif

#define __GetOutPwnFreq(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetOutputModuleValue(OutputOffsetRegulationTime, _n)

#define __GetOutRegulationTime(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetOutputModuleValue(OutputOffsetRegulationTime, _n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __GetOutRegulationOptions(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetOutputModuleValue(OutputOffsetRegulationOptions, _n)

#endif

dseg segment
  __lsModuleOffsetMutex mutex
  __lsModuleOffset word
dseg ends

#define __getLSInputBuffer(_p, _offset, _cnt, _data) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleBytes(LowSpeedOffsetInBufBuf(_p)+_offset, _cnt, _data) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, _offset \
  GetLowSpeedModuleBytes(__lsModuleOffset, _cnt, _data) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSInputBufferInPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleValue(LowSpeedOffsetInBufInPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 16 \
  GetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSInputBufferOutPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleValue(LowSpeedOffsetInBufOutPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 17 \
  GetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSInputBufferBytesToRx(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleValue(LowSpeedOffsetInBufBytesToRx(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 18 \
  GetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __getLSOutputBuffer(_p, _offset, _cnt, _data) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleBytes(LowSpeedOffsetOutBufBuf(_p)+_offset, _cnt, _data) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 76 \
  add __lsModuleOffset, __lsModuleOffset, _offset \
  GetLowSpeedModuleBytes(__lsModuleOffset, _cnt, _data) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSOutputBufferInPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleValue(LowSpeedOffsetOutBufInPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 92 \
  GetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSOutputBufferOutPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleValue(LowSpeedOffsetOutBufOutPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 93 \
  GetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSOutputBufferBytesToRx(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleValue(LowSpeedOffsetOutBufBytesToRx(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 94 \
  GetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSMode(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleValue(LowSpeedOffsetMode(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 152 \
  GetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSChannelState(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleValue(LowSpeedOffsetChannelState(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 156 \
  GetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSErrorType(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetLowSpeedModuleValue(LowSpeedOffsetErrorType(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 160 \
  GetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __GetLSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetLowSpeedModuleValue(LowSpeedOffsetState, _n)

#define __GetLSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetLowSpeedModuleValue(LowSpeedOffsetSpeed, _n)

#ifdef __ENHANCED_FIRMWARE

#define __GetLSNoRestartOnRead(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetLowSpeedModuleValue(LowSpeedOffsetNoRestartOnRead, _n)

#endif

#define __GetDisplayEraseMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  GetDisplayModuleValue(DisplayOffsetEraseMask, _n)

#define __GetDisplayUpdateMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  GetDisplayModuleValue(DisplayOffsetUpdateMask, _n)

#define __GetDisplayFont(_n) \
  compchk EQ, sizeof(_n), 4 \
  GetDisplayModuleValue(DisplayOffsetPFont, _n)

#define __GetDisplayDisplay(_n) \
  compchk EQ, sizeof(_n), 4 \
  GetDisplayModuleValue(DisplayOffsetDisplay, _n)

#define __GetDisplayFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetDisplayModuleValue(DisplayOffsetFlags, _n)

#define __GetDisplayTextLinesCenterFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetDisplayModuleValue(DisplayOffsetTextLinesCenterFlags, _n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __GetDisplayContrast(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetDisplayModuleValue(DisplayOffsetContrast, _n)

#endif

dseg segment
  __displayModuleOffsetMutex mutex
  __displayModuleOffset word
dseg ends

#define __getDisplayNormal(_x, _line, _cnt, _data) \
  compif EQ, isconst(_line+_x), TRUE \
  compchk LT, _line, 0x08 \
  compchk GTEQ, _line, 0x00 \
  GetDisplayModuleBytes(DisplayOffsetNormal(_line,_x), _cnt, _data) \
  compelse \
  acquire __displayModuleOffsetMutex \
  mul __displayModuleOffset, _line, 100 \
  add __displayModuleOffset, __displayModuleOffset, _x \
  add __displayModuleOffset, __displayModuleOffset, 119 \
  GetDisplayModuleBytes(__displayModuleOffset, _cnt, _data) \
  release __displayModuleOffsetMutex \
  compend

#define __getDisplayPopup(_x, _line, _cnt, _data) \
  compif EQ, isconst(_line+_x), TRUE \
  compchk LT, _line, 0x08 \
  compchk GTEQ, _line, 0x00 \
  GetDisplayModuleBytes(DisplayOffsetPopup(_line,_x), _cnt, _data) \
  compelse \
  acquire __displayModuleOffsetMutex \
  mul __displayModuleOffset, _line, 100 \
  add __displayModuleOffset, __displayModuleOffset, _x \
  add __displayModuleOffset, __displayModuleOffset, 919 \
  GetDisplayModuleBytes(__displayModuleOffset, _cnt, _data) \
  release __displayModuleOffsetMutex \
  compend

dseg segment
  __commModuleOffsetMutex mutex
  __commModuleOffset word
dseg ends

#define __GetBTDeviceName(_p, _str) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleBytes(CommOffsetBtDeviceTableName(_p), 16, _str) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 8 \
  GetCommModuleBytes(__commModuleOffset, 16, _str) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTDeviceClass(_p, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleValue(CommOffsetBtDeviceTableClassOfDevice(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 24 \
  GetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __getBTDeviceAddress(_p, _btaddr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleBytes(CommOffsetBtDeviceTableBdAddr(_p), 7, _btaddr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 28 \
  GetCommModuleBytes(__commModuleOffset, 7, _btaddr) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTDeviceStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleValue(CommOffsetBtDeviceTableDeviceStatus(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 35 \
  GetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionName(_p, _str) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleBytes(CommOffsetBtConnectTableName(_p), 16, _str) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 938 \
  GetCommModuleBytes(__commModuleOffset, 16, _str) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionClass(_p, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleValue(CommOffsetBtConnectTableClassOfDevice(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 954 \
  GetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionPinCode(_p, _code) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleBytes(CommOffsetBtConnectTablePinCode(_p), 16, _code) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 958 \
  GetCommModuleBytes(__commModuleOffset, 16, _code) \
  release __commModuleOffsetMutex \
  compend

#define __getBTConnectionAddress(_p, _btaddr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleBytes(CommOffsetBtConnectTableBdAddr(_p), 7, _btaddr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 974 \
  GetCommModuleBytes(__commModuleOffset, 7, _btaddr) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionHandleNum(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleValue(CommOffsetBtConnectTableHandleNr(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 981 \
  GetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionStreamStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleValue(CommOffsetBtConnectTableStreamStatus(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 982 \
  GetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __GetBTConnectionLinkQuality(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleValue(CommOffsetBtConnectTableLinkQuality(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 983 \
  GetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __getBTInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetBtInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtInBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getBTOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetBtOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtOutBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getHSInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetHsInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsInBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getHSOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetHsOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsOutBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getUSBInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetUsbInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbInBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getUSBOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetUsbOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbOutBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __getUSBPollBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetUsbPollBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbPollBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

dseg segment
  __IOMWArgs TIOMapWrite
  __IOMWMutex mutex
  __IOMWFlattenBuf byte[]
dseg ends

#define __SetIOMapBytes(_modName, _offset, _cnt, _arrIn) \
  acquire __IOMWMutex \
  mov __IOMWArgs.ModuleName, _modName \
  mov __IOMWArgs.Offset, _offset \
  arrsubset __IOMWArgs.Buffer, _arrIn, NA, _cnt \
  syscall IOMapWrite, __IOMWArgs \
  release __IOMWMutex

#define __SetIOMapValue(_modName, _offset, _n) \
  acquire __IOMWMutex \
  mov __IOMWArgs.ModuleName, _modName \
  mov __IOMWArgs.Offset, _offset \
  flatten __IOMWFlattenBuf, _n \
  strtoarr __IOMWArgs.Buffer, __IOMWFlattenBuf \
  syscall IOMapWrite, __IOMWArgs \
  release __IOMWMutex

#ifdef __ENHANCED_FIRMWARE

dseg segment
  __IOMWBIArgs TIOMapWriteByID
dseg ends

#define __SetIOMapBytesByID(_modID, _offset, _cnt, _arrIn) \
  acquire __IOMWMutex \
  mov __IOMWBIArgs.ModuleID, _modID \
  mov __IOMWBIArgs.Offset, _offset \
  arrsubset __IOMWBIArgs.Buffer, _arrIn, NA, _cnt \
  syscall IOMapWriteByID, __IOMWBIArgs \
  release __IOMWMutex

#define __SetIOMapValueByID(_modID, _offset, _n) \
  acquire __IOMWMutex \
  mov __IOMWBIArgs.ModuleID, _modID \
  mov __IOMWBIArgs.Offset, _offset \
  flatten __IOMWFlattenBuf, _n \
  strtoarr __IOMWBIArgs.Buffer, __IOMWFlattenBuf \
  syscall IOMapWriteByID, __IOMWBIArgs \
  release __IOMWMutex

#endif

#define __setLSInputBuffer(_p, _offset, _cnt, _data) \
  compif EQ, isconst(_p+_offset), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleBytes(LowSpeedOffsetInBufBuf(_p)+_offset, _cnt, _data) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, _offset \
  SetLowSpeedModuleBytes(__lsModuleOffset, _cnt, _data) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSOutputBuffer(_p, _offset, _cnt, _data) \
  compif EQ, isconst(_p+_offset), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleBytes(LowSpeedOffsetInBufBuf(_p)+_offset, _cnt, _data) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 76 \
  add __lsModuleOffset, __lsModuleOffset, _offset \
  SetLowSpeedModuleBytes(__lsModuleOffset, _cnt, _data) \
  release __lsModuleOffsetMutex \
  compend

#ifdef __ENHANCED_FIRMWARE

#define __spawnProgram(_fname) \
  acquire __IOMWMutex \
  mov __IOMWBIArgs.ModuleID, CommandModuleID \
  mov __IOMWBIArgs.Offset, CommandOffsetActivateFlag \
  arrsubset __IOMWFlattenBuf, _fname, NA, 20 \
  arrbuild __IOMWBIArgs.Buffer, 1, 0, __IOMWFlattenBuf \
  syscall IOMapWriteByID, __IOMWBIArgs \
  release __IOMWMutex \
  stop NA

#else

#define __spawnProgram(_fname) \
  acquire __IOMWMutex \
  mov __IOMWArgs.ModuleName, CommandModuleName \
  mov __IOMWArgs.Offset, CommandOffsetActivateFlag \
  arrsubset __IOMWFlattenBuf, _fname, NA, 20 \
  arrbuild __IOMWArgs.Buffer, 1, 0, __IOMWFlattenBuf \
  syscall IOMapWrite, __IOMWArgs \
  release __IOMWMutex \
  stop NA

#endif

#define __setDisplayNormal(_x, _line, _cnt, _data) \
  compif EQ, isconst(_line+_x), TRUE \
  compchk LT, _line, 0x08 \
  compchk GTEQ, _line, 0x00 \
  SetDisplayModuleBytes(DisplayOffsetNormal(_line,_x), _cnt, _data) \
  compelse \
  acquire __displayModuleOffsetMutex \
  mul __displayModuleOffset, _line, 100 \
  add __displayModuleOffset, __displayModuleOffset, _x \
  add __displayModuleOffset, __displayModuleOffset, 119 \
  SetDisplayModuleBytes(__displayModuleOffset, _cnt, _data) \
  release __displayModuleOffsetMutex \
  compend

#define __setDisplayPopup(_x, _line, _cnt, _data) \
  compif EQ, isconst(_line+_x), TRUE \
  compchk LT, _line, 0x08 \
  compchk GTEQ, _line, 0x00 \
  SetDisplayModuleBytes(DisplayOffsetPopup(_line,_x), _cnt, _data) \
  compelse \
  acquire __displayModuleOffsetMutex \
  mul __displayModuleOffset, _line, 100 \
  add __displayModuleOffset, __displayModuleOffset, _x \
  add __displayModuleOffset, __displayModuleOffset, 919 \
  SetDisplayModuleBytes(__displayModuleOffset, _cnt, _data) \
  release __displayModuleOffsetMutex \
  compend

#define __setBTDeviceName(_p, _str) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtDeviceTableName(_p), 16, _str) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 8 \
  SetCommModuleBytes(__commModuleOffset, 16, _str) \
  release __commModuleOffsetMutex \
  compend

#define __setBTDeviceAddress(_p, _btaddr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtDeviceTableBdAddr(_p), 7, _btaddr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 28 \
  SetCommModuleBytes(__commModuleOffset, 7, _btaddr) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionName(_p, _str) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtConnectTableName(_p), 16, _str) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 938 \
  SetCommModuleBytes(__commModuleOffset, 16, _str) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionPinCode(_p, _code) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtConnectTablePinCode(_p), 16, _code) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 958 \
  SetCommModuleBytes(__commModuleOffset, 16, _code) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionAddress(_p, _btaddr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtConnectTableBdAddr(_p), 7, _btaddr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 974 \
  SetCommModuleBytes(__commModuleOffset, 7, _btaddr) \
  release __commModuleOffsetMutex \
  compend

#define __setBTInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetBtInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtInBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setBTOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetBtOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtOutBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setHSInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetHsInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsInBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setHSOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetHsOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsOutBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setUSBInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetUsbInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbInBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setUSBOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetUsbOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbOutBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setUSBPollBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetUsbPollBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbPollBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define __setSoundFrequency(_n) \
  compchk EQ, sizeof(_n), 2 \
  SetSoundModuleValue(SoundOffsetFreq, _n)

#define __setSoundDuration(_n) \
  compchk EQ, sizeof(_n), 2 \
  SetSoundModuleValue(SoundOffsetDuration, _n)

#define __setSoundSampleRate(_n) \
  compchk EQ, sizeof(_n), 2 \
  SetSoundModuleValue(SoundOffsetSampleRate, _n)

#define __setSoundFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetSoundModuleValue(SoundOffsetFlags, _n)

#define __setSoundModuleState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetSoundModuleValue(SoundOffsetState, _n)

#define __setSoundMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetSoundModuleValue(SoundOffsetMode, _n)

#define __setSoundVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetSoundModuleValue(SoundOffsetVolume, _n)

#define __setButtonPressCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  SetButtonModuleValue(ButtonOffsetPressedCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonLongPressCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  SetButtonModuleValue(ButtonOffsetLongPressCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 1 \
  SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonShortReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  SetButtonModuleValue(ButtonOffsetShortRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 2 \
  SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonLongReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  SetButtonModuleValue(ButtonOffsetLongRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 3 \
  SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonReleaseCount(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  SetButtonModuleValue(ButtonOffsetRelCnt(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  mul __btnModuleOffset, _b, 8 \
  add __btnModuleOffset, __btnModuleOffset, 4 \
  SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  compend

#define __setButtonState(_b, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_b), TRUE \
  compchk LT, _b, 0x04 \
  compchk GTEQ, _b, 0x00 \
  SetButtonModuleValue(ButtonOffsetState(_b), _n) \
  compelse \
  acquire __btnModuleOffsetMutex \
  add __btnModuleOffset, _b, 32 \
  SetButtonModuleValue(__btnModuleOffset, _n) \
  release __btnModuleOffsetMutex \
  Compend

#define __setCommandFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetFlags, _n)

#define __setUIState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetState, _n)

#define __setUIButton(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetButton, _n)

#define __setVMRunState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetRunState, _n)

#define __setBatteryState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetBatteryState, _n)

#define __setBluetoothState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetBluetoothState, _n)

#define __setUsbState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetUsbState, _n)

#define __setSleepTimeout(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetSleepTimeout, _n)

#define __setSleepTimer(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetSleepTimer, _n)

#define __setVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetVolume, _n)

#define __setOnBrickProgramPointer(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetOBPPointer, _n)

#define __forceOff(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetForceOff, _n)

#define __setAbortFlag(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetUIModuleValue(UIOffsetAbortFlag, _n)

#define __setInCustomZeroOffset(_p, _n) \
  compchk EQ, sizeof(_n), 2 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetCustomZeroOffset(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInSensorBoolean(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetSensorBoolean(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 10 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInDigiPinsDirection(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetDigiPinsDir(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 11 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInDigiPinsStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetDigiPinsIn(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 12 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInDigiPinsOutputLevel(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetDigiPinsOut(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 13 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInCustomPercentFullScale(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetCustomPctFullScale(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 14 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setInCustomActiveStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetInputModuleValue(InputOffsetCustomActiveStatus(_p), _n) \
  compelse \
  acquire __inputModuleOffsetMutex \
  mul __inputModuleOffset, _p, 20 \
  add __inputModuleOffset, __inputModuleOffset, 15 \
  SetInputModuleValue(__inputModuleOffset, _n) \
  release __inputModuleOffsetMutex \
  compend

#define __setOutPwnFreq(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetOutputModuleValue(OutputOffsetRegulationTime, _n)

#define __setOutRegulationTime(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetOutputModuleValue(OutputOffsetRegulationTime, _n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

#define __setOutRegulationOptions(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetOutputModuleValue(OutputOffsetRegulationOptions, _n)

#endif

#define __setLSInputBufferInPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleValue(LowSpeedOffsetInBufInPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 16 \
  SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSInputBufferOutPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleValue(LowSpeedOffsetInBufOutPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 17 \
  SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSInputBufferBytesToRx(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleValue(LowSpeedOffsetInBufBytesToRx(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 18 \
  SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSOutputBufferInPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleValue(LowSpeedOffsetOutBufInPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 92 \
  SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSOutputBufferOutPtr(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleValue(LowSpeedOffsetOutBufOutPtr(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 93 \
  SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSOutputBufferBytesToRx(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleValue(LowSpeedOffsetOutBufBytesToRx(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  mul __lsModuleOffset, _p, 19 \
  add __lsModuleOffset, __lsModuleOffset, 94 \
  SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSMode(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleValue(LowSpeedOffsetMode(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 152 \
  SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSChannelState(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleValue(LowSpeedOffsetChannelState(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 156 \
  SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSErrorType(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetLowSpeedModuleValue(LowSpeedOffsetErrorType(_p), _n) \
  compelse \
  acquire __lsModuleOffsetMutex \
  add __lsModuleOffset, _p, 160 \
  SetLowSpeedModuleValue(__lsModuleOffset, _n) \
  release __lsModuleOffsetMutex \
  compend

#define __setLSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetLowSpeedModuleValue(LowSpeedOffsetState, _n)

#define __setLSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetLowSpeedModuleValue(LowSpeedOffsetSpeed, _n)

#ifdef __ENHANCED_FIRMWARE
#define __setLSNoRestartOnRead(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetLowSpeedModuleValue(LowSpeedOffsetNoRestartOnRead, _n)
#endif

#define __setDisplayEraseMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  SetDisplayModuleValue(DisplayOffsetEraseMask, _n)

#define __setDisplayUpdateMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  SetDisplayModuleValue(DisplayOffsetUpdateMask, _n)

#define __setDisplayFont(_n) \
  compchk EQ, sizeof(_n), 4 \
  SetDisplayModuleValue(DisplayOffsetPFont, _n)

#define __setDisplayDisplay(_n) \
  compchk EQ, sizeof(_n), 4 \
  SetDisplayModuleValue(DisplayOffsetDisplay, _n)

#define __setDisplayFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetDisplayModuleValue(DisplayOffsetFlags, _n)

#define __setDisplayTextLinesCenterFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetDisplayModuleValue(DisplayOffsetTextLinesCenterFlags, _n)

#define __setDisplayContrast(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetDisplayModuleValue(DisplayOffsetContrast, _n)

#define __setBTDeviceClass(_p, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtDeviceTableClassOfDevice(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 24 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTDeviceStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtDeviceTableDeviceStatus(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 35 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionClass(_p, _n) \
  compchk EQ, sizeof(_n), 4 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtConnectTableClassOfDevice(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 954 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionHandleNum(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtConnectTableHandleNr(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 981 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionStreamStatus(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtConnectTableStreamStatus(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 982 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBTConnectionLinkQuality(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleValue(CommOffsetBtConnectTableLinkQuality(_p), _n) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 983 \
  SetCommModuleValue(__commModuleOffset, _n) \
  release __commModuleOffsetMutex \
  compend

#define __setBrickDataBluecoreVersion(_n) \
  compchk EQ, sizeof(_n), 2 \
  SetCommModuleValue(CommOffsetBrickDataBluecoreVersion, _n)

#define __setBrickDataBtStateStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBrickDataBtStateStatus, _n)

#define __setBrickDataBtHardwareStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBrickDataBtHwStatus, _n)

#define __setBrickDataTimeoutValue(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBrickDataTimeOutValue, _n)

#define __setBTInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtInBufInPtr, _n)

#define __setBTInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtInBufOutPtr, _n)

#define __setBTOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtOutBufInPtr, _n)

#define __setBTOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtOutBufOutPtr, _n)

#define __setHSInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsInBufInPtr, _n)

#define __setHSInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsInBufOutPtr, _n)

#define __setHSOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsOutBufInPtr, _n)

#define __setHSOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsOutBufOutPtr, _n)

#define __setUSBInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbInBufInPtr, _n)

#define __setUSBInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbInBufOutPtr, _n)

#define __setUSBOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbOutBufInPtr, _n)

#define __setUSBOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbOutBufOutPtr, _n)

#define __setUSBPollBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbPollBufInPtr, _n)

#define __setUSBPollBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbPollBufOutPtr, _n)

#define __setBTDeviceCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtDeviceCnt, _n)

#define __setBTDeviceNameCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetBtDeviceNameCnt, _n)

#define __setHSFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsFlags, _n)

#define __setHSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsSpeed, _n)

#define __setHSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetHsState, _n)

#define __setUSBState(_n) \
  compchk EQ, sizeof(_n), 1 \
  SetCommModuleValue(CommOffsetUsbState, _n)

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)

#define __setHSMode(_n) \
  compchk EQ, sizeof(_n), 2 \
  SetCommModuleValue(CommOffsetHsMode, _n)

#define __setBTDataMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  compchk EQ, isconst(_n), 1 \
  SetCommModuleValue(CommOffsetBtDataMode, _n|DATA_MODE_UPDATE) \
  wait 1

#define __setHSDataMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  compchk EQ, isconst(_n), 1 \
  SetCommModuleValue(CommOffsetHsDataMode, _n|DATA_MODE_UPDATE) \
  wait 1

#endif

dseg segment
  __FOMutex mutex
  __FOArgs TFileOpen
  __FCMutex mutex
  __FCArgs TFileClose
  __FRHMutex mutex
  __FRHArgs TFileResolveHandle
  __FRMutex mutex
  __FRArgs TFileRename
  __FDMutex mutex
  __FDArgs TFileDelete
  __FFMutex mutex
dseg ends

#ifdef __ENHANCED_FIRMWARE
dseg segment
  __FFArgs TFileFind
dseg ends
#endif

subroutine __fileResizeSub
  dseg segment
    __frsMutex mutex
    __frsNewSize dword
    __frsOldName byte[]
    __frsTmpName byte[]
    __frsFOReadArgs TFileOpen
    __frsFOWriteArgs TFileOpen
    __frsFReadArgs TFileReadWrite
    __frsFWriteArgs TFileReadWrite
    __frsFRArgs TFileRename
    __frsFCArgs TFileClose
    __frsFDArgs TFileDelete
    __frsResult word
  dseg ends
  strcat __frsFRArgs.NewFilename, '_tmp', __frsOldName
  mov __frsFRArgs.OldFilename, __frsOldName
  syscall FileRename, __frsFRArgs
  mov __frsResult, __frsFRArgs.Result
  brtst NEQ, __frsEnd, __frsResult
  // old file has been renamed successfully
  mov __frsFOReadArgs.Filename, __frsFRArgs.NewFilename
  syscall FileOpenRead, __frsFOReadArgs
  mov __frsResult, __frsFOReadArgs.Result
  brtst NEQ, __frsOpenReadFailed, __frsResult
  // renamed file is open for reading
  mov __frsFOWriteArgs.Filename, __frsOldName
  mov __frsFOWriteArgs.Length, __frsNewSize
  syscall FileOpenWrite, __frsFOWriteArgs
  mov __frsResult, __frsFOWriteArgs.Result
  brtst NEQ, __frsOpenWriteFailed, __frsResult
  // both files are open
  mov __frsFReadArgs.FileHandle, __frsFOReadArgs.FileHandle
  mov __frsFWriteArgs.FileHandle, __frsFOWriteArgs.FileHandle
__frsCopyLoop:
  set __frsFReadArgs.Length, 1024
  syscall FileRead, __frsFReadArgs
  brtst LTEQ, __frsEndLoop, __frsFReadArgs.Length
  mov __frsFWriteArgs.Buffer, __frsFReadArgs.Buffer
  mov __frsFWriteArgs.Length, __frsFReadArgs.Length
  syscall FileWrite, __frsFWriteArgs
  brtst NEQ, __frsEndLoop, __frsFWriteArgs.Result
  brtst NEQ, __frsEndLoop, __frsFReadArgs.Result
  jmp __frsCopyLoop
__frsEndLoop:
  // close read file
  mov __frsFCArgs.FileHandle, __frsFOReadArgs.FileHandle
  syscall FileClose, __frsFCArgs
  // close write file
  mov __frsFCArgs.FileHandle, __frsFOWriteArgs.FileHandle
  syscall FileClose, __frsFCArgs
  // delete read file
  mov __frsFDArgs.Filename, __frsFOReadArgs.Filename
  syscall FileDelete, __frsFDArgs
  jmp __frsEnd
__frsOpenWriteFailed:
  // close read file
  mov __frsFCArgs.FileHandle, __frsFOReadArgs.FileHandle
  syscall FileClose, __frsFCArgs
  jmp __frsEnd
__frsOpenReadFailed:
  // if the open read failed rename tmp back to original and exit
  mov __frsFRArgs.OldFilename, __frsFRArgs.NewFilename
  mov __frsFRArgs.NewFilename, __frsOldName
  syscall FileRename, __frsFRArgs
__frsEnd:
  return
ends

#define __fileResize(_fname, _newsize, _result) \
  acquire __frsMutex \
  mov __frsOldName, _fname \
  mov __frsNewSize, _newsize \
  call __fileResizeSub \
  mov _result, __frsResult \
  release __frsMutex 

#define __createFile(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  mov __FOArgs.Length, _fsize \
  syscall FileOpenWrite, __FOArgs \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __createFileLinear(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  mov __FOArgs.Length, _fsize \
  syscall FileOpenWriteLinear, __FOArgs \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __createFileNonLinear(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  mov __FOArgs.Length, _fsize \
  syscall FileOpenWriteNonLinear, __FOArgs \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __openFileAppend(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  syscall FileOpenAppend, __FOArgs \
  mov _fsize, __FOArgs.Length \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __openFileRead(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  syscall FileOpenRead, __FOArgs \
  mov _fsize, __FOArgs.Length \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __openFileReadLinear(_fname, _fsize, _handle, _result) \
  acquire __FOMutex \
  mov __FOArgs.Filename, _fname \
  syscall FileOpenReadLinear, __FOArgs \
  mov _fsize, __FOArgs.Length \
  mov _handle, __FOArgs.FileHandle \
  mov _result, __FOArgs.Result \
  release __FOMutex

#define __closeFile(_handle, _result) \
  acquire __FCMutex \
  mov __FCArgs.FileHandle, _handle \
  syscall FileClose, __FCArgs \
  mov _result, __FCArgs.Result \
  release __FCMutex

#define __resolveHandle(_fname, _handle, _writeable, _result) \
  acquire __FRHMutex \
  mov __FRHArgs.Filename, _fname \
  syscall FileResolveHandle, __FRHArgs \
  mov _handle, __FRHArgs.FileHandle \
  mov _writeable, __FRHArgs.WriteHandle \
  mov _result, __FRHArgs.Result \
  release __FRHMutex

#define __renameFile(_oldname, _newname, _result) \
  acquire __FRMutex \
  mov __FRArgs.OldFilename, _oldname \
  mov __FRArgs.NewFilename, _newname \
  syscall FileRename, __FRArgs \
  mov _result, __FRArgs.Result \
  release __FRMutex

#define __deleteFile(_fname, _result) \
  acquire __FDMutex \
  mov __FDArgs.Filename, _fname \
  syscall FileDelete, __FDArgs \
  mov _result, __FDArgs.Result \
  release __FDMutex

#ifdef __ENHANCED_FIRMWARE

#define __findFirstFile(_fname, _handle, _result) \
  acquire __FFMutex \
  mov __FFArgs.Filename, _fname \
  syscall FileFindFirst, __FFArgs \
  mov _result, __FFArgs.Result \
  mov _handle, __FFArgs.FileHandle \
  mov _fname, __FFArgs.Filename \
  release __FFMutex

#define __findNextFile(_fname, _handle, _result) \
  acquire __FFMutex \
  mov __FFArgs.FileHandle, _handle \
  syscall FileFindNext, __FFArgs \
  mov _result, __FFArgs.Result \
  mov _handle, __FFArgs.FileHandle \
  mov _fname, __FFArgs.Filename \
  release __FFMutex

#endif

dseg segment
  __FReadArgs TFileReadWrite
  __FReadTmpByte byte
  __FReadMutex mutex
  __RLSBuffer byte[]
  __RLSOutput byte[]
  __RLSReturn word
  __RLSReturnAddress byte
  __RLSMaxBytes word
  __RLSByteCount word
  __soTmpBuf byte[]
  __soMutex mutex
dseg ends

#define __sizeOF(_n, _result) \
  compif EQ, ((typeof(_n)>=1)&&(typeof(_n)<=6))||(typeof(_n)==10), TRUE \
  set _result, sizeof(_n) \
  compelse \
  acquire __soMutex \
  flatten __soTmpBuf, _n \
  arrsize _result, __soTmpBuf \
  sub _result, _result, 1 \
  release __soMutex \
  compend

#define __readBytes(_handle, _len, _buf, _result) \
  acquire __FReadMutex \
  mov __FReadArgs.FileHandle, _handle \
  mov __FReadArgs.Length, _len \
  syscall FileRead, __FReadArgs \
  mov _result, __FReadArgs.Result \
  strtoarr _buf, __FReadArgs.Buffer \
  mov _len, __FReadArgs.Length \
  release __FReadMutex

#define __readValue(_handle, _n, _result) \
  acquire __FReadMutex \
  mov __FReadArgs.FileHandle, _handle \
  __sizeOF(_n, __FReadArgs.Length) \
  syscall FileRead, __FReadArgs \
  mov _result, __FReadArgs.Result \
  unflatten _n, __FReadTmpByte, __FReadArgs.Buffer, _n \
  release __FReadMutex

#define __readLnValue(_handle, _n, _result) \
  acquire __FReadMutex \
  mov __FReadArgs.FileHandle, _handle \
  __sizeOF(_n, __FReadArgs.Length) \
  syscall FileRead, __FReadArgs \
  unflatten _n, __FReadTmpByte, __FReadArgs.Buffer, _n \
  set __FReadArgs.Length, 2 \
  syscall FileRead, __FReadArgs \
  mov _result, __FReadArgs.Result \
  release __FReadMutex

#define __readLnStringEx(_handle, _output, _max, _result) \
  acquire __FReadMutex \
  mov __FReadArgs.FileHandle, _handle \
  mov __RLSMaxBytes, _max \
  subcall __readStringLine, __RLSReturnAddress \
  mov _result, __RLSReturn \
  mov _output, __RLSOutput \
  release __FReadMutex \

#define __readLnString(_handle, _output, _result) __readLnStringEx(_handle, _output, 0xFFFF, _result)

subroutine __readStringLine
  arrinit __RLSOutput, 0, 1
  set __RLSByteCount, 0
  __RLSStringLoop:
  set __FReadArgs.Length, 1
  mov __RLSBuffer, __RLSOutput
  syscall FileRead, __FReadArgs
  mov __RLSReturn, __FReadArgs.Result
  brtst NEQ, __RLSStringDone, __RLSReturn
  index __FReadTmpByte, __FReadArgs.Buffer, NA
  brcmp EQ, __RLSStringDone, __FReadTmpByte, 0x0A
  brcmp EQ, __RLSStringSkip, __FReadTmpByte, 0x0D
  strcat __RLSOutput, __RLSBuffer, __FReadArgs.Buffer
  add __RLSByteCount, __RLSByteCount, 1
  brcmp GTEQ, __RLSStringDone, __RLSByteCount, __RLSMaxBytes
  __RLSStringSkip:
  jmp __RLSStringLoop
  __RLSStringDone:
  subret __RLSReturnAddress
ends

dseg segment
  __FWriteArgs TFileReadWrite
  __FWriteFlattenBuf byte[]
  __FWriteMutex mutex
  __FWriteLn byte[] {0x0D, 0x0A}
dseg ends

#define __writeBytes(_handle, _buf, _len, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  mov __FWriteArgs.Buffer, _buf \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  mov _len, __FWriteArgs.Length \
  release __FWriteMutex

#define __writeString(_handle, _str, _len, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  strtoarr __FWriteArgs.Buffer, _str \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  mov _len, __FWriteArgs.Length \
  release __FWriteMutex

#define __writeLnString(_handle, _str, _len, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  strtoarr __FWriteFlattenBuf, _str \
  arrbuild __FWriteArgs.Buffer, __FWriteFlattenBuf, __FWriteLn \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  mov _len, __FWriteArgs.Length \
  release __FWriteMutex

#define __writeBytesEx(_handle, _len, _buf, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  mov __FWriteArgs.Length, _len \
  mov __FWriteArgs.Buffer, _buf \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  mov _len, __FWriteArgs.Length \
  release __FWriteMutex

#define __writeValue(_handle, _n, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  flatten __FWriteFlattenBuf, _n \
  strtoarr __FWriteArgs.Buffer, __FWriteFlattenBuf \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  release __FWriteMutex

#define __writeLnValue(_handle, _n, _result) \
  acquire __FWriteMutex \
  mov __FWriteArgs.FileHandle, _handle \
  flatten __FWriteFlattenBuf, _n \
  strtoarr __FWriteArgs.Buffer, __FWriteFlattenBuf \
  arrbuild __FWriteFlattenBuf, __FWriteArgs.Buffer, __FWriteLn \
  mov __FWriteArgs.Buffer, __FWriteFlattenBuf \
  arrsize __FWriteArgs.Length, __FWriteArgs.Buffer \
  syscall FileWrite, __FWriteArgs \
  mov _result, __FWriteArgs.Result \
  release __FWriteMutex

dseg segment
  __MWMutex mutex
  __MWArgs TMessageWrite
  __MRMutex mutex
  __MRArgs TMessageRead
  __SRNTmpVal sdword
  __RRNTmpVal sdword
  __RRNErr byte
dseg ends

#define __sendMessage(_queue, _msg, _result) \
  acquire __MWMutex \
  mov __MWArgs.QueueID, _queue \
  mov __MWArgs.Message, _msg \
  syscall MessageWrite, __MWArgs \
  mov _result, __MWArgs.Result \
  release __MWMutex

#define __receiveMessage(_queue, _clear, _msg, _result) \
  acquire __MRMutex \
  mov __MRArgs.QueueID, _queue \
  mov __MRArgs.Remove, _clear \
  syscall MessageRead, __MRArgs \
  mov _msg, __MRArgs.Message \
  mov _result, __MRArgs.Result \
  release __MRMutex

#define __receiveRemoteBool(_queue, _clear, _bval, _result) \
  acquire __MRMutex \
  mov __MRArgs.QueueID, _queue \
  mov __MRArgs.Remove, _clear \
  set _bval, 0 \
  syscall MessageRead, __MRArgs \
  brtst NEQ, __RRB_Err##__I__, __MRArgs.Result \
  index _bval, __MRArgs.Message, NA \
  __RRB_Err##__I__: \
  __IncI__ \
  mov _result, __MRArgs.Result \
  release __MRMutex

#define __receiveRemoteNumber(_queue, _clear, _val, _result) \
  acquire __MRMutex \
  mov __MRArgs.QueueID, _queue \
  mov __MRArgs.Remove, _clear \
  set __RRNTmpVal, 0 \
  syscall MessageRead, __MRArgs \
  unflatten __RRNTmpVal, __RRNErr, __MRArgs.Message, __RRNTmpVal \
  mov _val, __RRNTmpVal \
  mov _result, __MRArgs.Result \
  release __MRMutex

#define __receiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, _result) \
  acquire __MRMutex \
  mov __MRArgs.QueueID, _queue \
  mov __MRArgs.Remove, _clear \
  set __RRNTmpVal, 0 \
  set _bval, 0 \
  syscall MessageRead, __MRArgs \
  brtst NEQ, __RRM_Err##__I__, __MRArgs.Result \
  index _bval, __MRArgs.Message, NA \
  unflatten __RRNTmpVal, __RRNErr, __MRArgs.Message, __RRNTmpVal \
  __RRM_Err##__I__: \
  __IncI__ \
  mov _val, __RRNTmpVal \
  mov _str, __MRArgs.Message \
  mov _result, __MRArgs.Result \
  release __MRMutex

#define __sendResponseBool(_queue, _bval, _result) \
  acquire __MWMutex \
  add __MWArgs.QueueID, _queue, 10 \
  arrbuild __MWArgs.Message, _bval, 0 \
  syscall MessageWrite, __MWArgs \
  mov _result, __MWArgs.Result \
  release __MWMutex

#define __sendResponseNumber(_queue, _val, _result) \
  acquire __MWMutex \
  add __MWArgs.QueueID, _queue, 10 \
  mov __SRNTmpVal, _val \
  flatten __MWArgs.Message, __SRNTmpVal \
  syscall MessageWrite, __MWArgs \
  mov _result, __MWArgs.Result \
  release __MWMutex

#define __sendResponseString(_queue, _msg, _result) \
  acquire __MWMutex \
  add __MWArgs.QueueID, _queue, 10 \
  mov __MWArgs.Message, _msg \
  syscall MessageWrite, __MWArgs \
  mov _result, __MWArgs.Result \
  release __MWMutex


dseg segment
  __CBTCSArgs TCommBTCheckStatus
  __CBTCSMutex mutex
  __CBTWArgs TCommBTWrite
  __CBTWMutex mutex
  __SRSTmpBuf byte[]
  __SRSSendBuf byte[]
  __SRSTmpLongVal sdword
  __SRSTmpWordVal sword
  __SRSTmpByteVal sbyte
  __SRSFlattenBuf byte[]
  __RemoteMutex mutex
dseg ends

dseg segment
  __GenericCmdFilenamePacket byte[] {0xFF, 0xFF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __GenericCreateFilePacket byte[]  {0xFF, 0xFF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0xFF, 0xFF, 0xFF, 0xFF}
  __GenericIOMapPacket byte[]       {0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF}
// direct commands
  __DCStartProgramPacket byte[]     {0x80, 0x00}
  __DCStopProgramPacket byte[]      {0x80, 0x01}
  __DCPlaySoundFilePacket byte[]    {0x80, 0x02, 0xFF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __DCPlayTonePacket byte[]         {0x80, 0x03, 0xFF, 0xFF, 0xFF, 0xFF}
  __DCSetOutputStatePacket byte[]   {0x80, 0x04}
  __DCSetInputModePacket byte[]     {0x80, 0x05}
  __DCGetOutputStatePacket byte[]   {0x00, 0x06}
  __DCGetInputValuesPacket byte[]   {0x00, 0x07}
  __DCResetScaledValuePacket byte[] {0x80, 0x08}
  __DCMessageWritePacket byte[]     {0x80, 0x09, 0xFF, 0xFF}
  __DCResetMotorPosPacket byte[]    {0x80, 0x0a}
  __DCGetBatteryLevelPacket byte[]  {0x00, 0x0b}
  __DCStopSoundPacket byte[]        {0x80, 0x0c}
  __DCKeepAlivePacket byte[]        {0x80, 0x0d}
  __DCLSGetStatusPacket byte[]      {0x00, 0x0e}
  __DCLSWritePacket byte[]          {0x80, 0x0f}
  __DCLSReadPacket byte[]           {0x00, 0x10}
  __DCGetCurProgNamePacket byte[]   {0x00, 0x11}
  __DCMessageReadPacket byte[]      {0x00, 0x13}
  __DCDatalogReadPacket byte[]      {0x00, 0x19}
  __DCDatalogSetTimesPacket byte[]  {0x80, 0x1a}
  __DCBTGetContactCntPacket byte[]  {0x00, 0x1b}
  __DCBTGetContactNamePacket byte[] {0x00, 0x1c}
  __DCBTGetConnectCntPacket byte[]  {0x00, 0x1d}
  __DCBTGetConnectNamePacket byte[] {0x00, 0x1e}
  __DCSetPropertyPacket byte[]      {0x80, 0x1f}
  __DCGetPropertyPacket byte[]      {0x00, 0x20}
  __DCUpdateResetCountPacket byte[] {0x80, 0x21}
// system commands
  __SCOpenReadPacket byte[]         {0x01, 0x80}
  __SCOpenWritePacket byte[]        {0x01, 0x81}
  __SCReadPacket byte[]             {0x01, 0x82}
  __SCWritePacket byte[]            {0x01, 0x83}
  __SCClosePacket byte[]            {0x01, 0x84}
  __SCDeletePacket byte[]           {0x01, 0x85}
  __SCFindFirstPacket byte[]        {0x01, 0x86}
  __SCFindNextPacket byte[]         {0x01, 0x87}
  __SCGetFirmwareVerPacket byte[]   {0x01, 0x88}
  __SCOpenWriteLinearPacket byte[]  {0x01, 0x89}
  __SCOpenWriteDataPacket byte[]    {0x01, 0x8b}
  __SCOpenAppendDataPacket byte[]   {0x01, 0x8c}
  __SCIOMapReadPacket byte[]        {0x01, 0x94}
  __SCIOMapWritePacket byte[]       {0x81, 0x95}
  __SCSetBrickNamePacket byte[]     {0x81, 0x98, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __SCBTGetAddressPacket byte[]     {0x01, 0x9a}
  __SCGetDeviceInfoPacket byte[]    {0x01, 0x9b}
  __SCDeleteUserFlashPacket byte[]  {0x01, 0xA0}
  __SCPollCommandLenPacket byte[]   {0x01, 0xA1}
  __SCPollCommandPacket byte[]      {0x01, 0xA2} // append buffer number, cmd len,
  __SCRenameFilePacket byte[]       {0x81, 0xA3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __SCBTFactoryResetPacket byte[]   {0x81, 0xA4}
dseg ends

#define __bluetoothStatus(_conn, _result) \
  acquire __CBTCSMutex \
  mov __CBTCSArgs.Connection, _conn \
  syscall CommBTCheckStatus, __CBTCSArgs \
  mov _result, __CBTCSArgs.Result \
  release __CBTCSMutex

#define __bluetoothWrite(_conn, _buffer, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  mov __CBTWArgs.Buffer, _buffer \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __UseRS485() \
  setin IN_TYPE_HISPEED, IN_4, TypeField \
  wait 1

#ifdef __ENHANCED_FIRMWARE

dseg segment
  __CHSCSArgs TCommHSCheckStatus
  __CHSCSMutex mutex
  __CHSWArgs TCommHSReadWrite
  __CHSWMutex mutex
  __CHSRArgs TCommHSReadWrite
  __CHSRMutex mutex
  __CHSCArgs TCommHSControl
  __CHSCMutex mutex
  __SHSTmpVal sdword
  __WFRRMutex mutex
  __WFRRAvail byte
  __WFRR_I byte
  __WFRRCmd byte
  __WFRRBuffer byte[]
  __WFRRTmpBuffer byte[]
  __WFRRUnflattenBuf byte[]
  __WFRRUnflattenErr byte
  __WFRRTmpByte byte
  __WFRRTmpSWord sword
  __WFRRTmpSDWord sdword
  __WFRRStatus sbyte
dseg ends

#define __RS485Status(_sendingData, _dataAvail) \
  acquire __CHSCSMutex \
  syscall CommHSCheckStatus, __CHSCSArgs \
  mov _sendingData, __CHSCSArgs.SendingData \
  mov _dataAvail, __CHSCSArgs.DataAvailable \
  release __CHSCSMutex

#define __RS485WriteSCDC(_conn, _buffer, _status) \
  acquire __CHSWMutex \
  sub __WFRRTmpByte, _conn, CONN_HS_ALL \
  arrbuild __CHSWArgs.Buffer, __WFRRTmpByte, _buffer \
  syscall CommHSWrite, __CHSWArgs \
  mov _status, __CHSWArgs.Status \
  release __CHSWMutex

#define __RS485Write(_buffer, _status) \
  acquire __CHSWMutex \
  mov __CHSWArgs.Buffer, _buffer \
  syscall CommHSWrite, __CHSWArgs \
  mov _status, __CHSWArgs.Status \
  release __CHSWMutex

#define __RS485Read(_buffer, _status) \
  acquire __CHSRMutex \
  syscall CommHSRead, __CHSRArgs \
  mov _buffer, __CHSRArgs.Buffer \
  mov _status, __CHSRArgs.Status \
  release __CHSRMutex

#if __FIRMWARE_VERSION > 107

#define __RS485Control(_cmd, _baud, _mode, _result) \
  acquire __CHSCMutex \
  mov __CHSCArgs.Command, _cmd \
  mov __CHSCArgs.BaudRate, _baud \
  mov __CHSCArgs.Mode, _mode \
  syscall CommHSControl, __CHSCArgs \
  mov _result, __CHSCArgs.Result \
  release __CHSCMutex \
  wait 1

#else

#define __RS485Control(_cmd, _baud, _result) \
  acquire __CHSCMutex \
  mov __CHSCArgs.Command, _cmd \
  mov __CHSCArgs.BaudRate, _baud \
  syscall CommHSControl, __CHSCArgs \
  mov _result, __CHSCArgs.Result \
  release __CHSCMutex \
  wait 1

#endif

#define __sendRS485Bool(_bval, _status) \
  acquire __CHSWMutex \
  arrbuild __CHSWArgs.Buffer, _bval, 0 \
  syscall CommHSWrite, __CHSWArgs \
  mov _status, __CHSWArgs.Status \
  release __CHSWMutex

#define __sendRS485Number(_val, _status) \
  acquire __CHSWMutex \
  mov __SHSTmpVal, _val \
  flatten __CHSWArgs.Buffer, __SHSTmpVal \
  syscall CommHSWrite, __CHSWArgs \
  mov _status, __CHSWArgs.Status \
  release __CHSWMutex

#define __sendRS485String(_str, _status) __RS485Write(_str, _status)

#endif

#ifdef __ENHANCED_FIRMWARE

#define __connectionSCDCWrite(_conn, _buffer, _result) \
  brcmp LT, __ConnWrite_Else##__I__, _conn, 4 \
  __RS485WriteSCDC(_conn, _buffer, _result) \
  jmp __ConnWrite_EndIf##__I__ \
  __ConnWrite_Else##__I__: \
  __bluetoothWrite(_conn, _buffer, _result) \
  __ConnWrite_EndIf##__I__: \
  __IncI__

#define __connectionRawWrite(_conn, _buffer, _result) \
  brcmp LT, __ConnWrite_Else##__I__, _conn, 4 \
  __RS485Write(_buffer, _result) \
  jmp __ConnWrite_EndIf##__I__ \
  __ConnWrite_Else##__I__: \
  __bluetoothWrite(_conn, _buffer, _result) \
  __ConnWrite_EndIf##__I__: \
  __IncI__

#define __remoteConnectionIdle(_conn, _result) \
  brcmp NEQ, __ConnIdle_Else##__I__, _conn, 4 \
  __RS485Status(_result, __SHSTmpVal) \
  jmp __ConnIdle_EndIf##__I__ \
  __ConnIdle_Else##__I__: \
  __bluetoothStatus(_conn, _result) \
  __ConnIdle_EndIf##__I__: \
  tst EQ, _result, _result \
  __IncI__

subroutine __DoWaitForRemoteResponse
  set __WFRR_I, 0
  __wFRR_Repeat:
  __GetLastResponseInfo(FALSE, __WFRRAvail, __WFRRCmd, __WFRRBuffer, __WFRRStatus)
  wait 2
  add __WFRR_I, __WFRR_I, 1
  // if it rolls back around to 0 then break out of loop
  brtst EQ, __wFRR_Break, __WFRR_I
  brtst EQ, __wFRR_Repeat, __WFRRAvail
  // > 0 bytes in last response so read it one more time and clear it
  __GetLastResponseInfo(TRUE, __WFRRAvail, __WFRRCmd, __WFRRBuffer, __WFRRStatus)
  jmp __wFRR_End
  __wFRR_Break:
  set __WFRRStatus, TRUE // timeout error occurred
  __wFRR_End:
  return
ends

#else

#define __connectionSCDCWrite(_conn, _buffer, _result) __bluetoothWrite(_conn, _buffer, _result)
#define __connectionRawWrite(_conn, _buffer, _result) __bluetoothWrite(_conn, _buffer, _result)

#define __remoteConnectionIdle(_conn, _result) \
  __bluetoothStatus(_conn, _result) \
  tst EQ, _result, _result

#endif

#define __sendRemoteBool(_conn, _queue, _bval, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpBuf, __DCMessageWritePacket \
  replace __SRSTmpBuf, __SRSTmpBuf, 2, _queue \
  replace __SRSTmpBuf, __SRSTmpBuf, 3, 2 \
  arrbuild __SRSSendBuf, __SRSTmpBuf, _bval, 0 \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __sendRemoteNumber(_conn, _queue, _val, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpBuf, __DCMessageWritePacket \
  replace __SRSTmpBuf, __SRSTmpBuf, 2, _queue \
  replace __SRSTmpBuf, __SRSTmpBuf, 3, 5 \
  mov __SRSTmpLongVal, _val \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  arrbuild __SRSSendBuf, __SRSTmpBuf, __SRSFlattenBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __sendRemoteString(_conn, _queue, _str, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpBuf, __DCMessageWritePacket \
  replace __SRSTmpBuf, __SRSTmpBuf, 2, _queue \
  arrsize __SRSTmpLongVal, _str \
  replace __SRSTmpBuf, __SRSTmpBuf, 3, __SRSTmpLongVal \
  arrbuild __SRSSendBuf, __SRSTmpBuf, _str \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteMessageRead(_conn, _queue, _result) \
  acquire __RemoteMutex \
  add __SRSTmpLongVal, _queue, 10 \
  arrbuild __SRSSendBuf, __DCMessageReadPacket, __SRSTmpLongVal, _queue, 0x01 \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteResetScaledValue(_conn, _port, _result) \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __DCResetScaledValuePacket, _port \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteResetMotorPosition(_conn, _port, _brelative, _result) \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __DCResetMotorPosPacket, _port, _brelative \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteSetInputMode(_conn, _port, _type, _mode, _result) \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __DCSetInputModePacket, _port, _type, _mode \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpLongVal, _tacholimit \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  arrbuild __SRSTmpBuf, __DCSetOutputStatePacket, _port, _speed, _mode, _regmode, _turnpct, _runstate, __SRSFlattenBuf \
  strtoarr __SRSSendBuf, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remotePlaySoundFile(_conn, _filename, _bloop, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __DCPlaySoundFilePacket \
  strsubset __SRSTmpBuf, _filename, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, 2, _bloop \
  replace __SRSSendBuf, __SRSSendBuf, 3, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remotePlayTone(_conn, _frequency, _duration, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __DCPlayTonePacket \
  and __SRSTmpLongVal, _frequency, 0xff \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpLongVal \
  div __SRSTmpLongVal, _frequency, 0xff \
  replace __SRSSendBuf, __SRSSendBuf, 3, __SRSTmpLongVal \
  and __SRSTmpLongVal, _duration, 0xff \
  replace __SRSSendBuf, __SRSSendBuf, 4, __SRSTmpLongVal \
  div __SRSTmpLongVal, _duration, 0xff \
  replace __SRSSendBuf, __SRSSendBuf, 5, __SRSTmpLongVal \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteGenericFilenameCommand(_conn, _cmdBuf, _filename, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericCmdFilenamePacket \
  strsubset __SRSTmpBuf, _filename, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, NA, _cmdBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteStartProgram(_conn, _filename, _result) __remoteGenericFilenameCommand(_conn, __DCStartProgramPacket, _filename, _result)

#define __remoteGenericCreateFileCommand(_conn, _cmdBuf, _filename, _size, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericCreateFilePacket \
  strsubset __SRSTmpBuf, _filename, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, NA, _cmdBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  mov __SRSTmpLongVal, _size \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 22, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteGenericByteCommand(_conn, _cmdBuf, _val, _result) \
  compchk EQ, sizeof(_val), 1 \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, _cmdBuf, _val \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteResetTachoCount(_conn, _port, _result) __remoteGenericByteCommand(_conn, __DCUpdateResetCountPacket, _port, _result)

#define __remoteDoWrite(_conn, _handle, _data, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __SCWritePacket, _handle, _data \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteDoRead(_conn, _handle, _numbytes, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  mov __SRSTmpWordVal, _numbytes \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  arrbuild __SRSSendBuf, __SCReadPacket, _handle, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteDoPollCommand(_conn, _bufnum, _len, _result) \
  compchk EQ, sizeof(_bufnum), 1 \
  compchk EQ, sizeof(_len), 1 \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __SCPollCommandPacket, _bufnum, _len \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteDoIOMapRead(_conn, _id, _offset, _numbytes, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericIOMapPacket \
  replace __SRSSendBuf, __SRSSendBuf, NA, __SCIOMapReadPacket \
  mov __SRSTmpLongVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  mov __SRSTmpWordVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 6, __SRSTmpBuf \
  mov __SRSTmpWordVal, _numbytes \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 8, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex


#ifdef __ENHANCED_FIRMWARE

#define __remoteGetOutputState(_conn, _params, _result) \
  __remoteGenericByteCommand(_conn, __DCGetOutputStatePacket, _params.Port, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGOSR_End##__I__, _result \
  brcmp NEQ, __RRGOSR_End##__I__, __WFRRAvail, 23 \
  unflatten _params, __WFRRUnflattenErr, __WFRRBuffer, _params \
  __RRGOSR_End##__I__: \
  __IncI__

#define __remoteGetInputValues(_conn, _params, _result) \
  __remoteGenericByteCommand(_conn, __DCGetInputValuesPacket, _params.Port, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGIVR_End##__I__, _result \
  brcmp NEQ, __RRGIVR_End##__I__, __WFRRAvail, 14 \
  unflatten _params, __WFRRUnflattenErr, __WFRRBuffer, _params \
  __RRGIVR_End##__I__: \
  __IncI__

#define __remoteGetBatteryLevel(_conn, _value, _result) \
  compchk EQ, sizeof(_value), 2 \
  __connectionSCDCWrite(_conn, __DCGetBatteryLevelPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGBL_End##__I__, _result \
  brcmp NEQ, __RRGBL_End##__I__, __WFRRAvail, 3 \
  unflatten _value, __WFRRUnflattenErr, __WFRRBuffer, _value \
  __RRGBL_End##__I__: \
  __IncI__

#define __remoteLowspeedGetStatus(_conn, _value, _result) \
  __connectionSCDCWrite(_conn, __DCLSGetStatusPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRLGS_End##__I__, _result \
  brcmp NEQ, __RRLGS_End##__I__, __WFRRAvail, 2 \
  index _value, __WFRRBuffer, NA \
  __RRLGS_End##__I__: \
  __IncI__

#define __remoteLowspeedRead(_conn, _port, _bread, _data, _result) \
  __remoteGenericByteCommand(_conn, __DCLSReadPacket, _port, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRLR_End##__I__, _result \
  brcmp NEQ, __RRLR_End##__I__, __WFRRAvail, 18 \
  index _bread, __WFRRBuffer, NA \
  arrsubset _data, __WFRRBuffer, 1, _bread \
  __RRLR_End##__I__: \
  __IncI__

#define __remoteGetCurrentProgramName(_conn, _name, _result) \
  __connectionSCDCWrite(_conn, __DCGetCurProgNamePacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCPN_End##__I__, _result \
  brcmp NEQ, __RRGCPN_End##__I__, __WFRRAvail, 21 \
  mov _name, __WFRRBuffer \
  __RRGCPN_End##__I__: \
  __IncI__

#define __remoteDatalogRead(_conn, _remove, _cnt, _log, _result) \
  __remoteGenericByteCommand(_conn, __DCDatalogReadPacket, _remove, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRDR_End##__I__, _result \
  brcmp NEQ, __RRDR_End##__I__, __WFRRAvail, 62 \
  index _cnt, __WFRRBuffer, NA \
  arrsubset _log, __WFRRBuffer, 1, _cnt \
  __RRDR_End##__I__: \
  __IncI__

#define __remoteGetContactCount(_conn, _cnt, _result) \
  __connectionSCDCWrite(_conn, __DCBTGetContactCntPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCTC_End##__I__, _result \
  brcmp NEQ, __RRGCTC_End##__I__, __WFRRAvail, 2 \
  index _cnt, __WFRRBuffer, NA \
  __RRGCTC_End##__I__: \
  __IncI__

#define __remoteGetContactName(_conn, _idx, _name, _result) \
  __remoteGenericByteCommand(_conn, __DCBTGetContactNamePacket, _idx, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCTN_End##__I__, _result \
  brcmp NEQ, __RRGCTN_End##__I__, __WFRRAvail, 19 \
  mov _name, __WFRRBuffer \
  __RRGCTN_End##__I__: \
  __IncI__

#define __remoteGetConnectionCount(_conn, _cnt, _result) \
  __connectionSCDCWrite(_conn, __DCBTGetConnectCntPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCNC_End##__I__, _result \
  brcmp NEQ, __RRGCNC_End##__I__, __WFRRAvail, 2 \
  index _cnt, __WFRRBuffer, NA \
  __RRGCNC_End##__I__: \
  __IncI__

#define __remoteGetConnectionName(_conn, _idx, _name, _result) \
  __remoteGenericByteCommand(_conn, __DCBTGetConnectNamePacket, _idx, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGCNN_End##__I__, _result \
  brcmp NEQ, __RRGCNN_End##__I__, __WFRRAvail, 19 \
  mov _name, __WFRRBuffer \
  __RRGCNN_End##__I__: \
  __IncI__

#define __remoteGetProperty(_conn, _property, _value, _result) \
  mov _value, 0 \
  __remoteGenericByteCommand(_conn, __DCGetPropertyPacket, _property, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGP_End##__I__, _result \
  unflatten _value, __WFRRUnflattenErr, __WFRRBuffer, _value \
  __RRGP_End##__I__: \
  __IncI__

#define __remoteOpenRead(_conn, _filename, _handle, _size, _result) \
  __remoteGenericFilenameCommand(_conn, __SCOpenReadPacket, _filename, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROR_End##__I__, _result \
  brcmp NEQ, __RROR_End##__I__, __WFRRAvail, 6 \
  index _handle, __WFRRBuffer, NA \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 1, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _size, __WFRRTmpSDWord \
  __RROR_End##__I__: \
  __IncI__

#define __remoteOpenWrite(_conn, _filename, _size, _handle, _result) \
  __remoteGenericCreateFileCommand(_conn, __SCOpenWritePacket, _filename, _size, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROW_End##__I__, _result \
  brcmp NEQ, __RROW_End##__I__, __WFRRAvail, 2 \
  index _handle, __WFRRBuffer, NA \
  __RROW_End##__I__: \
  __IncI__

#define __remoteRead(_conn, _handle, _numbytes, _data, _result) \
  mov _result, 1 \
  brcmp GT, __RRRead_End##__I__, _numbytes, 58 \
  __remoteDoRead(_conn, _handle, _numbytes, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  add __WFRRTmpByte, _numbytes, 4 \
  brtst NEQ, __RRRead_End##__I__, _result \
  brcmp NEQ, __RRRead_End##__I__, __WFRRAvail, __WFRRTmpByte \
  index _handle, __WFRRBuffer, NA \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 1, 2 \
  arrtostr __WFRRUnflattenBuf, __WFRRTmpBuffer \
  unflatten __WFRRTmpSWord, __WFRRUnflattenErr, __WFRRUnflattenBuf, __WFRRTmpSWord \
  mov _numbytes, __WFRRTmpSWord \
  arrsubset _data, __WFRRBuffer, 2, _numbytes \
  __RRRead_End##__I__: \
  __IncI__

#define __remoteWrite(_conn, _handle, _numbytes, _data, _result) \
  mov _result, 1 \
  brcmp GT, __RRWrite_End##__I__, _numbytes, 58 \
  __remoteDoWrite(_conn, _handle, _data, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRWrite_End##__I__, _result \
  brcmp NEQ, __RRWrite_End##__I__, __WFRRAvail, 4 \
  index _handle, __WFRRBuffer, NA \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 1, 3 \
  unflatten __WFRRTmpSWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSWord \
  mov _numbytes, __WFRRTmpSWord \
  __RRWrite_End##__I__: \
  __IncI__

#define __remoteCloseFile(_conn, _handle, _result) \
  __remoteGenericByteCommand(_conn, __SCClosePacket, _handle, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus

#define __remoteDeleteFile(_conn, _filename, _result) \
  __remoteGenericFilenameCommand(_conn, __SCDeletePacket, _filename, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus

#define __remoteDeleteUserFlash(_conn, _result) \
  __connectionSCDCWrite(_conn, __SCDeleteUserFlashPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus

#define __remoteFindFirstFile(_conn, _mask, _handle, _name, _size, _result) \
  __remoteGenericFilenameCommand(_conn, __SCFindFirstPacket, _mask, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRFindFirstFile_End##__I__, _result \
  brcmp NEQ, __RRFindFirstFile_End##__I__, __WFRRAvail, 26 \
  index _handle, __WFRRBuffer, NA \
  arrsubset _name, __WFRRBuffer, 1, 20 \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 21, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _size, __WFRRTmpSDWord \
  __RRFindFirstFile_End##__I__: \
  __IncI__

#define __remoteFindNextFile(_conn, _handle, _name, _size, _result) \
  __remoteGenericByteCommand(_conn, __SCFindNextPacket, _handle, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRFindNextFile_End##__I__, _result \
  brcmp NEQ, __RRFindNextFile_End##__I__, __WFRRAvail, 26 \
  index _handle, __WFRRBuffer, NA \
  arrsubset _name, __WFRRBuffer, 1, 20 \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 21, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _size, __WFRRTmpSDWord \
  __RRFindNextFile_End##__I__: \
  __IncI__

#define __remoteGetFirmwareVersion(_conn, _pmin, _pmaj, _fmin, _fmaj, _result) \
  __connectionSCDCWrite(_conn, __SCGetFirmwareVerPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGetFirmwareVersion_End##__I__, _result \
  brcmp NEQ, __RRGetFirmwareVersion_End##__I__, __WFRRAvail, 5 \
  index _pmin, __WFRRBuffer, NA \
  index _pmaj, __WFRRBuffer, 1 \
  index _fmin, __WFRRBuffer, 2 \
  index _fmaj, __WFRRBuffer, 3 \
  __RRGetFirmwareVersion_End##__I__: \
  __IncI__

#define __remoteOpenWriteLinear(_conn, _filename, _size, _handle, _result) \
  __remoteGenericCreateFileCommand(_conn, __SCOpenWriteLinearPacket, _filename, _size, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROWL_End##__I__, _result \
  brcmp NEQ, __RROWL_End##__I__, __WFRRAvail, 2 \
  index _handle, __WFRRBuffer, NA \
  __RROWL_End##__I__: \
  __IncI__

#define __remoteOpenWriteData(_conn, _filename, _size, _handle, _result) \
  __remoteGenericCreateFileCommand(_conn, __SCOpenWriteDataPacket, _filename, _size, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROWD_End##__I__, _result \
  brcmp NEQ, __RROWD_End##__I__, __WFRRAvail, 2 \
  index _handle, __WFRRBuffer, NA \
  __RROWD_End##__I__: \
  __IncI__

#define __remoteOpenAppendData(_conn, _filename, _handle, _size, _result) \
  __remoteGenericFilenameCommand(_conn, __SCOpenAppendDataPacket, _filename, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RROAD_End##__I__, _result \
  brcmp NEQ, __RROAD_End##__I__, __WFRRAvail, 6 \
  index _handle, __WFRRBuffer, NA \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 1, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _size, __WFRRTmpSDWord \
  __RROAD_End##__I__: \
  __IncI__

#define __remoteGetDeviceInfo(_conn, _name, _btaddr, _btsignal, _freemem, _result) \
  __connectionSCDCWrite(_conn, __SCGetDeviceInfoPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGetDeviceInfo_End##__I__, _result \
  brcmp NEQ, __RRGetDeviceInfo_End##__I__, __WFRRAvail, 31 \
  arrsubset _name, __WFRRBuffer, NA, 15 \
  arrsubset _btaddr, __WFRRBuffer, 15, 7 \
  arrsubset _btsignal, __WFRRBuffer, 22, 4 \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 26, 5 \
  unflatten __WFRRTmpSDWord, __WFRRUnflattenErr, __WFRRTmpBuffer, __WFRRTmpSDWord \
  mov _freemem, __WFRRTmpSDWord \
  __RRGetDeviceInfo_End##__I__: \
  __IncI__

#define __remotePollCommandLength(_conn, _bufnum, _length, _result) \
  __remoteGenericByteCommand(_conn, __SCPollCommandLenPacket, _bufnum, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRPollCommandLength_End##__I__, _result \
  brcmp NEQ, __RRPollCommandLength_End##__I__, __WFRRAvail, 3 \
  index _length, __WFRRBuffer, 1 \
  __RRPollCommandLength_End##__I__: \
  __IncI__

#define __remotePollCommand(_conn, _bufnum, _len, _data, _result) \
  mov _result, 1 \
  brcmp GT, __RRPollCommand_End##__I__, _len, 58 \
  __remoteDoPollCommand(_conn, _bufnum, _len, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  add __WFRRTmpByte, _len, 3 \
  brtst NEQ, __RRPollCommand_End##__I__, _result \
  brcmp NEQ, __RRPollCommand_End##__I__, __WFRRAvail, __WFRRTmpByte \
  index _len, __WFRRBuffer, 1 \
  arrsubset _data, __WFRRBuffer, 2, _len \
  __RRPollCommand_End##__I__: \
  __IncI__

#define __remoteIOMapRead(_conn, _id, _offset, _numbytes, _data, _result) \
  mov _result, 1 \
  brcmp GT, __RRIOMapRead_End##__I__, _numbytes, 58 \
  __remoteDoIOMapRead(_conn, _id, _offset, _numbytes, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  add __WFRRTmpByte, _numbytes, 7 \
  brtst NEQ, __RRIOMapRead_End##__I__, _result \
  brcmp NEQ, __RRIOMapRead_End##__I__, __WFRRAvail, __WFRRTmpByte \
  arrsubset __WFRRTmpBuffer, __WFRRBuffer, 4, 2 \
  arrtostr __WFRRUnflattenBuf, __WFRRTmpBuffer \
  unflatten __WFRRTmpSWord, __WFRRUnflattenErr, __WFRRUnflattenBuf, __WFRRTmpSWord \
  mov _numbytes, __WFRRTmpSWord \
  arrsubset _data, __WFRRBuffer, 6, _numbytes \
  __RRIOMapRead_End##__I__: \
  __IncI__

#define __remoteGetBluetoothAddress(_conn, _btaddr, _result) \
  __connectionSCDCWrite(_conn, __SCBTGetAddressPacket, _result) \
  call __DoWaitForRemoteResponse \
  mov _result, __WFRRStatus \
  brtst NEQ, __RRGetBluetoothAddress_End##__I__, _result \
  brcmp NEQ, __RRGetBluetoothAddress_End##__I__, __WFRRAvail, 8 \
  arrsubset _btaddr, __WFRRBuffer, NA, 7 \
  __RRGetBluetoothAddress_End##__I__: \
  __IncI__

#define __remoteRenameFile(_conn, _oldname, _newname, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __SCRenameFilePacket \
  strsubset __SRSTmpBuf, _oldname, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  strsubset __SRSTmpBuf, _newname, NA, 19 \
  replace __SRSSendBuf, __SRSSendBuf, 22, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#else

#define __remoteGetOutputState(_conn, _port, _result) __remoteGenericByteCommand(_conn, __DCGetOutputStatePacket, _port, _result)
#define __remoteGetInputValues(_conn, _port, _result) __remoteGenericByteCommand(_conn, __DCGetInputValuesPacket, _port, _result)
#define __remoteGetBatteryLevel(_conn, _result) __connectionSCDCWrite(_conn, __DCGetBatteryLevelPacket, _result)
#define __remoteLowspeedGetStatus(_conn, _result) __connectionSCDCWrite(_conn, __DCLSGetStatusPacket, _result)
#define __remoteLowspeedRead(_conn, _port, _result) __remoteGenericByteCommand(_conn, __DCLSReadPacket, _port, _result)
#define __remoteGetCurrentProgramName(_conn, _result) __connectionSCDCWrite(_conn, __DCGetCurProgNamePacket, _result)
#define __remoteDatalogRead(_conn, _remove, _result) __remoteGenericByteCommand(_conn, __DCDatalogReadPacket, _remove, _result)
#define __remoteGetContactCount(_conn, _result) __connectionSCDCWrite(_conn, __DCBTGetContactCntPacket, _result)
#define __remoteGetContactName(_conn, _idx, _result) __remoteGenericByteCommand(_conn, __DCBTGetContactNamePacket, _idx, _result)
#define __remoteGetConnectionCount(_conn, _result) __connectionSCDCWrite(_conn, __DCBTGetConnectCntPacket, _result)
#define __remoteGetConnectionName(_conn, _idx, _result) __remoteGenericByteCommand(_conn, __DCBTGetConnectNamePacket, _idx, _result)
#define __remoteGetProperty(_conn, _property, _result) __remoteGenericByteCommand(_conn, __DCGetPropertyPacket, _property, _result)


#define __remoteOpenRead(_conn, _filename, _result) __remoteGenericFilenameCommand(_conn, __SCOpenReadPacket, _filename, _result)
#define __remoteOpenWrite(_conn, _filename, _size, _result) __remoteGenericCreateFileCommand(_conn, __SCOpenWritePacket, _filename, _size, _result)
#define __remoteRead(_conn, _handle, _numbytes, _result) __remoteDoRead(_conn, _handle, _numbytes, _result)
#define __remoteWrite(_conn, _handle, _data, _result) __remoteDoWrite(_conn, _handle, _data, _result)
#define __remoteCloseFile(_conn, _handle, _result) __remoteGenericByteCommand(_conn, __SCClosePacket, _handle, _result)
#define __remoteDeleteFile(_conn, _filename, _result) __remoteGenericFilenameCommand(_conn, __SCDeletePacket, _filename, _result)
#define __remoteFindFirstFile(_conn, _mask, _result) __remoteGenericFilenameCommand(_conn, __SCFindFirstPacket, _mask, _result)
#define __remoteFindNextFile(_conn, _handle, _result) __remoteGenericByteCommand(_conn, __SCFindNextPacket, _handle, _result)
#define __remoteOpenWriteLinear(_conn, _filename, _size, _result) __remoteGenericCreateFileCommand(_conn, __SCOpenWriteLinearPacket, _filename, _size, _result)
#define __remoteOpenWriteData(_conn, _filename, _size, _result) __remoteGenericCreateFileCommand(_conn, __SCOpenWriteDataPacket, _filename, _size, _result)
#define __remoteOpenAppendData(_conn, _filename, _result) __remoteGenericFilenameCommand(_conn, __SCOpenAppendDataPacket, _filename, _result)
#define __remotePollCommandLength(_conn, _bufnum, _result) __remoteGenericByteCommand(_conn, __SCPollCommandLenPacket, _bufnum, _result)
#define __remotePollCommand(_conn, _bufnum, _len, _result) __remoteDoPollCommand(_conn, _bufnum, _len, _result)
#define __remoteIOMapRead(_conn, _id, _offset, _numbytes, _result) __remoteDoIOMapRead(_conn, _id, _offset, _numbytes, _result)

#endif

#define __remoteDatalogSetTimes(_conn, _synctime, _result) \
  acquire __RemoteMutex \
  mov __SRSTmpLongVal, _synctime \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  arrbuild __SRSSendBuf, __DCDatalogSetTimesPacket, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteSetProperty(_conn, _prop, _value, _result) \
  compchk EQ, sizeof(_prop), 1 \
  acquire __RemoteMutex \
  flatten __SRSFlattenBuf, _value \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  arrbuild __SRSSendBuf, __DCSetPropertyPacket, _prop, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteLowspeedWrite(_conn, _port, _txlen, _rxlen, _data, _result) \
  compchk EQ, sizeof(_port), 1 \
  compchk EQ, sizeof(_txlen), 1 \
  compchk EQ, sizeof(_rxlen), 1 \
  acquire __RemoteMutex \
  arrbuild __SRSSendBuf, __DCLSWritePacket, _port, _txlen, _rxlen, _data \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteIOMapWriteValue(_conn, _id, _offset, _value, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericIOMapPacket \
  replace __SRSSendBuf, __SRSSendBuf, NA, __SCIOMapWritePacket \
  mov __SRSTmpLongVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  mov __SRSTmpWordVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 6, __SRSTmpBuf \
  set __SRSTmpWordVal, sizeof(_value) \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 8, __SRSTmpBuf \
  flatten __SRSFlattenBuf, _value \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  mov __SRSFlattenBuf, __SRSSendBuf \
  arrbuild __SRSSendBuf, __SRSFlattenBuf, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteIOMapWriteBytes(_conn, _id, _offset, _data, _result) \
  compchk EQ, sizeof(_handle), 1 \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __GenericIOMapPacket \
  replace __SRSSendBuf, __SRSSendBuf, NA, __SCIOMapWritePacket \
  mov __SRSTmpLongVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpLongVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  mov __SRSTmpWordVal, _offset \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 6, __SRSTmpBuf \
  arrsize __SRSTmpWordVal, _data \
  flatten __SRSFlattenBuf, __SRSTmpWordVal \
  strtoarr __SRSTmpBuf, __SRSFlattenBuf \
  replace __SRSSendBuf, __SRSSendBuf, 8, __SRSTmpBuf \
  mov __SRSFlattenBuf, __SRSSendBuf \
  arrbuild __SRSSendBuf, __SRSFlattenBuf, _data \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#define __remoteSetBrickName(_conn, _name, _result) \
  acquire __RemoteMutex \
  mov __SRSSendBuf, __SCSetBrickNamePacket \
  strsubset __SRSTmpBuf, _name, NA, 15 \
  replace __SRSSendBuf, __SRSSendBuf, 2, __SRSTmpBuf \
  __connectionSCDCWrite(_conn, __SRSSendBuf, _result) \
  release __RemoteMutex

#if defined(__ENHANCED_FIRMWARE)

#define __SQRT(_X,_R) sqrt _R, _X
#define __SIN(_X,_R) sin _R, _X
#define __COS(_X,_R) cos _R, _X
#define __ASIN(_X,_R) asin _R, _X
#define __ACOS(_X,_R) acos _R, _X

#else

#if (__FIRMWARE_VERSION > 107)
#define __SQRT(_X,_R) sqrt _R, _X
#else
#define __SQRT(_X,_R) \
  acquire __sqrtMutex \
  mov __sqrtValue, _X \
  call __sqrtSub \
  mov _R, __sqrtResult \
  release __sqrtMutex
#endif

#define __SIN(_X,_R) \
  acquire __sinMutex \
  mov __sinValue, _X \
  call __sinSub \
  mov _R, __sinResult \
  release __sinMutex

#define __COS(_X,_R) \
  acquire __sinMutex \
  mov __sinValue, _X \
  add __sinValue, __sinValue, 90 \
  call __sinSub \
  mov _R, __sinResult \
  release __sinMutex

#define __ASIN(_X,_R) \
  acquire __asinMutex \
  mov __asinValue, _X \
  call __asinSub \
  mov _R, __asinResult \
  release __asinMutex

#define __ACOS(_X,_R) \
  acquire __asinMutex \
  mov __asinValue, _X \
  call __asinSub \
  sub _R, 90, __asinResult \
  release __asinMutex

#endif

// data segment
dseg segment

  // sin/cos related tables
  __sin_table sword[] 0,2,3,5,7,9,10,12,14,16,17,19,21,22,24,26,28,29,31,33,34,36,37,39,41,42,44,45,47,48,50,52,53,54,56,57,59,60,62,63,64,66,67,68,69,71,72,73,74,75,77,78,79,80,81,82,83,84,85,86,87,87,88,89,90,91,91,92,93,93,94,95,95,96,96,97,97,97,98,98,98,99,99,99,99,100,100,100,100,100,100
  __asin_table sdword[] 0,1,1,2,2,3,3,4,5,5,6,6,7,7,8,9,9,10,10,11,12,12,13,13,14,14,15,16,16,17,17,18,19,19,20,20,21,22,22,23,24,24,25,25,26,27,27,28,29,29,30,31,31,32,33,33,34,35,35,36,37,38,38,39,40,41,41,42,43,44,44,45,46,47,48,49,49,50,51,52,53,54,55,56,57,58,59,60,62,63,64,66,67,68,70,72,74,76,79,82,90

  // mutexes
  __sqrtMutex mutex
  __sinMutex mutex
  __asinMutex mutex

  // sqrt variables
  __sqrtPairs byte[]  0, 0, 0, 0, 0, 0
  __sqrtPaircount sbyte
  __sqrtValue dword
  __sqrtResult dword
  __sqrtP dword
  __sqrtR dword
  __sqrtM dword
  __sqrtN dword

  // sin variables
  __sinValue sdword
  __sinResult sdword
  __sinValueNeg byte

  // asin variables
  __asinValue sdword
  __asinResult sdword
dseg ends

subroutine __sinSub
  // move the sin to + angle
  set __sinValueNeg, FALSE
  brtst GTEQ, __sinValuePos, __sinValue

  neg __sinValue, __sinValue
  set __sinValueNeg, TRUE

__sinValuePos:
  // get the 360 mod and check which quarter the sin falls into
  mod __sinValue, __sinValue, 360
  brcmp GT, __sinQ4, __sinValue, 270
  brcmp GT, __sinQ3, __sinValue, 180
  brcmp GT, __sinQ2, __sinValue, 90

  // 1st quarter
  index __sinResult, __sin_table, __sinValue
  jmp __sinAlmostDone

__sinQ2:
  // 2nd quarter
  sub __sinValue, 180, __sinValue
  index __sinResult, __sin_table, __sinValue
  jmp __sinAlmostDone

__sinQ3:
  // 3rd quarter
  sub __sinValue, __sinValue, 180
  index __sinResult, __sin_table, __sinValue
  neg __sinResult, __sinResult
  jmp __sinAlmostDone

__sinQ4:
  // 4th quarter
  sub __sinValue, 360, __sinValue
  index __sinResult, __sin_table, __sinValue
  neg __sinResult, __sinResult
  jmp __sinAlmostDone

__sinAlmostDone:

  // if the incoming angle was <0, need to negate the result because sin(-x)=-sin(x)
  brcmp EQ, __sinDone, __sinValueNeg, FALSE
  neg __sinResult, __sinResult

__sinDone:
  return
ends


subroutine __asinSub
  // input sin value should be -1 -> 1
  brcmp GT, __asinValueBad, __asinValue, 100
  brcmp LT, __asinValueBad, __asinValue, -100

  // check if it's 0->-1
  brtst LT, __asinValueNeg, __asinValue

  // value 0->1
  index __asinResult, __asin_table, __asinValue
  jmp __asinDone

__asinValueNeg:
  // value 0->-1
  neg __asinValue, __asinValue
  index __asinResult, __asin_table, __asinValue
  neg __asinResult, __asinResult
  jmp __asinDone

__asinValueBad:
  set __asinResult, 101

__asinDone:
  return
ends

subroutine __sqrtSub
  // if the input value is 0, we're done
  set __sqrtResult, 0
  brtst EQ, __sqrtDone, __sqrtValue

  // init the paircount array
  mov __sqrtPaircount, 0
  replace __sqrtPairs, __sqrtPairs, 0, 0
  replace __sqrtPairs, __sqrtPairs, 1, 0
  replace __sqrtPairs, __sqrtPairs, 2, 0
  replace __sqrtPairs, __sqrtPairs, 3, 0
  replace __sqrtPairs, __sqrtPairs, 4, 0

__sqrtPairsLoop:
  brtst EQ, __sqrtPairsOK, __sqrtValue
  mod __sqrtN, __sqrtValue, 100
  replace __sqrtPairs, __sqrtPairs, __sqrtPaircount, __sqrtN
  div __sqrtValue, __sqrtValue, 100
  add __sqrtPaircount, __sqrtPaircount, 1

  jmp __sqrtPairsLoop

__sqrtPairsOK:
  // get the leftmost pair
  index __sqrtP, __sqrtPairs, __sqrtPaircount
  set __sqrtResult, 1

  // find the sqrt for the leftmost pair (1-9), if 0 we're not here!
__sqrtFirstLoop:
  mul __sqrtN, __sqrtResult, __sqrtResult
  brcmp GT, __sqrtFirstOK, __sqrtN, __sqrtP
  add __sqrtResult, __sqrtResult, 1
  jmp __sqrtFirstLoop

__sqrtFirstOK:
  sub __sqrtResult, __sqrtResult, 1
  // got the sqrt of the first pair in sqrtResult

  mul __sqrtN, __sqrtResult, __sqrtResult
  sub __sqrtM, __sqrtP, __sqrtN

  // in loop we get 1 new digit in sqrtResult for each pair
__sqrtBigLoop:
  sub __sqrtPaircount, __sqrtPaircount, 1

  brtst LT, __sqrtDone, __sqrtPaircount

  mul __sqrtM, __sqrtM, 100
  index __sqrtP, __sqrtPairs, __sqrtPaircount
  add __sqrtM, __sqrtM, __sqrtP

  // find the next digit
  set __sqrtN, 1

__sqrtDigitLoop:
  mul __sqrtR, __sqrtResult, 20
  add __sqrtR, __sqrtR, __sqrtN
  mul __sqrtR, __sqrtR, __sqrtN

  brcmp GT, __sqrtDigitDone, __sqrtR, __sqrtM

  add __sqrtN, __sqrtN, 1
  jmp __sqrtDigitLoop

__sqrtDigitDone:
  sub __sqrtN, __sqrtN, 1
  // got the next digit

  // calculate the new value to continue with
  mul __sqrtR, __sqrtResult, 20
  add __sqrtR, __sqrtR, __sqrtN
  mul __sqrtR, __sqrtR, __sqrtN
  sub __sqrtM, __sqrtM, __sqrtR

  // add the new digit to the end of the result in sqrtResult
  mul __sqrtResult, __sqrtResult, 10
  add __sqrtResult, __sqrtResult, __sqrtN

  jmp __sqrtBigLoop

__sqrtDone:
  return
ends

dseg segment
  __bcd2DecTens byte
  __bcd2DecOnes byte
  __bcd2DecMutex mutex
dseg ends

#define __bcd2dec(_bcd, _result) \
  acquire __bcd2DecMutex \
  div __bcd2DecTens, _bcd, 16 \
  mod __bcd2DecOnes, _bcd, 16 \
  mul _result, __bcd2DecTens, 10 \
  add _result, _result, __bcd2DecOnes \
  release __bcd2DecMutex

#define __SetSensorHTEOPD(_port, _bStd) \
  setin IN_TYPE_LIGHT_ACTIVE+_bStd, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __ReadSensorHTEOPD(_port, _val) \
  getin _val, _port, RawValueField \
  sub _val, 1023, _val

#define __SetSensorHTGyro(_port) \
  setin IN_TYPE_LIGHT_INACTIVE, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __ReadSensorHTGyro(_port, _offset, _val) \
  getin _val, _port, RawValueField \
  sub _val, _val, 600 \
  sub _val, _val, _offset

#define __ReadSensorHTMagnet(_port, _offset, _val) __ReadSensorHTGyro(_port, _offset, _val)
#define __SetSensorHTMagnet(_port) __SetSensorHTGyro(_port)

dseg segment
  __HTMplexRaw word
  __HTMplexScaled dword
  __HTMplexMutex mutex
dseg ends

#define __ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) \
  acquire __HTMplexMutex \
  getin __HTMplexRaw, _p, RawValueField \
  mul __HTMplexScaled, __HTMplexRaw, 339 \
  sub __HTMplexScaled, 346797, __HTMplexScaled \
  div __HTMplexScaled, __HTMplexScaled, __HTMplexRaw \
  add __HTMplexScaled, __HTMplexScaled, 5 \
  div __HTMplexScaled, __HTMplexScaled, 10 \
  and _t4, __HTMplexScaled, 8 \
  and _t3, __HTMplexScaled, 4 \
  and _t2, __HTMplexScaled, 2 \
  and _t1, __HTMplexScaled, 1 \
  release __HTMplexMutex

dseg segment
  __HTPFStartIRLink  byte[] 0x02, 0x42
  __HTPFCommitIRLink byte[] 0x0B, 0x02, 0x01
  __HTPFBits byte[]
  __HTPFI2CBuf byte[]
  __HTPFI sword
  __HTPFJ sword
  __HTPFValue byte
  __HTPFDx byte
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
  call __PFApplyToggle
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  replace __PFNibbles, __PFNibbles, 1, PF_MODE_COMBO_DIRECT
  mul __PF_p3, __PF_p3, 4
  add __PF_p3, __PF_p3, __PF_p2
  replace __PFNibbles, __PFNibbles, 2, __PF_p3
  call __PFUpdateToggle
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
  call __PFApplyToggle
  add __PF_p1, __PF_p1, PF_MODE_COMBO_PWM
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  replace __PFNibbles, __PFNibbles, 1, __PF_p3
  replace __PFNibbles, __PFNibbles, 2, __PF_p2
  call __PFUpdateToggle
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
  call __PFApplyToggle
  replace __PFNibbles, __PFNibbles, NA, __PF_p1
  replace __PFNibbles, __PFNibbles, 1, __PF_p2
  replace __PFNibbles, __PFNibbles, 2, __PF_p3
  call __PFUpdateToggle
  return
ends

subroutine __HTPowerFunctionCalcBits
  call __PFCalcChecksum
  brtst EQ, __HTPFUseIRTrainMode, __PFPowerFuncMode
  set __HTPFDx, 3
  jmp __HTPFEndPowerFuncModeCheck
__HTPFUseIRTrainMode:
  set __HTPFDx, 2
__HTPFEndPowerFuncModeCheck:
  arrinit __HTPFBits, 0, 88
  arrinit __PFBytes, 0, 11
  // fill in the bits
  set __PFIdx, 0
  replace __HTPFBits, __HTPFBits, __PFIdx, 1
  add __PFIdx, __PFIdx, 8
  // check bits in n0..n3
  set __HTPFI, 0
__lblCalcBitsForIBitSet:
  index __PFNx, __PFNibbles, __HTPFI
  set __HTPFJ, 3
__lblCalcBitsForJBitSet:
  replace __HTPFBits, __HTPFBits, __PFIdx, 1
  shl __PFTmp, 1, __HTPFJ
  and __HTPFValue, __PFNx, __PFTmp
  add __PFIdx, __PFIdx, __HTPFDx
  brcmp NEQ, __lblCalcBitsFoundZero, __HTPFValue, __PFTmp
  add __PFIdx, __PFIdx, 2
__lblCalcBitsFoundZero:
  sub __HTPFJ, __HTPFJ, 1
  brtst GTEQ, __lblCalcBitsForJBitSet, __HTPFJ
  add __HTPFI, __HTPFI, 1
  brcmp LTEQ, __lblCalcBitsForIBitSet, __HTPFI, 3
  replace __HTPFBits, __HTPFBits, __PFIdx, 1
  // now calculate bytes
  set __HTPFI, 0
__lblCalcBitsWhileIByteCalc:
  set __HTPFValue, 0
  set __HTPFJ, 0
__lblCalcBitsForJByteCalc:
  index __PFTmp, __HTPFBits, __HTPFI
  add __HTPFValue, __HTPFValue, __PFTmp
  brcmp GTEQ, __lblCalcBitsByteCalcLastBit, __HTPFJ, 7
  mul __HTPFValue, __HTPFValue, 2
__lblCalcBitsByteCalcLastBit:
  add __HTPFI, __HTPFI, 1
  add __HTPFJ, __HTPFJ, 1
  brcmp LTEQ, __lblCalcBitsForJByteCalc, __HTPFJ, 7
  div __PFIdx, __HTPFI, 8
  sub __PFIdx, __PFIdx, 1
  replace __PFBytes, __PFBytes, __PFIdx, __HTPFValue
  brcmp LT, __lblCalcBitsWhileIByteCalc, __HTPFI, 88
  // set IRLink mode to either PF or IRTrain
  sub __HTPFDx, __HTPFDx, 1
  replace __HTPFCommitIRLink, __HTPFCommitIRLink, 1, __HTPFDx
  // build i2c buffer
  arrbuild __HTPFI2CBuf, __HTPFStartIRLink, __PFBytes, __HTPFCommitIRLink
  return
ends

#define __HTPFComboDirect(_port, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 4 \
  mod __PF_p3, _outb, 4 \
  call __PFComboDirectSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  mov __CLSWArgs0.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  mov __CLSWArgs0.Port, _port \
  mov __CLSWArgs0.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs0 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  mov __CLSWArgs##_port.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  set __CLSWArgs##_port.Port, _port \
  mov __CLSWArgs##_port.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs##_port \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  compend

#define __HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _pin, 2 \
  mod __PF_p4, _func, 4 \
  set __PF_p5, _cont \
  call __PFSinglePinSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  mov __CLSWArgs0.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  mov __CLSWArgs0.Port, _port \
  mov __CLSWArgs0.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs0 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  mov __CLSWArgs##_port.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  set __CLSWArgs##_port.Port, _port \
  mov __CLSWArgs##_port.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs##_port \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  compend

#define __HTPFSingleOutput(_port, _channel, _out, _func, _cst, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _func, 16 \
  set __PF_p4, _cst \
  call __PFSingleOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  mov __CLSWArgs0.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  mov __CLSWArgs0.Port, _port \
  mov __CLSWArgs0.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs0 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  mov __CLSWArgs##_port.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  set __CLSWArgs##_port.Port, _port \
  mov __CLSWArgs##_port.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs##_port \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  compend

#define __HTPFComboPWM(_port, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 16 \
  mod __PF_p3, _outb, 16 \
  call __PFComboPWMSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  mov __CLSWArgs0.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  mov __CLSWArgs0.Port, _port \
  mov __CLSWArgs0.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs0 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  mov __CLSWArgs##_port.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  set __CLSWArgs##_port.Port, _port \
  mov __CLSWArgs##_port.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs##_port \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  compend

#define __HTIRTrain(_port, _channel, _func, _PFMode, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _func, 5 \
  compif EQ, _PFMode, TRUE \
  call __PFTrainSub \
  compelse \
  call __RCTrainSub \
  compend \
  set __PFPowerFuncMode, _PFMode \
  call __HTPowerFunctionCalcBits \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  mov __CLSWArgs0.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  mov __CLSWArgs0.Port, _port \
  mov __CLSWArgs0.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs0 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  mov __CLSWArgs##_port.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  set __CLSWArgs##_port.Port, _port \
  mov __CLSWArgs##_port.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs##_port \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  compend

#define __HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, _result) \
  acquire __PFMutex \
  mod __PF_p1, _nibble0, 7 \
  mod __PF_p2, _nibble1, 16 \
  mod __PF_p3, _nibble2, 16 \
  call __PFRawOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __HTPowerFunctionCalcBits \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  mov __CLSWArgs0.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  mov __CLSWArgs0.Port, _port \
  mov __CLSWArgs0.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs0 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  mov __CLSWArgs##_port.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  set __CLSWArgs##_port.Port, _port \
  mov __CLSWArgs##_port.ReturnLen, 0 \
  syscall CommLSWrite, __CLSWArgs##_port \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  compend

#define __HTPFRepeatLastCommand(_port, _count, _delay, _result) \
  acquire __PFMutex \
  mov __PF_p1, _count \
  compif EQ, isconst(_port), FALSE \
  acquire __CLSWMutex0 \
  acquire __CLSWMutex1 \
  acquire __CLSWMutex2 \
  acquire __CLSWMutex3 \
  mov __CLSWArgs0.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  mov __CLSWArgs0.Port, _port \
  mov __CLSWArgs0.ReturnLen, 0 \
  __HTPFRepeatLoop##__I__: \
  syscall CommLSWrite, __CLSWArgs0 \
  waitv _delay \
  sub __PF_p1, __PF_p1, 1 \
  brtst GT, __HTPFRepeatLoop##__I__, __PF_p1 \
  mov _result, __CLSWArgs0.Result \
  release __CLSWMutex0 \
  release __CLSWMutex1 \
  release __CLSWMutex2 \
  release __CLSWMutex3 \
  __IncI__ \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __CLSWMutex##_port \
  mov __CLSWArgs##_port.Buffer, __HTPFI2CBuf \
  release __PFMutex \
  set __CLSWArgs##_port.Port, _port \
  mov __CLSWArgs##_port.ReturnLen, 0 \
  __HTPFRepeatLoop##__I__: \
  syscall CommLSWrite, __CLSWArgs##_port \
  waitv _delay \
  sub __PF_p1, __PF_p1, 1 \
  brtst GT, __HTPFRepeatLoop##__I__, __PF_p1 \
  mov _result, __CLSWArgs##_port.Result \
  release __CLSWMutex##_port \
  __IncI__ \
  compend

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

subroutine __HTRCXCommandSub
  dseg segment
    __RCSToggle byte
    __RCSI byte
    __RCSInCmd byte[]
    __RCSCmdBytes sbyte
    __RCSCmd byte
    __RCSCSum byte
    __RCSMsgBufSize byte
    __RCSTotalBytes byte
    __RCSTmpByte byte
    __RCSTmpByte2 byte
    __RCSResult byte
    __RCSHeaderMsg byte[] 0x02, 0x4a, 0x55, 0xff, 0x00, 0x03, 0x00, 0x01
  dseg ends
  arrsize __RCSCmdBytes, __gRCXCmd.Command
  index __RCSCmd, __gRCXCmd.Command, NA
  set __RCSCSum, 0

  replace __RCSHeaderMsg, __RCSHeaderMsg, NA, __gRCXCmd.Address
  // send the IR message
  __lowspeedWrite(__gRCXCmd.Port, 0, __RCSHeaderMsg, __RCSTmpByte)
  wait 12

  // build rest of the message
  set __RCSMsgBufSize, 2
  mul __RCSMsgBufSize, __RCSMsgBufSize, __RCSCmdBytes
  add __RCSMsgBufSize, __RCSMsgBufSize, 7
  add __RCSTotalBytes, __RCSMsgBufSize, __gRCXCmd.ResponseBytes

  arrinit __RCSInCmd, 0, __RCSMsgBufSize
  replace __RCSInCmd, __RCSInCmd, NA, __gRCXCmd.Address
  set __RCSTmpByte, 2
  mul __RCSTmpByte, __RCSTmpByte, __RCSCmdBytes
  sub __RCSTmpByte, 0x4b, __RCSTmpByte
  replace __RCSInCmd, __RCSInCmd, 1, __RCSTmpByte

  // put cmd and ~cmd into msg
  or __RCSTmpByte, __RCSCmd, __RCSToggle
  replace __RCSInCmd, __RCSInCmd, 2, __RCSTmpByte
  mov __RCSCSum, __RCSTmpByte
  sub __RCSTmpByte, 0xFF, __RCSTmpByte
  replace __RCSInCmd, __RCSInCmd, 3, __RCSTmpByte

  set __RCSI, 0
  xor __RCSToggle, __RCSToggle, 8

  brcmp LTEQ, __RCSEndWhileILTCmdBytes, __RCSCmdBytes, 1

__RCSWhileILTCmdBytes:
  sub __RCSTmpByte, __RCSCmdBytes, 1
  brcmp GTEQ, __RCSEndWhileILTCmdBytes, __RCSI, __RCSTmpByte
  add __RCSTmpByte, __RCSI, 1
  index __RCSTmpByte2, __gRCXCmd.Command, __RCSTmpByte
  mul __RCSTmpByte, __RCSI, 2
  add __RCSTmpByte, __RCSTmpByte, 4
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSTmpByte2
  add __RCSCSum, __RCSCSum, __RCSTmpByte2
  add __RCSTmpByte, __RCSTmpByte, 1
  sub __RCSTmpByte2, 0xFF, __RCSTmpByte2
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSTmpByte2
  add __RCSI, __RCSI, 1
  jmp __RCSWhileILTCmdBytes
__RCSEndWhileILTCmdBytes:

  mul __RCSTmpByte, __RCSI, 2
  add __RCSTmpByte, __RCSTmpByte, 4
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSCSum
  sub __RCSTmpByte2, 0xFF, __RCSCSum
  add __RCSTmpByte, __RCSTmpByte, 1
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSTmpByte2
  // fill in the last three bytes
  add __RCSTmpByte, __RCSTmpByte, 1
  mul __RCSTmpByte2, __RCSCmdBytes, 2
  add __RCSTmpByte2, __RCSTmpByte2, 2
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, __RCSTmpByte2
  add __RCSTmpByte, __RCSTmpByte, 1
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, 0x00
  add __RCSTmpByte, __RCSTmpByte, 1
  replace __RCSInCmd, __RCSInCmd, __RCSTmpByte, 0x01

  // send the IR message
  __lowspeedWrite(__gRCXCmd.Port, 0, __RCSInCmd, __RCSTmpByte)

  // give the message time to be transferred
  mul __RCSTmpByte, __RCSTotalBytes, 5
  add __RCSTmpByte, __RCSTmpByte, 10
  waitv __RCSTmpByte

  // do we need to read a response?
  brtst EQ, __RCSNoResponse, __gRCXCmd.ResponseBytes

  arrbuild __RCSInCmd, __gRCXCmd.Address, 0x51
  mov __RCSTmpByte, __gRCXCmd.ResponseBytes
  __ReadI2CBytes(__gRCXCmd.Port, __RCSInCmd, __RCSTmpByte, __gRCXCmd.Response, __RCSResult)
__RCSNoResponse:
  return
ends

#define __HTRCXSetIRLinkPort(_port) \
  set __gRCXCmd.Port, _port \
  set __gRCXCmd.Address, 0x02

#define __HTRCXPoll(_src, _value, _result) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PollOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 12 \
  call __HTRCXCommandSub \
  index _result, __gRCXCmd.Response, 7 \
  index __RCSTmpByte, __gRCXCmd.Response, 5 \
  mul _result, _result, 256 \
  add _result, _result, __RCSTmpByte \
  release __RCXCmdMutex

#define __HTRCXBatteryLevel(_result) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_BatteryLevelOp \
  set __gRCXCmd.ResponseBytes, 12 \
  call __HTRCXCommandSub \
  index _result, __gRCXCmd.Response, 7 \
  index __RCSTmpByte, __gRCXCmd.Response, 5 \
  mul _result, _result, 256 \
  add _result, _result, __RCSTmpByte \
  release __RCXCmdMutex

#define __HTRCXOpNoArgs(_op) \
  acquire __RCXCmdMutex \
  arrinit __gRCXCmd.Command, _op, 1 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetOutput(_outputs, _mode) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _mode \
  arrbuild __gRCXCmd.Command, RCX_OnOffFloatOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetDirection(_outputs, _dir) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _dir \
  arrbuild __gRCXCmd.Command, RCX_OutputDirOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetPower(_outputs, _pwrsrc, _pwrval) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_OutputPowerOp, _outputs, _pwrsrc, _pwrval \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXOnFwd(_outputs) \
  __HTRCXSetDirection(_outputs, RCX_OUT_FWD) \
  __HTRCXSetOutput(_outputs, RCX_OUT_ON)

#define __HTRCXOnRev(_outputs) \
  __HTRCXSetDirection(_outputs, RCX_OUT_REV) \
  __HTRCXSetOutput(_outputs, RCX_OUT_ON)

#define __HTRCXOnFor(_outputs, _ms) \
  __HTRCXSetOutput(_outputs, RCX_OUT_ON) \
  waitv _ms \
  __HTRCXSetOutput(_outputs, RCX_OUT_OFF)

#define __HTRCXSetTxPower(_pwr) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_IRModeOp, _pwr \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXPlaySound(_snd) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PlaySoundOp, _snd \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXDeleteTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DeleteTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXStartTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_StartTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXStopTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_StopTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSelectProgram(_prog) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SelectProgramOp, _prog \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXClearTimer(_timer) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearTimerOp, _timer \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetSleepTime(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_AutoOffOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXDeleteSub(_s) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DeleteSubOp, _s \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXClearSensor(_port) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearSensorOp, _port \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXPlayToneVar(_varnum, _duration) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PlayToneVarOp, _varnum, _duration \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetWatch(_hours, _minutes) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetWatchOp, _hours, _minutes \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetSensorType(_port, _type) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_InputTypeOp, _port, _type \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetSensorMode(_port, _mode) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_InputModeOp, _port, _mode \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXCreateDatalog(_size) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _size, 0xFF \
  div __RCSTmpByte2, _size, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetDatalogOp, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXAddToDatalog(_src, _value) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DatalogOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSendSerial(_first, _count) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SendUARTDataOp, _first, _count \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXRemote(_cmd) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _cmd, 0xFF \
  div __RCSTmpByte2, _cmd, 256 \
  arrbuild __gRCXCmd.Command, RCX_RemoteOp, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXEvent(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_DirectEventOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXPlayTone(_freq, _duration) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _freq, 0xFF \
  div __RCSTmpByte2, _freq, 256 \
  arrbuild __gRCXCmd.Command, RCX_PlayToneOp, __RCSTmpByte, __RCSTmpByte2, _duration \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSelectDisplay(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_DisplayOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXPollMemory(_memaddress, _result) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _memaddress, 0xFF \
  div __RCSTmpByte2, _memaddress, 256 \
  arrbuild __gRCXCmd.Command, RCX_PollMemoryOp, __RCSTmpByte, __RCSTmpByte2, 1 \
  set __gRCXCmd.ResponseBytes, 16 \
  call __HTRCXCommandSub \
  index _result, __gRCXCmd.Response, 7 \
  index __RCSTmpByte, __gRCXCmd.Response, 5 \
  mul _result, _result, 256 \
  add _result, _result, __RCSTmpByte \
  release __RCXCmdMutex

#define __HTRCXSetEvent(_evt, _src, _type) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetEventOp, _evt, _src, _type \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetGlobalOutput(_outputs, _mode) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _mode \
  arrbuild __gRCXCmd.Command, RCX_GOutputModeOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetGlobalDirection(_outputs, _dir) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _dir \
  arrbuild __gRCXCmd.Command, RCX_GOutputDirOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_GOutputPowerOp, _outputs, _pwrsrc, _pwrval \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXIncCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_IncCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXDecCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DecCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXClearCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetPriority(_p) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetPriorityOp, _p \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTRCXSetMessage(_msg) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_MessageOp, _msg \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetScoutMode(_mode) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ScoutOp, _mode \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSendVLL(_src, _value) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_VLLOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetSensorClickTime(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSBlinkTimeOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetSensorHysteresis(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSHysteresisOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetSensorLowerLimit(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSLowerThreshOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetSensorUpperLimit(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSUpperThreshOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetEventFeedback(_src, _value) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _value, 0xFF \
  div __RCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetFeedbackOp, _src, __RCSTmpByte, __RCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutMuteSound() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, 0x80 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutUnmuteSound() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, 0xc0 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSelectSounds(_grp) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, _grp \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __HTScoutSetLight(_x) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_LightOp, _x \
  set __gRCXCmd.ResponseBytes, 0 \
  call __HTRCXCommandSub \
  release __RCXCmdMutex

#define __ReadSensorHTCompass(_port, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 2 \
  call __ReadLSBytesVar \
  index _value, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  add _value, _value, _value \
  add _value, _value, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 2 \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  add _value, _value, _value \
  add _value, _value, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTAccel(_port, _x, _y, _z, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _x, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  brcmp LTEQ, __RSHTAX##__I__, _x, 127 \
  sub _x, _x, 256 \
  __RSHTAX##__I__: \
  __IncI__ \
  mul _x, _x, 4 \
  add _x, _x, __RLSBytesCountVar \
  index _y, __RLSReadBufVar, 1 \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  brcmp LTEQ, __RSHTAY##__I__, _y, 127 \
  sub _y, _y, 256 \
  __RSHTAY##__I__: \
  __IncI__ \
  mul _y, _y, 4 \
  add _y, _y, __RLSBytesCountVar \
  index _z, __RLSReadBufVar, 2 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  brcmp LTEQ, __RSHTAZ##__I__, _z, 127 \
  sub _z, _z, 256 \
  __RSHTAZ##__I__: \
  __IncI__ \
  mul _z, _z, 4 \
  add _z, _z, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _x, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  brcmp LTEQ, __RSHTAX##__I__, _x, 127 \
  sub _x, _x, 256 \
  __RSHTAX##__I__: \
  __IncI__ \
  mul _x, _x, 4 \
  add _x, _x, __RLSBytesCount##_port \
  index _y, __RLSReadBuf##_port, 1 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  brcmp LTEQ, __RSHTAY##__I__, _y, 127 \
  sub _y, _y, 256 \
  __RSHTAY##__I__: \
  __IncI__ \
  mul _y, _y, 4 \
  add _y, _y, __RLSBytesCount##_port \
  index _z, __RLSReadBuf##_port, 2 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  brcmp LTEQ, __RSHTAZ##__I__, _z, 127 \
  sub _z, _z, 256 \
  __RSHTAZ##__I__: \
  __IncI__ \
  mul _z, _z, 4 \
  add _z, _z, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

dseg segment
  __RSHTColorRawBuf byte[] 0x02, 0x46
  __RSHTColorNormBuf byte[] 0x02, 0x4C
  __RSHTColor2NormBuf byte[] 0x02, 0x47
dseg ends

#define __ReadSensorHTRawColor(_port, _Red, _Green, _Blue, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSHTColorRawBuf \
  set __RLSBytesCountVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _Red, __RLSReadBufVar, 1 \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  mul _Red, _Red, 256 \
  add _Red, _Red, __RLSBytesCountVar \
  index _Green, __RLSReadBufVar, 3 \
  index __RLSBytesCountVar, __RLSReadBufVar, 2 \
  mul _Green, _Green, 256 \
  add _Green, _Green, __RLSBytesCountVar \
  index _Blue, __RLSReadBufVar, 5 \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  mul _Blue, _Blue, 256 \
  add _Blue, _Blue, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSHTColorRawBuf \
  set __RLSBytesCount##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _Red, __RLSReadBuf##_port, 1 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  mul _Red, _Red, 256 \
  add _Red, _Red, __RLSBytesCount##_port \
  index _Green, __RLSReadBuf##_port, 3 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 2 \
  mul _Green, _Green, 256 \
  add _Green, _Green, __RLSBytesCount##_port \
  index _Blue, __RLSReadBuf##_port, 5 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  mul _Blue, _Blue, 256 \
  add _Blue, _Blue, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 4 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _ColorNum, __RLSReadBufVar, NA \
  index _Red, __RLSReadBufVar, 1 \
  index _Green, __RLSReadBufVar, 2 \
  index _Blue, __RLSReadBufVar, 3 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 4 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _ColorNum, __RLSReadBuf##_port, NA \
  index _Red, __RLSReadBuf##_port, 1 \
  index _Green, __RLSReadBuf##_port, 2 \
  index _Blue, __RLSReadBuf##_port, 3 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSHTColorNormBuf \
  set __RLSBytesCountVar, 4 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _ColorIdx, __RLSReadBufVar, NA \
  index _Red, __RLSReadBufVar, 1 \
  index _Green, __RLSReadBufVar, 2 \
  index _Blue, __RLSReadBufVar, 3 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSHTColorNormBuf \
  set __RLSBytesCount##_port, 4 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _ColorIdx, __RLSReadBuf##_port, NA \
  index _Red, __RLSReadBuf##_port, 1 \
  index _Green, __RLSReadBuf##_port, 2 \
  index _Blue, __RLSReadBuf##_port, 3 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 5 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _ColorNum, __RLSReadBufVar, NA \
  index _Red, __RLSReadBufVar, 1 \
  index _Green, __RLSReadBufVar, 2 \
  index _Blue, __RLSReadBufVar, 3 \
  index _White, __RLSReadBufVar, 4 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 5 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _ColorNum, __RLSReadBuf##_port, NA \
  index _Red, __RLSReadBuf##_port, 1 \
  index _Green, __RLSReadBuf##_port, 2 \
  index _Blue, __RLSReadBuf##_port, 3 \
  index _White, __RLSReadBuf##_port, 4 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RSHTColor2NormBuf \
  set __RLSBytesCountVar, 4 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _ColorIdx, __RLSReadBufVar, NA \
  index _Red, __RLSReadBufVar, 1 \
  index _Green, __RLSReadBufVar, 2 \
  index _Blue, __RLSReadBufVar, 3 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RSHTColor2NormBuf \
  set __RLSBytesCount##_port, 5 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _ColorIdx, __RLSReadBuf##_port, NA \
  index _Red, __RLSReadBuf##_port, 1 \
  index _Green, __RLSReadBuf##_port, 2 \
  index _Blue, __RLSReadBuf##_port, 3 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 8 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _Red, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul _Red, _Red, 256 \
  add _Red, _Red, __RLSBytesCountVar \
  index _Green, __RLSReadBufVar, 2 \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  mul _Green, _Green, 256 \
  add _Green, _Green, __RLSBytesCountVar \
  index _Blue, __RLSReadBufVar, 4 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  mul _Blue, _Blue, 256 \
  add _Blue, _Blue, __RLSBytesCountVar \
  index _White, __RLSReadBufVar, 6 \
  index __RLSBytesCountVar, __RLSReadBufVar, 7 \
  mul _White, _White, 256 \
  add _White, _White, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 8 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _Red, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul _Red, _Red, 256 \
  add _Red, _Red, __RLSBytesCount##_port \
  index _Green, __RLSReadBuf##_port, 2 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  mul _Green, _Green, 256 \
  add _Green, _Green, __RLSBytesCount##_port \
  index _Blue, __RLSReadBuf##_port, 4 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  mul _Blue, _Blue, 256 \
  add _Blue, _Blue, __RLSBytesCount##_port \
  index _White, __RLSReadBuf##_port, 6 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 7 \
  mul _White, _White, 256 \
  add _White, _White, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _dir, __RLSReadBufVar, NA \
  index _s1, __RLSReadBufVar, 1 \
  index _s3, __RLSReadBufVar, 2 \
  index _s5, __RLSReadBufVar, 3 \
  index _s7, __RLSReadBufVar, 4 \
  index _s9, __RLSReadBufVar, 5 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _dir, __RLSReadBuf##_port, NA \
  index _s1, __RLSReadBuf##_port, 1 \
  index _s3, __RLSReadBuf##_port, 2 \
  index _s5, __RLSReadBuf##_port, 3 \
  index _s7, __RLSReadBuf##_port, 4 \
  index _s9, __RLSReadBuf##_port, 5 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, 0x10, 0x42 \
  set __RLSBytesCountVar, 7 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _dir, __RLSReadBufVar, NA \
  index _s1, __RLSReadBufVar, 1 \
  index _s3, __RLSReadBufVar, 2 \
  index _s5, __RLSReadBufVar, 3 \
  index _s7, __RLSReadBufVar, 4 \
  index _s9, __RLSReadBufVar, 5 \
  index _avg, __RLSReadBufVar, 6 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, 0x10, 0x42 \
  set __RLSBytesCount##_port, 7 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _dir, __RLSReadBuf##_port, NA \
  index _s1, __RLSReadBuf##_port, 1 \
  index _s3, __RLSReadBuf##_port, 2 \
  index _s5, __RLSReadBuf##_port, 3 \
  index _s7, __RLSReadBuf##_port, 4 \
  index _s9, __RLSReadBuf##_port, 5 \
  index _avg, __RLSReadBuf##_port, 6 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, 0x10, 0x49 \
  set __RLSBytesCountVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _dir, __RLSReadBufVar, NA \
  index _s1, __RLSReadBufVar, 1 \
  index _s3, __RLSReadBufVar, 2 \
  index _s5, __RLSReadBufVar, 3 \
  index _s7, __RLSReadBufVar, 4 \
  index _s9, __RLSReadBufVar, 5 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, 0x10, 0x49 \
  set __RLSBytesCount##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _dir, __RLSReadBuf##_port, NA \
  index _s1, __RLSReadBuf##_port, 1 \
  index _s3, __RLSReadBuf##_port, 2 \
  index _s5, __RLSReadBuf##_port, 3 \
  index _s7, __RLSReadBuf##_port, 4 \
  index _s9, __RLSReadBuf##_port, 5 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeeker2Addr(_port, _reg, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, 0x10, _reg \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  index _value, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, 0x10, _reg \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __SetHTIRSeeker2Mode(_port, _mode, _result) __I2CSendCmd(_port, 0x10, _mode, _result)

#define __ReadSensorHTIRReceiver(_port, _pfdata, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 8 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  mov _pfdata, __RLSReadBufVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 8 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov _pfdata, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  add __RLSBytesCountVar, 0x42, _reg \
  arrbuild __RLSReadBufVar, 0x02, __RLSBytesCountVar \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _pfchar, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  add __RLSBytesCount##_port, 0x42, _reg \
  arrbuild __RLSReadBuf##_port, 0x02, __RLSBytesCount##_port \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _pfchar, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __SetHTColor2Mode(_port, _mode, _result) __I2CSendCmd(_port, 0x02, _mode, _result)

#define __ReadSensorHTColorNum(_port, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  index _value, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorHTIRSeekerDir(_port, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  index _value, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __ResetSensorHTAngle(_port, _mode, _result) \
  compchk EQ, isconst(_mode), TRUE \
  __I2CSendCmd(_port, 0x02, _mode, _result) \
  compif EQ, _mode, HTANGLE_MODE_CALIBRATE \
  wait 30 \
  compend

#define __ReadSensorHTAngle(_port, _Angle, _AccAngle, _RPM, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufLSWrite1 \
  set __RLSBytesCountVar, 8 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _Angle, __RLSReadBufVar, NA \
  add _Angle, _Angle, _Angle \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  add _Angle, _Angle, __RLSBytesCountVar \
  index _AccAngle, __RLSReadBufVar, 2 \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  add _AccAngle, _AccAngle, __RLSBytesCountVar \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCountVar, __RLSReadBufVar, 4 \
  add _AccAngle, _AccAngle, __RLSBytesCountVar \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  add _AccAngle, _AccAngle, __RLSBytesCountVar \
  index _RPM, __RLSReadBufVar, 6 \
  mul _RPM, _RPM, 256 \
  index __RLSBytesCountVar, __RLSReadBufVar, 7 \
  add _RPM, _RPM, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufLSWrite1 \
  set __RLSBytesCount##_port, 8 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _Angle, __RLSReadBuf##_port, NA \
  add _Angle, _Angle, _Angle \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  add _Angle, _Angle, __RLSBytesCount##_port \
  index _AccAngle, __RLSReadBuf##_port, 2 \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  add _AccAngle, _AccAngle, __RLSBytesCount##_port \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 4 \
  add _AccAngle, _AccAngle, __RLSBytesCount##_port \
  mul _AccAngle, _AccAngle, 256 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  add _AccAngle, _AccAngle, __RLSBytesCount##_port \
  index _RPM, __RLSReadBuf##_port, 6 \
  mul _RPM, _RPM, 256 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 7 \
  add _RPM, _RPM, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadI2CDeviceInfo(_port, _i2caddr, _info, _strVal) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, _info \
  set __RLSBytesCountVar, 8 \
  call __ReadLSBytesVar \
  mov _strVal, __RLSReadBufVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, _info \
  set __RLSBytesCount##_port, 8 \
  call __ReadLSBytes##_port \
  mov _strVal, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend

#define __SetSensorMSPressure(_port) \
  setin IN_TYPE_REFLECTION, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorMSDRODActive(_port) \
  setin IN_TYPE_LIGHT_ACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorMSDRODInactive(_port) \
  setin IN_TYPE_LIGHT_INACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port)

#define __SetSensorNXTSumoEyesLong(_port) \
  setin IN_TYPE_LIGHT_INACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port) \
  wait 275

#define __SetSensorNXTSumoEyesShort(_port) \
  setin IN_TYPE_LIGHT_ACTIVE, _port, TypeField \
  setin IN_MODE_PCTFULLSCALE, _port, InputModeField \
  __ResetSensor(_port) \
  wait 275

#define __SetSensorMSTouchMux(_port) \
  setin IN_TYPE_LIGHT_INACTIVE, _port, TypeField \
  setin IN_MODE_RAW, _port, InputModeField \
  __ResetSensor(_port)

#define __ReadSensorMSPressure(_port, _value) \
  getin _value, _port, RawValueField \
  sub _value, 1024, _value \
  div _value, _value, 25

#define __ReadSensorMSPressureRaw(_port, _value) \
  getin _value, _port, RawValueField

#define __ReadSensorMSDROD(_port, _value) \
  getin _value, _port, NormalizedValueField

#define __ReadSensorNXTSumoEyes(_port, _value) \
  getin _value, _port, NormalizedValueField \
  mul _value, _value, 100 \
  div _value, _value, 1023

#define __ReadSensorMSCompass(_port, _i2caddr, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, 0x42 \
  set __RLSBytesCountVar, 2 \
  call __ReadLSBytesVar \
  index _value, __RLSReadBufVar, 1 \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  mul _value, _value, 256 \
  add _value, _value, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, 0x42 \
  set __RLSBytesCount##_port, 2 \
  call __ReadLSBytes##_port \
  index _value, __RLSReadBuf##_port, 1 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  mul _value, _value, 256 \
  add _value, _value, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, 0xD0, 0x00 \
  set __RLSBytesCountVar, 8 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _sec, __RLSReadBufVar, NA \
  index _min, __RLSReadBufVar, 1 \
  index _hrs, __RLSReadBufVar, 2 \
  index _dow, __RLSReadBufVar, 3 \
  index _date, __RLSReadBufVar, 4 \
  index _month, __RLSReadBufVar, 5 \
  index _year, __RLSReadBufVar, 6 \
  bcd2dec(_sec, _sec) \
  bcd2dec(_min, _min) \
  bcd2dec(_hrs, _hrs) \
  bcd2dec(_dow, _dow) \
  bcd2dec(_date, _date) \
  bcd2dec(_month, _month) \
  bcd2dec(_year, _year) \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, 0xD0, 0x00 \
  set __RLSBytesCount##_port, 8 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _sec, __RLSReadBuf##_port, NA \
  index _min, __RLSReadBuf##_port, 1 \
  index _hrs, __RLSReadBuf##_port, 2 \
  index _dow, __RLSReadBuf##_port, 3 \
  index _date, __RLSReadBuf##_port, 4 \
  index _month, __RLSReadBuf##_port, 5 \
  index _year, __RLSReadBuf##_port, 6 \
  bcd2dec(_sec, _sec) \
  bcd2dec(_min, _min) \
  bcd2dec(_hrs, _hrs) \
  bcd2dec(_dow, _dow) \
  bcd2dec(_date, _date) \
  bcd2dec(_month, _month) \
  bcd2dec(_year, _year) \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, 0x42  \
  set __RLSBytesCountVar, 3 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _x, __RLSReadBufVar, NA \
  index _y, __RLSReadBufVar, 1 \
  index _z, __RLSReadBufVar, 2 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, 0x42 \
  set __RLSBytesCount##_port, 3 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _x, __RLSReadBuf##_port, NA \
  index _y, __RLSReadBuf##_port, 1 \
  index _z, __RLSReadBuf##_port, 2 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, 0x45 \
  set __RLSBytesCountVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _x, __RLSReadBufVar, NA \
  index __RLSBytesCountVar, __RLSReadBufVar, 1 \
  mul __RLSBytesCountVar, __RLSBytesCountVar, 256 \
  add _x, _x, __RLSBytesCountVar \
  index _y, __RLSReadBufVar, 2 \
  index __RLSBytesCountVar, __RLSReadBufVar, 3 \
  mul __RLSBytesCountVar, __RLSBytesCountVar, 256 \
  add _y, _y, __RLSBytesCountVar \
  index _z, __RLSReadBufVar, 4 \
  index __RLSBytesCountVar, __RLSReadBufVar, 5 \
  mul __RLSBytesCountVar, __RLSBytesCountVar, 256 \
  add _z, _z, __RLSBytesCountVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, 0x45 \
  set __RLSBytesCount##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _x, __RLSReadBuf##_port, NA \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 1 \
  mul __RLSBytesCount##_port, __RLSBytesCount##_port, 256 \
  add _x, _x, __RLSBytesCount##_port \
  index _y, __RLSReadBuf##_port, 2 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 3 \
  mul __RLSBytesCount##_port, __RLSBytesCount##_port, 256 \
  add _y, _y, __RLSBytesCount##_port \
  index _z, __RLSReadBuf##_port, 4 \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, 5 \
  mul __RLSBytesCount##_port, __RLSBytesCount##_port, 256 \
  add _z, _z, __RLSBytesCount##_port \
  release __RLSBmutex##_port \
  compend

#define __PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, PFMATE_REG_CHANNEL, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB  \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  arrbuild __RLSReadBufVar, _i2caddr, PFMATE_REG_CMD, PFMATE_CMD_GO  \
  set __RLSBytesCountVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, PFMATE_REG_CHANNEL, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB  \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, PFMATE_REG_CMD, PFMATE_CMD_GO  \
  set __RLSBytesCount##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

#define __PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, PFMATE_REG_CHANNEL, _channel, 0x00, _b1, _b2  \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  arrbuild __RLSReadBufVar, _i2caddr, PFMATE_REG_CMD, PFMATE_CMD_RAW  \
  set __RLSBytesCountVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, PFMATE_REG_CHANNEL, _channel, 0x00, _b1, _b2  \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, PFMATE_REG_CMD, PFMATE_CMD_RAW  \
  set __RLSBytesCount##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend


dseg segment
  __RLSBbufRFIDInit byte[] 0x04, 0x32
  __RLSBbufRFIDData byte[] 0x04, 0x42
  __RFIDCount byte
  __RFIDCont_Port byte
  __RFIDCont_Result byte
  __RFIDCont_Output byte[]
  __RFIDmutex mutex
dseg ends

#define __RFIDInit(_port, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  mov __RLSReadBufVar, __RLSBbufRFIDInit \
  set __RLSBytesCountVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  mov __RLSReadBuf##_port, __RLSBbufRFIDInit \
  set __RLSBytesCount##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

#define __RFIDMode(_port, _mode, _result) __I2CSendCmd(_port, 0x04, _mode, _result)
#define __RFIDStatus(_port, _result) __MSReadValue(_port, 0x04, 0x32, 1, _result, __RDSD_LSStatus)
#define __RFIDRead(_port, _output, _result) \
  set __RFIDCount, 5 \
  __ReadI2CBytes(_port, __RLSBbufRFIDData, __RFIDCount, _output, _result)

#define __RFIDStop(_port, _result) \
  __RFIDInit(_port, _result) \
  wait 10 \
  __RFIDMode(_port, RFID_MODE_STOP, _result)

#define __RFIDReadSingle(_port, _output, _result) \
  __RFIDInit(_port, _result) \
  wait 15 \
  __RFIDMode(_port, RFID_MODE_SINGLE, _result) \
  wait 250 \
  __RFIDRead(_port, _output, _result)

#define __RFIDReadContinuous(_port, _output, _result) \
  acquire __RFIDmutex \
  mov __RFIDCont_Port, _port \
  call __RFIDReadContinuousSub \
  mov _output, __RFIDCont_Output \
  mov _result, __RFIDCont_Result \
  release __RFIDmutex

#define __NXTServoInit(_port, _i2caddr, _servo, _result) \
  __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_INIT, _result) \
  __I2CSendCmd(_port, _i2caddr, _servo+1, _result)

#define __NXTServoGotoMacroAddress(_port, _i2caddr, _macro, _result) \
  __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_GOTO, _result) \
  __I2CSendCmd(_port, _i2caddr, _macro, _result)

#define __NXTServoEditMacro(_port, _i2caddr, _result) \
  __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_EDIT1, _result) \
  __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_EDIT2, _result)

#define __NXTHIDLoadCharacter(_port, _i2caddr, _modifier, _character, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, _modifier, _character \
  set __RLSBytesCountVar, 0 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, _modifier, _character \
  set __RLSBytesCount##_port, 0 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  release __RLSBmutex##_port \
  compend

dseg segment
  __WDSC_LSB byte
  __WDSC_MSB byte
  __WDSC_Port byte
  __WDSC_WriteBytes byte[]
  __WDSC_SensorAddress byte
  __WDSC_SensorRegister byte
  __WDSC_ByteCount byte
  __WDSC_lswArgs TCommLSWrite
  __WDSC_LSStatus sbyte
  __WDSC_Result sbyte
  __WDSCmutex mutex
  __DNRVmutex mutex
  __RDSD_Port byte
  __RDSD_SensorAddress byte
  __RDSD_SensorRegister byte
  __RDSD_NumBytesToRead byte
  __RDSD_Value sdword
  __RDSD_lswArgs TCommLSWrite
  __RDSD_lsrArgs TCommLSRead
  __RDSD_LSStatus sbyte
  __RDSD_bytesRead sdword
  __RDSD_PreviousValue sdword
  __RDSD_Byte byte
dseg ends

#define __MSWriteToRegister(_port, _i2caddr, _reg, _bytes, _result) \
  acquire __WDSCmutex \
  mov __WDSC_Port, _port \
  mov __WDSC_SensorAddress, _i2caddr \
  set __WDSC_SensorRegister, _reg \
  arrbuild __WDSC_WriteBytes, _bytes \
  call __MSWriteBytesSub \
  mov _result, __WDSC_LSStatus \
  release __WDSCmutex

#define __MSWriteLEIntToRegister(_port, _i2caddr, _reg, _ival, _result) \
  acquire __WDSCmutex \
  mov __WDSC_Port, _port \
  mov __WDSC_SensorAddress, _i2caddr \
  set __WDSC_SensorRegister, _reg \
  and __WDSC_LSB, _ival, 0xFF \
  div __WDSC_MSB, _ival, 0xFF \
  arrbuild __WDSC_WriteBytes, __WDSC_LSB, __WDSC_MSB \
  call __MSWriteBytesSub \
  mov _result, __WDSC_LSStatus \
  release __WDSCmutex

#define __I2CSendCmd(_port, _i2caddr, _cmd, _result) \
  __MSWriteToRegister(_port, _i2caddr, I2C_REG_CMD, _cmd, _result)

#define __TempSendCmd(_port, _cmd, _result) \
  __MSWriteToRegister(_port, LEGO_ADDR_TEMP, TEMP_REG_CONFIG, _cmd, _result)

#define __MSReadValue(_port, _i2caddr, _reg, _bytes, _out, _result) \
  acquire __DNRVmutex \
  mov __RDSD_Port, _port \
  mov __RDSD_SensorAddress, _i2caddr \
  mov __RDSD_SensorRegister, _reg \
  set __RDSD_NumBytesToRead, _bytes \
  call __MSReadLEValueSub \
  mov _out, __RDSD_Value \
  mov _result, __RDSD_LSStatus \
  release __DNRVmutex

subroutine __RFIDReadContinuousSub
  __RFIDInit(__RFIDCont_Port, __RFIDCont_Result)
  wait 15
  __RFIDStatus(__RFIDCont_Port, __RFIDCont_Result)
  brtst GT, __RFIDCont_Endif, __RFIDCont_Result
  __RFIDMode(__RFIDCont_Port, RFID_MODE_CONTINUOUS, __RFIDCont_Result)
  wait 250
__RFIDCont_Endif:
  __RFIDRead(__RFIDCont_Port, __RFIDCont_Output, __RFIDCont_Result)
  return
ends

subroutine __MSWriteBytesSub
  mov __WDSC_lswArgs.Port, __WDSC_Port
  arrbuild __WDSC_lswArgs.Buffer, __WDSC_SensorAddress, __WDSC_SensorRegister, __WDSC_WriteBytes
  set __WDSC_lswArgs.ReturnLen, 0
  syscall CommLSWrite, __WDSC_lswArgs
__WDSC_StatusLoop:
  __lowspeedCheckStatus(__WDSC_Port, __WDSC_LSStatus)
  brtst GT, __WDSC_StatusLoop, __WDSC_LSStatus
  return
ends

subroutine __MSReadLEValueSub
  mov __RDSD_lswArgs.Port, __RDSD_Port
  arrbuild __RDSD_lswArgs.Buffer, __RDSD_SensorAddress, __RDSD_SensorRegister
  mov __RDSD_lswArgs.ReturnLen, __RDSD_NumBytesToRead
  syscall CommLSWrite, __RDSD_lswArgs
__RDSD_CheckStatusAfterWriteLoop:
  __lowspeedCheckStatus(__RDSD_Port, __RDSD_LSStatus)
  brtst GT, __RDSD_CheckStatusAfterWriteLoop, __RDSD_LSStatus
  brtst EQ, __RDSD_GoAheadWithRead, __RDSD_LSStatus
  jmp __RDSD_ReadError
__RDSD_GoAheadWithRead:
  mov __RDSD_lsrArgs.Port, __RDSD_Port
  mov __RDSD_lsrArgs.BufferLen, __RDSD_NumBytesToRead
  syscall CommLSRead, __RDSD_lsrArgs
__RDSD_CheckStatusAfterReadLoop:
  __lowspeedCheckStatus(__RDSD_Port, __RDSD_LSStatus)
  brtst GT, __RDSD_CheckStatusAfterReadLoop, __RDSD_LSStatus
  arrsize __RDSD_bytesRead, __RDSD_lsrArgs.Buffer
  brcmp NEQ, __RDSD_ReadError, __RDSD_bytesRead, __RDSD_NumBytesToRead
  brtst EQ, __RDSD_GoAheadAndCalculateValue, __RDSD_LSStatus
__RDSD_ReadError:
  mov __RDSD_Value, __RDSD_PreviousValue
  jmp __RDSD_ReturnResults
__RDSD_GoAheadAndCalculateValue:
  set __RDSD_Value, 0
  brcmp EQ, __RDSD_OneByte, __RDSD_NumBytesToRead, 1
  brcmp EQ, __RDSD_TwoBytes, __RDSD_NumBytesToRead, 2
  brcmp NEQ, __RDSD_ReadError, __RDSD_NumBytesToRead, 4
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 3
  mul __RDSD_Value, __RDSD_Byte, 256
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 2
  add __RDSD_Value, __RDSD_Value, __RDSD_Byte
  mul __RDSD_Value, __RDSD_Value, 256
__RDSD_TwoBytes:
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 1
  add __RDSD_Value, __RDSD_Value, __RDSD_Byte
  mul __RDSD_Value, __RDSD_Value, 256
__RDSD_OneByte:
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, NA
  add __RDSD_Value, __RDSD_Value, __RDSD_Byte
  mov __RDSD_PreviousValue, __RDSD_Value
__RDSD_ReturnResults:
  return
ends

#define __ReadSensorMSPlayStation(_port, _i2caddr, _b1, _b2, _xleft, _yleft, _xright, _yright, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, PSP_REG_BTNSET1 \
  set __RLSBytesCountVar, 6 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _b1, __RLSReadBufVar, NA \
  index _b2, __RLSReadBufVar, 1 \
  index _xleft, __RLSReadBufVar, 2 \
  index _yleft, __RLSReadBufVar, 3 \
  index _xright, __RLSReadBufVar, 4 \
  index _yright, __RLSReadBufVar, 5 \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, PSP_REG_BTNSET1 \
  set __RLSBytesCount##_port, 6 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _b1, __RLSReadBuf##_port, NA \
  index _b2, __RLSReadBuf##_port, 1 \
  index _xleft, __RLSReadBuf##_port, 2 \
  index _yleft, __RLSReadBuf##_port, 3 \
  index _xright, __RLSReadBuf##_port, 4 \
  index _yright, __RLSReadBuf##_port, 5 \
  release __RLSBmutex##_port \
  compend

#define __RunNRLinkMacro(_port, _i2caddr, _macro, _result) \
  acquire __WDSCmutex \
  mov __WDSC_Port, _port \
  mov __WDSC_SensorAddress, _i2caddr \
  arrbuild __WDSC_WriteBytes, NRLINK_CMD_RUN_MACRO, _macro \
  call __MSWriteBytesSub \
  mov _result, __WDSC_LSStatus \
  release __WDSCmutex

#define __ReadNRLinkStatus(_port, _i2caddr, _value, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, I2C_REG_CMD \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  index _value, __RLSReadBufVar, NA \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, I2C_REG_CMD \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define __WriteNRLinkBytes(_port, _i2caddr, _bytes, _result) \
  __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_FLUSH, _result) \
  __MSWriteToRegister(_port, _i2caddr, NRLINK_REG_DATA, _bytes, _result) \
  arrsize __WDSC_ByteCount, _bytes \
  __MSWriteToRegister(_port, _i2caddr, NRLINK_REG_BYTES, __WDSC_ByteCount, _result)

#define __ReadNRLinkBytes(_port, _i2caddr, _bytes, _result) \
  acquire __DNRVmutex \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _i2caddr, NRLINK_REG_BYTES \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  arrbuild __RLSReadBufVar, _i2caddr, NRLINK_REG_DATA \
  call __ReadLSBytesVar \
  tst EQ, _result, __RLSBResultVar \
  mov _bytes, __RLSReadBufVar \
  release __RLSBmutex0 \
  release __RLSBmutex1 \
  release __RLSBmutex2 \
  release __RLSBmutex3 \
  compelse \
  compchk LT, _port, 0x04 \
  compchk GTEQ, _port, 0x00 \
  acquire __RLSBmutex##_port \
  arrbuild __RLSReadBuf##_port, _i2caddr, NRLINK_REG_BYTES \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  arrbuild __RLSReadBuf##_port, _i2caddr, NRLINK_REG_DATA \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov _bytes, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend \
  __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_FLUSH, _result) \
  release __DNRVmutex

dseg segment
  __MSPFByte1 byte
  __MSPFByte2 byte
dseg ends

subroutine __MSPowerFunctionCalcBytes
  call __PFCalcChecksum
  // build __PFBytes using two values calculated from the __PFNibbles
  index __MSPFByte1, __PFNibbles, NA
  index __PFTmp, __PFNibbles, 1
  mul __MSPFByte1, __MSPFByte1, 16
  add __MSPFByte1, __MSPFByte1, __PFTmp
  index __MSPFByte2, __PFNibbles, 2
  index __PFTmp, __PFNibbles, 3
  mul __MSPFByte2, __MSPFByte2, 16
  add __MSPFByte2, __MSPFByte2, __PFTmp
  arrbuild __PFBytes, __MSPFByte1, __MSPFByte2
  return
ends

#define __MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 4 \
  mod __PF_p3, _outb, 4 \
  call __PFComboDirectSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _pin, 2 \
  mod __PF_p4, _func, 4 \
  set __PF_p5, _cont \
  call __PFSinglePinSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, _cst, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _func, 16 \
  set __PF_p4, _cst \
  call __PFSingleOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 16 \
  mod __PF_p3, _outb, 16 \
  call __PFComboPWMSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSIRTrain(_port, _i2caddr, _channel, _func, _PFMode, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _func, 5 \
  compif EQ, _PFMode, TRUE \
  call __PFTrainSub \
  compelse \
  call __RCTrainSub \
  compend \
  set __PFPowerFuncMode, _PFMode \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2, _result) \
  acquire __PFMutex \
  mod __PF_p1, _nibble0, 7 \
  mod __PF_p2, _nibble1, 16 \
  mod __PF_p3, _nibble2, 16 \
  call __PFRawOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFRepeatLastCommand(_port, _i2caddr, _count, _delay, _result) \
  acquire __PFMutex \
  mov __PF_p1, _count \
  __MSPFRepeatLoop##__I__: \
  __WriteNRLinkBytes(_port, _i2caddr, __PFBytes, _result) \
  waitv _delay \
  sub __PF_p1, __PF_p1, 1 \
  brtst GT, __MSPFRepeatLoop##__I__, __PF_p1 \
  release __PFMutex \
  __IncI__

subroutine __MSRCXCommandSub
  dseg segment
    __MSRCSToggle byte
    __MSRCSI byte
    __MSRCSInCmd byte[]
    __MSRCSTmpBuf byte[]
    __MSRCSCmdBytes sbyte
    __MSRCSCmd byte
    __MSRCSCSum byte
    __MSRCSMsgBufSize byte
    __MSRCSTmpByte byte
    __MSRCSTmpSByte sbyte
    __MSRCSTmpWord word
    __MSRCSTmpByte2 byte
    __MSRCSResult byte
  dseg ends
  arrsize __MSRCSCmdBytes, __gRCXCmd.Command
  index __MSRCSCmd, __gRCXCmd.Command, NA
  set __MSRCSCSum, 0

  // build the message
  set __MSRCSMsgBufSize, 2
  mul __MSRCSMsgBufSize, __MSRCSMsgBufSize, __MSRCSCmdBytes
  add __MSRCSMsgBufSize, __MSRCSMsgBufSize, 5

  arrinit __MSRCSInCmd, 0, __MSRCSMsgBufSize
  replace __MSRCSInCmd, __MSRCSInCmd, NA, 0x55
  replace __MSRCSInCmd, __MSRCSInCmd, 1, 0xFF
  replace __MSRCSInCmd, __MSRCSInCmd, 2, 0x00
  // add cmd and ~cmd bytes
  or __MSRCSTmpByte, __MSRCSCmd, __MSRCSToggle
  replace __MSRCSInCmd, __MSRCSInCmd, 3, __MSRCSTmpByte
  mov __MSRCSCSum, __MSRCSTmpByte
  sub __MSRCSTmpByte, 0xFF, __MSRCSCSum
  replace __MSRCSInCmd, __MSRCSInCmd, 4, __MSRCSTmpByte

  set __MSRCSI, 0
  xor __MSRCSToggle, __MSRCSToggle, 8

  brcmp LTEQ, __MSRCSEndWhileILTCmdBytes, __MSRCSCmdBytes, 1

__MSRCSWhileILTCmdBytes:
  sub __MSRCSTmpByte, __MSRCSCmdBytes, 1
  brcmp GTEQ, __MSRCSEndWhileILTCmdBytes, __MSRCSI, __MSRCSTmpByte
  add __MSRCSTmpByte, __MSRCSI, 1
  index __MSRCSTmpByte2, __gRCXCmd.Command, __MSRCSTmpByte
  mul __MSRCSTmpByte, __MSRCSI, 2
  add __MSRCSTmpByte, __MSRCSTmpByte, 5
  replace __MSRCSInCmd, __MSRCSInCmd, __MSRCSTmpByte, __MSRCSTmpByte2
  // calculate checksum
  add __MSRCSCSum, __MSRCSCSum, __MSRCSTmpByte2
  add __MSRCSTmpByte, __MSRCSTmpByte, 1
  sub __MSRCSTmpByte2, 255, __MSRCSTmpByte2
  replace __MSRCSInCmd, __MSRCSInCmd, __MSRCSTmpByte, __MSRCSTmpByte2
  add __MSRCSI, __MSRCSI, 1
  jmp __MSRCSWhileILTCmdBytes
__MSRCSEndWhileILTCmdBytes:

  // add the two checksum bytes
  mul __MSRCSTmpByte, __MSRCSI, 2
  add __MSRCSTmpByte, __MSRCSTmpByte, 5
  replace __MSRCSInCmd, __MSRCSInCmd, __MSRCSTmpByte, __MSRCSCSum
  sub __MSRCSTmpByte2, 255, __MSRCSCSum
  add __MSRCSTmpByte, __MSRCSTmpByte, 1
  replace __MSRCSInCmd, __MSRCSInCmd, __MSRCSTmpByte, __MSRCSTmpByte2

  // if the size of __MSRCSInCmd > 14 then we need to chunk up the transmission
  mov __MSRCSTmpSByte, __MSRCSMsgBufSize
__MSRCSWhileMsgBufSizeGTZero:
  arrsubset __gRCXCmd.Command, __MSRCSInCmd, NA, 14
  arrbuild __MSRCSTmpBuf, __gRCXCmd.Address, 0x42, __gRCXCmd.Command
  // write message bytes to the NRLink device
  __WriteNRLinkBytes(__gRCXCmd.Port, __gRCXCmd.Address, __MSRCSTmpBuf, __MSRCSResult)
  sub __MSRCSTmpSByte, __MSRCSTmpSByte, 14
  brtst LTEQ, __MSRCSEndWhileMsgBufSizeGTZero, __MSRCSTmpSByte
  arrsubset __MSRCSTmpBuf, __MSRCSInCmd, 14, NA
  mov __MSRCSInCmd, __MSRCSTmpBuf
  jmp __MSRCSWhileMsgBufSizeGTZero
__MSRCSEndWhileMsgBufSizeGTZero:

  // Now send the IR message
  arrbuild __MSRCSTmpBuf, __gRCXCmd.Address, 0x40, __MSRCSMsgBufSize
  __WriteNRLinkBytes(__gRCXCmd.Port, __gRCXCmd.Address, __MSRCSTmpBuf, __MSRCSResult)

  // give the message time to be transferred
  mul __MSRCSTmpWord, __MSRCSMsgBufSize, 5
  waitv __MSRCSTmpWord

  // do we need to read a response?
  brtst EQ, __MSRCSNoResponse, __gRCXCmd.ResponseBytes

  // give the message time to be transferred
  add __MSRCSTmpWord, __MSRCSMsgBufSize, __gRCXCmd.ResponseBytes
  mul __MSRCSTmpWord, __MSRCSTmpWord, 5
  waitv __MSRCSTmpWord

  // read the response
  __ReadNRLinkBytes(__gRCXCmd.Port, __gRCXCmd.Address, __gRCXCmd.Response, __MSRCSResult)

__MSRCSNoResponse:
  return
ends


#define __MSRCXSetNRLink(_port, _i2caddr) \
  set __gRCXCmd.Port, _port \
  set __gRCXCmd.Address, _i2caddr

#define __MSRCXPoll(_src, _value, _result) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PollOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 12 \
  call __MSRCXCommandSub \
  index _result, __gRCXCmd.Response, 4 \
  index __MSRCSTmpByte, __gRCXCmd.Response, 2 \
  mul _result, _result, 256 \
  add _result, _result, __MSRCSTmpByte \
  release __RCXCmdMutex

#define __MSRCXBatteryLevel(_result) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_BatteryLevelOp \
  set __gRCXCmd.ResponseBytes, 12 \
  call __MSRCXCommandSub \
  index _result, __gRCXCmd.Response, 4 \
  index __MSRCSTmpByte, __gRCXCmd.Response, 2 \
  mul _result, _result, 256 \
  add _result, _result, __MSRCSTmpByte \
  release __RCXCmdMutex

#define __MSRCXOpNoArgs(_op) \
  acquire __RCXCmdMutex \
  arrinit __gRCXCmd.Command, _op, 1 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetOutput(_outputs, _mode) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _mode \
  arrbuild __gRCXCmd.Command, RCX_OnOffFloatOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetDirection(_outputs, _dir) \
  acquire __RCXCmdMutex \
  add __RCSTmpByte, _outputs, _dir \
  arrbuild __gRCXCmd.Command, RCX_OutputDirOp, __RCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetPower(_outputs, _pwrsrc, _pwrval) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_OutputPowerOp, _outputs, _pwrsrc, _pwrval \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXOnFwd(_outputs) \
  __MSRCXSetDirection(_outputs, RCX_OUT_FWD) \
  __MSRCXSetOutput(_outputs, RCX_OUT_ON)

#define __MSRCXOnRev(_outputs) \
  __MSRCXSetDirection(_outputs, RCX_OUT_REV) \
  __MSRCXSetOutput(_outputs, RCX_OUT_ON)

#define __MSRCXOnFor(_outputs, _ms) \
  __MSRCXSetOutput(_outputs, RCX_OUT_ON) \
  waitv _ms \
  __MSRCXSetOutput(_outputs, RCX_OUT_OFF)

#define __MSRCXSetTxPower(_pwr) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_IRModeOp, _pwr \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXPlaySound(_snd) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PlaySoundOp, _snd \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXDeleteTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DeleteTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXStartTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_StartTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXStopTask(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_StopTaskOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSelectProgram(_prog) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SelectProgramOp, _prog \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXClearTimer(_timer) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearTimerOp, _timer \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetSleepTime(_t) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_AutoOffOp, _t \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXDeleteSub(_s) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DeleteSubOp, _s \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXClearSensor(_port) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearSensorOp, _port \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXPlayToneVar(_varnum, _duration) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_PlayToneVarOp, _varnum, _duration \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetWatch(_hours, _minutes) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetWatchOp, _hours, _minutes \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetSensorType(_port, _type) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_InputTypeOp, _port, _type \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetSensorMode(_port, _mode) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_InputModeOp, _port, _mode \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXCreateDatalog(_size) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _size, 0xFF \
  div __MSRCSTmpByte2, _size, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetDatalogOp, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXAddToDatalog(_src, _value) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DatalogOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSendSerial(_first, _count) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SendUARTDataOp, _first, _count \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXRemote(_cmd) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _cmd, 0xFF \
  div __MSRCSTmpByte2, _cmd, 256 \
  arrbuild __gRCXCmd.Command, RCX_RemoteOp, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXEvent(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_DirectEventOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXPlayTone(_freq, _duration) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _freq, 0xFF \
  div __MSRCSTmpByte2, _freq, 256 \
  arrbuild __gRCXCmd.Command, RCX_PlayToneOp, __MSRCSTmpByte, __MSRCSTmpByte2, _duration \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSelectDisplay(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_DisplayOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXPollMemory(_memaddress, _result) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _memaddress, 0xFF \
  div __MSRCSTmpByte2, _memaddress, 256 \
  arrbuild __gRCXCmd.Command, RCX_PollMemoryOp, __MSRCSTmpByte, __MSRCSTmpByte2, 1 \
  set __gRCXCmd.ResponseBytes, 12 \
  call __MSRCXCommandSub \
  index _result, __gRCXCmd.Response, 4 \
  index __MSRCSTmpByte, __gRCXCmd.Response, 2 \
  mul _result, _result, 256 \
  add _result, _result, __MSRCSTmpByte \
  release __RCXCmdMutex

#define __MSRCXSetEvent(_evt, _src, _type) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetEventOp, _evt, _src, _type \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetGlobalOutput(_outputs, _mode) \
  acquire __RCXCmdMutex \
  add __MSRCSTmpByte, _outputs, _mode \
  arrbuild __gRCXCmd.Command, RCX_GOutputModeOp, __MSRCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetGlobalDirection(_outputs, _dir) \
  acquire __RCXCmdMutex \
  add __MSRCSTmpByte, _outputs, _dir \
  arrbuild __gRCXCmd.Command, RCX_GOutputDirOp, __MSRCSTmpByte \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_GOutputPowerOp, _outputs, _pwrsrc, _pwrval \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_CalibrateEventOp, _evt, _low, _hi, _hyst \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __RCXVarOp(_op, _vnum, _src, _val) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _val, 0xFF \
  div __MSRCSTmpByte2, _val, 256 \
  arrbuild __gRCXCmd.Command, _op, _vnum, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSet(_dstsrc, _dstval, _src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetSourceValueOp, _dstsrc, _dstval, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXUnlock() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_UnlockOp, 1, 3, 5, 7, 11 \
  set __gRCXCmd.ResponseBytes, 16 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXReset() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_BootModeOp, 1, 3, 5, 7, 11 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXBoot() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_UnlockFirmOp, 0x4c, 0x45, 0x47, 0x4F, 0xAE \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetUserDisplay(_src, _value, _precision) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_ViewSourceValOp, 0, _precision, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXIncCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_IncCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXDecCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_DecCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXClearCounter(_counter) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ClearCounterOp, _counter \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetPriority(_p) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SetPriorityOp, _p \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSRCXSetMessage(_msg) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_MessageOp, _msg \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetScoutMode(_mode) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ScoutOp, _mode \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_ScoutRulesOp, _m, _t, _l, _tm, _fx \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSendVLL(_src, _value) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_VLLOp, _src, _value \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetSensorClickTime(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSBlinkTimeOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetSensorHysteresis(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSHysteresisOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetSensorLowerLimit(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSLowerThreshOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetSensorUpperLimit(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_LSUpperThreshOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetEventFeedback(_src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetFeedbackOp, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetCounterLimit(_ctr, _src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetCounterOp, _ctr, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetTimerLimit(_tmr, _src, _value) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _value, 0xFF \
  div __MSRCSTmpByte2, _value, 256 \
  arrbuild __gRCXCmd.Command, RCX_SetTimerLimitOp, _tmr, _src, __MSRCSTmpByte, __MSRCSTmpByte2 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutMuteSound() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, 0x80 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutUnmuteSound() \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, 0xc0 \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSelectSounds(_grp) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_SoundOp, _grp \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __MSScoutSetLight(_x) \
  acquire __RCXCmdMutex \
  arrbuild __gRCXCmd.Command, RCX_LightOp, _x \
  set __gRCXCmd.ResponseBytes, 0 \
  call __MSRCXCommandSub \
  release __RCXCmdMutex

#define __glInit()                                                                             \
         call     __GL_glInit

#define __glSet(_glType, _glValue)                                                             \
         mov      __GL_glSettingType,         _glType                                          \
         mov      __GL_glSettingValue,        _glValue                                         \
         call     __GL_glSet

#define __glBeginObject(_glObjId)                                                              \
         mov      __GL_object.firstVertex,    __GL_vertexCount                                 \
         mov      __GL_object.lastVertex,     __GL_vertexCount                                 \
         mov      __GL_object.firstPolygon,   __GL_polygonCount                                \
         mov      _glObjId,                   __GL_objectCount

#define __glEndObject()                                                                        \
         call     __GL_glEndObject

#define __glObjectAction(_glObjectId, _glAction, _glValue)                                     \
         mov      __GL_objectIndex,           _glObjectId                                      \
         mov      __GL_action,                _glAction                                        \
         mov      __GL_value,                 _glValue                                         \
         call     __GL_glObjectAction

#define __glAddVertex(_glX, _glY, _glZ)                                                        \
         mov      __GL_vertex0.orig.x,        _glX                                             \
         mov      __GL_vertex0.orig.y,        _glY                                             \
         mov      __GL_vertex0.orig.z,        _glZ                                             \
         call     __GL_glAddVertex

#define __glBegin(_glBeginMode)                                                                \
         mov      __GL_polygon.beginMode,     _glBeginMode                                     \
         mov      __GL_polygon.firstVertex,   __GL_pvDataCount                                 \
         mov      __GL_polygon.lastVertex,    __GL_pvDataCount

#define __glEnd()                                                                              \
         call     __GL_glEnd

#define __glBeginRender()                                                                      \
         call     __GL_glResetObjects

#define __glCallObject(_glObjectId)                                                            \
         mov      __GL_objectIndex,           _glObjectId                                      \
         call     __GL_glCallObject

#define __glFinishRender()                                                                     \
         call     __GL_glRotateVertexList                                                      \
         set      __GL_glDrawPoint.Location.X, 200                                             \
         set      __GL_glDrawPoint.Options,    DRAW_OPT_CLEAR_WHOLE_SCREEN                     \
         syscall  DrawPoint,                   __GL_glDrawPoint                                \
         call     __GL_glRenderObjects

#define __glSetAngleX(_glValue)                                                                \
         add      __GL_angleX,                _glValue,    3600                                \
         mod      __GL_angleX,                __GL_angleX, 360

#define __glAddToAngleX(_glValue)                                                              \
         add      __GL_angleX,                __GL_angleX, _glValue                            \
         add      __GL_angleX,                __GL_angleX, 3600                                \
         mod      __GL_angleX,                __GL_angleX, 360

#define __glSetAngleY(_glValue)                                                                \
         add      __GL_angleY,                _glValue,    3600                                \
         mod      __GL_angleY,                __GL_angleY, 360

#define __glAddToAngleY(_glValue)                                                              \
         add      __GL_angleY,                __GL_angleY, _glValue                            \
         add      __GL_angleY,                __GL_angleY, 3600                                \
         mod      __GL_angleY,                __GL_angleY, 360

#define __glSetAngleZ(_glValue)                                                                \
         add      __GL_angleZ,                _glValue,    3600                                \
         mod      __GL_angleZ,                __GL_angleZ, 360

#define __glAddToAngleZ(_glValue)                                                              \
         add      __GL_angleZ,                __GL_angleZ, _glValue                            \
         add      __GL_angleZ,                __GL_angleZ, 3600                                \
         mod      __GL_angleZ,                __GL_angleZ, 360

#define __glSin32768(_glAngle, _glResult)                                                      \
         mov      __GL_angle,                 _glAngle                                         \
         mod      __GL_angle,                 __GL_angle, 360                                  \
         index    _glResult,                  __GL_SIN_TABLE, __GL_angle

#define __glCos32768(_glAngle, _glResult)                                                      \
         mov      __GL_angle,                 _glAngle                                         \
         add      __GL_angle,                 __GL_angle, 90                                   \
         mod      __GL_angle,                 __GL_angle, 360                                  \
         index    _glResult,                  __GL_SIN_TABLE, __GL_angle

#define __glBox(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId)                               \
         mov      __GL_mode                   _glMode                                          \
         mov      __GL_sizeX                  _glSizeX                                         \
         mov      __GL_sizeY                  _glSizeY                                         \
         mov      __GL_sizeZ                  _glSizeZ                                         \
         call     __GL_glBox                                                                   \
         mov      _glObjId,                   __GL_tmpId

#define __glPyramid(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glOjbId)                           \
         mov      __GL_mode                   _glMode                                          \
         mov      __GL_sizeX                  _glSizeX                                         \
         mov      __GL_sizeY                  _glSizeY                                         \
         mov      __GL_sizeZ                  _glSizeZ                                         \
         call     __GL_glPyramid                                                               \
         mov      _glObjId,                   __GL_tmpId

//-----------------------------------------------------------------------------------------
//
// Private definitions...
//
//-----------------------------------------------------------------------------------------
#define __glRangeCheck(_glValue, _glMaxValue, _glErrorMsg)                                     \
         mov      __GL_glRangeValue,          _glValue                                         \
         mov      __GL_glRangeMaxValue,       _glMaxValue                                      \
         mov      __GL_glRangeErrorMsg,       _glErrorMsg                                      \
         call     __GL_glRangeCheck

// Data sizes...
#define __GL_MAX_VERTICES       256
#define __GL_MAX_LINES          256
#define __GL_MAX_POLYGONS       128
#define __GL_MAX_OBJECT_ACTIONS  32
#define __GL_MAX_OBJECTS         16
#define __GL_MAX_PV_DATA        256
#define __GL_MAX_PL_DATA        256

dseg segment
  // Sine table constants...
  __GL_SIN_TABLE sword[] 0,572,1144,1715,2286,2856,3425,3993,4560,5126,5690,6252,6813,7371,7927,   \
 8481,9032,9580,10126,10668,11207,11743,12275,12803,13328,13848,14365,14876,15384,15886,16384,     \
 16877,17364,17847,18324,18795,19261,19720,20174,20622,21063,21498,21926,22348,22763,23170,23571,  \
 23965,24351,24730,25102,25466,25822,26170,26510,26842,27166,27482,27789,28088,28378,28660,28932,  \
 29197,29452,29698,29935,30163,30382,30592,30792,30983,31164,31336,31499,31651,31795,31928,32052,  \
 32166,32270,32365,32449,32524,32588,32643,32688,32723,32748,32763,32767,32763,32748,32723,32688,  \
 32643,32588,32524,32449,32365,32270,32166,32052,31928,31795,31651,31499,31336,31164,30983,30792,  \
 30592,30382,30163,29935,29698,29452,29197,28932,28660,28378,28088,27789,27482,27166,26842,26510,  \
 26170,25822,25466,25102,24730,24351,23965,23571,23170,22763,22348,21926,21498,21063,20622,20174,  \
 19720,19261,18795,18324,17847,17364,16877,16384,15886,15384,14876,14365,13848,13328,12803,12275,  \
 11743,11207,10668,10126,9580,9032,8481,7927,7371,6813,6252,5690,5126,4560,3993,3425,2856,2286,    \
 1715,1144,572,0,-572,-1144,-1715,-2286,-2856,-3425,-3993,-4560,-5126,-5690,-6252,-6813,-7371,     \
 -7927,-8481,-9032,-9580,-10126,-10668,-11207,-11743,-12275,-12803,-13328,-13848,-14365,-14876,    \
 -15384,-15886,-16384,-16877,-17364,-17847,-18324,-18795,-19261,-19720,-20174,-20622,-21063,-21498,\
 -21926,-22348,-22763,-23170,-23571,-23965,-24351,-24730,-25102,-25466,-25822,-26170,-26510,-26842,\
 -27166,-27482,-27789,-28088,-28378,-28660,-28932,-29197,-29452,-29698,-29935,-30163,-30382,-30592,\
 -30792,-30983,-31164,-31336,-31499,-31651,-31795,-31928,-32052,-32166,-32270,-32365,-32449,-32524,\
 -32588,-32643,-32688,-32723,-32748,-32763,-32767,-32763,-32748,-32723,-32688,-32643,-32588,-32524,\
 -32449,-32365,-32270,-32166,-32052,-31928,-31795,-31651,-31499,-31336,-31164,-30983,-30792,-30592,\
 -30382,-30163,-29935,-29698,-29452,-29197,-28932,-28660,-28378,-28088,-27789,-27482,-27166,-26842,\
 -26510,-26170,-25822,-25466,-25102,-24730,-24351,-23965,-23571,-23170,-22763,-22348,-21926,-21498,\
 -21063,-20622,-20174,-19720,-19261,-18795,-18324,-17847,-17364,-16877,-16384,-15886,-15384,-14876,\
 -14365,-13848,-13328,-12803,-12275,-11743,-11207,-10668,-10126,-9580,-9032,-8481,-7927,-7371,     \
 -6813,-6252,-5690,-5126,-4560,-3993,-3425,-2856,-2286,-1715,-1144,-572,0

  // General stuff, copied from NXTDefs.h...
  __GL_glDrawLine        TDrawLine
  __GL_glDrawPoint       TDrawPoint
  __GL_glDrawCircle      TDrawCircle
  __GL_glDrawData        TDrawText

  // settings...
  TGLSettings struct
    cullMode         byte
    circleSize       byte
    camDepth         byte
    zoom             byte
  TGLSettings ends

  __GL_glSettings        TGLSettings
  __GL_glSettingType     byte
  __GL_glSettingValue    byte

  // Vertex data...
  TGLVertex struct
    x                sword //sdword
    y                sword //sdword
    z                sword //sdword
  TGLVertex ends

  TGLScreenVertex struct
    x                sword //sdword
    y                sword //sdword
  TGLScreenVertex ends

  TGLRotVertex struct
    orig             TGLVertex
    rot              TGLVertex
    screen           TGLScreenVertex
  TGLRotVertex ends

  __GL_vertexData        TGLRotVertex[]
  __GL_vertex0           TGLRotVertex
  __GL_vertex1           TGLRotVertex
  __GL_vertex2           TGLRotVertex
  __GL_vertexCount       byte
  __GL_vertexIndex       byte
  __GL_vertexOffset      byte

  // Line data...
  TGLLine struct
    firstVertex      byte
    lastVertex       byte
  TGLLine ends

  __GL_lineData          TGLLine[]
  __GL_line              TGLLine
  __GL_lineCount         byte
  __GL_lineIndex         byte
  __GL_lineDone          byte[]

  // Polygon data...
  TGLPolygon struct
    beginMode        byte
    firstVertex      byte
    lastVertex       byte
    firstLine        byte
    lastLine         byte
  TGLPolygon ends

  __GL_polygonData       TGLPolygon[]
  __GL_polygon           TGLPolygon
  __GL_polygonCount      byte
  __GL_polygonIndex      byte

  // Polygon/vertex link...
  __GL_pvData            byte[]
  __GL_pvDataCount       byte

  // Polygon/line link...
  __GL_plData            byte[]
  __GL_plDataCount       byte

  // Object action...
  TGLObjectAction struct
    type             byte
    value            sword //sdword
//    fsin             float
//    fcos             float
    lsin             sword //sdword
    lcos             sword //sdword
  TGLObjectAction ends

  __GL_objectAction      TGLObjectAction
  __GL_objectActionData  TGLObjectAction[]
  __GL_objectActionCount byte

  // Object data...
  TObject struct
    firstVertex      byte
    lastVertex       byte
    firstPolygon     byte
    lastPolygon      byte
    firstLine        byte
    lastLine         byte
    render           byte
    
    // settings...
    circleSize       byte
    cullMode         byte

    actionCount      byte
    actionList       byte[]
  TObject ends

  __GL_objectData        TObject[]
  __GL_object            TObject
  __GL_objectCount       byte
  __GL_objectIndex       byte

  // Temp offset...
  __GL_offset            word

  // Counters...
  __GL_i                 word
  __GL_j                 word
  __GL_k                 word
  __GL_l                 word

  // Angles...
  __GL_angleX            sword //sdword
  __GL_angleY            sword //sdword
  __GL_angleZ            sword //sdword

  // Save angles...
  __GL_saveAngleX        sword //sdword
  __GL_saveAngleY        sword //sdword
  __GL_saveAngleZ        sword //sdword

  __GL_sinX              sword //sdword
  __GL_cosX              sword //sdword
  __GL_sinY              sword //sdword
  __GL_cosY              sword //sdword
  __GL_sinZ              sword //sdword
  __GL_cosZ              sword //sdword
//  __GL_sinX              float
//  __GL_cosX              float
//  __GL_sinY              float
//  __GL_cosY              float
//  __GL_sinZ              float
//  __GL_cosZ              float

  // Temp vars for calculations...
  __GL_a                 sdword
  __GL_b                 sdword
  __GL_c                 sdword
  __GL_d                 sdword
  __GL_e                 sdword
  __GL_f                 sdword

  // Rotated x, y, z coords...
  __GL_xx                sdword
  __GL_yy                sdword
  __GL_zz                sdword

  __GL_camDepth          sdword
  __GL_zoom              sdword
  
  __GL_x0                sdword
  __GL_y0                sdword
  __GL_z0                sdword
  
  __GL_x1                sdword
  __GL_y1                sdword
  __GL_z1                sdword

  __GL_x2                sdword
  __GL_y2                sdword
  __GL_z2                sdword

  // data for filling polygons...
  __GL_buffer            byte[]
  
  __GL_minX              sword
  __GL_maxX              sword
  
  __GL_startY            sword
  __GL_startX            sword
  __GL_endY              sword
  __GL_endX              sword
  
  __GL_deltaY            sword
  __GL_deltaX            sword
  
  __GL_action            byte
  __GL_index             word
  __GL_value             sword //sdword
  __GL_type              sword //sdword
  
  // rangecheck data...
  __GL_glRangeValue      word
  __GL_glRangeMaxValue   word
  __GL_glRangeErrorMsg   byte[]

  __GL_glErrorState      byte FALSE
  __GL_glErrorMsg        byte[]

  __GL_glLinesClipped    byte
dseg ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glRangeCheck
// Description : Check array sizes.
//-----------------------------------------------------------------------------------------
subroutine __GL_glRangeCheck
  // check if there's an already error...
  brcmp    EQ,                     __GL_nbc_gl_range_ok, __GL_glErrorState, TRUE
  // check the range...
  brcmp    LT,                     __GL_nbc_gl_range_ok, __GL_glRangeValue, __GL_glRangeMaxValue
  set      __GL_glErrorState,      TRUE
  mov      __GL_glErrorMsg,        __GL_glRangeErrorMsg
__GL_nbc_gl_range_ok:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glInit
// Description : Initialize vars.
//-----------------------------------------------------------------------------------------
subroutine __GL_glInit
  set      __GL_glSettings.cullMode,   GL_CULL_BACK
  set      __GL_glSettings.circleSize, 4
  set      __GL_glSettings.camDepth,   100
  set      __GL_glSettings.zoom,       0
  arrinit  __GL_vertexData,            __GL_vertex0, __GL_MAX_VERTICES
  set      __GL_vertexCount,           0
  arrinit  __GL_lineData,              __GL_line, __GL_MAX_LINES
  set      __GL_lineCount,             0
  arrinit  __GL_polygonData,           __GL_polygon, __GL_MAX_POLYGONS
  set      __GL_polygonCount,          0
  arrinit  __GL_objectActionData,      __GL_objectAction, __GL_MAX_OBJECT_ACTIONS
  arrinit  __GL_object.actionList,     0, __GL_MAX_OBJECT_ACTIONS
  arrinit  __GL_objectData,            __GL_object, __GL_MAX_OBJECTS
  set      __GL_objectCount,           0
  arrinit  __GL_pvData                 0, __GL_MAX_PV_DATA
  set      __GL_pvDataCount,           0
  arrinit  __GL_plData                 0, __GL_MAX_PL_DATA
  set      __GL_plDataCount            0
  set      __GL_angleX,                0
  set      __GL_angleY,                0
  set      __GL_angleZ,                0
  arrinit  __GL_buffer,                0, 200
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glSet
// Description : Change settings.
//-----------------------------------------------------------------------------------------
subroutine __GL_glSet
  brcmp    EQ,                     __GL_nbc_gl_set_circle_size,  __GL_glSettingType, GL_CIRCLE_SIZE
  brcmp    EQ,                     __GL_nbc_gl_set_cull_mode,    __GL_glSettingType, GL_CULL_MODE
  brcmp    EQ,                     __GL_nbc_gl_set_camera_depth, __GL_glSettingType, GL_CAMERA_DEPTH
  brcmp    EQ,                     __GL_nbc_gl_set_zoom_factor,  __GL_glSettingType, GL_ZOOM_FACTOR
  // unknown setting...
  jmp      __GL_nbc_gl_set_done
__GL_nbc_gl_set_circle_size:
  mov      __GL_glSettings.circleSize, __GL_glSettingValue
  jmp      __GL_nbc_gl_set_done
__GL_nbc_gl_set_cull_mode:
  mov      __GL_glSettings.cullMode,   __GL_glSettingValue
  jmp      __GL_nbc_gl_set_done
__GL_nbc_gl_set_camera_depth:
  mov      __GL_glSettings.camDepth,   __GL_glSettingValue
  jmp      __GL_nbc_gl_set_done
__GL_nbc_gl_set_zoom_factor:
  mov      __GL_glSettings.zoom,       __GL_glSettingValue
__GL_nbc_gl_set_done:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glAddVertex
// Description : Check if there's an existing vertex with the same (x,y,z) coord.
//               If there's an existing vertex found then return the index to that vertex
//               else add the vertex to the list and return the index of the added vertex.
//-----------------------------------------------------------------------------------------
subroutine __GL_glAddVertex
  brcmp    EQ,                      __GL_nbc_gl_add_vertex_error, __GL_glErrorState, TRUE
  // check if the list is empty...
  brcmp    EQ,                      __GL_nbc_gl_empty_vertex_list, __GL_vertexCount, 0
  // loop through the list...
  mov      __GL_i,                  __GL_object.firstVertex
__GL_nbc_gl_find_vertex:
  index    __GL_vertex1,            __GL_vertexData, __GL_i
  brcmp    NEQ,                     __GL_nbc_gl_vertex_not_equal, __GL_vertex1.orig.x, __GL_vertex0.orig.x
  brcmp    NEQ,                     __GL_nbc_gl_vertex_not_equal, __GL_vertex1.orig.y, __GL_vertex0.orig.y
  brcmp    NEQ,                     __GL_nbc_gl_vertex_not_equal, __GL_vertex1.orig.z, __GL_vertex0.orig.z
  mov      __GL_vertexIndex,        __GL_i
  jmp      __GL_nbc_gl_add_vertex_done
__GL_nbc_gl_vertex_not_equal:
  add      __GL_i,                  __GL_i, 1
  brcmp    LT,                      __GL_nbc_gl_find_vertex, __GL_i, __GL_object.lastVertex
__GL_nbc_gl_empty_vertex_list:
  __glRangeCheck(__GL_vertexCount, __GL_MAX_VERTICES, 'Too many vertices')
  brcmp    EQ,                      __GL_nbc_gl_add_vertex_error, __GL_glErrorState, TRUE
  // there's no matching vertex found, add a new vertex to the list...
  replace  __GL_vertexData,         __GL_vertexData, __GL_vertexCount, __GL_vertex0
  mov      __GL_vertexIndex,        __GL_vertexCount
  add      __GL_vertexCount,        __GL_vertexCount, 1
__GL_nbc_gl_add_vertex_done:
  replace  __GL_pvData,             __GL_pvData, __GL_polygon.lastVertex, __GL_vertexIndex
  add      __GL_polygon.lastVertex, __GL_polygon.lastVertex, 1
  add      __GL_pvDataCount,        __GL_pvDataCount, 1
  mov      __GL_object.lastVertex,  __GL_vertexCount
__GL_nbc_gl_add_vertex_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glEnd
// Description : Store the polygon data, call __GL_glAddLines to optimize lines list.
//-----------------------------------------------------------------------------------------
subroutine __GL_glEnd
  brcmp    EQ,                     __GL_nbc_gl_end_error, __GL_glErrorState, TRUE
  call     __GL_glAddLines
  replace  __GL_polygonData,       __GL_polygonData, __GL_polygonCount, __GL_polygon
  add      __GL_polygonCount,      __GL_polygonCount, 1
__GL_nbc_gl_end_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glAddLines
// Description : Add the lines of the polygon and check if the line already exists.
//               Each line should be rendered only once.
//-----------------------------------------------------------------------------------------
subroutine __GL_glAddLines
  brcmp    EQ,                     __GL_nbc_gl_add_lines_error, __GL_glErrorState, TRUE
  mov      __GL_polygon.firstLine, __GL_plDataCount
  // loop through polygon vertex the list...
  mov      __GL_i,                 __GL_polygon.firstVertex
__GL_nbc_gl_find_lines1:
  add      __GL_j,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_find_lines_modj, __GL_j, __GL_polygon.lastVertex
  mov      __GL_j,                 __GL_polygon.firstVertex
  // if the beginMode is GL_LINE then don't close the polygon...
  brcmp    EQ,                     __GL_nbc_gl_add_line_done2, __GL_polygon.beginMode, GL_LINE
__GL_nbc_gl_find_lines_modj:
  // _a = _pvData[_i]
  index    __GL_a,                 __GL_pvData, __GL_i
  // _b = _pvData[_j]
  index    __GL_b,                 __GL_pvData, __GL_j
  // check if the list is empty...
  brcmp    EQ,                     __GL_nbc_empty_lines_list, __GL_lineCount, 0
  // loop through the line list to find a matching line...
  mov      __GL_k,                 __GL_object.firstLine
__GL_nbc_gl_find_lines2:
  index    __GL_line,              __GL_lineData, __GL_k
  brcmp    NEQ,                    __GL_nbc_gl_find_line_not_equal1, __GL_a, __GL_line.firstVertex
  brcmp    NEQ,                    __GL_nbc_gl_find_line_not_equal1, __GL_b, __GL_line.lastVertex
  mov      __GL_lineIndex,         __GL_k
  jmp      __GL_nbc_gl_add_line_done1
__GL_nbc_gl_find_line_not_equal1:
  brcmp    NEQ,                    __GL_nbc_gl_find_line_not_equal2, __GL_b, __GL_line.firstVertex
  brcmp    NEQ,                    __GL_nbc_gl_find_line_not_equal2, __GL_a, __GL_line.lastVertex
  mov      __GL_lineIndex,         __GL_k
  jmp      __GL_nbc_gl_add_line_done1
__GL_nbc_gl_find_line_not_equal2:
  add      __GL_k,                 __GL_k, 1
  brcmp    LT,                     __GL_nbc_gl_find_lines2, __GL_k, __GL_lineCount
__GL_nbc_empty_lines_list:
  mov      __GL_line.firstVertex,  __GL_a
  mov      __GL_line.lastVertex,   __GL_b
  __glRangeCheck(__GL_lineCount, __GL_MAX_LINES, 'Too many lines')
  brcmp    EQ,                     __GL_nbc_gl_add_lines_error, __GL_glErrorState, TRUE
  // _lineData[_lineCount] = _line
  replace  __GL_lineData,          __GL_lineData, __GL_lineCount, __GL_line
  mov      __GL_lineIndex,         __GL_lineCount
  add      __GL_lineCount,         __GL_lineCount, 1
__GL_nbc_gl_add_line_done1:
  __glRangeCheck(__GL_plDataCount, __GL_MAX_PL_DATA, 'Too many poly-lines')
  brcmp    EQ,                     __GL_nbc_gl_add_lines_error, __GL_glErrorState, TRUE
  // _plData[_plDataCount] = _lineIndex
  replace  __GL_plData,            __GL_plData, __GL_plDataCount, __GL_lineIndex
  add      __GL_plDataCount,       __GL_plDataCount, 1
  add      __GL_i,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_find_lines1, __GL_i, __GL_polygon.lastVertex
__GL_nbc_gl_add_line_done2:
  mov      __GL_polygon.lastLine,  __GL_plDataCount
__GL_nbc_gl_add_lines_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glEndObject
// Description : Save the last polygon number, store the object in the objectlist.
//-----------------------------------------------------------------------------------------
subroutine __GL_glEndObject
  brcmp    EQ,                      __GL_nbc_gl_end_object_error, __GL_glErrorState, TRUE
  mov      __GL_object.lastPolygon, __GL_polygonCount
  replace  __GL_objectData,         __GL_objectData, __GL_objectCount, __GL_object
  add      __GL_objectCount,        __GL_objectCount, 1
__GL_nbc_gl_end_object_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glObjectAction
// Description : Add an action to the object...
//-----------------------------------------------------------------------------------------
subroutine __GL_glObjectAction
  index    __GL_object,             __GL_objectData, __GL_objectIndex
  mov      __GL_objectAction.type,  __GL_action
  mov      __GL_objectAction.value, __GL_value
  brcmp    EQ,                      __GL_nbc_gl_action_rotate, __GL_action, GL_ROTATE_X
  brcmp    EQ,                      __GL_nbc_gl_action_rotate, __GL_action, GL_ROTATE_Y
  brcmp    EQ,                      __GL_nbc_gl_action_rotate, __GL_action, GL_ROTATE_Z
  jmp      __GL_nbc_gl_action_no_rotate
__GL_nbc_gl_action_rotate:
  // if the action is a rotation of any kind then grab the sin and cos of the angle
  mod      __GL_value,              __GL_value, 360
//  sind     __GL_objectAction.fsin,  __GL_value
//  cosd     __GL_objectAction.fcos,  __GL_value
  index    __GL_objectAction.lsin,  __GL_SIN_TABLE, __GL_value
  add      __GL_value,              __GL_value, 90
  mod      __GL_value,              __GL_value, 360
  index    __GL_objectAction.lcos,  __GL_SIN_TABLE, __GL_value
__GL_nbc_gl_action_no_rotate:
  __glRangeCheck(__GL_object.actionCount, __GL_MAX_OBJECT_ACTIONS, 'Too many object-actions')
  brcmp    EQ,                      __GL_nbc_gl_add_object_error, __GL_glErrorState, TRUE
  // _object.actionList[_object.actionCount] = _objectActionCount
  replace  __GL_object.actionList,  __GL_object.actionList, __GL_object.actionCount, __GL_objectActionCount
  add      __GL_object.actionCount, __GL_object.actionCount, 1
  replace  __GL_objectData,         __GL_objectData, __GL_objectIndex, __GL_object
  __glRangeCheck(__GL_objectActionCount, __GL_MAX_OBJECT_ACTIONS, 'Too many object-actions')
  brcmp    EQ,                      __GL_nbc_gl_add_object_error, __GL_glErrorState, TRUE
  // _objectActionData[_objectActionCount] = _objectAction
  replace  __GL_objectActionData,   __GL_objectActionData, __GL_objectActionCount, __GL_objectAction
  add      __GL_objectActionCount,  __GL_objectActionCount, 1
__GL_nbc_gl_add_object_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glRotateObject
// Description : Check the object actions and apply them to the object...
//-----------------------------------------------------------------------------------------
subroutine __GL_glRotateObject
  mov      __GL_i,                 __GL_object.firstVertex
__GL_nbc_gl_apply_next_vertex:
  index    __GL_vertex0,           __GL_vertexData, __GL_i
  mov      __GL_vertex0.rot.x,     __GL_vertex0.orig.x
  mov      __GL_vertex0.rot.y,     __GL_vertex0.orig.y
  mov      __GL_vertex0.rot.z,     __GL_vertex0.orig.z
  brcmp    EQ,                     __GL_nbc_gl_no_actions, __GL_object.actionCount, 0
  set      __GL_j,                 0
__GL_nbc_gl_apply_next_action:
  // _objectAction = _objectActionData[_object.actionData[_j]]
  index    __GL_k,                 __GL_object.actionList, __GL_j
  index    __GL_objectAction,      __GL_objectActionData, __GL_k
  brcmp    EQ,                     __GL_nbc_gl_apply_translate_x, __GL_objectAction.type, GL_TRANSLATE_X
  brcmp    EQ,                     __GL_nbc_gl_apply_translate_y, __GL_objectAction.type, GL_TRANSLATE_Y
  brcmp    EQ,                     __GL_nbc_gl_apply_translate_z, __GL_objectAction.type, GL_TRANSLATE_Z
  brcmp    EQ,                     __GL_nbc_gl_apply_rotate_x,    __GL_objectAction.type, GL_ROTATE_X
  brcmp    EQ,                     __GL_nbc_gl_apply_rotate_y,    __GL_objectAction.type, GL_ROTATE_Y
  brcmp    EQ,                     __GL_nbc_gl_apply_rotate_z,    __GL_objectAction.type, GL_ROTATE_Z
  brcmp    EQ,                     __GL_nbc_gl_apply_scale_x,     __GL_objectAction.type, GL_SCALE_X
  brcmp    EQ,                     __GL_nbc_gl_apply_scale_y,     __GL_objectAction.type, GL_SCALE_Y
  brcmp    EQ,                     __GL_nbc_gl_apply_scale_z,     __GL_objectAction.type, GL_SCALE_Z
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_translate_x:
  add      __GL_vertex0.rot.x,     __GL_vertex0.rot.x, __GL_objectAction.value
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_translate_y:
  add      __GL_vertex0.rot.y,     __GL_vertex0.rot.y, __GL_objectAction.value
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_translate_z:
  add      __GL_vertex0.rot.z,     __GL_vertex0.rot.z, __GL_objectAction.value
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_rotate_x:
  mul      __GL_a,                 __GL_objectAction.lcos, __GL_vertex0.rot.y
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lsin, __GL_vertex0.rot.z
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_c,                 __GL_a, __GL_b
  mul      __GL_a,                 __GL_objectAction.lsin, __GL_vertex0.rot.y
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lcos, __GL_vertex0.rot.z
  shr      __GL_b,                 __GL_b, 15
  add      __GL_d,                 __GL_a, __GL_b
  mov      __GL_vertex0.rot.y,     __GL_c
  mov      __GL_vertex0.rot.z,     __GL_d
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_rotate_y:
  mul      __GL_a,                 __GL_objectAction.lsin, __GL_vertex0.rot.z
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lcos, __GL_vertex0.rot.x
  shr      __GL_b,                 __GL_b, 15
  add      __GL_c,                 __GL_a, __GL_b
  mul      __GL_a,                 __GL_objectAction.lcos, __GL_vertex0.rot.z
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lsin, __GL_vertex0.rot.x
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_d,                 __GL_a, __GL_b
  mov      __GL_vertex0.rot.x,     __GL_c
  mov      __GL_vertex0.rot.z,     __GL_d
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_rotate_z:
  mul      __GL_a,                 __GL_objectAction.lcos, __GL_vertex0.rot.x
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lsin, __GL_vertex0.rot.y
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_c,                 __GL_a, __GL_b
  mul      __GL_a,                 __GL_objectAction.lsin, __GL_vertex0.rot.x
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_objectAction.lcos, __GL_vertex0.rot.y
  shr      __GL_b,                 __GL_b, 15
  add      __GL_d,                 __GL_a, __GL_b
  mov      __GL_vertex0.rot.x,     __GL_c
  mov      __GL_vertex0.rot.y,     __GL_d
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_scale_x:
  mul      __GL_vertex0.rot.x,     __GL_vertex0.rot.x, __GL_objectAction.value
  shr      __GL_vertex0.rot.x,     __GL_vertex0.rot.x, 8
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_scale_y:
  mul      __GL_vertex0.rot.y,     __GL_vertex0.rot.y, __GL_objectAction.value
  shr      __GL_vertex0.rot.y,     __GL_vertex0.rot.y, 8
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_scale_z:
  mul      __GL_vertex0.rot.z,     __GL_vertex0.rot.z, __GL_objectAction.value
  shr      __GL_vertex0.rot.z,     __GL_vertex0.rot.z, 8
  jmp      __GL_nbc_gl_apply_done
__GL_nbc_gl_apply_done:
  add      __GL_j,                 __GL_j, 1
  brcmp    LT,                     __GL_nbc_gl_apply_next_action, __GL_j, __GL_object.actionCount
__GL_nbc_gl_no_actions:
  replace  __GL_vertexData,        __GL_vertexData, __GL_i, __GL_vertex0
  add      __GL_i,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_apply_next_vertex, __GL_i, __GL_object.lastVertex
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glRotateVertexList
// Description : Rotate all the vertices in the vertext list...
//-----------------------------------------------------------------------------------------
subroutine __GL_glRotateVertexList
  // update all object actions first...
  set      __GL_l,                 0
__GL_nbc_gl_rotate_objects:
  index    __GL_object,            __GL_objectData, __GL_l
  brcmp    EQ,                     __GL_nbc_gl_dont_rotate_object, __GL_object.render, FALSE
  call     __GL_glRotateObject
__GL_nbc_gl_dont_rotate_object:
  add      __GL_l,                 __GL_l, 1
  brcmp    LT,                     __GL_nbc_gl_rotate_objects, __GL_l, __GL_objectCount
  mov      __GL_saveAngleX,        __GL_angleX
  mov      __GL_saveAngleY,        __GL_angleY
  index    __GL_sinX,              __GL_SIN_TABLE, __GL_angleX
  add      __GL_angleX,            __GL_angleX, 90
  mod      __GL_angleX,            __GL_angleX, 360
  index    __GL_cosX,              __GL_SIN_TABLE, __GL_angleX
  index    __GL_sinY,              __GL_SIN_TABLE, __GL_angleY
  add      __GL_angleY,            __GL_angleY, 90
  mod      __GL_angleY,            __GL_angleY, 360
  index    __GL_cosY,              __GL_SIN_TABLE, __GL_angleY
  mov      __GL_camDepth,          __GL_glSettings.camDepth
  mov      __GL_zoom,              __GL_glSettings.zoom
  set      __GL_i,                 0
  set      __GL_vertexOffset,      0
__GL_nbc_gl_rotate_loop:
  // get the values from the vertex list...
  index    __GL_vertex0,           __GL_vertexData, __GL_vertexOffset
  // z1 = (_vertex0.rot.z * _cosY) - (_vertex0.rot.x * _sinY)
  mul      __GL_a,                 __GL_vertex0.rot.z, __GL_cosY
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_vertex0.rot.x, __GL_sinY
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_z1,                __GL_a, __GL_b
  // xx = (_vertex0.rot.z * _sinY) + (_vertex0.rot.x * _cosY)
  mul      __GL_a,                 __GL_vertex0.rot.z, __GL_sinY
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_vertex0.rot.x, __GL_cosY
  shr      __GL_b,                 __GL_b, 15
  add      __GL_xx,                __GL_a, __GL_b
  // zz = (_vertex0.rot.y * _sinX) + (_z1 * _cosX) + _zoom
  mul      __GL_a,                 __GL_vertex0.rot.y, __GL_sinX
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_z1, __GL_cosX
  shr      __GL_b,                 __GL_b, 15
  add      __GL_zz,                __GL_a, __GL_b
  add      __GL_zz,                __GL_zz, __GL_zoom
  // yy = (_vertex0.rot.y * cosX) - (z1 * sinX)
  mul      __GL_a,                 __GL_vertex0.rot.y, __GL_cosX
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_z1, __GL_sinX
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_yy,                __GL_a, __GL_b
  // the actual screen coords...
  add      __GL_zz,                __GL_zz, __GL_camDepth
  // _vertex0.screen.sx = width  + (x * camDepth) / (zz + camDepth))
  // _vertex0.screen.sy = height - (y * camDepth) / (zz + camDepth))
  mul      __GL_vertex0.screen.x,  __GL_xx, __GL_camDepth
  div      __GL_vertex0.screen.x,  __GL_vertex0.screen.x, __GL_zz
  add      __GL_vertex0.screen.x,  __GL_vertex0.screen.x, 50
  mul      __GL_vertex0.screen.y,  __GL_yy, __GL_camDepth
  div      __GL_vertex0.screen.y,  __GL_vertex0.screen.y, __GL_zz
  sub      __GL_vertex0.screen.y,  32, __GL_vertex0.screen.y
  // save the screen coords...
  replace  __GL_vertexData,        __GL_vertexData, __GL_vertexOffset, __GL_vertex0
  add      __GL_vertexOffset,      __GL_vertexOffset, 1
  add      __GL_i,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_rotate_loop, __GL_i, __GL_vertexCount
  mov      __GL_angleX,            __GL_saveAngleX
  mov      __GL_angleY,            __GL_saveAngleY
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glResetObjects
// Description : Reset the rotate, translate and scale actions for all objects...
//-----------------------------------------------------------------------------------------
subroutine __GL_glResetObjects
  set      __GL_glLinesClipped,     0
  brcmp    EQ,                      __GL_nbc_gl_reset_objects_error, __GL_glErrorState, TRUE
  arrinit  __GL_lineDone,           0, __GL_lineCount
  set      __GL_objectActionCount,  0
  set      __GL_i,                  0
__GL_nbc_gl_reset_actions:
  index    __GL_object,             __GL_objectData, __GL_i
  set      __GL_object.actionCount, 0
  set      __GL_object.render,      FALSE
  replace  __GL_objectData,         __GL_objectData, __GL_i, __GL_object
  add      __GL_i,                  __GL_i, 1
  brcmp    LT,                      __GL_nbc_gl_reset_actions, __GL_i, __GL_objectCount
__GL_nbc_gl_reset_objects_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glCallObject
// Description : Set the render boolean, copy the settings...
//-----------------------------------------------------------------------------------------
subroutine __GL_glCallObject
  brcmp    EQ,                     __GL_nbc_gl_call_object_error, __GL_glErrorState, TRUE
  index    __GL_object,            __GL_objectData, __GL_objectIndex
  set      __GL_object.render,     TRUE
  mov      __GL_object.cullMode,   __GL_glSettings.cullMode
  mov      __GL_object.circleSize, __GL_glSettings.circleSize
  replace  __GL_objectData,        __GL_objectData, __GL_objectIndex, __GL_object
__GL_nbc_gl_call_object_error:
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glDrawObject
// Description : Draw the object, this routine expects the '_object' struct to be set.
//-----------------------------------------------------------------------------------------
subroutine __GL_glDrawObject
  // set once...
  mov      __GL_glDrawLine.Options,     0
  // loop through the polygon list for this object...
  mov      __GL_i,                      __GL_object.firstPolygon
__GL_nbc_gl_draw_polygons:
  // get the information for the polygon...
  index    __GL_polygon,                __GL_polygonData, __GL_i
  brcmp    EQ,                          __GL_nbc_gl_render_polygon, __GL_polygon.beginMode, GL_POLYGON
  brcmp    EQ,                          __GL_nbc_gl_render_line,    __GL_polygon.beginMode, GL_LINE
  brcmp    EQ,                          __GL_nbc_gl_render_point,   __GL_polygon.beginMode, GL_POINT
  brcmp    EQ,                          __GL_nbc_gl_render_circle,  __GL_polygon.beginMode, GL_CIRCLE
  jmp      __GL_nbc_gl_cull_polygon
  //---------------------------------------------------------------------------------------
  // Render a polygon...
  //---------------------------------------------------------------------------------------
__GL_nbc_gl_render_polygon:
  // loop through the vertex list for this polygon...
  mov      __GL_j,                      __GL_polygon.firstVertex
  mov      __GL_k,                      __GL_polygon.lastVertex
  // _vertex0 = _vertexData[_pvData[j]]
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex0,                __GL_vertexData, __GL_vertexOffset
  // _vertex1 = _vertexData[_pvData[j + 1]]
  add      __GL_j,                      __GL_j, 1
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex1,                __GL_vertexData, __GL_vertexOffset
  // _vertex2 = _vertexData[_pvData[j + 2]]
  add      __GL_j,                      __GL_j, 1
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex2,                __GL_vertexData, __GL_vertexOffset
  // check if culling is enabled...
  brcmp    EQ,                          __GL_nbc_gl_no_culling, __GL_object.cullMode, GL_CULL_NONE
  // calculate the culling...
  // ((x1 - x0) * (y2 - y0) >= (x2 - x0) * (y1 - y0))
  sub      __GL_a,                      __GL_vertex1.screen.x, __GL_vertex0.screen.x
  sub      __GL_b,                      __GL_vertex2.screen.y, __GL_vertex0.screen.y
  mul      __GL_c,                      __GL_a, __GL_b
  sub      __GL_d,                      __GL_vertex2.screen.x, __GL_vertex0.screen.x
  sub      __GL_e,                      __GL_vertex1.screen.y, __GL_vertex0.screen.y
  mul      __GL_f,                      __GL_d, __GL_e
  // check if culling is enabled...
  brcmp    EQ,                          __GL_nbc_gl_check_front_cull, __GL_object.cullMode, GL_CULL_FRONT
  brcmp    GTEQ,                        __GL_nbc_gl_cull_polygon, __GL_c, __GL_f
  jmp      __GL_nbc_gl_no_culling
__GL_nbc_gl_check_front_cull:
  brcmp    GTEQ,                        __GL_nbc_gl_cull_polygon, __GL_f, __GL_c
__GL_nbc_gl_no_culling:
  //--> render the lines...
  mov      __GL_j,                      __GL_polygon.firstLine
__GL_nbc_gl_draw_lines:
  // _k = _plData[_j]
  index    __GL_k,                      __GL_plData, __GL_j
  // render every line only once!
  // _l = _lineDone[_k]
  index    __GL_l,                      __GL_lineDone, __GL_k
  brcmp    EQ,                          __GL_nbc_gl_line_done, __GL_l, 1
  // set the 'done' byte...
  replace  __GL_lineDone,               __GL_lineDone, 1, __GL_l
  // _line = _lineData[_k]
  index    __GL_line,                   __GL_lineData, __GL_k
  // _vertex1 = _vertexData[_line.firstVertex]
  index    __GL_vertex1,                __GL_vertexData, __GL_line.firstVertex
  // _vertex1 = _vertexData[_line.lastVertex]
  index    __GL_vertex2,                __GL_vertexData, __GL_line.lastVertex
  // very crude clipping...
//  add      __GL_glLinesClipped,         __GL_glLinesClipped, 1
//  brcmp    LT,                          __GL_nbc_gl_line_done, __GL_vertex1.screen.x,  0
//  brcmp    LT,                          __GL_nbc_gl_line_done, __GL_vertex2.screen.x,  0
//  brcmp    LT,                          __GL_nbc_gl_line_done, __GL_vertex1.screen.y,  0
//  brcmp    LT,                          __GL_nbc_gl_line_done, __GL_vertex2.screen.y,  0
//  brcmp    GT,                          __GL_nbc_gl_line_done, __GL_vertex1.screen.x, 99
//  brcmp    GT,                          __GL_nbc_gl_line_done, __GL_vertex2.screen.x, 99
//  brcmp    GT,                          __GL_nbc_gl_line_done, __GL_vertex1.screen.y, 63
//  brcmp    GT,                          __GL_nbc_gl_line_done, __GL_vertex2.screen.y, 63
//  sub      __GL_glLinesClipped,         __GL_glLinesClipped, 1
//  mov      __GL_glDrawLine.StartLoc.X,  __GL_vertex1.screen.x
//  mov      __GL_glDrawLine.StartLoc.Y,  __GL_vertex1.screen.y
//  mov      __GL_glDrawLine.EndLoc.X,    __GL_vertex2.screen.x
//  mov      __GL_glDrawLine.EndLoc.Y,    __GL_vertex2.screen.y
  mov      __GL_glDrawLine.StartLoc,    __GL_vertex1.screen
  mov      __GL_glDrawLine.EndLoc,      __GL_vertex2.screen
  syscall  DrawLine,                    __GL_glDrawLine
__GL_nbc_gl_line_done:
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_draw_lines, __GL_j, __GL_polygon.lastLine
  //<-- render the lines...
/*
  mov      __GL_minX,                  1000
  mov      __GL_maxX,                 -1000

  set      __GL_a,                     0
__GL_nbc_gl_polygon_loop:
  add      __GL_b,                     __GL_a, 1

  brcmp    LT,                         __GL_nbc_gl_modb, __GL_b, __GL_polygon.lastVertex
  mov      __GL_b,                     __GL_polygon.firstVertex
__GL_nbc_gl_modb:

  // _vertex1 = _vertexData[_pvData[_a]]
  index    __GL_vertexOffset,          __GL_pvData, __GL_a
  index    __GL_vertex1,               __GL_vertexData, __GL_vertexOffset
  // _vertex1 = _vertexData[_pvData[_b]]
  index    __GL_vertexOffset,          __GL_pvData, __GL_b
  index    __GL_vertex2,               __GL_vertexData, __GL_vertexOffset

  brcmp    GTEQ,                       __GL_nbc_gl_minx1, __GL_vertex1.screen.x, __GL_minX
  mov      __GL_minX,                  __GL_vertex1.screen.x
__GL_nbc_gl_minx1:
  brcmp    GTEQ,                       __GL_nbc_gl_minx2, __GL_vertex2.screen.x, __GL_minX
  mov      __GL_minX,                  __GL_vertex2.screen.x
__GL_nbc_gl_minx2:

  brcmp    LTEQ,                       __GL_nbc_gl_maxx1, __GL_vertex1.screen.x, __GL_maxX
  mov      __GL_maxX,                  __GL_vertex1.screen.x
__GL_nbc_gl_maxx1:
  brcmp    LTEQ,                       __GL_nbc_gl_maxx2, __GL_vertex2.screen.x, __GL_maxX
  mov      __GL_maxX,                  __GL_vertex2.screen.x
__GL_nbc_gl_maxx2:

  mov      __GL_index,                 0

  mov      __GL_startY,                __GL_vertex1.screen.y
  mov      __GL_startX,                __GL_vertex1.screen.x
  mov      __GL_endY,                  __GL_vertex2.screen.y
  mov      __GL_endX,                  __GL_vertex2.screen.x

  brcmp    GTEQ,                       __GL_nbc_gl_polygon_flip, __GL_endX, __GL_startX
  mov      __GL_startY,                __GL_vertex2.screen.y
  mov      __GL_startX,                __GL_vertex2.screen.x
  mov      __GL_endY,                  __GL_vertex1.screen.y
  mov      __GL_endX,                  __GL_vertex1.screen.x
  mov      __GL_index,                 100
__GL_nbc_gl_polygon_flip:

  sub      __GL_deltaY,                __GL_endY, __GL_startY
  sub      __GL_deltaX,                __GL_endX, __GL_startX

  mov      __GL_c,                     __GL_startX
__GL_nbc_gl_polygon_line:
  add      __GL_offset,                __GL_c, __GL_index

  // _startY + _deltaY * (_c - _startX) / _deltaX
  sub      __GL_value,                 __GL_c, __GL_startX
  mul      __GL_value,                 __GL_value, __GL_deltaY
  div      __GL_value,                 __GL_value, __GL_deltaX
  add      __GL_value,                 __GL_value, __GL_startY

  replace  __GL_buffer,                __GL_buffer, __GL_offset, __GL_value

  add      __GL_c,                     __GL_c, 1
  brcmp    LTEQ                        __GL_nbc_gl_polygon_line, __GL_c, __GL_endX

  add      __GL_a,                     __GL_a, 1
  brcmp    LT                          __GL_nbc_gl_polygon_loop, __GL_a, __GL_polygon.lastVertex

  mov      __GL_a,                     __GL_minX
__GL_nbc_gl_polygon_lines:
  index    __GL_startY,                __GL_buffer, __GL_a
  add      __GL_b,                     __GL_a, 100
  index    __GL_endY,                  __GL_buffer, __GL_b

  mov      __GL_glDrawLine.Options,    0
  mov      __GL_glDrawLine.StartLoc.X, __GL_a
  mov      __GL_glDrawLine.StartLoc.Y, __GL_startY
  mov      __GL_glDrawLine.EndLoc.X,   __GL_a
  mov      __GL_glDrawLine.EndLoc.Y,   __GL_endY
  syscall  DrawLine,                   __GL_glDrawLine

  add      __GL_a,                     __GL_a, 1
  brcmp    LTEQ,                       __GL_nbc_gl_polygon_lines, __GL_a, __GL_maxX
*/
  jmp      __GL_nbc_gl_cull_polygon
  //---------------------------------------------------------------------------------------
  // Render lines...
  //---------------------------------------------------------------------------------------
__GL_nbc_gl_render_line:
  mov      __GL_j,                      __GL_polygon.firstLine
__GL_nbc_gl_render_lines:
  // _k = _plData[_j]
  index    __GL_k,                      __GL_plData, __GL_j
  // render every line only once!
  // _l = _lineDone[_k]
  index    __GL_l,                      __GL_lineDone, __GL_k
  brcmp    EQ,                          __GL_nbc_gl_render_lines_done, __GL_l, 1
  // set the 'done' byte...
  replace  __GL_lineDone,               __GL_lineDone, 1, __GL_l
  // _line = _lineData[_k]
  index    __GL_line,                   __GL_lineData, __GL_k
  // _vertex1 = _vertexData[_line.firstVertex]
  // _vertex2 = _vertexData[_line.lastVertex]
  index    __GL_vertex1,                __GL_vertexData, __GL_line.firstVertex
  index    __GL_vertex2,                __GL_vertexData, __GL_line.lastVertex
  mov      __GL_glDrawLine.StartLoc,    __GL_vertex1.screen
  mov      __GL_glDrawLine.EndLoc,      __GL_vertex2.screen
//  mov      __GL_glDrawLine.StartLoc.X,  __GL_vertex1.screen.x
//  mov      __GL_glDrawLine.StartLoc.Y,  __GL_vertex1.screen.y
//  mov      __GL_glDrawLine.EndLoc.X,    __GL_vertex2.screen.x
//  mov      __GL_glDrawLine.EndLoc.Y,    __GL_vertex2.screen.y
  syscall  DrawLine,                    __GL_glDrawLine
__GL_nbc_gl_render_lines_done:
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_render_lines, __GL_j, __GL_polygon.lastLine
  jmp      __GL_nbc_gl_cull_polygon
  //---------------------------------------------------------------------------------------
  // Render points...
  //---------------------------------------------------------------------------------------
__GL_nbc_gl_render_point:
  set      __GL_glDrawPoint.Options,    0
  mov      __GL_j,                      __GL_polygon.firstVertex
__GL_nbc_gl_render_points:
  // _vertex0 = _vertexData[_pvData[j]]
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex0,                __GL_vertexData, __GL_vertexOffset
  mov      __GL_glDrawPoint.Location,   __GL_vertex0.screen
//  mov      __GL_glDrawPoint.Location.X, __GL_vertex0.screen.x
//  mov      __GL_glDrawPoint.Location.Y, __GL_vertex0.screen.y
  syscall  DrawPoint,                   __GL_glDrawPoint
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_render_points, __GL_j, __GL_polygon.lastVertex
  jmp      __GL_nbc_gl_cull_polygon
  //---------------------------------------------------------------------------------------
  // Render circle...
  //---------------------------------------------------------------------------------------
__GL_nbc_gl_render_circle:
  set      __GL_glDrawCircle.Options,   0
  mov      __GL_glDrawCircle.Size,      __GL_object.circleSize
  mov      __GL_j,                      __GL_polygon.firstVertex
__GL_nbc_gl_render_circles:
  // _vertex0 = _vertexData[_pvData[j]]
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex0,                __GL_vertexData, __GL_vertexOffset
  mov      __GL_glDrawCircle.Center,    __GL_vertex0.screen
//  mov      __GL_glDrawCircle.Center.X,  __GL_vertex0.screen.x
//  mov      __GL_glDrawCircle.Center.Y,  __GL_vertex0.screen.y
  syscall  DrawCircle,                  __GL_glDrawCircle
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_render_circles, __GL_j, __GL_polygon.lastVertex
  jmp      __GL_nbc_gl_cull_polygon
__GL_nbc_gl_cull_polygon:
  add      __GL_i,                      __GL_i, 1
  brcmp    LT,                          __GL_nbc_gl_draw_polygons, __GL_i, __GL_object.lastPolygon
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glRenderObjects
// Description : Draw all objects which have been called...
//-----------------------------------------------------------------------------------------
subroutine __GL_glRenderObjects
  brcmp    EQ,                          __GL_nbc_gl_render_objects_error, __GL_glErrorState, TRUE
  set      __GL_objectIndex,            0
__GL_nbc_gl_render_objects:
  // get the information for the object...
  index    __GL_object,                 __GL_objectData, __GL_objectIndex
  brcmp    EQ,                          __GL_nbc_gl_dont_render_object, __GL_object.render, FALSE
  call     __GL_glDrawObject
__GL_nbc_gl_dont_render_object:
  add      __GL_objectIndex,            __GL_objectIndex, 1
  brcmp    LT,                          __GL_nbc_gl_render_objects, __GL_objectIndex, __GL_objectCount
  return
__GL_nbc_gl_render_objects_error:
  // Display the error message...
  set       __GL_glDrawData.Options,    1
  set       __GL_glDrawData.Location.X, 0
  set       __GL_glDrawData.Location.Y, 56
  mov       __GL_glDrawData.Text,       'Error:'
  syscall   DrawText,                   __GL_glDrawData
  set       __GL_glDrawData.Options,    0
  set       __GL_glDrawData.Location.Y, 48
  mov       __GL_glDrawData.Text,       __GL_glErrorMsg
  syscall   DrawText,                   __GL_glDrawData
  return
ends

dseg segment
  __GL_tmpId             byte
  __GL_mode              byte
  __GL_sizeX             sdword
  __GL_sizeY             sdword
  __GL_sizeZ             sdword
  __GL_angle             sdword
dseg ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glBox
// Description : Add a box with the dimensions: _sizeX, _sizeY, _sizeZ.
//               Use mode _mode.
//-----------------------------------------------------------------------------------------
subroutine __GL_glBox
  shr      __GL_x1,                    __GL_sizeX, 1
  neg      __GL_x0,                    __GL_x1
  shr      __GL_y1,                    __GL_sizeY, 1
  neg      __GL_y0,                    __GL_y1
  shr      __GL_z1,                    __GL_sizeZ, 1
  neg      __GL_z0,                    __GL_z1
  __glBeginObject(__GL_tmpId)
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z0)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z0)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z0)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z1)
    __glEnd()

    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z0)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z0)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z0)
    __glEnd()

    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z0)
      __glAddVertex(__GL_x0, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z1)
      __glAddVertex(__GL_x1, __GL_y0, __GL_z0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z0)
      __glAddVertex(__GL_x1, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z1)
      __glAddVertex(__GL_x0, __GL_y1, __GL_z0)
    __glEnd()
  __glEndObject()
  return
ends

//-----------------------------------------------------------------------------------------
// Subroutine  : __GL_glPyramid
// Description : Add a pyramid with the dimensions: _sizeX, _sizeY, _sizeZ.
//               Use mode _mode.
//-----------------------------------------------------------------------------------------
subroutine __GL_glPyramid
  shr      __GL_x1,                    __GL_sizeX, 1
  neg      __GL_x0,                    __GL_x1
  shr      __GL_z1,                    __GL_sizeZ, 1
  neg      __GL_z0,                    __GL_z1
  neg      __GL_y0,                    __GL_sizeY
  __glBeginObject(__GL_tmpId)
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, 0, __GL_z0)
      __glAddVertex(__GL_x1, 0, __GL_z1)
      __glAddVertex(__GL_x0, 0, __GL_z1)
      __glAddVertex(__GL_x0, 0, __GL_z0)
    __glEnd()

    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, 0,   __GL_z0)
      __glAddVertex(__GL_x0, 0,   __GL_z1)
      __glAddVertex(0,   __GL_y0, 0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, 0,   __GL_z1)
      __glAddVertex(__GL_x1, 0,   __GL_z0)
      __glAddVertex(0,   __GL_y0, 0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x1, 0,   __GL_z0)
      __glAddVertex(__GL_x0, 0,   __GL_z0)
      __glAddVertex(0,   __GL_y0, 0)
    __glEnd()
    __glBegin(__GL_mode)
      __glAddVertex(__GL_x0, 0,   __GL_z1)
      __glAddVertex(__GL_x1, 0,   __GL_z1)
      __glAddVertex(0,   __GL_y0, 0)
    __glEnd()
  __glEndObject()
  return
ends

// no documentation for these functions since they are essentially readonly
#define SetLSInputBuffer(_p, _offset, _cnt, _data) __setLSInputBuffer(_p, _offset, _cnt, _data)
#define SetLSInputBufferInPtr(_p, _n) __setLSInputBufferInPtr(_p, _n)
#define SetLSInputBufferOutPtr(_p, _n) __setLSInputBufferOutPtr(_p, _n)
#define SetLSInputBufferBytesToRx(_p, _n) __setLSInputBufferBytesToRx(_p, _n)

#define SetLSOutputBuffer(_p, _offset, _cnt, _data) __setLSOutputBuffer(_p, _offset, _cnt, _data)
#define SetLSOutputBufferInPtr(_p, _n) __setLSOutputBufferInPtr(_p, _n)
#define SetLSOutputBufferOutPtr(_p, _n) __setLSOutputBufferOutPtr(_p, _n)
#define SetLSOutputBufferBytesToRx(_p, _n) __setLSOutputBufferBytesToRx(_p, _n)

#define SetLSMode(_p, _n) __setLSMode(_p, _n)
#define SetLSChannelState(_p, _n) __setLSChannelState(_p, _n)
#define SetLSErrorType(_p, _n) __setLSErrorType(_p, _n)
#define SetLSState(_n) __setLSState(_n)
#define SetLSSpeed(_n) __setLSSpeed(_n)

#ifdef __ENHANCED_FIRMWARE
#define SetLSNoRestartOnRead(_n) __setLSNoRestartOnRead(_n)
#endif

// these functions really cannot be used for any useful purpose (read-only)
#define SetBTDeviceName(_p, _str) __setBTDeviceName(_p, _str)
#define SetBTDeviceAddress(_p, _btaddr) __setBTDeviceAddress(_p, _btaddr)
#define SetBTConnectionName(_p, _str) __setBTConnectionName(_p, _str)
#define SetBTConnectionPinCode(_p, _code) __setBTConnectionPinCode(_p, _code)
#define SetBTConnectionAddress(_p, _btaddr) __setBTConnectionAddress(_p, _btaddr)
#define SetBrickDataName(_str) SetCommModuleBytes(CommOffsetBrickDataName, 16, _str)
#define SetBrickDataAddress(_btaddr) SetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _btaddr)
#define SetBTDeviceClass(_p, _n) __setBTDeviceClass(_p, _n)
#define SetBTDeviceStatus(_p, _n) __setBTDeviceStatus(_p, _n)
#define SetBTConnectionClass(_p, _n) __setBTConnectionClass(_p, _n)
#define SetBTConnectionHandleNum(_p, _n) __setBTConnectionHandleNum(_p, _n)
#define SetBTConnectionStreamStatus(_p, _n) __setBTConnectionStreamStatus(_p, _n)
#define SetBTConnectionLinkQuality(_p, _n) __setBTConnectionLinkQuality(_p, _n)
#define SetBrickDataBluecoreVersion(_n) __setBrickDataBluecoreVersion(_n)
#define SetBrickDataBtStateStatus(_n) __setBrickDataBtStateStatus(_n)
#define SetBrickDataBtHardwareStatus(_n) __setBrickDataBtHardwareStatus(_n)
#define SetBrickDataTimeoutValue(_n) __setBrickDataTimeoutValue(_n)
#define SetBTDeviceCount(_n) __setBTDeviceCount(_n)
#define SetBTDeviceNameCount(_n) __setBTDeviceNameCount(_n)

// not ready to be documented
#define SpawnProgram(_fname) __spawnProgram(_fname)

// standard firmware math functions written by Tamas Sorosy (www.sorosy.com)

// X is any integer, Y is the sqrt value (0->max), if X<0, Y is the sqrt value of absolute X
#define Sqrt(_X,_R) __SQRT(_X,_R)

// X is any integer in degrees, Y is 100* the sin value (-100->100)
#define Sin(_X,_R) __SIN(_X,_R)

// X is any integer in degrees, Y is 100* the cos value (-100->100)
#define Cos(_X,_R) __COS(_X,_R)

// X is 100* the sin value (-100->100), Y is -90->90, Y is 101 if X is outside -100->100 range
#define Asin(_X,_R) __ASIN(_X,_R)

// X is 100* the cos value (-100->100), Y is 0->180, Y is -11 if X is outside -100->100 range
#define Acos(_X,_R) __ACOS(_X,_R)


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


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// OUTPUT MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup OutputModule
 * @{
 */
/** @defgroup OutputModuleFunctions Output module functions
 * Functions for accessing and modifying output module features.
 * @{
 */
/**
 * Reset tachometer counter.
 * Reset the tachometer count and tachometer limit goal for the specified
 * outputs.
 *
 * \param _p Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
#define ResetTachoCount(_p) __resetTachoCount(_p)

/**
 * Reset block-relative counter.
 * Reset the block-relative position counter for the specified outputs.
 *
 * \param _p Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
#define ResetBlockTachoCount(_p) __resetBlockTachoCount(_p)

/**
 * Reset program-relative counter.
 * Reset the program-relative position counter for the specified outputs.
 *
 * \param _p Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
#define ResetRotationCount(_p) __resetRotationCount(_p)

/**
 * Reset all tachometer counters.
 * Reset all three position counters and reset the current tachometer limit
 * goal for the specified outputs.
 *
 * \param _p Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. For multiple outputs at the same time
 * you need to add single output port values into a byte array and pass the array
 * instead of a single numeric value.
 */
#define ResetAllTachoCounts(_p) __resetAllTachoCounts(_p)

/**
 * Run motors forward and reset counters.
 * Set outputs to forward direction and turn them on.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnFwdEx(_ports, _pwr, _reset) __OnFwdEx(_ports, _pwr, _reset)

/**
 * Run motors backward and reset counters.
 * Set outputs to reverse direction and turn them on.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnRevEx(_ports, _pwr, _reset) __OnRevEx(_ports, _pwr, _reset)

/**
 * Run motors forward and reset counters.
 * Set outputs to forward direction and turn them on.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdExPID(_ports, _pwr, _reset, _p, _i, _d) __OnFwdExPID(_ports, _pwr, _reset, _p, _i, _d)

/**
 * Run motors backward and reset counters.
 * Set outputs to reverse direction and turn them on.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevExPID(_ports, _pwr, _reset, _p, _i, _d) __OnRevExPID(_ports, _pwr, _reset, _p, _i, _d)

/**
 * Run motors forward.
 * Set outputs to forward direction and turn them on.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 */
#define OnFwd(_ports, _pwr) OnFwdEx(_ports, _pwr, RESET_BLOCKANDTACHO)

/**
 * Run motors backward.
 * Set outputs to reverse direction and turn them on.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 */
#define OnRev(_ports, _pwr) OnRevEx(_ports, _pwr, RESET_BLOCKANDTACHO)

/**
 * Coast motors and reset counters.
 * Turn off the specified outputs, making them coast to a stop.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define CoastEx(_ports, _reset) __CoastEx(_ports, _reset)

/**
 * Turn motors off and reset counters.
 * Turn the specified outputs off (with braking).
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OffEx(_ports, _reset) __OffEx(_ports, _reset)

/**
 * Coast motors.
 * Turn off the specified outputs, making them coast to a stop.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
#define Coast(_ports) CoastEx(_ports, RESET_BLOCKANDTACHO)

/**
 * Turn motors off.
 * Turn the specified outputs off (with braking).
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
#define Off(_ports) OffEx(_ports, RESET_BLOCKANDTACHO)

/**
 * Float motors.
 * Make outputs float. Float is an alias for Coast.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 */
#define Float(_ports) Coast(_ports)

/**
 * Run motors forward regulated and reset counters.
 * Run the specified outputs forward using the specified regulation mode.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnFwdRegEx(_ports, _pwr, _regmode, _reset) __OnFwdRegEx(_ports, _pwr, _regmode, _reset)

/**
 * Run motors backward regulated and reset counters.
 * Run the specified outputs in reverse using the specified regulation mode.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnRevRegEx(_ports, _pwr, _regmode, _reset) __OnRevRegEx(_ports, _pwr, _regmode, _reset)

/**
 * Run motors forward regulated and reset counters with PID factors.
 * Run the specified outputs forward using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) __OnFwdRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d)

/**
 * Run motors backward regulated and reset counters with PID factors.
 * Run the specified outputs in reverse using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) __OnRevRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d)

/**
 * Run motors forward regulated.
 * Run the specified outputs forward using the specified regulation mode.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 */
#define OnFwdReg(_ports, _pwr, _regmode) OnFwdRegEx(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO)

/**
 * Run motors forward regulated.
 * Run the specified outputs in reverse using the specified regulation mode.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 */
#define OnRevReg(_ports, _pwr, _regmode) OnRevRegEx(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO)

/**
 * Run motors forward regulated with PID factors.
 * Run the specified outputs forward using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdRegPID(_ports, _pwr, _regmode, _p, _i, _d) OnFwdRegExPID(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO, _p, _i, _d)

/**
 * Run motors reverse regulated with PID factors.
 * Run the specified outputs in reverse using the specified regulation mode.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _regmode Regulation mode, see \ref OutRegModeConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevRegPID(_ports, _pwr, _regmode, _p, _i, _d) OnRevRegExPID(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO, _p, _i, _d)

/**
 * Run motors forward synchronised and reset counters.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnFwdSyncEx(_ports, _pwr, _turnpct, _reset) __OnFwdSyncEx(_ports, _pwr, _turnpct, _reset)

/**
 * Run motors backward synchronised and reset counters.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 */
#define OnRevSyncEx(_ports, _pwr, _turnpct, _reset) __OnRevSyncEx(_ports, _pwr, _turnpct, _reset)

/**
 * Run motors forward synchronised and reset counters with PID factors.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) __OnFwdSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d)

/**
 * Run motors backward synchronised and reset counters with PID factors.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _reset Position counters reset control. It must be a constant, see
 * \ref TachoResetConstants.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) __OnRevSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d)

/**
 * Run motors forward synchronised.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 */
#define OnFwdSync(_ports, _pwr, _turnpct) OnFwdSyncEx(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO)

/**
 * Run motors backward synchronised.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 */
#define OnRevSync(_ports, _pwr, _turnpct) OnRevSyncEx(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO)

/**
 * Run motors forward synchronised with PID factors.
 * Run the specified outputs forward with regulated synchronization using the
 * specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnFwdSyncPID(_ports, _pwr, _turnpct, _p, _i, _d) OnFwdSyncExPID(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO, _p, _i, _d)

/**
 * Run motors backward synchronised with PID factors.
 * Run the specified outputs in reverse with regulated synchronization using
 * the specified turn ratio.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define OnRevSyncPID(_ports, _pwr, _turnpct, _p, _i, _d) OnRevSyncExPID(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO, _p, _i, _d)

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _angle Angle limit, in degree. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _bSync Synchronise two motors. Should be set to true if a non-zero
 * turn percent is specified or no turning will occur.
 * \param _bStop Specify whether the motor(s) should brake at the end of the
 * rotation.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   __RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d)

// default PID values are 96, 32, 32 (PID_3, PID_1, PID_1)

/**
 * Rotate motor with PID factors.
 * Run the specified outputs forward for the specified number of degrees.
 * Specify proportional, integral, and derivative factors.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _angle Angle limit, in degree. Can be negative to reverse direction.
 * \param _p Proportional factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _i Integral factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 * \param _d Derivative factor used by the firmware's PID motor control
 * algorithm. See \ref PIDConstants.
 */
#define RotateMotorPID(_ports, _pwr, _angle, _p, _i, _d) \
   __RotateMotorExPID(_ports, _pwr, _angle, 0, FALSE, TRUE, _p, _i, _d)

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _angle Angle limit, in degree. Can be negative to reverse direction.
 * \param _turnpct Turn ratio, -100 to 100. The direction of your vehicle will
 * depend on its construction.
 * \param _bSync Synchronise two motors. Should be set to true if a non-zero
 * turn percent is specified or no turning will occur.
 * \param _bStop Specify whether the motor(s) should brake at the end of the
 * rotation.
 */
#define RotateMotorEx(_ports, _pwr, _angle, _turnpct, _bSync, _bStop) \
   __RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, PID_1, PID_0, PID_3)

/**
 * Rotate motor.
 * Run the specified outputs forward for the specified number of degrees.
 *
 * \param _ports Desired output ports. Can be a constant or a variable, see
 * \ref OutputPortConstants. If you use a variable and want to control multiple
 * outputs in a single call you need to use a byte array rather than a byte and
 * store the output port values in the byte array before passing it into this function.
 * \param _pwr Output power, 0 to 100. Can be negative to reverse direction.
 * \param _angle Angle limit, in degree. Can be negative to reverse direction.
 */
#define RotateMotor(_ports, _pwr, _angle) \
   __RotateMotorExPID(_ports, _pwr, _angle, 0, FALSE, TRUE, PID_1, PID_0, PID_3)

/**
 * Set motor regulation frequency.
 * Set the motor regulation frequency to the specified number of milliseconds.
 * \param _n The motor regulation frequency in milliseconds
 */
#define SetOutPwnFreq(_n) __setOutPwnFreq(_n)

/**
 * Get motor regulation frequency.
 * Get the current motor regulation frequency.
 * \param _n The motor regulation frequency in milliseconds
 */
#define GetOutPwnFreq(_n) __GetOutPwnFreq(_n)

/**
 * Set motor regulation time.
 * Set the motor regulation time to the specified number of milliseconds.
 * \param _n The motor regulation time in milliseconds
 */
#define SetOutRegulationTime(_n) __setOutRegulationTime(_n)

/**
 * Get motor regulation time.
 * Get the current motor regulation time.
 * \param _n The motor regulation time in milliseconds
 */
#define GetOutRegulationTime(_n) __GetOutRegulationTime(_n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Set motor regulation options.
 * Set the motor regulation options.
 * \param _n The motor regulation options
 */
#define SetOutRegulationOptions(_n) __setOutRegulationOptions(_n)

/**
 * Get motor regulation options.
 * Get the current motor regulation options.
 * \param _n The motor regulation options
 */
#define GetOutRegulationOptions(_n) __GetOutRegulationOptions(_n)
#endif

/** @} */ // end of OutputModuleFunctions group
/** @} */ // end of OutputModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// INPUT MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup InputModule
 * @{
 */
/** @defgroup InputModuleFunctions Input module functions
 * Functions for accessing and modifying input module features.
 * @{
 */

/**
 * Set sensor type.
 * Set a sensor's type, which must be one of the predefined sensor type
 * constants.  After changing the type or the mode of a sensor
 * port you must call \ref ResetSensor to give the firmware time to reconfigure
 * the sensor port.
 * \sa SetSensorMode()
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 * \param _t The desired sensor type.  See \ref NBCSensorTypeConstants.
 */
#define SetSensorType(_port,_t) setin _t, _port, TypeField

/**
 * Set sensor mode.
 * Set a sensor's mode, which should be one of the predefined sensor mode
 * constants. A slope parameter for boolean conversion, if desired, may be
 * added to the mode. After changing the type or the mode of a sensor
 * port you must call \ref ResetSensor to give the firmware time to reconfigure
 * the sensor port.
 * \sa SetSensorType()
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 * \param _m The desired sensor mode. See \ref NBCSensorModeConstants.
 */
#define SetSensorMode(_port,_m) setin _m, _port, InputModeField

/**
 * Read sensor scaled value.
 * Return the processed sensor reading for a sensor on the specified port.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants. A variable whose value is
 * the desired sensor port may also be used.
 * \param _value The sensor's scaled value.
 */
#define ReadSensor(_port,_value) getin _value, _port, ScaledValueField

/**
 * Clear a sensor value.
 * Clear the value of a sensor - only affects sensors that are configured
 * to measure a cumulative quantity such as rotation or a pulse count.
 * \param _port The port to clear. See \ref NBCInputPortConstants.
 */
#define ClearSensor(_port) setin 0, _port, ScaledValueField

/**
 * Configure a touch sensor.
 * Configure the sensor on the specified port as a touch sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorTouch(_port) __SetSensorTouch(_port)

/**
 * Configure a light sensor.
 * Configure the sensor on the specified port as an NXT light sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorLight(_port) __SetSensorLight(_port)

/**
 * Configure a sound sensor.
 * Configure the sensor on the specified port as a sound sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorSound(_port) __SetSensorSound(_port)

/**
 * Configure an I2C sensor.
 * Configure the sensor on the specified port as a 9V powered I2C digital sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorLowspeed(_port) __SetSensorLowspeed(_port)

/**
 * Configure an ultrasonic sensor.
 * Configure the sensor on the specified port as an ultrasonic sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorUltrasonic(_port) __SetSensorLowspeed(_port)

/**
 * Configure an EMeter sensor.
 * Configure the sensor on the specified port as an EMeter sensor.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorEMeter(_port) __SetSensorLowspeed(_port)

/**
 * Configure a temperature sensor.
 * Configure the sensor on the specified port as a temperature sensor. Use this
 * to setup the temperature sensor rather than \ref SetSensorLowspeed so that
 * the sensor is properly configured in 12-bit conversion mode.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorTemperature(_port) \
  __SetSensorLowspeed(_port) \
  __MSWriteToRegister(_port, LEGO_ADDR_TEMP, TEMP_REG_CONFIG, TEMP_RES_12BIT, __WDSC_LSStatus)


#if __FIRMWARE_VERSION > 107

/**
 * Configure an NXT 2.0 full color sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in full color mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorFull(_port) __SetSensorColorFull(_port)

/**
 * Configure an NXT 2.0 red light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in red light mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorRed(_port) __SetSensorColorRed(_port)

/**
 * Configure an NXT 2.0 green light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in green light mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorGreen(_port) __SetSensorColorGreen(_port)

/**
 * Configure an NXT 2.0 blue light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in blue light mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorBlue(_port) __SetSensorColorBlue(_port)

/**
 * Configure an NXT 2.0 no light sensor.
 * Configure the sensor on the specified port as an NXT 2.0 color sensor
 * in no light mode. Requires an NXT 2.0 compatible firmware.
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 *
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define SetSensorColorNone(_port) __SetSensorColorNone(_port)

#endif

/**
 * Reset the sensor port.
 * Sets the invalid data flag on the specified port and waits for it to
 * become valid again. After changing the type or the mode of a sensor
 * port you must call this function to give the firmware time to reconfigure
 * the sensor port.
 * \param _port The port to reset. See \ref NBCInputPortConstants.
 */
#define ResetSensor(_port) __ResetSensor(_port)

#if __FIRMWARE_VERSION > 107

/**
 * Read LEGO color sensor raw values.
 * This function lets you read the LEGO color sensor. It returns an array
 * containing raw color values for red, green, blue, and none indices.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _rawVals An array containing four raw color values. See \ref InputColorIdxConstants.
 * \param _result The function call result.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define ReadSensorColorRaw(_port, _rawVals, _result) __ReadSensorColorRaw(_port, _rawVals, _result)

/**
 * Read LEGO color sensor extra.
 * This function lets you read the LEGO color sensor. It returns the color value,
 * and three arrays containing raw, normalized, and scaled color values for
 * red, green, blue, and none indices.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _colorval The color value. See \ref InputColorValueConstants.
 * \param _rawVals An array containing four raw color values. See \ref InputColorIdxConstants.
 * \param _normVals An array containing four normalized color values. See \ref InputColorIdxConstants.
 * \param _scaledVals An array containing four scaled color values. See \ref InputColorIdxConstants.
 * \param _result The function call result.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define ReadSensorColorEx(_port, _colorval, _rawVals, _normVals, _scaledVals, _result) \
   __ReadSensorColorEx(_port, _colorval, _rawVals, _normVals, _scaledVals, _result)

#endif

/**
 * Get the custom sensor zero offset.
 * Return the custom sensor zero offset value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _n The custom sensor zero offset.
 */
#define GetInCustomZeroOffset(_p, _n) __GetInCustomZeroOffset(_p, _n)

/**
 * Read sensor boolean value.
 * Return the boolean value of a sensor on the specified port. Boolean
 * conversion is either done based on preset cutoffs, or a slope parameter
 * specified by calling SetSensorMode.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The sensor's boolean value.
 */
#define GetInSensorBoolean(_p, _n) __GetInSensorBoolean(_p, _n)

/**
 * Read sensor digital pins direction.
 * Return the digital pins direction value of a sensor on the specified port.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The sensor's digital pins direction.
 */
#define GetInDigiPinsDirection(_p, _n) __GetInDigiPinsDirection(_p, _n)

/**
 * Read sensor digital pins status.
 * Return the digital pins status value of a sensor on the specified port.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The sensor's digital pins status.
 */
#define GetInDigiPinsStatus(_p, _n) __GetInDigiPinsStatus(_p, _n)

/**
 * Read sensor digital pins output level.
 * Return the digital pins output level value of a sensor on the specified port.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The sensor's digital pins output level.
 */
#define GetInDigiPinsOutputLevel(_p, _n) __GetInDigiPinsOutputLevel(_p, _n)

/**
 * Get the custom sensor percent full scale.
 * Return the custom sensor percent full scale value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _n The custom sensor percent full scale.
 */
#define GetInCustomPercentFullScale(_p, _n) __GetInCustomPercentFullScale(_p, _n)

/**
 * Get the custom sensor active status.
 * Return the custom sensor active status value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _n The custom sensor active status.
*/
#define GetInCustomActiveStatus(_p, _n) __GetInCustomActiveStatus(_p, _n)

#if __FIRMWARE_VERSION > 107

/**
 * Read a LEGO color sensor calibration point value.
 * This function lets you directly access a specific LEGO color calibration point value.
 * The port, point, and color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _np The calibration point. See \ref InputColorCalibrationConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The calibration point value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorCalibration(_p, _np, _nc, _n) __GetInColorCalibration(_p, _np, _nc, _n)

/**
 * Read a LEGO color sensor calibration limit value.
 * This function lets you directly access a specific LEGO color calibration limit value.
 * The port and the point must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _np The calibration point. See \ref InputColorCalibrationConstants. Must be a constant.
 * \param _n The calibration limit value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorCalLimits(_p, _np, _n) __GetInColorCalLimits(_p, _np, _n)

/**
 * Read a LEGO color sensor AD raw value.
 * This function lets you directly access a specific LEGO color sensor AD raw value. Both the
 * port and the color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The AD raw value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorADRaw(_p, _nc, _n) __GetInColorADRaw(_p, _nc, _n)

/**
 * Read a LEGO color sensor raw value.
 * This function lets you directly access a specific LEGO color sensor raw value. Both the
 * port and the color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The raw value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorSensorRaw(_p, _nc, _n) __GetInColorSensorRaw(_p, _nc, _n)

/**
 * Read a LEGO color sensor scaled value.
 * This function lets you directly access a specific LEGO color sensor scaled value. Both the
 * port and the color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The scaled value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorSensorValue(_p, _nc, _n) __GetInColorSensorValue(_p, _nc, _n)

/**
 * Read a LEGO color sensor boolean value.
 * This function lets you directly access a specific LEGO color sensor boolean value. Both the
 * port and the color index must be constants.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _nc The color index. See \ref InputColorIdxConstants. Must be a constant.
 * \param _n The boolean value.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorBoolean(_p, _nc, _n) __GetInColorBoolean(_p, _nc, _n)

/**
 * Read LEGO color sensor calibration state.
 * This function lets you directly access the LEGO color calibration state.
 * The port must be a constant.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The calibration state.
 * \warning This function requires an NXT 2.0 compatible firmware.
 */
#define GetInColorCalibrationState(_p, _n) __GetInColorCalibrationState(_p, _n)

#endif

/**
 * Set custom zero offset.
 * Sets the zero offset value of a custom sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new zero offset value.
 */
#define SetInCustomZeroOffset(_p, _n) __setInCustomZeroOffset(_p, _n)

/**
 * Set sensor boolean value.
 * Sets the boolean value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new boolean value.
 */
#define SetInSensorBoolean(_p, _n) __setInSensorBoolean(_p, _n)

/**
 * Set digital pins direction.
 * Sets the digital pins direction value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new digital pins direction value.
 */
#define SetInDigiPinsDirection(_p, _n) __setInDigiPinsDirection(_p, _n)

/**
 * Set digital pins status.
 * Sets the digital pins status value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new digital pins status value.
 */
#define SetInDigiPinsStatus(_p, _n) __setInDigiPinsStatus(_p, _n)

/**
 * Set digital pins output level.
 * Sets the digital pins output level value of a sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new digital pins output level value.
 */
#define SetInDigiPinsOutputLevel(_p, _n) __setInDigiPinsOutputLevel(_p, _n)

/**
 * Set percent full scale.
 * Sets the percent full scale value of a custom sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new percent full scale value.
 */
#define SetInCustomPercentFullScale(_p, _n) __setInCustomPercentFullScale(_p, _n)

/**
 * Set active status.
 * Sets the active status value of a custom sensor.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants. Must be a constant.
 * \param _n The new active status value.
 */
#define SetInCustomActiveStatus(_p, _n) __setInCustomActiveStatus(_p, _n)

/** @} */ // end of InputModuleFunctions group
/** @} */ // end of InputModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// LOWSPEED MODULE ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup LowSpeedModule
 * @{
 */
/** @defgroup LowSpeedModuleFunctions LowSpeed module functions
 * Functions for accessing and modifying low speed module features.
 * @{
 */

/**
 * Read ultrasonic sensor value.
 * Return the ultrasonic sensor distance value. Since an
 * ultrasonic sensor is an I2C digital sensor its value cannot be read using
 * the standard Sensor(n) value.
 * The port must be configured as a Lowspeed port before using this function.
 * \param _port The port to which the ultrasonic sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _value The ultrasonic sensor distance value (0..255)
 */
#define ReadSensorUS(_port, _value) __ReadSensorUS(_port, _value)

/**
 * Read multiple ultrasonic sensor values.
 * Return eight ultrasonic sensor distance values.
 * \param _port The port to which the ultrasonic sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _values An array of bytes that will contain the 8 distance values
 * read from the ultrasonic sensor.
 * \param _result A status code indicating whether the read completed successfully or not.
 * See \ref TCommLSRead for possible Result values.
 */
#define ReadSensorUSEx(_port, _values, _result) __ReadSensorUSEx(_port, _values, _result)

/**
 * Read the LEGO EMeter values.
 * Read all the LEGO EMeter register values.
 * They must all be read at once to ensure data coherency.
 *
 * \param _port The port to which the LEGO EMeter sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _vIn Input voltage
 * \param _aIn Input current
 * \param _vOut Output voltage
 * \param _aOut Output current
 * \param _joules The number of joules stored in E-Meter
 * \param _wIn The number of watts generated
 * \param _wOut The number of watts consumed
 * \param _result A status code indicating whether the read completed successfully or not.
 * See \ref TCommLSRead for possible Result values.
 */
#define ReadSensorEMeter(_port, _vIn, _aIn, _vOut, _aOut, _joules, _wIn, _wOut, _result) __ReadSensorEMeter(_port, _vIn, _aIn, _vOut, _aOut, _joules, _wIn, _wOut, _result)

/**
 * Configure LEGO Temperature sensor options.
 * Set various LEGO Temperature sensor options.
 *
 * \param _port The port to which the LEGO EMeter sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _config The temperature sensor configuration settings.  See
 * \ref TempI2CConstants for configuration constants that can be ORed or added
 * together.
 * \param _result A status code indicating whether the read completed successfully or not.
 * See \ref TCommLSRead for possible Result values.
 */
#define ConfigureTemperatureSensor(_port, _config, _result) __TempSendCmd(_port, _config, _result)

/**
 * Read the LEGO Temperature sensor value.
 * Return the temperature sensor value in degrees celcius. Since a
 * temperature sensor is an I2C digital sensor its value cannot be read using
 * the standard Sensor(n) value.
 * The port must be configured as a temperature sensor port before using this
 * function. Use \ref SetSensorTemperature to configure the port.
 * \param _port The port to which the temperature sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _temp The temperature sensor value in degrees celcius.
 */
#define ReadSensorTemperature(_port, _temp) __ReadSensorTemperature(_port, _temp)

/**
 * Get lowspeed status.
 * This method checks the status of the I2C communication on the specified
 * port. If the last operation on this port was a successful LowspeedWrite
 * call that requested response data from the device then bytesready will
 * be set to the number of bytes in the internal read buffer.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _bready The number of bytes available to be read from the internal I2C buffer.
 * The maximum number of bytes that can be read is 16.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref LowspeedRead or \ref LowspeedWrite while LowspeedStatus returns
 * \ref STAT_COMM_PENDING.
 * \sa LowspeedRead, LowspeedWrite, and LowspeedCheckStatus
 */
#define LowspeedStatus(_port, _bready, _result) __lowspeedStatus(_port, _bready, _result)

/**
 * Check lowspeed status.
 * This method checks the status of the I2C communication on the specified
 * port.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * Avoid calls to \ref LowspeedRead or \ref LowspeedWrite while LowspeedCheckStatus returns
 * \ref STAT_COMM_PENDING.
 * \sa LowspeedRead, LowspeedWrite, and LowspeedStatus
 */
#define LowspeedCheckStatus(_port, _result) __lowspeedCheckStatus(_port, _result)

/**
 * Get lowspeed bytes ready.
 * This method checks the number of bytes that are ready to be read on the
 * specified port. If the last operation on this port was a successful
 * LowspeedWrite call that requested response data from the device then the
 * return value will be the number of bytes in the internal read buffer.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _bready The number of bytes available to be read from the internal I2C buffer.
 * The maximum number of bytes that can be read is 16.
 * \sa LowspeedRead, LowspeedWrite, and LowspeedStatus
 */
#define LowspeedBytesReady(_port, _bready) __lowspeedBytesReady(_port, _bready)

/**
 * Write lowspeed data.
 * This method starts a transaction to write the bytes contained in the array
 * buffer to the I2C device on the specified port. It also tells the I2C device
 * the number of bytes that should be included in the response. The maximum
 * number of bytes that can be written or read is 16.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _retlen The number of bytes that should be returned by the I2C device.
 * \param _buffer A byte array containing the address of the I2C device, the I2C
 * device register at which to write data, and up to 14 bytes of data to be
 * written at the specified register.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSWrite for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa LowspeedRead, LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
#define LowspeedWrite(_port, _retlen, _buffer, _result) __lowspeedWrite(_port, _retlen, _buffer, _result)

/**
 * Read lowspeed data.
 * Read the specified number of bytes from the I2C device on the specified
 * port and store the bytes read in the byte array buffer provided.  The maximum
 * number of bytes that can be written or read is 16.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _buflen The initial size of the output buffer.
 * \param _buffer A byte array that contains the data read from the internal I2C
 * buffer.  If the return value is negative then the output buffer will be empty.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSRead for possible Result values. If the return
 * value is \ref NO_ERR then the last operation did not cause any errors.
 * \sa LowspeedWrite, LowspeedCheckStatus, LowspeedBytesReady, and LowspeedStatus
 */
#define LowspeedRead(_port, _buflen, _buffer, _result) __lowspeedRead(_port, _buflen, _buffer, _result)

/**
 * Perform an I2C write/read transaction.
 * This method writes the bytes contained in the input buffer (inbuf) to the
 * I2C device on the specified port, checks for the specified number of bytes
 * to be ready for reading, and then tries to read the specified number (count)
 * of bytes from the I2C device into the output buffer (outbuf).
 *
 * This is a higher-level wrapper around the three main I2C functions. It also
 * maintains a "last good read" buffer and returns values from that buffer if
 * the I2C communication transaction fails.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _inbuf A byte array containing the address of the I2C device, the I2C
 * device register at which to write data, and up to 14 bytes of data to be
 * written at the specified register.
 * \param _count The number of bytes that should be returned by the I2C device.
 * On output count is set to the number of bytes in outbuf.
 * \param _outbuf A byte array that contains the data read from the internal I2C
 * buffer.
 * \param _result Returns true or false indicating whether the I2C transaction
 * succeeded or failed.
 * \sa LowspeedRead, LowspeedWrite, LowspeedCheckStatus, LowspeedBytesReady,
 * and LowspeedStatus
 */
#define ReadI2CBytes(_port, _inbuf, _count, _outbuf, _result) __ReadI2CBytes(_port, _inbuf, _count, _outbuf, _result)

/**
 * Read I2C device information.
 * Read standard I2C device information: version, vendor, and device ID. The
 * I2C device uses the specified address.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _info A value indicating the type of device information you are requesting.
 * See \ref GenericI2CConstants.
 * \param _strVal A string containing the requested device information.
 */
#define ReadI2CDeviceInfo(_port, _i2caddr, _info, _strVal) __ReadI2CDeviceInfo(_port, _i2caddr, _info, _strVal)

/**
 * Read I2C device version.
 * Read standard I2C device version. The I2C device uses the specified address.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _strVal A string containing the device version.
 */
#define ReadI2CVersion(_port, _i2caddr, _strVal) ReadI2CDeviceInfo(_port, _i2caddr, I2C_REG_VERSION, _strVal)

/**
 * Read I2C device vendor.
 * Read standard I2C device vendor. The I2C device uses the specified address.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _strVal A string containing the device vendor.
 */
#define ReadI2CVendorId(_port, _i2caddr, _strVal) ReadI2CDeviceInfo(_port, _i2caddr, I2C_REG_VENDOR_ID, _strVal)

/**
 * Read I2C device identifier.
 * Read standard I2C device identifier. The I2C device uses the specified address.
 *
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _strVal A string containing the device identifier.
 */
#define ReadI2CDeviceId(_port, _i2caddr, _strVal) ReadI2CDeviceInfo(_port, _i2caddr, I2C_REG_DEVICE_ID, _strVal)

/**
 * Read I2C register.
 * Read a single byte from an I2C device register.
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _i2caddr The I2C device address.
 * \param _reg The I2C device register from which to read a single byte.
 * \param _out The single byte read from the I2C device.
 * \param _result A status code indicating whether the read completed successfully or not.
 * See \ref TCommLSRead for possible Result values.
 */
#define ReadI2CRegister(_port, _i2caddr, _reg, _out, _result) __MSReadValue(_port, _i2caddr, _reg, 1, _out, _result)

/**
 * Write I2C register.
 * Write a single byte to an I2C device register.
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _i2caddr The I2C device address.
 * \param _reg The I2C device register to which to write a single byte.
 * \param _val The byte to write to the I2C device.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define WriteI2CRegister(_port, _i2caddr, _reg, _val, _result) __MSWriteToRegister(_port, _i2caddr, _reg, _val, _result)

/**
 * Send an I2C command.
 * Send a command to an I2C device at the standard command register: \ref I2C_REG_CMD.
 * The I2C device uses the specified address.
 * \param _port The port to which the I2C device is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable. Constants should
 * be used where possible to avoid blocking access to I2C devices on other
 * ports by code running on other threads.
 * \param _i2caddr The I2C device address.
 * \param _cmd The command to send to the I2C device.
 * \param _result A status code indicating whether the write completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define I2CSendCommand(_port, _i2caddr, _cmd, _result) __I2CSendCmd(_port, _i2caddr, _cmd, _result)

/** @defgroup LowLevelLowSpeedModuleFunctions Low level LowSpeed module functions
 * Low level functions for accessing low speed module features.
 * @{
 */

/**
 * Get I2C input buffer data.
 * This method reads count bytes of data from the I2C input buffer for the
 * specified port and writes it to the buffer provided.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _offset A constant offset into the I2C input buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the I2C input buffer.
 */
#define GetLSInputBuffer(_p, _offset, _cnt, _data) __getLSInputBuffer(_p, _offset, _cnt, _data)

/**
 * Get I2C input buffer in-pointer.
 * This method returns the value of the input pointer of the I2C input
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C input buffer's in-pointer value.
 */
#define GetLSInputBufferInPtr(_p, _n) __GetLSInputBufferInPtr(_p, _n)

/**
 * Get I2C input buffer out-pointer.
 * This method returns the value of the output pointer of the I2C input
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C input buffer's out-pointer value.
 */
#define GetLSInputBufferOutPtr(_p, _n) __GetLSInputBufferOutPtr(_p, _n)

/**
 * Get I2C input buffer bytes to rx.
 * This method returns the value of the bytes to rx field of the I2C input
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C input buffer's bytes to rx value.
 */
#define GetLSInputBufferBytesToRx(_p, _n) __GetLSInputBufferBytesToRx(_p, _n)

/**
 * Get I2C output buffer data.
 * This method reads cnt bytes of data from the I2C output buffer for the
 * specified port and writes it to the buffer provided.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _offset A constant offset into the I2C output buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the I2C output buffer.
 */
#define GetLSOutputBuffer(_p, _offset, _cnt, _data) __getLSOutputBuffer(_p, _offset, _cnt, _data)

/**
 * Get I2C output buffer in-pointer.
 * This method returns the value of the input pointer of the I2C output
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C output buffer's in-pointer value.
 */
#define GetLSOutputBufferInPtr(_p, _n) __GetLSOutputBufferInPtr(_p, _n)

/**
 * Get I2C output buffer out-pointer.
 * This method returns the value of the output pointer of the I2C output
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C output buffer's out-pointer value.
 */
#define GetLSOutputBufferOutPtr(_p, _n) __GetLSOutputBufferOutPtr(_p, _n)

/**
 * Get I2C output buffer bytes to rx.
 * This method returns the value of the bytes to rx field of the I2C output
 * buffer for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C output buffer's bytes to rx value.
 */
#define GetLSOutputBufferBytesToRx(_p, _n) __GetLSOutputBufferBytesToRx(_p, _n)

/**
 * Get I2C mode.
 * This method returns the value of the I2C mode for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C port mode. See \ref LowSpeedModeConstants.
 */
#define GetLSMode(_p, _n) __GetLSMode(_p, _n)

/**
 * Get I2C channel state.
 * This method returns the value of the I2C channel state for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C port channel state. See \ref LowSpeedChannelStateConstants.
 */
#define GetLSChannelState(_p, _n) __GetLSChannelState(_p, _n)

/**
 * Get I2C error type.
 * This method returns the value of the I2C error type for the specified port.
 * \param _p A constant port number (S1..S4). See \ref NBCInputPortConstants.
 * \param _n The I2C port error type. See \ref LowSpeedErrorTypeConstants.
 */
#define GetLSErrorType(_p, _n) __GetLSErrorType(_p, _n)

/**
 * Get I2C state.
 * This method returns the value of the I2C state.
 * \param _n The I2C state. See \ref LowSpeedStateConstants.
 */
#define GetLSState(_n) __GetLSState(_n)

/**
 * Get I2C speed.
 * This method returns the value of the I2C speed.
 * \param _n The I2C speed.
 *
 * \warning This function is unimplemented within the firmware.
 */
#define GetLSSpeed(_n) __GetLSSpeed(_n)

#ifdef __ENHANCED_FIRMWARE
/**
 * Get I2C no restart on read setting.
 * This method returns the value of the I2C no restart on read field.
 * \param _n The I2C no restart on read field. See \ref LowSpeedNoRestartConstants.
 */
#define GetLSNoRestartOnRead(_n) __GetLSNoRestartOnRead(_n)
#endif

/** @} */ // end of LowLevelLowSpeedModuleFunctions group

/** @} */ // end of LowSpeedModuleFunctions group
/** @} */ // end of LowSpeedModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// DISPLAY MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup DisplayModule
 * @{
 */
/** @defgroup DisplayModuleFunctions Display module functions
 * Functions for accessing and modifying display module features.
 * @{
 */

/**
 * Clear a line on the LCD screen.
 * This function lets you clear a single line on the NXT LCD.
 * \param _line The line you want to clear. See \ref LineConstants.
 */
#define ClearLine(_line) __TextOutEx(0, _line, __BlankLine, 0)

/**
 * Draw a point with drawing options.
 * This function lets you draw a point on the screen at x, y.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawPoint
 *
 * \param _x The x value for the point.
 * \param _y The y value for the point.
 * \param _options The optional drawing options.
 */
#define PointOutEx(_x,_y,_options) __PointOutEx(_x,_y,_options)

/**
 * Draw a point.
 * This function lets you draw
 a point on the screen at x, y.
 * \sa TDrawPoint
 *
 * \param _x The x value for the point.
 * \param _y The y value for the point.
 */
#define PointOut(_x,_y) __PointOutEx(_x,_y,0)

/**
 * Clear LCD screen.
 * This function lets you clear the NXT LCD to a blank screen.
 */
#define ClearScreen() __PointOutEx(200, 200, 1)

/**
 * Draw a line with drawing options.
 * This function lets you draw a line on the screen from x1, y1 to x2, y2.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawLine
 *
 * \param _x1 The x value for the start of the line.
 * \param _y1 The y value for the start of the line.
 * \param _x2 The x value for the end of the line.
 * \param _y2 The y value for the end of the line.
 * \param _options The optional drawing options.
 */
#define LineOutEx(_x1,_y1,_x2,_y2,_options) __LineOutEx(_x1,_y1,_x2,_y2,_options)

/**
 * Draw a line.
 * This function lets you draw a line on the screen from x1, y1 to x2, y2.
 * \sa TDrawLine
 *
 * \param _x1 The x value for the start of the line.
 * \param _y1 The y value for the start of the line.
 * \param _x2 The x value for the end of the line.
 * \param _y2 The y value for the end of the line.
 */
#define LineOut(_x1,_y1,_x2,_y2) __LineOutEx(_x1,_y1,_x2,_y2,0)

/**
 * Draw a rectangle with drawing options.
 * This function lets you draw a rectangle on the screen at x, y with the
 * specified width and height.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawRect
 *
 * \param _x The x value for the top left corner of the rectangle.
 * \param _y The y value for the top left corner of the rectangle.
 * \param _w The width of the rectangle.
 * \param _h The height of the rectangle.
 * \param _options The optional drawing options.
 */
#define RectOutEx(_x,_y,_w,_h,_options) __RectOutEx(_x,_y,_w,_h,_options)

/**
 * Draw a rectangle.
 * This function lets you draw a rectangle on the screen at x, y with the
 * specified width and height.
 * \sa TDrawRect
 *
 * \param _x The x value for the top left corner of the rectangle.
 * \param _y The y value for the top left corner of the rectangle.
 * \param _w The width of the rectangle.
 * \param _h The height of the rectangle.
 */
#define RectOut(_x,_y,_w,_h) __RectOutEx(_x,_y,_w,_h,0)

/**
 * Draw a circle with drawing options.
 * This function lets you draw a circle on the screen with its center at the
 * specified x and y location, using the specified radius. Also specify
 * drawing options. Valid display option constants are listed in the
 * \ref DisplayDrawOptionConstants group.
 * \sa TDrawCircle
 *
 * \param _x The x value for the center of the circle.
 * \param _y The y value for the center of the circle.
 * \param _r The radius of the circle.
 * \param _options The optional drawing options.
 */
#define CircleOutEx(_x,_y,_r,_options) __CircleOutEx(_x,_y,_r,_options)

/**
 * Draw a circle.
 * This function lets you draw a circle on the screen with its center at the
 * specified x and y location, using the specified radius.
 * \sa TDrawCircle
 *
 * \param _x The x value for the center of the circle.
 * \param _y The y value for the center of the circle.
 * \param _r The radius of the circle.
 */
#define CircleOut(_x,_y,_r) __CircleOutEx(_x,_y,_r,0)

/**
 * Draw a number with drawing options.
 * Draw a numeric value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawText
 *
 * \param _x The x value for the start of the number output.
 * \param _y The text line number for the number output.
 * \param _num The value to output to the LCD screen. Any numeric type is supported.
 * \param _options The optional drawing options.
 */
#define NumOutEx(_x,_y,_num,_options) __NumOutEx(_x,_y,_num,_options)

/**
 * Draw a number.
 * Draw a numeric value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * \sa TDrawText
 *
 * \param _x The x value for the start of the number output.
 * \param _y The text line number for the number output.
 * \param _num The value to output to the LCD screen. Any numeric type is supported.
 */
#define NumOut(_x,_y,_num) __NumOutEx(_x,_y,_num,0)

/**
 * Draw text.
 * Draw a text value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawText
 *
 * \param _x The x value for the start of the text output.
 * \param _y The text line number for the text output.
 * \param _txt The text to output to the LCD screen.
 * \param _options The optional drawing options.
 */
#define TextOutEx(_x,_y,_txt,_options) __TextOutEx(_x,_y,_txt,_options)

/**
 * Draw text.
 * Draw a text value on the screen at the specified x and y location. The y
 * value must be a multiple of 8.  Valid line number constants are listed in
 * the \ref LineConstants group.
 * \sa TDrawText
 *
 * \param _x The x value for the start of the text output.
 * \param _y The text line number for the text output.
 * \param _txt The text to output to the LCD screen.
 */
#define TextOut(_x,_y,_txt) __TextOutEx(_x,_y,_txt,0)

/**
 * Draw a graphic image with parameters and drawing options.
 * Draw a graphic image file on the screen at the specified x and y location using
 * an array of parameters. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa TDrawGraphic
 *
 * \param _x The x value for the position of the graphic image.
 * \param _y The y value for the position of the graphic image.
 * \param _file The filename of the RIC graphic image.
 * \param _vars The byte array of parameters.
 * \param _options The drawing options.
 */
#define GraphicOutEx(_x,_y,_file,_vars,_options) __GraphicOutEx(_x,_y,_file,_vars,_options)

/**
 * Draw a graphic image.
 * Draw a graphic image file on the screen at the specified x and y location.
 * If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa TDrawGraphic
 *
 * \param _x The x value for the position of the graphic image.
 * \param _y The y value for the position of the graphic image.
 * \param _file The filename of the RIC graphic image.
 */
#define GraphicOut(_x,_y,_file) __GraphicOutEx(_x,_y,_file,__GraphicOutEmptyVars,0)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

/**
 * Draw a graphic image from byte array with parameters and drawing options.
 * Draw a graphic image byte array on the screen at the specified x and y
 * location using an array of parameters and drawing options.
 * Valid display option constants are listed in the
 * \ref DisplayDrawOptionConstants group. If the file cannot be found then
 * nothing will be drawn and no errors will be reported.
 * \sa TDrawGraphicArray
 *
 * \param _x The x value for the position of the graphic image.
 * \param _y The y value for the position of the graphic image.
 * \param _data The byte array of the RIC graphic image.
 * \param _vars The byte array of parameters.
 * \param _options The drawing options.
 */
#define GraphicArrayOutEx(_x,_y,_data,_vars,_options) __GraphicArrayOutEx(_x,_y,_data,_vars,_options)

/**
 * Draw a graphic image from byte array.
 * Draw a graphic image byte array on the screen at the specified x and y
 * location. If the file cannot be found then nothing will be drawn and no
 * errors will be reported.
 * \sa TDrawGraphicArray
 *
 * \param _x The x value for the position of the graphic image.
 * \param _y The y value for the position of the graphic image.
 * \param _data The byte array of the RIC graphic image.
 */
#define GraphicArrayOut(_x,_y,_data) __GraphicArrayOutEx(_x,_y,_data,__GraphicOutEmptyVars,0)

/**
 * Draw an ellipse with drawing options.
 * This function lets you draw an ellipse on the screen with its center at the
 * specified x and y location, using the specified radii. Also specify
 * drawing options. Valid display option constants are listed in the
 * \ref DisplayDrawOptionConstants group.
 * \sa SysDrawEllipse, DrawEllipseType
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the center of the ellipse.
 * \param _y The y value for the center of the ellipse.
 * \param _rX The x axis radius.
 * \param _rY The y axis radius.
 * \param _options The drawing options.
 */
#define EllipseOutEx(_x,_y,_rX,_rY,_options) __EllipseOutEx(_x,_y,_rX,_rY,_options)

/**
 * Draw an ellipse.
 * This function lets you draw an ellipse on the screen with its center at the
 * specified x and y location, using the specified radii.
 * \sa TDrawEllipse
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the center of the ellipse.
 * \param _y The y value for the center of the ellipse.
 * \param _rX The x axis radius.
 * \param _rY The y axis radius.
 */
#define EllipseOut(_x,_y,_rX,_rY) __EllipseOutEx(_x,_y,_rX,_rY,0)

/**
 * Draw a polygon with drawing options.
 * This function lets you draw a polygon on the screen using an array of points.
 * Also specify drawing options. Valid display option constants are listed in
 * the \ref DisplayDrawOptionConstants group.
 * \sa TDrawPolygon
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _points An array of \ref TLocation points that define the polygon.
 * \param _options The drawing options.
 */
#define PolyOutEx(_points,_options) __PolyOutEx(_points,_options)

/**
 * Draw a polygon.
 * This function lets you draw a polygon on the screen using an array of points.
 * \sa TDrawPolygon
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _points An array of LocationType points that define the polygon.
 */
#define PolyOut(_points) __PolyOutEx(_points,0)

/**
 * Draw text with font and drawing options.
 * Draw a text value on the screen at the specified x and y location using
 * a custom RIC font. Also specify drawing options. Valid display option
 * constants are listed in the \ref DisplayDrawOptionConstants group.  See the
 * \ref DisplayFontDrawOptionConstants for options specific to the font
 * drawing functions.
 * \sa FontNumOut, TDrawFont
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the start of the text output.
 * \param _y The y value for the start of the text output.
 * \param _fnt The filename of the RIC font.
 * \param _txt The text to output to the LCD screen.
 * \param _options The drawing options.
 */
#define FontTextOutEx(_x,_y,_fnt,_txt,_options) __FontTextOutEx(_x,_y,_fnt,_txt,_options)

/**
 * Draw text with font.
 * Draw a text value on the screen at the specified x and y location using
 * a custom RIC font.
 * \sa FontNumOut, TDrawFont
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the start of the text output.
 * \param _y The y value for the start of the text output.
 * \param _fnt The filename of the RIC font.
 * \param _txt The text to output to the LCD screen.
 */
#define FontTextOut(_x,_y,_fnt,_txt) __FontTextOutEx(_x,_y,_fnt,_txt,0)

/**
 * Draw a number with font and drawing options.
 * Draw a numeric value on the screen at the specified x and y location using
 * a custom RIC font. Also specify drawing options. Valid display option
 * constants are listed in the \ref DisplayDrawOptionConstants group.  See the
 * \ref DisplayFontDrawOptionConstants for options specific to the font
 * drawing functions.
 * \sa FontTextOut, TDrawFont
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the start of the number output.
 * \param _y The y value for the start of the number output.
 * \param _fnt The filename of the RIC font.
 * \param _num The value to output to the LCD screen. Any numeric type is supported.
 * \param _options The optional drawing options.
 */
#define FontNumOutEx(_x,_y,_fnt,_num,_options) __FontNumOutEx(_x,_y,_fnt,_num,_options)

/**
 * Draw a number with font.
 * Draw a numeric value on the screen at the specified x and y location using
 * a custom RIC font.
 * \sa FontTextOut, TDrawFont
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _x The x value for the start of the number output.
 * \param _y The y value for the start of the number output.
 * \param _fnt The filename of the RIC font.
 * \param _num The value to output to the LCD screen. Any numeric type is supported.
 */
#define FontNumOut(_x,_y,_fnt,_num) __FontNumOutEx(_x,_y,_fnt,_num,0)

#endif

/**
 * Read the display erase mask value.
 * This function lets you read the current display erase mask value.
 * \param _n The current display erase mask value.
 */
#define GetDisplayEraseMask(_n) __GetDisplayEraseMask(_n)

/**
 * Read the display update mask value.
 * This function lets you read the current display update mask value.
 * \param _n The current display update mask.
 */
#define GetDisplayUpdateMask(_n) __GetDisplayUpdateMask(_n)

/**
 * Read the display font memory address.
 * This function lets you read the current display font memory address.
 * \param _n The current display font memory address.
 */
#define GetDisplayFont(_n) __GetDisplayFont(_n)

/**
 * Read the display memory address.
 * This function lets you read the current display memory address.
 * \param _n The current display memory address.
 */
#define GetDisplayDisplay(_n) __GetDisplayDisplay(_n)

/**
 * Read the display flags.
 * This function lets you read the current display flags.
 * Valid flag values are listed in the \ref DisplayFlagsGroup group.
 * \param _n The current display flags.
 */
#define GetDisplayFlags(_n) __GetDisplayFlags(_n)

/**
 * Read the display text lines center flags.
 * This function lets you read the current display text lines center flags.
 * \param _n The current display text lines center flags.
 */
#define GetDisplayTextLinesCenterFlags(_n) __GetDisplayTextLinesCenterFlags(_n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Read the display contrast setting.
 * This function lets you read the current display contrast setting.
 * \param _n The current display contrast (byte).
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define GetDisplayContrast(_n) __GetDisplayContrast(_n)
#endif

/**
 * Read pixel data from the normal display buffer.
 * Read "cnt" bytes from the normal display memory into the data array. Start
 * reading from the specified x, line coordinate. Each byte of data read from
 * screen memory is a vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param _x The desired x position from which to read pixel data.
 * \param _line The desired line from which to read pixel data.
 * \param _cnt The number of bytes of pixel data to read.
 * \param _data The array of bytes into which pixel data is read.
 */
#define GetDisplayNormal(_x, _line, _cnt, _data) __getDisplayNormal(_x, _line, _cnt, _data)

/**
 * Read pixel data from the popup display buffer.
 * Read "cnt" bytes from the popup display memory into the data array. Start
 * reading from the specified x, line coordinate. Each byte of data read from
 * screen memory is a vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param _x The desired x position from which to read pixel data.
 * \param _line The desired line from which to read pixel data.
 * \param _cnt The number of bytes of pixel data to read.
 * \param _data The array of bytes into which pixel data is read.
 */
#define GetDisplayPopup(_x, _line, _cnt, _data) __getDisplayPopup(_x, _line, _cnt, _data)

/**
 * Set the display font memory address.
 * This function lets you set the current display font memory address.
 *
 * \param _n The new display font memory address.
 */
#define SetDisplayFont(_n) __setDisplayFont(_n)

/**
 * Set the display memory address.
 * This function lets you set the current display memory address.
 *
 * \param _n The new display memory address.
 */
#define SetDisplayDisplay(_n) __setDisplayDisplay(_n)

/**
 * Set the display erase mask.
 * This function lets you set the current display erase mask.
 *
 * \param _n The new display erase mask.
 */
#define SetDisplayEraseMask(_n) __setDisplayEraseMask(_n)

/**
 * Set the display flags.
 * This function lets you set the current display flags.
 *
 * \param _n The new display flags. See \ref DisplayFlagsGroup.
 */
#define SetDisplayFlags(_n) __setDisplayFlags(_n)

/**
 * Set the display text lines center flags.
 * This function lets you set the current display text lines center flags.
 *
 * \param _n The new display text lines center flags.
 */
#define SetDisplayTextLinesCenterFlags(_n) __setDisplayTextLinesCenterFlags(_n)

/**
 * Set the display update mask.
 * This function lets you set the current display update mask.
 *
 * \param _n The new display update mask.
 */
#define SetDisplayUpdateMask(_n) __setDisplayUpdateMask(_n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Set the display contrast.
 * This function lets you set the display contrast setting.
 *
 * \param _n The desired display contrast.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define SetDisplayContrast(_n) __setDisplayContrast(_n)
#endif

/**
 * Write pixel data to the normal display buffer.
 * Write "cnt" bytes to the normal display memory from the data array. Start
 * writing at the specified x, line coordinate. Each byte of data is a
 * vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param _x The desired x position where you wish to write pixel data.
 * \param _line The desired line where you wish to write pixel data.
 * \param _cnt The number of bytes of pixel data to write.
 * \param _data The array of bytes from which pixel data is read.
 */
#define SetDisplayNormal(_x, _line, _cnt, _data) __setDisplayNormal(_x, _line, _cnt, _data)

/**
 * Write pixel data to the popup display buffer.
 * Write "cnt" bytes to the popup display memory from the data array. Start
 * writing at the specified x, line coordinate. Each byte of data is a
 * vertical strip of 8 bits at the desired location. Each
 * bit represents a single pixel on the LCD screen. Use TEXTLINE_1 through
 * TEXTLINE_8 for the "line" parameter.
 *
 * \param _x The desired x position where you wish to write pixel data.
 * \param _line The desired line where you wish to write pixel data.
 * \param _cnt The number of bytes of pixel data to write.
 * \param _data The array of bytes from which pixel data is read.
 */
#define SetDisplayPopup(_x, _line, _cnt, _data) __setDisplayPopup(_x, _line, _cnt, _data)

/** @} */ // end of DisplayModuleFunctions group
/** @} */ // end of DisplayModule group
/** @} */ // end of NXTFirmwareModules group


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
#define PlayFile(_file) __PlayFileEx(_file,4,0)

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
 */
#define PlayFileEx(_file,_vol,_loop) __PlayFileEx(_file,_vol,_loop)

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


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// COMMAND MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup CommandModule
 * @{
 */
/** @defgroup CommandModuleFunctions Command module functions
 * Functions for accessing and modifying Command module features.
 * @{
 */

/**
 * Set IOMap bytes by name.
 * Modify one or more bytes of data in an IOMap structure. The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to start writing, the number of bytes to
 * write at that location, and a byte array containing the new data.
 * \param _modName The module name of the IOMap to modify. See \ref ModuleNameConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the data should be written
 * \param _cnt The number of bytes to write at the specified IOMap
 * offset.
 * \param _arrIn The byte array containing the data to write to the IOMap
 */
#define SetIOMapBytes(_modName, _offset, _cnt, _arrIn) __SetIOMapBytes(_modName, _offset, _cnt, _arrIn)

/**
 * Set IOMap value by name.
 * Set one of the fields of an IOMap structure to a new value.  The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to write the value along with a variable
 * containing the new value.
 * \param _modName The module name of the IOMap to modify. See \ref ModuleNameConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the new value should be written
 * \param _n A variable containing the new value to write to the IOMap
 */
#define SetIOMapValue(_modName, _offset, _n) __SetIOMapValue(_modName, _offset, _n)

#ifdef __ENHANCED_FIRMWARE

/**
 * Set IOMap bytes by ID.
 * Modify one or more bytes of data in an IOMap structure. The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to start writing, the number of bytes to
 * write at that location, and a byte array containing the new data.
 * \param _modID The module ID of the IOMap to modify. See \ref ModuleIDConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the data should be written.
 * \param _cnt The number of bytes to write at the specified IOMap
 * offset.
 * \param _arrIn The byte array containing the data to write to the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SetIOMapBytesByID(_modID, _offset, _cnt, _arrIn) __SetIOMapBytesByID(_modID, _offset, _cnt, _arrIn)

/**
 * Set IOMap value by ID.
 * Set one of the fields of an IOMap structure to a new value.  The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to write the value along with a variable
 * containing the new value.
 * \param _modID The module ID of the IOMap to modify. See \ref ModuleIDConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the new value should be written.
 * \param _n A variable containing the new value to write to the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SetIOMapValueByID(_modID, _offset, _n) __SetIOMapValueByID(_modID, _offset, _n)

/**
 * Set Command module IOMap value.
 * Set one of the fields of the Command module IOMap structure to a new value.
 * You provide the offset into the Command module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Command
 * module IOMap structure where the new value should be written. See \ref CommandIOMAP.
 * \param _n A variable containing the new value to write to the Command
 * module IOMap.
 */
#define SetCommandModuleValue(_offset, _n) SetIOMapValueByID(CommandModuleID, _offset, _n)

/**
 * Set IOCtrl module IOMap value.
 * Set one of the fields of the IOCtrl module IOMap structure to a new value.
 * You provide the offset into the IOCtrl module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the IOCtrl
 * module IOMap structure where the new value should be written. See \ref IOCtrlIOMAP.
 * \param _n A variable containing the new value to write to the IOCtrl
 * module IOMap.
 */
#define SetIOCtrlModuleValue(_offset, _n) SetIOMapValueByID(IOCtrlModuleID, _offset, _n)

/**
 * Set Loader module IOMap value.
 * Set one of the fields of the Loader module IOMap structure to a new value.
 * You provide the offset into the Loader module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Loader
 * module IOMap structure where the new value should be written. See \ref LoaderIOMAP.
 * \param _n A variable containing the new value to write to the Loader
 * module IOMap.
 */
#define SetLoaderModuleValue(_offset, _n) SetIOMapValueByID(LoaderModuleID, _offset, _n)

/**
 * Set Ui module IOMap value.
 * Set one of the fields of the Ui module IOMap structure to a new value.
 * You provide the offset into the Ui module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Ui
 * module IOMap structure where the new value should be written. See \ref UiIOMAP.
 * \param _n A variable containing the new value to write to the Ui
 * module IOMap.
 */
#define SetUIModuleValue(_offset, _n) SetIOMapValueByID(UIModuleID, _offset, _n)

/**
 * Set Sound module IOMap value.
 * Set one of the fields of the Sound module IOMap structure to a new value.
 * You provide the offset into the Sound module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Sound
 * module IOMap structure where the new value should be written. See \ref SoundIOMAP.
 * \param _n A variable containing the new value to write to the Sound
 * module IOMap.
 */
#define SetSoundModuleValue(_offset, _n) SetIOMapValueByID(SoundModuleID, _offset, _n)

/**
 * Set Button module IOMap value.
 * Set one of the fields of the Button module IOMap structure to a new value.
 * You provide the offset into the Button module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Button
 * module IOMap structure where the new value should be written. See \ref ButtonIOMAP.
 * \param _n A variable containing the new value to write to the Button
 * module IOMap.
 */
#define SetButtonModuleValue(_offset, _n) SetIOMapValueByID(ButtonModuleID, _offset, _n)

/**
 * Set Input module IOMap value.
 * Set one of the fields of the Input module IOMap structure to a new value.
 * You provide the offset into the Input module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Input
 * module IOMap structure where the new value should be written. See \ref InputIOMAP.
 * \param _n A variable containing the new value to write to the Input
 * module IOMap.
 */
#define SetInputModuleValue(_offset, _n) SetIOMapValueByID(InputModuleID, _offset, _n)

/**
 * Set Output module IOMap value.
 * Set one of the fields of the Output module IOMap structure to a new value.
 * You provide the offset into the Output module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Output
 * module IOMap structure where the new value should be written. See \ref OutputIOMAP.
 * \param _n A variable containing the new value to write to the Output
 * module IOMap.
 */
#define SetOutputModuleValue(_offset, _n) SetIOMapValueByID(OutputModuleID, _offset, _n)

/**
 * Set Lowspeed module IOMap value.
 * Set one of the fields of the Lowspeed module IOMap structure to a new value.
 * You provide the offset into the Lowspeed module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Lowspeed
 * module IOMap structure where the new value should be written. See \ref LowSpeedIOMAP.
 * \param _n A variable containing the new value to write to the Lowspeed
 * module IOMap.
 */
#define SetLowSpeedModuleValue(_offset, _n) SetIOMapValueByID(LowSpeedModuleID, _offset, _n)

/**
 * Set Display module IOMap value.
 * Set one of the fields of the Display module IOMap structure to a new value.
 * You provide the offset into the Display module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Display
 * module IOMap structure where the new value should be written. See \ref DisplayIOMAP.
 * \param _n A variable containing the new value to write to the Display
 * module IOMap.
 */
#define SetDisplayModuleValue(_offset, _n) SetIOMapValueByID(DisplayModuleID, _offset, _n)

/**
 * Set Comm module IOMap value.
 * Set one of the fields of the Comm module IOMap structure to a new value.
 * You provide the offset into the Comm module IOMap structure where you
 * want to write the value along with a variable containing the new value.
 * \param _offset The number of bytes offset from the start of the Comm
 * module IOMap structure where the new value should be written. See \ref CommIOMAP.
 * \param _n A variable containing the new value to write to the Comm
 * module IOMap.
 */
#define SetCommModuleValue(_offset, _n) SetIOMapValueByID(CommModuleID, _offset, _n)

/**
 * Set Command module IOMap bytes.
 * Modify one or more bytes of data in the Command module IOMap structure. You
 * provide the offset into the Command module IOMap structure where you want
 * to start writing, the number of bytes to write at that location, and a byte
 * array containing the new data.
 * \param _offset The number of bytes offset from the start of the Command module
 * IOMap structure where the data should be written. See \ref CommandIOMAP.
 * \param _cnt The number of bytes to write at the specified Command module
 * IOMap offset.
 * \param _arrIn The byte array containing the data to write to the Command
 * module IOMap.
 */
#define SetCommandModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(CommandModuleID, _offset, _cnt, _arrIn)

/**
 * Set Lowspeed module IOMap bytes.
 * Modify one or more bytes of data in the Lowspeed module IOMap structure. You
 * provide the offset into the Lowspeed module IOMap structure where you want
 * to start writing, the number of bytes to write at that location, and a byte
 * array containing the new data.
 * \param _offset The number of bytes offset from the start of the Lowspeed
 * module IOMap structure where the data should be written. See \ref LowSpeedIOMAP.
 * \param _cnt The number of bytes to write at the specified Lowspeed module
 * IOMap offset.
 * \param _arrIn The byte array containing the data to write to the Lowspeed
 * module IOMap.
 */
#define SetLowSpeedModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(LowSpeedModuleID, _offset, _cnt, _arrIn)

/**
 * Set Display module IOMap bytes.
 * Modify one or more bytes of data in the Display module IOMap structure. You
 * provide the offset into the Display module IOMap structure where you want to
 * start writing, the number of bytes to write at that location, and a byte
 * array containing the new data.
 * \param _offset The number of bytes offset from the start of the Display module
 * IOMap structure where the data should be written. See \ref DisplayIOMAP.
 * \param _cnt The number of bytes to write at the specified Display module
 * IOMap offset.
 * \param _arrIn The byte array containing the data to write to the Display
 * module IOMap.
 */
#define SetDisplayModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(DisplayModuleID, _offset, _cnt, _arrIn)

/**
 * Set Comm module IOMap bytes.
 * Modify one or more bytes of data in an IOMap structure. You provide the
 * offset into the Comm module IOMap structure where you want to start writing,
 * the number of bytes to write at that location, and a byte array containing
 * the new data.
 * \param _offset The number of bytes offset from the start of the Comm module
 * IOMap structure where the data should be written. See \ref CommIOMAP.
 * \param _cnt The number of bytes to write at the specified Comm module IOMap
 * offset.
 * \param _arrIn The byte array containing the data to write to the Comm module
 * IOMap.
 */
#define SetCommModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(CommModuleID, _offset, _cnt, _arrIn)

#else

#define SetCommandModuleValue(_offset, _n) SetIOMapValue(CommandModuleName, _offset, _n)
#define SetIOCtrlModuleValue(_offset, _n) SetIOMapValue(IOCtrlModuleName, _offset, _n)
#define SetLoaderModuleValue(_offset, _n) SetIOMapValue(LoaderModuleName, _offset, _n)
#define SetUIModuleValue(_offset, _n) SetIOMapValue(UIModuleName, _offset, _n)
#define SetSoundModuleValue(_offset, _n) SetIOMapValue(SoundModuleName, _offset, _n)
#define SetButtonModuleValue(_offset, _n) SetIOMapValue(ButtonModuleName, _offset, _n)
#define SetInputModuleValue(_offset, _n) SetIOMapValue(InputModuleName, _offset, _n)
#define SetOutputModuleValue(_offset, _n) SetIOMapValue(OutputModuleName, _offset, _n)
#define SetLowSpeedModuleValue(_offset, _n) SetIOMapValue(LowSpeedModuleName, _offset, _n)
#define SetDisplayModuleValue(_offset, _n) SetIOMapValue(DisplayModuleName, _offset, _n)
#define SetCommModuleValue(_offset, _n) SetIOMapValue(CommModuleName, _offset, _n)

#define SetCommandModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytes(CommandModuleName, _offset, _cnt, _arrIn)
#define SetLowSpeedModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytes(LowSpeedModuleName, _offset, _cnt, _arrIn)
#define SetDisplayModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytes(DisplayModuleName, _offset, _cnt, _arrIn)
#define SetCommModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytes(CommModuleName, _offset, _cnt, _arrIn)

#endif

/**
 * Get IOMap bytes by name.
 * Read one or more bytes of data from an IOMap structure. The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to start reading, the number of bytes to
 * read from that location, and a byte array where the data will be stored.
 * \param _modName The module name of the IOMap. See \ref ModuleNameConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the data should be read
 * \param _cnt The number of bytes to read from the specified IOMap
 * offset.
 * \param _arrOut A byte array that will contain the data read from the IOMap
 */
#define GetIOMapBytes(_modName, _offset, _cnt, _arrOut) __getIOMapBytes(_modName, _offset, _cnt, _arrOut)

/**
 * Get IOMap value by name.
 * Read a value from an IOMap structure.  The IOMap
 * structure is specified by its module name. You also provide the offset into
 * the IOMap structure where you want to read the value along with a variable
 * that will contain the IOMap value.
 * \param _modName The module name of the IOMap. See \ref ModuleNameConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read
 * \param _n A variable that will contain the value read from the IOMap
 */
#define GetIOMapValue(_modName, _offset, _n) __getIOMapValue(_modName, _offset, _n)

#ifdef __ENHANCED_FIRMWARE

/**
 * Get IOMap bytes by ID.
 * Read one or more bytes of data from an IOMap structure. The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to start reading, the number of bytes to
 * read from that location, and a byte array where the data will be stored.
 * \param _modID The module ID of the IOMap. See \ref ModuleIDConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the data should be read.
 * \param _cnt The number of bytes to read from the specified IOMap
 * offset.
 * \param _arrOut A byte array that will contain the data read from the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define GetIOMapBytesByID(_modID, _offset, _cnt, _arrOut) __getIOMapBytesByID(_modID, _offset, _cnt, _arrOut)

/**
 * Get IOMap value by ID.
 * Read a value from an IOMap structure.  The IOMap
 * structure is specified by its Module ID. You also provide the offset into
 * the IOMap structure where you want to read the value along with a variable
 * that will contain the IOMap value.
 * \param _modID The module ID of the IOMap. See \ref ModuleIDConstants.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read.
 * \param _n A variable that will contain the value read from the IOMap.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define GetIOMapValueByID(_modID, _offset, _n) __getIOMapValueByID(_modID, _offset, _n)

/**
 * Get Command module IOMap value.
 * Read a value from the Command module IOMap structure.  You provide the
 * offset into the Command module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref CommandIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetCommandModuleValue(_offset, _n) GetIOMapValueByID(CommandModuleID, _offset, _n)

/**
 * Get Loader module IOMap value.
 * Read a value from the Loader module IOMap structure.  You provide the
 * offset into the Loader module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref LoaderIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetLoaderModuleValue(_offset, _n) GetIOMapValueByID(LoaderModuleID, _offset, _n)

/**
 * Get Sound module IOMap value.
 * Read a value from the Sound module IOMap structure.  You provide the
 * offset into the Sound module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref SoundIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetSoundModuleValue(_offset, _n) GetIOMapValueByID(SoundModuleID, _offset, _n)

/**
 * Get Button module IOMap value.
 * Read a value from the Button module IOMap structure.  You provide the
 * offset into the Button module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref ButtonIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetButtonModuleValue(_offset, _n) GetIOMapValueByID(ButtonModuleID, _offset, _n)

/**
 * Get Ui module IOMap value.
 * Read a value from the Ui module IOMap structure.  You provide the
 * offset into the Ui module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref UiIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetUIModuleValue(_offset, _n) GetIOMapValueByID(UIModuleID, _offset, _n)

/**
 * Get Input module IOMap value.
 * Read a value from the Input module IOMap structure.  You provide the
 * offset into the Input module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref InputIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetInputModuleValue(_offset, _n) GetIOMapValueByID(InputModuleID, _offset, _n)

/**
 * Get Output module IOMap value.
 * Read a value from the Output module IOMap structure.  You provide the
 * offset into the Output module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref OutputIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetOutputModuleValue(_offset, _n) GetIOMapValueByID(OutputModuleID, _offset, _n)

/**
 * Get LowSpeed module IOMap value.
 * Read a value from the LowSpeed module IOMap structure.  You provide the
 * offset into the Command module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref LowSpeedIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetLowSpeedModuleValue(_offset, _n) GetIOMapValueByID(LowSpeedModuleID, _offset, _n)

/**
 * Get Display module IOMap value.
 * Read a value from the Display module IOMap structure.  You provide the
 * offset into the Display module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref DisplayIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetDisplayModuleValue(_offset, _n) GetIOMapValueByID(DisplayModuleID, _offset, _n)

/**
 * Get Comm module IOMap value.
 * Read a value from the Comm module IOMap structure.  You provide the
 * offset into the Comm module IOMap structure where you want to read
 * the value from along with a variable that will store the value. The type
 * of the variable determines how many bytes are read from the IOMap.
 * \param _offset The number of bytes offset from the start of the IOMap
 * structure where the value should be read. See \ref CommIOMAP.
 * \param _n A variable that will contain the value read from the IOMap.
 */
#define GetCommModuleValue(_offset, _n) GetIOMapValueByID(CommModuleID, _offset, _n)

#else

#define GetCommandModuleValue(_offset, _n) GetIOMapValue(CommandModuleName, _offset, _n)
#define GetLoaderModuleValue(_offset, _n) GetIOMapValue(LoaderModuleName, _offset, _n)
#define GetSoundModuleValue(_offset, _n) GetIOMapValue(SoundModuleName, _offset, _n)
#define GetButtonModuleValue(_offset, _n) GetIOMapValue(ButtonModuleName, _offset, _n)
#define GetUIModuleValue(_offset, _n) GetIOMapValue(UIModuleName, _offset, _n)
#define GetInputModuleValue(_offset, _n) GetIOMapValue(InputModuleName, _offset, _n)
#define GetOutputModuleValue(_offset, _n) GetIOMapValue(OutputModuleName, _offset, _n)
#define GetLowSpeedModuleValue(_offset, _n) GetIOMapValue(LowSpeedModuleName, _offset, _n)
#define GetDisplayModuleValue(_offset, _n) GetIOMapValue(DisplayModuleName, _offset, _n)
#define GetCommModuleValue(_offset, _n) GetIOMapValue(CommModuleName, _offset, _n)

#endif

/**
 * Get Lowspeed module IOMap bytes.
 * Read one or more bytes of data from Lowspeed module IOMap structure.
 * You provide the offset into the Lowspeed module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param _offset The number of bytes offset from the start of the Lowspeed
 * module IOMap structure where the data should be read. See \ref LowSpeedIOMAP.
 * \param _cnt The number of bytes to read from the specified Lowspeed module
 * IOMap offset.
 * \param _arrOut A byte array that will contain the data read from the Lowspeed
 * module IOMap.
 */
#define GetLowSpeedModuleBytes(_offset, _cnt, _arrOut) __getLowSpeedModuleBytes(_offset, _cnt, _arrOut)

/**
 * Get Display module IOMap bytes.
 * Read one or more bytes of data from Display module IOMap structure.
 * You provide the offset into the Display module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param _offset The number of bytes offset from the start of the Display
 * module IOMap structure where the data should be read. See \ref DisplayIOMAP.
 * \param _cnt The number of bytes to read from the specified Display module
 * IOMap offset.
 * \param _arrOut A byte array that will contain the data read from the Display
 * module IOMap.
 */
#define GetDisplayModuleBytes(_offset, _cnt, _arrOut) __getDisplayModuleBytes(_offset, _cnt, _arrOut)

/**
 * Get Comm module IOMap bytes.
 * Read one or more bytes of data from Comm module IOMap structure.
 * You provide the offset into the Comm module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param _offset The number of bytes offset from the start of the Comm module
 * IOMap structure where the data should be read. See \ref CommIOMAP.
 * \param _cnt The number of bytes to read from the specified Comm module
 * IOMap offset.
 * \param _arrOut A byte array that will contain the data read from the Comm
 * module IOMap.
 */
#define GetCommModuleBytes(_offset, _cnt, _arrOut) __getCommModuleBytes(_offset, _cnt, _arrOut)

/**
 * Get Command module IOMap bytes.
 * Read one or more bytes of data from Command module IOMap structure.
 * You provide the offset into the Command module IOMap structure where you
 * want to start reading, the number of bytes to read from that location, and
 * a byte array where the data will be stored.
 * \param _offset The number of bytes offset from the start of the Command module
 * IOMap structure where the data should be read. See \ref CommandIOMAP.
 * \param _cnt The number of bytes to read from the specified Command module
 * IOMap offset.
 * \param _arrOut A byte array that will contain the data read from the Command
 * module IOMap.
 */
#define GetCommandModuleBytes(_offset, _cnt, _arrOut) __getCommandModuleBytes(_offset, _cnt, _arrOut)

/**
 * Reset the sleep timer.
 * This function lets you reset the sleep timer.
 *
 */
#define ResetSleepTimer syscall KeepAlive, __KeepAliveArgs

/**
 * Get the first tick.
 * Return an unsigned 32-bit value, which is the system timing value
 * (called a "tick") in milliseconds at the time that the program began
 * running.
 *
 * \param _value The tick count at the start of program execution.
 */
#define GetFirstTick(_value) __GetFirstTick(_value)

/**
 * Wait some milliseconds.
 * Make a task sleep for specified amount of time (in 1000ths of a second).
 *
 * \param _n The number of milliseconds to sleep.
 */
#define Wait(_n) waitv _n

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
/**
 * Read memory information.
 * Read the current pool size and dataspace size.  Optionally compact the
 * dataspace before returning the information. Running programs have a maximum
 * of 32k bytes of memory available.  The amount of free RAM can be calculated
 * by subtracting the value returned by this function from \ref POOL_MAX_SIZE.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _Compact A boolean value indicating whether to compact the dataspace or not.
 * \param _PoolSize The current pool size.
 * \param _DataspaceSize The current dataspace size.
 * \param _Result The function call result. It will be \ref NO_ERR if the compact
 * operation is not performed.  Otherwise it will be the result of the compact
 * operation.
 */
#define GetMemoryInfo(_Compact,_PoolSize,_DataspaceSize,_Result) __GetMemoryInfo(_Compact,_PoolSize,_DataspaceSize,_Result)

/**
 * Read last response information.
 * Read the last direct or system command response packet received by the NXT.
 * Optionally clear the response after retrieving the information.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.31+.
 *
 * \param _Clear A boolean value indicating whether to clear the response or not.
 * \param _Length The response packet length.
 * \param _Command The original command byte.
 * \param _Buffer The response packet buffer.
 * \param _Result The response status code.
 */
#define GetLastResponseInfo(_Clear,_Length,_Command,_Buffer,_Result) __GetLastResponseInfo(_Clear,_Length,_Command,_Buffer,_Result)

#endif


/** @} */ // end of CommandModuleFunctions group
/** @} */ // end of CommandModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// BUTTON MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup ButtonModule
 * @{
 */
/** @defgroup ButtonModuleFunctions Button module functions
 * Functions for accessing and modifying Button module features.
 * @{
 */

/**
 * Read button information.
 * Read the specified button. Set the pressed and count parameters with the
 * current state of the button. Optionally reset the press count after
 * reading it.
 *
 * \param _idx The button to check. See \ref ButtonNameConstants.
 * \param _reset Whether or not to reset the press counter.
 * \param _pressed The button pressed state.
 * \param _count The button press count.
 * \param _result The function call result.
 */
#define ReadButtonEx(_idx, _reset, _pressed, _count, _result) __ReadButtonEx(_idx, _reset, _pressed, _count, _result)

/**
 * Get button press count.
 * Return the press count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button press count.
 */
#define GetButtonPressCount(_b, _n) __GetButtonPressCount(_b, _n)

/**
 * Get button long press count.
 * Return the long press count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button long press count.
 */
#define GetButtonLongPressCount(_b, _n) __GetButtonLongPressCount(_b, _n)

/**
 * Get button short release count.
 * Return the short release count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button short release count.
 */
#define GetButtonShortReleaseCount(_b, _n) __GetButtonShortReleaseCount(_b, _n)

/**
 * Get button long release count.
 * Return the long release count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button long release count.
 */
#define GetButtonLongReleaseCount(_b, _n) __GetButtonLongReleaseCount(_b, _n)

/**
 * Get button release count.
 * Return the release count of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button release count.
*/
#define GetButtonReleaseCount(_b, _n) __GetButtonReleaseCount(_b, _n)

/**
 * Get button state.
 * Return the state of the specified button. See \ref ButtonStateConstants.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The button state.
 */
#define GetButtonState(_b, _n) __GetButtonState(_b, _n)

/**
 * Set button press count.
 * Set the press count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new press count value.
 */
#define SetButtonPressCount(_b, _n) __setButtonPressCount(_b, _n)

/**
 * Set button long press count.
 * Set the long press count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new long press count value.
 */
#define SetButtonLongPressCount(_b, _n) __setButtonLongPressCount(_b, _n)

/**
 * Set button short release count.
 * Set the short release count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new short release count value.
 */
#define SetButtonShortReleaseCount(_b, _n) __setButtonShortReleaseCount(_b, _n)

/**
 * Set button long release count.
 * Set the long release count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new long release count value.
 */
#define SetButtonLongReleaseCount(_b, _n) __setButtonLongReleaseCount(_b, _n)

/**
 * Set button release count.
 * Set the release count of the specified button.
 *
 * \param _b The button number. See \ref ButtonNameConstants.
 * \param _n The new release count value.
 */
#define SetButtonReleaseCount(_b, _n) __setButtonReleaseCount(_b, _n)

/**
 * Set button state.
 * Set the state of the specified button.
 *
 * \param _b The button to check. See \ref ButtonNameConstants.
 * \param _n The new button state. See \ref ButtonStateConstants.
*/
#define SetButtonState(_b, _n) __setButtonState(_b, _n)

/** @} */ // end of ButtonModuleFunctions group
/** @} */ // end of ButtonModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
////////////////////////////////// UI MODULE //////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup UiModule
 * @{
 */
/** @defgroup UiModuleFunctions Ui module functions
 * Functions for accessing and modifying Ui module features.
 * @{
 */

/**
 * Set command flags.
 * Set the command flags.
 *
 * \param _n The new command flags. See \ref UiFlagsConstants.
 */
#define SetCommandFlags(_n) __setCommandFlags(_n)

/**
 * Set UI state.
 * Set the user interface state.
 *
 * \param _n A user interface state value. See \ref UiStateConstants.
 */
#define SetUIState(_n) __setUIState(_n)

/**
 * Set UI button.
 * Set user interface button information.
 *
 * \param _n A user interface button value. See \ref UiButtonConstants.
 */
#define SetUIButton(_n) __setUIButton(_n)

/**
 * Set VM run state.
 * Set VM run state information.
 *
 * \param _n The desired VM run state. See \ref UiVMRunStateConstants.
 */
#define SetVMRunState(_n) __setVMRunState(_n)

/**
 * Set battery state.
 * Set battery state information.
 *
 * \param _n The desired battery state (0..4).
 */
#define SetBatteryState(_n) __setBatteryState(_n)

/**
 * Set bluetooth state.
 * Set the Bluetooth state.
 *
 * \param _n The desired bluetooth state. See \ref UiBluetoothStateConstants.
 */
#define SetBluetoothState(_n) __setBluetoothState(_n)

/**
 * Set Usb state.
 * This method sets the value of the Usb state.
 * \param _n The Usb state.
 */
#define SetUsbState(_n) __setUsbState(_n)

/**
 * Set sleep timeout.
 * Set the NXT sleep timeout value to the specified number of minutes.
 *
 * \param _n The minutes to wait before sleeping.
 */
#define SetSleepTimeout(_n) __setSleepTimeout(_n)

/**
 * Set the sleep timer.
 * Set the system sleep timer to the specified number of minutes.
 *
 * \param _n The minutes left on the timer.
 */
#define SetSleepTimer(_n) __setSleepTimer(_n)

/**
 * Set volume.
 * Set the user interface volume level. Valid values are from 0 to 4.
 *
 * \param _n The new volume level.
 */
#define SetVolume(_n) __setVolume(_n)

/**
 * Set on-brick program pointer.
 * Set the current OBP (on-brick program) step.
 *
 * \param _n The new on-brick program step.
 */
#define SetOnBrickProgramPointer(_n) __setOnBrickProgramPointer(_n)

/**
 * Turn off NXT.
 * Force the NXT to turn off if the specified value is greater than zero.
 * \param _n If greater than zero the NXT will turn off.
*/
#define ForceOff(_n) __forceOff(_n)

/**
 * Set abort flag.
 * Set the enhanced NBC/NXC firmware's program abort flag. By default the
 * running program can be interrupted by a short press of the escape button.
 * You can change this to any other button state flag.
 *
 * \param _n The new abort flag value. See \ref ButtonStateConstants
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SetAbortFlag(_n) __setAbortFlag(_n)

/**
 * Get battery Level.
 * Return the battery level in millivolts.
 * \param _n The battery level
 */
#define GetBatteryLevel(_n) __GetBatteryLevel(_n)

/**
 * Get command flags.
 * Return the command flags.
 * \param _n Command flags. See \ref UiFlagsConstants
 */
#define GetCommandFlags(_n) __GetCommandFlags(_n)

/**
 * Get UI module state.
 * Return the user interface state.
 * \param _n The UI module state. See \ref UiStateConstants.
 */
#define GetUIState(_n) __GetUIState(_n)

/**
 * Read UI button.
 * Return user interface button information.
 * \param _n A UI button value.  See \ref UiButtonConstants.
 */
#define GetUIButton(_n) __GetUIButton(_n)

/**
 * Read VM run state.
 * Return VM run state information.
 * \param _n VM run state. See \ref UiVMRunStateConstants.
 */
#define GetVMRunState(_n) __GetVMRunState(_n)

/**
 * Get battery state.
 * Return battery state information (0..4).
 * \param _n The battery state (0..4)
 */
#define GetBatteryState(_n) __GetBatteryState(_n)

/**
 * Get bluetooth state.
 * Return the bluetooth state.
 * \param _n The bluetooth state. See \ref UiBluetoothStateConstants.
 */
#define GetBluetoothState(_n) __GetBluetoothState(_n)

/**
 * Get UI module USB state.
 * This method returns the UI module USB state.
 * \param _n The UI module USB state.  (0=disconnected, 1=connected, 2=working)
 */
#define GetUsbState(_n) __GetUsbState(_n)

/**
 * Read sleep timeout.
 * Return the number of minutes that the NXT will remain on before
 * it automatically shuts down.
 * \param _n The sleep timeout value
 */
#define GetSleepTimeout(_n) __GetSleepTimeout(_n)

/**
 * Read sleep timer.
 * Return the number of minutes left in the countdown to zero from the
 * original SleepTimeout value. When the SleepTimer value reaches zero the
 * NXT will shutdown.
 * \param _n The sleep timer value
 */
#define GetSleepTimer(_n) __GetSleepTimer(_n)

/**
 * Read battery type.
 * Return whether the NXT has a rechargeable battery installed or not.
 * \param _n Whether the battery is rechargeable or not. (false = no, true = yes)
 */
#define GetRechargeableBattery(_n) __GetRechargeableBattery(_n)

/**
 * Read volume.
 * Return the user interface volume level. Valid values are from 0 to 4.
 * \param _n The UI module volume. (0..4)
 */
#define GetVolume(_n) __GetVolume(_n)

/**
 * Read the on brick program pointer value.
 * Return the current OBP (on-brick program) step
 *
 * \param _n On brick program pointer (step).
 */
#define GetOnBrickProgramPointer(_n) __GetOnBrickProgramPointer(_n)

/**
 * Read abort flag.
 * Return the enhanced NBC/NXC firmware's abort flag.
 *
 * \param _n The current abort flag value.  See \ref ButtonStateConstants.
 * \warning This function requires the enhanced NBC/NXC firmware.
*/
#define GetAbortFlag(_n) __GetAbortFlag(_n)

/** @} */ // end of UiModuleFunctions group
/** @} */ // end of UiModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
///////////////////////////////// COMM MODULE /////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup CommModule
 * @{
 */
/** @defgroup CommModuleFunctions Comm module functions
 * Functions for accessing and modifying Comm module features.
 * @{
 */

/**
 * Send a message to a queue/mailbox.
 * Write a message into a local mailbox.
 * 
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _msg The message to write to the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendMessage(_queue, _msg, _result) __sendMessage(_queue, _msg, _result)

/**
 * Read a message from a queue/mailbox.
 * Read a message from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _msg The message that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveMessage(_queue, _clear, _msg, _result) __receiveMessage(_queue, _clear, _msg, _result)

/**
 * Read a boolean value from a queue/mailbox.
 * Read a boolean value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _bval The boolean value that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveRemoteBool(_queue, _clear, _bval, _result) __receiveRemoteBool(_queue, _clear, _bval, _result)

/**
 * Read a numeric value from a queue/mailbox.
 * Read a numeric value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _val The numeric value that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveRemoteNumber(_queue, _clear, _val, _result) __receiveRemoteNumber(_queue, _clear, _val, _result)

/**
 * Read a string value from a queue/mailbox.
 * Read a string value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _str The string value that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveRemoteString(_queue, _clear, _str, _result) __receiveMessage(_queue, _clear, _str, _result)

/**
 * Read a value from a queue/mailbox.
 * Read a value from a mailbox and optionally remove it.  If the local mailbox
 * is empty and this NXT is the master then it attempts to poll one of its
 * slave NXTs for a message from the response mailbox that corresponds to the
 * specified local mailbox number.  Output the value in string, number, and
 * boolean form.
 *
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _clear A flag indicating whether to remove the message from the mailbox
 * after it has been read.
 * \param _str The string value that is read from the mailbox.
 * \param _val The numeric value that is read from the mailbox.
 * \param _bval The boolean value that is read from the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define ReceiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, _result) __receiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, _result)

/**
 * Write a string value to a local response mailbox.
 * Write a string value to a response mailbox (the mailbox number + 10).
 *
 * \param _queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param _msg The string value to write.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendResponseString(_queue, _msg, _result) __sendResponseString(_queue, _msg, _result)

/**
 * Write a boolean value to a local response mailbox.
 * Write a boolean value to a response mailbox (the mailbox number + 10).
 *
 * \param _queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param _bval The boolean value to write.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendResponseBool(_queue, _bval, _result) __sendResponseBool(_queue, _bval, _result)

/**
 * Write a numeric value to a local response mailbox.
 * Write a numeric value to a response mailbox (the mailbox number + 10).
 *
 * \param _queue The mailbox number. See \ref MailboxConstants. This function
 * shifts the specified value into the range of response mailbox numbers by
 * adding 10.
 * \param _val The numeric value to write.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendResponseNumber(_queue, _val, _result) __sendResponseNumber(_queue, _val, _result)

/**
 * Check bluetooth status.
 * Check the status of the bluetooth subsystem for the specified connection slot.
 *
 * \param _conn The connection slot (0..3). Connections 0 through 3 are for
 * bluetooth connections. See \ref CommConnectionConstants.
 * \param _result The bluetooth status for the specified connection.
 */
#define BluetoothStatus(_conn, _result) __bluetoothStatus(_conn, _result)

/**
 * Write to a bluetooth connection.
 * This method tells the NXT firmware to write the data in the buffer to the
 * device on the specified Bluetooth connection. Use \ref BluetoothStatus to
 * determine when this write request is completed.
 *
 * \param _conn The connection slot (0..3). Connections 0 through 3 are for
 * bluetooth connections.  See \ref CommConnectionConstants.
 * \param _buffer The data to be written (up to 128 bytes)
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define BluetoothWrite(_conn, _buffer, _result) __bluetoothWrite(_conn, _buffer, _result)

/**
 * Write to a remote connection.
 * This method tells the NXT firmware to write the data in the buffer to the
 * device on the specified connection. Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _buffer The data to be written (up to 128 bytes)
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning Writing to the RS485 hi-speed connection requires the enhanced
 * NBC/NXC firmware 
 */
#define RemoteConnectionWrite(_conn, _buffer, _result) __connectionRawWrite(_conn, _buffer, _result)

/**
 * Check if remote connection is idle.
 * Check whether a Bluetooth or RS485 hi-speed port connection is idle,
 * i.e., not currently sending data.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A boolean value indicating whether the connection is idle or busy.
 *
 * \warning Checking the status of the RS485 hi-speed connection requires the
 * enhanced NBC/NXC firmware
 */
#define RemoteConnectionIdle(_conn, _result) __remoteConnectionIdle(_conn, _result)

/**
 * Send a boolean value to a remote mailbox.
 * Send a boolean value on the specified connection to the
 * specified remote mailbox number.  Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _bval The boolean value to send.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendRemoteBool(_conn, _queue, _bval, _result) __sendRemoteBool(_conn, _queue, _bval, _result)

/**
 * Send a numeric value to a remote mailbox.
 * Send a numeric value on the specified connection to the
 * specified remote mailbox number.  Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _val The numeric value to send.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendRemoteNumber(_conn, _queue, _val, _result) __sendRemoteNumber(_conn, _queue, _val, _result)

/**
 * Send a string value to a remote mailbox.
 * Send a string value on the specified connection to the
 * specified remote mailbox number. Use \ref RemoteConnectionIdle to determine
 * when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox number. See \ref MailboxConstants.
 * \param _str The string value to send.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define SendRemoteString(_conn, _queue, _str, _result) __sendRemoteString(_conn, _queue, _str, _result)


/** @defgroup CommModuleDCFunctions Direct Command functions
 * Functions for sending direct commands to another NXT.
 * @{
 */

/**
 * Send a MessageRead message.
 * This method sends a MessageRead direct command to the device on the
 * specified connection. Use \ref RemoteConnectionIdle to determine when this write
 * request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox to read. See \ref MailboxConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteMessageRead(_conn, _queue, _result) __remoteMessageRead(_conn, _queue, _result)

/**
 * Send a MessageWrite message.
 * This method sends a MessageWrite direct command to the device on the
 * specified connection. Use \ref RemoteConnectionIdle to determine when this write
 * request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _queue The mailbox to write. See \ref MailboxConstants.
 * \param _msg The message to write to the mailbox.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteMessageWrite(_conn, _queue, _msg, _result) __sendRemoteString(_conn, _queue, _msg, _result)

/**
 * Send a StartProgram message.
 * Send the StartProgram direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to start running.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteStartProgram(_conn, _filename, _result) __remoteStartProgram(_conn, _filename, _result)

/**
 * Send a StopProgram message.
 * Send the StopProgram direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteStopProgram(_conn, _result) __connectionSCDCWrite(_conn, __DCStopProgramPacket, _result)

/**
 * Send a PlaySoundFile message.
 * Send the PlaySoundFile direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the sound file to play.
 * \param _bloop A boolean value indicating whether to loop the sound file or not.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePlaySoundFile(_conn, _filename, _bloop, _result) __remotePlaySoundFile(_conn, _filename, _bloop, _result)

/**
 * Send a PlayTone message.
 * Send the PlayTone direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _frequency The frequency of the tone.
 * \param _duration The duration of the tone.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePlayTone(_conn, _frequency, _duration, _result) __remotePlayTone(_conn, _frequency, _duration, _result)

/**
 * Send a StopSound message.
 * Send the StopSound direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteStopSound(_conn, _result) __connectionSCDCWrite(_conn, __DCStopSoundPacket, _result)

/**
 * Send a KeepAlive message.
 * This method sends a KeepAlive direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteKeepAlive(_conn, _result) __connectionSCDCWrite(_conn, __DCKeepAlivePacket, _result)

/**
 * Send a ResetScaledValue message.
 * Send the ResetScaledValue direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port to reset.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteResetScaledValue(_conn, _port, _result) __remoteResetScaledValue(_conn, _port, _result)

/**
 * Send a ResetMotorPosition message.
 * Send the ResetMotorPosition direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The output port to reset.
 * \param _brelative A flag indicating whether the counter to reset is relative.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteResetMotorPosition(_conn, _port, _brelative, _result) __remoteResetMotorPosition(_conn, _port, _brelative, _result)

/**
 * Send a SetInputMode message.
 * Send the SetInputMode direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port to configure. See \ref NBCInputPortConstants.
 * \param _type The sensor type. See \ref NBCSensorTypeConstants.
 * \param _mode The sensor mode. See \ref NBCSensorModeConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteSetInputMode(_conn, _port, _type, _mode, _result) __remoteSetInputMode(_conn, _port, _type, _mode, _result)

/**
 * Send a SetOutputMode message.
 * Send the SetOutputMode direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The output port to configure. See \ref OutputPortConstants.
 * \param _speed The motor speed. (-100..100)
 * \param _mode The motor mode. See \ref OutModeConstants.
 * \param _regmode The motor regulation mode. See \ref OutRegModeConstants.
 * \param _turnpct The motor synchronized turn percentage. (-100..100)
 * \param _runstate The motor run state. See \ref OutRunStateConstants.
 * \param _tacholimit The motor tachometer limit.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, _result) \
  __remoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, _result)

#ifdef __ENHANCED_FIRMWARE

/**
 * Send a GetOutputState message.
 * Send the GetOutputState direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _params The input and output parameters for the function call.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetOutputState(_conn, _params, _result) \
  compchktype _params, TOutputState \
  __remoteGetOutputState(_conn, _params, _result)

/**
 * Send a GetInputValues message.
 * Send the GetInputValues direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _params The input and output parameters for the function call.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetInputValues(_conn, _params, _result) \
  compchktype _params, TInputValues \
__remoteGetInputValues(_conn, _params, _result)

/**
 * Send a GetBatteryLevel message.
 * This method sends a GetBatteryLevel direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _value The battery level value.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetBatteryLevel(_conn, _value, _result) __remoteGetBatteryLevel(_conn, _value, _result)

/**
 * Send a LSGetStatus message.
 * This method sends a LSGetStatus direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _value The count of available bytes to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedGetStatus(_conn, _value, _result) __remoteLowspeedGetStatus(_conn, _value, _result)

/**
 * Send a LowspeedRead message.
 * Send the LowspeedRead direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port from which to read I2C data. See \ref NBCInputPortConstants.
 * \param _bread The number of bytes read.
 * \param _data A byte array containing the data read from the I2C device.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedRead(_conn, _port, _bread, _data, _result) __remoteLowspeedRead(_conn, _port, _bread, _data, _result)

/**
 * Send a GetCurrentProgramName message.
 * This method sends a GetCurrentProgramName direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _name The current program name.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetCurrentProgramName(_conn, _name, _result) __remoteGetCurrentProgramName(_conn, _name, _result)

/**
 * Send a DatalogRead message.
 * Send the DatalogRead direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _remove Remove the datalog message from the queue after reading it (true or false).
 * \param _cnt The number of bytes read from the datalog.
 * \param _log A byte array containing the datalog contents.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDatalogRead(_conn, _remove, _cnt, _log, _result) __remoteDatalogRead(_conn, _remove, _cnt, _log, _result)

/**
 * Send a GetContactCount message.
 * This method sends a GetContactCount direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _cnt The number of contacts.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetContactCount(_conn, _cnt, _result) __remoteGetContactCount(_conn, _cnt, _result)

/**
 * Send a GetContactName message.
 * Send the GetContactName direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _idx The index of the contact.
 * \param _name The name of the specified contact.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetContactName(_conn, _idx, _name, _result) __remoteGetContactName(_conn, _idx, _name, _result)

/**
 * Send a GetConnectionCount message.
 * This method sends a GetConnectionCount direct command to the device on the specified
 * connection.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _cnt The number of connections.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetConnectionCount(_conn, _cnt, _result) __remoteGetConnectionCount(_conn, _cnt, _result)

/**
 * Send a GetConnectionName message.
 * Send the GetConnectionName direct command on the specified connection slot.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _idx The index of the connection.
 * \param _name The name of the specified connection.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetConnectionName(_conn, _idx, _name, _result) __remoteGetConnectionName(_conn, _idx, _name, _result)


#else

/**
 * Send a GetOutputState message.
 * Send the GetOutputState direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The output port from which to read state information. See \ref OutputPortConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetOutputState(_conn, _port, _result) __remoteGetOutputState(_conn, _port, _result)

/**
 * Send a GetInputValues message.
 * Send the GetInputValues direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port from which to read sensor values. See \ref NBCInputPortConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetInputValues(_conn, _port, _result) __remoteGetInputValues(_conn, _port, _result)

/**
 * Send a GetBatteryLevel message.
 * This method sends a GetBatteryLevel direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetBatteryLevel(_conn, _result) __remoteGetBatteryLevel(_conn, _result)

/**
 * Send a LSGetStatus message.
 * This method sends a LSGetStatus direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedGetStatus(_conn, _result) __remoteLowspeedGetStatus(_conn, _result)

/**
 * Send a LowspeedRead message.
 * Send the LowspeedRead direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The input port from which to read I2C data. See \ref NBCInputPortConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedRead(_conn, _port, _result) __remoteLowspeedRead(_conn, _port, _result)

/**
 * Send a GetCurrentProgramName message.
 * This method sends a GetCurrentProgramName direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetCurrentProgramName(_conn, _result) __remoteGetCurrentProgramName(_conn, _result)

/**
 * Send a DatalogRead message.
 * Send the DatalogRead direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _remove Remove the datalog message from the queue after reading it (true or false).
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDatalogRead(_conn, _remove, _result) __remoteDatalogRead(_conn, _remove, _result)

/**
 * Send a GetContactCount message.
 * This method sends a GetContactCount direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetContactCount(_conn, _result) __remoteGetContactCount(_conn, _result)

/**
 * Send a GetContactName message.
 * Send the GetContactName direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _idx The index of the contact.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetContactName(_conn, _idx, _result) __remoteGetContactName(_conn, _idx, _result)

/**
 * Send a GetConnectionCount message.
 * This method sends a GetConnectionCount direct command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write
 * request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetConnectionCount(_conn, _result) __remoteGetConnectionCount(_conn, _result)

/**
 * Send a GetConnectionName message.
 * Send the GetConnectionName direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _idx The index of the connection.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetConnectionName(_conn, _idx, _result) __remoteGetConnectionName(_conn, _idx, _result)


#endif

/**
 * Send a ResetTachoCount message.
 * Send the ResetTachoCount direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The output port to reset the tachometer count on. See \ref OutputPortConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteResetTachoCount(_conn, _port, _result) __remoteResetTachoCount(_conn, _port, _result)

/**
 * Send a GetProperty message.
 * Send the GetProperty direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _property The property to read. See \ref RCPropertyConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetProperty(_conn, _property, _result) __remoteGetProperty(_conn, _property, _result)

/**
 * Send a DatalogSetTimes message.
 * Send the DatalogSetTimes direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _synctime The datalog sync time.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDatalogSetTimes(_conn, _synctime, _result) __remoteDatalogSetTimes(_conn, _synctime, _result)

/**
 * Send a SetProperty message.
 * Send the SetProperty direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _prop The property to set. See \ref RCPropertyConstants.
 * \param _value The new property value.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteSetProperty(_conn, _prop, _value, _result) __remoteSetProperty(_conn, _prop, _value, _result)

/**
 * Send a LowspeedWrite message.
 * Send the LowspeedWrite direct command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _port The I2C port. See \ref NBCInputPortConstants.
 * \param _txlen The number of bytes you are writing to the I2C device.
 * \param _rxlen The number of bytes want to read from the I2C device.
 * \param _data A byte array containing the data you are writing to the device.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteLowspeedWrite(_conn, _port, _txlen, _rxlen, _data, _result) __remoteLowspeedWrite(_conn, _port, _txlen, _rxlen, _data, _result)


/** @} */ // end of CommModuleDCFunctions group

/** @defgroup CommModuleSCFunctions System Command functions
 * Functions for sending system commands to another NXT.
 * @{
 */

#ifdef __ENHANCED_FIRMWARE

/**
 * Send an OpenRead message.
 * Send the OpenRead system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the file to open for reading.
 * \param _handle The handle of the file.
 * \param _size The size of the file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenRead(_conn, _filename, _handle, _size, _result) __remoteOpenRead(_conn, _filename, _handle, _size, _result)

/**
 * Send an OpenAppendData message.
 * Send the OpenAppendData system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the file to open for appending.
 * \param _handle The handle of the file.
 * \param _size The size of the file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenAppendData(_conn, _filename, _handle, _size, _result) __remoteOpenAppendData(_conn, _filename, _handle, _size, _result)

/**
 * Send a DeleteFile message.
 * Send the DeleteFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to delete.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDeleteFile(_conn, _filename, _result) __remoteDeleteFile(_conn, _filename, _result)

/**
 * Send a FindFirstFile message.
 * Send the FindFirstFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _mask The filename mask for the files you want to find.
 * \param _handle The handle of the found file.
 * \param _name The name of the found file.
 * \param _size The size of the found file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteFindFirstFile(_conn, _mask, _handle, _name, _size, _result) __remoteFindFirstFile(_conn, _mask, _handle, _name, _size, _result)

/**
 * Send a GetFirmwareVersion message.
 * This method sends a GetFirmwareVersion system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _pmin The protocol minor version byte.
 * \param _pmaj The protocol major version byte.
 * \param _fmin The firmware minor version byte.
 * \param _fmaj The firmware major version byte.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetFirmwareVersion(_conn, _pmin, _pmaj, _fmin, _fmaj, _result) __remoteGetFirmwareVersion(_conn, _pmin, _pmaj, _fmin, _fmaj, _result)

/**
 * Send a GetBluetoothAddress message.
 * This method sends a GetBluetoothAddress system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _btaddr The bluetooth address of the remote device.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetBluetoothAddress(_conn, _btaddr, _result) __remoteGetBluetoothAddress(_conn, _btaddr, _result)

/**
 * Send a GetDeviceInfo message.
 * This method sends a GetDeviceInfo system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _name The name of the remote device.
 * \param _btaddr The bluetooth address of the remote device.
 * \param _btsignal The signal strength of each connection on the remote device.
 * \param _freemem The number of bytes of free flash memory on the remote device.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetDeviceInfo(_conn, _name, _btaddr, _btsignal, _freemem, _result) __remoteGetDeviceInfo(_conn, _name, _btaddr, _btsignal, _freemem, _result)

/**
 * Send a DeleteUserFlash message.
 * This method sends a DeleteUserFlash system command to the device on the specified
 * connection.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDeleteUserFlash(_conn, _result) __remoteDeleteUserFlash(_conn, _result)

/**
 * Send an OpenWrite message.
 * Send the OpenWrite system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWrite(_conn, _filename, _size, _result) __remoteOpenWrite(_conn, _filename, _size, _result)

/**
 * Send an OpenWriteLinear message.
 * Send the OpenWriteLinear system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWriteLinear(_conn, _filename, _size, _result) __remoteOpenWriteLinear(_conn, _filename, _size, _result)

/**
 * Send an OpenWriteData message.
 * Send the OpenWriteData system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWriteData(_conn, _filename, _size, _result) __remoteOpenWriteData(_conn, _filename, _size, _result)

/**
 * Send a CloseFile message.
 * Send the CloseFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file to close.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteCloseFile(_conn, _handle, _result) __remoteCloseFile(_conn, _handle, _result)

/**
 * Send a FindNextFile message.
 * Send the FindNextFile system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle returned by the last \ref FindFirstFile or FindNextFile call.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteFindNextFile(_conn, _handle, _result) __remoteFindNextFile(_conn, _handle, _result)

/**
 * Send a PollCommandLength message.
 * Send the PollCommandLength system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _bufnum The poll buffer you want to query (0=USBPoll, 1=HiSpeed).
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePollCommandLength(_conn, _bufnum, _result) __remotePollCommandLength(_conn, _bufnum, _result)

/**
 * Send a Write message.
 * Send the Write system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file you are writing to.
 * \param _data A byte array containing the data you are writing.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteWrite(_conn, _handle, _data, _result) __remoteWrite(_conn, _handle, _data, _result)

/**
 * Send a Read message.
 * Send the Read system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file you are reading from.
 * \param _numbytes The number of bytes you want to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteRead(_conn, _handle, _numbytes, _result) __remoteRead(_conn, _handle, _numbytes, _result)

/**
 * Send an IOMapRead message.
 * Send the IOMapRead system command on the specified connection slot.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _id The ID of the module from which to read data.
 * \param _offset The offset into the IOMap structure from which to read.
 * \param _numbytes The number of bytes of data to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteIOMapRead(_conn, _id, _offset, _numbytes, _result) __remoteIOMapRead(_conn, _id, _offset, _numbytes, _result)

/**
 * Send a PollCommand message.
 * Send the PollCommand system command on the specified connection slot to
 * write the data provided.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _bufnum The buffer from which to read data (0=USBPoll, 1=HiSpeed).
 * \param _len The number of bytes to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePollCommand(_conn, _bufnum, _len, _result) __remotePollCommand(_conn, _bufnum, _len, _result)

/**
 * Send a RenameFile message.
 * Send the RenameFile system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _oldname The old filename.
 * \param _newname The new filename.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteRenameFile(_conn, _oldname, _newname, _result) __remoteRenameFile(_conn, _oldname, _newname, _result)

#else

/**
 * Send an OpenRead message.
 * Send the OpenRead system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for reading.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenRead(_conn, _filename, _result) __remoteOpenRead(_conn, _filename, _result)

/**
 * Send an OpenAppendData message.
 * Send the OpenAppendData system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for appending.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenAppendData(_conn, _filename, _result) __remoteOpenAppendData(_conn, _filename, _result)

/**
 * Send a DeleteFile message.
 * Send the DeleteFile system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to delete.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDeleteFile(_conn, _filename, _result) __remoteDeleteFile(_conn, _filename, _result)

/**
 * Send a FindFirstFile message.
 * Send the FindFirstFile system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _mask The filename mask for the files you want to find.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteFindFirstFile(_conn, _mask, _result) __remoteFindFirstFile(_conn, _mask, _result)

/**
 * Send a GetFirmwareVersion message.
 * This method sends a GetFirmwareVersion system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetFirmwareVersion(_conn, _result) __connectionSCDCWrite(_conn, __SCGetFirmwareVerPacket, _result)

/**
 * Send a GetBluetoothAddress message.
 * This method sends a GetBluetoothAddress system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetBluetoothAddress(_conn, _result) __connectionSCDCWrite(_conn, __SCBTGetAddressPacket, _result)

/**
 * Send a GetDeviceInfo message.
 * This method sends a GetDeviceInfo system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteGetDeviceInfo(_conn, _result) __connectionSCDCWrite(_conn, __SCGetDeviceInfoPacket, _result)

/**
 * Send a DeleteUserFlash message.
 * This method sends a DeleteUserFlash system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteDeleteUserFlash(_conn, _result) __connectionSCDCWrite(_conn, __SCDeleteUserFlashPacket, _result)

/**
 * Send an OpenWrite message.
 * Send the OpenWrite system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWrite(_conn, _filename, _size, _result) __remoteOpenWrite(_conn, _filename, _size, _result)

/**
 * Send an OpenWriteLinear message.
 * Send the OpenWriteLinear system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWriteLinear(_conn, _filename, _size, _result) __remoteOpenWriteLinear(_conn, _filename, _size, _result)

/**
 * Send an OpenWriteData message.
 * Send the OpenWriteData system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _filename The name of the program to open for writing (i.e., create the file).
 * \param _size The size for the new file.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteOpenWriteData(_conn, _filename, _size, _result) __remoteOpenWriteData(_conn, _filename, _size, _result)

/**
 * Send a CloseFile message.
 * Send the CloseFile system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file to close.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteCloseFile(_conn, _handle, _result) __remoteCloseFile(_conn, _handle, _result)

/**
 * Send a FindNextFile message.
 * Send the FindNextFile system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle returned by the last \ref FindFirstFile or FindNextFile call.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteFindNextFile(_conn, _handle, _result) __remoteFindNextFile(_conn, _handle, _result)

/**
 * Send a PollCommandLength message.
 * Send the PollCommandLength system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _bufnum The poll buffer you want to query (0=USBPoll, 1=HiSpeed).
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePollCommandLength(_conn, _bufnum, _result) __remotePollCommandLength(_conn, _bufnum, _result)

/**
 * Send a Write message.
 * Send the Write system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file you are writing to.
 * \param _data A byte array containing the data you are writing.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteWrite(_conn, _handle, _data, _result) __remoteWrite(_conn, _handle, _data, _result)

/**
 * Send a Read message.
 * Send the Read system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _handle The handle of the file you are reading from.
 * \param _numbytes The number of bytes you want to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteRead(_conn, _handle, _numbytes, _result) __remoteRead(_conn, _handle, _numbytes, _result)

/**
 * Send an IOMapRead message.
 * Send the IOMapRead system command on the specified connection slot.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _id The ID of the module from which to read data.
 * \param _offset The offset into the IOMap structure from which to read.
 * \param _numbytes The number of bytes of data to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteIOMapRead(_conn, _id, _offset, _numbytes, _result) __remoteIOMapRead(_conn, _id, _offset, _numbytes, _result)

/**
 * Send a PollCommand message.
 * Send the PollCommand system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _bufnum The buffer from which to read data (0=USBPoll, 1=HiSpeed).
 * \param _len The number of bytes to read.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemotePollCommand(_conn, _bufnum, _len, _result) __remotePollCommand(_conn, _bufnum, _len, _result)

#endif

/**
 * Send a BluetoothFactoryReset message.
 * This method sends a BluetoothFactoryReset system command to the device on the specified
 * connection. Use \ref RemoteConnectionIdle to determine when this write request is
 * completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteBluetoothFactoryReset(_conn, _result) __connectionSCDCWrite(_conn, __SCBTFactoryResetPacket, _result)

/**
 * Send an IOMapWrite value message.
 * Send the IOMapWrite system command on the specified connection slot to
 * write the value provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _id The ID of the module to which to write data.
 * \param _offset The offset into the IOMap structure to which to write.
 * \param _value A scalar variable containing the value you are writing to the IOMap structure.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteIOMapWriteValue(_conn, _id, _offset, _value, _result) __remoteIOMapWriteValue(_conn, _id, _offset, _value, _result)

/**
 * Send an IOMapWrite bytes message.
 * Send the IOMapWrite system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _id The ID of the module to which to write data.
 * \param _offset The offset into the IOMap structure to which to write.
 * \param _data A byte array containing the data you are writing to the IOMap structure.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteIOMapWriteBytes(_conn, _id, _offset, _data, _result) __remoteIOMapWriteBytes(_conn, _id, _offset, _data, _result)

/**
 * Send a SetBrickName message.
 * Send the SetBrickName system command on the specified connection slot to
 * write the data provided.
 * Use \ref RemoteConnectionIdle to determine when this write request is completed.
 *
 * \param _conn The connection slot (0..4). Connections 0 through 3 are for
 * bluetooth connections.  Connection 4 refers to the RS485 hi-speed port.
 * See \ref CommConnectionConstants.
 * \param _name The new brick name.
 * \param _result A char value indicating whether the function call succeeded or not.
 */
#define RemoteSetBrickName(_conn, _name, _result) __remoteSetBrickName(_conn, _name, _result)

/** @} */ // end of CommModuleSCFunctions group

/**
 * Use the RS485 port.
 * Configure port 4 for RS485 usage.
 *
 */
#define UseRS485() __UseRS485()

#ifdef __ENHANCED_FIRMWARE

/**
 * Check RS485 status.
 * Check the status of the RS485 hi-speed port.
 *
 * \param _sendingData A boolean value set to true on output if data is being sent.
 * \param _dataAvail A boolean value set to true on output if data is available to be read.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Status(_sendingData, _dataAvail) __RS485Status(_sendingData, _dataAvail)

/**
 * Write RS485 data.
 * Write data to the RS485 hi-speed port.
 *
 * \param _buffer A byte array containing the data to write to the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Write(_buffer, _status) __RS485Write(_buffer, _status)

/**
 * Read RS485 data.
 * Read data from the RS485 hi-speed port.
 *
 * \param _buffer A byte array that will contain the data read from the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Read(_buffer, _status) __RS485Read(_buffer, _status)

#if __FIRMWARE_VERSION > 107

/**
 * Control the RS485 port.
 * Control the RS485 hi-speed port using the specified parameters.
 *
 * \param _cmd The control command to send to the port. See \ref CommHiSpeedCtrlConstants.
 * \param _baud The baud rate for the RS485 port. See \ref CommHiSpeedBaudConstants.
 * \param _mode The RS485 port mode (data bits, stop bits, parity).  See \ref
 * CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants, \ref
 * CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Control(_cmd, _baud, _mode, _result) __RS485Control(_cmd, _baud, _mode, _result)

/**
 * Configure RS485 UART.
 * Configure the RS485 UART parameters, including baud rate, data bits,
 * stop bits, and parity.
 *
 * \param _baud The baud rate for the RS485 port. See \ref CommHiSpeedBaudConstants.
 * \param _mode The RS485 port mode (data bits, stop bits, parity).  See \ref
 * CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants, \ref
 * CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Uart(_baud, _mode, _result) __RS485Control(HS_CTRL_UART, _baud, _mode, _result)

/**
 * Initialize RS485 port.
 * Initialize the RS485 UART port to its default values.  The baud rate is
 * set to 921600 and the mode is set to 8N1 (8 data bits, no parity, 1 stop bit).
 * Data cannot be sent or received over the RS485 port until the UART is
 * initialized and the port has been configured for RS485 usage.
 *
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Initialize(_result) __RS485Control(HS_CTRL_UART, HS_BAUD_DEFAULT, HS_MODE_DEFAULT, _result)

/**
 * Enable RS485.
 * Turn on the RS485 hi-speed port so that it can be used.
 *
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Enable(_result) __RS485Control(HS_CTRL_INIT, HS_BAUD_DEFAULT, HS_MODE_DEFAULT, _result)

/**
 * Disable RS485.
 * Turn off the RS485 port.
 *
 * \param _result A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define RS485Disable(_result) __RS485Control(HS_CTRL_EXIT, HS_BAUD_DEFAULT, HS_MODE_DEFAULT, _result)

#else

#define RS485Control(_cmd, _baud, _result) __RS485Control(_cmd, _baud, _result)
#define RS485Uart(_baud, _result) __RS485Control(HS_CTRL_UART, _baud, _result)
#define RS485Initialize(_result) __RS485Control(HS_CTRL_UART, HS_BAUD_DEFAULT, _result)
#define RS485Enable(_result) __RS485Control(HS_CTRL_INIT, HS_BAUD_DEFAULT, _result)
#define RS485Disable(_result) __RS485Control(HS_CTRL_EXIT, HS_BAUD_DEFAULT, _result)

#endif

/**
 * Write RS485 boolean.
 * Write a boolean value to the RS485 hi-speed port.
 *
 * \param _bval A boolean value to write over the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SendRS485Bool(_bval, _status) __sendRS485Bool(_bval, _status)

/**
 * Write RS485 numeric.
 * Write a numeric value to the RS485 hi-speed port.
 *
 * \param _val A numeric value to write over the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SendRS485Number(_val, _status) __sendRS485Number(_val, _status)

/**
 * Write RS485 string.
 * Write a string value to the RS485 hi-speed port.
 *
 * \param _str A string value to write over the RS485 port.
 * \param _status A char value indicating whether the function call succeeded or not.
 *
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define SendRS485String(_str, _status) __sendRS485String(_str, _status)

#endif

/**
 * Get bluetooth device name.
 * This method returns the name of the device at the specified index in the
 * Bluetooth device table.
 * \param _p The device table index.
 * \param _str The device name of the specified bluetooth device.
 */
#define GetBTDeviceName(_p, _str) __GetBTDeviceName(_p, _str)

/**
 * Get bluetooth device class.
 * This method returns the class of the device at the specified index within
 * the Bluetooth device table.
 * \param _p The device table index.
 * \param _n The device class of the specified bluetooth device.
 */
#define GetBTDeviceClass(_p, _n) __GetBTDeviceClass(_p, _n)

/**
 * Get bluetooth device address.
 * This method reads the address of the device at the specified index within
 * the Bluetooth device table and stores it in the data buffer provided.
 * \param _p The device table index.
 * \param _btaddr The byte array reference that will contain the device address.
 */
#define GetBTDeviceAddress(_p, _btaddr) __getBTDeviceAddress(_p, _btaddr)

/**
 * Get bluetooth device status.
 * This method returns the status of the device at the specified index within
 * the Bluetooth device table.
 * \param _p The device table index.
 * \param _n The status of the specified bluetooth device.
 */
#define GetBTDeviceStatus(_p, _n) __GetBTDeviceStatus(_p, _n)

/**
 * Get bluetooth device name.
 * This method returns the name of the device at the specified index in the
 * Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _str The name of the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionName(_p, _str) __GetBTConnectionName(_p, _str)

/**
 * Get bluetooth device class.
 * This method returns the class of the device at the specified index within
 * the Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _n The class of the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionClass(_p, _n) __GetBTConnectionClass(_p, _n)

/**
 * Get bluetooth device pin code.
 * This method returns the pin code of the device at the specified index in the
 * Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _code The pin code for the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionPinCode(_p, _code) __GetBTConnectionPinCode(_p, _code)

/**
 * Get bluetooth device address.
 * This method reads the address of the device at the specified index within
 * the Bluetooth connection table and stores it in the data buffer provided.
 * \param _p The connection slot (0..3).
 * \param _btaddr The byte array reference that will contain the device address.
 */
#define GetBTConnectionAddress(_p, _btaddr) __getBTConnectionAddress(_p, _btaddr)

/**
 * Get bluetooth device handle number.
 * This method returns the handle number of the device at the specified index within
 * the Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _n The handle number of the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionHandleNum(_p, _n) __GetBTConnectionHandleNum(_p, _n)

/**
 * Get bluetooth device stream status.
 * This method returns the stream status of the device at the specified index within
 * the Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _n The stream status of the bluetooth device at the specified connection slot.
 */
#define GetBTConnectionStreamStatus(_p, _n) __GetBTConnectionStreamStatus(_p, _n)

/**
 * Get bluetooth device link quality.
 * This method returns the link quality of the device at the specified index within
 * the Bluetooth connection table.
 * \param _p The connection slot (0..3).
 * \param _n The link quality of the specified connection slot (unimplemented).
 * \warning This function is not implemented at the firmware level.
 */
#define GetBTConnectionLinkQuality(_p, _n) __GetBTConnectionLinkQuality(_p, _n)

/**
 * Get NXT name.
 * This method returns the name of the NXT.
 * \param _str The NXT's bluetooth name.
 */
#define GetBrickDataName(_str) GetCommModuleBytes(CommOffsetBrickDataName, 16, _str)

/**
 * Get NXT bluecore version.
 * This method returns the bluecore version of the NXT.
 * \param _n The NXT's bluecore version number.
 */
#define GetBrickDataBluecoreVersion(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetCommModuleValue(CommOffsetBrickDataBluecoreVersion, _n)

/**
 * Get NXT address.
 * This method reads the address of the NXT and stores it in the data buffer
 * provided.
 * \param _btaddr The byte array reference that will contain the device address.
 */
#define GetBrickDataAddress(_btaddr) GetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _btaddr)

/**
 * Get NXT bluetooth state status.
 * This method returns the Bluetooth state status of the NXT.
 * \param _n The NXT's bluetooth state status.
 */
#define GetBrickDataBtStateStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBrickDataBtStateStatus, _n)

/**
 * Get NXT bluetooth hardware status.
 * This method returns the Bluetooth hardware status of the NXT.
 * \param _n The NXT's bluetooth hardware status.
 */
#define GetBrickDataBtHardwareStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBrickDataBtHwStatus, _n)

/**
 * Get NXT bluetooth timeout value.
 * This method returns the Bluetooth timeout value of the NXT.
 * \param _n The NXT's bluetooth timeout value.
 */
#define GetBrickDataTimeoutValue(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBrickDataTimeOutValue, _n)

/**
 * Get bluetooth input buffer data.
 * This method reads count bytes of data from the Bluetooth input buffer and
 * writes it to the buffer provided.
 * 
 * \param _offset A constant offset into the bluetooth input buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the bluetooth input buffer.
 */
#define GetBTInputBuffer(_offset, _cnt, _data) __getBTInputBuffer(_offset, _cnt, _data)

/**
 * Get bluetooth input buffer in-pointer.
 * This method returns the value of the input pointer of the Bluetooth input
 * buffer.
 * \param _n The bluetooth input buffer's in-pointer value.
 */
#define GetBTInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtInBufInPtr, _n)

/**
 * Get bluetooth input buffer out-pointer.
 * This method returns the value of the output pointer of the Bluetooth input
 * buffer.
 * \param _n The bluetooth input buffer's out-pointer value.
 */
#define GetBTInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtInBufOutPtr, _n)

/**
 * Get bluetooth output buffer data.
 * This method reads count bytes of data from the Bluetooth output buffer and
 * writes it to the buffer provided.
 *
 * \param _offset A constant offset into the bluetooth output buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the bluetooth output buffer.
 */
#define GetBTOutputBuffer(_offset, _cnt, _data) __getBTOutputBuffer(_offset, _cnt, _data)

/**
 * Get bluetooth output buffer in-pointer.
 * This method returns the value of the input pointer of the Bluetooth output
 * buffer.
 * \param _n The bluetooth output buffer's in-pointer value.
 */
#define GetBTOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtOutBufInPtr, _n)

/**
 * Get bluetooth output buffer out-pointer.
 * This method returns the value of the output pointer of the Bluetooth output
 * buffer.
 * \param _n The bluetooth output buffer's out-pointer value.
 */
#define GetBTOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtOutBufOutPtr, _n)

/**
 * Get hi-speed port input buffer data.
 * This method reads count bytes of data from the hi-speed port input buffer and
 * writes it to the buffer provided.
 * 
 * \param _offset A constant offset into the hi-speed port input buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the hi-speed port input buffer.
 */
#define GetHSInputBuffer(_offset, _cnt, _data) __getHSInputBuffer(_offset, _cnt, _data)

/**
 * Get hi-speed port input buffer in-pointer.
 * This method returns the value of the input pointer of the hi-speed port input
 * buffer.
 * \param _n The hi-speed port input buffer's in-pointer value.
 */
#define GetHSInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsInBufInPtr, _n)

/**
 * Get hi-speed port input buffer out-pointer.
 * This method returns the value of the output pointer of the hi-speed port input
 * buffer.
 * \param _n The hi-speed port input buffer's out-pointer value.
 */
#define GetHSInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsInBufOutPtr, _n)

/**
 * Get hi-speed port output buffer data.
 * This method reads count bytes of data from the hi-speed port output buffer and
 * writes it to the buffer provided.
 *
 * \param _offset A constant offset into the hi-speed port output buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the hi-speed port output buffer.
 */
#define GetHSOutputBuffer(_offset, _cnt, _data) __getHSOutputBuffer(_offset, _cnt, _data)

/**
 * Get hi-speed port output buffer in-pointer.
 * This method returns the value of the input pointer of the hi-speed port output
 * buffer.
 * \param _n The hi-speed port output buffer's in-pointer value.
 */
#define GetHSOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsOutBufInPtr, _n)

/**
 * Get hi-speed port output buffer out-pointer.
 * This method returns the value of the output pointer of the hi-speed port output
 * buffer.
 * \param _n The hi-speed port output buffer's out-pointer value.
 */
#define GetHSOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsOutBufOutPtr, _n)

/**
 * Get usb input buffer data.
 * This method reads count bytes of data from the usb input buffer and
 * writes it to the buffer provided.
 *
 * \param _offset A constant offset into the usb input buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the usb input buffer.
 */
#define GetUSBInputBuffer(_offset, _cnt, _data) __getUSBInputBuffer(_offset, _cnt, _data)

/**
 * Get usb port input buffer in-pointer.
 * This method returns the value of the input pointer of the usb port input
 * buffer.
 * \param _n The USB port input buffer's in-pointer value.
 */
#define GetUSBInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbInBufInPtr, _n)

/**
 * Get usb port input buffer out-pointer.
 * This method returns the value of the output pointer of the usb port input
 * buffer.
 * \param _n The USB port input buffer's out-pointer value.
 */
#define GetUSBInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbInBufOutPtr, _n)

/**
 * Get usb output buffer data.
 * This method reads count bytes of data from the usb output buffer and
 * writes it to the buffer provided.
 * \param _offset A constant offset into the usb output buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the usb output buffer.
 */
#define GetUSBOutputBuffer(_offset, _cnt, _data) __getUSBOutputBuffer(_offset, _cnt, _data)

/**
 * Get usb port output buffer in-pointer.
 * This method returns the value of the input pointer of the usb port output
 * buffer.
 * \param _n The USB port output buffer's in-pointer value.
 */
#define GetUSBOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbOutBufInPtr, _n)

/**
 * Get usb port output buffer out-pointer.
 * This method returns the value of the output pointer of the usb port output
 * buffer.
 * \param _n The USB port output buffer's out-pointer value.
 */
#define GetUSBOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbOutBufOutPtr, _n)

/**
 * Get usb poll buffer data.
 * This method reads count bytes of data from the usb poll buffer and
 * writes it to the buffer provided.
 * \param _offset A constant offset into the usb poll buffer.
 * \param _cnt The number of bytes to read.
 * \param _data The byte array reference which will contain the data read from
 * the usb poll buffer.
 */
#define GetUSBPollBuffer(_offset, _cnt, _data) __getUSBPollBuffer(_offset, _cnt, _data)

/**
 * Get usb port poll buffer in-pointer.
 * This method returns the value of the input pointer of the usb port poll
 * buffer.
 * \param _n The USB port poll buffer's in-pointer value.
 */
#define GetUSBPollBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbPollBufInPtr, _n)

/**
 * Get usb port poll buffer out-pointer.
 * This method returns the value of the output pointer of the usb port poll
 * buffer.
 * \param _n The USB port poll buffer's out-pointer value.
 */
#define GetUSBPollBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbPollBufOutPtr, _n)

/**
 * Get bluetooth device count.
 * This method returns the number of devices defined within the Bluetooth
 * device table.
 * \return The count of known bluetooth devices.
 */
#define GetBTDeviceCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtDeviceCnt, _n)

/**
 * Get bluetooth device name count.
 * This method returns the number of device names defined within the Bluetooth
 * device table. This usually has the same value as BTDeviceCount but it can
 * differ in some instances.
 * \param _n The count of known bluetooth device names.
 */
#define GetBTDeviceNameCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtDeviceNameCnt, _n)

/**
 * Get hi-speed port flags.
 * This method returns the value of the hi-speed port flags.
 * \param _n The hi-speed port flags. See \ref CommHiSpeedFlagsConstants.
 */
#define GetHSFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsFlags, _n)

/**
 * Get hi-speed port speed.
 * This method returns the value of the hi-speed port speed (baud rate).
 * \param _n The hi-speed port speed (baud rate).  See \ref CommHiSpeedBaudConstants.
 */
#define GetHSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsSpeed, _n)

/**
 * Get hi-speed port state.
 * This method returns the value of the hi-speed port state.
 * \param _n The hi-speed port state. See \ref CommHiSpeedStateConstants.
 */
#define GetHSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsState, _n)

/**
 * Get USB state.
 * This method returns the value of the USB state.
 * \param _n The USB state.
 */
#define GetUSBState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbState, _n)

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)

/**
 * Get hi-speed port mode.
 * This method returns the value of the hi-speed port mode.
 * \param _n The hi-speed port mode (data bits, stop bits, parity).  See
 * \ref CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants,
 * \ref CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define GetHSMode(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetCommModuleValue(CommOffsetHsMode, _n)

/**
 * Get Bluetooth data mode.
 * This method returns the value of the Bluetooth data mode.
 * \param _n The Bluetooth data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define GetBTDataMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtDataMode, _n)

/**
 * Get hi-speed port data mode.
 * This method returns the value of the hi-speed port data mode.
 * \param _n The hi-speed port data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define GetHSDataMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsDataMode, _n)

#endif  

/**
 * Set bluetooth input buffer data.
 * Write cnt bytes of data to the bluetooth input buffer at offset.
 * \param _offset A constant offset into the input buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetBTInputBuffer(_offset, _cnt, _data) __setBTInputBuffer(_offset, _cnt, _data)

/**
 * Set bluetooth input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param _n The new in-pointer value (0..127).
 */
#define SetBTInputBufferInPtr(_n) __setBTInputBufferInPtr(_n)

/**
 * Set bluetooth input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param _n The new out-pointer value (0..127).
 */
#define SetBTInputBufferOutPtr(_n) __setBTInputBufferOutPtr(_n)

/**
 * Set bluetooth output buffer data.
 * Write cnt bytes of data to the bluetooth output buffer at offset.
 * \param _offset A constant offset into the output buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetBTOutputBuffer(_offset, _cnt, _data) __setBTOutputBuffer(_offset, _cnt, _data)

/**
 * Set bluetooth output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param _n The new in-pointer value (0..127).
 */
#define SetBTOutputBufferInPtr(_n) __setBTOutputBufferInPtr(_n)

/**
 * Set bluetooth output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param _n The new out-pointer value (0..127).
 */
#define SetBTOutputBufferOutPtr(_n) __setBTOutputBufferOutPtr(_n)

/**
 * Set hi-speed port input buffer data.
 * Write cnt bytes of data to the hi-speed port input buffer at offset.
 * \param _offset A constant offset into the input buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetHSInputBuffer(_offset, _cnt, _data) __setHSInputBuffer(_offset, _cnt, _data)

/**
 * Set hi-speed port input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param _n The new in-pointer value (0..127).
 */
#define SetHSInputBufferInPtr(_n) __setHSInputBufferInPtr(_n)

/**
 * Set hi-speed port input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param _n The new out-pointer value (0..127).
 */
#define SetHSInputBufferOutPtr(_n) __setHSInputBufferOutPtr(_n)

/**
 * Set hi-speed port output buffer data.
 * Write cnt bytes of data to the hi-speed port output buffer at offset.
 * \param _offset A constant offset into the output buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetHSOutputBuffer(_offset, _cnt, _data) __setHSOutputBuffer(_offset, _cnt, _data)

/**
 * Set hi-speed port output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param _n The new in-pointer value (0..127).
 */
#define SetHSOutputBufferInPtr(_n) __setHSOutputBufferInPtr(_n)

/**
 * Set hi-speed port output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param _n The new out-pointer value (0..127).
 */
#define SetHSOutputBufferOutPtr(_n) __setHSOutputBufferOutPtr(_n)

/**
 * Set USB input buffer data.
 * Write cnt bytes of data to the USB input buffer at offset.
 * \param _offset A constant offset into the input buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetUSBInputBuffer(_offset, _cnt, _data) __setUSBInputBuffer(_offset, _cnt, _data)

/**
 * Set USB input buffer in-pointer.
 * Set the value of the input buffer in-pointer.
 * \param _n The new in-pointer value (0..63).
 */
#define SetUSBInputBufferInPtr(_n) __setUSBInputBufferInPtr(_n)

/**
 * Set USB input buffer out-pointer.
 * Set the value of the input buffer out-pointer.
 * \param _n The new out-pointer value (0..63).
 */
#define SetUSBInputBufferOutPtr(_n) __setUSBInputBufferOutPtr(_n)

/**
 * Set USB output buffer data.
 * Write cnt bytes of data to the USB output buffer at offset.
 * \param _offset A constant offset into the output buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetUSBOutputBuffer(_offset, _cnt, _data) __setUSBOutputBuffer(_offset, _cnt, _data)

/**
 * Set USB output buffer in-pointer.
 * Set the value of the output buffer in-pointer.
 * \param _n The new in-pointer value (0..63).
 */
#define SetUSBOutputBufferInPtr(_n) __setUSBOutputBufferInPtr(_n)

/**
 * Set USB output buffer out-pointer.
 * Set the value of the output buffer out-pointer.
 * \param _n The new out-pointer value (0..63).
 */
#define SetUSBOutputBufferOutPtr(_n) __setUSBOutputBufferOutPtr(_n)

/**
 * Set USB poll buffer data.
 * Write cnt bytes of data to the USB poll buffer at offset.
 * \param _offset A constant offset into the poll buffer
 * \param _cnt The number of bytes to write
 * \param _data A byte array containing the data to write
 */
#define SetUSBPollBuffer(_offset, _cnt, _data) __setUSBPollBuffer(_offset, _cnt, _data)

/**
 * Set USB poll buffer in-pointer.
 * Set the value of the poll buffer in-pointer.
 * \param _n The new in-pointer value (0..63).
 */
#define SetUSBPollBufferInPtr(_n) __setUSBPollBufferInPtr(_n)

/**
 * Set USB poll buffer out-pointer.
 * Set the value of the poll buffer out-pointer.
 * \param _n The new out-pointer value (0..63).
 */
#define SetUSBPollBufferOutPtr(_n) __setUSBPollBufferOutPtr(_n)

/**
 * Set hi-speed port flags.
 * This method sets the value of the hi-speed port flags.
 * \param _n The hi-speed port flags. See \ref CommHiSpeedFlagsConstants.
 */
#define SetHSFlags(_n) __setHSFlags(_n)

/**
 * Set hi-speed port speed.
 * This method sets the value of the hi-speed port speed (baud rate).
 * \param _n The hi-speed port speed (baud rate).  See \ref CommHiSpeedBaudConstants.
 */
#define SetHSSpeed(_n) __setHSSpeed(_n)

/**
 * Set hi-speed port state.
 * This method sets the value of the hi-speed port state.
 * \param _n The hi-speed port state. See \ref CommHiSpeedStateConstants.
 */
#define SetHSState(_n) __setHSState(_n)

/**
 * Set USB state.
 * This method sets the value of the USB state.
 * \param _n The USB state.
 */
#define SetUSBState(_n) __setUSBState(_n)

#if (__FIRMWARE_VERSION > 107) && defined(__ENHANCED_FIRMWARE)

/**
 * Set hi-speed port mode.
 * This method sets the value of the hi-speed port mode.
 * \param _n The hi-speed port mode (data bits, stop bits, parity).  See
 * \ref CommHiSpeedDataBitsConstants, \ref CommHiSpeedStopBitsConstants,
 * \ref CommHiSpeedParityConstants, and \ref CommHiSpeedCombinedConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define SetHSMode(_n) __setHSMode(_n)

/**
 * Set Bluetooth data mode.
 * This method sets the value of the Bluetooth data mode.
 * \param _n The Bluetooth data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define SetBTDataMode(_n) __setBTDataMode(_n)

/**
 * Set hi-speed port data mode.
 * This method sets the value of the hi-speed port data mode.
 * \param _n The hi-speed port data mode.  See \ref CommDataModeConstants.
 *
 * \warning This function requires the enhanced NBC/NXC firmware version 1.28+.
 */
#define SetHSDataMode(_n) __setHSDataMode(_n)

#endif

/** @} */ // end of CommModuleFunctions group
/** @} */ // end of CommModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// IOCTRL MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup IOCtrlModule
 * @{
 */
/** @defgroup IOCtrlModuleFunctions IOCtrl module functions
 * Functions for accessing and modifying IOCtrl module features.
 * @{
 */

/**
 * Power down the NXT.
 * This function powers down the NXT.
 * The running program will terminate as a result of this action.
 */
#define PowerDown SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_POWERDOWN)

/**
 * Reboot the NXT in firmware download mode.
 * This function lets you reboot the NXT into SAMBA or firmware download mode.
 * The running program will terminate as a result of this action.
 */
#define RebootInFirmwareMode SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_BOOT)

/** @} */ // end of IOCtrlModuleFunctions group
/** @} */ // end of IOCtrlModule group
/** @} */ // end of NXTFirmwareModules group


///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// LOADER MODULE ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup NXTFirmwareModules
 * @{
 */
/** @addtogroup LoaderModule
 * @{
 */
/** @defgroup LoaderModuleFunctions Loader module functions
 * Functions for accessing and modifying Loader module features.
 * @{
 */

/**
 * Get free flash memory.
 * Get the number of bytes of flash memory that are available for use.
 *
 * \param _value The number of bytes of unused flash memory.
 */
#define GetFreeMemory(_value) __GetFreeMemory(_value)

/**
 * Create a file.
 * Create a new file with the specified filename and size and open it for
 * writing. The file handle is returned in the last parameter, which must be a
 * variable. The loader result code is returned as the value of the function
 * call. The filename and size parameters must be constants, constant
 * expressions, or variables. A file created with a size of zero bytes cannot
 * be written to since the NXC file writing functions do not grow the file if
 * its capacity is exceeded during a write attempt.
 *
 * \param _fname The name of the file to create.
 * \param _fsize The size of the file.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define CreateFile(_fname, _fsize, _handle, _result) __createFile(_fname, _fsize, _handle, _result)

/**
 * Open a file for appending.
 * Open an existing file with the specified filename for writing. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call.
 * The filename parameter must be a constant or a variable.
 *
 * \param _fname The name of the file to open.
 * \param _fsize The size of the file returned by the function.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define OpenFileAppend(_fname, _fsize, _handle, _result) __openFileAppend(_fname, _fsize, _handle, _result)

/**
 * Open a file for reading.
 * Open an existing file with the specified filename for reading. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param _fname The name of the file to open.
 * \param _fsize The size of the file returned by the function.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define OpenFileRead(_fname, _fsize, _handle, _result) __openFileRead(_fname, _fsize, _handle, _result)

/**
 * Close a file.
 * Close the file associated with the specified file handle. The loader
 * result code is returned as the value of the function call. The handle
 * parameter must be a constant or a variable.
 *
 * \param _handle The file handle.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define CloseFile(_handle, _result) __closeFile(_handle, _result)

/**
 * Resolve a handle.
 * Resolve a file handle from the specified filename. The file handle is
 * returned in the second parameter, which must be a variable. A boolean
 * value indicating whether the handle can be used to write to the file or
 * not is returned in the last parameter, which must be a variable. The
 * loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param _fname The name of the file for which to resolve a handle.
 * \param _handle The file handle output from the function call.
 * \param _writeable A boolean flag indicating whether the handle is
 * to a file open for writing (true) or reading (false).
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ResolveHandle(_fname, _handle, _writeable, _result) __resolveHandle(_fname, _handle, _writeable, _result)

/**
 * Rename a file.
 * Rename a file from the old filename to the new filename. The loader
 * param _result code is returned as the value of the function call. The filename
 * parameters must be constants or variables.
 *
 * \param _oldname The old filename.
 * \param _newname The new filename.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define RenameFile(_oldname, _newname, _result) __renameFile(_oldname, _newname, _result)

/**
 * Delete a file.
 * Delete the specified file. The loader result code is returned as the
 * value of the function call. The filename parameter must be a constant or a
 * variable.
 *
 * \param _fname The name of the file to delete.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define DeleteFile(_fname, _result) __deleteFile(_fname, _result)

/**
 * Resize a file.
 * Resize the specified file. The loader result code is returned as the
 * value of the function call. The filename parameter must be a constant or a
 * variable.
 *
 * \param _fname The name of the file to resize.
 * \param _newsize The new size for the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ResizeFile(_fname, _newsize, _result) __fileResize(_fname, _newsize, _result)

#ifdef __ENHANCED_FIRMWARE

/**
 * Create a linear file.
 * Create a new linear file with the specified filename and size and open it for
 * writing. The file handle is returned in the last parameter, which must be a
 * variable. The loader result code is returned as the value of the function
 * call. The filename and size parameters must be constants, constant
 * expressions, or variables. A file created with a size of zero bytes cannot
 * be written to since the NXC file writing functions do not grow the file if
 * its capacity is exceeded during a write attempt.
 *
 * \param _fname The name of the file to create.
 * \param _fsize The size of the file.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define CreateFileLinear(_fname, _fsize, _handle, _result) __createFileLinear(_fname, _fsize, _handle, _result)

/**
 * Create a non-linear file.
 * Create a new non-linear file with the specified filename and size and open it for
 * writing. The file handle is returned in the last parameter, which must be a
 * variable. The loader result code is returned as the value of the function
 * call. The filename and size parameters must be constants, constant
 * expressions, or variables. A file created with a size of zero bytes cannot
 * be written to since the NXC file writing functions do not grow the file if
 * its capacity is exceeded during a write attempt.
 *
 * \param _fname The name of the file to create.
 * \param _fsize The size of the file.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define CreateFileNonLinear(_fname, _fsize, _handle, _result) __createFileNonLinear(_fname, _fsize, _handle, _result)

/**
 * Open a linear file for reading.
 * Open an existing linear file with the specified filename for reading. The file
 * size is returned in the second parameter, which must be a variable. The
 * file handle is returned in the last parameter, which must be a variable.
 * The loader result code is returned as the value of the function call. The
 * filename parameter must be a constant or a variable.
 *
 * \param _fname The name of the file to open.
 * \param _fsize The size of the file returned by the function.
 * \param _handle The file handle output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define OpenFileReadLinear(_fname, _fsize, _handle, _result) __openFileReadLinear(_fname, _fsize, _handle, _result)

/**
 * Start searching for files.
 * This function lets you begin iterating through files stored on the NXT.
 *
 * \param _fname On input this contains the filename pattern you are searching
 * for. On output this contains the name of the first file found that matches
 * the pattern.
 * \param _handle The search handle input to and output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define FindFirstFile(_fname, _handle, _result) __findFirstFile(_fname, _handle, _result)

/**
 * Continue searching for files.
 * This function lets you continue iterating through files stored on the NXT.
 *
 * \param _fname On output this contains the name of the next file found that
 * matches the pattern used when the search began by calling \ref FindFirstFile.
 * \param _handle The search handle input to and output from the function call.
 * \param _result The function call result. See \ref LoaderErrors.
 * \warning This function requires the enhanced NBC/NXC firmware.
 */
#define FindNextFile(_fname, _handle, _result) __findNextFile(_fname, _handle, _result)
#endif

/**
 * Calculate the size of a variable.
 * Calculate the number of bytes required to store the contents of the
 * variable passed into the function.
 *
 * \param _n The variable.
 * \param _result The number of bytes occupied by the variable.
 */
#define SizeOf(_n, _result) __sizeOF(_n, _result)

/**
 * Read a value from a file.
 * Read a value from the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * variable. The type of the value parameter determines the number of bytes of
 * data read.
 *
 * \param _handle The file handle.
 * \param _n The variable to store the data read from the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define Read(_handle, _n, _result) __readValue(_handle, _n, _result)

/**
 * Read a value from a file plus line ending.
 * Read a value from the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * variable. The type of the value parameter determines the number of bytes
 * of data read. The ReadLn function reads two additional bytes from the
 * file which it assumes are a carriage return and line feed pair.
 *
 * \param _handle The file handle.
 * \param _n The variable to store the data read from the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ReadLn(_handle, _n, _result) __readLnValue(_handle, _n, _result)

/**
 * Read bytes from a file.
 * Read the specified number of bytes from the file associated with the
 * specified handle. The handle parameter must be a variable. The length
 * parameter must be a variable. The buf parameter must be an array or a
 * string variable. The actual number of bytes read is returned in the
 * length parameter.
 *
 * \param _handle The file handle.
 * \param _len The number of bytes to read. Returns the number of bytes actually read.
 * \param _buf The byte array where the data is stored on output.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ReadBytes(_handle, _len, _buf, _result) __readBytes(_handle, _len, _buf, _result)

/**
 * Read a string from a file plus line ending.
 * Read a string from the file associated with the specified handle.
 * The handle parameter must be a variable. The output parameter must be a
 * variable. Appends bytes to the output variable until a line ending (CRLF)
 * is reached. The line ending is also read but it is not appended to the
 * output parameter.
 *
 * \param _handle The file handle.
 * \param _output The variable to store the string read from the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define ReadLnString(_handle, _output, _result) __readLnString(_handle, _output, _result)

/**
 * Write value to file.
 * Write a value to the file associated with the specified handle.
 * The handle parameter must be a variable. The value parameter must be a
 * constant, a constant expression, or a variable. The type of the value
 * parameter determines the number of bytes of data written.
 *
 * \param _handle The file handle.
 * \param _n The value to write to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define Write(_handle, _n, _result) __writeValue(_handle, _n, _result)

/**
 * Write a value and new line to a file.
 * Write a value to the file associated with the specified handle. The
 * handle parameter must be a variable. The value parameter must be a constant,
 * a constant expression, or a variable. The type of the value parameter
 * determines the number of bytes of data written. This function also
 * writes a carriage return and a line feed to the file following the numeric
 * data.
 *
 * \param _handle The file handle.
 * \param _n The value to write to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteLn(_handle, _n, _result) __writeLnValue(_handle, _n, _result)

/**
 * Write string to a file.
 * Write the string to the file associated with the specified handle. The
 * handle parameter must be a variable. The count parameter must be a variable.
 * The str parameter must be a string variable or string constant. The actual
 * number of bytes written is returned in the cnt parameter.
 *
 * \param _handle The file handle.
 * \param _str The string to write to the file.
 * \param _cnt The number of bytes actually written to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteString(_handle, _str, _cnt, _result) __writeString(_handle, _str, _cnt, _result)

/**
 * Write string and new line to a file.
 * Write the string to the file associated with the specified handle. The
 * handle parameter must be a variable. The count parameter must be a variable.
 * The str parameter must be a string variable or string constant. This
 * function also writes a carriage return and a line feed to the file following
 * the string data. The total number of bytes written is returned in the
 * cnt parameter.
 *
 * \param _handle The file handle.
 * \param _str The string to write to the file.
 * \param _cnt The number of bytes actually written to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteLnString(_handle, _str, _cnt, _result) __writeLnString(_handle, _str, _cnt, _result)

/**
 * Write bytes to file.
 * Write the contents of the data array to the file associated with the
 * specified handle. The handle parameter must be a variable. The cnt
 * parameter must be a variable. The data parameter must be a byte array. The
 * actual number of bytes written is returned in the cnt parameter.
 *
 * \param _handle The file handle.
 * \param _buf The byte array or string containing the data to write.
 * \param _cnt The number of bytes actually written to the file.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteBytes(_handle, _buf, _cnt, _result) __writeBytes(_handle, _buf, _cnt, _result)

/**
 * Write bytes to a file with limit.
 * Write the specified number of bytes to the file associated with the
 * specified handle. The handle parameter must be a variable. The len
 * parameter must be a variable. The buf parameter must be a byte array or a
 * string variable or string constant. The actual number of bytes written is
 * returned in the len parameter.
 *
 * \param _handle The file handle.
 * \param _len The maximum number of bytes to write on input.  Returns the
 * actual number of bytes written.
 * \param _buf The byte array or string containing the data to write.
 * \param _result The function call result. See \ref LoaderErrors.
 */
#define WriteBytesEx(_handle, _len, _buf, _result) __writeBytesEx(_handle, _len, _buf, _result)

/** @} */ // end of LoaderModuleFunctions group
/** @} */ // end of LoaderModule group
/** @} */ // end of NXTFirmwareModules group

/** @addtogroup StandardCAPIFunctions
 * @{
 */

/** @defgroup cstdlibAPI cstdlib API
 * Standard C cstdlib API functions.
 * @{
 */

/**
 * Generate an unsigned random number.
 * Return an unsigned 16-bit random number. The
 * returned value will range between 0 and n (exclusive).
 *
 * \param _arg An unsigned random number.
 * \param _max The maximum unsigned value desired.
 */
#define Random(_arg,_max) __Random(_arg,_max)

/**
 * Generate signed random number.
 * Return a signed 16-bit random number.
 *
 * \param _arg A signed random number
 */
#define SignedRandom(_arg) __SignedRandom(_arg)

/** @} */ // end of cstdlibAPI group

/** @defgroup cmathAPI cmath API
 * Standard C cmath API functions.
 * @{
 */

/**
 * Convert from BCD to decimal
 * Return the decimal equivalent of the binary coded decimal value provided.
 *
 * \param _bcd The value you want to convert from bcd to decimal.
 * \param _result The decimal equivalent of the binary coded decimal byte.
 */
#define bcd2dec(_bcd, _result) __bcd2dec(_bcd, _result)

/** @} */ // end of cmathAPI group
/** @} */ // end of StandardCAPIFunctions group


/** @addtogroup ThirdPartyDevices
 * @{
 */

///////////////////////////////////////////////////////////////////////////////
//////////////////////////////// HiTechnic API ////////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup HiTechnicAPI
 * @{
 */

/**
 * Set sensor as HiTechnic Gyro.
 * Configure the sensor on the specified port as a HiTechnic Gyro sensor.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 */
#define SetSensorHTGyro(_port) __SetSensorHTGyro(_port)

/**
 * Read HiTechnic Gyro sensor.
 * Read the HiTechnic Gyro sensor on the specified port. The offset value
 * should be calculated by averaging several readings with an offset of zero
 * while the sensor is perfectly still.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _offset The zero offset.
 * \param _val The Gyro sensor reading.
 */
#define ReadSensorHTGyro(_p, _offset, _val) __ReadSensorHTGyro(_p, _offset, _val)

/**
 * Set sensor as HiTechnic Magnet.
 * Configure the sensor on the specified port as a HiTechnic Magnet sensor.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 */
#define SetSensorHTMagnet(_port) __SetSensorHTGyro(_port)

/**
 * Read HiTechnic Magnet sensor.
 * Read the HiTechnic Magnet sensor on the specified port. The offset value
 * should be calculated by averaging several readings with an offset of zero
 * while the sensor is perfectly still.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _offset The zero offset.
 * \param _val The Magnet sensor reading.
 */
#define ReadSensorHTMagnet(_p, _offset, _val) __ReadSensorHTGyro(_p, _offset, _val)

/**
 * Set sensor as HiTechnic EOPD.
 * Configure the sensor on the specified port as a HiTechnic EOPD sensor.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _bStd Configure in standard or long-range mode.
 */
#define SetSensorHTEOPD(_port, _bStd) __SetSensorHTEOPD(_port, _bStd)

/**
 * Read HiTechnic EOPD sensor.
 * Read the HiTechnic EOPD sensor on the specified port.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _val The EOPD sensor reading.
 */
#define ReadSensorHTEOPD(_port, _val) __ReadSensorHTEOPD(_port, _val)

/**
 * Read HiTechnic touch multiplexer.
 * Read touch sensor values from the HiTechnic touch multiplexer device.
 *
 * \param _p The sensor port. See \ref NBCInputPortConstants.
 * \param _t1 The value of touch sensor 1.
 * \param _t2 The value of touch sensor 2.
 * \param _t3 The value of touch sensor 3.
 * \param _t4 The value of touch sensor 4.
 */
#define ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) __ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4)

/**
 * HTPowerFunctionCommand function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the HiTechnic iRLink device. Commands for outa and outb are
 * \ref PF_CMD_STOP, \ref PF_CMD_REV, \ref PF_CMD_FWD, and \ref PF_CMD_BRAKE.
 * Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param _outb The Power Function command for output B. See \ref PFCmdConstants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPowerFunctionCommand(_port, _channel, _outa, _outb, _result) \
  __HTPFComboDirect(_port, _channel, _outa, _outb, _result)

/**
 * HTIRTrain function.
 * Control an IR Train receiver set to the specified channel using the
 * HiTechnic iRLink device. Valid func values are \ref TRAIN_FUNC_STOP,
 * \ref TRAIN_FUNC_INCR_SPEED, \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT.
 * Valid channel values are \ref TRAIN_CHANNEL_1 through \ref TRAIN_CHANNEL_3 and
 * \ref TRAIN_CHANNEL_ALL. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The IR Train channel.  See \ref IRTrainChannels.
 * \param _func The IR Train function. See \ref IRTrainFuncs
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTIRTrain(_port, _channel, _func, _result) \
  __HTIRTrain(_port, _channel, _func, FALSE, _result)

/**
 * HTPFComboDirect function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the HiTechnic iRLink device. Commands for outa and outb are
 * \ref PF_CMD_STOP, \ref PF_CMD_REV, \ref PF_CMD_FWD, and \ref PF_CMD_BRAKE. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param _outb The Power Function command for output B. See \ref PFCmdConstants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFComboDirect(_port, _channel, _outa, _outb, _result) \
  __HTPFComboDirect(_port, _channel, _outa, _outb, _result)

/**
 * HTPFComboPWM function.
 * Control the speed of both outputs on a Power Function receiver set to the
 * specified channel using the HiTechnic iRLink device. Valid output values
 * are \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function PWM command for output A. See \ref PFPWMOptions.
 * \param _outb The Power Function PWM command for output B. See \ref PFPWMOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFComboPWM(_port, _channel, _outa, _outb, _result) \
  __HTPFComboPWM(_port, _channel, _outa, _outb, _result)

/**
 * HTPFRawOutput function.
 * Control a Power Function receiver set to the specified channel using the
 * HiTechnic iRLink device. Build the raw data stream using the 3 nibbles
 * (4 bit values). The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _nibble0 The first raw data nibble.
 * \param _nibble1 The second raw data nibble.
 * \param _nibble2 The third raw data nibble.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, _result) \
  __HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, _result)

/**
 * HTPFRepeat function.
 * Repeat sending the last Power Function command using the HiTechnic
 * IRLink device. Specify the number of times to repeat the command and the
 * number of milliseconds of delay between each repetition. The port must be
 * configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _count The number of times to repeat the command.
 * \param _delay The number of milliseconds to delay between each repetition.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFRepeat(_port, _count, _delay, _result) \
  __HTPFRepeatLastCommand(_port, _count, _delay, _result)

/**
 * HTPFSingleOutputCST function.
 * Control a single output on a Power Function receiver set to the specified
 * channel using the HiTechnic iRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are \ref PF_CST_CLEAR1_CLEAR2,
 * \ref PF_CST_SET1_CLEAR2, \ref PF_CST_CLEAR1_SET2, \ref PF_CST_SET1_SET2,
 * \ref PF_CST_INCREMENT_PWM, \ref PF_CST_DECREMENT_PWM, \ref PF_CST_FULL_FWD,
 * \ref PF_CST_FULL_REV, and \ref PF_CST_TOGGLE_DIR. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _func The Power Function CST function. See \ref PFCSTOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFSingleOutputCST(_port, _channel, _out, _func, _result) \
  __HTPFSingleOutput(_port, _channel, _out, _func, TRUE, _result)

/**
 * HTPFSingleOutputPWM function.
 * Control the speed of a single output on a Power Function receiver set to
 * the specified channel using the HiTechnic iRLink device. Select the
 * desired output using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are
 * \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _func The Power Function PWM function. See \ref PFPWMOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFSingleOutputPWM(_port, _channel, _out, _func, _result) \
  __HTPFSingleOutput(_port, _channel, _out, _func, FALSE, _result)

/**
 * HTPFSinglePin function.
 * Control a single pin on a Power Function receiver set to the specified
 * channel using the HiTechnic iRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B.  Select the desired pin using \ref PF_PIN_C1 or
 * \ref PF_PIN_C2. Valid functions are \ref PF_FUNC_NOCHANGE, \ref PF_FUNC_CLEAR,
 * \ref PF_FUNC_SET, and \ref PF_FUNC_TOGGLE. Valid channels are \ref PF_CHANNEL_1 through
 * \ref PF_CHANNEL_4. Specify whether the mode by passing true (continuous) or
 * false (timeout) as the final parameter. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _pin The Power Function pin. See \ref PFPinConstants.
 * \param _func The Power Function single pin function. See \ref PFPinFuncs.
 * \param _cont Control whether the mode is continuous or timeout.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, _result) \
  __HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, _result)

/**
 * HTPFTrain function.
 * Control both outputs on a Power Function receiver set to the specified
 * channel using the HiTechnic iRLink device as if it were an IR Train
 * receiver. Valid function values are \ref TRAIN_FUNC_STOP, \ref TRAIN_FUNC_INCR_SPEED,
 * \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _func The Power Function train function. See \ref IRTrainFuncs.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define HTPFTrain(_port, _channel, _func, _result) \
  __HTIRTrain(_port, _channel, _func, TRUE, _result)

/**
 * HTRCXSetIRLinkPort function.
 * Set the global port in advance of using the HTRCX* and HTScout* API
 * functions for sending RCX and Scout messages over the HiTechnic iRLink
 * device. The port must be configured as a Lowspeed port before using any of
 * the HiTechnic RCX and Scout iRLink functions.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 */
#define HTRCXSetIRLinkPort(_port) __HTRCXSetIRLinkPort(_port)

/**
 * HTRCXBatteryLevel function.
 * Send the BatteryLevel command to an RCX to read the current battery level.
 *
 * \param _result The RCX battery level.
 */
#define HTRCXBatteryLevel(_result) __HTRCXBatteryLevel(_result)

/**
 * HTRCXPoll function
 * Send the Poll command to an RCX to read a signed 2-byte value at the
 * specified source and value combination.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 * \param _result The value read from the specified port and value.
 */
#define HTRCXPoll(_src, _value, _result) __HTRCXPoll(_src, _value, _result)

/**
 * HTRCXPollMemory function.
 * Send the PollMemory command to an RCX.
 *
 * \param _memaddress The RCX memory address.
 * \param _result The value read from the specified address.
 */
#define HTRCXPollMemory(_memaddress, _result) __HTRCXPollMemory(_memaddress, _result)

/**
 * HTRCXAddToDatalog function.
 * Send the AddToDatalog command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define HTRCXAddToDatalog(_src, _value) __HTRCXAddToDatalog(_src, _value)

/**
 * HTRCXClearAllEvents function.
 * Send the ClearAllEvents command to an RCX.
 */
#define HTRCXClearAllEvents() __HTRCXOpNoArgs(RCX_ClearAllEventsOp)

/**
 * HTRCXClearCounter function.
 * Send the ClearCounter command to an RCX.
 *
 * \param _counter The counter to clear.
 */
#define HTRCXClearCounter(_counter) __HTRCXClearCounter(_counter)

/**
 * HTRCXClearMsg function.
 * Send the ClearMsg command to an RCX.
 */
#define HTRCXClearMsg() __HTRCXOpNoArgs(RCX_ClearMsgOp)

/**
 * HTRCXClearSensor function.
 * Send the ClearSensor command to an RCX.
 *
 * \param _port The RCX port number.
 */
#define HTRCXClearSensor(_port) __HTRCXClearSensor(_port)

/**
 * HTRCXClearSound function.
 * Send the ClearSound command to an RCX.
 */
#define HTRCXClearSound() __HTRCXOpNoArgs(RCX_ClearSoundOp)

/**
 * HTRCXClearTimer function.
 * Send the ClearTimer command to an RCX.
 *
 * \param _timer The timer to clear.
 */
#define HTRCXClearTimer(_timer) __HTRCXClearTimer(_timer)

/**
 * HTRCXCreateDatalog function.
 * Send the CreateDatalog command to an RCX.
 *
 * \param _size The new datalog size.
 */
#define HTRCXCreateDatalog(_size) __HTRCXCreateDatalog(_size)

/**
 * HTRCXDecCounter function.
 * Send the DecCounter command to an RCX.
 *
 * \param _counter The counter to decrement.
 */
#define HTRCXDecCounter(_counter) __HTRCXDecCounter(_counter)

/**
 * HTRCXDeleteSub function.
 * Send the DeleteSub command to an RCX.
 *
 * \param _s The subroutine number to delete.
 */
#define HTRCXDeleteSub(_s) __HTRCXDeleteSub(_s)

/**
 * HTRCXDeleteSubs function.
 * Send the DeleteSubs command to an RCX.
 */
#define HTRCXDeleteSubs() __HTRCXOpNoArgs(RCX_DeleteSubsOp)

/**
 * HTRCXDeleteTask function.
 * Send the DeleteTask command to an RCX.
 *
 * \param _t The task number to delete.
 */
#define HTRCXDeleteTask(_t) __HTRCXDeleteTask(_t)

/**
 * HTRCXDeleteTasks function.
 * Send the DeleteTasks command to an RCX.
 */
#define HTRCXDeleteTasks() __HTRCXOpNoArgs(RCX_DeleteTasksOp)

/**
 * HTRCXDisableOutput function.
 * Send the DisableOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to disable. See \ref RCXOutputConstants.
 */
#define HTRCXDisableOutput(_outputs) __HTRCXSetGlobalOutput(_outputs, RCX_OUT_OFF)

/**
 * HTRCXEnableOutput function.
 * Send the EnableOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to enable. See \ref RCXOutputConstants.
 */
#define HTRCXEnableOutput(_outputs) __HTRCXSetGlobalOutput(_outputs, RCX_OUT_ON)

/**
 * HTRCXEvent function.
 * Send the Event command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define HTRCXEvent(_src, _value) __HTRCXEvent(_src, _value)

/**
 * HTRCXFloat function.
 * Send commands to an RCX to float the specified outputs.
 *
 * \param _outputs The RCX output(s) to float. See \ref RCXOutputConstants.
 */
#define HTRCXFloat(_outputs) __HTRCXSetOutput(_outputs, RCX_OUT_FLOAT)

/**
 * HTRCXFwd function.
 * Send commands to an RCX to set the specified outputs to the forward direction.
 *
 * \param _outputs The RCX output(s) to set forward. See \ref RCXOutputConstants.
 */
#define HTRCXFwd(_outputs) __HTRCXSetDirection(_outputs, RCX_OUT_FWD)

/**
 * HTRCXIncCounter function.
 * Send the IncCounter command to an RCX.
 *
 * \param _counter The counter to increment.
 */
#define HTRCXIncCounter(_counter) __HTRCXIncCounter(_counter)

/**
 * HTRCXInvertOutput function.
 * Send the InvertOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to invert. See \ref RCXOutputConstants.
 */
#define HTRCXInvertOutput(_outputs) __HTRCXSetGlobalDirection(_outputs, RCX_OUT_REV)

/**
 * HTRCXMuteSound function.
 * Send the MuteSound command to an RCX.
 */
#define HTRCXMuteSound() __HTRCXOpNoArgs(RCX_MuteSoundOp)

/**
 * HTRCXObvertOutput function.
 * Send the ObvertOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to obvert. See \ref RCXOutputConstants.
 */
#define HTRCXObvertOutput(_outputs) __HTRCXSetGlobalDirection(_outputs, RCX_OUT_FWD)

/**
 * HTRCXOff function.
 * Send commands to an RCX to turn off the specified outputs.
 *
 * \param _outputs The RCX output(s) to turn off. See \ref RCXOutputConstants.
 */
#define HTRCXOff(_outputs) __HTRCXSetOutput(_outputs, RCX_OUT_OFF)

/**
 * HTRCXOn function.
 * Send commands to an RCX to turn on the specified outputs.
 *
 * \param _outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 */
#define HTRCXOn(_outputs) __HTRCXSetOutput(_outputs, RCX_OUT_ON)

/**
 * HTRCXOnFor function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction for the specified duration.
 *
 * \param _outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 * \param _ms The number of milliseconds to leave the outputs on
 */
#define HTRCXOnFor(_outputs, _ms) __HTRCXOnFor(_outputs, _ms)

/**
 * HTRCXOnFwd function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction.
 *
 * \param _outputs The RCX output(s) to turn on in the forward direction. See \ref RCXOutputConstants.
 */
#define HTRCXOnFwd(_outputs) __HTRCXOnFwd(_outputs)

/**
 * HTRCXOnRev function.
 * Send commands to an RCX to turn on the specified outputs in the reverse direction.
 *
 * \param _outputs The RCX output(s) to turn on in the reverse direction. See \ref RCXOutputConstants.
 */
#define HTRCXOnRev(_outputs) __HTRCXOnRev(_outputs)

/**
 * HTRCXPBTurnOff function.
 * Send the PBTurnOff command to an RCX.
 */
#define HTRCXPBTurnOff() __HTRCXOpNoArgs(RCX_PBTurnOffOp)

/**
 * HTRCXPing function.
 * Send the Ping command to an RCX.
 */
#define HTRCXPing() __HTRCXOpNoArgs(RCX_PingOp)

/**
 * HTRCXPlaySound function.
 * Send the PlaySound command to an RCX.
 *
 * \param _snd The sound number to play.
 */
#define HTRCXPlaySound(_snd) __HTRCXPlaySound(_snd)

/**
 * HTRCXPlayTone function.
 * Send the PlayTone command to an RCX.
 *
 * \param _freq The frequency of the tone to play.
 * \param _duration The duration of the tone to play.
 */
#define HTRCXPlayTone(_freq, _duration) __HTRCXPlayTone(_freq, _duration)

/**
 * HTRCXPlayToneVar function.
 * Send the PlayToneVar command to an RCX.
 *
 * \param _varnum The variable containing the tone frequency to play.
 * \param _duration The duration of the tone to play.
 */
#define HTRCXPlayToneVar(_varnum, _duration) __HTRCXPlayToneVar(_varnum, _duration)

/**
 * HTRCXRemote function.
 * Send the Remote command to an RCX.
 *
 * \param _cmd The RCX IR remote command to send. See \ref RCXRemoteConstants.
 */
#define HTRCXRemote(_cmd) __HTRCXRemote(_cmd)

/**
 * HTRCXRev function.
 * Send commands to an RCX to set the specified outputs to the reverse direction.
 *
 * \param _outputs The RCX output(s) to reverse direction. See \ref RCXOutputConstants.
 */
#define HTRCXRev(_outputs) __HTRCXSetDirection(_outputs, RCX_OUT_REV)

/**
 * HTRCXSelectDisplay function.
 * Send the SelectDisplay command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define HTRCXSelectDisplay(_src, _value) __HTRCXSelectDisplay(_src, _value)

/**
 * HTRCXSelectProgram function.
 * Send the SelectProgram command to an RCX.
 *
 * \param _prog The program number to select.
 */
#define HTRCXSelectProgram(_prog) __HTRCXSelectProgram(_prog)

/**
 * HTRCXSendSerial function.
 * Send the SendSerial command to an RCX.
 *
 * \param _first The first byte address.
 * \param _count The number of bytes to send.
 */
#define HTRCXSendSerial(_first, _count) __HTRCXSendSerial(_first, _count)

/**
 * HTRCXSetDirection function.
 * Send the SetDirection command to an RCX to configure the direction of the specified outputs.
 *
 * \param _outputs The RCX output(s) to set direction. See \ref RCXOutputConstants.
 * \param _dir The RCX output direction. See \ref RCXOutputDirection.
 */
#define HTRCXSetDirection(_outputs, _dir) __HTRCXSetDirection(_outputs, _dir)

/**
 * HTRCXSetEvent function.
 * Send the SetEvent command to an RCX.
 *
 * \param _evt The event number to set.
 * \param _src The RCX source. See \ref RCXSourceConstants.
 * \param _type The event type.
 */
#define HTRCXSetEvent(_evt, _src, _type) __HTRCXSetEvent(_evt, _src, _type)

/**
 * HTRCXSetGlobalDirection function.
 * Send the SetGlobalDirection command to an RCX.
 *
 * \param _outputs The RCX output(s) to set global direction. See \ref RCXOutputConstants.
 * \param _dir The RCX output direction. See \ref RCXOutputDirection.
 */
#define HTRCXSetGlobalDirection(_outputs, _dir) __HTRCXSetGlobalDirection(_outputs, _dir)

/**
 * HTRCXSetGlobalOutput function.
 * Send the SetGlobalOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to set global mode. See \ref RCXOutputConstants.
 * \param _mode The RCX output mode. See \ref RCXOutputMode.
 */
#define HTRCXSetGlobalOutput(_outputs, _mode) __HTRCXSetGlobalOutput(_outputs, _mode)

/**
 * HTRCXSetMaxPower function.
 * Send the SetMaxPower command to an RCX.
 *
 * \param _outputs The RCX output(s) to set max power. See \ref RCXOutputConstants.
 * \param _pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param _pwrval The RCX value.
 */
#define HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) __HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval)

/**
 * HTRCXSetMessage function.
 * Send the SetMessage command to an RCX.
 *
 * \param _msg The numeric message to send.
 */
#define HTRCXSetMessage(_msg) __HTRCXSetMessage(_msg)

/**
 * HTRCXSetOutput function.
 * Send the SetOutput command to an RCX to configure the mode of the specified outputs
 *
 * \param _outputs The RCX output(s) to set mode. See \ref RCXOutputConstants.
 * \param _mode The RCX output mode. See \ref RCXOutputMode.
 */
#define HTRCXSetOutput(_outputs, _mode) __HTRCXSetOutput(_outputs, _mode)

/**
 * HTRCXSetPower function.
 * Send the SetPower command to an RCX to configure the power level of the specified outputs.
 *
 * \param _outputs The RCX output(s) to set power. See \ref RCXOutputConstants.
 * \param _pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param _pwrval The RCX value.
 */
#define HTRCXSetPower(_outputs, _pwrsrc, _pwrval) __HTRCXSetPower(_outputs, _pwrsrc, _pwrval)

/**
 * HTRCXSetPriority function.
 * Send the SetPriority command to an RCX.
 *
 * \param _p The new task priority.
 */
#define HTRCXSetPriority(_p) __HTRCXSetPriority(_p)

/**
 * HTRCXSetSensorMode function.
 * Send the SetSensorMode command to an RCX.
 *
 * \param _port The RCX sensor port.
 * \param _mode The RCX sensor mode.
 */
#define HTRCXSetSensorMode(_port, _mode) __HTRCXSetSensorMode(_port, _mode)

/**
 * HTRCXSetSensorType function.
 * Send the SetSensorType command to an RCX.
 *
 * \param _port The RCX sensor port.
 * \param _type The RCX sensor type.
 */
#define HTRCXSetSensorType(_port, _type) __HTRCXSetSensorType(_port, _type)

/**
 * HTRCXSetSleepTime function.
 * Send the SetSleepTime command to an RCX.
 *
 * \param _t The new sleep time value.
 */
#define HTRCXSetSleepTime(_t) __HTRCXSetSleepTime(_t)

/**
 * HTRCXSetTxPower function.
 * Send the SetTxPower command to an RCX.
 *
 * \param _pwr The IR transmit power level.
 */
#define HTRCXSetTxPower(_pwr) __HTRCXSetTxPower(_pwr)

/**
 * HTRCXSetWatch function.
 * Send the SetWatch command to an RCX.
 *
 * \param _hours The new watch time hours value.
 * \param _minutes The new watch time minutes value.
 */
#define HTRCXSetWatch(_hours, _minutes) __HTRCXSetWatch(_hours, _minutes)

/**
 * HTRCXStartTask function.
 * Send the StartTask command to an RCX.
 *
 * \param _t The task number to start.
 */
#define HTRCXStartTask(_t) __HTRCXStartTask(_t)

/**
 * HTRCXStopAllTasks function.
 * Send the StopAllTasks command to an RCX.
 */
#define HTRCXStopAllTasks() __HTRCXOpNoArgs(RCX_StopAllTasksOp)

/**
 * HTRCXStopTask function.
 * Send the StopTask command to an RCX.
 *
 * \param _t The task number to stop.
 */
#define HTRCXStopTask(_t) __HTRCXStopTask(_t)

/**
 * HTRCXToggle function.
 * Send commands to an RCX to toggle the direction of the specified outputs.
 *
 * \param _outputs The RCX output(s) to toggle. See \ref RCXOutputConstants.
 */
#define HTRCXToggle(_outputs) __HTRCXSetDirection(_outputs, RCX_OUT_TOGGLE)

/**
 * HTRCXUnmuteSound function.
 * Send the UnmuteSound command to an RCX.
 */
#define HTRCXUnmuteSound() __HTRCXOpNoArgs(RCX_UnmuteSoundOp)

/**
 * HTScoutCalibrateSensor function.
 * Send the CalibrateSensor command to a Scout.
 */
#define HTScoutCalibrateSensor() __HTRCXOpNoArgs(RCX_LSCalibrateOp)

/**
 * HTScoutMuteSound function.
 * Send the MuteSound command to a Scout.
 */
#define HTScoutMuteSound() __HTScoutMuteSound()

/**
 * HTScoutSelectSounds function.
 * Send the SelectSounds command to a Scout.
 *
 * \param _grp The Scout sound group to select.
 */
#define HTScoutSelectSounds(_grp) __HTScoutSelectSounds(_grp)

/**
 * HTScoutSendVLL function.
 * Send the SendVLL command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSendVLL(_src, _value) __HTScoutSendVLL(_src, _value)

/**
 * HTScoutSetEventFeedback function.
 * Send the SetEventFeedback command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetEventFeedback(_src, _value) __HTScoutSetEventFeedback(_src, _value)

/**
 * HTScoutSetLight function.
 * Send the SetLight command to a Scout.
 *
 * \param _x Set the light on or off using this value. See \ref ScoutLightConstants.
 */
#define HTScoutSetLight(_x) __HTScoutSetLight(_x)

/**
 * HTScoutSetScoutMode function.
 * Send the SetScoutMode command to a Scout.
 *
 * \param _mode Set the scout mode. See \ref ScoutModeConstants.
*/
#define HTScoutSetScoutMode(_mode) __HTScoutSetScoutMode(_mode)

/**
 * HTScoutSetSensorClickTime function.
 * Send the SetSensorClickTime command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetSensorClickTime(_src, _value) __HTScoutSetSensorClickTime(_src, _value)

/**
 * HTScoutSetSensorHysteresis function.
 * Send the SetSensorHysteresis command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetSensorHysteresis(_src, _value) __HTScoutSetSensorHysteresis(_src, _value)

/**
 * HTScoutSetSensorLowerLimit function.
 * Send the SetSensorLowerLimit command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetSensorLowerLimit(_src, _value) __HTScoutSetSensorLowerLimit(_src, _value)

/**
 * HTScoutSetSensorUpperLimit function.
 * Send the SetSensorUpperLimit command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define HTScoutSetSensorUpperLimit(_src, _value) __HTScoutSetSensorUpperLimit(_src, _value)

/**
 * HTScoutUnmuteSound function.
 * Send the UnmuteSound command to a Scout.
 */
#define HTScoutUnmuteSound() __HTScoutUnmuteSound()

/**
 * Read HiTechnic compass.
 * Read the compass heading value of the HiTechnic Compass sensor on the
 * specified port. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The compass heading.
 */
#define ReadSensorHTCompass(_port, _value) __ReadSensorHTCompass(_port, _value)

/**
 * Read HiTechnic color sensor color number.
 * Read the color number from the HiTechnic Color sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The color number.
 */
#define ReadSensorHTColorNum(_port, _value) __ReadSensorHTColorNum(_port, _value)

/**
 * Read HiTechnic IRSeeker direction.
 * Read the direction value of the HiTechnic IR Seeker on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The IRSeeker direction.
 */
#define ReadSensorHTIRSeekerDir(_port, _value) __ReadSensorHTIRSeekerDir(_port, _value)

/**
 * Read HiTechnic IRSeeker2 register.
 * Read a register value from the HiTechnic IR Seeker2 on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _reg The register address. See \ref HTIRSeeker2Constants.
 * \param _value The IRSeeker2 register value.
 */
#define ReadSensorHTIRSeeker2Addr(_port, _reg, _value) __ReadSensorHTIRSeeker2Addr(_port, _reg, _value)

/**
 * Read HiTechnic acceleration values.
 * Read X, Y, and Z axis acceleration values from the HiTechnic Accelerometer
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _x The output x-axis acceleration.
 * \param _y The output y-axis acceleration.
 * \param _z The output z-axis acceleration.
 * \param _result The function call result.
 */
#define ReadSensorHTAccel(_port, _x, _y, _z, _result) __ReadSensorHTAccel(_port, _x, _y, _z, _result)

/**
 * Read HiTechnic Color values.
 * Read color number, red, green, and blue values from the HiTechnic Color
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _ColorNum The output color number.
 * \param _Red The red color value.
 * \param _Green The green color value.
 * \param _Blue The blue color value.
 * \param _result The function call result.
 */
#define ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, _result) __ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, _result)

/**
 * Read HiTechnic Color raw values.
 * Read the raw red, green, and blue values from the HiTechnic Color sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _Red The raw red color value.
 * \param _Green The raw green color value.
 * \param _Blue The raw blue color value.
 * \param _result The function call result.
 */
#define ReadSensorHTRawColor(_port, _Red, _Green, _Blue, _result) __ReadSensorHTRawColor(_port, _Red, _Green, _Blue, _result)

/**
 * Read HiTechnic Color normalized values.
 * Read the color index and the normalized red, green, and blue values from
 * the HiTechnic Color sensor. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _ColorIdx The output color index.
 * \param _Red The normalized red color value.
 * \param _Green The normalized green color value.
 * \param _Blue The normalized blue color value.
 * \param _result The function call result.
 */
#define ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, _result) __ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, _result)

/**
 * Read HiTechnic IRSeeker values.
 * Read direction, and five signal strength values from the HiTechnic
 * IRSeeker sensor. Returns a boolean value indicating whether or not the
 * operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _dir The direction.
 * \param _s1 The signal strength from sensor 1.
 * \param _s3 The signal strength from sensor 3.
 * \param _s5 The signal strength from sensor 5.
 * \param _s7 The signal strength from sensor 7.
 * \param _s9 The signal strength from sensor 9.
 * \param _result The function call result.
 */
#define ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) __ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result)

/**
 * Read HiTechnic IRSeeker2 DC values.
 * Read direction, five signal strength, and average strength values from the
 * HiTechnic IRSeeker2 sensor. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _dir The direction.
 * \param _s1 The signal strength from sensor 1.
 * \param _s3 The signal strength from sensor 3.
 * \param _s5 The signal strength from sensor 5.
 * \param _s7 The signal strength from sensor 7.
 * \param _s9 The signal strength from sensor 9.
 * \param _avg The average signal strength.
 * \param _result The function call result.
 */
#define ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, _result) __ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, _result)

/**
 * Read HiTechnic IRSeeker2 AC values.
 * Read direction, and five signal strength values from the HiTechnic
 * IRSeeker2 sensor in AC mode. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _dir The direction.
 * \param _s1 The signal strength from sensor 1.
 * \param _s3 The signal strength from sensor 3.
 * \param _s5 The signal strength from sensor 5.
 * \param _s7 The signal strength from sensor 7.
 * \param _s9 The signal strength from sensor 9.
 * \param _result The function call result.
 */
#define ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) __ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result)

/**
 * Set HiTechnic IRSeeker2 mode.
 * Set the mode of the HiTechnic IRSeeker2 sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _mode The IRSeeker2 mode. See \ref HTIRSeeker2Constants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define SetHTIRSeeker2Mode(_port, _mode, _result) __SetHTIRSeeker2Mode(_port, _mode, _result)

/**
 * Set HiTechnic Color2 mode.
 * Set the mode of the HiTechnic Color2 sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _mode The Color2 mode. See \ref HTColor2Constants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define SetHTColor2Mode(_port, _mode, _result) __SetHTColor2Mode(_port, _mode, _result)

/**
 * Read HiTechnic Color2 active values.
 * Read color number, red, green, and blue values from the HiTechnic Color2
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _ColorNum The output color number.
 * \param _Red The red color value.
 * \param _Green The green color value.
 * \param _Blue The blue color value.
 * \param _White The white color value.
 * \param _result The function call result.
 */
#define ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, _result) __ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, _result)

/**
 * Read HiTechnic Color2 normalized active values.
 * Read the color index and the normalized red, green, and blue values from
 * the HiTechnic Color2 sensor. Returns a boolean value indicating whether or
 * not the operation completed successfully. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _ColorIdx The output color index.
 * \param _Red The normalized red color value.
 * \param _Green The normalized green color value.
 * \param _Blue The normalized blue color value.
 * \param _result The function call result.
 */
#define ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, _result) __ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, _result)

/**
 * Read HiTechnic Color2 raw values.
 * Read the raw red, green, and blue values from the HiTechnic Color2 sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _Red The raw red color value.
 * \param _Green The raw green color value.
 * \param _Blue The raw blue color value.
 * \param _White The raw white color value.
 * \param _result The function call result.
 */
#define ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, _result) __ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, _result)

/**
 * Read HiTechnic IRReceiver Power Function bytes.
 * Read Power Function bytes from the HiTechnic IRReceiver sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _pfdata Eight bytes of power function remote IR data.
 * \param _result The function call result.
 */
#define ReadSensorHTIRReceiver(_port, _pfdata, _result) __ReadSensorHTIRReceiver(_port, _pfdata, _result)

/**
 * Read HiTechnic IRReceiver Power Function value.
 * Read a Power Function byte from the HiTechnic IRReceiver sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _reg The power function data offset. See \ref HTIRReceiverConstants.
 * \param _pfchar A single byte of power function remote IR data.
 * \param _result The function call result.
 */
#define ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, _result) __ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, _result)

/**
 * Reset HiTechnic Angle sensor.
 * Reset the HiTechnic Angle sensor on the specified
 * port. The port must be configured as a Lowspeed port before using this
 * function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _mode The Angle reset mode. See \ref HTAngleConstants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define ResetSensorHTAngle(_port, _mode, _result) __ResetSensorHTAngle(_port, _mode, _result)

/**
 * Read HiTechnic Angle sensor values.
 * Read values from the HiTechnic Angle sensor.
 * Returns a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _Angle Current angle in degrees (0-359).
 * \param _AccAngle Accumulated angle in degrees (-2147483648 to 2147483647).
 * \param _RPM rotations per minute (-1000 to 1000).
 * \param _result The function call result.
 */
#define ReadSensorHTAngle(_port, _Angle, _AccAngle, _RPM, _result) __ReadSensorHTAngle(_port, _Angle, _AccAngle, _RPM, _result)


/** @} */ // end of HiTechnicAPI group


///////////////////////////////////////////////////////////////////////////////
/////////////////////////////// MindSensors API ///////////////////////////////
///////////////////////////////////////////////////////////////////////////////


/** @addtogroup MindSensorsAPI
 * @{
 */

/**
 * Read mindsensors compass value.
 * Return the Mindsensors Compass sensor value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The mindsensors compass value
 */
#define ReadSensorMSCompass(_port, _i2caddr, _value) __ReadSensorMSCompass(_port, _i2caddr, _value)

/**
 * Read mindsensors DROD value.
 * Return the Mindsensors DROD sensor value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The mindsensors DROD value
 */
#define ReadSensorMSDROD(_port, _value) __ReadSensorMSDROD(_port, _value)

/**
 * Configure a mindsensors DROD active sensor.
 * Configure the specified port for an active mindsensors DROD sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorMSDRODActive(_port) __SetSensorMSDRODActive(_port)

/**
 * Configure a mindsensors DROD inactive sensor.
 * Configure the specified port for an inactive mindsensors DROD sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorMSDRODInactive(_port) __SetSensorMSDRODInactive(_port)

/**
 * Read mindsensors NXTSumoEyes value.
 * Return the Mindsensors NXTSumoEyes sensor value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The mindsensors NXTSumoEyes value
 */
#define ReadSensorNXTSumoEyes(_port, _value) __ReadSensorNXTSumoEyes(_port, _value)

/**
 * Configure a mindsensors NXTSumoEyes long range sensor.
 * Configure the specified port for a long range mindsensors NXTSumoEyes sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorNXTSumoEyesLong(_port) __SetSensorNXTSumoEyesLong(_port)

/**
 * Configure a mindsensors NXTSumoEyes short range sensor.
 * Configure the specified port for a short range mindsensors NXTSumoEyes sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorNXTSumoEyesShort(_port) __SetSensorNXTSumoEyesShort(_port)

/**
 * Read mindsensors raw pressure value.
 * Return the Mindsensors pressure sensor raw value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The mindsensors raw pressure value
 */
#define ReadSensorMSPressureRaw(_port, _value) __ReadSensorMSPressureRaw(_port, _value)

/**
 * Read mindsensors processed pressure value.
 * Return the Mindsensors pressure sensor processed value.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _value The mindsensors processed pressure value
 */
#define ReadSensorMSPressure(_port, _value) __ReadSensorMSPressure(_port, _value)

/**
 * Configure a mindsensors pressure sensor.
 * Configure the specified port for a mindsensors pressure sensor.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorMSPressure(_port) __SetSensorMSPressure(_port)

/**
 * Configure a mindsensors touch sensor multiplexer.
 * Configure the specified port for a mindsensors touch sensor multiplexer.
 *
 * \param _port The port to configure. See \ref NBCInputPortConstants.
 */
#define SetSensorMSTouchMux(_port) __SetSensorMSTouchMux(_port)

/**
 * Read mindsensors acceleration values.
 * Read X, Y, and Z axis acceleration values from the mindsensors Accelerometer
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _x The output x-axis acceleration.
 * \param _y The output y-axis acceleration.
 * \param _z The output z-axis acceleration.
 * \param _result The function call result.
 */
#define ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z, _result) __ReadSensorMSAccel(_port, _i2caddr, _x, _y, _z, _result)

/**
 * Read mindsensors playstation controller values.
 * Read playstation controller values from the mindsensors playstation
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _b1 The button set 1 values. See \ref MSPSPNXBtnSet1.
 * \param _b2 The button set 2 values. See \ref MSPSPNXBtnSet2.
 * \param _xleft The left joystick x value.
 * \param _yleft The left joystick y value.
 * \param _xright The right joystick x value.
 * \param _yright The right joystick y value.
 * \param _result The function call result.
 */
#define ReadSensorMSPlayStation(_port, _i2caddr, _b1, _b2, _xleft, _yleft, _xright, _yright, _result) \
  __ReadSensorMSPlayStation(_port, _i2caddr, _b1, _b2, _xleft, _yleft, _xright, _yright, _result)

/**
 * Read mindsensors RTClock values.
 * Read real-time clock values from the Mindsensors RTClock sensor. Returns
 * a boolean value indicating whether or not the operation completed
 * successfully. The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _sec The seconds.
 * \param _min The minutes.
 * \param _hrs The hours.
 * \param _dow The day of week number.
 * \param _date The day.
 * \param _month The month.
 * \param _year The year.
 * \param _result The function call result.
 */
#define ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, _result) \
  __ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, _result)

/**
 * Read mindsensors tilt values.
 * Read X, Y, and Z axis tilt values from the mindsensors tilt
 * sensor. Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _x The output x-axis tilt.
 * \param _y The output y-axis tilt.
 * \param _z The output z-axis tilt.
 * \param _result The function call result.
 */
#define ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z, _result) __ReadSensorMSTilt(_port, _i2caddr, _x, _y, _z, _result)

/**
 * Send PFMate command.
 * Send a PFMate command to the power function IR receiver.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The power function IR receiver channel. See the \ref PFMateChannelConstants group.
 * \param _motors The motor(s) to control. See the \ref PFMateMotorConstants group.
 * \param _cmdA The power function command for motor A. See the \ref PFCmdConstants group.
 * \param _spdA The power function speed for motor A.
 * \param _cmdB The power function command for motor B. See the \ref PFCmdConstants group.
 * \param _spdB The power function speed for motor B.
 * \param _result The function call result.
 */
#define PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB, _result) __PFMateSend(_port, _i2caddr, _channel, _motors, _cmdA, _spdA, _cmdB, _spdB, _result)

/**
 * Send raw PFMate command.
 * Send a raw PFMate command to the power function IR receiver.
 * Returns a boolean value indicating whether or not the operation
 * completed successfully. The port must be configured as a Lowspeed port
 * before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The power function IR receiver channel. See the \ref PFMateChannelConstants group.
 * \param _b1 Raw byte 1.
 * \param _b2 Raw byte 2.
 * \param _result The function call result.
 */
#define PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2, _result) __PFMateSendRaw(_port, _i2caddr, _channel, _b1, _b2, _result)

/**
 * Read a mindsensors device value.
 * Read a one, two, or four byte value from a mindsensors sensor. The value must be
 * stored with the least signficant byte (LSB) first (i.e., little endian). Returns a boolean value
 * indicating whether or not the operation completed successfully. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _reg The device register to read.
 * \param _bytes The number of bytes to read. Only 1, 2, or 4 byte values are supported.
 * \param _out The value read from the device.
 * \param _result The function call result.
 */
#define MSReadValue(_port, _i2caddr, _reg, _bytes, _out, _result) __MSReadValue(_port, _i2caddr, _reg, _bytes, _out, _result)

/**
 * Turn on power to device.
 * Turn the power on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define MSEnergize(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, MS_CMD_ENERGIZED, _result)

/**
 * Turn off power to device.
 * Turn power off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define MSDeenergize(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, MS_CMD_DEENERGIZED, _result)

/**
 * Turn on mindsensors ADPA mode.
 * Turn ADPA mode on for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define MSADPAOn(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, MS_CMD_ADPA_ON, _result)

/**
 * Turn off mindsensors ADPA mode.
 * Turn ADPA mode off for the mindsensors device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define MSADPAOff(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, MS_CMD_ADPA_OFF, _result)

/**
 * Configure DIST-Nx as GP2D12.
 * Configure the mindsensors DIST-Nx sensor as GP2D12. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define DISTNxGP2D12(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2D12, _result)

/**
 * Configure DIST-Nx as GP2D120.
 * Configure the mindsensors DIST-Nx sensor as GP2D120. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define DISTNxGP2D120(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2D120, _result)

/**
 * Configure DIST-Nx as GP2YA02.
 * Configure the mindsensors DIST-Nx sensor as GP2YA02. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define DISTNxGP2YA02(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2YA02, _result)

/**
 * Configure DIST-Nx as GP2YA21.
 * Configure the mindsensors DIST-Nx sensor as GP2YA21. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define DISTNxGP2YA21(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, DIST_CMD_GP2YA21, _result)

/**
 * Read DIST-Nx distance value.
 * Read the mindsensors DIST-Nx sensor's distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The distance value.
 * \param _result The function call result.
 */
#define ReadDISTNxDistance(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, DIST_REG_DIST, 2, _out, _result)

/**
 * Read DIST-Nx maximum distance value.
 * Read the mindsensors DIST-Nx sensor's maximum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The maximum distance value.
 * \param _result The function call result.
 */
#define ReadDISTNxMaxDistance(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, DIST_REG_DIST_MAX, 2, _out, _result)

/**
 * Read DIST-Nx minimum distance value.
 * Read the mindsensors DIST-Nx sensor's minimum distance value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The minimum distance value.
 * \param _result The function call result.
 */
#define ReadDISTNxMinDistance(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, DIST_REG_DIST_MIN, 2, _out, _result)

/**
 * Read DIST-Nx module type value.
 * Read the mindsensors DIST-Nx sensor's module type value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The module type value.
 * \param _result The function call result.
 */
#define ReadDISTNxModuleType(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, DIST_REG_MODULE_TYPE, 1, _out, _result)

/**
 * Read DIST-Nx num points value.
 * Read the mindsensors DIST-Nx sensor's num points value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The num points value.
 * \param _result The function call result.
 */
#define ReadDISTNxNumPoints(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, DIST_REG_NUM_POINTS, 1, _out, _result)

/**
 * Read DIST-Nx voltage value.
 * Read the mindsensors DIST-Nx sensor's voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The voltage value.
 * \param _result The function call result.
 */
#define ReadDISTNxVoltage(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, DIST_REG_VOLT, 2, _out, _result)

/**
 * Calibrate ACCL-Nx X-axis.
 * Calibrate the mindsensors ACCL-Nx sensor X-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateX(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_X_CAL, _result)

/**
 * Stop calibrating ACCL-Nx X-axis.
 * Stop calibrating the mindsensors ACCL-Nx sensor X-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateXEnd(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_X_CAL_END, _result)

/**
 * Calibrate ACCL-Nx Y-axis.
 * Calibrate the mindsensors ACCL-Nx sensor Y-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateY(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Y_CAL, _result)

/**
 * Stop calibrating ACCL-Nx Y-axis.
 * Stop calibrating the mindsensors ACCL-Nx sensor Y-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateYEnd(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Y_CAL_END, _result)

/**
 * Calibrate ACCL-Nx Z-axis.
 * Calibrate the mindsensors ACCL-Nx sensor Z-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateZ(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Z_CAL, _result)

/**
 * Stop calibrating ACCL-Nx Z-axis.
 * Stop calibrating the mindsensors ACCL-Nx sensor Z-axis. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxCalibrateZEnd(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_Z_CAL_END, _result)

/**
 * Reset ACCL-Nx calibration.
 * Reset the mindsensors ACCL-Nx sensor calibration to factory settings. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define ACCLNxResetCalibration(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, ACCL_CMD_RESET_CAL, _result)

/**
 * Set ACCL-Nx sensitivity.
 * Reset the mindsensors ACCL-Nx sensor calibration to factory settings. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _slevel The sensitivity level. See \ref MSACCLNxSLevel.
 * \param _result The function call result.
 */
#define SetACCLNxSensitivity(_port, _i2caddr, _slevel, _result) __I2CSendCmd(_port, _i2caddr, _slevel, _result)

/**
 * Read ACCL-Nx sensitivity value.
 * Read the mindsensors ACCL-Nx sensitivity value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The sensitivity value.
 * \param _result The function call result.
 */
#define ReadACCLNxSensitivity(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, ACCL_REG_sENS_LVL, 1, _out, _result)

/**
 * Read ACCL-Nx X offset value.
 * Read the mindsensors ACCL-Nx sensor's X offset value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The X offset value.
 * \param _result The function call result.
 */
#define ReadACCLNxXOffset(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, ACCL_REG_X_OFFSET, 2, _out, _result)

/**
 * Read ACCL-Nx X range value.
 * Read the mindsensors ACCL-Nx sensor's X range value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The X range value.
 * \param _result The function call result.
 */
#define ReadACCLNxXRange(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, ACCL_REG_X_RANGE, 2, _out, _result)

/**
 * Read ACCL-Nx Y offset value.
 * Read the mindsensors ACCL-Nx sensor's Y offset value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The Y offset value.
 * \param _result The function call result.
 */
#define ReadACCLNxYOffset(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, ACCL_REG_Y_OFFSET, 2, _out, _result)

/**
 * Read ACCL-Nx Y range value.
 * Read the mindsensors ACCL-Nx sensor's Y range value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The Y range value.
 * \param _result The function call result.
 */
#define ReadACCLNxYRange(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, ACCL_REG_Y_RANGE, 2, _out, _result)

/**
 * Read ACCL-Nx Z offset value.
 * Read the mindsensors ACCL-Nx sensor's Z offset value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The Z offset value.
 * \param _result The function call result.
 */
#define ReadACCLNxZOffset(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, ACCL_REG_Z_OFFSET, 2, _out, _result)

/**
 * Read ACCL-Nx Z range value.
 * Read the mindsensors ACCL-Nx sensor's Z range value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The Z range value.
 * \param _result The function call result.
 */
#define ReadACCLNxZRange(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, ACCL_REG_Z_RANGE, 2, _out, _result)

/**
 * Configure PSP-Nx in digital mode.
 * Configure the mindsensors PSP-Nx device in digital mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define PSPNxDigital(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, PSP_CMD_DIGITAL, _result)

/**
 * Configure PSP-Nx in analog mode.
 * Configure the mindsensors PSP-Nx device in analog mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define PSPNxAnalog(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, PSP_CMD_ANALOG, _result)

/**
 * Read NXTServo servo position value.
 * Read the mindsensors NXTServo device's servo position value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _out The specified servo's position value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTServoPosition(_port, _i2caddr, _servo, _out, _result) __MSReadValue(_port, _i2caddr, NXTSERVO_REG_S1_POS+(_servo*2), 2, _out, _result)

/**
 * Read NXTServo servo speed value.
 * Read the mindsensors NXTServo device's servo speed value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _out The specified servo's speed value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTServoSpeed(_port, _i2caddr, _servo, _out, _result) __MSReadValue(_port, _i2caddr, NXTSERVO_REG_S1_SPEED+_servo, 1, _out, _result)

/**
 * Read NXTServo battery voltage value.
 * Read the mindsensors NXTServo device's battery voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTServo battery voltage.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTServoBatteryVoltage(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTSERVO_REG_VOLTAGE, 1, _out, _result)

/**
 * Set NXTServo servo motor speed.
 * Set the speed of a servo motor controlled by the NXTServo device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _speed The servo speed. (0..255)
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTServoSpeed(_port, _i2caddr, _servo, _speed, _result) __MSWriteToRegister(_port, _i2caddr, NXTSERVO_REG_S1_SPEED+_servo, _speed, _result)

/**
 * Set NXTServo servo motor quick position.
 * Set the quick position of a servo motor controlled by the NXTServo device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _qpos The servo quick position. See \ref NXTServoQPos group.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTServoQuickPosition(_port, _i2caddr, _servo, _qpos, _result) __MSWriteToRegister(_port, _i2caddr, NXTSERVO_REG_S1_QPOS+_servo, _qpos, _result)

/**
 * Set NXTServo servo motor position.
 * Set the position of a servo motor controlled by the NXTServo device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _pos The servo position. See \ref NXTServoPos group.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTServoPosition(_port, _i2caddr, _servo, _pos, _result) __MSWriteLEIntToRegister(_port, _i2caddr, _reg, _pos, _result)

/**
 * Reset NXTServo properties.
 * Reset NXTServo device properties to factory defaults.
 * Initial position = 1500.  Initial speed = 0. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoReset(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_RESET, _result)

/**
 * Halt NXTServo macro.
 * Halt a macro executing on the NXTServo device. This command re-initializes
 * the macro environment.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoHaltMacro(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_HALT, _result)

/**
 * Resume NXTServo macro.
 * Resume a macro executing on the NXTServo device. This command resumes
 * executing a macro where it was paused last, using the same environment.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoResumeMacro(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_RESUME, _result)

/**
 * Pause NXTServo macro.
 * Pause a macro executing on the NXTServo device. This command will pause the
 * currently executing macro, and save the environment for subsequent resumption.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoPauseMacro(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTSERVO_CMD_PAUSE, _result)

/**
 * Initialize NXTServo servo properties.
 * Store the initial speed and position properties of the servo motor 'n'.
 * Current speed and position values of the nth servo is read from the
 * servo speed register and servo position register and written to permanent
 * memory.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _servo The servo number. See \ref NXTServoNumbers group.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoInit(_port, _i2caddr, _servo, _result) __NXTServoInit(_port, _i2caddr, _servo, _result)

/**
 * Goto NXTServo macro address.
 * Run the macro found at the specified EEPROM macro address. This command
 * re-initializes the macro environment.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _macro The EEPROM macro address.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoGotoMacroAddress(_port, _i2caddr, _macro, _result) __NXTServoGotoMacroAddress(_port, _i2caddr, _macro, _result)

/**
 * Edit NXTServo macro.
 * Put the NXTServo device into macro edit mode. This operation changes the
 * I2C address of the device to 0x40.  Macros are written to EEPROM addresses
 * between 0x21 and 0xFF. Use \ref NXTServoQuitEdit to return the device to
 * its normal operation mode.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoEditMacro(_port, _i2caddr, _result) __NXTServoEditMacro(_port, _i2caddr, _result)

/**
 * Quit NXTServo macro edit mode.
 * Stop editing NXTServo device macro EEPROM memory. Use \ref NXTServoEditMacro
 * to start editing a macro.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTServoQuitEdit(_port, _result) __MSWriteToRegister(_port, MS_ADDR_NXTSERVO_EM, NXTSERVO_EM_REG_CMD, NXTSERVO_EM_CMD_QUIT, _result)

/**
 * Set NXTHID into ASCII data mode.
 * Set the NXTHID device into ASCII data mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTHIDAsciiMode(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTHID_CMD_ASCII, _result)

/**
 * Set NXTHID into direct data mode.
 * Set the NXTHID device into direct data mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTHIDDirectMode(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTHID_CMD_DIRECT, _result)

/**
 * Transmit NXTHID character.
 * Transmit a single character to a computer using the NXTHID device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTHIDTransmit(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTHID_CMD_TRANSMIT, _result)

/**
 * Load NXTHID character.
 * Load a character into the NXTHID device.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _modifier The key modifier.
 * \param _character The character.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTHIDLoadCharacter(_port, _i2caddr, _modifier, _character, _result) __NXTHIDLoadCharacter(_port, _i2caddr, _modifier, _character, _result)

/**
 * Reset NXTPowerMeter counters.
 * Reset the NXTPowerMeter counters back to zero. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTPowerMeterResetCounters(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTPM_CMD_RESET, _result)

/**
 * Read NXTPowerMeter present current.
 * Read the mindsensors NXTPowerMeter device's present current value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter present current.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterPresentCurrent(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_CURRENT, 2, _out, _result)

/**
 * Read NXTPowerMeter present voltage.
 * Read the mindsensors NXTPowerMeter device's present voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter present voltage.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterPresentVoltage(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_VOLTAGE, 2, _out, _result)

/**
 * Read NXTPowerMeter capacity used.
 * Read the mindsensors NXTPowerMeter device's capacity used since the last reset command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter capacity used value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterCapacityUsed(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_CAPACITY, 2, _out, _result)

/**
 * Read NXTPowerMeter present power.
 * Read the mindsensors NXTPowerMeter device's present power value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter present power value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterPresentPower(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_POWER, 2, _out, _result)

/**
 * Read NXTPowerMeter total power consumed.
 * Read the mindsensors NXTPowerMeter device's total power consumed since the last reset command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter total power consumed value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterTotalPowerConsumed(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_POWER, 4, _out, _result)

/**
 * Read NXTPowerMeter maximum current.
 * Read the mindsensors NXTPowerMeter device's maximum current value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter maximum current value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterMaxCurrent(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_MAXCURRENT, 2, _out, _result)

/**
 * Read NXTPowerMeter minimum current.
 * Read the mindsensors NXTPowerMeter device's minimum current value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter minimum current value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterMinCurrent(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_MINCURRENT, 2, _out, _result)

/**
 * Read NXTPowerMeter maximum voltage.
 * Read the mindsensors NXTPowerMeter device's maximum voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter maximum voltage value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterMaxVoltage(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_MAXVOLTAGE, 2, _out, _result)

/**
 * Read NXTPowerMeter minimum voltage.
 * Read the mindsensors NXTPowerMeter device's minimum voltage value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter minimum voltage value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterMinVoltage(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_MINVOLTAGE, 2, _out, _result)

/**
 * Read NXTPowerMeter elapsed time.
 * Read the mindsensors NXTPowerMeter device's elapsed time since the last reset command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter elapsed time value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterElapsedTime(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_TIME, 4, _out, _result)

/**
 * Read NXTPowerMeter error count.
 * Read the mindsensors NXTPowerMeter device's error count value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTPowerMeter error count value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTPowerMeterErrorCount(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTPM_REG_ERRORCOUNT, 2, _out, _result)

/**
 * Powerdown NXTLineLeader device.
 * Put the NXTLineLeader to sleep so that it does not consume power when it is
 * not required. The device wakes up on its own when any I2C communication
 * happens or you can specifically wake it up by using the \ref NXTLineLeaderPowerUp
 * command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderPowerDown(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_POWERDOWN, _result)

/**
 * Powerup NXTLineLeader device.
 * Wake up the NXTLineLeader device so that it can be used. The device can be
 * put to sleep using the \ref NXTLineLeaderPowerDown command.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderPowerUp(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_POWERUP, _result)

/**
 * Invert NXTLineLeader colors.
 * Invert color sensing so that the device can detect a white line on a
 * black background.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderInvert(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_INVERT, _result)

/**
 * Reset NXTLineLeader color inversion.
 * Reset the NXTLineLeader color detection back to its default state (black
 * line on a white background).
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderReset(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_RESET, _result)

/**
 * Take NXTLineLeader line snapshot.
 * Takes a snapshot of the line under the sensor and tracks that position in
 * subsequent tracking operations.  This function also will set color inversion
 * if it sees a white line on a black background.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderSnapshot(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_SNAPSHOT, _result)

/**
 * Calibrate NXTLineLeader white color.
 * Store calibration data for the white color.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderCalibrateWhite(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_WHITE, _result)

/**
 * Calibrate NXTLineLeader black color.
 * Store calibration data for the black color.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define NXTLineLeaderCalibrateBlack(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NXTLL_CMD_BLACK, _result)

/**
 * Read NXTLineLeader steering.
 * Read the mindsensors NXTLineLeader device's steering value. This is the power
 * returned by the sensor to correct your course.  Add this value to your left
 * motor and subtract it from your right motor.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTLineLeader steering value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTLineLeaderSteering(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTLL_REG_STEERING, 1, _out, _result)

/**
 * Read NXTLineLeader average.
 * Read the mindsensors NXTLineLeader device's average value. The
 * average is a weighted average of the bits set to 1 based on the position.
 * The left most bit has a weight of 10, second bit has a weight of 20, and so
 * forth. When all 8 sensors are over a black surface the average will be 45.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTLineLeader average value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTLineLeaderAverage(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTLL_REG_AVERAGE, 1, _out, _result)

/**
 * Read NXTLineLeader result.
 * Read the mindsensors NXTLineLeader device's result value. This is a single
 * byte showing the 8 sensor's readings. Each bit corresponding to the sensor
 * where the line is seen is set to 1, otherwise it is set to 0.
 * When all 8 sensors are over a black surface the result will be 255 (b11111111).
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _out The NXTLineLeader result value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define ReadNXTLineLeaderResult(_port, _i2caddr, _out, _result) __MSReadValue(_port, _i2caddr, NXTLL_REG_RESULT, 1, _out, _result)

/**
 * Write NXTLineLeader setpoint.
 * Write a new setpoint value to the NXTLineLeader device. The Set Point is a
 * value you can ask sensor to maintain the average to. The default value is
 * 45, whereby the line is maintained in center of the sensor. If you need to
 * maintain line towards left of the sensor, set the Set Point to
 * a lower value (minimum: 10). If you need it to be towards on the right of the
 * sensor, set it to higher value (maximum: 80). Set point is also useful while
 * tracking an edge of dark and light areas.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new setpoint value (10..80).
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderSetpoint(_port, _i2caddr, _value, _result) __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_SETPOINT, _value, _result)

/**
 * Write NXTLineLeader Kp value.
 * Write a Kp value to the NXTLineLeader device. This value divided by PID
 * Factor for Kp is the Proportional value for the PID control. Suggested value
 * is 25 with a divisor factor of 32 (which is also a factory default), start
 * with this value, and tune it to meet your needs. Value ranges
 * between 0 and 255.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Kp value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKpValue(_port, _i2caddr, _value, _result) __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KP_VALUE, _value, _result)

/**
 * Write NXTLineLeader Ki value.
 * Write a Ki value to the NXTLineLeader device. This value divided by PID
 * Factor for Ki is the Integral value for the PID control. Suggested value
 * is 0 with a divisor factor of 32 (which is also a factory default), start
 * with this value, and tune it to meet your needs. Value ranges
 * between 0 and 255.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Ki value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKiValue(_port, _i2caddr, _value, _result) __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KI_VALUE, _value, _result)

/**
 * Write NXTLineLeader Kd value.
 * Write a Kd value to the NXTLineLeader device. This value divided by PID
 * Factor for Kd is the Derivative value for the PID control. Suggested value
 * is 8 with a divisor factor of 32 (which is also a factory default), start
 * with this value, and tune it to meet your needs. Value ranges
 * between 0 and 255.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Kd value.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKdValue(_port, _i2caddr, _value, _result) __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KD_VALUE, _value, _result)

/**
 * Write NXTLineLeader Kp factor.
 * Write a Kp divisor factor to the NXTLineLeader device. Value ranges between
 * 1 and 255. Change this value if you need more granularities in Kp value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Kp factor.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKpFactor(_port, _i2caddr, _value, _result) __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KP_FACTOR, _value, _result)

/**
 * Write NXTLineLeader Ki factor.
 * Write a Ki divisor factor to the NXTLineLeader device. Value ranges between
 * 1 and 255. Change this value if you need more granularities in Ki value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Ki factor.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKiFactor(_port, _i2caddr, _value, _result) __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KI_FACTOR, _value, _result)

/**
 * Write NXTLineLeader Kd factor.
 * Write a Kd divisor factor to the NXTLineLeader device. Value ranges between
 * 1 and 255. Change this value if you need more granularities in Kd value.
 * The port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The new Kd factor.
 * \param _result A status code indicating whether the operation completed successfully or not.
 * See \ref TCommLSCheckStatus for possible Result values.
 */
#define SetNXTLineLeaderKdFactor(_port, _i2caddr, _value, _result) __MSWriteToRegister(_port, _i2caddr, NXTLL_REG_KD_FACTOR, _value, _result)

/**
 * Configure NRLink in 2400 baud mode.
 * Configure the mindsensors NRLink device in 2400 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLink2400(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_2400, _result)

/**
 * Configure NRLink in 4800 baud mode.
 * Configure the mindsensors NRLink device in 4800 baud mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLink4800(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_4800, _result)

/**
 * Flush NRLink buffers.
 * Flush the mindsensors NRLink device buffers. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkFlush(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_FLUSH, _result)

/**
 * Configure NRLink in IR long mode.
 * Configure the mindsensors NRLink device in IR long mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkIRLong(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_IR_LONG, _result)

/**
 * Configure NRLink in IR short mode.
 * Configure the mindsensors NRLink device in IR short mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkIRShort(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_IR_SHORT, _result)

/**
 * Configure NRLink in power function mode.
 * Configure the mindsensors NRLink device in power function mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkSetPF(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_PF, _result)

/**
 * Configure NRLink in RCX mode.
 * Configure the mindsensors NRLink device in RCX mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkSetRCX(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_RCX, _result)

/**
 * Configure NRLink in IR train mode.
 * Configure the mindsensors NRLink device in IR train mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkSetTrain(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_SET_TRAIN, _result)

/**
 * Configure NRLink in raw IR transmit mode.
 * Configure the mindsensors NRLink device in raw IR transmit mode. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _result The function call result.
 */
#define NRLinkTxRaw(_port, _i2caddr, _result) __I2CSendCmd(_port, _i2caddr, NRLINK_CMD_TX_RAW, _result)

/**
 * Read NRLink status.
 * Read the status of the mindsensors NRLink device. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _value The mindsensors NRLink status.
 * \param _result The function call result.
 */
#define ReadNRLinkStatus(_port, _i2caddr, _value, _result) __ReadNRLinkStatus(_port, _i2caddr, _value, _result)

/**
 * Run NRLink macro.
 * Run the specified mindsensors NRLink device macro. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _macro The address of the macro to execute.
 * \param _result The function call result.
 */
#define RunNRLinkMacro(_port, _i2caddr, _macro, _result) __RunNRLinkMacro(_port, _i2caddr, _macro, _result)

/**
 * Write data to NRLink.
 * Write data to the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _bytes A byte array containing the data to write.
 * \param _result The function call result.
 */
#define WriteNRLinkBytes(_port, _i2caddr, _bytes, _result) __WriteNRLinkBytes(_port, _i2caddr, _bytes, _result)

/**
 * Read data from NRLink.
 * Read data from the mindsensors NRLink device on the specified port. The port
 * must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _bytes A byte array that will contain the data read from the device on output.
 * \param _result The function call result.
 */
#define ReadNRLinkBytes(_port, _i2caddr, _bytes, _result) __ReadNRLinkBytes(_port, _i2caddr, _bytes, _result)

/**
 * MSIRTrain function.
 * Control an IR Train receiver set to the specified channel using the
 * mindsensors NRLink device. Valid function values are \ref TRAIN_FUNC_STOP,
 * \ref TRAIN_FUNC_INCR_SPEED, \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT.
 * Valid channels are \ref TRAIN_CHANNEL_1 through \ref TRAIN_CHANNEL_3 and
 * \ref TRAIN_CHANNEL_ALL. The port must be configured as a Lowspeed port before
 * using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The IR Train channel.  See \ref IRTrainChannels.
 * \param _func The IR Train function. See \ref IRTrainFuncs
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSIRTrain(_port, _i2caddr, _channel, _func, _result) \
  __MSIRTrain(_port, _i2caddr, _channel, _func, FALSE, _result)

/**
 * MSPFComboDirect function.
 * Execute a pair of Power Function motor commands on the specified channel
 * using the mindsensors NRLink device. Commands for outa and outb are
 * PF_CMD_STOP, PF_CMD_REV, PF_CMD_FWD, and \ref PF_CMD_BRAKE. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function command for output A. See \ref PFCmdConstants.
 * \param _outb The Power Function command for output B. See \ref PFCmdConstants.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb, _result) \
  __MSPFComboDirect(_port, _i2caddr, _channel, _outa, _outb, _result)

/**
 * MSPFComboPWM function.
 * Control the speed of both outputs on a Power Function receiver set to the
 * specified channel using the mindsensors NRLink device. Valid output values
 * are \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _outa The Power Function PWM command for output A. See \ref PFPWMOptions.
 * \param _outb The Power Function PWM command for output B. See \ref PFPWMOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb, _result) \
  __MSPFComboPWM(_port, _i2caddr, _channel, _outa, _outb, _result)

/**
 * MSPFRawOutput function.
 * Control a Power Function receiver set to the specified channel using the
 * mindsensors NRLink device. Build the raw data stream using the 3 nibbles
 * (4 bit values). The port must be configured as a Lowspeed port before using
 * this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _nibble0 The first raw data nibble.
 * \param _nibble1 The second raw data nibble.
 * \param _nibble2 The third raw data nibble.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2, _result) \
  __MSPFRawOutput(_port, _i2caddr, _nibble0, _nibble1, _nibble2, _result)

/**
 * MSPFRepeat function.
 * Repeat sending the last Power Function command using the mindsensors
 * NRLink device. Specify the number of times to repeat the command and the
 * number of milliseconds of delay between each repetition. The port must be
 * configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _count The number of times to repeat the command.
 * \param _delay The number of milliseconds to delay between each repetition.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFRepeat(_port, _i2caddr, _count, _delay, _result) \
  __MSPFRepeatLastCommand(_port, _i2caddr, _count, _delay, _result)

/**
 * MSPFSingleOutputCST function.
 * Control a single output on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are \ref PF_CST_CLEAR1_CLEAR2,
 * \ref PF_CST_SET1_CLEAR2, \ref PF_CST_CLEAR1_SET2, \ref PF_CST_SET1_SET2,
 * \ref PF_CST_INCREMENT_PWM, \ref PF_CST_DECREMENT_PWM, \ref PF_CST_FULL_FWD,
 * \ref PF_CST_FULL_REV, and \ref PF_CST_TOGGLE_DIR. Valid channels are
 * \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _func The Power Function CST function. See \ref PFCSTOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFSingleOutputCST(_port, _i2caddr, _channel, _out, _func, _result) \
  __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, TRUE, _result)

/**
 * MSPFSingleOutputPWM function.
 * Control the speed of a single output on a Power Function receiver set to
 * the specified channel using the mindsensors NRLink device. Select the
 * desired output using \ref PF_OUT_A or \ref PF_OUT_B. Valid functions are
 * \ref PF_PWM_FLOAT, \ref PF_PWM_FWD1, \ref PF_PWM_FWD2, \ref PF_PWM_FWD3, \ref PF_PWM_FWD4,
 * \ref PF_PWM_FWD5, \ref PF_PWM_FWD6, \ref PF_PWM_FWD7, \ref PF_PWM_BRAKE, \ref PF_PWM_REV7,
 * \ref PF_PWM_REV6, \ref PF_PWM_REV5, \ref PF_PWM_REV4, \ref PF_PWM_REV3, \ref PF_PWM_REV2, and
 * \ref PF_PWM_REV1. Valid channels are \ref PF_CHANNEL_1 through \ref PF_CHANNEL_4. The
 * port must be configured as a Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _func The Power Function PWM function. See \ref PFPWMOptions.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFSingleOutputPWM(_port, _i2caddr, _channel, _out, _func, _result) \
  __MSPFSingleOutput(_port, _i2caddr, _channel, _out, _func, FALSE, _result)

/**
 * MSPFSinglePin function.
 * Control a single pin on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device. Select the desired output
 * using \ref PF_OUT_A or \ref PF_OUT_B.  Select the desired pin using \ref PF_PIN_C1 or
 * \ref PF_PIN_C2. Valid functions are \ref PF_FUNC_NOCHANGE, \ref PF_FUNC_CLEAR,
 * \ref PF_FUNC_SET, and \ref PF_FUNC_TOGGLE. Valid channels are \ref PF_CHANNEL_1 through
 * \ref PF_CHANNEL_4. Specify whether the mode by passing true (continuous) or
 * false (timeout) as the final parameter. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _out The Power Function output. See \ref PFOutputs.
 * \param _pin The Power Function pin. See \ref PFPinConstants.
 * \param _func The Power Function single pin function. See \ref PFPinFuncs.
 * \param _cont Control whether the mode is continuous or timeout.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont, _result) \
  __MSPFSinglePin(_port, _i2caddr, _channel, _out, _pin, _func, _cont, _result)

/**
 * MSPFTrain function.
 * Control both outputs on a Power Function receiver set to the specified
 * channel using the mindsensors NRLink device as if it were an IR Train
 * receiver. Valid function values are \ref TRAIN_FUNC_STOP, \ref TRAIN_FUNC_INCR_SPEED,
 * \ref TRAIN_FUNC_DECR_SPEED, and \ref TRAIN_FUNC_TOGGLE_LIGHT. Valid channels are
 * PF_CHANNEL_1 through PF_CHANNEL_4. The port must be configured as a
 * Lowspeed port before using this function.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 * \param _channel The Power Function channel.  See \ref PFChannelConstants.
 * \param _func The Power Function train function. See \ref IRTrainFuncs.
 * \param _result The function call result. \ref NO_ERR or \ref CommandCommErrors.
 */
#define MSPFTrain(_port, _i2caddr, _channel, _func, _result) \
  __MSIRTrain(_port, _i2caddr, _channel, _func, TRUE, _result)

/**
 * MSRCXSetIRLinkPort function.
 * Set the global port in advance of using the MSRCX* and MSScout* API
 * functions for sending RCX and Scout messages over the mindsensors NRLink
 * device. The port must be configured as a Lowspeed port before using any of
 * the mindsensors RCX and Scout NRLink functions.
 *
 * \param _port The sensor port. See \ref NBCInputPortConstants.
 * \param _i2caddr The sensor I2C address. See sensor documentation for this value.
 */
#define MSRCXSetNRLinkPort(_port, _i2caddr) __MSRCXSetNRLink(_port, _i2caddr)

/**
 * MSRCXBatteryLevel function.
 * Send the BatteryLevel command to an RCX to read the current battery level.
 *
 * \param _result The RCX battery level.
 */
#define MSRCXBatteryLevel(_result) __MSRCXBatteryLevel(_result)

/**
 * MSRCXPoll function.
 * Send the Poll command to an RCX to read a signed 2-byte value at the
 * specified source and value combination.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 * \param _result The value read from the specified port and value.
 */
#define MSRCXPoll(_src, _value, _result) __MSRCXPoll(_src, _value, _result)

/**
 * MSRCXPollMemory function.
 * Send the PollMemory command to an RCX.
 *
 * \param _memaddress The RCX memory address.
 * \param _result The value read from the specified address.
 */
#define MSRCXPollMemory(_memaddress, _result) __MSRCXPollMemory(_memaddress, _result)

/**
 * MSRCXAbsVar function.
 * Send the AbsVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXAbsVar(_varnum, _src, _value) __MSRCXVarOp(RCX_AbsVarOp, _varnum, _src, _value)

/**
 * MSRCXAddToDatalog function.
 * Send the AddToDatalog command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXAddToDatalog(_src, _value) __MSRCXAddToDatalog(_src, _value)

/**
 * MSRCXAndVar function.
 * Send the AndVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXAndVar(_varnum, _src, _value) __MSRCXVarOp(RCX_AndVarOp, _varnum, _src, _value)

/**
 * MSRCXBoot function.
 * Send the Boot command to an RCX.
 */
#define MSRCXBoot() __MSRCXBoot()

/**
 * MSRCXCalibrateEvent function.
 * Send the CalibrateEvent command to an RCX.
 *
 * \param _evt The event number.
 * \param _low The low threshold.
 * \param _hi The high threshold.
 * \param _hyst The hysterisis value.
 */
#define MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) __MSRCXCalibrateEvent(_evt, _low, _hi, _hyst)

/**
 * MSRCXClearAllEvents function.
 * Send the ClearAllEvents command to an RCX.
 */
#define MSRCXClearAllEvents() __MSRCXOpNoArgs(RCX_ClearAllEventsOp)

/**
 * MSRCXClearCounter function.
 * Send the ClearCounter command to an RCX.
 *
 * \param _counter The counter to clear.
 */
#define MSRCXClearCounter(_counter) __MSRCXClearCounter(_counter)

/**
 * MSRCXClearMsg function.
 * Send the ClearMsg command to an RCX.
 */
#define MSRCXClearMsg() __MSRCXOpNoArgs(RCX_ClearMsgOp)

/**
 * MSRCXClearSensor function.
 * Send the ClearSensor command to an RCX.
 *
 * \param _port The RCX port number.
 */
#define MSRCXClearSensor(_port) __MSRCXClearSensor(_port)

/**
 * MSRCXClearSound function.
 * Send the ClearSound command to an RCX.
 */
#define MSRCXClearSound() __MSRCXOpNoArgs(RCX_ClearSoundOp)

/**
 * MSRCXClearTimer function.
 * Send the ClearTimer command to an RCX.
 *
 * \param _timer The timer to clear.
 */
#define MSRCXClearTimer(_timer) __MSRCXClearTimer(_timer)

/**
 * MSRCXCreateDatalog function.
 * Send the CreateDatalog command to an RCX.
 *
 * \param _size The new datalog size.
 */
#define MSRCXCreateDatalog(_size) __MSRCXCreateDatalog(_size)

/**
 * MSRCXDecCounter function.
 * Send the DecCounter command to an RCX.
 *
 * \param _counter The counter to decrement.
 */
#define MSRCXDecCounter(_counter) __MSRCXDecCounter(_counter)

/**
 * MSRCXDeleteSub function.
 * Send the DeleteSub command to an RCX.
 *
 * \param _s The subroutine number to delete.
 */
#define MSRCXDeleteSub(_s) __MSRCXDeleteSub(_s)

/**
 * MSRCXDeleteSubs function.
 * Send the DeleteSubs command to an RCX.
 */
#define MSRCXDeleteSubs() __MSRCXOpNoArgs(RCX_DeleteSubsOp)

/**
 * MSRCXDeleteTask function.
 * Send the DeleteTask command to an RCX.
 *
 * \param _t The task number to delete.
 */
#define MSRCXDeleteTask(_t) __MSRCXDeleteTask(_t)

/**
 * MSRCXDeleteTasks function.
 * Send the DeleteTasks command to an RCX.
 */
#define MSRCXDeleteTasks() __MSRCXOpNoArgs(RCX_DeleteTasksOp)

/**
 * MSRCXDisableOutput function.
 * Send the DisableOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to disable. See \ref RCXOutputConstants.
 */
#define MSRCXDisableOutput(_outputs) __MSRCXSetGlobalOutput(_outputs, RCX_OUT_OFF)

/**
 * MSRCXDivVar function.
 * Send the DivVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXDivVar(_varnum, _src, _value) __MSRCXVarOp(RCX_DivVarOp, _varnum, _src, _value)

/**
 * MSRCXEnableOutput function.
 * Send the EnableOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to enable. See \ref RCXOutputConstants.
 */
#define MSRCXEnableOutput(_outputs) __MSRCXSetGlobalOutput(_outputs, RCX_OUT_ON)

/**
 * MSRCXEvent function.
 * Send the Event command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXEvent(_src, _value) __MSRCXEvent(_src, _value)

/**
 * MSRCXFloat function.
 * Send commands to an RCX to float the specified outputs.
 *
 * \param _outputs The RCX output(s) to float. See \ref RCXOutputConstants.
 */
#define MSRCXFloat(_outputs) __MSRCXSetOutput(_outputs, RCX_OUT_FLOAT)

/**
 * MSRCXFwd function.
 * Send commands to an RCX to set the specified outputs to the forward direction.
 *
 * \param _outputs The RCX output(s) to set forward. See \ref RCXOutputConstants.
 */
#define MSRCXFwd(_outputs) __MSRCXSetDirection(_outputs, RCX_OUT_FWD)

/**
 * MSRCXIncCounter function.
 * Send the IncCounter command to an RCX.
 *
 * \param _counter The counter to increment.
 */
#define MSRCXIncCounter(_counter) __MSRCXIncCounter(_counter)

/**
 * MSRCXInvertOutput function.
 * Send the InvertOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to invert. See \ref RCXOutputConstants.
 */
#define MSRCXInvertOutput(_outputs) __MSRCXSetGlobalDirection(_outputs, RCX_OUT_REV)

/**
 * MSRCXMulVar function.
 * Send the MulVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXMulVar(_varnum, _src, _value) __MSRCXVarOp(RCX_MulVarOp, _varnum, _src, _value)

/**
 * MSRCXMuteSound function.
 * Send the MuteSound command to an RCX.
 */
#define MSRCXMuteSound() __MSRCXOpNoArgs(RCX_MuteSoundOp)

/**
 * MSRCXObvertOutput function.
 * Send the ObvertOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to obvert. See \ref RCXOutputConstants.
 */
#define MSRCXObvertOutput(_outputs) __MSRCXSetGlobalDirection(_outputs, RCX_OUT_FWD)

/**
 * MSRCXOff function.
 * Send commands to an RCX to turn off the specified outputs.
 *
 * \param _outputs The RCX output(s) to turn off. See \ref RCXOutputConstants.
 */
#define MSRCXOff(_outputs) __MSRCXSetOutput(_outputs, RCX_OUT_OFF)

/**
 * MSRCXOn function.
 * Send commands to an RCX to turn on the specified outputs.
 *
 * \param _outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 */
#define MSRCXOn(_outputs) __MSRCXSetOutput(_outputs, RCX_OUT_ON)

/**
 * MSRCXOnFor function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction for the specified duration.
 *
 * \param _outputs The RCX output(s) to turn on. See \ref RCXOutputConstants.
 * \param _ms The number of milliseconds to leave the outputs on
 */
#define MSRCXOnFor(_outputs, _ms) __MSRCXOnFor(_outputs, _ms)

/**
 * MSRCXOnFwd function.
 * Send commands to an RCX to turn on the specified outputs in the forward
 * direction.
 *
 * \param _outputs The RCX output(s) to turn on in the forward direction. See \ref RCXOutputConstants.
 */
#define MSRCXOnFwd(_outputs) __MSRCXOnFwd(_outputs)

/**
 * MSRCXOnRev function.
 * Send commands to an RCX to turn on the specified outputs in the reverse direction.
 *
 * \param _outputs The RCX output(s) to turn on in the reverse direction. See \ref RCXOutputConstants.
 */
#define MSRCXOnRev(_outputs) __MSRCXOnRev(_outputs)

/**
 * MSRCXOrVar function.
 * Send the OrVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXOrVar(_varnum, _src, _value) __MSRCXVarOp(RCX_OrVarOp, _varnum, _src, _value)

/**
 * MSRCXPBTurnOff function.
 * Send the PBTurnOff command to an RCX.
 */
#define MSRCXPBTurnOff() __MSRCXOpNoArgs(RCX_PBTurnOffOp)

/**
 * MSRCXPing function.
 * Send the Ping command to an RCX.
 */
#define MSRCXPing() __MSRCXOpNoArgs(RCX_PingOp)

/**
 * MSRCXPlaySound function.
 * Send the PlaySound command to an RCX.
 *
 * \param _snd The sound number to play.
 */
#define MSRCXPlaySound(_snd) __MSRCXPlaySound(_snd)

/**
 * MSRCXPlayTone function.
 * Send the PlayTone command to an RCX.
 *
 * \param _freq The frequency of the tone to play.
 * \param _duration The duration of the tone to play.
 */
#define MSRCXPlayTone(_freq, _duration) __MSRCXPlayTone(_freq, _duration)

/**
 * MSRCXPlayToneVar function.
 * Send the PlayToneVar command to an RCX.
 *
 * \param _varnum The variable containing the tone frequency to play.
 * \param _duration The duration of the tone to play.
 */
#define MSRCXPlayToneVar(_varnum, _duration) __MSRCXPlayToneVar(_varnum, _duration)

/**
 * MSRCXRemote function.
 * Send the Remote command to an RCX.
 *
 * \param _cmd The RCX IR remote command to send. See \ref RCXRemoteConstants.
 */
#define MSRCXRemote(_cmd) __MSRCXRemote(_cmd)

/**
 * MSRCXReset function.
 * Send the Reset command to an RCX.
 */
#define MSRCXReset() __MSRCXReset()

/**
 * MSRCXRev function.
 * Send commands to an RCX to set the specified outputs to the reverse direction.
 *
 * \param _outputs The RCX output(s) to reverse direction. See \ref RCXOutputConstants.
 */
#define MSRCXRev(_outputs) __MSRCXSetDirection(_outputs, RCX_OUT_REV)

/**
 * MSRCXSelectDisplay function.
 * Send the SelectDisplay command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSelectDisplay(_src, _value) __MSRCXSelectDisplay(_src, _value)

/**
 * MSRCXSelectProgram function.
 * Send the SelectProgram command to an RCX.
 *
 * \param _prog The program number to select.
 */
#define MSRCXSelectProgram(_prog) __MSRCXSelectProgram(_prog)

/**
 * MSRCXSendSerial function.
 * Send the SendSerial command to an RCX.
 *
 * \param _first The first byte address.
 * \param _count The number of bytes to send.
 */
#define MSRCXSendSerial(_first, _count) __MSRCXSendSerial(_first, _count)

/**
 * MSRCXSet function.
 * Send the Set command to an RCX.
 *
 * \param _dstsrc The RCX destination source.  See \ref RCXSourceConstants.
 * \param _dstval The RCX destination value.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSet(_dstsrc, _dstval, _src, _value) __MSRCXSet(_dstsrc, _dstval, _src, _value)

/**
 * MSRCXSetDirection function.
 * Send the SetDirection command to an RCX to configure the direction of the specified outputs.
 *
 * \param _outputs The RCX output(s) to set direction. See \ref RCXOutputConstants.
 * \param _dir The RCX output direction. See \ref RCXOutputDirection.
 */
#define MSRCXSetDirection(_outputs, _dir) __MSRCXSetDirection(_outputs, _dir)

/**
 * MSRCXSetEvent function.
 * Send the SetEvent command to an RCX.
 *
 * \param _evt The event number to set.
 * \param _src The RCX source. See \ref RCXSourceConstants.
 * \param _type The event type.
 */
#define MSRCXSetEvent(_evt, _src, _type) __MSRCXSetEvent(_evt, _src, _type)

/**
 * MSRCXSetGlobalDirection function.
 * Send the SetGlobalDirection command to an RCX.
 *
 * \param _outputs The RCX output(s) to set global direction. See \ref RCXOutputConstants.
 * \param _dir The RCX output direction. See \ref RCXOutputDirection.
 */
#define MSRCXSetGlobalDirection(_outputs, _dir) __MSRCXSetGlobalDirection(_outputs, _dir)

/**
 * MSRCXSetGlobalOutput function.
 * Send the SetGlobalOutput command to an RCX.
 *
 * \param _outputs The RCX output(s) to set global mode. See \ref RCXOutputConstants.
 * \param _mode The RCX output mode. See \ref RCXOutputMode.
 */
#define MSRCXSetGlobalOutput(_outputs, _mode) __MSRCXSetGlobalOutput(_outputs, _mode)

/**
 * MSRCXSetMaxPower function.
 * Send the SetMaxPower command to an RCX.
 *
 * \param _outputs The RCX output(s) to set max power. See \ref RCXOutputConstants.
 * \param _pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param _pwrval The RCX value.
 */
#define MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) __MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval)

/**
 * MSRCXSetMessage function.
 * Send the SetMessage command to an RCX.
 *
 * \param _msg The numeric message to send.
 */
#define MSRCXSetMessage(_msg) __MSRCXSetMessage(_msg)

/**
 * MSRCXSetOutput function.
 * Send the SetOutput command to an RCX to configure the mode of the specified outputs
 *
 * \param _outputs The RCX output(s) to set mode. See \ref RCXOutputConstants.
 * \param _mode The RCX output mode. See \ref RCXOutputMode.
 */
#define MSRCXSetOutput(_outputs, _mode) __MSRCXSetOutput(_outputs, _mode)

/**
 * MSRCXSetPower function.
 * Send the SetPower command to an RCX to configure the power level of the specified outputs.
 *
 * \param _outputs The RCX output(s) to set power. See \ref RCXOutputConstants.
 * \param _pwrsrc The RCX source.  See \ref RCXSourceConstants.
 * \param _pwrval The RCX value.
 */
#define MSRCXSetPower(_outputs, _pwrsrc, _pwrval) __MSRCXSetPower(_outputs, _pwrsrc, _pwrval)

/**
 * MSRCXSetPriority function.
 * Send the SetPriority command to an RCX.
 *
 * \param _p The new task priority.
 */
#define MSRCXSetPriority(_p) __MSRCXSetPriority(_p)

/**
 * MSRCXSetSensorMode function.
 * Send the SetSensorMode command to an RCX.
 *
 * \param _port The RCX sensor port.
 * \param _mode The RCX sensor mode.
 */
#define MSRCXSetSensorMode(_port, _mode) __MSRCXSetSensorMode(_port, _mode)

/**
 * MSRCXSetSensorType function.
 * Send the SetSensorType command to an RCX.
 *
 * \param _port The RCX sensor port.
 * \param _type The RCX sensor type.
 */
#define MSRCXSetSensorType(_port, _type) __MSRCXSetSensorType(_port, _type)

/**
 * MSRCXSetSleepTime function.
 * Send the SetSleepTime command to an RCX.
 *
 * \param _t The new sleep time value.
 */
#define MSRCXSetSleepTime(_t) __MSRCXSetSleepTime(_t)

/**
 * MSRCXSetTxPower function.
 * Send the SetTxPower command to an RCX.
 *
 * \param _pwr The IR transmit power level.
 */
#define MSRCXSetTxPower(_pwr) __MSRCXSetTxPower(_pwr)

/**
 * MSRCXSetUserDisplay function.
 * Send the SetUserDisplay command to an RCX.
 *
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 * \param _precision The number of digits of precision.
 */
#define MSRCXSetUserDisplay(_src, _value, _precision) __MSRCXSetUserDisplay(_src, _value, _precision)

/**
 * MSRCXSetVar function.
 * Send the SetVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSetVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SetVarOp, _varnum, _src, _value)

/**
 * MSRCXSetWatch function.
 * Send the SetWatch command to an RCX.
 *
 * \param _hours The new watch time hours value.
 * \param _minutes The new watch time minutes value.
 */
#define MSRCXSetWatch(_hours, _minutes) __MSRCXSetWatch(_hours, _minutes)

/**
 * MSRCXSgnVar function.
 * Send the SgnVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSgnVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SgnVarOp, _varnum, _src, _value)

/**
 * MSRCXStartTask function.
 * Send the StartTask command to an RCX.
 *
 * \param _t The task number to start.
 */
#define MSRCXStartTask(_t) __MSRCXStartTask(_t)

/**
 * MSRCXStopAllTasks function.
 * Send the StopAllTasks command to an RCX.
 */
#define MSRCXStopAllTasks() __MSRCXOpNoArgs(RCX_StopAllTasksOp)

/**
 * MSRCXStopTask function.
 * Send the StopTask command to an RCX.
 *
 * \param _t The task number to stop.
 */
#define MSRCXStopTask(_t) __MSRCXStopTask(_t)

/**
 * MSRCXSubVar function.
 * Send the SubVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSubVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SubVarOp, _varnum, _src, _value)

/**
 * MSRCXSumVar function.
 * Send the SumVar command to an RCX.
 *
 * \param _varnum The variable number to change.
 * \param _src The RCX source.  See \ref RCXSourceConstants.
 * \param _value The RCX value.
 */
#define MSRCXSumVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SumVarOp, _varnum, _src, _value)

/**
 * MSRCXToggle function.
 * Send commands to an RCX to toggle the direction of the specified outputs.
 *
 * \param _outputs The RCX output(s) to toggle. See \ref RCXOutputConstants.
 */
#define MSRCXToggle(_outputs) __MSRCXSetDirection(_outputs, RCX_OUT_TOGGLE)

/**
 * MSRCXUnlock function.
 * Send the Unlock command to an RCX.
 */
#define MSRCXUnlock() __MSRCXUnlock()

/**
 * MSRCXUnmuteSound function.
 * Send the UnmuteSound command to an RCX.
 */
#define MSRCXUnmuteSound() __MSRCXOpNoArgs(RCX_UnmuteSoundOp)

/**
 * MSScoutCalibrateSensor function.
 * Send the CalibrateSensor command to a Scout.
 */
#define MSScoutCalibrateSensor() __MSRCXOpNoArgs(RCX_LSCalibrateOp)

/**
 * MSScoutMuteSound function.
 * Send the MuteSound command to a Scout.
 */
#define MSScoutMuteSound() __MSScoutMuteSound()

/**
 * MSScoutSelectSounds function.
 * Send the SelectSounds command to a Scout.
 *
 * \param _grp The Scout sound group to select.
 */
#define MSScoutSelectSounds(_grp) __MSScoutSelectSounds(_grp)

/**
 * MSScoutSendVLL function.
 * Send the SendVLL command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSendVLL(_src, _value) __MSScoutSendVLL(_src, _value)

/**
 * MSScoutSetCounterLimit function.
 * Send the SetCounterLimit command to a Scout.
 *
 * \param _ctr The counter for which to set the limit.
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetCounterLimit(_ctr, _src, _value) __MSScoutSetCounterLimit(_ctr, _src, _value)

/**
 * MSScoutSetEventFeedback function.
 * Send the SetEventFeedback command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetEventFeedback(_src, _value) __MSScoutSetEventFeedback(_src, _value)

/**
 * MSScoutSetLight function.
 * Send the SetLight command to a Scout.
 *
 * \param _x Set the light on or off using this value. See \ref ScoutLightConstants.
 */
#define MSScoutSetLight(_x) __MSScoutSetLight(_x)

/**
 * MSScoutSetScoutMode function.
 * Send the SetScoutMode command to a Scout.
 *
 * \param _mode Set the scout mode. See \ref ScoutModeConstants.
*/
#define MSScoutSetScoutMode(_mode) __MSScoutSetScoutMode(_mode)

/**
 * MSScoutSetScoutRules function.
 * Send the SetScoutRules command to a Scout.
 *
 * \param _m Scout motion rule. See \ref ScoutMotionRuleConstants.
 * \param _t Scout touch rule. See \ref ScoutTouchRuleConstants.
 * \param _l Scout light rule. See \ref ScoutLightRuleConstants.
 * \param _tm Scout transmit rule. See \ref ScoutTransmitRuleConstants.
 * \param _fx Scout special effects rule. See \ref ScoutSpecialEffectConstants.
 */
#define MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) __MSScoutSetScoutRules(_m, _t, _l, _tm, _fx)

/**
 * MSScoutSetSensorClickTime function.
 * Send the SetSensorClickTime command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetSensorClickTime(_src, _value) __MSScoutSetSensorClickTime(_src, _value)

/**
 * MSScoutSetSensorHysteresis function.
 * Send the SetSensorHysteresis command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetSensorHysteresis(_src, _value) __MSScoutSetSensorHysteresis(_src, _value)

/**
 * MSScoutSetSensorLowerLimit function.
 * Send the SetSensorLowerLimit command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetSensorLowerLimit(_src, _value) __MSScoutSetSensorLowerLimit(_src, _value)

/**
 * MSScoutSetSensorUpperLimit function.
 * Send the SetSensorUpperLimit command to a Scout.
 *
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetSensorUpperLimit(_src, _value) __MSScoutSetSensorUpperLimit(_src, _value)

/**
 * MSScoutSetTimerLimit function.
 * Send the SetTimerLimit command to a Scout.
 *
 * \param _tmr The timer for which to set a limit.
 * \param _src The Scout source.  See \ref RCXSourceConstants.
 * \param _value The Scout value.
 */
#define MSScoutSetTimerLimit(_tmr, _src, _value) __MSScoutSetTimerLimit(_tmr, _src, _value)

/**
 * MSScoutUnmuteSound function.
 * Send the UnmuteSound command to a Scout.
 */
#define MSScoutUnmuteSound() __MSScoutUnmuteSound()

/** @} */ // end of MindSensorsAPI group

/** @addtogroup CodatexAPI
 * @{
 */

// Codatex RFID functions

/**
 * RFIDInit function.
 * Initialize the Codatex RFID sensor.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The boolean function call result.
 */
#define RFIDInit(_port, _result) __RFIDInit(_port, _result)

/**
 * RFIDMode function.
 * Configure the Codatex RFID sensor mode.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _mode The RFID sensor mode.  See the \ref CTRFIDModeConstants group.
 * \param _result The boolean function call result.
 */
#define RFIDMode(_port, _mode, _result) __RFIDMode(_port, _mode, _result)

/**
 * RFIDStatus function.
 * Read the Codatex RFID sensor status.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The RFID sensor status.
 */
#define RFIDStatus(_port, _result) __RFIDStatus(_port, _result)

/**
 * RFIDRead function.
 * Read the Codatex RFID sensor value.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _output The five bytes of RFID data.
 * \param _result The boolean function call result.
 */
#define RFIDRead(_port, _output, _result) __RFIDRead(_port, _output, _result)

/**
 * RFIDStop function.
 * Stop the Codatex RFID sensor.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _result The boolean function call result.
 */
#define RFIDStop(_port, _result) __RFIDStop(_port, _result)

/**
 * RFIDReadSingle function.
 * Set the Codatex RFID sensor into single mode and read the RFID data.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _output The five bytes of RFID data.
 * \param _result The boolean function call result.
 */
#define RFIDReadSingle(_port, _output, _result) __RFIDReadSingle(_port, _output, _result)

/**
 * RFIDReadContinuous function.
 * Set the Codatex RFID sensor into continuous mode, if necessary, and read
 * the RFID data.
 *
 * \param _port The port to which the Codatex RFID sensor is attached. See the
 * \ref NBCInputPortConstants group. You may use a constant or a variable.
 * \param _output The five bytes of RFID data.
 * \param _result The boolean function call result.
 */
#define RFIDReadContinuous(_port, _output, _result) __RFIDReadContinuous(_port, _output, _result)

/** @} */  // end of CodatexAPI group

/** @} */ // end of ThirdPartyDevices group


/** @addtogroup GraphicsLibrary
 * @{
 */

//------------------------------------------------------------------------------
// File          : nbcGL.nbc
// Description   : Data and subroutines for a very simple 3D engine.
// Programmed by : Arno van der Vegt, legoasimo@gmail.com
//------------------------------------------------------------------------------

/**
 * Initialize graphics library.
 * Setup all the necessary data for the graphics library to function. Call this
 * function before any other graphics library routine.
 */
#define glInit() __glInit()

/**
 * Set graphics library options.
 * Adjust graphic library settings for circle size and cull mode.
 *
 * \param _glType The setting type.  See \ref GLConstantsSettings.
 * \param _glValue The setting value. For culling modes see \ref GLConstantsCullMode.
 */
#define glSet(_glType, _glValue) __glSet(_glType, _glValue)

/**
 * Begin defining an object.
 * Start the process of defining a graphics library object using low level
 * functions such as \ref glBegin, \ref glAddVertex, and \ref glEnd.
 *
 * \param _glObjId The object index of the new object being created.
 */
#define glBeginObject(_glObjId) __glBeginObject(_glObjId)

/**
 * Stop defining an object.
 * Finish the process of defining a graphics library object.  Call this function
 * after you have completed the object definition.
 */
#define glEndObject() __glEndObject()

/**
 * Perform an object action.
 * Execute the specified action on the specified object.
 *
 * \param _glObjectId The object id.
 * \param _glAction The action to perform on the object. See \ref GLConstantsActions.
 * \param _glValue The setting value.
 */
#define glObjectAction(_glObjectId, _glAction, _glValue) __glObjectAction(_glObjectId, _glAction, _glValue)

/**
 * Add a vertex to an object.
 * Add a vertex to an object currently being defined.  This function should
 * only be used between \ref glBegin and \ref glEnd which are themselves
 * nested within a \ref glBeginObject and \ref glEndObject pair.
 *
 * \param _glX The X axis coordinate.
 * \param _glY The Y axis coordinate.
 * \param _glZ The Z axis coordinate.
 */
#define glAddVertex(_glX, _glY, _glZ) __glAddVertex(_glX, _glY, _glZ)

/**
 * Begin a new polygon for the current object.
 * Start defining a polygon surface for the current graphics object using
 * the specified begin mode.
 *
 * \param _glBeginMode The desired mode.  See \ref GLConstantsBeginModes.
 */
#define glBegin(_glBeginMode) __glBegin(_glBeginMode)

/**
 * Finish a polygon for the current object.
 * Stop defining a polgyon surface for the current graphics object.
 */
#define glEnd() __glEnd()

/**
 * Begin a new render.
 * Start the process of rendering the existing graphic objects.
 */
#define glBeginRender() __glBeginRender()

/**
 * Call a graphic object.
 * Tell the graphics library that you want it to include the specified
 * object in the render.
 *
 * \param _glObjectId The desired object id.
 */
#define glCallObject(_glObjectId) __glCallObject(_glObjectId)

/**
 * Finish the current render.
 * Rotate the vertex list, clear the screen, and draw the rendered objects
 * to the LCD.
 */
#define glFinishRender() __glFinishRender()

/**
 * Set the X axis angle.
 * Set the X axis angle to the specified value.
 *
 * \param _glValue The new X axis angle.
 */
#define glSetAngleX(_glValue) __glSetAngleX(_glValue)

/**
 * Add to the X axis angle.
 * Add the specified value to the existing X axis angle.
 *
 * \param _glValue The value to add to the X axis angle.
 */
#define glAddToAngleX(_glValue) __glAddToAngleX(_glValue)

/**
 * Set the Y axis angle.
 * Set the Y axis angle to the specified value.
 *
 * \param _glValue The new Y axis angle.
 */
#define glSetAngleY(_glValue) __glSetAngleY(_glValue)

/**
 * Add to the Y axis angle.
 * Add the specified value to the existing Y axis angle.
 *
 * \param _glValue The value to add to the Y axis angle.
 */
#define glAddToAngleY(_glValue) __glAddToAngleY(_glValue)

/**
 * Set the Z axis angle.
 * Set the Z axis angle to the specified value.
 *
 * \param _glValue The new Z axis angle.
 */
#define glSetAngleZ(_glValue) __glSetAngleZ(_glValue)

/**
 * Add to the Z axis angle.
 * Add the specified value to the existing Z axis angle.
 *
 * \param _glValue The value to add to the Z axis angle.
 */
#define glAddToAngleZ(_glValue) __glAddToAngleZ(_glValue)

/**
 * Table-based sine scaled by 32768.
 * Return the sine of the specified angle in degrees.  The result is scaled
 * by 32768.
 *
 * \param _glAngle The angle in degrees.
 * \param _glResult The sine value scaled by 32768.
 */
#define glSin32768(_glAngle, _glResult) __glSin32768(_glAngle, _glResult)

/**
 * Table-based cosine scaled by 32768.
 * Return the cosine of the specified angle in degrees.  The result is scaled
 * by 32768.
 *
 * \param _glAngle The angle in degrees.
 * \param _glResult The cosine value scaled by 32768.
 */
#define glCos32768(_glAngle, _glResult) __glCos32768(_glAngle, _glResult)

/**
 * Create a 3D box.
 * Define a 3D box using the specified begin mode for all faces. The center
 * of the box is at the origin of the XYZ axis with width, height, and depth
 * specified via the glSizeX, glSizeY, and glSizeZ parameters.
 *
 * \param _glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param _glSizeX The X axis size (width).
 * \param _glSizeY The Y axis size (height).
 * \param _glSizeZ The Z axis size (depth).
 * \param _glObjId The object ID of the new object.
 */
#define glBox(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId) __glBox(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId)

/**
 * Create a 3D cube.
 * Define a 3D cube using the specified begin mode for all faces. The center
 * of the box is at the origin of the XYZ axis with equal width, height, and depth
 * specified via the glSize parameter.
 *
 * \param _glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param _glSize The cube's width, height, and depth.
 * \param _glObjId The object ID of the new object.
 */
#define glCube(_glMode, _glSize, _glObjId) __glBox(_glMode, _glSize, _glSize, _glSize, _glObjId)

/**
 * Create a 3D pyramid.
 * Define a 3D pyramid using the specified begin mode for all faces. The center
 * of the pyramid is at the origin of the XYZ axis with width, height, and depth
 * specified via the glSizeX, glSizeY, and glSizeZ parameters.
 *
 * \param _glMode The begin mode for each surface.  See \ref GLConstantsBeginModes.
 * \param _glSizeX The X axis size (width).
 * \param _glSizeY The Y axis size (height).
 * \param _glSizeZ The Z axis size (depth).
 * \param _glObjId The object ID of the new object.
 */
#define glPyramid(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId) __glPyramid(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId)

/** @} */ // end of GraphicsLibrary group


#endif // NXTDEFS__H
