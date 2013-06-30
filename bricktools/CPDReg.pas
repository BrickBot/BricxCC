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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit CPDReg;

interface

procedure Register;

implementation

uses
  // Delphi units
  Classes,
  // ComDrv32 units
  CPDrv,
  // syn edit terminal
  SynTerm;

{$R ComDrv32.dcr}

const
  TargetTab = 'Communication';

procedure Register;
begin
  RegisterComponents( TargetTab, [CPDrv.TCommPortDriver, CPDrv.TUSBPortDriver, SynTerm.TSynTerm]);
end;

end.