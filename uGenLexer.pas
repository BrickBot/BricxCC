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
unit uGenLexer;

interface

uses
  mwGenericLex;

type
  TGenLexer = class(TmwGenLex)
  protected
    procedure InitForLanguage(Lex: TGenLexer); virtual; abstract;
  public
    constructor CreateLexer; virtual;
  end;

  TGenLexerClass = class of TGenLexer;


implementation

{ TGenLexer }

constructor TGenLexer.CreateLexer;
begin
  inherited Create;
  Sensitive := True;
  Clear;
  InitMainSelector;
  InitForLanguage(Self);
end;

end.