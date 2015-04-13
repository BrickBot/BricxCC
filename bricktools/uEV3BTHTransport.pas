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
unit uEV3BTHTransport;

interface

uses
  Classes, uEV3Transport;

type
  TEV3BTHTransport = class(TInterfacedObject, IEV3Transport)
  public
    function GetMaxMessageSize : integer;
    function GetSerialNumber : string;
    function GetUserVisibleType : string;

    procedure Close;
    function Open : boolean;
    function IsOpen : boolean;
    function IsFirmwareDownload : boolean;
    function SendMessage(SequenceId : Word; var Buffer : TEV3Data) : integer;
    function SendStream(SequenceId : Word; aStream : TStream) : integer;
    function ReceiveMessage(var Buffer : TEV3Data; Timeout : Word; Id : Integer) : Word;
  end;

procedure LoadEV3BTHTransports(List : TInterfaceList);

implementation

uses
  SysUtils;
  
{ TEV3BTHTransport }

procedure TEV3BTHTransport.Close;
begin
  // nothing to close;
end;

function TEV3BTHTransport.Open: boolean;
begin
  // cannot be opened
  Result := False;
end;

function TEV3BTHTransport.IsOpen: boolean;
begin
  // cannot be opened
  Result := False;
end;

function TEV3BTHTransport.IsFirmwareDownload: boolean;
begin
  // cannot be in firmware download mode
  Result := False;
end;

function TEV3BTHTransport.ReceiveMessage(var Buffer: TEV3Data; Timeout: Word; Id : Integer): Word;
begin
  Result := 0;
  if not IsOpen then
    Exit;
end;

function TEV3BTHTransport.SendMessage(SequenceId: Word; var Buffer: TEV3Data): integer;
begin
  Result := 0;
  if not IsOpen then
    Exit;
end;

function TEV3BTHTransport.SendStream(SequenceId: Word; aStream: TStream): integer;
begin
  Result := 0;
  if not IsOpen then
    Exit;
end;

function TEV3BTHTransport.GetMaxMessageSize: integer;
begin
  Result := 1024;
end;

function TEV3BTHTransport.GetSerialNumber: string;
begin
  Result := '0';
end;

function TEV3BTHTransport.GetUserVisibleType: string;
begin
  Result := 'bth';
end;


(*
		private BluetoothDeviceInfo _info;
		private string _serialNumber;
		private DeviceTransportStatus _transportStatus;
		private object _sendMutex = new object();
		private BluetoothClient _bthclient;
		private System.Net.Sockets.NetworkStream _stream;
		private System.IO.BinaryReader _reader;
		private System.IO.BinaryWriter _writer;
		private System.Threading.Thread _receiveWorker;
		private System.DateTime _lastConnection = System.DateTime.Now.AddSeconds(-100.0);
		private int _millisecondsToWaitToReconnect = 20000;
		private static AuthenticateTransport _defaultAthenticateTransport = new AuthenticateTransport(BluetoothTransport.AuthenticateWith1234Once);
		private bool _disposed;
		public int Generation
		{
			get;
			set;
		}
		public int MaxMessageSize
		{
			get
			{
				return 1024;
			}
		}

		public string SerialNumber
		{
			get
			{
				return this._serialNumber;
			}
		}

		public int TripTime
		{
			get
			{
				return 40;
			}
		}
		public string UserVisibleType
		{
			get
			{
				return "BTH";
			}
		}

		public BluetoothTransport(BluetoothDeviceInfo info)
		{
			this._info = info;
			this._serialNumber = info.get_DeviceAddress().ToString();
			this._transportStatus = DeviceTransportStatus.Available;
		}

		public CasperErrorCode Connect()
		{
			CasperErrorCode result;
			lock (this._sendMutex)
			{
				if (this.State == DeviceTransportStatus.Connected)
				{
					result = CasperErrorCode.NoError;
				}
				else
				{
					int timeToWait = (int)(this._lastConnection - System.DateTime.Now).TotalMilliseconds + this._millisecondsToWaitToReconnect;
					if (timeToWait > 0)
					{
						System.Console.WriteLine("Waiting for {0} milliseconds...", timeToWait);
						System.Threading.Thread.Sleep(timeToWait);
					}
					X3Log.DebugLog.WriteLine("Connecting to brick via BTH");
					AuthenticateTransport authenticator = this.Parent.Manager.AuthenticateTransport ?? BluetoothTransport._defaultAthenticateTransport;
					BluetoothEndPoint endpt = new BluetoothEndPoint(this._info.get_DeviceAddress(), BluetoothService.SerialPort);
					this._bthclient = new BluetoothClient();
					this._info.Refresh();
					string authenticationToken = authenticator("BTH", this.Parent.SerialNumber);
					if (authenticationToken != null)
					{
						if (string.IsNullOrEmpty(authenticationToken))
						{
							X3Log.DebugLog.WriteLine("Bluetooth Authentication Needed");
							result = CasperErrorCode.AuthenticationNeeded;
							return result;
						}
						if (!BluetoothSecurity.PairRequest(this._info.get_DeviceAddress(), authenticationToken))
						{
							X3Log.DebugLog.WriteLine("Bluetooth Connection Failed: {0}", new object[]
							{
								this.SerialNumber
							});
							result = CasperErrorCode.TransportUnavailable;
							return result;
						}
					}
					try
					{
						this._bthclient.Connect(endpt);
					}
					catch (System.Net.Sockets.SocketException e)
					{
						X3Log.DebugLog.WriteLine("Bluetooth Connection SocketException {0}", new object[]
						{
							this._serialNumber
						});
						X3Log.DebugLog.WriteLine("Bluetooth exception {0}", new object[]
						{
							e
						});
						BluetoothClient bthclient = this._bthclient;
						if (bthclient != null)
						{
							this._bthclient.Dispose();
						}
						this._bthclient = null;
						if (BluetoothRadio.get_PrimaryRadio() == null)
						{
							this.State = DeviceTransportStatus.Disabled;
							result = CasperErrorCode.TransportUnavailable;
							return result;
						}
						if (e.SocketErrorCode == System.Net.Sockets.SocketError.InvalidArgument)
						{
							result = CasperErrorCode.AuthenticationNeeded;
							return result;
						}
						if (e.SocketErrorCode == System.Net.Sockets.SocketError.AddressAlreadyInUse)
						{
							this.State = DeviceTransportStatus.Available;
							result = CasperErrorCode.AuthenticationNeeded;
							return result;
						}
						this.State = DeviceTransportStatus.Disabled;
						result = CasperErrorCode.TransportUnavailable;
						return result;
					}
					catch (System.Exception)
					{
						X3Log.DebugLog.WriteLine("Bluetooth Connection: " + this._serialNumber);
						throw;
					}
					try
					{
						X3Log.DebugLog.WriteLine("Bluetooth Connection Successful: {0}", new object[]
						{
							this._serialNumber
						});
						this._stream = this._bthclient.GetStream();
						this._writer = new System.IO.BinaryWriter(this._stream);
						this._reader = new System.IO.BinaryReader(this._stream);
						this._stream.ReadTimeout = -1;
						this._receiveWorker = new System.Threading.Thread(new System.Threading.ThreadStart(this.RecvWorker))
						{
							Name = "BluetoothTportWorker: " + this.Parent.SerialNumber,
							IsBackground = true
						};
						this._receiveWorker.Start();
						this.State = DeviceTransportStatus.Connected;
						result = CasperErrorCode.NoError;
					}
					catch (System.InvalidOperationException ex)
					{
						X3Log.DebugLog.WriteLine("Bluetooth connection Failed: " + this._serialNumber);
						X3Log.DebugLog.WriteLine("Bluetooth InvalidOperationException: {0} ", new object[]
						{
							ex
						});
						this.State = DeviceTransportStatus.Available;
						result = CasperErrorCode.TransportUnavailable;
					}
				}
			}
			return result;
		}

		public CasperErrorCode SendMessage(byte[] buffer, short sequenceId)
		{
			if (buffer.Length == 0)
			{
				return CasperErrorCode.NoError;
			}
			try
			{
				lock (this._sendMutex)
				{
					if (this.State != DeviceTransportStatus.Connected)
					{
						CasperErrorCode result = CasperErrorCode.NotConnected;
						return result;
					}
					this._writer.Write((ushort)(buffer.Length + 2));
					this._writer.Write((ushort)sequenceId);
					this._writer.Write(buffer);
					this._writer.Flush();
				}
			}
			catch (System.IO.IOException e)
			{
				X3Log.DebugLog.WriteLine("Bluetooth IOException e:{0} ", new object[]
				{
					e
				});
				this.DisconnectWorker();
				this.State = DeviceTransportStatus.Disabled;
				CasperErrorCode result = CasperErrorCode.TransportUnavailable;
				return result;
			}
			catch (System.NullReferenceException)
			{
				X3Log.DebugLog.WriteLine("Bluetooth NullReferenceException");
				this.DisconnectWorker();
				this.State = DeviceTransportStatus.Disabled;
				CasperErrorCode result = CasperErrorCode.TransportUnavailable;
				return result;
			}
			catch (System.Exception e2)
			{
				X3Log.DebugLog.WriteLine("Bluetooth exception e:{0} ", new object[]
				{
					e2
				});
				throw;
			}
			return CasperErrorCode.NoError;
		}

		private void RecvWorker()
		{
			try
			{
				int messageSize;
				while (true)
				{
					messageSize = (int)this._reader.ReadUInt16();
					if (messageSize > this.MaxMessageSize)
					{
						break;
					}
					short sequenceID = this._reader.ReadInt16();
					messageSize -= 2;
					byte[] msg = this._reader.ReadBytes(messageSize);
					this.Parent.MessageReceived(msg, sequenceID, this);
				}
				X3Log.DebugLog.WriteLine("BluetoothTransport : Packet did not match EV3 protocol");
				X3Log.DebugLog.WriteLine("   Packet indicated size was {0}, should typically be less than 1K", new object[]
				{
					messageSize
				});
				X3Log.DebugLog.WriteLine("   Typically caused by having iPad/iPhone support enabled on brick", new object[]
				{
					messageSize
				});
				X3Log.DebugLog.WriteLine("   Connection will be closed.", new object[]
				{
					messageSize
				});
			}
			catch (System.IO.IOException exception)
			{
				X3Log.DebugLog.WriteLine("BTH: Connection closed by peer. {0}", new object[]
				{
					exception
				});
			}
			catch (System.InvalidOperationException exception2)
			{
				X3Log.DebugLog.WriteLine("BTH: Bumpy shutdown of BT connection {0}", new object[]
				{
					exception2
				});
			}
			finally
			{
				this.DestructionWorker();
				this._receiveWorker = null;
				this.State = DeviceTransportStatus.Available;
			}
		}

		private static string AuthenticateWith1234Once(string transport, string serial)
		{
			return "1234";
		}
*)

procedure LoadEV3BTHTransports(List : TInterfaceList);
begin
  List.Add(TEV3NullTransport.Create);
end;

end.
