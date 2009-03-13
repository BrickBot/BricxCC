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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit posixserial;

interface

type
  TPosixSerial = class(TNQCStream)
  protected
    fD : integer;
    fDevicename : string;
    function InternalRead(Ptr : PByte; count: Integer): LongInt;
    procedure SetLinkMode(const Value: TLinkMode); override;
  public
    function Open(Name : string) : Boolean; virtual;
    procedure Close; override;
    function Read(Ptr : PByte; count : Longint; timeout : Longint = kPStream_NeverTimeout) : LongInt; override;
    function Write(Ptr : PByte; count : LongInt) : LongInt; override;
    procedure FlushWrite; override;
    procedure FlushRead(delay : Integer); override;
    function SetTimeout(timeout_ms : LongInt = kPStream_NeverTimeout) : Boolean; override;
    function SetSpeed(speed : integer; opts : integer = 0) : Boolean; virtual;
    function SetDTR(bDTR : Boolean) : Boolean; virtual;
    function SetRTS(bRTS : Boolean) : Boolean; virtual;
  end;


implementation

{ TPosixSerial }

procedure TPosixSerial.Close;
begin
  if not Active then Exit;
  CloseHandle(fFile);
  inherited Close;
end;

procedure TPosixSerial.FlushRead(delay : Integer);
var
  buff : PByte;
const
  BUFFSIZE = 512;
begin
  GetMem(buff, BUFFSIZE);
  try
    while Read(buff, BUFFSIZE, delay) > 0 do
    begin
    end;
//    PurgeComm(fFile, PURGE_RXCLEAR);
  finally
    FreeMem(buff, BUFFSIZE);
  end;
end;

procedure TPosixSerial.FlushWrite;
begin
  FlushFileBuffers(fFile);
end;

function TPosixSerial.InternalRead(Ptr: PByte; count: Integer): LongInt;
var
  actual, Errors : DWORD;
  cstat : TComStat;
begin
  actual := 10;
  if not ReadFile(fFile, Ptr^, Cardinal(count), actual, nil) then
  begin
    GetLastError();
    ClearCommError(fFile, Errors, @cstat);
    Result := 0;
  end
  else
  begin
    Result := actual;
  end;
end;

function TPosixSerial.Open(Name: string): Boolean;
begin
  Result := False;
  if Active then Exit;

  fFile := CreateFile(PChar(Name), GENERIC_READ or GENERIC_WRITE, 0,
                      nil, OPEN_EXISTING, 0, 0);

  if fFile = INVALID_HANDLE_VALUE then Exit;

  if not SetSpeed(kDefaultSpeed) then Exit;
  fOpen := True;
  Result := True;
end;

function TPosixSerial.Read(Ptr : PByte; count : Longint; timeout : LongInt): LongInt;
begin
  if count > 1 then
    SetTimeout(timeout);
  Result := InternalRead(Ptr, count);
end;

function TPosixSerial.SetDTR(bDTR: Boolean): Boolean;
begin
  if bDTR then
    Result := EscapeCommFunction(fFile, Windows.SETDTR)
  else
    Result := EscapeCommFunction(fFile, CLRDTR);
end;

procedure TPosixSerial.SetLinkMode(const Value: TLinkMode);
begin
  fLinkMode := lmIR;
end;

function TPosixSerial.SetRTS(bRTS: Boolean): Boolean;
begin
  if bRTS then
    Result := EscapeCommFunction(fFile, Windows.SETRTS)
  else
    Result := EscapeCommFunction(fFile, CLRRTS);
end;

function TPosixSerial.SetSpeed(speed, opts: integer): Boolean;
var
  dcb : TDCB;
begin
  Result := False;
  FillChar(dcb, sizeof(TDCB), 0);
  dcb.DCBlength := sizeof(TDCB);
  if not GetCommState(fFile, dcb) then Exit;
  dcb.BaudRate  := GetBaud(speed);
  dcb.XonLim    := 100;
  dcb.XoffLim   := 100;
  dcb.ByteSize  := 8 - (opts and kPSerial_DataMask);
  dcb.Parity    := (opts and kPSerial_ParityMask) shr kPSerial_ParityShift;
  dcb.StopBits  := (opts and kPSerial_StopMask) shr kPSerial_StopShift;
  dcb.XonChar   := #1;
  dcb.XoffChar  := #2;
//  dcb.XonChar   := #17;
//  dcb.XoffChar  := #19;
  dcb.ErrorChar := #0;
  dcb.EofChar   := #0;
  dcb.EvtChar   := #0;
  dcb.Flags     := fBinary or fDtrControlEnable;
  if UseXonXoff then
    dcb.Flags   := dcb.Flags or fOutX or fInX;
  Result := SetCommState(fFile, dcb);
end;

function TPosixSerial.SetTimeout(timeout_ms: Integer): Boolean;
var
  timeouts : TCommTimeouts;
begin
  timeouts.ReadIntervalTimeout := 0;
  timeouts.ReadTotalTimeoutMultiplier := 0;
  timeouts.ReadTotalTimeoutConstant := 0;
  timeouts.WriteTotalTimeoutMultiplier := 0;
  timeouts.WriteTotalTimeoutConstant := 0;

  case timeout_ms of
    kPStream_NeverTimeout : ;
    0 : timeouts.ReadIntervalTimeout := MAXDWORD;
  else
    timeouts.ReadTotalTimeoutConstant   := Abs(timeout_ms);
  end;
  Result := SetCommTimeouts(fFile, timeouts);
end;

function TPosixSerial.Write(Ptr : PByte; count: Integer): LongInt;
var
  actual : DWORD;
begin
  if not WriteFile(fFile, Ptr^, Cardinal(count), actual, nil) then
    Result := -1
  else
    Result := actual;
  FlushWrite;
end;

(*
static bool setRaw(int fd);
static bool setSpeed(int fd, int speed, int opts);
static bool setTermiosSpeed(int fd, termios &tios, int speed);


static const int TIMEOUT = 1000;

SerialLink::SerialLink(const char *deviceName)
    : deviceName_(deviceName), fd_(-1)
{
}


void SerialLink::open()
{
    fd_ = ::open(deviceName_.c_str(), O_RDWR);
    if (fd_ < 0) {
        throw StringException("Could not open Bluetooth link");
    }
    setRaw(fd_);
}


void SerialLink::close()
{
    if (fd_ >= 0) {
        ::close(fd_);
        fd_ = -1;
    }
}


int SerialLink::read(void *ptr, int maxLength)
{
    unsigned char header[2];
    if (readTO(header, 2, TIMEOUT) != 2) {
        return -1;
    }

    int packetSize = header[0] + (header[1] << 8);
    if (packetSize > maxLength) {
        return -1;
    }

    int actual = readTO(ptr, packetSize, TIMEOUT);
    if (actual != packetSize) {
        return -1;
    }

    return actual;
}


int SerialLink::readTO(void *ptr, int count, int timeoutMs)
{
	// time limited read
	char *cur = ( char * ) ptr;
	struct timeval expire;
	struct timezone tz;

	if (gettimeofday(&expire, &tz) < 0)
	{
		return -1;
	}

	expire.tv_sec += timeoutMs / 1000;
	expire.tv_usec += (timeoutMs % 1000) * 1000;

	while (count)
	{
		fd_set rfds;
		FD_ZERO(&rfds);
		FD_SET(fd_, &rfds);
		struct timeval delay;
		long nread;

		if (gettimeofday(&delay, &tz) < 0)
		{
			return -1;
		}

		if (timercmp(&delay, &expire, >=))
		{
			// delay (current time) >= expire
		  	break;
		}

		timersub(&expire, &delay, &delay);	// delay = expire - delay

		if (select(fd_ + 1, &rfds, NULL, NULL, &delay))
		{
			if (ioctl(fd_, FIONREAD, &nread) < 0)
			{
				return -1;
		  	}

		  	nread = (count < nread) ? count : nread;
		  	if ((nread = ::read(fd_, cur, nread)) < 0)
		  	{
				return -1;
		  	}
			count -= nread;
			cur += nread;
		}
		else
		{
		  // timeout
		  break;
		}
	} // while

	return (cur - ( char * )ptr);
}


int SerialLink::write(const void *ptr, int count)
{
    unsigned char header[2];
    header[0] = count;
    header[1] = count >> 8;
    ::write(fd_, header, 2);
	return ::write(fd_, ptr, count);
}


// Put the tty into raw mode
// Adapted from tty_raw, "Advanced Programing in the UNIX
// Environment", W. Richard Stevens, pp354-355
bool setRaw(int fd)
{
	termios tios;

	if (tcgetattr(fd, &tios) < 0)
		return false;

	// echo off, canonical mode off, extended input processing off
	// signal chars off
	tios.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);

	// no SIGINT on BREAK, CR-to-NL off, input parity check off,
	// don't strip 8th bit on input, output flow control off
	tios.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);

	// clear size bits, 1 stop bit, disable parity
	tios.c_cflag &= ~(CSIZE | CSTOPB | PARENB | PARODD);

	// set 8 bits/char
	tios.c_cflag |= (CS8);

	// output processing off
	tios.c_oflag &= ~(OPOST);

	// 1 byte at a time, no timer
	tios.c_cc[VMIN] = 1;
	tios.c_cc[VTIME] = 0;


	if (tcsetattr(fd, TCSAFLUSH, &tios) < 0)
		return false;


	return setSpeed(fd, 9600, 0);
}


bool setSpeed(int fd, int speed, int opts)
{
	termios tios;

	if (tcgetattr(fd, &tios) < 0)
		return false;

	// set the speed
	if (!setTermiosSpeed(fd, tios, speed))
		return false;

    tios.c_cflag &= ~(PARENB);

	if (tcsetattr(fd, TCSAFLUSH, &tios) < 0)
		return false;

	return true;
}


bool setTermiosSpeed(int fd, termios &tios, int speed)
{
	speed_t s;

	switch(speed)
	{
		case 2400:
			s = B2400;
			break;
		case 4800:
			s = B4800;
			break;
		case 9600:
			s = B9600;
			break;
		default:
			return false;
	}

	if (cfsetispeed(&tios, s) < 0)
		return false;

	if (cfsetospeed(&tios, s) < 0)
		return false;

	return true;
}
*)
end.
