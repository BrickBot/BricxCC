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
program NeXTTool;

{$APPTYPE CONSOLE}

uses
{$IFNDEF FPC}
  FastMM4,
  FastMove,
{$ENDIF}
  Classes,
  SysUtils,
  Math,
{$IFDEF FPC}
{$IFDEF WIN32}
  serial in 'fpc\serial.pp',
{$ENDIF}
{$ENDIF}
  ParamUtils in 'ParamUtils.pas',
  uVersionInfo in 'uVersionInfo.pas',
  uNXTConstants in 'NXT\uNXTConstants.pas',
  uSpirit in 'bricktools\uSpirit.pas',
  FantomSpirit in 'bricktools\FantomSpirit.pas',
  uCommonUtils in 'uCommonUtils.pas',
  uCmdLineUtils in 'uCmdLineUtils.pas';

{$IFDEF WIN32}
{$R *.RES}
{$ENDIF}

var
  SL : TStrings;
  i, j : Integer;
  cvalue : cardinal;
// getoutputstate variables
  port, power: integer;
  maddr, msize: integer;
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
  pmin, pmaj, fmin, fmaj, bytesReady : byte;
  btaddr : string;
  btsig : cardinal;
  memFree : Cardinal;
  pressed : boolean;
  btncount : byte;
  Msg : NXTMessage;
  BC : TBrickComm;


function BrickComm : TBrickComm;
begin
  if not Assigned(BC) then
  begin
    BC := TFantomSpirit.Create();
  end;
  Result := BC;
end;

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

{$I nexttool_preproc.inc}

procedure PrintUsage;
begin
  PrintVersion(COMPILATION_TIMESTAMP);
  Writeln('Usage: ' + progName + ' [options] [actions]');
  Writeln('Options:');
  Writeln('   /COM=port: specify port name (COMn, usb, resource string, or alias)');
  Writeln('   /BT[=name]: use bluetooth (selects the first brick found or the named brick)');
  Writeln('   /HEX: use hexidecimal for numeric output');
  Writeln('   /Duration=<n>: specify the tone duration for the playtone action');
  Writeln('   /Inbox=<n>: use inbox number n when sending or reading a message');
  Writeln('   /Loop: loop when playing sound files');
  Writeln('   /Relative: reset output position relative');
  Writeln('   /Empty: empty mailbox when reading');
  Writeln('   /Bin[=filename]: dump data output as binary to a file (nxt.bin)');
  Writeln('Actions:');
  Writeln('   -init : initialize nxt.dat file');
  Writeln('   -listbricks : list resource names of all found NXT bricks');
  Writeln('   -clear : erase all items on the brick');
  Writeln('   -battery : return the battery level');
  Writeln('   -input=<N> : read input N (0-3)');
  Writeln('   -output=<N> : read the status of output N (0-2)');
  Writeln('   -mute : stop playing sounds');
  Writeln('   -playtone=<frequency> : play a tone for the specified duration');
  Writeln('   -run=<filename> : run the specified program');
  Writeln('   -runningprogram : return the name of the currently running program');
  Writeln('   -stop : stop the currently running program');
  Writeln('   -playfile=<filename> : play the specified sound file');
  Writeln('   -firmware=<filename> : download firmware');
  Writeln('   -download=<filename> : download the specified file to the NXT');
  Writeln('   -upload[=<pattern>] : upload the specified file(s) from the NXT (or *.*)');
  Writeln('   -listfiles[=<pattern>] : list the files matching the pattern (or *.*)');
  Writeln('   -listmodules[=<pattern>] : list the modules matching the pattern (or *.*)');
  Writeln('   -delete=<filename> : delete the specified file from the NXT');
  Writeln('   -datalog | -datalog_full: upload datalog (_full == verbose)');
  Writeln('   -eeprom=<n> | -eeprom_full: upload eeprom block (_full == all blocks)');
  Writeln('   -memory=<n> | -memory_full: upload 128 bytes of memory (_full == all memory)');
  Writeln('   -map: upload memory map');
  Writeln('   -keepalive : return the current sleep time limit');
  Writeln('   -sleep=<timeout> : set NXT sleep timeout (in minutes)');
  Writeln('   -msg=<string> : send the specified message to the NXT');
  Writeln('   -readmsg=<box> : read the message from the specified box');
  Writeln('   -resetoutputposition=<port> : reset the position for the specified port');
  Writeln('   -resetinputsv=<port> : reset the input scaled value for the specified port');
  Writeln('   -setname=<new_name> : set the name of the NXT');
  Writeln('   -getname : return the name of the NXT');
  Writeln('   -versions : return the NXT firmware and protocol versions');
  Writeln('   -deviceinfo : return all NXT device information');
  Writeln('   -freemem : return the amount of free memory');
  Writeln('   -lsstatus=<port> : return the low speed status for the specified port');
//  Writeln('   -btnstate=<btn> : return the button state for the specified button');
//  Writeln('   -resetbtnstate=<btn> : reset the button state for the specified button');
  Writeln('   -boot : reset the NXT into SAMBA mode (usb only)');
  Writeln('   -btreset : reset the NXT bluetooth to factory settings (usb only)');
  Writeln('   -defrag : defragment the NXT filesystem');
{
SetNXTOutputState
SetNXTInputMode
NXTPollCommandLen
NXTPollCommand
NXTWriteIOMap
NXTReadIOMap
NXTLowSpeed[port : byte]
}
  Writeln('General:');
  Writeln('   -help : display command line options');
end;

procedure DumpData(SL : TStrings);
var
  MS : TMemoryStream;
  i : integer;
  b : Byte;
begin
  if ParamSwitch('/Bin') then
  begin
    pattern := ParamValue('/Bin');
    if pattern = '' then
      pattern := 'nxt.bin';
    MS := TMemoryStream.Create;
    try
      for i := 0 to SL.Count - 1 do
      begin
        b := Byte(StrToIntDef(SL[i], 0));
        MS.Write(b, 1);
      end;
      MS.SaveToFile(pattern);
    finally
      MS.Free;
    end;
  end
  else
  begin
    for i := 0 to SL.Count - 1 do
      OutputValue(SL[i]);
    if BrickComm.VerboseMode then
      Writeln('');
  end;
end;


begin
{$IFDEF FPC}
  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := '';
  VerFileVersion      := '1.2.1.r3';
  VerInternalName     := 'nexttool';
  VerLegalCopyright   := 'Copyright (c) 2006-2010, John Hansen';
  VerOriginalFileName := 'nexttool';
  VerProductName      := 'nexttool';
  VerProductVersion   := '1.2';
  VerComments         := '';
{$ENDIF}

  valid := False;
  calibrated := False;
  stype := 0;
  smode := 0;
  raw := 0;
  normalized := 0;
  scaled := 0;
  calvalue := 0;
  power := 0;
  mode := 0;
  regmode := 0;
  turnratio := 0;
  runstate := 0;
  tacholimit := 0;
  tachocount := 0;
  blocktachocount := 0;
  rotationcount := 0;
  cvalue := 0;
  pmin := 0;
  pmaj := 0;
  fmin := 0;
  fmaj := 0;
  memFree := 0;
  btsig := 0;
  bytesReady := 0;
  btncount := 0;
  pressed := False;
  Msg.Inbox:= 0;

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

  try
    SL := BrickComm.MemoryData;

    if ParamSwitch('-init') then
    begin
      BrickComm.NXTInitializeResourceNames;
      Exit;
    end;
    if ParamSwitch('-listbricks') then
    begin
      SL.Clear;
      BrickComm.NXTListBricks(SL);
      for i := 0 to SL.Count - 1 do
        WriteLn(SL[i]);
      Exit;
    end;
    if ParamSwitch('/COM') then
      BrickComm.Port := ParamValue('/COM');
    BrickComm.UseBluetooth := ParamSwitch('/BT');
    BrickComm.BluetoothName := ParamValue('/BT');
    if ParamSwitch('-firmware') then
    begin
      j := ParamIntValue('-iterations', 1, False);
      for i := 0 to j - 1 do
      begin
        BrickComm.DownloadFirmware(ParamValue('-firmware'), False, False, False);
        if j > 1 then
          WriteLn(Format('%d of %d', [i, j]));
      end;
    end;
    if BrickComm.Open then
    begin
      if ParamSwitch('-clear') then
        BrickComm.ClearMemory;
      if ParamSwitch('-sleep') then
        BrickComm.Sleep(ParamIntValue('-sleep', 10));
      if ParamSwitch('-msg') then
      begin
        BrickComm.MessageWrite(Byte(ParamIntValue('/Inbox', 0)), ParamValue('-msg'));
      end;
      if ParamSwitch('-battery') then
        OutputValue(BrickComm.BatteryLevel);
      if ParamSwitch('-input') then
      begin
        port := ParamIntValue('-input', 0);
        if BrickComm.GetNXTInputValues(Byte(port), valid,
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
                         [port, BoolToStr(valid),
                          BoolToStr(calibrated),
                          stype, NXTInputTypeToStr(stype),
                          smode, NXTInputModeToStr(smode),
                          raw, normalized, scaled, calvalue]));
        end;
      end;
      if ParamSwitch('-output') then
      begin
        port := ParamIntValue('-output', 0);
        if BrickComm.GetNXTOutputState(Byte(port), power, mode,
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
      end;
      if ParamSwitch('-mute') then
        BrickComm.MuteSound;
      if ParamSwitch('-playtone') then
        BrickComm.PlayTone(Word(ParamIntValue('-playtone', 440)), Word(ParamIntValue('/Duration', 500)));
      if ParamSwitch('-stop') then
        BrickComm.StopProgram;
      if ParamSwitch('-playfile') then
        BrickComm.PlaySoundFile(ParamValue('-playfile'), ParamSwitch('/L'));
      if ParamSwitch('-keepalive') then
      begin
        if BrickComm.KeepAlive(cvalue) then
          OutputValue(cvalue div 60000);
      end;
      if ParamSwitch('-resetoutputposition') then
        BrickComm.ResetOutputPosition(Byte(ParamIntValue('-resetoutputposition', 0)), ParamSwitch('/Relative'));
      if ParamSwitch('-resetinputsv') then
        BrickComm.ResetInputScaledValue(Byte(ParamIntValue('-resetinputsv', 0)));
      if ParamSwitch('-upload') then
      begin
        pattern := ParamValue('-upload');
        if pattern = '' then
          pattern := '*.*';
        BrickComm.NXTUploadFile(pattern);
      end;
      if ParamSwitch('-download') then
      begin
        pattern := ParamValue('-download');
        if pattern <> '' then
          BrickComm.DownloadFile(pattern, NameToNXTFileType(pattern));
      end;
      if ParamSwitch('-run') then begin
        BrickComm.StartProgram(ParamValue('-run'));
      end;
      if ParamSwitch('-delete') then
      begin
        pattern := ParamValue('-delete');
        if pattern <> '' then
          BrickComm.NXTDeleteFile(pattern, True);
      end;
      if ParamSwitch('-defrag') then
      begin
        if not BrickComm.NXTDefragmentFlash then
          WriteLn('Defragmentation failed');
      end;
      if ParamSwitch('-listfiles') then
      begin
        pattern := ParamValue('-listfiles');
        if pattern = '' then
          pattern := '*.*';
        SL.Clear;
        BrickComm.NXTListFiles(pattern, SL);
        for i := 0 to SL.Count - 1 do
          WriteLn(SL[i]);
      end;
      if ParamSwitch('-listmodules') then
      begin
        pattern := ParamValue('-listmodules');
        if pattern = '' then
          pattern := '*.*';
        SL.Clear;
        BrickComm.NXTListModules(pattern, SL);
        for i := 0 to SL.Count - 1 do
          WriteLn(SL[i]);
      end;
      if ParamSwitch('-runningprogram') then
      begin
        if BrickComm.GetCurrentProgramName(pattern) then
          Writeln(pattern);
      end;
      if ParamSwitch('-setname') then
        BrickComm.NXTSetBrickName(ParamValue('-setname'), True);
      if ParamSwitch('-boot') then
        BrickComm.NXTBootCommand(True);
      if ParamSwitch('-btreset') then
        BrickComm.NXTBTFactoryReset(True);
      if ParamSwitch('-versions') then
      begin
        if BrickComm.NXTGetVersions(pmin, pmaj, fmin, fmaj) then
        begin
          Writeln(Format('Protocol version = %d.%d', [pmaj, pmin]));
          Writeln(Format('Firmware version = %d.%2.2d', [fmaj, fmin]));
        end;
      end;
      if ParamSwitch('-deviceinfo') then
      begin
        if BrickComm.NXTGetDeviceInfo(pattern, btaddr, btsig, memFree) then
        begin
          Writeln(Format('Brick name = %s', [pattern]));
          Writeln(Format('Bluetooth Address = %s', [btaddr]));
          Writeln(Format('Bluetooth signal strength = %d,%d,%d,%d',
            [GetByte(btsig, 0), GetByte(btsig, 1), GetByte(btsig, 2), GetByte(btsig, 3)]));
          Writeln(Format('Free memory = %d', [memFree]));
        end;
      end;
      if ParamSwitch('-getname') then
      begin
        if BrickComm.NXTGetDeviceInfo(pattern, btaddr, btsig, memFree) then
          Writeln(pattern);
      end;
      if ParamSwitch('-freemem') then
      begin
        if BrickComm.NXTGetDeviceInfo(pattern, btaddr, btsig, memFree) then
          OutputValue(memFree);
      end;
      if ParamSwitch('-lsstatus') then
      begin
        port := ParamIntValue('-lsstatus', 0);
        if BrickComm.LSGetStatus(Byte(port), bytesReady) then
          OutputValue(bytesReady);
      end;
      if ParamSwitch('-btnstate') then
      begin
        port := ParamIntValue('-btnstate', 0);
        if BrickComm.GetButtonState(Byte(port), False, pressed, btncount) then
          Writeln(Format('Button %d: pressed = %s, count = %d', [port, BoolToStr(pressed), btncount]));
      end;
      if ParamSwitch('-resetbtnstate') then
      begin
        port := ParamIntValue('-resetbtnstate', 0);
        BrickComm.GetButtonState(Byte(port), True, pressed, btncount);
      end;
      if ParamSwitch('-readmsg') then
      begin
        port := ParamIntValue('-readmsg', 0);
        if BrickComm.MessageRead(Byte(port), Byte(ParamIntValue('/Inbox', 0)), ParamSwitch('/Empty'), Msg) then
        begin
          for i := 0 to Msg.Size - 1 do
            OutputValue(Msg.Data[i]);
        end;
      end;
      if (ParamSwitch('-memory') or ParamSwitch('-memory_full')) then
      begin
        if ParamSwitch('-memory_full') then
        begin
          maddr := $0000;
          msize := $8034;
  //        msize := $FFFF;
          SL := BrickComm.PollMemory(maddr, msize);
        end
        else
          SL := BrickComm.PollMemory(ParamIntValue('-memory', 0));
        DumpData(SL);
      end;
      if ParamSwitch('-map') then
      begin
        SL := BrickComm.DownloadMemoryMap;
        for i := 0 to SL.Count - 1 do
          OutputValue(SL[i]);
        if BrickComm.VerboseMode then
          Writeln('');
      end;
      if (ParamSwitch('-datalog') or ParamSwitch('-datalog_full')) then
      begin
        SL := BrickComm.UploadDatalog(ParamSwitch('-datalog_full'));
        DumpData(SL);
      end;
      if not ParamSwitch('/noclose') then
        BrickComm.Close;
    end;
    if not ParamSwitch('/nofree') then
      BrickComm.Free;
  finally
    if ParamSwitch('/debug') then
      WriteLn('Exiting NeXTTool');
  end;
end.
