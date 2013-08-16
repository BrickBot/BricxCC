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
unit uEV3TCPTransport;

interface

uses
  Classes, uEV3Transport;

type
  TEV3HIDTransport = class(TInterfacedObject, IEV3Transport)
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

procedure LoadEV3TCPTransports(List : TInterfaceList);

implementation

uses
  SysUtils;

{ TEV3HIDTransport }

procedure TEV3HIDTransport.Close;
begin
  // nothing to close;
end;

function TEV3HIDTransport.Open: boolean;
begin
  // cannot be opened
  Result := False;
end;

function TEV3HIDTransport.IsOpen: boolean;
begin
  // cannot be opened
  Result := False;
end;

function TEV3HIDTransport.ReceiveMessage(var Buffer: TEV3Data; Timeout: Word; Id : Word): Word;
begin
  Result := 0;
  if not IsOpen then
    Exit;
end;

function TEV3HIDTransport.SendMessage(SequenceId: Word; var Buffer: TEV3Data): integer;
begin
  Result := 0;
  if not IsOpen then
    Exit;
end;

function TEV3HIDTransport.SendStream(SequenceId: Word; aStream: TStream): integer;
begin
  Result := 0;
  if not IsOpen then
    Exit;
end;

function TEV3HIDTransport.GetMaxMessageSize: integer;
begin
  Result := 1024;
end;

function TEV3HIDTransport.GetSerialNumber: string;
begin
  Result := '0';
end;

function TEV3HIDTransport.GetUserVisibleType: string;
begin
  Result := 'tcp';
end;


(*
		private const int ConnectTimeout = 2500;
		private string _serialNumber;
		private System.Net.IPEndPoint _address;
		private string _contentType;
		private System.Net.Sockets.TcpClient _client;
		private System.Net.Sockets.NetworkStream _stream;
		private System.IO.MemoryStream _writerstorage;
		private System.IO.BinaryReader _reader;
		private System.IO.BinaryWriter _writer;
		private volatile bool _intentionalClose;
		private System.Threading.Thread _receiveWorker;
		private DeviceTransportStatus _transportStatus;
		internal System.DateTime LastSeen;
		private bool _disposed;
		public System.Net.IPEndPoint Address
		{
			get
			{
				return this._address;
			}
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
		public DeviceTransportStatus State
		{
			get
			{
				return this._transportStatus;
			}
			private set
			{
				bool changed = this._transportStatus != value;
				this._transportStatus = value;
				if (changed)
				{
					this.Parent.UpdateTransport(this);
				}
			}
		}
		public int TripTime
		{
			get
			{
				return 10;
			}
		}
		public string UserVisibleType
		{
			get
			{
				return "TCP";
			}
		}
		public TcpTransport(System.Net.IPEndPoint address, string serialNumber)
		{
			this._address = address;
			this._serialNumber = serialNumber;
			this._contentType = "EV3";
			this._transportStatus = DeviceTransportStatus.Available;
			this.LastSeen = System.DateTime.Now;
		}

		public CasperErrorCode Connect()
		{
			if (this.State == DeviceTransportStatus.Connected)
			{
				return CasperErrorCode.NoError;
			}
			CasperErrorCode result;
			try
			{
				X3Log.DebugLog.WriteLine("Connecting via TCP: {0}", new object[]
				{
					this._serialNumber
				});
				this._client = new System.Net.Sockets.TcpClient();
				System.IAsyncResult ar = this._client.BeginConnect(this._address.Address, this._address.Port, null, null);
				if (!ar.AsyncWaitHandle.WaitOne(2500, false))
				{
					this._client.Close();
					this._client = null;
					X3Log.DebugLog.WriteLine("TCP Connection Timed Out: {0}", new object[]
					{
						this._serialNumber
					});
					result = CasperErrorCode.TransportUnavailable;
				}
				else
				{
					this._client.EndConnect(ar);
					this._client.NoDelay = true;
					this._stream = this._client.GetStream();
					this._reader = new System.IO.BinaryReader(this._stream);
					this._writerstorage = new System.IO.MemoryStream();
					this._writer = new System.IO.BinaryWriter(this._writerstorage);
					if (!this.ProcessHeaders(this._serialNumber, this._contentType))
					{
						this._client.Close();
						this.State = DeviceTransportStatus.Disabled;
						X3Log.DebugLog.WriteLine("TCP Headers corrupt: {0}", new object[]
						{
							this._serialNumber
						});
						result = CasperErrorCode.TransportUnavailable;
					}
					else
					{
						this._receiveWorker = new System.Threading.Thread(new System.Threading.ThreadStart(this.RecvWorker))
						{
							Name = "TcpTportWorker: " + this.Parent.SerialNumber,
							IsBackground = true
						};
						this._receiveWorker.Start();
						X3Log.DebugLog.WriteLine("TCP Connection Success: {0}", new object[]
						{
							this._serialNumber
						});
						this.State = DeviceTransportStatus.Connected;
						result = CasperErrorCode.NoError;
					}
				}
			}
			catch (System.Net.Sockets.SocketException ex)
			{
				X3Log.DebugLog.ReportError(ex, "TCP Connection SocketException: " + this._serialNumber);
				this.State = DeviceTransportStatus.Disabled;
				result = CasperErrorCode.TransportUnavailable;
			}
			catch (System.IO.IOException ex2)
			{
				X3Log.DebugLog.ReportError(ex2, "TCP Connection IOException: " + this._serialNumber);
				this.State = DeviceTransportStatus.Disabled;
				result = CasperErrorCode.TransportUnavailable;
			}
			return result;
		}

		public CasperErrorCode SendMessage(byte[] buffer, short sequenceId)
		{
			if (buffer.Length == 0)
			{
				return CasperErrorCode.NoError;
			}
			if (this.State != DeviceTransportStatus.Connected)
			{
				return CasperErrorCode.NotConnected;
			}
			try
			{
				lock (this._writer)
				{
					this._writerstorage.SetLength(0L);
					this._writer.Write((short)(buffer.Length + 2));
					this._writer.Write(sequenceId);
					this._writer.Write(buffer);
					this._stream.Write(this._writerstorage.GetBuffer(), 0, buffer.Length + 4);
				}
			}
			catch (System.IO.IOException e)
			{
				X3Log.DebugLog.ReportError(e, "TCP SendMessage");
				this.DisconnectWorker();
				this.State = DeviceTransportStatus.Disabled;
				return CasperErrorCode.TransportUnavailable;
			}
			return CasperErrorCode.NoError;
		}

		private bool ProcessHeaders(string serialNumber, string contentType)
		{
			System.IO.StreamWriter streamWriter = new System.IO.StreamWriter(this._stream);
			System.IO.StreamReader streamReader = new System.IO.StreamReader(this._stream);
			bool result;
			try
			{
				this._stream.ReadTimeout = (this._stream.WriteTimeout = 2500);
				streamWriter.Write("GET /target?sn={0} VMTP1.0\r\nProtocol: {1}\r\n\r\n", serialNumber, contentType);
				streamWriter.Flush();
				string line = streamReader.ReadLine();
				bool success = !string.IsNullOrEmpty(line);
				while (!string.IsNullOrEmpty(streamReader.ReadLine()))
				{
				}
				result = success;
			}
			catch (System.IO.IOException)
			{
				result = false;
			}
			finally
			{
				this._stream.ReadTimeout = (this._stream.WriteTimeout = -1);
			}
			return result;
		}
		private void RecvWorker()
		{
			this._intentionalClose = false;
			try
			{
				while (true)
				{
					int messageSize = (int)(this._reader.ReadInt16() - 2);
					short sequenceID = this._reader.ReadInt16();
					byte[] msg = this._reader.ReadBytes(messageSize);
					this.Parent.MessageReceived(msg, sequenceID, this);
				}
			}
			catch (System.IO.IOException)
			{
			}
			catch (System.ArgumentOutOfRangeException)
			{
			}
			finally
			{
				this._receiveWorker = null;
				this.DestructionWorker();
				if (!this._intentionalClose)
				{
					this.State = DeviceTransportStatus.Disabled;
				}
			}
		}


using NationalInstruments.X3.Shared;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
namespace NationalInstruments.Casper
{
	public sealed class TcpDeviceDiscoveryService : IDiscoveryService, System.IDisposable
	{
		private const int BroadcastListenPort = 3015;
		private const int CullInterval = 12000;
		private System.TimeSpan _oldnessCutoff = new System.TimeSpan(0, 0, 12);
		private static string _transportIdentifier = "TCP";
		private static char[] _lineSeparators = "\r\n".ToCharArray();
		private System.Collections.Generic.Dictionary<string, TcpTransport> _announcedTransports;
		private int _cullInterlock;
		private System.Threading.Timer _cullTimer;
		private System.Threading.Thread _udpListener;
		private System.Net.Sockets.UdpClient _udpSocket;
		private bool _disposed;
		public string DiscoveryServiceName
		{
			get
			{
				return TcpDeviceDiscoveryService._transportIdentifier;
			}
		}
		public OnNewTransportFound OnNewTransportFound
		{
			get;
			set;
		}
		public System.Collections.Generic.IEnumerable<string> SupportedTransportTypes
		{
			get
			{
				return new string[]
				{
					TcpDeviceDiscoveryService._transportIdentifier
				};
			}
		}
		public System.Collections.Generic.IEnumerable<string> KnownTransportTypes
		{
			get
			{
				return new string[]
				{
					TcpDeviceDiscoveryService._transportIdentifier
				};
			}
		}
		public TcpDeviceDiscoveryService()
		{
			this._announcedTransports = new System.Collections.Generic.Dictionary<string, TcpTransport>();
		}
		public void ForceActiveScan(System.Collections.Generic.IEnumerable<string> transports)
		{
		}
		public void EnablePassiveScan(System.Collections.Generic.IEnumerable<string> transports)
		{
			if (TcpDeviceDiscoveryService.Supported(transports))
			{
				if (this._udpSocket == null)
				{
					this._udpSocket = new System.Net.Sockets.UdpClient();
					this._udpSocket.EnableBroadcast = true;
					this._udpSocket.Client.SetSocketOption(System.Net.Sockets.SocketOptionLevel.Socket, System.Net.Sockets.SocketOptionName.ReuseAddress, true);
					this._udpSocket.Client.Bind(new System.Net.IPEndPoint(System.Net.IPAddress.Any, 3015));
				}
				if (this._udpListener == null)
				{
					this._udpListener = new System.Threading.Thread(new System.Threading.ThreadStart(this.UdpListenThreadMain));
					this._udpListener.Name = "TcpDeviceDiscoveryThread";
					this._udpListener.IsBackground = true;
					this._udpListener.Start();
				}
				if (this._cullTimer == null)
				{
					this._cullTimer = new System.Threading.Timer(new System.Threading.TimerCallback(this.CullOldTransports), null, 0, 12000);
				}
			}
		}
		private void AddTcpTransportFromAnnouncement(string message, System.Net.IPAddress ipAddress)
		{
			string sport = null;
			string serialNumber = null;
			string name = null;
			string protocol = null;
			string[] lines = message.Split(TcpDeviceDiscoveryService._lineSeparators, System.StringSplitOptions.RemoveEmptyEntries);
			if (lines.Count<string>() == 1)
			{
				string[] parameters = lines[0].Split(new char[]
				{
					':'
				});
				if (parameters.Length >= 5)
				{
					sport = parameters[2];
					serialNumber = parameters[3];
					name = parameters[4];
					protocol = ((parameters.Length > 5) ? parameters[5] : "EV3");
				}
			}
			else
			{
				string[] array = lines;
				for (int i = 0; i < array.Length; i++)
				{
					string line = array[i];
					string[] parameters = line.Split(new char[]
					{
						':'
					});
					if (parameters.Count<string>() == 2)
					{
						string value = parameters[1].Trim();
						string a;
						if ((a = parameters[0]) != null)
						{
							if (!(a == "Port"))
							{
								if (!(a == "Name"))
								{
									if (!(a == "Serial-Number"))
									{
										if (a == "Protocol")
										{
											protocol = value;
										}
									}
									else
									{
										serialNumber = value.ToUpperInvariant();
									}
								}
								else
								{
									name = value;
								}
							}
							else
							{
								sport = value;
							}
						}
					}
				}
			}
			int port;
			if (!int.TryParse(sport, out port))
			{
				X3Log.DebugLog.WriteLine("Tcp Port unparseable: {0}", new object[]
				{
					sport
				});
				return;
			}
			if (serialNumber == null || protocol == null)
			{
				X3Log.DebugLog.WriteLine("Tcp Information missing. Serial: {0}\t Protocol: {1}", new object[]
				{
					serialNumber,
					protocol
				});
				return;
			}
			System.Net.IPEndPoint address = new System.Net.IPEndPoint(ipAddress, port);
			foreach (System.Collections.Generic.KeyValuePair<string, TcpTransport> oldTransport in this._announcedTransports)
			{
				if (oldTransport.Value.SerialNumber == serialNumber && object.Equals(oldTransport.Value.Address, address))
				{
					X3Log.DebugLog.WriteLine("TCP Name Change from {0}:\n\t{1}", new object[]
					{
						ipAddress,
						message
					});
					oldTransport.Value.Parent.Name = name;
					this._announcedTransports.Add(message, oldTransport.Value);
					this._announcedTransports.Remove(oldTransport.Key);
					return;
				}
			}
			TcpTransport newTransport = null;
			lock (this._announcedTransports)
			{
				newTransport = new TcpTransport(address, serialNumber);
				this._announcedTransports.Add(message, newTransport);
			}
			this.OnNewTransportFound(newTransport);
			newTransport.Parent.DeviceType = protocol;
			if (name != null)
			{
				newTransport.Parent.Name = name;
			}
		}
		private void CullOldTransports(object state)
		{
			try
			{
				if (System.Threading.Interlocked.Increment(ref this._cullInterlock) == 1)
				{
					lock (this._announcedTransports)
					{
						System.DateTime limit = System.DateTime.Now - this._oldnessCutoff;
						foreach (TcpTransport tport in this._announcedTransports.Values)
						{
							if (tport != null && tport.State != DeviceTransportStatus.Connected && tport.LastSeen < limit)
							{
								tport.Disable();
							}
						}
					}
				}
			}
			finally
			{
				System.Threading.Interlocked.Decrement(ref this._cullInterlock);
			}
		}
		private void UdpListenThreadMain()
		{
			try
			{
				System.Net.IPEndPoint sender = new System.Net.IPEndPoint(System.Net.IPAddress.Any, 0);
				while (true)
				{
					while (true)
					{
						byte[] data;
						try
						{
							data = this._udpSocket.Receive(ref sender);
						}
						catch (System.Net.Sockets.SocketException)
						{
							break;
						}
						string message = System.Text.Encoding.ASCII.GetString(data);
						message += string.Format(System.Globalization.CultureInfo.InvariantCulture, "SourceAddress: {0}:{1}\r\n", new object[]
						{
							sender.Address,
							sender.Port
						});
						TcpTransport tport = null;
						if (this._announcedTransports.TryGetValue(message, out tport))
						{
							if (tport != null)
							{
								tport.Revive();
							}
						}
						else
						{
							X3Log.DebugLog.WriteLine("TcpDeviceDiscoveryService: New Announcement" + System.Environment.NewLine + message);
							this.AddTcpTransportFromAnnouncement(message, sender.Address);
							byte[] derpy = System.Text.Encoding.ASCII.GetBytes("Derpy Derp Derp");
							this._udpSocket.Send(derpy, derpy.Length, sender);
						}
					}
				}
			}
			catch (System.Net.Sockets.SocketException)
			{
			}
			catch (System.ObjectDisposedException)
			{
			}
			finally
			{
				this._udpListener = null;
				System.Net.Sockets.UdpClient udpSocket = this._udpSocket;
				this._udpSocket = null;
				if (udpSocket != null)
				{
					udpSocket.Close();
				}
				System.Threading.Timer cullTimer = this._cullTimer;
				this._cullTimer = null;
				if (cullTimer != null)
				{
					cullTimer.Dispose();
				}
			}
		}
		public void DisablePassiveScan(System.Collections.Generic.IEnumerable<string> transports)
		{
			if (TcpDeviceDiscoveryService.Supported(transports))
			{
				System.Net.Sockets.UdpClient udpSocket = this._udpSocket;
				if (udpSocket != null)
				{
					udpSocket.Close();
				}
			}
		}
		private static bool Supported(System.Collections.Generic.IEnumerable<string> transports)
		{
			return transports == null || transports.Contains(TcpDeviceDiscoveryService._transportIdentifier);
		}
		public void Dispose()
		{
			this.Dispose(true);
		}
		private void Dispose(bool freeManagedObjectsAlso)
		{
			if (!this._disposed && freeManagedObjectsAlso)
			{
				if (this._cullTimer != null)
				{
					this._cullTimer.Dispose();
					this._cullTimer = null;
				}
				if (this._udpSocket != null)
				{
					this._udpSocket.Close();
				}
			}
			this._disposed = true;
		}
	}
}

*)

procedure LoadEV3TCPTransports(List : TInterfaceList);
begin
  // iterate through addresses on the same network as this PC
  // e.g., if this machine has IP = 192.168.2.123
  // then try IPs from 192.168.2.0 through 192.168.2.255
  List.Add(TEV3NullTransport.Create);
end;

end.
