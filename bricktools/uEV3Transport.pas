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
 * Portions created by John Hansen are Copyright (C) 2012-2103 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uEV3Transport;

interface

uses
  Classes;

type
  TEV3Data = array of byte;
  IEV3Transport = interface(IInterface)
    ['{2825BB5A-7278-40E2-A87C-464C2198919F}']
    function GetMaxMessageSize : integer;
    function GetSerialNumber : string;
    function GetUserVisibleType : string;

    procedure Close;
    function Open : boolean;
    function IsOpen : boolean;
    function SendMessage(SequenceId : Word; var Buffer : TEV3Data) : integer;
    function SendStream(SequenceId : Word; aStream : TStream) : integer;
    function ReceiveMessage(var Buffer : TEV3Data; Timeout : Word; Id : Word) : Word;

    property MaxMessageSize : integer read GetMaxMessageSize;
    property SerialNumber : string read GetSerialNumber;
    property UserVisibleType : string read GetUserVisibleType;
  end;

  TEV3NullTransport = class(TInterfacedObject, IEV3Transport)
  public
    function GetMaxMessageSize : integer;
    function GetSerialNumber : string;
    function GetUserVisibleType : string;

    procedure Close;
    function Open : boolean;
    function IsOpen : boolean;
    function SendMessage(SequenceId : Word; var Buffer : TEV3Data) : integer;
    function SendStream(SequenceId : Word; aStream : TStream) : integer;
    function ReceiveMessage(var Buffer : TEV3Data; Timeout : Word; Id : Word) : Word;
  end;

implementation

{ TEV3NullTransport }

procedure TEV3NullTransport.Close;
begin
  // nothing to close;
end;

function TEV3NullTransport.Open: boolean;
begin
  // cannot be opened
  Result := False;
end;

function TEV3NullTransport.IsOpen: boolean;
begin
  // cannot be opened
  Result := False;
end;

function TEV3NullTransport.ReceiveMessage(var Buffer: TEV3Data; Timeout: Word; Id : Word): Word;
begin
  Result := 0;
  if not IsOpen then
    Exit;
end;

function TEV3NullTransport.SendMessage(SequenceId: Word; var Buffer: TEV3Data): integer;
begin
  Result := 0;
  if not IsOpen then
    Exit;
end;

function TEV3NullTransport.GetMaxMessageSize: integer;
begin
  Result := 0;
end;

function TEV3NullTransport.GetSerialNumber: string;
begin
  Result := '0';
end;

function TEV3NullTransport.GetUserVisibleType: string;
begin
  Result := 'NULL';
end;

function TEV3NullTransport.SendStream(SequenceId: Word;
  aStream: TStream): integer;
begin
  Result := 0;
  if not IsOpen then
    Exit;
end;

end.
