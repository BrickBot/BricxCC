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
unit uBricxCCProcLexer;

interface

uses
  Classes, uParseCommon;

type
  TProcRec = record
    LineNum : Integer;
    ProcName : string;
  end;
  PProcRec = ^TProcRec;

  TBricxCCProcLexer = class(TThread)
  private
    { Private declarations }
    FTextToParse: string;
    FResults: string;
    fTimeout: Integer;
  protected
    function GetLanguage: TExploredLanguage; virtual; abstract;
  public
    property TextToParse : string read FTextToParse write FTextToParse;
    property Results : string read FResults write FResults;
    property Timeout : Integer read fTimeout write fTimeout;
    property Language : TExploredLanguage read GetLanguage;
  end;

  TUnknownProcLexer = class(TBricxCCProcLexer)
  protected
    procedure Execute; override;
    function GetLanguage: TExploredLanguage; override;
  end;



implementation

{ TUnknownProcLexer }

procedure TUnknownProcLexer.Execute;
begin
  Results := '';
end;

function TUnknownProcLexer.GetLanguage: TExploredLanguage;
begin
  Result := elUnknown;
end;

end.