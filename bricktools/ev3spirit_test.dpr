program ev3spirit_test;

{$APPTYPE CONSOLE}

uses
  SysUtils, Classes, brick_common, EV3Spirit, uGlobals, uCompCommon, uImgFormats;

var
  name, btaddr, filename : string;
  btsig, memfree : cardinal;
  fileList : TStringList;
  i : integer;

begin
  LocalBrickType := SU_EV3;
  BrickComm.Port := 'usb';
  if BrickComm.Open then
  begin
    WriteLn(BrickComm.SendRawCommand('800000820F', false));
    Sleep(2500);
//    WriteLn(BrickComm.SendRawCommand('0004003A830100000060', false));
//    WriteLn(BrickComm.SendRawCommand('0000009401816482B80182E803', false));
//    BrickComm.PlayTone(440, 2000);
//    Sleep(2500);
//    BrickComm.PlayTone(880, 2000);
//    Sleep(500);
//    BrickComm.ClearSound();
    BrickComm.DCPlaySoundFile('/media/card/3', false);
//    BrickComm.DCPlaySoundFile('../prjs/SD_Card/3', false);
    Sleep(2500);
(*
    WriteLn(BrickComm.BatteryLevel);
    WriteLn(BrickComm.VersionString);
    BrickComm.SCGetDeviceInfo(name, btaddr, btsig, memfree);
    WriteLn(name);
    WriteLn(btaddr);
    WriteLn(btsig);
    WriteLn(memfree);
    WriteLn(BrickComm.SCSetBrickName('EV3', true));
    WriteLn(BrickComm.SCGetDeviceInfo(name, btaddr, btsig, memfree));
    WriteLn(name);
    filename := '../prjs/SD_Card/Project/Debug1.rbf';
    WriteLn(BrickComm.SCDeleteFile(filename, true));
    BrickComm.BrickFolder := '/media/card/';
    filename := 'D:\ev3\play_tones\api\2.rsf';
    WriteLn(BrickComm.DownloadFile(filename, nftSound));
    filename := 'D:\ev3\lms2012\sys\ui\mindstorms.rgf';
    WriteLn(BrickComm.DownloadFile(filename, nftGraphics));
*)
(*
    fileList := TStringList.Create;
    try
      BrickComm.BrickFolder := '/media/card/';
      BrickComm.ListFiles('*.*', fileList);
      for i := 0 to fileList.Count - 1 do
      begin
        WriteLn(fileList[i]);
      end;
    finally
      fileList.Free;
    end;
*)
    BrickComm.Close;
  end;
end.
