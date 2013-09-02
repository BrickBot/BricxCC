unit uDeviceTypeImages;

interface

uses
  SysUtils, Classes, ImgList, Controls, ActnList;

type
  TdmDevTypeImg = class(TDataModule)
    imgDevType34: TImageList;
    imgDevType64: TImageList;
    actList: TActionList;
    actNone: TAction;
    actNXTTouch: TAction;
    actNXTLight: TAction;
    actNXTSound: TAction;
    actNXTColor: TAction;
    actNXTUltrasonic: TAction;
    actTemperature: TAction;
    actLargeMotor: TAction;
    actMediumMotor: TAction;
    actEV3Touch: TAction;
    actEV3Color: TAction;
    actEV3Ultrasonic: TAction;
    actEV3Gyro: TAction;
    actEV3InfraRed: TAction;
    actHTPIR: TAction;
    actHTBarometer: TAction;
    actHTIRSeekerV2: TAction;
    actEMeter: TAction;
    actI2C: TAction;
    actHTColor: TAction;
    actHTColorPD: TAction;
    actHTAngle: TAction;
    actHTCompass: TAction;
    actHTIRReceiver: TAction;
    actHTAccel: TAction;
    actHTIRLink: TAction;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDevTypeImg: TdmDevTypeImg;

implementation

{$R *.dfm}

end.
