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
unit uCodeExplorer;

interface

uses
  Classes, Controls, Forms, ComCtrls, ExtCtrls, ImgList, Menus,
  uBricxCCProcLexer, uParseCommon, uOfficeComp;

type
  TfrmCodeExplorer = class(TForm)
    treCodeExplorer: TTreeView;
    tmrCodeExplorer: TTimer;
    ilCodeExplorer: TImageList;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure treCodeExplorerDblClick(Sender: TObject);
    procedure tmrCodeExplorerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure treCodeExplorerKeyPress(Sender: TObject; var Key: Char);
    procedure mniCodeExpPropClick(Sender: TObject);
    procedure mniViewEditorClick(Sender: TObject);
    procedure mniCloseClick(Sender: TObject);
  private
    popCodeExplorer: TOfficePopupMenu;
    mniViewEditor: TOfficeMenuItem;
    mniClose: TOfficeMenuItem;
    N1: TOfficeMenuItem;
    mniCodeExpProp: TOfficeMenuItem;
    function GetProcessing: Boolean;
    procedure SetProcessing(const Value: Boolean);
    procedure SetChangedSinceLastProcess(const Value: Boolean);
    procedure CreatePopupMenu;
  private
    { Private declarations }
    fChangedSinceLastProcess : Boolean;
    NodeArray : array[TProcType] of TTreeNode;
    fFileName: string;
    fProcessing : Boolean;
    fTopNodeIdx, fSelNodeIdx : Integer;
    procedure HandleGetProcsDone(Sender: TObject);
    procedure CreateNode(aStr : string);
    procedure FocusEditor;
    procedure GotoCode;
    procedure ReprocessFile;
    function GetNodeIndex(aNode : TTreeNode) : Integer;
    function FindNode(aIdx : Integer) : TTreeNode;
    function CreateProcLexer : TBricxCCProcLexer;
    property Processing : Boolean read GetProcessing write SetProcessing;
  public
    { Public declarations }
    procedure RefreshEntireTree;
    procedure ClearTree;
    procedure ProcessFile(sName : string);
    property ChangedSinceLastProcess : Boolean
      read fChangedSinceLastProcess write SetChangedSinceLastProcess;
  end;

var
  frmCodeExplorer: TfrmCodeExplorer;

implementation

{$R *.DFM}

uses
  SysUtils, MainUnit, Editor, uExplorerOptions, uNQCProcLexer,
  uNXCProcLexer, uMindScriptProcLexer, uCppProcLexer, uPasProcLexer,
  uForthProcLexer, uNBCProcLexer, uLASMProcLexer, uMiscDefines,
  uLocalizedStrings, uGuiUtils, Preferences, SynEditHighlighter;

procedure TfrmCodeExplorer.ClearTree;
var
  i : Integer;
  PT : TProcType;
begin
  if Assigned(treCodeExplorer) then
  begin
    treCodeExplorer.Items.BeginUpdate;
    try
      fTopNodeIdx := GetNodeIndex(treCodeExplorer.TopItem);
      fSelNodeIdx := GetNodeIndex(treCodeExplorer.Selected);
      for PT := Low(TProcType) to High(TProcType) do
      begin
        if Assigned(NodeArray[PT]) then
          for i := NodeArray[PT].Count - 1 downto 0 do
            NodeArray[PT].Item[i].Delete;
      end;
    finally
      treCodeExplorer.Items.EndUpdate;
    end;
  end;
end;

procedure TfrmCodeExplorer.CreateNode(aStr: string);
var
  pType, pName, pLine : string;
  i : Integer;
  N : TTreeNode;
  PT : TProcType;
const
  PROC_TYPE_IMAGES_COUNT = 9; // the # of led images in the image list
begin
  N := nil;
  i := Pos('|', aStr);
  pLine := Copy(aStr, 1, i - 1);
  Delete(aStr, 1, i);
  i := Pos('|', aStr);
  pType := Copy(aStr, 1, i - 1);
  Delete(aStr, 1, i);
  pName := aStr;
  for PT := Low(TProcType) to High(TProcType) do
  begin
    if (pType = PROC_NAMES[PT]) and Assigned(NodeArray[PT]) then begin
      N := treCodeExplorer.Items.AddChild(NodeArray[PT], pName);
      N.ImageIndex := Ord(PT)+1;
      N.SelectedIndex := N.ImageIndex + PROC_TYPE_IMAGES_COUNT;
      Break;
    end;
  end;
  if Assigned(N) then
    N.Data := Pointer(StrToIntDef(pLine, 0) + 1);
end;

procedure TfrmCodeExplorer.FormClose(Sender: TObject;
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
  tmrCodeExplorer.Enabled := False;
end;

procedure TfrmCodeExplorer.FormCreate(Sender: TObject);
begin
  CreatePopupMenu;
  treCodeExplorer.PopupMenu := popCodeExplorer;
  DockOrientation := doVertical;
  fProcessing := False;
  Caption := sExploring;
  ManualDock(MainForm.pnlCodeExplorer, nil, alTop);
//  treCodeExplorer.DoubleBuffered := True;
  RefreshEntireTree;
end;

procedure TfrmCodeExplorer.HandleGetProcsDone(Sender: TObject);
var
  S : TStrings;
  i : Integer;
  p : string;
  fThread : TBricxCCProcLexer;
  N : TTreeNode;
  PT : TProcType;
begin
  if not (csDestroying in ComponentState) and (Sender is TBricxCCProcLexer) then
  begin
    fThread := TBricxCCProcLexer(Sender);
    fThread.OnTerminate := nil;
    // build nodes in tree view
    try
      S := TStringList.Create;
      try
        S.Text := fThread.Results;
        for i := 0 to S.Count - 1 do
        begin
          p := S[i];
          CreateNode(p);
        end;
      finally
        S.Free;
      end;
      for PT := Low(TProcType) to High(TProcType) do
      begin
        if Assigned(NodeArray[PT]) then
          NodeArray[PT].Expanded := CodeExplorerSettings.Expand[PT];
      end;
      ChangedSinceLastProcess := False;
      if CodeExplorerSettings.UseAlphaSort then
      begin
        for PT := Low(TProcType) to High(TProcType) do
        begin
          if Assigned(NodeArray[PT]) then
            NodeArray[PT].AlphaSort;
        end;
      end;
      N := FindNode(fSelNodeIdx);
      if Assigned(N) then
        treCodeExplorer.Selected := N;
      N := FindNode(fTopNodeIdx);
      if Assigned(N) then
        treCodeExplorer.TopItem := N;
    finally
      Processing := False;
    end;
  end;
end;

procedure TfrmCodeExplorer.ProcessFile(sName : string);
begin
  fFileName := sName;
  ReprocessFile;
end;

procedure TfrmCodeExplorer.treCodeExplorerDblClick(Sender: TObject);
begin
  GotoCode;
end;

procedure TfrmCodeExplorer.tmrCodeExplorerTimer(Sender: TObject);
begin
  if ChangedSinceLastProcess then
    ProcessFile(fFileName);
end;

procedure TfrmCodeExplorer.FormShow(Sender: TObject);
begin
  tmrCodeExplorer.Enabled := True;
end;

procedure TfrmCodeExplorer.FocusEditor;
var
  AEF : TEditorForm;
begin
  if Assigned(MainForm) then
  begin
    AEF := MainForm.ActiveEditorForm;
    if Assigned(AEF) then
    begin
      SetWindowFocus(AEF);
      if not MainForm.MDI then
        AEF.TheEditor.SetFocus;
    end;
  end;
end;

procedure TfrmCodeExplorer.treCodeExplorerKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then GotoCode;
end;

procedure TfrmCodeExplorer.GotoCode;
var
  i : Integer;
  N : TTreeNode;
  AEF : TEditorForm;
begin
  N := treCodeExplorer.Selected;
  if Assigned(N) and Assigned(N.Data) and Assigned(MainForm) then
  begin
    AEF := MainForm.ActiveEditorForm;
    if Assigned(AEF) then
    begin
      i := Integer(N.Data);
      with AEF.TheEditor do
      begin
        CaretXY := Point(1, i);
        EnsureCursorPosVisibleEx(True);
      end;
      FocusEditor;
    end;
  end;
end;

procedure TfrmCodeExplorer.mniCodeExpPropClick(Sender: TObject);
begin
  with TfrmExplorerOptions.Create(nil) do
  try
    // set up form
    ConfigureForm(CodeExplorerSettings);
    if ShowModal = mrOk then
    begin
      // read values from form
      UpdateDefaults(CodeExplorerSettings);
      RefreshEntireTree;
    end;
  finally
    Free;
  end;
end;

procedure TfrmCodeExplorer.RefreshEntireTree;
var
  ItemOrder : string;
  p : integer;
  s : string;
  PT : TProcType;
  EL : TExploredLanguage;
begin
  EL := ExploredLanguageType;
  ItemOrder := CodeExplorerSettings.CategorySort;
  if ItemOrder = '' then
  begin
    for PT := Low(TProcType) to High(TProcType) do
    begin
      ItemOrder := ItemOrder + PROC_TYPES[PT] + ';';
    end;
    Delete(ItemOrder, Length(ItemOrder), 1);
  end;
  with treCodeExplorer.Items do
  begin
    BeginUpdate;
    try
      Clear;
      for PT := Low(TProcType) to High(TProcType) do
        NodeArray[PT] := nil;
      while Length(ItemOrder) > 0 do begin
        p := Pos(';', ItemOrder);
        if p = 0 then p := Length(ItemOrder) + 1;
        s := Copy(ItemOrder, 1, p-1);
        System.Delete(ItemOrder, 1, p);
        for PT := Low(TProcType) to High(TProcType) do
        begin
          if s = PROC_TYPES[PT] then
          begin
            if CodeExplorerSettings.Visible[PT] and VISIBLE_PROC_TYPES[EL, PT] then
              NodeArray[PT] := Add(nil, s);
            Break;
          end;
        end;
      end;
    finally
      EndUpdate;
    end;
  end;
  ReprocessFile;
end;

procedure TfrmCodeExplorer.ReprocessFile;
var
  fGetProcs : TBricxCCProcLexer;
  AEF : TEditorForm;
begin
  if not Assigned(MainForm) then Exit;
  if Processing then Exit;
  Caption := sExploring + ' ' + fFileName;
  Processing := True;
  ClearTree;
  AEF := MainForm.ActiveEditorForm;
  if Assigned(AEF) then
  begin
    if (AEF.TheEditor.Lines.Count = 0) or not FileCanBeProcessed then
    begin
      Processing := False;
      Exit;
    end;

    try
      fGetProcs := CreateProcLexer;
      fGetProcs.FreeOnTerminate := True;
      fGetProcs.OnTerminate := HandleGetProcsDone;
      fGetProcs.TextToParse := AEF.TheEditor.Lines.Text;
      fGetProcs.Timeout     := ParseTimeout; // default is 2 seconds
      fGetProcs.Resume;
    except
      Processing := False;
      raise;
    end;
  end
  else
  begin
    Processing := False;
  end;
end;

procedure TfrmCodeExplorer.mniViewEditorClick(Sender: TObject);
begin
  FocusEditor;
end;

function TfrmCodeExplorer.GetProcessing: Boolean;
begin
  Result := fProcessing;
end;

procedure TfrmCodeExplorer.SetProcessing(const Value: Boolean);
begin
  if Value <> fProcessing then
  begin
    fProcessing := Value;
    if Value then
      treCodeExplorer.Items.BeginUpdate
    else
      treCodeExplorer.Items.EndUpdate;
  end;
end;

function TfrmCodeExplorer.FindNode(aIdx: Integer): TTreeNode;
begin
  Result := nil;
  if (aIdx >= 0) and (aIdx < treCodeExplorer.Items.Count) then
    Result := treCodeExplorer.Items[aIdx];
end;

function TfrmCodeExplorer.GetNodeIndex(aNode: TTreeNode): Integer;
begin
  Result := -1;
  if Assigned(aNode) then
    Result := aNode.AbsoluteIndex;
end;

function TfrmCodeExplorer.CreateProcLexer: TBricxCCProcLexer;
var
  H : TSynCustomHighlighter;
  AEF : TEditorForm;
begin
  if not Assigned(MainForm) then
    raise Exception.Create(sUnableToParseFile);
  AEF := MainForm.ActiveEditorForm;
  if Assigned(AEF) then
  begin
    H := AEF.Highlighter;
    if H = MainForm.SynNQCSyn then
      Result := TNQCProcLexer.Create(True)
    else if H = MainForm.SynMindScriptSyn then
      Result := TMindScriptProcLexer.Create(True)
    else if H = MainForm.SynCppSyn then
      Result := TCppProcLexer.Create(True)
    else if H = MainForm.SynPasSyn then
      Result := TPasProcLexer.Create(True)
    else if H = MainForm.SynROPSSyn then
      Result := TPasProcLexer.Create(True)
    else if H = MainForm.SynJavaSyn then
      Result := TJavaProcLexer.Create(True)
    else if H = MainForm.SynForthSyn then
      Result := TForthProcLexer.Create(True)
    else if H = MainForm.SynNBCSyn then
      Result := TNBCProcLexer.Create(True)
    else if H = MainForm.SynNXCSyn then
      Result := TNXCProcLexer.Create(True)
    else if H = MainForm.SynLASMSyn then
      Result := TLASMProcLexer.Create(True)
    else
      raise Exception.Create(sUnableToParseFile);
  end
  else
    raise Exception.Create(sUnableToParseFile);
end;

procedure TfrmCodeExplorer.SetChangedSinceLastProcess(const Value: Boolean);
begin
  if Value then
    fChangedSinceLastProcess := FileCanBeProcessed
  else
    fChangedSinceLastProcess := False;
end;

procedure TfrmCodeExplorer.mniCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCodeExplorer.CreatePopupMenu;
begin
  popCodeExplorer := TOfficePopupMenu.Create(Self);
  popCodeExplorer.Name := 'popCodeExplorer';
  mniViewEditor := TOfficeMenuItem.Create(popCodeExplorer);
  mniClose := TOfficeMenuItem.Create(popCodeExplorer);
  N1 := TOfficeMenuItem.Create(popCodeExplorer);
  mniCodeExpProp := TOfficeMenuItem.Create(popCodeExplorer);
  popCodeExplorer.Items.Add([mniViewEditor, mniClose, N1, mniCodeExpProp]);
  with mniViewEditor do
  begin
    Name := 'mniViewEditor';
    Caption := 'View Editor';
    ShortCut := 24645;
    OnClick := mniViewEditorClick;
  end;
  with mniClose do
  begin
    Name := 'mniClose';
    Caption := 'Close';
    OnClick := mniCloseClick;
  end;
  with N1 do
  begin
    Name := 'N1';
    Caption := '-';
  end;
  with mniCodeExpProp do
  begin
    Name := 'mniCodeExpProp';
    Caption := 'Properties';
    OnClick := mniCodeExpPropClick;
  end;
end;

end.
