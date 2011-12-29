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
unit spirit;

interface

uses
  FantomDefs, uSpirit;

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

var
  SpiritAPILoaded: Boolean = False;

procedure UnloadSpiritAPI;

implementation

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
  DLLHandle := LoadLibrary('NXTSPIRITLIB.DLL');
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

end.
