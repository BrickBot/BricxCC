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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
program BrickTool;

{$APPTYPE CONSOLE}

uses
{$IFDEF FAST_MM}
  FastMM4,
  FastMove,
{$ENDIF}
  Classes,
  SysUtils,                            
  Dialogs,
  Math,
  uGlobals in 'uGlobals.pas',
  ParamUtils in 'ParamUtils.pas',
  rcx_link in 'bricktools\rcx_link.pas',
  brick_common in 'bricktools\brick_common.pas',
  uSpirit in 'bricktools\uSpirit.pas',
  uVersionInfo in 'uVersionInfo.pas',
  uNXTClasses in 'NXT\uNXTClasses.pas',
  uNXTConstants in 'NXT\uNXTConstants.pas',
  uCmdLineUtils in 'uCmdLineUtils.pas',
  uCommonUtils in 'uCommonUtils.pas';

{$R *.RES}

type
  TRCXToolHelper = class
  public
    procedure HandleDownloadStatus(Sender : TObject; cur, total : Integer; var Abort : Boolean);
    procedure HandleDownloadDone(Sender : TObject);
  end;

var
  SL : TStrings;
  i : Integer;
  rcxToolHelper : TRCXToolHelper;
  addr, size : Integer;
  cvalue : cardinal;
// getoutputstate variables
  port, power: integer;
  mode, regmode, runstate: byte;
  turnratio: integer;
  tacholimit: cardinal;
  tachocount, blocktachocount, rotationcount: Integer;
// getintputvalues variables
  valid, calibrated: boolean;
  stype, smode: byte;
  raw, normalized: word;
  scaled, calvalue: smallint;
// misc variables
  pattern : string;
  pmin, pmaj, fmin, fmaj, bytesReady, lsstate : byte;
  btaddr : string;
  btsig : Cardinal;
  memFree : Cardinal;
  pressed : boolean;
  btncount : byte;
  Msg : PBRMessage;



procedure OutputValue(val : integer); overload;
const
  HEX_FMT : array[Boolean] of string = ('%4.2x', '%4.4x');
begin
  if ParamSwitch('/HEX') then
    Writeln(Format(HEX_FMT[val > $FF], [val]))
  else
    Writeln(val);
end;

procedure OutputValue(str : string); overload;
begin
  OutputValue(StrToIntDef(str, 0));
end;

function IsRCX : Boolean;
begin
  Result := (BrickComm.BrickType = rtRCX) or (BrickComm.BrickType = rtRCX2) or (BrickComm.BrickType = rtSwan);
end;

function IsNXT : Boolean;
begin
  Result := BrickComm.BrickType = rtNXT;
end;

function NotNXT : Boolean;
begin
  Result := not IsNXT;
end;

procedure PrintUsage;
begin
  PrintVersion;
  Writeln('Usage: ' + progName + ' [options] [actions]');
  Writeln('Options:');
  Writeln('   /Target=<n>: target can be RCX (0), Cybermaster (1), Scout (2), RCX2 (3), SpyBot (4), Swan (5), or NXT (6)');
  Writeln('   /COM=port: specify port name (COMn or usb)');
  Writeln('   /BT: use bluetooth (NXT only)');
  Writeln('   /RPT=<n>: specify remote repeat count');
  Writeln('   /T=<n>: specify transmit timeout value');
  Writeln('   /V: specify verbose mode');
  Writeln('   /X: omit packet header (RCX only)');
  Writeln('   /HEX: use hexidecimal for numeric output');
  Writeln('   /Duration=<n>: specify the tone duration for the playtone action');
  Writeln('NXT Options:');
  Writeln('   /Inbox=<n>: use inbox number n when sending or reading a message');
  Writeln('   /Loop: loop when playing sound files');
  Writeln('   /Relative: reset output position relative');
  Writeln('   /Empty: empty mailbox when reading');
//  Writeln('   /F: specify fast mode');
  Writeln('Actions:');
  Writeln('   -run: run current program');
  Writeln('   -pgm=<n>: select program number');
  Writeln('   -datalog | -datalog_full: upload datalog (_full == verbose)');
  Writeln('   -eeprom=<n> | -eeprom_full: upload eeprom block (_full == all blocks)');
  Writeln('   -memory=<n> | -memory_full: upload 128 bytes of memory (_full == all memory)');
  Writeln('   -map: upload memory map');
  Writeln('   -monitor=<n>: monitor IR for n seconds');
  Writeln('   -near : set IR to near mode');
  Writeln('   -far : set IR to far mode');
  Writeln('   -firmware=<filename> : download firmware');
  Writeln('   -firmfast=<filename> : download firmware at quad speed');
  Writeln('   -watch=<HHMM|now> : set RCX time');
  Writeln('   -sleep=<timeout> : set RCX sleep timeout');
  Writeln('   -msg=<number> : send IR message to RCX');
  Writeln('   -raw=<data> : format data as a packet and send to RCX');
  Writeln('   -remote=<value> : send a remote command to RCX');
  Writeln('   -scout=<0|1> : put Scout into normal or power mode');
  Writeln('   -var=<N> : read the value of variable N (0-31)');
  Writeln('   -timer=<N> : read the value of timer N (0-3)');
  Writeln('   -counter=<N> : read the value of timer N (0-2)');
  Writeln('   -msgVal : read the current message');
  Writeln('   -incCounter=<N> : increment counter N');
  Writeln('   -decCounter=<N> : increment counter N');
  Writeln('Actions supported by all bricks:');
  Writeln('   -clear : erase all items on the brick');
  Writeln('   -battery : return the battery level');
  Writeln('   -input=<N> : read input N (0-2, 0-3 for NXT)');
  Writeln('   -output=<N> : read the status of output N (0-2)');
  Writeln('   -mute : stop playing sounds');
  Writeln('   -playtone=<frequency> : play a tone for the specified duration');
  Writeln('NXT Actions:');
  Writeln('   -run=<filename> : run the specified program');
  Writeln('   -runningprogram : return the name of the currently running program');
  Writeln('   -stop : stop the currently running program');
  Writeln('   -playfile=<filename> : play the specified sound file');
  Writeln('   -download=<filename> : download the specified file to the NXT');
  Writeln('   -upload=<filename> : upload the specified file from the NXT');
  Writeln('   -listfiles[=<pattern>] : list the files matching the pattern (or *.*)');
  Writeln('   -listmodules[=<pattern>] : list the modules matching the pattern (or *.*)');
  Writeln('   -delete=<filename> : delete the specified file from the NXT');
  Writeln('   -keepalive : return the current sleep time limit');
  Writeln('   -msg=<string> : send the specified message to the NXT');
  Writeln('   -msgread=<box> : read the message from the specified box');
  Writeln('   -resetoutputposition=<port> : reset the position for the specified port');
  Writeln('   -resetinputsv=<port> : reset the input scaled value for the specified port');
  Writeln('   -setname=<new_name> : set the name of the NXT');
  Writeln('   -getname : return the name of the NXT');
  Writeln('   -versions : return the NXT firmware and protocol versions');
  Writeln('   -deviceinfo : return all NXT device information');
  Writeln('   -freemem : return the amount of free memory');
  Writeln('   -lsstatus=<port> : return the low speed status for the specified port');
  Writeln('   -btnstate=<btn> : return the button state for the specified button');
  Writeln('   -resetbtnstate=<btn> : reset the button state for the specified button');
  Writeln('   -boot : reset the NXT into SAMBA mode (usb only)');
  Writeln('   -btreset : reset the NXT bluetooth to factory settings (usb only)');
  Writeln('   -defrag : defragment the NXT filesystem');
{
DCSetOutputState
DCSetInputMode
SCPollCommandLen
SCPollCommand
SCWriteIOMap
SCReadIOMap
NXTLowSpeed[port : byte]
}
  Writeln('General:');
  Writeln('   -help : display command line options');
end;

{ TRCXToolHelper }

procedure TRCXToolHelper.HandleDownloadStatus(Sender: TObject; cur,
  total: Integer; var Abort: Boolean);
begin
  Write('.');
end;

procedure TRCXToolHelper.HandleDownloadDone(Sender : TObject);
begin
  Writeln('done');
end;

begin

  if ParamCount = 0 then
  begin
    PrintUsageError;
    Exit;
  end;

  if ParamSwitch('-help') then
  begin
    PrintUsage;
    Exit;
  end;

  rcxToolHelper := TRCXToolHelper.Create;
  try
    SL := BrickComm.DataLog;
    BrickComm.OnDownloadStatus := rcxToolHelper.HandleDownloadStatus;
    BrickComm.OnDownloadDone   := rcxToolHelper.HandleDownloadDone;

    if ParamSwitch('/COM') then
      BrickComm.Port := ParamValue('/COM');
    if ParamSwitch('/Target') then
      BrickComm.BrickType := ParamIntValue('/Target', 0);
    BrickComm.VerboseMode := ParamSwitch('/V');
    BrickComm.OmitHeader  := ParamSwitch('/X');
    BrickComm.UseBluetooth := ParamSwitch('/BT');
  //  BrickComm.FastMode := ParamSwitch('/F');
    if ParamSwitch('/T') then
      BrickComm.RxTimeout := ParamIntValue('/T', 1000);
    if ParamSwitch('-scout') and (BrickComm.BrickType = rtScout) then
      BrickComm.ScoutNum(ParamIntValue('-scout', 1));
    if (ParamSwitch('-datalog') or ParamSwitch('-datalog_full')) and IsRCX then
    begin
      SL := BrickComm.UploadDatalog(ParamSwitch('-datalog_full'));
      for i := 0 to SL.Count - 1 do
        OutputValue(SL[i]);
      if BrickComm.VerboseMode then
        Writeln('');
    end;
    if (ParamSwitch('-eeprom') or ParamSwitch('-eeprom_full')) and
       (BrickComm.BrickType = rtSpy) then
    begin
      if ParamSwitch('-eeprom_full') then
        SL := BrickComm.PollEEPROM()
      else
        SL := BrickComm.PollEEPROM(ParamIntValue('-eeprom', 0));
      for i := 0 to SL.Count - 1 do
        OutputValue(SL[i]);
      if BrickComm.VerboseMode then
        Writeln('');
    end;
    if (ParamSwitch('-memory') or ParamSwitch('-memory_full')) and
       (BrickComm.BrickType in [rtScout..rtSpy]) then
    begin
      if ParamSwitch('-memory_full') then
      begin
        case BrickComm.BrickType of
          rtScout :
          begin
            addr := $0040;
            size := $0440 - addr;
          end;
          rtSpy :
          begin
            addr := $0080;
            size := $0FFF - addr;
          end;
        else
          addr := $8000;
          size := $FFFF - addr;
        end;
        SL := BrickComm.PollMemory(addr, size);
      end
      else
        SL := BrickComm.PollMemory(ParamIntValue('-memory', 0));
      for i := 0 to SL.Count - 1 do
        OutputValue(SL[i]);
      if BrickComm.VerboseMode then
        Writeln('');
    end;
    if ParamSwitch('-map') then
    begin
      SL := BrickComm.DownloadMemoryMap;
      for i := 0 to SL.Count - 1 do
        OutputValue(SL[i]);
      if BrickComm.VerboseMode then
        Writeln('');
    end;
    if ParamSwitch('-monitor') then
    begin
      SL := BrickComm.MonitorIR(ParamIntValue('-monitor', 10));
      for i := 0 to SL.Count - 1 do
        Writeln((SL[i]));
      if BrickComm.VerboseMode then
        Writeln('');
    end;
    if ParamSwitch('-clear') then
      if IsNXT then
        BrickComm.SCDeleteUserFlash(True)
      else
        BrickComm.ClearMemory;
    if ParamSwitch('-near') and NotNXT then
      BrickComm.TransmitPower(tlNear);
    if ParamSwitch('-far') and NotNXT then
      BrickComm.TransmitPower(tlFar);
    if ParamSwitch('-firmware') and IsRCX then
      BrickComm.DownloadFirmware(ParamValue('-firmware'), False, True, True);
    if ParamSwitch('-firmfast') and IsRCX then
      BrickComm.DownloadFirmware(ParamValue('-firmfast'), True, True, True);
    if ParamSwitch('-watch') and IsRCX then
      BrickComm.SetWatch(ParamValue('-watch'));
    if ParamSwitch('-sleep') and NotNXT then
      BrickComm.Sleep(ParamIntValue('-sleep', 10));
    if ParamSwitch('-run') then begin
      // run with filename for NXT
      if IsNXT then
        BrickComm.DCStartProgram(ParamValue('-run'))
      else
        BrickComm.StartTask(ParamIntValue('-run', 0));
    end;
    if ParamSwitch('-pgm') and IsRCX then
      BrickComm.SelectProgram(ParamIntValue('-pgm', 1));
    if ParamSwitch('-msg') then
    begin
      if IsNXT then
        BrickComm.DCMessageWrite(ParamIntValue('/Inbox', 0), ParamValue('-msg'))
      else
        BrickComm.SendMessage(ParamIntValue('-msg', 0));
    end;
    if ParamSwitch('-raw') and NotNXT then
      OutputValue(BrickComm.SendRawCommand(ParamValue('-raw'), true));
    if ParamSwitch('-raw1') and NotNXT then
      BrickComm.SendRawCommand(ParamValue('-raw1'), false);
    if ParamSwitch('-remote') and NotNXT then
      BrickComm.SendRemoteStr(ParamValue('-remote'), ParamIntValue('/RPT', 1));
    if ParamSwitch('-battery') then
      OutputValue(BrickComm.BatteryLevel);
    if ParamSwitch('-input') then
    begin
      if IsNXT then
      begin
        port := ParamIntValue('-input', 0);
        if BrickComm.DCGetInputValues(port, valid,
          calibrated, stype, smode, raw, normalized, scaled, calvalue) then
        begin
          Writeln(Format('Port: %d'#13#10 +
                         'Valid: %s'#13#10 +
                         'Calibrated: %s'#13#10 +
                         'Type: %d (%s)'#13#10 +
                         'Mode: %d (%s)'#13#10 +
                         'Raw Value: %d'#13#10 +
                         'Normalized Value: %d'#13#10 +
                         'Scaled Value: %d'#13#10 +
                         'Calibrated Value: %d',
                         [port, BoolToStr(valid, True),
                          BoolToStr(calibrated, True),
                          stype, NXTInputTypeToStr(stype),
                          smode, NXTInputModeToStr(smode),
                          raw, normalized, scaled, calvalue]));
        end;
      end
      else
        OutputValue(BrickComm.GetInputValue(ParamIntValue('-input', 0)));
    end;
    if ParamSwitch('-output') then
    begin
      if IsNXT then
      begin
        port := ParamIntValue('-output', 0);
        if BrickComm.DCGetOutputState(port, power, mode,
          regmode, turnratio, runstate, tacholimit, tachocount, blocktachocount, rotationcount) then
        begin
          Writeln(Format('Port: %d'#13#10 +
                         'Power: %d'#13#10 +
                         'Mode: %d (%s)'#13#10 +
                         'Regulation Mode: %d (%s)'#13#10 +
                         'Turn Ratio: %d'#13#10 +
                         'Run State: %d (%s)'#13#10 +
                         'Tacho Limit: %d'#13#10 +
                         'Tacho Count: %d'#13#10 +
                         'Block Tacho Count: %d'#13#10 +
                         'Rotation Count: %d',
                         [port, power, mode, NXTOutputModeToStr(mode),
                          regmode, NXTOutputRegModeToStr(regmode),
                          turnratio, runstate, NXTOutputRunStateToStr(runstate),
                          tacholimit, tachocount, blocktachocount, rotationcount]));
        end;
      end
      else
        OutputValue(BrickComm.GetOutputStatus(ParamIntValue('-output', 0)));
    end;
    if ParamSwitch('-var') and NotNXT then
      OutputValue(BrickComm.GetVariableValue(ParamIntValue('-var', 0)));
    if ParamSwitch('-timer') and NotNXT then
      OutputValue(BrickComm.GetTimerValue(ParamIntValue('-timer', 0)));
    if ParamSwitch('-counter') and NotNXT then
      OutputValue(BrickComm.GetCounterValue(ParamIntValue('-counter', 0)));
    if ParamSwitch('-msgVal') and NotNXT then
      OutputValue(BrickComm.GetMessageValue(0));
    if ParamSwitch('-incCounter') and NotNXT then
      BrickComm.IncCounter(ParamIntValue('-incCounter', 0));
    if ParamSwitch('-decCounter') and NotNXT then
      BrickComm.DecCounter(ParamIntValue('-decCounter', 0));
    if ParamSwitch('-mute') then
      BrickComm.MuteSound;
    if ParamSwitch('-playtone') then
      BrickComm.PlayTone(ParamIntValue('-playtone', 440), ParamIntValue('/Duration', 500));
    // NXT actions
    if ParamSwitch('-stop') and IsNXT then
      BrickComm.DCStopProgram;
    if ParamSwitch('-playfile') and IsNXT then
      BrickComm.DCPlaySoundFile(ParamValue('-playfile'), ParamSwitch('/L'));
    if ParamSwitch('-keepalive') and IsNXT then
    begin
      if BrickComm.DCKeepAlive(cvalue) then
        OutputValue(cvalue);
    end;
    if ParamSwitch('-resetoutputposition') and IsNXT then
      BrickComm.DCResetOutputPosition(ParamIntValue('-resetoutputposition', 0), ParamSwitch('/Relative'));
    if ParamSwitch('-resetinputsv') and IsNXT then
      BrickComm.DCResetInputScaledValue(ParamIntValue('-resetinputsv', 0));
    if ParamSwitch('-upload') and IsNXT then
      BrickComm.UploadFile(ParamValue('-upload'));
    if ParamSwitch('-download') and IsNXT then
    begin
      pattern := ParamValue('-download');
      BrickComm.DownloadFile(pattern, NXTNameToPBRFileType(pattern));
    end;
    if ParamSwitch('-delete') and IsNXT then
    begin
      pattern := ParamValue('-delete');
      BrickComm.SCDeleteFile(pattern, True);
    end;
    if ParamSwitch('-defrag') then
    begin
      if not BrickComm.SCDefragmentFlash then
        WriteLn('Defragmentation failed');
    end;
    if ParamSwitch('-listfiles') and IsNXT then
    begin
      pattern := ParamValue('-listfiles');
      if pattern = '' then
        pattern := '*.*';
      SL.Clear;
      BrickComm.ListFiles(pattern, SL);
      for i := 0 to SL.Count - 1 do
        WriteLn(SL[i]);
    end;
    if ParamSwitch('-listmodules') and IsNXT then
    begin
      pattern := ParamValue('-listmodules');
      if pattern = '' then
        pattern := '*.*';
      SL.Clear;
      BrickComm.ListModules(pattern, SL);
      for i := 0 to SL.Count - 1 do
        WriteLn(SL[i]);
    end;
    if ParamSwitch('-runningprogram') and IsNXT then
    begin
      if BrickComm.DCGetCurrentProgramName(pattern) then
        Writeln(pattern);
    end;
    if ParamSwitch('-setname') and IsNXT then
      BrickComm.SCSetBrickName(ParamValue('-setname'), True);
    if ParamSwitch('-boot') and IsNXT then
      BrickComm.SCBootCommand(True);
    if ParamSwitch('-btreset') and IsNXT then
      BrickComm.SCBTFactoryReset(True);
    if ParamSwitch('-versions') and IsNXT then
    begin
      if BrickComm.SCGetVersions(pmin, pmaj, fmin, fmaj) then
      begin
        Writeln(Format('Protocol version = %d.%d', [pmaj, pmin]));
        Writeln(Format('Firmware version = %d.%d', [fmaj, fmin]));
      end;
    end;
    if ParamSwitch('-deviceinfo') and IsNXT then
    begin
      if BrickComm.SCGetDeviceInfo(pattern, btaddr, btsig, memFree) then
      begin
        Writeln(Format('Brick name = %s', [pattern]));
        Writeln(Format('Bluetooth Address = %s', [btaddr]));
        Writeln(Format('Bluetooth signal strength = %d', [btsig]));
        Writeln(Format('Free memory = %d', [memFree]));
      end;
    end;
    if ParamSwitch('-getname') and IsNXT then
    begin
      if BrickComm.SCGetDeviceInfo(pattern, btaddr, btsig, memFree) then
        Writeln(pattern);
    end;
    if ParamSwitch('-freemem') and IsNXT then
    begin
      if BrickComm.SCGetDeviceInfo(pattern, btaddr, btsig, memFree) then
        OutputValue(memFree);
    end;
    if ParamSwitch('-lsstatus') and IsNXT then
    begin
      port := ParamIntValue('-lsstatus', 0);
      if BrickComm.DCLSGetStatus(port, bytesReady, lsstate) then
        OutputValue(bytesReady);
    end;
    if ParamSwitch('-btnstate') and IsNXT then
    begin
      port := ParamIntValue('-btnstate', 0);
      if BrickComm.DCGetButtonState(port, False, pressed, btncount) then
        Writeln(Format('Button %d: pressed = %s, count = %d', [port, BoolToStr(pressed, True), btncount]));
    end;
    if ParamSwitch('-resetbtnstate') and IsNXT then
    begin
      port := ParamIntValue('-resetbtnstate', 0);
      BrickComm.DCGetButtonState(port, True, pressed, btncount);
    end;
    if ParamSwitch('-readmsg') and IsNXT then
    begin
      port := ParamIntValue('-readmsg', 0);
      if BrickComm.DCMessageRead(port, ParamIntValue('/Inbox', 0), ParamSwitch('/Empty'), Msg) then
      begin
        for i := 0 to Msg.Size - 1 do
          OutputValue(Msg.Data[i]);
      end;
    end;

    if BrickComm.VerboseMode then
    begin
      SL.Text := BrickComm.LinkLog;
      for i := 0 to SL.Count - 1 do
        Writeln(SL[i]);
    end;
  finally
    FreeAndNil(rcxToolHelper);
  end;
end.