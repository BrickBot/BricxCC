unit uCasperTypes;

interface

type
	TDeviceTransportStatus = (
		dtsConnected,
		dtsPreoperational,
		dtsDisabled
	);

	TCasperErrorCode = (
		cecNoError,
		cecTransportUnavailable,
		cecMessageTooLarge,
		cecNoTransportsAvailable,
		cecNotConnected
	);

implementation

end.
