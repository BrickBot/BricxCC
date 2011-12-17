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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit FantomSpirit;

interface

uses
  Classes, SysUtils, rcx_cmd, uSpirit, uNXTConstants, FantomDefs;

type
  TFantomSpirit = class(TBrickComm)
  private
    fResPort : string;
    fResourceNames : TStrings;
//    fNXTFileHandle : FantomHandle;
//    fNXTFileIteratorHandle : FantomHandle;
    dcResponse : array [0..63] of byte;
    function TransferFirmware(aStream: TStream): boolean;
  protected
    fNXTHandle : FantomHandle;
    function  GetDownloadWaitTime: Integer; override;
    function  GetEEPROM(addr: Byte): Byte; override;
    function  GetEEPROMBlock(idx: Integer): EEPROMBlock; override;
    function  GetIsOpen: boolean; override;
    function  GetLSBlock(aPort: byte): NXTLSBlock; override;
    function  GetFullPortName: string; override;
    function  GetNicePortName: string; override;
    function  GetOmitHeader: Boolean; override;
    function  GetPortName: string; override;
    function  GetQuiet: Boolean; override;
    function  GetRCXFirmwareChunkSize: Integer; override;
    function  GetRxTimeout: Word; override;
    function  GetLinkLog: string; override;
    function  GetUseBT: Boolean; override;
    procedure SetDownloadWaitTime(const Value: Integer); override;
    procedure SetEEPROM(addr: Byte; const Value: Byte); override;
    procedure SetLSBlock(aPort: byte; const Value: NXTLSBlock); override;
    procedure SetOmitHeader(const Value: Boolean); override;
    procedure SetPort(const Value: string); override;
    procedure SetQuiet(const Value: Boolean); override;
    procedure SetRCXFirmwareChunkSize(const Value: Integer); override;
    procedure SetRxTimeout(const Value: Word); override;
  protected
    function  dcBuffer: PByte;
    function  GetReplyByte(index: integer): Byte;
    function  GetReplyCardinal(index: integer): Cardinal;
    function  GetReplyWord(index: integer): Word;
    procedure SetResourcePort(const name : string);
    procedure LookupResourceName;
    function InternalNXTUploadFileToStream(handle : FantomHandle; const name : string;
      const totalSize, availSize : cardinal; aStream : TStream) : boolean;
    procedure LookupOffsetsIfNeeded;
    function GetNXTVariableHelper(aNum, aIdx, aCount, aDigits : integer) : variant;
    function GetVariantFromByteArray(dst : TDSType; buf : array of byte; idx : integer) : variant;
  public
    constructor Create(aType : byte = 0; const aPort : string = ''); override;
    destructor Destroy; override;

    function  Open : boolean; override;
    function  Close : boolean; override;

    procedure FlushReceiveBuffer; override;
    procedure SendRawData(const Data : array of byte); override;

    // PBrick sound commands
    function PlayTone(aFreq, aTime : word) : boolean; override;
    function PlaySystemSound(aSnd : byte) : boolean; override;

    // PBrick output control commands
    function MotorsOn(aMotorList : Byte) : boolean; override;
    function MotorsOff(aMotorList : Byte) : boolean; override;
    function MotorsFloat(aMotorList : Byte) : boolean; override;
    function SetFwd(aMotorList : Byte) : boolean; override;
    function SetRwd(aMotorList : Byte) : boolean; override;
    function SwitchDirection(aMotorList : Byte) : boolean; override;
    function SetMotorPower(aMotorList : Byte; aSrc, aNum : integer) : boolean; override;

    // PBrick input control commands
    function SetSensorType(aNum, aType : integer) : boolean; override;
    function SetSensorMode(aNum, aMode, aSlope : integer) : boolean; override;
    function ClearSensorValue(aNum : integer) : boolean; override;

    // general
    function TowerExists : boolean; override;
    function Ping : boolean; override;
    function PrepareBrick : boolean; override;
    function UnlockFirmware : boolean; override;
    function UnlockBrick : string; override;
    function DownloadMemoryMap : TStrings; override;
    function MonitorIR(aSeconds: integer): TStrings; override;
    function PowerDownTime(aTime : integer) : boolean; override;
    function BatteryLevel : integer; override;
    function BrickAlive : boolean; override;
    function Shutdown : boolean; override;
    function Sleep(aVal : integer) : boolean; override;
	  function Version(var rom : Cardinal; var ram : Cardinal) : boolean; override;
    function TransmitPower(aLevel : TTransmitLevel) : boolean; override;

    function Poll(aSrc, aNum : integer) : variant; override;
    function StartTask(aTask : integer) : boolean; override;
    function StopTask(aTask : integer) : boolean; override;
    function StopAllTasks : boolean; override;
    function DeleteTask(aTask : integer) : boolean; override;
    function DeleteAllTasks : boolean; override;
    function DeleteSub(aSub : integer) : boolean; override;
    function DeleteAllSubs : boolean; override;
    function ClearTimer(aNum : integer) : boolean; override;
    function ClearMemory : boolean; override;

    function GetOutputStatus(aOut : integer) : integer; override;
    function GetVariableValue(aVar: integer): variant; override;
    function GetInputValue(aIn: integer): integer; override;
    function GetMessageValue(aNum : integer) : integer; override;
    function GetTimerValue(aNum : integer) : integer; override;
    function GetCounterValue(aNum : integer) : integer; override;

    // PBrick arithmetic/logical commands
    function SetVar(aVar, aSrc, aNum : integer) : boolean; override;
    function SumVar(aVar, aSrc, aNum : integer) : boolean; override;
    function SubVar(aVar, aSrc, aNum : integer) : boolean; override;
    function DivVar(aVar, aSrc, aNum : integer) : boolean; override;
    function MulVar(aVar, aSrc, aNum : integer) : boolean; override;
    function SgnVar(aVar, aSrc, aNum : integer) : boolean; override;
    function AbsVar(aVar, aSrc, aNum : integer) : boolean; override;
    function AndVar(aVar, aSrc, aNum : integer) : boolean; override;
    function OrVar(aVar, aSrc, aNum : integer) : boolean; override;

    // communication to brick
    function SendRawCommand(aCmd : string; bRetry : boolean) : string; override;
    function SendRemoteStr(aEvent : string; aRepeat : integer = 1) : boolean; override;
    function SendRemote(aEvent : Word; aRepeat : integer = 1) : boolean; override;
    function SendMessage(aMsg : integer) : boolean; override;

    // RCX/2 only
    function SelectProgram(aProg : integer) : boolean; override;
    function SelectDisplay(aSrc, aNumber : integer) : boolean; override;
    function SetWatchHHMM(aHrs, aMins : integer) : boolean; override;
    function SetWatch(aTime : string) : boolean; override;
    function DownloadFirmware(aFile : string; bFast, bComp, bUnlock : boolean) : boolean; override;
    function SetDatalog(aSize : integer) : boolean; override;
    function DatalogNext(aSrc, aNum : integer) : boolean; override;
    function UploadPartialDatalog(aFrom, aSize : integer) : TStrings; override;
    function UploadDatalog(bVerbose : boolean) : TStrings; override;

    // CM only methods
    function Drive(aLeft, aRight : integer) : boolean; override;
    function ClearTachoCounter(aMotorList : Byte) : boolean; override;
    function OnWait(aMotorList : Byte; aNum : integer; aTime : Byte) : boolean; override;
    function OnWaitDifferent(aMotorList : Byte; aNum0, aNum1, aNum2 : integer; aTime : Byte) : boolean; override;

    // Scout only methods
    function ScoutNum(aVal : integer) : boolean; override;
    function Scout(bPower : boolean = true) : boolean; override;
    function CalibrateLightSensor : boolean; override;
    function SetFeedback(src, val : integer) : boolean; override;
    function SetLightSensorUpperThreshold(src : TLSSource; val : TThresholdValue) : boolean; override;
    function SetLightSensorLowerThreshold(src : TLSSource; val : TThresholdValue) : boolean; override;
    function SetLightSensorHysteresis(src : TLSSource; val : TThresholdValue) : boolean; override;
    function SetLightSensorBlinkTime(src : TLSSource; val : TBlinkTimeValue) : boolean; override;
    function SetTimerLimit(num : TTimerNumber; src : TTCSource; val : integer) : boolean; override;
    function SetCounterLimit(num : TCounterNumber; src : TTCSource; val : integer) : boolean; override;
    function ScoutRules(motion : TScoutMotion; touch : TScoutTouch;
      light : TScoutLight; time : TScoutScale; fx : TScoutEffects) : boolean; override;
    function ScoutSound(bSoundEnable : boolean; bSoundOff : boolean; aNum : TSoundSetNumber) : boolean; override;

    // Scout & Spybot only methods
    function SendVLL(aSrc, aNum : integer) : boolean; override;
    function SetLight(bOn : boolean) : boolean; override;

    // RCX2, Scout, & Spybot methods
    function PollMemory(address : Integer; size : Integer = 128) : TStrings; override;
    function SetGlobalOutput(motors : TMotorsNum; action : TGlobalOutAction) : boolean; override;
    function SetGlobalDirection(motors : TMotorsNum; action : TGlobalDirAction) : boolean; override;
    function SetMaxPower(motors : TMotorsNum; src, num : integer) : boolean; override;
    function IncCounter(num : TCounterNumber) : boolean; override;
    function DecCounter(num : TCounterNumber) : boolean; override;
    function ClearCounter(num : TCounterNumber) : boolean; override;

    // RCX2 & spybot only methods
    function ClearSound : boolean; override;
    function UnmuteSound : boolean; override;
    function SendUARTData(start, size : integer) : boolean; override;
    function SetEvent(enum, snum, etype : integer) : boolean; override;
    function CalibrateEvent(enum, upper, lower, hysteresis : integer) : boolean; override;
    function ClearAllEvents : boolean; override;
    function SetSourceValue(aDestSrc, aDestVal, aOrigSrc: Byte; aOrigVal: Smallint): boolean; override;

    // RCX2, Spy, & NXT
    function MuteSound : boolean; override;

    // RCX2 only methods
    function ViewSourceValue(prec, src, value : integer) : boolean; override;

    // Spybot only methods
    function PollEEPROM(block : Integer = -1) : TStrings; override;

    // NXT only methods
    // NXT direct commands
    function NXTStartProgram(const filename : string) : boolean; override;
    function NXTStopProgram : boolean; override;
    function NXTPlaySoundFile(const filename : string; bLoop : boolean) : boolean; override;
    function GetNXTOutputState(const aPort : byte; var power : integer;
      var mode, regmode : byte; var turnratio : integer;
      var runstate : byte; var tacholimit : cardinal; var tachocount,
      blocktachocount, rotationcount : longint) : boolean; override;
    function SetNXTOutputState(const aPort : byte; const power : integer;
      const mode, regmode : byte; const turnratio : integer;
      const runstate : byte; const tacholimit : cardinal) : boolean; override;
    function GetNXTInputValues(const aPort : byte; var valid, calibrated : boolean;
      var stype, smode : byte; var raw, normalized : word;
      var scaled, calvalue : smallint) : boolean; override;
    function SetNXTInputMode(const aPort, stype, smode : byte) : boolean; override;
    function NXTResetInputScaledValue(const aPort : byte) : boolean; override;
    function NXTResetOutputPosition(const aPort : byte; const Relative : boolean) : boolean; override;
    function NXTMessageWrite(const inbox : byte; const msg : string) : boolean; override;
    function NXTKeepAlive(var time : cardinal; const chkResponse : boolean = true) : boolean; override;
    function NXTLSGetStatus(aPort : byte; var bytesReady : byte) : boolean; override;
    function NXTGetCurrentProgramName(var name : string) : boolean; override;
    function NXTGetButtonState(const idx : byte; const reset : boolean;
      var pressed : boolean; var count : byte) : boolean; override;
    function NXTMessageRead(const remote, local : byte; const remove : boolean; var Msg : NXTMessage) : boolean; override;
    function NXTSetPropDebugging(const debugging : boolean; const pauseClump : byte; const pausePC : Word) : boolean; override;
    function NXTGetPropDebugging(var debugging : boolean; var pauseClump : byte; var pausePC : Word) : boolean; override;
    function NXTSetVMState(const state : byte) : boolean; override;
    function NXTSetVMStateEx(var state : byte; var clump : byte; var pc : word) : boolean; override;
    function NXTGetVMState(var state : byte; var clump : byte; var pc : word) : boolean; override;
    // NXT system commands
    function NXTOpenRead(const filename : string; var handle : FantomHandle;
      var size : cardinal) : boolean; override;
    function NXTOpenWrite(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function NXTRead(var handle : FantomHandle; var count : word;
      var buffer : NXTDataBuffer) : boolean; override;
    function NXTWrite(var handle : FantomHandle; const buffer : NXTDataBuffer;
      var count : word; const chkResponse : boolean = false) : boolean; override;
    function NXTCloseFile(var handle : FantomHandle; const chkResponse: boolean = false) : boolean; override;
    function NXTDeleteFile(var filename : string; const chkResponse: boolean = false) : boolean; override;
    function NXTFindFirstFile(var filename : string; var IterHandle : FantomHandle; var filesize, availsize : cardinal) : boolean; override;
    function NXTFindNextFile(var IterHandle : FantomHandle; var filename : string; var filesize, availsize : cardinal) : boolean; override;
    function NXTFindClose(var IterHandle : FantomHandle) : boolean; override;
    function NXTGetVersions(var protmin, protmaj, firmmin, firmmaj : byte) : boolean; override;
    function NXTOpenWriteLinear(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function NXTOpenReadLinear(const filename : string; var handle : FantomHandle;
      var size : cardinal) : boolean; override;
    function NXTOpenWriteData(const filename : string; const size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function NXTOpenAppendData(const filename : string; var size : cardinal;
      var handle : FantomHandle) : boolean; override;
    function NXTCloseModuleHandle(var handle : FantomHandle; const chkResponse: boolean = false) : boolean; override;
    function NXTBootCommand(const chkResponse: boolean = false) : boolean; override;
    function NXTSetBrickName(const name : string; const chkResponse: boolean = false) : boolean; override;
    function NXTGetDeviceInfo(var name : string; var BTAddress : string;
      var BTSignal : Cardinal; var memFree : Cardinal) : boolean; override;
    function NXTFreeMemory : integer; override;
    function NXTDeleteUserFlash(const chkResponse: boolean = false) : boolean; override;
    function NXTBTFactoryReset(const chkResponse: boolean = false) : boolean; override;
    function NXTPollCommandLen(const bufNum : byte; var count : byte) : boolean; override;
    function NXTPollCommand(const bufNum : byte; var count : byte;
      var buffer : NXTDataBuffer) : boolean; override;
    function NXTWriteIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; const buffer : NXTDataBuffer; chkResponse : Boolean = False) : boolean; override;
    function NXTReadIOMap(var ModID : Cardinal; const Offset : Word;
      var count : Word; var buffer : NXTDataBuffer) : boolean; override;
    function NXTFindFirstModule(var ModName : string; var Handle : FantomHandle;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; override;
    function NXTFindNextModule(var Handle : FantomHandle; var ModName : string;
      var ModID, ModSize : Cardinal; var IOMapSize : Word) : boolean; override;
    function NXTRenameFile(const old, new : string; const chkResponse: boolean = false) : boolean; override;
{
  kNXT_SCGetBTAddress          = $9A;
}
    // wrapper functions
    function NXTDownloadFile(const filename : string; const filetype : TNXTFileType) : boolean; override;
    function NXTDownloadStream(aStream : TStream; const dest : string; const filetype : TNXTFileType) : boolean; override;
    function NXTUploadFile(const filename : string; const dir : string = '') : boolean; override;
    function NXTUploadFileToStream(const filename : string; aStream : TStream) : boolean; override;
    function NXTListFiles(const searchPattern : string; Files : TStrings) : boolean; override;
    function NXTListModules(const searchPattern : string; Modules : TStrings) : boolean; override;
    function NXTListBricks(Bricks : TStrings) : boolean; override;
    procedure NXTInitializeResourceNames; override;
    procedure NXTUpdateResourceNames; override;
  end;

procedure iNXT_sendSystemCommand(nxtHandle : FantomHandle; requireResponse : byte;
  inputBufferPtr : Pbyte; inputBufferSize : Cardinal; outputBufferPtr : PByte;
  outputBufferSize : Cardinal; var status : integer);

implementation

uses
  rcx_constants, Contnrs, Math, uCommonUtils, uDebugLogging,
  {$IFNDEF FPC}
  FANTOM
  {$ELSE}
  {$IFDEF Darwin}fantomosx{$ENDIF}
  {$IFNDEF Darwin}
  {$IFDEF Unix}fantomfpc{$ENDIF}
  {$IFDEF Windows}FANTOM{$ENDIF}
  {$ENDIF}
  {$ENDIF};


procedure iNXT_sendSystemCommand(nxtHandle : FantomHandle; requireResponse : byte;
  inputBufferPtr : Pbyte; inputBufferSize : Cardinal; outputBufferPtr : PByte;
  outputBufferSize : Cardinal; var status : integer);
var
  BufOut, BufIn : PByte;
  dstatus : integer;
begin
  if status < kStatusNoError then Exit;
  BufOut := nil;
  GetMem(BufOut, inputBufferSize+1);
  try
    BufOut^ := kNXT_SystemCmd;
    if not Boolean(requireResponse) then
      BufOut^ := BufOut^ or kNXT_NoResponseMask;
    inc(BufOut);
    Move(inputBufferPtr^, BufOut^, inputBufferSize);
    dec(BufOut);
    iNXT_write(nxtHandle, BufOut, inputBufferSize+1, status);
    if Boolean(requireResponse) and (status >= kStatusNoError) then
    begin
      BufIn := nil;
      GetMem(BufIn, outputBufferSize+1);
      try
        iNXT_read(nxtHandle, BufIn, outputBufferSize+1, status);
        if Boolean(requireResponse) and (status >= kStatusNoError) then
        begin
          inc(BufIn);
          Move(BufIn^, outputBufferPtr^, outputBufferSize);
          dec(BufIn);
        end;
      finally
        FreeMem(BufIn);
      end;
    end
    else
    begin
      // no response required or error occurred on write
      // drain our channel of any leftover data
      BufIn := nil;
      GetMem(BufIn, 1);
      try
        dstatus := kStatusNoError;
        while dstatus = kStatusNoError do
          iNXT_read(nxtHandle, BufIn, 1, dstatus);
      finally
        FreeMem(BufIn);
      end;
    end;
  finally
    FreeMem(BufOut);
  end;
end;

var
  scResponse : array [0..63] of byte;

procedure iNXT_getDeviceInfoEx(nxtHandle : FantomHandle; name : PChar;
  address : PByte; signalStrength : PByte; var availableFlash : Cardinal;
  var status : integer);
var
  cmd : TNINxtCmd;
  scBuffer : PByte;
  b1, b2, b3, b4 : Byte;
begin
  FillChar(scResponse, 64, 0);
  scBuffer := @scResponse[0];
  cmd := TNINxtCmd.Create;
  try
    cmd.SetVal(kNXT_SystemCmd, kNXT_SCGetDeviceInfo);
    iNXT_sendSystemCommand(nxtHandle, 1, cmd.BytePtr, cmd.Len, scBuffer, 32, status);
    if status = kStatusNoError then
    begin
      inc(scBuffer, 2); // offset to start of name in the response
      Move(scBuffer^, name^, 15);
      inc(scBuffer, 15); // move to address
      Move(scBuffer^, address^, 6);
      inc(scBuffer, 7); // move to signal strength
      Move(scBuffer^, signalStrength^, 4);
      inc(scBuffer, 4);
      b1 := scBuffer^; inc(scBuffer);
      b2 := scBuffer^; inc(scBuffer);
      b3 := scBuffer^; inc(scBuffer);
      b4 := scBuffer^; inc(scBuffer);
      availableFlash := BytesToCardinal(b1, b2, b3, b4);
    end;
  finally
    cmd.Free;
  end;
end;


procedure iNXT_sendDirectCommandEnhanced(nxtHandle : FantomHandle; requireResponse : byte;
  inputBufferPtr : Pbyte; inputBufferSize : Cardinal; outputBufferPtr : PByte;
  outputBufferSize : Cardinal; var status : integer; bEnhanced : boolean = false);
var
  BufOut, BufIn : PByte;
  dstatus : integer;
begin
  // is this an enhanced direct command?
  if requireResponse = 127 then
  begin
    if status < kStatusNoError then Exit;
    BufOut := nil;
    GetMem(BufOut, inputBufferSize+1);
    try
      BufOut^ := kNXT_DirectCmd;
      if not Boolean(requireResponse) then
        BufOut^ := BufOut^ or kNXT_NoResponseMask;
      inc(BufOut);
      Move(inputBufferPtr^, BufOut^, inputBufferSize);
      dec(BufOut);
      iNXT_write(nxtHandle, BufOut, inputBufferSize+1, status);
      if Boolean(requireResponse) and (status >= kStatusNoError) then
      begin
        BufIn := nil;
        GetMem(BufIn, outputBufferSize+1);
        try
          iNXT_read(nxtHandle, BufIn, outputBufferSize+1, status);
          if Boolean(requireResponse) and (status >= kStatusNoError) then
          begin
            inc(BufIn);
            Move(BufIn^, outputBufferPtr^, outputBufferSize);
            dec(BufIn);
          end;
        finally
          FreeMem(BufIn);
        end;
      end
      else
      begin
        // no response required or error occurred on write
        // drain our channel of any leftover data
        BufIn := nil;
        GetMem(BufIn, 1);
        try
          dstatus := kStatusNoError;
          while dstatus = kStatusNoError do
            iNXT_read(nxtHandle, BufIn, 1, dstatus);
        finally
          FreeMem(BufIn);
        end;
      end;
    finally
      FreeMem(BufOut);
    end;
  end
  else
    iNXT_sendDirectCommand(nxtHandle, requireResponse, inputBufferPtr,
      inputBufferSize, outputBufferPtr, outputBufferSize, status);
end;

function NXTModuleIDToName(const modID : cardinal) : string;
var
  i : integer;
begin
  Result := '*.*';
  for i := Low(NXTModuleMap) to High(NXTModuleMap) do
  begin
    if NXTModuleMap[i].ID = modID then
    begin
      Result := NXTModuleMap[i].Name;
      Break;
    end;
  end;
end;

{ TFantomSpirit }

constructor TFantomSpirit.Create(aType: byte; const aPort: string);
begin
  inherited Create(aType, aPort);
  fResPort := '';
  fResourceNames := TStringList.Create;
end;

destructor TFantomSpirit.Destroy;
begin
  FreeAndNil(fResourceNames);
  inherited Destroy;
end;

function TFantomSpirit.BatteryLevel: integer;
var
  bopen : boolean;
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := -1;
  bopen := IsOpen;
  if bopen then
  begin
    cmd := TNINxtCmd.Create;
    try
      status := kStatusNoError;
      cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetBatteryLevel);
      iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 4, status);
      if status < kStatusNoError then
      begin
        result := kRCX_ReplyError;
        Exit;
      end;
      Result := GetReplyWord(0);
    finally
      cmd.Free;
    end;
  end;
end;

function TFantomSpirit.Shutdown: boolean;
var
  modID : Cardinal;
  count : Word;
  buffer : NXTDataBuffer;
begin
  Result := IsOpen;
  if not Result then Exit;
  modID := kNXT_ModuleIOCtrl;
  count := 2;
  buffer.Data[0] := $0;
  buffer.Data[1] := $5a;
  Result := NXTWriteIOMap(modID, IOCtrlOffsetPowerOn, count, buffer);
end;

const
  MotorBits : array[0..2] of byte = (1, 2, 4);

function TFantomSpirit.MotorsOn(aMotorList: Byte): boolean;
var
  mode, regmode, runstate : byte;
  oldpower, power, turnratio : integer;
  tacholimit : cardinal;
  tachocount, blocktachocount, rotationcount : integer;
  i : Byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  for i := 0 to 2 do
  begin
    if (MotorBits[i] and aMotorList) = MotorBits[i] then
    begin
      fMotorOn[i] := True;
      rotationcount := 0;
      blocktachocount := 0;
      tachocount := 0;
      tacholimit := 0;
      runstate := 0;
      turnratio := 0;
      mode := 0;
      regmode := 0;
      oldpower := 0;
      Result := Result and GetNXTOutputState(i, oldpower, mode, regmode, turnratio,
        runstate, tacholimit, tachocount, blocktachocount, rotationcount);
      if fMotorPower[i] = 7 then
        power := 100
      else
        power := fMotorPower[i] * 14;
      if not fMotorForward[i] then
        power := power * -1;
      if (oldpower <> power) or
         ((mode and OUT_MODE_MOTORON) <> OUT_MODE_MOTORON) or
         ((runstate and OUT_RUNSTATE_RUNNING) <> OUT_RUNSTATE_RUNNING) then
      begin
        mode := OUT_MODE_MOTORON+OUT_MODE_BRAKE;
        runstate := OUT_RUNSTATE_RUNNING;
        Result := Result and SetNXTOutputState(i, power, mode, regmode, turnratio,
          runstate, tacholimit);
      end;
    end;
    if not Result then Break;
  end;
end;

function TFantomSpirit.MotorsOff(aMotorList: Byte): boolean;
var
  mode, regmode, runstate : byte;
  power, turnratio : integer;
  tacholimit : cardinal;
  i : Byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  for i := 0 to 2 do
  begin
    if (MotorBits[i] and aMotorList) = MotorBits[i] then
    begin
      fMotorOn[i] := False;
      power := 0;
      mode  := OUT_MODE_MOTORON+OUT_MODE_BRAKE;
      regmode := OUT_REGMODE_IDLE;
      runstate := OUT_RUNSTATE_RUNNING;
      turnratio := 0; // straight (side effect of stopping motors is to reset turn ratio)
      tacholimit := 0; // no limit (side effect of stopping motors is to reset tacho limit)
      Result := Result and SetNXTOutputState(i, power, mode, regmode, turnratio,
        runstate, tacholimit);
    end;
    if not Result then Break;
  end;
end;

function TFantomSpirit.MotorsFloat(aMotorList: Byte): boolean;
var
  mode, regmode, runstate : byte;
  power, turnratio : integer;
  tacholimit : cardinal;
  i : Byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  for i := 0 to 2 do
  begin
    if (MotorBits[i] and aMotorList) = MotorBits[i] then
    begin
      fMotorOn[i] := False;
      power := 0;
      mode  := 0; // OUT_MODE_COAST;
      regmode := 0; // OUT_REGMODE_IDLE;
      runstate := 0; // OUT_RUNSTATE_IDLE;
      turnratio := 0; // straight (side effect of stopping motors is to reset turn ratio)
      tacholimit := 0; // no limit (side effect of stopping motors is to reset tacho limit)
      Result := Result and SetNXTOutputState(i, power, mode, regmode, turnratio,
        runstate, tacholimit);
    end;
    if not Result then Break;
  end;
end;

function TFantomSpirit.SetFwd(aMotorList: Byte): boolean;
var
  mode, regmode, runstate : byte;
  power, turnratio : integer;
  tacholimit : cardinal;
  tachocount, blocktachocount, rotationcount : integer;
  i : Byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  for i := 0 to 2 do
  begin
    if (MotorBits[i] and aMotorList) = MotorBits[i] then
    begin
      fMotorForward[i] := True;
      rotationcount := 0;
      blocktachocount := 0;
      tachocount := 0;
      tacholimit := 0;
      runstate := 0;
      turnratio := 0;
      mode := 0;
      regmode := 0;
      power := 0;
      Result := Result and GetNXTOutputState(i, power, mode, regmode, turnratio,
        runstate, tacholimit, tachocount, blocktachocount, rotationcount);
      if power < 0 then
      begin
        power := power * -1;
        if not fMotorOn[i] then
        begin
          // make sure we are idle
          mode := 0;
          regmode := 0;
          runstate := 0;
        end;
        Result := Result and SetNXTOutputState(i, power, mode, regmode, turnratio,
          runstate, tacholimit);
      end;
    end;
    if not Result then Break;
  end;
end;

function TFantomSpirit.SetRwd(aMotorList: Byte): boolean;
var
  mode, regmode, runstate : byte;
  power, turnratio : integer;
  tacholimit : cardinal;
  tachocount, blocktachocount, rotationcount : integer;
  i : Byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  for i := 0 to 2 do
  begin
    if (MotorBits[i] and aMotorList) = MotorBits[i] then
    begin
      fMotorForward[i] := False;
      rotationcount := 0;
      blocktachocount := 0;
      tachocount := 0;
      tacholimit := 0;
      runstate := 0;
      turnratio := 0;
      mode := 0;
      regmode := 0;
      power := 0;
      Result := Result and GetNXTOutputState(i, power, mode, regmode, turnratio,
        runstate, tacholimit, tachocount, blocktachocount, rotationcount);
      if power > 0 then
      begin
        power := power * -1;
        if not fMotorOn[i] then
        begin
          // make sure we are idle
          mode := 0;
          regmode := 0;
          runstate := 0;
        end;
        Result := Result and SetNXTOutputState(i, power, mode, regmode, turnratio,
          runstate, tacholimit);
      end;
    end;
    if not Result then Break;
  end;
end;

function TFantomSpirit.SwitchDirection(aMotorList: Byte): boolean;
var
  mode, regmode, runstate : byte;
  power, turnratio : integer;
  tacholimit : cardinal;
  tachocount, blocktachocount, rotationcount : integer;
  i : Byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  for i := 0 to 2 do
  begin
    if (MotorBits[i] and aMotorList) = MotorBits[i] then
    begin
      fMotorForward[i] := not fMotorForward[i];
      rotationcount := 0;
      blocktachocount := 0;
      tachocount := 0;
      tacholimit := 0;
      runstate := 0;
      turnratio := 0;
      mode := 0;
      regmode := 0;
      power := 0;
      Result := Result and GetNXTOutputState(i, power, mode, regmode, turnratio,
        runstate, tacholimit, tachocount, blocktachocount, rotationcount);
      power := power * -1;
      Result := Result and SetNXTOutputState(i, power, mode, regmode, turnratio,
        runstate, tacholimit);
    end;
    if not Result then Break;
  end;
end;

function TFantomSpirit.SetMotorPower(aMotorList: Byte; aSrc, aNum: integer): boolean;
var
  mode, regmode, runstate : byte;
  oldpower, power, turnratio : integer;
  tacholimit : cardinal;
  tachocount, blocktachocount, rotationcount : integer;
  i : Byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  if aSrc <> 2 then
  begin
    Result := False;
    Exit;
  end
  else
  begin
    for i := 0 to 2 do
    begin
      if (MotorBits[i] and aMotorList) = MotorBits[i] then
      begin
        fMotorPower[i] := Byte(Abs(aNum) mod 8);
        rotationcount := 0;
        blocktachocount := 0;
        tachocount := 0;
        tacholimit := 0;
        runstate := 0;
        turnratio := 0;
        mode := 0;
        regmode := 0;
        oldpower := 0;
        Result := Result and GetNXTOutputState(i, oldpower, mode, regmode, turnratio,
          runstate, tacholimit, tachocount, blocktachocount, rotationcount);
        if fMotorPower[i] = 7 then
          power := 100
        else
          power := fMotorPower[i] * 14;
        if not fMotorForward[i] then
          power := power * -1;
        if oldpower <> power then
        begin
          if not fMotorOn[i] then
          begin
            // make sure we are idle
            mode := 0;
            regmode := 0;
            runstate := 0;
          end;
          Result := Result and SetNXTOutputState(i, power, mode, regmode, turnratio,
            runstate, tacholimit);
        end;
      end;
      if not Result then Break;
    end;
  end;
end;

function TFantomSpirit.PlayTone(aFreq, aTime: word): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCPlayTone, Lo(aFreq), Hi(aFreq), Lo(aTime), Hi(aTime));
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.SetSensorType(aNum, aType: integer): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  fSensorType[aNum] := Byte(aType);
  Result := SetNXTInputMode(Byte(aNum), Byte(aType), fSensorMode[aNum]);
end;

function TFantomSpirit.SetSensorMode(aNum, aMode, aSlope: integer): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  fSensorMode[aNum] := Byte(((aMode and $7) shl 5) or (aSlope and $F));
  Result := SetNXTInputMode(Byte(aNum), fSensorType[aNum], fSensorMode[aNum]);
end;

function TFantomSpirit.ClearSensorValue(aNum: integer): boolean;
begin
  Result := NXTResetInputScaledValue(Byte(aNum));
end;

function TFantomSpirit.Close: boolean;
var
  status : integer;
begin
  Result := inherited Close;
  if IsOpen then
  begin
    DebugLog('TFantomSpirit.Close: Closing our open connection');
    fResPort   := ''; // clear this so that it gets looked up again when opening
    fUseBT     := False;
    status     := kStatusNoError;
    destroyNXT(fNXTHandle, status);
    fActive    := False;
    fNXTHandle := 0;
    Result := Result and (status >= kStatusNoError);
  end;
end;

function TFantomSpirit.Open: boolean;
var
  nih : FantomHandle;
  status, status2 : integer;
  resNamePC : array[0..54] of Char;
  pairedResNamePC : array[0..54] of Char;
  resName, pName, bName : string;
begin
  DebugLog('TFantomSpirit.Open: Checking whether the connection is already open');
  Result := IsOpen;
  if not FantomAPILoaded then Exit;
  if not Result then begin
    DebugLog('TFantomSpirit.Open: IsOpen returned FALSE');
    if fResPort = '' then
      LookupResourceName;
    if fResPort = '' then
      fResPort := fPort;
    resName := '';
    pName := AnsiUpperCase(fResPort);
    bName := AnsiUpperCase(BluetoothName);
    DebugFmt('TFantomSpirit.Open: pName = "%s"', [pName]);
    DebugFmt('TFantomSpirit.Open: bName = "%s"', [bName]);
    if (Length(pName) > 4) and (Pos('::', pName) > 0) then
    begin
      // we think this is a resource string
      // if we are using bluetooth then we need to make sure we are paired
      // with the brick
      status := kStatusNoError;
      // if we are using a brick resource string we think we have already paired
      // with the PC so try without pairing.  If that fails then try again after
      // pairing.
      DebugLog('TFantomSpirit.Open: Already have a full brick resource string so try to connect using it');
      fNXTHandle := createNXT(PChar(pName), status, 0);
      if status >= kStatusNoError then
      begin
        DebugLog('TFantomSpirit.Open: First attempt to createNXT worked.  All done.');
        fActive := True;
        Result := True;
      end
      else
      begin
        DebugFmt('TFantomSpirit.Open: First attempt to createNXT failed.  Status = %d.', [status]);
        // if bluetooth then try again after pairing
        if UseBluetooth then
        begin
          DebugLog('TFantomSpirit.Open: UseBluetooth is TRUE');
          status := kStatusNoError;
          DebugLog('TFantomSpirit.Open: Try pairing with pin = 1234');
          pairBluetooth(PChar(pName), '1234', pairedResNamePC, status);
          pName := pairedResNamePC;
          DebugFmt('TFantomSpirit.Open: pName now = "%s"', [pName]);
          if status >= kStatusNoError then
          begin
            DebugFmt('TFantomSpirit.Open: status = %d', [status]);
            status := kStatusNoError;
            DebugLog('TFantomSpirit.Open: Try calling createNXT again');
            fNXTHandle := createNXT(PChar(pName), status, 0);
            if status >= kStatusNoError then
            begin
              DebugLog('TFantomSpirit.Open: Second attempt to createNXT worked.  All done.');
              fActive := True;
              Result := True;
            end;
          end;
        end;
      end;
    end
    else
    begin
      DebugLog('TFantomSpirit.Open: We do not already have a full brick resource string');
      // use Fantom API to obtain a handle to an NXT on either USB or bluetooth
      status := kStatusNoError;
      DebugLog('TFantomSpirit.Open: calling createNXTIterator to search for devices');
      nih := createNXTIterator(Ord(UseBluetooth), BluetoothSearchTimeout, status);
      while status >= kStatusNoError do
      begin
        status2 := kStatusNoError;
        DebugLog('TFantomSpirit.Open: calling iNXTIterator_getName');
        iNXTIterator_getName(nih, resNamePC, status2);
        resName := AnsiUpperCase(resNamePC);
        DebugFmt('TFantomSpirit.Open: current resource name = "%s"', [resNamePC]);
        if UseBluetooth then
        begin
          if bName = '' then
            bName := 'BTH';
          if Pos(bName, resName) > 0 then
            Break;
        end
        else if Pos(pName, resName) > 0 then
          Break;
        iNXTIterator_advance(nih, status);
      end;
      // if we are using bluetooth then we need to make sure we are paired
      // with the brick
      if UseBluetooth then
      begin
        status := kStatusNoError;
        DebugLog('TFantomSpirit.Open: Try pairing with pin = 1234');
        pairBluetooth(resNamePC, '1234', pairedResNamePC, status);
        resName := AnsiUpperCase(pairedResNamePC);
        DebugFmt('TFantomSpirit.Open: resource name now = "%s"', [resName]);
      end;
      if status >= kStatusNoError then
      begin
        DebugLog('TFantomSpirit.Open: calling iNXTIterator_getNXT');
        fNXTHandle := iNXTIterator_getNXT(nih, status);
        if status >= kStatusNoError then
        begin
          DebugFmt('TFantomSpirit.Open: Got NXT with resName = "%s".  All done.', [resName]);
          SetResourcePort(resName);
          fActive := True;
          Result := True;
        end;
      end;
      status := kStatusNoError;
      DebugLog('TFantomSpirit.Open: calling destroyNXTIterator');
      destroyNXTIterator(nih, status);
    end;
  end;
end;

function TFantomSpirit.ClearMemory: boolean;
begin
  Result := NXTDeleteUserFlash(True);
end;

function TFantomSpirit.Sleep(aVal: integer): boolean;
begin
  Result := PowerDownTime(aVal);
end;

function TFantomSpirit.GetInputValue(aIn : integer) : integer;
var
  bOpen : boolean;
begin
  Result := -1;
  bopen := Open;
  if bOpen then
  begin
    Result := Poll(kRCX_InputValueType, aIn);
  end;
end;

procedure TFantomSpirit.SetPort(const Value: string);
begin
  if (Value <> fPort) or (fResPort = '') then
  begin
    Close;
    inherited SetPort(Value);
    fResPort := fPort;
    LookupResourceName;
  end;
end;

function TFantomSpirit.DownloadFirmware(aFile: string; bFast : Boolean;
  bComp : Boolean; bUnlock : boolean): boolean;
var
  MS : TMemoryStream;
begin
  if not IsOpen then
    Open;
  Result := FileExists(aFile);
  if Result and (bFast or bComp or bUnlock or True) then
  begin
    // put the NXT into firmware download mode first and wait a few seconds
    MS := TMemoryStream.Create;
    try
      MS.LoadFromFile(aFile);
      DoDownloadStart;
      Result := NXTDownloadStream(MS, aFile, nftFirmware);
      DoDownloadDone;
    finally
      MS.Free;
    end;
  end;
end;

function TFantomSpirit.Ping: boolean;
var
  time : cardinal;
begin
  Result := IsOpen;
  if not Result then Exit;
  time := 0;
  Result := NXTKeepAlive(time);
end;

function TFantomSpirit.MuteSound: boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCStopSoundPlayback);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.UnmuteSound: boolean;
var
  cmd : TNINxtCmd;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
  // TODO : Implement Unmute Sound
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.GetPortName: string;
begin
  Result := FPort;
end;

function TFantomSpirit.GetFullPortName: string;
begin
  Result := fResPort;
end;

function TFantomSpirit.GetNicePortName: string;
var
  i : integer;
begin
  i := Pos('::', fResPort);
  if i > 0 then
    Result := Copy(fResPort, 1, i-1)
  else
    Result := fResPort;
end;

function TFantomSpirit.GetIsOpen: boolean;
begin
  Result := inherited GetIsOpen;
  Result := Result and FantomAPILoaded;
end;

function TFantomSpirit.NXTStartProgram(const filename: string): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
  tmp : string;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    // any time you start a program reset the stored DS and DVA offsets
    fOffsetDS := MaxInt;
    fOffsetDVA := MaxInt;
    status := kStatusNoError;
    tmp := MakeValidNXTFilename(filename);
    cmd.MakeCmdWithFilename(kNXT_DirectCmd, kNXT_DCStartProgram, tmp);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 2, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTStopProgram: boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    // reset offsets to "no program running" values
    fOffsetDS := $FFFF;
    fOffsetDVA := $FFFF;
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCStopProgram);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 2, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTPlaySoundFile(const filename: string; bLoop: boolean): boolean;
var
  i : integer;
  cmd : TNINxtCmd;
  orig : PByte;
  nxtFilename : string;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    // filename is limited to 19 bytes + null terminator
    cmd.SetLength(23);
    orig := cmd.GetBody;
    orig^ := kNXT_DirectCmdNoReply;
    inc(orig);
    orig^ := kNXT_DCPlaySoundFile;
    inc(orig);
    orig^ := Ord(bLoop);
    inc(orig);
    i := 1;
    nxtFilename := MakeValidNXTFilename(filename);
    while i <= 19 do
    begin
      // copy the first nineteen bytes from the filename provided
      if i > Length(nxtFilename) then
        orig^ := 0
      else
        orig^ := Ord(nxtFilename[i]);
      inc(orig);
      inc(i);
    end;
    orig^ := 0; // set last byte to null
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.GetNXTOutputState(const aPort: byte; var power: integer;
  var mode, regmode: byte; var turnratio: integer; var runstate: byte;
  var tacholimit: cardinal; var tachocount, blocktachocount, rotationcount: Integer): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetOutputState, aPort);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 24, status);
    Result := status >= kStatusNoError;
    if not Result then
      Exit;
//    port      := GetReplyByte(0)
    power     := ShortInt(GetReplyByte(1));
    mode      := GetReplyByte(2);
    regmode   := GetReplyByte(3);
    turnratio := ShortInt(GetReplyByte(4));
    runstate  := GetReplyByte(5);
    tacholimit := GetReplyCardinal(6);
    tachocount := Integer(GetReplyCardinal(10));
    blocktachocount := Integer(GetReplyCardinal(14));
    rotationcount := Integer(GetReplyCardinal(18));
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.SetNXTOutputState(const aPort: byte;
  const power: integer; const mode, regmode: byte;
  const turnratio: integer; const runstate: byte;
  const tacholimit: cardinal): boolean;
var
  cmd : TNINxtCmd;
//  orig : PByte;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.MakeSetOutputState(aPort, mode, regmode, runstate, ShortInt(power), ShortInt(turnratio), tacholimit, False);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.GetNXTInputValues(const aPort: byte; var valid,
  calibrated: boolean; var stype, smode: byte; var raw, normalized: word;
  var scaled, calvalue: smallint): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetInputValues, aPort);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 15, status);
    Result := status >= kStatusNoError;
    if not Result then
      Exit;
//    port       := GetReplyByte(0);
    valid      := GetReplyByte(1) <> 0;
    calibrated := GetReplyByte(2) <> 0;
    stype      := GetReplyByte(3);
    smode      := GetReplyByte(4);
    raw        := GetReplyWord(5);
    normalized := GetReplyWord(7);
    scaled     := SmallInt(GetReplyWord(9));
    calvalue   := SmallInt(GetReplyWord(11));
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.SetNXTInputMode(const aPort, stype, smode: byte): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCSetInputMode, aPort, stype, smode);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTResetInputScaledValue(const aPort: byte): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCResetInputScaledValue, aPort);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTResetOutputPosition(const aPort: byte;
  const Relative: boolean): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCResetMotorPosition, aPort, Ord(Relative));
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTMessageWrite(const inbox: byte; const msg: string): boolean;
var
  i, len : integer;
  cmd : TNINxtCmd;
  orig : PByte;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    // message is limited to 59 bytes + null terminator
    len := Min(Length(msg), kNXT_MaxBytes-5);
    cmd.SetLength(len+5);
    orig := cmd.GetBody;
    orig^ := kNXT_DirectCmdNoReply;
    inc(orig);
    orig^ := kNXT_DCMessageWrite;
    inc(orig);
    orig^ := inbox;
    inc(orig);
    orig^ := Byte(len+1); // add null terminator
    inc(orig);
    i := 1;
    while i <= len do
    begin
      orig^ := Ord(msg[i]);
      inc(orig);
      inc(i);
    end;
    orig^ := 0; // set last byte to null
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTKeepAlive(var time: cardinal; const chkResponse : boolean): boolean;
var
  cmd : TNINxtCmd;
  b : byte;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    result := False;
    if chkResponse then
      b := kNXT_DirectCmd
    else
      b := kNXT_DirectCmdNoReply;
    cmd.SetVal(b, kNXT_DCKeepAlive);
    if chkResponse then
      iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 6, status)
    else
      iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
    Result := status >= kStatusNoError;
    if chkResponse then
    begin
      if not Result then
        Exit;
      time := Integer(GetReplyCardinal(0));
    end;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTLSGetStatus(aPort : byte; var bytesReady: byte): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCLSGetStatus, aPort);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 3, status);
    Result := status >= kStatusNoError;
    if not Result then
      Exit;
    bytesReady := GetReplyByte(0);
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.GetLSBlock(aPort: byte): NXTLSBlock;
var
  cmd : TNINxtCmd;
  i : integer;
  status : integer;
begin
  // LSRead
  Result.TXCount := 0;
  if not IsOpen then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCLSRead, aPort);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 19, status);
    if status < kStatusNoError then
    begin
      Result.RXCount := 0;
      Exit;
    end;
    Result.RXCount := GetReplyByte(0);
    for i := 1 to 16 do
    begin
      Result.Data[i-1] := GetReplyByte(i);
    end;
  finally
    cmd.Free;
  end;
end;

procedure TFantomSpirit.SetLSBlock(aPort: byte; const Value: NXTLSBlock);
var
  i, len : integer;
  cmd : TNINxtCmd;
  orig : PByte;
  status : integer;
begin
  // LSWrite
  if not IsOpen then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    len := Min(Value.TXCount, 16);
    cmd.SetLength(len+5); // up to a max of 21 bytes
    orig := cmd.GetBody;
    orig^ := kNXT_DirectCmdNoReply;
    inc(orig);
    orig^ := kNXT_DCLSWrite;
    inc(orig);
    orig^ := aPort;
    inc(orig);
    orig^ := Byte(len);
    inc(orig);
    orig^ := Byte(Min(Value.RXCount, 16));
    inc(orig);
    i := 0;
    while i < len do
    begin
      orig^ := Value.Data[i];
      inc(orig);
      inc(i);
    end;
    orig^ := 0; // set last byte to null
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status);
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTGetCurrentProgramName(var name: string): boolean;
var
  cmd : TNINxtCmd;
  i : integer;
  Buf : array[0..19] of Char;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetCurrentProgramName);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 22, status);
    Result := status >= kStatusNoError;
    if not Result then
    begin
      name   := '';
      Exit;
    end;
    for i := 0 to 19 do
    begin
      Buf[i] := Char(GetReplyByte(i));
    end;
    name := Buf;
    Result := name <> '';
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTGetButtonState(const idx: byte; const reset: boolean;
  var pressed: boolean; var count: byte): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetButtonState, idx, Ord(reset));
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 3, status);
    Result := status >= kStatusNoError;
    if not Result then
      Exit;
    pressed := Boolean(GetReplyByte(0));
    count   := GetReplyByte(1);
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTMessageRead(const remote, local: byte;
  const remove: boolean; var Msg: NXTMessage): boolean;
var
  cmd : TNINxtCmd;
  i : integer;
  status : integer;
begin
  Msg.Inbox := 0;
  Msg.Size  := 0;
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCMessageRead, remote, local, Ord(remove));
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 63, status);
    Result := status >= kStatusNoError;
    if not Result then
      Exit;
    Msg.Inbox := GetReplyByte(0);
    Msg.Size  := GetReplyByte(1);
    for i := 2 to 60 do
    begin
      Msg.Data[i-2] := GetReplyByte(i);
    end;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTOpenRead(const filename: string; var handle: FantomHandle;
  var size: cardinal): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  handle := iNXT_createFile(fNXTHandle, PChar(filename), status);
  Result := status >= kStatusNoError;
  if Result then
  begin
    iFile_openForRead(handle, status);
    Result := status >= kStatusNoError;
    if Result then
    begin
      size := iFile_getSize(handle, status);
      Result := status >= kStatusNoError;
    end;
    if not Result then
    begin
      status := kStatusNoError;
      iNXT_destroyFile(fNXTHandle, handle, status);
    end;
  end;
end;

function TFantomSpirit.NXTOpenReadLinear(const filename: string;
  var handle: FantomHandle; var size: cardinal): boolean;
begin
  Result := NXTOpenRead(filename, handle, size);
end;

function TFantomSpirit.NXTOpenAppendData(const filename: string;
  var size: cardinal; var handle: FantomHandle): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  handle := iNXT_createFile(fNXTHandle, PChar(filename), status);
  Result := status >= kStatusNoError;
  if Result then
  begin
    iFile_openForDataAppend(handle, status);
    Result := status >= kStatusNoError;
    if Result then
    begin
      size := iFile_getSize(handle, status);
      Result := status >= kStatusNoError;
    end;
    if not Result then
    begin
      status := kStatusNoError;
      iNXT_destroyFile(fNXTHandle, handle, status);
    end;
  end;
end;

function TFantomSpirit.NXTOpenWrite(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  handle := iNXT_createFile(fNXTHandle, PChar(filename), status);
  Result := status >= kStatusNoError;
  if Result then
  begin
    iFile_openForWrite(handle, size, status);
    Result := status >= kStatusNoError;
    if not Result then
    begin
      status := kStatusNoError;
      iNXT_destroyFile(fNXTHandle, handle, status);
    end;
  end;
end;

function TFantomSpirit.NXTOpenWriteData(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  handle := iNXT_createFile(fNXTHandle, PChar(filename), status);
  Result := status >= kStatusNoError;
  if Result then
  begin
    iFile_openForDataWrite(handle, size, status);
    Result := status >= kStatusNoError;
    if not Result then
    begin
      status := kStatusNoError;
      iNXT_destroyFile(fNXTHandle, handle, status);
    end;
  end;
end;

function TFantomSpirit.NXTOpenWriteLinear(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  handle := iNXT_createFile(fNXTHandle, PChar(filename), status);
  Result := status >= kStatusNoError;
  if Result then
  begin
    iFile_openForLinearWrite(handle, size, status);
    Result := status >= kStatusNoError;
    if not Result then
    begin
      status := kStatusNoError;
      iNXT_destroyFile(fNXTHandle, handle, status);
    end;
  end;
end;

function TFantomSpirit.NXTRead(var handle: FantomHandle; var count: word;
  var buffer: NXTDataBuffer): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iFile_read(handle, @buffer.Data[0], count, status);
  Result := status >= kStatusNoError;
end;

function TFantomSpirit.NXTWrite(var handle: FantomHandle; const buffer: NXTDataBuffer;
  var count: word; const chkResponse: boolean): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iFile_write(handle, @buffer.Data[0], count, status);
  if chkResponse then
    Result := status >= kStatusNoError
  else
    Result := status >= kStatusNoError;
end;

function TFantomSpirit.NXTCloseFile(var handle: FantomHandle; const chkResponse: boolean): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iFile_close(handle, status);
  if chkResponse then
    Result := status >= kStatusNoError
  else
    Result := status >= kStatusNoError;
  if Result then
  begin
    iNXT_destroyFile(FNXTHandle, handle, status);
    Result := status >= kStatusNoError;
  end;
end;

function TFantomSpirit.NXTDeleteFile(var filename: string; const chkResponse: boolean): boolean;
var
  handle : FantomHandle;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  handle := iNXT_createFile(FNXTHandle, PChar(filename), status);
  if chkResponse then
    Result := status >= kStatusNoError
  else
    Result := status >= kStatusNoError;
  if Result then
  begin
    iFile_remove(handle, status);
    Result := status >= kStatusNoError;
    status := kStatusNoError;
    iNXT_destroyFile(FNXTHandle, handle, status);
  end;
end;

function TFantomSpirit.NXTFindFirstFile(var filename: string;
  var IterHandle: FantomHandle; var filesize, availsize : cardinal): boolean;
var
  status : integer;
  buf : array[0..19] of Char;
  NXTFileHandle : FantomHandle;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  IterHandle := iNXT_createFileIterator(FNXTHandle, PChar(filename), status);
  Result := status >= kStatusNoError;
  if Result then
  begin
    iFileIterator_getName(IterHandle, buf, status);
    filename := buf;
    status := kStatusNoError;
    filesize := iFileIterator_getSize(IterHandle, status);
    NXTFileHandle := iFileIterator_getFile(IterHandle, status);
    status := kStatusNoError;
    availsize := iFile_getAvailableSize(NXTFileHandle, status);
    status := kStatusNoError;
    iFile_close(NXTFileHandle, status);
  end;
end;

function TFantomSpirit.NXTFindNextFile(var IterHandle: FantomHandle; var filename: string;
  var filesize, availsize : cardinal): boolean;
var
  status : integer;
  Buf : array[0..19] of Char;
  NXTFileHandle : FantomHandle;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iFileIterator_advance(IterHandle, status);
  Result := status >= kStatusNoError;
  if Result then
  begin
    iFileIterator_getName(IterHandle, buf, status);
    filename := buf;
    status := kStatusNoError;
    filesize := iFileIterator_getSize(IterHandle, status);
    NXTFileHandle := iFileIterator_getFile(IterHandle, status);
    status := kStatusNoError;
    availsize := iFile_getAvailableSize(NXTFileHandle, status);
    status := kStatusNoError;
    iFile_close(NXTFileHandle, status);
  end
  else
  begin
    Result := NXTFindClose(IterHandle);
    filename := '';
  end;
end;

function TFantomSpirit.NXTFindClose(var IterHandle: FantomHandle): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  // destroy the iterator
  status := kStatusNoError;
  iNXT_destroyFileIterator(fNXTHandle, IterHandle, status);
  IterHandle := 0;
  Result := status >= kStatusNoError;
end;

function TFantomSpirit.NXTGetVersions(var protmin, protmaj, firmmin, firmmaj : byte): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iNXT_getFirmwareVersion(fNXTHandle, protmaj, protmin, firmmaj, firmmin, status);
  Result := status >= kStatusNoError;
end;

function TFantomSpirit.NXTCloseModuleHandle(var handle: FantomHandle; const chkResponse: boolean): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iNXT_destroyModule(fNXTHandle, handle, status);
  if chkResponse then
    Result := status >= kStatusNoError
  else
    Result := status >= kStatusNoError;
end;

function TFantomSpirit.NXTBootCommand(const chkResponse: boolean): boolean;
var
  status : integer;
  resBuf : array[0..60] of Char;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iNXT_getResourceString(fNXTHandle, resBuf, status);
  if chkResponse then
    Result := status >= kStatusNoError
  else
    Result := status >= kStatusNoError;
  if Result then
  begin
    iNXT_bootIntoFirmwareDownloadMode(resBuf, status);
    Result := status >= kStatusNoError;
  end;
end;

function TFantomSpirit.NXTSetBrickName(const name: string; const chkResponse: boolean): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iNXT_setName(fNXTHandle, PChar(name), status);
  if chkResponse then
    Result := status >= kStatusNoError
  else
    Result := status >= kStatusNoError;
end;

function TFantomSpirit.NXTGetDeviceInfo(var name: string;
  var BTAddress : String; var BTSignal : Cardinal; var memFree : Cardinal): boolean;
var
  status : integer;
  buf : array[0..20] of Char;
  addr : array[0..6] of Byte;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iNXT_getDeviceInfoEx(fNXTHandle, buf, @addr[0], @BTSignal, memFree, status);
  name := buf;
  BTAddress := Format('%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x',
    [addr[0], addr[1], addr[2], addr[3], addr[4], addr[5]]);
  Result := status >= kStatusNoError;
end;

function TFantomSpirit.NXTDeleteUserFlash(const chkResponse: boolean): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iNXT_eraseUserFlash(fNXTHandle, status);
  if chkResponse then
    Result := status >= kStatusNoError
  else
    Result := status >= kStatusNoError;
end;

function TFantomSpirit.NXTBTFactoryReset(const chkResponse: boolean): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iNXT_bluetoothFactoryReset(fNXTHandle, status);
  if chkResponse then
    Result := status >= kStatusNoError
  else
    Result := status >= kStatusNoError;
end;

type
  TFileInfoRec = class
  public
    FileHandle : FantomHandle;
    TotalSize : Cardinal;
    AvailableSize : Cardinal;
    Name : string;
  end;

function TFantomSpirit.NXTUploadFile(const filename: string; const dir : string): boolean;
var
  handle : FantomHandle;
  totalSize, availableSize : Cardinal;
  MS : TMemoryStream;
  tmpFilename : string;
  NXTFileIteratorHandle : FantomHandle;
  status, i : integer;
  buf : array[0..20] of Char;
  FIR : TFileInfoRec;
  OL : TObjectList;
begin
  Result := IsOpen;
  if not Result then Exit;
  // upload means from NXT to PC
  OL := TObjectList.Create;
  try
    status := kStatusNoError;
    NXTFileIteratorHandle := iNXT_createFileIterator(fNXTHandle, PChar(filename), status);
    Result := status >= kStatusNoError;
    if Result then
    begin
      while status >= kStatusNoError do
      begin
        iFileIterator_getName(NXTFileIteratorHandle, buf, status);
        tmpFilename := buf;
        status := kStatusNoError;
        totalSize := iFileIterator_getSize(NXTFileIteratorHandle, status);
        status := kStatusNoError;
        handle := iFileIterator_getFile(NXTFileIteratorHandle, status);
        status := kStatusNoError;
        availableSize := iFile_getAvailableSize(handle, status);
        // save the info for this file into our object list
        FIR := TFileInfoRec.Create;
        OL.Add(FIR);
        FIR.FileHandle    := handle;
        FIR.Name          := tmpFilename;
        FIR.TotalSize     := totalSize;
        FIR.AvailableSize := availableSize;
        // advance to the next file
        status := kStatusNoError;
        iFileIterator_advance(NXTFileIteratorHandle, status);
      end;
      status := kStatusNoError;
      iNXT_destroyFileIterator(fNXTHandle, NXTFileIteratorHandle, status);
      Result := OL.Count > 0;
      for i := 0 to OL.Count - 1 do
      begin
        FIR := TFileInfoRec(OL.Items[i]);
        MS := TMemoryStream.Create;
        try
          InternalNXTUploadFileToStream(FIR.FileHandle, FIR.Name, FIR.TotalSize, FIR.AvailableSize, MS);
          NXTCloseFile(FIR.FileHandle);
          // now try to save the file
          tmpFilename := FIR.Name;
          if dir <> '' then
            tmpFilename := IncludeTrailingPathDelimiter(dir) + tmpFilename;
          if Result then
            MS.SaveToFile(tmpFilename);
        finally
          MS.Free;
        end;
      end;
    end;
  finally
    OL.Free;
  end;
end;

function TFantomSpirit.NXTUploadFileToStream(const filename: string;
  aStream: TStream): boolean;
var
  handle : FantomHandle;
  totalSize, availableSize : Cardinal;
  tmpFilename : string;
  NXTFileIteratorHandle : FantomHandle;
  status : integer;
  buf : array[0..20] of Char;
begin
  Result := IsOpen;
  if not Result then Exit;
  // upload means from NXT to PC
  status := kStatusNoError;
  NXTFileIteratorHandle := iNXT_createFileIterator(fNXTHandle, PChar(filename), status);
  if status >= kStatusNoError then
  begin
    iFileIterator_getName(NXTFileIteratorHandle, buf, status);
    tmpFilename := buf;
    status := kStatusNoError;
    totalSize := iFileIterator_getSize(NXTFileIteratorHandle, status);
    status := kStatusNoError;
    handle := iFileIterator_getFile(NXTFileIteratorHandle, status);
    status := kStatusNoError;
    availableSize := iFile_getAvailableSize(handle, status);
    status := kStatusNoError;
    iNXT_destroyFileIterator(fNXTHandle, NXTFileIteratorHandle, status);
    // upload file
    InternalNXTUploadFileToStream(handle, tmpFilename, totalSize, availableSize, aStream);
    NXTCloseFile(handle);
  end;
end;

function TFantomSpirit.InternalNXTUploadFileToStream(handle: FantomHandle;
  const name: string; const totalSize, availSize: cardinal;
  aStream: TStream): boolean;
var
  size : cardinal;
  tmpFilename : string;
  status : integer;
  fileBuf : PByte;
  bEOFOnRead : boolean;
begin
  tmpFilename := name;
  size        := Cardinal(Max(totalSize - availSize, 0));
  status      := kStatusNoError;
  iFile_openForRead(handle, status);
  aStream.Size := 0;
  aStream.Position := 0;
//  aStream.Clear; // empty the stream
  fileBuf := nil;
  GetMem(fileBuf, size);
  try
    FillChar(fileBuf^, size, 0);
    status := kStatusNoError;
    iFile_read(handle, fileBuf, size, status);
    bEOFOnRead := status = kStatusFWEndOfFile;
    Result := (status >= kStatusNoError) or bEOFOnRead;
    if Result then
      aStream.Write(fileBuf^, size);
  finally
    FreeMem(fileBuf);
  end;
  // hmmm we may have a problem here.  If we encountered an EOF on
  // read then that means the file we are trying to upload is one of
  // those files which has been created using the syscall file io
  // functions and it's contents are less than its reported size.
  // In that case we need to discard what we just did and try to
  // read the file one byte at a time.
  if bEOFOnRead then
  begin
    status := kStatusNoError;
    iFile_close(handle, status); // close the file and reopen it
    status := kStatusNoError;
    iFile_openForRead(handle, status);
    Result := status >= kStatusNoError;
    aStream.Size := 0;
    aStream.Position := 0;
//    aStream.Clear; // empty the stream
    GetMem(fileBuf, 1);
    try
      FillChar(fileBuf^, 1, 0);
      while status >= kStatusNoError do
      begin
        iFile_read(handle, fileBuf, 1, status);
        if status >= kStatusNoError then
          aStream.Write(fileBuf^, 1);
      end;
    finally
      FreeMem(fileBuf);
    end;
  end;
end;

function TFantomSpirit.NXTListFiles(const searchPattern: string; Files: TStrings): boolean;
var
  size : Cardinal;
  tmpfilename : string;
  NXTFileIteratorHandle : FantomHandle;
  buf : array[0..20] of Char;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  NXTFileIteratorHandle := iNXT_createFileIterator(fNXTHandle, PChar(searchPattern), status);
  Result := status >= kStatusNoError;
  while status >= kStatusNoError do
  begin
    iFileIterator_getName(NXTFileIteratorHandle, buf, status);
    tmpFilename := buf;
    size := iFileIterator_getSize(NXTFileIteratorHandle, status);
    Files.Add(tmpfilename + '=' + IntToStr(size));
    Result := status >= kStatusNoError;
    iFileIterator_advance(NXTFileIteratorHandle, status);
  end;
  status := kStatusNoError;
  iNXT_destroyFileIterator(fNXTHandle, NXTFileIteratorHandle, status);
end;

function TFantomSpirit.NXTListModules(const searchPattern: string;
  Modules: TStrings): boolean;
var
  size, mID : Cardinal;
  NXTModuleIteratorHandle, handle : FantomHandle;
  buf : array[0..20] of Char;
  status : integer;
  iosize : Word;
  tmpname : string;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  NXTModuleIteratorHandle := iNXT_createModuleIterator(fNXTHandle, PChar(searchPattern), status);
  Result := status >= kStatusNoError;
  while status >= kStatusNoError do
  begin
    handle := iModuleIterator_getModule(NXTModuleIteratorHandle, status);
    iModule_getName(handle, buf, status);
    tmpname := buf;
    status := kStatusNoError;
    iosize := Word(iModule_getIOMapSize(handle, status));
    status := kStatusNoError;
    mID    := iModule_getModuleID(handle, status);
    status := kStatusNoError;
    size   := iModule_getModuleSize(handle, status);
    Modules.Add(Format('%s=%d, %d, %d', [tmpname, mID, size, iosize]));
    status := kStatusNoError;
    iNXT_destroyModule(fNXTHandle, handle, status);
    status := kStatusNoError;
    iModuleIterator_advance(NXTModuleIteratorHandle, status);
  end;
  status := kStatusNoError;
  iNXT_destroyModuleIterator(fNXTHandle, NXTModuleIteratorHandle, status);
end;

function TFantomSpirit.NXTDownloadFile(const filename: string;
  const filetype: TNXTFileType): boolean;
var
  MS : TMemoryStream;
begin
  Result := IsOpen;
  if not Result then Exit;
  // download means from PC to NXT
  Result := FileExists(filename);
  if Result then
  begin
    MS := TMemoryStream.Create;
    try
      MS.LoadFromFile(filename);
      Result := NXTDownloadStream(MS, filename, filetype);
    finally
      MS.Free;
    end;
  end;
end;

function TFantomSpirit.TransferFirmware(aStream : TStream) : boolean;
var
  size : Cardinal;
  resBuf : array[0..255] of Char;
  status : integer;
  buf : PByte;
  elapsedTime : Cardinal;
  bStop : boolean;
  cur, i : integer;
const
  K_SEC = 1000;
  MaximumWait = 30*K_SEC; // 30 seconds
  K_STEPS = 30;
begin
  Result := IsOpen;
  DebugLog('TFantomSpirit.TransferFirmware: Connection is open = ' + BoolToStr(Result));
  size   := Cardinal(aStream.Size);
  bStop  := False;
  status := kStatusNoError;
  cur := 0;
  DoDownloadStatus(cur, K_STEPS, bStop);
  if bStop then begin
    Result := False;
    Exit;
  end;
  if Result then
  begin
    // if we could open the NXT then it isn't in firmware download mode
    iNXT_getResourceString(fNXTHandle, resBuf, status);
    Result := status >= kStatusNoError;
    DebugLog('TFantomSpirit.TransferFirmware: iNXT_getResourceString status = ' + IntToStr(status) + ', resBuf = ' + String(resBuf));
    if Result then
    begin
      status := kStatusNoError;
      iNXT_bootIntoFirmwareDownloadMode(resBuf, status);
      DebugLog('TFantomSpirit.TransferFirmware: iNXT_bootIntoFirmwareDownloadMode status = ' + IntToStr(status) + ', resBuf = ' + String(resBuf));
      Result := status >= kStatusNoError;
      if Result then
      begin
        destroyNXT(fNXTHandle, status);
        DebugLog('TFantomSpirit.TransferFirmware: destroyNXT status = ' + IntToStr(status));
      end;
    end;
    inc(cur);
    DoDownloadStatus(cur, K_STEPS, bStop);
    if bStop then begin
      Result := False;
      Exit;
    end;
  end;
  // the device should now be in firmware download mode
  elapsedTime := 0;
  repeat
    SysUtils.Sleep(K_SEC);
    inc(elapsedTime, K_SEC);
    status := kStatusNoError;
    iNXT_findDeviceInFirmwareDownloadMode(resBuf, status);
    DebugLog('TFantomSpirit.TransferFirmware: iNXT_findDeviceInFirmwareDownloadMode status = ' + IntToStr(status) + ', resBuf = ' + String(resBuf));
    inc(cur);
    DoDownloadStatus(cur, K_STEPS, bStop);
    if bStop then begin
      Result := False;
      Exit;
    end;
  until (status >= kStatusNoError) or (elapsedTime >= MaximumWait);
  cur := 16;
  DoDownloadStatus(cur, K_STEPS, bStop);
  if bStop then begin
    Result := False;
    Exit;
  end;
  // now download the firmware
  if status >= kStatusNoError then
  begin
    status := kStatusNoError;
    fNXTHandle := createNXT(resBuf, status, 0);
    DebugLog('TFantomSpirit.TransferFirmware: createNXT status = ' + IntToStr(status) + ', resBuf = ' + String(resBuf));
    inc(cur);
    DoDownloadStatus(cur, K_STEPS, bStop);
    if bStop then begin
      Result := False;
      Exit;
    end;
    buf := nil;
    GetMem(buf, size);
    try
      aStream.Position := 0; // start at the beginning
      aStream.Read(buf^, size);
      status := kStatusNoError;
      iNXT_downloadFirmware(fNXTHandle, buf, size, status);
      DebugLog('TFantomSpirit.TransferFirmware: iNXT_downloadFirmware status = ' + IntToStr(status) + ', resBuf = ' + String(resBuf));
      inc(cur);
      DoDownloadStatus(cur, K_STEPS, bStop);
      if bStop then begin
        Result := False;
        Exit;
      end;
    finally
      FreeMem(buf);
    end;
    // wait 10 seconds
    for i := 0 to 9 do begin
      SysUtils.Sleep(K_SEC);
      inc(cur);
      DoDownloadStatus(cur, K_STEPS, bStop);
      if bStop then begin
        Result := False;
        Exit;
      end;
    end;
    Close;
    SysUtils.Sleep(K_SEC); // one more second before reopening
    Open;
    Result := status >= kStatusNoError;
  end;
end;

function TFantomSpirit.NXTDownloadStream(aStream: TStream; const dest : string;
  const filetype: TNXTFileType): boolean;
var
  size : Cardinal;
  handle : FantomHandle;
  status : integer;
  buf : PByte;
  nxtFilename, delname : string;
begin
  handle := 0;
  Result := IsOpen;
  if not FantomAPILoaded then Exit;
  status := kStatusNoError;
  if filetype = nftFirmware then
  begin
    Result := TransferFirmware(aStream);
  end
  else
  begin
    if not Result then Exit;
    size := Cardinal(aStream.Size);
    // download means from PC to NXT
    // make destination filename a valid NXT filename (15.3)
    nxtFilename := MakeValidNXTFilename(dest);
    delname := nxtFilename;
    NXTDeleteFile(delname, True);
    if filetype in [nftProgram, nftGraphics] then
      Result := NXTOpenWriteLinear(nxtFilename, size, handle)
    else if filetype = nftData then
      Result := NXTOpenWriteData(nxtFilename, size, handle)
    else
      Result := NXTOpenWrite(nxtFilename, size, handle);
    if Result then
    begin
      buf := nil;
      GetMem(buf, size);
      try
        aStream.Position := 0; // start at the beginning
        aStream.Read(buf^, size);
        status := kStatusNoError;
        iFile_write(handle, buf, size, status);
        Result := status >= kStatusNoError;
      finally
        FreeMem(buf);
      end;
      Result := NXTCloseFile(handle) and Result;
    end;
  end;
end;

function TFantomSpirit.NXTPollCommandLen(const bufNum : byte; var count: byte): boolean;
var
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := 0;
  count := Byte(iNXT_pollAvailableLength(fNXTHandle, bufNum, status));
  Result := status < kStatusNoError;
  if not Result then
    count := 0;
end;

function TFantomSpirit.NXTPollCommand(const bufNum: byte; var count: byte;
  var buffer: NXTDataBuffer): boolean;
var
  dataBuffer : PByte;
  status : Integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  if count > 64 then
    count := 64;
  dataBuffer := @buffer.Data[0];
  status := 0;
  count := Byte(iNXT_readBufferData(fNXTHandle, dataBuffer, bufNum, count, status));
  Result := status >= kStatusNoError;
  if not Result then
    count := 0;
end;

function TFantomSpirit.NXTWriteIOMap(var ModID: Cardinal;
  const Offset: Word; var count: Word; const buffer: NXTDataBuffer;
  chkResponse : Boolean): boolean;
var
  status : integer;
  mh : FantomHandle;
  modName : string;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  modName := NXTModuleIDToName(ModID);
  mh := iNXT_createModule(fNXTHandle, PChar(modName), ModID, 0, 0, status);
  if status >= kStatusNoError then
  begin
    // found the correct module
    status := kStatusNoError;
    iModule_writeIOMap(mh, Offset, count, @(buffer.Data), status);
    // now destroy it
    status := kStatusNoError;
    iNXT_destroyModule(fNXTHandle, mh, status);
    if not chkResponse then
      status := kStatusNoError;
  end;
end;

function TFantomSpirit.NXTReadIOMap(var ModID: Cardinal;
  const Offset: Word; var Count: Word; var buffer: NXTDataBuffer): boolean;
var
  status : integer;
  mh : FantomHandle;
  modName : string;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  modName := NXTModuleIDToName(ModID);
  mh := iNXT_createModule(fNXTHandle, PChar(modName), ModID, 0, 0, status);
  if status >= kStatusNoError then
  begin
    // found the correct module
    status := kStatusNoError;
    FillChar(buffer.Data[0], kNXT_MaxBytes, 0);
    iModule_readIOMap(mh, Offset, Count, @(buffer.Data), status);
    Result := status = kStatusNoError;
    // now destroy it
    status := kStatusNoError;
    iNXT_destroyModule(fNXTHandle, mh, status);
  end;
end;

function TFantomSpirit.NXTFindNextModule(var Handle: FantomHandle;
  var ModName: string; var ModID, ModSize: Cardinal;
  var IOMapSize: Word): boolean;
var
  status : integer;
  Buf : array[0..19] of Char;
  mh : FantomHandle;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  iModuleIterator_advance(Handle, status);
  Result := status >= kStatusNoError;
  if Result then
  begin
    mh := iModuleIterator_getModule(Handle, status);
    status := kStatusNoError;
    iModule_getName(mh, buf, status);
    ModName   := buf;
    status := kStatusNoError;
    ModSize   := iModule_getModuleSize(mh, status);
    status := kStatusNoError;
    ModID     := iModule_getModuleID(mh, status);
    status := kStatusNoError;
    IOMapSize := Word(iModule_getIOMapSize(mh, status));
    status := kStatusNoError;
    iNXT_destroyModule(FNXTHandle, mh, status);
  end
  else
  begin
    // destroy the iterator
    status := kStatusNoError;
    iNXT_destroyModuleIterator(fNXTHandle, Handle, status);
    handle := 0;
    ModName := '';
  end;
end;

function TFantomSpirit.NXTFindFirstModule(var ModName: string; var Handle: FantomHandle;
  var ModID, ModSize: Cardinal; var IOMapSize: Word): boolean;
var
  status : integer;
  buf : array[0..19] of Char;
  mh : FantomHandle;
begin
  Result := IsOpen;
  if not Result then Exit;
  status := kStatusNoError;
  Handle := iNXT_createModuleIterator(FNXTHandle, PChar(ModName), status);
  Result := status >= kStatusNoError;
  if Result then
  begin
    mh := iModuleIterator_getModule(Handle, status);
    status := kStatusNoError;
    iModule_getName(mh, buf, status);
    ModName   := buf;
    status := kStatusNoError;
    ModSize   := iModule_getModuleSize(mh, status);
    status := kStatusNoError;
    ModID     := iModule_getModuleID(mh, status);
    status := kStatusNoError;
    IOMapSize := Word(iModule_getIOMapSize(mh, status));
    status := kStatusNoError;
    iNXT_destroyModule(FNXTHandle, mh, status);
  end;
end;

function TFantomSpirit.dcBuffer: PByte;
begin
  Result := @dcResponse[0];
end;

function TFantomSpirit.GetReplyByte(index: integer): Byte;
const
  DCReplyOffset = 2;
begin
  Result := dcResponse[index + DCReplyOffset];

end;

function TFantomSpirit.GetReplyCardinal(index: integer): Cardinal;
begin
  Result := BytesToCardinal(GetReplyByte(index),
                            GetReplyByte(index+1),
                            GetReplyByte(index+2),
                            GetReplyByte(index+3));
end;

function TFantomSpirit.GetReplyWord(index: integer): Word;
begin
  Result := Word(BytesToCardinal(GetReplyByte(index), GetReplyByte(index+1)));
end;

function TFantomSpirit.NXTListBricks(Bricks: TStrings): boolean;
var
  nih : FantomHandle;
  status, status2 : integer;
  resNamePC : array[0..255] of Char;
  resName, alias, tmp : string;
begin
  Result := False;
  Bricks.Clear;
  if FantomAPILoaded then
  begin
    resName := '';
    status := kStatusNoError;
    // use Fantom API to obtain a handle to an NXT on either USB or bluetooth
    nih := createNXTIterator(1, BluetoothSearchTimeout, status);
    while status >= kStatusNoError do
    begin
      status2 := kStatusNoError;
      iNXTIterator_getName(nih, resNamePC, status2);
      resName := AnsiUpperCase(resNamePC);
      // if the resource name starts with BTH then grab the beginning of
      // the resource name and use it as the alias
      // if the resource name starts with USB then grab the end of the
      // resource name instead
      if Pos('BTH', resName) = 1 then
      begin
        tmp := Copy(resName, 6, MaxInt);
        alias := 'BTH::' + Copy(tmp, 1, Pos('::', tmp)-1);
      end
      else
      begin
        alias := Copy(resName, 23, MaxInt);
        System.Delete(alias, Length(alias)-4, 5);
      end;
//      alias := AnsiLowerCase(Copy(resName, 1, Pos('::', resName)-1));
      Bricks.Add(alias + '=' + resName);
      iNXTIterator_advance(nih, status);
    end;
    status := kStatusNoError;
    destroyNXTIterator(nih, status);
    // also look for bricks in firmware download mode
    status := kStatusNoError;
    iNXT_findDeviceInFirmwareDownloadMode(resNamePC, status);
    if status >= kStatusNoError then
    begin
      resName := AnsiUpperCase(resNamePC);
      alias := Copy(resName, 23, MaxInt);
      System.Delete(alias, Length(alias)-4, 5);
//      alias := AnsiLowerCase(Copy(resName, 1, Pos('::', resName)-1));
      Bricks.Add(alias + '=' + resName);
    end;
    Result := Bricks.Count > 0;
  end;
end;

function TFantomSpirit.GetDownloadWaitTime: Integer;
begin
  Result := 0;
end;

function TFantomSpirit.GetEEPROM(addr: Byte): Byte;
begin
  Result := addr;
end;

function TFantomSpirit.GetEEPROMBlock(idx: Integer): EEPROMBlock;
begin
  Result.Data[idx] := 0;
// do nothing
end;

function TFantomSpirit.GetLinkLog: string;
begin
  Result := '';
end;

function TFantomSpirit.GetOmitHeader: Boolean;
begin
  Result := False;
end;

function TFantomSpirit.GetQuiet: Boolean;
begin
  Result := False;
end;

function TFantomSpirit.GetRCXFirmwareChunkSize: Integer;
begin
  Result := 200;
end;

function TFantomSpirit.GetRxTimeout: Word;
begin
  Result := 400;
end;

procedure TFantomSpirit.SetDownloadWaitTime(const Value: Integer);
begin
// do nothing
  if Value = 0 then Exit;
end;

procedure TFantomSpirit.SetEEPROM(addr: Byte; const Value: Byte);
begin
// do nothing
  if Value = 0 then Exit;
  if addr = 0 then Exit;
end;

procedure TFantomSpirit.SetOmitHeader(const Value: Boolean);
begin
// do nothing
  if Value then Exit;
end;

procedure TFantomSpirit.SetQuiet(const Value: Boolean);
begin
// do nothing
  if Value then Exit;
end;

procedure TFantomSpirit.SetRCXFirmwareChunkSize(const Value: Integer);
begin
// do nothing
  if Value = 0 then Exit;
end;

procedure TFantomSpirit.SetRxTimeout(const Value: Word);
begin
// do nothing
  if Value = 0 then Exit;
end;

function TFantomSpirit.AbsVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aVar = 0 then Exit;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TFantomSpirit.AndVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aVar = 0 then Exit;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TFantomSpirit.BrickAlive: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.CalibrateEvent(enum, upper, lower,
  hysteresis: integer): boolean;
begin
  Result := Open;
  if enum = 0 then Exit;
  if upper = 0 then Exit;
  if lower = 0 then Exit;
  if hysteresis = 0 then Exit;
end;

function TFantomSpirit.CalibrateLightSensor: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.ClearAllEvents: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.ClearCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TFantomSpirit.ClearSound: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.ClearTachoCounter(aMotorList: Byte): boolean;
var
  i : Byte;
begin
  Result := Open;
  if Result then
  begin
    for i := 0 to 2 do
    begin
      if (MotorBits[i] and aMotorList) = MotorBits[i] then
      begin
        Result := Result and NXTResetOutputPosition(i, False);
        if not Result then Break;
      end;
    end;
  end;
end;

function TFantomSpirit.ClearTimer(aNum: integer): boolean;
begin
  Result := Open;
  if aNum = 0 then Exit;
end;

function TFantomSpirit.DatalogNext(aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TFantomSpirit.DecCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TFantomSpirit.DeleteAllSubs: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.DeleteAllTasks: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.DeleteSub(aSub: integer): boolean;
begin
  Result := Open;
  if aSub = 0 then Exit;
end;

function TFantomSpirit.DeleteTask(aTask: integer): boolean;
begin
  Result := Open;
  if aTask = 0 then Exit;
end;

function TFantomSpirit.DivVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aVar = 0 then Exit;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TFantomSpirit.DownloadMemoryMap: TStrings;
var
  SL : TStringList;
  i, p, id : integer;
  tmp : string;
begin
  fMemMap.Clear;
  SL := TStringList.Create;
  try
    fMemMap.Add('Files');
    fMemMap.Add('');
    if NXTListFiles('*.*', SL) then
    begin
      for i := 0 to SL.Count - 1 do
      begin
        fMemMap.Add(SL.Names[i]);
        fMemMap.Add(SL.ValueFromIndex[i]);
      end;
    end;
    SL.Clear;
    fMemMap.Add('');
    fMemMap.Add('');
    fMemMap.Add('Modules');
    fMemMap.Add('');
    if NXTListModules('*.*', SL) then
    begin
      for i := 0 to SL.Count - 1 do
      begin
        fMemMap.Add(SL.Names[i]);
        tmp := SL.ValueFromIndex[i];
        // tmp = moduleID, size, iosize
        p := Pos(',', tmp);
        id := StrToIntDef(Copy(tmp, 1, p-1), 0);
        Delete(tmp, 1, p);
        p := Pos(',', tmp);
        Delete(tmp, 1, p);
        fMemMap.Add(IntToStr(id)+'|'+tmp); // moduleID|iomap size
      end;
    end;
    fMemMap.Add('');
    fMemMap.Add('');
    i := NXTFreeMemory;
    fMemMap.Add('Free Memory');
    fMemMap.Add(IntToStr(i));
  finally
    SL.Free;
  end;
  Result := fMemMap;
end;

function TFantomSpirit.Drive(aLeft, aRight: integer): boolean;
begin
  Result := Open;
  if aLeft = 0 then Exit;
  if aRight = 0 then Exit;
end;

function TFantomSpirit.GetCounterValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_CounterType, aNum);
end;

function TFantomSpirit.GetMessageValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_MessageType, aNum);
end;

function TFantomSpirit.GetOutputStatus(aOut: integer): integer;
var
  res : boolean;
  mode, regmode, runstate : byte;
  power, turnratio : integer;
  tacholimit : cardinal;
  tachocount, blocktachocount, rotationcount : integer;
  bBrake : boolean;
begin
  Result := 0;
  rotationcount := 0;
  blocktachocount := 0;
  tachocount := 0;
  tacholimit := 0;
  runstate := 0;
  turnratio := 0;
  mode := 0;
  regmode := 0;
  power := 0;
  res := GetNXTOutputState(Byte(aOut), power, mode, regmode, turnratio, runstate,
    tacholimit, tachocount, blocktachocount, rotationcount);
  if res then
  begin
    // what is the power?
    fMotorOn[aOut]      := ((mode and OUT_MODE_MOTORON) = OUT_MODE_MOTORON) and
                           ((runstate and OUT_RUNSTATE_RUNNING) = OUT_RUNSTATE_RUNNING) and
                           (power <> 0);
    bBrake              := (mode and OUT_MODE_BRAKE) = OUT_MODE_BRAKE;
    // if the power is 0 and fMotorOn[aOut] is false then do not change
    // the stored power level
    if fMotorOn[aOut] then
      fMotorPower[aOut] := Byte(abs(power div 14) mod 8);
    fMotorForward[aOut] := power >= 0;
    Result := fMotorPower[aOut]; // bits 0..2
    if fMotorForward[aOut] then
      Result := Result + (1 shl 3); // bit 3
    if bBrake then
      Result := Result + (1 shl 6); // bit 6
    if fMotorOn[aOut] then
      Result := Result + (1 shl 7); // bit 7
  end;
end;

function TFantomSpirit.GetTimerValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_TimerType, aNum);
end;

function TFantomSpirit.GetVariableValue(aVar: integer): variant;
begin
  Result := Poll(kRCX_VariableType, aVar);
end;

function TFantomSpirit.IncCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TFantomSpirit.MonitorIR(aSeconds: integer): TStrings;
begin
  Result := fMemData;
  if aSeconds = 0 then Exit;
end;

function TFantomSpirit.MulVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aVar = 0 then Exit;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TFantomSpirit.OnWait(aMotorList: Byte; aNum: integer; aTime: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
  if aNum = 0 then Exit;
  if aTime = 0 then Exit;
end;

function TFantomSpirit.OnWaitDifferent(aMotorList: Byte; aNum0, aNum1,
  aNum2: integer; aTime: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
  if aNum0 = 0 then Exit;
  if aNum1 = 0 then Exit;
  if aNum2 = 0 then Exit;
  if aTime = 0 then Exit;
end;

function TFantomSpirit.OrVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aVar = 0 then Exit;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TFantomSpirit.PlaySystemSound(aSnd: byte): boolean;
begin
  Result := Open;
  if aSnd = 0 then Exit;
end;

function TFantomSpirit.Poll(aSrc, aNum: integer): variant;
var
  valid, calibrated, res : boolean;
  stype, smode : byte;
  raw, normalized : word;
  scaled, calvalue : smallint;
  modID : Cardinal;
  count : Word;
  buffer : NXTDataBuffer;
  power, turnratio, tachocount, blocktachocount, rotationcount : integer;
  mode, regmode, runstate : byte;
  tacholimit : cardinal;
  protmin, protmaj, firmmin, firmmaj : byte;
begin
  Result := 0;
  case aSrc of
    kRCX_VariableType : begin
      Result := GetNXTVariableHelper(aNum, 0, 0, 18);
    end;
    kRCX_ConstantType : begin
      Result := aNum;
    end;
    kRCX_OutputStatusType : begin
      Result := GetOutputStatus(aNum);
    end;
    kRCX_RandomType : begin
      Result := Random(aNum);
    end;
    kRCX_TachCounterType : begin
      rotationcount := 0;
      blocktachocount := 0;
      tachocount := 0;
      tacholimit := 0;
      runstate := 0;
      turnratio := 0;
      mode := 0;
      regmode := 0;
      power := 0;
      res := GetNXTOutputState(Byte(aNum), power, mode, regmode, turnratio, runstate,
        tacholimit, tachocount, blocktachocount, rotationcount);
      if res then
        Result := rotationcount;
    end;
    kRCX_TimerType : begin
      // IOMapRead CommandOffsetTick
      modID := kNXT_ModuleCmd;
      count := 4;
      buffer.Data[0] := 0;
      res := NXTReadIOMap(modID, CommandOffsetTick, count, buffer);
      if res then
      begin
        Result := BytesToCardinal(buffer.Data[0], buffer.Data[1], buffer.Data[2], buffer.Data[3]);
      end;
    end;
    kRCX_BatteryLevelType : begin
      Result := BatteryLevel;
    end;
    kRCX_FirmwareVersionType : begin
      firmmaj := 0;
      firmmin := 0;
      protmin := 0;
      protmaj := 0;
      if NXTGetVersions(protmin, protmaj, firmmin, firmmaj) then
      begin
        // 1.03 => 1030
        Result := (firmmaj * 100) + firmmin;
      end;
    end;
    kRCX_InputTypeType, kRCX_InputModeType,
    kRCX_InputValueType, kRCX_InputRawType,
    kRCX_InputBooleanType : begin
      // get input type or input mode
      calibrated := False;
      stype := 0;
      smode := 0;
      raw := 0;
      normalized := 0;
      scaled := 0;
      calvalue := 0;
      valid := False;
      res := GetNXTInputValues(Byte(aNum), valid, calibrated, stype, smode,
        raw, normalized, scaled, calvalue);
      if res then
      begin
        if aSrc = kRCX_InputTypeType then
        begin
          fSensorType[aNum] := stype;
          Result := stype;
        end
        else if aSrc = kRCX_InputModeType then
        begin
          fSensorMode[aNum] := smode;
          Result := smode;
        end
        else if aSrc = kRCX_InputValueType then
        begin
          Result := scaled; // normalized?
        end
        else if aSrc = kRCX_InputRawType then
        begin
          Result := raw;
        end
        else if aSrc = kRCX_InputBooleanType then
        begin
          Result := scaled;
        end;
      end;
    end;
  end;
end;

function TFantomSpirit.PollEEPROM(block: Integer): TStrings;
var
  i, j, start, finish, status : Integer;
  mh : FantomHandle;
  Offset, cnt : Cardinal;
  buf : PByte;
const
  MAX_BLOCK  = $803;
  BLOCK_SIZE = $10;
begin
  Open;
  Result := fMemData;
  fMemData.Clear;
  start := block;
  finish := block;
  if block < 0 then
  begin
    start := 0;
    finish := MAX_BLOCK;
  end
  else if block > MAX_BLOCK then
  begin
    start  := MAX_BLOCK;
    finish := MAX_BLOCK;
  end;
  status := 0;
  mh := iNXT_createModule(fNXTHandle, PChar(kNXT_ModuleCmdName), kNXT_ModuleCmd, 0, 0, status);
  // are we in a position to poll memory?
  if status >= kStatusNoError then
  begin
    buf := nil;
    GetMem(buf, BLOCK_SIZE);
    try
      for j := start to finish do
      begin
        status := kStatusNoError;
        Offset := j*BLOCK_SIZE;
        cnt := iModule_readIOMap(mh, Offset, BLOCK_SIZE, buf, status);
        if status >= kStatusNoError then
        begin
          for i := 0 to Integer(cnt) - 1 do
          begin
            fMemData.Add(Format('%d', [PByte(PChar(buf) + i)^]));
          end;
        end
        else
          Break;
      end;
    finally
      FreeMem(buf);
    end;
    // now destroy the module handle
    status := kStatusNoError;
    iNXT_destroyModule(fNXTHandle, mh, status);
  end;
end;

function TFantomSpirit.PollMemory(address, size: Integer): TStrings;
var
  status, cnt : integer;
  mh : FantomHandle;
  Offset : Cardinal;
  amt, i : Integer;
  buf : PByte;
const
//  CHUNK = $FFFF;
  CHUNK = $36;
begin
  Open;
  fMemData.Clear;
  Result := fMemData;
  status := 0;
  mh := iNXT_createModule(fNXTHandle, PChar(kNXT_ModuleCmdName), kNXT_ModuleCmd, 0, 0, status);
  // are we in a position to poll memory?
  if status >= kStatusNoError then
  begin
    // found the Command module now use it
    Offset := address;
    amt := 0;
    buf := nil;
    GetMem(buf, CHUNK);
    try
      while (amt < size) and (status >= kStatusNoError) do
      begin
        status := kStatusNoError;
        cnt := Min(CHUNK, size-amt);
        cnt := iModule_readIOMap(mh, Offset, cnt, buf, status);
        if status >= kStatusNoError then
        begin
          for i := 0 to cnt - 1 do
          begin
            fMemData.Add(Format('%d', [PByte(PChar(buf) + i)^]));
          end;
        end;
        inc(amt, CHUNK);
        inc(Offset, CHUNK);
      end;
    finally
      FreeMem(buf);
    end;
    // now destroy the module handle
    status := kStatusNoError;
    iNXT_destroyModule(fNXTHandle, mh, status);
  end;
end;

function TFantomSpirit.PowerDownTime(aTime: integer): boolean;
var
  modID : Cardinal;
  count : Word;
  buffer : NXTDataBuffer;
begin
  Result := Open;
  if not Result then Exit;
  modID := kNXT_ModuleUI;
  count := 1;
  buffer.Data[0] := Byte(abs(aTime) mod $FF);
  Result := NXTWriteIOMap(modID, UIOffsetSleepTimeout, count, buffer);
end;

function TFantomSpirit.PrepareBrick: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.Scout(bPower: boolean): boolean;
begin
  Result := Open and bPower;
end;

function TFantomSpirit.ScoutNum(aVal: integer): boolean;
begin
  Result := Open;
  if aVal = 0 then Exit;
end;

function TFantomSpirit.ScoutRules(motion: TScoutMotion; touch: TScoutTouch;
  light: TScoutLight; time: TScoutScale; fx: TScoutEffects): boolean;
begin
  Result := Open;
  if motion = smNone then Exit;
  if touch = stIgnore then Exit;
  if light = slIgnore then Exit;
  if time = ssShort then Exit;
  if fx = seNone then Exit;
end;

function TFantomSpirit.ScoutSound(bSoundEnable, bSoundOff: boolean;
  aNum: TSoundSetNumber): boolean;
begin
  Result := Open and bSoundEnable and bSoundOff;
  if aNum = 0 then Exit;
end;

function TFantomSpirit.SelectDisplay(aSrc, aNumber: integer): boolean;
begin
  Result := Open;
  if aSrc = 0 then Exit;
  if aNumber = 0 then Exit;
end;

function TFantomSpirit.SelectProgram(aProg: integer): boolean;
begin
  Result := Open;
  if aProg = 0 then Exit;
end;

function TFantomSpirit.SendMessage(aMsg: integer): boolean;
begin
  Result := NXTMessageWrite(0, IntToStr(aMsg));
end;

function TFantomSpirit.SendRawCommand(aCmd: string; bRetry: boolean): string;
var
  SL : TStringList;
  data : array of byte;
  status, i, j : integer;
  cmdType, reqResp, len : byte;
  tmpStr : string;
  scBuffer : PByte;
begin
  Result := '';
  if Length(aCmd) = 0 then Exit;
  FillChar(scResponse, 64, 0);
  // the raw command is either a system command or a direct command
  // formatted as a series of 2digit hex bytes separated by a comma.
  // first byte tells whether system or direct.
  SL := TStringList.Create;
  try
    if aCmd[Length(aCmd)] = ',' then
      System.Delete(aCmd, Length(aCmd), 1);
    SL.CommaText := aCmd;
    if SL.Count < 2 then Exit;
    // convert string to array of bytes
    // check that each byte is valid
    SetLength(data, SL.Count-1);
    j := StrToIntDef('$'+SL[0], -1);
    if (j < 0) or (j > 255) then
      Exit;
    cmdType := Byte(j);
    for i := 1 to SL.Count - 1 do
    begin
      tmpStr := SL[i];
      j := StrToIntDef('$'+tmpStr, -1);
      if (j < 0) or (j > 255) then
        break;
      data[i-1] := Byte(j);
    end;
  finally
    SL.Free;
  end;
  // call system or direct command functions if it looks like it is a valid
  // command
  status := kStatusNoError;
  reqResp := Byte((cmdType and $80) <> $80);
  cmdType := cmdType and $7F;
  if reqResp <> 0 then
  begin
    len := NXT_CMD_RESPONSE_LENGTH[data[0]]-1;
    scBuffer := @scResponse[0];
  end
  else
  begin
    len := 0;
    scBuffer := nil;
  end;
  if cmdType = $01 then
    iNXT_sendSystemCommand(fNXTHandle, reqResp, @data[0], Length(data), scBuffer, len, status)
  else if cmdType = $00 then
    iNXT_sendDirectCommandEnhanced(fNXTHandle, reqResp, @data[0], Length(data), scBuffer, len, status)
  else
    Exit;
  if status >= kStatusNoError then
  begin
    for i := 0 to len - 1 do
    begin
      Result := Result + Format('%2.2x ', [scResponse[i]]);
    end;
    Result := Trim(Result);
  end;
end;

function TFantomSpirit.SendRemoteStr(aEvent: string; aRepeat: integer): boolean;
begin
  Result := Open;
  if aEvent = '' then Exit;
  if aRepeat = 0 then Exit;
end;

function TFantomSpirit.SendRemote(aEvent: Word; aRepeat: integer): boolean;
begin
  Result := Open;
  if aEvent = 0 then Exit;
  if aRepeat = 0 then Exit;
end;

function TFantomSpirit.SendUARTData(start, size: integer): boolean;
begin
  Result := Open;
  if start = 0 then Exit;
  if size = 0 then Exit;
end;

function TFantomSpirit.SendVLL(aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TFantomSpirit.SetCounterLimit(num: TCounterNumber; src: TTCSource;
  val: integer): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
  if src = tcVariable then Exit;
  if val = 0 then Exit;
end;

function TFantomSpirit.SetDatalog(aSize: integer): boolean;
begin
  Result := Open;
  if aSize = 0 then Exit;
end;

function TFantomSpirit.SetEvent(enum, snum, etype: integer): boolean;
begin
  Result := Open;
  if (enum = 0) or (snum = 0) or (etype = 0) then Exit;
end;

function TFantomSpirit.SetFeedback(src, val: integer): boolean;
begin
  Result := Open;
  if (src = 0) or (val = 0) then Exit;
end;

function TFantomSpirit.SetGlobalDirection(motors: TMotorsNum; action: TGlobalDirAction): boolean;
begin
  Result := Open;
  if (motors = 0) or (action = gdaBackward) then Exit;
end;

function TFantomSpirit.SetGlobalOutput(motors: TMotorsNum; action: TGlobalOutAction): boolean;
begin
  Result := Open;
  if (motors = 0) or (action = goaFloat) then Exit;
end;

function TFantomSpirit.SetLight(bOn: boolean): boolean;
begin
  Result := Open and bOn;
end;

function TFantomSpirit.SetLightSensorBlinkTime(src: TLSSource; val: TBlinkTimeValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TFantomSpirit.SetLightSensorHysteresis(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TFantomSpirit.SetLightSensorLowerThreshold(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TFantomSpirit.SetLightSensorUpperThreshold(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TFantomSpirit.SetMaxPower(motors: TMotorsNum; src, num: integer): boolean;
begin
  Result := Open;
  if (motors = 0) or (src = 0) or (num = 0) then Exit;
end;

function TFantomSpirit.SetSourceValue(aDestSrc, aDestVal, aOrigSrc: Byte; aOrigVal: Smallint): boolean;
begin
  Result := Open;
  if (aDestSrc = 0) or (aDestVal = 0) or (aOrigSrc = 0) or (aOrigVal = 0) then Exit;
end;

function TFantomSpirit.SetTimerLimit(num: TTimerNumber; src: TTCSource; val: integer): boolean;
begin
  Result := Open;
  if (val = 0) or (src = tcVariable) or (num = 0) then Exit;
end;

function TFantomSpirit.SetVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TFantomSpirit.SetWatch(aTime: string): boolean;
begin
  Result := Open;
  if aTime = '' then Exit;
end;

function TFantomSpirit.SetWatchHHMM(aHrs, aMins: integer): boolean;
begin
  Result := Open;
  if (aHrs = 0) or (aMins = 0) then Exit;
end;

function TFantomSpirit.SgnVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TFantomSpirit.StartTask(aTask: integer): boolean;
begin
  Result := Open;
  if aTask = 0 then Exit;
end;

function TFantomSpirit.StopAllTasks: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.StopTask(aTask: integer): boolean;
begin
  Result := Open;
  if aTask = 0 then Exit;
end;

function TFantomSpirit.SubVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TFantomSpirit.SumVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TFantomSpirit.TowerExists: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.TransmitPower(aLevel: TTransmitLevel): boolean;
begin
  Result := Open;
  if aLevel = tlNear then Exit;
end;

function TFantomSpirit.UnlockBrick: string;
begin
  Open;
  Result := '';
end;

function TFantomSpirit.UnlockFirmware: boolean;
begin
  Result := Open;
end;

function TFantomSpirit.UploadDatalog(bVerbose: boolean): TStrings;
begin
  Open;
  Result := fDataLog;
  if bVerbose then Exit;
end;

function TFantomSpirit.UploadPartialDatalog(aFrom, aSize: integer): TStrings;
begin
  Open;
  Result := fDataLog;
  if aFrom = 0 then Exit;
  if aSize = 0 then Exit;
end;

function TFantomSpirit.Version(var rom, ram: Cardinal): boolean;
var
  protmin, protmaj, firmmin, firmmaj : byte;
begin
  firmmaj := 0;
  firmmin := 0;
  protmin := 0;
  protmaj := 0;
  Result := NXTGetVersions(protmin, protmaj, firmmin, firmmaj);
  rom := (protmin shl 8) + (protmaj shl 16);
  ram := (firmmin shl 0) + (firmmaj shl 16);
end;

function TFantomSpirit.ViewSourceValue(prec, src, value: integer): boolean;
begin
  Result := Open;
  if (prec = 0) or (src = 0) or (value = 0) then Exit;
end;

function TFantomSpirit.GetUseBT: Boolean;
begin
  DebugFmt('TFantomSpirit.GetUseBT: fUseBT was = %s', [BoolToStr(fUseBT)]);
  DebugFmt('TFantomSpirit.GetUseBT: fResPort = %s', [fResPort]);
  DebugFmt('TFantomSpirit.GetUseBT: (Pos(''BTH'', fResPort) > 0) = %s', [BoolToStr((Pos('BTH', fResPort) > 0))]);
  Result := fUseBT or (Pos('BTH', fResPort) > 0);
  if Result then
    fUseBT := True;
  DebugFmt('TFantomSpirit.GetUseBT: fUseBT now = %s', [BoolToStr(fUseBT)]);
end;

procedure TFantomSpirit.NXTInitializeResourceNames;
var
  SL : TStringList;
  name : string;
begin
  SL := TStringList.Create;
  try
    NXTListBricks(SL);
    name := GetInitFilename;
    ForceDirectories(ExtractFilePath(name));
    SL.Sort;
    SL.SaveToFile(name);
  finally
    SL.Free;
  end;
end;

function TFantomSpirit.NXTFreeMemory: integer;
var
  memFree, BTSig : Cardinal;
  nxtName, nxtAddr : string;
begin
  Result  := 0;
  memFree := 0;
  BTSig   := 0;
  nxtName := '';
  nxtAddr := '';
  if NXTGetDeviceInfo(nxtName, nxtAddr, BTSig, memFree) then
  begin
    Result := memFree;
  end;
end;

function TFantomSpirit.NXTRenameFile(const old, new: string;
  const chkResponse: boolean): boolean;
var
  cmd : TNxtCmd;
  status : integer;
  b : byte;
  buf, readBuf : PByte;
  bufLen : Cardinal;
begin
  Result := Open;
  if not Result then Exit;
  cmd := TNxtCmd.Create;
  try
    if chkResponse then
      b := kNXT_SystemCmd
    else
      b := kNXT_SystemCmdNoReply;
    cmd.MakeCmdRenameFile(b, new, old);
//    cmd.MakeCmdRenameFile(b, old, new);
    buf := cmd.GetBody;
    bufLen := cmd.GetLength;
    status := kStatusNoError;
    iNXT_write(fNXTHandle, buf, bufLen, status);
    // now read the response
    if (status >= kStatusNoError) and chkResponse then
    begin
      readBuf := nil;
      GetMem(readBuf, 44);
      try
        iNXT_read(fNXTHandle, readBuf, 44, status);
      finally
        FreeMem(readBuf);
      end;
    end;
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

procedure TFantomSpirit.SetResourcePort(const name: string);
var
  sl : TStringList;
  i : integer;
  fname : string;
begin
  fResPort := name;
  sl := TStringList.Create;
  try
    fname := GetInitFilename;
    if FileExists(fname) then
    begin
      sl.LoadFromFile(fname);
      for i := 0 to sl.Count - 1 do
      begin
        if Pos(fResPort, sl[i]) > 0 then
          Exit;
      end;
      // if we get here then we need to add this resource string to
      // our nxt.dat file
      sl.Add('alias' + IntToStr(sl.Count) + '=' + fResPort);
      sl.SaveToFile(fname);
    end;
  finally
    sl.Free;
  end;
end;

procedure TFantomSpirit.LookupResourceName;
var
  name : string;
  i : integer;
begin
  // lookup a resource string given this port name
  if fResourceNames.Count = 0 then
  begin
    name := GetInitFilename;
    if FileExists(name) then
    begin
      fResourceNames.LoadFromFile(name);
    end;
  end;
  i := fResourceNames.IndexOfName(fPort);
  if i <> -1 then
    fResPort := fResourceNames.Values[fPort];
end;

function TFantomSpirit.NXTGetVMState(var state: byte; var clump : byte; var pc : word): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetVMState);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 6, status, True);
    Result := status >= kStatusNoError;
    state := GetReplyByte(0);
    clump := GetReplyByte(1);
    pc    := GetReplyWord(2);
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTSetVMStateEx(var state, clump: byte; var pc: word): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCSetVMState, state);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 6, status, True);
    Result := status >= kStatusNoError;
    state := GetReplyByte(0);
    clump := GetReplyByte(1);
    pc    := GetReplyWord(2);
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTSetVMState(const state: byte): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCSetVMState, state);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status, True);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTGetPropDebugging(var debugging : boolean; var pauseClump: byte;
  var pausePC: Word): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmd, kNXT_DCGetProperty, kNXT_Property_Debugging);
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 1, cmd.BytePtr, cmd.Len, dcBuffer, 6, status, True);
    Result := status >= kStatusNoError;
    debugging  := Boolean(GetReplyByte(0));
    pauseClump := GetReplyByte(1);
    pausePC    := GetReplyWord(2);
  finally
    cmd.Free;
  end;
end;

function TFantomSpirit.NXTSetPropDebugging(const debugging : boolean; const pauseClump: byte;
  const pausePC: Word): boolean;
var
  cmd : TNINxtCmd;
  status : integer;
begin
  Result := IsOpen;
  if not Result then Exit;
  cmd := TNINxtCmd.Create;
  try
    status := kStatusNoError;
    cmd.SetVal(kNXT_DirectCmdNoReply, kNXT_DCSetProperty, kNXT_Property_Debugging,
      Ord(debugging), pauseClump, Lo(pausePC), Hi(pausePC));
    iNXT_sendDirectCommandEnhanced(fNXTHandle, 0, cmd.BytePtr, cmd.Len, nil, 0, status, True);
    Result := status >= kStatusNoError;
  finally
    cmd.Free;
  end;
end;

procedure TFantomSpirit.NXTUpdateResourceNames;
var
  SL, tmpSL : TStringList;
  fname : string;
begin
  SL := TStringList.Create;
  try
    SL.Sorted := True;
    SL.Duplicates := dupIgnore;
    tmpSL := TStringList.Create;
    try
      NXTListBricks(tmpSL);
      fname := GetInitFilename;
      if FileExists(fname) then
        SL.LoadFromFile(fname);
      SL.AddStrings(tmpSL);
      ForceDirectories(ExtractFilePath(fname));
      SL.SaveToFile(fname);
    finally
      tmpSL.Free;
    end;
  finally
    SL.Free;
  end;
end;

procedure TFantomSpirit.LookupOffsetsIfNeeded;
var
  modID : Cardinal;
  count : Word;
  buffer : NXTDataBuffer;
  res : boolean;
begin
  // lookup our offsets if needed
  if (fOffsetDS = MaxInt) and (fOffsetDVA = MaxInt) then
  begin
    modID := kNXT_ModuleCmd;
    count := 4;
    buffer.Data[0] := 0;
    res := NXTReadIOMap(modID, CommandOffsetOffsetDS, count, buffer);
    if res then
    begin
      fOffsetDS := Word(BytesToCardinal(buffer.Data[0], buffer.Data[1]));
      fOffsetDVA := Word(BytesToCardinal(buffer.Data[2], buffer.Data[3]));
    end;
  end
  else if fOffsetDS = MaxInt then
  begin
    // IOMapRead CommandOffsetOffsetDS
    modID := kNXT_ModuleCmd;
    count := 2;
    buffer.Data[0] := 0;
    res := NXTReadIOMap(modID, CommandOffsetOffsetDS, count, buffer);
    if res then
      fOffsetDS := Word(BytesToCardinal(buffer.Data[0], buffer.Data[1]));
  end
  else if fOffsetDVA = MaxInt then
  begin
    // IOMapRead CommandOffsetOffsetDVA
    modID := kNXT_ModuleCmd;
    count := 2;
    buffer.Data[0] := 0;
    res := NXTReadIOMap(modID, CommandOffsetOffsetDVA, count, buffer);
    if res then
      fOffsetDVA := Word(BytesToCardinal(buffer.Data[0], buffer.Data[1]));
  end;
end;

function TFantomSpirit.GetNXTVariableHelper(aNum, aIdx, aCount, aDigits: integer): variant;
var
  modID, cval : Cardinal;
  count, dvindex, dvoff, dvsize, dvcount, totalbytes, idx, dims : Word;
  buffer : NXTDataBuffer;
  offset, size, vartype, ival : integer;
  tmpoffset, tmpsize, tmpvartype : integer;
  dst : TDSType;
  res : boolean;
  buf : array of Byte;
  tmpVar : Variant;
  fval : Single;
begin
  Result := 0;
  LookupOffsetsIfNeeded;
  if (fOffsetDS <> $FFFF) and (fOffsetDVA <> $FFFF) then
  begin
    modID := kNXT_ModuleCmd;
    DoGetVarInfoByID(aNum, offset, size, vartype);
    if (offset <> -1) and (size <> -1) and (vartype <> -1) then
    begin
      dst := TDSType(Byte(vartype));
      // if vartype == scalar type then
      if dst in [dsUByte, dsSByte, dsUWord, dsSWord, dsULong, dsSLong, dsFloat] then
      begin
        // IOMapRead from fOffsetDS+offset, size bytes
        count := size; // variable size
        buffer.Data[0] := 0;
        res := NXTReadIOMap(modID, fOffsetDS+offset, count, buffer);
        if res then
        begin
          Result := GetVariantFromByteArray(dst, buffer.Data, 0);
        end;
      end
      else if dst = dsArray then
      begin
        // TODO: this code only supports 1-dimensional arrays!!!!!
        // Fix it to support N-dimensions

        dims := 0; // how many dimensions are there?
        // what is the base array type?
        idx := 1;
        while dst = dsArray do
        begin
          DoGetVarInfoByID(aNum+idx, tmpoffset, tmpsize, tmpvartype);
          if (tmpoffset <> -1) and (tmpsize <> -1) and (tmpvartype <> -1) then
            dst := TDSType(Byte(tmpvartype))
          else
            break;
          inc(idx);
          inc(dims);
        end;
        if (offset <> -1) and (size <> -1) and (vartype <> -1) and (dims = 1) then
        begin
          // read aCount elements starting at aIdx
          // first get dope vector index
          count := 2; //  get a UWORD for the DVIndex
          buffer.Data[0] := 0;
          res := NXTReadIOMap(modID, fOffsetDS+offset, count, buffer);
          if res then
          begin
            dvindex := Word(BytesToCardinal(buffer.Data[0], buffer.Data[1]));
            // now get this array's dope vector information
            count := 6; //  get 3 UWORD values from the dope vector array
            buffer.Data[0] := 0;
            res := NXTReadIOMap(modID, fOffsetDVA+(10*dvindex), count, buffer);
            if res then
            begin
              dvoff   := Word(BytesToCardinal(buffer.Data[0], buffer.Data[1]));
              dvsize  := Word(BytesToCardinal(buffer.Data[2], buffer.Data[3]));
              dvcount := Word(BytesToCardinal(buffer.Data[4], buffer.Data[5]));
              // I can read up to ~50 bytes at a time so try to optimize this, if possible
              // the user has requested aCount elements (0 == 1)
              if aCount = 0 then
                aCount := 1;
              if (aIdx + aCount) > dvcount then
                aCount := dvcount-aIdx;
              dvoff := dvoff + aIdx*dvsize; // move the offset forward to the specified element index
              // number of bytes to read is dvsize*aCount but maxed out at dvsize*dvcount
              totalbytes := dvsize*aCount; // total number of bytes
              SetLength(buf, totalbytes);
              idx := 0;
              while totalbytes > 0 do
              begin
                count := Min(56, totalbytes);
                res := NXTReadIOMap(modID, fOffsetDS+dvoff+idx, count, buffer);
                if not res then
                  Exit;
                Move(buffer.Data[0], buf[idx], count);
                inc(idx, count);
                dec(totalbytes, count);
              end;
              // we have filled our byte array with all the values we need
              Result := ''; // empty string
              for idx := 0 to aCount - 1 do
              begin
                if dst in [dsUByte, dsSByte, dsUWord, dsSWord, dsULong, dsSLong, dsFloat] then
                begin
                  tmpVar := GetVariantFromByteArray(dst, buf, idx);
                  case dst of
                    dsUByte, dsSByte, dsUWord, dsSWord, dsSLong : begin
                      ival := tmpVar;
                      Result := Result + Format('%d ', [ival]);
                    end;
                    dsULong : begin
                      cval := tmpVar;
                      Result := Result + Format('%d ', [cval]);
                    end;
                  else
                    // dsFloat
                    fval := tmpVar;
                    Result := Result + Format('%.4f ', [fval]);
                  end;
                end
                else if dst = dsCluster then
                begin
                  // ???
                end;
              end;
            end;
          end;
        end
        else
          Result := 0;
      end
      else if dst = dsCluster then
      begin
        // output all the structure fields as a string
      end;
    end;
  end;
end;

function TFantomSpirit.GetVariantFromByteArray(dst: TDSType; buf: array of byte; idx: integer): variant;
begin
  case dst of
    dsUByte :
      Result := Integer(buf[idx]);
    dsSByte :
      Result := Integer(Char(buf[idx]));
    dsUWord :
      Result := Integer(Word(BytesToCardinal(buf[idx*2], buf[(idx*2)+1])));
    dsSWord :
      Result := Integer(SmallInt(BytesToCardinal(buf[idx*2], buf[(idx*2)+1])));
    dsULong :
      Result := BytesToCardinal(buf[idx*4], buf[(idx*4)+1], buf[(idx*4)+2], buf[(idx*4)+3]);
    dsSLong :
      Result := Integer(BytesToCardinal(buf[idx*4], buf[(idx*4)+1], buf[(idx*4)+2], buf[(idx*4)+3]));
    dsFloat :
      Result := CardinalToSingle(BytesToCardinal(buf[idx*4], buf[(idx*4)+1], buf[(idx*4)+2], buf[(idx*4)+3]));
  else
    Result := 0;
  end;
end;

procedure TFantomSpirit.FlushReceiveBuffer;
begin
  //
end;

procedure TFantomSpirit.SendRawData(const Data: array of byte);
begin
  //
end;

end.
