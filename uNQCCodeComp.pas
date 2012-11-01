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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uNQCCodeComp;

interface

uses
  Classes;

function NQCCodeCompIndex(aName : string) : Integer;
procedure AddNQCCodeCompParams(aStrings : TStrings; Index : integer);

implementation

uses
  uCppCode;

type
  TNQCCodeComp = record
    Name : string;
    Params : string;
  end;

const
  NQCCodeCompDataSize = 171-28+97+92; // 310
  NQCCodeCompData: array[0..NQCCodeCompDataSize-1] of TNQCCodeComp = (
    (
     Name: 'abs';
     Params: '(const int &x)'
    ),
    (
     Name: 'sign';
     Params: '(const int &x)'
    ),
    (
     Name: 'SetSensor';
     Params: '(__sensor sensor, const int configuration)'
    ),
    (
     Name: 'SetSensorType';
     Params: '(__sensor sensor, const int type)'
    ),
    (
     Name: 'SetSensorMode';
     Params: '(__sensor sensor, const int mode)'
    ),
    (
     Name: 'ClearSensor';
     Params: '(__sensor sensor)'
    ),
    (
     Name: 'SensorValue';
     Params: '(const int n)'
    ),
    (
     Name: 'SensorType';
     Params: '(const int n)'
    ),
    (
     Name: 'SensorMode';
     Params: '(const int n)'
    ),
    (
     Name: 'SensorValueBool';
     Params: '(const int n)'
    ),
    (
     Name: 'SensorValueRaw';
     Params: '(const int n)'
    ),
    (
     Name: 'SetSensorLowerLimit';
     Params: '(const int &value)'
    ),
    (
     Name: 'SetSensorUpperLimit';
     Params: '(const int &value)'
    ),
    (
     Name: 'SetSensorHysteresis';
     Params: '(const int &value)'
    ),
    (
     Name: 'CalibrateSensor';
     Params: '()'
    ),
    (
     Name: 'SetOutput';
     Params: '(const int outputs, const int mode)'
    ),
    (
     Name: 'SetDirection';
     Params: '(const int outputs, const int direction)'
    ),
    (
     Name: 'SetPower';
     Params: '(const int outputs, const int &power)'
    ),
    (
     Name: 'OutputStatus';
     Params: '(const int n)'
    ),
    (
     Name: 'On';
     Params: '(const int outputs)'
    ),
    (
     Name: 'Off';
     Params: '(const int outputs)'
    ),
    (
     Name: 'Float';
     Params: '(const int outputs)'
    ),
    (
     Name: 'Fwd';
     Params: '(const int outputs)'
    ),
    (
     Name: 'Rev';
     Params: '(const int outputs)'
    ),
    (
     Name: 'Toggle';
     Params: '(const int outputs)'
    ),
    (
     Name: 'OnFwd';
     Params: '(const int outputs)'
    ),
    (
     Name: 'OnRev';
     Params: '(const int outputs)'
    ),
    (
     Name: 'OnFor';
     Params: '(const int outputs, const int &time)'
    ),
    (
     Name: 'SetGlobalOutput';
     Params: '(const int outputs, const int mode)'
    ),
    (
     Name: 'SetGlobalDirection';
     Params: '(const int outputs, const int direction)'
    ),
    (
     Name: 'SetMaxPower';
     Params: '(const int outputs, const int &power)'
    ),
    (
     Name: 'EnableOutput';
     Params: '(const int outputs)'
    ),
    (
     Name: 'DisableOutput';
     Params: '(const int outputs)'
    ),
    (
     Name: 'InvertOutput';
     Params: '(const int outputs)'
    ),
    (
     Name: 'ObvertOutput';
     Params: '(const int outputs)'
    ),
    (
     Name: 'GlobalOutputStatus';
     Params: '(const int n)'
    ),
    (
     Name: 'PlaySound';
     Params: '(const int &sound)'
    ),
    (
     Name: 'PlayTone';
     Params: '(const int &frequency, const int duration)'
    ),
    (
     Name: 'MuteSound';
     Params: '()'
    ),
    (
     Name: 'UnmuteSound';
     Params: '()'
    ),
    (
     Name: 'ClearSound';
     Params: '()'
    ),
    (
     Name: 'SelectSounds';
     Params: '(const int group)'
    ),
    (
     Name: 'SelectDisplay';
     Params: '(const int &mode)'
    ),
    (
     Name: 'SetUserDisplay';
     Params: '(const int &value, const int precision)'
    ),
    (
     Name: 'Message';
     Params: '()'
    ),
    (
     Name: 'ClearMessage';
     Params: '()'
    ),
    (
     Name: 'SendMessage';
     Params: '(const int &message)'
    ),
    (
     Name: 'SetTxPower';
     Params: '(const int power)'
    ),
    (
     Name: 'SetSerialComm';
     Params: '(const int &settings)'
    ),
    (
     Name: 'SetSerialData';
     Params: '(const int n, const int &data)'
    ),
    (
     Name: 'SetSerialPacket';
     Params: '(const int &settings)'
    ),
    (
     Name: 'SerialComm';
     Params: '()'
    ),
    (
     Name: 'SerialData';
     Params: '(const int n)'
    ),
    (
     Name: 'SerialPacket';
     Params: '()'
    ),
    (
     Name: 'SendSerial';
     Params: '(const int start, const int count)'
    ),
    (
     Name: 'SendVLL';
     Params: '(const int &value)'
    ),
    (
     Name: 'SetMessage';
     Params: '(const int message)'
    ),
    (
     Name: 'ClearTimer';
     Params: '(const int n)'
    ),
    (
     Name: 'Timer';
     Params: '(const int n)'
    ),
    (
     Name: 'SetTimer';
     Params: '(const int n, const int &value)'
    ),
    (
     Name: 'FastTimer';
     Params: '(const int n)'
    ),
    (
     Name: 'ClearCounter';
     Params: '(const int n)'
    ),
    (
     Name: 'IncCounter';
     Params: '(const int n)'
    ),
    (
     Name: 'DecCounter';
     Params: '(const int n)'
    ),
    (
     Name: 'Counter';
     Params: '(const int n)'
    ),
    (
     Name: 'SetPriority';
     Params: '(const int p)'
    ),
    (
     Name: 'ActiveEvents';
     Params: '(const int task)'
    ),
    (
     Name: 'CurrentEvents';
     Params: '()'
    ),
    (
     Name: 'Event';
     Params: '(const int &events)'
    ),
    (
     Name: 'SetEvent';
     Params: '(event, source, type)'
    ),
    (
     Name: 'ClearEvent';
     Params: '(const int event)'
    ),
    (
     Name: 'ClearAllEvents';
     Params: '()'
    ),
    (
     Name: 'EventState';
     Params: '(const int event)'
    ),
    (
     Name: 'CalibrateEvent';
     Params: '(const int event, const int low, const int hi, const int hyst)'
    ),
    (
     Name: 'EVENT_MASK';
     Params: '(const int e)'
    ),
    (
     Name: 'SetUpperLimit';
     Params: '(const int event, const int &limit)'
    ),
    (
     Name: 'UpperLimit';
     Params: '(const int event)'
    ),
    (
     Name: 'SetLowerLimit';
     Params: '(const int event, const int &limit)'
    ),
    (
     Name: 'LowerLimit';
     Params: '(const int event)'
    ),
    (
     Name: 'SetHysteresis';
     Params: '(const int event, const int &value)'
    ),
    (
     Name: 'Hysteresis';
     Params: '(const int event)'
    ),
    (
     Name: 'SetClickTime';
     Params: '(const int event, const int &value)'
    ),
    (
     Name: 'ClickTime';
     Params: '(const int event)'
    ),
    (
     Name: 'SetClickCounter';
     Params: '(const int event, const int &value)'
    ),
    (
     Name: 'ClickCounter';
     Params: '(const int event)'
    ),
    (
     Name: 'SetSensorClickTime';
     Params: '(const int &value)'
    ),
    (
     Name: 'SetCounterLimit';
     Params: '(const int n, const int &value)'
    ),
    (
     Name: 'SetTimerLimit';
     Params: '(const int n, const int &value)'
    ),
    (
     Name: 'CreateDatalog';
     Params: '(const int size)'
    ),
    (
     Name: 'AddToDatalog';
     Params: '(const int &value)'
    ),
    (
     Name: 'UploadDatalog';
     Params: '(const int start, const int count)'
    ),
    (
     Name: 'Wait';
     Params: '(const int &time)'
    ),
    (
     Name: 'StopAllTasks';
     Params: '()'
    ),
    (
     Name: 'Random';
     Params: '(const int n)'
    ),
    (
     Name: 'SetRandomSeed';
     Params: '(const int &value)'
    ),
    (
     Name: 'SetSleepTime';
     Params: '(const int minutes)'
    ),
    (
     Name: 'SleepNow';
     Params: '()'
    ),
    (
     Name: 'Program';
     Params: '()'
    ),
    (
     Name: 'SelectProgram';
     Params: '(const int n)'
    ),
    (
     Name: 'BatteryLevel';
     Params: '()'
    ),
    (
     Name: 'FirmwareVersion';
     Params: '()'
    ),
    (
     Name: 'Watch';
     Params: '()'
    ),
    (
     Name: 'SetWatch';
     Params: '(const int hours, const int minutes)'
    ),
    (
     Name: 'SetScoutRules';
     Params: '(const int motion, const int touch, const int light, const int time, const int fx)'
    ),
    (
     Name: 'ScoutRules';
     Params: '(const int n)'
    ),
    (
     Name: 'SetScoutMode';
     Params: '(const int mode)'
    ),
    (
     Name: 'SetEventFeedback';
     Params: '(const int &x)'
    ),
    (
     Name: 'EventFeedback';
     Params: '()'
    ),
    (
     Name: 'SetLight';
     Params: '(const int mode)'
    ),
    (
     Name: 'CounterLimit';
     Params: '(const int n)'
    ),
    (
     Name: 'TimerLimit';
     Params: '(const int n)'
    ),
    (
     Name: 'Drive';
     Params: '(const int pwr_m0, const int pwr_m1)'
    ),
    (
     Name: 'OnWait';
     Params: '(const int motors, const int power, const int time)'
    ),
    (
     Name: 'OnWaitDifferent';
     Params: '(const int motors, const int pwr0, const int pwr1, const int pwr2, const int time)'
    ),
    (
     Name: 'ClearTachoCounter';
     Params: '(const int motors)'
    ),
    (
     Name: 'TachoCount';
     Params: '(const int n)'
    ),
    (
     Name: 'TachoSpeed';
     Params: '(const int n)'
    ),
    (
     Name: 'ExternalMotorRunning';
     Params: '()'
    ),
    (
     Name: 'AGC';
     Params: '()'
    ),
    (
     Name: 'DIRSPEED';
     Params: '(const int v)'
    ),
    (
     Name: 'Set';
     Params: '(const int &dest, const int &src)'
    ),
    (
     Name: 'Indirect';
     Params: '(const int n)'
    ),
    (
     Name: 'SetIndirectVar';
     Params: '(const int &v, const int &n)'
    ),
    (
     Name: 'DatalogType';
     Params: '(const int &n)'
    ),
    (
     Name: 'DatalogValue';
     Params: '(const int &n)'
    ),
    (
     Name: 'DatalogByte';
     Params: '(const int &n)'
    ),
    (
     Name: 'InitSpybotComm';
     Params: '()'
    ),
    (
     Name: 'SendSpybotMsg';
     Params: '()'
    ),
    (
     Name: 'SetSpybotMessage';
     Params: '(const int &nMode, const int &nMyID, const int &nAddress, const int &nCmd, const int &nHiByte, const int &nLoByte)'
    ),
    (
     Name: 'SendSpybotMessage';
     Params: '(const int &nMode, const int &nMyID, const int &nAddress, const int &nCmd, const int &nHiByte, const int &nLoByte)'
    ),
    (
     Name: 'SendSpybotCtrlMsg';
     Params: '()'
    ),
    (
     Name: 'SetSpybotCtrlMessage';
     Params: '(const int &nMyID, const int &nMsg)'
    ),
    (
     Name: 'SendSpybotCtrlMessage';
     Params: '(const int &nMyID, const int &nMsg)'
    ),
    (
     Name: 'SendSpybotCtrlPingMsg';
     Params: '()'
    ),
    (
     Name: 'SetSpybotCtrlPingMessage';
     Params: '(const int &nID)'
    ),
    (
     Name: 'SendSpybotCtrlPingMessage';
     Params: '(const int &nID)'
    ),
    (
     Name: 'SendSpybotPingMsg';
     Params: '()'
    ),
    (
     Name: 'SetSpybotPing';
     Params: '(const int &nLinkID, const int &nMyID, const int &nInfo)'
    ),
    (
     Name: 'SendSpybotPing';
     Params: '(const int &nLinkID, const int &nMyID, const int &nInfo)'
    ),
    (
     Name: 'InitRCComm';
     Params: '()'
    ),
    (
     Name: 'SendRCMsg';
     Params: '()'
    ),
    (
     Name: 'SetRCMessage';
     Params: '(const int &nChannel, const int &nLeft, const int &nRight)'
    ),
    (
     Name: 'SendRCMessage';
     Params: '(const int &nChannel, const int &nLeft, const int &nRight)'
    ),
    (
     Name: 'SetAnimation';
     Params: '(const int animation)'
    ),
    (
     Name: 'SetLED';
     Params: '(const int mode, const int &value)'
    ),
    (
     Name: 'LED';
     Params: '(const int mode)'
    ),
    (
     Name: 'VLL';
     Params: '()'
    ),
    (
     Name: 'SerialType';
     Params: '()'
    ),
    (
     Name: 'SetSerialType';
     Params: '(const int &t)'
    ),
    (
     Name: 'SerialBaud';
     Params: '()'
    ),
    (
     Name: 'SetSerialBaud';
     Params: '(const int &b)'
    ),
    (
     Name: 'SerialChannel';
     Params: '()'
    ),
    (
     Name: 'SetSerialChannel';
     Params: '(const int &c)'
    ),
    (
     Name: 'SerialPreamblePos';
     Params: '()'
    ),
    (
     Name: 'SetSerialPreamblePos';
     Params: '(const int &p)'
    ),
    (
     Name: 'SerialPreambleLen';
     Params: '()'
    ),
    (
     Name: 'SetSerialPreambleLen';
     Params: '(const int &l)'
    ),
    (
     Name: 'SerialChecksum';
     Params: '()'
    ),
    (
     Name: 'SetSerialChecksum';
     Params: '(const int &n)'
    ),
    (
     Name: 'SerialBiPhase';
     Params: '()'
    ),
    (
     Name: 'SetSerialBiPhase';
     Params: '(const int &n)'
    ),
    (
     Name: 'RxMessageLock';
     Params: '()'
    ),
    (
     Name: 'SetRxMessageLock';
     Params: '(const int &l)'
    ),
    (
     Name: 'RxMessageIndex';
     Params: '()'
    ),
    (
     Name: 'RxMessageChannel';
     Params: '()'
    ),
    (
     Name: 'RxMessageID';
     Params: '(const int channel)'
    ),
    (
     Name: 'RxMessage';
     Params: '(const int channel, const int n)'
    ),
    (
     Name: 'AnimateLED';
     Params: '(const int led_mask, const int time)'
    ),
    (
     Name: 'RepeatAnimation';
     Params: '()'
    ),
    (
     Name: 'Gate';
     Params: '(const int on, const int period)'
    ),
    (
     Name: 'GateOff';
     Params: '()'
    ),
    (
     Name: 'Glide';
     Params: '(const int freq1, const int freq2, const int duration)'
    ),
    (
     Name: 'Vibrato';
     Params: '(const int freq1, const int freq2, const int duration)'
    ),
    (
     Name: 'WaitEffect';
     Params: '(const int duration)'
    ),
    (
     Name: 'FixedWaitEffect';
     Params: '(const int duration)'
    ),
    (
     Name: 'Tone';
     Params: '(const int freq, const int duration)'
    ),
    (
     Name: 'FixedTone';
     Params: '(const int freq, const int duration)'
    ),
    (
     Name: 'RepeatEffect';
     Params: '()'
    ),
    (
     Name: 'EffectSound';
     Params: '()'
    ),
    (
     Name: 'EffectTime';
     Params: '()'
    ),
    (
     Name: 'SetEffectSound';
     Params: '(const int &s)'
    ),
    (
     Name: 'SetEffectTime';
     Params: '(const int &t)'
    ),
    (
     Name: 'FindWorld';
     Params: '(int &v, const int relsrc, const int crit, const int& thresh)'
    ),
    (
     Name: 'ClearWorld';
     Params: '()'
    ),
    (
     Name: 'Target';
     Params: '(const int relation_source)'
    ),
    (
     Name: 'SetTargetID';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetTargetNote';
     Params: '(const int &v)'
    ),
    (
     Name: 'World';
     Params: '(const int i, const int &n)'
    ),
    (
     Name: 'WorldShortID';
     Params: '(const int &n)'
    ),
    (
     Name: 'WorldLinkID';
     Params: '(const int &n)'
    ),
    (
     Name: 'WorldRange';
     Params: '(const int &n)'
    ),
    (
     Name: 'WorldDirection';
     Params: '(const int &n)'
    ),
    (
     Name: 'WorldAspect';
     Params: '(const int &n)'
    ),
    (
     Name: 'WorldNote';
     Params: '(const int &n)'
    ),
    (
     Name: 'GetWorld';
     Params: '(const int n, int &t, int &v)'
    ),
    (
     Name: 'GetWorldShortID';
     Params: '(int &t, int &v)'
    ),
    (
     Name: 'GetWorldLinkID';
     Params: '(int &t, int &v)'
    ),
    (
     Name: 'GetWorldRange';
     Params: '(int &t, int &v)'
    ),
    (
     Name: 'GetWorldDirection';
     Params: '(int &t, int &v)'
    ),
    (
     Name: 'GetWorldAspect';
     Params: '(int &t, int &v)'
    ),
    (
     Name: 'GetWorldNote';
     Params: '(int &t, int &v)'
    ),
    (
     Name: 'SetWorldNote';
     Params: '(int &t, const int &v)'
    ),
    (
     Name: 'Stack';
     Params: '(const int n)'
    ),
    (
     Name: 'Push';
     Params: '(const int &v)'
    ),
    (
     Name: 'Pop';
     Params: '(const int n)'
    ),
    (
     Name: 'SetStack';
     Params: '(const int i, const int &v)'
    ),
    (
     Name: 'TimerState';
     Params: '(const int n)'
    ),
    (
     Name: 'SetTimerState';
     Params: '(const int n, const int &s)'
    ),
    (
     Name: 'CurrentTaskID';
     Params: '()'
    ),
    (
     Name: 'PingControl';
     Params: '(const int n)'
    ),
    (
     Name: 'PingData';
     Params: '()'
    ),
    (
     Name: 'SetPingData';
     Params: '(const int &d)'
    ),
    (
     Name: 'PingInterval';
     Params: '()'
    ),
    (
     Name: 'SetPingInterval';
     Params: '(const int &i)'
    ),
    (
     Name: 'PingID';
     Params: '()'
    ),
    (
     Name: 'BeaconControl';
     Params: '(const int n)'
    ),
    (
     Name: 'LinkID';
     Params: '()'
    ),
    (
     Name: 'SetLinkID';
     Params: '(const int &n)'
    ),
    (
     Name: 'RCRxChannel';
     Params: '()'
    ),
    (
     Name: 'SetRCRxChannel';
     Params: '(const int &c)'
    ),
    (
     Name: 'RCTxChannel';
     Params: '()'
    ),
    (
     Name: 'SetRCTxChannel';
     Params: '(const int &c)'
    ),
    (
     Name: 'RCTxMode';
     Params: '()'
    ),
    (
     Name: 'SetRCTxMode';
     Params: '(const int &m)'
    ),
    (
     Name: 'EEPROM';
     Params: '(const int &i)'
    ),
    (
     Name: 'SetEEPROM';
     Params: '(const int &i, const int &d)'
    ),
    (
     Name: 'StartTask';
     Params: '(const int t)'
    ),
    (
     Name: 'StopTask';
     Params: '(const int t)'
    ),
    (
     Name: 'SendSpybotMessage';
     Params: '(const int &nIndex, const int &nCmd, const int &nHiByte, const int &nLoByte)'
    ),
    (
     Name: 'SendRCXMessage';
     Params: '(const int &nMessage)'
    ),
    (
     Name: 'SendAllRangeMessage';
     Params: '(const int &nMessage, const int &nData)'
    ),
    (
     Name: 'Disp';
     Params: '(const int &display)'
    ),
    (
     Name: 'BasicMove';
     Params: '(const int &move, const int &time)'
    ),
    (
     Name: 'Action';
     Params: '(const int &nSound, const int &nDisplay, const int &nMovement, const int &nRepeat, const int &nTime)'
    ),
    (
     Name: 'RandomMove';
     Params: '(const int &move, const int &time)'
    ),
    (
     Name: 'FancyMove';
     Params: '(const int &move, const int &time)'
    ),
    (
     Name: 'SlowDownMove';
     Params: '(const int &move, const int &time)'
    ),
    (
     Name: 'SpeedUpMove';
     Params: '(const int &move, const int &time)'
    ),
    (
     Name: 'Sum2Mem';
     Params: '(const int &nMem, const int &nValue)'
    ),
    (
     Name: 'Sum4Mem';
     Params: '(const int &nMem, const int &nValue)'
    ),
    (
     Name: 'BitClear';
     Params: '(const int &result, const int &operand)'
    ),
    (
     Name: 'BitSet';
     Params: '(const int &result, const int &operand)'
    ),
    (
     Name: 'ClearAll';
     Params: '(const int &nCmdFlags)'
    ),
    (
     Name: 'CommErrorsFraming';
     Params: '()'
    ),
    (
     Name: 'CommErrorsOverrun';
     Params: '()'
    ),
    (
     Name: 'CommErrorsParity';
     Params: '()'
    ),
    (
     Name: 'CommErrorsTimeout';
     Params: '()'
    ),
    (
     Name: 'CurrentTask';
     Params: '()'
    ),
    (
     Name: 'DatalogSize';
     Params: '()'
    ),
    (
     Name: 'DebugTaskMode';
     Params: '()'
    ),
    (
     Name: 'DefaultSerialComm';
     Params: '()'
    ),
    (
     Name: 'DefaultSerialPacket';
     Params: '()'
    ),
    (
     Name: 'DefaultStackSize';
     Params: '()'
    ),
    (
     Name: 'EventCounts';
     Params: '(const int n)'
    ),
    (
     Name: 'EventSrc';
     Params: '(const int n)'
    ),
    (
     Name: 'EventType';
     Params: '(const int n)'
    ),
    (
     Name: 'ExpandedRemoteMessages';
     Params: '()'
    ),
    (
     Name: 'ExpandedSubroutines';
     Params: '()'
    ),
    (
     Name: 'FloatDuringInactivePWM';
     Params: '()'
    ),
    (
     Name: 'GlobalVar';
     Params: '(const int n)'
    ),
    (
     Name: 'IgnoreMessagesCPU';
     Params: '()'
    ),
    (
     Name: 'ImmediateBatteryLevel';
     Params: '()'
    ),
    (
     Name: 'InterCharTimeout';
     Params: '()'
    ),
    (
     Name: 'IntrinsicIndGlobal';
     Params: '(const int n)'
    ),
    (
     Name: 'LCDRefreshRate';
     Params: '()'
    ),
    (
     Name: 'MemoryMapAddress';
     Params: '()'
    ),
    (
     Name: 'MessageParam';
     Params: '()'
    ),
    (
     Name: 'MissedSensorADConversions';
     Params: '()'
    ),
    (
     Name: 'MotorBrakePower';
     Params: '(const int n)'
    ),
    (
     Name: 'MotorPower128';
     Params: '(const int n)'
    ),
    (
     Name: 'MotorPower8';
     Params: '(const int n)'
    ),
    (
     Name: 'MotorPowerSigned';
     Params: '(const int n)'
    ),
    (
     Name: 'MotorTransitionDelay';
     Params: '()'
    ),
    (
     Name: 'MSTimer';
     Params: '(const int n)'
    ),
    (
     Name: 'Negate';
     Params: '(const int &result, const int &operand)'
    ),
    (
     Name: 'NoPowerDownOnAC';
     Params: '()'
    ),
    (
     Name: 'OpcodesPerTimeslice';
     Params: '()'
    ),
    (
     Name: 'PlaySounds';
     Params: '()'
    ),
    (
     Name: 'PowerDownDelay';
     Params: '()'
    ),
    (
     Name: 'QueuedSoundCount';
     Params: '()'
    ),
    (
     Name: 'ResetMSTimer';
     Params: '(const int n)'
    ),
    (
     Name: 'RotDebouncedGlitches';
     Params: '()'
    ),
    (
     Name: 'RotErrorsCount';
     Params: '()'
    ),
    (
     Name: 'SendMessageWithParam';
     Params: '(const int &m, const int &p)'
    ),
    (
     Name: 'SensorDelayCycles';
     Params: '()'
    ),
    (
     Name: 'SensorRefreshRate';
     Params: '()'
    ),
    (
     Name: 'SensorRefreshState';
     Params: '()'
    ),
    (
     Name: 'SensorScanCount';
     Params: '()'
    ),
    (
     Name: 'SensorStartupDelay';
     Params: '()'
    ),
    (
     Name: 'SerialLinkStatus';
     Params: '()'
    ),
    (
     Name: 'SetDefaultSerialComm';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetDefaultSerialPacket';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetDefaultStackSize';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetEventCounts';
     Params: '(const int n, const int &v)'
    ),
    (
     Name: 'SetEventSrc';
     Params: '(const int n, const int &v)'
    ),
    (
     Name: 'SetEventType';
     Params: '(const int n, const int &v)'
    ),
    (
     Name: 'SetExpandedRemoteMessages';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetExpandedSubroutines';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetFloatDuringInactivePWM';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetInterCharTimeout';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetLCDRefreshRate';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetMessageByteParam';
     Params: '(const int m, const int p)'
    ),
    (
     Name: 'SetMessageVariableParam';
     Params: '(const int &m, const int &p)'
    ),
    (
     Name: 'SetMessageWordParam';
     Params: '(const int m, const int p)'
    ),
    (
     Name: 'SetMotorBrakePower';
     Params: '(const int n, const int &v)'
    ),
    (
     Name: 'SetMotorPower128';
     Params: '(const int n, const int &v)'
    ),
    (
     Name: 'SetMotorPower8';
     Params: '(const int n, const int &v)'
    ),
    (
     Name: 'SetMotorPowerSigned';
     Params: '(const int n, const int &v)'
    ),
    (
     Name: 'SetMotorTransitionDelay';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetNoPowerDownOnAC';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetOpcodesPerTimeslice';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetPlaySounds';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetSensorRefreshRate';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetSensorStartupDelay';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetSystem';
     Params: '(const int n, const int &v)'
    ),
    (
     Name: 'SetSystemPreambleSize';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetTaskAcquirePriority';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetTaskSchedulingPriority';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetVolume';
     Params: '(const int &v)'
    ),
    (
     Name: 'SetWatchFormat';
     Params: '(const int &v)'
    ),
    (
     Name: 'SoundActive';
     Params: '()'
    ),
    (
     Name: 'StackAddress';
     Params: '(const int n)'
    ),
    (
     Name: 'StackSize';
     Params: '(const int n)'
    ),
    (
     Name: 'System';
     Params: '(const int n)'
    ),
    (
     Name: 'SystemPreambleSize';
     Params: '()'
    ),
    (
     Name: 'TaskAcquirePriority';
     Params: '()'
    ),
    (
     Name: 'TaskSchedulingPriority';
     Params: '()'
    ),
    (
     Name: 'TransmitterRange';
     Params: '()'
    ),
    (
     Name: 'UnsolicitedMessages';
     Params: '()'
    ),
    (
     Name: 'Volume';
     Params: '()'
    ),
    (
     Name: 'WaitMS';
     Params: '(const int &v)'
    ),
    (
     Name: 'WatchFormat';
     Params: '()'
    )
(*
    (
     Name: '_SENSOR_CFG';
     Params: '(type,mode)'
    ),
    (
     Name: '__SetEvent';
     Params: '(const int event, const int source, const int type)'
    ),
    (
     Name: '_GSetOutput';
     Params: '(const int outputs, const int mode)'
    ),
    (
     Name: '_GSetDirection';
     Params: '(const int outputs, const int direction)'
    ),
    (
     Name: '_GSetPower';
     Params: '(const int outputs, const int &power)'
    ),
    (
     Name: '_GOn';
     Params: '(const int outputs)'
    ),
    (
     Name: '_GOff';
     Params: '(const int outputs)'
    ),
    (
     Name: '_GFloat';
     Params: '(const int outputs)'
    ),
    (
     Name: '_GToggle';
     Params: '(const int outputs)'
    ),
    (
     Name: '_GFwd';
     Params: '(const int outputs)'
    ),
    (
     Name: '_GRev';
     Params: '(const int outputs)'
    ),
    (
     Name: '_GOnFwd';
     Params: '(const int outputs)'
    ),
    (
     Name: '_GOnRev';
     Params: '(const int outputs)'
    ),
    (
     Name: '_GOnFor';
     Params: '(const int outputs, const int &time)'
    ),
    (
     Name: '_WaitEvents';
     Params: '(const int &mask)'
    ),
    (
     Name: '_LSBlink';
     Params: '(const int &x)'
    ),
    (
     Name: '_LSCal';
     Params: '()'
    ),
    (
     Name: '_LSHyst';
     Params: '(const int &x)'
    ),
    (
     Name: '_LSLower';
     Params: '(const int &x)'
    ),
    (
     Name: '_LSUpper';
     Params: '(const int &x)'
    ),
    (
     Name: '_Rules';
     Params: '(const int m, const int t, const int l, const int tm, const int fx)'
    ),
    (
     Name: '_Scout';
     Params: '(const int s)'
    ),
    (
     Name: '_SetFeedback';
     Params: '(const int &x)'
    ),
    (
     Name: '_Sound';
     Params: '(const int x)'
    ),
    (
     Name: '_VLL';
     Params: '(const int &x)'
    ),
    (
     Name: '_RTS';
     Params: '()'
    ),
    (
     Name: 'local';
     Params: '(n)'
    ),
    (
     Name: 'Call';
     Params: '(const int n)'
    )
*)
  );

function NQCCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to NQCCodeCompDataSize - 1 do begin
    if NQCCodeCompData[i].Name = aName then begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure AddNQCCodeCompParams(aStrings : TStrings; Index : integer);
begin
  if (Index < 0) or (Index >= NQCCodeCompDataSize) then Exit;
  AddCodeCompParamsHelper(aStrings, NQCCodeCompData[Index].Params, 'void', ',');
end;

end.