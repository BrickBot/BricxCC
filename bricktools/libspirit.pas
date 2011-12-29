(*
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
 * Portions created by John Hansen are Copyright (C) 2011 John Hansen.
 * All Rights Reserved.
 *
 *)
unit libspirit;

interface

uses
  FantomDefs;

{$IFNDEF WIN32}

{$MODE OBJFPC}

{$LINKLIB nxtspirit}
{$PACKRECORDS C}

{$ENDIF}

type
  NXTLSBlock = record
    TXCount : byte;
    RXCount : byte;
    Data : array[0..15] of byte;
  end;

  NXTMessage = record
    Inbox : byte;
    Size : byte;
    Data : array[0..58] of byte;
  end;

  NXTDataBuffer = record
    Data : array[0..63] of Byte;
  end;

// nxtfiletype constants
const
  nftProgram  = 0;
  nftGraphics = 1;
  nftSound    = 2;
  nftData     = 3;
  nftOther    = 4;
  nftFirmware = 5;

// installed firmware constants
const
  ifUnknown  = 0;
  ifStandard = 1;
  ifEnhanced = 2;


{$IFNDEF WIN32}
{$linklib nxtspirit}
{ Function prototypes  }
function FantomSpiritCreate() : FantomHandle; cdecl; external;
procedure FantomSpiritDestroy(fsh : FantomHandle); cdecl; external;
function FantomSpiritOpen(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritClose(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritPlayTone(fsh : FantomHandle; aFreq, aTime : word) : integer;  cdecl; external;
function FantomSpiritMotorsOn(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; external;
function FantomSpiritMotorsOff(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; external;
function FantomSpiritMotorsFloat(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; external;
function FantomSpiritSetFwd(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; external;
function FantomSpiritSetRwd(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; external;
function FantomSpiritSwitchDirection(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; external;
function FantomSpiritSetMotorPower(fsh : FantomHandle; aMotorList : Byte; aSrc, aNum : integer) : integer; cdecl; external;
function FantomSpiritSetSensorType(fsh : FantomHandle; aNum, aType : integer) : integer; cdecl; external;
function FantomSpiritSetSensorMode(fsh : FantomHandle; aNum, aMode, aSlope : integer) : integer; cdecl; external;
function FantomSpiritClearSensorValue(fsh : FantomHandle; aNum : integer) : integer; cdecl; external;
function FantomSpiritPing(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritPowerDownTime(fsh : FantomHandle; aTime : integer) : integer; cdecl; external;
function FantomSpiritBatteryLevel(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritBrickAlive(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritShutdown(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritSleep(fsh : FantomHandle; aVal : integer) : integer; cdecl; external;
function FantomSpiritVersion(fsh : FantomHandle; var rom, ram : Cardinal) : integer; cdecl; external;
function FantomSpiritStopAllTasks(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritClearMemory(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritGetOutputStatus(fsh : FantomHandle; aOut : integer) : integer; cdecl; external;
function FantomSpiritGetInputValue(fsh : FantomHandle; aIn: integer): integer; cdecl; external;
function FantomSpiritGetTimerValue(fsh : FantomHandle; aNum : integer) : integer; cdecl; external;
function FantomSpiritSendMessage(fsh : FantomHandle; aMsg : integer) : integer; cdecl; external;
function FantomSpiritDownloadFirmware(fsh : FantomHandle; aFile : PChar; bFast, bComp, bUnlock : byte) : integer; cdecl; external;
function FantomSpiritClearTachoCounter(fsh : FantomHandle; aMotorList : byte) : integer; cdecl; external;
function FantomSpiritMuteSound(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritNXTStartProgram(fsh : FantomHandle; filename : PChar) : integer; cdecl; external;
function FantomSpiritNXTStopProgram(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritNXTPlaySoundFile(fsh : FantomHandle; filename : PChar; bLoop : byte) : integer; cdecl; external;
function FantomSpiritGetNXTOutputState(fsh : FantomHandle; aPort : byte; var pwr : integer; var mode, rmode : byte; var tratio : integer; var rstate : byte; var tlimit : cardinal; var tcnt, btcnt, rcnt : longint) : integer; cdecl; external;
function FantomSpiritSetNXTOutputState(fsh : FantomHandle; aPort : byte; pwr : integer; mode, rmode : byte; tratio : integer; rstate : byte; tlimit : cardinal) : integer; cdecl; external;
function FantomSpiritGetNXTInputValues(fsh : FantomHandle; aPort : byte; var valid, calib, stype, smode : byte; var raw, normal : word; var scaled, calvalue : smallint) : integer; cdecl; external;
function FantomSpiritSetNXTInputMode(fsh : FantomHandle; aPort, stype, smode : byte) : integer; cdecl; external;
function FantomSpiritNXTResetInputScaledValue(fsh : FantomHandle; aPort : byte) : integer; cdecl; external;
function FantomSpiritNXTResetOutputPosition(fsh : FantomHandle; aPort, Relative : byte) : integer; cdecl; external;
function FantomSpiritNXTMessageWrite(fsh : FantomHandle; inbox : byte; msg : PChar) : integer; cdecl; external;
function FantomSpiritNXTKeepAlive(fsh : FantomHandle; var time : cardinal; chkResponse : byte) : integer; cdecl; external;
function FantomSpiritNXTLSGetStatus(fsh : FantomHandle; aPort : byte; var bready, lsstate : byte) : integer; cdecl; external;
function FantomSpiritNXTGetCurrentProgramName(fsh : FantomHandle; name : PChar) : integer; cdecl; external;
function FantomSpiritNXTGetButtonState(fsh : FantomHandle; idx, reset : byte; var pressed, count : byte) : integer; cdecl; external;
function FantomSpiritNXTMessageRead(fsh : FantomHandle; remote, local, remove : byte; var msg : NXTMessage) : integer; cdecl; external;
function FantomSpiritNXTSetPropDebugging(fsh : FantomHandle; debug : byte; pauseClump : byte; pausePC : Word) : integer; cdecl; external;
function FantomSpiritNXTGetPropDebugging(fsh : FantomHandle; var debug : byte; var pauseClump : byte; var pausePC : Word) : integer; cdecl; external;
function FantomSpiritNXTSetVMState(fsh : FantomHandle; state : byte) : integer; cdecl; external;
function FantomSpiritNXTSetVMStateEx(fsh : FantomHandle; var state, clump : byte; var pc : word) : integer; cdecl; external;
function FantomSpiritNXTGetVMState(fsh : FantomHandle; var state, clump : byte; var pc : word) : integer; cdecl; external;
function FantomSpiritNXTOpenRead(fsh : FantomHandle; filename : PChar; var handle : FantomHandle; var size : cardinal) : integer; cdecl; external;
function FantomSpiritNXTOpenWrite(fsh : FantomHandle; filename : PChar; const size : cardinal; var handle : FantomHandle) : integer; cdecl; external;
function FantomSpiritNXTRead(fsh : FantomHandle; var handle : FantomHandle; var count : word; var buffer : NXTDataBuffer) : integer; cdecl; external;
function FantomSpiritNXTWrite(fsh : FantomHandle; var handle : FantomHandle; buffer : NXTDataBuffer; var count : word; chkResponse : byte) : integer; cdecl; external;
function FantomSpiritNXTCloseFile(fsh : FantomHandle; var handle : FantomHandle; chkResponse: byte) : integer; cdecl; external;
function FantomSpiritNXTDeleteFile(fsh : FantomHandle; filename : PChar; chkResponse: byte) : integer; cdecl; external;
function FantomSpiritNXTFindFirstFile(fsh : FantomHandle; filename : PChar; var IterHandle : FantomHandle; var filesize, availsize : cardinal) : integer; cdecl; external;
function FantomSpiritNXTFindNextFile(fsh : FantomHandle; var IterHandle : FantomHandle; filename : PChar; var filesize, availsize : cardinal) : integer; cdecl; external;
function FantomSpiritNXTFindClose(fsh : FantomHandle; var IterHandle : FantomHandle) : integer; cdecl; external;
function FantomSpiritNXTGetVersions(fsh : FantomHandle; var protmin, protmaj, firmmin, firmmaj : byte) : integer; cdecl; external;
function FantomSpiritNXTOpenWriteLinear(fsh : FantomHandle; filename : PChar; size : cardinal; var handle : FantomHandle) : integer; cdecl; external;
function FantomSpiritNXTOpenReadLinear(fsh : FantomHandle; filename : PChar; var handle : FantomHandle; var size : cardinal) : integer; cdecl; external;
function FantomSpiritNXTOpenWriteData(fsh : FantomHandle; filename : PChar; size : cardinal; var handle : FantomHandle) : integer; cdecl; external;
function FantomSpiritNXTOpenAppendData(fsh : FantomHandle; filename : PChar; var size : cardinal; var handle : FantomHandle) : integer; cdecl; external;
function FantomSpiritNXTCloseModuleHandle(fsh : FantomHandle; var handle : FantomHandle; chkResponse: byte) : integer; cdecl; external;
function FantomSpiritNXTBootCommand(fsh : FantomHandle; chkResponse: byte) : integer; cdecl; external;
function FantomSpiritNXTSetBrickName(fsh : FantomHandle; name : PChar; chkResponse: byte) : integer; cdecl; external;
function FantomSpiritNXTGetDeviceInfo(fsh : FantomHandle; name, btaddr : PChar; var BTSignal : Cardinal; var memFree : Cardinal) : integer; cdecl; external;
function FantomSpiritNXTFreeMemory(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritNXTDeleteUserFlash(fsh : FantomHandle; chkResponse: byte) : integer; cdecl; external;
function FantomSpiritNXTBTFactoryReset(fsh : FantomHandle; chkResponse: byte) : integer; cdecl; external;
function FantomSpiritNXTPollCommandLen(fsh : FantomHandle; bufNum : byte; var count : byte) : integer; cdecl; external;
function FantomSpiritNXTPollCommand(fsh : FantomHandle; bufNum : byte; var count : byte; var buffer : NXTDataBuffer) : integer; cdecl; external;
function FantomSpiritNXTWriteIOMap(fsh : FantomHandle; var ModID : Cardinal; Offset : Word; var count : Word; buffer : NXTDataBuffer; chkResponse : byte) : integer; cdecl; external;
function FantomSpiritNXTReadIOMap(fsh : FantomHandle; var ModID : Cardinal; Offset : Word; var count : Word; var buffer : NXTDataBuffer) : integer; cdecl; external;
function FantomSpiritNXTFindFirstModule(fsh : FantomHandle; ModName : PChar; var Handle : FantomHandle; var ModID, ModSize : Cardinal; var IOMapSize : Word) : integer; cdecl; external;
function FantomSpiritNXTFindNextModule(fsh : FantomHandle; var Handle : FantomHandle; ModName : PChar; var ModID, ModSize : Cardinal; var IOMapSize : Word) : integer; cdecl; external;
function FantomSpiritNXTRenameFile(fsh : FantomHandle; old, new : PChar; chkResponse: byte) : integer; cdecl; external;
function FantomSpiritNXTDownloadFile(fsh : FantomHandle; filename : PChar; nxtfiletype : byte) : integer; cdecl; external;
function FantomSpiritNXTUploadFile(fsh : FantomHandle; filename, dir : PChar) : integer; cdecl; external;
procedure FantomSpiritNXTInitializeResourceNames(fsh : FantomHandle); cdecl; external;
procedure FantomSpiritNXTUpdateResourceNames(fsh : FantomHandle); cdecl; external;
function FantomSpiritNXTDownloadStream(fsh : FantomHandle; aStream : PByte; count : Integer; dest : PChar; nxtfiletype : byte) : integer; cdecl; external;
function FantomSpiritNXTUploadFileToStream(fsh : FantomHandle; filename : PChar; aStream : PByte) : integer; cdecl; external;
function FantomSpiritNXTListFiles(fsh : FantomHandle; searchPattern : PChar; Files : PChar) : integer; cdecl; external;
function FantomSpiritNXTListModules(fsh : FantomHandle; searchPattern : PChar; Modules : PChar) : integer; cdecl; external;
function FantomSpiritNXTListBricks(fsh : FantomHandle; Bricks : PChar) : integer; cdecl; external;
function FantomSpiritPoll(fsh : FantomHandle; aSrc, aNum : integer; value : PChar) : integer; cdecl; external;
function FantomSpiritGetVariableValue(fsh : FantomHandle; aVar: integer; value : PChar) : integer; cdecl; external;
function FantomSpiritSendRawCommand(fsh : FantomHandle; aCmd : PChar; bRetry : byte; value : PChar) : integer; cdecl; external;
function FantomSpiritPollMemory(fsh : FantomHandle; address : Integer; size : Integer; value : PChar) : integer; cdecl; external;
function FantomSpiritPollEEPROM(fsh : FantomHandle; block : Integer; value : PChar) : integer; cdecl; external;
function FantomSpiritSetNXTLowSpeed(fsh : FantomHandle; aPort : byte; lsb : NXTLSBlock) : integer; cdecl; external;
function FantomSpiritGetNXTLowSpeed(fsh : FantomHandle; aPort : byte; var lsb : NXTLSBlock) : integer; cdecl; external;
function FantomSpiritIsOpen(fsh : FantomHandle) : byte; cdecl; external;
function FantomSpiritUseBluetooth(fsh : FantomHandle) : byte; cdecl; external;
function FantomSpiritBluetoothName(fsh : FantomHandle; name : PChar) : integer; cdecl; external;
function FantomSpiritGetSearchBluetooth(fsh : FantomHandle) : byte; cdecl; external;
procedure FantomSpiritSetSearchBluetooth(fsh : FantomHandle; search : byte); cdecl; external;
function FantomSpiritGetBluetoothSearchTimeout(fsh : FantomHandle) : cardinal; cdecl; external;
procedure FantomSpiritSetBluetoothSearchTimeout(fsh : FantomHandle; sto : cardinal); cdecl; external;
function FantomSpiritGetBrickType(fsh : FantomHandle) : byte; cdecl; external;
procedure FantomSpiritSetBrickType(fsh : FantomHandle; btype : byte); cdecl; external;
procedure FantomSpiritGetPort(fsh : FantomHandle; port : PChar); cdecl; external;
procedure FantomSpiritSetPort(fsh : FantomHandle; port : PChar); cdecl; external;
procedure FantomSpiritGetPortName(fsh : FantomHandle; name : PChar); cdecl; external;
procedure FantomSpiritGetNicePortName(fsh : FantomHandle; name : PChar); cdecl; external;
procedure FantomSpiritGetFullPortName(fsh : FantomHandle; name : PChar); cdecl; external;
procedure FantomSpiritGetBrickTypeName(fsh : FantomHandle; name : PChar); cdecl; external;
function FantomSpiritNXTDefragmentFlash(fsh : FantomHandle) : integer; cdecl; external;
procedure FantomSpiritDownloadMemoryMap(fsh : FantomHandle; value : PChar); cdecl; external;
function FantomSpiritNXTFirmwareVersion(fsh : FantomHandle) : integer; cdecl; external;
function FantomSpiritNXTInstalledFirmware(fsh : FantomHandle) : byte; cdecl; external;
procedure FantomSpiritNXTGetBrickName(fsh : FantomHandle; name : PChar); cdecl; external;
function NameToNXTFileType(name : PChar) : integer; cdecl; external;
procedure LoadLSBlock(var aBlock : NXTLSBlock; buf : PChar; rxCount : integer); cdecl; external;


{$ELSE}

var
  FantomSpiritCreate : function() : FantomHandle; cdecl;
  FantomSpiritDestroy : procedure(fsh : FantomHandle); cdecl;
  FantomSpiritOpen : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritClose : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritPlayTone : function(fsh : FantomHandle; aFreq, aTime : word) : integer;  cdecl;
  FantomSpiritMotorsOn : function(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl;
  FantomSpiritMotorsOff : function(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl;
  FantomSpiritMotorsFloat : function(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl;
  FantomSpiritSetFwd : function(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl;
  FantomSpiritSetRwd : function(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl;
  FantomSpiritSwitchDirection : function(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl;
  FantomSpiritSetMotorPower : function(fsh : FantomHandle; aMotorList : Byte; aSrc, aNum : integer) : integer; cdecl;
  FantomSpiritSetSensorType : function(fsh : FantomHandle; aNum, aType : integer) : integer; cdecl;
  FantomSpiritSetSensorMode : function(fsh : FantomHandle; aNum, aMode, aSlope : integer) : integer; cdecl;
  FantomSpiritClearSensorValue : function(fsh : FantomHandle; aNum : integer) : integer; cdecl;
  FantomSpiritPing : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritPowerDownTime : function(fsh : FantomHandle; aTime : integer) : integer; cdecl;
  FantomSpiritBatteryLevel : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritBrickAlive : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritShutdown : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritSleep : function(fsh : FantomHandle; aVal : integer) : integer; cdecl;
  FantomSpiritVersion : function(fsh : FantomHandle; var rom, ram : Cardinal) : integer; cdecl;
  FantomSpiritStopAllTasks : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritClearMemory : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritGetOutputStatus : function(fsh : FantomHandle; aOut : integer) : integer; cdecl;
  FantomSpiritGetInputValue : function(fsh : FantomHandle; aIn: integer): integer; cdecl;
  FantomSpiritGetTimerValue : function(fsh : FantomHandle; aNum : integer) : integer; cdecl;
  FantomSpiritSendMessage : function(fsh : FantomHandle; aMsg : integer) : integer; cdecl;
  FantomSpiritDownloadFirmware : function(fsh : FantomHandle; aFile : PChar; bFast, bComp, bUnlock : byte) : integer; cdecl;
  FantomSpiritClearTachoCounter : function(fsh : FantomHandle; aMotorList : byte) : integer; cdecl;
  FantomSpiritMuteSound : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritNXTStartProgram : function(fsh : FantomHandle; filename : PChar) : integer; cdecl;
  FantomSpiritNXTStopProgram : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritNXTPlaySoundFile : function(fsh : FantomHandle; filename : PChar; bLoop : byte) : integer; cdecl;
  FantomSpiritGetNXTOutputState : function(fsh : FantomHandle; aPort : byte; var pwr : integer; var mode, rmode : byte; var tratio : integer; var rstate : byte; var tlimit : cardinal; var tcnt, btcnt, rcnt : longint) : integer; cdecl;
  FantomSpiritSetNXTOutputState : function(fsh : FantomHandle; aPort : byte; pwr : integer; mode, rmode : byte; tratio : integer; rstate : byte; tlimit : cardinal) : integer; cdecl;
  FantomSpiritGetNXTInputValues : function(fsh : FantomHandle; aPort : byte; var valid, calib, stype, smode : byte; var raw, normal : word; var scaled, calvalue : smallint) : integer; cdecl;
  FantomSpiritSetNXTInputMode : function(fsh : FantomHandle; aPort, stype, smode : byte) : integer; cdecl;
  FantomSpiritNXTResetInputScaledValue : function(fsh : FantomHandle; aPort : byte) : integer; cdecl;
  FantomSpiritNXTResetOutputPosition : function(fsh : FantomHandle; aPort, Relative : byte) : integer; cdecl;
  FantomSpiritNXTMessageWrite : function(fsh : FantomHandle; inbox : byte; msg : PChar) : integer; cdecl;
  FantomSpiritNXTKeepAlive : function(fsh : FantomHandle; var time : cardinal; chkResponse : byte) : integer; cdecl;
  FantomSpiritNXTLSGetStatus : function(fsh : FantomHandle; aPort : byte; var bready, lsstate : byte) : integer; cdecl;
  FantomSpiritNXTGetCurrentProgramName : function(fsh : FantomHandle; name : PChar) : integer; cdecl;
  FantomSpiritNXTGetButtonState : function(fsh : FantomHandle; idx, reset : byte; var pressed, count : byte) : integer; cdecl;
  FantomSpiritNXTMessageRead : function(fsh : FantomHandle; remote, local, remove : byte; var msg : NXTMessage) : integer; cdecl;
  FantomSpiritNXTSetPropDebugging : function(fsh : FantomHandle; debug : byte; pauseClump : byte; pausePC : Word) : integer; cdecl;
  FantomSpiritNXTGetPropDebugging : function(fsh : FantomHandle; var debug : byte; var pauseClump : byte; var pausePC : Word) : integer; cdecl;
  FantomSpiritNXTSetVMState : function(fsh : FantomHandle; state : byte) : integer; cdecl;
  FantomSpiritNXTSetVMStateEx : function(fsh : FantomHandle; var state, clump : byte; var pc : word) : integer; cdecl;
  FantomSpiritNXTGetVMState : function(fsh : FantomHandle; var state, clump : byte; var pc : word) : integer; cdecl;
  FantomSpiritNXTOpenRead : function(fsh : FantomHandle; filename : PChar; var handle : FantomHandle; var size : cardinal) : integer; cdecl;
  FantomSpiritNXTOpenWrite : function(fsh : FantomHandle; filename : PChar; const size : cardinal; var handle : FantomHandle) : integer; cdecl;
  FantomSpiritNXTRead : function(fsh : FantomHandle; var handle : FantomHandle; var count : word; var buffer : NXTDataBuffer) : integer; cdecl;
  FantomSpiritNXTWrite : function(fsh : FantomHandle; var handle : FantomHandle; buffer : NXTDataBuffer; var count : word; chkResponse : byte) : integer; cdecl;
  FantomSpiritNXTCloseFile : function(fsh : FantomHandle; var handle : FantomHandle; chkResponse: byte) : integer; cdecl;
  FantomSpiritNXTDeleteFile : function(fsh : FantomHandle; filename : PChar; chkResponse: byte) : integer; cdecl;
  FantomSpiritNXTFindFirstFile : function(fsh : FantomHandle; filename : PChar; var IterHandle : FantomHandle; var filesize, availsize : cardinal) : integer; cdecl;
  FantomSpiritNXTFindNextFile : function(fsh : FantomHandle; var IterHandle : FantomHandle; filename : PChar; var filesize, availsize : cardinal) : integer; cdecl;
  FantomSpiritNXTFindClose : function(fsh : FantomHandle; var IterHandle : FantomHandle) : integer; cdecl;
  FantomSpiritNXTGetVersions : function(fsh : FantomHandle; var protmin, protmaj, firmmin, firmmaj : byte) : integer; cdecl;
  FantomSpiritNXTOpenWriteLinear : function(fsh : FantomHandle; filename : PChar; size : cardinal; var handle : FantomHandle) : integer; cdecl;
  FantomSpiritNXTOpenReadLinear : function(fsh : FantomHandle; filename : PChar; var handle : FantomHandle; var size : cardinal) : integer; cdecl;
  FantomSpiritNXTOpenWriteData : function(fsh : FantomHandle; filename : PChar; size : cardinal; var handle : FantomHandle) : integer; cdecl;
  FantomSpiritNXTOpenAppendData : function(fsh : FantomHandle; filename : PChar; var size : cardinal; var handle : FantomHandle) : integer; cdecl;
  FantomSpiritNXTCloseModuleHandle : function(fsh : FantomHandle; var handle : FantomHandle; chkResponse: byte) : integer; cdecl;
  FantomSpiritNXTBootCommand : function(fsh : FantomHandle; chkResponse: byte) : integer; cdecl;
  FantomSpiritNXTSetBrickName : function(fsh : FantomHandle; name : PChar; chkResponse: byte) : integer; cdecl;
  FantomSpiritNXTGetDeviceInfo : function(fsh : FantomHandle; name, btaddr : PChar; var BTSignal : Cardinal; var memFree : Cardinal) : integer; cdecl;
  FantomSpiritNXTFreeMemory : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritNXTDeleteUserFlash : function(fsh : FantomHandle; chkResponse: byte) : integer; cdecl;
  FantomSpiritNXTBTFactoryReset : function(fsh : FantomHandle; chkResponse: byte) : integer; cdecl;
  FantomSpiritNXTPollCommandLen : function(fsh : FantomHandle; bufNum : byte; var count : byte) : integer; cdecl;
  FantomSpiritNXTPollCommand : function(fsh : FantomHandle; bufNum : byte; var count : byte; var buffer : NXTDataBuffer) : integer; cdecl;
  FantomSpiritNXTWriteIOMap : function(fsh : FantomHandle; var ModID : Cardinal; Offset : Word; var count : Word; buffer : NXTDataBuffer; chkResponse : byte) : integer; cdecl;
  FantomSpiritNXTReadIOMap : function(fsh : FantomHandle; var ModID : Cardinal; Offset : Word; var count : Word; var buffer : NXTDataBuffer) : integer; cdecl;
  FantomSpiritNXTFindFirstModule : function(fsh : FantomHandle; ModName : PChar; var Handle : FantomHandle; var ModID, ModSize : Cardinal; var IOMapSize : Word) : integer; cdecl;
  FantomSpiritNXTFindNextModule : function(fsh : FantomHandle; var Handle : FantomHandle; ModName : PChar; var ModID, ModSize : Cardinal; var IOMapSize : Word) : integer; cdecl;
  FantomSpiritNXTRenameFile : function(fsh : FantomHandle; old, new : PChar; chkResponse: byte) : integer; cdecl;
  FantomSpiritNXTDownloadFile : function(fsh : FantomHandle; filename : PChar; filetype : byte) : integer; cdecl;
  FantomSpiritNXTUploadFile : function(fsh : FantomHandle; filename, dir : PChar) : integer; cdecl;
  FantomSpiritNXTInitializeResourceNames : procedure(fsh : FantomHandle); cdecl;
  FantomSpiritNXTUpdateResourceNames : procedure(fsh : FantomHandle); cdecl;
  FantomSpiritNXTDownloadStream : function(fsh : FantomHandle; aStream : PByte; count : Integer; dest : PChar; filetype : byte) : integer; cdecl;
  FantomSpiritNXTUploadFileToStream : function(fsh : FantomHandle; filename : PChar; aStream : PByte) : integer; cdecl;
  FantomSpiritNXTListFiles : function(fsh : FantomHandle; searchPattern : PChar; Files : PChar) : integer; cdecl;
  FantomSpiritNXTListModules : function(fsh : FantomHandle; searchPattern : PChar; Modules : PChar) : integer; cdecl;
  FantomSpiritNXTListBricks : function(fsh : FantomHandle; Bricks : PChar) : integer; cdecl;
  FantomSpiritPoll : function(fsh : FantomHandle; aSrc, aNum : integer; value : PChar) : integer; cdecl;
  FantomSpiritGetVariableValue : function(fsh : FantomHandle; aVar: integer; value : PChar) : integer; cdecl;
  FantomSpiritSendRawCommand : function(fsh : FantomHandle; aCmd : PChar; bRetry : byte; value : PChar) : integer; cdecl;
  FantomSpiritPollMemory : function(fsh : FantomHandle; address : Integer; size : Integer; value : PChar) : integer; cdecl;
  FantomSpiritPollEEPROM : function(fsh : FantomHandle; block : Integer; value : PChar) : integer; cdecl;
  FantomSpiritSetNXTLowSpeed : function(fsh : FantomHandle; aPort : byte; lsb : NXTLSBlock) : integer; cdecl;
  FantomSpiritGetNXTLowSpeed : function(fsh : FantomHandle; aPort : byte; var lsb : NXTLSBlock) : integer; cdecl;
  FantomSpiritIsOpen : function(fsh : FantomHandle) : byte; cdecl;
  FantomSpiritUseBluetooth : function(fsh : FantomHandle) : byte; cdecl;
  FantomSpiritBluetoothName : function(fsh : FantomHandle; name : PChar) : integer; cdecl;
  FantomSpiritGetSearchBluetooth : function(fsh : FantomHandle) : byte; cdecl;
  FantomSpiritSetSearchBluetooth : procedure(fsh : FantomHandle; search : byte); cdecl;
  FantomSpiritGetBluetoothSearchTimeout : function(fsh : FantomHandle) : cardinal; cdecl;
  FantomSpiritSetBluetoothSearchTimeout : procedure(fsh : FantomHandle; sto : cardinal); cdecl;
  FantomSpiritGetBrickType : function(fsh : FantomHandle) : byte; cdecl;
  FantomSpiritSetBrickType : procedure(fsh : FantomHandle; btype : byte); cdecl;
  FantomSpiritGetPort : procedure(fsh : FantomHandle; port : PChar); cdecl;
  FantomSpiritSetPort : procedure(fsh : FantomHandle; port : PChar); cdecl;
  FantomSpiritGetPortName : procedure(fsh : FantomHandle; name : PChar); cdecl;
  FantomSpiritGetNicePortName : procedure(fsh : FantomHandle; name : PChar); cdecl;
  FantomSpiritGetFullPortName : procedure(fsh : FantomHandle; name : PChar); cdecl;
  FantomSpiritGetBrickTypeName : procedure(fsh : FantomHandle; name : PChar); cdecl;
  FantomSpiritNXTDefragmentFlash : function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritDownloadMemoryMap : procedure(fsh : FantomHandle; value : PChar); cdecl;
  FantomSpiritNXTFirmwareVersion :  function(fsh : FantomHandle) : integer; cdecl;
  FantomSpiritNXTInstalledFirmware : function(fsh : FantomHandle) : byte; cdecl;
  FantomSpiritNXTGetBrickName : procedure(fsh : FantomHandle; name : PChar); cdecl;
  NameToNXTFileType : function(name : PChar) : integer; cdecl;
  LoadLSBlock : procedure(var aBlock : NXTLSBlock; buf : PChar; rxCount : integer); cdecl;

var
  SpiritAPILoaded: Boolean = False;

procedure UnloadSpiritAPI;

{$ENDIF}

implementation

{$IFDEF WIN32}
uses
  Windows;

var
  DLLHandle: THandle;
  ErrorMode: Integer;

procedure UnloadSpiritAPI;
begin
  if SpiritAPILoaded then
  begin
    if DLLHandle >= 32 then
      FreeLibrary(DLLHandle);
    SpiritAPILoaded := False;
  end;
end;

procedure LoadSpiritDLL;
begin
  if SpiritAPILoaded then Exit;
  ErrorMode := SetErrorMode($8000{SEM_NoOpenFileErrorBox});
  DLLHandle := LoadLibrary('NXTSPIRIT.DLL');
  if DLLHandle >= 32 then
  begin
    SpiritAPILoaded := True;
    @FantomSpiritCreate := GetProcAddress(DLLHandle, 'FantomSpiritCreate');
    Assert(@FantomSpiritCreate <> nil);
    @FantomSpiritDestroy := GetProcAddress(DLLHandle, 'FantomSpiritDestroy');
    Assert(@FantomSpiritDestroy <> nil);
    @FantomSpiritOpen := GetProcAddress(DLLHandle, 'FantomSpiritOpen');
    Assert(@FantomSpiritOpen <> nil);
    @FantomSpiritClose := GetProcAddress(DLLHandle, 'FantomSpiritClose');
    Assert(@FantomSpiritClose <> nil);
    @FantomSpiritPlayTone := GetProcAddress(DLLHandle, 'FantomSpiritPlayTone');
    Assert(@FantomSpiritPlayTone <> nil);
    @FantomSpiritMotorsOn := GetProcAddress(DLLHandle, 'FantomSpiritMotorsOn');
    Assert(@FantomSpiritMotorsOn <> nil);
    @FantomSpiritMotorsOff := GetProcAddress(DLLHandle, 'FantomSpiritMotorsOff');
    Assert(@FantomSpiritMotorsOff <> nil);
    @FantomSpiritMotorsFloat := GetProcAddress(DLLHandle, 'FantomSpiritMotorsFloat');
    Assert(@FantomSpiritMotorsFloat <> nil);
    @FantomSpiritSetFwd := GetProcAddress(DLLHandle, 'FantomSpiritSetFwd');
    Assert(@FantomSpiritSetFwd <> nil);
    @FantomSpiritSetRwd := GetProcAddress(DLLHandle, 'FantomSpiritSetRwd');
    Assert(@FantomSpiritSetRwd <> nil);
    @FantomSpiritSwitchDirection := GetProcAddress(DLLHandle, 'FantomSpiritSwitchDirection');
    Assert(@FantomSpiritSwitchDirection <> nil);
    @FantomSpiritSetMotorPower := GetProcAddress(DLLHandle, 'FantomSpiritSetMotorPower');
    Assert(@FantomSpiritSetMotorPower <> nil);
    @FantomSpiritSetSensorType := GetProcAddress(DLLHandle, 'FantomSpiritSetSensorType');
    Assert(@FantomSpiritSetSensorType <> nil);
    @FantomSpiritSetSensorMode := GetProcAddress(DLLHandle, 'FantomSpiritSetSensorMode');
    Assert(@FantomSpiritSetSensorMode <> nil);
    @FantomSpiritClearSensorValue := GetProcAddress(DLLHandle, 'FantomSpiritClearSensorValue');
    Assert(@FantomSpiritClearSensorValue <> nil);
    @FantomSpiritPing := GetProcAddress(DLLHandle, 'FantomSpiritPing');
    Assert(@FantomSpiritPing <> nil);
    @FantomSpiritPowerDownTime := GetProcAddress(DLLHandle, 'FantomSpiritPowerDownTime');
    Assert(@FantomSpiritPowerDownTime <> nil);
    @FantomSpiritBatteryLevel := GetProcAddress(DLLHandle, 'FantomSpiritBatteryLevel');
    Assert(@FantomSpiritBatteryLevel <> nil);
    @FantomSpiritBrickAlive := GetProcAddress(DLLHandle, 'FantomSpiritBrickAlive');
    Assert(@FantomSpiritBrickAlive <> nil);
    @FantomSpiritShutdown := GetProcAddress(DLLHandle, 'FantomSpiritShutdown');
    Assert(@FantomSpiritShutdown <> nil);
    @FantomSpiritSleep := GetProcAddress(DLLHandle, 'FantomSpiritSleep');
    Assert(@FantomSpiritSleep <> nil);
    @FantomSpiritVersion := GetProcAddress(DLLHandle, 'FantomSpiritVersion');
    Assert(@FantomSpiritVersion <> nil);
    @FantomSpiritStopAllTasks := GetProcAddress(DLLHandle, 'FantomSpiritStopAllTasks');
    Assert(@FantomSpiritStopAllTasks <> nil);
    @FantomSpiritClearMemory := GetProcAddress(DLLHandle, 'FantomSpiritClearMemory');
    Assert(@FantomSpiritClearMemory <> nil);
    @FantomSpiritGetOutputStatus := GetProcAddress(DLLHandle, 'FantomSpiritGetOutputStatus');
    Assert(@FantomSpiritGetOutputStatus <> nil);
    @FantomSpiritGetInputValue := GetProcAddress(DLLHandle, 'FantomSpiritGetInputValue');
    Assert(@FantomSpiritGetInputValue <> nil);
    @FantomSpiritGetTimerValue := GetProcAddress(DLLHandle, 'FantomSpiritGetTimerValue');
    Assert(@FantomSpiritGetTimerValue <> nil);
    @FantomSpiritSendMessage := GetProcAddress(DLLHandle, 'FantomSpiritSendMessage');
    Assert(@FantomSpiritSendMessage <> nil);
    @FantomSpiritDownloadFirmware := GetProcAddress(DLLHandle, 'FantomSpiritDownloadFirmware');
    Assert(@FantomSpiritDownloadFirmware <> nil);
    @FantomSpiritClearTachoCounter := GetProcAddress(DLLHandle, 'FantomSpiritClearTachoCounter');
    Assert(@FantomSpiritClearTachoCounter <> nil);
    @FantomSpiritMuteSound := GetProcAddress(DLLHandle, 'FantomSpiritMuteSound');
    Assert(@FantomSpiritMuteSound <> nil);
    @FantomSpiritNXTStartProgram := GetProcAddress(DLLHandle, 'FantomSpiritNXTStartProgram');
    Assert(@FantomSpiritNXTStartProgram <> nil);
    @FantomSpiritNXTStopProgram := GetProcAddress(DLLHandle, 'FantomSpiritNXTStopProgram');
    Assert(@FantomSpiritNXTStopProgram <> nil);
    @FantomSpiritNXTPlaySoundFile := GetProcAddress(DLLHandle, 'FantomSpiritNXTPlaySoundFile');
    Assert(@FantomSpiritNXTPlaySoundFile <> nil);
    @FantomSpiritGetNXTOutputState := GetProcAddress(DLLHandle, 'FantomSpiritGetNXTOutputState');
    Assert(@FantomSpiritGetNXTOutputState <> nil);
    @FantomSpiritSetNXTOutputState := GetProcAddress(DLLHandle, 'FantomSpiritSetNXTOutputState');
    Assert(@FantomSpiritSetNXTOutputState <> nil);
    @FantomSpiritGetNXTInputValues := GetProcAddress(DLLHandle, 'FantomSpiritGetNXTInputValues');
    Assert(@FantomSpiritGetNXTInputValues <> nil);
    @FantomSpiritSetNXTInputMode := GetProcAddress(DLLHandle, 'FantomSpiritSetNXTInputMode');
    Assert(@FantomSpiritSetNXTInputMode <> nil);
    @FantomSpiritNXTResetInputScaledValue := GetProcAddress(DLLHandle, 'FantomSpiritNXTResetInputScaledValue');
    Assert(@FantomSpiritNXTResetInputScaledValue <> nil);
    @FantomSpiritNXTResetOutputPosition := GetProcAddress(DLLHandle, 'FantomSpiritNXTResetOutputPosition');
    Assert(@FantomSpiritNXTResetOutputPosition <> nil);
    @FantomSpiritNXTMessageWrite := GetProcAddress(DLLHandle, 'FantomSpiritNXTMessageWrite');
    Assert(@FantomSpiritNXTMessageWrite <> nil);
    @FantomSpiritNXTKeepAlive := GetProcAddress(DLLHandle, 'FantomSpiritNXTKeepAlive');
    Assert(@FantomSpiritNXTKeepAlive <> nil);
    @FantomSpiritNXTLSGetStatus := GetProcAddress(DLLHandle, 'FantomSpiritNXTLSGetStatus');
    Assert(@FantomSpiritNXTLSGetStatus <> nil);
    @FantomSpiritNXTGetCurrentProgramName := GetProcAddress(DLLHandle, 'FantomSpiritNXTGetCurrentProgramName');
    Assert(@FantomSpiritNXTGetCurrentProgramName <> nil);
    @FantomSpiritNXTGetButtonState := GetProcAddress(DLLHandle, 'FantomSpiritNXTGetButtonState');
    Assert(@FantomSpiritNXTGetButtonState <> nil);
    @FantomSpiritNXTMessageRead := GetProcAddress(DLLHandle, 'FantomSpiritNXTMessageRead');
    Assert(@FantomSpiritNXTMessageRead <> nil);
    @FantomSpiritNXTSetPropDebugging := GetProcAddress(DLLHandle, 'FantomSpiritNXTSetPropDebugging');
    Assert(@FantomSpiritNXTSetPropDebugging <> nil);
    @FantomSpiritNXTGetPropDebugging := GetProcAddress(DLLHandle, 'FantomSpiritNXTGetPropDebugging');
    Assert(@FantomSpiritNXTGetPropDebugging <> nil);
    @FantomSpiritNXTSetVMState := GetProcAddress(DLLHandle, 'FantomSpiritNXTSetVMState');
    Assert(@FantomSpiritNXTSetVMState <> nil);
    @FantomSpiritNXTSetVMStateEx := GetProcAddress(DLLHandle, 'FantomSpiritNXTSetVMStateEx');
    Assert(@FantomSpiritNXTSetVMStateEx <> nil);
    @FantomSpiritNXTGetVMState := GetProcAddress(DLLHandle, 'FantomSpiritNXTGetVMState');
    Assert(@FantomSpiritNXTGetVMState <> nil);
    @FantomSpiritNXTOpenRead := GetProcAddress(DLLHandle, 'FantomSpiritNXTOpenRead');
    Assert(@FantomSpiritNXTOpenRead <> nil);
    @FantomSpiritNXTOpenWrite := GetProcAddress(DLLHandle, 'FantomSpiritNXTOpenWrite');
    Assert(@FantomSpiritNXTOpenWrite <> nil);
    @FantomSpiritNXTRead := GetProcAddress(DLLHandle, 'FantomSpiritNXTRead');
    Assert(@FantomSpiritNXTRead <> nil);
    @FantomSpiritNXTWrite := GetProcAddress(DLLHandle, 'FantomSpiritNXTWrite');
    Assert(@FantomSpiritNXTWrite <> nil);
    @FantomSpiritNXTCloseFile := GetProcAddress(DLLHandle, 'FantomSpiritNXTCloseFile');
    Assert(@FantomSpiritNXTCloseFile <> nil);
    @FantomSpiritNXTDeleteFile := GetProcAddress(DLLHandle, 'FantomSpiritNXTDeleteFile');
    Assert(@FantomSpiritNXTDeleteFile <> nil);
    @FantomSpiritNXTFindFirstFile := GetProcAddress(DLLHandle, 'FantomSpiritNXTFindFirstFile');
    Assert(@FantomSpiritNXTFindFirstFile <> nil);
    @FantomSpiritNXTFindNextFile := GetProcAddress(DLLHandle, 'FantomSpiritNXTFindNextFile');
    Assert(@FantomSpiritNXTFindNextFile <> nil);
    @FantomSpiritNXTFindClose := GetProcAddress(DLLHandle, 'FantomSpiritNXTFindClose');
    Assert(@FantomSpiritNXTFindClose <> nil);
    @FantomSpiritNXTGetVersions := GetProcAddress(DLLHandle, 'FantomSpiritNXTGetVersions');
    Assert(@FantomSpiritNXTGetVersions <> nil);
    @FantomSpiritNXTOpenWriteLinear := GetProcAddress(DLLHandle, 'FantomSpiritNXTOpenWriteLinear');
    Assert(@FantomSpiritNXTOpenWriteLinear <> nil);
    @FantomSpiritNXTOpenReadLinear := GetProcAddress(DLLHandle, 'FantomSpiritNXTOpenReadLinear');
    Assert(@FantomSpiritNXTOpenReadLinear <> nil);
    @FantomSpiritNXTOpenWriteData := GetProcAddress(DLLHandle, 'FantomSpiritNXTOpenWriteData');
    Assert(@FantomSpiritNXTOpenWriteData <> nil);
    @FantomSpiritNXTOpenAppendData := GetProcAddress(DLLHandle, 'FantomSpiritNXTOpenAppendData');
    Assert(@FantomSpiritNXTOpenAppendData <> nil);
    @FantomSpiritNXTCloseModuleHandle := GetProcAddress(DLLHandle, 'FantomSpiritNXTCloseModuleHandle');
    Assert(@FantomSpiritNXTCloseModuleHandle <> nil);
    @FantomSpiritNXTBootCommand := GetProcAddress(DLLHandle, 'FantomSpiritNXTBootCommand');
    Assert(@FantomSpiritNXTBootCommand <> nil);
    @FantomSpiritNXTSetBrickName := GetProcAddress(DLLHandle, 'FantomSpiritNXTSetBrickName');
    Assert(@FantomSpiritNXTSetBrickName <> nil);
    @FantomSpiritNXTGetDeviceInfo := GetProcAddress(DLLHandle, 'FantomSpiritNXTGetDeviceInfo');
    Assert(@FantomSpiritNXTGetDeviceInfo <> nil);
    @FantomSpiritNXTFreeMemory := GetProcAddress(DLLHandle, 'FantomSpiritNXTFreeMemory');
    Assert(@FantomSpiritNXTFreeMemory <> nil);
    @FantomSpiritNXTDeleteUserFlash := GetProcAddress(DLLHandle, 'FantomSpiritNXTDeleteUserFlash');
    Assert(@FantomSpiritNXTDeleteUserFlash <> nil);
    @FantomSpiritNXTBTFactoryReset := GetProcAddress(DLLHandle, 'FantomSpiritNXTBTFactoryReset');
    Assert(@FantomSpiritNXTBTFactoryReset <> nil);
    @FantomSpiritNXTPollCommandLen := GetProcAddress(DLLHandle, 'FantomSpiritNXTPollCommandLen');
    Assert(@FantomSpiritNXTPollCommandLen <> nil);
    @FantomSpiritNXTPollCommand := GetProcAddress(DLLHandle, 'FantomSpiritNXTPollCommand');
    Assert(@FantomSpiritNXTPollCommand <> nil);
    @FantomSpiritNXTWriteIOMap := GetProcAddress(DLLHandle, 'FantomSpiritNXTWriteIOMap');
    Assert(@FantomSpiritNXTWriteIOMap <> nil);
    @FantomSpiritNXTReadIOMap := GetProcAddress(DLLHandle, 'FantomSpiritNXTReadIOMap');
    Assert(@FantomSpiritNXTReadIOMap <> nil);
    @FantomSpiritNXTFindFirstModule := GetProcAddress(DLLHandle, 'FantomSpiritNXTFindFirstModule');
    Assert(@FantomSpiritNXTFindFirstModule <> nil);
    @FantomSpiritNXTFindNextModule := GetProcAddress(DLLHandle, 'FantomSpiritNXTFindNextModule');
    Assert(@FantomSpiritNXTFindNextModule <> nil);
    @FantomSpiritNXTRenameFile := GetProcAddress(DLLHandle, 'FantomSpiritNXTRenameFile');
    Assert(@FantomSpiritNXTRenameFile <> nil);
    @FantomSpiritNXTDownloadFile := GetProcAddress(DLLHandle, 'FantomSpiritNXTDownloadFile');
    Assert(@FantomSpiritNXTDownloadFile <> nil);
    @FantomSpiritNXTUploadFile := GetProcAddress(DLLHandle, 'FantomSpiritNXTUploadFile');
    Assert(@FantomSpiritNXTUploadFile <> nil);
    @FantomSpiritNXTInitializeResourceNames := GetProcAddress(DLLHandle, 'FantomSpiritNXTInitializeResourceNames');
    Assert(@FantomSpiritNXTInitializeResourceNames <> nil);
    @FantomSpiritNXTUpdateResourceNames := GetProcAddress(DLLHandle, 'FantomSpiritNXTUpdateResourceNames');
    Assert(@FantomSpiritNXTUpdateResourceNames <> nil);
    @FantomSpiritNXTDownloadStream := GetProcAddress(DLLHandle, 'FantomSpiritNXTDownloadStream');
    Assert(@FantomSpiritNXTDownloadStream <> nil);
    @FantomSpiritNXTUploadFileToStream := GetProcAddress(DLLHandle, 'FantomSpiritNXTUploadFileToStream');
    Assert(@FantomSpiritNXTUploadFileToStream <> nil);
    @FantomSpiritNXTListFiles := GetProcAddress(DLLHandle, 'FantomSpiritNXTListFiles');
    Assert(@FantomSpiritNXTListFiles <> nil);
    @FantomSpiritNXTListModules := GetProcAddress(DLLHandle, 'FantomSpiritNXTListModules');
    Assert(@FantomSpiritNXTListModules <> nil);
    @FantomSpiritNXTListBricks := GetProcAddress(DLLHandle, 'FantomSpiritNXTListBricks');
    Assert(@FantomSpiritNXTListBricks <> nil);
    @FantomSpiritPoll := GetProcAddress(DLLHandle, 'FantomSpiritPoll');
    Assert(@FantomSpiritPoll <> nil);
    @FantomSpiritGetVariableValue := GetProcAddress(DLLHandle, 'FantomSpiritGetVariableValue');
    Assert(@FantomSpiritGetVariableValue <> nil);
    @FantomSpiritSendRawCommand := GetProcAddress(DLLHandle, 'FantomSpiritSendRawCommand');
    Assert(@FantomSpiritSendRawCommand <> nil);
    @FantomSpiritPollMemory := GetProcAddress(DLLHandle, 'FantomSpiritPollMemory');
    Assert(@FantomSpiritPollMemory <> nil);
    @FantomSpiritPollEEPROM := GetProcAddress(DLLHandle, 'FantomSpiritPollEEPROM');
    Assert(@FantomSpiritPollEEPROM <> nil);
    @FantomSpiritSetNXTLowSpeed := GetProcAddress(DLLHandle, 'FantomSpiritSetNXTLowSpeed');
    Assert(@FantomSpiritSetNXTLowSpeed <> nil);
    @FantomSpiritGetNXTLowSpeed := GetProcAddress(DLLHandle, 'FantomSpiritGetNXTLowSpeed');
    Assert(@FantomSpiritGetNXTLowSpeed <> nil);
    @FantomSpiritIsOpen := GetProcAddress(DLLHandle, 'FantomSpiritIsOpen');
    Assert(@FantomSpiritIsOpen <> nil);
    @FantomSpiritUseBluetooth := GetProcAddress(DLLHandle, 'FantomSpiritUseBluetooth');
    Assert(@FantomSpiritUseBluetooth <> nil);
    @FantomSpiritBluetoothName := GetProcAddress(DLLHandle, 'FantomSpiritBluetoothName');
    Assert(@FantomSpiritBluetoothName <> nil);
    @FantomSpiritGetSearchBluetooth := GetProcAddress(DLLHandle, 'FantomSpiritGetSearchBluetooth');
    Assert(@FantomSpiritGetSearchBluetooth <> nil);
    @FantomSpiritSetSearchBluetooth := GetProcAddress(DLLHandle, 'FantomSpiritSetSearchBluetooth');
    Assert(@FantomSpiritSetSearchBluetooth <> nil);
    @FantomSpiritGetBluetoothSearchTimeout := GetProcAddress(DLLHandle, 'FantomSpiritGetBluetoothSearchTimeout');
    Assert(@FantomSpiritGetBluetoothSearchTimeout <> nil);
    @FantomSpiritSetBluetoothSearchTimeout := GetProcAddress(DLLHandle, 'FantomSpiritSetBluetoothSearchTimeout');
    Assert(@FantomSpiritSetBluetoothSearchTimeout <> nil);
    @FantomSpiritGetBrickType := GetProcAddress(DLLHandle, 'FantomSpiritGetBrickType');
    Assert(@FantomSpiritGetBrickType <> nil);
    @FantomSpiritSetBrickType := GetProcAddress(DLLHandle, 'FantomSpiritSetBrickType');
    Assert(@FantomSpiritSetBrickType <> nil);
    @FantomSpiritGetPort := GetProcAddress(DLLHandle, 'FantomSpiritGetPort');
    Assert(@FantomSpiritGetPort <> nil);
    @FantomSpiritSetPort := GetProcAddress(DLLHandle, 'FantomSpiritSetPort');
    Assert(@FantomSpiritSetPort <> nil);
    @FantomSpiritGetPortName := GetProcAddress(DLLHandle, 'FantomSpiritGetPortName');
    Assert(@FantomSpiritGetPortName <> nil);
    @FantomSpiritGetNicePortName := GetProcAddress(DLLHandle, 'FantomSpiritGetNicePortName');
    Assert(@FantomSpiritGetNicePortName <> nil);
    @FantomSpiritGetFullPortName := GetProcAddress(DLLHandle, 'FantomSpiritGetFullPortName');
    Assert(@FantomSpiritGetFullPortName <> nil);
    @FantomSpiritGetBrickTypeName := GetProcAddress(DLLHandle, 'FantomSpiritGetBrickTypeName');
    Assert(@FantomSpiritGetBrickTypeName <> nil);
    @FantomSpiritNXTDefragmentFlash := GetProcAddress(DLLHandle, 'FantomSpiritNXTDefragmentFlash');
    Assert(@FantomSpiritNXTDefragmentFlash <> nil);
    @FantomSpiritDownloadMemoryMap := GetProcAddress(DLLHandle, 'FantomSpiritDownloadMemoryMap');
    Assert(@FantomSpiritDownloadMemoryMap <> nil);
    @FantomSpiritNXTFirmwareVersion := GetProcAddress(DLLHandle, 'FantomSpiritNXTFirmwareVersion');
    Assert(@FantomSpiritNXTFirmwareVersion <> nil);
    @FantomSpiritNXTInstalledFirmware := GetProcAddress(DLLHandle, 'FantomSpiritNXTInstalledFirmware');
    Assert(@FantomSpiritNXTInstalledFirmware <> nil);
    @FantomSpiritNXTGetBrickName := GetProcAddress(DLLHandle, 'FantomSpiritNXTGetBrickName');
    Assert(@FantomSpiritNXTGetBrickName <> nil);
    @NameToNXTFileType := GetProcAddress(DLLHandle, 'NameToNXTFileType');
    Assert(@NameToNXTFileType <> nil);
    @LoadLSBlock := GetProcAddress(DLLHandle, 'LoadLSBlock');
    Assert(@LoadLSBlock <> nil);
  end
  else
  begin
    SpiritAPILoaded := False;
    { Error: nxtspiritlib.dll could not be loaded !! }
  end;
  SetErrorMode(ErrorMode)
end;


initialization
  LoadSpiritDLL;

finalization
  UnloadSpiritAPI;
{$ENDIF}
end.
