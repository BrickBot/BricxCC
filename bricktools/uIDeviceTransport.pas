unit uIDeviceTransport;

interface

uses
  Classes, uCasperTypes, uCasperDevice;
  
type
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

implementation

end.
