unit Diagnose;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, ExtCtrls, Menus, uOfficeComp, uSpin;

type
  TDiagForm = class(TForm)
    grpInfo: TGroupBox;
    lblAlive: TLabel;
    Alive: TPanel;
    lblVersion: TLabel;
    Version: TPanel;
    lblBattery: TLabel;
    RefreshBtn: TButton;
    lblPort: TLabel;
    Port: TPanel;
    IRGroup: TGroupBox;
    IRShort: TRadioButton;
    IRLong: TRadioButton;
    lblProgram: TLabel;
    ProgramNumb: TPanel;
    WatchGroup: TGroupBox;
    lblTime: TLabel;
    CurrentBtn: TButton;
    Watch: TPanel;
    DisplayGroup: TGroupBox;
    DisplayType: TComboBox;
    PowerGroup: TGroupBox;
    lblMinutes: TLabel;
    BatStatus: TPanel;
    lblPrecision: TLabel;
    lblSource: TLabel;
    lblValue: TLabel;
    btnUpdateDisplay: TButton;
    cboPrecision: TComboBox;
    cboSource: TComboBox;
    udValue: TUpDown;
    edtValue: TEdit;
    btnHelp: TButton;
    grpNXTDiag: TGroupBox;
    Label1: TLabel;
    NXTName: TPanel;
    Label2: TLabel;
    BTAddress: TPanel;
    Label3: TLabel;
    BTSignal: TPanel;
    Label4: TLabel;
    FreeMemory: TPanel;
    btnRefreshNXT: TButton;
    PowerDown: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure RefreshBtnClick(Sender: TObject);
    procedure IRShortClick(Sender: TObject);
    procedure IRLongClick(Sender: TObject);
    procedure CurrentBtnClick(Sender: TObject);
    procedure DisplayTypeChange(Sender: TObject);
    procedure PowerDownChange(Sender: TObject);
    procedure btnUpdateDisplayClick(Sender: TObject);
    procedure cboSourceChange(Sender: TObject);
    procedure edtValueExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure btnHelpClick(Sender: TObject);
    procedure btnRefreshNXTClick(Sender: TObject);
  private
    { Private declarations }
    procedure InitForm;
    procedure InitDisplay;
    procedure AdjustFormSize;
    procedure MakeDisplayOptionsVisible(bVis : Boolean);
    procedure AdjustRangeOfValueSlider(source : Integer);
    function GetSourceIndex : Integer;
  public
    { Public declarations }
  end;

var
  DiagForm: TDiagForm;

implementation

{$R *.DFM}

uses
  Preferences, SearchRCX, rcx_constants, uSources, uMiscDefines,
  uSpirit, brick_common, uCommonUtils, uLocalizedStrings;

var
  V_FUDGE, V_HEIGHT, V_DISPLAY_HEIGHT, V_DISPLAY_DELTA, V_HELP : Integer;

const
  K_FUDGE = 2;
  K_HEIGHT = 492;
  K_HELP   = 28;
  carray : array[0..8] of string = (
    sWatch, sInput1, sInput2, sInput3, sOutputA, sOutputB,
    sOutputC, sUserSelect, sExceptions);
  K_DEFAULT_WATCH   = '00:00';
  K_DEFAULT_CAPTION = '---';
  K_USER_SELECT     = 7;
  K_DISPLAY_DELTA   = 58;
  K_DISPLAY_HEIGHT  = 106;

procedure TDiagForm.FormShow(Sender: TObject);
var
  c : TCursor;
begin
  c := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    InitForm;
  finally
    Screen.Cursor := c;
  end;
end;

procedure TDiagForm.RefreshBtnClick(Sender: TObject);
var
  c : TCursor;
  w : integer;
  rom, ram, time : Cardinal;
  name : string;
begin
  c := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    Port.Caption  := BrickComm.NicePortName;
    if BrickComm.BrickAlive then
    begin
      Alive.Caption := sRCXAlive;
      try
        BatStatus.Caption := Format('%d mV',[BrickComm.BatteryLevel]);
      except
        BatStatus.Caption := K_DEFAULT_CAPTION;
      end;
      BrickComm.Version(rom, ram);
//      Version.Caption := Format('%8.8x/%8.8x', [rom, ram]);
      Version.Caption := Format('%d%d.%d%d / %d%d.%d%d',
                                [(rom and $FF000000) shr 24,
                                 (rom and $00FF0000) shr 16,
                                 (rom and $0000FF00) shr 8,
                                 (rom and $000000FF),
                                 (ram and $FF000000) shr 24,
                                 (ram and $00FF0000) shr 16,
                                 (ram and $0000FF00) shr 8,
                                 (ram and $000000FF)]);
      if IsRCX then
      begin
        try
          ProgramNumb.Caption := Format('%d',[1+BrickComm.Poll(kRCX_ProgramSlotType,0)]);
        except
          ProgramNumb.Caption := K_DEFAULT_CAPTION;
        end;
        try
          w := BrickComm.Poll(kRCX_WatchType,0);
          Watch.Caption := Format('%2.2d:%2.2d',[w div 60,w mod 60]);
        except
          Watch.Caption := K_DEFAULT_WATCH;
        end;
      end
      else if IsNXT then
      begin
        if BrickComm.GetCurrentProgramName(name) then
          ProgramNumb.Caption := name;
        if BrickComm.KeepAlive(time, True) then
        begin
          time := time div 60 div 1000; // convert to minutes
          PowerDown.SilentValue := time;
        end;
      end
      else begin
        ProgramNumb.Caption := K_DEFAULT_CAPTION;
        Watch.Caption := K_DEFAULT_CAPTION;
      end;
    end else begin
      Alive.Caption       := sRCXDead;
      BatStatus.Caption   := K_DEFAULT_CAPTION;
      Version.Caption     := K_DEFAULT_CAPTION;
      ProgramNumb.Caption := K_DEFAULT_CAPTION;
      Watch.Caption       := K_DEFAULT_WATCH;
    end;
  finally
    Screen.Cursor := c;
  end;
end;

procedure TDiagForm.IRShortClick(Sender: TObject);
begin
  BrickComm.TransmitPower(tlNear);
end;

procedure TDiagForm.IRLongClick(Sender: TObject);
begin
  BrickComm.TransmitPower(tlFar);
end;

procedure TDiagForm.CurrentBtnClick(Sender: TObject);
var
  Hour, Min, Sec, MSec: Word;
begin
  DecodeTime(Now, Hour, Min, Sec, MSec);
  Watch.Caption:= Format('%2.2d:%2.2d',[Hour,Min]);
  BrickComm.SetWatchHHMM(Hour, Min);
end;

procedure TDiagForm.DisplayTypeChange(Sender: TObject);
begin
  MakeDisplayOptionsVisible(DisplayType.ItemIndex = K_USER_SELECT);
  BrickComm.SelectDisplay(kRCX_ConstantType, DisplayType.ItemIndex);
end;

procedure TDiagForm.PowerDownChange(Sender: TObject);
begin
  BrickComm.PowerDownTime(PowerDown.Value);
end;

procedure TDiagForm.InitForm;
begin
  InitDisplay;
  DisplayGroup.Visible := IsRCX;
  WatchGroup.Visible := IsRCX;
  IRGroup.Visible := IsRCX or IsScout;
  grpNXTDiag.Visible := IsNXT;
  MakeDisplayOptionsVisible(False);
  AdjustFormSize;
  RefreshBtnClick(Self);
  if IsRCX or IsScout then
  begin
    if IRShort.Checked then
    begin
      BrickComm.TransmitPower(tlNear);
    end
    else
    begin
      BrickComm.TransmitPower(tlFar);
    end;
  end;
end;

procedure TDiagForm.AdjustFormSize;
begin
  if IsRCX then
  begin
    if DisplayGroup.Height = V_DISPLAY_HEIGHT then
      Height := V_HEIGHT
    else
      Height := V_HEIGHT - V_DISPLAY_DELTA;
  end
  else if IsScout then
  begin
    Height := WatchGroup.Top + GetSystemMetrics(SM_CYCAPTION) + V_FUDGE + V_HELP;
  end
  else if IsNXT then
  begin
    Height := grpNXTDiag.Top + grpNXTDiag.Height + 7 +
              GetSystemMetrics(SM_CYCAPTION) + V_FUDGE + V_HELP;
  end
  else
  begin
    Height := IRGroup.Top + GetSystemMetrics(SM_CYCAPTION) + V_FUDGE + V_HELP;
  end;
end;

procedure TDiagForm.MakeDisplayOptionsVisible(bVis: Boolean);
begin
  lblValue.Visible         := bVis;
  edtValue.Visible         := bVis;
  lblSource.Visible        := bVis;
  cboSource.Visible        := bVis;
  lblPrecision.Visible     := bVis;
  cboPrecision.Visible     := bVis;
  btnUpdateDisplay.Visible := bVis;
  if bVis then begin
    DisplayGroup.Height    := V_DISPLAY_HEIGHT;
    cboPrecision.ItemIndex := 0;
    cboSource.ItemIndex    := 0;
    AdjustRangeOfValueSlider(0);
  end
  else
    DisplayGroup.Height := V_DISPLAY_HEIGHT - V_DISPLAY_DELTA;
  AdjustFormSize;
  Application.ProcessMessages;
end;

procedure TDiagForm.btnUpdateDisplayClick(Sender: TObject);
begin
  BrickComm.ViewSourceValue(cboPrecision.ItemIndex, GetSourceIndex, udValue.Position);
end;

procedure TDiagForm.AdjustRangeOfValueSlider(source: Integer);
var
  WS : WatchSources;
begin
  WS := BrickWatchSources[LocalBrickType];
  udValue.Position := WS[source].VMin;
  udValue.Min      := WS[source].VMin;
  udValue.Max      := WS[source].VMax;
end;

procedure TDiagForm.InitDisplay;
var
  i : integer;
  d : integer;
  WS : WatchSources;
begin
  DisplayType.Items.Clear;
  // only RCX2 can display user sources
  d := 1;
  if IsRCX2 then
    d := 0;
  for i := low(carray) to high(carray) - d do
  begin
    DisplayType.Items.Add(carray[i]);
  end;
  WS := BrickWatchSources[LocalBrickType];
  cboSource.Items.Clear;
  for i := low(WS) to high(WS) do
  begin
    if WS[i].Has then
      cboSource.Items.AddObject(WS[i].Name, TObject(i));
  end;
end;

procedure TDiagForm.cboSourceChange(Sender: TObject);
begin
  AdjustRangeOfValueSlider(GetSourceIndex);
end;

procedure TDiagForm.edtValueExit(Sender: TObject);
var
  i : Integer;
begin
  // make sure text is valid
  i := StrToIntDef(edtValue.Text, -10000);
  if i > udValue.Max then
    udValue.Position := udValue.Max
  else if i < udValue.Min then
    udValue.Position := udValue.Min;
  edtValue.Text := IntToStr(udValue.Position);
end;

procedure TDiagForm.FormCreate(Sender: TObject);
var
  scale_amount : double;
begin
  scale_amount     := Screen.PixelsPerInch / 96;
  V_HEIGHT         := Trunc(K_HEIGHT * scale_amount);
  V_DISPLAY_HEIGHT := Trunc(K_DISPLAY_HEIGHT * scale_amount);
  V_DISPLAY_DELTA  := Trunc(K_DISPLAY_DELTA * scale_amount);
  V_FUDGE          := Trunc(K_FUDGE * scale_amount);
  V_HELP           := Trunc(K_HELP * scale_amount);
end;

procedure TDiagForm.edtValueKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, #16, '0'..'9']) then
    Key := #0;
end;

function TDiagForm.GetSourceIndex: Integer;
begin
  Result := Integer(cboSource.Items.Objects[cboSource.ItemIndex]);
end;

procedure TDiagForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TDiagForm.btnRefreshNXTClick(Sender: TObject);
var
  btaddr : array[0..5] of Byte;
  btsig : cardinal;
  memFree : Cardinal;
  bname : string;
begin
  if BrickComm.NXTGetDeviceInfo(bname, @btaddr[0], btsig, memFree) then
  begin
    NXTName.Caption   := bname;
    BTAddress.Caption := Format('%2.2x:%2.2x:%2.2x:%2.2x:%2.2x:%2.2x',
      [btaddr[0], btaddr[1], btaddr[2], btaddr[3], btaddr[4], btaddr[5]]);
    BTSignal.Caption  := Format('%d,%d,%d,%d', [GetByte(btsig, 0),
       GetByte(btsig, 1), GetByte(btsig, 2), GetByte(btsig, 3)]);
    FreeMemory.Caption := IntToStr(memFree);
  end;
end;

end.
