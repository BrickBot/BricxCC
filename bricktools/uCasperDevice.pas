unit uCasperDevice;

interface

uses
  Classes, Contnrs, SysUtils, SyncObjs, uCasperTypes, uPBRSimpleTypes;

type
  EOperationCanceledException = class(Exception);
  EIOException = class(Exception);
  EThreadAbortException = class(Exception);
  ETimeoutException = class(Exception);
  EFileNotFoundException = class(Exception)
  public
    constructor Create();
  end;
  ENotSupportedException = class(Exception)
  public
    constructor Create();
  end;
  ENotImplementedException = class(Exception);

  TCasperDevice = class;

  IDeviceTransport = interface
    function GetMaxMessageSize : integer;
    function GetParent : TCasperDevice;
    procedure SetParent(aParent : TCasperDevice);
    function GetSerialNumber : string;
    function GetState : TDeviceTransportStatus;
    function GetUserVisibleType : string;
    
    function Connect : boolean;
    procedure Disable;
    procedure Disconnect;
    procedure Revive;
    function SendMessage(buffer : TStream; sequenceId : Word) : TCasperErrorCode;

    property MaxMessageSize : integer read GetMaxMessageSize;
    property Parent : TCasperDevice read GetParent write SetParent;
    property SerialNumber : string read GetSerialNumber;
    property State : TDeviceTransportStatus read GetState;
    property UserVisibleType : string read GetUserVisibleType;
  end;

  TPendingResponse = class
  private
    fStatus: Exception;
    fTimingDebug: boolean;
    fDisposed : boolean;
    fStartTime: TDateTime;
    fBuffer: TStream;
    fEvent: TEvent;
    function GetMessageReady: boolean;
    procedure SetBuffer(const Value: TStream);
  public
    constructor Create;
    destructor Destroy; override;
    function ReceiveMessage(timeout : integer) : TStream; overload;
    function ReceiveMessage : TStream; overload;
    function TryReceiveMessage(aMessage : TStream; timeout : integer) : boolean; overload;
    function TryReceiveMessage(aMessage : TStream) : boolean; overload;
    procedure ReadBuffer(offset : integer; var aValue : ShortInt); overload;
    procedure ReadBuffer(offset : integer; var aValue : byte); overload;
    procedure ReadBuffer(offset : integer; var aValue: SmallInt); overload;
    procedure ReadBuffer(offset : integer; var aValue : Word); overload;
    procedure ReadBuffer(offset : integer; var aValue : Integer); overload;
    procedure ReadBuffer(offset : integer; var aValue : Cardinal); overload;
    // properties
    property Status : Exception read fStatus write fStatus;
    property TimingDebug : boolean read fTimingDebug write fTimingDebug;
    property StartTime : TDateTime read fStartTime write fStartTime;
    property Buffer : TStream read fBuffer write SetBuffer;
    property Event : TEvent read fEvent write fEvent;
    property MessageReady : boolean read GetMessageReady;
  end;

  TPendingResponseCache = class
  private
    fList : TStringList;
    function GetValues(aIndex: integer): TPendingResponse;
    function SequenceIdAsString(aSequenceID : Word) : string;
  public
    constructor Create;
    destructor Destroy; override;
    function ContainsKey(aSequenceID : Word) : boolean;
    function Add(aSequenceID : Word; aPendingResponse : TPendingResponse) : integer;
		function TryGetValue(aSequenceID : Word; out response : TPendingResponse) : boolean;
		procedure Remove(aSequenceID : Word);
    function Count : integer;
    function IndexOf(aSequenceID : Word) : integer;
    procedure Clear;
    property Values[aIndex : integer] : TPendingResponse read GetValues; default;
  end;

  TCasperDevice = class
  private
    fActiveTransport : IDeviceTransport;
    fTransports : TInterfaceList;
    fAllowableTransports : TInterfaceList;
    fAllowedTransportIdentifiers : TStrings;
    fDeviceType : string;
    fName : string;
    fSequenceID : word;
    fPendingResponses : TPendingResponseCache;
    fSerialNumber: string;
    fOnDeviceChanged: TNotifyEvent;
    fAvailableTransportNames : TStrings;
    fStreamState : TPBrickStreamState;
    procedure SetATI(const Value: TStrings);
		function AllowedTransport(transport : string) : boolean;
    procedure SetName(const Value: string);
    procedure SetDeviceType(const Value: string);
    function GetRecommendedMessageSize: integer;
    function GetConnectedTransport: string;
    function SendMessage(buffer : TStream; aSequenceID : Word) : TCasperErrorCode; overload;
    procedure AddTransport(transport : IDeviceTransport);
    function GetNextSequenceID : Word;
    procedure PoisonTokenCache;
    procedure MessageReceived(msg : TStream; aSequenceID : Word; receiver : IDeviceTransport);
  public
    constructor Create(aSerialNumber : string);
    destructor Destroy; override;
    procedure Update(rs : TPBrickRecoveryState; current, total : integer);
    // methods
    function Connect : TCasperErrorCode; overload;
    function Connect(reviveDisabledTransports : boolean) : TCasperErrorCode; overload;
    procedure Disconnect;
    function GetAvailableTransports : TStrings;
    function GetState : TDeviceTransportStatus;
    function SendMessage(msg : TStream; requestResponse : boolean) : TPendingResponse; overload;
    procedure UpdateTransport(transport : IDeviceTransport);
    // pbr methods
    procedure Recover(fileName: string);
    function EraseFlash : integer;
    procedure BeginFlashDownload(address, imageSize: integer);
    procedure BeginFlashDownloadWithErase(address, imageSize: integer);
    function DownloadProgram(image: TStream): cardinal;
    function GetChecksum(address, imageSize: integer): cardinal;
    procedure GetVersion(out firmwareId, hardwareId: integer);
    procedure StartApplication;
    // pbr file methods
    procedure FileCloseHandle(handle: byte);
    procedure FileOpenRead(path: string; out handle: byte; out length: integer);
    function FileRead(handle: byte; aStream: TStream; offset, count : integer;
      out length : integer; var position : integer) : integer;
    procedure DownloadFileToDevice(filename : string; data : TStream; overwrite : boolean);
    // pbr device info
    procedure AutoIDHardware();
    procedure GetDeviceInfo(out availableFlash, batteryLevel: integer);
    // properties
    property AllowedTransports : TStrings read fAllowedTransportIdentifiers write SetATI;
    property SerialNumber : string read fSerialNumber;
    property Name : string read fName write SetName;
    property DeviceType : string read fDeviceType write SetDeviceType;
    property RecommendedMessageSize : integer read GetRecommendedMessageSize;
    property StreamState : TPBrickStreamState read fStreamState write fStreamState;
//    property Manager : TDiscoveryManager read fManager;
    property ConnectedTransport : string read GetConnectedTransport;
    property OnDeviceChanged : TNotifyEvent read fOnDeviceChanged write fOnDeviceChanged;
  end;

  function CasperErrorCodeToStr(aCec : TCasperErrorCode) : string;

implementation

uses
  Math, uPBRMiscTypes, uStreamRW;

function CasperErrorCodeToStr(aCec : TCasperErrorCode) : string;
begin
  case aCec of
    cecNoError : Result := 'cecNoError';
    cecTransportUnavailable : Result := 'cecTransportUnavailable';
    cecMessageTooLarge : Result := 'cecMessageTooLarge';
    cecNoTransportsAvailable : Result := 'cecNoTransportsAvailable';
    cecNotConnected : Result := 'cecNotConnected';
  end;
end;

{ TPendingResponse }

constructor TPendingResponse.Create;
begin
  inherited;
  fStartTime := Now;
  fBuffer := TMemoryStream.Create;
  fEvent := TEvent.Create(nil, true, false, 'PendingResponseEvent');
end;

destructor TPendingResponse.Destroy;
begin
  FreeAndNil(fBuffer);
  FreeAndNil(fEvent);
  inherited;
end;

function TPendingResponse.GetMessageReady: boolean;
begin
  Result := (Event.WaitFor(1) = wrSignaled);
end;

function TPendingResponse.ReceiveMessage(timeout: integer): TStream;
var
  timedOut : boolean;
begin
  timedOut := (Event.WaitFor(timeout) = wrTimeout);
  if Status <> nil then
    raise Status;
  if timedOut then
  begin
    Result := Buffer;
    Exit;
  end;
  raise ETimeoutException.Create('ReceiveMessage timed out.');
end;

function TPendingResponse.ReceiveMessage: TStream;
begin
  Result := ReceiveMessage(1000);
end;

function TPendingResponse.TryReceiveMessage(aMessage: TStream; timeout: integer): boolean;
var
  timedOut : boolean;
begin
  if Assigned(aMessage) then
    aMessage.Size := 0; // empty the stream
  timedOut := (Event.WaitFor(timeout) = wrTimeout);
  if not timedOut or (Status <> nil) then
  begin
    if Assigned(aMessage) then
      aMessage.Size := 0;
    Result := False;
  end
  else
  begin
//    if (PendingResponse.TimingDebug)
//    {
//      System.Console.WriteLine("Response Time: {0}", (System.DateTime.Now - this.StartTime).TotalMilliseconds);
//    }
    if Assigned(aMessage) then
      aMessage.CopyFrom(Buffer, 0);
    Result := True;
  end;
end;

procedure TPendingResponse.SetBuffer(const Value: TStream);
begin
  fBuffer.CopyFrom(Value, 0);
end;

function TPendingResponse.TryReceiveMessage(aMessage: TStream): boolean;
begin
  Result := TryReceiveMessage(aMessage, 1000);
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: ShortInt);
var
  tmp : ShortInt;
begin
  ReadBuffer(offset, tmp);
  aValue := ShortInt(tmp);
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue : byte);
begin
  aValue := 0;
  if MessageReady then
  begin
    fBuffer.Seek(offset, soBeginning);
    aValue := ReadByte(fBuffer);
  end;
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: SmallInt);
var
  tmp : Word;
begin
  ReadBuffer(offset, tmp);
  aValue := SmallInt(tmp);
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: Word);
begin
  aValue := 0;
  if MessageReady then
  begin
    fBuffer.Seek(offset, soBeginning);
    aValue := ReadWord(fBuffer);
  end;
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: Integer);
var
  tmp : Cardinal;
begin
  ReadBuffer(offset, tmp);
  aValue := Integer(tmp);
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: Cardinal);
begin
  aValue := 0;
  if MessageReady then
  begin
    fBuffer.Seek(offset, soBeginning);
    aValue := ReadCardinal(fBuffer);
  end;
end;

{ TPendingResponseCache }

function TPendingResponseCache.Add(aSequenceID: Word;
  aPendingResponse: TPendingResponse): integer;
begin
  Result := fList.AddObject(SequenceIdAsString(aSequenceID), aPendingResponse);
end;

procedure TPendingResponseCache.Clear;
begin
  fList.Clear;
end;

function TPendingResponseCache.ContainsKey(aSequenceID: Word): boolean;
begin
  Result := IndexOf(aSequenceID) <> -1;
end;

function TPendingResponseCache.Count: integer;
begin
  Result := fList.Count;
end;

constructor TPendingResponseCache.Create;
begin
  fList := TStringList.Create;
end;

destructor TPendingResponseCache.Destroy;
begin
  FreeAndNil(fList);
  inherited;
end;

function TPendingResponseCache.GetValues(aIndex: integer): TPendingResponse;
begin
  Result := TPendingResponse(fList.Objects[aIndex]);
end;

function TPendingResponseCache.IndexOf(aSequenceID: Word): integer;
begin
  Result := fList.IndexOf(SequenceIdAsString(aSequenceID));
end;

procedure TPendingResponseCache.Remove(aSequenceID: Word);
begin
  fList.Delete(IndexOf(aSequenceID));
end;

function TPendingResponseCache.SequenceIdAsString(aSequenceID: Word): string;
begin
  Result := Format('%16.16d', [aSequenceID]);
end;

function TPendingResponseCache.TryGetValue(aSequenceID: Word;
  out response: TPendingResponse): boolean;
var
  i : integer;
begin
  response := nil;
  i := IndexOf(aSequenceID);
  Result := i <> -1;
  if Result then
    response := TPendingResponse(fList.Objects[i]);
end;

{ TCasperDevice }

procedure TCasperDevice.AddTransport(transport: IDeviceTransport);
begin
//lock (this._transports)
  fTransports.Add(transport);
  transport.Parent := Self;
//unlock (this._transports)

//lock (this._allowableTransports)
  if AllowedTransport(transport.UserVisibleType) then
  begin
    fAllowableTransports.Add(transport);
  end;
//unlock (this._allowableTransports)
  fOnDeviceChanged(nil);
end;

function TCasperDevice.AllowedTransport(transport: string): boolean;
begin
	Result := (AllowedTransports.Count = 0) or
            (AllowedTransports.IndexOf(transport) <> -1);
end;

function TCasperDevice.Connect: TCasperErrorCode;
begin
  Result := Connect(true);
end;

function TCasperDevice.Connect(reviveDisabledTransports: boolean): TCasperErrorCode;
var
  i : integer;
  transport : IDeviceTransport;
begin
  // lock the allowable transport list?

  // revive disabled transports first (if desired)
  if reviveDisabledTransports then
  begin
    for i := 0 to fAllowableTransports.Count - 1 do
    begin
      transport := IDeviceTransport(fAllowableTransports[i]);
      if transport.State = dtsDisabled then
      begin
        transport.Revive;
      end;
    end;
  end;
  // now check if one of the transports is already connected
  for i := 0 to fAllowableTransports.Count - 1 do
  begin
    transport := IDeviceTransport(fAllowableTransports[i]);
    if transport.State = dtsConnected then
    begin
      fActiveTransport := transport;
      result := cecNoError;
      Exit;
    end;
  end;
  for i := 0 to fAllowableTransports.Count - 1 do
  begin
    transport := IDeviceTransport(fAllowableTransports[i]);
    if (transport.State = dtsPreoperational) and transport.Connect then
    begin
      fActiveTransport := transport;
      result := cecNoError;
      Exit;
    end;
  end;
  // error condition
  fActiveTransport := nil;
  PoisonTokenCache;
  result := cecNoTransportsAvailable;

  // unlock allowable transport list?
end;

constructor TCasperDevice.Create(aSerialNumber : string);
begin
  fTransports := TInterfaceList.Create;
  fAllowableTransports := TInterfaceList.Create;
  fAllowedTransportIdentifiers := TStringList.Create;
  fPendingResponses := TPendingResponseCache.Create;
  fAvailableTransportNames := TStringList.Create;
  fSerialNumber := aSerialNumber;
end;

destructor TCasperDevice.Destroy;
begin
  FreeAndNil(fTransports);
  FreeAndNil(fAllowableTransports);
  FreeAndNil(fAllowedTransportIdentifiers);
  FreeAndNil(fPendingResponses);
  FreeAndNil(fAvailableTransportNames);
  inherited;
end;

procedure TCasperDevice.Disconnect;
var
  i : integer;
  transport : IDeviceTransport;
begin
  fActiveTransport := nil;
  for i := 0 to fTransports.Count - 1 do
  begin
    transport := IDeviceTransport(fTransports[i]);
    if transport.State = dtsConnected then
      transport.Disconnect;
  end;
end;

function TCasperDevice.GetAvailableTransports: TStrings;
var
  i : integer;
  transport : IDeviceTransport;
begin
//			lock (this._allowableTransports)
  Result := fAvailableTransportNames;
  Result.Clear;
  for i := 0 to fAllowableTransports.Count - 1 do
  begin
    transport := IDeviceTransport(fAllowableTransports[i]);
    if transport.State <> dtsDisabled then
      Result.Add(transport.UserVisibleType);
  end;
//} // unlock list
end;

function TCasperDevice.GetConnectedTransport: string;
begin
  if fActiveTransport <> nil then
    Result := fActiveTransport.UserVisibleType
  else
    Result := '';
end;

function TCasperDevice.GetNextSequenceID: Word;
begin
//  lock (this._pendingResponses)
  repeat
    Inc(fSequenceID);
  until(not fPendingResponses.ContainsKey(fSequenceID));
//  } unlock list
  Result := fSequenceID;
end;

function TCasperDevice.GetRecommendedMessageSize: integer;
begin
  if fActiveTransport <> nil then
    Result := fActiveTransport.MaxMessageSize
  else
    Result := 0;
end;

function TCasperDevice.GetState: TDeviceTransportStatus;
var
  i : integer;
  transport : IDeviceTransport;
begin
  if fAllowableTransports.Count = 0 then
  begin
    Result := dtsDisabled;
  end
  else
  begin
    // return the min of all the allowable transport's status
    Result := dtsDisabled;
    for i := 0 to fAllowableTransports.Count - 1 do
    begin
      transport := IDeviceTransport(fAllowableTransports[i]);
      if transport.State < Result then
        Result := transport.State;
    end;
  end;
end;

function TCasperDevice.SendMessage(buffer: TStream; aSequenceID: Word): TCasperErrorCode;
var
  transport : IDeviceTransport;
  status : TCasperErrorCode;
begin
  transport := fActiveTransport;
  if transport <> nil then
  begin
    status := transport.SendMessage(buffer, aSequenceID);
    if status <> cecTransportUnavailable then
    begin
      Result := status;
      Exit;
    end;
  end;
// lock (this._allowabletransports)
  while Connect(false) <> cecNoTransportsAvailable do
  begin
    transport := fActiveTransport;
    status := transport.SendMessage(buffer, aSequenceID);
    if status <> cecTransportUnavailable then
    begin
      Result := status;
      Exit;
    end;
  end;
  Result :=  cecNoTransportsAvailable;
// unlock (this._allowabletransports)
end;

procedure TCasperDevice.PoisonTokenCache;
var
  token : TPendingResponse;
  i : integer;
begin
//  lock (this._pendingResponses)
  for i := 0 to fPendingResponses.Count - 1 do
  begin
    token := fPendingResponses[i];
    token.Status := EOperationCanceledException.Create('CasperDevice unable to receive response');
    token.Event.SetEvent;
  end;
  fPendingResponses.Clear;
//  unlock (this._pendingResponses)
end;

function TCasperDevice.SendMessage(msg: TStream; requestResponse: boolean): TPendingResponse;
var
  responseToken : TPendingResponse;
  sequenceID : Word;
  errCode : TCasperErrorCode;
begin
  responseToken := nil;
  sequenceID := GetNextSequenceID;
  if requestResponse then
  begin
    responseToken := TPendingResponse.Create;
    fPendingResponses.Add(sequenceID, responseToken);
  end;
  errCode := SendMessage(msg, sequenceID);
  if (errCode <> cecNoError) and requestResponse then
  begin
    responseToken.Event.SetEvent;
    responseToken.Status := EIOException.Create(CasperErrorCodeToStr(errCode));
  end;
  Result := responseToken;
end;

procedure TCasperDevice.SetATI(const Value: TStrings);
var
  i : integer;
  tport : IDeviceTransport;
begin
  fAllowedTransportIdentifiers.Assign(Value);
  fAllowableTransports.Clear;
  for i := 0 to fTransports.Count - 1 do
  begin
    tport := IDeviceTransport(fTransports[i]);
    if AllowedTransport(tport.UserVisibleType) then
      fAllowableTransports.Add(tport);
  end;
  if (fActiveTransport <> nil) and (fAllowableTransports.IndexOf(fActiveTransport) = -1) then
    fActiveTransport := nil;
end;

procedure TCasperDevice.SetDeviceType(const Value: string);
begin
  if fDeviceType <> Value then
  begin
    fDeviceType := Value;
    fOnDeviceChanged(Self);
  end;
end;

procedure TCasperDevice.SetName(const Value: string);
begin
  if fName <> Value then
  begin
    fName := Value;
    fOnDeviceChanged(Self);
  end;
end;

procedure TCasperDevice.UpdateTransport(transport: IDeviceTransport);
begin
  fOnDeviceChanged(nil);
  if (transport = fActiveTransport) and (transport.State <> dtsConnected) then
    fActiveTransport := nil;
end;

procedure TCasperDevice.MessageReceived(msg: TStream; aSequenceID: Word;
  receiver: IDeviceTransport);
var
  response : TPendingResponse;
begin
  if fPendingResponses.TryGetValue(aSequenceID, response) then
  begin
    fPendingResponses.Remove(aSequenceID);
  end;
  if response = nil then
  begin
//    System.Console.WriteLine("Unknown message received.  SequenceID: {0}\t Transport: {1}", sequenceId, receiver.UserVisibleType);
  end
  else
  begin
    response.Buffer := msg;
    response.Event.SetEvent;
  end;
end;

procedure TCasperDevice.Recover(fileName: string);
var
  image : TMemoryStream;
  checkCrc : boolean;
  expectedChecksum, receivedCheckSum : Cardinal;
begin
  checkCrc := Copy(fileName, 1, 1) = '!';
  if checkCrc then
  begin
    fileName := Copy(fileName, 2, MaxInt);
  end;
  
  try
    image := TMemoryStream.Create;
    try
      try
        image.LoadFromFile(fileName);
        BeginFlashDownloadWithErase(0, Integer(image.Size));
        expectedChecksum := DownloadProgram(image);
        if checkCrc then
          receivedChecksum := GetChecksum(0, Integer(image.Size))
        else
          receivedChecksum := expectedChecksum;
        if expectedChecksum = receivedChecksum then
          StartApplication
        else
          Self.Update(pbrsImageVerificationFailed, 0, 0);
      except
        on E : EIOException do
        begin
          Self.Update(pbrsFileNotFound, 0, 0);
        end
        else
          raise;
      end;
    finally
      image.Free;
    end;
  except
    on E : EThreadAbortException do
    begin
      Update(pbrsAborted, 1, 1);
    end;
  end;
end;

function TCasperDevice.EraseFlash: integer;
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
  start : TDateTime;
begin
  Update(pbrsErasingChip, 0, 1);
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcChipErase);
    start := Now;
    token := Self.SendMessage(command.OutStream, true);
    while not token.TryReceiveMessage(nil, 2000) do
    begin
      Update(pbrsErasingChip, 1, 1);
    end;
  finally
    command.Free;
  end;
  Result := Trunc(TimeStampToMSecs(DateTimeToTimeStamp(Now-start)));
end;

procedure TCasperDevice.BeginFlashDownload(address, imageSize: integer);
var
  command : TPBrickGenericCommandObject;
begin
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcBeginDownload);
    command.Write(address);
    command.Write(imageSize);
    SendMessage(command.OutStream, true).ReceiveMessage(5000);
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.BeginFlashDownloadWithErase(address, imageSize: integer);
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
begin
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcBeginDownloadWithErase);
    command.Write(address);
    command.Write(imageSize);
    token := SendMessage(command.OutStream, true);
    while not token.TryReceiveMessage(nil, 2000) do
    begin
      Update(pbrsErasingChip, 1, 2);
    end;
    Update(pbrsErasingChip, 2, 2);
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.GetVersion(out firmwareId, hardwareId: integer);
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
  status : byte;
begin
  hardwareId := 0;
  firmwareId := 0;
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcGetVersion);
    token := SendMessage(command.OutStream, true);
    if token.TryReceiveMessage(nil, 5000) then
    begin
      token.ReadBuffer(2, status);
      token.ReadBuffer(3, hardwareId);
      token.ReadBuffer(7, firmwareId);
    end;
  finally
    command.Free;
  end;
end;

function TCasperDevice.DownloadProgram(image: TStream): cardinal;
var
  imageLength, totalBytesDownloaded, actualReadSize : integer;
  crc : Cardinal;
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
  calculator : TCrcCalculator;
  payload : TByteArray;
begin
  imageLength := Integer(image.Size);
  Update(pbrsDownloadingImage, 0, imageLength);
  calculator := TCrcCalculator.Create;
  try
    crc := 0;
    command := TPBrickGenericCommandObject.Create;
    try
      command.Write(ctSystemWithReply);
      command.Write(rcDownloadData);
      totalBytesDownloaded := 0;
      actualReadSize := image.Read(payload, 1018);
      while (actualReadSize <> 0) do
      begin
        command.BaseStream.Seek(2, soBeginning);
        command.BaseStream.Size := 2;
        command.BaseStream.Write(payload, actualReadSize);
        crc := calculator.CalculateCrc(payload, actualReadSize, crc);
        token := Self.SendMessage(command.BaseStream, true);
        if not token.TryReceiveMessage(nil, 5000) then
        begin
          Update(pbrsDownloadingImageFailed, totalBytesDownloaded, imageLength);
          break;
        end;
        totalBytesDownloaded := totalBytesDownloaded + actualReadSize;
        Update(pbrsDownloadingImage, totalBytesDownloaded, imageLength);
        actualReadSize := image.Read(payload, 1018);
      end;
      Result := crc;
    finally
      command.Free;
    end;
  finally
    calculator.Free;
  end;
end;

procedure TCasperDevice.StartApplication;
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
begin
  Update(pbrsStartingApplication, 0, 1);
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcStartApp);
    token := SendMessage(command.OutStream, true);
    if token.TryReceiveMessage(nil, 5000) then
    begin
      Update(pbrsStartingApplication, 1, 1);
    end;
  finally
    command.Free;
  end;
end;

function TCasperDevice.GetChecksum(address, imageSize: integer): cardinal;
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
begin
  Update(pbrsStartingApplication, 0, 1);
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcGetChecksum);
    command.Write(address);
    command.Write(imageSize);
    token := SendMessage(command.OutStream, true);
    while not token.TryReceiveMessage(nil, 5000) do
    begin
      Update(pbrsVerifyingImage, 1, 1);
    end;
    if token.MessageReady then
    begin
      token.ReadBuffer(3, Result);
    end;
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.FileCloseHandle(handle : byte);
var
  command : TMemoryStream;
  token : TPendingResponse;
begin
  command := TMemoryStream.Create;
  try
    TSystemCommandBuilder.CloseHandle(handle, command);
    token := SendMessage(command, true);
    token.TryReceiveMessage(nil);
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.FileOpenRead(path : string; out handle : byte; out length : integer);
var
  command : TMemoryStream;
  token : TPendingResponse;
  status : byte;
begin
  command := TMemoryStream.Create;
  try
    TSystemCommandBuilder.BeginGetFile(path, 0, command);
// lock (this._device)
    token := SendMessage(command, true);
    token.TryReceiveMessage(nil, 3000);
// unlock (this._device)
    token.ReadBuffer(2, status);
    case status of
      0 : StreamState := pbssUpload;
      1, 2, 4 : raise EIOException.Create('No PBrick handles available.');
      6 : raise EFileNotFoundException.Create();
    end;
    StreamState := pbssUpload;
    token.ReadBuffer(3, length);
    token.ReadBuffer(7, handle);
  finally
    command.Free;
  end;
end;

function TCasperDevice.FileRead(handle : byte; aStream : TStream;
  offset, count : integer; out length : integer; var position : integer) : integer;
var
  maximumReadSize, actualReadSize : integer;
  fhs : TFileHandlingStatus;
  status : byte;
  command : TMemoryStream;
  token : TPendingResponse;
begin
  token := nil;
  Result := 0;
  if StreamState <> pbssEndOfFile then
  begin
    if StreamState <> pbssUpload then
      raise ENotSupportedException.Create();
    maximumReadSize := min(count, 1010);
    actualReadSize := 0;
    while (actualReadSize = 0) and (StreamState = pbssUpload) do
    begin
      command := TMemoryStream.Create;
      try
        TSystemCommandBuilder.ContinueGetFile(handle, maximumReadSize, command);
        // lock (this._device)
        token := SendMessage(command, true);
        token.TryReceiveMessage(nil);
        // unlock (this._device)
        token.ReadBuffer(2, status);
        fhs := TFileHandlingStatus(status);
        case fhs of
          fhsSuccess : begin
            // do nothing
          end;
          fhsEndOfFile : begin
            StreamState := pbssEndOfFile;
          end;
          fhsUnknownHandle,
          fhsHandleNotReady,
          fhsUnknownError : begin
            StreamState := pbssEndOfFile;
            Result := 0;
            Exit;
          end;
        else
          raise ENotImplementedException('Unknown Error. Status: ' + IntToStr(status));
        end;
      finally
        command.Free;
      end;
      actualReadSize := token.Buffer.Size - 8;
      if actualReadSize = 0 then
      begin
        Sleep(50);
      end;
    end;
    if Assigned(token) then
    begin
      token.ReadBuffer(3, length);
      position := position + actualReadSize;
      CopyStream(token.Buffer, 8, aStream, offset, actualReadSize);
      Result := actualReadSize;
    end;
  end;
end;


procedure TCasperDevice.AutoIDHardware;
var
  command : TMemoryStream;
  token : TPendingResponse;
begin
//			lock (this.CasperDevice)
  command := TMemoryStream.Create;
  try
    TDirectCommandBuilder.BuildCommand(ctDirectWithReply, 16, 0, nil, command);
  finally
    command.Free;
  end;
(*
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 16, 0, new byte[][]
				{
					DirectCommandBuilder.SensorGetType(0, PortId.InputFlag, 0, 4),
					DirectCommandBuilder.SensorGetType(0, PortId.InputTwo, 1, 5),
					DirectCommandBuilder.SensorGetType(0, PortId.InputThree, 2, 6),
					DirectCommandBuilder.SensorGetType(0, PortId.InputFour, 3, 7),
					DirectCommandBuilder.SensorGetType(0, PortId.OutputA, 4, 8),
					DirectCommandBuilder.SensorGetType(0, PortId.OutputB, 5, 9),
					DirectCommandBuilder.SensorGetType(0, PortId.OutputC, 6, 10),
					DirectCommandBuilder.SensorGetType(0, PortId.OutputD, 7, 11)
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok)
				{
					for (int i = 0; i < base.PortHardware.Count<byte>(); i++)
					{
						byte currentSensorType = reply[1 + i];
						base.PortHardware[i] = currentSensorType;
						DetectedHardwareResponse detectedHardwareResponse = new DetectedHardwareResponse();
						detectedHardwareResponse.PortID = this._portIDs[i];
						DetectedHardwareResponse arg_118_0 = detectedHardwareResponse;
						int num = (int)currentSensorType;
						arg_118_0.HardwareID = num.ToString(CultureInfo.InvariantCulture);
						PingBuffer.AddResponse(detectedHardwareResponse);
					}
				}
				else
				{
					PBrickDevice.ReportError("AutoId connected hardware.");
				}
//			unlock (this.CasperDevice)
*)
end;

procedure TCasperDevice.DownloadFileToDevice(filename: string; data : TStream; overwrite : boolean);
begin
(*
		public override void DownloadFileToDevice(string fileName, byte[] data, bool overwrite)
		{
			lock (this.CasperDevice)
			{
				int chunkSize = 900;
				byte[] header = SystemCommandBuilder.FileDownloadHeader(fileName, data);
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(header, true).TryReceiveMessage(out reply);
				if (!ok)
				{
					PBrickDevice.ReportError("begin file.");
				}
				else
				{
					FileHandlingStatus status = (FileHandlingStatus)reply[2];
					byte handle = reply[3];
					if (status == FileHandlingStatus.Success)
					{
						int position = 0;
						while (position < data.Length && ok)
						{
							if (position + chunkSize > data.Length)
							{
								chunkSize = data.Length - position;
							}
							byte[] section = SystemCommandBuilder.FileDownloadSection(data, chunkSize, position, handle);
							ok = this.CasperDevice.SendMessage(section, true).TryReceiveMessage(out reply);
							position += chunkSize;
						}
					}
					if (!ok)
					{
						PBrickDevice.ReportError("file section download.");
					}
					byte[] closeHandle = SystemCommandBuilder.FileDownloadCloseHandle(handle);
					if (!this.CasperDevice.SendMessage(closeHandle, true).TryReceiveMessage(out reply))
					{
						PBrickDevice.ReportError("close file handle on download.");
					}
				}
			}
		}
*)
end;

procedure TCasperDevice.GetDeviceInfo(out availableFlash : integer; out batteryLevel : integer);
begin
(*
		public void GetDeviceInfo()
		{
			ConnectedDeviceInfo deviceInfo = new ConnectedDeviceInfo();
			deviceInfo.AvailableFlash = 0;
			deviceInfo.Ports = this._portList;
			lock (this.CasperDevice)
			{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 4, 0, new byte[][]
				{
					DirectCommandBuilder.GetBrickPowerStatus(0)
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok && reply[0] == 2)
				{
					double voltage = (double)BitConverter.ToSingle(reply, 1);
					if (voltage < 5.5)
					{
						voltage = 5.5;
					}
					else
					{
						if (voltage > 9.0)
						{
							voltage = 9.0;
						}
					}
					deviceInfo.BatteryLevel = (int)((voltage - 5.5) / 3.5 * 100.0);
				}
			}
			PingBuffer.AddResponse(new GetConnectedDeviceInfoResponse
			{
				DeviceInfoUpdate = deviceInfo
			});
		}
*)
end;

(*
		private void GetLiveSensorValues()
		{
			lock (this.CasperDevice)
			{
				byte[] reply = new byte[2000];
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 32, 0, new byte[][]
				{
					DirectCommandBuilder.SensorRead(0, PortId.InputFlag, base.PortHardware[0], 0, true, 0),
					DirectCommandBuilder.SensorRead(0, PortId.InputTwo, base.PortHardware[1], 0, true, 4),
					DirectCommandBuilder.SensorRead(0, PortId.InputThree, base.PortHardware[2], 0, true, 8),
					DirectCommandBuilder.SensorRead(0, PortId.InputFour, base.PortHardware[3], 0, true, 12),
					DirectCommandBuilder.SensorRead(0, PortId.OutputA, base.PortHardware[4], 0, true, 16),
					DirectCommandBuilder.SensorRead(0, PortId.OutputB, base.PortHardware[5], 0, true, 20),
					DirectCommandBuilder.SensorRead(0, PortId.OutputC, base.PortHardware[6], 0, true, 24),
					DirectCommandBuilder.SensorRead(0, PortId.OutputD, base.PortHardware[7], 0, true, 28)
				});
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok)
				{
					if (reply[0] == 2)
					{
						for (int i = 0; i < base.PortHardware.Count<byte>(); i++)
						{
							PingBuffer.AddResponse(new LiveSensorResponse
							{
								SensorInfo = new HardwarePortValue
								{
									PortId = this._portIDs[i],
									Value = (double)BitConverter.ToSingle(reply, i * 4 + 1)
								}
							});
						}
					}
				}
				else
				{
					PBrickDevice.ReportError("read sensor.");
				}
			}
		}
		public override void DeleteFile(string fileName)
		{
		}
		public IList<string> ListDirectory(string path)
		{
			string fullPath = "../prjs/" + path;
			IList<string> result;
			lock (this.CasperDevice)
			{
				byte[] command = SystemCommandBuilder.FileListHeader(fullPath);
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok)
				{
					FileHandlingStatus status = (FileHandlingStatus)reply[2];
					int filelistSize = BitConverter.ToInt32(reply, 3);
					byte[] rawfilelist = new byte[filelistSize];
					Array.ConstrainedCopy(reply, 8, rawfilelist, 0, filelistSize);
					string filelist = Encoding.UTF8.GetString(rawfilelist);
					IList<string> arrayOfFiles = filelist.Split(new char[]
					{
						'\n'
					});
					result = (
						from x in arrayOfFiles
						where !string.IsNullOrEmpty(x) && !x.StartsWith(".", StringComparison.Ordinal)
						select x).ToList<string>();
				}
				else
				{
					result = new List<string>();
				}
			}
			return result;
		}
		public override List<DeviceFileInfo> ListFiles(string pattern)
		{
			List<DeviceFileInfo> fileInfos = new List<DeviceFileInfo>();
			IList<string> topList = this.ListDirectory(string.Empty);
			foreach (string directory in topList)
			{
				IList<string> subList = this.ListDirectory(directory);
				foreach (string fileLine in subList)
				{
					string[] parsedLine = fileLine.Split(new char[]
					{
						' '
					}, 3);
					if (parsedLine.Length == 3)
					{
						if (fileLine.Contains("."))
						{
							try
							{
								fileInfos.Add(new DeviceFileInfo
								{
									FileChecksum = Encoding.ASCII.GetBytes(parsedLine[0]),
									FileSize = int.Parse(parsedLine[1], NumberStyles.HexNumber, CultureInfo.InvariantCulture),
									FileName = directory + "/" + parsedLine[2]
								});
							}
							catch (FormatException)
							{
							}
						}
					}
				}
			}
			return fileInfos;
		}
		public override List<PairedDeviceInfo> PairedDevices()
		{
			List<PairedDeviceInfo> pairedDevices = new List<PairedDeviceInfo>();
			lock (this.CasperDevice)
			{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 1, 0, new byte[][]
				{
					DirectCommandBuilder.GetFavorItemsCount()
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok && reply[0] == 2)
				{
					byte numItems = reply[1];
					for (byte i = 0; i < numItems; i += 1)
					{
						command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 34, 0, new byte[][]
						{
							DirectCommandBuilder.GetFavorItem(i)
						});
						ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
						if (ok && reply[0] == 2)
						{
							PairedDeviceInfo info = new PairedDeviceInfo();
							string name = Encoding.UTF8.GetString(reply, 1, 30);
							info.Name = name.Substring(0, name.IndexOf('\0'));
							info.Paired = BitConverter.ToBoolean(reply, 31);
							info.Connected = BitConverter.ToBoolean(reply, 32);
							info.DeviceType = (byte)BitConverter.ToChar(reply, 33);
							pairedDevices.Add(info);
						}
					}
				}
			}
			return pairedDevices;
		}
		public override void PlayTone(int tone, int duration)
		{
		}
		public override int ReadVMMemory(int targetSegment, int targetOffset, byte[] buffer, int offset, int count)
		{
			lock (this.CasperDevice)
			{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, count + 1, 0, new byte[][]
				{
					DirectCommandBuilder.GetProgramStatus(ProgramSlot.UserSlot, 0),
					DirectCommandBuilder.MemoryRead(ProgramSlot.UserSlot, targetSegment, targetOffset, count, 1)
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok && reply[0] == 2)
				{
					this.UpdateRunningStatus((ProgramStatus)reply[1]);
					Array.Copy(reply, 2, buffer, offset, count);
				}
				else
				{
					PBrickDevice.ReportError("read memory.");
					count = 0;
				}
				this._LastTimeProgramStatusChecked = DateTime.Now;
			}
			return count;
		}
		public override int WriteVMMemory(int targetSegment, int targetOffset, byte[] data, int offset, int count)
		{
			lock (this.CasperDevice)
			{
				using (PBrickDirectCommandObject commandsObject = new PBrickDirectCommandObject(CommandType.DirectNoReply, 1, 2))
				{
					commandsObject.Write(DirectCommandBuilder.InitBytes(0, data));
					commandsObject.Write(DirectCommandBuilder.MemoryWrite(ProgramSlot.UserSlot, targetSegment, targetOffset, data.Length, 0));
					this.CasperDevice.SendMessage(commandsObject.ToArray(), false);
				}
			}
			return 1;
		}
		public override byte[] UploadFileFromDevice(string path)
		{
			byte[] result;
			lock (this.CasperDevice)
			{
				string filePath = "../prjs/" + path;
				byte[] command = SystemCommandBuilder.FileUploadHeader(filePath, 900);
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (!ok)
				{
					PBrickDevice.ReportError("start upload file.");
					result = new byte[0];
				}
				else
				{
					FileHandlingStatus status = (FileHandlingStatus)reply[2];
					if (status != FileHandlingStatus.Success && status != FileHandlingStatus.EndOfFile)
					{
						result = new byte[0];
					}
					else
					{
						byte handle = reply[7];
						int fileSize = BitConverter.ToInt32(reply, 3);
						byte[] file = new byte[fileSize];
						int filePointer = 0;
						int payloadSize = reply.Length - 8;
						if (payloadSize > 0)
						{
							Array.Copy(reply, 8, file, 0, payloadSize);
							filePointer = payloadSize;
						}
						while (ok && filePointer < fileSize)
						{
							command = SystemCommandBuilder.FileUploadSection(handle, 900);
							ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
							if (ok)
							{
								status = (FileHandlingStatus)reply[2];
								payloadSize = Math.Min(reply.Length - 4, fileSize - filePointer);
								Array.Copy(reply, 4, file, filePointer, payloadSize);
								filePointer += payloadSize;
							}
						}
						if (!ok)
						{
							PBrickDevice.ReportError("upload file section.");
							file = new byte[0];
						}
						result = file;
					}
				}
			}
			return result;
		}
		public override void RenameDevice(string name)
		{
			if (!(name == this.CasperDevice.Name))
			{
				lock (this.CasperDevice)
				{
					using (PBrickDirectCommandObject commandsObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 0, 0))
					{
						commandsObject.Write(DirectCommandBuilder.RenameBrick(name));
						byte[] reply;
						if (!this.CasperDevice.SendMessage(commandsObject.ToArray(), true).TryReceiveMessage(out reply))
						{
							PBrickDevice.ReportError("rename brick.");
						}
					}
				}
				base.TheDeviceInfo.Name = name;
				this.CasperDevice.Name = name;
			}
		}
		public override void StartProgram(string fileName, IList<int> startBlockOffsets)
		{
			lock (this.CasperDevice)
			{
				using (PBrickDirectCommandObject commandsObject = new PBrickDirectCommandObject(CommandType.DirectNoReply, 0, 10))
				{
					commandsObject.Write(DirectCommandBuilder.ProgramStop(ProgramSlot.UserSlot));
					commandsObject.Write(DirectCommandBuilder.PutInMruList(fileName));
					commandsObject.Write(DirectCommandBuilder.LoadImage(fileName, 1, 0, 4));
					commandsObject.Write(DirectCommandBuilder.ProgramStart(ProgramSlot.UserSlot, 0, 4, ProgramStartMode.LoadOnly));
					commandsObject.Write(DirectCommandBuilder.InitBytes(8, new byte[]
					{
						1
					}));
					foreach (int offset in startBlockOffsets)
					{
						commandsObject.Write(DirectCommandBuilder.MemoryWrite(ProgramSlot.UserSlot, 0, offset, 1, 8));
					}
					commandsObject.Write(DirectCommandBuilder.ProgramObjectStart(ProgramSlot.UserSlot, 1));
					byte[] reply;
					if (!this.CasperDevice.SendMessage(commandsObject.ToArray(), true).TryReceiveMessage(out reply))
					{
						PBrickDevice.ReportError("start program.");
					}
				}
			}
			this.UpdateRunningStatus(fileName);
		}
		public override void StopProgram()
		{
			lock (this.CasperDevice)
			{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
				{
					DirectCommandBuilder.ProgramStop(ProgramSlot.UserSlot),
					DirectCommandBuilder.OutputStop(0, PortId.AllOutputs, false)
				});
				byte[] reply;
				if (!this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply))
				{
					PBrickDevice.ReportError("stop program.");
				}
			}
			this.UpdateRunningStatus(ProgramStatus.Stopped);
		}
		public override void ResetMotorCount(string port)
		{
			lock (this.CasperDevice)
			{
				byte portBitField = PBrickDevice.ConvertPortStringToBitField(port);
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
				{
					DirectCommandBuilder.OutputClearCount(0, portBitField)
				});
				byte[] reply;
				if (!this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply))
				{
					PBrickDevice.ReportError("stop program.");
				}
			}
		}
		internal void GetOscilloscopeValues()
		{
			lock (this._casperDevice)
			{
				List<DataLogDataPoint> myPoints = new List<DataLogDataPoint>();
				List<double> sensorValues = new List<double>();
				byte[] reply = new byte[2000];
/*
			for (int i = 0; i < portSensorPairs.Count; i++)
			{
				commandList[i] = DirectCommandBuilder.SensorReadyRead(0, Device.ConvertStringToPortID(portSensorPairs[i].Port), portSensorPairs[i].SensorID, portSensorPairs[i].ModeID, 1, portSensorPairs[i].ReadSI, (byte)(i * 4));
			}
			this._oscilloscopeModeCommand = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, portSensorPairs.Count * 4, 0, commandList);
*/
				bool ok = this._casperDevice.SendMessage(this._oscilloscopeModeCommand, true).TryReceiveMessage(out reply);
				if (ok && reply[0] == 2)
				{
					for (int i = 0; i < this._oscilloscopeModePortConfigList.Count; i++)
					{
						sensorValues.Add((double)BitConverter.ToSingle(reply, i * 4 + 1));
					}
					for (int j = 0; j < this._oscilloscopeModePortConfigList.Count; j++)
					{
						myPoints.Add(new DataLogDataPoint
						{
							DataSetId = this._oscilloscopeModePortConfigList[j].DataSetId,
							X = (double)this._oscilloscopeModeSampleCounter * 0.2,
							Y = sensorValues[j]
						});
					}
					PingBuffer.AddResponse(new DataLogSessionDataResponse
					{
						Data = myPoints
					});
					this._oscilloscopeModeSampleCounter++;
				}
				else
				{
					PBrickDatalogEngine.ReportError("get oMode values.");
				}
			}
		}
*)
(*
sing NationalInstruments.Casper;
using NationalInstruments.LabVIEW.VI.VirtualMachine.Runtime.PBrick;
using NationalInstruments.X3.BrickServerShared;
using NationalInstruments.X3.LauncherBase;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Diagnostics.CodeAnalysis;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
namespace NationalInstruments.X3.BrickServerService.Core
{
	[SuppressMessage("NationalInstruments.MeasurementStudio.Libraries", "LRT007:InternalTypesAreInInternalNamespace", Justification = "TODO"), SuppressMessage("NationalInstruments.MeasurementStudio.Libraries", "LRT001:AllTypesAreInNationalInstrumentsNamespace", Justification = "TODO"), SuppressMessage("Microsoft.Maintainability", "CA1506:AvoidExcessiveClassCoupling", Justification = "TODO")]
	internal sealed class PBrickDevice : Device
	{
		private const int BrickPollingRate = 200;
		private const int RunningStatusCheckThrehold = 150;
		private const double OModeSamplingRate = 0.2;
		private const string BrickProjectPrefix = "../prjs/";
		private const string BrickSdCardProjectPrefix = "../prjs/SD_Card/";
		private const string BrickApplicationPrefix = "../apps/";
		private int _autoIDHardwareInterlock;
		public DateTime _LastTimeProgramStatusChecked;
		private static Dictionary<string, string> _bluetoothAuthenticationTokens = new Dictionary<string, string>();
		private PBrickDatalogEngine _pbrickDatalogger;
		private FileStorageLocation _defaultStorageLocation;
		private static BackgroundWorker _scanBluetoothWorker;
		private static AuthenticateTransport _authenticateTransport = new AuthenticateTransport(PBrickDevice.Authenticate);
		public CasperDevice CasperDevice
		{
			get;
			private set;
		}
		public static DiscoveryManager DiscoveryManager
		{
			get;
			private set;
		}
		public PBrickDevice(AvailableDeviceInfo deviceInfo)
		{
			base.TheDeviceInfo = deviceInfo;
			base.PollingBrickTimer = new Timer(new TimerCallback(this.PollingBrickTimer_OnTimer), null, -1, -1);
			this._LastTimeProgramStatusChecked = DateTime.Now.Subtract(TimeSpan.FromMinutes(1.0));
			this.InitializePorts();
		}
		private void InitializePorts()
		{
			int num = 4;
			base.Ports = new Dictionary<string, DevicePort>(num * 8);
			for (int i = 0; i < num; i++)
			{
				int j = 0;
				while (j < 8)
				{
					DevicePort devicePort = new DevicePort();
					devicePort.LayerNumber = (byte)i;
					devicePort.Mode = 0;
					devicePort.Type = 0;
					devicePort.PortNumber = (byte)((j < 4) ? j : (j + 12));
					string str;
					switch (++j)
					{
					case 5:
						str = "A";
						break;
					case 6:
						str = "B";
						break;
					case 7:
						str = "C";
						break;
					case 8:
						str = "D";
						break;
					default:
						str = j.ToString(CultureInfo.InvariantCulture);
						break;
					}
					base.Ports.Add((i + 1).ToString(CultureInfo.InvariantCulture) + "." + str, devicePort);
				}
			}
		}
		public static void StartDiscovery()
		{
			PBrickDevice.DiscoveryManager = new DiscoveryManager(new IDiscoveryService[]
			{
				new TcpDeviceDiscoveryService(),
				new HidApiDiscoveryService(),
				new BthDeviceDiscoveryService()
			});
			PBrickDevice.DiscoveryManager.KnownDevicesChanged += new EventHandler(PBrickDevice.DiscoveryManager_OnKnownDevicesChanged);
			PBrickDevice.DiscoveryManager.AuthenticateTransport = PBrickDevice._authenticateTransport;
			string[] knownTransports = PBrickDevice.DiscoveryManager.GetKnownTransports();
			PBrickDevice.DiscoveryManager.EnablePassiveScan(knownTransports.Except(new string[]
			{
				"BTH"
			}));
			ThreadPool.QueueUserWorkItem(delegate
			{
				PBrickDevice.DiscoveryManager.ForceActiveScan(new string[]
				{
					"USB",
					"BTH"
				});
			});
		}
		private static void DiscoveryManager_OnKnownDevicesChanged(object sender, EventArgs e)
		{
			PingBuffer.AddResponse(new DeviceListUpdateResponse
			{
				BluetoothScanActive = false,
				DeviceListChanged = true
			});
		}
		private static void ReportError(string message)
		{
			string text = "Error: EV3 Brick did not reply to " + message;
			Console.WriteLine(text);
			PingBuffer.AddResponse(new ErrorReportResponse
			{
				Message = text
			});
		}
		[SuppressMessage("Microsoft.Mobility", "CA1601:DoNotUseTimersThatPreventPowerStateChanges", Justification = "Need to poll faster than 1Hz")]
		public void StartPollingBrickForStuff()
		{
			base.PollingBrickTimer.Change(200, 200);
		}
		private void UpdateRunningStatus(ProgramStatus currentStatus)
		{
			if (currentStatus == ProgramStatus.Stopped && !string.IsNullOrEmpty(base.ActiveProgramName))
			{
				base.ActiveProgramName = string.Empty;
				PingBuffer.AddResponse(new GetCurrentProgramNameResponse
				{
					FileName = string.Empty
				});
				return;
			}
			if (currentStatus == ProgramStatus.Running && string.IsNullOrEmpty(base.ActiveProgramName))
			{
				base.ActiveProgramName = "UnknownUserProgram";
				PingBuffer.AddResponse(new GetCurrentProgramNameResponse
				{
					FileName = "UnknownUserProgram"
				});
			}
		}
		private void UpdateRunningStatus(string name)
		{
			base.ActiveProgramName = name;
			PingBuffer.AddResponse(new GetCurrentProgramNameResponse
			{
				FileName = name
			});
		}
		private void AutoIDPortHardware()
		{
			int num = base.Ports.Count<KeyValuePair<string, DevicePort>>();
			byte[][] array = new byte[num][];
			int num2 = 0;
			Dictionary<string, DevicePort>.Enumerator enumerator = base.Ports.GetEnumerator();
			while (enumerator.MoveNext())
			{
				KeyValuePair<string, DevicePort> current = enumerator.Current;
				DevicePort value = current.Value;
				array[num2] = DirectCommandBuilder.SensorGetType(value.LayerNumber, value.PortNumber, (byte)num2, (byte)(num2 + num));
				num2++;
			}
			byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 2 * num, 0, array);
			lock (this.CasperDevice)
			{
				byte[] array2;
				bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array2);
				if (flag2)
				{
					enumerator = base.Ports.GetEnumerator();
					num2 = 1;
					while (enumerator.MoveNext())
					{
						KeyValuePair<string, DevicePort> current2 = enumerator.Current;
						DevicePort value2 = current2.Value;
						byte b = array2[num2];
						sbyte b2 = (sbyte)array2[num + num2];
						if (value2.Type != b || value2.Mode != b2)
						{
							value2.Type = b;
							value2.Mode = b2;
							DetectedHardwareResponse detectedHardwareResponse = new DetectedHardwareResponse();
							DetectedHardwareResponse arg_111_0 = detectedHardwareResponse;
							KeyValuePair<string, DevicePort> current3 = enumerator.Current;
							arg_111_0.PortID = current3.Key;
							DetectedHardwareResponse arg_128_0 = detectedHardwareResponse;
							int num3 = (int)b;
							arg_128_0.HardwareID = num3.ToString(CultureInfo.InvariantCulture);
							detectedHardwareResponse.ModeID = b2;
							PingBuffer.AddResponse(detectedHardwareResponse);
						}
						num2++;
					}
				}
				else
				{
					PBrickDevice.ReportError("AutoId connected hardware.");
				}
			}
		}
		public override ConnectionResult Connect(string desiredTransport, string passkey)
		{
			this.CasperDevice = PBrickDevice.DiscoveryManager.KnownDevices.FirstOrDefault((CasperDevice device) => device.SerialNumber == base.TheDeviceInfo.SerialNumber);
			if (!string.IsNullOrEmpty(passkey))
			{
				PBrickDevice._bluetoothAuthenticationTokens[this.CasperDevice.SerialNumber] = passkey;
			}
			CasperErrorCode casperErrorCode = this.CasperDevice.Connect(desiredTransport);
			if (casperErrorCode == CasperErrorCode.NoError)
			{
				base.TheDeviceInfo.ConnectedTransport = this.CasperDevice.ConnectedTransport;
				this.SendAuthenticationToken();
				this.InitializePorts();
				lock (this.CasperDevice)
				{
					byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 24, 0, new byte[][]
					{
						DirectCommandBuilder.SetDatalogSyncTimeAndTick(0),
						DirectCommandBuilder.GetBrickName(20, 4)
					});
					byte[] source;
					bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out source);
					if (flag2)
					{
						string @string = Encoding.UTF8.GetString(source.Skip(5).TakeWhile((byte t) => t != 0).ToArray<byte>());
						this.CasperDevice.ValidatedName = @string;
					}
				}
				this.StartPollingBrickForStuff();
				this._pbrickDatalogger = new PBrickDatalogEngine(this.CasperDevice);
				return ConnectionResult.Success;
			}
			if (casperErrorCode != CasperErrorCode.AuthenticationNeeded)
			{
				return ConnectionResult.Failure;
			}
			return ConnectionResult.PromptForPasskey;
		}
		public override void Disconnect()
		{
			if (base.PollingBrickTimer != null)
			{
				base.PollingBrickTimer.Change(-1, -1);
			}
			this.CasperDevice.Disconnect();
		}
		public override void UpdateFirmware(string fileName, bool abort)
		{
			using (PBrickGenericCommandObject pBrickGenericCommandObject = new PBrickGenericCommandObject())
			{
				pBrickGenericCommandObject.Write(129);
				pBrickGenericCommandObject.Write(160);
				lock (this.CasperDevice)
				{
					this.CasperDevice.SendMessage(pBrickGenericCommandObject.ToArray(), false);
					Thread.Sleep(4000);
				}
			}
		}
		public override void DownloadFileToDevice(FileStorageLocation? storageLocation, string fileName, byte[] data, bool overwrite, ref bool success)
		{
			if (!storageLocation.HasValue)
			{
				fileName = PBrickDevice.PrettyPathToBrickPath(fileName, this._defaultStorageLocation);
			}
			else
			{
				fileName = PBrickDevice.PrettyPathToBrickPath(fileName, storageLocation.Value);
			}
			lock (this.CasperDevice)
			{
				int num = 900;
				byte[] message = SystemCommandBuilder.FileDownloadHeader(fileName, data);
				byte[] array;
				bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
				if (!flag2)
				{
					PBrickDevice.ReportError("begin file.");
					success = false;
				}
				else
				{
					FileHandlingStatus fileHandlingStatus = (FileHandlingStatus)array[2];
					byte handle = array[3];
					if (fileHandlingStatus == FileHandlingStatus.Success)
					{
						int num2 = 0;
						while (num2 < data.Length && flag2)
						{
							if (num2 + num > data.Length)
							{
								num = data.Length - num2;
							}
							byte[] message2 = SystemCommandBuilder.FileDownloadSection(data, num, num2, handle);
							flag2 = this.CasperDevice.SendMessage(message2, true).TryReceiveMessage(out array);
							num2 += num;
						}
					}
					if (!flag2)
					{
						PBrickDevice.ReportError("file section download.");
						success = false;
					}
					byte[] message3 = SystemCommandBuilder.FileDownloadCloseHandle(handle);
					if (!this.CasperDevice.SendMessage(message3, true).TryReceiveMessage(out array))
					{
						PBrickDevice.ReportError("close file handle on download.");
						success = false;
					}
				}
			}
		}

		public override void PlayDownloadCompleteSound()
		{
			lock (this.CasperDevice)
			{
				byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
				{
					DirectCommandBuilder.DownloadCompleteSound()
				});
				byte[] array;
				this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
			}
		}

		public unsafe void GetDeviceInfo()
		{
			if (ConfigTokens.Singleton.DisableGetDeviceInfo)
			{
				return;
			}
			ConnectedDeviceInfo connectedDeviceInfo = new ConnectedDeviceInfo();
			lock (this.CasperDevice)
			{
				byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 16, 0, new byte[][]
				{
					DirectCommandBuilder.GetBrickPowerStatus(0),
					DirectCommandBuilder.GetBrickSDCardStatus(4, 8, 12)
				});
				byte[] array;
				bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
				if (flag2 && array[0] == 2)
				{
					double num = (double)BitConverter.ToSingle(array, 1);
					if (num < 5.5)
					{
						num = 5.5;
					}
					else
					{
						if (num > 9.0)
						{
							num = 9.0;
						}
					}
					connectedDeviceInfo.BatteryLevel = (int)((num - 5.5) / 3.5 * 100.0);
					this._defaultStorageLocation = ((array[5] != 0) ? FileStorageLocation.SDCard : FileStorageLocation.Brick);
					connectedDeviceInfo.SDCardPresent = (array[5] != 0);
				}
				byte[] message2 = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 16, 0, new byte[][]
				{
					DirectCommandBuilder.GetBrickFirmwareVersion(16, 0)
				});
				byte[] array2;
				bool flag3 = this.CasperDevice.SendMessage(message2, true).TryReceiveMessage(out array2);
				if (flag3 && array2[0] == 2)
				{
					array2[array2.Length - 1] = 0;
					fixed (byte* ptr = &array2[1])
					{
						connectedDeviceInfo.FirmwareVersion = new string((sbyte* )ptr);
					}
				}
			}
			PingBuffer.AddResponse(new GetConnectedDeviceInfoResponse
			{
				DeviceInfoUpdate = connectedDeviceInfo
			});
		}

		public override void AddRemovePortHardware(string portID, string inputHardware, sbyte mode, bool addHardwareFlag)
		{
			DevicePort devicePort = base.Ports[portID];
			byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 4, 0, new byte[][]
			{
				DirectCommandBuilder.SensorReadyRead(devicePort.LayerNumber, devicePort.PortNumber, devicePort.Type, mode, 1, true, 0)
			});
			lock (this.CasperDevice)
			{
				byte[] array;
				this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
			}
			devicePort.Mode = mode;
			PingBuffer.AddResponse(new DetectedHardwareResponse
			{
				PortID = portID,
				HardwareID = devicePort.Type.ToString(CultureInfo.InvariantCulture),
				ModeID = mode
			});
		}

		private void GetLiveSensorValues()
		{
			IEnumerable<KeyValuePair<string, DevicePort>> enumerable =
				from p in base.Ports
				where p.Value.Type != 126 && p.Value.Type != 100
				select p;
			int num = enumerable.Count<KeyValuePair<string, DevicePort>>();
			byte[][] array = new byte[num][];
			int num2 = 0;
			IEnumerator<KeyValuePair<string, DevicePort>> enumerator = enumerable.GetEnumerator();
			while (enumerator.MoveNext())
			{
				KeyValuePair<string, DevicePort> current = enumerator.Current;
				DevicePort value = current.Value;
				array[num2] = DirectCommandBuilder.SensorRead(value.LayerNumber, value.PortNumber, value.Type, -1, true, (byte)(4 * num2));
				num2++;
			}
			lock (this.CasperDevice)
			{
				byte[] array2 = new byte[2000];
				byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 4 * num, 0, array);
				bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array2);
				if (flag2)
				{
					if (array2[0] == 2)
					{
						num2 = 0;
						enumerator = enumerable.GetEnumerator();
						while (enumerator.MoveNext())
						{
							LiveSensorResponse liveSensorResponse = new LiveSensorResponse();
							LiveSensorResponse arg_11C_0 = liveSensorResponse;
							HardwarePortValue hardwarePortValue = new HardwarePortValue();
							HardwarePortValue arg_101_0 = hardwarePortValue;
							KeyValuePair<string, DevicePort> current2 = enumerator.Current;
							arg_101_0.PortId = current2.Key;
							hardwarePortValue.Value = (double)BitConverter.ToSingle(array2, num2 * 4 + 1);
							arg_11C_0.SensorInfo = hardwarePortValue;
							PingBuffer.AddResponse(liveSensorResponse);
							num2++;
						}
					}
				}
				else
				{
					PBrickDevice.ReportError("read sensor.");
				}
			}
		}

		public override void CopyFile(FileStorageLocation sourceStorageLocation, string sourcePath, FileStorageLocation destinationStorageLocation, string destinationPath)
		{
			string sourcePath2 = PBrickDevice.PrettyPathToBrickPath(sourcePath, sourceStorageLocation);
			string destinationPath2 = PBrickDevice.PrettyPathToBrickPath(destinationPath, destinationStorageLocation);
			byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
			{
				DirectCommandBuilder.CopyFile(sourcePath2, destinationPath2)
			});
			lock (this.CasperDevice)
			{
				byte[] array;
				this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
			}
		}

		public override bool DeleteFile(FileStorageLocation fileStorageLocation, string path)
		{
			string path2 = PBrickDevice.PrettyPathToBrickPath(path, fileStorageLocation);
			byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
			{
				DirectCommandBuilder.DeleteFile(path2)
			});
			lock (this.CasperDevice)
			{
				byte[] array;
				bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
				if (!flag2 || array[0] != 2)
				{
					return false;
				}
			}
			return true;
		}

		public IList<string> ListDirectory(string devicePath)
		{
			bool flag = false;
			byte[] bytes = this.UploadFileFromDeviceLowLevel(true, devicePath, ref flag);
			string @string = Encoding.UTF8.GetString(bytes);
			IList<string> source = @string.Split(new char[]
			{
				'\n'
			});
			return (
				from x in source
				where !string.IsNullOrEmpty(x) && !x.StartsWith(".", StringComparison.Ordinal)
				select x).ToList<string>();
		}
		public override void ListFiles(FileStorageLocation storageLocation, ListFilesResponse listFileResponse)
		{
			List<DeviceFileFolderInfo> list = new List<DeviceFileFolderInfo>();
			string text = PBrickDevice.PrettyPathToBrickPath("Projects/", storageLocation);
			byte[] array;
			if (storageLocation == FileStorageLocation.SDCard)
			{
				array = DirectCommandBuilder.GetBrickSDCardStatus(0, 4, 8);
			}
			else
			{
				array = DirectCommandBuilder.GetOnBrickStorageStatus(4, 8);
			}
			byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 12, 0, new byte[][]
			{
				array
			});
			byte[] array2;
			bool flag2;
			lock (this.CasperDevice)
			{
				flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array2);
			}
			if (flag2 && array2[0] == 2)
			{
				listFileResponse.TotalSpace = BitConverter.ToInt32(array2, 5);
				listFileResponse.FreeSpace = BitConverter.ToInt32(array2, 9);
				IList<string> list2 = this.ListDirectory(text);
				using (IEnumerator<string> enumerator = list2.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						string current = enumerator.Current;
						IList<string> list3 = this.ListDirectory(text + current);
						bool readOnly = list3.Contains("CVS/");
						if (current.EndsWith("/", StringComparison.OrdinalIgnoreCase))
						{
							list.Add(new DeviceFileFolderInfo
							{
								Name = "Projects/" + current,
								IsFolder = true,
								ReadOnly = readOnly
							});
						}
						foreach (string current2 in list3)
						{
							string[] array3 = current2.Split(new char[]
							{
								' '
							}, 3);
							if (array3.Length == 3 && current2.Contains("."))
							{
								try
								{
									list.Add(new DeviceFileFolderInfo
									{
										FileChecksum = Encoding.ASCII.GetBytes(array3[0]),
										FileSize = int.Parse(array3[1], NumberStyles.HexNumber, CultureInfo.InvariantCulture),
										Name = "Projects/" + current + array3[2],
										ReadOnly = readOnly
									});
								}
								catch (FormatException)
								{
								}
							}
						}
					}
					goto IL_235;
				}
			}
			if (storageLocation == FileStorageLocation.SDCard)
			{
				PBrickDevice.ReportError("checking sd status returns error");
			}
			else
			{
				PBrickDevice.ReportError("checking brick status returns error");
			}
			listFileResponse.TotalSpace = 0;
			listFileResponse.FreeSpace = 0;
			listFileResponse.Error = true;
			IL_235:
			if (storageLocation == FileStorageLocation.Brick)
			{
				IList<string> list4 = this.ListDirectory("../apps/");
				foreach (string current3 in list4)
				{
					if (current3.EndsWith("/", StringComparison.OrdinalIgnoreCase))
					{
						IList<string> list5 = this.ListDirectory("../apps/" + current3);
						bool readOnly2 = list5.Contains("CVS/");
						DeviceFileFolderInfo deviceFileFolderInfo = new DeviceFileFolderInfo();
						string text2 = current3.Substring(0, current3.Length - 1);
						deviceFileFolderInfo.Name = string.Concat(new string[]
						{
							"Applications/",
							text2,
							"/",
							text2,
							".rbf"
						});
						deviceFileFolderInfo.ReadOnly = readOnly2;
						foreach (string current4 in list5)
						{
							string[] array4 = current4.Split(new char[]
							{
								' '
							}, 3);
							if (array4.Length == 3 && current4.Contains("."))
							{
								try
								{
									deviceFileFolderInfo.FileSize += int.Parse(array4[1], NumberStyles.HexNumber, CultureInfo.InvariantCulture);
								}
								catch (FormatException)
								{
								}
							}
						}
						list.Add(deviceFileFolderInfo);
					}
				}
			}
			listFileResponse.FileList = list;
		}
		public override List<PairedDeviceInfo> PairedDevices()
		{
			List<PairedDeviceInfo> list = new List<PairedDeviceInfo>();
			lock (this.CasperDevice)
			{
				byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 1, 0, new byte[][]
				{
					DirectCommandBuilder.GetFavorItemsCount()
				});
				byte[] array;
				bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
				if (flag2 && array[0] == 2)
				{
					byte b = array[1];
					for (byte b2 = 0; b2 < b; b2 += 1)
					{
						message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 34, 0, new byte[][]
						{
							DirectCommandBuilder.GetFavorItem(b2)
						});
						flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
						if (flag2 && array[0] == 2)
						{
							PairedDeviceInfo pairedDeviceInfo = new PairedDeviceInfo();
							string @string = Encoding.UTF8.GetString(array, 1, 30);
							pairedDeviceInfo.Name = @string.Substring(0, @string.IndexOf('\0'));
							pairedDeviceInfo.Paired = BitConverter.ToBoolean(array, 31);
							pairedDeviceInfo.Connected = BitConverter.ToBoolean(array, 32);
							pairedDeviceInfo.DeviceType = (byte)BitConverter.ToChar(array, 33);
							list.Add(pairedDeviceInfo);
						}
					}
				}
			}
			return list;
		}
		public override void PlayTone(int tone, int duration)
		{
		}
		private void PollingBrickTimer_OnTimer(object state)
		{
			try
			{
				if (1 == Interlocked.Increment(ref this._autoIDHardwareInterlock))
				{
					lock (this.CasperDevice)
					{
						this.AutoIDPortHardware();
						this.GetLiveSensorValues();
						if (this._pbrickDatalogger != null && this._pbrickDatalogger.IsOMode)
						{
							this._pbrickDatalogger.GetOscilloscopeValues();
						}
						this.GetDeviceInfo();
					}
					this.CheckRunningStatusPollingBrickTimerHelper();
				}
			}
			finally
			{
				Interlocked.Decrement(ref this._autoIDHardwareInterlock);
			}
		}
		private void CheckRunningStatusPollingBrickTimerHelper()
		{
			if (this._LastTimeProgramStatusChecked + TimeSpan.FromMilliseconds(150.0) < DateTime.Now)
			{
				this._LastTimeProgramStatusChecked = DateTime.Now;
				lock (this.CasperDevice)
				{
					byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 1, 0, new byte[][]
					{
						DirectCommandBuilder.GetProgramStatus(ProgramSlot.UserSlot, 0)
					});
					byte[] array;
					bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
					if (flag2 && array[0] == 2)
					{
						this.UpdateRunningStatus((ProgramStatus)array[1]);
					}
				}
			}
		}
		public override double ReadSensor(DataLogPortConfigInfo devicePortSensorValue)
		{
			return double.NaN;
		}
		public override byte[] ReadVMMemory(int targetSegment, int targetOffset, int offset, int count, bool isHandle)
		{
			byte[] array = new byte[0];
			lock (this.CasperDevice)
			{
				byte[] message;
				if (isHandle)
				{
					message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, count + 12, 0, new byte[][]
					{
						DirectCommandBuilder.GetProgramStatus(ProgramSlot.UserSlot, 0),
						DirectCommandBuilder.MemoryRead(ProgramSlot.UserSlot, targetSegment, targetOffset, 2, 2),
						DirectCommandBuilder.ReadArrayContent(ProgramSlot.UserSlot, 2, 0, count, 8),
						DirectCommandBuilder.ReadArraySize(ProgramSlot.UserSlot, 2, 4)
					});
				}
				else
				{
					message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, count + 1, 0, new byte[][]
					{
						DirectCommandBuilder.GetProgramStatus(ProgramSlot.UserSlot, 0),
						DirectCommandBuilder.MemoryRead(ProgramSlot.UserSlot, targetSegment, targetOffset, count, 1)
					});
				}
				byte[] array2;
				bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array2);
				if (flag2)
				{
					ProgramStatus programStatus = (ProgramStatus)array2[1];
					this.UpdateRunningStatus(programStatus);
					if (programStatus == ProgramStatus.Running)
					{
						if (isHandle)
						{
							count = Math.Min(count, BitConverter.ToInt32(array2, 5));
							Array.Resize<byte>(ref array, count);
							Array.Copy(array2, 9, array, offset, count);
						}
						else
						{
							Array.Resize<byte>(ref array, count);
							Array.Copy(array2, 2, array, offset, count);
						}
					}
				}
				else
				{
					PBrickDevice.ReportError("read memory.");
				}
				this._LastTimeProgramStatusChecked = DateTime.Now;
			}
			return array;
		}
		public override int WriteVMMemory(int targetSegment, int targetOffset, byte[] data, int offset, int count)
		{
			lock (this.CasperDevice)
			{
				using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 1, 2))
				{
					pBrickDirectCommandObject.Write(DirectCommandBuilder.InitBytes(0, data));
					pBrickDirectCommandObject.Write(DirectCommandBuilder.MemoryWrite(ProgramSlot.UserSlot, targetSegment, targetOffset, data.Length, 0));
					byte[] array;
					this.CasperDevice.SendMessage(pBrickDirectCommandObject.ToArray(), true).TryReceiveMessage(out array);
				}
			}
			return 1;
		}
		public override void CleanProjectDirectory(FileStorageLocation storageLocation, string projectDirectory, List<string> validList)
		{
			IList<string> list = this.ListDirectory(PBrickDevice.PrettyPathToBrickPath(projectDirectory, storageLocation));
			foreach (string current in list)
			{
				string[] array = current.Split(new char[]
				{
					' '
				}, 3);
				if (array.Length == 3 && !current.EndsWith(".rdf", StringComparison.OrdinalIgnoreCase) && !current.EndsWith(".rtf", StringComparison.OrdinalIgnoreCase) && !validList.Contains(projectDirectory + array[2]))
				{
					this.DeleteFile(storageLocation, projectDirectory + array[2]);
				}
			}
		}
		public static string PrettyPathToBrickPath(string prettyPath, FileStorageLocation storageLocation)
		{
			string result = prettyPath;
			if (prettyPath.StartsWith("Projects/", StringComparison.Ordinal))
			{
				string str = (storageLocation == FileStorageLocation.SDCard) ? "../prjs/SD_Card/" : "../prjs/";
				result = str + prettyPath.Substring("Projects/".Length);
			}
			if (prettyPath.StartsWith("Applications/", StringComparison.Ordinal))
			{
				string str2 = "../apps/";
				result = str2 + prettyPath.Substring("Applications/".Length);
			}
			return result;
		}
		public static string BrickPathToPrettyPath(string brickPath)
		{
			string text = brickPath;
			if (text.StartsWith("../prjs/SD_Card/", StringComparison.Ordinal))
			{
				text = "Projects/" + brickPath.Substring("../prjs/SD_Card/".Length);
			}
			else
			{
				if (text.StartsWith("../prjs/", StringComparison.Ordinal))
				{
					text = "Projects/" + brickPath.Substring("../prjs/".Length);
				}
				else
				{
					if (text.StartsWith("../apps/", StringComparison.Ordinal))
					{
						text = "Applications/" + brickPath.Substring("../apps/".Length);
					}
				}
			}
			return text;
		}
		public override byte[] UploadFileFromDevice(FileStorageLocation? storageLocation, string path, ref bool success)
		{
			if (!storageLocation.HasValue)
			{
				path = PBrickDevice.PrettyPathToBrickPath(path, this._defaultStorageLocation);
			}
			else
			{
				path = PBrickDevice.PrettyPathToBrickPath(path, storageLocation.Value);
			}
			return this.UploadFileFromDeviceLowLevel(false, path, ref success);
		}
		public byte[] UploadFileFromDeviceLowLevel(bool directoryList, string devicePath, ref bool success)
		{
			success = true;
			byte[] result;
			lock (this.CasperDevice)
			{
				byte[] message = SystemCommandBuilder.FileUploadHeader(devicePath, 900, directoryList);
				byte[] array;
				bool flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
				if (!flag2)
				{
					PBrickDevice.ReportError("start upload file.");
					success = false;
					result = new byte[0];
				}
				else
				{
					FileHandlingStatus fileHandlingStatus = (FileHandlingStatus)array[2];
					if (fileHandlingStatus != FileHandlingStatus.Success && fileHandlingStatus != FileHandlingStatus.EndOfFile)
					{
						success = false;
						result = new byte[0];
					}
					else
					{
						byte handle = array[7];
						int num = BitConverter.ToInt32(array, 3);
						byte[] array2 = new byte[num];
						int num2 = 0;
						int num3 = array.Length - 8;
						if (num3 > 0)
						{
							Array.Copy(array, 8, array2, 0, num3);
							num2 = num3;
						}
						while (flag2 && num2 < num)
						{
							message = SystemCommandBuilder.FileUploadSection(handle, 900, directoryList);
							flag2 = this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array);
							if (flag2)
							{
								fileHandlingStatus = (FileHandlingStatus)array[2];
								num3 = Math.Min(array.Length - 4, num - num2);
								Array.Copy(array, 4, array2, num2, num3);
								num2 += num3;
							}
						}
						if (!flag2)
						{
							PBrickDevice.ReportError("upload file section.");
							success = false;
							array2 = new byte[0];
						}
						result = array2;
					}
				}
			}
			return result;
		}
		public static void RefreshBluetooth()
		{
			if (PBrickDevice._scanBluetoothWorker == null)
			{
				PBrickDevice._scanBluetoothWorker = new BackgroundWorker();
				PBrickDevice._scanBluetoothWorker.DoWork += new DoWorkEventHandler(PBrickDevice.ScanBluetooth_DoWork);
			}
			if (!PBrickDevice._scanBluetoothWorker.IsBusy)
			{
				PBrickDevice._scanBluetoothWorker.RunWorkerAsync();
			}
		}
		private static void ScanBluetooth_DoWork(object sender, DoWorkEventArgs e)
		{
			PBrickDevice.DiscoveryManager.ForceActiveScan(new string[]
			{
				"BTH"
			});
			PingBuffer.AddResponse(new BluetoothScanFinishedResponse());
		}
		public override void RenameDevice(string name)
		{
			if (name == this.CasperDevice.ValidatedName)
			{
				return;
			}
			lock (this.CasperDevice)
			{
				using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 0, 0))
				{
					pBrickDirectCommandObject.Write(DirectCommandBuilder.RenameBrick(name));
					byte[] array;
					if (!this.CasperDevice.SendMessage(pBrickDirectCommandObject.ToArray(), true).TryReceiveMessage(out array))
					{
						PBrickDevice.ReportError("rename brick.");
					}
				}
			}
			base.TheDeviceInfo.Name = name;
			this.CasperDevice.ValidatedName = name;
		}
		public static List<AvailableDeviceInfo> ScanForDevices(bool searchBluetooth)
		{
			IList<CasperDevice> knownDevices = PBrickDevice.DiscoveryManager.KnownDevices;
			List<AvailableDeviceInfo> list = new List<AvailableDeviceInfo>();
			foreach (CasperDevice current in knownDevices)
			{
				DeviceTransportStatus state = current.GetState();
				if (state != DeviceTransportStatus.Disabled)
				{
					AvailableDeviceInfo availableDeviceInfo = new AvailableDeviceInfo();
					availableDeviceInfo.SerialNumber = current.SerialNumber;
					availableDeviceInfo.ConnectedTransport = current.ConnectedTransport;
					availableDeviceInfo.AvailableTransports = string.Join(",", current.GetAvailableTransports());
					availableDeviceInfo.ResourceId = current.SerialNumber;
					availableDeviceInfo.Name = current.ValidatedName;
					if (current.DeviceType == "EV3" || current.DeviceType == "EV3:Recovery")
					{
						availableDeviceInfo.RecoveryMode = (current.DeviceType == "EV3:Recovery");
						availableDeviceInfo.RuntimeType = "PBR";
						availableDeviceInfo.PhysicalBrickType = "PBR";
					}
					else
					{
						availableDeviceInfo.RuntimeType = current.DeviceType;
						availableDeviceInfo.PhysicalBrickType = current.DeviceType;
					}
					if (current.SerialNumber.StartsWith("VIVM", StringComparison.Ordinal))
					{
						availableDeviceInfo.RuntimeType = "LVM";
					}
					list.Insert(0, availableDeviceInfo);
				}
			}
			return list;
		}
		public override void StartProgram(string fileName, IList<int> startBlockOffsets)
		{
			fileName = PBrickDevice.PrettyPathToBrickPath(fileName, this._defaultStorageLocation);
			lock (this.CasperDevice)
			{
				using (PBrickDirectCommandObject pBrickDirectCommandObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 0, 10))
				{
					pBrickDirectCommandObject.Write(DirectCommandBuilder.ProgramStop(ProgramSlot.UserSlot));
					pBrickDirectCommandObject.Write(DirectCommandBuilder.PutInMruList(fileName));
					pBrickDirectCommandObject.Write(DirectCommandBuilder.LoadImage(fileName, 1, 0, 4));
					pBrickDirectCommandObject.Write(DirectCommandBuilder.ProgramStart(ProgramSlot.UserSlot, 0, 4, ProgramStartMode.LoadOnly));
					pBrickDirectCommandObject.Write(DirectCommandBuilder.InitBytes(8, new byte[]
					{
						1
					}));
					foreach (int current in startBlockOffsets)
					{
						pBrickDirectCommandObject.Write(DirectCommandBuilder.MemoryWrite(ProgramSlot.UserSlot, 0, current, 1, 8));
					}
					pBrickDirectCommandObject.Write(DirectCommandBuilder.ProgramObjectStart(ProgramSlot.UserSlot, 1));
					PendingResponse pendingResponse = this.CasperDevice.SendMessage(pBrickDirectCommandObject.ToArray(), true);
					byte[] array;
					if (!pendingResponse.TryReceiveMessage(out array))
					{
						PBrickDevice.ReportError("start program.");
					}
				}
			}
			this.UpdateRunningStatus(fileName);
		}
		public override void StopProgram()
		{
			lock (this.CasperDevice)
			{
				byte[] message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
				{
					DirectCommandBuilder.ProgramStop(ProgramSlot.UserSlot),
					DirectCommandBuilder.OutputStop(0, PortId.AllOutputs, false)
				});
				byte[] array;
				if (!this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array))
				{
					PBrickDevice.ReportError("stop program.");
				}
			}
			this.UpdateRunningStatus(ProgramStatus.Stopped);
		}
		public override void ResetPortCount(string port)
		{
			DevicePort devicePort = base.Ports[port];
			lock (this.CasperDevice)
			{
				byte[] message;
				if (devicePort.PortNumber >= 16)
				{
					byte portBitField = (byte)Math.Pow(2.0, (double)(devicePort.PortNumber - 16));
					message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
					{
						DirectCommandBuilder.OutputClearCount(0, portBitField)
					});
				}
				else
				{
					byte type = devicePort.Type;
					if (type == 32)
					{
						message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
						{
							DirectCommandBuilder.InputWrite(devicePort.LayerNumber, devicePort.PortNumber, new byte[]
							{
								17
							})
						});
					}
					else
					{
						message = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
						{
							DirectCommandBuilder.InputClear(devicePort.LayerNumber, devicePort.PortNumber)
						});
					}
				}
				byte[] array;
				if (!this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array))
				{
					PBrickDevice.ReportError("stop program.");
				}
			}
		}
		private static string GetAuthenticationToken(string serialNumber)
		{
			string result;
			lock (PBrickDevice._bluetoothAuthenticationTokens)
			{
				if (PBrickDevice._bluetoothAuthenticationTokens.ContainsKey(serialNumber))
				{
					result = PBrickDevice._bluetoothAuthenticationTokens[serialNumber];
				}
				else
				{
					Random random = new Random();
					string text = random.Next(10000).ToString(CultureInfo.InvariantCulture).PadLeft(4, '0');
					PBrickDevice._bluetoothAuthenticationTokens[serialNumber] = text;
					result = text;
				}
			}
			return result;
		}
		private bool SendAuthenticationToken()
		{
			if (this.CasperDevice.ConnectedTransport != "USB")
			{
				return false;
			}
			ThreadPool.QueueUserWorkItem(delegate
			{
				PBrickDevice.DiscoveryManager.ForceActiveScan(new string[]
				{
					"BTH"
				});
			});
			string hostAddress = BthDeviceDiscoveryService.HostAddress;
			if (hostAddress == null)
			{
				return false;
			}
			lock (this.CasperDevice)
			{
				string[] allowedTransports = null;
				try
				{
					allowedTransports = this.CasperDevice.AllowedTransports;
					this.CasperDevice.AllowedTransports = new string[]
					{
						"USB"
					};
					string serialNumber = this.CasperDevice.SerialNumber;
					string authenticationToken = PBrickDevice.GetAuthenticationToken(serialNumber);
					byte[] message;
					using (PBrickGenericCommandObject pBrickGenericCommandObject = new PBrickGenericCommandObject())
					{
						pBrickGenericCommandObject.Write(1);
						pBrickGenericCommandObject.Write(159);
						pBrickGenericCommandObject.Write((byte)(hostAddress.Length + 1));
						pBrickGenericCommandObject.Write(Encoding.UTF8.GetBytes(hostAddress));
						pBrickGenericCommandObject.Write(0);
						pBrickGenericCommandObject.Write((byte)(authenticationToken.Length + 1));
						pBrickGenericCommandObject.Write(Encoding.UTF8.GetBytes(authenticationToken));
						pBrickGenericCommandObject.Write(0);
						message = pBrickGenericCommandObject.ToArray();
					}
					byte[] array;
					if (this.CasperDevice.SendMessage(message, true).TryReceiveMessage(out array) && array[0] == 3)
					{
						byte arg_141_0 = array[0];
						byte arg_146_0 = array[1];
						byte arg_14B_0 = array[2];
						byte arg_150_0 = array[3];
						byte arg_156_0 = array[17];
						Encoding.UTF8.GetString(array, 4, 12);
						Encoding.UTF8.GetString(array, 18, 4);
					}
				}
				finally
				{
					this.CasperDevice.AllowedTransports = allowedTransports;
				}
			}
			return true;
		}
		private static string Authenticate(string transport, string serial)
		{
			if (transport != "BTH")
			{
				throw new NotImplementedException("Only BTH at this point.");
			}
			string result;
			bool flag = PBrickDevice._bluetoothAuthenticationTokens.TryGetValue(serial, out result);
			if (flag)
			{
				PBrickDevice._bluetoothAuthenticationTokens.Remove(serial);
				return result;
			}
			return null;
		}
		public override HighRateDatalogSessionInfo StartDataLogSession(IList<DataLogPortConfigInfo> portSensorPairs, string deploymentFolderName, string logFileBaseName, bool isHighFrequencyRate)
		{
			deploymentFolderName = PBrickDevice.PrettyPathToBrickPath("Projects/" + deploymentFolderName, this._defaultStorageLocation);
			HighRateDatalogSessionInfo highRateDatalogSessionInfo = this._pbrickDatalogger.StartDataLogSession(portSensorPairs, deploymentFolderName, logFileBaseName, isHighFrequencyRate);
			highRateDatalogSessionInfo.ResolvedLogFilePath = PBrickDevice.BrickPathToPrettyPath(highRateDatalogSessionInfo.ResolvedLogFilePath);
			highRateDatalogSessionInfo.StorageLocation = this._defaultStorageLocation;
			return highRateDatalogSessionInfo;
		}
		public override void StopDataLogSession()
		{
			this._pbrickDatalogger.StopDataLogSession();
		}
		public override void StartOscilloscopeMode(IList<DataLogPortConfigInfo> portSensorPairs)
		{
			this._pbrickDatalogger.StartOscilloscopeMode(portSensorPairs);
		}
		public override void StopOscilloscopeMode()
		{
			this._pbrickDatalogger.StopOscilloscopeMode();
		}
		public override void WifiTurnWifiAdapterOn(WifiTurnAdapterOnResponse response)
		{
			response.WifiAdapterOn = false;
			response.WifiAdapterConnected = false;
			if (PBrickWifi.IsPresent(this.CasperDevice))
			{
				response.WifiAdapterConnected = true;
				if (PBrickWifi.IsEnabled(this.CasperDevice))
				{
					response.WifiAdapterOn = true;
					return;
				}
				PBrickWifi.SetEnabled(this.CasperDevice, true);
				if (PBrickWifi.IsEnabled(this.CasperDevice))
				{
					response.WifiAdapterOn = true;
				}
			}
		}
		public override void WifiSearchForAccessPoints(WifiSearchForAccessPointsResponse response)
		{
			List<AccessPoint> list = new List<AccessPoint>();
			PBrickWifi.StartSearch(this.CasperDevice);
			PBrickWifi.WaitBusy(this.CasperDevice, 30000);
			ICollection<WifiItem> collection = PBrickWifi.ResultsFromSearch(this.CasperDevice);
			foreach (WifiItem current in collection)
			{
				list.Add(new AccessPoint
				{
					SSID = current.SSID,
					Connected = (current.State & WifiStates.Connected) != (WifiStates)0,
					Encrypted = (current.State & WifiStates.Encrypted) != (WifiStates)0
				});
			}
			response.AccessPoints = list;
		}
		public override bool WifiConnectToAccessPoint(string name, string pin)
		{
			return PBrickWifi.ConnectTo(this.CasperDevice, name, pin);
		}
		private void Dispose(bool disposing)
		{
			if (disposing)
			{
				if (base.PollingBrickTimer != null)
				{
					base.PollingBrickTimer.Dispose();
					base.PollingBrickTimer = null;
				}
				if (this._pbrickDatalogger != null)
				{
					this._pbrickDatalogger.Dispose();
					this._pbrickDatalogger = null;
				}
			}
		}
		public override void Dispose()
		{
			this.Dispose(true);
			GC.SuppressFinalize(this);
		}
	}
}
*)
procedure TCasperDevice.Update(rs: TPBrickRecoveryState; current, total: integer);
begin

end;

{ EFileNotFoundException }

constructor EFileNotFoundException.Create;
begin
  inherited Create('File not found');
end;

{ ENotSupportedException }

constructor ENotSupportedException.Create;
begin
  inherited Create('Operation not supported');
end;

end.
=======
unit uCasperDevice;

interface

uses
  Classes, Contnrs, SysUtils, SyncObjs, uCasperTypes, uPBRSimpleTypes;

type
  EOperationCanceledException = class(Exception);
  EIOException = class(Exception);
  EThreadAbortException = class(Exception);
  ETimeoutException = class(Exception);
  EFileNotFoundException = class(Exception)
  public
    constructor Create();
  end;
  ENotSupportedException = class(Exception)
  public
    constructor Create();
  end;
  ENotImplementedException = class(Exception);

  TCasperDevice = class;

  IDeviceTransport = interface
    function GetMaxMessageSize : integer;
    function GetParent : TCasperDevice;
    procedure SetParent(aParent : TCasperDevice);
    function GetSerialNumber : string;
    function GetState : TDeviceTransportStatus;
    function GetUserVisibleType : string;
    
    function Connect : boolean;
    procedure Disable;
    procedure Disconnect;
    procedure Revive;
    function SendMessage(buffer : TStream; sequenceId : Word) : TCasperErrorCode;

    property MaxMessageSize : integer read GetMaxMessageSize;
    property Parent : TCasperDevice read GetParent write SetParent;
    property SerialNumber : string read GetSerialNumber;
    property State : TDeviceTransportStatus read GetState;
    property UserVisibleType : string read GetUserVisibleType;
  end;

  TPendingResponse = class
  private
    fStatus: Exception;
    fTimingDebug: boolean;
    fDisposed : boolean;
    fStartTime: TDateTime;
    fBuffer: TStream;
    fEvent: TEvent;
    function GetMessageReady: boolean;
    procedure SetBuffer(const Value: TStream);
  public
    constructor Create;
    destructor Destroy; override;
    function ReceiveMessage(timeout : integer) : TStream; overload;
    function ReceiveMessage : TStream; overload;
    function TryReceiveMessage(aMessage : TStream; timeout : integer) : boolean; overload;
    function TryReceiveMessage(aMessage : TStream) : boolean; overload;
    procedure ReadBuffer(offset : integer; var aValue : ShortInt); overload;
    procedure ReadBuffer(offset : integer; var aValue : byte); overload;
    procedure ReadBuffer(offset : integer; var aValue: SmallInt); overload;
    procedure ReadBuffer(offset : integer; var aValue : Word); overload;
    procedure ReadBuffer(offset : integer; var aValue : Integer); overload;
    procedure ReadBuffer(offset : integer; var aValue : Cardinal); overload;
    // properties
    property Status : Exception read fStatus write fStatus;
    property TimingDebug : boolean read fTimingDebug write fTimingDebug;
    property StartTime : TDateTime read fStartTime write fStartTime;
    property Buffer : TStream read fBuffer write SetBuffer;
    property Event : TEvent read fEvent write fEvent;
    property MessageReady : boolean read GetMessageReady;
  end;

  TPendingResponseCache = class
  private
    fList : TStringList;
    function GetValues(aIndex: integer): TPendingResponse;
    function SequenceIdAsString(aSequenceID : Word) : string;
  public
    constructor Create;
    destructor Destroy; override;
    function ContainsKey(aSequenceID : Word) : boolean;
    function Add(aSequenceID : Word; aPendingResponse : TPendingResponse) : integer;
		function TryGetValue(aSequenceID : Word; out response : TPendingResponse) : boolean;
		procedure Remove(aSequenceID : Word);
    function Count : integer;
    function IndexOf(aSequenceID : Word) : integer;
    procedure Clear;
    property Values[aIndex : integer] : TPendingResponse read GetValues; default;
  end;

  TCasperDevice = class
  private
    fActiveTransport : IDeviceTransport;
    fTransports : TInterfaceList;
    fAllowableTransports : TInterfaceList;
    fAllowedTransportIdentifiers : TStrings;
    fDeviceType : string;
    fName : string;
    fSequenceID : word;
    fPendingResponses : TPendingResponseCache;
    fSerialNumber: string;
    fOnDeviceChanged: TNotifyEvent;
    fAvailableTransportNames : TStrings;
    fStreamState : TPBrickStreamState;
    procedure SetATI(const Value: TStrings);
		function AllowedTransport(transport : string) : boolean;
    procedure SetName(const Value: string);
    procedure SetDeviceType(const Value: string);
    function GetRecommendedMessageSize: integer;
    function GetConnectedTransport: string;
    function SendMessage(buffer : TStream; aSequenceID : Word) : TCasperErrorCode; overload;
    procedure AddTransport(transport : IDeviceTransport);
    function GetNextSequenceID : Word;
    procedure PoisonTokenCache;
    procedure MessageReceived(msg : TStream; aSequenceID : Word; receiver : IDeviceTransport);
  public
    constructor Create(aSerialNumber : string);
    destructor Destroy; override;
    procedure Update(rs : TPBrickRecoveryState; current, total : integer);
    // methods
    function Connect : TCasperErrorCode; overload;
    function Connect(reviveDisabledTransports : boolean) : TCasperErrorCode; overload;
    procedure Disconnect;
    function GetAvailableTransports : TStrings;
    function GetState : TDeviceTransportStatus;
    function SendMessage(msg : TStream; requestResponse : boolean) : TPendingResponse; overload;
    procedure UpdateTransport(transport : IDeviceTransport);
    // pbr methods
    procedure Recover(fileName: string);
    function EraseFlash : integer;
    procedure BeginFlashDownload(address, imageSize: integer);
    procedure BeginFlashDownloadWithErase(address, imageSize: integer);
    function DownloadProgram(image: TStream): cardinal;
    function GetChecksum(address, imageSize: integer): cardinal;
    procedure GetVersion(out firmwareId, hardwareId: integer);
    procedure StartApplication;
    // pbr file methods
    procedure FileCloseHandle(handle: byte);
    procedure FileOpenRead(path: string; out handle: byte; out length: integer);
    function FileRead(handle: byte; aStream: TStream; offset, count : integer;
      out length : integer; var position : integer) : integer;
    procedure DownloadFileToDevice(filename : string; data : TStream; overwrite : boolean);
    // pbr device info
    procedure AutoIDHardware();
    procedure GetDeviceInfo(out availableFlash, batteryLevel: integer);
    // properties
    property AllowedTransports : TStrings read fAllowedTransportIdentifiers write SetATI;
    property SerialNumber : string read fSerialNumber;
    property Name : string read fName write SetName;
    property DeviceType : string read fDeviceType write SetDeviceType;
    property RecommendedMessageSize : integer read GetRecommendedMessageSize;
    property StreamState : TPBrickStreamState read fStreamState write fStreamState;
//    property Manager : TDiscoveryManager read fManager;
    property ConnectedTransport : string read GetConnectedTransport;
    property OnDeviceChanged : TNotifyEvent read fOnDeviceChanged write fOnDeviceChanged;
  end;

  function CasperErrorCodeToStr(aCec : TCasperErrorCode) : string;

implementation

uses
  Math, uPBRMiscTypes, uStreamRW;

function CasperErrorCodeToStr(aCec : TCasperErrorCode) : string;
begin
  case aCec of
    cecNoError : Result := 'cecNoError';
    cecTransportUnavailable : Result := 'cecTransportUnavailable';
    cecMessageTooLarge : Result := 'cecMessageTooLarge';
    cecNoTransportsAvailable : Result := 'cecNoTransportsAvailable';
    cecNotConnected : Result := 'cecNotConnected';
  end;
end;

{ TPendingResponse }

constructor TPendingResponse.Create;
begin
  inherited;
  fStartTime := Now;
  fBuffer := TMemoryStream.Create;
  fEvent := TEvent.Create(nil, true, false, 'PendingResponseEvent');
end;

destructor TPendingResponse.Destroy;
begin
  FreeAndNil(fBuffer);
  FreeAndNil(fEvent);
  inherited;
end;

function TPendingResponse.GetMessageReady: boolean;
begin
  Result := (Event.WaitFor(1) = wrSignaled);
end;

function TPendingResponse.ReceiveMessage(timeout: integer): TStream;
var
  timedOut : boolean;
begin
  timedOut := (Event.WaitFor(timeout) = wrTimeout);
  if Status <> nil then
    raise Status;
  if timedOut then
  begin
    Result := Buffer;
    Exit;
  end;
  raise ETimeoutException.Create('ReceiveMessage timed out.');
end;

function TPendingResponse.ReceiveMessage: TStream;
begin
  Result := ReceiveMessage(1000);
end;

function TPendingResponse.TryReceiveMessage(aMessage: TStream; timeout: integer): boolean;
var
  timedOut : boolean;
begin
  if Assigned(aMessage) then
    aMessage.Size := 0; // empty the stream
  timedOut := (Event.WaitFor(timeout) = wrTimeout);
  if not timedOut or (Status <> nil) then
  begin
    if Assigned(aMessage) then
      aMessage.Size := 0;
    Result := False;
  end
  else
  begin
//    if (PendingResponse.TimingDebug)
//    {
//      System.Console.WriteLine("Response Time: {0}", (System.DateTime.Now - this.StartTime).TotalMilliseconds);
//    }
    if Assigned(aMessage) then
      aMessage.CopyFrom(Buffer, 0);
    Result := True;
  end;
end;

procedure TPendingResponse.SetBuffer(const Value: TStream);
begin
  fBuffer.CopyFrom(Value, 0);
end;

function TPendingResponse.TryReceiveMessage(aMessage: TStream): boolean;
begin
  Result := TryReceiveMessage(aMessage, 1000);
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: ShortInt);
var
  tmp : ShortInt;
begin
  ReadBuffer(offset, tmp);
  aValue := ShortInt(tmp);
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue : byte);
begin
  aValue := 0;
  if MessageReady then
  begin
    fBuffer.Seek(offset, soBeginning);
    aValue := ReadByte(fBuffer);
  end;
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: SmallInt);
var
  tmp : Word;
begin
  ReadBuffer(offset, tmp);
  aValue := SmallInt(tmp);
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: Word);
begin
  aValue := 0;
  if MessageReady then
  begin
    fBuffer.Seek(offset, soBeginning);
    aValue := ReadWord(fBuffer);
  end;
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: Integer);
var
  tmp : Cardinal;
begin
  ReadBuffer(offset, tmp);
  aValue := Integer(tmp);
end;

procedure TPendingResponse.ReadBuffer(offset: integer; var aValue: Cardinal);
begin
  aValue := 0;
  if MessageReady then
  begin
    fBuffer.Seek(offset, soBeginning);
    aValue := ReadCardinal(fBuffer);
  end;
end;

{ TPendingResponseCache }

function TPendingResponseCache.Add(aSequenceID: Word;
  aPendingResponse: TPendingResponse): integer;
begin
  Result := fList.AddObject(SequenceIdAsString(aSequenceID), aPendingResponse);
end;

procedure TPendingResponseCache.Clear;
begin
  fList.Clear;
end;

function TPendingResponseCache.ContainsKey(aSequenceID: Word): boolean;
begin
  Result := IndexOf(aSequenceID) <> -1;
end;

function TPendingResponseCache.Count: integer;
begin
  Result := fList.Count;
end;

constructor TPendingResponseCache.Create;
begin
  fList := TStringList.Create;
end;

destructor TPendingResponseCache.Destroy;
begin
  FreeAndNil(fList);
  inherited;
end;

function TPendingResponseCache.GetValues(aIndex: integer): TPendingResponse;
begin
  Result := TPendingResponse(fList.Objects[aIndex]);
end;

function TPendingResponseCache.IndexOf(aSequenceID: Word): integer;
begin
  Result := fList.IndexOf(SequenceIdAsString(aSequenceID));
end;

procedure TPendingResponseCache.Remove(aSequenceID: Word);
begin
  fList.Delete(IndexOf(aSequenceID));
end;

function TPendingResponseCache.SequenceIdAsString(aSequenceID: Word): string;
begin
  Result := Format('%16.16d', [aSequenceID]);
end;

function TPendingResponseCache.TryGetValue(aSequenceID: Word;
  out response: TPendingResponse): boolean;
var
  i : integer;
begin
  response := nil;
  i := IndexOf(aSequenceID);
  Result := i <> -1;
  if Result then
    response := TPendingResponse(fList.Objects[i]);
end;

{ TCasperDevice }

procedure TCasperDevice.AddTransport(transport: IDeviceTransport);
begin
//lock (this._transports)
  fTransports.Add(transport);
  transport.Parent := Self;
//unlock (this._transports)

//lock (this._allowableTransports)
  if AllowedTransport(transport.UserVisibleType) then
  begin
    fAllowableTransports.Add(transport);
  end;
//unlock (this._allowableTransports)
  fOnDeviceChanged(nil);
end;

function TCasperDevice.AllowedTransport(transport: string): boolean;
begin
	Result := (AllowedTransports.Count = 0) or
            (AllowedTransports.IndexOf(transport) <> -1);
end;

function TCasperDevice.Connect: TCasperErrorCode;
begin
  Result := Connect(true);
end;

function TCasperDevice.Connect(reviveDisabledTransports: boolean): TCasperErrorCode;
var
  i : integer;
  transport : IDeviceTransport;
begin
  // lock the allowable transport list?

  // revive disabled transports first (if desired)
  if reviveDisabledTransports then
  begin
    for i := 0 to fAllowableTransports.Count - 1 do
    begin
      transport := IDeviceTransport(fAllowableTransports[i]);
      if transport.State = dtsDisabled then
      begin
        transport.Revive;
      end;
    end;
  end;
  // now check if one of the transports is already connected
  for i := 0 to fAllowableTransports.Count - 1 do
  begin
    transport := IDeviceTransport(fAllowableTransports[i]);
    if transport.State = dtsConnected then
    begin
      fActiveTransport := transport;
      result := cecNoError;
      Exit;
    end;
  end;
  for i := 0 to fAllowableTransports.Count - 1 do
  begin
    transport := IDeviceTransport(fAllowableTransports[i]);
    if (transport.State = dtsPreoperational) and transport.Connect then
    begin
      fActiveTransport := transport;
      result := cecNoError;
      Exit;
    end;
  end;
  // error condition
  fActiveTransport := nil;
  PoisonTokenCache;
  result := cecNoTransportsAvailable;

  // unlock allowable transport list?
end;

constructor TCasperDevice.Create(aSerialNumber : string);
begin
  fTransports := TInterfaceList.Create;
  fAllowableTransports := TInterfaceList.Create;
  fAllowedTransportIdentifiers := TStringList.Create;
  fPendingResponses := TPendingResponseCache.Create;
  fAvailableTransportNames := TStringList.Create;
  fSerialNumber := aSerialNumber;
end;

destructor TCasperDevice.Destroy;
begin
  FreeAndNil(fTransports);
  FreeAndNil(fAllowableTransports);
  FreeAndNil(fAllowedTransportIdentifiers);
  FreeAndNil(fPendingResponses);
  FreeAndNil(fAvailableTransportNames);
  inherited;
end;

procedure TCasperDevice.Disconnect;
var
  i : integer;
  transport : IDeviceTransport;
begin
  fActiveTransport := nil;
  for i := 0 to fTransports.Count - 1 do
  begin
    transport := IDeviceTransport(fTransports[i]);
    if transport.State = dtsConnected then
      transport.Disconnect;
  end;
end;

function TCasperDevice.GetAvailableTransports: TStrings;
var
  i : integer;
  transport : IDeviceTransport;
begin
//			lock (this._allowableTransports)
  Result := fAvailableTransportNames;
  Result.Clear;
  for i := 0 to fAllowableTransports.Count - 1 do
  begin
    transport := IDeviceTransport(fAllowableTransports[i]);
    if transport.State <> dtsDisabled then
      Result.Add(transport.UserVisibleType);
  end;
//} // unlock list
end;

function TCasperDevice.GetConnectedTransport: string;
begin
  if fActiveTransport <> nil then
    Result := fActiveTransport.UserVisibleType
  else
    Result := '';
end;

function TCasperDevice.GetNextSequenceID: Word;
begin
//  lock (this._pendingResponses)
  repeat
    Inc(fSequenceID);
  until(not fPendingResponses.ContainsKey(fSequenceID));
//  } unlock list
  Result := fSequenceID;
end;

function TCasperDevice.GetRecommendedMessageSize: integer;
begin
  if fActiveTransport <> nil then
    Result := fActiveTransport.MaxMessageSize
  else
    Result := 0;
end;

function TCasperDevice.GetState: TDeviceTransportStatus;
var
  i : integer;
  transport : IDeviceTransport;
begin
  if fAllowableTransports.Count = 0 then
  begin
    Result := dtsDisabled;
  end
  else
  begin
    // return the min of all the allowable transport's status
    Result := dtsDisabled;
    for i := 0 to fAllowableTransports.Count - 1 do
    begin
      transport := IDeviceTransport(fAllowableTransports[i]);
      if transport.State < Result then
        Result := transport.State;
    end;
  end;
end;

function TCasperDevice.SendMessage(buffer: TStream; aSequenceID: Word): TCasperErrorCode;
var
  transport : IDeviceTransport;
  status : TCasperErrorCode;
begin
  transport := fActiveTransport;
  if transport <> nil then
  begin
    status := transport.SendMessage(buffer, aSequenceID);
    if status <> cecTransportUnavailable then
    begin
      Result := status;
      Exit;
    end;
  end;
// lock (this._allowabletransports)
  while Connect(false) <> cecNoTransportsAvailable do
  begin
    transport := fActiveTransport;
    status := transport.SendMessage(buffer, aSequenceID);
    if status <> cecTransportUnavailable then
    begin
      Result := status;
      Exit;
    end;
  end;
  Result :=  cecNoTransportsAvailable;
// unlock (this._allowabletransports)
end;

procedure TCasperDevice.PoisonTokenCache;
var
  token : TPendingResponse;
  i : integer;
begin
//  lock (this._pendingResponses)
  for i := 0 to fPendingResponses.Count - 1 do
  begin
    token := fPendingResponses[i];
    token.Status := EOperationCanceledException.Create('CasperDevice unable to receive response');
    token.Event.SetEvent;
  end;
  fPendingResponses.Clear;
//  unlock (this._pendingResponses)
end;

function TCasperDevice.SendMessage(msg: TStream; requestResponse: boolean): TPendingResponse;
var
  responseToken : TPendingResponse;
  sequenceID : Word;
  errCode : TCasperErrorCode;
begin
  responseToken := nil;
  sequenceID := GetNextSequenceID;
  if requestResponse then
  begin
    responseToken := TPendingResponse.Create;
    fPendingResponses.Add(sequenceID, responseToken);
  end;
  errCode := SendMessage(msg, sequenceID);
  if (errCode <> cecNoError) and requestResponse then
  begin
    responseToken.Event.SetEvent;
    responseToken.Status := EIOException.Create(CasperErrorCodeToStr(errCode));
  end;
  Result := responseToken;
end;

procedure TCasperDevice.SetATI(const Value: TStrings);
var
  i : integer;
  tport : IDeviceTransport;
begin
  fAllowedTransportIdentifiers.Assign(Value);
  fAllowableTransports.Clear;
  for i := 0 to fTransports.Count - 1 do
  begin
    tport := IDeviceTransport(fTransports[i]);
    if AllowedTransport(tport.UserVisibleType) then
      fAllowableTransports.Add(tport);
  end;
  if (fActiveTransport <> nil) and (fAllowableTransports.IndexOf(fActiveTransport) = -1) then
    fActiveTransport := nil;
end;

procedure TCasperDevice.SetDeviceType(const Value: string);
begin
  if fDeviceType <> Value then
  begin
    fDeviceType := Value;
    fOnDeviceChanged(Self);
  end;
end;

procedure TCasperDevice.SetName(const Value: string);
begin
  if fName <> Value then
  begin
    fName := Value;
    fOnDeviceChanged(Self);
  end;
end;

procedure TCasperDevice.UpdateTransport(transport: IDeviceTransport);
begin
  fOnDeviceChanged(nil);
  if (transport = fActiveTransport) and (transport.State <> dtsConnected) then
    fActiveTransport := nil;
end;

procedure TCasperDevice.MessageReceived(msg: TStream; aSequenceID: Word;
  receiver: IDeviceTransport);
var
  response : TPendingResponse;
begin
  if fPendingResponses.TryGetValue(aSequenceID, response) then
  begin
    fPendingResponses.Remove(aSequenceID);
  end;
  if response = nil then
  begin
//    System.Console.WriteLine("Unknown message received.  SequenceID: {0}\t Transport: {1}", sequenceId, receiver.UserVisibleType);
  end
  else
  begin
    response.Buffer := msg;
    response.Event.SetEvent;
  end;
end;

procedure TCasperDevice.Recover(fileName: string);
var
  image : TMemoryStream;
  checkCrc : boolean;
  expectedChecksum, receivedCheckSum : Cardinal;
begin
  checkCrc := Copy(fileName, 1, 1) = '!';
  if checkCrc then
  begin
    fileName := Copy(fileName, 2, MaxInt);
  end;
  
  try
    image := TMemoryStream.Create;
    try
      try
        image.LoadFromFile(fileName);
        BeginFlashDownloadWithErase(0, Integer(image.Size));
        expectedChecksum := DownloadProgram(image);
        if checkCrc then
          receivedChecksum := GetChecksum(0, Integer(image.Size))
        else
          receivedChecksum := expectedChecksum;
        if expectedChecksum = receivedChecksum then
          StartApplication
        else
          Self.Update(pbrsImageVerificationFailed, 0, 0);
      except
        on E : EIOException do
        begin
          Self.Update(pbrsFileNotFound, 0, 0);
        end
        else
          raise;
      end;
    finally
      image.Free;
    end;
  except
    on E : EThreadAbortException do
    begin
      Update(pbrsAborted, 1, 1);
    end;
  end;
end;

function TCasperDevice.EraseFlash: integer;
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
  start : TDateTime;
begin
  Update(pbrsErasingChip, 0, 1);
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcChipErase);
    start := Now;
    token := Self.SendMessage(command.OutStream, true);
    while not token.TryReceiveMessage(nil, 2000) do
    begin
      Update(pbrsErasingChip, 1, 1);
    end;
  finally
    command.Free;
  end;
  Result := Trunc(TimeStampToMSecs(DateTimeToTimeStamp(Now-start)));
end;

procedure TCasperDevice.BeginFlashDownload(address, imageSize: integer);
var
  command : TPBrickGenericCommandObject;
begin
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcBeginDownload);
    command.Write(address);
    command.Write(imageSize);
    SendMessage(command.OutStream, true).ReceiveMessage(5000);
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.BeginFlashDownloadWithErase(address, imageSize: integer);
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
begin
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcBeginDownloadWithErase);
    command.Write(address);
    command.Write(imageSize);
    token := SendMessage(command.OutStream, true);
    while not token.TryReceiveMessage(nil, 2000) do
    begin
      Update(pbrsErasingChip, 1, 2);
    end;
    Update(pbrsErasingChip, 2, 2);
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.GetVersion(out firmwareId, hardwareId: integer);
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
  status : byte;
begin
  hardwareId := 0;
  firmwareId := 0;
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcGetVersion);
    token := SendMessage(command.OutStream, true);
    if token.TryReceiveMessage(nil, 5000) then
    begin
      token.ReadBuffer(2, status);
      token.ReadBuffer(3, hardwareId);
      token.ReadBuffer(7, firmwareId);
    end;
  finally
    command.Free;
  end;
end;

function TCasperDevice.DownloadProgram(image: TStream): cardinal;
var
  imageLength, totalBytesDownloaded, actualReadSize : integer;
  crc : Cardinal;
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
  calculator : TCrcCalculator;
  payload : TByteArray;
begin
  imageLength := Integer(image.Size);
  Update(pbrsDownloadingImage, 0, imageLength);
  calculator := TCrcCalculator.Create;
  try
    crc := 0;
    command := TPBrickGenericCommandObject.Create;
    try
      command.Write(ctSystemWithReply);
      command.Write(rcDownloadData);
      totalBytesDownloaded := 0;
      actualReadSize := image.Read(payload, 1018);
      while (actualReadSize <> 0) do
      begin
        command.BaseStream.Seek(2, soBeginning);
        command.BaseStream.Size := 2;
        command.BaseStream.Write(payload, actualReadSize);
        crc := calculator.CalculateCrc(payload, actualReadSize, crc);
        token := Self.SendMessage(command.BaseStream, true);
        if not token.TryReceiveMessage(nil, 5000) then
        begin
          Update(pbrsDownloadingImageFailed, totalBytesDownloaded, imageLength);
          break;
        end;
        totalBytesDownloaded := totalBytesDownloaded + actualReadSize;
        Update(pbrsDownloadingImage, totalBytesDownloaded, imageLength);
        actualReadSize := image.Read(payload, 1018);
      end;
      Result := crc;
    finally
      command.Free;
    end;
  finally
    calculator.Free;
  end;
end;

procedure TCasperDevice.StartApplication;
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
begin
  Update(pbrsStartingApplication, 0, 1);
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcStartApp);
    token := SendMessage(command.OutStream, true);
    if token.TryReceiveMessage(nil, 5000) then
    begin
      Update(pbrsStartingApplication, 1, 1);
    end;
  finally
    command.Free;
  end;
end;

function TCasperDevice.GetChecksum(address, imageSize: integer): cardinal;
var
  command : TPBrickGenericCommandObject;
  token : TPendingResponse;
begin
  Update(pbrsStartingApplication, 0, 1);
  command := TPBrickGenericCommandObject.Create;
  try
    command.Write(ctSystemWithReply);
    command.Write(rcGetChecksum);
    command.Write(address);
    command.Write(imageSize);
    token := SendMessage(command.OutStream, true);
    while not token.TryReceiveMessage(nil, 5000) do
    begin
      Update(pbrsVerifyingImage, 1, 1);
    end;
    if token.MessageReady then
    begin
      token.ReadBuffer(3, Result);
    end;
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.FileCloseHandle(handle : byte);
var
  command : TMemoryStream;
  token : TPendingResponse;
begin
  command := TMemoryStream.Create;
  try
    TSystemCommandBuilder.CloseHandle(handle, command);
    token := SendMessage(command, true);
    token.TryReceiveMessage(nil);
  finally
    command.Free;
  end;
end;

procedure TCasperDevice.FileOpenRead(path : string; out handle : byte; out length : integer);
var
  command : TMemoryStream;
  token : TPendingResponse;
  status : byte;
begin
  command := TMemoryStream.Create;
  try
    TSystemCommandBuilder.BeginGetFile(path, 0, command);
// lock (this._device)
    token := SendMessage(command, true);
    token.TryReceiveMessage(nil, 3000);
// unlock (this._device)
    token.ReadBuffer(2, status);
    case status of
      0 : StreamState := pbssUpload;
      1, 2, 4 : raise EIOException.Create('No PBrick handles available.');
      6 : raise EFileNotFoundException.Create();
    end;
    StreamState := pbssUpload;
    token.ReadBuffer(3, length);
    token.ReadBuffer(7, handle);
  finally
    command.Free;
  end;
end;

function TCasperDevice.FileRead(handle : byte; aStream : TStream;
  offset, count : integer; out length : integer; var position : integer) : integer;
var
  maximumReadSize, actualReadSize : integer;
  fhs : TFileHandlingStatus;
  status : byte;
  command : TMemoryStream;
  token : TPendingResponse;
begin
  token := nil;
  Result := 0;
  if StreamState <> pbssEndOfFile then
  begin
    if StreamState <> pbssUpload then
      raise ENotSupportedException.Create();
    maximumReadSize := min(count, 1010);
    actualReadSize := 0;
    while (actualReadSize = 0) and (StreamState = pbssUpload) do
    begin
      command := TMemoryStream.Create;
      try
        TSystemCommandBuilder.ContinueGetFile(handle, maximumReadSize, command);
        // lock (this._device)
        token := SendMessage(command, true);
        token.TryReceiveMessage(nil);
        // unlock (this._device)
        token.ReadBuffer(2, status);
        fhs := TFileHandlingStatus(status);
        case fhs of
          fhsSuccess : begin
            // do nothing
          end;
          fhsEndOfFile : begin
            StreamState := pbssEndOfFile;
          end;
          fhsUnknownHandle,
          fhsHandleNotReady,
          fhsUnknownError : begin
            StreamState := pbssEndOfFile;
            Result := 0;
            Exit;
          end;
        else
          raise ENotImplementedException('Unknown Error. Status: ' + IntToStr(status));
        end;
      finally
        command.Free;
      end;
      actualReadSize := token.Buffer.Size - 8;
      if actualReadSize = 0 then
      begin
        Sleep(50);
      end;
    end;
    if Assigned(token) then
    begin
      token.ReadBuffer(3, length);
      position := position + actualReadSize;
      CopyStream(token.Buffer, 8, aStream, offset, actualReadSize);
      Result := actualReadSize;
    end;
  end;
end;


procedure TCasperDevice.AutoIDHardware;
var
  command : TMemoryStream;
  token : TPendingResponse;
begin
//			lock (this.CasperDevice)
  command := TMemoryStream.Create;
  try
    TDirectCommandBuilder.BuildCommand(ctDirectWithReply, 16, 0, nil, command);
  finally
    command.Free;
  end;
(*
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 16, 0, new byte[][]
				{
					DirectCommandBuilder.SensorGetType(0, PortId.InputFlag, 0, 4),
					DirectCommandBuilder.SensorGetType(0, PortId.InputTwo, 1, 5),
					DirectCommandBuilder.SensorGetType(0, PortId.InputThree, 2, 6),
					DirectCommandBuilder.SensorGetType(0, PortId.InputFour, 3, 7),
					DirectCommandBuilder.SensorGetType(0, PortId.OutputA, 4, 8),
					DirectCommandBuilder.SensorGetType(0, PortId.OutputB, 5, 9),
					DirectCommandBuilder.SensorGetType(0, PortId.OutputC, 6, 10),
					DirectCommandBuilder.SensorGetType(0, PortId.OutputD, 7, 11)
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok)
				{
					for (int i = 0; i < base.PortHardware.Count<byte>(); i++)
					{
						byte currentSensorType = reply[1 + i];
						base.PortHardware[i] = currentSensorType;
						DetectedHardwareResponse detectedHardwareResponse = new DetectedHardwareResponse();
						detectedHardwareResponse.PortID = this._portIDs[i];
						DetectedHardwareResponse arg_118_0 = detectedHardwareResponse;
						int num = (int)currentSensorType;
						arg_118_0.HardwareID = num.ToString(CultureInfo.InvariantCulture);
						PingBuffer.AddResponse(detectedHardwareResponse);
					}
				}
				else
				{
					PBrickDevice.ReportError("AutoId connected hardware.");
				}
//			unlock (this.CasperDevice)
*)
end;

procedure TCasperDevice.DownloadFileToDevice(filename: string; data : TStream; overwrite : boolean);
begin
(*
		public override void DownloadFileToDevice(string fileName, byte[] data, bool overwrite)
		{
			lock (this.CasperDevice)
			{
				int chunkSize = 900;
				byte[] header = SystemCommandBuilder.FileDownloadHeader(fileName, data);
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(header, true).TryReceiveMessage(out reply);
				if (!ok)
				{
					PBrickDevice.ReportError("begin file.");
				}
				else
				{
					FileHandlingStatus status = (FileHandlingStatus)reply[2];
					byte handle = reply[3];
					if (status == FileHandlingStatus.Success)
					{
						int position = 0;
						while (position < data.Length && ok)
						{
							if (position + chunkSize > data.Length)
							{
								chunkSize = data.Length - position;
							}
							byte[] section = SystemCommandBuilder.FileDownloadSection(data, chunkSize, position, handle);
							ok = this.CasperDevice.SendMessage(section, true).TryReceiveMessage(out reply);
							position += chunkSize;
						}
					}
					if (!ok)
					{
						PBrickDevice.ReportError("file section download.");
					}
					byte[] closeHandle = SystemCommandBuilder.FileDownloadCloseHandle(handle);
					if (!this.CasperDevice.SendMessage(closeHandle, true).TryReceiveMessage(out reply))
					{
						PBrickDevice.ReportError("close file handle on download.");
					}
				}
			}
		}
*)
end;

procedure TCasperDevice.GetDeviceInfo(out availableFlash : integer; out batteryLevel : integer);
begin
(*
		public void GetDeviceInfo()
		{
			ConnectedDeviceInfo deviceInfo = new ConnectedDeviceInfo();
			deviceInfo.AvailableFlash = 0;
			deviceInfo.Ports = this._portList;
			lock (this.CasperDevice)
			{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 4, 0, new byte[][]
				{
					DirectCommandBuilder.GetBrickPowerStatus(0)
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok && reply[0] == 2)
				{
					double voltage = (double)BitConverter.ToSingle(reply, 1);
					if (voltage < 5.5)
					{
						voltage = 5.5;
					}
					else
					{
						if (voltage > 9.0)
						{
							voltage = 9.0;
						}
					}
					deviceInfo.BatteryLevel = (int)((voltage - 5.5) / 3.5 * 100.0);
				}
			}
			PingBuffer.AddResponse(new GetConnectedDeviceInfoResponse
			{
				DeviceInfoUpdate = deviceInfo
			});
		}
*)
end;

(*
		private void GetLiveSensorValues()
		{
			lock (this.CasperDevice)
			{
				byte[] reply = new byte[2000];
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 32, 0, new byte[][]
				{
					DirectCommandBuilder.SensorRead(0, PortId.InputFlag, base.PortHardware[0], 0, true, 0),
					DirectCommandBuilder.SensorRead(0, PortId.InputTwo, base.PortHardware[1], 0, true, 4),
					DirectCommandBuilder.SensorRead(0, PortId.InputThree, base.PortHardware[2], 0, true, 8),
					DirectCommandBuilder.SensorRead(0, PortId.InputFour, base.PortHardware[3], 0, true, 12),
					DirectCommandBuilder.SensorRead(0, PortId.OutputA, base.PortHardware[4], 0, true, 16),
					DirectCommandBuilder.SensorRead(0, PortId.OutputB, base.PortHardware[5], 0, true, 20),
					DirectCommandBuilder.SensorRead(0, PortId.OutputC, base.PortHardware[6], 0, true, 24),
					DirectCommandBuilder.SensorRead(0, PortId.OutputD, base.PortHardware[7], 0, true, 28)
				});
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok)
				{
					if (reply[0] == 2)
					{
						for (int i = 0; i < base.PortHardware.Count<byte>(); i++)
						{
							PingBuffer.AddResponse(new LiveSensorResponse
							{
								SensorInfo = new HardwarePortValue
								{
									PortId = this._portIDs[i],
									Value = (double)BitConverter.ToSingle(reply, i * 4 + 1)
								}
							});
						}
					}
				}
				else
				{
					PBrickDevice.ReportError("read sensor.");
				}
			}
		}
		public override void DeleteFile(string fileName)
		{
		}
		public IList<string> ListDirectory(string path)
		{
			string fullPath = "../prjs/" + path;
			IList<string> result;
			lock (this.CasperDevice)
			{
				byte[] command = SystemCommandBuilder.FileListHeader(fullPath);
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok)
				{
					FileHandlingStatus status = (FileHandlingStatus)reply[2];
					int filelistSize = BitConverter.ToInt32(reply, 3);
					byte[] rawfilelist = new byte[filelistSize];
					Array.ConstrainedCopy(reply, 8, rawfilelist, 0, filelistSize);
					string filelist = Encoding.UTF8.GetString(rawfilelist);
					IList<string> arrayOfFiles = filelist.Split(new char[]
					{
						'\n'
					});
					result = (
						from x in arrayOfFiles
						where !string.IsNullOrEmpty(x) && !x.StartsWith(".", StringComparison.Ordinal)
						select x).ToList<string>();
				}
				else
				{
					result = new List<string>();
				}
			}
			return result;
		}
		public override List<DeviceFileInfo> ListFiles(string pattern)
		{
			List<DeviceFileInfo> fileInfos = new List<DeviceFileInfo>();
			IList<string> topList = this.ListDirectory(string.Empty);
			foreach (string directory in topList)
			{
				IList<string> subList = this.ListDirectory(directory);
				foreach (string fileLine in subList)
				{
					string[] parsedLine = fileLine.Split(new char[]
					{
						' '
					}, 3);
					if (parsedLine.Length == 3)
					{
						if (fileLine.Contains("."))
						{
							try
							{
								fileInfos.Add(new DeviceFileInfo
								{
									FileChecksum = Encoding.ASCII.GetBytes(parsedLine[0]),
									FileSize = int.Parse(parsedLine[1], NumberStyles.HexNumber, CultureInfo.InvariantCulture),
									FileName = directory + "/" + parsedLine[2]
								});
							}
							catch (FormatException)
							{
							}
						}
					}
				}
			}
			return fileInfos;
		}
		public override List<PairedDeviceInfo> PairedDevices()
		{
			List<PairedDeviceInfo> pairedDevices = new List<PairedDeviceInfo>();
			lock (this.CasperDevice)
			{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 1, 0, new byte[][]
				{
					DirectCommandBuilder.GetFavorItemsCount()
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok && reply[0] == 2)
				{
					byte numItems = reply[1];
					for (byte i = 0; i < numItems; i += 1)
					{
						command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 34, 0, new byte[][]
						{
							DirectCommandBuilder.GetFavorItem(i)
						});
						ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
						if (ok && reply[0] == 2)
						{
							PairedDeviceInfo info = new PairedDeviceInfo();
							string name = Encoding.UTF8.GetString(reply, 1, 30);
							info.Name = name.Substring(0, name.IndexOf('\0'));
							info.Paired = BitConverter.ToBoolean(reply, 31);
							info.Connected = BitConverter.ToBoolean(reply, 32);
							info.DeviceType = (byte)BitConverter.ToChar(reply, 33);
							pairedDevices.Add(info);
						}
					}
				}
			}
			return pairedDevices;
		}
		public override void PlayTone(int tone, int duration)
		{
		}
		public override int ReadVMMemory(int targetSegment, int targetOffset, byte[] buffer, int offset, int count)
		{
			lock (this.CasperDevice)
			{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, count + 1, 0, new byte[][]
				{
					DirectCommandBuilder.GetProgramStatus(ProgramSlot.UserSlot, 0),
					DirectCommandBuilder.MemoryRead(ProgramSlot.UserSlot, targetSegment, targetOffset, count, 1)
				});
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (ok && reply[0] == 2)
				{
					this.UpdateRunningStatus((ProgramStatus)reply[1]);
					Array.Copy(reply, 2, buffer, offset, count);
				}
				else
				{
					PBrickDevice.ReportError("read memory.");
					count = 0;
				}
				this._LastTimeProgramStatusChecked = DateTime.Now;
			}
			return count;
		}
		public override int WriteVMMemory(int targetSegment, int targetOffset, byte[] data, int offset, int count)
		{
			lock (this.CasperDevice)
			{
				using (PBrickDirectCommandObject commandsObject = new PBrickDirectCommandObject(CommandType.DirectNoReply, 1, 2))
				{
					commandsObject.Write(DirectCommandBuilder.InitBytes(0, data));
					commandsObject.Write(DirectCommandBuilder.MemoryWrite(ProgramSlot.UserSlot, targetSegment, targetOffset, data.Length, 0));
					this.CasperDevice.SendMessage(commandsObject.ToArray(), false);
				}
			}
			return 1;
		}
		public override byte[] UploadFileFromDevice(string path)
		{
			byte[] result;
			lock (this.CasperDevice)
			{
				string filePath = "../prjs/" + path;
				byte[] command = SystemCommandBuilder.FileUploadHeader(filePath, 900);
				byte[] reply;
				bool ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
				if (!ok)
				{
					PBrickDevice.ReportError("start upload file.");
					result = new byte[0];
				}
				else
				{
					FileHandlingStatus status = (FileHandlingStatus)reply[2];
					if (status != FileHandlingStatus.Success && status != FileHandlingStatus.EndOfFile)
					{
						result = new byte[0];
					}
					else
					{
						byte handle = reply[7];
						int fileSize = BitConverter.ToInt32(reply, 3);
						byte[] file = new byte[fileSize];
						int filePointer = 0;
						int payloadSize = reply.Length - 8;
						if (payloadSize > 0)
						{
							Array.Copy(reply, 8, file, 0, payloadSize);
							filePointer = payloadSize;
						}
						while (ok && filePointer < fileSize)
						{
							command = SystemCommandBuilder.FileUploadSection(handle, 900);
							ok = this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply);
							if (ok)
							{
								status = (FileHandlingStatus)reply[2];
								payloadSize = Math.Min(reply.Length - 4, fileSize - filePointer);
								Array.Copy(reply, 4, file, filePointer, payloadSize);
								filePointer += payloadSize;
							}
						}
						if (!ok)
						{
							PBrickDevice.ReportError("upload file section.");
							file = new byte[0];
						}
						result = file;
					}
				}
			}
			return result;
		}
		public override void RenameDevice(string name)
		{
			if (!(name == this.CasperDevice.Name))
			{
				lock (this.CasperDevice)
				{
					using (PBrickDirectCommandObject commandsObject = new PBrickDirectCommandObject(CommandType.DirectWithReply, 0, 0))
					{
						commandsObject.Write(DirectCommandBuilder.RenameBrick(name));
						byte[] reply;
						if (!this.CasperDevice.SendMessage(commandsObject.ToArray(), true).TryReceiveMessage(out reply))
						{
							PBrickDevice.ReportError("rename brick.");
						}
					}
				}
				base.TheDeviceInfo.Name = name;
				this.CasperDevice.Name = name;
			}
		}
		public override void StartProgram(string fileName, IList<int> startBlockOffsets)
		{
			lock (this.CasperDevice)
			{
				using (PBrickDirectCommandObject commandsObject = new PBrickDirectCommandObject(CommandType.DirectNoReply, 0, 10))
				{
					commandsObject.Write(DirectCommandBuilder.ProgramStop(ProgramSlot.UserSlot));
					commandsObject.Write(DirectCommandBuilder.PutInMruList(fileName));
					commandsObject.Write(DirectCommandBuilder.LoadImage(fileName, 1, 0, 4));
					commandsObject.Write(DirectCommandBuilder.ProgramStart(ProgramSlot.UserSlot, 0, 4, ProgramStartMode.LoadOnly));
					commandsObject.Write(DirectCommandBuilder.InitBytes(8, new byte[]
					{
						1
					}));
					foreach (int offset in startBlockOffsets)
					{
						commandsObject.Write(DirectCommandBuilder.MemoryWrite(ProgramSlot.UserSlot, 0, offset, 1, 8));
					}
					commandsObject.Write(DirectCommandBuilder.ProgramObjectStart(ProgramSlot.UserSlot, 1));
					byte[] reply;
					if (!this.CasperDevice.SendMessage(commandsObject.ToArray(), true).TryReceiveMessage(out reply))
					{
						PBrickDevice.ReportError("start program.");
					}
				}
			}
			this.UpdateRunningStatus(fileName);
		}
		public override void StopProgram()
		{
			lock (this.CasperDevice)
			{
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
				{
					DirectCommandBuilder.ProgramStop(ProgramSlot.UserSlot),
					DirectCommandBuilder.OutputStop(0, PortId.AllOutputs, false)
				});
				byte[] reply;
				if (!this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply))
				{
					PBrickDevice.ReportError("stop program.");
				}
			}
			this.UpdateRunningStatus(ProgramStatus.Stopped);
		}
		public override void ResetMotorCount(string port)
		{
			lock (this.CasperDevice)
			{
				byte portBitField = PBrickDevice.ConvertPortStringToBitField(port);
				byte[] command = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, 0, 0, new byte[][]
				{
					DirectCommandBuilder.OutputClearCount(0, portBitField)
				});
				byte[] reply;
				if (!this.CasperDevice.SendMessage(command, true).TryReceiveMessage(out reply))
				{
					PBrickDevice.ReportError("stop program.");
				}
			}
		}
		internal void GetOscilloscopeValues()
		{
			lock (this._casperDevice)
			{
				List<DataLogDataPoint> myPoints = new List<DataLogDataPoint>();
				List<double> sensorValues = new List<double>();
				byte[] reply = new byte[2000];
/*
			for (int i = 0; i < portSensorPairs.Count; i++)
			{
				commandList[i] = DirectCommandBuilder.SensorReadyRead(0, Device.ConvertStringToPortID(portSensorPairs[i].Port), portSensorPairs[i].SensorID, portSensorPairs[i].ModeID, 1, portSensorPairs[i].ReadSI, (byte)(i * 4));
			}
			this._oscilloscopeModeCommand = DirectCommandBuilder.BuildCommand(CommandType.DirectWithReply, portSensorPairs.Count * 4, 0, commandList);
*/
				bool ok = this._casperDevice.SendMessage(this._oscilloscopeModeCommand, true).TryReceiveMessage(out reply);
				if (ok && reply[0] == 2)
				{
					for (int i = 0; i < this._oscilloscopeModePortConfigList.Count; i++)
					{
						sensorValues.Add((double)BitConverter.ToSingle(reply, i * 4 + 1));
					}
					for (int j = 0; j < this._oscilloscopeModePortConfigList.Count; j++)
					{
						myPoints.Add(new DataLogDataPoint
						{
							DataSetId = this._oscilloscopeModePortConfigList[j].DataSetId,
							X = (double)this._oscilloscopeModeSampleCounter * 0.2,
							Y = sensorValues[j]
						});
					}
					PingBuffer.AddResponse(new DataLogSessionDataResponse
					{
						Data = myPoints
					});
					this._oscilloscopeModeSampleCounter++;
				}
				else
				{
					PBrickDatalogEngine.ReportError("get oMode values.");
				}
			}
		}
*)
procedure TCasperDevice.Update(rs: TPBrickRecoveryState; current, total: integer);
begin

end;

{ EFileNotFoundException }

constructor EFileNotFoundException.Create;
begin
  inherited Create('File not found');
end;

{ ENotSupportedException }

constructor ENotSupportedException.Create;
begin
  inherited Create('Operation not supported');
end;

end.
