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
unit uCppCodeComp;

interface

uses
  uCppCode;

const
  CppCodeCompDataSize = 571;
  CppCodeCompData: array[0..CppCodeCompDataSize-1] of TCppCodeComp = (
    (
     Kind: ckAPIType;
     Name: '__persistent';
     Location: 11;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: '%_left';
     Location: 34;
     Params: '';
     Count: 3;
     Alpha: atLower
    ),
    (
     Kind: ckAPIConst;
     Name: '%_right';
     Location: 34;
     Params: '';
     Count: 3;
     Alpha: atLower
    ),
    (
     Kind: ckAPIConst;
     Name: '%_select';
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
     Params: '(void)';
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'battery_x';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_clear';
     Location: 21;
     Params: '(byte,bit)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_iload';
     Location: 21;
     Params: '(mask,bit)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_load';
     Location: 21;
     Params: '(mask,bit)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'BIT_OF';
     Location: 6;
     Params: '(a,b)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_set';
     Location: 21;
     Params: '(byte,bit)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'bit_store';
     Location: 21;
     Params: '(byte,bit)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'bool';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'brake';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'break';
     Location: 0;
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
     Name: 'BYTE_OF';
     Location: 6;
     Params: '(a,b)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'calloc';
     Location: 14;
     Params: '(size_t nmemb, size_t size)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'case';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'char';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'circle';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'class';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'clear_msg';
     Location: 38;
     Params: '(void)';
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
     Kind: ckKeyword;
     Name: 'const';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'continue';
     Location: 0;
     Params: '';
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
     Params: '(char c, int pos)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_%';
     Location: 1;
     Params: '(unsigned c)';
     Count: 6;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_hex';
     Location: 1;
     Params: '(char c, int pos)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_hex_%';
     Location: 1;
     Params: '(unsigned nibble)';
     Count: 6;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_native';
     Location: 1;
     Params: '(char mask, int pos)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputc_native_%';
     Location: 1;
     Params: '(char mask)';
     Count: 6;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputs';
     Location: 1;
     Params: '(char *s)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'cputw';
     Location: 1;
     Params: '(unsigned word)';
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
     Kind: ckAPIType;
     Name: 'critsec_t';
     Location: 2;
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'default';
     Location: 0;
     Params: '';
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
     Params: '(unsigned ms)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'destroy_critical_section';
     Location: 2;
     Params: '(cs)';
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
     Name: 'digit';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'digit_comma';
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
     Params: '(wakeup_t data)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dkey_released';
     Location: 5;
     Params: '(wakeup_t data)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dlcd_hide';
     Location: 6;
     Params: '(a)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dlcd_show';
     Location: 6;
     Params: '(a)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dlcd_store';
     Location: 6;
     Params: '(a)';
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dm_shutdown';
     Location: 23;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'do';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'dot';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'dot_inv';
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
     Params: '(volatile unsigned *sensor)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_init';
     Location: 24;
     Params: '(void)';
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
     Params: '(volatile unsigned *sensor)';
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
     Params: '(volatile unsigned *sensor)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_rotation_on';
     Location: 8;
     Params: '(volatile unsigned *sensor)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_rotation_set';
     Location: 8;
     Params: '(volatile unsigned *sensor, int pos)';
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
     Params: '(x)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_shutdown';
     Location: 24;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'ds_unscale';
     Location: 8;
     Params: '(x)';
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
     Params: '(wakeup_t data)';
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
     Params: '(const note_t *notes)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_playing';
     Location: 9;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_set_duration';
     Location: 9;
     Params: '(unsigned duration)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'dsound_set_internote';
     Location: 9;
     Params: '(unsigned duration)';
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
     Params: '(void)';
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
     Params: '(unsigned nr)';
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
     Name: 'e_%';
     Location: 34;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 'e0';
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
     Kind: ckKeyword;
     Name: 'else';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'enter_critical_section';
     Location: 2;
     Params: '(critsec_t* cs)';
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
     Kind: ckKeyword;
     Name: 'enum';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'EventType';
     Location: 12;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'everything';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'execi';
     Location: 19;
     Params: '(int (*code_start) (int, char **), int argc, char **argv, priority_t priority, size_t stack_size)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'exit';
     Location: 19;
     Params: '(int code)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'extern';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'for';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'free';
     Location: 14;
     Params: '(void *ptr)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'fwd';
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
     Params: '(void)';
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
     Kind: ckKeyword;
     Name: 'goto';
     Location: 0;
     Params: '';
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
     Location: 32;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'if';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'initialize_critical_section';
     Location: 2;
     Params: '(cs)';
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
     Kind: ckKeyword;
     Name: 'int';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ir_full';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'ir_half';
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
     Params: '(tid_t tid)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'killall';
     Location: 19;
     Params: '(priority_t p)';
     Count: 1;
     Alpha: atNumeric
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
     Name: 'LCD_1LEG';
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
     Name: 'LCD_2LEGS';
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
     Name: 'LCD_ARMS';
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
     Name: 'LCD_BODY';
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_clock';
     Location: 34;
     Params: '(t)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'lcd_comma_style';
     Location: 34;
     Params: '';
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
     Params: '(d)';
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
     Params: '(lcd_segment segment)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_init';
     Location: 27;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_int';
     Location: 34;
     Params: '(i)';
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
     Params: '(int i, lcd_number_style n, lcd_comma_style c)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'lcd_number_style';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_power_off';
     Location: 27;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_power_on';
     Location: 27;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_refresh';
     Location: 27;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_refresh_next_byte';
     Location: 27;
     Params: '(void)';
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
     Kind: ckAPIType;
     Name: 'lcd_segment';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
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
     Params: '(lcd_segment segment)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lcd_unsigned';
     Location: 34;
     Params: '(u)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'leave_critical_section';
     Location: 2;
     Params: '(cs)';
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
     Params: '(a)';
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
     Kind: ckAPIType;
     Name: 'lnp_addressing_handler_t';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_addressing_set_handler';
     Location: 38;
     Params: '(unsigned char port, lnp_addressing_handler_t handler)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_addressing_write';
     Location: 38;
     Params: '(const unsigned char *data,unsigned char length, unsigned char dest,unsigned char srcport)';
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_active';
     Location: 41;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_byte';
     Location: 41;
     Params: '(unsigned char b)';
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
     Kind: ckAPIType;
     Name: 'lnp_integrity_handler_t';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_reset';
     Location: 41;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_set_handler';
     Location: 38;
     Params: '(lnp_integrity_handler_t handler)';
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
     Kind: ckAPIType;
     Name: 'lnp_integrity_state_t';
     Location: 41;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_integrity_write';
     Location: 38;
     Params: '(const unsigned char *data,unsigned char length)';
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_init';
     Location: 42;
     Params: '(void)';
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
     Params: '(int far)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_range_is_far';
     Location: 39;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_shutdown';
     Location: 42;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_logical_write';
     Location: 39;
     Params: '(const void *buf,size_t len)';
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
     Kind: ckAPIType;
     Name: 'lnp_remote_handler_t';
     Location: 38;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_remote_set_handler';
     Location: 38;
     Params: '(lnp_remote_handler_t handler)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_set_hostaddr';
     Location: 38;
     Params: '(unsigned char host)';
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_timeout_set';
     Location: 41;
     Params: '(unsigned short timeout)';
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
     Params: '(unsigned char* counter)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'locked_increment';
     Location: 22;
     Params: '(unsigned char* counter)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'long';
     Location: 0;
     Params: '';
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
     Kind: ckAPIType;
     Name: 'lr_handler_t';
     Location: 12;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lr_init';
     Location: 12;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lr_set_handler';
     Location: 12;
     Params: '(lr_handler_t handler)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lr_shutdown';
     Location: 12;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lr_startup';
     Location: 12;
     Params: '(void)';
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
     Params: '(size_t size)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'man_run';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'man_stand';
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
     Params: '(void *dest, const void *src, size_t size)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'memset';
     Location: 15;
     Params: '(void *s, int c, size_t n)';
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
     Params: '(void)';
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
     Params: '(MotorDirection dir)';
     Count: 3;
     Alpha: atLower
    ),
    (
     Kind: ckAPIFunc;
     Name: 'motor_%_speed';
     Location: 7;
     Params: '(unsigned char speed)';
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
     Kind: ckAPIType;
     Name: 'MotorDirection';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'MotorState';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'MSECS_TO_TICKS';
     Location: 17;
     Params: '(a)';
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
     Params: '(unsigned int msec)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'nb_system_tasks';
     Location: 32;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'nb_tasks';
     Location: 32;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'note_t';
     Location: 9;
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
     Name: 'off';
     Location: 7;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'packet_cmd_t';
     Location: 29;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'pchain_t';
     Location: 18;
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'power_off';
     Location: 37;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'PRESSED';
     Location: 3;
     Params: '(state,button)';
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
     Kind: ckAPIType;
     Name: 'priority_t';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'private';
     Location: 0;
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
     Params: '(int flag)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'program_t';
     Location: 29;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'program_valid';
     Location: 29;
     Params: '(unsigned nr)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'protected';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'public';
     Location: 0;
     Params: '';
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'RELEASED';
     Location: 3;
     Params: '(state,button)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'reset';
     Location: 37;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'return';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'rev';
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
     Params: '(void)';
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
     Name: 's%_active';
     Location: 34;
     Params: '';
     Count: 3;
     Alpha: atNumeric1
    ),
    (
     Kind: ckAPIConst;
     Name: 's%_select';
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
     Params: '(a)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_destroy';
     Location: 13;
     Params: '(sem_t * sem)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_getvalue';
     Location: 13;
     Params: '(sem_t * sem, int *sval)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_init';
     Location: 13;
     Params: '(sem_t * sem, int pshared, unsigned int value)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_post';
     Location: 13;
     Params: '(sem_t * sem)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'sem_t';
     Location: 13;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_trywait';
     Location: 13;
     Params: '(sem_t * sem)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sem_wait';
     Location: 13;
     Params: '(sem_t * sem)';
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
     Kind: ckKeyword;
     Name: 'short';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
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
     Params: '(tid_t tid)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'shutdown_tasks';
     Location: 19;
     Params: '(tflags_t flags)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'shutoff_init';
     Location: 31;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'shutoff_restart';
     Location: 31;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'sign';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'size_t';
     Location: 10;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'sleep';
     Location: 19;
     Params: '(unsigned int sec)';
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
     Params: '(void)';
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
     Location: 32;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'srandom';
     Location: 14;
     Params: '(unsigned int seed)';
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
     Params: '(const char *s1, const char *s2)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'strcpy';
     Location: 15;
     Params: '(char *dest, const char *src)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'strlen';
     Location: 15;
     Params: '(const char *s)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'struct';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'switch';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'get_system_up_time';
     Location: 17;
     Params: '(void)';
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
     Location: 30;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'systime_set_switcher';
     Location: 30;
     Params: '(void* switcher)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'systime_set_timeslice';
     Location: 30;
     Params: '(unsigned char slice)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'systime_shutdown';
     Location: 30;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'systime_tm_return';
     Location: 30;
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
     Location: 32;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'tdata_t';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'tflags_t';
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
     Kind: ckAPIType;
     Name: 'tid_t';
     Location: 18;
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
     Kind: ckAPIType;
     Name: 'time_t';
     Location: 17;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'TM_DEFAULT_SLICE';
     Location: 30;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_idle_task';
     Location: 32;
     Params: '(int,char**)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_init';
     Location: 32;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_scheduler';
     Location: 32;
     Params: '(size_t *old_sp)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_start';
     Location: 32;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'tm_switcher';
     Location: 32;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIVar;
     Name: 'tm_timeslice';
     Location: 32;
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
     Params: '(a)';
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
     Kind: ckAPIType;
     Name: 'tstate_t';
     Location: 18;
     Params: '';
     Count: 1;
     Alpha: atNumeric
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'typedef';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'unknown_1';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIConst;
     Name: 'unsign';
     Location: 34;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'unsigned';
     Location: 0;
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
     Kind: ckKeyword;
     Name: 'virtual';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'vis_handler';
     Location: 33;
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'void';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'wait_critical_section';
     Location: 2;
     Params: '(wakeup_t data)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'wait_event';
     Location: 19;
     Params: '(wakeup_t(*wakeup) (wakeup_t), wakeup_t data)';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIType;
     Name: 'wakeup_t';
     Location: 18;
     Params: '';
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
     Kind: ckKeyword;
     Name: 'while';
     Location: 0;
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
     Params: '(void)';
     Count: 1;
     Alpha: atNumeric
    )
{
    (
     Kind: ckKeyword;
     Name: 'ad_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'cmi%a_vector';
     Location: 0;
     Params: '';
     Count: 2;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'cmi%b_vector';
     Location: 0;
     Params: '';
     Count: 2;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'eri_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'fovi_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'ici%_vector';
     Location: 0;
     Params: '';
     Count: 4;
     Alpha: atLower
    ),
    (
     Kind: ckAPIVar;
     Name: 'irq%_vector';
     Location: 0;
     Params: '';
     Count: 3;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'nmi_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'ocia_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'ocib_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'ovi0_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'ovi1_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'reset_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'rxi_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'tei_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'txi_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'wovf_vector';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'disable_irqs';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckKeyword;
     Name: 'enable_irqs';
     Location: 0;
     Params: '';
     Count: 1;
     Alpha: atNumeric
    ),
    (
     Kind: ckAPIFunc;
     Name: 'lnp_checksum_copy';
     Location: 41;
     Params: '( unsigned char *dest, const unsigned char *data, unsigned length )';
     Count: 1;
     Alpha: atNumeric
    ),
}
  );

const
  UnitNamesSize = 53;
  UnitNames: array[0..UnitNamesSize-1] of string = (
    '',
    '<conio.h>',            // 1
    '<critsec.h>',          // 2
    '<dbutton.h>',          // 3
    '<dirpd.h>',            // 4
    '<dkey.h>',             // 5
    '<dlcd.h>',             // 6
    '<dmotor.h>',           // 7
    '<dsensor.h>',          // 8
    '<dsound.h>',           // 9
    '<mem.h>',              // 10
    '<persistent.h>',       // 11
    '<remote.h>',           // 12
    '<semaphore.h>',        // 13
    '<stdlib.h>',           // 14
    '<string.h>',           // 15
    '<swmux.h>',            // 16
    '<time.h>',             // 17
    '<tm.h>',               // 18
    '<unistd.h>',           // 19
    '<sys/battery.h>',      // 20
    '<sys/bitops.h>',       // 21
    '<sys/critsec.h>',      // 22
    '<sys/dmotor.h>',       // 23
    '<sys/dsensor.h>',      // 24
    '<sys/dsound.h>',       // 25
    '<sys/h8.h>',           // 26
    '<sys/lcd.h>',          // 27
    '<sys/mm.h>',           // 28
    '<sys/program.h>',      // 29
    '<sys/time.h>',         // 30
    '<sys/timeout.h>',      // 31
    '<sys/tm.h>',           // 32
    '<sys/vis.h>',          // 33
    '<rom/lcd.h>',          // 34
    '<rom/registers.h>',    // 35
    '<rom/sound.h>',        // 36
    '<rom/system.h>',       // 37
    '<lnp/lnp.h>',          // 38
    '<lnp/lnp-logical.h>',  // 39
    '<lnp/sys/irq.h>',      // 40
    '<lnp/sys/lnp.h>',      // 41
    '<lnp/sys/lnp-logical.h>', // 42
    '<c++/Battery.H>',      // 43
    '<c++/Lamp.H>',         // 44
    '<c++/LightSensor.H>',  // 45
    '<c++/Motor.H>',        // 46
    '<c++/MotorPair.H>',    // 47
    '<c++/RotationSensor.H>', // 48
    '<c++/Sensor.H>',       // 49
    '<c++/Sound.H>',        // 50
    '<c++/TemperatureSensor.H>', // 51
    '<c++/TouchSensor.H>'   // 52
  );

implementation

end.