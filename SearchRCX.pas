(*
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is Mark Overmars.
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit SearchRCX;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, uMiscDefines;

type
  TSearchRCXForm = class(TForm)
    Label1: TLabel;
    OKBtn: TButton;
    CancelBtn: TButton;
    grpFirmware: TGroupBox;
    radStandard: TRadioButton;
    radBrickOS: TRadioButton;
    radPBForth: TRadioButton;
    radLejos: TRadioButton;
    radOtherFirmware: TRadioButton;
    btnHelp: TButton;
    pnlPorts: TGroupBox;
    pnlFirmware: TGroupBox;
    cboPort: TComboBox;
    cboBrickType: TComboBox;
    chkUseBluetooth: TCheckBox;
    procedure FirmwareClick(Sender: TObject);
    procedure BrictypeClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateControls;
    function GetUseBT: boolean;
    procedure SetUseBT(const Value: boolean);
  public
    { Public declarations }
    function GetPort : string;
    function GetRCXType : integer;
    function GetStandardFirmware : boolean;
    function GetFirmwareType : TFirmwareType;
    procedure SetPort(const aName : string);
    procedure SetRCXType(aType : integer);
    procedure SetStandardFirmware(aVal : Boolean);
    procedure SetFirmwareType(ft : TFirmwareType);
    property UseBluetooth : boolean read GetUseBT write SetUseBT;
  end;

var
  SearchRCXForm: TSearchRCXForm;

function SearchForRCX(atstartup, bAlwaysPrompt :boolean) : Boolean;

function CheckAlive : boolean; //Checks whether the RCX is still alive
function IsNXT : boolean;
function IsSwan : boolean;
function IsRCX2 : boolean;
function IsRCX : boolean;
function IsScout : boolean;
function IsSpybotic : boolean;
function UseUSB : Boolean;

var
  IRexists:boolean;          // Whether the COM port exists


implementation

{$R *.DFM}

uses
  SysUtils, Dialogs, Math, FakeSpirit, rcx_link, uSpirit, brick_common,
  uGuiUtils, uLocalizedStrings;

function IsNXT : boolean;
begin
  result := (LocalBrickType = SU_NXT);
end;

function IsSwan : boolean;
begin
  result := (LocalBrickType = SU_SWAN);
end;

function IsRCX2 : boolean;
begin
  result := (LocalBrickType = SU_RCX2) or (LocalBrickType = SU_SWAN);
end;

function IsRCX : boolean;
begin
  result := (LocalBrickType = SU_RCX) or (LocalBrickType = SU_RCX2) or (LocalBrickType = SU_SWAN);
end;

function IsScout : boolean;
begin
  result := (LocalBrickType = SU_SCOUT);
end;

function IsSpybotic : boolean;
begin
  result := (LocalBrickType = SU_SPYBOTIC);
end;

function UseUSB : Boolean;
begin
  Result := PortIsUSB(LocalPort);
end;

{Checks whether the RCX is (still) alive}
function CheckAlive : boolean;
begin
  Result := False;
  // always start with a closed BrickComm
  if not BrickComm.UseBluetooth then
    BrickComm.Close;
  while True do
  begin
    if not LocalStandardFirmware then begin
      // leave BrickComm open
      BrickComm.Open;
      Break;
    end
    else begin
      if BrickComm.BrickAlive then
        Break
      else if MessageDlg(S_CANNOT_FIND_RCX, mtWarning, [mbOK, mbCancel], 0) = mrCancel then
        Exit;
    end;
    if not BrickComm.UseBluetooth then
      BrickComm.Close;
  end;
  Result := True;
end;

{Searches for the COM port}
function FindPort(const theport:string):boolean;
var
  SL : TStringList;
  i : integer;
begin
  IRexists := false;
  if IsNXT and (UpperCase(thePort) = 'SEARCH') then
    BrickComm.NXTUpdateResourceNames;
  if (theport = '') or (thePort = 'Automatic') or (UpperCase(thePort) = 'SEARCH') then
  begin
    // first try brick resource strings from the nxt.dat file
    SL := TStringList.Create;
    try
      LoadNXTPorts(SL);
      for i := 0 to SL.Count - 1 do
      begin
        BrickComm.Port := SL[i];
        if BrickComm.TowerExists then
        begin
          IRexists  := True;
          LocalPort := BrickComm.Port;
          break;
        end;
      end;
    finally
      SL.Free;
    end;
    // then try usb/com1..com8
    if not IRexists then
    begin
      // try usb
      BrickComm.Port := 'usb';
      if BrickComm.TowerExists then
      begin
        IRexists  := True;
        LocalPort := BrickComm.Port;
      end;
    end;
    if not IRexists then
    begin
      for i := 1 to 8 do
      begin
        BrickComm.Port := 'COM'+IntToStr(i);
        if BrickComm.TowerExists then
        begin
          IRexists  := True;
          LocalPort := BrickComm.Port;
          break;
        end;
      end;
    end;
  end
  else
  begin
    BrickComm.Port := theport;
    if BrickComm.TowerExists then
    begin
      IRexists  := True;
      LocalPort := BrickComm.Port;
    end;
  end;
  result := IRexists;
end;

{Does the actual searching}
function FindIt(thetype:Integer; const theport : string):boolean;
begin
  BrickComm.BrickType := thetype;
  FindPort(theport);
  {If it exists, find the RCX}
  if IRexists then
    result := CheckAlive
  else
    result := false;
  // make sure local use bluetooth matches current BrickComm setting
  LocalUseBluetooth := BrickComm.UseBluetooth;
end;

{Tries to locate the RCX. atstartup indicates whether this is the
 call at startup, in which case we use the startup defaults.}
function SearchForRCX(atstartup, bAlwaysPrompt : boolean) : boolean;
begin
  result := False;
  IRexists:=false;
  if (atstartup and (LocalStartupAction = SU_NOCONNECT)) then
    Exit;
  if (atstartup and (LocalStartupAction = SU_CONNECT)) or
     (not (atstartup or bAlwaysPrompt)) then
  begin
    Result := FindIt(LocalBrickType, LocalPort);
    if Result then Exit;
  end;
  SearchRCXForm.SetPort(LocalPort);
  SearchRCXForm.SetRCXType(LocalBrickType);
  SearchRCXForm.SetStandardFirmware(LocalStandardFirmware);
  SearchRCXForm.SetFirmwareType(LocalFirmwareType);
  if SearchRCXForm.ShowModal = mrOk then
  begin
    LocalPort := SearchRCXForm.GetPort;
    if LocalBrickType <> SearchRCXForm.GetRCXType then
    begin
      LocalBrickType := SearchRCXForm.GetRCXType;
      // release the old brick comm object
      ReleaseBrickComm;
    end;
    LocalStandardFirmware := SearchRCXForm.GetStandardFirmware;
    LocalFirmwareType     := SearchRCXForm.GetFirmwareType;
    Result := FindIt(LocalBrickType, LocalPort);
  end;
end;

{ TSearchRCXForm }

function TSearchRCXForm.GetPort: string;
begin
  if cboPort.ItemIndex = 0 then
    Result := ''
  else
    Result := cboPort.Text;
end;

function TSearchRCXForm.GetRCXType: integer;
begin
  if cboBrickType.ItemIndex = -1 then
    Result := SU_RCX
  else
    Result := cboBrickType.ItemIndex;
end;

function TSearchRCXForm.GetStandardFirmware: boolean;
begin
  Result := radStandard.Checked;
end;

procedure TSearchRCXForm.SetPort(const aName: string);
begin
  cboPort.ItemIndex := cboPort.Items.IndexOf(aName);
  if cboPort.ItemIndex = -1 then
    cboPort.Text := aName;
end;

procedure TSearchRCXForm.SetRCXType(aType: integer);
begin
  cboBrickType.ItemIndex := aType;
end;

procedure TSearchRCXForm.SetStandardFirmware(aVal: Boolean);
begin
  radStandard.Checked := aVal;
  if not aVal then
    radBrickOS.Checked := True;
  UpdateControls;
end;

procedure TSearchRCXForm.UpdateControls;
var
  bStandard : Boolean;
begin
  bStandard := radStandard.Checked;
  // select RCX and disable brick type combo
  if not bStandard then
    cboBrickType.ItemIndex := 0;
  cboBrickType.Enabled := bStandard;
end;

procedure TSearchRCXForm.FirmwareClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TSearchRCXForm.SetFirmwareType(ft: TFirmwareType);
begin
  case ft of
    ftBrickOS : radBrickOS.Checked := True;
    ftPBForth : radPBForth.Checked := True;
    ftLeJOS   : radLejos.Checked   := True;
  else
    // assume standard
    radStandard.Checked := True;
  end;
end;

function TSearchRCXForm.GetFirmwareType: TFirmwareType;
begin
  if radBrickOS.Checked then
    Result := ftBrickOS
  else if radPBForth.Checked then
    Result := ftPBForth
  else if radLejos.Checked then
    Result := ftLeJOS
  else if radOtherFirmware.Checked then
    Result := ftOther
  else
    Result := ftStandard;
end;

procedure TSearchRCXForm.BrictypeClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TSearchRCXForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TSearchRCXForm.FormCreate(Sender: TObject);
var
  i : integer;
begin
  if not FileExists(GetInitFilename) then
    CreateInitFile;
  LoadNXTPorts(cboPort.Items);
  for i := 1 to 8 do
  begin
    cboPort.Items.Add('COM'+IntToStr(i));
  end;
  SizeComboboxDropdown(cboPort);
  cboPort.Text := 'usb';
end;

function TSearchRCXForm.GetUseBT: boolean;
begin

  Result := chkUseBluetooth.Checked;
end;

procedure TSearchRCXForm.SetUseBT(const Value: boolean);
begin
  chkUseBluetooth.Checked := Value;
end;

end.
