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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uNewWatch;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  DataAnalysis,
{$ELSE}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls, ExtCtrls, Buttons, ComCtrls;

type
  TVarControls = record
    CheckBox : TCheckBox;
    Edit : TEdit;
  end;

  TfrmNewWatch = class(TForm)
    btnPollNow: TButton;
    btnCheckAll: TButton;
    btnCheckNone: TButton;
    btnPollRegular: TSpeedButton;
    TimeBox: TComboBox;
    Timer1: TTimer;
    btnGraph: TSpeedButton;
    chkIfActive: TCheckBox;
    chkSyncSeries: TCheckBox;
    lblSource: TLabel;
    cboSource: TComboBox;
    lblValue: TLabel;
    edtValue: TEdit;
    udValue: TUpDown;
    btnAddWatch: TButton;
    pagMain: TPageControl;
    btnRemoveWatch: TButton;
    btnClear: TButton;
    btnHelp: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPollNowClick(Sender: TObject);
    procedure btnCheckAllClick(Sender: TObject);
    procedure btnCheckNoneClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure btnPollRegularClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimeBoxChange(Sender: TObject);
    procedure btnGraphClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure btnAddWatchClick(Sender: TObject);
    procedure cboSourceChange(Sender: TObject);
    procedure btnRemoveWatchClick(Sender: TObject);
    procedure edtValueExit(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure btnClearClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
{$IFNDEF FPC}
    fGraph : TfrmDataAnalysis;
{$ENDIF}
    fNewData : TStrings;
    fWatchCount : Integer;
    procedure UpdateGraph;
    procedure AdjustRangeOfValueSlider(source : Integer);
    procedure InitSources;
    function GetSourceIndex: Integer;
    procedure UpdateControls;
    procedure AddVariableHint(sht : TTabsheet; i : integer);
    procedure PopulateVariables(cbo : TCombobox);
    procedure cboNXTVarChange(Sender: TObject);
  public
    { Public declarations }
    procedure GraphDestroyed;
  end;

var
  frmNewWatch: TfrmNewWatch;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, Graphics, Dialogs, uBasicPrefs, uMiscDefines,
  brick_common, rcx_constants, uSources, uLocalizedStrings, uCommonUtils,
  uProgram, uGlobals, Variants;

var
  busy : boolean = false;

procedure TfrmNewWatch.btnPollNowClick(Sender: TObject);
var
  i, ival : integer;
  val : variant;
  fval : Single;
  tmpStr, tmpStr2 : string;
  temp: TComponent;
  idx, src, num : Integer;
  procedure FormatIntegerValue;
  begin
    ival := val;
    tmpStr  := Format(BrickWatchSources[LocalBrickType][idx].Name + '_%3.3d: %d', [num, ival]);
    tmpStr2 := Format('%6d', [ival]);
  end;
begin
  if busy then exit;     // Avoid polling while polling
  busy := true;
  try
    fNewData.Clear;
    for i := ComponentCount - 1 downto 0 do
    begin
      temp := Components[i];
      if (temp is TCheckBox) and TCheckBox(temp).Visible and
         not ((temp = chkIfActive) or (temp = chkSyncSeries)) and
         TCheckBox(temp).Checked then
      begin
        // the sheet this checkbox is on is the source and
        // the checkbox is the value
        idx := Integer(cboSource.Items.Objects[TComboBox(TCheckBox(temp).Parent.Controls[4]).ItemIndex]);
//        idx := TCheckBox(temp).Parent.Tag;
//        src := WatchSources[idx].SourceNum;
        src := idx;
        num := TUpDown(TCheckBox(temp).Parent.Controls[3]).Position;
        val := BrickComm.Poll(src, num);
        if IsNXT and (idx = 0) then begin
          if VarType(val) in [varSingle, varDouble] then begin
            fVal := val;
            tmpStr2 := StripTrailingZeros(Format('%.4f', [fval]));
            tmpStr  := TComboBox(TCheckBox(temp).Parent.Controls[5]).Items[num] + ': ' + tmpStr2;
          end
          else
            FormatIntegerValue;
        end
        else
          FormatIntegerValue;
        fNewData.Add(tmpStr);
        TEdit(TCheckBox(temp).Parent.Controls[1]).Text := tmpStr2;
      end;
    end;
{
    for i := Low(fVarArray) to High(fVarArray) do
    begin
      if fVarArray[i].CheckBox.Checked then
      begin
        val := BrickComm.GetVariableValue(i);
        tmpStr := Format('Var %d: %d', [i, val]);
        fNewData.Add(tmpStr);
        fVarArray[i].Edit.Text := Format('%6d',[val]);
      end;
    end;
}
    UpdateGraph;
    busy := false;
  except
    ShowMessage(sWatchError);
    Timer1.Enabled := false;
    btnPollRegular.Down := false;
    busy := false;
  end;
end;

procedure TfrmNewWatch.btnCheckAllClick(Sender: TObject);
var
  i: Integer;
  temp: TComponent;
begin
  for i := ComponentCount - 1 downto 0 do
  begin
    temp := Components[i];
    if (temp is TCheckBox) and TCheckBox(temp).Visible and
       not ((temp = chkIfActive) or (temp = chkSyncSeries)) then
      TCheckBox(temp).Checked := true;
  end;
end;

procedure TfrmNewWatch.btnCheckNoneClick(Sender: TObject);
var i: Integer;
    temp: TComponent;
begin
  for i := ComponentCount - 1 downto 0 do
  begin
    temp := Components[i];
    if (temp is TCheckBox) then
      TCheckBox(temp).Checked := false;
  end;
end;

procedure TfrmNewWatch.Timer1Timer(Sender: TObject);
begin
  btnPollNowClick(Self);
end;

procedure TfrmNewWatch.btnPollRegularClick(Sender: TObject);
begin
  Timer1.Enabled := btnPollRegular.Down;
end;

procedure TfrmNewWatch.FormShow(Sender: TObject);
begin
  InitSources;
  btnPollRegular.Down := false;
  Timer1.Enabled := false;
  busy := false;
  UpdateControls;
end;

procedure TfrmNewWatch.FormCreate(Sender: TObject);
begin
  fNewData := TStringList.Create;
{$IFNDEF FPC}
  fGraph := nil;
{$ENDIF}
  fWatchCount := 0;
  TimeBox.ItemIndex := 3;
end;

procedure TfrmNewWatch.TimeBoxChange(Sender: TObject);
begin
  case TimeBox.ItemIndex of
    0: Timer1.Interval := 100;
    1: Timer1.Interval := 200;
    2: Timer1.Interval := 500;
    3: Timer1.Interval := 1000;
    4: Timer1.Interval := 2000;
    5: Timer1.Interval := 5000;
    6: Timer1.Interval := 10000;
  end;
end;

procedure TfrmNewWatch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := false;
end;

procedure TfrmNewWatch.btnGraphClick(Sender: TObject);
begin
{$IFNDEF FPC}
  if not btnGraph.Down then
  begin
    // close graph form and nil our pointer
    if Assigned(fGraph) then
    begin
      fGraph.Close;
      fGraph := nil;
    end;
  end
  else
  begin
    // create graph form and show it
    fGraph := TfrmDataAnalysis.Create(Application);
    fGraph.FromNewWatch := True;
    fGraph.WatchPoints  := WatchPoints;
    fGraph.SyncSeries   := chkSyncSeries.Checked;
    fGraph.DataIsXY     := False;
    fGraph.Show;
  end;
{$ENDIF}
end;

procedure TfrmNewWatch.FormDestroy(Sender: TObject);
begin
  fNewData.Free;
end;

procedure TfrmNewWatch.UpdateGraph;
begin
{$IFNDEF FPC}
  if Assigned(fGraph) then
  begin
    fGraph.AddNewData(fNewData);
  end;
{$ENDIF}
end;

procedure TfrmNewWatch.GraphDestroyed;
begin
{$IFNDEF FPC}
  // called by data analysis form when it closes
  if Assigned(fGraph) then
  begin
    fGraph := nil;
    btnGraph.Down := False;
  end;
{$ENDIF}
end;

procedure TfrmNewWatch.FormActivate(Sender: TObject);
begin
  if chkIfActive.Checked then
    Timer1.Enabled := btnPollRegular.Down;
end;

procedure TfrmNewWatch.FormDeactivate(Sender: TObject);
begin
  if chkIfActive.Checked then
    Timer1.Enabled := False;
end;

procedure TfrmNewWatch.btnAddWatchClick(Sender: TObject);
var
  sht: TTabSheet;
  edtWatch: TEdit;
  chkWatch: TCheckBox;
  edtVal: TEdit;
  udVal: TUpDown;
  cboSrc: TComboBox;
  cboNXTVar: TComboBox;
  num : string;
  scale_amount : double;
begin
  scale_amount := Screen.PixelsPerInch / 96;
  Inc(fWatchCount);
  num := Format('%3.3d', [fWatchCount]);
  sht := TTabSheet.Create(Self);
  edtWatch := TEdit.Create(Self);
  chkWatch := TCheckBox.Create(Self);
  edtVal := TEdit.Create(Self);
  udVal := TUpDown.Create(Self);
  cboSrc := TComboBox.Create(Self);
  cboNXTVar := TComboBox.Create(Self);
  with sht do
  begin
    Name        := 'sht' + num;
    Parent      := pagMain;
    PageControl := pagMain;
    Caption     := num;
    Tag         := GetSourceIndex;
    HelpContext := 3615;
  end;
  with chkWatch do
  begin
    Name   := 'chkWatch' + num;
    Parent := sht;
    Left   := Trunc(8 * scale_amount);
    Top    := Trunc(16 * scale_amount);
    Width  := Trunc(21 * scale_amount);
    Height := Trunc(21 * scale_amount);
    TabOrder    := 1;
    Caption     := '';
    Tag         := udValue.Position;
    HelpContext := 3616;
  end;
  with edtWatch do
  begin
    Name   := 'edtWatch' + num;
    Parent := sht;
    Text   := '';
    Left   := Trunc(32 * scale_amount);
    Top    := Trunc(16 * scale_amount);
    Width  := Trunc(154 * scale_amount);
    Height := Trunc(21 * scale_amount);
    AutoSize     := False;
{$IFNDEF FPC}
    Font.Charset := DEFAULT_CHARSET;
{$ENDIF}
    Font.Color   := clWindowText;
    Font.Height  := -12;
    Font.Name    := 'Courier New';
    Font.Style   := [];
    ParentFont   := False;
    ReadOnly     := True;
    TabOrder     := 2;
    HelpContext  := 3617;
  end;
  with edtVal do
  begin
    Name   := 'edtValue'+num;
    Parent := sht;
    Left   := Trunc(190 * scale_amount);
    Top    := Trunc(16 * scale_amount);
    Width  := Trunc(50 * scale_amount);
    Height := Trunc(21 * scale_amount);
    MaxLength   := 5;
    TabOrder    := 3;
    Text        := IntToStr(udValue.Position);
    OnKeyPress  := edtValueKeyPress;
    HelpContext := 3618;
    ReadOnly := True;
    Visible := not (IsNXT and (sht.Tag = 0));
  end;
  with udVal do
  begin
    Name   := 'udValue' + num;
    Parent := sht;
    Left   := Trunc(240 * scale_amount);
    Top    := Trunc(16 * scale_amount);
    Width  := Trunc(15 * scale_amount);
    Height := Trunc(21 * scale_amount);
    Associate := edtVal;
    Min       := udValue.Min;
    Max       := udValue.Max;
    Position  := udValue.Position;
    TabOrder  := 4;
    Thousands := False;
    Wrap      := False;
    HelpContext := 3619;
    Visible := not (IsNXT and (sht.Tag = 0));
  end;
  with cboSrc do
  begin
    Name   := 'cboSource' + num;
    Parent := sht;
    if IsNXT and (sht.Tag = 0) then
    begin
      Left  := Trunc(340 * scale_amount);
      Width := Trunc(140 * scale_amount);
    end
    else
    begin
      Left  := Trunc(260 * scale_amount);
      Width := Trunc(160 * scale_amount);
    end;
    Top    := Trunc(16 * scale_amount);
    Height := Trunc(21 * scale_amount);
    Style  := csDropDownList;
    ItemHeight  := 13;
    TabOrder    := 5;
    Items.Assign(cboSource.Items);
    ItemIndex   := cboSource.ItemIndex;
    Enabled     := False;
    HelpContext := 3620;
  end;
  with cboNXTVar do
  begin
    Name   := 'cboNXTVar'+num;
    Parent := sht;
    Left   := Trunc(190 * scale_amount);
    Top    := Trunc(16 * scale_amount);
    Width  := Trunc(146 * scale_amount);
    Height := Trunc(21 * scale_amount);
    Style  := csDropDownList;
    ItemHeight  := 13;
    TabOrder := 3;
    Visible  := IsNXT and (sht.Tag = 0);
    OnChange := cboNXTVarChange;
  end;
  if IsNXT and (sht.Tag = 0) then
  begin
    AddVariableHint(sht, udValue.Position);
    PopulateVariables(cboNXTVar);
    if udValue.Position < cboNXTVar.Items.Count then
      cboNXTVar.ItemIndex := udValue.Position;
  end;
  UpdateControls;
end;

procedure TfrmNewWatch.cboSourceChange(Sender: TObject);
begin
  AdjustRangeOfValueSlider(GetSourceIndex);
  UpdateControls;
end;

procedure TfrmNewWatch.AdjustRangeOfValueSlider(source: Integer);
begin
  udValue.Position := BrickWatchSources[LocalBrickType][source].VMin;
  // crud.  poll only accepts a byte value 0..255
//  udValue.Min := Max(BrickWatchSources[LocalBrickType][source].VMin, 0);
//  udValue.Max := Min(BrickWatchSources[LocalBrickType][source].VMax, 255);
  udValue.Min := BrickWatchSources[LocalBrickType][source].VMin;
  udValue.Max := BrickWatchSources[LocalBrickType][source].VMax;
  if (source = 0) and IsNXT and CurrentProgram.Loaded(GetActiveEditorFilename) then
  begin
    udValue.Min := 0;
    udValue.Max := CurrentProgram.Dataspace.Count - 1;
  end;
end;

procedure TfrmNewWatch.InitSources;
var
  i : Integer;
  WS : WatchSources;
begin
  cboSource.Items.Clear;
  WS := BrickWatchSources[LocalBrickType];
  for i := low(WS) to high(WS) do
  begin
    if WS[i].Has then
      cboSource.Items.AddObject(WS[i].Name, TObject(i));
  end;
end;

function TfrmNewWatch.GetSourceIndex: Integer;
begin
  Result := Integer(cboSource.Items.Objects[cboSource.ItemIndex]);
end;

procedure TfrmNewWatch.btnRemoveWatchClick(Sender: TObject);
begin
  pagMain.ActivePage.Free;
  UpdateControls;
end;

procedure TfrmNewWatch.edtValueExit(Sender: TObject);
var
  i : Integer;
begin
  // make sure text is valid
  i := StrToIntDef(edtValue.Text, -32768);
  if i > udValue.Max then
    udValue.Position := udValue.Max
  else if i < udValue.Min then
    udValue.Position := udValue.Min;
  edtValue.Text := IntToStr(udValue.Position);
end;

procedure TfrmNewWatch.edtValueKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, #16, '0'..'9']) then
    Key := #0;
end;

procedure TfrmNewWatch.UpdateControls;
var
  bEnable : Boolean;
begin
  btnAddWatch.Enabled := cboSource.ItemIndex <> -1;
  bEnable := pagMain.PageCount > 0;
  btnRemoveWatch.Enabled := bEnable;
  btnCheckAll.Enabled    := bEnable;
  btnCheckNone.Enabled   := bEnable;
  btnPollNow.Enabled     := bEnable;
  btnPollRegular.Enabled := bEnable;
end;

procedure TfrmNewWatch.btnClearClick(Sender: TObject);
var
  i: Integer;
  temp: TComponent;
begin
  for i := ComponentCount - 1 downto 0 do
  begin
    temp := Components[i];
    if (temp is TEdit) and (Pos('edtWatch', TEdit(temp).Name) = 1) then
      TEdit(temp).Text := '';
  end;
end;

procedure TfrmNewWatch.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TfrmNewWatch.AddVariableHint(sht: TTabsheet; i : integer);
var
  tmp : string;
begin
  if IsNXT and CurrentProgram.Loaded(GetActiveEditorFilename) then
  begin
    if CurrentProgram.Dataspace.Count > i then
    begin
      tmp := CurrentProgram.Dataspace[i].PrettyName;
      sht.Hint := tmp;
    end;
  end;
end;

procedure TfrmNewWatch.PopulateVariables(cbo: TCombobox);
var
  i : integer;
begin
  if IsNXT and CurrentProgram.Loaded(GetActiveEditorFilename) then
  begin
    cbo.Items.Clear;
    for i := 0 to CurrentProgram.Dataspace.Count - 1 do
      cbo.Items.Add(CurrentProgram.Dataspace[i].PrettyName);
  end;
end;

procedure TfrmNewWatch.cboNXTVarChange(Sender: TObject);
var
  C : TComboBox;
begin
  // change the edit value and ud position
  C := TCombobox(Sender);
  TUpDown(C.Parent.Controls[3]).Position := C.ItemIndex;
  C.Parent.Hint := C.Text;
end;

{$IFDEF FPC}
initialization
  {$i uNewWatch.lrs}
{$ENDIF}

end.
