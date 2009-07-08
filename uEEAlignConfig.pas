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
 * Portions of this code are covered under the GExperts license
 * http://www.gexperts.org/license.html
 *
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uEEAlignConfig;

interface

uses
  Classes, Controls, StdCtrls, Forms, BricxccSpin;

type
  TfrmAlignOptions = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbxTokens: TGroupBox;
    gbxOptions: TGroupBox;
    lblWhitespace: TLabel;
    mmoTokens: TMemo;
    edtWhitespace: TBricxccSpinEdit;
  end;

implementation

{$R *.dfm}

end.
