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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit SearchRCX;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls, ExtCtrls, uMiscDefines, uGlobals;

type
  TSearchBrickForm = class(TForm)
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
    radLinux: TRadioButton;
    procedure FirmwareClick(Sender: TObject);
    procedure BrictypeClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cboBrickTypeChange(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateControls;
    function GetUseBT: boolean;
    procedure SetUseBT(const Value: boolean);
    procedure DoCreateInitFile;
    function SearchAllPorts : boolean;
    function GetFirmwareType : TFirmwareType;
    procedure SetFirmwareType(ft : TFirmwareType);
    function GetBrickType : integer;
    procedure SetBrickType(aType : integer);
  public
    { Public declarations }
    function GetPort : string;
    function GetStandardFirmware : boolean;
    procedure SetPort(const aName : string);
    procedure SetStandardFirmware(aVal : Boolean);
    procedure PopulatePortsList;
    procedure DoUpdateInitFile;
    procedure DoAutomaticPorts;
    property UseBluetooth : boolean read GetUseBT write SetUseBT;
    property FirmwareType : TFirmwareType read GetFirmwareType write SetFirmwareType;
    property BrickType : integer read GetBrickType write SetBrickType;
  end;

var
  SearchBrickForm: TSearchBrickForm;

function SearchForBrick(atstartup, bAlwaysPrompt :boolean) : Boolean;

function UseUSB : Boolean;

var
  IRexists:boolean;          // Whether the COM port exists


implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, Dialogs, Math, FakeSpirit, rcx_link, uSpirit, brick_common,
  uGuiUtils, uLocalizedStrings, uSearchNXT
  {$IFNDEF FPC}, Windows{$ENDIF};

const
  AUTOPORTS_TIMEOUT  = 30000; // 15 seconds
  CREATEINIT_TIMEOUT = 30000; // 30 seconds
  UPDATEINIT_TIMEOUT = 30000; // 30 seconds

function UseUSB : Boolean;
begin
  Result := PortIsUSB(LocalPort);
end;

{Searches for the COM port}
function FindPort(const theport:string):boolean;
begin
  IRexists := false;
  if (theport = '') or (thePort = 'Automatic') or (UpperCase(thePort) = 'SEARCH') then
  begin
    SearchBrickForm.DoAutomaticPorts;
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
  {If it exists, find the brick}
  if IRexists then
    result := CheckAlive
  else
    result := false;
  // make sure local use bluetooth matches current BrickComm setting
  LocalUseBluetooth := BrickComm.UseBluetooth;
end;

{Tries to locate the brick. atstartup indicates whether this is the
 call at startup, in which case we use the startup defaults.}
function SearchForBrick(atstartup, bAlwaysPrompt : boolean) : boolean;
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
  SearchBrickForm.SetPort(LocalPort);
  SearchBrickForm.SetBrickType(LocalBrickType);
  SearchBrickForm.SetStandardFirmware(LocalStandardFirmware);
  SearchBrickForm.SetFirmwareType(LocalFirmwareType);
  if SearchBrickForm.ShowModal = mrOk then
  begin
    LocalPort := SearchBrickForm.GetPort;
    if LocalBrickType <> SearchBrickForm.GetBrickType then
    begin
      LocalBrickType := SearchBrickForm.GetBrickType;
      // release the old brick comm object
      ReleaseBrickComm;
    end;
    LocalStandardFirmware := SearchBrickForm.GetStandardFirmware;
    LocalFirmwareType     := SearchBrickForm.GetFirmwareType;
    if IsNXT and (UpperCase(LocalPort) = 'SEARCH') then
      SearchBrickForm.DoUpdateInitFile;
    Result := FindIt(LocalBrickType, LocalPort);
    if UpperCase(SearchBrickForm.GetPort) = 'SEARCH' then
      SearchBrickForm.PopulatePortsList;
  end;
end;

type
  TUpdaterProc = function : boolean of object;
  TUpdaterThread = class(TThread)
  protected
    fProc : TUpdaterProc;
    procedure Execute; override;
  public
    constructor Create(p : TUpdaterProc);
  end;

{ TUpdaterThread }

constructor TUpdaterThread.Create(p: TUpdaterProc);
begin
  inherited Create(True);
  FreeOnTerminate := True;
  fProc := p;
end;

procedure TUpdaterThread.Execute;
begin
  fProc;
end;

{ TSearchRCXForm }

function TSearchBrickForm.GetPort: string;
begin
  if cboPort.ItemIndex = 0 then
    Result := ''
  else
    Result := cboPort.Text;
end;

function TSearchBrickForm.GetBrickType: integer;
begin
  if cboBrickType.ItemIndex = -1 then
    Result := SU_RCX
  else
    Result := cboBrickType.ItemIndex;
end;

function TSearchBrickForm.GetStandardFirmware: boolean;
begin
  Result := radStandard.Checked;
end;

procedure TSearchBrickForm.SetPort(const aName: string);
begin
  cboPort.ItemIndex := cboPort.Items.IndexOf(aName);
  if cboPort.ItemIndex = -1 then
    cboPort.Text := aName;
end;

procedure TSearchBrickForm.SetBrickType(aType: integer);
begin
  cboBrickType.ItemIndex := aType;
  PopulatePortsList;
end;

procedure TSearchBrickForm.SetStandardFirmware(aVal: Boolean);
begin
  radStandard.Checked := aVal;
  if not aVal then
    radOtherFirmware.Checked := True;
  UpdateControls;
end;

procedure TSearchBrickForm.UpdateControls;
var
  bt : integer;
begin
  bt := BrickType;
  case bt of
    rtRCX, rtRCX2 : begin
      radStandard.Enabled := True;
      radBrickOS.Enabled := True;
      radPBForth.Enabled := True;
      radLeJOS.Enabled := True;
      radLinux.Enabled := False;
      radOtherFirmware.Enabled := True;
      if radLinux.Checked then
        radStandard.Checked := True;
    end;
    rtCybermaster, rtScout, rtSpy, rtSwan, rtSPro : begin
      radStandard.Checked := True;
      radStandard.Enabled := True;
      radBrickOS.Enabled := False;
      radPBForth.Enabled := False;
      radLeJOS.Enabled := False;
      radLinux.Enabled := False;
      radOtherFirmware.Enabled := False;
    end;
    rtNXT : begin
      if not (radStandard.Checked or radLeJOS.Checked) then
        radStandard.Checked := True;
      radStandard.Enabled := True;
      radBrickOS.Enabled := False;
      radPBForth.Enabled := False;
      radLeJOS.Enabled := True;
      radLinux.Enabled := False;
      radOtherFirmware.Enabled := False;
    end;
    rtEV3 : begin
      if not (radStandard.Checked or radLeJOS.Checked or radLinux.Checked) then
        radStandard.Checked := True;
      radStandard.Enabled := True;
      radBrickOS.Enabled := False;
      radPBForth.Enabled := False;
      radLeJOS.Enabled := True;
      radLinux.Enabled := True;
      radOtherFirmware.Enabled := False;
    end;
  end;

end;

procedure TSearchBrickForm.FirmwareClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TSearchBrickForm.SetFirmwareType(ft: TFirmwareType);
begin
  case ft of
    ftBrickOS : radBrickOS.Checked := True;
    ftPBForth : radPBForth.Checked := True;
    ftLeJOS   : radLejos.Checked   := True;
    ftLinux   : radLinux.Checked   := True;
    ftOther   : radOtherFirmware.Checked := True;
  else
    // assume standard
    radStandard.Checked := True;
  end;
end;

function TSearchBrickForm.GetFirmwareType: TFirmwareType;
begin
  if radBrickOS.Checked then
    Result := ftBrickOS
  else if radPBForth.Checked then
    Result := ftPBForth
  else if radLejos.Checked then
    Result := ftLeJOS
  else if radLinux.Checked then
    Result := ftLinux
  else if radOtherFirmware.Checked then
    Result := ftOther
  else
    Result := ftStandard;
end;

procedure TSearchBrickForm.BrictypeClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TSearchBrickForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TSearchBrickForm.FormCreate(Sender: TObject);
begin
  if not FileExists(GetInitFilename) then
    DoCreateInitFile;
  PopulatePortsList;
  SizeComboboxDropdown(cboPort);
  cboPort.Text := 'usb';
end;

function TSearchBrickForm.GetUseBT: boolean;
begin

  Result := chkUseBluetooth.Checked;
end;

procedure TSearchBrickForm.SetUseBT(const Value: boolean);
begin
  chkUseBluetooth.Checked := Value;
end;

procedure TSearchBrickForm.PopulatePortsList;
var
  i : integer;
  bt : integer;
begin
  bt := GetBrickType;
  cboPort.Items.Clear;
  cboPort.Items.Add('Automatic');
  cboPort.Items.Add('Search');
  if bt in [SU_RCX, SU_SCOUT, SU_RCX2, SU_NXT, SU_EV3] then
    cboPort.Items.Add('usb');
  if bt in [SU_NXT, SU_EV3] then
    LoadKnownPorts(cboPort.Items);
  if not (bt in [SU_NXT, SU_EV3]) then
  begin
    for i := 1 to 8 do
      cboPort.Items.Add('COM'+IntToStr(i));
  end;
end;

procedure TSearchBrickForm.DoCreateInitFile;
var
  F : TfrmSearchNXT;
  T : TUpdaterThread;
  h : THandle;
  oldbt : integer;
  tick : Cardinal;
begin
  oldbt := LocalBrickType;
  try
    // must set the brick type before the first call to BrickComm
    // in order to get an NXT version rather than an RCX version
    LocalBrickType := rtNXT;
    F := TfrmSearchNXT.Create(nil);
    try
      F.Text := S_SEARCHING_NXT;
      F.Show;
      T :=  TUpdaterThread.Create(BrickComm.InitializeResourceNames);
      h := T.Handle;
      T.Resume;
      tick := GetTickCount;
      while WaitForSingleObject(h, 20) = WAIT_TIMEOUT do
      begin
        Application.ProcessMessages;
        if (GetTickCount - tick) > CREATEINIT_TIMEOUT then
        begin
          if Assigned(T) then
            T.Terminate;
          break;
        end;
      end;
      F.Done;
    finally
      F.Free;
    end;
  finally
    ReleaseBrickComm;
    LocalBrickType := oldbt;
  end;
end;

procedure TSearchBrickForm.DoUpdateInitFile;
var
  F : TfrmSearchNXT;
  T : TUpdaterThread;
  h : THandle;
  tick : Cardinal;
begin
  F := TfrmSearchNXT.Create(nil);
  try
    F.Text := S_SEARCHING_NXT;
    F.Show;
    BrickComm.BrickType := rtNXT;
    T :=  TUpdaterThread.Create(BrickComm.UpdateResourceNames);
    h := T.Handle;
    T.Resume;
    tick := GetTickCount;
    while WaitForSingleObject(h, 20) = WAIT_TIMEOUT do
    begin
      Application.ProcessMessages;
      if (GetTickCount - tick) > UPDATEINIT_TIMEOUT then
      begin
        if Assigned(T) then
          T.Terminate;
        break;
      end;
    end;
    F.Done;
  finally
    F.Free;
  end;
end;

procedure TSearchBrickForm.DoAutomaticPorts;
var
  F : TfrmSearchNXT;
  T : TUpdaterThread;
  h : THandle;
  tick : Cardinal;
begin
  F := TfrmSearchNXT.Create(nil);
  try
    F.Text := S_SEARCHING_BRICK;
    F.Show;
    BrickComm.BrickType := rtNXT;
    T :=  TUpdaterThread.Create(Self.SearchAllPorts);
    h := T.Handle;
    T.Resume;
    tick := GetTickCount;
    while WaitForSingleObject(h, 20) = WAIT_TIMEOUT do begin
      Application.ProcessMessages;
      if (GetTickCount - tick) > AUTOPORTS_TIMEOUT then
      begin
        if Assigned(T) then
          T.Terminate;
        break;
      end;
    end;
    F.Done;
  finally
    F.Free;
  end;
end;

function TSearchBrickForm.SearchAllPorts : boolean;
var
  SL : TStringList;
  i : integer;
begin
  Result := False;
  if IsNXT or IsEV3 then // don't try bricks.dat entries for a non-NXT/EV3 brick type
  begin
    // first try brick resource strings from the bricks.dat file
    SL := TStringList.Create;
    try
      LoadKnownPorts(SL);
      for i := 0 to SL.Count - 1 do
      begin
        BrickComm.Port := SL[i];
        if BrickComm.TowerExists then
        begin
          IRexists  := True;
          LocalPort := BrickComm.Port;
          Result := True;
          break;
        end;
      end;
    finally
      SL.Free;
    end;
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
      Result := True;
    end;
  end;
  if not IsNXT then // don't try COMn ports for an NXT brick type
  begin
    if not IRexists then
    begin
      for i := 1 to 8 do
      begin
        BrickComm.Port := 'COM'+IntToStr(i);
        if BrickComm.TowerExists then
        begin
          IRexists  := True;
          LocalPort := BrickComm.Port;
          Result := True;
          break;
        end;
      end;
    end;
  end;
end;

procedure TSearchBrickForm.cboBrickTypeChange(Sender: TObject);
begin
  PopulatePortsList;
  UpdateControls;
end;

{$IFDEF FPC}
initialization
  {$i SearchRCX.lrs}
{$ENDIF}

end.