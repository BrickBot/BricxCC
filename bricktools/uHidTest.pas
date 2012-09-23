unit uHidTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, hidapi;

type
  TfrmHIDDevices = class(TForm)
    lstDeviceList: TListBox;
    btnConnect: TButton;
    btnDisconnect: TButton;
    btnRescan: TButton;
    procedure btnDisconnectClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure btnRescanClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    devices : PHidDeviceInfo;
    connected_device : PHidDevice;
    procedure DoRescan;
    procedure UpdateControls;
  end;

var
  frmHIDDevices: TfrmHIDDevices;

implementation

{$R *.dfm}

procedure TfrmHIDDevices.btnDisconnectClick(Sender: TObject);
begin
// disconnect
end;

procedure TfrmHIDDevices.btnConnectClick(Sender: TObject);
begin
// connect
end;

procedure TfrmHIDDevices.btnRescanClick(Sender: TObject);
begin
// rescan
  DoRescan();
end;

procedure TfrmHIDDevices.FormCreate(Sender: TObject);
begin
	devices := nil;
	connected_device := nil;
  DoRescan();
end;

procedure TfrmHIDDevices.FormDestroy(Sender: TObject);
begin
	if Assigned(connected_device) then
		hid_close(connected_device);
	hid_exit();
end;

procedure TfrmHIDDevices.DoRescan;
var
  cur_dev : PHidDeviceInfo;
  tmpstr : string;
begin
  lstDeviceList.Clear;
  // list the devices
  hid_free_enumeration(devices);
  devices := hid_enumerate($0, $0);
  cur_dev := devices;
  while Assigned(cur_dev) do
  begin
		// Add it to the List Box.
    tmpstr := Format('0x%4.4x:0x%4.4x', [cur_dev^.vendor_id, cur_dev^.product_id]);
//    if Assigned(cur_dev^.manufacturer_string) then
//      tmpstr := tmpstr + ' ' + widestring(cur_dev^.manufacturer_string);
//    if Assigned(cur_dev^.product_string) then
//      tmpstr := tmpstr + ' ' + widestring(cur_dev^.product_string);
    tmpstr := tmpstr + ' ' + Format('0x%4.4x:0x%4.4x', [cur_dev^.usage_page, cur_dev^.usage]);
    lstDeviceList.Items.Add(tmpstr);
    cur_dev := cur_dev^.next;
  end;
  if lstDeviceList.Count = 0 then
    lstDeviceList.Items.Add('*** No Devices Connected ***')
  else
    lstDeviceList.ItemIndex := 0;

  UpdateControls();
end;

procedure TfrmHIDDevices.UpdateControls;
begin

end;

end.
