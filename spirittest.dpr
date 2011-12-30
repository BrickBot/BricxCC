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
 * Copyright (C) 2011 John Hansen.
 * All Rights Reserved.
 *
 *)
program spirittest;

{$APPTYPE CONSOLE}

uses
{$IFNDEF FPC}
  FastMM4,
  FastMove,
{$ENDIF}
  Classes,
  SysUtils,
  Math,
  ParamUtils in 'ParamUtils.pas',
  uVersionInfo in 'uVersionInfo.pas',
  uNXTConstants in 'NXT\uNXTConstants.pas',
  libspirit in 'bricktools\libspirit.pas',
  FantomDefs in 'bricktools\FantomDefs.pas',
  uCommonUtils in 'uCommonUtils.pas',
  uCmdLineUtils in 'uCmdLineUtils.pas';

{$IFNDEF FPC}
{$R *.RES}
{$ENDIF}

var
  SL : TStrings;
  MS : TMemoryStream;
  i, j, src, num : Integer;
  cvalue : cardinal;
// getoutputstate variables
  port, power: integer;
  maddr, msize: integer;
  mode, regmode, runstate: byte;
  modestr, regmodestr, runstatestr : string;
  turnratio: integer;
  tacholimit: cardinal;
  tachocount, blocktachocount, rotationcount: Integer;
// getintputvalues variables
  valid, calibrated: byte;
  stype, smode: byte;
  stypestr, smodestr : string;
  raw, normalized, pc: word;
  scaled, calvalue: smallint;
// misc variables
  pattern : string;
  pmin, pmaj, fmin, fmaj, bytesReady, lsstate : byte;
  btaddr : string;
  btsig : cardinal;
  memFree : Cardinal;
  pressed : byte;
  btncount, state, clump : byte;
  i2csend, rawcmd, tmpstr : string;
  LSBlock : NXTLSBlock;
  Msg : NXTMessage;
  BCHandle : FantomHandle;
  buf, tmpbuf1 : PChar;


procedure OutputValue(val : integer; bNewLine : boolean = True); overload;
const
  HEX_FMT : array[Boolean] of string = ('%4.2x', '%4.4x');
begin
  if ParamSwitch('/HEX') then
  begin
    if bNewLine then
      Writeln(Format(HEX_FMT[val > $FF], [val]))
    else
      Write(Format(HEX_FMT[val > $FF], [val]));
  end
  else
  begin
    if bNewLine then
      Writeln(val)
    else
      Write(val);
  end;
end;

procedure OutputValue(str : string; bNewLine : boolean = True); overload;
begin
  OutputValue(StrToIntDef(str, 0), bNewLine);
end;

{$I spirittest_preproc.inc}

procedure PrintUsage;
begin
  PrintVersion(COMPILATION_TIMESTAMP);
  Writeln('Usage: ' + progName + ' [options] [actions]');
  Writeln('Options:');
  Writeln('   /COM=port: specify port name (usb, resource string, or alias)');
  Writeln('   /HEX: use hexadecimal for numeric output');
  Writeln('   /Duration=<n>: specify the tone duration for the playtone action');
  Writeln('   /Inbox=<n>: use inbox number n when sending or reading a message');
  Writeln('   /Loop: loop when playing sound files');
  Writeln('   /Relative: reset output position relative');
  Writeln('   /Empty: empty mailbox when reading');
  Writeln('   /Bin[=filename]: dump data output as binary to a file (nxt.bin)');
  Writeln('   /Power=<n>: output power level (-100..100)');
  Writeln('   /Mode=<n>: output mode (COAST=0, MOTORON=1, BRAKE=2, REGULATED=4)');
  Writeln('   /RegMode=<n>: output regulation mode (IDLE=0, SPEED=1, SYNC=2)');
  Writeln('   /RunState=<n>: output run state (IDLE=0, RAMPUP=16, RUNNING=32, RAMPDOWN=64)');
  Writeln('   /TurnRatio=<n>: output turn ratio (-100..100)');
  Writeln('   /TachoLimit=<n>: output tachometer limit (0..MaxInt)');
  Writeln('   /SensorType=<n>: sensor type (0..17)');
  Writeln('   /SensorMode=<n>: sensor mode (0, 32, 64, 96, 128, 160, 192, 224)');
  Writeln('Actions:');
  Writeln('   -init : initialize nxt.dat file');
  Writeln('   -listbricks : list resource names of all found NXT bricks');
  Writeln('   -clear : erase all items on the brick');
  Writeln('   -battery : return the battery level');
  Writeln('   -input=<N> : read input N (0-3)');
  Writeln('   -output=<N> : read the status of output N (0-2)');
  Writeln('   -setinput=<N> : configure input N (0-3)');
  Writeln('   -setoutput=<N> : configure output N (0-2)');
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
//  Writeln('   -datalog | -datalog_full: upload datalog (_full == verbose)');
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
  Writeln('   -i2cbytes=<data> : send/receive I2C data');
  Writeln('   -lsstatus=<port> : return the low speed status for the specified port');
  Writeln('   -sendraw=<cmd> : send a direct or system command (comma-separated hex bytes)');
  Writeln('   -resetbtnstate=<btn> : reset the button state for the specified button');
  Writeln('   -boot : reset the NXT into SAMBA mode');
  Writeln('   -btreset : reset the NXT bluetooth to factory settings (usb only)');
  Writeln('   -defrag : defragment the NXT filesystem');
  Writeln('   -shutdown : turn off the NXT');
  Writeln('   -motorson=<motorlist> : Turn on the specified motors');
  Writeln('   -motorsoff=<motorlist> : Turn off the specified motors');
  Writeln('   -motorsfloat=<motorlist> : Float the specified motors');
  Writeln('   -setfwd=<motorlist> : Set the motor direction to forward');
  Writeln('   -setrwd=<motorlist> : Set the motor direction to reverse');
  Writeln('   -switchdir=<motorlist> : Switch the motor direction');
  Writeln('   -setmotorpower=<motorlist,pwr> : Set the motor power');
  Writeln('   -poll=<src,num> : Poll the specified src and number');
  Writeln('   -getoutputstatus=<out> : Get the output status');
  Writeln('   -getvariablevalue=<var> : Get the variable value');
  Writeln('   -getinputvalue=<input> : Get the input value');
  Writeln('   -gettimervalue=<num> : Get the timer value');
  Writeln('   -polleeprom=<block> : Poll eeprom block');
  Writeln('   -setvmstate=<state> : Set the VM state (enhanced firmware only)');
  Writeln('   -getvmstate : Get the VM state (enhanced firmware only)');
{
NXTPollCommandLen
NXTPollCommand
NXTWriteIOMap
NXTReadIOMap
    function NXTSetPropDebugging(const debugging : boolean; const pauseClump : byte; const pausePC : Word) : boolean; override;
    function NXTGetPropDebugging(var debugging : boolean; var pauseClump : byte; var pausePC : Word) : boolean; override;
    function NXTSetVMStateEx(var state : byte; var clump : byte; var pc : word) : boolean; override;
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
    Writeln('');
  end;
end;

begin
{$IFDEF FPC}
  VerCompanyName      := 'JoCar Consulting';
  VerFileDescription  := '';
  VerFileVersion      := '1.2.1.r5';
  VerInternalName     := 'spirittest';
  VerLegalCopyright   := 'Copyright (c) 2006-2011, John Hansen';
  VerOriginalFileName := 'spirittest';
  VerProductName      := 'spirittest';
  VerProductVersion   := '1.2';
  VerComments         := '';
{$ENDIF}

  valid := 0;
  calibrated := 0;
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
  pressed := 0;
  Msg.Inbox:= 0;
  btaddr := '';

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

  SL := TStringList.Create;
  try
    BCHandle := FantomSpiritCreate();

    if ParamSwitch('-init') then
    begin
      FantomSpiritSetSearchBluetooth(BCHandle, ParamIntValue('-init', 1));
      FantomSpiritNXTInitializeResourceNames(BCHandle);
      Exit;
    end;
    if ParamSwitch('-update') then
    begin
      FantomSpiritSetSearchBluetooth(BCHandle, ParamIntValue('-update', 1));
      FantomSpiritNXTUpdateResourceNames(BCHandle);
      Exit;
    end;
    if ParamSwitch('-listbricks') then
    begin
      SL.Clear;
      FantomSpiritSetSearchBluetooth(BCHandle, ParamIntValue('-listbricks', 1));
      buf := AllocMem(10000);
      try
        FantomSpiritNXTListBricks(BCHandle, buf);
        SL.Text := String(buf);
      finally
        FreeMem(buf, 10000);
      end;
      for i := 0 to SL.Count - 1 do
        WriteLn(SL[i]);
      Exit;
    end;
    if ParamSwitch('/COM') then
      FantomSpiritSetPort(BCHandle, PChar(ParamValue('/COM')))
    else
      FantomSpiritSetPort(BCHandle, 'usb');
    if ParamSwitch('-firmware') then
    begin
      j := ParamIntValue('-iterations', 1, False);
      for i := 0 to j - 1 do
      begin
        FantomSpiritDownloadFirmware(BCHandle, PChar(ParamValue('-firmware')), 0, 0, 0);
        if j > 1 then
          WriteLn(Format('%d of %d', [i+1, j]));
      end;
    end;
    if FantomSpiritOpen(BCHandle) <> 0 then
    begin
      if ParamSwitch('-clear') then
        FantomSpiritClearMemory(BCHandle);
      if ParamSwitch('-sleep') then
        FantomSpiritSleep(BCHandle, ParamIntValue('-sleep', 10));
      if ParamSwitch('-msg') then
      begin
        FantomSpiritNXTMessageWrite(BCHandle, Byte(ParamIntValue('/Inbox', 0)), PChar(ParamValue('-msg')));
      end;
      if ParamSwitch('-battery') then
        OutputValue(FantomSpiritBatteryLevel(BCHandle));
      if ParamSwitch('-input') then
      begin
        port := ParamIntValue('-input', 0);
        if FantomSpiritGetNXTInputValues(BCHandle, Byte(port), valid, calibrated,
          stype, smode, raw, normalized, scaled, calvalue) <> 0 then
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
                         [port, IntToStr(valid),
                          IntToStr(calibrated),
                          stype, NXTInputTypeToStr(stype),
                          smode, NXTInputModeToStr(smode),
                          raw, normalized, scaled, calvalue]));
        end;
      end;
      if ParamSwitch('-setinput') then
      begin
        port := ParamIntValue('-setinput', 0);
        stypestr := ParamValue('/SensorType');
        if stypestr <> '' then
          stype := StrToNXTInputType(stypestr);
        smodestr := ParamValue('/SensorMode');
        if smodestr <> '' then
          smode := StrToNXTInputMode(smodestr);
        FantomSpiritSetNXTInputMode(BCHandle, Byte(port), stype, smode);
      end;
      if ParamSwitch('-output') then
      begin
        port := ParamIntValue('-output', 0);
        if FantomSpiritGetNXTOutputState(BCHandle, Byte(port), power, mode,
          regmode, turnratio, runstate, tacholimit, tachocount, blocktachocount,
          rotationcount) <> 0 then
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
      if ParamSwitch('-setoutput') then
      begin
        port := ParamIntValue('-setoutput', 0);
        power := ParamIntValue('/Power', power);
        modestr := ParamValue('/Mode');
        if modestr <> '' then
          mode := StrToNXTOutputMode(modestr);
        regmodestr := ParamValue('/RegMode');
        if regmodestr <> '' then
          regmode := StrToNXTOutputRegMode(regmodestr);
        runstatestr := ParamValue('/RunState');
        if runstatestr <> '' then
          runstate := StrToNXTOutputRunState(runstatestr);
        turnratio := ParamIntValue('/TurnRatio', turnratio);
        tacholimit := ParamIntValue('/TachoLimit', tacholimit);
        FantomSpiritSetNXTOutputState(BCHandle, Byte(port), power, mode,
          regmode, turnratio, runstate, tacholimit);
      end;
      if ParamSwitch('-mute') then
        FantomSpiritMuteSound(BCHandle);
      if ParamSwitch('-playtone') then
        FantomSpiritPlayTone(BCHandle, Word(ParamIntValue('-playtone', 440)), Word(ParamIntValue('/Duration', 500)));
      if ParamSwitch('-stop') then
        FantomSpiritNXTStopProgram(BCHandle);
      if ParamSwitch('-playfile') then
        FantomSpiritNXTPlaySoundFile(BCHandle, PChar(ParamValue('-playfile')), Ord(ParamSwitch('/Loop')));
      if ParamSwitch('-keepalive') then
      begin
        if FantomSpiritNXTKeepAlive(BCHandle, cvalue, 0) <> 0 then
          OutputValue(cvalue div 60000);
      end;
      if ParamSwitch('-resetoutputposition') then
        FantomSpiritNXTResetOutputPosition(BCHandle, Byte(ParamIntValue('-resetoutputposition', 0)), Ord(ParamSwitch('/Relative')));
      if ParamSwitch('-resetinputsv') then
        FantomSpiritNXTResetInputScaledValue(BCHandle, Byte(ParamIntValue('-resetinputsv', 0)));
      if ParamSwitch('-upload') then
      begin
        pattern := ParamValue('-upload');
        if pattern = '' then
          pattern := '*.*';
        FantomSpiritNXTUploadFile(BCHandle, PChar(pattern), '');
      end;
      if ParamSwitch('-download') then
      begin
        pattern := ParamValue('-download');
        if pattern <> '' then
          FantomSpiritNXTDownloadFile(BCHandle, PChar(pattern), NameToNXTFileType(PChar(pattern)));
      end;
      if ParamSwitch('-run') then begin
        FantomSpiritNXTStartProgram(BCHandle, PChar(ParamValue('-run')));
      end;
      if ParamSwitch('-delete') then
      begin
        pattern := ParamValue('-delete');
        if pattern <> '' then
          FantomSpiritNXTDeleteFile(BCHandle, PChar(pattern), 1);
      end;
      if ParamSwitch('-defrag') then
      begin
        if FantomSpiritNXTDefragmentFlash(BCHandle) = 0 then
          WriteLn('Defragmentation failed');
      end;
      if ParamSwitch('-listfiles') then
      begin
        pattern := ParamValue('-listfiles');
        if pattern = '' then
          pattern := '*.*';
        SL.Clear;
        buf := AllocMem(10000);
        try
          FantomSpiritNXTListFiles(BCHandle, PChar(pattern), buf);
          SL.Text := String(buf);
        finally
          FreeMem(buf, 10000);
        end;
        for i := 0 to SL.Count - 1 do
          WriteLn(SL[i]);
      end;
      if ParamSwitch('-listmodules') then
      begin
        pattern := ParamValue('-listmodules');
        if pattern = '' then
          pattern := '*.*';
        SL.Clear;
        buf := AllocMem(10000);
        try
          FantomSpiritNXTListModules(BCHandle, PChar(pattern), buf);
          SL.Text := String(buf);
        finally
          FreeMem(buf, 10000);
        end;
        for i := 0 to SL.Count - 1 do
          WriteLn(SL[i]);
      end;
      if ParamSwitch('-runningprogram') then
      begin
        buf := AllocMem(256);
        try
          if FantomSpiritNXTGetCurrentProgramName(BCHandle, buf) <> 0 then
          begin
            pattern := String(buf);
            Writeln(pattern);
          end;
        finally
          FreeMem(buf, 256);
        end;
      end;
      if ParamSwitch('-setname') then
        FantomSpiritNXTSetBrickName(BCHandle, PChar(ParamValue('-setname')), 1);
      if ParamSwitch('-boot') then
        FantomSpiritNXTBootCommand(BCHandle, 1);
      if ParamSwitch('-btreset') then
        FantomSpiritNXTBTFactoryReset(BCHandle, 1);
      if ParamSwitch('-versions') then
      begin
        if FantomSpiritNXTGetVersions(BCHandle, pmin, pmaj, fmin, fmaj) <> 0 then
        begin
          Writeln(Format('Protocol version = %d.%d', [pmaj, pmin]));
          Writeln(Format('Firmware version = %d.%2.2d', [fmaj, fmin]));
        end;
      end;
      if ParamSwitch('-deviceinfo') then
      begin
        buf := AllocMem(256);
        try
          tmpbuf1 := AllocMem(256);
          try
            if FantomSpiritNXTGetDeviceInfo(BCHandle, buf, tmpbuf1, btsig, memFree) <> 0 then
            begin
              pattern := String(buf);
              btaddr  := String(tmpbuf1);
              Writeln(Format('Brick name = %s', [pattern]));
              Writeln(Format('Bluetooth Address = %s', [btaddr]));
              Writeln(Format('Bluetooth signal strength = %d,%d,%d,%d',
                [GetByte(btsig, 0), GetByte(btsig, 1), GetByte(btsig, 2), GetByte(btsig, 3)]));
              Writeln(Format('Free memory = %d', [memFree]));
            end;
          finally
            FreeMem(tmpbuf1, 256);
          end;
        finally
          FreeMem(buf, 256);
        end;
      end;
      if ParamSwitch('-getname') then
      begin
        buf := AllocMem(256);
        try
          FantomSpiritNXTGetBrickName(BCHandle, buf);
          pattern := String(buf);
          Writeln(pattern);
        finally
          FreeMem(buf, 256);
        end;
      end;
      if ParamSwitch('-freemem') then
      begin
        buf := AllocMem(256);
        try
          tmpbuf1 := AllocMem(256);
          try
            if FantomSpiritNXTGetDeviceInfo(BCHandle, buf, tmpbuf1, btsig, memFree) <> 0 then
            begin
              OutputValue(memFree);
            end;
          finally
            FreeMem(tmpbuf1, 256);
          end;
        finally
          FreeMem(buf, 256);
        end;
      end;
      if ParamSwitch('-i2cbytes') then
      begin
        i2csend := ParamValue('-i2cbytes'); // port,cnt,bytes
        // get port
        i := Pos(',', i2csend);
        if i > 0 then
        begin
          port := StrToIntDef(Copy(i2csend, 1, i-1), 0);
          System.Delete(i2csend, 1, i); // delete up to and including comma
          // get count of bytes to read
          i := Pos(',', i2csend);
          if i > 0 then
          begin
            j := StrToIntDef(Copy(i2csend, 1, i-1), 0);
            System.Delete(i2csend, 1, i);
            // everything left should be comma-separated list of bytes to send
            LoadLSBlock(LSBlock, PChar(i2csend), j);
            FantomSpiritSetNXTLowSpeed(BCHandle, port, LSBlock);
            FantomSpiritGetNXTLowSpeed(BCHandle, port, LSBlock);
            for i := 0 to j - 1 do
            begin
              OutputValue(LSBlock.Data[i], False);
              Write(' ');
            end;
            WriteLn('');
          end;
        end;
      end;
      if ParamSwitch('-lsstatus') then
      begin
        port := ParamIntValue('-lsstatus', 0);
        if FantomSpiritNXTLSGetStatus(BCHandle, Byte(port), bytesReady, lsstate) <> 0 then
        begin
          OutputValue(bytesReady, False); Write(' ');
          OutputValue(lsstate);
        end;
      end;
      if ParamSwitch('-sendraw') then
      begin
        rawcmd := ParamValue('-sendraw');
        if rawcmd <> '' then
        begin
          buf := AllocMem(1024);
          try
            FantomSpiritSendRawCommand(BCHandle, PChar(rawcmd), 0, buf);
            rawcmd := String(buf);
          finally
            FreeMem(buf, 1024);
          end;
          WriteLn(rawcmd);
        end;
      end;
{ // button state direct command is not implemented
      if ParamSwitch('-btnstate') then
      begin
        port := ParamIntValue('-btnstate', 0);
        if FantomSpiritNXTGetButtonState(Byte(port), False, pressed, btncount) then
          Writeln(Format('Button %d: pressed = %s, count = %d', [port, BoolToStr(pressed), btncount]));
      end;
}
      if ParamSwitch('-resetbtnstate') then
      begin
        port := ParamIntValue('-resetbtnstate', 0);
        FantomSpiritNXTGetButtonState(BCHandle, Byte(port), 1, pressed, btncount);
      end;
      if ParamSwitch('-readmsg') then
      begin
        port := ParamIntValue('-readmsg', 0);
        if FantomSpiritNXTMessageRead(BCHandle, Byte(port), Byte(ParamIntValue('/Inbox', 0)), Ord(ParamSwitch('/Empty')), Msg) <> 0 then
        begin
          for i := 0 to Msg.Size - 1 do
            OutputValue(Msg.Data[i]);
        end;
      end;
      if ParamSwitch('-memory') or ParamSwitch('-memory_full') then
      begin
        if ParamSwitch('-memory_full') then
        begin
          maddr := $0000;
//          msize := $8034;
          msize := 8192;
          buf := AllocMem(msize+1);
          try
            FantomSpiritPollMemory(BCHandle, maddr, msize, buf);
            MS := TMemoryStream.Create;
            try
              MS.Write(buf^, msize);
              MS.Position := 0;
              SL.LoadFromStream(MS);
            finally
              MS.Free;
            end;
          finally
            FreeMem(buf, msize+1);
          end;
        end
        else
        begin
          buf := AllocMem(129);
          try
            FantomSpiritPollMemory(BCHandle, ParamIntValue('-memory', 0), 128, buf);
            SL.Text := String(buf);
          finally
            FreeMem(buf, 129);
          end;
        end;
        DumpData(SL);
      end;
      if ParamSwitch('-map') then
      begin
        buf := AllocMem(10000);
        try
          FantomSpiritDownloadMemoryMap(BCHandle, buf);
          SL.Text := String(buf);
        finally
          FreeMem(buf, 10000);
        end;
        for i := 0 to SL.Count - 1 do
          OutputValue(SL[i]);
        Writeln('');
      end;
      if ParamSwitch('-motorson') then
        FantomSpiritMotorsOn(BCHandle, ParamIntValue('-motorson', 0));
      if ParamSwitch('-motorsoff') then
        FantomSpiritMotorsOff(BCHandle, ParamIntValue('-motorsoff', 0));
      if ParamSwitch('-motorsfloat') then
        FantomSpiritMotorsFloat(BCHandle, ParamIntValue('-motorsfloat', 0));
      if ParamSwitch('-setfwd') then
        FantomSpiritSetFwd(BCHandle, ParamIntValue('-setfwd', 0));
      if ParamSwitch('-setrwd') then
        FantomSpiritSetRwd(BCHandle, ParamIntValue('-setrwd', 0));
      if ParamSwitch('-switchdir') then
        FantomSpiritSwitchDirection(BCHandle, ParamIntValue('-switchdir', 0));
      if ParamSwitch('-setmotorpower') then
      begin
        tmpstr := ParamValue('-setmotorpower');
        power := 0;
        i := Pos(',', tmpstr);
        if i > 0 then
        begin
          src := StrToIntDef(Copy(tmpstr, 1, i-1), 0);
          System.Delete(tmpstr, 1, i);
          power := StrToIntDef(tmpstr, 0);
        end
        else
          src := StrToIntDef(tmpstr, 0);
        FantomSpiritSetMotorPower(BCHandle, src, 2, power); // kRCX_ConstantType
      end;
      if ParamSwitch('-poll') then
      begin
        tmpstr := ParamValue('-poll');
        num := 0;
        i := Pos(',', tmpstr);
        if i > 0 then
        begin
          src := StrToPollSourceIndex(Copy(tmpstr, 1, i-1));
          System.Delete(tmpstr, 1, i);
          num := StrToIntDef(tmpstr, 0);
        end
        else
          src := StrToIntDef(tmpstr, 0);
        buf := AllocMem(256);
        try
          FantomSpiritPoll(BCHandle, src, num, buf);
          tmpstr := String(buf);
          WriteLn(tmpstr);
        finally
          FreeMem(buf, 256);
        end;
      end;
      if ParamSwitch('-getoutputstatus') then
        OutputValue(FantomSpiritGetOutputStatus(BCHandle, ParamIntValue('-getoutputstatus', 0)));
      if ParamSwitch('-getvariablevalue') then
      begin
        buf := AllocMem(256);
        try
          FantomSpiritGetVariableValue(BCHandle, ParamIntValue('-getvariablevalue', 0), buf);
          tmpstr := String(buf);
        finally
          FreeMem(buf, 256);
        end;
        OutputValue(tmpstr);
      end;
      if ParamSwitch('-getinputvalue') then
        OutputValue(FantomSpiritGetInputValue(BCHandle, ParamIntValue('-getinputvalue', 0)));
      if ParamSwitch('-gettimervalue') then
        OutputValue(FantomSpiritGetTimerValue(BCHandle, ParamIntValue('-gettimervalue', 0)));
      if ParamSwitch('-polleeprom') then
      begin
        buf := AllocMem(10000);
        try
          FantomSpiritPollEEPROM(BCHandle, ParamIntValue('-polleeprom', 0), buf);
          SL.Text := String(buf);
        finally
          FreeMem(buf, 10000);
        end;
        DumpData(SL);
      end;
      if ParamSwitch('-setvmstate') then
      begin
        FantomSpiritNXTSetVMState(BCHandle, ParamIntValue('-setvmstate', 0));
      end;
      if ParamSwitch('-getvmstate') then
      begin
        FantomSpiritNXTGetVMState(BCHandle, state, clump, pc);
        OutputValue(state, False); Write(' ');
        OutputValue(clump, False); Write(' ');
        OutputValue(pc);
      end;
      if ParamSwitch('-shutdown') then
        FantomSpiritShutdown(BCHandle);
      if not ParamSwitch('/noclose') then
        FantomSpiritClose(BCHandle);
    end;
    if not ParamSwitch('/nofree') then
      FantomSpiritDestroy(BCHandle);
  finally
    if ParamSwitch('/debug') then
      WriteLn('Exiting spirittest');
  end;
end.
