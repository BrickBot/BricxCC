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
unit link;

interface

uses
  Classes;
  
type
  TLink = class
  public
    procedure open; virtual; abstract;
    procedure close; virtual; abstract;
    function read(ptr : Pointer; maxLength : integer) : integer; virtual; abstract;
    function write(ptr : Pointer; count : integer) : integer; virtual; abstract;
  end;

  { TUSBLink }

  TUSBLink = class(TLink)
  private
    fName : string;
//    fDevice : PUSBDevice;
//    fInterface : PUSBInterface;
    function openDevice(vendorID, producID : word) : integer;
    function configure(config : integer) : integer;
    function openInterface : integer;
  public
    constructor Create(name : string); virtual;
    destructor Destroy; override;
    procedure open; override;
    procedure close; override;
    function read(ptr : Pointer; maxLength : integer) : integer; override;
    function write(ptr : Pointer; count : integer) : integer; override;
  end;

  { TSerialLink }

  TSerialLink = class(TLink)
  private
    fName : string;
    fHandle : integer;
    function readTO(ptr : Pointer; length, timeoutMS : integer) : integer;
  public
    constructor Create(name : string); virtual;
    destructor Destroy; override;
    procedure open; override;
    procedure close; override;
    function read(ptr : Pointer; maxLength : integer) : integer; override;
    function write(ptr : Pointer; count : integer) : integer; override;
  end;

implementation

uses
  termio, time;

{ TUSBLink }

function TUSBLink.openDevice(vendorID, producID: word): integer;
begin

end;

function TUSBLink.configure(config: integer): integer;
begin

end;

function TUSBLink.openInterface: integer;
begin

end;

constructor TUSBLink.Create(name: string);
begin

end;

destructor TUSBLink.Destroy;
begin
  close;
  inherited Destroy;
end;

procedure TUSBLink.open;
begin

end;

procedure TUSBLink.close;
begin

end;

function TUSBLink.read(ptr: Pointer; maxLength: integer): integer;
begin

end;

function TUSBLink.write(ptr: Pointer; count: integer): integer;
begin

end;

{ TSerialLink }

function setTermiosSpeed(fd : integer; var tios : Termios; speed : integer) : boolean;
var
  s : Cardinal;
begin
  Result := False;
  case speed of
    2400 : s := B2400;
    4800 : s := B4800;
    9600 : s := B9600;
  else
    Exit;
  end;
  cfsetispeed(tios, s);
  cfsetospeed(tios, s);
  Result := True;
end;

const
  NOTPARENB = $11110111;

function setSpeed(fd, speed, opts : integer) : boolean;
var
  tios : Termios;
begin
  Result := False;
  if tcgetattr(fd, tios) < 0 then
    Exit;
  if not setTermiosSpeed(fd, tios, speed) then
    Exit;
  tios.c_cflag = tios.c_cflag and not PARENB;
  if tcsetattr(fd, TCSAFLUSH, tios) < 0 then
    Exit;
  Result := True;
end;

function setRaw(fd : integer) : boolean;
var
  tios : Termios;
begin
  Result := False;
  if tcgetattr(fd, tios) < 0 then
    Exit;
  // echo off, canonical mode off, extended input processing off
  // signal chars off
  tios.c_lflag = tios.c_lflag and not (ECHO or ICANON or IEXTEN or ISIG);

  tios.c_iflag = tios.c_iflag and not (BRKINT or ICRNL or INPCK or ISTRIP or IXON);

  tios.c_cflag = tios.c_cflag and not (CSIZE or CSTOPB or PARENB or PARODD);

  tios.c_cflag = tios.c_cflag or CS8;

  tios.c_oflag = tios.c_oflag and not OPOST;

  tios.c_cc[VMIN] = 1;
  tios.c_cc[VTIME] = 0;

  if tcsetattr(fd, TCSAFLUSH, tios) < 0 then
    Exit;

  Result := setSpeed(fd, 9600, 0);
end;

const
  TIMEOUT = 1000;

function TSerialLink.readTO(ptr: Pointer; length, timeoutMS: integer): integer;
var
  cur : Pointer;
  expire : timeval;
  tz : timezone;
begin
  Result := -1;
  if gettimeofday(expire, tz) < 0 then
    Exit;

end;

constructor TSerialLink.Create(name: string);
begin
  fName := name;
  fHandle := -1;
end;

destructor TSerialLink.Destroy;
begin
  close;
  inherited Destroy;
end;

procedure TSerialLink.open;
begin
  fHandle := FileOpen(fName, 0);
  if (fHandle < 0) then
    raise Exception.Create('Could not open Bluetooth link');
  setRaw(fHandle);
end;

procedure TSerialLink.close;
begin
  if (fHandle >- 0) then
  begin
    FileClose(fHandle);
    fHandle := -1;
  end;
end;

function TSerialLink.read(ptr: Pointer; maxLength: integer): integer;
var
  header : array[0..1] of Char;
  packetSize : integer;
  actual : integer;
begin
  Result := -1;
  if readTO(@header[0], 2, TIMEOUT) <> 2) then
    Exit;

  packetSize := header[0] + (header[1]*256);
  if (packetSize > maxLength) then
    Exit;
    
  actual := readTO(ptr, packetSize, TIMEOUT);
  if (actual <> packetSize) then
    Exit;

  Result := actual;
end;

function TSerialLink.write(ptr: Pointer; count: integer): integer;
var
  header : array[0..1] of Char;
begin
  header[0] := Lo(Word(count));
  header[1] := Hi(Word(count));
  FileWrite(fHandle, @header[0], 2);
  Result := FileWrite(fHandle, ptr, count);
end;

end.