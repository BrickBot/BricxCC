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
 * date 2010-04-05
 * version 60
 */
#ifndef NXTDEFS__H
#define NXTDEFS__H 1

#include "NBCCommon.h"

/*
 * Logical comparison operators for use in brtst, tst, tstset, brcmp,
 * cmp, and cmpset.
 */
#define LT   0x00
#define GT   0x01
#define LTEQ 0x02
#define GTEQ 0x03
#define EQ   0x04
#define NEQ  0x05 

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

#define UF_UPDATE_ONFWD 0x28

// API macros
#define __resetMotorCounter0(_val) setout OUT_A, UpdateFlags, _val
#define __resetMotorCounter1(_val) setout OUT_B, UpdateFlags, _val
#define __resetMotorCounter2(_val) setout OUT_C, UpdateFlags, _val
#define __resetMotorCounter3(_val) setout __OUT_AB, UpdateFlags, _val
#define __resetMotorCounter4(_val) setout __OUT_AC, UpdateFlags, _val
#define __resetMotorCounter5(_val) setout __OUT_BC, UpdateFlags, _val
#define __resetMotorCounter6(_val) setout __OUT_ABC, UpdateFlags, _val

#define __resetTachoCount(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlags, RESET_COUNT \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_COUNT) \
  compend

#define __resetBlockTachoCount(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlags, RESET_BLOCK_COUNT \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_BLOCK_COUNT) \
  compend

#define __resetRotationCount(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlags, RESET_ROTATION_COUNT \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_ROTATION_COUNT) \
  compend

#define __resetAllTachoCounts(_p) \
  compif EQ, isconst(_p), FALSE \
  setout _p, UpdateFlags, RESET_ALL \
  compelse \
  compchk LT, _p, 0x07 \
  compchk GTEQ, _p, 0x00 \
  __resetMotorCounter##_p(RESET_ALL) \
  compend

#define ResetTachoCount(_p) __resetTachoCount(_p)
#define ResetBlockTachoCount(_p) __resetBlockTachoCount(_p)
#define ResetRotationCount(_p) __resetRotationCount(_p)
#define ResetAllTachoCounts(_p) __resetAllTachoCounts(_p) 

#define __onFwdExPIDAll(_ports, _pwr, _reset, _p, _i, _d) setout _ports, Power, _pwr, OutputMode, OUT_MODE_MOTORON+OUT_MODE_BRAKE, RegMode, OUT_REGMODE_IDLE, RunState, OUT_RUNSTATE_RUNNING, TurnRatio, 0, TachoLimit, 0, RegPValue, _p, RegIValue, _i, RegDValue, _d, UpdateFlags, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __onFwdExPID0(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(OUT_A, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID1(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(OUT_B, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID2(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(OUT_C, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID3(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_AB, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID4(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_AC, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID5(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_BC, _pwr, _reset, _p, _i, _d)
#define __onFwdExPID6(_pwr, _reset, _p, _i, _d) __onFwdExPIDAll(__OUT_ABC, _pwr, _reset, _p, _i, _d)

#define OnFwdEx(_ports, _pwr, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdExPIDAll(_ports, _pwr, _reset, PID_3, PID_1, PID_1) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdExPID##_ports(_pwr, _reset, PID_3, PID_1, PID_1) \
  compend

#define OnRevEx(_ports, _pwr, _reset) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  OnFwdEx(_ports, __OnRev_Tmp, _reset) \
  release __OnRevMutex

#define OnFwdExPID(_ports, _pwr, _reset, _p, _i, _d) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdExPIDAll(_ports, _pwr, _reset, _p, _i, _d) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdExPID##_ports(_pwr, _reset, _p, _i, _d) \
  compend

#define OnRevExPID(_ports, _pwr, _reset, _p, _i, _d) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  OnFwdExPID(_ports, __OnRev_Tmp, _reset, _p, _i, _d) \
  release __OnRevMutex

#define OnFwd(_ports, _pwr) OnFwdEx(_ports, _pwr, RESET_BLOCKANDTACHO)
#define OnRev(_ports, _pwr) OnRevEx(_ports, _pwr, RESET_BLOCKANDTACHO)

#define __coastExAll(_ports, _reset) setout _ports, Power, 0, OutputMode, OUT_MODE_BRAKE, RegMode, OUT_REGMODE_IDLE, RunState, OUT_RUNSTATE_IDLE, TurnRatio, 0, TachoLimit, 0, RegPValue, PID_3, RegIValue, PID_1, RegDValue, PID_1, UpdateFlags, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __coastEx0(_reset) __coastExAll(OUT_A, _reset)
#define __coastEx1(_reset) __coastExAll(OUT_B, _reset)
#define __coastEx2(_reset) __coastExAll(OUT_C, _reset)
#define __coastEx3(_reset) __coastExAll(__OUT_AB, _reset)
#define __coastEx4(_reset) __coastExAll(__OUT_AC, _reset)
#define __coastEx5(_reset) __coastExAll(__OUT_BC, _reset)
#define __coastEx6(_reset) __coastExAll(__OUT_ABC, _reset)

#define CoastEx(_ports, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __coastExAll(_ports, _reset) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __coastEx##_ports(_reset) \
  compend

#define __offExAll(_ports, _reset) setout _ports, Power, 0, OutputMode, OUT_MODE_MOTORON+OUT_MODE_BRAKE, RegMode, OUT_REGMODE_IDLE, RunState, OUT_RUNSTATE_RUNNING, TurnRatio, 0, TachoLimit, 0, RegPValue, PID_3, RegIValue, PID_1, RegDValue, PID_1, UpdateFlags, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __offEx0(_reset) __offExAll(OUT_A, _reset)
#define __offEx1(_reset) __offExAll(OUT_B, _reset)
#define __offEx2(_reset) __offExAll(OUT_C, _reset)
#define __offEx3(_reset) __offExAll(__OUT_AB, _reset)
#define __offEx4(_reset) __offExAll(__OUT_AC, _reset)
#define __offEx5(_reset) __offExAll(__OUT_BC, _reset)
#define __offEx6(_reset) __offExAll(__OUT_ABC, _reset)

#define OffEx(_ports, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __offExAll(_ports, _reset) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __offEx##_ports(_reset) \
  compend

#define Coast(_ports) CoastEx(_ports, RESET_BLOCKANDTACHO)
#define Off(_ports) OffEx(_ports, RESET_BLOCKANDTACHO)
#define Float(_ports) Coast(_ports)

#define __onFwdRegExPIDAll(_ports, _pwr, _regmode, _reset, _p, _i, _d) setout _ports, Power, _pwr, OutputMode, OUT_MODE_MOTORON+OUT_MODE_REGULATED+OUT_MODE_BRAKE, RegMode, _regmode, RunState, OUT_RUNSTATE_RUNNING, TurnRatio, 0, TachoLimit, 0, RegPValue, _p, RegIValue, _i, RegDValue, _d, UpdateFlags, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __onFwdRegExPID0(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(OUT_A, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID1(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(OUT_B, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID2(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(OUT_C, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID3(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_AB, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID4(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_AC, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID5(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_BC, _pwr, _regmode, _reset, _p, _i, _d)
#define __onFwdRegExPID6(_pwr, _regmode, _reset, _p, _i, _d) __onFwdRegExPIDAll(__OUT_ABC, _pwr, _regmode, _reset, _p, _i, _d)

#define OnFwdRegEx(_ports, _pwr, _regmode, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdRegExPIDAll(_ports, _pwr, _regmode, _reset, PID_3, PID_1, PID_1) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdRegExPID##_ports(_pwr, _regmode, _reset, PID_3, PID_1, PID_1) \
  compend

#define OnRevRegEx(_ports, _pwr, _regmode, _reset) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  OnFwdRegEx(_ports, __OnRev_Tmp, _regmode, _reset) \
  release __OnRevMutex

#define OnFwdRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdRegExPIDAll(_ports, _pwr, _regmode, _reset, _p, _i, _d) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdRegExPID##_ports(_pwr, _regmode, _reset, _p, _i, _d) \
  compend

#define OnRevRegExPID(_ports, _pwr, _regmode, _reset, _p, _i, _d) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  OnFwdRegExPID(_ports, __OnRev_Tmp, _regmode, _reset, _p, _i, _d) \
  release __OnRevMutex

#define OnFwdReg(_ports, _pwr, _regmode) OnFwdRegEx(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO)
#define OnRevReg(_ports, _pwr, _regmode) OnRevRegEx(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO)
#define OnFwdRegPID(_ports, _pwr, _regmode, _p, _i, _d) OnFwdRegExPID(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO, _p, _i, _d)
#define OnRevRegPID(_ports, _pwr, _regmode, _p, _i, _d) OnRevRegExPID(_ports, _pwr, _regmode, RESET_BLOCKANDTACHO, _p, _i, _d)

#define __onFwdSyncExPIDAll(_ports, _pwr, _turnpct, _reset, _p, _i, _d) setout _ports, Power, _pwr, OutputMode, OUT_MODE_MOTORON+OUT_MODE_REGULATED+OUT_MODE_BRAKE, RegMode, OUT_REGMODE_SYNC, TurnRatio, _turnpct, RunState, OUT_RUNSTATE_RUNNING, TachoLimit, 0, RegPValue, _p, RegIValue, _i, RegDValue, _d, UpdateFlags, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_MODE+UF_UPDATE_SPEED+UF_UPDATE_PID_VALUES+_reset
#define __onFwdSyncExPID0(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(OUT_A, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID1(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(OUT_B, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID2(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(OUT_C, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID3(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_AB, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID4(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_AC, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID5(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_BC, _pwr, _turnpct, _reset, _p, _i, _d)
#define __onFwdSyncExPID6(_pwr, _turnpct, _reset, _p, _i, _d) __onFwdSyncExPIDAll(__OUT_ABC, _pwr, _turnpct, _reset, _p, _i, _d)

#define OnFwdSyncEx(_ports, _pwr, _turnpct, _reset) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdSyncExPIDAll(_ports, _pwr, _turnpct, _reset, PID_3, PID_1, PID_1) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdSyncExPID##_ports(_pwr, _turnpct, _reset, PID_3, PID_1, PID_1) \
  compend

#define OnRevSyncEx(_ports, _pwr, _turnpct, _reset) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  OnFwdSyncEx(_ports, __OnRev_Tmp, _turnpct, _reset) \
  release __OnRevMutex

#define OnFwdSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) \
  compif EQ, isconst(_ports), FALSE \
  __onFwdSyncExPIDAll(_ports, _pwr, _turnpct, _reset, _p, _i, _d) \
  compelse \
  compchk LT, _ports, 0x07 \
  compchk GTEQ, _ports, 0x00 \
  __onFwdSyncExPID##_ports(_pwr, _turnpct, _reset, _p, _i, _d) \
  compend

#define OnRevSyncExPID(_ports, _pwr, _turnpct, _reset, _p, _i, _d) \
  acquire __OnRevMutex \
  neg __OnRev_Tmp, _pwr \
  OnFwdSyncExPID(_ports, __OnRev_Tmp, _turnpct, _reset, _p, _i, _d) \
  release __OnRevMutex

#define OnFwdSync(_ports, _pwr, _turnpct) OnFwdSyncEx(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO)
#define OnRevSync(_ports, _pwr, _turnpct) OnRevSyncEx(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO)
#define OnFwdSyncPID(_ports, _pwr, _turnpct, _p, _i, _d) OnFwdSyncExPID(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO, _p, _i, _d)
#define OnRevSyncPID(_ports, _pwr, _turnpct, _p, _i, _d) OnRevSyncExPID(_ports, _pwr, _turnpct, RESET_BLOCKANDTACHO, _p, _i, _d)

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

#define RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   compif EQ, isconst(_ports), FALSE \
   __rotateMotorExPIDVar(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   compelse \
   compchk LT, _ports, 0x07 \
   compchk GTEQ, _ports, 0x00 \
   __rotateMotorExPID##_ports(_pwr, _angle, _turnpct, _bSync, _bStop, _p, _i, _d) \
   compend

// default PID values are 96, 32, 32 (PID_3, PID_1, PID_1)

#define RotateMotorPID(_ports, _pwr, _angle, _p, _i, _d) \
   RotateMotorExPID(_ports, _pwr, _angle, 0, FALSE, TRUE, _p, _i, _d)

#define RotateMotorEx(_ports, _pwr, _angle, _turnpct, _bSync, _bStop) \
   RotateMotorExPID(_ports, _pwr, _angle, _turnpct, _bSync, _bStop, PID_1, PID_0, PID_3)

#define RotateMotor(_ports, _pwr, _angle) \
   RotateMotorExPID(_ports, _pwr, _angle, 0, FALSE, TRUE, PID_1, PID_0, PID_3)

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
  setout __rotate_ports0, OutputMode, __rotate_theOM0, RegMode, __rotate_theRM0, TachoLimit, __rotate_theAngle0, RunState, __rotate_theRS0, RegPValue, __rotate_theRVP0, RegIValue, __rotate_theRVI0, RegDValue, __rotate_theRVD0, Power, __rotate_thePower0, TurnRatio, __rotate_turnpct0, UpdateFlags, __rotate_theUF0

// Waits till angle reached
  index __rotate_firstPort0, __rotate_ports0, NA
__rotate_Running0:
  getout __rotate_power0, __rotate_firstPort0, Power
  brtst EQ, __rotate_doneRunning0, __rotate_power0
  getout __rotate_rs0, __rotate_firstPort0, RunState
  brcmp EQ, __rotate_Running0, __rotate_rs0, OUT_RUNSTATE_RUNNING
__rotate_doneRunning0:
  brtst EQ, __rotate_Reset0, __rotate_stop0 ; skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM0, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF0, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports0, OutputMode, __rotate_theOM0, RegMode, OUT_REGMODE_SPEED, RunState, __rotate_theRS0, Power, 0, TachoLimit, 0, UpdateFlags, __rotate_theUF0
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount0, __rotate_firstPort0, RotationCount
__rotate_Stabilize0:
  mov __rotate_OldRotCount0, __rotate_RotCount0
  wait 50
  // check rotation
  getout __rotate_RotCount0, __rotate_firstPort0, RotationCount
  brcmp NEQ, __rotate_Stabilize0, __rotate_OldRotCount0, __rotate_RotCount0
  set __rotate_theOM0, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports0, RegMode, __rotate_theRM0, RunState, OUT_RUNSTATE_IDLE, OutputMode, __rotate_theOM0, UpdateFlags, UF_UPDATE_MODE
__rotate_Reset0:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done0, __rotate_theTurnPct0
  setout __rotate_ports0, UpdateFlags, UF_UPDATE_RESET_BLOCK_COUNT
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
  setout __rotate_ports1, OutputMode, __rotate_theOM1, RegMode, __rotate_theRM1, TachoLimit, __rotate_theAngle1, RunState, __rotate_theRS1, RegPValue, __rotate_theRVP1, RegIValue, __rotate_theRVI1, RegDValue, __rotate_theRVD1, Power, __rotate_thePower1, TurnRatio, __rotate_turnpct1, UpdateFlags, __rotate_theUF1

// Waits till angle reached
  index __rotate_firstPort1, __rotate_ports1, NA
__rotate_Running1:
  getout __rotate_power1, __rotate_firstPort1, Power
  brtst EQ, __rotate_doneRunning1, __rotate_power1
  getout __rotate_rs1, __rotate_firstPort1, RunState
  brcmp EQ, __rotate_Running1, __rotate_rs1, OUT_RUNSTATE_RUNNING
__rotate_doneRunning1:
  brtst EQ, __rotate_Reset1, __rotate_stop1 ; skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM1, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF1, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports1, OutputMode, __rotate_theOM1, RegMode, OUT_REGMODE_SPEED, RunState, __rotate_theRS1, Power, 0, TachoLimit, 0, UpdateFlags, __rotate_theUF1
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount1, __rotate_firstPort1, RotationCount
__rotate_Stabilize1:
  mov __rotate_OldRotCount1, __rotate_RotCount1
  wait 50
  // check rotation
  getout __rotate_RotCount1, __rotate_firstPort1, RotationCount
  brcmp NEQ, __rotate_Stabilize1, __rotate_OldRotCount1, __rotate_RotCount1
  set __rotate_theOM1, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports1, RegMode, __rotate_theRM1, RunState, OUT_RUNSTATE_IDLE, OutputMode, __rotate_theOM1, UpdateFlags, UF_UPDATE_MODE
__rotate_Reset1:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done1, __rotate_theTurnPct1
  setout __rotate_ports1, UpdateFlags, UF_UPDATE_RESET_BLOCK_COUNT
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
  setout __rotate_ports2, OutputMode, __rotate_theOM2, RegMode, __rotate_theRM2, TachoLimit, __rotate_theAngle2, RunState, __rotate_theRS2, RegPValue, __rotate_theRVP2, RegIValue, __rotate_theRVI2, RegDValue, __rotate_theRVD2, Power, __rotate_thePower2, TurnRatio, __rotate_turnpct2, UpdateFlags, __rotate_theUF2

// Waits till angle reached
  index __rotate_firstPort2, __rotate_ports2, NA
__rotate_Running2:
  getout __rotate_power2, __rotate_firstPort2, Power
  brtst EQ, __rotate_doneRunning2, __rotate_power2
  getout __rotate_rs2, __rotate_firstPort2, RunState
  brcmp EQ, __rotate_Running2, __rotate_rs2, OUT_RUNSTATE_RUNNING
__rotate_doneRunning2:
  brtst EQ, __rotate_Reset2, __rotate_stop2 ; skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM2, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF2, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports2, OutputMode, __rotate_theOM2, RegMode, OUT_REGMODE_SPEED, RunState, __rotate_theRS2, Power, 0, TachoLimit, 0, UpdateFlags, __rotate_theUF2
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount2, __rotate_firstPort2, RotationCount
__rotate_Stabilize2:
  mov __rotate_OldRotCount2, __rotate_RotCount2
  wait 50
  // check rotation
  getout __rotate_RotCount2, __rotate_firstPort2, RotationCount
  brcmp NEQ, __rotate_Stabilize2, __rotate_OldRotCount2, __rotate_RotCount2
  set __rotate_theOM2, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports2, RegMode, __rotate_theRM2, RunState, OUT_RUNSTATE_IDLE, OutputMode, __rotate_theOM2, UpdateFlags, UF_UPDATE_MODE
__rotate_Reset2:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done2, __rotate_theTurnPct2
  setout __rotate_ports2, UpdateFlags, UF_UPDATE_RESET_BLOCK_COUNT
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
  setout __rotate_ports3, OutputMode, __rotate_theOM3, RegMode, __rotate_theRM3, TachoLimit, __rotate_theAngle3, RunState, __rotate_theRS3, RegPValue, __rotate_theRVP3, RegIValue, __rotate_theRVI3, RegDValue, __rotate_theRVD3, Power, __rotate_thePower3, TurnRatio, __rotate_turnpct3, UpdateFlags, __rotate_theUF3

// Waits till angle reached
  index __rotate_firstPort3, __rotate_ports3, NA
__rotate_Running3:
  getout __rotate_power3, __rotate_firstPort3, Power
  brtst EQ, __rotate_doneRunning3, __rotate_power3
  getout __rotate_rs3, __rotate_firstPort3, RunState
  brcmp EQ, __rotate_Running3, __rotate_rs3, OUT_RUNSTATE_RUNNING
__rotate_doneRunning3:
  brtst EQ, __rotate_Reset3, __rotate_stop3 ; skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM3, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF3, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports3, OutputMode, __rotate_theOM3, RegMode, OUT_REGMODE_SPEED, RunState, __rotate_theRS3, Power, 0, TachoLimit, 0, UpdateFlags, __rotate_theUF3
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount3, __rotate_firstPort3, RotationCount
__rotate_Stabilize3:
  mov __rotate_OldRotCount3, __rotate_RotCount3
  wait 50
  // check rotation
  getout __rotate_RotCount3, __rotate_firstPort3, RotationCount
  brcmp NEQ, __rotate_Stabilize3, __rotate_OldRotCount3, __rotate_RotCount3
  set __rotate_theOM3, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports3, RegMode, __rotate_theRM3, RunState, OUT_RUNSTATE_IDLE, OutputMode, __rotate_theOM3, UpdateFlags, UF_UPDATE_MODE
__rotate_Reset3:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done3, __rotate_theTurnPct3
  setout __rotate_ports3, UpdateFlags, UF_UPDATE_RESET_BLOCK_COUNT
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
  setout __rotate_ports4, OutputMode, __rotate_theOM4, RegMode, __rotate_theRM4, TachoLimit, __rotate_theAngle4, RunState, __rotate_theRS4, RegPValue, __rotate_theRVP4, RegIValue, __rotate_theRVI4, RegDValue, __rotate_theRVD4, Power, __rotate_thePower4, TurnRatio, __rotate_turnpct4, UpdateFlags, __rotate_theUF4

// Waits till angle reached
  index __rotate_firstPort4, __rotate_ports4, NA
__rotate_Running4:
  getout __rotate_power4, __rotate_firstPort4, Power
  brtst EQ, __rotate_doneRunning4, __rotate_power4
  getout __rotate_rs4, __rotate_firstPort4, RunState
  brcmp EQ, __rotate_Running4, __rotate_rs4, OUT_RUNSTATE_RUNNING
__rotate_doneRunning4:
  brtst EQ, __rotate_Reset4, __rotate_stop4 ; skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM4, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF4, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports4, OutputMode, __rotate_theOM4, RegMode, OUT_REGMODE_SPEED, RunState, __rotate_theRS4, Power, 0, TachoLimit, 0, UpdateFlags, __rotate_theUF4
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount4, __rotate_firstPort4, RotationCount
__rotate_Stabilize4:
  mov __rotate_OldRotCount4, __rotate_RotCount4
  wait 50
  // check rotation
  getout __rotate_RotCount4, __rotate_firstPort4, RotationCount
  brcmp NEQ, __rotate_Stabilize4, __rotate_OldRotCount4, __rotate_RotCount4
  set __rotate_theOM4, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports4, RegMode, __rotate_theRM4, RunState, OUT_RUNSTATE_IDLE, OutputMode, __rotate_theOM4, UpdateFlags, UF_UPDATE_MODE
__rotate_Reset4:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done4, __rotate_theTurnPct4
  setout __rotate_ports4, UpdateFlags, UF_UPDATE_RESET_BLOCK_COUNT
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
  setout __rotate_ports5, OutputMode, __rotate_theOM5, RegMode, __rotate_theRM5, TachoLimit, __rotate_theAngle5, RunState, __rotate_theRS5, RegPValue, __rotate_theRVP5, RegIValue, __rotate_theRVI5, RegDValue, __rotate_theRVD5, Power, __rotate_thePower5, TurnRatio, __rotate_turnpct5, UpdateFlags, __rotate_theUF5

// Waits till angle reached
  index __rotate_firstPort5, __rotate_ports5, NA
__rotate_Running5:
  getout __rotate_power5, __rotate_firstPort5, Power
  brtst EQ, __rotate_doneRunning5, __rotate_power5
  getout __rotate_rs5, __rotate_firstPort5, RunState
  brcmp EQ, __rotate_Running5, __rotate_rs5, OUT_RUNSTATE_RUNNING
__rotate_doneRunning5:
  brtst EQ, __rotate_Reset5, __rotate_stop5 ; skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM5, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF5, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports5, OutputMode, __rotate_theOM5, RegMode, OUT_REGMODE_SPEED, RunState, __rotate_theRS5, Power, 0, TachoLimit, 0, UpdateFlags, __rotate_theUF5
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount5, __rotate_firstPort5, RotationCount
__rotate_Stabilize5:
  mov __rotate_OldRotCount5, __rotate_RotCount5
  wait 50
  // check rotation
  getout __rotate_RotCount5, __rotate_firstPort5, RotationCount
  brcmp NEQ, __rotate_Stabilize5, __rotate_OldRotCount5, __rotate_RotCount5
  set __rotate_theOM5, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports5, RegMode, __rotate_theRM5, RunState, OUT_RUNSTATE_IDLE, OutputMode, __rotate_theOM5, UpdateFlags, UF_UPDATE_MODE
__rotate_Reset5:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done5, __rotate_theTurnPct5
  setout __rotate_ports5, UpdateFlags, UF_UPDATE_RESET_BLOCK_COUNT
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
  setout __rotate_ports6, OutputMode, __rotate_theOM6, RegMode, __rotate_theRM6, TachoLimit, __rotate_theAngle6, RunState, __rotate_theRS6, RegPValue, __rotate_theRVP6, RegIValue, __rotate_theRVI6, RegDValue, __rotate_theRVD6, Power, __rotate_thePower6, TurnRatio, __rotate_turnpct6, UpdateFlags, __rotate_theUF6

// Waits till angle reached
  index __rotate_firstPort6, __rotate_ports6, NA
__rotate_Running6:
  getout __rotate_power6, __rotate_firstPort6, Power
  brtst EQ, __rotate_doneRunning6, __rotate_power6
  getout __rotate_rs6, __rotate_firstPort6, RunState
  brcmp EQ, __rotate_Running6, __rotate_rs6, OUT_RUNSTATE_RUNNING
__rotate_doneRunning6:
  brtst EQ, __rotate_Reset6, __rotate_stop6 ; skip the speed regulation phase if __rotate_stop is false
// Regulates for speed = 0
  set __rotate_theOM6, OUT_MODE_MOTORON+OUT_MODE_BRAKE+OUT_MODE_REGULATED
  set __rotate_theUF6, UF_UPDATE_TACHO_LIMIT+UF_UPDATE_SPEED+UF_UPDATE_MODE
  setout __rotate_ports6, OutputMode, __rotate_theOM6, RegMode, OUT_REGMODE_SPEED, RunState, __rotate_theRS6, Power, 0, TachoLimit, 0, UpdateFlags, __rotate_theUF6
// Verifies that motor doesn't rotate for 50ms, else loops
  getout __rotate_RotCount6, __rotate_firstPort6, RotationCount
__rotate_Stabilize6:
  mov __rotate_OldRotCount6, __rotate_RotCount6
  wait 50
  // check rotation
  getout __rotate_RotCount6, __rotate_firstPort6, RotationCount
  brcmp NEQ, __rotate_Stabilize6, __rotate_OldRotCount6, __rotate_RotCount6
  set __rotate_theOM6, OUT_MODE_COAST+OUT_MODE_REGULATED
  setout __rotate_ports6, RegMode, __rotate_theRM6, RunState, OUT_RUNSTATE_IDLE, OutputMode, __rotate_theOM6, UpdateFlags, UF_UPDATE_MODE
__rotate_Reset6:
  // maybe reset the block rotation count
  brtst EQ, __rotate_Done6, __rotate_theTurnPct6
  setout __rotate_ports6, UpdateFlags, UF_UPDATE_RESET_BLOCK_COUNT
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

#define SetSensorType(_port,_t) setin _t, _port, Type
#define SetSensorMode(_port,_m) setin _m, _port, InputMode
#define ReadSensor(_port,_value) getin _value, _port, ScaledValue
#define ClearSensor(_port) setin 0, _port, ScaledValue

#define __SetSensorTouch(_port) \
  SetSensorType(_port, IN_TYPE_SWITCH) \
  SetSensorMode(_port, IN_MODE_BOOLEAN) \
  ResetSensor(_port)

#define __SetSensorLight(_port) \
  SetSensorType(_port,IN_TYPE_LIGHT_ACTIVE) \
  SetSensorMode(_port,IN_MODE_PCTFULLSCALE) \
  ResetSensor(_port)

#define __SetSensorSound(_port) \
  SetSensorType(_port,IN_TYPE_SOUND_DB) \
  SetSensorMode(_port,IN_MODE_PCTFULLSCALE) \
  ResetSensor(_port)

#define __SetSensorLowspeed(_port) \
  SetSensorType(_port,IN_TYPE_LOWSPEED_9V) \
  SetSensorMode(_port,IN_MODE_RAW) \
  ResetSensor(_port)

#define SetSensorTouch(_port) __SetSensorTouch(_port)
#define SetSensorLight(_port) __SetSensorLight(_port)
#define SetSensorSound(_port) __SetSensorSound(_port)
#define SetSensorLowspeed(_port) __SetSensorLowspeed(_port)
#define SetSensorUltrasonic(_port) __SetSensorLowspeed(_port)

#if __FIRMWARE_VERSION > 107

#define __SetSensorColorFull(_port) \
  SetSensorType(_port,IN_TYPE_COLORFULL) \
  SetSensorMode(_port,IN_MODE_RAW) \
  ResetSensor(_port)

#define __SetSensorColorRed(_port) \
  SetSensorType(_port,IN_TYPE_COLORRED) \
  SetSensorMode(_port,IN_MODE_PCTFULLSCALE) \
  ResetSensor(_port)

#define __SetSensorColorGreen(_port) \
  SetSensorType(_port,IN_TYPE_COLORGREEN) \
  SetSensorMode(_port,IN_MODE_PCTFULLSCALE) \
  ResetSensor(_port)

#define __SetSensorColorBlue(_port) \
  SetSensorType(_port,IN_TYPE_COLORBLUE) \
  SetSensorMode(_port,IN_MODE_PCTFULLSCALE) \
  ResetSensor(_port)

#define __SetSensorColorNone(_port) \
  SetSensorType(_port,IN_TYPE_COLORNONE) \
  SetSensorMode(_port,IN_MODE_PCTFULLSCALE) \
  ResetSensor(_port)

#define SetSensorColorFull(_port) __SetSensorColorFull(_port)
#define SetSensorColorRed(_port) __SetSensorColorRed(_port)
#define SetSensorColorGreen(_port) __SetSensorColorGreen(_port)
#define SetSensorColorBlue(_port) __SetSensorColorBlue(_port)
#define SetSensorColorNone(_port) __SetSensorColorNone(_port)

#endif

dseg segment
  __ResetSensorMutex mutex
  __ResetSensorPort byte
  __ResetSensorTmp byte
dseg ends

subroutine __ResetSensorSubroutine
  setin TRUE, __ResetSensorPort, InvalidData
__SensorStillInvalid:
  getin	__ResetSensorTmp, __ResetSensorPort, InvalidData
  brtst	NEQ, __SensorStillInvalid, __ResetSensorTmp
  return
ends

#define __ResetSensor(_port) \
  acquire __ResetSensorMutex \
  mov __ResetSensorPort, _port \
  call __ResetSensorSubroutine \
  release __ResetSensorMutex

#define ResetSensor(_port) __ResetSensor(_port)

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

#define LowspeedStatus(_port, _bready, _result) __lowspeedStatus(_port, _bready, _result)
#define LowspeedCheckStatus(_port, _result) __lowspeedCheckStatus(_port, _result)
#define LowspeedBytesReady(_port, _bready) __lowspeedBytesReady(_port, _bready)
#define LowspeedWrite(_port, _retlen, _buffer, _result) __lowspeedWrite(_port, _retlen, _buffer, _result)
#define LowspeedRead(_port, _buflen, _buffer, _result) __lowspeedRead(_port, _buflen, _buffer, _result)

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
dseg ends

#define TextOut(_x,_y,_txt) TextOutEx(_x,_y,_txt,0)

#define TextOutEx(_x,_y,_txt,_options) \
  acquire __TextOutMutex \
  mov __TextOutArgs.Location.X,_x \
  mov __TextOutArgs.Location.Y,_y \
  mov __TextOutArgs.Options,_options \
  mov __TextOutArgs.Text,_txt \
  syscall DrawText,__TextOutArgs \
  release __TextOutMutex

dseg segment
  __NumOutMutex mutex
  __NumOutArgs TDrawText
dseg ends

#define NumOut(_x,_y,_num) NumOutEx(_x,_y,_num,0)

#define NumOutEx(_x,_y,_num,_options) \
  acquire __NumOutMutex \
  mov __NumOutArgs.Location.X,_x \
  mov __NumOutArgs.Location.Y,_y \
  mov __NumOutArgs.Options,_options \
  numtostr __NumOutArgs.Text,_num \
  syscall DrawText,__NumOutArgs \
  release __NumOutMutex

dseg segment
  __PointOutArgs TDrawPoint
  __PointOutMutex mutex
dseg ends

#define PointOut(_x,_y) PointOutEx(_x,_y,0)

#define PointOutEx(_x,_y,_options) \
  acquire __PointOutMutex \
  mov __PointOutArgs.Location.X,_x \
  mov __PointOutArgs.Location.Y,_y \
  mov __PointOutArgs.Options,_options \
  syscall DrawPoint,__PointOutArgs \
  release __PointOutMutex

#define ClearScreen() PointOutEx(200, 200, 1)

dseg segment
  __LineOutArgs TDrawLine
  __LineOutMutex mutex
dseg ends

#define LineOut(_x1,_y1,_x2,_y2) LineOutEx(_x1,_y1,_x2,_y2,0)

#define LineOutEx(_x1,_y1,_x2,_y2,_options) \
  acquire __LineOutMutex \
  mov __LineOutArgs.StartLoc.X,_x1 \
  mov __LineOutArgs.StartLoc.Y,_y1 \
  mov __LineOutArgs.EndLoc.X,_x2 \
  mov __LineOutArgs.EndLoc.Y,_y2 \
  mov __LineOutArgs.Options,_options \
  syscall DrawLine,__LineOutArgs \
  release __LineOutMutex

dseg segment
  __RectOutArgs TDrawRect
  __RectOutMutex mutex
dseg ends

#define RectOut(_x,_y,_w,_h) RectOutEx(_x,_y,_w,_h,0)

#define RectOutEx(_x,_y,_w,_h,_options) \
  acquire __RectOutMutex \
  mov __RectOutArgs.Location.X,_x \
  mov __RectOutArgs.Location.Y,_y \
  mov __RectOutArgs.Size.Width,_w \
  mov __RectOutArgs.Size.Height,_h \
  mov __RectOutArgs.Options,_options \
  syscall DrawRect,__RectOutArgs \
  release __RectOutMutex

dseg segment
  __CircleOutArgs TDrawCircle
  __CircleOutMutex mutex
dseg ends

#define CircleOut(_x,_y,_r) CircleOutEx(_x,_y,_r,0)

#define CircleOutEx(_x,_y,_r,_options) \
  acquire __CircleOutMutex \
  mov __CircleOutArgs.Center.X,_x \
  mov __CircleOutArgs.Center.Y,_y \
  mov __CircleOutArgs.Size,_r \
  mov __CircleOutArgs.Options,_options \
  syscall DrawCircle,__CircleOutArgs \
  release __CircleOutMutex

dseg segment
  __GraphicOutArgs TDrawGraphic
  __GraphicOutMutex mutex
  __GraphicOutEmptyVars sdword[]
dseg ends

#define GraphicOut(_x,_y,_file) GraphicOutEx(_x,_y,_file,__GraphicOutEmptyVars,0)

#define GraphicOutEx(_x,_y,_file,_vars,_options) \
  acquire __GraphicOutMutex \
  mov __GraphicOutArgs.Location.X,_x \
  mov __GraphicOutArgs.Location.Y,_y \
  mov __GraphicOutArgs.Filename,_file \
  mov __GraphicOutArgs.Variables,_vars \
  mov __GraphicOutArgs.Options,_options \
  syscall DrawGraphic,__GraphicOutArgs \
  release __GraphicOutMutex

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)

dseg segment
  __GraphicArrayOutArgs TDrawGraphicArray
dseg ends

#define GraphicArrayOut(_x,_y,_data) GraphicArrayOutEx(_x,_y,_data,__GraphicOutEmptyVars,0)

#define GraphicArrayOutEx(_x,_y,_data,_vars,_options) \
  acquire __GraphicOutMutex \
  mov __GraphicArrayOutArgs.Location.X,_x \
  mov __GraphicArrayOutArgs.Location.Y,_y \
  mov __GraphicArrayOutArgs.Data,_data \
  mov __GraphicArrayOutArgs.Variables,_vars \
  mov __GraphicArrayOutArgs.Options,_options \
  syscall DrawGraphicArray,__GraphicArrayOutArgs \
  release __GraphicOutMutex

dseg segment
  __PolyOutArgs TDrawPolygon
  __PolyOutMutex mutex
dseg ends

#define PolyOut(_points) PolyOutEx(_points,0)

#define PolyOutEx(_points,_options) \
  acquire __PolyOutMutex \
  mov __PolyOutArgs.Points,_points \
  mov __PolyOutArgs.Options,_options \
  syscall DrawPolygon,__PolyOutArgs \
  release __PolyOutMutex

dseg segment
  __EllipseOutArgs TDrawEllipse
  __EllipseOutMutex mutex
dseg ends

#define EllipseOut(_x,_y,_rX,_rY) EllipseOutEx(_x,_y,_rX,_rY,0)

#define EllipseOutEx(_x,_y,_rX,_rY,_options) \
  acquire __EllipseOutMutex \
  mov __EllipseOutArgs.Center.X,_x \
  mov __EllipseOutArgs.Center.Y,_y \
  mov __EllipseOutArgs.SizeX,_rX \
  mov __EllipseOutArgs.SizeY,_rY \
  mov __EllipseOutArgs.Options,_options \
  syscall DrawEllipse,__EllipseOutArgs \
  release __EllipseOutMutex

dseg segment
  __FontOutMutex mutex
  __FontOutArgs TDrawFont
dseg ends

#define FontTextOut(_x,_y,_fnt,_txt) FontTextOutEx(_x,_y,_fnt,_txt,0)

#define FontTextOutEx(_x,_y,_fnt,_txt,_options) \
  acquire __FontOutMutex \
  mov __FontOutArgs.Location.X,_x \
  mov __FontOutArgs.Location.Y,_y \
  mov __FontOutArgs.Options,_options \
  mov __FontOutArgs.Filename,_fnt \
  mov __FontOutArgs.Text,_txt \
  syscall DrawFont,__FontOutArgs \
  release __FontOutMutex

#define FontNumOut(_x,_y,_fnt,_num) FontNumOutEx(_x,_y,_fnt,_num,0)

#define FontNumOutEx(_x,_y,_fnt,_num,_options) \
  acquire __FontOutMutex \
  mov __FontOutArgs.Location.X,_x \
  mov __FontOutArgs.Location.Y,_y \
  mov __FontOutArgs.Options,_options \
  mov __FontOutArgs.Filename,_fnt \
  numtostr __FontOutArgs.Text,_num \
  syscall DrawFont,__FontOutArgs \
  release __FontOutMutex

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

#define ReadSensorColorRaw(_port, _rawVals, _result) __ReadSensorColorRaw(_port, _rawVals, _result)
#define ReadSensorColorEx(_port, _colorval, _rawVals, _normVals, _scaledVals, _result) __ReadSensorColorEx(_port, _colorval, _rawVals, _normVals, _scaledVals, _result)

#endif

; generic I2C read routine

#define ReadI2CBytes(_port, _inbuf, _count, _outbuf, _result) \
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

; US Sensor read routine

dseg segment
  __RLSBbufLSWrite1 byte[] 0x02, 0x42
dseg ends

#define ReadSensorUS(_port, _value) \
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

#define ReadSensorUSEx(_port, _values, _result) __ReadSensorUSEx(_port, _values, _result)

#define ReadI2CRegister(_port, _reg, _out, _result) __MSReadValue(_port, 0x02, _reg, 1, _out, _result)
#define WriteI2CRegister(_port, _reg, _val, _result) __MSWriteToRegister(_port, 0x02, _reg, _val, _result)

subroutine __ReadLSBytes0
  dseg segment
    __RLSBmutex0 mutex
    __RLSLastGoodRead0 byte[] 0x00
    __RLSBResult0 sbyte
    __RLSBytesCount0 byte
    __RLSBIterations0 byte
    __RLSReadBuf0 byte[]
  dseg ends
  LowspeedWrite(0, __RLSBytesCount0, __RLSReadBuf0, __RLSBResult0)
  brtst EQ, __RLSBReturn0, __RLSBytesCount0 ; terminate if zero bytes to read
  arrinit __RLSReadBuf0, 0, __RLSBytesCount0
  brtst NEQ, __RLSBError0, __RLSBResult0 ; terminate if not NO_ERR
  set __RLSBIterations0, 4
__RLSBDoCheckStatus0:
  LowspeedStatus(0, __RLSBytesCount0, __RLSBResult0)
  sub __RLSBIterations0, __RLSBIterations0, 1
  brtst LTEQ, __RLSBError0, __RLSBIterations0
  brtst LT, __RLSBError0, __RLSBResult0 ; negative results are absolute errors
  brtst EQ, __RLSBReadyToRead0, __RLSBResult0
  ; if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatus0
__RLSBReadyToRead0:
  ; Try reading now
  LowspeedRead(0, __RLSBytesCount0, __RLSReadBuf0, __RLSBResult0)
  brtst NEQ, __RLSBError0, __RLSBResult0 ; terminate if not NO_ERR
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
  LowspeedWrite(1, __RLSBytesCount1, __RLSReadBuf1, __RLSBResult1)
  brtst EQ, __RLSBReturn1, __RLSBytesCount1 ; terminate if zero bytes to read
  arrinit __RLSReadBuf1, 0, __RLSBytesCount1
  brtst NEQ, __RLSBError1, __RLSBResult1 ; terminate if not NO_ERR
  set __RLSBIterations1, 4
__RLSBDoCheckStatus1:
  LowspeedStatus(1, __RLSBytesCount1, __RLSBResult1)
  sub __RLSBIterations1, __RLSBIterations1, 1
  brtst LTEQ, __RLSBError1, __RLSBIterations1
  brtst LT, __RLSBError1, __RLSBResult1 ; negative results are absolute errors
  brtst EQ, __RLSBReadyToRead1, __RLSBResult1
  ; if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatus1
__RLSBReadyToRead1:
  ; Try reading now
  LowspeedRead(1, __RLSBytesCount1, __RLSReadBuf1, __RLSBResult1)
  brtst NEQ, __RLSBError1, __RLSBResult1 ; terminate if not NO_ERR
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
  LowspeedWrite(2, __RLSBytesCount2, __RLSReadBuf2, __RLSBResult2)
  brtst EQ, __RLSBReturn2, __RLSBytesCount2 ; terminate if zero bytes to read
  arrinit __RLSReadBuf2, 0, __RLSBytesCount2
  brtst NEQ, __RLSBError2, __RLSBResult2 ; terminate if not NO_ERR
  set __RLSBIterations2, 4
__RLSBDoCheckStatus2:
  LowspeedStatus(2, __RLSBytesCount2, __RLSBResult2)
  sub __RLSBIterations2, __RLSBIterations2, 1
  brtst LTEQ, __RLSBError2, __RLSBIterations2
  brtst LT, __RLSBError2, __RLSBResult2 ; negative results are absolute errors
  brtst EQ, __RLSBReadyToRead2, __RLSBResult2
  ; if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatus2
__RLSBReadyToRead2:
  ; Try reading now
  LowspeedRead(2, __RLSBytesCount2, __RLSReadBuf2, __RLSBResult2)
  brtst NEQ, __RLSBError2, __RLSBResult2 ; terminate if not NO_ERR
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
  LowspeedWrite(3, __RLSBytesCount3, __RLSReadBuf3, __RLSBResult3)
  brtst EQ, __RLSBReturn3, __RLSBytesCount3 ; terminate if zero bytes to read
  arrinit __RLSReadBuf3, 0, __RLSBytesCount3
  brtst NEQ, __RLSBError3, __RLSBResult3 ; terminate if not NO_ERR
  set __RLSBIterations3, 4
__RLSBDoCheckStatus3:
  LowspeedStatus(3, __RLSBytesCount3, __RLSBResult3)
  sub __RLSBIterations3, __RLSBIterations3, 1
  brtst LTEQ, __RLSBError3, __RLSBIterations3
  brtst LT, __RLSBError3, __RLSBResult3 ; negative results are absolute errors
  brtst EQ, __RLSBReadyToRead3, __RLSBResult3
  ; if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatus3
__RLSBReadyToRead3:
  ; Try reading now
  LowspeedRead(3, __RLSBytesCount3, __RLSReadBuf3, __RLSBResult3)
  brtst NEQ, __RLSBError3, __RLSBResult3 ; terminate if not NO_ERR
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
  LowspeedWrite(__RLSReadPort, __RLSBytesCountVar, __RLSReadBufVar, __RLSBResultVar)
  brtst EQ, __RLSBReturnVar, __RLSBytesCountVar ; terminate if zero bytes to read
  arrinit __RLSReadBufVar, 0, __RLSBytesCountVar
  brtst NEQ, __RLSBErrorVar, __RLSBResultVar ; terminate if not NO_ERR
  set __RLSBIterationsVar, 4
__RLSBDoCheckStatusVar:
  LowspeedStatus(__RLSReadPort, __RLSBytesCountVar, __RLSBResultVar)
  sub __RLSBIterationsVar, __RLSBIterationsVar, 1
  brtst LTEQ, __RLSBErrorVar, __RLSBIterationsVar
  brtst LT, __RLSBErrorVar, __RLSBResultVar ; negative results are absolute errors
  brtst EQ, __RLSBReadyToReadVar, __RLSBResultVar
  ; if STAT_COMM_PENDING then wait a bit and then try again (up to 4 times)
  wait 15
  jmp __RLSBDoCheckStatusVar
__RLSBReadyToReadVar:
  ; Try reading now
  LowspeedRead(__RLSReadPort, __RLSBytesCountVar, __RLSReadBufVar, __RLSBResultVar)
  brtst NEQ, __RLSBErrorVar, __RLSBResultVar ; terminate if not NO_ERR
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
dseg ends

#define PlayTone(_freq,_dur) PlayToneEx(_freq,_dur,4,0)
#define PlayFile(_file) PlayFileEx(_file,4,0)

#define PlayToneEx(_freq,_dur,_vol,_loop) \
  acquire __PlayToneMutex \
  mov __PlayToneTmp.Frequency, _freq \
  mov __PlayToneTmp.Duration, _dur \
  mov __PlayToneTmp.Volume, _vol \
  mov __PlayToneTmp.Loop, _loop \
  syscall SoundPlayTone, __PlayToneTmp \
  release __PlayToneMutex

#define PlayFileEx(_file,_vol,_loop) \
  acquire __PlayFileMutex \
  mov __PlayFileTmp.Filename, _file \
  mov __PlayFileTmp.Volume, _vol \
  mov __PlayFileTmp.Loop, _loop \
  syscall SoundPlayFile, __PlayFileTmp \
  release __PlayFileMutex

dseg segment
  __SGSMutex mutex
  __SGSArgs TSoundGetState
  __SSSMutex mutex
  __SSSArgs TSoundSetState
dseg ends

#define GetSoundState(_state, _flags) \
  acquire __SGSMutex \
  syscall SoundGetState, __SGSArgs \
  mov _state, __SGSArgs.State \
  mov _flags, __SGSArgs.Flags \
  release __SGSMutex

#define SetSoundState(_state, _flags, _result) __setSoundState(_state, _flags, _result)

#define __setSoundState(_state, _flags, _result) \
  acquire __SSSMutex \
  mov __SSSArgs.State, _state \
  mov __SSSArgs.Flags, _flags \
  syscall SoundSetState, __SSSArgs \
  mov _result, __SSSArgs.Result \
  release __SSSMutex

dseg segment
  __RandomTmp dword
  __RandomArgs TRandomNumber
  __RandomMutex mutex
dseg ends

#define Random(_arg,_max) \
  acquire __RandomMutex \
  syscall RandomNumber, __RandomArgs \
  mov __RandomTmp, __RandomArgs.Result \
  add __RandomTmp, __RandomTmp, 32768 \
  mul __RandomTmp, __RandomTmp, _max \
  div __RandomTmp, __RandomTmp, 65536 \
  mov _arg, __RandomTmp \
  release __RandomMutex

#define SignedRandom(_arg) \
  acquire __RandomMutex \
  syscall RandomNumber, __RandomArgs \
  mov _arg, __RandomArgs.Result \
  release __RandomMutex


dseg segment
   __KeepAliveArgs TKeepAlive
   __KeepAliveMutex mutex
dseg ends

#define ResetSleepTimer syscall KeepAlive, __KeepAliveArgs

dseg segment
  __GSTArgs TGetStartTick
  __GSTMutex mutex
dseg ends

#define GetFirstTick(_value) \
  compchk EQ, sizeof(_value), 4 \
  acquire __GSTMutex \
  syscall GetStartTick, __GSTArgs \
  mov _value, __GSTArgs.Result \
  release __GSTMutex

dseg segment
  __RBtnMutex mutex
  __RBtnArgs TReadButton
dseg ends

#define ReadButtonEx(_idx, _reset, _pressed, _count, _result) \
  acquire __RBtnMutex \
  mov __RBtnArgs.Index, _idx \
  mov __RBtnArgs.Reset, _reset \
  syscall ReadButton, __RBtnArgs \
  mov _pressed, __RBtnArgs.Pressed \
  mov _count, __RBtnArgs.Count \
  mov _result, __RBtnArgs.Result \
  release __RBtnMutex

dseg segment
  __IOMRMutex mutex
  __IOMRArgs TIOMapRead
  __IOMRUnflattenErr byte
  __IOMRUnflattenBuf byte[]
dseg ends

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

#define GetIOMapBytes(_modName, _offset, _cnt, _arrOut) __getIOMapBytes(_modName, _offset, _cnt, _arrOut)
#define GetIOMapValue(_modName, _offset, _n) __getIOMapValue(_modName, _offset, _n)

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

#define GetIOMapBytesByID(_modID, _offset, _cnt, _arrOut) __getIOMapBytesByID(_modID, _offset, _cnt, _arrOut)
#define GetIOMapValueByID(_modID, _offset, _n) __getIOMapValueByID(_modID, _offset, _n)

#define GetCommandModuleValue(_offset, _n) GetIOMapValueByID(CommandModuleID, _offset, _n)
#define GetLoaderModuleValue(_offset, _n) GetIOMapValueByID(LoaderModuleID, _offset, _n)
#define GetSoundModuleValue(_offset, _n) GetIOMapValueByID(SoundModuleID, _offset, _n)
#define GetButtonModuleValue(_offset, _n) GetIOMapValueByID(ButtonModuleID, _offset, _n)
#define GetUIModuleValue(_offset, _n) GetIOMapValueByID(UIModuleID, _offset, _n)
#define GetInputModuleValue(_offset, _n) GetIOMapValueByID(InputModuleID, _offset, _n)
#define GetOutputModuleValue(_offset, _n) GetIOMapValueByID(OutputModuleID, _offset, _n)
#define GetLowSpeedModuleValue(_offset, _n) GetIOMapValueByID(LowSpeedModuleID, _offset, _n)
#define GetDisplayModuleValue(_offset, _n) GetIOMapValueByID(DisplayModuleID, _offset, _n)
#define GetCommModuleValue(_offset, _n) GetIOMapValueByID(CommModuleID, _offset, _n)

#define __getLowSpeedModuleBytes(_offset, _cnt, _arrOut) GetIOMapBytesByID(LowSpeedModuleID, _offset, _cnt, _arrOut)
#define __getDisplayModuleBytes(_offset, _cnt, _arrOut) GetIOMapBytesByID(DisplayModuleID, _offset, _cnt, _arrOut)
#define __getCommModuleBytes(_offset, _cnt, _arrOut) GetIOMapBytesByID(CommModuleID, _offset, _cnt, _arrOut)

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

#define __getLowSpeedModuleBytes(_offset, _cnt, _arrOut) GetIOMapBytes(LowSpeedModuleName, _offset, _cnt, _arrOut)
#define __getDisplayModuleBytes(_offset, _cnt, _arrOut) GetIOMapBytes(DisplayModuleID, _offset, _cnt, _arrOut)
#define __getCommModuleBytes(_offset, _cnt, _arrOut) GetIOMapBytes(CommModuleID, _offset, _cnt, _arrOut)

#endif

#define GetLowSpeedModuleBytes(_offset, _cnt, _arrOut) __getLowSpeedModuleBytes(_offset, _cnt, _arrOut)
#define GetDisplayModuleBytes(_offset, _cnt, _arrOut) __getDisplayModuleBytes(_offset, _cnt, _arrOut)
#define GetCommModuleBytes(_offset, _cnt, _arrOut) __getCommModuleBytes(_offset, _cnt, _arrOut)

#define GetFreeMemory(_value) \
  compchk EQ, sizeof(_value), 4 \
  GetLoaderModuleValue(LoaderOffsetFreeUserFlash, _value)

#define GetSoundFrequency(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetSoundModuleValue(SoundOffsetFreq, _n)

#define GetSoundDuration(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetSoundModuleValue(SoundOffsetDuration, _n)

#define GetSoundSampleRate(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetSoundModuleValue(SoundOffsetSampleRate, _n)

#define GetSoundMode(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetSoundModuleValue(SoundOffsetMode, _n)

#define GetSoundVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetSoundModuleValue(SoundOffsetVolume, _n)

dseg segment
  __btnModuleOffsetMutex mutex
  __btnModuleOffset word
dseg ends

#define GetButtonPressCount(_b, _n) \
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

#define GetButtonLongPressCount(_b, _n) \
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

#define GetButtonShortReleaseCount(_b, _n) \
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

#define GetButtonLongReleaseCount(_b, _n) \
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

#define GetButtonReleaseCount(_b, _n) \
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

#define GetButtonState(_b, _n) \
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

#define GetBatteryLevel(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetUIModuleValue(UIOffsetBatteryVoltage, _n)

#define GetCommandFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetFlags, _n)

#define GetUIState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetState, _n)

#define GetUIButton(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetButton, _n)

#define GetVMRunState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetRunState, _n)

#define GetBatteryState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetBatteryState, _n)

#define GetBluetoothState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetBluetoothState, _n)

#define GetUsbState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetUsbState, _n)

#define GetSleepTimeout(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetSleepTimeout, _n)

#define GetSleepTimer(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetSleepTimer, _n)

#define GetRechargeableBattery(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetRechargeable, _n)

#define GetVolume(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetVolume, _n)

#define GetOnBrickProgramPointer(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetOBPPointer, _n)

#define GetAbortFlag(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetUIModuleValue(UIOffsetAbortFlag, _n)

dseg segment
  __inputModuleOffsetMutex mutex
  __inputModuleOffset word
dseg ends

#define GetInCustomZeroOffset(_p, _n) \
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

#define GetInSensorBoolean(_p, _n) \
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

#define GetInDigiPinsDirection(_p, _n) \
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

#define GetInDigiPinsStatus(_p, _n) \
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

#define GetInDigiPinsOutputLevel(_p, _n) \
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

#define GetInCustomPercentFullScale(_p, _n) \
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

#define GetInCustomActiveStatus(_p, _n) \
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

#define GetInColorCalibration(_p, _np, _nc, _n) \
  compchk EQ, sizeof(_n), 4 \
  compchk EQ, isconst(_p), TRUE \
  compchk EQ, isconst(_np), TRUE \
  compchk EQ, isconst(_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _np, INPUT_NO_OF_POINTS \
  compchk GTEQ, _np, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorCalibration(_p, _np, _nc), _n)

#define GetInColorCalLimits(_p, _np, _n) \
  compchk EQ, sizeof(_n), 2 \
  compchk EQ, isconst(_p), TRUE \
  compchk EQ, isconst(_np), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _np, 0x02 \
  compchk GTEQ, _np, 0x00 \
  GetInputModuleValue(InputOffsetColorCalLimits(_p, _np), _n)

#define GetInColorADRaw(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 2 \
  compchk EQ, isconst(_p), TRUE \
  compchk EQ, isconst(_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorADRaw(_p, _nc), _n)

#define GetInColorSensorRaw(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 2 \
  compchk EQ, isconst(_p), TRUE \
  compchk EQ, isconst(_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorSensorRaw(_p, _nc), _n)

#define GetInColorSensorValue(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 2 \
  compchk EQ, isconst(_p), TRUE \
  compchk EQ, isconst(_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorSensorValue(_p, _nc), _n)

#define GetInColorBoolean(_p, _nc, _n) \
  compchk EQ, sizeof(_n), 1 \
  compchk EQ, isconst(_p), TRUE \
  compchk EQ, isconst(_nc), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  compchk LT, _nc, INPUT_NO_OF_COLORS \
  compchk GTEQ, _nc, 0x00 \
  GetInputModuleValue(InputOffsetColorBoolean(_p, _nc), _n)

#define GetInColorCalibrationState(_p, _n) \
  compchk EQ, sizeof(_n), 1 \
  compchk EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetInputModuleValue(InputOffsetColorCalibrationState(_p), _n)

#endif

#define GetOutPwnFreq(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetOutputModuleValue(OutputOffsetPwnFreq, _n)

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

#define GetLSInputBuffer(_p, _offset, _cnt, _data) __getLSInputBuffer(_p, _offset, _cnt, _data)

#define GetLSInputBufferInPtr(_p, _n) \
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

#define GetLSInputBufferOutPtr(_p, _n) \
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

#define GetLSInputBufferBytesToRx(_p, _n) \
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

#define GetLSOutputBuffer(_p, _offset, _cnt, _data) __getLSOutputBuffer(_p, _offset, _cnt, _data)

#define GetLSOutputBufferInPtr(_p, _n) \
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

#define GetLSOutputBufferOutPtr(_p, _n) \
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

#define GetLSOutputBufferBytesToRx(_p, _n) \
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

#define GetLSMode(_p, _n) \
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

#define GetLSChannelState(_p, _n) \
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

#define GetLSErrorType(_p, _n) \
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

#define GetLSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetLowSpeedModuleValue(LowSpeedOffsetState, _n)

#define GetLSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetLowSpeedModuleValue(LowSpeedOffsetSpeed, _n)

#ifdef __ENHANCED_FIRMWARE
#define GetLSNoRestartOnRead(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetLowSpeedModuleValue(LowSpeedOffsetNoRestartOnRead, _n)
#endif

#define GetDisplayEraseMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  GetDisplayModuleValue(DisplayOffsetEraseMask, _n)

#define GetDisplayUpdateMask(_n) \
  compchk EQ, sizeof(_n), 4 \
  GetDisplayModuleValue(DisplayOffsetUpdateMask, _n)

#define GetDisplayDisplay(_n) \
  compchk EQ, sizeof(_n), 4 \
  GetDisplayModuleValue(DisplayOffsetDisplay, _n)

#define GetDisplayFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetDisplayModuleValue(DisplayOffsetFlags, _n)

#define GetDisplayTextLinesCenterFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetDisplayModuleValue(DisplayOffsetTextLinesCenterFlags, _n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define GetDisplayContrast(_n) \
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

#define GetDisplayNormal(_x, _line, _cnt, _data) __getDisplayNormal(_x, _line, _cnt, _data)

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

#define GetDisplayPopup(_x, _line, _cnt, _data) __getDisplayPopup(_x, _line, _cnt, _data)

dseg segment
  __commModuleOffsetMutex mutex
  __commModuleOffset word
dseg ends

#define GetBTDeviceName(_p, _str) \
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

#define GetBTDeviceClass(_p, _n) \
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

#define __getBTDeviceAddress(_p, _addr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleBytes(CommOffsetBtDeviceTableBdAddr(_p), 7, _addr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 28 \
  GetCommModuleBytes(__commModuleOffset, 7, _addr) \
  release __commModuleOffsetMutex \
  compend

#define GetBTDeviceAddress(_p, _addr) __getBTDeviceAddress(_p, _addr)

#define GetBTDeviceStatus(_p, _n) \
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

#define GetBTConnectionName(_p, _str) \
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

#define GetBTConnectionClass(_p, _n) \
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

#define GetBTConnectionPinCode(_p, _code) \
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

#define __getBTConnectionAddress(_p, _addr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  GetCommModuleBytes(CommOffsetBtConnectTableBdAddr(_p), 7, _addr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 974 \
  GetCommModuleBytes(__commModuleOffset, 7, _addr) \
  release __commModuleOffsetMutex \
  compend

#define GetBTConnectionAddress(_p, _addr) __getBTConnectionAddress(_p, _addr)

#define GetBTConnectionHandleNum(_p, _n) \
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

#define GetBTConnectionStreamStatus(_p, _n) \
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

#define GetBTConnectionLinkQuality(_p, _n) \
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

#define GetBrickDataName(_str) \
  GetCommModuleBytes(CommOffsetBrickDataName, 16, _str)

#define GetBrickDataBluecoreVersion(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetCommModuleValue(CommOffsetBrickDataBluecoreVersion, _n)

#define GetBrickDataAddress(_addr) \
  GetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _addr)

#define GetBrickDataBtStateStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBrickDataBtStateStatus, _n)

#define GetBrickDataBtHardwareStatus(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBrickDataBtHwStatus, _n)

#define GetBrickDataTimeoutValue(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBrickDataTimeOutValue, _n)

#define __getBTInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetBtInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtInBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define GetBTInputBuffer(_offset, _cnt, _data) __getBTInputBuffer(_offset, _cnt, _data)

#define GetBTInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtInBufInPtr, _n)

#define GetBTInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtInBufOutPtr, _n)

#define __getBTOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetBtOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtOutBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define GetBTOutputBuffer(_offset, _cnt, _data) __getBTOutputBuffer(_offset, _cnt, _data)

#define GetBTOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtOutBufInPtr, _n)

#define GetBTOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtOutBufOutPtr, _n)

#define __getHSInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetHsInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsInBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define GetHSInputBuffer(_offset, _cnt, _data) __getHSInputBuffer(_offset, _cnt, _data)

#define GetHSInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsInBufInPtr, _n)

#define GetHSInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsInBufOutPtr, _n)

#define __getHSOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetHsOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsOutBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define GetHSOutputBuffer(_offset, _cnt, _data) __getHSOutputBuffer(_offset, _cnt, _data)

#define GetHSOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsOutBufInPtr, _n)

#define GetHSOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsOutBufOutPtr, _n)

#define __getUSBInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetUsbInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbInBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define GetUSBInputBuffer(_offset, _cnt, _data) __getUSBInputBuffer(_offset, _cnt, _data)

#define GetUSBInputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbInBufInPtr, _n)

#define GetUSBInputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbInBufOutPtr, _n)

#define __getUSBOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetUsbOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbOutBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define GetUSBOutputBuffer(_offset, _cnt, _data) __getUSBOutputBuffer(_offset, _cnt, _data)

#define GetUSBOutputBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbOutBufInPtr, _n)

#define GetUSBOutputBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbOutBufOutPtr, _n)

#define __getUSBPollBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  GetCommModuleBytes(CommOffsetUsbPollBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbPollBufBuf \
  GetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define GetUSBPollBuffer(_offset, _cnt, _data) __getUSBPollBuffer(_offset, _cnt, _data)

#define GetUSBPollBufferInPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbPollBufInPtr, _n)

#define GetUSBPollBufferOutPtr(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbPollBufOutPtr, _n)

#define GetBTDeviceCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtDeviceCnt, _n)

#define GetBTDeviceNameCount(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetBtDeviceNameCnt, _n)

#define GetHSFlags(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsFlags, _n)

#define GetHSSpeed(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsSpeed, _n)

#define GetHSState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetHsState, _n)

#define GetUSBState(_n) \
  compchk EQ, sizeof(_n), 1 \
  GetCommModuleValue(CommOffsetUsbState, _n)

#define GetHSMode(_n) \
  compchk EQ, sizeof(_n), 2 \
  GetCommModuleValue(CommOffsetHsMode, _n)

dseg segment
  __IOMWArgs TIOMapWrite
  __IOMWMutex mutex
  __IOMWFlattenBuf byte[]
dseg ends

#define SetIOMapBytes(_modName, _offset, _cnt, _arrIn) \
  acquire __IOMWMutex \
  mov __IOMWArgs.ModuleName, _modName \
  mov __IOMWArgs.Offset, _offset \
  arrsubset __IOMWArgs.Buffer, _arrIn, NA, _cnt \
  syscall IOMapWrite, __IOMWArgs \
  release __IOMWMutex

#define SetIOMapValue(_modName, _offset, _n) \
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

#define SetIOMapBytesByID(_modID, _offset, _cnt, _arrIn) \
  acquire __IOMWMutex \
  mov __IOMWBIArgs.ModuleID, _modID \
  mov __IOMWBIArgs.Offset, _offset \
  arrsubset __IOMWBIArgs.Buffer, _arrIn, NA, _cnt \
  syscall IOMapWriteByID, __IOMWBIArgs \
  release __IOMWMutex

#define SetIOMapValueByID(_modID, _offset, _n) \
  acquire __IOMWMutex \
  mov __IOMWBIArgs.ModuleID, _modID \
  mov __IOMWBIArgs.Offset, _offset \
  flatten __IOMWFlattenBuf, _n \
  strtoarr __IOMWBIArgs.Buffer, __IOMWFlattenBuf \
  syscall IOMapWriteByID, __IOMWBIArgs \
  release __IOMWMutex

#define SetCommandModuleValue(_offset, _n) SetIOMapValueByID(CommandModuleID, _offset, _n)
#define SetIOCtrlModuleValue(_offset, _n) SetIOMapValueByID(IOCtrlModuleID, _offset, _n)
#define SetLoaderModuleValue(_offset, _n) SetIOMapValueByID(LoaderModuleID, _offset, _n)
#define SetUIModuleValue(_offset, _n) SetIOMapValueByID(UIModuleID, _offset, _n)
#define SetSoundModuleValue(_offset, _n) SetIOMapValueByID(SoundModuleID, _offset, _n)
#define SetButtonModuleValue(_offset, _n) SetIOMapValueByID(ButtonModuleID, _offset, _n)
#define SetInputModuleValue(_offset, _n) SetIOMapValueByID(InputModuleID, _offset, _n)
#define SetOutputModuleValue(_offset, _n) SetIOMapValueByID(OutputModuleID, _offset, _n)
#define SetLowSpeedModuleValue(_offset, _n) SetIOMapValueByID(LowSpeedModuleID, _offset, _n)
#define SetDisplayModuleValue(_offset, _n) SetIOMapValueByID(DisplayModuleID, _offset, _n)
#define SetCommModuleValue(_offset, _n) SetIOMapValueByID(CommModuleID, _offset, _n)

#define SetCommandModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(CommandModuleID, _offset, _cnt, _arrIn)
#define SetLowSpeedModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(LowSpeedModuleID, _offset, _cnt, _arrIn)
#define SetDisplayModuleBytes(_offset, _cnt, _arrIn) SetIOMapBytesByID(DisplayModuleID, _offset, _cnt, _arrIn)
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


#define PowerDown SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_POWERDOWN)
#define RebootInFirmwareMode SetIOCtrlModuleValue(IOCtrlOffsetPowerOn, IOCTRL_BOOT)

#define SetSoundFrequency(_n) __setSoundFrequency(_n)
#define SetSoundDuration(_n) __setSoundDuration(_n)
#define SetSoundSampleRate(_n) __setSoundSampleRate(_n)
#define SetSoundFlags(_n) __setSoundFlags(_n)
#define SetSoundModuleState(_n) __setSoundModuleState(_n)
#define SetSoundMode(_n) __setSoundMode(_n)
#define SetSoundVolume(_n) __setSoundVolume(_n)

#define SetButtonPressCount(_b, _n) __setButtonPressCount(_b, _n)
#define SetButtonLongPressCount(_b, _n) __setButtonLongPressCount(_b, _n)
#define SetButtonShortReleaseCount(_b, _n) __setButtonShortReleaseCount(_b, _n)
#define SetButtonLongReleaseCount(_b, _n) __setButtonLongReleaseCount(_b, _n)
#define SetButtonReleaseCount(_b, _n) __setButtonReleaseCount(_b, _n)
#define SetButtonState(_b, _n) __setButtonState(_b, _n)

#define SetCommandFlags(_n) __setCommandFlags(_n)
#define SetUIState(_n) __setUIState(_n)
#define SetUIButton(_n) __setUIButton(_n)
#define SetVMRunState(_n) __setVMRunState(_n)
#define SetBatteryState(_n) __setBatteryState(_n)
#define SetBluetoothState(_n) __setBluetoothState(_n)
#define SetUsbState(_n) __setUsbState(_n)
#define SetSleepTimeout(_n) __setSleepTimeout(_n)
#define SetSleepTimer(_n) __setSleepTimer(_n)
#define SetVolume(_n) __setVolume(_n)
#define SetOnBrickProgramPointer(_n) __setOnBrickProgramPointer(_n)
#define ForceOff(_n) __forceOff(_n)
#define SetAbortFlag(_n) __setAbortFlag(_n)

#define SetInCustomZeroOffset(_p, _n) __setInCustomZeroOffset(_p, _n)
#define SetInSensorBoolean(_p, _n) __setInSensorBoolean(_p, _n)
#define SetInDigiPinsDirection(_p, _n) __setInDigiPinsDirection(_p, _n)
#define SetInDigiPinsStatus(_p, _n) __setInDigiPinsStatus(_p, _n)
#define SetInDigiPinsOutputLevel(_p, _n) __setInDigiPinsOutputLevel(_p, _n)
#define SetInCustomPercentFullScale(_p, _n) __setInCustomPercentFullScale(_p, _n)
#define SetInCustomActiveStatus(_p, _n) __setInCustomActiveStatus(_p, _n)

#define SetOutPwnFreq(_n) __setOutPwnFreq(_n)

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

#define SetLSInputBuffer(_p, _offset, _cnt, _data) __setLSInputBuffer(_p, _offset, _cnt, _data)

#define SetLSInputBufferInPtr(_p, _n) __setLSInputBufferInPtr(_p, _n)
#define SetLSInputBufferOutPtr(_p, _n) __setLSInputBufferOutPtr(_p, _n)
#define SetLSInputBufferBytesToRx(_p, _n) __setLSInputBufferBytesToRx(_p, _n)

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

#define SpawnProgram(_fname) __spawnProgram(_fname)


#define SetDisplayEraseMask(_n) __setDisplayEraseMask(_n)
#define SetDisplayUpdateMask(_n) __setDisplayUpdateMask(_n)
#define SetDisplayDisplay(_n) __setDisplayDisplay(_n)
#define SetDisplayFlags(_n) __setDisplayFlags(_n)
#define SetDisplayTextLinesCenterFlags(_n) __setDisplayTextLinesCenterFlags(_n)

#if defined(__ENHANCED_FIRMWARE) && (__FIRMWARE_VERSION > 107)
#define SetDisplayContrast(_n) __setDisplayContrast(_n)
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

#define SetDisplayNormal(_x, _line, _cnt, _data) __setDisplayNormal(_x, _line, _cnt, _data)

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

#define SetDisplayPopup(_x, _line, _cnt, _data) __setDisplayPopup(_x, _line, _cnt, _data)

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

#define SetBTDeviceName(_p, _str) __setBTDeviceName(_p, _str)

#define __setBTDeviceAddress(_p, _addr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtDeviceTableBdAddr(_p), 7, _addr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 31 \
  add __commModuleOffset, __commModuleOffset, 28 \
  SetCommModuleBytes(__commModuleOffset, 7, _addr) \
  release __commModuleOffsetMutex \
  compend

#define SetBTDeviceAddress(_p, _addr) __setBTDeviceAddress(_p, _addr)

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

#define SetBTConnectionName(_p, _str) __setBTConnectionName(_p, _str)

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

#define SetBTConnectionPinCode(_p, _code) __setBTConnectionPinCode(_p, _code)

#define __setBTConnectionAddress(_p, _addr) \
  compif EQ, isconst(_p), TRUE \
  compchk LT, _p, 0x04 \
  compchk GTEQ, _p, 0x00 \
  SetCommModuleBytes(CommOffsetBtConnectTableBdAddr(_p), 7, _addr) \
  compelse \
  acquire __commModuleOffsetMutex \
  mul __commModuleOffset, _p, 47 \
  add __commModuleOffset, __commModuleOffset, 974 \
  SetCommModuleBytes(__commModuleOffset, 7, _addr) \
  release __commModuleOffsetMutex \
  compend

#define SetBTConnectionAddress(_p, _addr) __setBTConnectionAddress(_p, _addr)

#define SetBrickDataName(_str) \
  SetCommModuleBytes(CommOffsetBrickDataName, 16, _str)

#define SetBrickDataAddress(_addr) \
  SetCommModuleBytes(CommOffsetBrickDataBdAddr, 7, _addr)

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

#define __setBTInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetBtInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtInBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define SetBTInputBuffer(_offset, _cnt, _data) __setBTInputBuffer(_offset, _cnt, _data)

#define SetBTInputBufferInPtr(_n) __setBTInputBufferInPtr(_n)
#define SetBTInputBufferOutPtr(_n) __setBTInputBufferOutPtr(_n)

#define __setBTOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetBtOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetBtOutBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define SetBTOutputBuffer(_offset, _cnt, _data) __setBTOutputBuffer(_offset, _cnt, _data)

#define SetBTOutputBufferInPtr(_n) __setBTOutputBufferInPtr(_n)
#define SetBTOutputBufferOutPtr(_n) __setBTOutputBufferOutPtr(_n)

#define __setHSInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetHsInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsInBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define SetHSInputBuffer(_offset, _cnt, _data) __setHSInputBuffer(_offset, _cnt, _data)

#define SetHSInputBufferInPtr(_n) __setHSInputBufferInPtr(_n)
#define SetHSInputBufferOutPtr(_n) __setHSInputBufferOutPtr(_n)

#define __setHSOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetHsOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetHsOutBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define SetHSOutputBuffer(_offset, _cnt, _data) __setHSOutputBuffer(_offset, _cnt, _data)

#define SetHSOutputBufferInPtr(_n) __setHSOutputBufferInPtr(_n)
#define SetHSOutputBufferOutPtr(_n) __setHSOutputBufferOutPtr(_n)

#define __setUSBInputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetUsbInBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbInBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define SetUSBInputBuffer(_offset, _cnt, _data) __setUSBInputBuffer(_offset, _cnt, _data)

#define SetUSBInputBufferInPtr(_n) __setUSBInputBufferInPtr(_n)
#define SetUSBInputBufferOutPtr(_n) __setUSBInputBufferOutPtr(_n)

#define __setUSBOutputBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetUsbOutBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbOutBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define SetUSBOutputBuffer(_offset, _cnt, _data) __setUSBOutputBuffer(_offset, _cnt, _data)

#define SetUSBOutputBufferInPtr(_n) __setUSBOutputBufferInPtr(_n)
#define SetUSBOutputBufferOutPtr(_n) __setUSBOutputBufferOutPtr(_n)

#define __setUSBPollBuffer(_offset, _cnt, _data) \
  compif EQ, isconst(_offset), TRUE \
  SetCommModuleBytes(CommOffsetUsbPollBufBuf+_offset, _cnt, _data) \
  compelse \
  acquire __commModuleOffsetMutex \
  add __commModuleOffset, _offset, CommOffsetUsbPollBufBuf \
  SetCommModuleBytes(__commModuleOffset, _cnt, _data) \
  release __commModuleOffsetMutex \
  compend

#define SetUSBPollBuffer(_offset, _cnt, _data) __setUSBPollBuffer(_offset, _cnt, _data)

#define SetUSBPollBufferInPtr(_n) __setUSBPollBufferInPtr(_n)
#define SetUSBPollBufferOutPtr(_n) __setUSBPollBufferOutPtr(_n)
#define SetBTDeviceCount(_n) __setBTDeviceCount(_n)
#define SetBTDeviceNameCount(_n) __setBTDeviceNameCount(_n)
#define SetHSFlags(_n) __setHSFlags(_n)
#define SetHSSpeed(_n) __setHSSpeed(_n)
#define SetHSState(_n) __setHSState(_n)
#define SetUSBState(_n) __setUSBState(_n)
#define SetHSMode(_n) __setHSMode(_n)

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
  SetOutputModuleValue(OutputOffsetPwnFreq, _n)

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

#define __setHSMode(_n) \
  compchk EQ, sizeof(_n), 2 \
  SetCommModuleValue(CommOffsetHsMode, _n)

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

#define CreateFile(_fname, _fsize, _handle, _result) __createFile(_fname, _fsize, _handle, _result)
#define OpenFileAppend(_fname, _fsize, _handle, _result) __openFileAppend(_fname, _fsize, _handle, _result)
#define OpenFileRead(_fname, _fsize, _handle, _result) __openFileRead(_fname, _fsize, _handle, _result)
#define CloseFile(_handle, _result) __closeFile(_handle, _result)
#define ResolveHandle(_fname, _handle, _writeable, _result) __resolveHandle(_fname, _handle, _writeable, _result)
#define RenameFile(_oldname, _newname, _result) __renameFile(_oldname, _newname, _result)
#define DeleteFile(_fname, _result) __deleteFile(_fname, _result)
#define ResizeFile(_fname, _newsize, _result) __fileResize(_fname, _newsize, _result)

#ifdef __ENHANCED_FIRMWARE
dseg segment
  __FFArgs TFileFind
dseg ends
#define CreateFileLinear(_fname, _fsize, _handle, _result) __createFileLinear(_fname, _fsize, _handle, _result)
#define CreateFileNonLinear(_fname, _fsize, _handle, _result) __createFileNonLinear(_fname, _fsize, _handle, _result)
#define OpenFileReadLinear(_fname, _fsize, _handle, _result) __openFileReadLinear(_fname, _fsize, _handle, _result)
#define FindFirstFile(_fname, _handle, _result) __findFirstFile(_fname, _handle, _result)
#define FindNextFile(_fname, _handle, _result) __findNextFile(_fname, _handle, _result)
#endif

#define Read(_handle, _n, _result) __readValue(_handle, _n, _result)
#define ReadLn(_handle, _n, _result) __readLnValue(_handle, _n, _result)
#define ReadBytes(_handle, _len, _buf, _result) __readBytes(_handle, _len, _buf, _result)
#define ReadLnString(_handle, _output, _result) __readLnString(_handle, _output, _result)

#define Write(_handle, _n, _result) __writeValue(_handle, _n, _result)
#define WriteLn(_handle, _n, _result) __writeLnValue(_handle, _n, _result)
#define WriteString(_handle, _str, _cnt, _result) __writeString(_handle, _str, _cnt, _result)
#define WriteLnString(_handle, _str, _cnt, _result) __writeLnString(_handle, _str, _cnt, _result)
#define WriteBytes(_handle, _buf, _cnt, _result) __writeBytes(_handle, _buf, _cnt, _result)
#define WriteBytesEx(_handle, _len, _buf, _result) __writeBytesEx(_handle, _len, _buf, _result)


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
  brtst NEQ, __frsEndLoop, __frsFReadArgs.Result
  brtst LTEQ, __frsEndLoop, __frsFReadArgs.Length
  mov __frsFWriteArgs.Buffer, __frsFReadArgs.Buffer
  mov __frsFWriteArgs.Length, __frsFReadArgs.Length
  syscall FileWrite, __frsFWriteArgs
  brtst NEQ, __frsEndLoop, __frsFWriteArgs.Result
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
dseg ends

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
  set __FReadArgs.Length, sizeof(_n) \
  syscall FileRead, __FReadArgs \
  mov _result, __FReadArgs.Result \
  unflatten _n, __FReadTmpByte, __FReadArgs.Buffer, _n \
  release __FReadMutex

#define __readLnValue(_handle, _n, _result) \
  acquire __FReadMutex \
  mov __FReadArgs.FileHandle, _handle \
  set __FReadArgs.Length, sizeof(_n) \
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

#define SendMessage(_queue, _msg, _result) __sendMessage(_queue, _msg, _result)
#define ReceiveMessage(_queue, _clear, _msg, _result) __receiveMessage(_queue, _clear, _msg, _result)

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

#define ReceiveRemoteBool(_queue, _clear, _bval, _result) __receiveRemoteBool(_queue, _clear, _bval, _result)
#define ReceiveRemoteNumber(_queue, _clear, _val, _result) __receiveRemoteNumber(_queue, _clear, _val, _result)
#define ReceiveRemoteString(_queue, _clear, _str, _result) __receiveMessage(_queue, _clear, _str, _result)
#define ReceiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, _result) __receiveRemoteMessageEx(_queue, _clear, _str, _val, _bval, _result)

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

#define SendResponseString(_queue, _msg, _result) __sendResponseString(_queue, _msg, _result)
#define SendResponseBool(_queue, _bval, _result) __sendResponseBool(_queue, _bval, _result)
#define SendResponseNumber(_queue, _val, _result) __sendResponseNumber(_queue, _val, _result)

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
  __SRSTmpVal sdword
  __SRSFlattenBuf byte[]
dseg ends

dseg segment
  __DCMessageWritePacket byte[] {0x80, 0x09, 0xFF, 0xFF} // append N bytes
  __DCStopProgramPacket byte[]  {0x80, 0x01}
  __DCStopSoundPacket byte[]    {0x80, 0x0c}
  __DCKeepAlivePacket byte[]    {0x80, 0x0d}
  __DCStartProgramPacket byte[] {0x80, 0x00, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __DCPlaySoundFilePacket byte[] {0x80, 0x02, 0xFF, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
  __DCPlayTonePacket byte[]     {0x80, 0x03, 0xFF, 0xFF, 0xFF, 0xFF}
dseg ends

#define BluetoothStatus(_conn, _result) __bluetoothStatus(_conn, _result)
#define BluetoothWrite(_conn, _buffer, _result) __bluetoothWrite(_conn, _buffer, _result)

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

#define SendRemoteBool(_conn, _queue, _bval, _result) __sendRemoteBool(_conn, _queue, _bval, _result)
#define SendRemoteNumber(_conn, _queue, _val, _result) __sendRemoteNumber(_conn, _queue, _val, _result)
#define SendRemoteString(_conn, _queue, _str, _result) __sendRemoteString(_conn, _queue, _str, _result)

#define __sendRemoteBool(_conn, _queue, _bval, _result) \
  acquire __CBTWMutex \
  mov __SRSTmpBuf, __DCMessageWritePacket \
  replace __SRSTmpBuf, __SRSTmpBuf, 2, _queue \
  replace __SRSTmpBuf, __SRSTmpBuf, 3, 2 \
  mov __CBTWArgs.Connection, _conn \
  arrbuild __CBTWArgs.Buffer, __SRSTmpBuf, _bval, 0 \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __sendRemoteNumber(_conn, _queue, _val, _result) \
  acquire __CBTWMutex \
  mov __SRSTmpBuf, __DCMessageWritePacket \
  replace __SRSTmpBuf, __SRSTmpBuf, 2, _queue \
  replace __SRSTmpBuf, __SRSTmpBuf, 3, 5 \
  mov __SRSTmpVal, _val \
  flatten __SRSFlattenBuf, __SRSTmpVal \
  mov __CBTWArgs.Connection, _conn \
  arrbuild __CBTWArgs.Buffer, __SRSTmpBuf, __SRSFlattenBuf \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __sendRemoteString(_conn, _queue, _str, _result) \
  acquire __CBTWMutex \
  mov __SRSTmpBuf, __DCMessageWritePacket \
  replace __SRSTmpBuf, __SRSTmpBuf, 2, _queue \
  arrsize __SRSTmpVal, _str \
  replace __SRSTmpBuf, __SRSTmpBuf, 3, __SRSTmpVal \
  mov __CBTWArgs.Connection, _conn \
  arrbuild __CBTWArgs.Buffer, __SRSTmpBuf, _str \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define Wait(_n) waitv _n

#define RemoteMessageRead(_conn, _queue, _result) __remoteMessageRead(_conn, _queue, _result)
#define RemoteMessageWrite(_conn, _queue, _msg, _result) __sendRemoteString(_conn, _queue, _msg, _result)
#define RemoteStartProgram(_conn, _filename, _result) __remoteStartProgram(_conn, _filename, _result)
#define RemoteStopProgram(_conn, _result) __bluetoothWrite(_conn, __DCStopProgramPacket, _result)
#define RemotePlaySoundFile(_conn, _filename, _bloop, _result) __remotePlaySoundFile(_conn, _filename, _bloop, _result)
#define RemotePlayTone(_conn, _frequency, _duration, _result) __remotePlayTone(_conn, _frequency, _duration, _result)
#define RemoteStopSound(_conn, _result) __bluetoothWrite(_conn, __DCStopSoundPacket, _result)
#define RemoteKeepAlive(_conn, _result) __bluetoothWrite(_conn, __DCKeepAlivePacket, _result)
#define RemoteResetScaledValue(_conn, _port, _result) __remoteResetScaledValue(_conn, _port, _result)
#define RemoteResetMotorPosition(_conn, _port, _brelative, _result) __remoteResetMotorPosition(_conn, _port, _brelative, _result)
#define RemoteSetInputMode(_conn, _port, _type, _mode, _result) __remoteSetInputMode(_conn, _port, _type, _mode, _result)
#define RemoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, _result) \
  __remoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, _result)

#define __remoteMessageRead(_conn, _queue, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  add __SRSTmpVal, _queue, 10 \
  arrbuild __CBTWArgs.Buffer, 0x00, 0x13, __SRSTmpVal, _queue, 0x01 \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __remoteResetScaledValue(_conn, _port, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  arrbuild __CBTWArgs.Buffer, 0x80, 0x08, _port \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __remoteResetMotorPosition(_conn, _port, _brelative, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  arrbuild __CBTWArgs.Buffer, 0x80, 0x0a, _port, _brelative \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __remoteSetInputMode(_conn, _port, _type, _mode, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  arrbuild __CBTWArgs.Buffer, 0x80, 0x05, _port, _type, _mode \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __remoteSetOutputState(_conn, _port, _speed, _mode, _regmode, _turnpct, _runstate, _tacholimit, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  mov __SRSTmpVal, _tacholimit \
  flatten __SRSFlattenBuf, __SRSTmpVal \
  arrbuild __SRSTmpBuf, 0x80, 0x04, _port, _speed, _mode, _regmode, _turnpct, _runstate, __SRSFlattenBuf \
  strtoarr __CBTWArgs.Buffer, __SRSTmpBuf \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __remoteStartProgram(_conn, _filename, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  mov __CBTWArgs.Buffer, __DCStartProgramPacket \
  strsubset __SRSTmpBuf, _filename, NA, 19 \
  replace __CBTWArgs.Buffer, __CBTWArgs.Buffer, 2, __SRSTmpBuf \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __remotePlaySoundFile(_conn, _filename, _bloop, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  mov __CBTWArgs.Buffer, __DCPlaySoundFilePacket \
  strsubset __SRSTmpBuf, _filename, NA, 19 \
  replace __CBTWArgs.Buffer, __CBTWArgs.Buffer, 2, _bloop \
  replace __CBTWArgs.Buffer, __CBTWArgs.Buffer, 3, __SRSTmpBuf \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex

#define __remotePlayTone(_conn, _frequency, _duration, _result) \
  acquire __CBTWMutex \
  mov __CBTWArgs.Connection, _conn \
  mov __CBTWArgs.Buffer, __DCPlayTonePacket \
  and __SRSTmpVal, _frequency, 0xff \
  replace __CBTWArgs.Buffer, __CBTWArgs.Buffer, 2, __SRSTmpVal \
  div __SRSTmpVal, _frequency, 0xff \
  replace __CBTWArgs.Buffer, __CBTWArgs.Buffer, 3, __SRSTmpVal \
  and __SRSTmpVal, _duration, 0xff \
  replace __CBTWArgs.Buffer, __CBTWArgs.Buffer, 4, __SRSTmpVal \
  div __SRSTmpVal, _duration, 0xff \
  replace __CBTWArgs.Buffer, __CBTWArgs.Buffer, 5, __SRSTmpVal \
  syscall CommBTWrite, __CBTWArgs \
  mov _result, __CBTWArgs.Result \
  release __CBTWMutex


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
dseg ends

#define RS485Status(_sendingData, _dataAvail) __RS485Status(_sendingData, _dataAvail)
#define RS485Write(_buffer, _status) __RS485Write(_buffer, _status)
#define RS485Read(_buffer, _status) __RS485Read(_buffer, _status)

#define __RS485Status(_sendingData, _dataAvail) \
  acquire __CHSCSMutex \
  syscall CommHSCheckStatus, __CHSCSArgs \
  mov _sendingData, __CHSCSArgs.SendingData \
  mov _dataAvail, __CHSCSArgs.DataAvailable \
  release __CHSCSMutex

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

#define RS485Control(_cmd, _baud, _mode, _result) __RS485Control(_cmd, _baud, _mode, _result)
#define RS485Uart(_baud, _mode, _result) __RS485Control(HS_CTRL_UART, _baud, _mode, _result)
#define RS485Init(_result) __RS485Control(HS_CTRL_INIT, 0, 0, _result)
#define RS485Exit(_result) __RS485Control(HS_CTRL_EXIT, 0, 0, _result)

#define __RS485Control(_cmd, _baud, _mode, _result) \
  acquire __CHSCMutex \
  mov __CHSCArgs.Command, _cmd \
  mov __CHSCArgs.BaudRate, _baud \
  mov __CHSCArgs.Mode, _mode \
  syscall CommHSControl, __CHSCArgs \
  mov _result, __CHSCArgs.Result \
  release __CHSCMutex

#else

#define RS485Control(_cmd, _baud, _result) __RS485Control(_cmd, _baud, _result)
#define RS485Uart(_baud, _result) __RS485Control(HS_CTRL_UART, _baud, _result)
#define RS485Init(_result) __RS485Control(HS_CTRL_INIT, 0, _result)
#define RS485Exit(_result) __RS485Control(HS_CTRL_EXIT, 0, _result)

#define __RS485Control(_cmd, _baud, _result) \
  acquire __CHSCMutex \
  mov __CHSCArgs.Command, _cmd \
  mov __CHSCArgs.BaudRate, _baud \
  syscall CommHSControl, __CHSCArgs \
  mov _result, __CHSCArgs.Result \
  release __CHSCMutex

#endif

#define SendRS485Bool(_bval, _status) __sendRS485Bool(_bval, _status)
#define SendRS485Number(_val, _status) __sendRS485Number(_val, _status)
#define SendRS485String(_str, _status) __sendRS485String(_str, _status)

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

#define __sendRS485String(_str, _status) \
  acquire __CHSWMutex \
  mov __CHSWArgs.Buffer, _str \
  syscall CommHSWrite, __CHSWArgs \
  mov _status, __CHSWArgs.Status \
  release __CHSWMutex
#endif


// standard firmware math functions written by Tamas Sorosy (www.sorosy.com)

// X is any integer; Y is the sqrt value (0->max); if X<0, Y is the sqrt value of absolute X
#define Sqrt(_X,_R) __SQRT(_X,_R)

// X is any integer in degrees; Y is 100* the sin value (-100->100)
#define Sin(_X,_R) __SIN(_X,_R)

// X is any integer in degrees; Y is 100* the cos value (-100->100)
#define Cos(_X,_R) __COS(_X,_R)

// X is 100* the sin value (-100->100); Y is -90->90; Y is 101 if X is outside -100->100 range
#define Asin(_X,_R) __ASIN(_X,_R)

// X is 100* the cos value (-100->100); Y is 0->180; Y is -11 if X is outside -100->100 range
#define Acos(_X,_R) __ACOS(_X,_R)

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

#define bcd2dec(_bcd, _result) __bcd2dec(_bcd, _result)


// HiTechnic API functions

#define SetSensorHTEOPD(_p, _bStd) \
  SetSensorType(_p, IN_TYPE_LIGHT_ACTIVE+_bStd) \
  SetSensorMode(_p, IN_MODE_RAW) \
  ResetSensor(_p)

#define ReadSensorHTEOPD(_p, _val) \
  getin _val, _p, RawValue \
  sub _val, 1023, _val

#define SetSensorHTGyro(_p) \
  SetSensorType(_p, IN_TYPE_LIGHT_INACTIVE) \
  SetSensorMode(_p, IN_MODE_RAW) \
  ResetSensor(_p)
	
#define ReadSensorHTGyro(_p, _offset, _val) \
  getin _val, _p, RawValue \
  sub _val, _val, 600 \
  sub _val, _val, _offset

dseg segment
  __HTMplexRaw word
  __HTMplexScaled dword
  __HTMplexMutex mutex
dseg ends

#define __ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) \
  acquire __HTMplexMutex \
  getin __HTMplexRaw, _p, RawValue \
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

#define ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4) __ReadSensorHTTouchMultiplexer(_p, _t1, _t2, _t3, _t4)

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

#define HTPowerFunctionCommand(_port, _channel, _outa, _outb, _result) \
  __HTPFComboDirect(_port, _channel, _outa, _outb, _result)

#define HTPFComboDirect(_port, _channel, _outa, _outb, _result) \
  __HTPFComboDirect(_port, _channel, _outa, _outb, _result)

#define HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, _result) \
  __HTPFSinglePin(_port, _channel, _out, _pin, _func, _cont, _result)

#define HTPFSingleOutputCST(_port, _channel, _out, _func, _result) \
  __HTPFSingleOutput(_port, _channel, _out, _func, TRUE, _result)

#define HTPFSingleOutputPWM(_port, _channel, _out, _func, _result) \
  __HTPFSingleOutput(_port, _channel, _out, _func, FALSE, _result)

#define HTPFComboPWM(_port, _channel, _outa, _outb, _result) \
  __HTPFComboPWM(_port, _channel, _outa, _outb, _result)

#define HTPFTrain(_port, _channel, _func, _result) \
  __HTIRTrain(_port, _channel, _func, TRUE, _result)

#define HTIRTrain(_port, _channel, _func, _result) \
  __HTIRTrain(_port, _channel, _func, FALSE, _result)

#define HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, _result) \
  __HTPFRawOutput(_port, _nibble0, _nibble1, _nibble2, _result)

#define HTPFRepeat(_port, _count, _delay, _result) \
  __HTPFRepeatLastCommand(_port, _count, _delay, _result)


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
  ReadI2CBytes(__gRCXCmd.Port, __RCSInCmd, __RCSTmpByte, __gRCXCmd.Response, __RCSResult)
__RCSNoResponse:
  return
ends

#define HTRCXSetIRLinkPort(_port) __HTRCXSetIRLinkPort(_port)
#define HTRCXPoll(_src, _value, _result) __HTRCXPoll(_src, _value, _result)
#define HTRCXBatteryLevel(_result) __HTRCXBatteryLevel(_result)
#define HTRCXPing() __HTRCXOpNoArgs(RCX_PingOp)
#define HTRCXDeleteTasks() __HTRCXOpNoArgs(RCX_DeleteTasksOp)
#define HTRCXStopAllTasks() __HTRCXOpNoArgs(RCX_StopAllTasksOp)
#define HTRCXPBTurnOff() __HTRCXOpNoArgs(RCX_PBTurnOffOp)
#define HTRCXDeleteSubs() __HTRCXOpNoArgs(RCX_DeleteSubsOp)
#define HTRCXClearSound() __HTRCXOpNoArgs(RCX_ClearSoundOp)
#define HTRCXClearMsg() __HTRCXOpNoArgs(RCX_ClearMsgOp)
#define HTRCXMuteSound() __HTRCXOpNoArgs(RCX_MuteSoundOp)
#define HTRCXUnmuteSound() __HTRCXOpNoArgs(RCX_UnmuteSoundOp)
#define HTRCXClearAllEvents() __HTRCXOpNoArgs(RCX_ClearAllEventsOp)
#define HTRCXSetOutput(_outputs, _mode) __HTRCXSetOutput(_outputs, _mode)
#define HTRCXSetDirection(_outputs, _dir) __HTRCXSetDirection(_outputs, _dir)
#define HTRCXSetPower(_outputs, _pwrsrc, _pwrval) __HTRCXSetPower(_outputs, _pwrsrc, _pwrval)
#define HTRCXOn(_outputs) __HTRCXSetOutput(_outputs, RCX_OUT_ON)
#define HTRCXOff(_outputs) __HTRCXSetOutput(_outputs, RCX_OUT_OFF)
#define HTRCXFloat(_outputs) __HTRCXSetOutput(_outputs, RCX_OUT_FLOAT)
#define HTRCXToggle(_outputs) __HTRCXSetDirection(_outputs, RCX_OUT_TOGGLE)
#define HTRCXFwd(_outputs) __HTRCXSetDirection(_outputs, RCX_OUT_FWD)
#define HTRCXRev(_outputs) __HTRCXSetDirection(_outputs, RCX_OUT_REV)
#define HTRCXOnFwd(_outputs) __HTRCXOnFwd(_outputs)
#define HTRCXOnRev(_outputs) __HTRCXOnRev(_outputs)
#define HTRCXOnFor(_outputs, _ms) __HTRCXOnFor(_outputs, _ms)
#define HTRCXSetTxPower(_pwr) __HTRCXSetTxPower(_pwr)
#define HTRCXPlaySound(_snd) __HTRCXPlaySound(_snd)
#define HTRCXDeleteTask(_t) __HTRCXDeleteTask(_t)
#define HTRCXStartTask(_t) __HTRCXStartTask(_t)
#define HTRCXStopTask(_t) __HTRCXStopTask(_t)
#define HTRCXSelectProgram(_prog) __HTRCXSelectProgram(_prog)
#define HTRCXClearTimer(_timer) __HTRCXClearTimer(_timer)
#define HTRCXSetSleepTime(_t) __HTRCXSetSleepTime(_t)
#define HTRCXDeleteSub(_s) __HTRCXDeleteSub(_s)
#define HTRCXClearSensor(_port) __HTRCXClearSensor(_port)
#define HTRCXPlayToneVar(_varnum, _duration) __HTRCXPlayToneVar(_varnum, _duration)
#define HTRCXSetWatch(_hours, _minutes) __HTRCXSetWatch(_hours, _minutes)
#define HTRCXSetSensorType(_port, _type) __HTRCXSetSensorType(_port, _type)
#define HTRCXSetSensorMode(_port, _mode) __HTRCXSetSensorMode(_port, _mode)
#define HTRCXCreateDatalog(_size) __HTRCXCreateDatalog(_size)
#define HTRCXAddToDatalog(_src, _value) __HTRCXAddToDatalog(_src, _value)
#define HTRCXSendSerial(_first, _count) __HTRCXSendSerial(_first, _count)
#define HTRCXRemote(_cmd) __HTRCXRemote(_cmd)
#define HTRCXEvent(_src, _value) __HTRCXEvent(_src, _value)
#define HTRCXPlayTone(_freq, _duration) __HTRCXPlayTone(_freq, _duration)
#define HTRCXSelectDisplay(_src, _value) __HTRCXSelectDisplay(_src, _value)
#define HTRCXPollMemory(_address, _result) __HTRCXPollMemory(_address, _result)
#define HTRCXSetEvent(_evt, _src, _type) __HTRCXSetEvent(_evt, _src, _type)
#define HTRCXSetGlobalOutput(_outputs, _mode) __HTRCXSetGlobalOutput(_outputs, _mode)
#define HTRCXSetGlobalDirection(_outputs, _dir) __HTRCXSetGlobalDirection(_outputs, _dir)
#define HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) __HTRCXSetMaxPower(_outputs, _pwrsrc, _pwrval)
#define HTRCXEnableOutput(_outputs) __HTRCXSetGlobalOutput(_outputs, RCX_OUT_ON)
#define HTRCXDisableOutput(_outputs) __HTRCXSetGlobalOutput(_outputs, RCX_OUT_OFF)
#define HTRCXInvertOutput(_outputs) __HTRCXSetGlobalDirection(_outputs, RCX_OUT_REV)
#define HTRCXObvertOutput(_outputs) __HTRCXSetGlobalDirection(_outputs, RCX_OUT_FWD)
#define HTRCXIncCounter(_counter) __HTRCXIncCounter(_counter)
#define HTRCXDecCounter(_counter) __HTRCXDecCounter(_counter)
#define HTRCXClearCounter(_counter) __HTRCXClearCounter(_counter)
#define HTRCXSetPriority(_p) __HTRCXSetPriority(_p)
#define HTRCXSetMessage(_msg) __HTRCXSetMessage(_msg)


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
  wait _ms \
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

#define __HTRCXPollMemory(_address, _result) \
  acquire __RCXCmdMutex \
  and __RCSTmpByte, _address, 0xFF \
  div __RCSTmpByte2, _address, 256 \
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

#define HTScoutCalibrateSensor() __HTRCXOpNoArgs(RCX_LSCalibrateOp)
#define HTScoutMuteSound() __HTScoutMuteSound()
#define HTScoutUnmuteSound() __HTScoutUnmuteSound()
#define HTScoutSelectSounds(_grp) __HTScoutSelectSounds(_grp)
#define HTScoutSetLight(_x) __HTScoutSetLight(_x)
#define HTScoutSetSensorClickTime(_src, _value) __HTScoutSetSensorClickTime(_src, _value)
#define HTScoutSetSensorHysteresis(_src, _value) __HTScoutSetSensorHysteresis(_src, _value)
#define HTScoutSetSensorLowerLimit(_src, _value) __HTScoutSetSensorLowerLimit(_src, _value)
#define HTScoutSetSensorUpperLimit(_src, _value) __HTScoutSetSensorUpperLimit(_src, _value)
#define HTScoutSetEventFeedback(_src, _value) __HTScoutSetEventFeedback(_src, _value)
#define HTScoutSendVLL(_src, _value) __HTScoutSendVLL(_src, _value)
#define HTScoutSetScoutMode(_mode) __HTScoutSetScoutMode(_mode)

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



#define ReadSensorHTCompass(_port, _value) \
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

#define ReadSensorHTIRSeeker2Addr(_port, _addr, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, 0x10, _addr \
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
  arrbuild __RLSReadBuf##_port, 0x10, _addr \
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

#define ReadSensorHTColorNum(_port, _value) \
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


#define ReadSensorHTIRSeekerDir(_port, _value) \
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

#define ReadI2CDeviceInfoEx(_port, _addr, _info, _strVal) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _addr, _info \
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
  arrbuild __RLSReadBuf##_port, _addr, _info \
  set __RLSBytesCount##_port, 8 \
  call __ReadLSBytes##_port \
  mov _strVal, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend

#define ReadI2CDeviceInfo(_port, _info, _strVal) ReadI2CDeviceInfoEx(_port, 0x02, _info, _strVal)
#define ReadI2CVersionEx(_port, _addr, _strVal) ReadI2CDeviceInfoEx(_port, _addr, I2C_REG_VERSION, _strVal)
#define ReadI2CVersion(_port, _strVal) ReadI2CDeviceInfoEx(_port, 0x02, I2C_REG_VERSION, _strVal)
#define ReadI2CVendorIdEx(_port, _addr, _strVal) ReadI2CDeviceInfoEx(_port, _addr, I2C_REG_VENDOR_ID, _strVal)
#define ReadI2CVendorId(_port, _strVal) ReadI2CDeviceInfoEx(_port, 0x02, I2C_REG_VENDOR_ID, _strVal)
#define ReadI2CDeviceIdEx(_port, _addr, _strVal) ReadI2CDeviceInfoEx(_port, _addr, I2C_REG_DEVICE_ID, _strVal)
#define ReadI2CDeviceId(_port, _strVal) ReadI2CDeviceInfoEx(_port, 0x02, I2C_REG_DEVICE_ID, _strVal)


#define ReadSensorHTAccel(_port, _x, _y, _z, _result) __ReadSensorHTAccel(_port, _x, _y, _z, _result)
#define ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, _result) __ReadSensorHTColor(_port, _ColorNum, _Red, _Green, _Blue, _result)
#define ReadSensorHTRawColor(_port, _Red, _Green, _Blue, _result) __ReadSensorHTRawColor(_port, _Red, _Green, _Blue, _result)
#define ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, _result) __ReadSensorHTNormalizedColor(_port, _ColorIdx, _Red, _Green, _Blue, _result)
#define ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) __ReadSensorHTIRSeeker(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result)
#define ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, _result) __ReadSensorHTIRSeeker2DC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _avg, _result)
#define ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result) __ReadSensorHTIRSeeker2AC(_port, _dir, _s1, _s3, _s5, _s7, _s9, _result)
#define SetHTIRSeeker2Mode(_port, _mode, _result) __SetHTIRSeeker2Mode(_port, _mode, _result)

#define SetHTColor2Mode(_port, _mode, _result) __SetHTColor2Mode(_port, _mode, _result)
#define ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, _result) __ReadSensorHTColor2Active(_port, _ColorNum, _Red, _Green, _Blue, _White, _result)
#define ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, _result) __ReadSensorHTNormalizedColor2Active(_port, _ColorIdx, _Red, _Green, _Blue, _result)
#define ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, _result) __ReadSensorHTRawColor2(_port, _Red, _Green, _Blue, _White, _result)
#define ReadSensorHTIRReceiver(_port, _pfdata, _result) __ReadSensorHTIRReceiver(_port, _pfdata, _result)
#define ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, _result) __ReadSensorHTIRReceiverEx(_port, _reg, _pfchar, _result) 




// Mindsensors API functions

#define SetSensorMSPressure(_p) \
  SetSensorType(_p, IN_TYPE_REFLECTION) \
  SetSensorMode(_p, IN_MODE_RAW) \
  ResetSensor(_p)

#define ReadSensorMSPressure(_p, _value) \
  getin _value, _p, RawValue \
  sub _value, 1024, _value \
  div _value, _value, 25

#define ReadSensorMSPressureRaw(_p, _value) \
  getin _value, _p, RawValue

#define ReadSensorMSCompassEx(_port, _addr, _value) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _addr, 0x42 \
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
  arrbuild __RLSReadBuf##_port, _addr, 0x42 \
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

#define __ReadSensorMSTiltEx(_port, _addr, _x, _y, _z, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _addr, 0x42  \
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
  arrbuild __RLSReadBuf##_port, _addr, 0x42 \
  set __RLSBytesCount##_port, 3 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _x, __RLSReadBuf##_port, NA \
  index _y, __RLSReadBuf##_port, 1 \
  index _z, __RLSReadBuf##_port, 2 \
  release __RLSBmutex##_port \
  compend

#define __ReadSensorMSAccelEx(_port, _addr, _x, _y, _z, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _addr, 0x45 \
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
  arrbuild __RLSReadBuf##_port, _addr, 0x45 \
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

#define ReadSensorMSCompass(_port, _value) ReadSensorMSCompassEx(_port, 0x02, _value)
#define ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, _result) __ReadSensorMSRTClock(_port, _sec, _min, _hrs, _dow, _date, _month, _year, _result)
#define ReadSensorMSTilt(_port, _x, _y, _z, _result) __ReadSensorMSTiltEx(_port, 0x02, _x, _y, _z, _result)
#define ReadSensorMSTiltEx(_port, _addr, _x, _y, _z, _result) __ReadSensorMSTiltEx(_port, _addr, _x, _y, _z, _result)
#define ReadSensorMSAccel(_port, _x, _y, _z, _result) __ReadSensorMSAccelEx(_port, 0x02, _x, _y, _z, _result)
#define ReadSensorMSAccelEx(_port, _addr, _x, _y, _z, _result) __ReadSensorMSAccelEx(_port, _addr, _x, _y, _z, _result)

dseg segment
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

#define __MSWriteToRegister(_port, _addr, _reg, _bytes, _result) \
  acquire __WDSCmutex \
  mov __WDSC_Port, _port \
  mov __WDSC_SensorAddress, _addr \
  set __WDSC_SensorRegister, _reg \
  arrbuild __WDSC_WriteBytes, _bytes \
  call __MSWriteBytesSub \
  mov _result, __WDSC_LSStatus \
  release __WDSCmutex

#define __I2CSendCmd(_port, _addr, _cmd, _result) \
  __MSWriteToRegister(_port, _addr, I2C_REG_CMD, _cmd, _result)

#define __MSReadValue(_port, _addr, _reg, _bytes, _out, _result) \
  acquire __DNRVmutex \
  mov __RDSD_Port, _port \
  mov __RDSD_SensorAddress, _addr \
  mov __RDSD_SensorRegister, _reg \
  set __RDSD_NumBytesToRead, _bytes \
  call __MSReadValueSub \
  mov _out, __RDSD_Value \
  mov _result, __RDSD_LSStatus \
  release __DNRVmutex


#define I2CSendCommandEx(_port, _addr, _cmd, _result) __I2CSendCmd(_port, _addr, _cmd, _result)
#define I2CSendCommand(_port, _cmd, _result) __I2CSendCmd(_port, 0x02, _cmd, _result)
#define MSReadValueEx(_port, _addr, _reg, _bytes, _out, _result) __MSReadValue(_port, _addr, _reg, _bytes, _out, _result)
#define MSReadValue(_port, _reg, _bytes, _out, _result) __MSReadValue(_port, 0x02, _reg, _bytes, _out, _result)

#define MSEnergize(_port, _result) __I2CSendCmd(_port, 0x02, MS_CMD_ENERGIZED, _result)
#define MSEnergizeEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, MS_CMD_ENERGIZED, _result)
#define MSDeenergize(_port, _result) __I2CSendCmd(_port, 0x02, MS_CMD_DEENERGIZED, _result)
#define MSDeenergizeEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, MS_CMD_DEENERGIZED, _result)
#define MSADPAOn(_port, _result) __I2CSendCmd(_port, 0x02, MS_CMD_ADPA_ON, _result)
#define MSADPAOnEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, MS_CMD_ADPA_ON, _result)
#define MSADPAOff(_port, _result) __I2CSendCmd(_port, 0x02, MS_CMD_ADPA_OFF, _result)
#define MSADPAOffEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, MS_CMD_ADPA_OFF, _result)

#define DISTNxGP2D12(_port, _result) __I2CSendCmd(_port, 0x02, DIST_CMD_GP2D12, _result)
#define DISTNxGP2D120(_port, _result) __I2CSendCmd(_port, 0x02, DIST_CMD_GP2D120, _result)
#define DISTNxGP2YA21(_port, _result) __I2CSendCmd(_port, 0x02, DIST_CMD_GP2YA21, _result)
#define DISTNxGP2YA02(_port, _result) __I2CSendCmd(_port, 0x02, DIST_CMD_GP2YA02, _result)
#define ReadDISTNxDistance(_port, _out, _result) __MSReadValue(_port, 0x02, DIST_REG_DIST, 2, _out, _result)
#define ReadDISTNxVoltage(_port, _out, _result) __MSReadValue(_port, 0x02, DIST_REG_VOLT, 2, _out, _result)
#define ReadDISTNxModuleType(_port, _out, _result) __MSReadValue(_port, 0x02, DIST_REG_MODULE_TYPE, 1, _out, _result)
#define ReadDISTNxNumPoints(_port, _out, _result) __MSReadValue(_port, 0x02, DIST_REG_NUM_POINTS, 1, _out, _result)
#define ReadDISTNxMinDistance(_port, _out, _result) __MSReadValue(_port, 0x02, DIST_REG_DIST_MIN, 2, _out, _result)
#define ReadDISTNxMaxDistance(_port, _out, _result) __MSReadValue(_port, 0x02, DIST_REG_DIST_MAX, 2, _out, _result)

#define DISTNxGP2D12Ex(_port, _addr, _result) __I2CSendCmd(_port, _addr, DIST_CMD_GP2D12, _result)
#define DISTNxGP2D120Ex(_port, _addr, _result) __I2CSendCmd(_port, _addr, DIST_CMD_GP2D120, _result)
#define DISTNxGP2YA21Ex(_port, _addr, _result) __I2CSendCmd(_port, _addr, DIST_CMD_GP2YA21, _result)
#define DISTNxGP2YA02Ex(_port, _addr, _result) __I2CSendCmd(_port, _addr, DIST_CMD_GP2YA02, _result)
#define ReadDISTNxDistanceEx(_port, _addr, _out, _result) __MSReadValue(_port, _addr, DIST_REG_DIST, 2, _out, _result)
#define ReadDISTNxVoltageEx(_port, _addr, _out, _result) __MSReadValue(_port, _addr, DIST_REG_VOLT, 2, _out, _result)
#define ReadDISTNxModuleTypeEx(_port, _addr, _out, _result) __MSReadValue(_port, _addr, DIST_REG_MODULE_TYPE, 1, _out, _result)
#define ReadDISTNxNumPointsEx(_port, _addr, _out, _result) __MSReadValue(_port, _addr, DIST_REG_NUM_POINTS, 1, _out, _result)
#define ReadDISTNxMinDistanceEx(_port, _addr, _out, _result) __MSReadValue(_port, _addr, DIST_REG_DIST_MIN, 2, _out, _result)
#define ReadDISTNxMaxDistanceEx(_port, _addr, _out, _result) __MSReadValue(_port, _addr, DIST_REG_DIST_MAX, 2, _out, _result)

subroutine __MSWriteBytesSub
  mov __WDSC_lswArgs.Port, __WDSC_Port
  arrbuild __WDSC_lswArgs.Buffer, __WDSC_SensorAddress, __WDSC_SensorRegister, __WDSC_WriteBytes
  set __WDSC_lswArgs.ReturnLen, 0
  syscall CommLSWrite, __WDSC_lswArgs
__WDSC_StatusLoop:
  LowspeedCheckStatus(__WDSC_Port, __WDSC_LSStatus)
  brtst GT, __WDSC_StatusLoop, __WDSC_LSStatus
  return
ends

subroutine __MSReadValueSub
  mov __RDSD_lswArgs.Port, __RDSD_Port
  arrbuild __RDSD_lswArgs.Buffer, __RDSD_SensorAddress, __RDSD_SensorRegister
  mov __RDSD_lswArgs.ReturnLen, __RDSD_NumBytesToRead
  syscall CommLSWrite, __RDSD_lswArgs
__RDSD_CheckStatusAfterWriteLoop:
  LowspeedCheckStatus(__RDSD_Port, __RDSD_LSStatus)
  brtst GT, __RDSD_CheckStatusAfterWriteLoop, __RDSD_LSStatus
  brtst EQ, __RDSD_GoAheadWithRead, __RDSD_LSStatus
  jmp __RDSD_ReadError
__RDSD_GoAheadWithRead:
  mov __RDSD_lsrArgs.Port, __RDSD_Port
  mov __RDSD_lsrArgs.BufferLen, __RDSD_NumBytesToRead
  syscall CommLSRead, __RDSD_lsrArgs
__RDSD_CheckStatusAfterReadLoop:
  LowspeedCheckStatus(__RDSD_Port, __RDSD_LSStatus)
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
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, 1
  mul __RDSD_Value, __RDSD_Byte, 256
__RDSD_OneByte:
  index __RDSD_Byte, __RDSD_lsrArgs.Buffer, NA
  add __RDSD_Value, __RDSD_Byte, __RDSD_Value
  mov __RDSD_PreviousValue, __RDSD_Value
__RDSD_ReturnResults:
  return
ends

#define SetSensorMSDRODActive(_p) \
  SetSensorType(_p, IN_TYPE_LIGHT_ACTIVE) \
  SetSensorMode(_p, IN_MODE_PCTFULLSCALE) \
  ResetSensor(_p)

#define SetSensorMSDRODInactive(_p) \
  SetSensorType(_p, IN_TYPE_LIGHT_INACTIVE) \
  SetSensorMode(_p, IN_MODE_PCTFULLSCALE) \
  ResetSensor(_p)

#define ReadSensorMSDROD(_p, _value) \
  getin _value, _p, NormalizedValue

#define PSPNxDigital(_port, _result) __I2CSendCmd(_port, 0x02, PSP_CMD_DIGITAL, _result)
#define PSPNxAnalog(_port, _result) __I2CSendCmd(_port, 0x02, PSP_CMD_ANALOG, _result)
#define PSPNxDigitalEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, PSP_CMD_DIGITAL, _result)
#define PSPNxAnalogEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, PSP_CMD_ANALOG, _result)

#define __ReadSensorMSPlayStationEx(_port, _addr, _b1, _b2, _xleft, _yleft, _xright, _yright, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _addr, PSP_REG_BTN1 \
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
  arrbuild __RLSReadBuf##_port, _addr, PSP_REG_BTN1 \
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

#define ReadSensorMSPlayStationEx(_port, _addr, _b1, _b2, _xleft, _yleft, _xright, _yright, _result) \
  __ReadSensorMSPlayStationEx(_port, _addr, _b1, _b2, _xleft, _yleft, _xright, _yright, _result)

#define ReadSensorMSPlayStation(_port, _b1, _b2, _xleft, _yleft, _xright, _yright, _result) \
  __ReadSensorMSPlayStationEx(_port, 0x02, _b1, _b2, _xleft, _yleft, _xright, _yright, _result)

#define NRLink2400(_port, _result) __I2CSendCmd(_port, 0x02, NRLINK_CMD_2400, _result)
#define NRLink4800(_port, _result) __I2CSendCmd(_port, 0x02, NRLINK_CMD_4800, _result)
#define NRLinkFlush(_port, _result) __I2CSendCmd(_port, 0x02, NRLINK_CMD_FLUSH, _result)
#define NRLinkIRLong(_port, _result) __I2CSendCmd(_port, 0x02, NRLINK_CMD_IR_LONG, _result)
#define NRLinkIRShort(_port, _result) __I2CSendCmd(_port, 0x02, NRLINK_CMD_IR_SHORT, _result)
#define NRLinkTxRaw(_port, _result) __I2CSendCmd(_port, 0x02, NRLINK_CMD_TX_RAW, _result)
#define NRLinkSetRCX(_port, _result) __I2CSendCmd(_port, 0x02, NRLINK_CMD_SET_RCX, _result)
#define NRLinkSetTrain(_port, _result) __I2CSendCmd(_port, 0x02, NRLINK_CMD_SET_TRAIN, _result)
#define NRLinkSetPF(_port, _result) __I2CSendCmd(_port, 0x02, NRLINK_CMD_SET_PF, _result)

#define NRLink2400Ex(_port, _addr, _result) __I2CSendCmd(_port, _addr, NRLINK_CMD_2400, _result)
#define NRLink4800Ex(_port, _addr, _result) __I2CSendCmd(_port, _addr, NRLINK_CMD_4800, _result)
#define NRLinkFlushEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, NRLINK_CMD_FLUSH, _result)
#define NRLinkIRLongEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, NRLINK_CMD_IR_LONG, _result)
#define NRLinkIRShortEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, NRLINK_CMD_IR_SHORT, _result)
#define NRLinkTxRawEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, NRLINK_CMD_TX_RAW, _result)
#define NRLinkSetRCXEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, NRLINK_CMD_SET_RCX, _result)
#define NRLinkSetTrainEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, NRLINK_CMD_SET_TRAIN, _result)
#define NRLinkSetPFEx(_port, _addr, _result) __I2CSendCmd(_port, _addr, NRLINK_CMD_SET_PF, _result)

#define __RunNRLinkMacroEx(_port, _addr, _macro, _result) \
  acquire __WDSCmutex \
  mov __WDSC_Port, _port \
  mov __WDSC_SensorAddress, _addr \
  arrbuild __WDSC_WriteBytes, NRLINK_CMD_RUN_MACRO, _macro \
  call __MSWriteBytesSub \
  mov _result, __WDSC_LSStatus \
  release __WDSCmutex

#define RunNRLinkMacroEx(_port, _addr, _macro, _result) __RunNRLinkMacroEx(_port, _addr, _macro, _result)
#define RunNRLinkMacro(_port, _macro, _result) __RunNRLinkMacroEx(_port, 0x02, _macro, _result)

#define ReadNRLinkStatusEx(_port, _addr, _value, _result) \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _addr, I2C_REG_CMD \
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
  arrbuild __RLSReadBuf##_port, _addr, I2C_REG_CMD \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  index _value, __RLSReadBuf##_port, NA \
  release __RLSBmutex##_port \
  compend

#define ReadNRLinkStatus(_port, _value, _result) ReadNRLinkStatusEx(_port, 0x02, _value, _result)

#define __WriteNRLinkBytes(_port, _addr, _bytes, _result) \
  __I2CSendCmd(_port, _addr, NRLINK_CMD_FLUSH, _result) \
  __MSWriteToRegister(_port, _addr, NRLINK_REG_DATA, _bytes, _result) \
  arrsize __WDSC_ByteCount, _bytes \
  __MSWriteToRegister(_port, _addr, NRLINK_REG_BYTES, __WDSC_ByteCount, _result)

#define WriteNRLinkBytesEx(_port, _addr, _bytes, _result) __WriteNRLinkBytes(_port, _addr, _bytes, _result)
#define WriteNRLinkBytes(_port, _bytes, _result) __WriteNRLinkBytes(_port, 0x02, _bytes, _result)

#define __ReadNRLinkBytes(_port, _addr, _bytes, _result) \
  acquire __DNRVmutex \
  compif EQ, isconst(_port), FALSE \
  acquire __RLSBmutex0 \
  acquire __RLSBmutex1 \
  acquire __RLSBmutex2 \
  acquire __RLSBmutex3 \
  mov __RLSReadPort, _port \
  arrbuild __RLSReadBufVar, _addr, NRLINK_REG_BYTES \
  set __RLSBytesCountVar, 1 \
  call __ReadLSBytesVar \
  index __RLSBytesCountVar, __RLSReadBufVar, NA \
  arrbuild __RLSReadBufVar, _addr, NRLINK_REG_DATA \
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
  arrbuild __RLSReadBuf##_port, _addr, NRLINK_REG_BYTES \
  set __RLSBytesCount##_port, 1 \
  call __ReadLSBytes##_port \
  index __RLSBytesCount##_port, __RLSReadBuf##_port, NA \
  arrbuild __RLSReadBuf##_port, _addr, NRLINK_REG_DATA \
  call __ReadLSBytes##_port \
  tst EQ, _result, __RLSBResult##_port \
  mov _bytes, __RLSReadBuf##_port \
  release __RLSBmutex##_port \
  compend \
  __I2CSendCmd(_port, _addr, NRLINK_CMD_FLUSH, _result) \
  release __DNRVmutex

#define ReadNRLinkBytesEx(_port, _addr, _bytes, _result) __ReadNRLinkBytes(_port, _addr, _bytes, _result)
#define ReadNRLinkBytes(_port, _bytes, _result) __ReadNRLinkBytes(_port, 0x02, _bytes, _result)


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

#define __MSPFComboDirect(_port, _addr, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 4 \
  mod __PF_p3, _outb, 4 \
  call __PFComboDirectSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _addr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFSinglePin(_port, _addr, _channel, _out, _pin, _func, _cont, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _pin, 2 \
  mod __PF_p4, _func, 4 \
  set __PF_p5, _cont \
  call __PFSinglePinSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _addr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFSingleOutput(_port, _addr, _channel, _out, _func, _cst, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _out, 2 \
  mod __PF_p3, _func, 16 \
  set __PF_p4, _cst \
  call __PFSingleOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _addr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFComboPWM(_port, _addr, _channel, _outa, _outb, _result) \
  acquire __PFMutex \
  mod __PF_p1, _channel, 4 \
  mod __PF_p2, _outa, 16 \
  mod __PF_p3, _outb, 16 \
  call __PFComboPWMSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _addr, __PFBytes, _result) \
  release __PFMutex

#define __MSIRTrain(_port, _addr, _channel, _func, _PFMode, _result) \
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
  __WriteNRLinkBytes(_port, _addr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFRawOutput(_port, _addr, _nibble0, _nibble1, _nibble2, _result) \
  acquire __PFMutex \
  mod __PF_p1, _nibble0, 7 \
  mod __PF_p2, _nibble1, 16 \
  mod __PF_p3, _nibble2, 16 \
  call __PFRawOutputSub \
  set __PFPowerFuncMode, TRUE \
  call __MSPowerFunctionCalcBytes \
  __WriteNRLinkBytes(_port, _addr, __PFBytes, _result) \
  release __PFMutex

#define __MSPFRepeatLastCommand(_port, _addr, _count, _delay, _result) \
  acquire __PFMutex \
  mov __PF_p1, _count \
  __MSPFRepeatLoop##__I__: \
  __WriteNRLinkBytes(_port, _addr, __PFBytes, _result) \
  waitv _delay \
  sub __PF_p1, __PF_p1, 1 \
  brtst GT, __MSPFRepeatLoop##__I__, __PF_p1 \
  release __PFMutex \
  __IncI__

#define MSPFComboDirectEx(_port, _addr, _channel, _outa, _outb, _result) \
  __MSPFComboDirect(_port, _addr, _channel, _outa, _outb, _result)

#define MSPFComboDirect(_port, _channel, _outa, _outb, _result) \
  __MSPFComboDirect(_port, 0x02, _channel, _outa, _outb, _result)

#define MSPFSinglePinEx(_port, _addr, _channel, _out, _pin, _func, _cont, _result) \
  __MSPFSinglePin(_port, _addr, _channel, _out, _pin, _func, _cont, _result)

#define MSPFSinglePin(_port, _channel, _out, _pin, _func, _cont, _result) \
  __MSPFSinglePin(_port, 0x02, _channel, _out, _pin, _func, _cont, _result)

#define MSPFSingleOutputCSTEx(_port, _addr, _channel, _out, _func, _result) \
  __MSPFSingleOutput(_port, _addr, _channel, _out, _func, TRUE, _result)

#define MSPFSingleOutputCST(_port, _channel, _out, _func, _result) \
  __MSPFSingleOutput(_port, 0x02, _channel, _out, _func, TRUE, _result)

#define MSPFSingleOutputPWMEx(_port, _addr, _channel, _out, _func, _result) \
  __MSPFSingleOutput(_port, _addr, _channel, _out, _func, FALSE, _result)

#define MSPFSingleOutputPWM(_port, _channel, _out, _func, _result) \
  __MSPFSingleOutput(_port, 0x02, _channel, _out, _func, FALSE, _result)

#define MSPFComboPWMEx(_port, _addr, _channel, _outa, _outb, _result) \
  __MSPFComboPWM(_port, _addr, _channel, _outa, _outb, _result)

#define MSPFComboPWM(_port, _channel, _outa, _outb, _result) \
  __MSPFComboPWM(_port, 0x02, _channel, _outa, _outb, _result)

#define MSPFTrainEx(_port, _addr, _channel, _func, _result) \
  __MSIRTrain(_port, _addr, _channel, _func, TRUE, _result)

#define MSPFTrain(_port, _channel, _func, _result) \
  __MSIRTrain(_port, 0x02, _channel, _func, TRUE, _result)

#define MSIRTrainEx(_port, _addr, _channel, _func, _result) \
  __MSIRTrain(_port, _addr, _channel, _func, FALSE, _result)

#define MSIRTrain(_port, _channel, _func, _result) \
  __MSIRTrain(_port, 0x02, _channel, _func, FALSE, _result)

#define MSPFRawOutputEx(_port, _addr, _nibble0, _nibble1, _nibble2, _result) \
  __MSPFRawOutput(_port, _addr, _nibble0, _nibble1, _nibble2, _result)

#define MSPFRawOutput(_port, _nibble0, _nibble1, _nibble2, _result) \
  __MSPFRawOutput(_port, 0x02, _nibble0, _nibble1, _nibble2, _result)

#define MSPFRepeatEx(_port, _addr, _count, _delay, _result) \
  __MSPFRepeatLastCommand(_port, _addr, _count, _delay, _result)

#define MSPFRepeat(_port, _count, _delay, _result) \
  __MSPFRepeatLastCommand(_port, 0x02, _count, _delay, _result)

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

#define MSRCXSetNRLinkEx(_port, _addr) __MSRCXSetNRLink(_port, _addr)
#define MSRCXSetNRLinkPort(_port) __MSRCXSetNRLink(_port, 0x02)
#define MSRCXPoll(_src, _value, _result) __MSRCXPoll(_src, _value, _result)
#define MSRCXBatteryLevel(_result) __MSRCXBatteryLevel(_result)
#define MSRCXPing() __MSRCXOpNoArgs(RCX_PingOp)
#define MSRCXDeleteTasks() __MSRCXOpNoArgs(RCX_DeleteTasksOp)
#define MSRCXStopAllTasks() __MSRCXOpNoArgs(RCX_StopAllTasksOp)
#define MSRCXPBTurnOff() __MSRCXOpNoArgs(RCX_PBTurnOffOp)
#define MSRCXDeleteSubs() __MSRCXOpNoArgs(RCX_DeleteSubsOp)
#define MSRCXClearSound() __MSRCXOpNoArgs(RCX_ClearSoundOp)
#define MSRCXClearMsg() __MSRCXOpNoArgs(RCX_ClearMsgOp)
#define MSRCXMuteSound() __MSRCXOpNoArgs(RCX_MuteSoundOp)
#define MSRCXUnmuteSound() __MSRCXOpNoArgs(RCX_UnmuteSoundOp)
#define MSRCXClearAllEvents() __MSRCXOpNoArgs(RCX_ClearAllEventsOp)
#define MSRCXSetOutput(_outputs, _mode) __MSRCXSetOutput(_outputs, _mode)
#define MSRCXSetDirection(_outputs, _dir) __MSRCXSetDirection(_outputs, _dir)
#define MSRCXSetPower(_outputs, _pwrsrc, _pwrval) __MSRCXSetPower(_outputs, _pwrsrc, _pwrval)
#define MSRCXOn(_outputs) __MSRCXSetOutput(_outputs, RCX_OUT_ON)
#define MSRCXOff(_outputs) __MSRCXSetOutput(_outputs, RCX_OUT_OFF)
#define MSRCXFloat(_outputs) __MSRCXSetOutput(_outputs, RCX_OUT_FLOAT)
#define MSRCXToggle(_outputs) __MSRCXSetDirection(_outputs, RCX_OUT_TOGGLE)
#define MSRCXFwd(_outputs) __MSRCXSetDirection(_outputs, RCX_OUT_FWD)
#define MSRCXRev(_outputs) __MSRCXSetDirection(_outputs, RCX_OUT_REV)
#define MSRCXOnFwd(_outputs) __MSRCXOnFwd(_outputs)
#define MSRCXOnRev(_outputs) __MSRCXOnRev(_outputs)
#define MSRCXOnFor(_outputs, _ms) __MSRCXOnFor(_outputs, _ms)
#define MSRCXSetTxPower(_pwr) __MSRCXSetTxPower(_pwr)
#define MSRCXPlaySound(_snd) __MSRCXPlaySound(_snd)
#define MSRCXDeleteTask(_t) __MSRCXDeleteTask(_t)
#define MSRCXStartTask(_t) __MSRCXStartTask(_t)
#define MSRCXStopTask(_t) __MSRCXStopTask(_t)
#define MSRCXSelectProgram(_prog) __MSRCXSelectProgram(_prog)
#define MSRCXClearTimer(_timer) __MSRCXClearTimer(_timer)
#define MSRCXSetSleepTime(_t) __MSRCXSetSleepTime(_t)
#define MSRCXDeleteSub(_s) __MSRCXDeleteSub(_s)
#define MSRCXClearSensor(_port) __MSRCXClearSensor(_port)
#define MSRCXPlayToneVar(_varnum, _duration) __MSRCXPlayToneVar(_varnum, _duration)
#define MSRCXSetWatch(_hours, _minutes) __MSRCXSetWatch(_hours, _minutes)
#define MSRCXSetSensorType(_port, _type) __MSRCXSetSensorType(_port, _type)
#define MSRCXSetSensorMode(_port, _mode) __MSRCXSetSensorMode(_port, _mode)
#define MSRCXCreateDatalog(_size) __MSRCXCreateDatalog(_size)
#define MSRCXAddToDatalog(_src, _value) __MSRCXAddToDatalog(_src, _value)
#define MSRCXSendSerial(_first, _count) __MSRCXSendSerial(_first, _count)
#define MSRCXRemote(_cmd) __MSRCXRemote(_cmd)
#define MSRCXEvent(_src, _value) __MSRCXEvent(_src, _value)
#define MSRCXPlayTone(_freq, _duration) __MSRCXPlayTone(_freq, _duration)
#define MSRCXSelectDisplay(_src, _value) __MSRCXSelectDisplay(_src, _value)
#define MSRCXPollMemory(_address, _result) __MSRCXPollMemory(_address, _result)
#define MSRCXSetEvent(_evt, _src, _type) __MSRCXSetEvent(_evt, _src, _type)
#define MSRCXSetGlobalOutput(_outputs, _mode) __MSRCXSetGlobalOutput(_outputs, _mode)
#define MSRCXSetGlobalDirection(_outputs, _dir) __MSRCXSetGlobalDirection(_outputs, _dir)
#define MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval) __MSRCXSetMaxPower(_outputs, _pwrsrc, _pwrval)
#define MSRCXEnableOutput(_outputs) __MSRCXSetGlobalOutput(_outputs, RCX_OUT_ON)
#define MSRCXDisableOutput(_outputs) __MSRCXSetGlobalOutput(_outputs, RCX_OUT_OFF)
#define MSRCXInvertOutput(_outputs) __MSRCXSetGlobalDirection(_outputs, RCX_OUT_REV)
#define MSRCXObvertOutput(_outputs) __MSRCXSetGlobalDirection(_outputs, RCX_OUT_FWD)
#define MSRCXCalibrateEvent(_evt, _low, _hi, _hyst) __MSRCXCalibrateEvent(_evt, _low, _hi, _hyst)
#define MSRCXSetVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SetVarOp, _varnum, _src, _value)
#define MSRCXSumVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SumVarOp, _varnum, _src, _value)
#define MSRCXSubVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SubVarOp, _varnum, _src, _value)
#define MSRCXDivVar(_varnum, _src, _value) __MSRCXVarOp(RCX_DivVarOp, _varnum, _src, _value)
#define MSRCXMulVar(_varnum, _src, _value) __MSRCXVarOp(RCX_MulVarOp, _varnum, _src, _value)
#define MSRCXSgnVar(_varnum, _src, _value) __MSRCXVarOp(RCX_SgnVarOp, _varnum, _src, _value)
#define MSRCXAbsVar(_varnum, _src, _value) __MSRCXVarOp(RCX_AbsVarOp, _varnum, _src, _value)
#define MSRCXAndVar(_varnum, _src, _value) __MSRCXVarOp(RCX_AndVarOp, _varnum, _src, _value)
#define MSRCXOrVar(_varnum, _src, _value) __MSRCXVarOp(RCX_OrVarOp, _varnum, _src, _value)
#define MSRCXSet(_dstsrc, _dstval, _src, _value) __MSRCXSet(_dstsrc, _dstval, _src, _value)
#define MSRCXUnlock() __MSRCXUnlock()
#define MSRCXReset() __MSRCXReset()
#define MSRCXBoot() __MSRCXBoot()
#define MSRCXSetUserDisplay(_src, _value, _precision) __MSRCXSetUserDisplay(_src, _value, _precision)
#define MSRCXIncCounter(_counter) __MSRCXIncCounter(_counter)
#define MSRCXDecCounter(_counter) __MSRCXDecCounter(_counter)
#define MSRCXClearCounter(_counter) __MSRCXClearCounter(_counter)
#define MSRCXSetPriority(_p) __MSRCXSetPriority(_p)
#define MSRCXSetMessage(_msg) __MSRCXSetMessage(_msg)


#define __MSRCXSetNRLink(_port, _addr) \
  set __gRCXCmd.Port, _port \
  set __gRCXCmd.Address, _addr

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
  wait _ms \
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

#define __MSRCXPollMemory(_address, _result) \
  acquire __RCXCmdMutex \
  and __MSRCSTmpByte, _address, 0xFF \
  div __MSRCSTmpByte2, _address, 256 \
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

#define MSScoutCalibrateSensor() __MSRCXOpNoArgs(RCX_LSCalibrateOp)
#define MSScoutMuteSound() __MSScoutMuteSound()
#define MSScoutUnmuteSound() __MSScoutUnmuteSound()
#define MSScoutSelectSounds(_grp) __MSScoutSelectSounds(_grp)
#define MSScoutSetLight(_x) __MSScoutSetLight(_x)
#define MSScoutSetCounterLimit(_ctr, _src, _value) __MSScoutSetCounterLimit(_ctr, _src, _value)
#define MSScoutSetTimerLimit(_tmr, _src, _value) __MSScoutSetTimerLimit(_tmr, _src, _value)
#define MSScoutSetSensorClickTime(_src, _value) __MSScoutSetSensorClickTime(_src, _value)
#define MSScoutSetSensorHysteresis(_src, _value) __MSScoutSetSensorHysteresis(_src, _value)
#define MSScoutSetSensorLowerLimit(_src, _value) __MSScoutSetSensorLowerLimit(_src, _value)
#define MSScoutSetSensorUpperLimit(_src, _value) __MSScoutSetSensorUpperLimit(_src, _value)
#define MSScoutSetEventFeedback(_src, _value) __MSScoutSetEventFeedback(_src, _value)
#define MSScoutSendVLL(_src, _value) __MSScoutSendVLL(_src, _value)
#define MSScoutSetScoutRules(_m, _t, _l, _tm, _fx) __MSScoutSetScoutRules(_m, _t, _l, _tm, _fx)
#define MSScoutSetScoutMode(_mode) __MSScoutSetScoutMode(_mode)

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


#define SetSensorTemperature(_port) SetSensorLowspeed(_port)

#define __TempSendCmd(_port, _cmd, _result) \
  __MSWriteToRegister(_port, TEMP_I2C_ADDRESS, TEMP_REG_CONFIG, _cmd, _result)

#define TemperatureResolution(_port, _cmd, _result) __TempSendCmd(_port, _cmd, _result)

/*
// R1/R0
#define TEMP_RES_12BIT     0x60
#define TEMP_RES_11BIT     0x40
#define TEMP_RES_10BIT     0x20
#define TEMP_RES_9BIT      0x00
// SD (shutdown mode)
#define TEMP_SD_CONTINUOUS 0x00
#define TEMP_SD_SHUTDOWN   0x01
// TM (thermostat mode)
#define TEMP_TM_COMPARATOR 0x00
#define TEMP_TM_INTERRUPT  0x02
// OS (one shot)
#define TEMP_OS_ONESHOT    0x80
// F1/F0 (fault queue)
#define TEMP_FQ_1          0x00
#define TEMP_FQ_2          0x08
#define TEMP_FQ_4          0x10
#define TEMP_FQ_6          0x18
// POL (polarity)
#define TEMP_POL_LOW       0x00
#define TEMP_POL_HIGH      0x04

#define TEMP_I2C_ADDRESS   0x98
#define TEMP_REG_TEMP      0x00
#define TEMP_REG_CONFIG    0x01
#define TEMP_REG_TLOW      0x02
#define TEMP_REG_THIGH     0x03
*/

;-----------------------------------------------------------------------------------------
; File          : nbcGL.nbc
; Description   : Data and subroutines for a very simple 3D engine.
; Programmed by : Arno van der Vegt, avandervegt@home.nl
;-----------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------
; Public definitions...
;-----------------------------------------------------------------------------------------
#define glInit() __glInit()
#define glSet(_glType, _glValue) __glSet(_glType, _glValue)
#define glBeginObject(_glObjId) __glBeginObject(_glObjId)
#define glEndObject() __glEndObject()
#define glObjectAction(_glObjectId, _glAction, _glValue) __glObjectAction(_glObjectId, _glAction, _glValue)
#define glAddVertex(_glX, _glY, _glZ) __glAddVertex(_glX, _glY, _glZ)
#define glBegin(_glBeginMode) __glBegin(_glBeginMode)
#define glEnd() __glEnd()
#define glBeginRender() __glBeginRender()
#define glCallObject(_glObjectId) __glCallObject(_glObjectId)
#define glFinishRender() __glFinishRender()
#define glSetAngleX(_glValue) __glSetAngleX(_glValue)
#define glAddToAngleX(_glValue) __glAddToAngleX(_glValue)
#define glSetAngleY(_glValue) __glSetAngleY(_glValue)
#define glAddToAngleY(_glValue) __glAddToAngleY(_glValue)
#define glSetAngleZ(_glValue) __glSetAngleZ(_glValue)
#define glAddToAngleZ(_glValue) __glAddToAngleZ(_glValue)
#define glSin32768(_glAngle, _glResult) __glSin32768(_glAngle, _glResult)
#define glCos32768(_glAngle, _glResult) __glCos32768(_glAngle, _glResult)
#define glBox(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId) __glBox(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId)
#define glPyramid(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId) __glPyramid(_glMode, _glSizeX, _glSizeY, _glSizeZ, _glObjId)
#define glCube(_glMode, _glSize, _glObjId) __glBox(_glMode, _glSize, _glSize, _glSize, _glObjId)

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
         mov      __GL_angle,            _glAngle                                              \
         mod      __GL_angle,            __GL_angle, 360                                       \
         index    _glResult,             __GL_SIN_TABLE, __GL_angle

#define __glCos32768(_glAngle, _glResult)                                                      \
         mov      __GL_angle,            _glAngle                                              \
         add      __GL_angle,            __GL_angle, 90                                        \
         mod      __GL_angle,            __GL_angle, 360                                       \
         index    _glResult,             __GL_SIN_TABLE, __GL_angle

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

;-----------------------------------------------------------------------------------------
;
; Private definitions...
;
;-----------------------------------------------------------------------------------------
#define __glRangeCheck(_glValue, _glMaxValue, _glErrorMsg)                                     \
         mov      __GL_glRangeValue,          _glValue                                         \
         mov      __GL_glRangeMaxValue,       _glMaxValue                                      \
         mov      __GL_glRangeErrorMsg,       _glErrorMsg                                      \
         call     __GL_glRangeCheck

; Data sizes...
#define __GL_MAX_VERTICES       128
#define __GL_MAX_LINES          128
#define __GL_MAX_POLYGONS        64
#define __GL_MAX_OBJECT_ACTIONS  16
#define __GL_MAX_OBJECTS          8
#define __GL_MAX_PV_DATA        128
#define __GL_MAX_PL_DATA        128

dseg segment
  ; Sine table constants...
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

  ; General stuff, copied from NXTDefs.h...
  __GL_glDrawLine        TDrawLine
  __GL_glDrawPoint       TDrawPoint
  __GL_glDrawCircle      TDrawCircle
  __GL_glDrawData        TDrawText

  ; settings...
  TGLSettings struct
    cullMode         byte
    circleSize       byte
    camDepth         byte
    zoom             byte
  TGLSettings ends

  __GL_glSettings        TGLSettings
  __GL_glSettingType     byte
  __GL_glSettingValue    byte

  ; Vertex data...
  TGLVertex struct
    x                sdword
    y                sdword
    z                sdword
  TGLVertex ends

  TGLScreenVertex struct
    x                sdword
    y                sdword
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

  ; Line data...
  TGLLine struct
    firstVertex      byte
    lastVertex       byte
  TGLLine ends

  __GL_lineData          TGLLine[]
  __GL_line              TGLLine
  __GL_lineCount         byte
  __GL_lineIndex         byte
  __GL_lineDone          byte[]

  ; Polygon data...
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

  ; Polygon/vertex link...
  __GL_pvData            byte[]
  __GL_pvDataCount       byte

  ; Polygon/line link...
  __GL_plData            byte[]
  __GL_plDataCount       byte

  ; Object action...
  TGLObjectAction struct
    type             byte
    value            sdword
;    fsin             float
;    fcos             float
    lsin             sdword
    lcos             sdword
  TGLObjectAction ends

  __GL_objectAction      TGLObjectAction
  __GL_objectActionData  TGLObjectAction[]
  __GL_objectActionCount byte

  ; Object data...
  TObject struct
    firstVertex      byte
    lastVertex       byte
    firstPolygon     byte
    lastPolygon      byte
    firstLine        byte
    lastLine         byte
    render           byte
    
    ; settings...
    circleSize       byte
    cullMode         byte

    actionCount      byte
    actionList       byte[]
  TObject ends

  __GL_objectData        TObject[]
  __GL_object            TObject
  __GL_objectCount       byte
  __GL_objectIndex       byte

  ; Temp offset...
  __GL_offset            word

  ; Counters...
  __GL_i                 word
  __GL_j                 word
  __GL_k                 word
  __GL_l                 word

  ; Angles...
  __GL_angleX            sdword
  __GL_angleY            sdword
  __GL_angleZ            sdword
  
  ; Save angles...
  __GL_saveAngleX        sdword
  __GL_saveAngleY        sdword
  __GL_saveAngleZ        sdword

  __GL_sinX              sdword
  __GL_cosX              sdword
  __GL_sinY              sdword
  __GL_cosY              sdword
  __GL_sinZ              sdword
  __GL_cosZ              sdword
;  __GL_sinX              float
;  __GL_cosX              float
;  __GL_sinY              float
;  __GL_cosY              float
;  __GL_sinZ              float
;  __GL_cosZ              float

  ; Temp vars for calculations...
  __GL_a                 sdword
  __GL_b                 sdword
  __GL_c                 sdword
  __GL_d                 sdword
  __GL_e                 sdword
  __GL_f                 sdword

  ; Rotated x, y, z coords...
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
  
  ; data for filling polygons...
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
  __GL_value             sdword
  __GL_type              sdword
  
  ; rangecheck data...
  __GL_glRangeValue      word
  __GL_glRangeMaxValue   word
  __GL_glRangeErrorMsg   byte[]

  __GL_glErrorState      byte FALSE
  __GL_glErrorMsg        byte[]
  
  __GL_glLinesClipped    byte
dseg ends

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glRangeCheck
; Description : Check array sizes.
;-----------------------------------------------------------------------------------------
subroutine __GL_glRangeCheck
  ; check if there's an already error...
  brcmp    EQ,                     __GL_nbc_gl_range_ok, __GL_glErrorState, TRUE
  ; check the range...
  brcmp    LT,                     __GL_nbc_gl_range_ok, __GL_glRangeValue, __GL_glRangeMaxValue
  set      __GL_glErrorState,      TRUE
  mov      __GL_glErrorMsg,        __GL_glRangeErrorMsg
__GL_nbc_gl_range_ok:
  return
ends

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glInit
; Description : Initialize vars.
;-----------------------------------------------------------------------------------------
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

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glSet
; Description : Change settings.
;-----------------------------------------------------------------------------------------
subroutine __GL_glSet
  brcmp    EQ,                     __GL_nbc_gl_set_circle_size,  __GL_glSettingType, GL_CIRCLE_SIZE
  brcmp    EQ,                     __GL_nbc_gl_set_cull_mode,    __GL_glSettingType, GL_CULL_MODE
  brcmp    EQ,                     __GL_nbc_gl_set_camera_depth, __GL_glSettingType, GL_CAMERA_DEPTH
  brcmp    EQ,                     __GL_nbc_gl_set_zoom_factor,  __GL_glSettingType, GL_ZOOM_FACTOR
  ; unknown setting...
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

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glAddVertex
; Description : Check if there's an existing vertex with the same (x,y,z) coord.
;               If there's an existing vertex found then return the index to that vertex
;               else add the vertex to the list and return the index of the added vertex.
;-----------------------------------------------------------------------------------------
subroutine __GL_glAddVertex
  brcmp    EQ,                      __GL_nbc_gl_add_vertex_error, __GL_glErrorState, TRUE
  ; check if the list is empty...
  brcmp    EQ,                      __GL_nbc_gl_empty_vertex_list, __GL_vertexCount, 0
  ; loop through the list...
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
  ; there's no matching vertex found, add a new vertex to the list...
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

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glEnd
; Description : Store the polygon data, call __GL_glAddLines to optimize lines list.
;-----------------------------------------------------------------------------------------
subroutine __GL_glEnd
  brcmp    EQ,                     __GL_nbc_gl_end_error, __GL_glErrorState, TRUE
  call     __GL_glAddLines
  replace  __GL_polygonData,       __GL_polygonData, __GL_polygonCount, __GL_polygon
  add      __GL_polygonCount,      __GL_polygonCount, 1
__GL_nbc_gl_end_error:
  return
ends

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glAddLines
; Description : Add the lines of the polygon and check if the line already exists.
;               Each line should be rendered only once.
;-----------------------------------------------------------------------------------------
subroutine __GL_glAddLines
  brcmp    EQ,                     __GL_nbc_gl_add_lines_error, __GL_glErrorState, TRUE
  mov      __GL_polygon.firstLine, __GL_plDataCount
  ; loop through polygon vertex the list...
  mov      __GL_i,                 __GL_polygon.firstVertex
__GL_nbc_gl_find_lines1:
  add      __GL_j,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_find_lines_modj, __GL_j, __GL_polygon.lastVertex
  mov      __GL_j,                 __GL_polygon.firstVertex
  ; if the beginMode is GL_LINE then don't close the polygon...
  brcmp    EQ,                     __GL_nbc_gl_add_line_done2, __GL_polygon.beginMode, GL_LINE
__GL_nbc_gl_find_lines_modj:
  ; _a = _pvData[_i]
  index    __GL_a,                 __GL_pvData, __GL_i
  ; _b = _pvData[_j]
  index    __GL_b,                 __GL_pvData, __GL_j
  ; check if the list is empty...
  brcmp    EQ,                     __GL_nbc_empty_lines_list, __GL_lineCount, 0
  ; loop through the line list to find a matching line...
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
  ; _lineData[_lineCount] = _line
  replace  __GL_lineData,          __GL_lineData, __GL_lineCount, __GL_line
  mov      __GL_lineIndex,         __GL_lineCount
  add      __GL_lineCount,         __GL_lineCount, 1
__GL_nbc_gl_add_line_done1:
  __glRangeCheck(__GL_plDataCount, __GL_MAX_PL_DATA, 'Too many poly-lines')
  brcmp    EQ,                     __GL_nbc_gl_add_lines_error, __GL_glErrorState, TRUE
  ; _plData[_plDataCount] = _lineIndex
  replace  __GL_plData,            __GL_plData, __GL_plDataCount, __GL_lineIndex
  add      __GL_plDataCount,       __GL_plDataCount, 1
  add      __GL_i,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_find_lines1, __GL_i, __GL_polygon.lastVertex
__GL_nbc_gl_add_line_done2:
  mov      __GL_polygon.lastLine,  __GL_plDataCount
__GL_nbc_gl_add_lines_error:
  return
ends

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glEndObject
; Description : Save the last polygon number, store the object in the objectlist.
;-----------------------------------------------------------------------------------------
subroutine __GL_glEndObject
  brcmp    EQ,                      __GL_nbc_gl_end_object_error, __GL_glErrorState, TRUE
  mov      __GL_object.lastPolygon, __GL_polygonCount
  replace  __GL_objectData,         __GL_objectData, __GL_objectCount, __GL_object
  add      __GL_objectCount,        __GL_objectCount, 1
__GL_nbc_gl_end_object_error:
  return
ends

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glObjectAction
; Description : Add an action to the object...
;-----------------------------------------------------------------------------------------
subroutine __GL_glObjectAction
  index    __GL_object,             __GL_objectData, __GL_objectIndex
  mov      __GL_objectAction.type,  __GL_action
  mov      __GL_objectAction.value, __GL_value
  brcmp    EQ,                      __GL_nbc_gl_action_rotate, __GL_action, GL_ROTATE_X
  brcmp    EQ,                      __GL_nbc_gl_action_rotate, __GL_action, GL_ROTATE_Y
  brcmp    EQ,                      __GL_nbc_gl_action_rotate, __GL_action, GL_ROTATE_Z
  jmp      __GL_nbc_gl_action_no_rotate
__GL_nbc_gl_action_rotate:
  ; if the action is a rotation of any kind then grab the sin and cos of the angle
  mod      __GL_value,              __GL_value, 360
;  sind     __GL_objectAction.fsin,  __GL_value
;  cosd     __GL_objectAction.fcos,  __GL_value
  index    __GL_objectAction.lsin,  __GL_SIN_TABLE, __GL_value
  add      __GL_value,              __GL_value, 90
  mod      __GL_value,              __GL_value, 360
  index    __GL_objectAction.lcos,  __GL_SIN_TABLE, __GL_value
__GL_nbc_gl_action_no_rotate:
  __glRangeCheck(__GL_object.actionCount, __GL_MAX_OBJECT_ACTIONS, 'Too many object-actions')
  brcmp    EQ,                      __GL_nbc_gl_add_object_error, __GL_glErrorState, TRUE
  ; _object.actionList[_object.actionCount] = _objectActionCount
  replace  __GL_object.actionList,  __GL_object.actionList, __GL_object.actionCount, __GL_objectActionCount
  add      __GL_object.actionCount, __GL_object.actionCount, 1
  replace  __GL_objectData,         __GL_objectData, __GL_objectIndex, __GL_object
  __glRangeCheck(__GL_objectActionCount, __GL_MAX_OBJECT_ACTIONS, 'Too many object-actions')
  brcmp    EQ,                      __GL_nbc_gl_add_object_error, __GL_glErrorState, TRUE
  ; _objectActionData[_objectActionCount] = _objectAction
  replace  __GL_objectActionData,   __GL_objectActionData, __GL_objectActionCount, __GL_objectAction
  add      __GL_objectActionCount,  __GL_objectActionCount, 1
__GL_nbc_gl_add_object_error:
  return
ends

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glRotateObject
; Description : Check the object actions and apply them to the object...
;-----------------------------------------------------------------------------------------
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
  ; _objectAction = _objectActionData[_object.actionData[_j]]
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

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glRotateVertexList
; Description : Rotate all the vertices in the vertext list...
;-----------------------------------------------------------------------------------------
subroutine __GL_glRotateVertexList
  ; update all object actions first...
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
  ; get the values from the vertex list...
  index    __GL_vertex0,           __GL_vertexData, __GL_vertexOffset
  ; z1 = (_vertex0.rot.z * _cosY) - (_vertex0.rot.x * _sinY)
  mul      __GL_a,                 __GL_vertex0.rot.z, __GL_cosY
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_vertex0.rot.x, __GL_sinY
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_z1,                __GL_a, __GL_b
  ; xx = (_vertex0.rot.z * _sinY) + (_vertex0.rot.x * _cosY)
  mul      __GL_a,                 __GL_vertex0.rot.z, __GL_sinY
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_vertex0.rot.x, __GL_cosY
  shr      __GL_b,                 __GL_b, 15
  add      __GL_xx,                __GL_a, __GL_b
  ; zz = (_vertex0.rot.y * _sinX) + (_z1 * _cosX) + _zoom
  mul      __GL_a,                 __GL_vertex0.rot.y, __GL_sinX
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_z1, __GL_cosX
  shr      __GL_b,                 __GL_b, 15
  add      __GL_zz,                __GL_a, __GL_b
  add      __GL_zz,                __GL_zz, __GL_zoom
  ; yy = (_vertex0.rot.y * cosX) - (z1 * sinX)
  mul      __GL_a,                 __GL_vertex0.rot.y, __GL_cosX
  shr      __GL_a,                 __GL_a, 15
  mul      __GL_b,                 __GL_z1, __GL_sinX
  shr      __GL_b,                 __GL_b, 15
  sub      __GL_yy,                __GL_a, __GL_b
  ; the actual screen coords...
  add      __GL_zz,                __GL_zz, __GL_camDepth
  ; _vertex0.screen.sx = width  + (x * camDepth) / (zz + camDepth));
  ; _vertex0.screen.sy = height - (y * camDepth) / (zz + camDepth));
  mul      __GL_vertex0.screen.x,  __GL_xx, __GL_camDepth
  div      __GL_vertex0.screen.x,  __GL_vertex0.screen.x, __GL_zz
  add      __GL_vertex0.screen.x,  __GL_vertex0.screen.x, 50
  mul      __GL_vertex0.screen.y,  __GL_yy, __GL_camDepth
  div      __GL_vertex0.screen.y,  __GL_vertex0.screen.y, __GL_zz
  sub      __GL_vertex0.screen.y,  32, __GL_vertex0.screen.y
  ; save the screen coords...
  replace  __GL_vertexData,        __GL_vertexData, __GL_vertexOffset, __GL_vertex0
  add      __GL_vertexOffset,      __GL_vertexOffset, 1
  add      __GL_i,                 __GL_i, 1
  brcmp    LT,                     __GL_nbc_gl_rotate_loop, __GL_i, __GL_vertexCount
  mov      __GL_angleX,            __GL_saveAngleX
  mov      __GL_angleY,            __GL_saveAngleY
  return
ends

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glResetObjects
; Description : Reset the rotate, translate and scale actions for all objects...
;-----------------------------------------------------------------------------------------
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

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glCallObject
; Description : Set the render boolean, copy the settings...
;-----------------------------------------------------------------------------------------
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

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glDrawObject
; Description : Draw the object, this routine expects the '_object' struct to be set.
;-----------------------------------------------------------------------------------------
subroutine __GL_glDrawObject
  ; set once...
  mov      __GL_glDrawLine.Options,     0
  ; loop through the polygon list for this object...
  mov      __GL_i,                      __GL_object.firstPolygon
__GL_nbc_gl_draw_polygons:
  ; get the information for the polygon...
  index    __GL_polygon,                __GL_polygonData, __GL_i
  brcmp    EQ,                          __GL_nbc_gl_render_polygon, __GL_polygon.beginMode, GL_POLYGON
  brcmp    EQ,                          __GL_nbc_gl_render_line,    __GL_polygon.beginMode, GL_LINE
  brcmp    EQ,                          __GL_nbc_gl_render_point,   __GL_polygon.beginMode, GL_POINT
  brcmp    EQ,                          __GL_nbc_gl_render_circle,  __GL_polygon.beginMode, GL_CIRCLE
  jmp      __GL_nbc_gl_cull_polygon
  ;---------------------------------------------------------------------------------------
  ; Render a polygon...
  ;---------------------------------------------------------------------------------------
__GL_nbc_gl_render_polygon:
  ; loop through the vertex list for this polygon...
  mov      __GL_j,                      __GL_polygon.firstVertex
  mov      __GL_k,                      __GL_polygon.lastVertex
  ; _vertex0 = _vertexData[_pvData[j]]
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex0,                __GL_vertexData, __GL_vertexOffset
  ; _vertex1 = _vertexData[_pvData[j + 1]]
  add      __GL_j,                      __GL_j, 1
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex1,                __GL_vertexData, __GL_vertexOffset
  ; _vertex2 = _vertexData[_pvData[j + 2]]
  add      __GL_j,                      __GL_j, 1
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex2,                __GL_vertexData, __GL_vertexOffset
  ; check if culling is enabled...
  brcmp    EQ,                          __GL_nbc_gl_no_culling, __GL_object.cullMode, GL_CULL_NONE
  ; calculate the culling...
  ; ((x1 - x0) * (y2 - y0) >= (x2 - x0) * (y1 - y0))
  sub      __GL_a,                      __GL_vertex1.screen.x, __GL_vertex0.screen.x
  sub      __GL_b,                      __GL_vertex2.screen.y, __GL_vertex0.screen.y
  mul      __GL_c,                      __GL_a, __GL_b
  sub      __GL_d,                      __GL_vertex2.screen.x, __GL_vertex0.screen.x
  sub      __GL_e,                      __GL_vertex1.screen.y, __GL_vertex0.screen.y
  mul      __GL_f,                      __GL_d, __GL_e
  ; check if culling is enabled...
  brcmp    EQ,                          __GL_nbc_gl_check_front_cull, __GL_object.cullMode, GL_CULL_FRONT
  brcmp    GTEQ,                        __GL_nbc_gl_cull_polygon, __GL_c, __GL_f
  jmp      __GL_nbc_gl_no_culling
__GL_nbc_gl_check_front_cull:
  brcmp    GTEQ,                        __GL_nbc_gl_cull_polygon, __GL_f, __GL_c
__GL_nbc_gl_no_culling:
  ;--> render the lines...
  mov      __GL_j,                      __GL_polygon.firstLine
__GL_nbc_gl_draw_lines:
  ; _k = _plData[_j]
  index    __GL_k,                      __GL_plData, __GL_j
  ; render every line only once!
  ; _l = _lineDone[_k]
  index    __GL_l,                      __GL_lineDone, __GL_k
  brcmp    EQ,                          __GL_nbc_gl_line_done, __GL_l, 1
  ; set the 'done' byte...
  replace  __GL_lineDone,               __GL_lineDone, 1, __GL_l
  ; _line = _lineData[_k]
  index    __GL_line,                   __GL_lineData, __GL_k
  ; _vertex1 = _vertexData[_line.firstVertex]
  index    __GL_vertex1,                __GL_vertexData, __GL_line.firstVertex
  ; _vertex1 = _vertexData[_line.lastVertex]
  index    __GL_vertex2,                __GL_vertexData, __GL_line.lastVertex
  ; very crude clipping...
  add      __GL_glLinesClipped,         __GL_glLinesClipped, 1
  brcmp    LT,                          __GL_nbc_gl_line_done, __GL_vertex1.screen.x,  0
  brcmp    LT,                          __GL_nbc_gl_line_done, __GL_vertex2.screen.x,  0
  brcmp    LT,                          __GL_nbc_gl_line_done, __GL_vertex1.screen.y,  0
  brcmp    LT,                          __GL_nbc_gl_line_done, __GL_vertex2.screen.y,  0
  brcmp    GT,                          __GL_nbc_gl_line_done, __GL_vertex1.screen.x, 99
  brcmp    GT,                          __GL_nbc_gl_line_done, __GL_vertex2.screen.x, 99
  brcmp    GT,                          __GL_nbc_gl_line_done, __GL_vertex1.screen.y, 63
  brcmp    GT,                          __GL_nbc_gl_line_done, __GL_vertex2.screen.y, 63
  sub      __GL_glLinesClipped,         __GL_glLinesClipped, 1
  mov      __GL_glDrawLine.StartLoc.X,  __GL_vertex1.screen.x
  mov      __GL_glDrawLine.StartLoc.Y,  __GL_vertex1.screen.y
  mov      __GL_glDrawLine.EndLoc.X,    __GL_vertex2.screen.x
  mov      __GL_glDrawLine.EndLoc.Y,    __GL_vertex2.screen.y
  syscall  DrawLine,                    __GL_glDrawLine
__GL_nbc_gl_line_done:
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_draw_lines, __GL_j, __GL_polygon.lastLine
  ;<-- render the lines...
  jmp      __GL_nbc_gl_cull_polygon
  ;---------------------------------------------------------------------------------------
  ; Render lines...
  ;---------------------------------------------------------------------------------------
__GL_nbc_gl_render_line:
  mov      __GL_j,                      __GL_polygon.firstLine
__GL_nbc_gl_render_lines:
  ; _k = _plData[_j]
  index    __GL_k,                      __GL_plData, __GL_j
  ; render every line only once!
  ; _l = _lineDone[_k]
  index    __GL_l,                      __GL_lineDone, __GL_k
  brcmp    EQ,                          __GL_nbc_gl_render_lines_done, __GL_l, 1
  ; set the 'done' byte...
  replace  __GL_lineDone,               __GL_lineDone, 1, __GL_l
  ; _line = _lineData[_k]
  index    __GL_line,                   __GL_lineData, __GL_k
  ; _vertex1 = _vertexData[_line.firstVertex]
  index    __GL_vertex1,                __GL_vertexData, __GL_line.firstVertex
  ; _vertex1 = _vertexData[_line.lastVertex]
  index    __GL_vertex2,                __GL_vertexData, __GL_line.lastVertex
  mov      __GL_glDrawLine.StartLoc.X,  __GL_vertex1.screen.x
  mov      __GL_glDrawLine.StartLoc.Y,  __GL_vertex1.screen.y
  mov      __GL_glDrawLine.EndLoc.X,    __GL_vertex2.screen.x
  mov      __GL_glDrawLine.EndLoc.Y,    __GL_vertex2.screen.y
  syscall  DrawLine,                    __GL_glDrawLine
__GL_nbc_gl_render_lines_done:
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_render_lines, __GL_j, __GL_polygon.lastLine
  jmp      __GL_nbc_gl_cull_polygon
  ;---------------------------------------------------------------------------------------
  ; Render points...
  ;---------------------------------------------------------------------------------------
__GL_nbc_gl_render_point:
  set      __GL_glDrawPoint.Options,    0
  mov      __GL_j,                      __GL_polygon.firstVertex
__GL_nbc_gl_render_points:
  ; _vertex0 = _vertexData[_pvData[j]]
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex0,                __GL_vertexData, __GL_vertexOffset
  mov      __GL_glDrawPoint.Location.X, __GL_vertex0.screen.x
  mov      __GL_glDrawPoint.Location.Y, __GL_vertex0.screen.y
  syscall  DrawPoint,                   __GL_glDrawPoint
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_render_points, __GL_j, __GL_polygon.lastVertex
  jmp      __GL_nbc_gl_cull_polygon
  ;---------------------------------------------------------------------------------------
  ; Render circle...
  ;---------------------------------------------------------------------------------------
__GL_nbc_gl_render_circle:
  set      __GL_glDrawCircle.Options,   0
  mov      __GL_glDrawCircle.Size,      __GL_object.circleSize
  mov      __GL_j,                      __GL_polygon.firstVertex
__GL_nbc_gl_render_circles:
  ; _vertex0 = _vertexData[_pvData[j]]
  index    __GL_vertexOffset,           __GL_pvData, __GL_j
  index    __GL_vertex0,                __GL_vertexData, __GL_vertexOffset
  mov      __GL_glDrawCircle.Center.X,  __GL_vertex0.screen.x
  mov      __GL_glDrawCircle.Center.Y,  __GL_vertex0.screen.y
  syscall  DrawCircle,                  __GL_glDrawCircle
  add      __GL_j,                      __GL_j, 1
  brcmp    LT,                          __GL_nbc_gl_render_circles, __GL_j, __GL_polygon.lastVertex
  jmp      __GL_nbc_gl_cull_polygon
__GL_nbc_gl_cull_polygon:
  add      __GL_i,                      __GL_i, 1
  brcmp    LT,                          __GL_nbc_gl_draw_polygons, __GL_i, __GL_object.lastPolygon
  return
ends

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glRenderObjects
; Description : Draw all objects which have been called...
;-----------------------------------------------------------------------------------------
subroutine __GL_glRenderObjects
  brcmp    EQ,                          __GL_nbc_gl_render_objects_error, __GL_glErrorState, TRUE
  set      __GL_objectIndex,            0
__GL_nbc_gl_render_objects:
  ; get the information for the object...
  index    __GL_object,                 __GL_objectData, __GL_objectIndex
  brcmp    EQ,                          __GL_nbc_gl_dont_render_object, __GL_object.render, FALSE
  call     __GL_glDrawObject
__GL_nbc_gl_dont_render_object:
  add      __GL_objectIndex,            __GL_objectIndex, 1
  brcmp    LT,                          __GL_nbc_gl_render_objects, __GL_objectIndex, __GL_objectCount
  return
__GL_nbc_gl_render_objects_error:
  ; Display the error message...
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

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glBox
; Description : Add a box with the dimensions: _sizeX, _sizeY, _sizeZ.
;               Use mode _mode.
;-----------------------------------------------------------------------------------------
subroutine __GL_glBox
  shr      __GL_x1,                    __GL_sizeX, 1
  neg      __GL_x0,                    __GL_x1
  shr      __GL_y1,                    __GL_sizeY, 1
  neg      __GL_y0,                    __GL_y1
  shr      __GL_z1,                    __GL_sizeZ, 1
  neg      __GL_z0,                    __GL_z1
  glBeginObject(__GL_tmpId)
    glBegin(__GL_mode)
      glAddVertex(__GL_x0, __GL_y0, __GL_z0)
      glAddVertex(__GL_x1, __GL_y0, __GL_z0)
      glAddVertex(__GL_x1, __GL_y1, __GL_z0)
      glAddVertex(__GL_x0, __GL_y1, __GL_z0)
    glEnd()
    glBegin(__GL_mode)
      glAddVertex(__GL_x0, __GL_y1, __GL_z1)
      glAddVertex(__GL_x1, __GL_y1, __GL_z1)
      glAddVertex(__GL_x1, __GL_y0, __GL_z1)
      glAddVertex(__GL_x0, __GL_y0, __GL_z1)
    glEnd()

    glBegin(__GL_mode)
      glAddVertex(__GL_x0, __GL_y1, __GL_z0)
      glAddVertex(__GL_x0, __GL_y1, __GL_z1)
      glAddVertex(__GL_x0, __GL_y0, __GL_z1)
      glAddVertex(__GL_x0, __GL_y0, __GL_z0)
    glEnd()
    glBegin(__GL_mode)
      glAddVertex(__GL_x1, __GL_y0, __GL_z0)
      glAddVertex(__GL_x1, __GL_y0, __GL_z1)
      glAddVertex(__GL_x1, __GL_y1, __GL_z1)
      glAddVertex(__GL_x1, __GL_y1, __GL_z0)
    glEnd()

    glBegin(__GL_mode)
      glAddVertex(__GL_x0, __GL_y0, __GL_z0)
      glAddVertex(__GL_x0, __GL_y0, __GL_z1)
      glAddVertex(__GL_x1, __GL_y0, __GL_z1)
      glAddVertex(__GL_x1, __GL_y0, __GL_z0)
    glEnd()
    glBegin(__GL_mode)
      glAddVertex(__GL_x1, __GL_y1, __GL_z0)
      glAddVertex(__GL_x1, __GL_y1, __GL_z1)
      glAddVertex(__GL_x0, __GL_y1, __GL_z1)
      glAddVertex(__GL_x0, __GL_y1, __GL_z0)
    glEnd()
  glEndObject()
  return
ends

;-----------------------------------------------------------------------------------------
; Subroutine  : __GL_glPyramid
; Description : Add a pyramid with the dimensions: _sizeX, _sizeY, _sizeZ.
;               Use mode _mode.
;-----------------------------------------------------------------------------------------
subroutine __GL_glPyramid
  shr      __GL_x1,                    __GL_sizeX, 1
  neg      __GL_x0,                    __GL_x1
  shr      __GL_z1,                    __GL_sizeZ, 1
  neg      __GL_z0,                    __GL_z1
  neg      __GL_y0,                    __GL_sizeY
  glBeginObject(__GL_tmpId)
    glBegin(__GL_mode)
      glAddVertex(__GL_x1, 0, __GL_z0)
      glAddVertex(__GL_x1, 0, __GL_z1)
      glAddVertex(__GL_x0, 0, __GL_z1)
      glAddVertex(__GL_x0, 0, __GL_z0)
    glEnd()

    glBegin(__GL_mode)
      glAddVertex(__GL_x0, 0,   __GL_z0)
      glAddVertex(__GL_x0, 0,   __GL_z1)
      glAddVertex(0,   __GL_y0, 0)
    glEnd()
    glBegin(__GL_mode)
      glAddVertex(__GL_x1, 0,   __GL_z1)
      glAddVertex(__GL_x1, 0,   __GL_z0)
      glAddVertex(0,   __GL_y0, 0)
    glEnd()
    glBegin(__GL_mode)
      glAddVertex(__GL_x1, 0,   __GL_z0)
      glAddVertex(__GL_x0, 0,   __GL_z0)
      glAddVertex(0,   __GL_y0, 0)
    glEnd()
    glBegin(__GL_mode)
      glAddVertex(__GL_x0, 0,   __GL_z1)
      glAddVertex(__GL_x1, 0,   __GL_z1)
      glAddVertex(0,   __GL_y0, 0)
    glEnd()
  glEndObject()
  return
ends

#endif // NXTDEFS__H
