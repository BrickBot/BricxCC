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
unit SProSpirit;

interface

uses
  Classes, SysUtils, rcx_cmd, uSpirit, uNXTConstants, FantomDefs;

type
  TSProSpirit = class(TBrickComm)
  private
    dcResponse : array [0..63] of byte;
  protected
    function  GetDownloadWaitTime: Integer; override;
    function  GetEEPROM(addr: Byte): Byte; override;
    function  GetEEPROMBlock(idx: Integer): EEPROMBlock; override;
    function  GetIsOpen: boolean; override;
    function  GetLSBlock(aPort: byte): NXTLSBlock; override;
    function  GetOmitHeader: Boolean; override;
    function  GetQuiet: Boolean; override;
    function  GetRCXFirmwareChunkSize: Integer; override;
    function  GetRxTimeout: Word; override;
    function  GetLinkLog: string; override;
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
  public
    constructor Create(aType : byte = 0; const aPort : string = ''); override;
    destructor Destroy; override;

    function  Open : boolean; override;
    function  Close : boolean; override;

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
    function StartProgram(const filename : string) : boolean; override;
    function StopProgram : boolean; override;
    function PlaySoundFile(const filename : string; bLoop : boolean) : boolean; override;
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
    function ResetInputScaledValue(const aPort : byte) : boolean; override;
    function ResetOutputPosition(const aPort : byte; const Relative : boolean) : boolean; override;
    function MessageWrite(const inbox : byte; const msg : string) : boolean; override;
    function KeepAlive(var time : cardinal; const chkResponse : boolean = true) : boolean; override;
    function LSGetStatus(aPort : byte; var bytesReady : byte) : boolean; override;
    function GetCurrentProgramName(var name : string) : boolean; override;
    function GetButtonState(const idx : byte; const reset : boolean;
      var pressed : boolean; var count : byte) : boolean; override;
    function MessageRead(const remote, local : byte; const remove : boolean; var Msg : NXTMessage) : boolean; override;
    function SetPropDebugging(const debugging : boolean; const pauseClump : byte; const pausePC : Word) : boolean; override;
    function GetPropDebugging(var debugging : boolean; var pauseClump : byte; var pausePC : Word) : boolean; override;
    function SetVMState(const state : byte) : boolean; override;
    function SetVMStateEx(var state : byte; var clump : byte; var pc : word) : boolean; override;
    function GetVMState(var state : byte; var clump : byte; var pc : word) : boolean; override;
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
    // wrapper functions
    function DownloadFile(const filename : string; const filetype : TNXTFileType) : boolean; override;
    function DownloadStream(aStream : TStream; const dest : string; const filetype : TNXTFileType) : boolean; override;
    function NXTUploadFile(const filename : string; const dir : string = '') : boolean; override;
    function NXTUploadFileToStream(const filename : string; aStream : TStream) : boolean; override;
    function NXTListFiles(const searchPattern : string; Files : TStrings) : boolean; override;
    function NXTListModules(const searchPattern : string; Modules : TStrings) : boolean; override;
    function NXTListBricks(Bricks : TStrings) : boolean; override;
    procedure NXTInitializeResourceNames; override;
    procedure NXTUpdateResourceNames; override;
  end;

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

{ TSProSpirit }

constructor TSProSpirit.Create(aType: byte; const aPort: string);
begin
  inherited Create(aType, aPort);
end;

destructor TSProSpirit.Destroy;
begin
  inherited Destroy;
end;

function TSProSpirit.BatteryLevel: integer;
begin
  Result := -1;
  if IsOpen then
  begin
  end;
end;

function TSProSpirit.Shutdown: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.MotorsOn(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSProSpirit.MotorsOff(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSProSpirit.MotorsFloat(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSProSpirit.SetFwd(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSProSpirit.SetRwd(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSProSpirit.SwitchDirection(aMotorList: Byte): boolean;
begin
  Result := False;
end;

function TSProSpirit.SetMotorPower(aMotorList: Byte; aSrc, aNum: integer): boolean;
begin
  Result := False;
end;

function TSProSpirit.PlayTone(aFreq, aTime: word): boolean;
begin
  Result := False;
end;

function TSProSpirit.SetSensorType(aNum, aType: integer): boolean;
begin
  Result := False;
end;

function TSProSpirit.SetSensorMode(aNum, aMode, aSlope: integer): boolean;
begin
  Result := False;
end;

function TSProSpirit.ClearSensorValue(aNum: integer): boolean;
begin
  Result := False;
end;

function TSProSpirit.Close: boolean;
begin
  Result := inherited Close;
//  Result := Result and fLink.Close;
  fActive := False;
end;

function TSProSpirit.Open: boolean;
begin
  Result := IsOpen;
  if not Result then begin
//    Result := fLink.Open;
    fActive := Result;
  end;
end;

function TSProSpirit.ClearMemory: boolean;
begin
  Result := False;
end;

function TSProSpirit.Sleep(aVal: integer): boolean;
begin
  Result := Open;
end;

function TSProSpirit.GetInputValue(aIn : integer) : integer;
begin
  Result := -1;
  if Open then
  begin
  end;
end;

procedure TSProSpirit.SetPort(const Value: string);
begin
  inherited SetPort(Value);
//  fLink.Port := Value;
end;

function TSProSpirit.DownloadFirmware(aFile: string; bFast : Boolean;
  bComp : Boolean; bUnlock : boolean): boolean;
begin
  Result := False;
end;

function TSProSpirit.Ping: boolean;
begin
  Result := Open;
  if not Result then Exit;
end;

function TSProSpirit.MuteSound: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.UnmuteSound: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.GetIsOpen: boolean;
begin
  Result := inherited GetIsOpen;
end;

function TSProSpirit.StartProgram(const filename: string): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.StopProgram: boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  // TODO: Implement StopProgram command
  // send ^D^D^D^D
end;

function TSProSpirit.PlaySoundFile(const filename: string; bLoop: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.GetNXTOutputState(const aPort: byte; var power: integer;
  var mode, regmode: byte; var turnratio: integer; var runstate: byte;
  var tacholimit: cardinal; var tachocount, blocktachocount, rotationcount: Integer): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  power := 0;
  mode := 0;
  regmode := 0;
  turnratio := 0;
  runstate := 0;
  tacholimit := 0;
  tachocount := 0;
  blocktachocount := 0;
  rotationcount := 0;
end;

function TSProSpirit.SetNXTOutputState(const aPort: byte;
  const power: integer; const mode, regmode: byte;
  const turnratio: integer; const runstate: byte;
  const tacholimit: cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.GetNXTInputValues(const aPort: byte; var valid,
  calibrated: boolean; var stype, smode: byte; var raw, normalized: word;
  var scaled, calvalue: smallint): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  stype := 0;
  smode := 0;
  raw := 0;
  normalized := 0;
  scaled := 0;
  calvalue := 0;
end;

function TSProSpirit.SetNXTInputMode(const aPort, stype, smode: byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.ResetInputScaledValue(const aPort: byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.ResetOutputPosition(const aPort: byte;
  const Relative: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.MessageWrite(const inbox: byte; const msg: string): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.KeepAlive(var time: cardinal; const chkResponse : boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.LSGetStatus(aPort : byte; var bytesReady: byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.GetLSBlock(aPort: byte): NXTLSBlock;
begin
  Result.RXCount := 0;
end;

procedure TSProSpirit.SetLSBlock(aPort: byte; const Value: NXTLSBlock);
begin
  if aPort = 0 then Exit;
end;

function TSProSpirit.GetCurrentProgramName(var name: string): boolean;
begin
  name := '';
end;

function TSProSpirit.GetButtonState(const idx: byte; const reset: boolean;
  var pressed: boolean; var count: byte): boolean;
begin
  pressed := False;
  count := 0;
end;

function TSProSpirit.MessageRead(const remote, local: byte;
  const remove: boolean; var Msg: NXTMessage): boolean;
begin
  Msg.Inbox := 0;
  Msg.Size  := 0;
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTOpenRead(const filename: string; var handle: FantomHandle;
  var size: cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
  handle := 0;
  size := 0;
end;

function TSProSpirit.NXTOpenReadLinear(const filename: string;
  var handle: FantomHandle; var size: cardinal): boolean;
begin
  Result := NXTOpenRead(filename, handle, size);
end;

function TSProSpirit.NXTOpenAppendData(const filename: string;
  var size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTOpenWrite(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTOpenWriteData(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTOpenWriteLinear(const filename: string;
  const size: cardinal; var handle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTRead(var handle: FantomHandle; var count: word;
  var buffer: NXTDataBuffer): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTWrite(var handle: FantomHandle; const buffer: NXTDataBuffer;
  var count: word; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTCloseFile(var handle: FantomHandle; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTDeleteFile(var filename: string; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTFindFirstFile(var filename: string;
  var IterHandle: FantomHandle; var filesize, availsize : cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTFindNextFile(var IterHandle: FantomHandle; var filename: string;
  var filesize, availsize : cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTFindClose(var IterHandle: FantomHandle): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTGetVersions(var protmin, protmaj, firmmin, firmmaj : byte): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTCloseModuleHandle(var handle: FantomHandle; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTBootCommand(const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTSetBrickName(const name: string; const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTGetDeviceInfo(var name: string;
  var BTAddress : String; var BTSignal : Cardinal; var memFree : Cardinal): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTDeleteUserFlash(const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

function TSProSpirit.NXTBTFactoryReset(const chkResponse: boolean): boolean;
begin
  Result := IsOpen;
  if not Result then Exit;
end;

type
  TFileInfoRec = class
  public
    FileHandle : FantomHandle;
    TotalSize : Cardinal;
    AvailableSize : Cardinal;
    Name : string;
  end;

function TSProSpirit.NXTUploadFile(const filename: string; const dir : string): boolean;
begin
  Result := False;
end;

function TSProSpirit.NXTUploadFileToStream(const filename: string; aStream: TStream): boolean;
begin
  Result := False;
end;

function TSProSpirit.NXTListFiles(const searchPattern: string; Files: TStrings): boolean;
begin
  Result := False;
  Files.Clear;
end;

function TSProSpirit.NXTListModules(const searchPattern: string;  Modules: TStrings): boolean;
begin
  Result := False;
  Modules.Clear;
end;

function TSProSpirit.NXTListBricks(Bricks: TStrings): boolean;
begin
  Result := False;
  Bricks.Clear;
end;

function TSProSpirit.DownloadFile(const filename: string; const filetype: TNXTFileType): boolean;
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
      Result := DownloadStream(MS, filename, filetype);
    finally
      MS.Free;
    end;
  end;
end;

function TSProSpirit.DownloadStream(aStream: TStream; const dest : string;
  const filetype: TNXTFileType): boolean;
begin
  Result := IsOpen;
  // TODO: implement DownloadStream
end;

function TSProSpirit.NXTPollCommandLen(const bufNum : byte; var count: byte): boolean;
begin
  Result := False;
end;

function TSProSpirit.NXTPollCommand(const bufNum: byte; var count: byte;
  var buffer: NXTDataBuffer): boolean;
begin
  Result := False;
end;

function TSProSpirit.NXTWriteIOMap(var ModID: Cardinal;
  const Offset: Word; var count: Word; const buffer: NXTDataBuffer;
  chkResponse : Boolean): boolean;
begin
  Result := False;
end;

function TSProSpirit.NXTReadIOMap(var ModID: Cardinal;
  const Offset: Word; var Count: Word; var buffer: NXTDataBuffer): boolean;
begin
  Result := False;
end;

function TSProSpirit.NXTFindNextModule(var Handle: FantomHandle;
  var ModName: string; var ModID, ModSize: Cardinal;
  var IOMapSize: Word): boolean;
begin
  Result := False;
end;

function TSProSpirit.NXTFindFirstModule(var ModName: string; var Handle: FantomHandle;
  var ModID, ModSize: Cardinal; var IOMapSize: Word): boolean;
begin
  Result := False;
end;

function TSProSpirit.dcBuffer: PByte;
begin
  Result := @dcResponse[0];
end;

function TSProSpirit.GetReplyByte(index: integer): Byte;
const
  DCReplyOffset = 2;
begin
  Result := dcResponse[index + DCReplyOffset];
end;

function TSProSpirit.GetReplyCardinal(index: integer): Cardinal;
begin
  Result := BytesToCardinal(GetReplyByte(index),
                            GetReplyByte(index+1),
                            GetReplyByte(index+2),
                            GetReplyByte(index+3));
end;

function TSProSpirit.GetReplyWord(index: integer): Word;
begin
  Result := Word(BytesToCardinal(GetReplyByte(index), GetReplyByte(index+1)));
end;

function TSProSpirit.GetDownloadWaitTime: Integer;
begin
  Result := 0;
end;

function TSProSpirit.GetEEPROM(addr: Byte): Byte;
begin
  Result := addr;
end;

function TSProSpirit.GetEEPROMBlock(idx: Integer): EEPROMBlock;
begin
  Result.Data[idx] := 0;
end;

function TSProSpirit.GetLinkLog: string;
begin
  Result := '';
end;

function TSProSpirit.GetOmitHeader: Boolean;
begin
  Result := False;
end;

function TSProSpirit.GetQuiet: Boolean;
begin
  Result := False;
end;

function TSProSpirit.GetRCXFirmwareChunkSize: Integer;
begin
  Result := 200;
end;

function TSProSpirit.GetRxTimeout: Word;
begin
  Result := 400;
end;

procedure TSProSpirit.SetDownloadWaitTime(const Value: Integer);
begin
// do nothing
  if Value = 0 then Exit;
end;

procedure TSProSpirit.SetEEPROM(addr: Byte; const Value: Byte);
begin
// do nothing
  if Value = 0 then Exit;
  if addr = 0 then Exit;
end;

procedure TSProSpirit.SetOmitHeader(const Value: Boolean);
begin
// do nothing
  if Value then Exit;
end;

procedure TSProSpirit.SetQuiet(const Value: Boolean);
begin
// do nothing
  if Value then Exit;
end;

procedure TSProSpirit.SetRCXFirmwareChunkSize(const Value: Integer);
begin
// do nothing
  if Value = 0 then Exit;
end;

procedure TSProSpirit.SetRxTimeout(const Value: Word);
begin
// do nothing
  if Value = 0 then Exit;
end;

function TSProSpirit.AbsVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSProSpirit.AndVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSProSpirit.BrickAlive: boolean;
begin
  Result := Open;
end;

function TSProSpirit.CalibrateEvent(enum, upper, lower,
  hysteresis: integer): boolean;
begin
  Result := Open;
  if enum = 0 then Exit;
  if upper = 0 then Exit;
  if lower = 0 then Exit;
  if hysteresis = 0 then Exit;
end;

function TSProSpirit.CalibrateLightSensor: boolean;
begin
  Result := Open;
end;

function TSProSpirit.ClearAllEvents: boolean;
begin
  Result := Open;
end;

function TSProSpirit.ClearCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TSProSpirit.ClearSound: boolean;
begin
  Result := Open;
end;

function TSProSpirit.ClearTachoCounter(aMotorList: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
end;

function TSProSpirit.ClearTimer(aNum: integer): boolean;
begin
  Result := Open;
  if aNum = 0 then Exit;
end;

function TSProSpirit.DatalogNext(aSrc, aNum: integer): boolean;
begin
  Result := False;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TSProSpirit.DecCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TSProSpirit.DeleteAllSubs: boolean;
begin
  Result := False;
end;

function TSProSpirit.DeleteAllTasks: boolean;
begin
  Result := False;
end;

function TSProSpirit.DeleteSub(aSub: integer): boolean;
begin
  Result := False;
end;

function TSProSpirit.DeleteTask(aTask: integer): boolean;
begin
  Result := False;
  if aTask = 0 then Exit;
end;

function TSProSpirit.DivVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSProSpirit.DownloadMemoryMap: TStrings;
begin
  Result := fMemMap;
end;

function TSProSpirit.Drive(aLeft, aRight: integer): boolean;
begin
  Result := Open;
  if aLeft = 0 then Exit;
  if aRight = 0 then Exit;
end;

function TSProSpirit.GetCounterValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_CounterType, aNum);
end;

function TSProSpirit.GetMessageValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_MessageType, aNum);
end;

function TSProSpirit.GetOutputStatus(aOut: integer): integer;
begin
  Result := 0;
  if aOut = 0 then Exit;
end;

function TSProSpirit.GetTimerValue(aNum: integer): integer;
begin
  Result := Poll(kRCX_TimerType, aNum);
end;

function TSProSpirit.GetVariableValue(aVar: integer): variant;
begin
  Result := Poll(kRCX_VariableType, aVar);
end;

function TSProSpirit.IncCounter(num: TCounterNumber): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
end;

function TSProSpirit.MonitorIR(aSeconds: integer): TStrings;
begin
  Result := fMemData;
  if aSeconds = 0 then Exit;
end;

function TSProSpirit.MulVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSProSpirit.OnWait(aMotorList: Byte; aNum: integer; aTime: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
  if aNum = 0 then Exit;
  if aTime = 0 then Exit;
end;

function TSProSpirit.OnWaitDifferent(aMotorList: Byte; aNum0, aNum1,
  aNum2: integer; aTime: Byte): boolean;
begin
  Result := Open;
  if aMotorList = 0 then Exit;
  if aNum0 = 0 then Exit;
  if aNum1 = 0 then Exit;
  if aNum2 = 0 then Exit;
  if aTime = 0 then Exit;
end;

function TSProSpirit.OrVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSProSpirit.PlaySystemSound(aSnd: byte): boolean;
begin
  Result := False;
end;

function TSProSpirit.Poll(aSrc, aNum: integer): variant;
begin
  Result := 0;
end;

function TSProSpirit.PollEEPROM(block: Integer): TStrings;
begin
  Result := fMemData;
  fMemData.Clear;
end;

function TSProSpirit.PollMemory(address, size: Integer): TStrings;
begin
  Result := fMemData;
end;

function TSProSpirit.PowerDownTime(aTime: integer): boolean;
begin
  Result := Open;
  if not Result then Exit;
end;

function TSProSpirit.PrepareBrick: boolean;
begin
  Result := Open;
end;

function TSProSpirit.Scout(bPower: boolean): boolean;
begin
  Result := Open and bPower;
end;

function TSProSpirit.ScoutNum(aVal: integer): boolean;
begin
  Result := Open;
  if aVal = 0 then Exit;
end;

function TSProSpirit.ScoutRules(motion: TScoutMotion; touch: TScoutTouch;
  light: TScoutLight; time: TScoutScale; fx: TScoutEffects): boolean;
begin
  Result := Open;
  if motion = smNone then Exit;
  if touch = stIgnore then Exit;
  if light = slIgnore then Exit;
  if time = ssShort then Exit;
  if fx = seNone then Exit;
end;

function TSProSpirit.ScoutSound(bSoundEnable, bSoundOff: boolean;
  aNum: TSoundSetNumber): boolean;
begin
  Result := Open and bSoundEnable and bSoundOff;
  if aNum = 0 then Exit;
end;

function TSProSpirit.SelectDisplay(aSrc, aNumber: integer): boolean;
begin
  Result := False;
  if (aSrc = 0) or (aNumber = 0) then Exit;
end;

function TSProSpirit.SelectProgram(aProg: integer): boolean;
begin
  Result := Open;
  // TODO: implement the SelectProgram command
end;

function TSProSpirit.SendMessage(aMsg: integer): boolean;
begin
  Result := MessageWrite(0, IntToStr(aMsg));
end;

function TSProSpirit.SendRawCommand(aCmd: string; bRetry: boolean): string;
begin
  Result := '';
  if (aCmd = '') or bRetry then Exit;
end;

function TSProSpirit.SendRemoteStr(aEvent: string; aRepeat: integer): boolean;
begin
  Result := Open;
  if (aEvent = '') or (aRepeat = 0) then Exit;
end;

function TSProSpirit.SendRemote(aEvent: Word; aRepeat: integer): boolean;
begin
  Result := Open;
  if (aEvent = 0) or (aRepeat = 0) then Exit;
end;

function TSProSpirit.SendUARTData(start, size: integer): boolean;
begin
  Result := Open;
  if start = 0 then Exit;
  if size = 0 then Exit;
end;

function TSProSpirit.SendVLL(aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if aSrc = 0 then Exit;
  if aNum = 0 then Exit;
end;

function TSProSpirit.SetCounterLimit(num: TCounterNumber; src: TTCSource;
  val: integer): boolean;
begin
  Result := Open;
  if num = 0 then Exit;
  if src = tcVariable then Exit;
  if val = 0 then Exit;
end;

function TSProSpirit.SetDatalog(aSize: integer): boolean;
begin
  Result := False;
  if aSize = 0 then Exit;
end;

function TSProSpirit.SetEvent(enum, snum, etype: integer): boolean;
begin
  Result := Open;
  if (enum = 0) or (snum = 0) or (etype = 0) then Exit;
end;

function TSProSpirit.SetFeedback(src, val: integer): boolean;
begin
  Result := Open;
  if (src = 0) or (val = 0) then Exit;
end;

function TSProSpirit.SetGlobalDirection(motors: TMotorsNum; action: TGlobalDirAction): boolean;
begin
  Result := Open;
  if (motors = 0) or (action = gdaBackward) then Exit;
end;

function TSProSpirit.SetGlobalOutput(motors: TMotorsNum; action: TGlobalOutAction): boolean;
begin
  Result := Open;
  if (motors = 0) or (action = goaFloat) then Exit;
end;

function TSProSpirit.SetLight(bOn: boolean): boolean;
begin
  Result := Open and bOn;
end;

function TSProSpirit.SetLightSensorBlinkTime(src: TLSSource; val: TBlinkTimeValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TSProSpirit.SetLightSensorHysteresis(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TSProSpirit.SetLightSensorLowerThreshold(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TSProSpirit.SetLightSensorUpperThreshold(src: TLSSource; val: TThresholdValue): boolean;
begin
  Result := Open;
  if (src = lsVariable) or (val = 0) then Exit;
end;

function TSProSpirit.SetMaxPower(motors: TMotorsNum; src, num: integer): boolean;
begin
  Result := Open;
  if (motors = 0) or (src = 0) or (num = 0) then Exit;
end;

function TSProSpirit.SetSourceValue(aDestSrc, aDestVal, aOrigSrc: Byte; aOrigVal: Smallint): boolean;
begin
  Result := Open;
  if (aDestSrc = 0) or (aDestVal = 0) or (aOrigSrc = 0) or (aOrigVal = 0) then Exit;
end;

function TSProSpirit.SetTimerLimit(num: TTimerNumber; src: TTCSource; val: integer): boolean;
begin
  Result := Open;
  if (val = 0) or (src = tcVariable) or (num = 0) then Exit;
end;

function TSProSpirit.SetVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSProSpirit.SetWatch(aTime: string): boolean;
begin
  Result := Open;
  if aTime = '' then Exit;
end;

function TSProSpirit.SetWatchHHMM(aHrs, aMins: integer): boolean;
begin
  Result := Open;
  if (aHrs = 0) or (aMins = 0) then Exit;
end;

function TSProSpirit.SgnVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSProSpirit.StartTask(aTask: integer): boolean;
begin
  Result := Open;
  if aTask = 0 then Exit;
end;

function TSProSpirit.StopAllTasks: boolean;
begin
  Result := Open;
end;

function TSProSpirit.StopTask(aTask: integer): boolean;
begin
  Result := False;
end;

function TSProSpirit.SubVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSProSpirit.SumVar(aVar, aSrc, aNum: integer): boolean;
begin
  Result := Open;
  if (aVar = 0) or (aSrc = 0) or (aNum = 0) then Exit;
end;

function TSProSpirit.TowerExists: boolean;
begin
  Result := Open;
end;

function TSProSpirit.TransmitPower(aLevel: TTransmitLevel): boolean;
begin
  Result := Open;
  if aLevel = tlNear then Exit;
end;

function TSProSpirit.UnlockBrick: string;
begin
  Open;
  Result := '';
end;

function TSProSpirit.UnlockFirmware: boolean;
begin
  Result := Open;
end;

function TSProSpirit.UploadDatalog(bVerbose: boolean): TStrings;
begin
  Open;
  Result := fDataLog;
  if bVerbose then Exit;
end;

function TSProSpirit.UploadPartialDatalog(aFrom, aSize: integer): TStrings;
begin
  Open;
  Result := fDataLog;
  if aFrom = 0 then Exit;
  if aSize = 0 then Exit;
end;

function TSProSpirit.Version(var rom, ram: Cardinal): boolean;
begin
  Result := False;
end;

function TSProSpirit.ViewSourceValue(prec, src, value: integer): boolean;
begin
  Result := Open;
  if (prec = 0) or (src = 0) or (value = 0) then Exit;
end;

procedure TSProSpirit.NXTInitializeResourceNames;
begin
end;

function TSProSpirit.NXTFreeMemory: integer;
begin
  Result  := 0;
end;

function TSProSpirit.NXTRenameFile(const old, new: string; const chkResponse: boolean): boolean;
begin
  Result := False;
end;

function TSProSpirit.GetVMState(var state: byte; var clump : byte; var pc : word): boolean;
begin
  Result := False;
end;

function TSProSpirit.SetVMStateEx(var state, clump: byte; var pc: word): boolean;
begin
  Result := False;
end;

function TSProSpirit.SetVMState(const state: byte): boolean;
begin
  Result := False;
end;

function TSProSpirit.GetPropDebugging(var debugging : boolean; var pauseClump: byte;
  var pausePC: Word): boolean;
begin
  Result := False;
end;

function TSProSpirit.SetPropDebugging(const debugging : boolean; const pauseClump: byte;
  const pausePC: Word): boolean;
begin
  Result := False;
end;

procedure TSProSpirit.NXTUpdateResourceNames;
begin
end;

end.
