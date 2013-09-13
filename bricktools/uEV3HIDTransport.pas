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
unit uEV3HIDTransport;

interface

uses
  Classes, uEV3Transport, HidApiDefs, hidapi;

type
  TEV3HIDTransport = class(TInterfacedObject, IEV3Transport)
  private
    fFirmwareDownload : boolean;
    fPath : string;
    fSerial : string;
    fProductString : string;
    fDeviceHandle : PHidDeviceHandle;
  protected
    constructor Create(info : PHidDeviceInfo);
  public
    destructor Destroy; override;
    function GetMaxMessageSize : integer;
    function GetSerialNumber : string;
    function GetUserVisibleType : string;

    procedure Close;
    function Open : boolean;
    function IsOpen : boolean;
    function IsFirmwareDownload : boolean;
    function SendMessage(SequenceId : Word; var Buffer : TEV3Data) : integer;
    function SendStream(SequenceId : Word; aStream : TStream) : integer;
    function ReceiveMessage(var Buffer : TEV3Data; Timeout : Word; Id : Word) : Word;
  end;

procedure LoadEV3HIDTransports(List : TInterfaceList);

implementation

uses
  SysUtils, uDebugLogging;

const USB_ID_VENDOR_LEGO   = $0694;
const USB_ID_PRODUCT_NXT   = $0002;
const USB_ID_PRODUCT_EV3   = $0005;
const USB_ID_PRODUCT_EV3FW = $0006;

const USB_ID_VENDOR_ATMEL  = $03EB;
const USB_ID_PRODUCT_SAMBA = $6124;

function hid_write_stream(device : PHidDeviceHandle; aStream : TStream) : integer;
var
  buf : PByte;
  len : cardinal;
begin
  Result := -1;
  len := aStream.Size;
  GetMem(buf, len);
  try
    if aStream.Read(buf^, len) = Integer(len) then
      Result := hid_write(device, buf, len);
  finally
    FreeMem(buf);
  end;
end;

{ TEV3HIDTransport }

constructor TEV3HIDTransport.Create(info : PHidDeviceInfo);
begin
  inherited Create;
  fPath := info^.path;
  fSerial := UpperCase(info^.serial_number);
  fProductString := info^.product_string;
  fDeviceHandle := nil;
  fFirmwareDownload := (info^.product_id = USB_ID_PRODUCT_EV3FW) and
                       (info^.vendor_id = USB_ID_VENDOR_LEGO);
end;

destructor TEV3HIDTransport.Destroy;
begin
  Close;
  inherited;
end;

procedure TEV3HIDTransport.Close;
begin
  if Assigned(fDeviceHandle) then
  begin
    hid_close(fDeviceHandle);
    fDeviceHandle := nil;
  end;
end;

function TEV3HIDTransport.Open: boolean;
begin
  Result := IsOpen();
  if not Result then
  begin
    fDeviceHandle := hid_open_path(PAnsiChar(fPath));
    if InvalidHidDeviceHandle(fDeviceHandle) then
      Result := False
    else
    begin
//      hid_set_nonblocking(fDeviceHandle, 0);
      Result := True;
      DebugLog(Format('%d', [THidDevice(Pointer(fDeviceHandle)^).output_report_length]));
      DebugLog(Format('%d', [THidDevice(Pointer(fDeviceHandle)^).input_report_length]));
    end;
  end;
end;

function TEV3HIDTransport.IsOpen: boolean;
begin
  Result := fDeviceHandle <> nil;
end;

function TEV3HIDTransport.IsFirmwareDownload: boolean;
begin
  Result := fFirmwareDownload;
end;

function TEV3HIDTransport.ReceiveMessage(var Buffer: TEV3Data; Timeout: Word; Id : Word): Word;
var
  bytesRead : integer;
  buf, p : PByte;
  b1, b2 : byte;
  messageSize : SmallInt;
begin
  Result := 0;
  SetLength(Buffer, 0);
//  SetLength(Buffer, 0);
  if not IsOpen then
    Exit;
  repeat
    GetMem(buf, GetMaxMessageSize);
    try
      FillChar(buf^, GetMaxMessageSize, 0);
      bytesRead := hid_read_timeout(fDeviceHandle, buf, 1025, Timeout);
  //    bytesRead := hid_read_timeout(fDeviceHandle, buf, GetMaxMessageSize, Timeout);
      if (bytesRead > 4) then
      begin
        p := buf;
        // first 2 bytes are message length
        b1 := p^;
        inc(p);
        b2 := p^;
        inc(p);
        messageSize := SmallInt((b2 * 256) + b1) - 2; // little-endian
        if ((messageSize < 0) or (messageSize > GetMaxMessageSize-4)) then
        begin
          Exit;
        end;
        // next 2 bytes
        b1 := p^;
        inc(p);
        b2 := p^;
        inc(p);
        Result := Word((b2 * 256) + b1); // little-endian
        SetLength(Buffer, messageSize);
        Move(p^, Pointer(Buffer)^, messageSize);
      end
      else
        break;
    finally
      FreeMem(buf);
    end;
  until (Result = Id);
end;

function TEV3HIDTransport.SendMessage(SequenceId: Word; var Buffer: TEV3Data): integer;
const
  OUTPUT_REPORT_LEN = 1025;
var
  len, i : integer;
  msgSize : Word;
  buf, p : PByte;
begin
  Result := 0;
  if not IsOpen then
    Exit;
  len := Length(Buffer);
  if (len > (GetMaxMessageSize - 5)) then
  begin
    Exit;
  end;
  if len > 0 then
  begin
    GetMem(buf, OUTPUT_REPORT_LEN);
    try
      FillChar(buf^, OUTPUT_REPORT_LEN, 0);
      p := buf;
      p^ := 0; // report ID
      Inc(p);
      msgSize := len + 2;
      Move(msgSize, p^, 2);
      inc(p, 2);
      Move(SequenceId, p^, 2);
      inc(p, 2);
      Move(Pointer(Buffer)^, p^, len);
      for i := 0 to 2 do
      begin
        DebugLog(buf, msgSize+3);
        Result := hid_write(fDeviceHandle, buf, OUTPUT_REPORT_LEN);
        if Result = OUTPUT_REPORT_LEN then
        begin
          Result := Length(Buffer);
          break;
        end;
        if Result = -1 then
          DebugLog(hid_error(fDeviceHandle));
      end;
    finally
      FreeMem(buf);
    end;
  end;
end;

function TEV3HIDTransport.SendStream(SequenceId: Word; aStream: TStream): integer;
var
  data : TEV3Data;
  len : integer;
begin
  len := aStream.Size;
  SetLength(data, len);
  aStream.Position := 0;
  aStream.Read(Pointer(data)^, len);
  Result := SendMessage(SequenceId, data);
end;

function TEV3HIDTransport.GetMaxMessageSize: integer;
begin
  Result := 1025;
end;

function TEV3HIDTransport.GetSerialNumber: string;
begin
  Result := fSerial;
end;

function TEV3HIDTransport.GetUserVisibleType: string;
begin
  Result := 'usb';
end;

procedure LoadEV3HIDTransports(List : TInterfaceList);
var
  devices, cur_dev : PHidDeviceInfo;
begin
  devices := hid_enumerate($0, $0);
  cur_dev := devices;
  while Assigned(cur_dev) do
  begin
    // is this device an EV3?
    if ((cur_dev^.vendor_id = USB_ID_VENDOR_LEGO) and
        ((cur_dev^.product_id = USB_ID_PRODUCT_EV3) or
         (cur_dev^.product_id = USB_ID_PRODUCT_EV3FW))) then
    begin
      List.Add(TEV3HIDTransport.Create(cur_dev));
    end;
    cur_dev := cur_dev^.next;
  end;
  // list the devices
  hid_free_enumeration(devices);
  // always add the null device
  List.Add(TEV3NullTransport.Create);
end;

end.
