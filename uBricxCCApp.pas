unit uBricxCCApp;

interface

uses
  ComObj, ActiveX, AxCtrls, Classes, BricxCC_TLB, StdVcl, Windows;

type
  TBricxCCApp = class(TAutoObject, IConnectionPointContainer, IBricxCCApp)
  private
    { Private declarations }
    FConnectionPoints: TConnectionPoints;
    FConnectionPoint: TConnectionPoint;
    FSinkList: TList;
    FEvents: IBricxCCAppEvents;
  public
    procedure Initialize; override;
  protected
    { Protected declarations }
    property ConnectionPoints: TConnectionPoints read FConnectionPoints
      implements IConnectionPointContainer;
    procedure EventSinkChanged(const EventSink: IUnknown); override;
    procedure Hide; safecall;
    procedure Show; safecall;
    function Get_FileCount: Integer; safecall;
    procedure CloseFile(index: Integer); safecall;
    function Compile(bDownload, bRun: WordBool; iSlot: TBricxCCSlots;
      out sErrors: WideString): WordBool; safecall;
    procedure FocusFile(index: Integer); safecall;
    procedure InsertText(index: Integer; row, col: LongWord;
      const Value: WideString); safecall;
    procedure NewFile; safecall;
    procedure OpenFile(const aPath: WideString); safecall;
    procedure Run; safecall;
    procedure Stop; safecall;
    function Get_BrickType: TAutoBrickType; safecall;
    procedure Set_BrickType(Value: TAutoBrickType); safecall;
    procedure HelpOnWord(const aWord: WideString); safecall;
    function Get_Port: WideString; safecall;
    procedure Set_Port(const Value: WideString); safecall;
    function Get_UseBluetooth: WordBool; safecall;
    procedure Set_UseBluetooth(Value: WordBool); safecall;
    procedure GotoXY(row, col: LongWord); safecall;
  end;

implementation

uses ComServ, Forms, MainUnit, Editor, Preferences, uMiscDefines, brick_common;

procedure TBricxCCApp.EventSinkChanged(const EventSink: IUnknown);
begin
  FEvents := EventSink as IBricxCCAppEvents;
  if FConnectionPoint <> nil then
     FSinkList := FConnectionPoint.SinkList;
end;

procedure TBricxCCApp.Initialize;
begin
  inherited Initialize;
  FConnectionPoints := TConnectionPoints.Create(Self);
  if AutoFactory.EventTypeInfo <> nil then
    FConnectionPoint := FConnectionPoints.CreateConnectionPoint(
      AutoFactory.EventIID, ckSingle, EventConnect)
  else FConnectionPoint := nil;
end;


procedure TBricxCCApp.Hide;
var
  i : Integer;
  F : TForm;
begin
  if Assigned(MainForm) then
  begin
    for i := 0 to Screen.FormCount - 1 do
    begin
      F := Screen.Forms[i];
      if (F = MainForm) or (F is TEditorForm) then Continue;
      if F.Visible then F.Close;
    end;
    MainForm.Hide;
  end;
end;

procedure TBricxCCApp.Show;
begin
  if Assigned(MainForm) then
  begin
    LocalStartupAction := SU_NOCONNECT;
    MainForm.Show;
  end;
end;

function TBricxCCApp.Get_FileCount: Integer;
begin
  Result := 0;
  if Assigned(MainForm) then
    Result := MainForm.EditorFormCount;
end;

procedure TBricxCCApp.CloseFile(index: Integer);
var
  F : TEditorForm;
begin
  if Assigned(MainForm) and
     ((index >= 0) and (index < MainForm.EditorFormCount)) then
  begin
    // no saving here
    F := MainForm.EditorForms[index];
    F.TheEditor.Modified := False;
    F.Close;
  end;
end;

function TBricxCCApp.Compile(bDownload, bRun: WordBool;
  iSlot: TBricxCCSlots; out sErrors: WideString): WordBool;
var
  E : TEditorForm;
begin
  Result := False;
  if Assigned(MainForm) then
  begin
    E := MainForm.ActiveEditorForm;
    if Assigned(E) then
    begin
      MainForm.ProgramBox.ItemIndex := iSlot - 1;
      if bDownload and bRun then
        MainForm.actCompileDownloadRunExecute(Self)
      else if bDownload then
        MainForm.actCompileDownloadExecute(Self)
      else
        MainForm.actCompileCompileExecute(Self);
      sErrors := E.TheErrors.Items.Text;
      Result := E.TheErrors.Items.Count = 0;
    end;
  end;
end;

procedure TBricxCCApp.FocusFile(index: Integer);
begin
  if Assigned(MainForm) and
     ((index >= 0) and (index < MainForm.EditorFormCount)) then
  begin
    MainForm.ActivateEditorForm(index);
  end;
end;

procedure TBricxCCApp.InsertText(index: Integer; row, col: LongWord;
  const Value: WideString);
var
  F : TEditorForm;
begin
  if Assigned(MainForm) and
     ((index >= 0) and (index < MainForm.EditorFormCount)) then
  begin
    F := MainForm.EditorForms[index];
    with F.TheEditor do begin
      CaretXY := Point(col, row);
      SelText := Value;
      EnsureCursorPosVisible;
    end;
  end;
end;

procedure TBricxCCApp.NewFile;
begin
  if Assigned(MainForm) then
    MainForm.actFileNewExecute(self);
end;

procedure TBricxCCApp.OpenFile(const aPath: WideString);
begin
  if Assigned(MainForm) then
    MainForm.OpenFile(aPath);
end;

procedure TBricxCCApp.Run;
begin
  if Assigned(MainForm) then
    MainForm.actCompileRunExecute(Self);
end;

procedure TBricxCCApp.Stop;
begin
  if Assigned(MainForm) then
    MainForm.actCompileStopExecute(Self);
end;

function TBricxCCApp.Get_BrickType: TAutoBrickType;
begin
  Result := LocalBrickType;
end;

procedure TBricxCCApp.Set_BrickType(Value: TAutoBrickType);
begin
  LocalBrickType := Value;
end;

procedure TBricxCCApp.HelpOnWord(const aWord: WideString);
begin
  HelpALink(aWord);
end;

function TBricxCCApp.Get_Port: WideString;
begin
  Result := LocalPort;
end;

procedure TBricxCCApp.Set_Port(const Value: WideString);
begin
  LocalPort := Value;
end;

function TBricxCCApp.Get_UseBluetooth: WordBool;
begin
  Result := LocalUseBluetooth;
end;

procedure TBricxCCApp.Set_UseBluetooth(Value: WordBool);
begin
  LocalUseBluetooth := Value;
end;

procedure TBricxCCApp.GotoXY(row, col: LongWord);
var
  F : TEditorForm;
begin
  if Assigned(MainForm) then
  begin
    F := MainForm.ActiveEditorForm;
    if Assigned(F) then
      with F.TheEditor do begin
        CaretXY := Point(col, row);
        BlockBegin := CaretXY;
        BlockEnd   := BlockBegin;
        EnsureCursorPosVisible;
      end;
  end;
end;

initialization
  TAutoObjectFactory.Create(ComServer, TBricxCCApp, Class_BricxCCApp,
    ciSingleInstance, tmApartment);
end.
