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
 * Portions created by John Hansen are Copyright (C) 2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit VisaDefs;

interface

type
{$IFDEF FPC}
// for FPC we need a different type for 64 bit vs 32 bit.
  {$ifdef CPU32}
  VisaHandle = Cardinal;
  ViObject = Cardinal;
  ViAttr = Cardinal;
  ViAttrState = Cardinal;
  ViStatus = Integer;
  ViJobId = Cardinal;
  {$endif}
  {$ifdef CPU64}
  VisaHandle = QWord;
  ViObject = QWord;
  ViAttr = QWord;
  ViAttrState = QWord;
  ViStatus = QWord; // wrong
  {$endif}
{$ELSE}
// delphi
  VisaHandle = Cardinal;
  ViObject = Cardinal;
  ViAttr = Cardinal;
  ViAttrState = Cardinal;
  ViStatus = Integer;
  ViJobId = Cardinal;
{$ENDIF}

implementation

end.
