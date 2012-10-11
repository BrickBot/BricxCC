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
    edtMessages: TMemo;
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
    bConnected : boolean;
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
	hid_close(connected_device);
	connected_device := nil;
  bConnected := False;
  edtMessages.Lines.Add('Disconnected');
  UpdateControls;
end;

procedure TfrmHIDDevices.btnConnectClick(Sender: TObject);
var
  device_info : PHidDeviceInfo;
  tmpstr : string;
begin
// connect
  if lstDeviceList.ItemIndex = -1 then Exit;
  device_info := PHidDeviceInfo(lstDeviceList.Items.Objects[lstDeviceList.ItemIndex]);

	connected_device := hid_open_path(device_info^.path);

	if not Assigned(connected_device) then
  begin
		ShowMessage('Unable To Connect to Device');
		Exit;
	end;

	hid_set_nonblocking(connected_device, 1);

	tmpstr := Format('Connected to: %4.4x:%4.4x -', [device_info^.vendor_id, device_info^.product_id]);
	tmpstr := tmpstr + ' ' + device_info^.manufacturer_string;
	tmpstr := tmpstr + ' ' + device_info^.product_string;
  edtMessages.Lines.Add(tmpstr);
  bConnected := True;
  UpdateControls;
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
  bConnected := False;
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
    tmpstr := Format('%4.4x:%4.4x -', [cur_dev^.vendor_id, cur_dev^.product_id]);
//    tmpstr := cur_dev^.path + ' ' + Format('%4.4x:%4.4x -', [cur_dev^.vendor_id, cur_dev^.product_id]);
    if Assigned(cur_dev^.manufacturer_string) then
      tmpstr := tmpstr + ' ' + string(cur_dev^.manufacturer_string);
    if Assigned(cur_dev^.product_string) then
      tmpstr := tmpstr + ' ' + string(cur_dev^.product_string);
    tmpstr := tmpstr + Format(' (usage: %4.4x:%4.4x) ', [cur_dev^.usage_page, cur_dev^.usage]);
    lstDeviceList.Items.AddObject(tmpstr, TObject(cur_dev));
    cur_dev := cur_dev^.next;
  end;
  if lstDeviceList.Count = 0 then
    lstDeviceList.Items.Add('*** No Devices Connected ***')
  else
    lstDeviceList.ItemIndex := 0;

  UpdateControls;
end;

procedure TfrmHIDDevices.UpdateControls;
begin
  btnDisconnect.Enabled := bConnected;
  btnConnect.Enabled := not bConnected and (lstDeviceList.ItemIndex <> -1);
end;

end.
