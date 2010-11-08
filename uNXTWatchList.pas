unit uNXTWatchList;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms,
  Dialogs, Menus, Tabs, ComCtrls, ActnList, uNXTWatchCommon;

type
  TfrmNXTWatchList = class(TForm)
    pmuMain: TPopupMenu;
    TabSet1: TTabSet;
    mniEditWatch: TMenuItem;
    mniAddWatch: TMenuItem;
    N1: TMenuItem;
    mniEnableWatch: TMenuItem;
    mniDisableWatch: TMenuItem;
    mniDeleteWatch: TMenuItem;
    mniCopyWatchValue: TMenuItem;
    mniCopyWatchName: TMenuItem;
    N2: TMenuItem;
    mniEnableAllWatches: TMenuItem;
    mniDisableAllWatches: TMenuItem;
    mniDeleteAllWatches: TMenuItem;
    N3: TMenuItem;
    mniAddGroup: TMenuItem;
    mniDeleteGroup: TMenuItem;
    mniMoveWatchToGroup: TMenuItem;
    N4: TMenuItem;
    mniInspect: TMenuItem;
    mniBreakWhenChanged: TMenuItem;
    N5: TMenuItem;
    mniShowColumnHeaders: TMenuItem;
    N6: TMenuItem;
    mniStayonTop: TMenuItem;
    mniDockable: TMenuItem;
    lstWatches: TListView;
    alMain: TActionList;
    actEditWatch: TAction;
    actAddWatch: TAction;
    actEnableWatch: TAction;
    actDisableWatch: TAction;
    actDeleteWatch: TAction;
    actCopyWatchValue: TAction;
    actCopyWatchName: TAction;
    actEnableAllWatches: TAction;
    actDisableAllWatches: TAction;
    actDeleteAllWatches: TAction;
    actAddGroup: TAction;
    actDeleteGroup: TAction;
    actMoveWatchToGroup: TAction;
    actInspect: TAction;
    actBreakWhenChanged: TAction;
    actShowColumnHeaders: TAction;
    actStayOnTop: TAction;
    actDockable: TAction;
    procedure actEditWatchExecute(Sender: TObject);
    procedure actAddWatchExecute(Sender: TObject);
    procedure actEnableWatchExecute(Sender: TObject);
    procedure actDisableWatchExecute(Sender: TObject);
    procedure actDeleteWatchExecute(Sender: TObject);
    procedure actCopyWatchValueExecute(Sender: TObject);
    procedure actCopyWatchNameExecute(Sender: TObject);
    procedure actEnableAllWatchesExecute(Sender: TObject);
    procedure actDisableAllWatchesExecute(Sender: TObject);
    procedure actDeleteAllWatchesExecute(Sender: TObject);
    procedure actAddGroupExecute(Sender: TObject);
    procedure actDeleteGroupExecute(Sender: TObject);
    procedure actMoveWatchToGroupExecute(Sender: TObject);
    procedure actInspectExecute(Sender: TObject);
    procedure actBreakWhenChangedExecute(Sender: TObject);
    procedure actShowColumnHeadersExecute(Sender: TObject);
    procedure actStayOnTopExecute(Sender: TObject);
    procedure actDockableExecute(Sender: TObject);
    procedure alMainUpdate(Action: TBasicAction;
      var Handled: Boolean);
  private
    { Private declarations }
    procedure UpdateFormState;
    procedure ClearWatchList;
    procedure DisableAllWatches;
    procedure EnableAllWatches;
    procedure SetWatchEnabledState(const idx : integer; bEnabled : boolean);
    procedure EnableWatch(const idx : integer);
    procedure DisableWatch(const idx : integer);
    procedure DeleteWatch(const idx : integer);
    procedure CopyWatchValue(const idx : integer);
    procedure CopyWatchName(const idx : integer);
    function  GetWatchEnabledState(const idx : integer) : boolean;
    procedure UpdateGUIList;
  public
    { Public declarations }
    function CurrentGroupIndex : integer;
    function SelectedWatchIndex: integer;
    function SelectedWatch : TWatchInfo;
    function WatchCount: integer;
    function GroupCount: integer;
  end;

var
  frmNXTWatchList: TfrmNXTWatchList;

implementation

{$R *.dfm}

uses
  Clipbrd, uNXTWatchProperties, uNXTWatchGroups;

procedure TfrmNXTWatchList.UpdateFormState;
begin
  if actStayOnTop.Checked then
    FormStyle := fsStayOnTop
  else
    FormStyle := fsNormal;
  if actDockable.Checked then
    DragKind := dkDock
  else
    DragKind := dkDrag;
  lstWatches.ShowColumnHeaders := actShowColumnHeaders.Checked;
end;

procedure TfrmNXTWatchList.actEditWatchExecute(Sender: TObject);
var
  wi : TWatchInfo;
begin
  with TfrmNXTWatchProperties.Create(nil) do
  try
    wi := SelectedWatch;
    if Assigned(wi) then
    begin
      // copy selected watch information into properties dialog
      InitDialog(wi);
    end;
    if ShowModal = mrOK then
    begin
      if not Assigned(wi) then
      begin
        // add watch to list and view
        wi := TheWatchList.Add;
      end;
      // update this watch info values in our list
      UpdateWatchInfo(wi);
      UpdateGUIList;
    end;
  finally
    Free;
  end;
end;

procedure TfrmNXTWatchList.actAddWatchExecute(Sender: TObject);
var
  wi : TWatchInfo;
begin
  with TfrmNXTWatchProperties.Create(nil) do
  try
    if ShowModal = mrOK then
    begin
      // add watch to list and view
      wi := TheWatchList.Add;
      // update this watch info values in our list
      UpdateWatchInfo(wi);
      UpdateGUIList;
    end;
  finally
    Free;
  end;
end;

procedure TfrmNXTWatchList.actEnableWatchExecute(Sender: TObject);
begin
  EnableWatch(SelectedWatchIndex);
end;

procedure TfrmNXTWatchList.actDisableWatchExecute(Sender: TObject);
begin
  DisableWatch(SelectedWatchIndex);
end;

procedure TfrmNXTWatchList.actDeleteWatchExecute(Sender: TObject);
begin
  DeleteWatch(SelectedWatchIndex);
end;

procedure TfrmNXTWatchList.actCopyWatchValueExecute(Sender: TObject);
begin
  CopyWatchValue(SelectedWatchIndex);
end;

procedure TfrmNXTWatchList.actCopyWatchNameExecute(Sender: TObject);
begin
  CopyWatchName(SelectedWatchIndex);
end;

procedure TfrmNXTWatchList.actEnableAllWatchesExecute(Sender: TObject);
begin
 EnableAllWatches;
end;

procedure TfrmNXTWatchList.actDisableAllWatchesExecute(Sender: TObject);
begin
  DisableAllWatches;
end;

procedure TfrmNXTWatchList.actDeleteAllWatchesExecute(Sender: TObject);
begin
  ClearWatchList;
end;

procedure TfrmNXTWatchList.actAddGroupExecute(Sender: TObject);
begin
  with TfrmNXTWatchGroups.Create(nil) do
  try
    // load existing groups
    if ShowModal = mrOK then
    begin
      // retrieve new group name
    end;
  finally
    Free;
  end;
end;

procedure TfrmNXTWatchList.actDeleteGroupExecute(Sender: TObject);
begin
//
end;

procedure TfrmNXTWatchList.actMoveWatchToGroupExecute(Sender: TObject);
begin
//
end;

procedure TfrmNXTWatchList.actInspectExecute(Sender: TObject);
begin
//
end;

procedure TfrmNXTWatchList.actBreakWhenChangedExecute(Sender: TObject);
begin
  ShowMessage('Not Implemented');
end;

procedure TfrmNXTWatchList.actShowColumnHeadersExecute(Sender: TObject);
begin
  actShowColumnHeaders.Checked := not actShowColumnHeaders.Checked;
  UpdateFormState;
end;

procedure TfrmNXTWatchList.actStayOnTopExecute(Sender: TObject);
begin
  actStayOnTop.Checked := not actStayOnTop.Checked;
  UpdateFormState;
end;

procedure TfrmNXTWatchList.actDockableExecute(Sender: TObject);
begin
  actDockable.Checked := not actDockable.Checked;
  UpdateFormState;
end;

procedure TfrmNXTWatchList.alMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  i, wcnt, gcnt : integer;
begin
  i := SelectedWatchIndex;
  wcnt := WatchCount;
  gcnt := GroupCount;
  actDeleteGroup.Enabled       := CurrentGroupIndex <> 0;
  actEditWatch.Enabled         := True;
  actAddWatch.Enabled          := True;
  actEnableWatch.Enabled       := (i <> -1) and not GetWatchEnabledState(i);
  actDisableWatch.Enabled      := (i <> -1) and GetWatchEnabledState(i);
  actDeleteWatch.Enabled       := i <> -1;
  actCopyWatchValue.Enabled    := i <> -1;
  actCopyWatchName.Enabled     := i <> -1;
  actEnableAllWatches.Enabled  := wcnt > 0;
  actDisableAllWatches.Enabled := wcnt > 0;
  actDeleteAllWatches.Enabled  := wcnt > 0;
  actAddGroup.Enabled          := True;
  actDeleteGroup.Enabled       := gcnt > 1;
  actMoveWatchToGroup.Enabled  := False;
  actInspect.Enabled           := i <> -1;
  actBreakWhenChanged.Enabled  := False;
  actShowColumnHeaders.Enabled := True;
  actStayOnTop.Enabled         := True;
  actDockable.Enabled          := True;
end;

function TfrmNXTWatchList.CurrentGroupIndex: integer;
begin
  Result := 0;
end;

function TfrmNXTWatchList.SelectedWatchIndex: integer;
begin
  Result := lstWatches.ItemIndex;
end;

function TfrmNXTWatchList.GroupCount: integer;
begin
  Result := 1;
end;

function TfrmNXTWatchList.WatchCount: integer;
begin
  Result := TheWatchList.Count;
end;

procedure TfrmNXTWatchList.ClearWatchList;
begin
  // empty out our list of watches
  // also clear the list view
  TheWatchList.Clear;
  UpdateGUIList;
end;

procedure TfrmNXTWatchList.DisableAllWatches;
begin
  // disable all watches in our list
  TheWatchList.DisableAllWatches;
  UpdateGUIList;
end;

procedure TfrmNXTWatchList.EnableAllWatches;
begin
  // enable all watches in our list
  TheWatchList.EnableAllWatches;
  UpdateGUIList;
end;

procedure TfrmNXTWatchList.CopyWatchName(const idx: integer);
begin
  if idx <> -1 then
  begin
    // copy watch name
    Clipboard.AsText := TheWatchList[idx].Expression;
  end;
end;

procedure TfrmNXTWatchList.CopyWatchValue(const idx: integer);
begin
  if idx <> -1 then
  begin
    // copy watch value
    Clipboard.AsText := TheWatchList[idx].Value;
  end;
end;

procedure TfrmNXTWatchList.DeleteWatch(const idx: integer);
begin
  if idx <> -1 then
  begin
    // delete watch from list
    TheWatchList.Delete(idx);
    UpdateGUIList;
  end;
end;

procedure TfrmNXTWatchList.DisableWatch(const idx: integer);
begin
  SetWatchEnabledState(idx, False);
end;

procedure TfrmNXTWatchList.EnableWatch(const idx: integer);
begin
  SetWatchEnabledState(idx, True);
end;

procedure TfrmNXTWatchList.SetWatchEnabledState(const idx: integer;
  bEnabled: boolean);
begin
  if idx <> -1 then
  begin
    // enable watch
    TheWatchList[idx].Enabled := bEnabled;
    UpdateGUIList;
  end;
end;

function TfrmNXTWatchList.GetWatchEnabledState(const idx: integer): boolean;
begin
  Result := False;
  if idx <> -1 then
  begin
    // get watch enabled state
    Result := TheWatchList[idx].Enabled;
  end;
end;

function TfrmNXTWatchList.SelectedWatch: TWatchInfo;
var
  i : integer;
begin
  Result := nil;
  i := SelectedWatchIndex;
  if i <> -1 then
    Result := TheWatchList[i];
end;

procedure TfrmNXTWatchList.UpdateGUIList;
var
  i : integer;
  li : TListItem;
  wi : TWatchInfo;
begin
  lstWatches.Clear;
  TheWatchList.Refresh;
  for i := 0 to TheWatchList.Count - 1 do
  begin
    wi := TheWatchList[i];
    li := lstWatches.Items.Add;
    li.Caption := wi.Expression;
    li.Checked := wi.Enabled;
    li.SubItems.Add(wi.Value);
  end;
end;

end.
