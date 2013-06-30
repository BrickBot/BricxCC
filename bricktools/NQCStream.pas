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
unit NQCStream;

interface

const
  kPStream_NeverTimeout = -1;

  kPSerial_DataMask  = $03;
  kPSerial_DataShift = 0;
  kPSerial_Data8     = (0 shl kPSerial_DataShift);
  kPSerial_Data7     = (1 shl kPSerial_DataShift);
  kPSerial_Data6     = (2 shl kPSerial_DataShift);
  kPSerial_Data5     = (3 shl kPSerial_DataShift);

  kPSerial_ParityMask  = $0c;
  kPSerial_ParityShift = 2;
  kPSerial_ParityNone  = (0 shl kPSerial_ParityShift);
  kPSerial_ParityOdd   = (1 shl kPSerial_ParityShift);
  kPSerial_ParityEven	 = (2 shl kPSerial_ParityShift);

  kPSerial_StopMask  = $30;
  kPSerial_StopShift = 4;
  kPSerial_Stop1     = (0 shl kPSerial_StopShift);
  kPSerial_Stop1_5   = (1 shl kPSerial_StopShift);
  kPSerial_Stop2     = (2 shl kPSerial_StopShift);

  kDefaultSpeed     = $0008; // LT_SPEED_BPS_2400
  kInputBufferSize  = 16384;
  kOutputBufferSize = 16384;

  fBinary           = $0001; // Binary mode if set
  fParity           = $0002; // When set, parity checking is enabled.
  fOutxCtsFlow      = $0004; // No data sent unless CTS is high.
  fOutxDsrFlow      = $0008; // No data sent unless DSR is high.
  fDtrControlEnable = $0010; // 1 = 10 (enabled), 2 = 20 (handshake)
  fDtrControlHand   = $0020; // DTR_CONTROL_DISABLE, DTR_CONTROL_ENABLE, DTR_CONTROL_HANDSHAKE
  fDsrSensitivity   = $0040; // Unless DSR is high, all bytes ignored.
  fTxContinueOnXOff = $0080; // Can continue sending data, even when waiting on an XON character to be set. If not set, cannot send data until XONLim is reached.
  fOutX             = $0100; // XON/XOFF flow control enabled for sending.
  fInX              = $0200; // XON/XOFF flow control enabled for receiving.
  fErrorChar        = $0400; // If a parity error is detected, the error will be replaced with this character.
  fNull             = $0800; // Strip off the null characters.
  fRtsControlEnable = $1000; // 1 = 1000 (enabled), 2 = 2000 (handshake)
  fRtsControlHand   = $2000; // RTS_CONTROL_DISABLE, RTS_CONTROL_ENABLE, RTS_CONTROL_HANDSHAKE
  fAbortOnError     = $4000; // abort on error

  kNormalIrMode     = 1 shl 0;	// 2400 baud, odd parity, etc
  kFastIrMode       = 1 shl 1;	// 4800 baud, no parity
  kCyberMasterMode  = 1 shl 2;	// normal IR + DTR/RTS for CyberMaster
  kSpyboticsMode    = 1 shl 3;	// 4800 baud, odd parity, DTR/RTS
  kTxEchoFlag       = 1 shl 29;	// set if Tx data gets echoed
  kAbsorb55Flag     = 1 shl 30;	// set if pipe absorbs leading 0x55


type
  TLinkMode = (lmIR, lmVLL, lmIRC, lmRadio);
  TNQCStream = class
  private
  protected
    fOpen : Boolean;
    fLinkMode: TLinkMode;
    fUseXonXoff: Boolean;
    fForceRCXFreq: Boolean;
    procedure SetForceRCXFreq(const Value: Boolean);
    procedure SetLinkMode(const Value: TLinkMode); virtual; abstract;
    function GetActive: Boolean; virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Close; virtual;
    function Read(Ptr : PByte; count : Longint; timeout : Longint = kPStream_NeverTimeout) : LongInt; virtual; abstract;
    function Write(Ptr : PByte; count : LongInt) : LongInt; virtual; abstract;
    procedure FlushWrite; virtual;
    procedure FlushRead(delay : Integer); virtual;
    function SetTimeout(timeout_ms : LongInt = kPStream_NeverTimeout) : Boolean; virtual;
    function ReadLine(data : PChar; max : Integer) : Boolean; virtual;
    function SetBlocking(bBlock : Boolean) : Boolean;
    property LinkMode : TLinkMode read fLinkMode write SetLinkMode;
    property Active : Boolean read GetActive;
    property UseXonXoff : Boolean read fUseXonXoff write fUseXonXoff;
    property ForceRCXFrequency : Boolean read fForceRCXFreq write SetForceRCXFreq;
  end;

implementation

{ TNQCStream }

procedure TNQCStream.Close;
begin
  fOpen := false;
end;

constructor TNQCStream.Create;
begin
  inherited Create;
  fOpen       := False;
  fLinkMode   := lmIR;
  fUseXonXoff := False;
  fForceRCXFreq := False;
end;

destructor TNQCStream.Destroy;
begin
  Close;
  inherited Destroy;
end;

procedure TNQCStream.FlushRead(delay : Integer);
begin
  // do nothing in the base class
end;

procedure TNQCStream.FlushWrite;
begin
  // do nothing in base class
end;

function TNQCStream.GetActive: Boolean;
begin
  Result := fOpen;
end;

function TNQCStream.ReadLine(data: PChar; max: Integer): Boolean;
begin
  result := false;
  while(max > 1) do begin
    if (Read(PByte(data), 1) <> 1) then
      break;
    dec(max);
    if (data^ = #13) then
    begin
      inc(data);
      result := true;
      break;
    end;
    inc(data);
  end;
  data^ := #0;
end;

function TNQCStream.SetBlocking(bBlock: Boolean): Boolean;
begin
  if bBlock then
    result :=  SetTimeout(kPStream_NeverTimeout)
  else
    result :=  SetTimeout(0);
end;

procedure TNQCStream.SetForceRCXFreq(const Value: Boolean);
begin
  fForceRCXFreq := Value;
end;

function TNQCStream.SetTimeout(timeout_ms: Integer): Boolean;
begin
  result := (timeout_ms = kPStream_NeverTimeout);
end;

end.