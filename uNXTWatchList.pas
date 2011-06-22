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
 * Portions created by John Hansen are Copyright (C) 2010 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uNXTWatchList;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
  Messages, 
{$ELSE}
  LResources,
  LMessages,
  LCLType,
  LCLIntf,
{$ENDIF}
  SysUtils, Classes, Controls, Forms,
  Dialogs, Menus, Tabs, ComCtrls, ActnList, uNXTWatchCommon;

type
  TGetExpressionsEvent = procedure(Sender : TObject; aStrings : TStrings) of object;

  TfrmNXTWatchList = class(TForm)
    pmuMain: TPopupMenu;
    tabMain: TTabSet;
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
    actRefresh: TAction;
    Refresh1: TMenuItem;
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
    procedure lstWatchesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lstWatchesEditing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tabMainChange(Sender: TObject; NewTab: Integer;
      var AllowChange: Boolean);
    procedure lstWatchesDblClick(Sender: TObject);
    procedure lstWatchesChanging(Sender: TObject; Item: TListItem;
      Change: TItemChange; var AllowChange: Boolean);
    procedure lstWatchesChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure actRefreshExecute(Sender: TObject);
    procedure actEditWatchExecute(Sender: TObject);
  private
    { Private declarations }
    fOnGetExpressions: TGetExpressionsEvent;
    fOldItemCaption : string;
    procedure EditAWatch(aWatchInfo : TWatchInfo);
    procedure UpdateItem(aItem : TListItem);
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
    function CurrentGroupList : TListView;
    function CurrentGroupName : string;
    function CurrentGroupIndex : integer;
    procedure UpdateWatchToList(Info : TWatchInfo; const oldGroup, oldExpr : string);
    procedure AddWatchToList(Info : TWatchInfo; bRefresh : boolean = False);
    procedure DeleteWatchFromList(Info : TWatchInfo; name : string = '');
    function FindListByGroupName(const name : string) : TListView;
    function CreateListForWatchGroup(const GroupName : string) : TListView;
    function GetExpressions : string;
    function AddNewList(const GroupName : string) : TListView;
  public
    { Public declarations }
    function SelectedWatchIndex: integer;
    function SelectedWatch : TWatchInfo;
    function WatchCount: integer;
    function GroupCount: integer;
    property OnGetExpressions : TGetExpressionsEvent read fOnGetExpressions write fOnGetExpressions;
  end;

var
  frmNXTWatchList: TfrmNXTWatchList;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  Clipbrd, uNXTWatchProperties, uNXTWatchGroups, uLocalizedStrings,
  uGlobals, uMiscDefines, uROPS, uProgram, uPSRuntime;

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

procedure TfrmNXTWatchList.actAddWatchExecute(Sender: TObject);
var
  wi : TWatchInfo;
begin
  with TfrmNXTWatchProperties.Create(nil) do
  try
    PopulateExpressions(GetExpressions);
    if ShowModal = mrOK then
    begin
      // add watch to list and view
      wi := TheWatchList.Add;
      // update this watch info values in our list
      UpdateWatchInfo(wi);
      AddWatchToList(wi, True);
//      UpdateGUIList;
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
  if MessageDlg(sConfirmDeleteAllWatches, mtConfirmation, [mbOK, mbCancel], 0) = ID_OK then
    ClearWatchList;
end;

procedure TfrmNXTWatchList.actAddGroupExecute(Sender: TObject);
begin
  with TfrmNXTWatchGroups.Create(nil) do
  try
    // load existing groups
    cboGroupName.Items.Assign(tabMain.Tabs);
    if ShowModal = mrOK then
    begin
      // retrieve new group name
      if tabMain.Tabs.IndexOf(cboGroupName.Text) = -1 then
        AddNewList(cboGroupName.Text);
    end;
  finally
    Free;
  end;
end;

procedure TfrmNXTWatchList.actDeleteGroupExecute(Sender: TObject);
begin
  ShowMessage(sNotYetImplemented);
// delete watches on the group being deleted and
// delete the tab and list view
end;

procedure TfrmNXTWatchList.actMoveWatchToGroupExecute(Sender: TObject);
begin
  ShowMessage(sNotYetImplemented);
end;

procedure TfrmNXTWatchList.actInspectExecute(Sender: TObject);
begin
  ShowMessage(sNotYetImplemented);
end;

procedure TfrmNXTWatchList.actBreakWhenChangedExecute(Sender: TObject);
begin
  ShowMessage(sNotYetImplemented);
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

function TfrmNXTWatchList.SelectedWatchIndex: integer;
var
  groupname, expression : string;
  li : TListItem;
  list : TListView;
begin
  // determine the index by the selected list item's caption and the group name
  groupname := CurrentGroupName;
  list := FindListByGroupName(groupname);
  li   := list.Selected;
  if Assigned(li) then
  begin
    expression := li.Caption;
    Result := TheWatchList.indexOf(groupname, expression);
  end
  else
    Result := -1;
end;

function TfrmNXTWatchList.GroupCount: integer;
begin
  Result := tabMain.Tabs.Count;
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
  if (idx >= 0) and (idx < TheWatchList.Count) then
  begin
    // delete watch from list
    DeleteWatchFromList(TheWatchList[idx]);
    TheWatchList.Delete(idx);
//    UpdateGUIList;
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

procedure TfrmNXTWatchList.SetWatchEnabledState(const idx: integer; bEnabled: boolean);
var
  wi : TWatchInfo;
begin
  if idx <> -1 then
  begin
    // enable watch
    wi := TheWatchList[idx];
    wi.Enabled := bEnabled;
    UpdateWatchToList(wi, wi.GroupName, wi.Expression);
//    UpdateGUIList;
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
  wi : TWatchInfo;
  C : TControl;
begin
  // delete all extra list views
  for i := ControlCount - 1 downto 0 do
  begin
    C := Controls[i];
    if (C is TListView) and (C <> lstWatches) then
    begin
      FreeAndNil(C);
    end;
  end;
  // remove all tabs except first (Watches)
  tabMain.Tabs.Clear;
  tabMain.Tabs.Add(DEFAULT_GROUP);
  tabMain.TabIndex := 0;
  // create a list view for each watch group
  // create a tab for each watch group
  lstWatches.Clear;
  TheWatchList.Refresh;
  for i := 0 to TheWatchList.Count - 1 do
  begin
    wi := TheWatchList[i];
    AddWatchToList(wi, False);
  end;
end;

procedure TfrmNXTWatchList.lstWatchesEditing(Sender: TObject;
  Item: TListItem; var AllowEdit: Boolean);
begin
  AllowEdit := True;
  fOldItemCaption := Item.Caption;
end;

procedure TfrmNXTWatchList.lstWatchesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    // if there is a selected list item then delete it.
    if not TListView(Sender).IsEditing then
      DeleteWatch(SelectedWatchIndex);
  end
  else if Key = VK_RETURN then
  begin
    // edit the selected item
    EditAWatch(SelectedWatch);
  end;
end;

procedure TfrmNXTWatchList.lstWatchesDblClick(Sender: TObject);
var
  li : TListItem;
  groupname, expression : string;
  i : integer;
begin
  li := TListView(Sender).Selected;
  if Assigned(li) then
  begin
    groupname := CurrentGroupName;
    expression := li.Caption;
    i := TheWatchList.IndexOf(groupname, expression);
    // change and refresh the watch item
    if i <> -1 then
      EditAWatch(TheWatchList[i]);
  end;
end;

procedure TfrmNXTWatchList.lstWatchesChanging(Sender: TObject;
  Item: TListItem; Change: TItemChange; var AllowChange: Boolean);
begin
  AllowChange := True;
  if Change = ctText then Exit;
  fOldItemCaption := Item.Caption;
end;

procedure TfrmNXTWatchList.lstWatchesChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if fOldItemCaption = '' then
    Exit;
  UpdateItem(Item);
  fOldItemCaption := '';
end;

procedure TfrmNXTWatchList.FormCreate(Sender: TObject);
begin
//
end;

procedure TfrmNXTWatchList.FormDestroy(Sender: TObject);
begin
//
end;

procedure TfrmNXTWatchList.FormShow(Sender: TObject);
begin
  TheWatchList.Refresh;
  UpdateGUIList;
end;

procedure TfrmNXTWatchList.tabMainChange(Sender: TObject; NewTab: Integer;
  var AllowChange: Boolean);
var
  newname : string;
  list : TListView;
begin
  AllowChange := True;
  newname := tabMain.Tabs[NewTab];
  list := FindListByGroupName(newname);
  list.BringToFront;
end;

procedure TfrmNXTWatchList.AddWatchToList(Info: TWatchInfo; bRefresh : boolean);
var
  list : TListView;
  li : TListItem;
begin
  if bRefresh then
    Info.Refresh(True);
  list := FindListByGroupName(Info.GroupName); // this may create a new list
  list.OnChange := nil;
  try
    li := list.Items.Add;
    li.Caption := Info.Expression;
    li.SubItems.Add(Info.Value);
    li.Checked := Info.Enabled;
  finally
    list.OnChange := lstWatchesChange;
  end;
end;

function TfrmNXTWatchList.CurrentGroupList: TListView;
begin
  Result := FindListByGroupName(CurrentGroupName);
end;

procedure TfrmNXTWatchList.DeleteWatchFromList(Info: TWatchInfo; name : string);
var
  list : TListView;
  i : integer;
  li : TListItem;
begin
  if name = '' then
    name := Info.GroupName;
  list := FindListByGroupName(name);
  for i := list.Items.Count - 1 downto 0 do
  begin
    li := list.Items[i];
    if li.Caption = Info.Expression then
    begin
      list.Items.Delete(i);
      break;
    end;
  end;
end;

function TfrmNXTWatchList.FindListByGroupName(const name: string): TListView;
var
  i : integer;
  C : TControl;
begin
  Result := nil;
  if name = DEFAULT_GROUP then
  begin
    Result := lstWatches;
    Exit;
  end;
  for i := 0 to ControlCount - 1 do
  begin
    C := Controls[i];
    if (C is TListView) and (C.Name = 'lstWatchGroup'+name) then
    begin
      Result := TListView(C);
      break;
    end;
  end;
  if not Assigned(Result) then
  begin
    // we need to create a new list view
    Result := AddNewList(name);
  end;
end;

procedure TfrmNXTWatchList.UpdateWatchToList(Info : TWatchInfo; const oldGroup, oldExpr : string);
var
  list : TListView;
  i : integer;
  li : TListItem;
begin
  // does new group name differ from old group name?
  Info.Refresh(True);
  if Info.GroupName <> oldGroup then
  begin
    DeleteWatchFromList(Info, oldGroup);
    AddWatchToList(Info, True);
  end
  else
  begin
    list := FindListByGroupName(oldGroup);
    for i := 0 to list.Items.Count - 1 do
    begin
      li := list.Items[i];
      if li.Caption = oldExpr then
      begin
        li.Caption := Info.Expression;
        li.SubItems.Clear;
        li.SubItems.Add(Info.Value);
        break;
      end;
    end;
  end;
end;

function TfrmNXTWatchList.CreateListForWatchGroup(const GroupName: string): TListView;
begin
  Result := TListView.Create(Self);
  with Result do
  begin
    Name := 'lstWatchGroup'+GroupName;
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 488;
    Height := 142;
    Align := alClient;
    BevelInner := bvNone;
    BevelKind := bkTile;
    BorderStyle := bsNone;
    Checkboxes := True;
    with Columns.Add do begin
      Caption := sWatchName;
      MinWidth := 100;
      Width := 100;
    end;
    with Columns.Add do begin
      Caption := sWatchValue;
      MinWidth := 100;
      Width := 375;
    end;
    RowSelect := True;
    TabOrder := 1;
    ViewStyle := vsReport;
    OnEditing := lstWatchesEditing;
    OnKeyDown := lstWatchesKeyDown;
    OnChanging := lstWatchesChanging;
    OnChange := lstWatchesChange;
    OnDblClick := lstWatchesDblClick;
  end;
end;

function TfrmNXTWatchList.CurrentGroupName: string;
begin
  Result := DEFAULT_GROUP;
  if tabMain.TabIndex <> -1 then
    Result := tabMain.Tabs[tabMain.TabIndex];
end;

function TfrmNXTWatchList.CurrentGroupIndex: integer;
begin
  Result := tabMain.TabIndex;
end;

function TfrmNXTWatchList.GetExpressions: string;
var
  SL : TStringList;
  i : integer;
begin
  SL := TStringList.Create;
  try
    if Assigned(fOnGetExpressions) then
      fOnGetExpressions(Self, SL)
    else
    begin
      SL.Clear;
      if IsNXT then
      begin
        if FileIsROPS then
        begin
          if ce.Exec.Status in [isRunning, isPaused] then
            for i := 0 to ce.Exec.GlobalVarNames.Count - 1 do
              SL.Add(ce.Exec.GlobalVarNames[i]);
          if ce.Exec.Status in [isRunning, isPaused] then
          begin
            for i := 0 to ce.Exec.CurrentProcVars.Count - 1 do
              SL.Add(ce.Exec.CurrentProcVars[i]);
            for i := 0 to ce.Exec.CurrentProcParams.Count -1 do
              SL.Add(ce.Exec.CurrentProcParams[i]);
          end;
        end
        else if FileIsNBCOrNXC then
        begin
          for i := 0 to CurrentProgram.Dataspace.Count - 1 do
            SL.Add(CurrentProgram.Dataspace[i].Name); // ?? PrettyName
        end;
      end;
    end;
    Result := SL.CommaText;
  finally
    SL.Free;
  end;
end;

procedure TfrmNXTWatchList.actRefreshExecute(Sender: TObject);
begin
  TheWatchList.Refresh;
  UpdateGUIList;
end;

procedure TfrmNXTWatchList.EditAWatch(aWatchInfo: TWatchInfo);
var
  wi : TWatchInfo;
  oldGroup, oldExpr : string;
begin
  oldGroup := '';
  oldExpr  := '';
  with TfrmNXTWatchProperties.Create(nil) do
  try
    PopulateExpressions(GetExpressions);
    wi := aWatchInfo;
    if Assigned(wi) then
    begin
      // copy selected watch information into properties dialog
      oldGroup := wi.GroupName;
      oldExpr  := wi.Expression;
      InitDialog(wi);
    end;
    if ShowModal = mrOK then
    begin
      if not Assigned(wi) then
      begin
        // add watch to list and view
        wi := TheWatchList.Add;
        // update this watch info values in our list
        UpdateWatchInfo(wi);
        AddWatchToList(wi, True);
      end
      else
      begin
        // update this watch info values in our list
        UpdateWatchInfo(wi);
        UpdateWatchToList(wi, oldGroup, oldExpr);
      end;
    end;
  finally
    Free;
  end;
end;

procedure TfrmNXTWatchList.actEditWatchExecute(Sender: TObject);
begin
  EditAWatch(SelectedWatch);
end;

procedure TfrmNXTWatchList.UpdateItem(aItem: TListItem);
var
  groupname, expression : string;
  wi : TWatchInfo;
  i : integer;
begin
  groupname := CurrentGroupName;
  expression := fOldItemCaption;
  i := TheWatchList.IndexOf(groupname, expression);
  // change and refresh the watch item
  if i <> -1 then
  begin
    wi := TheWatchList[i];
    wi.Expression := aItem.Caption;
    wi.Enabled    := aItem.Checked;
    wi.Refresh(True);
    aItem.SubItems.Clear;
    aItem.SubItems.Add(wi.Value);
  end;
end;

function TfrmNXTWatchList.AddNewList(const GroupName: string): TListView;
begin
  Result := CreateListForWatchGroup(GroupName);
  // add a tab too
  tabMain.TabIndex := tabMain.Tabs.Add(GroupName);
end;

initialization
{$IFDEF FPC}
  {$i uNXTWatchList.lrs}
{$ENDIF}

end.
