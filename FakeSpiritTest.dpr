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
program FakeSpiritTest;

{$APPTYPE CONSOLE}

uses
  Classes,
  ParamUtils,
  SysUtils,
  Dialogs,
  Math,
  uSpirit in 'bricktools\uSpirit.pas',
  brick_common in 'bricktools\brick_common.pas',
  uVersionInfo in 'uVersionInfo.pas';

{$R *.RES}

type
  TRCXTool = class
  public
    procedure HandleDownloadStatus(Sender : TObject; cur, total : Integer; var Abort : Boolean);
    procedure HandleDownloadDone(Sender : TObject);
  end;

var
  remoteRepeat : integer;
  SL : TStrings;
  i : Integer;
  rcxTool : TRCXTool;

function progName : string;
begin
  Result := ExtractFileName(ParamStr(0));
  Result := Copy(Result, 1, Length(Result)-4);
end;

procedure PrintVersion;
var
  V : TVersionInfo;
  TFS : TFileStream;
  s, app : string;
begin
  app := ParamStr(0);
  TFS := TFileStream.Create(app, fmOpenRead or fmShareDenyNone);
  try
    s := FormatDateTime('mmm dd yyyy hh:mm:ss',FileDateToDateTime(FileGetDate(TFS.Handle)));
  finally
    TFS.Free;
  end;
  V := GetVersionInfo(app);
  WriteLn(V.ProductName + ' version ' + V.ProductVersion + ' (' +  V.FileVersion + ', built ' + s + ')');
  Writeln('     ' + V.LegalCopyright);
end;

procedure PrintUsageError;
begin
  PrintVersion;
  WriteLn('Use "' + progName + ' -help" for more information.');
end;

procedure PrintUsage;
begin
  PrintVersion;
  WriteLn('Usage: ' + progName + ' [options] [actions]');
  WriteLn('Options:');
  WriteLn('   /RCX=n: target can be RCX (0), Cybermaster (1), Scout (2), RCX2 (3), SpyBot (4), Swan (5), or NXT (6)');
  WriteLn('   /COM=name: specify port');
  WriteLn('   /RPT=n: specify remote repeat count');
  WriteLn('   /T=n: specify transmit timeout value');
  WriteLn('   /V: specify verbose mode');
//  WriteLn('   /F: specify fast mode');
  WriteLn('Actions:');
  WriteLn('   -run: run current program');
  WriteLn('   -pgm=n: select program number');
  WriteLn('   -datalog | -datalog_full: upload datalog (_full == verbose)');
  WriteLn('   -near : set IR to near mode');
  WriteLn('   -far : set IR to far mode');
  WriteLn('   -firmware=filename : download firmware');
  WriteLn('   -firmfast=filename : download firmware at quad speed');
  WriteLn('   -watch=<HHMM|now> : set RCX time');
  WriteLn('   -sleep=<timeout> : set RCX sleep timeout');
  WriteLn('   -msg=<number> : send IR message to RCX');
  WriteLn('   -raw=<data> : format data as a packet and send to RCX');
  WriteLn('   -remote=<value> : send a remote command to RCX');
  WriteLn('   -scout=<0|1> : put Scout into normal or power mode');
  WriteLn('   -clear : erase all programs and datalog in RCX');
  Writeln('   -input=<N> : read input N (0-2)');
  Writeln('   -output=<N> : read the status of output N (0-2)');
  Writeln('   -var=<N> : read the value of variable N (0-31)');
  Writeln('   -timer=<N> : read the value of timer N (0-3)');
  Writeln('   -counter=<N> : read the value of timer N (0-2)');
  Writeln('   -msgVal : read the current message');
  Writeln('   -incCounter=N : increment counter N');
  Writeln('   -decCounter=N : increment counter N');
  WriteLn('   -help : display command line options');
end;

{ TRCXTool }

procedure TRCXTool.HandleDownloadStatus(Sender: TObject; cur,
  total: Integer; var Abort: Boolean);
begin
  Write('.');
end;

procedure TRCXTool.HandleDownloadDone(Sender : TObject);
begin
  WriteLn('done');
end;

begin

  remoteRepeat := 1;

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

  rcxTool := TRCXTool.Create;
  try
    SL := BrickComm.DataLog;
    BrickComm.OnDownloadStatus := rcxTool.HandleDownloadStatus;
    BrickComm.OnDownloadDone   := rcxTool.HandleDownloadDone;

    if ParamSwitch('/RPT') then
      remoteRepeat := StrToIntDef(ParamValue('/RPT'), 1);
    if ParamSwitch('/COM') then
      BrickComm.Port := ParamValue('/COM');
    if ParamSwitch('/RCX') then
      BrickComm.BrickType := StrToIntDef(ParamValue('/RCX'), 0);
    BrickComm.VerboseMode := ParamSwitch('/V');
  //  BrickComm.FastMode := ParamSwitch('/F');
    if ParamSwitch('/T') then
      BrickComm.RxTimeout := StrToIntDef(ParamValue('/T'), 1000);
    if ParamSwitch('-scout') then
      BrickComm.ScoutNum(StrToIntDef(ParamValue('-scout'), 1));
    if ParamSwitch('-datalog') or ParamSwitch('-datalog_full') then
    begin
      SL := BrickComm.UploadDatalog(ParamSwitch('-datalog_full'));
      for i := 0 to SL.Count - 1 do
        Writeln(SL[i]);
      if BrickComm.VerboseMode then
        Writeln('');
    end;
    if ParamSwitch('-clear') then
      BrickComm.ClearMemory;
    if ParamSwitch('-near') then
      BrickComm.TransmitPower(tlNear);
    if ParamSwitch('-far') then
      BrickComm.TransmitPower(tlFar);
    if ParamSwitch('-firmware') then
      BrickComm.DownloadFirmware(ParamValue('-firmware'), False, True, True);
    if ParamSwitch('-firmfast') then
      BrickComm.DownloadFirmware(ParamValue('-firmfast'), True, True, True);
    if ParamSwitch('-watch') then
      BrickComm.SetWatch(ParamValue('-watch'));
    if ParamSwitch('-sleep') then
      BrickComm.Sleep(StrToIntDef(ParamValue('-sleep'), 10));
    if ParamSwitch('-run') then
      BrickComm.StartTask(StrToIntDef(ParamValue('-run'), 0));
    if ParamSwitch('-pgm') then
      BrickComm.SelectProgram(StrToIntDef(ParamValue('-pgm'), 1));
    if ParamSwitch('-msg') then
      BrickComm.SendMessage(StrToIntDef(ParamValue('-msg'), 0));
    if ParamSwitch('-raw') then
      Writeln(BrickComm.SendRawCommand(ParamValue('-raw'), true));
    if ParamSwitch('-raw1') then
      BrickComm.SendRawCommand(ParamValue('-raw1'), false);
    if ParamSwitch('-remote') then
      BrickComm.SendRemoteStr(ParamValue('-remote'), remoteRepeat);
    if ParamSwitch('-battery') then
      Writeln(BrickComm.BatteryLevel);
    if ParamSwitch('-input') then
      Writeln(BrickComm.GetInputValue(ParamIntValue('-input', 0)));
    if ParamSwitch('-output') then
      Writeln(BrickComm.GetOutputStatus(ParamIntValue('-output', 0)));
    if ParamSwitch('-var') then
      Writeln(BrickComm.GetVariableValue(ParamIntValue('-var', 0)));
    if ParamSwitch('-timer') then
      Writeln(BrickComm.GetTimerValue(ParamIntValue('-timer', 0)));
    if ParamSwitch('-counter') then
      Writeln(BrickComm.GetCounterValue(ParamIntValue('-counter', 0)));
    if ParamSwitch('-msgVal') then
      Writeln(BrickComm.GetMessageValue(0));
    if ParamSwitch('-incCounter') then
      BrickComm.IncCounter(ParamIntValue('-incCounter', 0));
    if ParamSwitch('-decCounter') then
      BrickComm.DecCounter(ParamIntValue('-decCounter', 0));

    if BrickComm.VerboseMode then
    begin
      SL.Text := BrickComm.LinkLog;
      for i := 0 to SL.Count - 1 do
        Writeln(SL[i]);
    end;
  finally
    FreeAndNil(rcxTool);
  end;
end.