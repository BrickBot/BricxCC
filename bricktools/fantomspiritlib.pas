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
unit fantomspiritlib;

interface

uses
  uSpirit, FantomDefs;

function FantomSpiritCreate() : FantomHandle; cdecl; export;
procedure FantomSpiritDestroy(fsh : FantomHandle); cdecl; export;
function FantomSpiritOpen(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritClose(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritPlayTone(fsh : FantomHandle; aFreq, aTime : word) : integer;  cdecl; export;
function FantomSpiritMotorsOn(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
function FantomSpiritMotorsOff(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
function FantomSpiritMotorsFloat(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
function FantomSpiritSetFwd(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
function FantomSpiritSetRwd(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
function FantomSpiritSwitchDirection(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
function FantomSpiritSetMotorPower(fsh : FantomHandle; aMotorList : Byte; aSrc, aNum : integer) : integer; cdecl; export;
function FantomSpiritSetSensorType(fsh : FantomHandle; aNum, aType : integer) : integer; cdecl; export;
function FantomSpiritSetSensorMode(fsh : FantomHandle; aNum, aMode, aSlope : integer) : integer; cdecl; export;
function FantomSpiritClearSensorValue(fsh : FantomHandle; aNum : integer) : integer; cdecl; export;
function FantomSpiritPing(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritPowerDownTime(fsh : FantomHandle; aTime : integer) : integer; cdecl; export;
function FantomSpiritBatteryLevel(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritBrickAlive(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritShutdown(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritSleep(fsh : FantomHandle; aVal : integer) : integer; cdecl; export;
function FantomSpiritVersion(fsh : FantomHandle; var rom, ram : Cardinal) : integer; cdecl; export;
function FantomSpiritStopAllTasks(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritClearMemory(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritGetOutputStatus(fsh : FantomHandle; aOut : integer) : integer; cdecl; export;
function FantomSpiritGetInputValue(fsh : FantomHandle; aIn: integer): integer; cdecl; export;
function FantomSpiritGetTimerValue(fsh : FantomHandle; aNum : integer) : integer; cdecl; export;
function FantomSpiritSendMessage(fsh : FantomHandle; aMsg : integer) : integer; cdecl; export;
function FantomSpiritDownloadFirmware(fsh : FantomHandle; aFile : PChar; bFast, bComp, bUnlock : byte) : integer; cdecl; export;
function FantomSpiritClearTachoCounter(fsh : FantomHandle; aMotorList : byte) : integer; cdecl; export;
function FantomSpiritMuteSound(fsh : FantomHandle) : integer; cdecl; export;

function FantomSpiritNXTStartProgram(fsh : FantomHandle; filename : PChar) : integer; cdecl; export;
function FantomSpiritNXTStopProgram(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritNXTPlaySoundFile(fsh : FantomHandle; filename : PChar; bLoop : byte) : integer; cdecl; export;
function FantomSpiritGetNXTOutputState(fsh : FantomHandle; aPort : byte; var pwr : integer; var mode, rmode : byte; var tratio : integer; var rstate : byte; var tlimit : cardinal; var tcnt, btcnt, rcnt : longint) : integer; cdecl; export;
function FantomSpiritSetNXTOutputState(fsh : FantomHandle; aPort : byte; pwr : integer; mode, rmode : byte; tratio : integer; rstate : byte; tlimit : cardinal) : integer; cdecl; export;
function FantomSpiritGetNXTInputValues(fsh : FantomHandle; aPort : byte; var valid, calib, stype, smode : byte; var raw, normal : word; var scaled, calvalue : smallint) : integer; cdecl; export;
function FantomSpiritSetNXTInputMode(fsh : FantomHandle; aPort, stype, smode : byte) : integer; cdecl; export;
function FantomSpiritNXTResetInputScaledValue(fsh : FantomHandle; aPort : byte) : integer; cdecl; export;
function FantomSpiritNXTResetOutputPosition(fsh : FantomHandle; aPort, Relative : byte) : integer; cdecl; export;
function FantomSpiritNXTMessageWrite(fsh : FantomHandle; inbox : byte; msg : PChar) : integer; cdecl; export;
function FantomSpiritNXTKeepAlive(fsh : FantomHandle; var time : cardinal; chkResponse : byte) : integer; cdecl; export;
function FantomSpiritNXTLSGetStatus(fsh : FantomHandle; aPort : byte; var bready, lsstate : byte) : integer; cdecl; export;
function FantomSpiritNXTGetCurrentProgramName(fsh : FantomHandle; name : PChar) : integer; cdecl; export;
function FantomSpiritNXTGetButtonState(fsh : FantomHandle; idx, reset : byte; var pressed, count : byte) : integer; cdecl; export;
function FantomSpiritNXTMessageRead(fsh : FantomHandle; remote, local, remove : byte; var msg : NXTMessage) : integer; cdecl; export;
function FantomSpiritNXTSetPropDebugging(fsh : FantomHandle; debug : byte; pauseClump : byte; pausePC : Word) : integer; cdecl; export;
function FantomSpiritNXTGetPropDebugging(fsh : FantomHandle; var debug : byte; var pauseClump : byte; var pausePC : Word) : integer; cdecl; export;
function FantomSpiritNXTSetVMState(fsh : FantomHandle; state : byte) : integer; cdecl; export;
function FantomSpiritNXTSetVMStateEx(fsh : FantomHandle; var state, clump : byte; var pc : word) : integer; cdecl; export;
function FantomSpiritNXTGetVMState(fsh : FantomHandle; var state, clump : byte; var pc : word) : integer; cdecl; export;

function FantomSpiritNXTOpenRead(fsh : FantomHandle; filename : PChar; var handle : FantomHandle; var size : cardinal) : integer; cdecl; export;
function FantomSpiritNXTOpenWrite(fsh : FantomHandle; filename : PChar; const size : cardinal; var handle : FantomHandle) : integer; cdecl; export;
function FantomSpiritNXTRead(fsh : FantomHandle; var handle : FantomHandle; var count : word; var buffer : NXTDataBuffer) : integer; cdecl; export;
function FantomSpiritNXTWrite(fsh : FantomHandle; var handle : FantomHandle; buffer : NXTDataBuffer; var count : word; chkResponse : byte) : integer; cdecl; export;
function FantomSpiritNXTCloseFile(fsh : FantomHandle; var handle : FantomHandle; chkResponse: byte) : integer; cdecl; export;
function FantomSpiritNXTDeleteFile(fsh : FantomHandle; filename : PChar; chkResponse: byte) : integer; cdecl; export;
function FantomSpiritNXTFindFirstFile(fsh : FantomHandle; filename : PChar; var IterHandle : FantomHandle; var filesize, availsize : cardinal) : integer; cdecl; export;
function FantomSpiritNXTFindNextFile(fsh : FantomHandle; var IterHandle : FantomHandle; filename : PChar; var filesize, availsize : cardinal) : integer; cdecl; export;
function FantomSpiritNXTFindClose(fsh : FantomHandle; var IterHandle : FantomHandle) : integer; cdecl; export;
function FantomSpiritNXTGetVersions(fsh : FantomHandle; var protmin, protmaj, firmmin, firmmaj : byte) : integer; cdecl; export;
function FantomSpiritNXTOpenWriteLinear(fsh : FantomHandle; filename : PChar; size : cardinal; var handle : FantomHandle) : integer; cdecl; export;
function FantomSpiritNXTOpenReadLinear(fsh : FantomHandle; filename : PChar; var handle : FantomHandle; var size : cardinal) : integer; cdecl; export;
function FantomSpiritNXTOpenWriteData(fsh : FantomHandle; filename : PChar; size : cardinal; var handle : FantomHandle) : integer; cdecl; export;
function FantomSpiritNXTOpenAppendData(fsh : FantomHandle; filename : PChar; var size : cardinal; var handle : FantomHandle) : integer; cdecl; export;
function FantomSpiritNXTCloseModuleHandle(fsh : FantomHandle; var handle : FantomHandle; chkResponse: byte) : integer; cdecl; export;
function FantomSpiritNXTBootCommand(fsh : FantomHandle; chkResponse: byte) : integer; cdecl; export;
function FantomSpiritNXTSetBrickName(fsh : FantomHandle; name : PChar; chkResponse: byte) : integer; cdecl; export;
function FantomSpiritNXTGetDeviceInfo(fsh : FantomHandle; name, btaddr : PChar; var BTSignal : Cardinal; var memFree : Cardinal) : integer; cdecl; export;
function FantomSpiritNXTFreeMemory(fsh : FantomHandle) : integer; cdecl; export;
function FantomSpiritNXTDeleteUserFlash(fsh : FantomHandle; chkResponse: byte) : integer; cdecl; export;
function FantomSpiritNXTBTFactoryReset(fsh : FantomHandle; chkResponse: byte) : integer; cdecl; export;
function FantomSpiritNXTPollCommandLen(fsh : FantomHandle; bufNum : byte; var count : byte) : integer; cdecl; export;
function FantomSpiritNXTPollCommand(fsh : FantomHandle; bufNum : byte; var count : byte; var buffer : NXTDataBuffer) : integer; cdecl; export;
function FantomSpiritNXTWriteIOMap(fsh : FantomHandle; var ModID : Cardinal; Offset : Word; var count : Word; buffer : NXTDataBuffer; chkResponse : byte) : integer; cdecl; export;
function FantomSpiritNXTReadIOMap(fsh : FantomHandle; var ModID : Cardinal; Offset : Word; var count : Word; var buffer : NXTDataBuffer) : integer; cdecl; export;
function FantomSpiritNXTFindFirstModule(fsh : FantomHandle; ModName : PChar; var Handle : FantomHandle; var ModID, ModSize : Cardinal; var IOMapSize : Word) : integer; cdecl; export;
function FantomSpiritNXTFindNextModule(fsh : FantomHandle; var Handle : FantomHandle; ModName : PChar; var ModID, ModSize : Cardinal; var IOMapSize : Word) : integer; cdecl; export;
function FantomSpiritNXTRenameFile(fsh : FantomHandle; old, new : PChar; chkResponse: byte) : integer; cdecl; export;

function FantomSpiritNXTDownloadFile(fsh : FantomHandle; filename : PChar; filetype : byte) : integer; cdecl; export;
function FantomSpiritNXTUploadFile(fsh : FantomHandle; filename, dir : PChar) : integer; cdecl; export;
procedure FantomSpiritNXTInitializeResourceNames(fsh : FantomHandle); cdecl; export;
procedure FantomSpiritNXTUpdateResourceNames(fsh : FantomHandle); cdecl; export;

function FantomSpiritNXTDownloadStream(fsh : FantomHandle; aStream : PByte; count : Integer; dest : PChar; filetype : byte) : integer; cdecl; export;
function FantomSpiritNXTUploadFileToStream(fsh : FantomHandle; filename : PChar; aStream : PByte) : integer; cdecl; export;

function FantomSpiritNXTListFiles(fsh : FantomHandle; searchPattern : PChar; Files : PChar) : integer; cdecl; export;
function FantomSpiritNXTListModules(fsh : FantomHandle; searchPattern : PChar; Modules : PChar) : integer; cdecl; export;
function FantomSpiritNXTListBricks(fsh : FantomHandle; Bricks : PChar) : integer; cdecl; export;

function FantomSpiritPoll(fsh : FantomHandle; aSrc, aNum : integer; value : PChar) : integer; cdecl; export;
function FantomSpiritGetVariableValue(fsh : FantomHandle; aVar: integer; value : PChar) : integer; cdecl; export;
function FantomSpiritSendRawCommand(fsh : FantomHandle; aCmd : PChar; bRetry : byte; value : PChar) : integer; cdecl; export;
function FantomSpiritPollMemory(fsh : FantomHandle; address : Integer; size : Integer; value : PChar) : integer; cdecl; export;
function FantomSpiritPollEEPROM(fsh : FantomHandle; block : Integer; value : PChar) : integer; cdecl; export;

function FantomSpiritSetNXTLowSpeed(fsh : FantomHandle; aPort : byte; lsb : NXTLSBlock) : integer; cdecl; export;
function FantomSpiritGetNXTLowSpeed(fsh : FantomHandle; aPort : byte; var lsb : NXTLSBlock) : integer; cdecl; export;
function FantomSpiritIsOpen(fsh : FantomHandle) : byte; cdecl; export;
function FantomSpiritUseBluetooth(fsh : FantomHandle) : byte; cdecl; export;
function FantomSpiritBluetoothName(fsh : FantomHandle; name : PChar) : integer; cdecl; export;
function FantomSpiritGetSearchBluetooth(fsh : FantomHandle) : byte; cdecl; export;
procedure FantomSpiritSetSearchBluetooth(fsh : FantomHandle; search : byte); cdecl; export;
function FantomSpiritGetBluetoothSearchTimeout(fsh : FantomHandle) : cardinal; cdecl; export;
procedure FantomSpiritSetBluetoothSearchTimeout(fsh : FantomHandle; sto : cardinal); cdecl; export;
function FantomSpiritGetBrickType(fsh : FantomHandle) : byte; cdecl; export;
procedure FantomSpiritSetBrickType(fsh : FantomHandle; btype : byte); cdecl; export;
procedure FantomSpiritGetPort(fsh : FantomHandle; port : PChar); cdecl; export;
procedure FantomSpiritSetPort(fsh : FantomHandle; port : PChar); cdecl; export;
procedure FantomSpiritGetPortName(fsh : FantomHandle; name : PChar); cdecl; export;
procedure FantomSpiritGetNicePortName(fsh : FantomHandle; name : PChar); cdecl; export;
procedure FantomSpiritGetFullPortName(fsh : FantomHandle; name : PChar); cdecl; export;
procedure FantomSpiritGetBrickTypeName(fsh : FantomHandle; name : PChar); cdecl; export;

function FantomSpiritNXTDefragmentFlash(fsh : FantomHandle) : integer; cdecl; export;
procedure FantomSpiritDownloadMemoryMap(fsh : FantomHandle; value : PChar); cdecl; export;

implementation

uses
  Classes, SysUtils, FantomSpirit, brick_common;

function FantomSpiritCreate() : FantomHandle; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit.Create;
  Result := FantomHandle(tmp);
end;

procedure FantomSpiritDestroy(fsh : FantomHandle); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  FreeAndNil(tmp);
end;

function FantomSpiritOpen(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.Open);
end;

function FantomSpiritClose(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.Close);
end;

function FantomSpiritPlayTone(fsh : FantomHandle; aFreq, aTime : word) : integer;  cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.PlayTone(aFreq, aTime));
end;

function FantomSpiritMotorsOn(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.MotorsOn(aMotorList));
end;

function FantomSpiritMotorsOff(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.MotorsOff(aMotorList));
end;

function FantomSpiritMotorsFloat(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.MotorsFloat(aMotorList));
end;

function FantomSpiritSetFwd(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SetFwd(aMotorList));
end;

function FantomSpiritSetRwd(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SetRwd(aMotorList));
end;

function FantomSpiritSwitchDirection(fsh : FantomHandle; aMotorList : Byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SwitchDirection(aMotorList));
end;

function FantomSpiritSetMotorPower(fsh : FantomHandle; aMotorList : Byte; aSrc, aNum : integer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SetMotorPower(aMotorList, aSrc, aNum));
end;

function FantomSpiritSetSensorType(fsh : FantomHandle; aNum, aType : integer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SetSensorType(aNum, aType));
end;

function FantomSpiritSetSensorMode(fsh : FantomHandle; aNum, aMode, aSlope : integer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SetSensorMode(aNum, aMode, aSlope));
end;

function FantomSpiritClearSensorValue(fsh : FantomHandle; aNum : integer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.ClearSensorValue(aNum));
end;

function FantomSpiritPing(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.Ping);
end;

function FantomSpiritPowerDownTime(fsh : FantomHandle; aTime : integer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.PowerDownTime(aTime));
end;

function FantomSpiritBatteryLevel(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := tmp.BatteryLevel;
end;

function FantomSpiritBrickAlive(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.BrickAlive);
end;

function FantomSpiritShutdown(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.Shutdown);
end;

function FantomSpiritSleep(fsh : FantomHandle; aVal : integer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.Sleep(aVal));
end;

function FantomSpiritVersion(fsh : FantomHandle; var rom, ram : Cardinal) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.Version(rom, ram));
end;

function FantomSpiritStopAllTasks(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.StopAllTasks);
end;

function FantomSpiritClearMemory(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.ClearMemory);
end;

function FantomSpiritGetOutputStatus(fsh : FantomHandle; aOut : integer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := tmp.GetOutputStatus(aOut);
end;

function FantomSpiritGetInputValue(fsh : FantomHandle; aIn: integer): integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := tmp.GetInputValue(aIn);
end;

function FantomSpiritGetTimerValue(fsh : FantomHandle; aNum : integer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := tmp.GetTimerValue(aNum);
end;

function FantomSpiritSendMessage(fsh : FantomHandle; aMsg : integer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SendMessage(aMsg));
end;

function FantomSpiritDownloadFirmware(fsh : FantomHandle; aFile : PChar; bFast, bComp, bUnlock : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.DownloadFirmware(String(aFile), Boolean(bFast), Boolean(bComp), Boolean(bUnlock)));
end;

function FantomSpiritClearTachoCounter(fsh : FantomHandle; aMotorList : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.ClearTachoCounter(aMotorList));
end;

function FantomSpiritMuteSound(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.MuteSound);
end;

function FantomSpiritNXTStartProgram(fsh : FantomHandle; filename : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTStartProgram(String(filename)));
end;

function FantomSpiritNXTStopProgram(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTStopProgram);
end;

function FantomSpiritNXTPlaySoundFile(fsh : FantomHandle; filename : PChar; bLoop : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTPlaySoundFile(String(filename), Boolean(bLoop)));
end;

function FantomSpiritGetNXTOutputState(fsh : FantomHandle; aPort : byte; var pwr : integer; var mode, rmode : byte; var tratio : integer; var rstate : byte; var tlimit : cardinal; var tcnt, btcnt, rcnt : longint) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.GetNXTOutputState(aPort, pwr, mode, rmode, tratio, rstate, tlimit, tcnt, btcnt, rcnt));
end;

function FantomSpiritSetNXTOutputState(fsh : FantomHandle; aPort : byte; pwr : integer; mode, rmode : byte; tratio : integer; rstate : byte; tlimit : cardinal) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SetNXTOutputState(aPort, pwr, mode, rmode, tratio, rstate, tlimit));
end;

function FantomSpiritGetNXTInputValues(fsh : FantomHandle; aPort : byte; var valid, calib, stype, smode : byte; var raw, normal : word; var scaled, calvalue : smallint) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  bValid, bCalib : boolean;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.GetNXTInputValues(aPort, bValid, bCalib, stype, smode, raw, normal, scaled, calvalue));
  valid := Ord(bValid);
  calib := Ord(bCalib);
end;

function FantomSpiritSetNXTInputMode(fsh : FantomHandle; aPort, stype, smode : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SetNXTInputMode(aPort, stype, smode));
end;

function FantomSpiritNXTResetInputScaledValue(fsh : FantomHandle; aPort : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTResetInputScaledValue(aPort));
end;

function FantomSpiritNXTResetOutputPosition(fsh : FantomHandle; aPort, Relative : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTResetOutputPosition(aPort, Boolean(Relative)));
end;

function FantomSpiritNXTMessageWrite(fsh : FantomHandle; inbox : byte; msg : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTMessageWrite(inbox, String(msg)));
end;

function FantomSpiritNXTKeepAlive(fsh : FantomHandle; var time : cardinal; chkResponse : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTKeepAlive(time, Boolean(chkResponse)));
end;

function FantomSpiritNXTLSGetStatus(fsh : FantomHandle; aPort : byte; var bready, lsstate : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTLSGetStatus(aPort, bready, lsstate));
end;

function FantomSpiritNXTGetCurrentProgramName(fsh : FantomHandle; name : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  sname : string;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTGetCurrentProgramName(sname));
  StrCopy(name, PChar(sname));
end;

function FantomSpiritNXTGetButtonState(fsh : FantomHandle; idx, reset : byte; var pressed, count : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  bPressed : boolean;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTGetButtonState(idx, Boolean(reset), bPressed, count));
  pressed := Ord(bPressed);
end;

function FantomSpiritNXTMessageRead(fsh : FantomHandle; remote, local, remove : byte; var msg : NXTMessage) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTMessageRead(remote, local, Boolean(remove), msg));
end;

function FantomSpiritNXTSetPropDebugging(fsh : FantomHandle; debug : byte; pauseClump : byte; pausePC : Word) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTSetPropDebugging(Boolean(debug), pauseClump, pausePC));
end;

function FantomSpiritNXTGetPropDebugging(fsh : FantomHandle; var debug : byte; var pauseClump : byte; var pausePC : Word) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  bDebug : boolean;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTGetPropDebugging(bDebug, pauseClump, pausePC));
  debug := Ord(bDebug);
end;

function FantomSpiritNXTSetVMState(fsh : FantomHandle; state : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTSetVMState(state));
end;

function FantomSpiritNXTSetVMStateEx(fsh : FantomHandle; var state, clump : byte; var pc : word) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTSetVMStateEx(state, clump, pc));
end;

function FantomSpiritNXTGetVMState(fsh : FantomHandle; var state, clump : byte; var pc : word) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTGetVMState(state, clump, pc));
end;

function FantomSpiritNXTOpenRead(fsh : FantomHandle; filename : PChar; var handle : FantomHandle; var size : cardinal) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTOpenRead(String(filename), handle, size));
end;

function FantomSpiritNXTOpenWrite(fsh : FantomHandle; filename : PChar; const size : cardinal; var handle : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTOpenWrite(String(filename), size, handle));
end;

function FantomSpiritNXTRead(fsh : FantomHandle; var handle : FantomHandle; var count : word; var buffer : NXTDataBuffer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTRead(handle, count, buffer));
end;

function FantomSpiritNXTWrite(fsh : FantomHandle; var handle : FantomHandle; buffer : NXTDataBuffer; var count : word; chkResponse : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTWrite(handle, buffer, count, Boolean(chkResponse)));
end;

function FantomSpiritNXTCloseFile(fsh : FantomHandle; var handle : FantomHandle; chkResponse: byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTCloseFile(handle, Boolean(chkResponse)));
end;

function FantomSpiritNXTDeleteFile(fsh : FantomHandle; filename : PChar; chkResponse: byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  sFilename : string;
begin
  tmp := TFantomSpirit(fsh);
  sFilename := String(filename);
  Result := Ord(tmp.NXTDeleteFile(sFilename, Boolean(chkResponse)));
  StrCopy(filename, PChar(sFilename));
end;

function FantomSpiritNXTFindFirstFile(fsh : FantomHandle; filename : PChar; var IterHandle : FantomHandle; var filesize, availsize : cardinal) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  sFilename : string;
begin
  tmp := TFantomSpirit(fsh);
  sFilename := String(filename);
  Result := Ord(tmp.NXTFindFirstFile(sFilename, IterHandle, filesize, availsize));
  StrCopy(filename, PChar(sFilename));
end;

function FantomSpiritNXTFindNextFile(fsh : FantomHandle; var IterHandle : FantomHandle; filename : PChar; var filesize, availsize : cardinal) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  sFilename : string;
begin
  tmp := TFantomSpirit(fsh);
  sFilename := String(filename);
  Result := Ord(tmp.NXTFindNextFile(IterHandle, sFilename, filesize, availsize));
  StrCopy(filename, PChar(sFilename));
end;

function FantomSpiritNXTFindClose(fsh : FantomHandle; var IterHandle : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTFindClose(IterHandle));
end;

function FantomSpiritNXTGetVersions(fsh : FantomHandle; var protmin, protmaj, firmmin, firmmaj : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTGetVersions(protmin, protmaj, firmmin, firmmaj));
end;

function FantomSpiritNXTOpenWriteLinear(fsh : FantomHandle; filename : PChar; size : cardinal; var handle : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTOpenWriteLinear(String(filename), size, handle));
end;

function FantomSpiritNXTOpenReadLinear(fsh : FantomHandle; filename : PChar; var handle : FantomHandle; var size : cardinal) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTOpenReadLinear(String(filename), handle, size));
end;

function FantomSpiritNXTOpenWriteData(fsh : FantomHandle; filename : PChar; size : cardinal; var handle : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTOpenWriteData(String(filename), size, handle));
end;

function FantomSpiritNXTOpenAppendData(fsh : FantomHandle; filename : PChar; var size : cardinal; var handle : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTOpenAppendData(String(filename), size, handle));
end;

function FantomSpiritNXTCloseModuleHandle(fsh : FantomHandle; var handle : FantomHandle; chkResponse: byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTCloseModuleHandle(handle, Boolean(chkResponse)));
end;

function FantomSpiritNXTBootCommand(fsh : FantomHandle; chkResponse: byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTBootCommand(Boolean(chkResponse)));
end;

function FantomSpiritNXTSetBrickName(fsh : FantomHandle; name : PChar; chkResponse: byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTSetBrickName(String(name), Boolean(chkResponse)));
end;

function FantomSpiritNXTGetDeviceInfo(fsh : FantomHandle; name, btaddr : PChar; var BTSignal : Cardinal; var memFree : Cardinal) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  sname, sbtaddr : string;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTGetDeviceInfo(sname, sbtaddr, BTSignal, memFree));
  StrCopy(name, PChar(sname));
  StrCopy(btaddr, PChar(sbtaddr));
end;

function FantomSpiritNXTFreeMemory(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := tmp.NXTFreeMemory;
end;

function FantomSpiritNXTDeleteUserFlash(fsh : FantomHandle; chkResponse: byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTDeleteUserFlash(Boolean(chkResponse)));
end;

function FantomSpiritNXTBTFactoryReset(fsh : FantomHandle; chkResponse: byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTBTFactoryReset(Boolean(chkResponse)));
end;

function FantomSpiritNXTPollCommandLen(fsh : FantomHandle; bufNum : byte; var count : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTPollCommandLen(bufNum, count));
end;

function FantomSpiritNXTPollCommand(fsh : FantomHandle; bufNum : byte; var count : byte; var buffer : NXTDataBuffer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTPollCommand(bufNum, count, buffer));
end;

function FantomSpiritNXTWriteIOMap(fsh : FantomHandle; var ModID : Cardinal; Offset : Word; var count : Word; buffer : NXTDataBuffer; chkResponse : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTWriteIOMap(ModID, Offset, count, buffer, Boolean(chkResponse)));
end;

function FantomSpiritNXTReadIOMap(fsh : FantomHandle; var ModID : Cardinal; Offset : Word; var count : Word; var buffer : NXTDataBuffer) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTReadIOMap(ModID, Offset, count, buffer));
end;

function FantomSpiritNXTFindFirstModule(fsh : FantomHandle; ModName : PChar; var Handle : FantomHandle; var ModID, ModSize : Cardinal; var IOMapSize : Word) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  sModName : string;
begin
  tmp := TFantomSpirit(fsh);
  sModName := String(ModName);
  Result := Ord(tmp.NXTFindFirstModule(sModName, Handle, ModID, ModSize, IOMapSize));
  StrCopy(ModName, PChar(sModName));
end;

function FantomSpiritNXTFindNextModule(fsh : FantomHandle; var Handle : FantomHandle; ModName : PChar; var ModID, ModSize : Cardinal; var IOMapSize : Word) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  sModName : string;
begin
  tmp := TFantomSpirit(fsh);
  sModName := String(ModName);
  Result := Ord(tmp.NXTFindFirstModule(sModName, Handle, ModID, ModSize, IOMapSize));
  StrCopy(ModName, PChar(sModName));
end;

function FantomSpiritNXTRenameFile(fsh : FantomHandle; old, new : PChar; chkResponse: byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTRenameFile(String(old), String(new), Boolean(chkResponse)));
end;

function FantomSpiritNXTDownloadFile(fsh : FantomHandle; filename : PChar; filetype : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTDownloadFile(String(filename), TNXTFileType(filetype)));
end;

function FantomSpiritNXTUploadFile(fsh : FantomHandle; filename, dir : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTUploadFile(String(filename), String(dir)));
end;

procedure FantomSpiritNXTInitializeResourceNames(fsh : FantomHandle); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  tmp.NXTInitializeResourceNames;
end;

procedure FantomSpiritNXTUpdateResourceNames(fsh : FantomHandle); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  tmp.NXTUpdateResourceNames;
end;

function FantomSpiritNXTDownloadStream(fsh : FantomHandle; aStream : PByte; count : Integer; dest : PChar; filetype : byte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  tmpStream : TMemoryStream;
begin
  tmp := TFantomSpirit(fsh);
  tmpStream := TMemoryStream.Create;
  try
    tmpStream.Read(aStream^, count);
    Result := Ord(tmp.NXTDownloadStream(tmpStream, String(dest), TNXTFileType(filetype)));
  finally
    tmpStream.Free;
  end;
end;

function FantomSpiritNXTUploadFileToStream(fsh : FantomHandle; filename : PChar; aStream : PByte) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  tmpStream : TMemoryStream;
begin
  tmp := TFantomSpirit(fsh);
  tmpStream := TMemoryStream.Create;
  try
    Result := Ord(tmp.NXTUploadFileToStream(String(filename), tmpStream));
    tmpStream.Write(aStream^, tmpStream.Size);
  finally
    tmpStream.Free;
  end;
end;

function FantomSpiritNXTListFiles(fsh : FantomHandle; searchPattern : PChar; Files : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  tmpSL : TStringList;
begin
  tmp := TFantomSpirit(fsh);
  tmpSL := TStringList.Create;
  try
    Result := Ord(tmp.NXTListFiles(String(searchPattern), tmpSL));
    StrCopy(Files, PChar(tmpSL.Text));
  finally
    tmpSL.Free;
  end;
end;

function FantomSpiritNXTListModules(fsh : FantomHandle; searchPattern : PChar; Modules : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  tmpSL : TStringList;
begin
  tmp := TFantomSpirit(fsh);
  tmpSL := TStringList.Create;
  try
    Result := Ord(tmp.NXTListModules(String(searchPattern), tmpSL));
    StrCopy(Modules, PChar(tmpSL.Text));
  finally
    tmpSL.Free;
  end;
end;

function FantomSpiritNXTListBricks(fsh : FantomHandle; Bricks : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  tmpSL : TStringList;
begin
  tmp := TFantomSpirit(fsh);
  tmpSL := TStringList.Create;
  try
    Result := Ord(tmp.NXTListBricks(tmpSL));
    StrCopy(Bricks, PChar(tmpSL.Text));
  finally
    tmpSL.Free;
  end;
end;

function FantomSpiritPoll(fsh : FantomHandle; aSrc, aNum : integer; value : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  val : string;
begin
  tmp := TFantomSpirit(fsh);
  val := tmp.Poll(aSrc, aNum);
  StrCopy(value, PChar(val));
  Result := 1;
end;

function FantomSpiritGetVariableValue(fsh : FantomHandle; aVar: integer; value : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  val : string;
begin
  tmp := TFantomSpirit(fsh);
  val := tmp.GetVariableValue(aVar);
  StrCopy(value, PChar(val));
  Result := 1;
end;

function FantomSpiritSendRawCommand(fsh : FantomHandle; aCmd : PChar; bRetry : byte; value : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  val : string;
begin
  tmp := TFantomSpirit(fsh);
  val := tmp.SendRawCommand(aCmd, Boolean(bRetry));
  StrCopy(value, PChar(val));
  Result := 1;
end;

function FantomSpiritPollMemory(fsh : FantomHandle; address : Integer; size : Integer; value : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  SL : TStrings;
  MS : TMemoryStream;
begin
  tmp := TFantomSpirit(fsh);
  MS := TMemoryStream.Create;
  try
    SL := tmp.PollMemory(address, size);
    SL.SaveToStream(MS);
    MS.Position := 0;
    MS.Read(value^, MS.Size);
  finally
    MS.Free;
  end;
  Result := 1;
end;

function FantomSpiritPollEEPROM(fsh : FantomHandle; block : Integer; value : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
  val : string;
begin
  tmp := TFantomSpirit(fsh);
  val := tmp.PollEEPROM(block).Text;
  StrCopy(value, PChar(val));
  Result := 1;
end;

function FantomSpiritSetNXTLowSpeed(fsh : FantomHandle; aPort : byte; lsb : NXTLSBlock) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  tmp.NXTLowSpeed[aPort] := lsb;
  Result := 1;
end;

function FantomSpiritGetNXTLowSpeed(fsh : FantomHandle; aPort : byte; var lsb : NXTLSBlock) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  lsb := tmp.NXTLowSpeed[aPort];
  Result := 1;
end;

function FantomSpiritIsOpen(fsh : FantomHandle) : byte; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.IsOpen);
end;

function FantomSpiritUseBluetooth(fsh : FantomHandle) : byte; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.UseBluetooth);
end;

function FantomSpiritBluetoothName(fsh : FantomHandle; name : PChar) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  StrCopy(name, PChar(tmp.BluetoothName));
  Result := 1;
end;

function FantomSpiritGetSearchBluetooth(fsh : FantomHandle) : byte; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.SearchBluetooth);
end;

procedure FantomSpiritSetSearchBluetooth(fsh : FantomHandle; search : byte); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  tmp.SearchBluetooth := Boolean(search);
end;

function FantomSpiritGetBluetoothSearchTimeout(fsh : FantomHandle) : cardinal; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := tmp.BluetoothSearchTimeout;
end;

procedure FantomSpiritSetBluetoothSearchTimeout(fsh : FantomHandle; sto : cardinal); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  tmp.BluetoothSearchTimeout := sto;
end;

function FantomSpiritGetBrickType(fsh : FantomHandle) : byte; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := tmp.BrickType;
end;

procedure FantomSpiritSetBrickType(fsh : FantomHandle; btype : byte); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  tmp.BrickType := btype;
end;

procedure FantomSpiritGetPort(fsh : FantomHandle; port : PChar); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  StrCopy(port, PChar(tmp.Port));
end;

procedure FantomSpiritSetPort(fsh : FantomHandle; port : PChar); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  tmp.Port := String(port);
end;

procedure FantomSpiritGetPortName(fsh : FantomHandle; name : PChar); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  StrCopy(name, PChar(tmp.PortName));
end;

procedure FantomSpiritGetNicePortName(fsh : FantomHandle; name : PChar); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  StrCopy(name, PChar(tmp.NicePortName));
end;

procedure FantomSpiritGetFullPortName(fsh : FantomHandle; name : PChar); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  StrCopy(name, PChar(tmp.FullPortName));
end;

procedure FantomSpiritGetBrickTypeName(fsh : FantomHandle; name : PChar); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  StrCopy(name, PChar(tmp.BrickTypeName));
end;

function FantomSpiritNXTDefragmentFlash(fsh : FantomHandle) : integer; cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  Result := Ord(tmp.NXTDefragmentFlash);
end;

procedure FantomSpiritDownloadMemoryMap(fsh : FantomHandle; value : PChar); cdecl; export;
var
  tmp : TFantomSpirit;
begin
  tmp := TFantomSpirit(fsh);
  StrCopy(value, PChar(tmp.DownloadMemoryMap.Text));
end;

end.