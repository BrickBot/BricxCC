unit uHidDeviceTransport;

interface

uses
  Classes, uCasperDevice, uCasperTypes, hidapi, HidApiDefs;

type
  THidApiTransport = class(TInterfacedObject, IDeviceTransport)
  private
    function GetUserVisibleName: string;
  private
    fParent : TCasperDevice;
		fReadTimeout : integer;
		fPath : string;
		fProductstring : string;
		fSerial : string;
		fInputBuffer : TStream;
		fOutputBuffer : TStream;
//		private object _sendMutex = new object();
		fTransportStatus : TDeviceTransportStatus;
		fDeviceHandle : PHidDeviceHandle;
		fOutputMemoryStream : TMemoryStream;
//		private System.IO.BinaryWriter _outputWriter;
//		private System.Threading.Thread _receiveWorker;
		fContinueReading : boolean;
		fIntentionalClose : boolean;
    procedure SetState(const Value: TDeviceTransportStatus);
    procedure DisconnectWorker;
    property UserVisibleName : string read GetUserVisibleName;
  protected
    function GetMaxMessageSize : integer;
    function GetParent : TCasperDevice;
    procedure SetParent(aParent : TCasperDevice);
    function GetSerialNumber : string;
    function GetState : TDeviceTransportStatus;
    function GetUserVisibleType : string;
  public
    constructor Create(path :  string; info : THidDeviceInfo);
    destructor Destroy; override;
    function Connect : boolean;
    procedure Disable;
    procedure Disconnect;
    procedure Revive;
    function SendMessage(buffer : TStream; sequenceId : Word) : TCasperErrorCode;

    property MaxMessageSize : integer read GetMaxMessageSize;
    property Parent : TCasperDevice read GetParent write SetParent;
    property SerialNumber : string read GetSerialNumber;
    property State : TDeviceTransportStatus read GetState write SetState;
    property UserVisibleType : string read GetUserVisibleType;
  end;
(*
		private void RecvWorker()
		{
			this._intentionalClose = false;
			try
			{
				while (this._continueReading)
				{
					int bytesRead = HidApiNativeMethods.hid_read_timeout(this._deviceHandle, this._inputBuffer, (System.UIntPtr)((ulong)((long)this._inputBuffer.Length)), 100);
					if (bytesRead != 0)
					{
						if (bytesRead == -1)
						{
							break;
						}
						int messageSize = (int)(System.BitConverter.ToUInt16(this._inputBuffer, 0) - 2);
						short sequenceID = System.BitConverter.ToInt16(this._inputBuffer, 2);
						if (messageSize >= 0)
						{
							byte[] msg = new byte[messageSize];
							System.Array.ConstrainedCopy(this._inputBuffer, 4, msg, 0, messageSize);
							this.Parent.MessageReceived(msg, sequenceID, this);
						}
					}
				}
			}
			finally
			{
				lock (this._sendMutex)
				{
					this.DestructionWorker();
					this._receiveWorker = null;
				}
			}
			if (!this._intentionalClose)
			{
				this.State = DeviceTransportStatus.Disabled;
			}
		}

		private void DestructionWorker()
		{
			HidApiNativeMethods.HidDeviceSafeHandle deviceHandle = this._deviceHandle;
			this._deviceHandle = null;
			if (deviceHandle != null)
			{
				deviceHandle.Dispose();
			}
			System.IO.BinaryWriter outputWriter = this._outputWriter;
			this._outputWriter = null;
			if (outputWriter != null)
			{
				outputWriter.Dispose();
			}
			System.IO.MemoryStream outputMemoryStream = this._outputMemoryStream;
			this._outputMemoryStream = null;
			if (outputMemoryStream != null)
			{
				outputMemoryStream.Dispose();
			}
		}
*)

function hid_write_stream(device : PHidDeviceHandle; aStream : TStream) : integer;

implementation

uses
  SysUtils;

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

{ THidApiTransport }

function THidApiTransport.Connect: boolean;
begin
  if Self.State = dtsConnected then
    Result := True
  else
  begin
    if Self.State <> dtsPreoperational then
      Result := False
    else
    begin
      fDeviceHandle := hid_open_path(PAnsiChar(Self.fPath));
      if InvalidHidDeviceHandle(fDeviceHandle) then
        Result := False
      else
      begin
        hid_set_nonblocking(fDeviceHandle, 0);
        Self.State := dtsConnected;
        // setup buffers/streams
//        this._inputBuffer = new byte[1025];
//        this._outputBuffer = new byte[1025];
//        this._outputMemoryStream = new System.IO.MemoryStream(this._outputBuffer);
//        this._outputWriter = new System.IO.BinaryWriter(this._outputMemoryStream);
        fContinueReading := True;
(*
        this._receiveWorker = new System.Threading.Thread(new System.Threading.ThreadStart(this.RecvWorker))
        {
          Name = "HidApiTportWorker: " + this.Parent.SerialNumber,
          IsBackground = true
        };
        this._receiveWorker.Start();
*)
        Result := True;
      end;
    end;
  end;
end;

constructor THidApiTransport.Create(path: string; info: THidDeviceInfo);
begin
  inherited Create;
  fPath := path;
  fSerial := UpperCase(info.serial_number);
  fProductstring := info.product_string;
  fTransportStatus := dtsPreoperational;
  fOutputBuffer := TMemoryStream.Create;
  fInputBuffer := TMemoryStream.Create;
end;

destructor THidApiTransport.Destroy;
begin
  FreeAndNil(fOutputBuffer);
  FreeAndNil(fInputBuffer);
  inherited;
end;

procedure THidApiTransport.Disable;
begin
  State := dtsDisabled;
  DisconnectWorker;
end;

procedure THidApiTransport.Disconnect;
begin
  State := dtsPreoperational;
  DisconnectWorker;
end;

procedure THidApiTransport.DisconnectWorker;
begin
  fIntentionalClose := True;
  fContinueReading := False;
  // stop receive worker thread
(*
		System.Threading.Thread receiveWorker = this._receiveWorker;
			this._receiveWorker = null;
			if (receiveWorker != null)
			{
				receiveWorker.Join(2000);
			}
*)
end;

function THidApiTransport.GetMaxMessageSize: integer;
begin
  Result := 1024;
end;

function THidApiTransport.GetParent: TCasperDevice;
begin
  Result := fParent;
end;

function THidApiTransport.GetSerialNumber: string;
begin
  Result := fSerial;
end;

function THidApiTransport.GetState: TDeviceTransportStatus;
begin
  Result := fTransportStatus;
end;

function THidApiTransport.GetUserVisibleName: string;
begin
  Result := fProductstring;
end;

function THidApiTransport.GetUserVisibleType: string;
begin
 Result := 'USB';
end;

procedure THidApiTransport.Revive;
begin
  if State = dtsDisabled then
    State := dtsPreoperational;
end;

function THidApiTransport.SendMessage(buffer: TStream; sequenceId: Word): TCasperErrorCode;
var
  bytesWritten : integer;
  data : word;
begin
  if self.State <> dtsConnected then
  begin
    result := cecNotConnected;
    exit;
  end;
  if buffer.Size > self.fOutputBuffer.Size - 4 then
  begin
    result := cecMessageTooLarge;
    exit;
  end;
  fOutputBuffer.Seek(1, soFromBeginning);
  data := Word(buffer.Size + 2);
  fOutputBuffer.Write(data, 2);
  fOutputBuffer.Write(sequenceId, 2);
  fOutputBuffer.CopyFrom(buffer, 0);
  if InvalidHidDeviceHandle(fDeviceHandle) then
  begin
    result := cecTransportUnavailable;
    exit;
  end;
//	lock (this._sendMutex)
  bytesWritten := hid_write_stream(fDeviceHandle, fOutputBuffer);
  fOutputBuffer.Size := 0; // empty the output stream
//	unlock (this._sendMutex)
  if bytesWritten <> -1 then
    Result := cecNoError
  else
  begin
//    System.Console.WriteLine("Error in HidApi.SendMessage: \t{0}", HidApiNativeMethods.hid_error(this._deviceHandle));
    Self.State := dtsDisabled;
    DisconnectWorker();
    Result := cecTransportUnavailable;
  end;
end;

procedure THidApiTransport.SetParent(aParent: TCasperDevice);
begin
  fParent := aParent;
end;

procedure THidApiTransport.SetState(const Value: TDeviceTransportStatus);
begin
  if fTransportStatus <> Value then
  begin
    fTransportStatus := Value;
    Parent.UpdateTransport(Self);
  end;
end;

end.
=======
unit uHidDeviceTransport;

interface

uses
  Classes, uCasperDevice, uCasperTypes, hidapi;

type
  THidApiTransport = class(TInterfacedObject, IDeviceTransport)
  private
    function GetUserVisibleName: string;
  private
    fParent : TCasperDevice;
		fReadTimeout : integer;
		fPath : string;
		fProductstring : string;
		fSerial : string;
		fInputBuffer : TStream;
		fOutputBuffer : TStream;
//		private object _sendMutex = new object();
		fTransportStatus : TDeviceTransportStatus;
		fDeviceHandle : PHidDeviceHandle;
		fOutputMemoryStream : TMemoryStream;
//		private System.IO.BinaryWriter _outputWriter;
//		private System.Threading.Thread _receiveWorker;
		fContinueReading : boolean;
		fIntentionalClose : boolean;
    procedure SetState(const Value: TDeviceTransportStatus);
    procedure DisconnectWorker;
    property UserVisibleName : string read GetUserVisibleName;
  protected
    function GetMaxMessageSize : integer;
    function GetParent : TCasperDevice;
    procedure SetParent(aParent : TCasperDevice);
    function GetSerialNumber : string;
    function GetState : TDeviceTransportStatus;
    function GetUserVisibleType : string;
  public
    constructor Create(path :  string; info : THidDeviceInfo);
    destructor Destroy; override;
    function Connect : boolean;
    procedure Disable;
    procedure Disconnect;
    procedure Revive;
    function SendMessage(buffer : TStream; sequenceId : Word) : TCasperErrorCode;

    property MaxMessageSize : integer read GetMaxMessageSize;
    property Parent : TCasperDevice read GetParent write SetParent;
    property SerialNumber : string read GetSerialNumber;
    property State : TDeviceTransportStatus read GetState write SetState;
    property UserVisibleType : string read GetUserVisibleType;
  end;
(*
	public sealed class HidApiTransport : IDeviceTransport, System.IDisposable
	{
		private void RecvWorker()
		{
			this._intentionalClose = false;
			try
			{
				while (this._continueReading)
				{
					int bytesRead = HidApiNativeMethods.hid_read_timeout(this._deviceHandle, this._inputBuffer, (System.UIntPtr)((ulong)((long)this._inputBuffer.Length)), 100);
					if (bytesRead != 0)
					{
						if (bytesRead == -1)
						{
							break;
						}
						int messageSize = (int)(System.BitConverter.ToUInt16(this._inputBuffer, 0) - 2);
						short sequenceID = System.BitConverter.ToInt16(this._inputBuffer, 2);
						if (messageSize >= 0)
						{
							byte[] msg = new byte[messageSize];
							System.Array.ConstrainedCopy(this._inputBuffer, 4, msg, 0, messageSize);
							this.Parent.MessageReceived(msg, sequenceID, this);
						}
					}
				}
			}
			finally
			{
				lock (this._sendMutex)
				{
					this.DestructionWorker();
					this._receiveWorker = null;
				}
			}
			if (!this._intentionalClose)
			{
				this.State = DeviceTransportStatus.Disabled;
			}
		}
		private void DestructionWorker()
		{
			HidApiNativeMethods.HidDeviceSafeHandle deviceHandle = this._deviceHandle;
			this._deviceHandle = null;
			if (deviceHandle != null)
			{
				deviceHandle.Dispose();
			}
			System.IO.BinaryWriter outputWriter = this._outputWriter;
			this._outputWriter = null;
			if (outputWriter != null)
			{
				outputWriter.Dispose();
			}
			System.IO.MemoryStream outputMemoryStream = this._outputMemoryStream;
			this._outputMemoryStream = null;
			if (outputMemoryStream != null)
			{
				outputMemoryStream.Dispose();
			}
		}
*)

implementation

uses
  SysUtils;

{ THidApiTransport }

function THidApiTransport.Connect: boolean;
begin
(*
			bool result;
			if (this.State == DeviceTransportStatus.Connected)
			{
				result = true;
			}
			else
			{
				if (this.State != DeviceTransportStatus.Preoperational)
				{
					result = false;
				}
				else
				{
					this._deviceHandle = HidApiNativeMethods.hid_open_path(this._path);
					if (this._deviceHandle.IsInvalid)
					{
						result = false;
					}
					else
					{
						HidApiNativeMethods.hid_set_nonblocking(this._deviceHandle, 0);
						this.State = DeviceTransportStatus.Connected;
						this._inputBuffer = new byte[1025];
						this._outputBuffer = new byte[1025];
						this._outputMemoryStream = new System.IO.MemoryStream(this._outputBuffer);
						this._outputWriter = new System.IO.BinaryWriter(this._outputMemoryStream);
						this._continueReading = true;
						this._receiveWorker = new System.Threading.Thread(new System.Threading.ThreadStart(this.RecvWorker))
						{
							Name = "HidApiTportWorker: " + this.Parent.SerialNumber,
							IsBackground = true
						};
						this._receiveWorker.Start();
						result = true;
					}
				}
			}
			return result;
*)
end;

constructor THidApiTransport.Create(path: string; info: THidDeviceInfo);
begin
  inherited Create;
  fPath := path;
  fSerial := UpperCase(info.serial_number);
  fProductstring := info.product_string;
  fTransportStatus := dtsPreoperational;
end;

destructor THidApiTransport.Destroy;
begin

  inherited;
end;

procedure THidApiTransport.Disable;
begin
  State := dtsDisabled;
  DisconnectWorker;
end;

procedure THidApiTransport.Disconnect;
begin
  State := dtsPreoperational;
  DisconnectWorker;
end;

procedure THidApiTransport.DisconnectWorker;
begin
  fIntentionalClose := True;
  fContinueReading := False;
  // stop receive worker thread
(*
		System.Threading.Thread receiveWorker = this._receiveWorker;
			this._receiveWorker = null;
			if (receiveWorker != null)
			{
				receiveWorker.Join(2000);
			}
*)
end;

function THidApiTransport.GetMaxMessageSize: integer;
begin
  Result := 1024;
end;

function THidApiTransport.GetParent: TCasperDevice;
begin
  Result := fParent;
end;

function THidApiTransport.GetSerialNumber: string;
begin
  Result := fSerial;
end;

function THidApiTransport.GetState: TDeviceTransportStatus;
begin
  Result := fTransportStatus;
end;

function THidApiTransport.GetUserVisibleName: string;
begin
  Result := fProductstring;
end;

function THidApiTransport.GetUserVisibleType: string;
begin
 Result := 'USB';
end;

procedure THidApiTransport.Revive;
begin
  if State = dtsDisabled then
    State := dtsPreoperational;
end;

function THidApiTransport.SendMessage(buffer: TStream; sequenceId: Word): TCasperErrorCode;
var
  bytesWritten : integer;
  data : word;
begin
  if self.State <> dtsConnected then
  begin
    result := cecNotConnected;
    exit;
  end;
  if buffer.Size > self.fOutputBuffer.Size - 4 then
  begin
    result := cecMessageTooLarge;
    exit;
  end;
  fOutputBuffer.Seek(1, soFromBeginning);
  data := Word(buffer.Size + 2);
  fOutputBuffer.Write(data, 2);
  fOutputBuffer.Write(sequenceId, 2);
  fOutputBuffer.CopyFrom(buffer, 0);
  if InvalidHidDeviceHandle(fDeviceHandle) then
  begin
    result := cecTransportUnavailable;
    exit;
  end;
//  bytesWritten := hid_write(Self.fDeviceHandle, 
(*
			lock (this._sendMutex)
			{
				bytesWritten = HidApiNativeMethods.hid_write(this._deviceHandle, this._outputBuffer, (System.UIntPtr)((ulong)((long)this._outputBuffer.Length)));
				System.Array.Clear(this._outputBuffer, 1, buffer.Length + 4);
			}
			if (bytesWritten != -1)
			{
				result = CasperErrorCode.NoError;
			}
			else
			{
				System.Console.WriteLine("Error in HidApi.SendMessage: \t{0}", HidApiNativeMethods.hid_error(this._deviceHandle));
				this.State = DeviceTransportStatus.Disabled;
				this.DisconnectWorker();
				result = CasperErrorCode.TransportUnavailable;
			}
			return result;
*)
end;

procedure THidApiTransport.SetParent(aParent: TCasperDevice);
begin
  fParent := aParent;
end;

procedure THidApiTransport.SetState(const Value: TDeviceTransportStatus);
begin
  if fTransportStatus <> Value then
  begin
    fTransportStatus := Value;
    Parent.UpdateTransport(Self);
  end;
end;

end.
