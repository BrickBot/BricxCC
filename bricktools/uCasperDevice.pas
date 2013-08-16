unit uCasperDevice; OBSOLETE

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
