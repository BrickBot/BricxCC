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
unit uPasCode;

interface

uses
  uCppCode;

const
  PasUnitNamesSize = 54;
  PasUnitNames: array[0..PasUnitNamesSize-1] of string = (
    '',
    'conio.pas',            // 1
    'critsec.pas',          // 2
    'dbutton.pas',          // 3
    'dirpd.pas',            // 4
    'dkey.pas',             // 5
    'dlcd.pas',             // 6
    'dmotor.pas',           // 7
    'dsensor.pas',          // 8
    'dsound.pas',           // 9
    'mem.pas',              // 10
    'persistent.pas',       // 11
    'remote.pas',           // 12
    'semaphore.pas',        // 13
    'stdlib.pas',           // 14
    'cstring.pas',           // 15
    'swmux.pas',            // 16
    'time.pas',             // 17
    'tm.pas',               // 18
    'unistd.pas',           // 19
    'battery.pas',      // 20
    'bitops.pas',       // 21
    'critsec.pas',      // 22
    'sys/dmotor.pas',       // 23
    'sys/dsensor.pas',      // 24
    'sys/dsound.pas',       // 25
    'h8.pas',           // 26
    'lcd.pas',          // 27
    'mm.pas',           // 28
    'program.pas',      // 29
    '',
    'timeout.pas',      // 31
    '',           // 32
    'vis.pas',          // 33
    'romlcd.pas',          // 34
    'registers.pas',    // 35
    'sound.pas',        // 36
    'romsystem.pas',       // 37
    'lnp/lnp.pas',          // 38
    'lnp/lnp-logical.pas',  // 39
    'lnp/sys/irq.pas',      // 40
    'lnp/sys/lnp.pas',      // 41
    'lnp/sys/lnp-logical.pas', // 42
    'ObjBattery.pas',      // 43
    'Lamp.pas',         // 44
    'LightSensor.pas',  // 45
    'Motor.pas',        // 46
    'MotorPair.pas',    // 47
    'RotationSensor.pas', // 48
    'Sensor.pas',       // 49
    'Sound.pas',        // 50
    'TemperatureSensor.pas', // 51
    'TouchSensor.pas',   // 52
    'types.pas'   // 53
  );

const
  PasCodeCompDataSize = 645;
  PasCodeCompData: array[0..PasCodeCompDataSize-1] of TCppCodeComp = (
    (Kind: ckKeyword; Name: 'Absolute'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Abstract'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'And'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Array'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'As'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Asm'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Begin'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Case'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Class'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Const'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Constructor'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Destructor'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Div'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Do'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Downto'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Dynamic'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Else'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'End'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'External'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'File'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Finalization'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'For'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Forward'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Function'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Goto'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'If'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Implementation'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'In'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Inherited'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Initialization'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Interface'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Is'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Label'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Library'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Mod'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Nil'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Not'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Object'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Of'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Or'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Override'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Packed'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Private'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Procedure'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Program'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Protected'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Public'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Record'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Repeat'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Set'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Shl'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Shr'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'String'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Then'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'To'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Type'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Unit'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Until'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Uses'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Var'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Virtual'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'While'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'With'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckKeyword; Name: 'Xor'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),

    (Kind: ckAPIType; Name: 'Byte'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'Cardinal'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'code_start_t'; Location: 19; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'critsec_t'; Location: 2; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'EventType'; Location: 12; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'int'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'Integer'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'lcd_comma_style'; Location: 34; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'lcd_number_style'; Location: 34; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'lcd_segment'; Location: 34; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'lnp_addressing_handler_t'; Location: 38; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'lnp_integrity_handler_t'; Location: 38; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'lnp_integrity_state_t'; Location: 41; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'lnp_remote_handler_t'; Location: 38; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'long_int'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'Longint'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'Longword'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'lr_handler_t'; Location: 12; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'MotorDirection'; Location: 7; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'MotorState'; Location: 7; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'note_t'; Location: 9; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'packet_cmd_t'; Location: 29; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'pchain_t'; Location: 18; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'Pcritsec_t'; Location: 2; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'pint'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'PPChar'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'priority_t'; Location: 18; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'program_t'; Location: 29; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'psem_t'; Location: 13; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'Psize_t'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'punsigned'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'punsigned_char'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'punsigned_int'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'sem_t'; Location: 13; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'Shortint'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'signed_char'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'size_t'; Location: 10; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'Smallint'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'tdata_t'; Location: 18; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'tflags_t'; Location: 18; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'tid_t'; Location: 18; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'time_t'; Location: 17; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'tstate_t'; Location: 18; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'unsigned'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'unsigned_char'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'unsigned_int'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'unsigned_long'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'unsigned_short'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'wakeup_t'; Location: 18; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'wakeupPtr'; Location: 53; Params: ''; Count: 1; Alpha: atNumeric),
    (Kind: ckAPIType; Name: 'Word'; Location: 0; Params: ''; Count: 1; Alpha: atNumeric),

    (Kind: ckAPIConst; Name: 'ls_%_left'; Location: 34; Params: ''; Count: 3; Alpha: atLower),
    (
     Kind: ckAPIConst;
     Name: 'ls_%_right';
     Location: 34;
     Params: '';
     Count: 3;
     Alpha: atLower
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_%_select';
     Location: 34;
     Params: '';
     Count: 3;
     Alpha: atLower
    ),
    (
     Kind: ckAPIVar;
     Name: 'AD_%';
     Location: 26;
     Params: '';
     Count: 4;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIVar;
     Name: 'AD_%_H';
     Location: 26;
     Params: '';
     Count: 4;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIVar;
     Name: 'AD_%_L';
     Location: 26;
     Params: '';
     Count: 4;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIVar;
     Name: 'AD_CR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'AD_CSR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ADCR_EXTERN';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ADCSR_AN_%';
     Location: 26;
     Params: '';
     Count: 4;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ADCSR_ENABLE_IRQ';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ADCSR_END';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ADCSR_GROUP_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ADCSR_SCAN';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ADCSR_START';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ADCSR_TIME_134';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ADCSR_TIME_266';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ascii_display_codes';
     Location: 1;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'auto_shutoff_counter';
     Location: 31;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'auto_shutoff_elapsed';
     Location: 31;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'auto_shutoff_period';
     Location: 31;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'auto_shutoff_secs';
     Location: 31;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'autoshutoff_check';
     Location: 31;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'B19200';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'B2400';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'B38400';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'B4800';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'B9600';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'BATTERY';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'BATTERY_LOW_THRESHOLD_MV';
     Location: 20;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'BATTERY_NORMAL_THRESHOLD_MV';
     Location: 20;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'battery_refresh';
     Location: 20;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_battery_x';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_clear';
     Location: 21;
     Params: '(b : punsigned_char; const bit : byte)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_iload';
     Location: 21;
     Params: '(mask : punsigned_char; const bit : byte)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_load';
     Location: 21;
     Params: '(mask : punsigned_char; const bit : byte)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_set';
     Location: 21;
     Params: '(b : punsigned_char; const bit : byte)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_store';
     Location: 21;
     Params: '(b : punsigned_char; const bit : byte)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'mdBrake';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'BUTTON_ONOFF';
     Location: 3;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'BUTTON_PROGRAM';
     Location: 3;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'BUTTON_RUN';
     Location: 3;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'BUTTON_VIEW';
     Location: 3;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ButtonState';
     Location: 3;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'calloc';
     Location: 14;
     Params: '(nmemb : size_t; size : size_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_circle';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'clear_msg';
     Location: 38;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cls';
     Location: 1;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'cprog';
     Location: 29;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc';
     Location: 1;
     Params: '(c : char; p : integer)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_%';
     Location: 1;
     Params: '(c : char)';
     Count: 6;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_hex';
     Location: 1;
     Params: '(c : byte; pos : integer)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_hex_%';
     Location: 1;
     Params: '(nibble : unsigned)';
     Count: 6;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_native';
     Location: 1;
     Params: '(mask : byte; p : integer)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_native_%';
     Location: 1;
     Params: '(mask : byte)';
     Count: 6;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputs';
     Location: 1;
     Params: '(const s : pchar)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputw';
     Location: 1;
     Params: '(w : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'CR_CLEAR_NEVER';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'CR_CLEAR_ON_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'CR_CLEAR_ON_EXTERN';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'CR_ENABLE_IRQ%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'CR_ENABLE_IRQO';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'CSR_0_ON_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'CSR_1_ON_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'CSR_IGNORE_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'CSR_MATCH_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'CSR_OVERFLOW';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'CSR_TOGGLE_ON_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIVar;
     Name: 'ctid';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dbutton';
     Location: 3;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'DEFAULT_SHUTOFF_TIME';
     Location: 31;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'DEFAULT_STACK_SIZE';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'delay';
     Location: 1;
     Params: '(d : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'destroy_critical_section';
     Location: 2;
     Params: '(cs : Pcritsec_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'DESTROY_KERNEL_CRITICAL_SECTION';
     Location: 22;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'lns_digit';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'lcs_digit_comma';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'display_memory';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'dkey';
     Location: 5;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'dkey_multi';
     Location: 5;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dkey_pressed';
     Location: 5;
     Params: '(data : wakeup_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dkey_released';
     Location: 5;
     Params: '(data : wakeup_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dlcd_hide';
     Location: 6;
     Params: '(b : punsigned_char; const i : byte)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dlcd_show';
     Location: 6;
     Params: '(b : punsigned_char; const i : byte)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dlcd_store';
     Location: 6;
     Params: '(b : punsigned_char; const i : byte)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'dm_%';
     Location: 7;
     Params: '';
     Count: 3;
     Alpha: atLower
    ),
    (
     Kind: ckAPIConst;
     Name: 'dm_%_pattern';
     Location: 7;
     Params: '';
     Count: 3;
     Alpha: atLower
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dm_init';
     Location: 23;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dm_shutdown';
     Location: 23;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_dot';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_dot_inv';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'ds_activation';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_active';
     Location: 8;
     Params: '(sensor : punsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_init';
     Location: 24;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'ds_mux';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_mux_off';
     Location: 8;
     Params: '(volatile unsigned *sensor)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_mux_on';
     Location: 8;
     Params: '(volatile unsigned *sensor, unsigned int ch1, unsigned int ch2, unsigned int ch3)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'DS_MUX_POST_SWITCH';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'ds_muxs';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_passive';
     Location: 8;
     Params: '(sensor : punsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'ds_rotation';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_rotation_off';
     Location: 8;
     Params: '(sensor : punsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_rotation_on';
     Location: 8;
     Params: '(sensor : punsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_rotation_set';
     Location: 8;
     Params: '(sensor : punsigned; p : Integer)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'ds_rotations';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_scale';
     Location: 8;
     Params: '(x : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_shutdown';
     Location: 24;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_unscale';
     Location: 8;
     Params: '(x : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'ds_velocities';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'dsound_16th_ms';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'DSOUND_BEEP';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'DSOUND_DEFAULT_16th_ms';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'DSOUND_DEFAULT_internote_ms';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_finished';
     Location: 9;
     Params: '(data : wakeup_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_handler';
     Location: 25;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_init';
     Location: 25;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'dsound_internote_ms';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'dsound_next_note';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'dsound_next_time';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_play';
     Location: 9;
     Params: '(const notes : Pnote_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_playing';
     Location: 9;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_set_duration';
     Location: 9;
     Params: '(duration : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_set_internote';
     Location: 9;
     Params: '(duration : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_shutdown';
     Location: 25;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_stop';
     Location: 9;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'DSOUND_SYS_MAX';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_system';
     Location: 9;
     Params: '(nr : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'dsound_system_sounds';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'lcs_e_%';
     Location: 34;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'lcs_e0';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'EAGAIN';
     Location: 13;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'EIGHTH';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'enter_critical_section';
     Location: 2;
     Params: '(cs : Pcritsec_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ENTER_KERNEL_CRITICAL_SECTION';
     Location: 22;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_everything';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'execi';
     Location: 19;
     Params: '(code_start : code_start_t; argc : int; argv : PPChar; priority : priority_t; stack_size : size_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bexit';
     Location: 19;
     Params: '(int code)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'free';
     Location: 14;
     Params: '(ptr : pointer)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'mdFwd';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'get_battery_mv';
     Location: 20;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'get_msg';
     Location: 38;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'getchar';
     Location: 5;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'HALF';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'HANDLER_WRAPPER';
     Location: 40;
     Params: '(wrapstring,handstring)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'hex_display_codes';
     Location: 1;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'I2C_READ';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'I2C_WRITE';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'idle_powerdown';
     Location: 31;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'IDLE_STACK_SIZE';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'initialize_critical_section';
     Location: 2;
     Params: '(cs : Pcritsec_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'INITIALIZE_KERNEL_CRITICAL_SECTION';
     Location: 22;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_ir_full';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_ir_half';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'kernel_critsec_count';
     Location: 22;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'KEY_ANY';
     Location: 5;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'KEY_ONOFF';
     Location: 5;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'KEY_PRGM';
     Location: 5;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'KEY_RUN';
     Location: 5;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'KEY_VIEW';
     Location: 5;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'kill';
     Location: 19;
     Params: '(tid : tid_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'killall';
     Location: 19;
     Params: '(p : priority_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_BATTERY_BYTE';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_CIRCLE_BYTE';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_IR_BYTE';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_EMPTY_%_BYTE';
     Location: 6;
     Params: '';
     Count: 2;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_S%_S_BYTE';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_S%_A_BYTE';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_S_BYTE';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_L_BYTE';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_R_BYTE';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_DOT_%_BYTE';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_BYTE';
     Location: 6;
     Params: '';
     Count: 6;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_R_BYTE';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_L_BYTE';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_DOT_BYTE';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atNumeric2
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_BOT';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_BOTL';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_BOTR';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_MID';
     Location: 6;
     Params: '';
     Count: 6;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_TOP';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_TOPL';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_TOPR';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_1LEG_BIT';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_DOT';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atNumeric2
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_2LEGS_BIT';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_LEFT';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_RIGHT';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_%_SELECT';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_ARMS_BIT';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_MAN_BYTE';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_BATTERY_X';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_BODY_BIT';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_CIRCLE_%';
     Location: 6;
     Params: '';
     Count: 4;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_clear';
     Location: 34;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_clock';
     Location: 34;
     Params: '(t : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_DATA_OFFSET';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_DATA_SIZE';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_DEV_ID';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_digit';
     Location: 34;
     Params: '(d : integer)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_DISABLE';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_DOT_%';
     Location: 6;
     Params: '';
     Count: 5;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_EMPTY_%';
     Location: 6;
     Params: '';
     Count: 2;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_ENABLE';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_hide';
     Location: 34;
     Params: '(seg : lcd_segment)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_init';
     Location: 27;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_int';
     Location: 34;
     Params: '(i : integer)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_IR_LOWER';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_IR_UPPER';
     Location: 6;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_LONG_CMD';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_MODE_SET';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_number';
     Location: 34;
     Params: '(i : integer; n : lcd_number_style; c : lcd_comma_style)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_power_off';
     Location: 27;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_power_on';
     Location: 27;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_refresh';
     Location: 27;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_refresh_next_byte';
     Location: 27;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_S%_ACTIVE';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_S%_SELECT';
     Location: 6;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LCD_SHORT_CMD';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_show';
     Location: 34;
     Params: '(seg : lcd_segment)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_unsigned';
     Location: 34;
     Params: '(u : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'leave_critical_section';
     Location: 2;
     Params: '(cs : Pcritsec_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'LEAVE_KERNEL_CRITICAL_SECTION';
     Location: 22;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'LIGHT';
     Location: 8;
     Params: '(a : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LIGHT_%';
     Location: 8;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LIGHT_MAX';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LIGHT_RAW_BLACK';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LIGHT_RAW_WHITE';
     Location: 8;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'lnp_addressing_handler';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_addressing_set_handler';
     Location: 38;
     Params: '(port : unsigned_char; handler : lnp_addressing_handler_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_addressing_write';
     Location: 38;
     Params: '(const data : punsigned_char; length : unsigned_char; dest : unsigned_char; srcport : unsigned_char)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_BYTE_SAFE';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_BYTE_TIME';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_BYTE_TIMEOUT';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_DUMMY_ADDRESSING';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_DUMMY_INTEGRITY';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_DUMMY_REMOTE';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'lnp_hostaddr';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_HOSTMASK';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_init';
     Location: 41;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_active';
     Location: 41;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_byte';
     Location: 41;
     Params: '(b : unsigned_char)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'lnp_integrity_handler';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_reset';
     Location: 41;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_set_handler';
     Location: 38;
     Params: '(handler : lnp_integrity_handler_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'lnp_integrity_state';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_write';
     Location: 38;
     Params: '(const data : punsigned_char; length : unsigned_char)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_LOGICAL_BAUD_RATE';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_fflush';
     Location: 39;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_init';
     Location: 42;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_LOGICAL_PARITY';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_range';
     Location: 39;
     Params: '(IsFar : boolean)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_range_is_far';
     Location: 39;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_shutdown';
     Location: 42;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_write';
     Location: 39;
     Params: '(const buf : pointer; len : size_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_PORTMASK';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_RCX_HEADER_LENGTH';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'lnp_rcx_message';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_RCX_MSG_OP_LENGTH';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_RCX_REMOTE_OP_LENGTH';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'lnp_remote_handler';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_remote_set_handler';
     Location: 38;
     Params: '(handler : lnp_remote_handler_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_set_hostaddr';
     Location: 38;
     Params: '(host : unsigned_char)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'lnp_timeout';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'lnp_timeout_counter';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_timeout_reset';
     Location: 41;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_timeout_set';
     Location: 41;
     Params: '(timeout : unsigned_short)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_WAIT_COLL';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNP_WAIT_TXOK';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitCRC';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitData';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitHeader';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitLength';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitMC';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitMCC';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitMH3';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitMH4';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitMN';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitMNC';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitRB0';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitRB0I';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitRB1';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitRB1I';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitRC';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitRCI';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LNPwaitRMH1';
     Location: 41;
     Params: '';
     Count: 4;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIFunc;
     Name: 'locked_decrement';
     Location: 2;
     Params: '(counter : punsigned_char)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'locked_increment';
     Location: 22;
     Params: '(counter : punsigned_char)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LR_DUMMY_HANDLER';
     Location: 12;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'lr_handler';
     Location: 12;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lr_init';
     Location: 12;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lr_set_handler';
     Location: 12;
     Params: '(handler : lr_handler_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lr_shutdown';
     Location: 12;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lr_startup';
     Location: 12;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LR_TIMEOUT';
     Location: 12;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LREVT_KEYOFF';
     Location: 12;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LREVT_KEYON';
     Location: 12;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LRKEY_A%';
     Location: 12;
     Params: '';
     Count: 2;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LRKEY_B%';
     Location: 12;
     Params: '';
     Count: 2;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LRKEY_BEEP';
     Location: 12;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'LRKEY_C%';
     Location: 12;
     Params: '';
     Count: 2;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LRKEY_M%';
     Location: 12;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LRKEY_P%';
     Location: 12;
     Params: '';
     Count: 5;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'LRKEY_STOP';
     Location: 12;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'malloc';
     Location: 14;
     Params: '(size : size_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_man_run';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_man_stand';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'MAX_SPEED';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'memcpy';
     Location: 15;
     Params: '(dest : pointer; const src : pointer; size : size_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'memset';
     Location: 15;
     Params: '(s : pointer; c : int; n : size_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'MIN_SPEED';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'MM_BLOCK_FREE';
     Location: 28;
     Params: '(addr)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'MM_BLOCK_RESERVED';
     Location: 28;
     Params: '(addr)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'mm_first_free';
     Location: 28;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'MM_FREE';
     Location: 28;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'mm_free_mem';
     Location: 28;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'MM_HEADER_SIZE';
     Location: 28;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'mm_init';
     Location: 28;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'mm_reaper';
     Location: 28;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'MM_RESERVED';
     Location: 28;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'MM_SPLIT_THRESH';
     Location: 28;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'mm_start';
     Location: 28;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'motor_%_dir';
     Location: 7;
     Params: '(dir : MotorDirection)';
     Count: 3;
     Alpha: atLower
    ),
    (
     Kind: ckAPIFunc;
     Name: 'motor_%_speed';
     Location: 7;
     Params: '(speed : unsigned_char)';
     Count: 3;
     Alpha: atLower
    ),
    (
     Kind: ckAPIVar;
     Name: 'motor_controller';
     Location: 23;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'MSECS_TO_TICKS';
     Location: 17;
     Params: '(ms : unsigned_long)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'msg_received';
     Location: 38;
     Params: '(wakeup_t m)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'msleep';
     Location: 19;
     Params: '(msec : unsigned_int)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'nb_system_tasks';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'nb_tasks';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'NULL';
     Location: 10;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'mdOff';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_A%';
     Location: 9;
     Params: '';
     Count: 9;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_Am%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_C%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_Cm%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_D%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_Dm%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_E%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_END';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_F%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_Fm%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_G%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_Gm%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_H%';
     Location: 9;
     Params: '';
     Count: 8;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_MAX';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PITCH_PAUSE';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'PORT%';
     Location: 26;
     Params: '';
     Count: 7;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIVar;
     Name: 'PORT%_DDR';
     Location: 26;
     Params: '';
     Count: 6;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIVar;
     Name: 'PORT%_PCR';
     Location: 26;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIFunc;
     Name: 'power_init';
     Location: 37;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'power_off';
     Location: 37;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'PRESSED';
     Location: 3;
     Params: '(state : unsigned; button : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PRIO_HIGHEST';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PRIO_LOWEST';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PRIO_NORMAL';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'PROG_MAX';
     Location: 29;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'program_init';
     Location: 29;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'program_shutdown';
     Location: 29;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'program_stop';
     Location: 29;
     Params: '(flag : int)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'program_valid';
     Location: 29;
     Params: '(nr : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'QUARTER';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'random';
     Location: 14;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'RELEASED';
     Location: 3;
     Params: '(state : unsigned; button : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'reset';
     Location: 37;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'mdRev';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'rom_dummy_handler';
     Location: 40;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'rom_ocia_handler';
     Location: 40;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'rom_ocia_return';
     Location: 40;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'rom_port%_ddr';
     Location: 35;
     Params: '';
     Count: 6;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIVar;
     Name: 'rom_port7_pin';
     Location: 35;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'rom_reset';
     Location: 37;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'rom_reset_vector';
     Location: 40;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'ROTATION_%';
     Location: 8;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIVar;
     Name: 'S_BRR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'S_CR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'S_MR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'S_RDR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'S_SR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'S_TCR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'S_TDR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_s%_active';
     Location: 34;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_s%_select';
     Location: 34;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCL';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCR_CLOCK_OUT';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCR_EXT_CLOCK';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCR_INT_CLOCK';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCR_MP_IRQ';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCR_RECEIVE';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCR_RX_IRQ';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCR_TE_IRQ';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCR_TRANSMIT';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SCR_TX_IRQ';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SDA';
     Location: 27;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'SECS_TO_TICKS';
     Location: 17;
     Params: '(s : unsigned_long)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_destroy';
     Location: 13;
     Params: '(sem : psem_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_getvalue';
     Location: 13;
     Params: '(sem : psem_t; sval : pint)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_init';
     Location: 13;
     Params: '(sem : psem_t; pshared : int; value : unsigned_int)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_post';
     Location: 13;
     Params: '(sem : psem_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_trywait';
     Location: 13;
     Params: '(sem : psem_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_wait';
     Location: 13;
     Params: '(sem : psem_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'send_msg';
     Location: 38;
     Params: '(unsigned char msg)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'SENSOR_%';
     Location: 8;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIVar;
     Name: 'SENSOR_%';
     Location: 8;
     Params: '';
     Count: 3;
     Alpha: atNumeric1Upper
    ),
    (
     Kind: ckAPIFunc;
     Name: 'shutdown_requested';
     Location: 18;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'shutdown_task';
     Location: 19;
     Params: '(tid : tid_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'shutdown_tasks';
     Location: 19;
     Params: '(flags : tflags_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'shutoff_init';
     Location: 31;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'shutoff_restart';
     Location: 31;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'lns_sign';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sleep';
     Location: 19;
     Params: '(sec : unsigned_int)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_%STOP';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_7BIT';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_8BIT';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_ASYNC';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_CLOCK';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_CLOCK_16';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_CLOCK_4';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_CLOCK_64';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_MP';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_P_EVEN';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_P_NONE';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_P_ODD';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SMR_SYNC';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sound_playing';
     Location: 36;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sound_system';
     Location: 36;
     Params: '(unsigned nr)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SP_RETURN_OFFSET';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'srandom';
     Location: 14;
     Params: '(seed : unsigned_int)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SSR_ERRORS';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SSR_FRAMING_ERR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SSR_MP';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SSR_MP_TRANSFER';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SSR_OVERRUN_ERR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SSR_PARITY_ERR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SSR_RECV_FULL';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SSR_TRANS_EMPTY';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SSR_TRANS_END';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'STCR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'strcmp';
     Location: 15;
     Params: '(const s1 : pchar; const s2 : pchar)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'strcpy';
     Location: 15;
     Params: '(dest : pchar; const src : pchar)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'strlen';
     Location: 15;
     Params: '(const s : pchar)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'get_system_up_time';
     Location: 17;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'SYSCR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'SYSCR_SOFTWARE_STANDBY';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'systime_init';
     Location: 17;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'systime_set_switcher';
     Location: 17;
     Params: '(switcher : pointer)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'systime_set_timeslice';
     Location: 17;
     Params: '(slice : unsigned_char)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'systime_shutdown';
     Location: 17;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'systime_tm_return';
     Location: 17;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T_CNT';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T_CR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T_CSR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'T_DEAD';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T_ICR%';
     Location: 26;
     Params: '';
     Count: 4;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'T_IDLE';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T_IER';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'T_KERNEL';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T_OCR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T_OCR%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'T_RUNNING';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'T_SHUTDOWN';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'T_SLEEPING';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'T_USER';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'T_WAITING';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'T_ZOMBIE';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T%_CNT';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T%_CORA';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T%_CORB';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T%_CR';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'T%_CSR';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCR_%_RISING';
     Location: 26;
     Params: '';
     Count: 4;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCR_BUFFER_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCR_CLOCK_2';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCR_CLOCK_32';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCR_CLOCK_8';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCR_CLOCK_EXT';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCSR_IC%';
     Location: 26;
     Params: '';
     Count: 4;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCSR_OC%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCSR_OF';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TCSR_RESET_ON_A';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'td_single';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TICK_IN_MS';
     Location: 17;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'TICKS_PER_SEC';
     Location: 17;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TIER_ENABLE_IC%';
     Location: 26;
     Params: '';
     Count: 4;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'TIER_ENABLE_OC%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'TIER_ENABLE_OF';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TIER_RESERVED';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TM_DEFAULT_SLICE';
     Location: 17;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_idle_task';
     Location: 18;
     Params: '(i : integer; c : PPChar)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_init';
     Location: 18;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_scheduler';
     Location: 18;
     Params: '(old_sp : Psize_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_start';
     Location: 18;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_switcher';
     Location: 18;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'tm_timeslice';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TOCR_ENABLE_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'TOCR_HIGH_LEVEL_%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIConst;
     Name: 'TOCR_OCR%';
     Location: 26;
     Params: '';
     Count: 2;
     Alpha: atUpper
    ),
    (
     Kind: ckAPIFunc;
     Name: 'TOUCH';
     Location: 8;
     Params: '(a : unsigned)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'TOUCH_%';
     Location: 8;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'TX_ACTIVE';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TX_COLL';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TX_IDLE';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'tx_state';
     Location: 42;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'txend_handler';
     Location: 42;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ls_unknown_1';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'lns_unsign';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'VELOCITY_%';
     Location: 8;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIFunc;
     Name: 'vis_handler';
     Location: 33;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'wait_critical_section';
     Location: 2;
     Params: '(data : wakeup_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'wait_event';
     Location: 19;
     Params: '(wakeup : wakeupPtr; data : wakeup_t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'WDT_CNT';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CNT_CLEAR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CNT_MSEC_64';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CNT_PASSWORD';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'WDT_CSR';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_CLOCK_128';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_CLOCK_2';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_CLOCK_2048';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_CLOCK_256';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_CLOCK_32';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_CLOCK_4096';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_CLOCK_512';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_CLOCK_64';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_ENABLE';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_MODE_OVERFLOW';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_MODE_WATCHDOG';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_PASSWORD';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_WATCHDOG_NMI';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WDT_CSR_WATCHDOG_RES';
     Location: 26;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'WHOLE';
     Location: 9;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'yield';
     Location: 19;
     Params: '()';
     Count: 1;
     Alpha: atNumeric
    )
  );

implementation

end.
