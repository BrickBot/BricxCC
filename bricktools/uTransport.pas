unit uTransport;

interface

uses
  Classes;

type
	TTransportStatus = (
		tsConnected,
		tsPreoperational,
		tsDisabled
	);

	TTransportErrorCode = (
		tecNoError,
		tecTransportUnavailable,
		tecMessageTooLarge,
		tecNoTransportsAvailable,
		tecNotConnected
	);

  ITransport = interface
    function GetMaxMessageSize : integer;
    function GetSerialNumber : string;
    function GetState : TTransportStatus;
    function GetUserVisibleType : string;
    
    function Connect : boolean;
    procedure Disable;
    procedure Disconnect;
    procedure Revive;
    function SendMessage(sendBuffer : TStream; sequenceId : Word) : TTransportErrorCode;
    function ReceiveMessage(sequenceId : Word; responseBuffer : TStream; timeout : integer) : TTransportErrorCode;

    property MaxMessageSize : integer read GetMaxMessageSize;
    property SerialNumber : string read GetSerialNumber;
    property State : TTransportStatus read GetState;
    property UserVisibleType : string read GetUserVisibleType;
  end;

implementation

end.
