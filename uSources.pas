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
unit uSources;

interface

uses
  rcx_constants;

type
  TSourceBrickType = (sbtRCX, sbtCM, sbtScout, sbtRCX2, sbtSpy, sbtSwan, sbtNXT);
  TSourceBrickTypes = set of TSourceBrickType;
  TWatchSource = record
    Has : Boolean;
    case Boolean of
      True: (
        VMin : Integer;
        VMax : Integer;
        RO : Boolean;
        Num : Byte;
        Name : String[30];
      );
      False: (
        X : Byte;
      );
  end;

type
  WatchSources = array[TRcxValueType] of TWatchSource;
const
  BrickWatchSources : array[0..6] of WatchSources =
  (
    // RCX
    (
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Variable'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Timer'),
      (Has:  True; VMin: -32768; VMax: 32767; RO:   True;  Name: 'Constant'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Motor status'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Random'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Program slot'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor value'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor type'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor mode'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor raw'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor bool'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Watch'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Message'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0)
    ),
    // CM
    (
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Variable'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Timer'),
      (Has:  True; VMin: -32768; VMax: 32767; RO:   True;  Name: 'Constant'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Motor status'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Random'),
      (Has:  True; VMin:      0; VMax:     1; RO:   True;  Name: 'Tach count'),
      (Has:  True; VMin:      0; VMax:     1; RO:   True;  Name: 'Tach speed'),
      (Has:  True; VMin:      2; VMax:     2; RO:   True;  Name: 'Output current'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor value'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor type'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor mode'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'AGC'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0)
    ),
    // Scout
    (
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Variable'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Timer'),
      (Has:  True; VMin: -32768; VMax: 32767; RO:   True;  Name: 'Constant'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Motor status'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Random'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor value'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor type'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor raw'),
      (Has: False; X: 0), (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Message'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Global motor status'),
      (Has:  True; VMin:      0; VMax:     5; RO:  False;  Name: 'Scout rules'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Light params'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Timer limit'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: 'Counter'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: 'Counter limit'),
      (Has:  True; VMin:      0; VMax:     5; RO:   True;  Name: 'Task events'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Event Feedback'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0)
    ),
    // RCX2
    (
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Variable'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Timer'),
      (Has:  True; VMin: -32768; VMax: 32767; RO:   True;  Name: 'Constant'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Motor status'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Random'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Program slot'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor value'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor type'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor mode'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor raw'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor bool'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Watch'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Message'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Global motor status'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Counter'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     9; RO:   True;  Name: 'Task events'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:    15; RO:   True;  Name: 'Event state'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: '10 ms timer'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Click counter'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Upper threshold'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Lower threshold'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Hysteresis'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Duration'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:    17; RO:  False;  Name: 'UART setup'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Battery level'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Firmware version'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Indirect variable'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Log type indirect'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Log type direct'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Log value indirect'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Log value direct'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Log byte indirect'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Log byte direct'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0)
    ),
    // Spybot
    (
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Variable'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Timer'),
      (Has:  True; VMin: -32768; VMax: 32767; RO:   True;  Name: 'Constant'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Motor status'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Random'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor value'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor mode'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor raw'),
      (Has: False; X: 0), (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Message'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Global motor status'),
      (Has:  True; VMin:      0; VMax:    79; RO:  False;  Name: 'Stack'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Timer control'),
      (Has:  True; VMin:      0; VMax:  4095; RO:  False;  Name: 'EEPROM'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Counter'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'LED'),
      (Has:  True; VMin:      0; VMax:    15; RO:   True;  Name: 'Task events'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:    15; RO:   True;  Name: 'Event state'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: '10 ms timer'),
      (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Upper threshold'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Lower threshold'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Hysteresis'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Duration'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Task ID'),
      (Has:  True; VMin:      0; VMax:    36; RO:  False;  Name: 'UART setup'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Battery level'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Firmware version'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Indirect variable'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Game notes'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Link ID?'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Robot distance'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Robot direction'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Robot orientation'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Game info?'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Robot ID'),
      (Has:  True; VMin:      0; VMax:     7; RO:  False;  Name: 'Target info'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Ping control'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Beacon control'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: 'Sound control'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Indirect EEPROM'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0)
    ),
    // Swan
    (
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Variable'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Timer'),
      (Has:  True; VMin: -32768; VMax: 32767; RO:   True;  Name: 'Constant'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Motor status'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Random'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Motor power signed'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Intrinsic indirect global'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Motor brake power'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Program slot'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor value'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor type'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor mode'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor raw'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor bool'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Watch'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: 'Message'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Motor power 128'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Global motor status'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Event type'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Event'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Event counts'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Counter'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: '1 ms timer'),
      (Has:  True; VMin:      0; VMax:    15; RO:   True;  Name: 'Task events'),
      (Has:  True; VMin:      0; VMax:    38; RO:  False;  Name: 'System'),
      (Has:  True; VMin:      0; VMax:    15; RO:   True;  Name: 'Event state'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: '10 ms timer'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Click counter'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Upper threshold'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Lower threshold'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Hysteresis'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Duration'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Motor power 8'),
      (Has:  True; VMin:      0; VMax:    19; RO:  False;  Name: 'UART setup'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Battery level'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Firmware version'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Indirect variable'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Log type indirect'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Log type direct'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Log value indirect'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Log value direct'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Log byte indirect'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Log byte direct'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Global variable'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Indirect global int'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Indirect global long'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Indirect global float'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Indexed global const'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Indexed global long const'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Stack var'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Constant var'),
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Func ret val word'),
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Func ret val long'),
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Func ret val float'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Var byte'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Var word'),
      (Has:  True; VMin:      0; VMax:   255; RO:  False;  Name: 'Var long'),
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Task stack var byte'),
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Task stack var word'),
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Task stack var long'),
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Task var'),
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Task stack address'),
      (Has:  True; VMin:      0; VMax:     9; RO:  False;  Name: 'Task stack size'),
      (Has: False; X: 0)
    ),
    // NXT
    (
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Variable'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Timer'),
      (Has:  True; VMin: -32768; VMax: 32767; RO:   True;  Name: 'Constant'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Motor status'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Random'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Tacho Count'),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     3; RO:   True;  Name: 'Sensor value'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Sensor type'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Sensor mode'),
      (Has:  True; VMin:      0; VMax:     3; RO:   True;  Name: 'Sensor raw'),
      (Has:  True; VMin:      0; VMax:     3; RO:   True;  Name: 'Sensor bool'),
      (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Battery level'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Firmware version'),
//      (Has: False; X: 0),
//      (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0),
      (Has: False; X: 0), (Has: False; X: 0), (Has: False; X: 0)
    )
  );



(*
    (VMin:      0; VMax:    31; RO:  False;
     Num:     0; Name: 'Variable'           ; Bricks: [sbtRCX, sbtCM, sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     3; RO:  False;
     Num:     1; Name: 'Timer'              ; Bricks: [sbtRCX, sbtCM, sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin: -32768; VMax: 32767; RO:   True;
     Num:     2; Name: 'Constant'           ; Bricks: [sbtRCX, sbtCM, sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     2; RO:   True;
     Num:     3; Name: 'Motor status'       ; Bricks: [sbtRCX, sbtCM, sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax: 32767; RO:  False;
     Num:     4; Name: 'Random'             ; Bricks: [sbtRCX, sbtCM, sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     1; RO:   True;
     Num:     5; Name: 'Tach count'         ; Bricks: [sbtCM]),
    (VMin:      0; VMax:     1; RO:   True;
     Num:     6; Name: 'Tach speed'         ; Bricks: [sbtCM]),
    (VMin:      2; VMax:     2; RO:   True;
     Num:     7; Name: 'Output current'     ; Bricks: [sbtCM]),
    (VMin:      0; VMax:     0; RO:  False;
     Num:     8; Name: 'Program slot'       ; Bricks: [sbtRCX, sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:     2; RO:   True;
     Num:     9; Name: 'Sensor value'       ; Bricks: [sbtRCX, sbtCM, sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     2; RO:  False;
     Num:    10; Name: 'Sensor type'        ; Bricks: [sbtRCX, sbtCM, sbtScout, sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:     2; RO:  False;
     Num:    11; Name: 'Sensor mode'        ; Bricks: [sbtRCX, sbtCM, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     2; RO:   True;
     Num:    12; Name: 'Sensor raw'         ; Bricks: [sbtRCX, sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     2; RO:   True;
     Num:    13; Name: 'Sensor bool'        ; Bricks: [sbtRCX, sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:     0; RO:  False;
     Num:    14; Name: 'Watch'              ; Bricks: [sbtRCX, sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:     0; RO:  False;
     Num:    15; Name: 'Message'            ; Bricks: [sbtRCX, sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     0; RO:   True;
     Num:    16; Name: 'AGC'                ; Bricks: [sbtCM]),
    (VMin:      0; VMax:     2; RO:   True;
     Num:    17; Name: 'Global motor status'; Bricks: [sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:    79; RO:  False;
     Num:    18; Name: 'Stack'              ; Bricks: [sbtScout, sbtSpy]),
    (VMin:      0; VMax:     3; RO:  False;
     Num:    19; Name: 'Timer control'      ; Bricks: [sbtScout, sbtSpy]),
    (VMin:      0; VMax:  4095; RO:  False;
     Num:    20; Name: 'EEPROM'             ; Bricks: [sbtScout, sbtSpy]),
    (VMin:      0; VMax:     2; RO:  False;
     Num:    21; Name: 'Counter'            ; Bricks: [sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:    15; RO:  False;
     Num:    22; Name: 'LED'                ; Bricks: [sbtScout, sbtSpy]),
    (VMin:      0; VMax:    15; RO:   True;
     Num:    23; Name: 'Task events'        ; Bricks: [sbtScout, sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     0; RO:  False;
     Num:    24; Name: 'Event Feedback'     ; Bricks: [sbtScout]),
    (VMin:      0; VMax:    15; RO:   True;
     Num:    25; Name: 'Event state'        ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     3; RO:  False;
     Num:    26; Name: '10 ms timer'        ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:    15; RO:  False;
     Num:    27; Name: 'Click counter'      ; Bricks: [sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:    15; RO:  False;
     Num:    28; Name: 'Upper threshold'    ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:    15; RO:  False;
     Num:    29; Name: 'Lower threshold'    ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:    15; RO:  False;
     Num:    30; Name: 'Hysteresis'         ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:    15; RO:  False;
     Num:    31; Name: 'Duration'           ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     0; RO:   True;
     Num:    32; Name: 'Task ID'            ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:    36; RO:  False;
     Num:    33; Name: 'UART setup'         ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     0; RO:   True;
     Num:    34; Name: 'Battery level'      ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:     0; RO:   True;
     Num:    35; Name: 'Firmware version'   ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:    31; RO:  False;
     Num:    36; Name: 'Indirect variable'  ; Bricks: [sbtRCX2, sbtSpy, sbtSwan]),
    (VMin:      0; VMax:    31; RO:  False;
     Num:    37; Name: '37'                 ; Bricks: [sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:    31; RO:  False;
     Num:    38; Name: '38'                 ; Bricks: [sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:    31; RO:  False;
     Num:    39; Name: '39'                 ; Bricks: [sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:    31; RO:  False;
     Num:    40; Name: '40'                 ; Bricks: [sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:    31; RO:  False;
     Num:    41; Name: '41'                 ; Bricks: [sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:    31; RO:  False;
     Num:    42; Name: '42'                 ; Bricks: [sbtRCX2, sbtSwan]),
    (VMin:      0; VMax:    31; RO:  False;
     Num:    43; Name: 'Game notes'         ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:    31; RO:   True;
     Num:    44; Name: 'Link ID?'           ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:    31; RO:   True;
     Num:    45; Name: 'Robot distance'     ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:    31; RO:   True;
     Num:    46; Name: 'Robot direction'    ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:    31; RO:   True;
     Num:    47; Name: 'Robot orientation'  ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:    31; RO:   True;
     Num:    48; Name: 'Game info?'         ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:    31; RO:   True;
     Num:    49; Name: 'Robot ID'           ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:     7; RO:  False;
     Num:    50; Name: 'Target info'        ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:     2; RO:  False;
     Num:    51; Name: 'Ping control'       ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:     3; RO:  False;
     Num:    52; Name: 'Beacon control'     ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:     1; RO:  False;
     Num:    53; Name: 'Sound control'      ; Bricks: [sbtSpy]),
    (VMin:      0; VMax:    31; RO:  False;
     Num:    54; Name: 'Indirect EEPROM'    ; Bricks: [sbtSpy])


    (
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Variable'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Timer'),
      (Has:  True; VMin: -32768; VMax: 32767; RO:   True;  Name: 'Constant'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Motor status'),
      (Has:  True; VMin:      0; VMax: 32767; RO:  False;  Name: 'Random'),
      (Has:  True; VMin:      0; VMax:     1; RO:   True;  Name: 'Tach count'),
      (Has:  True; VMin:      0; VMax:     1; RO:   True;  Name: 'Tach speed'),
      (Has:  True; VMin:      2; VMax:     2; RO:   True;  Name: 'Output current'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Program slot'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor value'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor type'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Sensor mode'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor raw'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Sensor bool'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Watch'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Message'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'AGC'),
      (Has:  True; VMin:      0; VMax:     2; RO:   True;  Name: 'Global motor status'),
      (Has:  True; VMin:      0; VMax:    79; RO:  False;  Name: 'Stack'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Timer control'),
      (Has:  True; VMin:      0; VMax:  4095; RO:  False;  Name: 'EEPROM'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Counter'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'LED'),
      (Has:  True; VMin:      0; VMax:    15; RO:   True;  Name: 'Task events'),
      (Has:  True; VMin:      0; VMax:     0; RO:  False;  Name: 'Event Feedback'),
      (Has:  True; VMin:      0; VMax:    15; RO:   True;  Name: 'Event state'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: '10 ms timer'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Click counter'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Upper threshold'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Lower threshold'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Hysteresis'),
      (Has:  True; VMin:      0; VMax:    15; RO:  False;  Name: 'Duration'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Task ID'),
      (Has:  True; VMin:      0; VMax:    36; RO:  False;  Name: 'UART setup'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Battery level'),
      (Has:  True; VMin:      0; VMax:     0; RO:   True;  Name: 'Firmware version'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Indirect variable'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: '37'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: '38'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: '39'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: '40'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: '41'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: '42'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Game notes'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Link ID?'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Robot distance'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Robot direction'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Robot orientation'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Game info?'),
      (Has:  True; VMin:      0; VMax:    31; RO:   True;  Name: 'Robot ID'),
      (Has:  True; VMin:      0; VMax:     7; RO:  False;  Name: 'Target info'),
      (Has:  True; VMin:      0; VMax:     2; RO:  False;  Name: 'Ping control'),
      (Has:  True; VMin:      0; VMax:     3; RO:  False;  Name: 'Beacon control'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: 'Sound control'),
      (Has:  True; VMin:      0; VMax:    31; RO:  False;  Name: 'Indirect EEPROM'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: '55'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: '56'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: '57'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: '58'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: '59'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: '60'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: '61'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: '62'),
      (Has:  True; VMin:      0; VMax:     1; RO:  False;  Name: '63')
    )


*)

implementation

end.
