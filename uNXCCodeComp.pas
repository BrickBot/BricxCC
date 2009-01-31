unit uNXCCodeComp;

interface

uses
  Classes;

function NXCCodeCompIndex(aName : string) : Integer;
procedure AddNXCCodeCompParams(aStrings : TStrings; Index : integer);

implementation

uses
  uCppCode;

type
  TNXCCodeComp = record
    Name : string;
    Params : string;
  end;

const
  NXCCodeCompDataSize = 577+91;
  NXCCodeCompData: array[0..NXCCodeCompDataSize-1] of TNXCCodeComp = (
    (
     Name: 'abs';
     Params: '(long n)'
    ),
    (
     Name: 'Acos';
     Params: '(X)'
    ),
    (
     Name: 'Acquire';
     Params: '(mutex)'
    ),
    (
     Name: 'ArrayBuild';
     Params: '(aout, src1, src2, srcN)'
    ),
    (
     Name: 'ArrayInit';
     Params: '(aout, val, unsigned int cnt)'
    ),
    (
     Name: 'ArraySubset';
     Params: '(aout, asrc, unsigned int idx, unsigned int len)'
    ),
    (
     Name: 'Asin';
     Params: '(char X)'
    ),
    (
     Name: 'BatteryLevel';
     Params: '(void)'
    ),
    (
     Name: 'BatteryState';
     Params: '(void)'
    ),
    (
     Name: 'BluetoothState';
     Params: '(void)'
    ),
    (
     Name: 'BluetoothStatus';
     Params: '(const byte conn)'
    ),
    (
     Name: 'BluetoothWrite';
     Params: '(const byte conn, byte buffer[])'
    ),
    (
     Name: 'BrickDataBluecoreVersion';
     Params: '(void)'
    ),
    (
     Name: 'BrickDataBtHardwareStatus';
     Params: '(void)'
    ),
    (
     Name: 'BrickDataBtStateStatus';
     Params: '(void)'
    ),
    (
     Name: 'BrickDataName';
     Params: '(void)'
    ),
    (
     Name: 'BrickDataTimeoutValue';
     Params: '(void)'
    ),
    (
     Name: 'BTConnectionClass';
     Params: '(const byte conn)'
    ),
    (
     Name: 'BTConnectionHandleNum';
     Params: '(const byte conn)'
    ),
    (
     Name: 'BTConnectionLinkQuality';
     Params: '(const byte conn)'
    ),
    (
     Name: 'BTConnectionName';
     Params: '(const byte conn)'
    ),
    (
     Name: 'BTConnectionPinCode';
     Params: '(const byte conn)'
    ),
    (
     Name: 'BTConnectionStreamStatus';
     Params: '(const byte conn)'
    ),
    (
     Name: 'BTDeviceClass';
     Params: '(const byte devidx)'
    ),
    (
     Name: 'BTDeviceCount';
     Params: '(void)'
    ),
    (
     Name: 'BTDeviceName';
     Params: '(const byte devidx)'
    ),
    (
     Name: 'BTDeviceNameCount';
     Params: '(void)'
    ),
    (
     Name: 'BTDeviceStatus';
     Params: '(const byte devidx)'
    ),
    (
     Name: 'BTInputBufferInPtr';
     Params: '(void)'
    ),
    (
     Name: 'BTInputBufferOutPtr';
     Params: '(void)'
    ),
    (
     Name: 'BTOutputBufferInPtr';
     Params: '(void)'
    ),
    (
     Name: 'BTOutputBufferOutPtr';
     Params: '(void)'
    ),
    (
     Name: 'ButtonCount';
     Params: '(const byte btn, bool resetCount)'
    ),
    (
     Name: 'ButtonLongPressCount';
     Params: '(const byte btn)'
    ),
    (
     Name: 'ButtonLongReleaseCount';
     Params: '(const byte btn)'
    ),
    (
     Name: 'ButtonPressCount';
     Params: '(const byte btn)'
    ),
    (
     Name: 'ButtonPressed';
     Params: '(const byte btn, bool resetCount)'
    ),
    (
     Name: 'ButtonReleaseCount';
     Params: '(const byte btn)'
    ),
    (
     Name: 'ButtonShortReleaseCount';
     Params: '(const byte btn)'
    ),
    (
     Name: 'ButtonState';
     Params: '(const byte btn)'
    ),
    (
     Name: 'ByteArrayToStr';
     Params: '(array)'
    ),
    (
     Name: 'ByteArrayToStrEx';
     Params: '(array, string str)'
    ),
    (
     Name: 'CircleOut';
     Params: '(byte x, byte y, byte radius, bool cls=false)'
    ),
    (
     Name: 'ClearScreen';
     Params: '(void)'
    ),
    (
     Name: 'ClearSensor';
     Params: '(const byte port)'
    ),
    (
     Name: 'CloseFile';
     Params: '(byte handle)'
    ),
    (
     Name: 'Coast';
     Params: '(const byte ports)'
    ),
    (
     Name: 'CoastEx';
     Params: '(const byte ports, const byte reset)'
    ),
    (
     Name: 'CommandFlags';
     Params: '(void)'
    ),
    (
     Name: 'Cos';
     Params: '(int degrees)'
    ),
    (
     Name: 'CreateFile';
     Params: '(string fname, unsigned int fsize, byte & handle)'
    ),
    (
     Name: 'CreateFileLinear';
     Params: '(string fname, unsigned int fsize, byte & handle)'
    ),
    (
     Name: 'CreateFileNonLinear';
     Params: '(string fname, unsigned int fsize, byte & handle)'
    ),
    (
     Name: 'CurrentTick';
     Params: '(void)'
    ),
    (
     Name: 'CustomSensorActiveStatus';
     Params: '(const byte port)'
    ),
    (
     Name: 'CustomSensorPercentFullScale';
     Params: '(const byte port)'
    ),
    (
     Name: 'CustomSensorZeroOffset';
     Params: '(const byte port)'
    ),
    (
     Name: 'DeleteFile';
     Params: '(string fname)'
    ),
    (
     Name: 'DisplayDisplay';
     Params: '(void)'
    ),
    (
     Name: 'DisplayEraseMask';
     Params: '(void)'
    ),
    (
     Name: 'DisplayFlags';
     Params: '(void)'
    ),
    (
     Name: 'DisplayTextLinesCenterFlags';
     Params: '(void)'
    ),
    (
     Name: 'DisplayUpdateMask';
     Params: '(void)'
    ),
    (
     Name: 'ExitTo';
     Params: '(taskname)'
    ),
    (
     Name: 'FindFirstFile';
     Params: '(string fname, unsigned int fsize, byte handle)'
    ),
    (
     Name: 'FindNextFile';
     Params: '(string fname, unsigned int fsize, byte handle)'
    ),
    (
     Name: 'FirstTick';
     Params: '(void)'
    ),
    (
     Name: 'Flatten';
     Params: '(long num)'
    ),
    (
     Name: 'FlattenVar';
     Params: '(variable)'
    ),
    (
     Name: 'Float';
     Params: '(const byte ports)'
    ),
    (
     Name: 'Follows';
     Params: '(task1, task2, taskn)'
    ),
    (
     Name: 'ForceOff';
     Params: '(long num)'
    ),
    (
     Name: 'FormatNum';
     Params: '(string fmt, long num)'
    ),
    (
     Name: 'FreeMemory';
     Params: '(void)'
    ),
    (
     Name: 'GetBrickDataAddress';
     Params: '(byte & data[])'
    ),
    (
     Name: 'GetBTConnectionAddress';
     Params: '(const byte conn, byte & data[])'
    ),
    (
     Name: 'GetBTDeviceAddress';
     Params: '(const byte devidx, byte & data[])'
    ),
    (
     Name: 'GetBTInputBuffer';
     Params: '(const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetBTOutputBuffer';
     Params: '(const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetDisplayNormal';
     Params: '(const byte x, const byte line, unsigned int cnt, byte & data[])'
    ),
    (
     Name: 'GetDisplayPopup';
     Params: '(const byte x, const byte line, unsigned int cnt, byte & data[])'
    ),
    (
     Name: 'GetHSInputBuffer';
     Params: '(const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetHSOutputBuffer';
     Params: '(const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetInput';
     Params: '(const byte port, const byte field)'
    ),
    (
     Name: 'GetLSInputBuffer';
     Params: '(const byte port, const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetLSOutputBuffer';
     Params: '(const byte port, const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetOutput';
     Params: '(const byte port, const byte field)'
    ),
    (
     Name: 'GetUSBInputBuffer';
     Params: '(const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetUSBOutputBuffer';
     Params: '(const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetUSBPollBuffer';
     Params: '(const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GraphicOut';
     Params: '(byte x, byte y, string filename, bool cls=false)'
    ),
    (
     Name: 'GraphicOutEx';
     Params: '(byte x, byte y, string filename, byte vars[], bool cls=false)'
    ),
    (
     Name: 'HSFlags';
     Params: '(void)'
    ),
    (
     Name: 'HSInputBufferInPtr';
     Params: '(void)'
    ),
    (
     Name: 'HSInputBufferOutPtr';
     Params: '(void)'
    ),
    (
     Name: 'HSOutputBufferInPtr';
     Params: '(void)'
    ),
    (
     Name: 'HSOutputBufferOutPtr';
     Params: '(void)'
    ),
    (
     Name: 'HSSpeed';
     Params: '(void)'
    ),
    (
     Name: 'HSState';
     Params: '(void)'
    ),
    (
     Name: 'HTPFComboDirect';
     Params: '(const byte port, byte channel, byte outa, byte outb)'
    ),
    (
     Name: 'HTPFSinglePin';
     Params: '(const byte port, byte channel, byte out, byte pin, byte func, bool cont)'
    ),
    (
     Name: 'HTPFSingleOutputCST';
     Params: '(const byte port, byte channel, byte out, byte func)'
    ),
    (
     Name: 'HTPFSingleOutputPWM';
     Params: '(const byte port, byte channel, byte out, byte func)'
    ),
    (
     Name: 'HTPFComboPWM';
     Params: '(const byte port, byte channel, byte outa, byte outb)'
    ),
    (
     Name: 'HTPFTrain';
     Params: '(const byte port, byte channel, byte func)'
    ),
    (
     Name: 'HTIRTrain';
     Params: '(const byte port, byte channel, byte func)'
    ),
    (
     Name: 'HTPFRawOutput';
     Params: '(const byte port, byte nibble0, byte nibble1, byte nibble2)'
    ),
    (
     Name: 'HTPFRepeat';
     Params: '(const byte port, byte count, unsigned int delay)'
    ),
    (
     Name: 'HTRCXSetIRLinkPort';
     Params: '(byte port)'
    ),
    (
     Name: 'HTRCXPoll';
     Params: '(byte src, byte value)'
    ),
    (
     Name: 'HTRCXBatteryLevel';
     Params: '()'
    ),
    (
     Name: 'HTRCXPing';
     Params: '()'
    ),
    (
     Name: 'HTRCXDeleteTasks';
     Params: '()'
    ),
    (
     Name: 'HTRCXStopAllTasks';
     Params: '()'
    ),
    (
     Name: 'HTRCXPBTurnOff';
     Params: '()'
    ),
    (
     Name: 'HTRCXDeleteSubs';
     Params: '()'
    ),
    (
     Name: 'HTRCXClearSound';
     Params: '()'
    ),
    (
     Name: 'HTRCXClearMsgOp';
     Params: '()'
    ),
    (
     Name: 'HTRCXLSCalibrateOp';
     Params: '()'
    ),
    (
     Name: 'HTRCXMuteSound';
     Params: '()'
    ),
    (
     Name: 'HTRCXUnmuteSound';
     Params: '()'
    ),
    (
     Name: 'HTRCXClearAllEvents';
     Params: '()'
    ),
    (
     Name: 'HTRCXSetOutput';
     Params: '(byte outputs, byte mode)'
    ),
    (
     Name: 'HTRCXSetDirection';
     Params: '(byte outputs, byte dir)'
    ),
    (
     Name: 'HTRCXSetPower';
     Params: '(byte outputs, byte pwrsrc, byte pwrval)'
    ),
    (
     Name: 'HTRCXOn';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXOff';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXFloat';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXToggle';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXFwd';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXRev';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXOnFwd';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXOnRev';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXOnFor';
     Params: '(byte outputs, unsigned int ms)'
    ),
    (
     Name: 'HTRCXSetTxPower';
     Params: '(const int pwr)'
    ),
    (
     Name: 'HTRCXPlaySound';
     Params: '(const int snd)'
    ),
    (
     Name: 'HTRCXDeleteTask';
     Params: '(const int t)'
    ),
    (
     Name: 'HTRCXStartTask';
     Params: '(const int t)'
    ),
    (
     Name: 'HTRCXStopTask';
     Params: '(const int t)'
    ),
    (
     Name: 'HTRCXSelectProgram';
     Params: '(const int prog)'
    ),
    (
     Name: 'HTRCXClearTimer';
     Params: '(const int timer)'
    ),
    (
     Name: 'HTRCXSetSleepTime';
     Params: '(const int t)'
    ),
    (
     Name: 'HTRCXDeleteSub';
     Params: '(const int s)'
    ),
    (
     Name: 'HTRCXClearSensor';
     Params: '(const int port)'
    ),
    (
     Name: 'HTRCXPlayToneVar';
     Params: '(byte varnum, byte duration)'
    ),
    (
     Name: 'HTRCXSetWatch';
     Params: '(byte hours, byte minutes)'
    ),
    (
     Name: 'HTRCXSetSensorType';
     Params: '(byte port, byte type)'
    ),
    (
     Name: 'HTRCXSetSensorMode';
     Params: '(byte port, byte mode)'
    ),
    (
     Name: 'HTRCXCreateDatalog';
     Params: '(unsigned int size)'
    ),
    (
     Name: 'HTRCXAddToDatalog';
     Params: '(byte src, byte value)'
    ),
    (
     Name: 'HTRCXSendSerial';
     Params: '(byte first, byte count)'
    ),
    (
     Name: 'HTRCXRemote';
     Params: '(unsigned int cmd)'
    ),
    (
     Name: 'HTRCXEvent';
     Params: '(byte src, int value)'
    ),
    (
     Name: 'HTRCXPlayTone';
     Params: '(unsigned int freq, byte duration)'
    ),
    (
     Name: 'HTRCXSelectDisplay';
     Params: '(byte src, int value)'
    ),
    (
     Name: 'HTRCXPollMemory';
     Params: '(unsigned int address, byte count)'
    ),
    (
     Name: 'HTRCXSetEvent';
     Params: '(byte evt, byte src, byte type)'
    ),
    (
     Name: 'HTRCXSetGlobalOutput';
     Params: '(byte outputs, byte mode)'
    ),
    (
     Name: 'HTRCXSetGlobalDirection';
     Params: '(byte outputs, byte dir)'
    ),
    (
     Name: 'HTRCXSetMaxPower';
     Params: '(byte outputs, byte pwrsrc, byte pwrval)'
    ),
    (
     Name: 'HTRCXEnableOutput';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXDisableOutput';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXInvertOutput';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXObvertOutput';
     Params: '(byte outputs)'
    ),
    (
     Name: 'HTRCXIncCounter';
     Params: '(byte counter)'
    ),
    (
     Name: 'HTRCXDecCounter';
     Params: '(byte counter)'
    ),
    (
     Name: 'HTRCXClearCounter';
     Params: '(byte counter)'
    ),
    (
     Name: 'HTRCXSetPriority';
     Params: '(byte p)'
    ),
    (
     Name: 'HTRCXSetMessage';
     Params: '(byte msg)'
    ),
    (
     Name: 'HTScoutCalibrateSensor';
     Params: '()'
    ),
    (
     Name: 'HTScoutMuteSound';
     Params: '()'
    ),
    (
     Name: 'HTScoutUnmuteSound';
     Params: '()'
    ),
    (
     Name: 'HTScoutSelectSounds';
     Params: '(byte grp)'
    ),
    (
     Name: 'HTScoutSetLight';
     Params: '(byte x)'
    ),
    (
     Name: 'HTScoutSetSensorClickTime';
     Params: '(byte src, unsigned int value)'
    ),
    (
     Name: 'HTScoutSetSensorHysteresis';
     Params: '(byte src, unsigned int value)'
    ),
    (
     Name: 'HTScoutSetSensorLowerLimit';
     Params: '(byte src, unsigned int value)'
    ),
    (
     Name: 'HTScoutSetSensorUpperLimit';
     Params: '(byte src, unsigned int value)'
    ),
    (
     Name: 'HTScoutSetEventFeedback';
     Params: '(byte src, unsigned int value)'
    ),
    (
     Name: 'HTScoutSendVLL';
     Params: '(byte src, byte value)'
    ),
    (
     Name: 'HTScoutSetScoutMode';
     Params: '(byte mode)'
    ),
    (
     Name: 'I2CBytes';
     Params: '(const byte port, byte inbuf[], byte & count, byte & outbuf[])'
    ),
    (
     Name: 'I2CBytesReady';
     Params: '(const byte port)'
    ),
    (
     Name: 'I2CRead';
     Params: '(const byte port, byte buflen, byte & buffer[])'
    ),
    (
     Name: 'I2CCheckStatus';
     Params: '(const byte port)'
    ),
    (
     Name: 'I2CStatus';
     Params: '(const byte port, byte & bready)'
    ),
    (
     Name: 'I2CWrite';
     Params: '(const byte port, byte retlen, byte buffer[])'
    ),
    (
     Name: 'IOMA';
     Params: '(const unsigned int num)'
    ),
    (
     Name: 'LineOut';
     Params: '(byte x1, byte y1, byte x2, byte y2, bool cls=false)'
    ),
    (
     Name: 'LowspeedBytesReady';
     Params: '(const byte port)'
    ),
    (
     Name: 'LowspeedRead';
     Params: '(const byte port, byte buflen, byte & buffer[])'
    ),
    (
     Name: 'LowspeedCheckStatus';
     Params: '(const byte port)'
    ),
    (
     Name: 'LowspeedStatus';
     Params: '(const byte port, byte & bready)'
    ),
    (
     Name: 'LowspeedWrite';
     Params: '(const byte port, byte retlen, byte buffer[])'
    ),
    (
     Name: 'LSChannelState';
     Params: '(const byte port)'
    ),
    (
     Name: 'LSErrorType';
     Params: '(const byte port)'
    ),
    (
     Name: 'LSInputBufferBytesToRx';
     Params: '(const byte port)'
    ),
    (
     Name: 'LSInputBufferInPtr';
     Params: '(const byte port)'
    ),
    (
     Name: 'LSInputBufferOutPtr';
     Params: '(const byte port)'
    ),
    (
     Name: 'LSMode';
     Params: '(const byte port)'
    ),
    (
     Name: 'LSOutputBufferBytesToRx';
     Params: '(const byte port)'
    ),
    (
     Name: 'LSOutputBufferInPtr';
     Params: '(const byte port)'
    ),
    (
     Name: 'LSOutputBufferOutPtr';
     Params: '(const byte port)'
    ),
    (
     Name: 'LSSpeed';
     Params: '(void)'
    ),
    (
     Name: 'LSState';
     Params: '(void)'
    ),
    (
     Name: 'MotorActualSpeed';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorBlockTachoCount';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorMode';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorOverload';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorPower';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorPwnFreq';
     Params: '(void)'
    ),
    (
     Name: 'MotorRegDValue';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorRegIValue';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorRegPValue';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorRegulation';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorRotationCount';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorRunState';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorTachoCount';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorTachoLimit';
     Params: '(const byte port)'
    ),
    (
     Name: 'MotorTurnRatio';
     Params: '(const byte port)'
    ),
    (
     Name: 'ArrayLen';
     Params: '(array)'
    ),
    (
     Name: 'NumOut';
     Params: '(byte x, byte y, long number, bool cls=false)'
    ),
    (
     Name: 'NumToStr';
     Params: '(long num)'
    ),
    (
     Name: 'Off';
     Params: '(const byte ports)'
    ),
    (
     Name: 'OffEx';
     Params: '(const byte ports, const byte reset)'
    ),
    (
     Name: 'OnBrickProgramPointer';
     Params: '(void)'
    ),
    (
     Name: 'AbortFlag';
     Params: '(void)'
    ),
    (
     Name: 'LongAbort';
     Params: '(void)'
    ),
    (
     Name: 'OnFwd';
     Params: '(const byte ports, char power)'
    ),
    (
     Name: 'OnFwdEx';
     Params: '(const byte ports, char power, const byte reset)'
    ),
    (
     Name: 'OnFwdReg';
     Params: '(const byte ports, char power, byte regmode)'
    ),
    (
     Name: 'OnFwdRegEx';
     Params: '(const byte ports, char power, byte regmode, const byte reset)'
    ),
    (
     Name: 'OnFwdSync';
     Params: '(const byte ports, char power, char turnpct)'
    ),
    (
     Name: 'OnFwdSyncEx';
     Params: '(const byte ports, char power, char turnpct, const byte reset)'
    ),
    (
     Name: 'OnRev';
     Params: '(const byte ports, char power)'
    ),
    (
     Name: 'OnRevEx';
     Params: '(const byte ports, char power, reset)'
    ),
    (
     Name: 'OnRevReg';
     Params: '(const byte ports, char power, byte regmode)'
    ),
    (
     Name: 'OnRevRegEx';
     Params: '(const byte ports, char power, byte regmode, const byte reset)'
    ),
    (
     Name: 'OnRevSync';
     Params: '(const byte ports, char power, char turnpct)'
    ),
    (
     Name: 'OnRevSyncEx';
     Params: '(const byte ports, char power, char turnpct, const byte reset)'
    ),
    (
     Name: 'OpenFileAppend';
     Params: '(string fname, unsigned int & fsize, byte & handle)'
    ),
    (
     Name: 'OpenFileRead';
     Params: '(string fname, unsigned int & fsize, byte & handle)'
    ),
    (
     Name: 'OpenFileReadLinear';
     Params: '(string fname, unsigned int & fsize, byte & handle)'
    ),
    (
     Name: 'PlayFile';
     Params: '(string filename)'
    ),
    (
     Name: 'PlayFileEx';
     Params: '(string filename, byte volume, bool loop)'
    ),
    (
     Name: 'PlayTone';
     Params: '(unsigned int frequency, unsigned int duration)'
    ),
    (
     Name: 'PlayToneEx';
     Params: '(unsigned int frequency, unsigned int duration, byte volume, bool loop)'
    ),
    (
     Name: 'PointOut';
     Params: '(byte x, byte y, bool cls=false)'
    ),
    (
     Name: 'PowerDown';
     Params: '(void)'
    ),
    (
     Name: 'Precedes';
     Params: '(task1, task2, taskn)'
    ),
    (
     Name: 'Random';
     Params: '(void)'
    ),
    (
     Name: 'Random';
     Params: '(unsigned int max)'
    ),
    (
     Name: 'Read';
     Params: '(byte handle, n)'
    ),
    (
     Name: 'ReadButtonEx';
     Params: '(const byte btn, bool reset, bool & pressed, unsigned int count)'
    ),
    (
     Name: 'ReadBytes';
     Params: '(byte handle, unsigned int len, byte & buf[])'
    ),
    (
     Name: 'ReadLn';
     Params: '(byte handle, n)'
    ),
    (
     Name: 'RebootInFirmwareMode';
     Params: '(void)'
    ),
    (
     Name: 'ReceiveMessage';
     Params: '(byte queue, bool clear, string & msg)'
    ),
    (
     Name: 'ReceiveRemoteBool';
     Params: '(byte queue, bool clear, bool & bval)'
    ),
    (
     Name: 'ReceiveRemoteMessageEx';
     Params: '(byte queue, bool clear, string & str, long & val, bool & bval)'
    ),
    (
     Name: 'ReceiveRemoteNumber';
     Params: '(byte queue, bool clear, long & val)'
    ),
    (
     Name: 'ReceiveRemoteString';
     Params: '(byte queue, bool clear, string & str)'
    ),
    (
     Name: 'RechargeableBattery';
     Params: '(void)'
    ),
    (
     Name: 'RectOut';
     Params: '(byte x, byte y, byte width, byte height, bool cls=false)'
    ),
    (
     Name: 'Release';
     Params: '(mutex)'
    ),
    (
     Name: 'RemoteKeepAlive';
     Params: '(byte conn)'
    ),
    (
     Name: 'RemoteMessageRead';
     Params: '(byte conn, byte queue)'
    ),
    (
     Name: 'RemoteMessageWrite';
     Params: '(byte conn, byte queue, string msg)'
    ),
    (
     Name: 'RemotePlaySoundFile';
     Params: '(byte conn, string filename, bool bloop)'
    ),
    (
     Name: 'RemotePlayTone';
     Params: '(byte conn, unsigned int frequency, unsigned int duration)'
    ),
    (
     Name: 'RemoteResetMotorPosition';
     Params: '(byte conn, byte port, bool brelative)'
    ),
    (
     Name: 'RemoteResetScaledValue';
     Params: '(byte conn, byte port)'
    ),
    (
     Name: 'RemoteSetInputMode';
     Params: '(byte conn, byte port, byte type, byte mode)'
    ),
    (
     Name: 'RemoteSetOutputState';
     Params: '(byte conn, byte port, char speed, byte mode, byteregmode, char turnpct, byte runstate, unsigned long tacholimit)'
    ),
    (
     Name: 'RemoteStartProgram';
     Params: '(byte conn, string filename)'
    ),
    (
     Name: 'RemoteStopProgram';
     Params: '(byte conn)'
    ),
    (
     Name: 'RemoteStopSound';
     Params: '(byte conn)'
    ),
    (
     Name: 'RenameFile';
     Params: '(string oldname, string newname)'
    ),
    (
     Name: 'ResetAllTachoCounts';
     Params: '(const byte ports)'
    ),
    (
     Name: 'ResetBlockTachoCount';
     Params: '(const byte ports)'
    ),
    (
     Name: 'ResetRotationCount';
     Params: '(const byte ports)'
    ),
    (
     Name: 'ResetScreen';
     Params: '(void)'
    ),
    (
     Name: 'ResetSensor';
     Params: '(const byte port)'
    ),
    (
     Name: 'ResetSleepTimer';
     Params: '(void)'
    ),
    (
     Name: 'ResetTachoCount';
     Params: '(const byte ports)'
    ),
    (
     Name: 'ResizeFile';
     Params: '(string filename, unsigned int newsize)'
    ),
    (
     Name: 'ResolveHandle';
     Params: '(string filename, byte & handle, bool & writeable)'
    ),
    (
     Name: 'RotateMotor';
     Params: '(const byte ports, char power, int angle)'
    ),
    (
     Name: 'RotateMotorEx';
     Params: '(const byte ports, char power, int angle, char turnpct, bool sync, bool stop)'
    ),
    (
     Name: 'RotateMotorExPID';
     Params: '(const byte ports, char power, int angle, char turnpct, bool sync, bool stop, byte p, byte i, byte d)'
    ),
    (
     Name: 'RotateMotorPID';
     Params: '(const byte ports, char power, int angle, byte p, byte i, byte d)'
    ),
    (
     Name: 'RS485Status';
     Params: '(bool & sendingData, bool & dataAvail)'
    ),
    (
     Name: 'RS485Write';
     Params: '(byte buffer[])'
    ),
    (
     Name: 'RS485Read';
     Params: '(byte buffer[])'
    ),
    (
     Name: 'RS485Control';
     Params: '(byte cmd, byte baud)'
    ),
    (
     Name: 'RS485Init';
     Params: '()'
    ),
    (
     Name: 'RS485Uart';
     Params: '(byte baud)'
    ),
    (
     Name: 'RS485Exit';
     Params: '()'
    ),
    (
     Name: 'SendRS485Bool';
     Params: '(bool bval)'
    ),
    (
     Name: 'SendRS485Number';
     Params: '(long val)'
    ),
    (
     Name: 'SendRS485String';
     Params: '(string str)'
    ),
    (
     Name: 'SendMessage';
     Params: '(byte queue, string msg)'
    ),
    (
     Name: 'SendRemoteBool';
     Params: '(byte conn, byte queue, bool bval)'
    ),
    (
     Name: 'SendRemoteNumber';
     Params: '(byte conn, byte queue, long val)'
    ),
    (
     Name: 'SendRemoteString';
     Params: '(byte conn, byte queue, string str)'
    ),
    (
     Name: 'SendResponseBool';
     Params: '(byte queue, bool bval)'
    ),
    (
     Name: 'SendResponseNumber';
     Params: '(byte queue, long val)'
    ),
    (
     Name: 'SendResponseString';
     Params: '(byte queue, string str)'
    ),
    (
     Name: 'Sensor';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorBoolean';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorDigiPinsDirection';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorDigiPinsOutputLevel';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorDigiPinsStatus';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorInvalid';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorMode';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorNormalized';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorRaw';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorScaled';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorType';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorUS';
     Params: '(const byte port)'
    ),
    (
     Name: 'SensorHTGyro';
     Params: '(const byte port, byte offset)'
    ),
    (
     Name: 'SetBatteryState';
     Params: '(byte state)'
    ),
    (
     Name: 'SetBluetoothState';
     Params: '(byte state)'
    ),
    (
     Name: 'SetBrickDataAddress';
     Params: '(const byte p, byte addr[])'
    ),
    (
     Name: 'SetBrickDataBluecoreVersion';
     Params: '(version)'
    ),
    (
     Name: 'SetBrickDataBtHardwareStatus';
     Params: '(status)'
    ),
    (
     Name: 'SetBrickDataBtStateStatus';
     Params: '(status)'
    ),
    (
     Name: 'SetBrickDataName';
     Params: '(string str)'
    ),
    (
     Name: 'SetBrickDataTimeoutValue';
     Params: '(timeout)'
    ),
    (
     Name: 'SetBTConnectionAddress';
     Params: '(const byte conn, addr)'
    ),
    (
     Name: 'SetBTConnectionClass';
     Params: '(const byte conn, class)'
    ),
    (
     Name: 'SetBTConnectionHandleNum';
     Params: '(const byte conn, handleNum)'
    ),
    (
     Name: 'SetBTConnectionLinkQuality';
     Params: '(const byte conn, quality)'
    ),
    (
     Name: 'SetBTConnectionName';
     Params: '(const byte conn, str)'
    ),
    (
     Name: 'SetBTConnectionPinCode';
     Params: '(const byte conn, code)'
    ),
    (
     Name: 'SetBTConnectionStreamStatus';
     Params: '(const byte conn, status)'
    ),
    (
     Name: 'SetBTDeviceAddress';
     Params: '(const byte devidx, addr)'
    ),
    (
     Name: 'SetBTDeviceClass';
     Params: '(const byte devidx, class)'
    ),
    (
     Name: 'SetBTDeviceCount';
     Params: '(count)'
    ),
    (
     Name: 'SetBTDeviceName';
     Params: '(const byte devidx, str)'
    ),
    (
     Name: 'SetBTDeviceNameCount';
     Params: '(count)'
    ),
    (
     Name: 'SetBTDeviceStatus';
     Params: '(const byte devidx, status)'
    ),
    (
     Name: 'SetBTInputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetBTInputBufferInPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetBTInputBufferOutPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetBTOutputBuffer';
     Params: '(const byte offset, cnt, byte data[])'
    ),
    (
     Name: 'SetBTOutputBufferInPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetBTOutputBufferOutPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetCommandFlags';
     Params: '(cmdFlags)'
    ),
    (
     Name: 'SetCustomSensorActiveStatus';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetCustomSensorPercentFullScale';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetCustomSensorZeroOffset';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetDisplayDisplay';
     Params: '(n)'
    ),
    (
     Name: 'SetDisplayEraseMask';
     Params: '(eraseMask)'
    ),
    (
     Name: 'SetDisplayFlags';
     Params: '(flags)'
    ),
    (
     Name: 'SetDisplayNormal';
     Params: '(const byte x, const byte line, byte cnt, byte data[])'
    ),
    (
     Name: 'SetDisplayPopup';
     Params: '(const byte x, const byte line, byte cnt, byte data[])'
    ),
    (
     Name: 'SetDisplayTextLinesCenterFlags';
     Params: '(ctrFlags)'
    ),
    (
     Name: 'SetDisplayUpdateMask';
     Params: '(updMask)'
    ),
    (
     Name: 'SetHSFlags';
     Params: '(hsFlags)'
    ),
    (
     Name: 'SetHSInputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetHSInputBufferInPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetHSInputBufferOutPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetHSOutputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetHSOutputBufferInPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetHSOutputBufferOutPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetHSSpeed';
     Params: '(hsSpeed)'
    ),
    (
     Name: 'SetHSState';
     Params: '(hsState)'
    ),
    (
     Name: 'SetInput';
     Params: '(const byte port, const int field, value)'
    ),
    (
     Name: 'SetIOMA';
     Params: '(num)'
    ),
    (
     Name: 'SetLSChannelState';
     Params: '(const byte port, chState)'
    ),
    (
     Name: 'SetLSErrorType';
     Params: '(const byte port, errType)'
    ),
    (
     Name: 'SetLSInputBuffer';
     Params: '(const byte port, const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetLSInputBufferBytesToRx';
     Params: '(const byte port, byte n)'
    ),
    (
     Name: 'SetLSInputBufferInPtr';
     Params: '(const byte port, byte n)'
    ),
    (
     Name: 'SetLSInputBufferOutPtr';
     Params: '(const byte port, byte n)'
    ),
    (
     Name: 'SetLSMode';
     Params: '(const byte port, byte mode)'
    ),
    (
     Name: 'SetLSOutputBuffer';
     Params: '(const byte port, const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetLSOutputBufferBytesToRx';
     Params: '(const byte port, byte n)'
    ),
    (
     Name: 'SetLSOutputBufferInPtr';
     Params: '(const byte port, byte n)'
    ),
    (
     Name: 'SetLSOutputBufferOutPtr';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSSpeed';
     Params: '(byte lsSpeed)'
    ),
    (
     Name: 'SetLSState';
     Params: '(byte lsState)'
    ),
    (
     Name: 'SetMotorPwnFreq';
     Params: '(pwnFreq)'
    ),
    (
     Name: 'SetOnBrickProgramPointer';
     Params: '(byte obpStep)'
    ),
    (
     Name: 'SetAbortFlag';
     Params: '(byte abortFlag)'
    ),
    (
     Name: 'SetLongAbort';
     Params: '(bool longAbort)'
    ),
    (
     Name: 'SetOutput';
     Params: '(const byte ports, const byte field1, value1, const byte field2, value2, const byte fieldN, valueN)'
    ),
    (
     Name: 'SetSensor';
     Params: '(const byte port, const int typemode)'
    ),
    (
     Name: 'SetSensorBoolean';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetSensorDigiPinsDirection';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetSensorDigiPinsOutputLevel';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetSensorDigiPinsStatus';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetSensorLight';
     Params: '(const byte port)'
    ),
    (
     Name: 'SetSensorLowspeed';
     Params: '(const byte port)'
    ),
    (
     Name: 'SetSensorHTGyro';
     Params: '(const byte port)'
    ),
    (
     Name: 'SetSensorMode';
     Params: '(const byte port, const int mode)'
    ),
    (
     Name: 'SetSensorSound';
     Params: '(const byte port)'
    ),
    (
     Name: 'SetSensorTouch';
     Params: '(const byte port)'
    ),
    (
     Name: 'SetSensorType';
     Params: '(const byte port, const int type)'
    ),
    (
     Name: 'SetSleepTimeout';
     Params: '(n)'
    ),
    (
     Name: 'SetSleepTimer';
     Params: '(n)'
    ),
    (
     Name: 'SetSoundDuration';
     Params: '(unsigned int duration)'
    ),
    (
     Name: 'SetSoundFlags';
     Params: '(byte flags)'
    ),
    (
     Name: 'SetSoundFrequency';
     Params: '(unsigned int frequency)'
    ),
    (
     Name: 'SetSoundMode';
     Params: '(byte mode)'
    ),
    (
     Name: 'SetSoundSampleRate';
     Params: '(unsigned int sampleRate)'
    ),
    (
     Name: 'SetSoundModuleState';
     Params: '(byte state)'
    ),
    (
     Name: 'SetSoundVolume';
     Params: '(byte volume)'
    ),
    (
     Name: 'SetUIButton';
     Params: '(byte btn)'
    ),
    (
     Name: 'SetUIState';
     Params: '(byte state)'
    ),
    (
     Name: 'SetUSBInputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetUSBInputBufferInPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetUSBInputBufferOutPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetUSBOutputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetUSBOutputBufferInPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetUSBOutputBufferOutPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetUSBPollBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetUSBPollBufferInPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetUSBPollBufferOutPtr';
     Params: '(byte n)'
    ),
    (
     Name: 'SetUsbState';
     Params: '(byte usbState)'
    ),
    (
     Name: 'SetUSBState';
     Params: '(byte usbState)'
    ),
    (
     Name: 'SetVMRunState';
     Params: '(vmRunState)'
    ),
    (
     Name: 'SetVolume';
     Params: '(byte volume)'
    ),
    (
     Name: 'sign';
     Params: '(long value)'
    ),
    (
     Name: 'Sin';
     Params: '(int degrees)'
    ),
    (
     Name: 'SleepTimeout';
     Params: '(void)'
    ),
    (
     Name: 'SleepTimer';
     Params: '(void)'
    ),
    (
     Name: 'SoundDuration';
     Params: '(void)'
    ),
    (
     Name: 'SoundFlags';
     Params: '(void)'
    ),
    (
     Name: 'SoundFrequency';
     Params: '(void)'
    ),
    (
     Name: 'SoundMode';
     Params: '(void)'
    ),
    (
     Name: 'SoundSampleRate';
     Params: '(void)'
    ),
    (
     Name: 'SoundState';
     Params: '(void)'
    ),
    (
     Name: 'SoundVolume';
     Params: '(void)'
    ),
    (
     Name: 'Sqrt';
     Params: '(unsigned long X)'
    ),
    (
     Name: 'Stop';
     Params: '(bool bvalue)'
    ),
    (
     Name: 'StopSound';
     Params: '(void)'
    ),
    (
     Name: 'StrCat';
     Params: '(string str1, string str2, string str3, string strN)'
    ),
    (
     Name: 'StrIndex';
     Params: '(string str, unsigned int idx)'
    ),
    (
     Name: 'StrLen';
     Params: '(string str)'
    ),
    (
     Name: 'StrReplace';
     Params: '(string str, unsigned int idx, string strnew)'
    ),
    (
     Name: 'StrToByteArray';
     Params: '(string str, array)'
    ),
    (
     Name: 'StrToNum';
     Params: '(string str)'
    ),
    (
     Name: 'SubStr';
     Params: '(string str, unsigned int idx, unsigned int len)'
    ),
    (
     Name: 'TextOut';
     Params: '(byte x, byte y, string str, bool cls=false)'
    ),
    (
     Name: 'UIButton';
     Params: '(void)'
    ),
    (
     Name: 'UIState';
     Params: '(void)'
    ),
    (
     Name: 'UnflattenVar';
     Params: '(string str, out variable)'
    ),
    (
     Name: 'USBInputBufferInPtr';
     Params: '(void)'
    ),
    (
     Name: 'USBInputBufferOutPtr';
     Params: '(void)'
    ),
    (
     Name: 'USBOutputBufferInPtr';
     Params: '(void)'
    ),
    (
     Name: 'USBOutputBufferOutPtr';
     Params: '(void)'
    ),
    (
     Name: 'USBPollBufferInPtr';
     Params: '(void)'
    ),
    (
     Name: 'USBPollBufferOutPtr';
     Params: '(void)'
    ),
    (
     Name: 'UsbState';
     Params: '(void)'
    ),
    (
     Name: 'USBState';
     Params: '(void)'
    ),
    (
     Name: 'VMRunState';
     Params: '(void)'
    ),
    (
     Name: 'Volume';
     Params: '(void)'
    ),
    (
     Name: 'Wait';
     Params: '(unsigned long ms)'
    ),
    (
     Name: 'Write';
     Params: '(byte handle, n)'
    ),
    (
     Name: 'WriteBytes';
     Params: '(byte handle, byte buf[], unsigned int & cnt)'
    ),
    (
     Name: 'WriteBytesEx';
     Params: '(byte handle, unsigned int & len, byte buf[])'
    ),
    (
     Name: 'WriteLn';
     Params: '(byte handle, n)'
    ),
    (
     Name: 'WriteLnString';
     Params: '(byte handle, string str, unsigned int & cnt)'
    ),
    (
     Name: 'WriteString';
     Params: '(byte handle, string str, unsigned int & cnt)'
    ),
    (
     Name: 'SysCall';
     Params: '(const byte func, args)'
    ),
    (
     Name: 'SysFileOpenRead';
     Params: '(FileOpenType & args)'
    ),
    (
     Name: 'SysFileOpenWrite';
     Params: '(FileOpenType & args)'
    ),
    (
     Name: 'SysFileOpenAppend';
     Params: '(FileOpenType & args)'
    ),
    (
     Name: 'SysFileRead';
     Params: '(FileReadWriteType & args)'
    ),
    (
     Name: 'SysFileWrite';
     Params: '(FileReadWriteType & args)'
    ),
    (
     Name: 'SysFileClose';
     Params: '(FileCloseType & args)'
    ),
    (
     Name: 'SysFileResolveHandle';
     Params: '(FileResolveHandleType & args)'
    ),
    (
     Name: 'SysFileRename';
     Params: '(FileRenameType & args)'
    ),
    (
     Name: 'SysFileDelete';
     Params: '(FileDeleteType & args)'
    ),
    (
     Name: 'SysSoundPlayFile';
     Params: '(SoundPlayFileType & args)'
    ),
    (
     Name: 'SysSoundPlayTone';
     Params: '(SoundPlayToneType & args)'
    ),
    (
     Name: 'SysSoundGetState';
     Params: '(SoundGetStateType & args)'
    ),
    (
     Name: 'SysSoundSetState';
     Params: '(SoundSetStateType & args)'
    ),
    (
     Name: 'SysDrawText';
     Params: '(DrawTextType & args)'
    ),
    (
     Name: 'SysDrawPoint';
     Params: '(DrawPointType & args)'
    ),
    (
     Name: 'SysDrawLine';
     Params: '(DrawLineType & args)'
    ),
    (
     Name: 'SysDrawCircle';
     Params: '(DrawCircleType & args)'
    ),
    (
     Name: 'SysDrawRect';
     Params: '(DrawRectType & args)'
    ),
    (
     Name: 'SysDrawGraphic';
     Params: '(DrawGraphicType & args)'
    ),
    (
     Name: 'SysSetScreenMode';
     Params: '(SetScreenModeType & args)'
    ),
    (
     Name: 'SysReadButton';
     Params: '(ReadButtonType & args)'
    ),
    (
     Name: 'SysCommLSWrite';
     Params: '(CommLSWriteType & args)'
    ),
    (
     Name: 'SysCommLSRead';
     Params: '(CommLSReadType & args)'
    ),
    (
     Name: 'SysCommLSCheckStatus';
     Params: '(CommLSCheckStatusType & args)'
    ),
    (
     Name: 'SysRandomNumber';
     Params: '(RandomNumberType & args)'
    ),
    (
     Name: 'SysGetStartTick';
     Params: '(GetStartTickType & args)'
    ),
    (
     Name: 'SysMessageWrite';
     Params: '(MessageWriteType & args)'
    ),
    (
     Name: 'SysMessageRead';
     Params: '(MessageReadType & args)'
    ),
    (
     Name: 'SysCommBTWrite';
     Params: '(CommBTWriteType & args)'
    ),
    (
     Name: 'SysCommBTCheckStatus';
     Params: '(CommBTCheckStatusType & args)'
    ),
    (
     Name: 'SysKeepAlive';
     Params: '(KeepAliveType & args)'
    ),
    (
     Name: 'SysIOMapRead';
     Params: '(IOMapReadType & args)'
    ),
    (
     Name: 'SysIOMapWrite';
     Params: '(IOMapWriteType & args)'
    ),
    (
     Name: 'SysIOMapReadByID';
     Params: '(IOMapReadByIDType & args)'
    ),
    (
     Name: 'SysIOMapWriteByID';
     Params: '(IOMapWriteByIDType & args)'
    ),
    (
     Name: 'SysDisplayExecuteFunction';
     Params: '(DisplayExecuteFunctionType & args)'
    ),
    (
     Name: 'SysCommExecuteFunction';
     Params: '(CommExecuteFunctionType & args)'
    ),
    (
     Name: 'SysLoaderExecuteFunction';
     Params: '(LoaderExecuteFunctionType & args)'
    ),
    (
     Name: 'bcd2dec';
     Params: '(byte bcd)'
    ),
    (
     Name: 'dec2bcd';
     Params: '(byte dec)'
    ),
    (
     Name: 'SensorHTCompass';
     Params: '(const byte port)'
    ),
    (
     Name: 'ReadSensorHTAccel';
     Params: '(const byte port, int & x, int & y, int & z)'
    ),
    (
     Name: 'ReadSensorHTColor';
     Params: '(const byte port, byte & ColorNum, byte & Red, byte & Green, byte & Blue)'
    ),
    (
     Name: 'ReadSensorHTIRSeeker';
     Params: '(const byte port, byte & dir, byte & s1, byte & s3, byte & s5, byte & s7, byte & s9)'
    ),
    (
     Name: 'SetSensorMSPressure';
     Params: '(port)'
    ),
    (
     Name: 'SensorMSPressure';
     Params: '(port)'
    ),
    (
     Name: 'SensorMSPressureRaw';
     Params: '(port)'
    ),
    (
     Name: 'SensorMSCompassEx';
     Params: '(port, addr)'
    ),
    (
     Name: 'SensorMSCompass';
     Params: '(port)'
    ),
    (
     Name: 'ReadSensorMSRTClock';
     Params: '(port, sec, min, hrs, dow, date, month, year)'
    ),
    (
     Name: 'ReadSensorMSTilt';
     Params: '(port, x, y, z)'
    ),
    (
     Name: 'ReadSensorMSTiltEx';
     Params: '(port, addr, x, y, z)'
    ),
    (
     Name: 'ReadSensorMSAccel';
     Params: '(port, x, y, z)'
    ),
    (
     Name: 'ReadSensorMSAccelEx';
     Params: '(port, addr, x, y, z)'
    ),
    (
     Name: 'MSSendCommandEx';
     Params: '(port, addr, cmd)'
    ),
    (
     Name: 'MSSendCommand';
     Params: '(port, cmd)'
    ),
    (
     Name: 'MSReadValueEx';
     Params: '(port, addr, reg, bytes)'
    ),
    (
     Name: 'MSReadValue';
     Params: '(port, reg, bytes)'
    ),
    (
     Name: 'DISTNxGP2D12';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxGP2D120';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxGP2YA21';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxGP2YA02';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxEnergize';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxDistance';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxVoltage';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxModuleType';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxNumPoints';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxMinDistance';
     Params: '(port)'
    ),
    (
     Name: 'DISTNxMaxDistance';
     Params: '(port)'
    ),
    (
     Name: 'SetSensorMSDRODActive';
     Params: '(port)'
    ),
    (
     Name: 'SetSensorMSDRODInactive';
     Params: '(port)'
    ),
    (
     Name: 'SensorMSDROD';
     Params: '(port)'
    ),
    (
     Name: 'PSPNxEnergize';
     Params: '(port)'
    ),
    (
     Name: 'ReadSensorMSPlayStationEx';
     Params: '(port, addr, b1, b2, xleft, yleft, xright, yright)'
    ),
    (
     Name: 'ReadSensorMSPlayStation';
     Params: '(port, b1, b2, xleft, yleft, xright, yright)'
    ),
    (
     Name: 'NRLink2400';
     Params: '(port)'
    ),
    (
     Name: 'NRLink4800';
     Params: '(port)'
    ),
    (
     Name: 'NRLinkFlush';
     Params: '(port)'
    ),
    (
     Name: 'NRLinkIRLong';
     Params: '(port)'
    ),
    (
     Name: 'NRLinkIRShort';
     Params: '(port)'
    ),
    (
     Name: 'NRLinkTxRaw';
     Params: '(port)'
    ),
    (
     Name: 'NRLinkSetRCX';
     Params: '(port)'
    ),
    (
     Name: 'NRLinkSetTrain';
     Params: '(port)'
    ),
    (
     Name: 'NRLinkSetPF';
     Params: '(port)'
    ),
    (
     Name: 'RunNRLinkMacroEx';
     Params: '(port, addr, macro)'
    ),
    (
     Name: 'RunNRLinkMacro';
     Params: '(port, macro)'
    ),
    (
     Name: 'NRLinkStatusEx';
     Params: '(port, addr)'
    ),
    (
     Name: 'NRLinkStatus';
     Params: '(port)'
    ),
    (
     Name: 'WriteNRLinkBytesEx';
     Params: '(port, addr, bytes)'
    ),
    (
     Name: 'WriteNRLinkBytes';
     Params: '(port, bytes)'
    ),
    (
     Name: 'ReadNRLinkBytesEx';
     Params: '(port, addr, bytes)'
    ),
    (
     Name: 'ReadNRLinkBytes';
     Params: '(port, bytes)'
    ),
    (
     Name: 'MSPFComboDirectEx';
     Params: '(port, addr, channel, outa, outb)'
    ),
    (
     Name: 'MSPFComboDirect';
     Params: '(port, channel, outa, outb)'
    ),
    (
     Name: 'MSPFSinglePinEx';
     Params: '(port, addr, channel, out, pin, func, cont)'
    ),
    (
     Name: 'MSPFSinglePin';
     Params: '(port, channel, out, pin, func, cont)'
    ),
    (
     Name: 'MSPFSingleOutputCSTEx';
     Params: '(port, addr, channel, out, func)'
    ),
    (
     Name: 'MSPFSingleOutputCST';
     Params: '(port, channel, out, func)'
    ),
    (
     Name: 'MSPFSingleOutputPWMEx';
     Params: '(port, addr, channel, out, func)'
    ),
    (
     Name: 'MSPFSingleOutputPWM';
     Params: '(port, channel, out, func)'
    ),
    (
     Name: 'MSPFComboPWMEx';
     Params: '(port, addr, channel, outa, outb)'
    ),
    (
     Name: 'MSPFComboPWM';
     Params: '(port, channel, outa, outb)'
    ),
    (
     Name: 'MSPFTrainEx';
     Params: '(port, addr, channel, func)'
    ),
    (
     Name: 'MSPFTrain';
     Params: '(port, channel, func)'
    ),
    (
     Name: 'MSIRTrainEx';
     Params: '(port, addr, channel, func)'
    ),
    (
     Name: 'MSIRTrain';
     Params: '(port, channel, func)'
    ),
    (
     Name: 'MSPFRawOutputEx';
     Params: '(port, addr, nibble0, nibble1, nibble2)'
    ),
    (
     Name: 'MSPFRawOutput';
     Params: '(port, nibble0, nibble1, nibble2)'
    ),
    (
     Name: 'MSPFRepeatEx';
     Params: '(port, addr, count, delay)'
    ),
    (
     Name: 'MSPFRepeat';
     Params: '(port, count, delay)'
    ),
    (
     Name: 'MSRCXSetNRLinkEx';
     Params: '(port, addr)'
    ),
    (
     Name: 'MSRCXSetNRLinkPort';
     Params: '(port)'
    ),
    (
     Name: 'MSRCXPoll';
     Params: '(src, value)'
    ),
    (
     Name: 'MSRCXBatteryLevel';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXPing';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXDeleteTasks';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXStopAllTasks';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXPBTurnOff';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXDeleteSubs';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXClearSound';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXClearMsg';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXMuteSound';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXUnmuteSound';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXClearAllEvents';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXSetOutput';
     Params: '(outputs, mode)'
    ),
    (
     Name: 'MSRCXSetDirection';
     Params: '(outputs, dir)'
    ),
    (
     Name: 'MSRCXSetPower';
     Params: '(outputs, pwrsrc, pwrval)'
    ),
    (
     Name: 'MSRCXOn';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXOff';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXFloat';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXToggle';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXFwd';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXRev';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXOnFwd';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXOnRev';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXOnFor';
     Params: '(outputs, ms)'
    ),
    (
     Name: 'MSRCXSetTxPower';
     Params: '(pwr)'
    ),
    (
     Name: 'MSRCXPlaySound';
     Params: '(snd)'
    ),
    (
     Name: 'MSRCXDeleteTask';
     Params: '(t)'
    ),
    (
     Name: 'MSRCXStartTask';
     Params: '(t)'
    ),
    (
     Name: 'MSRCXStopTask';
     Params: '(t)'
    ),
    (
     Name: 'MSRCXSelectProgram';
     Params: '(prog)'
    ),
    (
     Name: 'MSRCXClearTimer';
     Params: '(timer)'
    ),
    (
     Name: 'MSRCXSetSleepTime';
     Params: '(t)'
    ),
    (
     Name: 'MSRCXDeleteSub';
     Params: '(s)'
    ),
    (
     Name: 'MSRCXClearSensor';
     Params: '(port)'
    ),
    (
     Name: 'MSRCXPlayToneVar';
     Params: '(varnum, duration)'
    ),
    (
     Name: 'MSRCXSetWatch';
     Params: '(hours, minutes)'
    ),
    (
     Name: 'MSRCXSetSensorType';
     Params: '(port, type)'
    ),
    (
     Name: 'MSRCXSetSensorMode';
     Params: '(port, mode)'
    ),
    (
     Name: 'MSRCXCreateDatalog';
     Params: '(size)'
    ),
    (
     Name: 'MSRCXAddToDatalog';
     Params: '(src, value)'
    ),
    (
     Name: 'MSRCXSendSerial';
     Params: '(first, count)'
    ),
    (
     Name: 'MSRCXRemote';
     Params: '(cmd)'
    ),
    (
     Name: 'MSRCXEvent';
     Params: '(src, value)'
    ),
    (
     Name: 'MSRCXPlayTone';
     Params: '(freq, duration)'
    ),
    (
     Name: 'MSRCXSelectDisplay';
     Params: '(src, value)'
    ),
    (
     Name: 'MSRCXPollMemory';
     Params: '(address)'
    ),
    (
     Name: 'MSRCXSetEvent';
     Params: '(evt, src, type)'
    ),
    (
     Name: 'MSRCXSetGlobalOutput';
     Params: '(outputs, mode)'
    ),
    (
     Name: 'MSRCXSetGlobalDirection';
     Params: '(outputs, dir)'
    ),
    (
     Name: 'MSRCXSetMaxPower';
     Params: '(outputs, pwrsrc, pwrval)'
    ),
    (
     Name: 'MSRCXEnableOutput';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXDisableOutput';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXInvertOutput';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXObvertOutput';
     Params: '(outputs)'
    ),
    (
     Name: 'MSRCXCalibrateEvent';
     Params: '(evt, low, hi, hyst)'
    ),
    (
     Name: 'MSRCXSetVar';
     Params: '(varnum, src, value)'
    ),
    (
     Name: 'MSRCXSumVar';
     Params: '(varnum, src, value)'
    ),
    (
     Name: 'MSRCXSubVar';
     Params: '(varnum, src, value)'
    ),
    (
     Name: 'MSRCXDivVar';
     Params: '(varnum, src, value)'
    ),
    (
     Name: 'MSRCXMulVar';
     Params: '(varnum, src, value)'
    ),
    (
     Name: 'MSRCXSgnVar';
     Params: '(varnum, src, value)'
    ),
    (
     Name: 'MSRCXAbsVar';
     Params: '(varnum, src, value)'
    ),
    (
     Name: 'MSRCXAndVar';
     Params: '(varnum, src, value)'
    ),
    (
     Name: 'MSRCXOrVar';
     Params: '(varnum, src, value)'
    ),
    (
     Name: 'MSRCXSet';
     Params: '(dstsrc, dstval, src, value)'
    ),
    (
     Name: 'MSRCXUnlock';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXReset';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXBoot';
     Params: '(void)'
    ),
    (
     Name: 'MSRCXSetUserDisplay';
     Params: '(src, value, precision)'
    ),
    (
     Name: 'MSRCXIncCounter';
     Params: '(counter)'
    ),
    (
     Name: 'MSRCXDecCounter';
     Params: '(counter)'
    ),
    (
     Name: 'MSRCXClearCounter';
     Params: '(counter)'
    ),
    (
     Name: 'MSRCXSetPriority';
     Params: '(p)'
    ),
    (
     Name: 'MSRCXSetMessage';
     Params: '(msg)'
    ),
    (
     Name: 'MSScoutCalibrateSensor';
     Params: '(void)'
    ),
    (
     Name: 'MSScoutMuteSound';
     Params: '(void)'
    ),
    (
     Name: 'MSScoutUnmuteSound';
     Params: '(void)'
    ),
    (
     Name: 'MSScoutSelectSounds';
     Params: '(grp)'
    ),
    (
     Name: 'MSScoutSetLight';
     Params: '(x)'
    ),
    (
     Name: 'MSScoutSetCounterLimit';
     Params: '(ctr, src, value)'
    ),
    (
     Name: 'MSScoutSetTimerLimit';
     Params: '(tmr, src, value)'
    ),
    (
     Name: 'MSScoutSetSensorClickTime';
     Params: '(src, value)'
    ),
    (
     Name: 'MSScoutSetSensorHysteresis';
     Params: '(src, value)'
    ),
    (
     Name: 'MSScoutSetSensorLowerLimit';
     Params: '(src, value)'
    ),
    (
     Name: 'MSScoutSetSensorUpperLimit';
     Params: '(src, value)'
    ),
    (
     Name: 'MSScoutSetEventFeedback';
     Params: '(src, value)'
    ),
    (
     Name: 'MSScoutSendVLL';
     Params: '(src, value)'
    ),
    (
     Name: 'MSScoutSetScoutRules';
     Params: '(m, t, l, tm, fx)'
    ),
    (
     Name: 'MSScoutSetScoutMode';
     Params: '(mode)'
    )
  );

function NXCCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to NXCCodeCompDataSize - 1 do begin
    if NXCCodeCompData[i].Name = aName then begin
      Result := i;
      Exit;
    end;
  end;
end;

procedure AddNXCCodeCompParams(aStrings : TStrings; Index : integer);
begin
  if (Index < 0) or (Index >= NXCCodeCompDataSize) then Exit;
  AddCodeCompParamsHelper(aStrings, NXCCodeCompData[Index].Params, 'void', ',');
end;

end.
