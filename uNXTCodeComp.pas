unit uNXTCodeComp;

interface

uses
  Classes;

function NBCCodeCompIndex(aName : string) : Integer;
procedure AddNBCCodeCompParams(aStrings : TStrings; Index : integer);

implementation

uses
  uCppCode;

type
  TNBCCodeComp = record
    Name : string;
    Params : string;
  end;

const
  NBCCodeCompDataSize = 509+91;
  NBCCodeCompData: array[0..NBCCodeCompDataSize-1] of TNBCCodeComp = (
    (
     Name: 'Acos';
     Params: '(X, result)'
    ),
    (
     Name: 'Asin';
     Params: '(X, result)'
    ),
    (
     Name: 'BluetoothStatus';
     Params: '(conn, result)'
    ),
    (
     Name: 'BluetoothWrite';
     Params: '(conn, buffer, word & result)'
    ),
    (
     Name: 'CircleOut';
     Params: '(byte x, byte y, byte radius)'
    ),
    (
     Name: 'CircleOutEx';
     Params: '(byte x, byte y, byte radius, byte cls)'
    ),
    (
     Name: 'ClearScreen';
     Params: '(void)'
    ),
    (
     Name: 'ClearSensor';
     Params: '(port)'
    ),
    (
     Name: 'CloseFile';
     Params: '(byte handle, word & result)'
    ),
    (
     Name: 'Coast';
     Params: '(byte ports)'
    ),
    (
     Name: 'CoastEx';
     Params: '(byte ports, byte reset)'
    ),
    (
     Name: 'Cos';
     Params: '(degrees, result)'
    ),
    (
     Name: 'CreateFile';
     Params: '(string fname, word fsize, byte & handle, word & result)'
    ),
    (
     Name: 'CreateFileLinear';
     Params: '(string fname, word fsize, byte & handle, word & result)'
    ),
    (
     Name: 'CreateFileNonLinear';
     Params: '(string fname, word fsize, byte & handle, word & result)'
    ),
    (
     Name: 'DeleteFile';
     Params: '(string fname, result)'
    ),
    (
     Name: 'ResizeFile';
     Params: '(string fname, word newsize, result)'
    ),
    (
     Name: 'FindFirstFile';
     Params: '(string fname, fsize, handle, result)'
    ),
    (
     Name: 'FindNextFile';
     Params: '(string fname, fsize, handle, result)'
    ),
    (
     Name: 'Float';
     Params: '(ports)'
    ),
    (
     Name: 'ForceOff';
     Params: '(result)'
    ),
    (
     Name: 'GetBatteryLevel';
     Params: '(result)'
    ),
    (
     Name: 'GetBatteryState';
     Params: '(result)'
    ),
    (
     Name: 'GetBluetoothState';
     Params: '(result)'
    ),
    (
     Name: 'GetBrickDataAddress';
     Params: '(p, addr)'
    ),
    (
     Name: 'GetBrickDataBluecoreVersion';
     Params: '(result)'
    ),
    (
     Name: 'GetBrickDataBtHardwareStatus';
     Params: '(result)'
    ),
    (
     Name: 'GetBrickDataBtStateStatus';
     Params: '(result)'
    ),
    (
     Name: 'GetBrickDataName';
     Params: '(str)'
    ),
    (
     Name: 'GetBrickDataTimeoutValue';
     Params: '(result)'
    ),
    (
     Name: 'GetBTConnectionAddress';
     Params: '(conn, addr)'
    ),
    (
     Name: 'GetBTConnectionClass';
     Params: '(conn, result)'
    ),
    (
     Name: 'GetBTConnectionHandleNum';
     Params: '(conn, result)'
    ),
    (
     Name: 'GetBTConnectionLinkQuality';
     Params: '(conn, result)'
    ),
    (
     Name: 'GetBTConnectionName';
     Params: '(conn, str)'
    ),
    (
     Name: 'GetBTConnectionPinCode';
     Params: '(conn, code)'
    ),
    (
     Name: 'GetBTConnectionStreamStatus';
     Params: '(conn, result)'
    ),
    (
     Name: 'GetBTDeviceAddress';
     Params: '(const byte devidx, addr)'
    ),
    (
     Name: 'GetBTDeviceClass';
     Params: '(const byte devidx, result)'
    ),
    (
     Name: 'GetBTDeviceCount';
     Params: '(result)'
    ),
    (
     Name: 'GetBTDeviceName';
     Params: '(p, str)'
    ),
    (
     Name: 'GetBTDeviceNameCount';
     Params: '(result)'
    ),
    (
     Name: 'GetBTDeviceStatus';
     Params: '(const byte devidx, result)'
    ),
    (
     Name: 'GetBTInputBuffer';
     Params: '(const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetBTInputBufferInPtr';
     Params: '(result)'
    ),
    (
     Name: 'GetBTInputBufferOutPtr';
     Params: '(result)'
    ),
    (
     Name: 'GetBTOutputBuffer';
     Params: '(const byte offset, byte cnt, byte & data[])'
    ),
    (
     Name: 'GetBTOutputBufferInPtr';
     Params: '(result)'
    ),
    (
     Name: 'GetBTOutputBufferOutPtr';
     Params: '(result)'
    ),
    (
     Name: 'GetButtonLongPressCount';
     Params: '(const byte btn, result)'
    ),
    (
     Name: 'GetButtonLongReleaseCount';
     Params: '(const byte btn, result)'
    ),
    (
     Name: 'GetButtonModuleValue';
     Params: '(const byte offset, result)'
    ),
    (
     Name: 'GetButtonPressCount';
     Params: '(const byte btn, result)'
    ),
    (
     Name: 'GetButtonReleaseCount';
     Params: '(const byte btn, result)'
    ),
    (
     Name: 'GetButtonShortReleaseCount';
     Params: '(const byte btn, result)'
    ),
    (
     Name: 'GetButtonState';
     Params: '(const byte btn, result)'
    ),
    (
     Name: 'GetCommandFlags';
     Params: '(result)'
    ),
    (
     Name: 'GetCommandModuleValue';
     Params: '(const byte offset, result)'
    ),
    (
     Name: 'GetCommModuleValue';
     Params: '(const byte offset, result)'
    ),
    (
     Name: 'GetDisplayDisplay';
     Params: '(result)'
    ),
    (
     Name: 'GetDisplayEraseMask';
     Params: '(result)'
    ),
    (
     Name: 'GetDisplayFlags';
     Params: '(result)'
    ),
    (
     Name: 'GetDisplayModuleValue';
     Params: '(const byte offset, result)'
    ),
    (
     Name: 'GetDisplayNormal';
     Params: '(x, line, cnt, data)'
    ),
    (
     Name: 'GetDisplayPopup';
     Params: '(x, line, cnt, data)'
    ),
    (
     Name: 'GetDisplayTextLinesCenterFlags';
     Params: '(result)'
    ),
    (
     Name: 'GetDisplayUpdateMask';
     Params: '(result)'
    ),
    (
     Name: 'GetFirstTick';
     Params: '(value)'
    ),
    (
     Name: 'GetFreeMemory';
     Params: '(value)'
    ),
    (
     Name: 'GetHSFlags';
     Params: '(result)'
    ),
    (
     Name: 'GetHSInputBuffer';
     Params: '(const byte offset, cnt, data)'
    ),
    (
     Name: 'GetHSInputBufferInPtr';
     Params: '(result)'
    ),
    (
     Name: 'GetHSInputBufferOutPtr';
     Params: '(result)'
    ),
    (
     Name: 'GetHSOutputBuffer';
     Params: '(const byte offset, cnt, data)'
    ),
    (
     Name: 'GetHSOutputBufferInPtr';
     Params: '(result)'
    ),
    (
     Name: 'GetHSOutputBufferOutPtr';
     Params: '(result)'
    ),
    (
     Name: 'GetHSSpeed';
     Params: '(result)'
    ),
    (
     Name: 'GetHSState';
     Params: '(result)'
    ),
    (
     Name: 'GetInCustomActiveStatus';
     Params: '(port, result)'
    ),
    (
     Name: 'GetInCustomPercentFullScale';
     Params: '(port, result)'
    ),
    (
     Name: 'GetInCustomZeroOffset';
     Params: '(port, result)'
    ),
    (
     Name: 'GetInDigiPinsDirection';
     Params: '(port, result)'
    ),
    (
     Name: 'GetInDigiPinsOutputLevel';
     Params: '(port, result)'
    ),
    (
     Name: 'GetInDigiPinsStatus';
     Params: '(port, result)'
    ),
    (
     Name: 'GetInputModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'GetInSensorBoolean';
     Params: '(port, result)'
    ),
    (
     Name: 'GetIOMapBytes';
     Params: '(modName, offset, cnt, arrOut)'
    ),
    (
     Name: 'GetIOMapValue';
     Params: '(modName, offset, n)'
    ),
    (
     Name: 'GetLoaderModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'GetLowSpeedModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'GetLSChannelState';
     Params: '(port, result)'
    ),
    (
     Name: 'GetLSErrorType';
     Params: '(port, result)'
    ),
    (
     Name: 'GetLSInputBuffer';
     Params: '(p, offset, cnt, data)'
    ),
    (
     Name: 'GetLSInputBufferBytesToRx';
     Params: '(port, result)'
    ),
    (
     Name: 'GetLSInputBufferInPtr';
     Params: '(port, result)'
    ),
    (
     Name: 'GetLSInputBufferOutPtr';
     Params: '(port, result)'
    ),
    (
     Name: 'GetLSMode';
     Params: '(port, result)'
    ),
    (
     Name: 'GetLSOutputBuffer';
     Params: '(p, offset, cnt, data)'
    ),
    (
     Name: 'GetLSOutputBufferBytesToRx';
     Params: '(port, result)'
    ),
    (
     Name: 'GetLSOutputBufferInPtr';
     Params: '(port, result)'
    ),
    (
     Name: 'GetLSOutputBufferOutPtr';
     Params: '(port, result)'
    ),
    (
     Name: 'GetLSSpeed';
     Params: '(n)'
    ),
    (
     Name: 'GetLSState';
     Params: '(n)'
    ),
    (
     Name: 'GetOnBrickProgramPointer';
     Params: '(n)'
    ),
    (
     Name: 'GetAbortFlag';
     Params: '(n)'
    ),
    (
     Name: 'GetOutputModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'GetOutPwnFreq';
     Params: '(n)'
    ),
    (
     Name: 'GetRechargeableBattery';
     Params: '(n)'
    ),
    (
     Name: 'GetSleepTimeout';
     Params: '(n)'
    ),
    (
     Name: 'GetSleepTimer';
     Params: '(n)'
    ),
    (
     Name: 'GetSoundDuration';
     Params: '(n)'
    ),
    (
     Name: 'GetSoundFrequency';
     Params: '(n)'
    ),
    (
     Name: 'GetSoundMode';
     Params: '(n)'
    ),
    (
     Name: 'GetSoundModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'GetSoundSampleRate';
     Params: '(n)'
    ),
    (
     Name: 'GetSoundState';
     Params: '(state, flags)'
    ),
    (
     Name: 'GetSoundVolume';
     Params: '(n)'
    ),
    (
     Name: 'GetUIButton';
     Params: '(n)'
    ),
    (
     Name: 'GetUIModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'GetUIState';
     Params: '(n)'
    ),
    (
     Name: 'GetUSBInputBuffer';
     Params: '(const byte offset, cnt, data)'
    ),
    (
     Name: 'GetUSBInputBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'GetUSBInputBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'GetUSBOutputBuffer';
     Params: '(const byte offset, cnt, data)'
    ),
    (
     Name: 'GetUSBOutputBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'GetUSBOutputBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'GetUSBPollBuffer';
     Params: '(const byte offset, cnt, data)'
    ),
    (
     Name: 'GetUSBPollBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'GetUSBPollBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'GetUsbState';
     Params: '(n)'
    ),
    (
     Name: 'GetUSBState';
     Params: '(n)'
    ),
    (
     Name: 'GetVMRunState';
     Params: '(n)'
    ),
    (
     Name: 'GetVolume';
     Params: '(n)'
    ),
    (
     Name: 'GraphicOut';
     Params: '(x, y, file)'
    ),
    (
     Name: 'GraphicOutEx';
     Params: '(x, y, file, vars, cls)'
    ),
    (
     Name: 'HTRCXSetIRLinkPort';
     Params: '(byte port)'
    ),
    (
     Name: 'HTRCXPoll';
     Params: '(byte src, byte value, int & result)'
    ),
    (
     Name: 'HTRCXBatteryLevel';
     Params: '(int & result)'
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
     Params: '(unsigned int address, byte & result)'
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
     Params: '(grp)'
    ),
    (
     Name: 'HTScoutSetLight';
     Params: '(x)'
    ),
    (
     Name: 'HTScoutSetSensorClickTime';
     Params: '(src, value)'
    ),
    (
     Name: 'HTScoutSetSensorHysteresis';
     Params: '(src, value)'
    ),
    (
     Name: 'HTScoutSetSensorLowerLimit';
     Params: '(src, value)'
    ),
    (
     Name: 'HTScoutSetSensorUpperLimit';
     Params: '(src, value)'
    ),
    (
     Name: 'HTScoutSetEventFeedback';
     Params: '(src, value)'
    ),
    (
     Name: 'HTScoutSendVLL';
     Params: '(src, value)'
    ),
    (
     Name: 'HTScoutSetScoutMode';
     Params: '(mode)'
    ),
    (
     Name: 'LineOut';
     Params: '(x1, y1, x2, y2)'
    ),
    (
     Name: 'LineOutEx';
     Params: '(x1, y1, x2, y2, cls)'
    ),
    (
     Name: 'LowspeedBytesReady';
     Params: '(port, bready)'
    ),
    (
     Name: 'LowspeedCheckStatus';
     Params: '(port, result)'
    ),
    (
     Name: 'LowspeedRead';
     Params: '(port, buflen, buffer, result)'
    ),
    (
     Name: 'LowspeedStatus';
     Params: '(port, bready, result)'
    ),
    (
     Name: 'LowspeedWrite';
     Params: '(port, retlen, buffer, result)'
    ),
    (
     Name: 'NumOut';
     Params: '(x, y, num)'
    ),
    (
     Name: 'NumOutEx';
     Params: '(x, y, num, cls)'
    ),
    (
     Name: 'Off';
     Params: '(ports)'
    ),
    (
     Name: 'OffEx';
     Params: '(ports, reset)'
    ),
    (
     Name: 'OnFwd';
     Params: '(ports, pwr)'
    ),
    (
     Name: 'OnFwdEx';
     Params: '(ports, pwr, reset)'
    ),
    (
     Name: 'OnFwdReg';
     Params: '(ports, pwr, regmode)'
    ),
    (
     Name: 'OnFwdRegEx';
     Params: '(ports, pwr, regmode, reset)'
    ),
    (
     Name: 'OnFwdSync';
     Params: '(ports, pwr, turnpct)'
    ),
    (
     Name: 'OnFwdSyncEx';
     Params: '(ports, pwr, turnpct, reset)'
    ),
    (
     Name: 'OnRev';
     Params: '(ports, pwr)'
    ),
    (
     Name: 'OnRevEx';
     Params: '(ports, pwr, reset)'
    ),
    (
     Name: 'OnRevReg';
     Params: '(ports, pwr, regmode)'
    ),
    (
     Name: 'OnRevRegEx';
     Params: '(ports, pwr, regmode, reset)'
    ),
    (
     Name: 'OnRevSync';
     Params: '(ports, pwr, turnpct)'
    ),
    (
     Name: 'OnRevSyncEx';
     Params: '(ports, pwr, turnpct, reset)'
    ),
    (
     Name: 'OpenFileAppend';
     Params: '(string fname, word & fsize, byte & handle, word & result)'
    ),
    (
     Name: 'OpenFileRead';
     Params: '(string fname, word & fsize, byte & handle, word & result)'
    ),
    (
     Name: 'OpenFileReadLinear';
     Params: '(string fname, word & fsize, byte & handle, word & result)'
    ),
    (
     Name: 'PlayFile';
     Params: '(file)'
    ),
    (
     Name: 'PlayFileEx';
     Params: '(file, volume, bLoop)'
    ),
    (
     Name: 'PlayTone';
     Params: '(frequency, duration)'
    ),
    (
     Name: 'PlayToneEx';
     Params: '(frequency, duration, volume, bLoop)'
    ),
    (
     Name: 'PointOut';
     Params: '(x, y)'
    ),
    (
     Name: 'PointOutEx';
     Params: '(x, y, cls)'
    ),
    (
     Name: 'Random';
     Params: '(arg, maxval)'
    ),
    (
     Name: 'Read';
     Params: '(handle, n, result)'
    ),
    (
     Name: 'ReadButtonEx';
     Params: '(idx, reset, pressed, count, result)'
    ),
    (
     Name: 'ReadBytes';
     Params: '(handle, len, buf, result)'
    ),
    (
     Name: 'ReadI2CBytes';
     Params: '(port, inbuf, count, outbuf, result)'
    ),
    (
     Name: 'ReadLn';
     Params: '(handle, n, result)'
    ),
    (
     Name: 'ReadLnString';
     Params: '(handle, output, result)'
    ),
    (
     Name: 'ReadSensor';
     Params: '(port,value)'
    ),
    (
     Name: 'ReadSensorUS';
     Params: '(port,value)'
    ),
    (
     Name: 'ReadSensorHTGyro';
     Params: '(port, offset, value)'
    ),
    (
     Name: 'ReceiveMessage';
     Params: '(queue, clear, msg, result)'
    ),
    (
     Name: 'ReceiveRemoteBool';
     Params: '(queue, clear, bval, result)'
    ),
    (
     Name: 'ReceiveRemoteMessageEx';
     Params: '(queue, clear, str, val, bval, result)'
    ),
    (
     Name: 'ReceiveRemoteNumber';
     Params: '(queue, clear, val, result)'
    ),
    (
     Name: 'ReceiveRemoteString';
     Params: '(queue, clear, str, result)'
    ),
    (
     Name: 'RectOut';
     Params: '(x,y,w,h)'
    ),
    (
     Name: 'RectOutEx';
     Params: '(x,y,w,h,cls)'
    ),
    (
     Name: 'RemoteKeepAlive';
     Params: '(conn, result)'
    ),
    (
     Name: 'RemoteMessageRead';
     Params: '(conn, queue, result)'
    ),
    (
     Name: 'RemoteMessageWrite';
     Params: '(conn, queue, msg, result)'
    ),
    (
     Name: 'RemotePlaySoundFile';
     Params: '(conn, filename, bloop, result)'
    ),
    (
     Name: 'RemotePlayTone';
     Params: '(conn, frequency, duration, result)'
    ),
    (
     Name: 'RemoteResetMotorPosition';
     Params: '(conn, port, brelative, result)'
    ),
    (
     Name: 'RemoteResetScaledValue';
     Params: '(conn, port, result)'
    ),
    (
     Name: 'RemoteSetInputMode';
     Params: '(conn, port, type, mode, result)'
    ),
    (
     Name: 'RemoteSetOutputState';
     Params: '(conn, port, speed, mode, regmode, turnpct, runstate, tacholimit, result)'
    ),
    (
     Name: 'RemoteStartProgram';
     Params: '(conn, filename, result)'
    ),
    (
     Name: 'RemoteStopProgram';
     Params: '(conn, result)'
    ),
    (
     Name: 'RemoteStopSound';
     Params: '(conn, result)'
    ),
    (
     Name: 'RenameFile';
     Params: '(oldname, newname, result)'
    ),
    (
     Name: 'ResetAllTachoCounts';
     Params: '(p)'
    ),
    (
     Name: 'ResetBlockTachoCount';
     Params: '(p)'
    ),
    (
     Name: 'ResetRotationCount';
     Params: '(p)'
    ),
    (
     Name: 'ResetSensor';
     Params: '(port)'
    ),
    (
     Name: 'ResetTachoCount';
     Params: '(p)'
    ),
    (
     Name: 'ResolveHandle';
     Params: '(fname, handle, writeable, result)'
    ),
    (
     Name: 'RotateMotor';
     Params: '(ports, pwr, angle)'
    ),
    (
     Name: 'RotateMotorEx';
     Params: '(ports, pwr, angle, turnpct, bSync, bStop)'
    ),
    (
     Name: 'RotateMotorExPID';
     Params: '(ports, pwr, angle, turnpct, bSync, bStop, p, i, d)'
    ),
    (
     Name: 'RotateMotorPID';
     Params: '(ports, pwr, angle, p, i, d)'
    ),
    (
     Name: 'RS485Status';
     Params: '(sendingData, dataAvail)'
    ),
    (
     Name: 'RS485Write';
     Params: '(buffer, status)'
    ),
    (
     Name: 'RS485Read';
     Params: '(buffer, status)'
    ),
    (
     Name: 'RS485Control';
     Params: '(cmd, baud, result)'
    ),
    (
     Name: 'RS485Init';
     Params: '(result)'
    ),
    (
     Name: 'RS485Uart';
     Params: '(baud, result)'
    ),
    (
     Name: 'RS485Exit';
     Params: '(result)'
    ),
    (
     Name: 'SendRS485Bool';
     Params: '(bval, status)'
    ),
    (
     Name: 'SendRS485Number';
     Params: '(val, status)'
    ),
    (
     Name: 'SendRS485String';
     Params: '(str, status)'
    ),
    (
     Name: 'SendMessage';
     Params: '(queue, msg, result)'
    ),
    (
     Name: 'SendRemoteBool';
     Params: '(conn, queue, bval, result)'
    ),
    (
     Name: 'SendRemoteNumber';
     Params: '(conn, queue, val, result)'
    ),
    (
     Name: 'SendRemoteString';
     Params: '(conn, queue, str, result)'
    ),
    (
     Name: 'SendResponseBool';
     Params: '(queue, bval, result)'
    ),
    (
     Name: 'SendResponseNumber';
     Params: '(queue, val, result)'
    ),
    (
     Name: 'SendResponseString';
     Params: '(queue, msg, result)'
    ),
    (
     Name: 'SetBatteryState';
     Params: '(n)'
    ),
    (
     Name: 'SetBluetoothState';
     Params: '(n)'
    ),
    (
     Name: 'SetBrickDataAddress';
     Params: '(p, addr)'
    ),
    (
     Name: 'SetBrickDataBluecoreVersion';
     Params: '(n)'
    ),
    (
     Name: 'SetBrickDataBtHardwareStatus';
     Params: '(n)'
    ),
    (
     Name: 'SetBrickDataBtStateStatus';
     Params: '(n)'
    ),
    (
     Name: 'SetBrickDataName';
     Params: '(str)'
    ),
    (
     Name: 'SetBrickDataTimeoutValue';
     Params: '(value)'
    ),
    (
     Name: 'SetBTConnectionAddress';
     Params: '(p, addr)'
    ),
    (
     Name: 'SetBTConnectionClass';
     Params: '(conn, n)'
    ),
    (
     Name: 'SetBTConnectionHandleNum';
     Params: '(conn, n)'
    ),
    (
     Name: 'SetBTConnectionLinkQuality';
     Params: '(conn, n)'
    ),
    (
     Name: 'SetBTConnectionName';
     Params: '(conn, str)'
    ),
    (
     Name: 'SetBTConnectionPinCode';
     Params: '(conn, code)'
    ),
    (
     Name: 'SetBTConnectionStreamStatus';
     Params: '(conn, n)'
    ),
    (
     Name: 'SetBTDeviceAddress';
     Params: '(const byte devidx, addr)'
    ),
    (
     Name: 'SetBTDeviceClass';
     Params: '(const byte devidx, n)'
    ),
    (
     Name: 'SetBTDeviceCount';
     Params: '(n)'
    ),
    (
     Name: 'SetBTDeviceName';
     Params: '(const byte devidx, str)'
    ),
    (
     Name: 'SetBTDeviceNameCount';
     Params: '(n)'
    ),
    (
     Name: 'SetBTDeviceStatus';
     Params: '(const byte devidx, n)'
    ),
    (
     Name: 'SetBTInputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetBTInputBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetBTInputBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetBTOutputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetBTOutputBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetBTOutputBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetButtonLongPressCount';
     Params: '(btn, n)'
    ),
    (
     Name: 'SetButtonLongReleaseCount';
     Params: '(btn, n)'
    ),
    (
     Name: 'SetButtonModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'SetButtonPressCount';
     Params: '(btn, n)'
    ),
    (
     Name: 'SetButtonReleaseCount';
     Params: '(btn, n)'
    ),
    (
     Name: 'SetButtonShortReleaseCount';
     Params: '(btn, n)'
    ),
    (
     Name: 'SetButtonState';
     Params: '(btn, n)'
    ),
    (
     Name: 'SetCommandFlags';
     Params: '(n)'
    ),
    (
     Name: 'SetCommandModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'SetCommModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'SetDisplayDisplay';
     Params: '(n)'
    ),
    (
     Name: 'SetDisplayEraseMask';
     Params: '(n)'
    ),
    (
     Name: 'SetDisplayFlags';
     Params: '(n)'
    ),
    (
     Name: 'SetDisplayModuleValue';
     Params: '(const byte offset, n)'
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
     Params: '(n)'
    ),
    (
     Name: 'SetDisplayUpdateMask';
     Params: '(n)'
    ),
    (
     Name: 'SetHSFlags';
     Params: '(n)'
    ),
    (
     Name: 'SetHSInputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetHSInputBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetHSInputBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetHSOutputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetHSOutputBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetHSOutputBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetHSSpeed';
     Params: '(n)'
    ),
    (
     Name: 'SetHSState';
     Params: '(n)'
    ),
    (
     Name: 'SetInCustomActiveStatus';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetInCustomPercentFullScale';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetInCustomZeroOffset';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetInDigiPinsDirection';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetInDigiPinsOutputLevel';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetInDigiPinsStatus';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetInputModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'SetInSensorBoolean';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetIOCtrlModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'SetIOMapBytes';
     Params: '(modName, offset, cnt, arrIn)'
    ),
    (
     Name: 'SetIOMapValue';
     Params: '(modName, offset, n)'
    ),
    (
     Name: 'SetLoaderModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'SetLowSpeedModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'SetLSChannelState';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSErrorType';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSInputBuffer';
     Params: '(const byte port, const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetLSInputBufferBytesToRx';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSInputBufferInPtr';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSInputBufferOutPtr';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSMode';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSOutputBuffer';
     Params: '(const byte port, const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetLSOutputBufferBytesToRx';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSOutputBufferInPtr';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSOutputBufferOutPtr';
     Params: '(const byte port, n)'
    ),
    (
     Name: 'SetLSSpeed';
     Params: '(n)'
    ),
    (
     Name: 'SetLSState';
     Params: '(n)'
    ),
    (
     Name: 'SetOnBrickProgramPointer';
     Params: '(n)'
    ),
    (
     Name: 'SetAbortFlag';
     Params: '(n)'
    ),
    (
     Name: 'SetOutputModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'SetOutPwnFreq';
     Params: '(n)'
    ),
    (
     Name: 'SetSensorLight';
     Params: '(port)'
    ),
    (
     Name: 'SetSensorLowspeed';
     Params: '(port)'
    ),
    (
     Name: 'SetSensorHTGyro';
     Params: '(port)'
    ),
    (
     Name: 'SetSensorMode';
     Params: '(port, sensorMode)'
    ),
    (
     Name: 'SetSensorSound';
     Params: '(port)'
    ),
    (
     Name: 'SetSensorTouch';
     Params: '(port)'
    ),
    (
     Name: 'SetSensorType';
     Params: '(port, sensorType)'
    ),
    (
     Name: 'SetSensorUltrasonic';
     Params: '(port)'
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
     Params: '(duration)'
    ),
    (
     Name: 'SetSoundFlags';
     Params: '(flags)'
    ),
    (
     Name: 'SetSoundFrequency';
     Params: '(frequency)'
    ),
    (
     Name: 'SetSoundMode';
     Params: '(soundMode)'
    ),
    (
     Name: 'SetSoundModuleValue';
     Params: '(const byte offset, n)'
    ),
    (
     Name: 'SetSoundSampleRate';
     Params: '(sampleRate)'
    ),
    (
     Name: 'SetSoundModuleState';
     Params: '(soundState)'
    ),
    (
     Name: 'SetSoundState';
     Params: '(state, flags, result)'
    ),
    (
     Name: 'SetSoundVolume';
     Params: '(value)'
    ),
    (
     Name: 'SetUIButton';
     Params: '(value)'
    ),
    (
     Name: 'SetUIModuleValue';
     Params: '(const byte offset, value)'
    ),
    (
     Name: 'SetUIState';
     Params: '(n)'
    ),
    (
     Name: 'SetUSBInputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetUSBInputBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetUSBInputBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetUSBOutputBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetUSBOutputBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetUSBOutputBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetUSBPollBuffer';
     Params: '(const byte offset, byte cnt, byte data[])'
    ),
    (
     Name: 'SetUSBPollBufferInPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetUSBPollBufferOutPtr';
     Params: '(n)'
    ),
    (
     Name: 'SetUSBState';
     Params: '(n)'
    ),
    (
     Name: 'SetUsbState';
     Params: '(n)'
    ),
    (
     Name: 'SetVMRunState';
     Params: '(n)'
    ),
    (
     Name: 'SetVolume';
     Params: '(n)'
    ),
    (
     Name: 'SignedRandom';
     Params: '(slong result)'
    ),
    (
     Name: 'Sin';
     Params: '(degrees, result)'
    ),
    (
     Name: 'Sqrt';
     Params: '(value, result)'
    ),
    (
     Name: 'TextOut';
     Params: '(byte x, byte y, string txt)'
    ),
    (
     Name: 'TextOutEx';
     Params: '(byte x, byte y, string txt, bool cls)'
    ),
    (
     Name: 'Wait';
     Params: '(dword ms)'
    ),
    (
     Name: 'Write';
     Params: '(byte handle, n, word result)'
    ),
    (
     Name: 'WriteBytes';
     Params: '(byte handle, buf, cnt, word result)'
    ),
    (
     Name: 'WriteBytesEx';
     Params: '(byte handle, len, buf, word result)'
    ),
    (
     Name: 'WriteLn';
     Params: '(byte handle, n, word result)'
    ),
    (
     Name: 'WriteLnString';
     Params: '(byte handle, str, cnt, word result)'
    ),
    (
     Name: 'WriteString';
     Params: '(byte handle, str, cnt, word result)'
    ),
    (
     Name: 'HTPFComboDirect';
     Params: '(const byte port, byte channel, byte outa, byte outb, byte result)'
    ),
    (
     Name: 'HTPFSinglePin';
     Params: '(const byte port, byte channel, byte out, byte pin, byte func, bool cont, byte result)'
    ),
    (
     Name: 'HTPFSingleOutputCST';
     Params: '(const byte port, byte channel, byte out, byte func, byte result)'
    ),
    (
     Name: 'HTPFSingleOutputPWM';
     Params: '(const byte port, byte channel, byte out, byte func, byte result)'
    ),
    (
     Name: 'HTPFComboPWM';
     Params: '(const byte port, byte channel, byte outa, byte outb, byte result)'
    ),
    (
     Name: 'HTPFTrain';
     Params: '(const byte port, byte channel, byte func, byte result)'
    ),
    (
     Name: 'HTIRTrain';
     Params: '(const byte port, byte channel, byte func, byte result)'
    ),
    (
     Name: 'HTPFRawOutput';
     Params: '(const byte port, byte nibble0, byte nibble1, byte nibble2, byte result)'
    ),
    (
     Name: 'HTPFRepeat';
     Params: '(const byte port, byte count, word delay, byte result)'
    ),
    (
     Name: 'bcd2dec';
     Params: '(bcd, value)'
    ),
    (
     Name: 'dec2bcd';
     Params: '(dec, value)'
    ),
    (
     Name: 'ReadSensorHTCompass';
     Params: '(port, value)'
    ),
    (
     Name: 'ReadSensorHTAccel';
     Params: '(port, x, y, z, result)'
    ),
    (
     Name: 'ReadSensorHTColor';
     Params: '(port, ColorNum, Red, Green, Blue, result)'
    ),
    (
     Name: 'ReadSensorHTIRSeeker';
     Params: '(port, dir, s1, s3, s5, s7, s9, result)'
    ),
    (
     Name: 'SetSensorMSPressure';
     Params: '(port)'
    ),
    (
     Name: 'ReadSensorMSPressure';
     Params: '(port, value)'
    ),
    (
     Name: 'ReadSensorMSPressureRaw';
     Params: '(port, value)'
    ),
    (
     Name: 'ReadSensorMSCompassEx';
     Params: '(port, addr, value)'
    ),
    (
     Name: 'ReadSensorMSCompass';
     Params: '(port, value)'
    ),
    (
     Name: 'ReadSensorMSRTClock';
     Params: '(port, sec, min, hrs, dow, date, month, year, result)'
    ),
    (
     Name: 'ReadSensorMSTilt';
     Params: '(port, x, y, z, result)'
    ),
    (
     Name: 'ReadSensorMSTiltEx';
     Params: '(port, addr, x, y, z, result)'
    ),
    (
     Name: 'ReadSensorMSAccel';
     Params: '(port, x, y, z, result)'
    ),
    (
     Name: 'ReadSensorMSAccelEx';
     Params: '(port, addr, x, y, z, result)'
    ),
    (
     Name: 'MSSendCommandEx';
     Params: '(port, addr, cmd, result)'
    ),
    (
     Name: 'MSSendCommand';
     Params: '(port, cmd, result)'
    ),
    (
     Name: 'MSReadValueEx';
     Params: '(port, addr, reg, bytes, out, result)'
    ),
    (
     Name: 'MSReadValue';
     Params: '(port, reg, bytes, out, result)'
    ),
    (
     Name: 'DISTNxGP2D12';
     Params: '(port, result)'
    ),
    (
     Name: 'DISTNxGP2D120';
     Params: '(port, result)'
    ),
    (
     Name: 'DISTNxGP2YA21';
     Params: '(port, result)'
    ),
    (
     Name: 'DISTNxGP2YA02';
     Params: '(port, result)'
    ),
    (
     Name: 'DISTNxEnergize';
     Params: '(port, result)'
    ),
    (
     Name: 'ReadDISTNxDistance';
     Params: '(port, out, result)'
    ),
    (
     Name: 'ReadDISTNxVoltage';
     Params: '(port, out, result)'
    ),
    (
     Name: 'ReadDISTNxModuleType';
     Params: '(port, out, result)'
    ),
    (
     Name: 'ReadDISTNxNumPoints';
     Params: '(port, out, result)'
    ),
    (
     Name: 'ReadDISTNxMinDistance';
     Params: '(port, out, result)'
    ),
    (
     Name: 'ReadDISTNxMaxDistance';
     Params: '(port, out, result)'
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
     Name: 'ReadSensorMSDROD';
     Params: '(port, value)'
    ),
    (
     Name: 'PSPNxEnergize';
     Params: '(port, result)'
    ),
    (
     Name: 'ReadSensorMSPlayStationEx';
     Params: '(port, addr, b1, b2, xleft, yleft, xright, yright, result)'
    ),
    (
     Name: 'ReadSensorMSPlayStation';
     Params: '(port, b1, b2, xleft, yleft, xright, yright, result)'
    ),
    (
     Name: 'NRLink2400';
     Params: '(port, result)'
    ),
    (
     Name: 'NRLink4800';
     Params: '(port, result)'
    ),
    (
     Name: 'NRLinkFlush';
     Params: '(port, result)'
    ),
    (
     Name: 'NRLinkIRLong';
     Params: '(port, result)'
    ),
    (
     Name: 'NRLinkIRShort';
     Params: '(port, result)'
    ),
    (
     Name: 'NRLinkTxRaw';
     Params: '(port, result)'
    ),
    (
     Name: 'NRLinkSetRCX';
     Params: '(port, result)'
    ),
    (
     Name: 'NRLinkSetTrain';
     Params: '(port, result)'
    ),
    (
     Name: 'NRLinkSetPF';
     Params: '(port, result)'
    ),
    (
     Name: 'RunNRLinkMacroEx';
     Params: '(port, addr, macro, result)'
    ),
    (
     Name: 'RunNRLinkMacro';
     Params: '(port, macro, result)'
    ),
    (
     Name: 'ReadNRLinkStatusEx';
     Params: '(port, addr, value, result)'
    ),
    (
     Name: 'ReadNRLinkStatus';
     Params: '(port, value, result)'
    ),
    (
     Name: 'WriteNRLinkBytesEx';
     Params: '(port, addr, bytes, result)'
    ),
    (
     Name: 'WriteNRLinkBytes';
     Params: '(port, bytes, result)'
    ),
    (
     Name: 'ReadNRLinkBytesEx';
     Params: '(port, addr, bytes, result)'
    ),
    (
     Name: 'ReadNRLinkBytes';
     Params: '(port, bytes, result)'
    ),
    (
     Name: 'MSPFComboDirectEx';
     Params: '(port, addr, channel, outa, outb, result)'
    ),
    (
     Name: 'MSPFComboDirect';
     Params: '(port, channel, outa, outb, result)'
    ),
    (
     Name: 'MSPFSinglePinEx';
     Params: '(port, addr, channel, out, pin, func, cont, result)'
    ),
    (
     Name: 'MSPFSinglePin';
     Params: '(port, channel, out, pin, func, cont, result)'
    ),
    (
     Name: 'MSPFSingleOutputCSTEx';
     Params: '(port, addr, channel, out, func, result)'
    ),
    (
     Name: 'MSPFSingleOutputCST';
     Params: '(port, channel, out, func, result)'
    ),
    (
     Name: 'MSPFSingleOutputPWMEx';
     Params: '(port, addr, channel, out, func, result)'
    ),
    (
     Name: 'MSPFSingleOutputPWM';
     Params: '(port, channel, out, func, result)'
    ),
    (
     Name: 'MSPFComboPWMEx';
     Params: '(port, addr, channel, outa, outb, result)'
    ),
    (
     Name: 'MSPFComboPWM';
     Params: '(port, channel, outa, outb, result)'
    ),
    (
     Name: 'MSPFTrainEx';
     Params: '(port, addr, channel, func, result)'
    ),
    (
     Name: 'MSPFTrain';
     Params: '(port, channel, func, result)'
    ),
    (
     Name: 'MSIRTrainEx';
     Params: '(port, addr, channel, func, result)'
    ),
    (
     Name: 'MSIRTrain';
     Params: '(port, channel, func, result)'
    ),
    (
     Name: 'MSPFRawOutputEx';
     Params: '(port, addr, nibble0, nibble1, nibble2, result)'
    ),
    (
     Name: 'MSPFRawOutput';
     Params: '(port, nibble0, nibble1, nibble2, result)'
    ),
    (
     Name: 'MSPFRepeatEx';
     Params: '(port, addr, count, delay, result)'
    ),
    (
     Name: 'MSPFRepeat';
     Params: '(port, count, delay, result)'
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
     Params: '(src, value, result)'
    ),
    (
     Name: 'MSRCXBatteryLevel';
     Params: '(result)'
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
     Params: '(address, result)'
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

procedure AddNBCCodeCompParams(aStrings : TStrings; Index : integer);
begin
  if (Index < 0) or (Index >= NBCCodeCompDataSize) then Exit;
  AddCodeCompParamsHelper(aStrings, NBCCodeCompData[Index].Params, 'void', ',');
end;

function NBCCodeCompIndex(aName : string) : Integer;
var
  i : Integer;
begin
  Result := -1;
  for i := 0 to NBCCodeCompDataSize - 1 do begin
    if NBCCodeCompData[i].Name = aName then begin
      Result := i;
      Exit;
    end;
  end;
end;

end.