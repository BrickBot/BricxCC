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
 * The Initial Developer of this code is Mark Overmars.
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit Translate;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
  SynEdit;

procedure TranslateIt(TheEditor: TSynEdit);

implementation

uses
  SysUtils, Dialogs, Controls, Editor, uLocalizedStrings;

const MAXWORD = 48;

var oldwords: array[1..MAXWORD] of string =
  (
   'inline',
   'wait',

   'Sensor',
   'SensorMode',
   'SensorType',
   'OutputMode',
   'OutputDir',
   'OutputPower',
   'Fwd',
   'Rev',
   'PlayNote',
   'Sleep',
   'Display',
   'SetDatalog',
   'Datalog',
   'IRMode',

   'Input',
   'InputType',
   'InputMode',
   'InputRaw',
   'InputBool',

   'IN_1',
   'IN_2',
   'IN_3',
   'SMODE_RAW',
   'SMODE_BOOL',
   'SMODE_EDGE',
   'SMODE_PULSE',
   'SMODE_PERCENT',
   'SMODE_CELSIUS',
   'SMODE_FAHRENHEIT',
   'SMODE_ANGLE',
   'STYPE_SWITCH',
   'STYPE_TEMP',
   'STYPE_LIGHT',
   'STYPE_ANGLE',
   'IN_SWITCH',
   'IN_LIGHT',
   'IN_ANGLE',
   'IN_PULSE',
   'IN_EDGE',
   'OUT_FLIP',
   'IR_LO',
   'IR_HI',
   'IN_L',
   'IN_M',
   'IN_R',
   'IN_CFG'
  );
var newwords: array[1..MAXWORD] of string =
  (
   'void',
   'until',

   'SetSensor',
   'SetSensorMode',
   'SetSensorType',
   'SetOutput',
   'SetDirection',
   'SetPower',
   'OldFwd',
   'OldRev',
   'PlayTone',
   'Wait',
   'SelectDisplay',
   'CreateDatalog',
   'AddToDatalog',
   'SetTxPower',

   'SensorValue',
   'SensorType',
   'SensorMode',
   'SensorValueRaw',
   'SensorValueBool',

   'SENSOR_1',
   'SENSOR_2',
   'SENSOR_3',
   'SENSOR_MODE_RAW',
   'SENSOR_MODE_BOOL',
   'SENSOR_MODE_EDGE',
   'SENSOR_MODE_PULSE',
   'SENSOR_MODE_PERCENT',
   'SENSOR_MODE_CELSIUS',
   'SENSOR_MODE_FAHRENHEIT',
   'SENSOR_MODE_ROTATION',
   'SENSOR_TYPE_TOUCH',
   'SENSOR_TYPE_TEMPERATURE',
   'SENSOR_TYPE_LIGHT',
   'SENSOR_TYPE_ROTATION',
   'SENSOR_TOUCH',
   'SENSOR_LIGHT',
   'SENSOR_ROTATION',
   'SENSOR_PULSE',
   'SENSOR_EDGE',
   'OUT_TOGGLE',
   'TX_POWER_LO',
   'TX_POWER_HI',
   'SENSOR_L',
   'SENSOR_M',
   'SENSOR_R',
   '_SENSOR_CFG'
  );


function IsKeyChar(ch:char):boolean;
{Returns whether ch is a character in a keyword name}
begin
  IsKeyChar :=
      ((ch>= 'a') and (ch<= 'z')) or
      ((ch>= 'A') and (ch<= 'Z')) or
      ((ch>= '0') and (ch<= '9')) or
      (ch = '_');
end;

function TranslateWord(str:string):string;
{Translates the word}
var i:integer;
begin
  Result := str;
  for i:=1 to MAXWORD do
    if CompareStr(str,oldwords[i]) = 0 then
      begin Result:=newwords[i]; Exit; end;
end;

var is_comment:boolean = false;
    add_brackets:boolean = false;

procedure TranslateLine(Ed:TSynEdit; l:integer);
{Translate line l}
var
  curpos:integer;       {Current position in the line}
  str:string;           {Copy of the current line}
  str2,str3:string;     {Temporary string}
  ttt:integer;          {Temporary index}
begin
  if Ed.ReadOnly then Exit;
  if (l<0) or (l>=Ed.Lines.Count) then Exit;
  str:=Ed.Lines[l];

  {Handle the line}
  curpos:=1;
  while curpos <= Length(str) do
  begin
    {Check for comment}
    if (curpos<Length(str)) and (str[curpos] = '*') and (str[curpos+1] = '/') then
      begin curpos := curpos+2; Is_Comment := false; end
    else if (curpos<Length(str)) and (str[curpos] = '/') and (str[curpos+1] = '*') then
      begin curpos := curpos+2; Is_Comment := true; end
    else if (Is_Comment) then
      curpos := curpos+1
    else if (curpos<Length(str)) and (str[curpos] = '/') and (str[curpos+1] = '/') then
      curpos := Length(str)+1
    else if IsKeyChar(str[curpos]) then
    begin
      ttt:=curpos;
      str2:='';
      while (curpos <= Length(str)) and IsKeyChar(str[curpos]) do
        begin  str2:=str2+str[curpos]; curpos:=curpos+1; end;
      str3:=TranslateWord(str2);
      Delete(str,ttt,curpos-ttt);
      Insert(str3,str,ttt);
      if (CompareStr(str3,'task') = 0) or
         (CompareStr(str3,'sub') = 0) or
         (CompareStr(str3,'void') = 0) then
           Add_Brackets := true
      else if Add_Brackets then
      begin
        Add_Brackets := false;
        Insert('()',str,ttt+ Length(str3));
      end;
      curpos := ttt+ Length(str3)+1;
    end
    else
      curpos := curpos+1;
  end;
  Ed.Lines[l] := str;
end;

procedure TranslateIt(TheEditor: TSynEdit);
var i:integer;
begin
  if MessageDlg(S_TRANSLATE,
                mtConfirmation,
                [mbOK,mbCancel],0) = mrCancel then Exit;
  for i:=0 to TheEditor.Lines.Count-1 do
    TranslateLine(TheEditor,i);
  TheEditor.Lines.Insert(0,'#pragma noinit');
  TheEditor.Lines.Insert(1,'#define OldFwd(a,b)   do {OnFwd(a); SetPower(a,b);} while (false)');
  TheEditor.Lines.Insert(2,'#define OldRev(a,b)   do {OnRev(a); SetPower(a,b);} while (false)');
  TheEditor.Lines.Insert(3,'');
end;

end.