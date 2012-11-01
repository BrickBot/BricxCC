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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit ConstructUnit;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LResources,
  LMessages,
  LCLIntf,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Buttons, Menus, StdCtrls, ComCtrls,
  uOfficeComp, uTreeSaver;

const
  WM_DODOCK = WM_USER + 400;

type
  TOnAddConstructEvent = procedure(Sender : TObject; const aTemplate : string; const aX : integer = -1; const aY : integer = -1) of object;

  { TConstructForm }

  TConstructForm = class(TForm)
    ConstructPanel: TPanel;
    treTemplates: TTreeView;
    procedure treTemplatesClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure treTemplatesDblClick(Sender: TObject);
    procedure treTemplatesMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure treTemplatesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure treTemplatesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure treTemplatesStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure treTemplatesDeletion(Sender: TObject; Node: TTreeNode);
    procedure FormEndDock(Sender, Target: TObject; X, Y: Integer);
  private
    { Private declarations }
    popOptions: TOfficePopupMenu;
    mniExpandAll: TOfficeMenuItem;
    mniCollapseAll: TOfficeMenuItem;
    mniPopSep1: TOfficeMenuItem;
    mniDblClickInsert: TOfficeMenuItem;
    fActiveLanguageIndex: integer;
    fOnAddConstruct: TOnAddConstructEvent;
    procedure mniExpandAllClick(Sender: TObject);
    procedure mniCollapseAllClick(Sender: TObject);
    procedure mniDblClickInsertClick(Sender: TObject);
    procedure popOptionsPopup(Sender: TObject);
    function GetActiveLanguageIndex: integer;
    procedure UpdateCEPanel(bDocking : boolean);
  private
    { Private declarations }
    fDockMe: boolean;
    fMouseNode : TTreeNode;
    procedure WMDoDock(var Message: TMessage); message WM_DODOCK;
    procedure PopupHandler(Sender: TObject);
    procedure CreatePopupMenus;
    procedure CreateTreeSaver;
    function GetTemplate(const aLang, aIndex : integer) : string;
    procedure DoAddConstruct(const aTemplate : string; const aX : integer = -1; const aY : integer = -1);
  public
    { Public declarations }
    ConstructMenu: TOfficePopupMenu;
    tsvTemplates: TBricxCCTreeSave;
    procedure CreateConstructPanel;
    procedure CreateConstructPopup;
    procedure Rebuild(bSave : boolean = true);
    procedure DoTemplateInsert(x : integer = -1; y : integer = -1);
    procedure RestoreTemplateTree;
    procedure SaveTemplateTree;
    property  DockMe : boolean read fDockMe write fDockMe;
    property  ActiveLanguageIndex : integer read GetActiveLanguageIndex write fActiveLanguageIndex;
    property  OnAddConstruct : TOnAddConstructEvent read fOnAddConstruct write fOnAddConstruct;
  end;

var
  ConstructForm: TConstructForm;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  Registry, uLocalizedStrings, uBasicPrefs, uRegUtils, uGuiUtils;

const IMARGIN = 2;
      IHEIGHT = 16;

function MakeMenuString(constr:string):string;
var
  str : string;
  i : integer;
  len : integer;
begin
  str := '';
  i := 1;
  len := Length(constr);
  while i <= len do
  begin
    if constr[i] = '\' then
    begin
      i:=i+2;
    end else if constr[i] = '"' then
    begin
      str:=str+'..';
      repeat i:=i+1 until (i = len) or (constr[i] = '"');
      i:=i+1;
    end else if Copy(constr, i, 12) = 'SENSOR_MODE_' then
    begin
      str:=str+'_';
      i:=i+12;
    end else if Copy(constr, i, 12) = 'SENSOR_TYPE_' then
    begin
      str:=str+'_';
      i:=i+12;
    end else if Copy(constr, i, 7) = 'SENSOR_' then
    begin
      str:=str+'_';
      i:=i+7;
    end else if Copy(constr, i, 6) = 'SOUND_' then
    begin
      str:=str+'_';
      i:=i+6;
    end else begin
      str:=str+constr[i];
      i:=i+1;
    end;
  end;
  Result := str;
end;

procedure TConstructForm.CreateConstructPanel;
var
  str:string;
  newNode, CurNode : TTreeNode;
  i, cnt, ali : integer;
begin
{$IFNDEF FPC}
  treTemplates.Items.BeginUpdate;
  try
{$ENDIF}
    treTemplates.Items.Clear;
    curNode := nil;
    cnt := 0;
    i := 1;
    ali := ActiveLanguageIndex;
    while i <= templatenumb[ali] do
    begin
      str:=MakeMenuString(templates[ali][i-1]);
      if (str <> '') and ((str[1] = '-') or (str[1] = '|')) then
      begin
        Delete(str, 1, 1);
        str := Trim(str);
        if str = '' then
          str := 'Group' + IntToStr(cnt);
        curNode := treTemplates.Items.AddChild(nil, str);
        inc(cnt);
      end
      else
      begin
        if curNode = nil then
        begin
          // create a group
          curNode := treTemplates.Items.AddChild(nil, 'Group' + IntToStr(cnt));
          inc(cnt);
        end;
        newNode := treTemplates.Items.AddChild(curNode, str);
        newNode.Data := Pointer(i);
      end;
      inc(i);
    end;
{$IFNDEF FPC}
  finally
    treTemplates.Items.EndUpdate;
  end;
{$ENDIF}
end;

{Popup menu}

procedure TConstructForm.CreateConstructPopup;
var i:integer;
    mitem:TOfficeMenuItem;
    str:string;
    vsep:boolean;
begin
  ConstructMenu.Items.Clear;
//  {Remove old contents}
//  for i:= ConstructMenu.Items.Count-1 downto 0 do
//    ConstructMenu.Items.Delete(i);

  vsep:=false;
  for i:=1 to templatenumb[ActiveLanguageIndex] do
  begin
    str:=MakeMenuString(templates[ActiveLanguageIndex][i-1]);
    if str = '' then Continue;
    if str[1] = '|' then
    begin
      vsep := true;
    end else begin
      mitem := TOfficeMenuItem.Create(Self);
      if str[1] = '-' then
        str := '-';
      mitem.Caption := str;
{$IFNDEF FPC}
      if vsep then
        mitem.Break:=mbBarBreak;
{$ENDIF}
      mitem.OnClick := PopUpHandler;
      if str[1] <> '-' then mitem.Tag := i else mitem.Tag := 0;
      ConstructMenu.Items.Add(mitem);
      vsep:=false;
    end;
  end;
end;

procedure TConstructForm.PopupHandler(Sender: TObject);
begin
  if TOfficeMenuItem(Sender).Tag = 0 then Exit;
  DoAddConstruct(GetTemplate(ActiveLanguageIndex, TOfficeMenuItem(Sender).Tag));
end;

procedure TConstructForm.treTemplatesClick(Sender: TObject);
begin
  if TemplatesUseDblClick then Exit;
  DoTemplateInsert;
end;

procedure TConstructForm.FormCreate(Sender: TObject);
begin
  fActiveLanguageIndex := 0;
  CreateTreeSaver;
  CreatePopupMenus;
  treTemplates.PopupMenu := popOptions;
  fDockMe := False;
  DockOrientation := doVertical;
end;

procedure TConstructForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ShowTemplateForm := False;
  UpdateCEPanel(False); // undocking
end;

procedure TConstructForm.FormShow(Sender: TObject);
begin
  if DockMe then
    PostMessage(Self.Handle, WM_DODOCK, 0, 0);
  DockMe := False;
end;

procedure TConstructForm.WMDoDock(var Message: TMessage);
begin
  if Assigned(dockPanel) then
    ManualDock(dockPanel, nil, alBottom);
  // if we dock we need to restore the tree again
  RestoreTemplateTree;
  UpdateCEPanel(True); // docking
end;

procedure TConstructForm.mniExpandAllClick(Sender: TObject);
begin
  treTemplates.Items.BeginUpdate;
  try
    treTemplates.FullExpand;
    if Assigned(treTemplates.Selected) then
    begin
      treTemplates.Selected.MakeVisible;
      treTemplates.Selected.Focused := True;
    end;
  finally
    treTemplates.Items.EndUpdate;
  end;
end;

procedure TConstructForm.mniCollapseAllClick(Sender: TObject);
begin
  treTemplates.Items.BeginUpdate;
  try
    treTemplates.FullCollapse;
    if Assigned(treTemplates.Selected) then
    begin
      treTemplates.Selected.MakeVisible;
      treTemplates.Selected.Focused := True;
    end;
  finally
    treTemplates.Items.EndUpdate;
  end;
{$IFDEF FPC}
  treTemplates.Selected := nil;
{$ELSE}
  treTemplates.ClearSelection;
{$ENDIF}
end;

procedure TConstructForm.mniDblClickInsertClick(Sender: TObject);
begin
  TemplatesUseDblClick := not TemplatesUseDblClick;
end;

procedure TConstructForm.DoTemplateInsert(x : integer; y : integer);
begin
  if Assigned(fMouseNode) and Assigned(treTemplates.Selected) and
     (fMouseNode = treTemplates.Selected) and not fMouseNode.HasChildren then
    DoAddConstruct(GetTemplate(ActiveLanguageIndex, Integer(fMouseNode.Data)), x, y);
end;

procedure TConstructForm.treTemplatesDblClick(Sender: TObject);
begin
  if not TemplatesUseDblClick then Exit;
  DoTemplateInsert;
end;

procedure TConstructForm.popOptionsPopup(Sender: TObject);
begin
  mniDblClickInsert.Checked := TemplatesUseDblClick;
end;

procedure TConstructForm.treTemplatesMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  fMouseNode := treTemplates.GetNodeAt(X, Y);
end;

procedure TConstructForm.treTemplatesMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  fMouseNode := treTemplates.GetNodeAt(X, Y);
end;

procedure TConstructForm.treTemplatesMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  fMouseNode := treTemplates.GetNodeAt(X, Y);
end;

procedure TConstructForm.treTemplatesStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  if Assigned(fMouseNode) and Assigned(treTemplates.Selected) and
     (fMouseNode = treTemplates.Selected) and fMouseNode.HasChildren then
    CancelDrag;
end;

procedure TConstructForm.Rebuild(bSave : boolean);
begin
  if ShowTemplateForm then
  begin
    if bSave then
      SaveTemplateTree;
    CreateConstructPanel;
    RestoreTemplateTree;
  end;
  if ShowTemplatePopup then
    CreateConstructPopUp;
  ConstructMenu.AutoPopup := ShowTemplatePopup;
end;

procedure TConstructForm.treTemplatesDeletion(Sender: TObject;
  Node: TTreeNode);
begin
//  ShowMessage('deleting');
end;

procedure TConstructForm.FormEndDock(Sender, Target: TObject; X,
  Y: Integer);
begin
  // if we dock we need to restore the tree again
  if treTemplates.Items.Count = 0 then
    RestoreTemplateTree;
end;

procedure TConstructForm.CreatePopupMenus;
begin
  ConstructMenu := TOfficePopupMenu.Create(Self);
  ConstructMenu.Name := 'ConstructMenu';
  // popup menu for options
  popOptions := TOfficePopupMenu.Create(Self);
  mniExpandAll := TOfficeMenuItem.Create(Self);
  mniCollapseAll := TOfficeMenuItem.Create(Self);
  mniPopSep1 := TOfficeMenuItem.Create(Self);
  mniDblClickInsert := TOfficeMenuItem.Create(Self);
  AddMenuItems(popOptions.Items, [mniExpandAll, mniCollapseAll, mniPopSep1, mniDblClickInsert]);
//  popOptions.Items.Add([mniExpandAll, mniCollapseAll, mniPopSep1, mniDblClickInsert]);
  with popOptions do
  begin
    Name := 'popOptions';
    OnPopup := popOptionsPopup;
  end;
  with mniExpandAll do
  begin
    Name := 'mniExpandAll';
    Caption := sExpandAll;
    OnClick := mniExpandAllClick;
  end;
  with mniCollapseAll do
  begin
    Name := 'mniCollapseAll';
    Caption := sCollapseAll;
    OnClick := mniCollapseAllClick;
  end;
  with mniPopSep1 do
  begin
    Name := 'mniPopSep1';
    Caption := '-';
  end;
  with mniDblClickInsert do
  begin
    Name := 'mniDblClickInsert';
    Caption := sDoubleClickToInsert;
    OnClick := mniDblClickInsertClick;
  end;
end;

procedure TConstructForm.CreateTreeSaver;
begin
  tsvTemplates := TBricxCCTreeSave.Create(Self);
  with tsvTemplates do
  begin
    Name := 'tsvTemplates';
    TreeView := treTemplates;
  end;
end;

function TConstructForm.GetActiveLanguageIndex: integer;
begin
  Result := fActiveLanguageIndex;
end;

function TConstructForm.GetTemplate(const aLang, aIndex: integer): string;
begin
  Result := templates[aLang][aIndex-1];
end;

procedure TConstructForm.DoAddConstruct(const aTemplate: string; const aX, aY : integer);
begin
  if Assigned(fOnAddConstruct) then
    fOnAddConstruct(Self, aTemplate, aX, aY);
end;

procedure TConstructForm.RestoreTemplateTree;
var
  R : TRegistry;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    if R.OpenKey(fMainKey+'\'+fVersion+'\TemplateTree', false) then
    begin
      tsvTemplates.RestoreFromRegistry(R);
    end;
  finally
    R.Free;
  end;
end;

procedure TConstructForm.SaveTemplateTree;
var
  R : TRegistry;
  keyName : string;
begin
  R := TRegistry.Create;
  try
    R.RootKey := HKEY_CURRENT_USER;
    keyName := fMainKey+'\'+fVersion+'\TemplateTree';
    if R.OpenKey(keyName, true) then
    begin
      tsvTemplates.SaveToRegistry(R);
    end;
  finally
    R.Free;
  end;
end;

procedure TConstructForm.UpdateCEPanel(bDocking : boolean);
var
  CountOK : boolean;
  cnt : integer;
begin
  // am I one of the panel's dock clients?
  if bDocking then
    cnt := 0
  else
  begin
    if HostDockSite <> nil then
      cnt := 1
    else
      cnt := 0;
  end;
  if Assigned(dockPanel) then
  begin
    CountOK := dockPanel.VisibleDockClientCount > cnt;
    if Assigned(panelSplitter) then
    begin
      panelSplitter.Visible := CountOK;
      panelSplitter.Left := dockPanel.Width + 10;
    end;
    dockPanel.Visible := CountOK;
  end;
end;

{$IFDEF FPC}
initialization
  {$i ConstructUnit.lrs}
{$ENDIF}

end.