unit ConstructUnit;

interface

uses
  Messages, Classes, Controls, Forms, ExtCtrls, StdCtrls,
  ComCtrls, uOfficeComp, uTreeSaver;

const
  WM_DODOCK = WM_USER + 400;

type
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
    procedure mniExpandAllClick(Sender: TObject);
    procedure mniCollapseAllClick(Sender: TObject);
    procedure mniDblClickInsertClick(Sender: TObject);
    procedure popOptionsPopup(Sender: TObject);
  private
    { Private declarations }
    fDockMe: boolean;
    fMouseNode : TTreeNode;
    procedure WMDoDock(var Message: TWMPaint); message WM_DODOCK;
    procedure PopupHandler(Sender: TObject);
    procedure CreatePopupMenus;
    procedure CreateTreeSaver;
  public
    { Public declarations }
    ConstructMenu: TOfficePopupMenu;
    tsvTemplates: TBricxCCTreeSave;
    procedure CreateConstructPanel;
    procedure CreateConstructPopup;
    procedure Rebuild(bSave : boolean = true);
    procedure DoTemplateInsert(x : integer = -1; y : integer = -1);
    property  DockMe : boolean read fDockMe write fDockMe;
  end;

var
  ConstructForm: TConstructForm;

implementation

{$R *.DFM}

uses
  SysUtils, Menus, Preferences, MainUnit, Editor, uLocalizedStrings,
  uCommonUtils;

const IMARGIN = 2;
      IHEIGHT = 16;

function MakeMenuString(constr:string):string;
var str:string;
    i:integer;
begin
  str:='';
  i:=1;
  while i<= Length(constr) do
  begin
    if constr[i] = '\' then
    begin
      i:=i+2;
    end else if constr[i] = '"' then
    begin
      str:=str+'..';
      repeat i:=i+1 until constr[i] = '"';
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
  treTemplates.Items.BeginUpdate;
  try
    treTemplates.Items.Clear;
    curNode := nil;
    cnt := 0;
    i := 1;
    if not Assigned(MainForm) then Exit;
    ali := MainForm.ActiveLanguageIndex;
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
  finally
    treTemplates.Items.EndUpdate;
  end;
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
  for i:=1 to templatenumb[MainForm.ActiveLanguageIndex] do
  begin
    str:=MakeMenuString(templates[MainForm.ActiveLanguageIndex][i-1]);
    if str = '' then Continue;
    if str[1] = '|' then
    begin
      vsep := true;
    end else begin
      mitem := TOfficeMenuItem.Create(Self);
      if str[1] = '-' then
        str := '-';
      mitem.Caption := str;
      if vsep then mitem.Break:=mbBarBreak;
      mitem.OnClick := PopUpHandler;
      if str[1] <> '-' then mitem.Tag := i else mitem.Tag := 0;
      ConstructMenu.Items.Add(mitem);
      vsep:=false;
    end;
  end;
end;

procedure TConstructForm.PopupHandler(Sender: TObject);
var
  AEF : TEditorForm;
begin
  if TOfficeMenuItem(Sender).Tag = 0 then Exit;
  AEF := MainForm.ActiveEditorForm;
  if AEF = nil then Exit;
  AEF.AddConstruct(MainForm.ActiveLanguageIndex, TOfficeMenuItem(Sender).Tag);
end;

procedure TConstructForm.treTemplatesClick(Sender: TObject);
begin
  if TemplatesUseDblClick then Exit;
  DoTemplateInsert;
end;

procedure TConstructForm.FormCreate(Sender: TObject);
begin
  CreateTreeSaver;
  CreatePopupMenus;
  treTemplates.PopupMenu := popOptions;
  fDockMe := False;
  DockOrientation := doVertical;
end;

procedure TConstructForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
  CountOK, IAmDocked : boolean;
  cnt : integer;
begin
  // am I one of the panel's dock clients?
  IAmDocked := HostDockSite <> nil;
  if IAmDocked then
    cnt := 1
  else
    cnt := 0;
  CountOK := MainForm.pnlCodeExplorer.VisibleDockClientCount > cnt;
  MainForm.splCodeExplorer.Visible := CountOK;
  MainForm.pnlCodeExplorer.Visible := CountOK;
end;

procedure TConstructForm.FormShow(Sender: TObject);
begin
  if DockMe then
    PostWindowMessage(Self.Handle, WM_DODOCK, 0, 0);
  DockMe := False;
end;

procedure TConstructForm.WMDoDock(var Message: TWMPaint);
begin
  ManualDock(MainForm.pnlCodeExplorer, nil, alBottom);
  // if we dock we need to restore the tree again
  RestoreTemplateTree;
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
  treTemplates.ClearSelection;
end;

procedure TConstructForm.mniDblClickInsertClick(Sender: TObject);
begin
  TemplatesUseDblClick := not TemplatesUseDblClick;
end;

procedure TConstructForm.DoTemplateInsert(x : integer; y : integer);
var
  AEF : TEditorForm;
begin
  AEF := MainForm.ActiveEditorForm;
  if AEF = nil then Exit;
  if Assigned(fMouseNode) and Assigned(treTemplates.Selected) and
     (fMouseNode = treTemplates.Selected) and not fMouseNode.HasChildren then
    AEF.AddConstruct(MainForm.ActiveLanguageIndex, Integer(fMouseNode.Data), x, y);
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
  popOptions.Items.Add([mniExpandAll, mniCollapseAll, mniPopSep1, mniDblClickInsert]);
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

end.
