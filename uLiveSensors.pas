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
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uLiveSensors;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LResources,
  LCLType,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls, Buttons, Menus, ImgList, ComCtrls,
  ActnList, ExtCtrls, Contnrs, uOfficeComp, uDeviceTypeImages;

type
  TTypeMode = record
    iType : byte;
    iMode : byte;
    iFigures : byte;
    iDecimals : byte;
  end;
  TfrmLiveSensors = class(TForm)
    tmrRefresh: TTimer;
    pagDevices: TPageControl;
    shtLayer1: TTabSheet;
    shtLayer2: TTabSheet;
    shtLayer3: TTabSheet;
    shtLayer4: TTabSheet;
    actMain: TActionList;
    act100ms: TAction;
    act200ms: TAction;
    act500ms: TAction;
    act1sec: TAction;
    act2sec: TAction;
    act5sec: TAction;
    act10sec: TAction;
    actPollNow: TAction;
    actPolling: TAction;
    actMode0: TAction;
    actMode1: TAction;
    actMode2: TAction;
    actMode3: TAction;
    actMode4: TAction;
    actMode5: TAction;
    actMode6: TAction;
    actMode7: TAction;
    procedure FormCreate(Sender: TObject);
    procedure btnOutputClick(Sender: TObject);
    procedure btnInputClick(Sender: TObject);
    procedure btnInputDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnOutputDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmrRefreshTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actPollNowExecute(Sender: TObject);
    procedure actPollingExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure actSensorModeExecute(Sender: TObject);
  private
    { Private declarations }
    fNumLayers : integer;
    fBusy : boolean;
    fButtons : array of TSpeedButton;
    fLabels  : array of TLabel;
    fEdits   : array of TEdit;
    fTypeModes : array of TTypeMode;
    fValues : array of Single;
    fActivePort : byte;
    procedure CreateSheetComponents;
    procedure RefreshSensorData;
    procedure LoadActionList;
    procedure UpdateSensorButtons;
    procedure UpdateSensorValues;
    procedure RefreshRateClick(Sender: TObject);
    procedure SensorModeClick(Sender: TObject);
    procedure HandleOnPopup(Sender: TObject);
    function GetActivePort: Byte;
    function GetPortFromButton(aSB : TSpeedButton; bOutput : boolean) : byte;
  private
    pmuMain: TOfficePopupMenu;
    mniPollNow: TOfficeMenuItem;
    mniPoll: TOfficeMenuItem;
    mniRefreshRate: TOfficeMenuItem;
    mni100ms: TOfficeMenuItem;
    mni200ms: TOfficeMenuItem;
    mni500ms: TOfficeMenuItem;
    mni1sec: TOfficeMenuItem;
    mni2sec: TOfficeMenuItem;
    mni5sec: TOfficeMenuItem;
    mni10sec: TOfficeMenuItem;
    mniSensorModes: TOfficeMenuItem;
    mniMode0: TOfficeMenuItem;
    mniMode1: TOfficeMenuItem;
    mniMode2: TOfficeMenuItem;
    mniMode3: TOfficeMenuItem;
    mniMode4: TOfficeMenuItem;
    mniMode5: TOfficeMenuItem;
    mniMode6: TOfficeMenuItem;
    mniMode7: TOfficeMenuItem;
    procedure CreatePopupMenu;
  protected
    fActions : TStringList;
    function FindAction(aType : byte) : TAction;
  public
    { Public declarations }
    property ActivePort : Byte read GetActivePort;
  end;

var
  frmLiveSensors: TfrmLiveSensors;

implementation

{$R *.dfm}

uses
  SysUtils, Math, brick_common, uSpirit, uLocalizedStrings, uLiveSensorGlobals,
  uGuiUtils, uGlobals;

procedure TfrmLiveSensors.CreateSheetComponents;
var
  i, j : integer;
  b : TSpeedButton;
  l : TLabel;
  e : TEdit;
  x : integer;
begin
  x := 0;
  for i := 0 to 3 do
  begin
    for j := 0 to 3 do
    begin
      // inputs
      b := TSpeedButton.Create(self);
      fButtons[x] := b;
      with b do
      begin
        Name := Format('btn_%d_%d', [i, j]);;
        Parent := pagDevices.Pages[i];
        Left := 8 + (74 * j);
        Top := 139;
        Width := 68;
        Height := 68;
        AllowAllUp := True;
        Flat := True;
        ShowHint := True;
        Tag := i*4+j;
//        PopupMenu := pmuMain;
        OnClick := btnInputClick;
        OnMouseDown := btnInputDown;
      end;
      l := TLabel.Create(self);
      fLabels[x] := l;
      with l do
      begin
        Name := Format('lbl_%d_%d', [i, j]);
        Parent := pagDevices.Pages[i];
        Left := 8 + (74 * j);
        Top := 118;
        Width := 9;
        Height := 16;
        Caption := IntToStr(j);
        ParentFont := False;
      end;
      e := TEdit.Create(self);
      fEdits[x] := e;
      with e do
      begin
        Name := Format('edt_%d_%d', [i, j]);
        Parent := pagDevices.Pages[i];
        Left := 26 + (74 * j);
        Top := 116;
        Width := 49;
        Height := 21;
        ReadOnly := True;
        Text := '';
        TabOrder := 4+x;
      end;
      inc(x);
    end;
    for j := 0 to 3 do
    begin
      // outputs
      b := TSpeedButton.Create(self);
      fButtons[x] := b;
      with b do
      begin
        Name := Format('btn_%d_%s', [i, Chr(65+j)]);
        Parent := pagDevices.Pages[i];
        Left := 8 + (74 * j);
        Top := 43;
        Width := 68;
        Height := 68;
        AllowAllUp := True;
        Flat := True;
        ShowHint := True;
        Tag := 16+i*4+j;
//        PopupMenu := pmuMain;
        OnClick := btnOutputClick;
        OnMouseDown := btnOutputDown;
      end;
      l := TLabel.Create(self);
      fLabels[x] := l;
      with l do
      begin
        Name := Format('lbl_%d_%s', [i, Char(65+j)]);
        Parent := pagDevices.Pages[i];
        Left := 8 + (74 * j);
        Top := 22;
        Width := 11;
        Height := 16;
        Caption := Chr(65+j);
        ParentFont := False;
      end;
      e := TEdit.Create(self);
      fEdits[x] := e;
      with e do
      begin
        Name := Format('edt_%d_%s', [i, Char(65+j)]);;
        Parent := pagDevices.Pages[i];
        Left := 26 + (74 * j);
        Top := 20;
        Width := 49;
        Height := 21;
        ReadOnly := True;
        Text := '';
        TabOrder := x-4;
      end;
      inc(x);
    end;
  end;
end;

procedure TfrmLiveSensors.FormCreate(Sender: TObject);
begin
  fNumLayers := 4;
  fBusy := False;
  CreatePopupMenu;
  Self.PopupMenu := pmuMain;
  pagDevices.PopupMenu := pmuMain;
  shtLayer1.PopupMenu := pmuMain;
  shtLayer2.PopupMenu := pmuMain;
  shtLayer3.PopupMenu := pmuMain;
  shtLayer4.PopupMenu := pmuMain;
  SetLength(fButtons, 32);
  SetLength(fLabels, 32);
  SetLength(fEdits, 32);
  SetLength(fTypeModes, 32);
  SetLength(fValues, 32);
  fActions := TStringList.Create;
  fActions.Sorted := True;
  fActions.Duplicates := dupIgnore;
  CreateSheetComponents;
  LoadActionList;
end;

procedure TfrmLiveSensors.btnOutputClick(Sender: TObject);
var
  sb : TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  fActivePort := GetPortFromButton(sb, true);
  pmuMain.Popup(Left + sb.Left+32, Top + sb.Top+32);
end;

procedure TfrmLiveSensors.btnInputClick(Sender: TObject);
var
  sb : TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  fActivePort := GetPortFromButton(sb, false);
  pmuMain.Popup(Left + sb.Left+32, Top + sb.Top+32);
end;

procedure TfrmLiveSensors.btnInputDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sb : TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  fActivePort := GetPortFromButton(sb, false);
  if Button = mbRight then
    pmuMain.Popup(Left + sb.Left+32, Top + sb.Top+32);
end;

procedure TfrmLiveSensors.btnOutputDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sb : TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  fActivePort := GetPortFromButton(sb, true);
  if Button = mbRight then
    pmuMain.Popup(Left + sb.Left+32, Top + sb.Top+32);
end;

procedure TfrmLiveSensors.tmrRefreshTimer(Sender: TObject);
begin
  if not fBusy and Visible and (WindowState <> wsMinimized) then
    RefreshSensorData;
end;

procedure TfrmLiveSensors.RefreshSensorData;
var
  data : EEPROMBlock;
  i : integer;
  tmp : Single;
begin
  fBusy := True;
  try
    data := BrickComm.EEPROMBlocks[0];
    for i := 0 to 31 do
    begin
      fTypeModes[i].iType     := data.Data[i*4+0];
      fTypeModes[i].iMode     := data.Data[i*4+1];
      fTypeModes[i].iFigures  := data.Data[i*4+2];
      fTypeModes[i].iDecimals := data.Data[i*4+3];
    end;
    UpdateSensorButtons;
    // now get values
    data := BrickComm.EEPROMBlocks[1];
    for i := 0 to 31 do
    begin
      Move(data.Data[i*4], tmp, 4);
      fValues[i] := tmp;
    end;
    UpdateSensorValues;
  finally
    fBusy := False;
  end;
end;

procedure TfrmLiveSensors.FormShow(Sender: TObject);
var
  i : integer;
begin
  if IsEV3 then
    fNumLayers := 4
  else
    fNumLayers := 1;
  for i := 0 to 3 do
    pagDevices.Pages[i].TabVisible := ((i = 0) or False);
  tmrRefresh.Interval := LiveSensorDefaultRefreshRate;
  fActivePort := $FF;
end;

procedure TfrmLiveSensors.FormDestroy(Sender: TObject);
begin
  SetLength(fButtons, 0);
  SetLength(fLabels, 0);
  SetLength(fEdits, 0);
  SetLength(fTypeModes, 0);
  SetLength(fValues, 0);
  FreeAndNil(fActions);
end;

procedure TfrmLiveSensors.LoadActionList;
var
  i : integer;
  tmpAct : TAction;
begin
  fActions.Clear;
  for i := 0 to dmDevTypeImg.actList.ActionCount - 1 do
  begin
    tmpAct := TAction(dmDevTypeImg.actlist.Actions[i]);
    fActions.AddObject(Format('%3.3d', [tmpAct.ImageIndex]), tmpAct);
  end;
end;

procedure TfrmLiveSensors.UpdateSensorButtons;
var
  i, j : integer;
  a : TAction;
  itm : TTypeMode;
  b : TSpeedButton;
  bVisible : boolean;
begin
  for i := 0 to fNumLayers - 1 do
  begin
    bVisible := (i = 0);
    for j := 0 to 7 do
    begin
      b := fButtons[i*8+j];
      itm := fTypeModes[i*8+j];
      a := FindAction(itm.iType);
      if b.Tag <> a.ImageIndex then
      begin
        b.Tag := a.ImageIndex;
        b.Glyph := nil;
        dmDevTypeImg.imgDevType64.GetBitmap(a.ImageIndex, b.Glyph);
        b.Hint := a.Hint;
      end;
      // if any of the actions are something other than actNone
      // then the tab needs to be visible
      bVisible := bVisible or (a <> dmDevTypeImg.actNone);
    end;
    pagDevices.Pages[i].TabVisible := bVisible;
  end;
end;

procedure TfrmLiveSensors.UpdateSensorValues;
var
  i : integer;
  itm : TTypeMode;
  val : single;
begin
  for i := 0 to 31 do
  begin
    itm := fTypeModes[i];
    val := fValues[i];
    if IsNan(val) then
      fEdits[i].Text := ''
    else
      fEdits[i].Text := Format('%*.*f', [itm.iFigures, itm.iDecimals, val]);
  end;
end;

function TfrmLiveSensors.FindAction(aType: byte): TAction;
var
  idx : integer;
begin
  idx := fActions.IndexOf(Format('%3.3d', [aType]));
  if idx <> -1 then
    Result := TAction(fActions.Objects[idx])
  else
    Result := dmDevTypeImg.actNone;
end;

procedure TfrmLiveSensors.CreatePopupMenu;
begin
  pmuMain := TOfficePopupMenu.Create(Self);
  pmuMain.Name := 'pmuMain';
  pmuMain.OnPopup := HandleOnPopup;
  mniPollNow := TOfficeMenuItem.Create(pmuMain);
  mniPoll := TOfficeMenuItem.Create(pmuMain);
  mniRefreshRate := TOfficeMenuItem.Create(pmuMain);
  mni100ms := TOfficeMenuItem.Create(mniRefreshRate);
  mni200ms := TOfficeMenuItem.Create(mniRefreshRate);
  mni500ms := TOfficeMenuItem.Create(mniRefreshRate);
  mni1sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni2sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni5sec := TOfficeMenuItem.Create(mniRefreshRate);
  mni10sec := TOfficeMenuItem.Create(mniRefreshRate);
  mniSensorModes := TOfficeMenuItem.Create(pmuMain);
  mniMode0 := TOfficeMenuItem.Create(mniSensorModes);
  mniMode1 := TOfficeMenuItem.Create(mniSensorModes);
  mniMode2 := TOfficeMenuItem.Create(mniSensorModes);
  mniMode3 := TOfficeMenuItem.Create(mniSensorModes);
  mniMode4 := TOfficeMenuItem.Create(mniSensorModes);
  mniMode5 := TOfficeMenuItem.Create(mniSensorModes);
  mniMode6 := TOfficeMenuItem.Create(mniSensorModes);
  mniMode7 := TOfficeMenuItem.Create(mniSensorModes);
  with mniPollNow do
  begin
    Name := 'mniPollNow';
    Action := actPollNow;
  end;
  with mniPoll do
  begin
    Name := 'mniPoll';
    Action := actPolling;
  end;
  with mniRefreshRate do
  begin
    Name := 'mniRefreshRate';
    Caption := sRefreshRate;
    OnClick := RefreshRateClick;
  end;
  with mni100ms do
  begin
    Name := 'mni100ms';
    Tag := 100;
    Action := act100ms;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni200ms do
  begin
    Name := 'mni200ms';
    Tag := 200;
    Action := act200ms;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni500ms do
  begin
    Name := 'mni500ms';
    Tag := 500;
    Action := act500ms;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni1sec do
  begin
    Name := 'mni1sec';
    Tag := 1000;
    Action := act1sec;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni2sec do
  begin
    Name := 'mni2sec';
    Tag := 20;
    Action := act2sec;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni5sec do
  begin
    Name := 'mni5sec';
    Tag := 30;
    Action := act5sec;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mni10sec do
  begin
    Name := 'mni10sec';
    Tag := 10000;
    Action := act10sec;
    GroupIndex := 2;
    RadioItem := True;
  end;
  with mniSensorModes do
  begin
    Name := 'mniSensorModes';
    Caption := 'Sensor Mode';
    OnClick := SensorModeClick;
  end;
  with mniMode0 do
  begin
    Name := 'mniMode0';
    Tag := 0;
    Action := actMode0;
    GroupIndex := 3;
    RadioItem := True;
  end;
  with mniMode1 do
  begin
    Name := 'mniMode1';
    Tag := 1;
    Action := actMode1;
    GroupIndex := 3;
    RadioItem := True;
  end;
  with mniMode2 do
  begin
    Name := 'mniMode2';
    Tag := 2;
    Action := actMode2;
    GroupIndex := 3;
    RadioItem := True;
  end;
  with mniMode3 do
  begin
    Name := 'mniMode3';
    Tag := 3;
    Action := actMode3;
    GroupIndex := 3;
    RadioItem := True;
  end;
  with mniMode4 do
  begin
    Name := 'mniMode4';
    Tag := 4;
    Action := actMode4;
    GroupIndex := 3;
    RadioItem := True;
  end;
  with mniMode5 do
  begin
    Name := 'mniMode5';
    Tag := 5;
    Action := actMode5;
    GroupIndex := 3;
    RadioItem := True;
  end;
  with mniMode6 do
  begin
    Name := 'mniMode6';
    Tag := 6;
    Action := actMode6;
    GroupIndex := 3;
    RadioItem := True;
  end;
  with mniMode7 do
  begin
    Name := 'mniMode7';
    Tag := 7;
    Action := actMode7;
    GroupIndex := 3;
    RadioItem := True;
  end;
  AddMenuItems(pmuMain.Items, [mniPollNow, mniPoll, mniRefreshRate, mniSensorModes]);
  AddMenuItems(mniRefreshRate, [mni100ms, mni200ms, mni500ms, mni1sec, mni2sec, mni5sec, mni10sec]);
  AddMenuItems(mniSensorModes, [mniMode0, mniMode1, mniMode2, mniMode3, mniMode4, mniMode5, mniMode6, mniMode7]);
end;

procedure TfrmLiveSensors.RefreshRateClick(Sender: TObject);
var
  i : integer;
  M : TOfficeMenuItem;
begin
  for i := 0 to mniRefreshRate.Count - 1 do
  begin
    M := TOfficeMenuItem(mniRefreshRate.Items[i]);
    M.Checked := M.Tag = LiveSensorDefaultRefreshRate;
  end;
end;

procedure TfrmLiveSensors.SensorModeClick(Sender: TObject);
var
  i : integer;
  M : TOfficeMenuItem;
begin
  for i := 0 to mniSensorModes.Count - 1 do
  begin
    M := TOfficeMenuItem(mniSensorModes.Items[i]);
  end;
end;

procedure TfrmLiveSensors.actPollNowExecute(Sender: TObject);
begin
  tmrRefreshTimer(Sender);
end;

procedure TfrmLiveSensors.actPollingExecute(Sender: TObject);
begin
  actPolling.Checked := not actPolling.Checked;
  tmrRefresh.Enabled := actPolling.Checked;
end;

procedure TfrmLiveSensors.actRefreshExecute(Sender: TObject);
begin
  if Sender is TAction then
    TAction(Sender).Checked := True
  else if Sender is TOfficeMenuItem then
    TOfficeMenuItem(Sender).Checked := True;
  LiveSensorDefaultRefreshRate := TControl(Sender).Tag;
  tmrRefresh.Interval := LiveSensorDefaultRefreshRate;
end;

procedure TfrmLiveSensors.actSensorModeExecute(Sender: TObject);
begin
  if Sender is TAction then
    TAction(Sender).Checked := True
  else if Sender is TOfficeMenuItem then
    TOfficeMenuItem(Sender).Checked := True;
  BrickComm.SetSensorMode(ActivePort, TControl(Sender).Tag, 0);
  fActivePort := $FF;
end;

function TfrmLiveSensors.GetActivePort: Byte;
begin
  Result := fActivePort;
end;

procedure TfrmLiveSensors.HandleOnPopup(Sender: TObject);
begin
  mniSensorModes.Visible := ActivePort <> $FF;
end;

function TfrmLiveSensors.GetPortFromButton(aSB: TSpeedButton; bOutput : boolean): byte;
var
  layer : byte;
  tmp : integer;
begin
  Result := 0;
  if bOutput then
    Result := 16;
  layer := 0;
  if aSB.Parent = shtLayer2 then
    layer := 1
  else if aSB.Parent = shtLayer3 then
    layer := 2
  else if aSB.Parent = shtLayer4 then
    layer := 3;
  tmp := aSB.Left;
  Result := Result + (layer * 4) + (tmp div 74);
end;

end.
