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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uCodeExplorer;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, ComCtrls, ExtCtrls, ImgList, Menus,
  uBricxCCProcLexer, uParseCommon, uOfficeComp, SynEditHighlighter,
  BricxccSynEdit;

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
    procedure FormDestroy(Sender: TObject);
  private
    popCodeExplorer: TOfficePopupMenu;
    mniViewEditor: TOfficeMenuItem;
    mniClose: TOfficeMenuItem;
    N1: TOfficeMenuItem;
    mniCodeExpProp: TOfficeMenuItem;
    fOnFinishedProcessing: TNotifyEvent;
    fSource: string;
    fEditor: TBricxccSynEdit;
    function GetProcessing: Boolean;
    procedure SetProcessing(const Value: Boolean);
    procedure SetChangedSinceLastProcess(const Value: Boolean);
    procedure CreatePopupMenu;
    function GetProcResults: TStrings;
    function GetActiveHighlighter: TSynCustomHighlighter;
    procedure SetSource(const Value: string);
    function GetActiveEditor: TBricxccSynEdit;
    function ExploredLanguageType: TExploredLanguage;
  private
    { Private declarations }
    fProcResults : TStrings;
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
    procedure ProcessFile(const sName : string; const aSource : string);
    property ChangedSinceLastProcess : Boolean
      read fChangedSinceLastProcess write SetChangedSinceLastProcess;
    property ProcessedResults : TStrings read GetProcResults;
    property OnFinishedProcessing : TNotifyEvent read fOnFinishedProcessing write fOnFinishedProcessing;
    property ActiveHighlighter : TSynCustomHighlighter read GetActiveHighlighter;
    property CurrentFilename : string read fFileName write fFileName;
    property CurrentSource : string read fSource write SetSource;
    property ActiveEditor : TBricxccSynEdit read GetActiveEditor write fEditor;
  end;

var
  frmCodeExplorer: TfrmCodeExplorer;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, uExplorerOptions, uNXCProcLexer, uNBCProcLexer,
  uSPCProcLexer, uPasProcLexer, 
  uLocalizedStrings, uGuiUtils, uBasicPrefs, uMiscDefines, uDebugLogging,
{$IFNDEF NXT_ONLY}
  uNQCProcLexer, uMindScriptProcLexer, uCppProcLexer,
  uForthProcLexer, uLASMProcLexer,
  SynHighlighterForth, SynHighlighterJava, SynHighlighterCpp,
  SynHighlighterMindScript, SynHighlighterLASM, SynHighlighterPas,
{$ENDIF}
  SynHighlighterROPS, SynHighlighterNQC, SynHighlighterNBC;

procedure TfrmCodeExplorer.ClearTree;
var
  i : Integer;
  PT : TProcType;
begin
  if csDestroying in ComponentState then Exit;
  if not Assigned(treCodeExplorer) then Exit;
  if Assigned(fProcResults) then
    fProcResults.Clear;
  treCodeExplorer.Items.BeginUpdate;
  try
    fTopNodeIdx := GetNodeIndex(treCodeExplorer.TopItem);
    fSelNodeIdx := GetNodeIndex(treCodeExplorer.Selected);
    for PT := Low(TProcType) to High(TProcType) do
    begin
      if Assigned(NodeArray[PT]) then
        for i := NodeArray[PT].Count - 1 downto 0 do
{$IFDEF FPC}
          NodeArray[PT].Items[i].Delete;
{$ELSE}
          NodeArray[PT].Item[i].Delete;
{$ENDIF}
    end;
  finally
    treCodeExplorer.Items.EndUpdate;
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
  tmrCodeExplorer.Enabled := False;
end;

procedure TfrmCodeExplorer.FormCreate(Sender: TObject);
begin
  fProcResults := TStringList.Create;
  CreatePopupMenu;
  treCodeExplorer.PopupMenu := popCodeExplorer;
  DockOrientation := doVertical;
  fProcessing := False;
  fFileName := '';
  fSource   := '';
  Caption := sExploring;
  if Assigned(dockPanel) then
    ManualDock(dockPanel, nil, alTop);
//  treCodeExplorer.DoubleBuffered := True;
  RefreshEntireTree;
end;

procedure TfrmCodeExplorer.HandleGetProcsDone(Sender: TObject);
var
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
      fProcResults.Text := fThread.Results;
      for i := 0 to fProcResults.Count - 1 do
      begin
        p := fProcResults[i];
        CreateNode(p);
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
    if Assigned(fOnFinishedProcessing) then
      fOnFinishedProcessing(Self);
  end;
end;

procedure TfrmCodeExplorer.ProcessFile(const sName : string; const aSource : string);
begin
  fFileName := sName;
  fSource   := aSource;
  ReprocessFile;
end;

procedure TfrmCodeExplorer.treCodeExplorerDblClick(Sender: TObject);
begin
  GotoCode;
end;

procedure TfrmCodeExplorer.tmrCodeExplorerTimer(Sender: TObject);
begin
  if ChangedSinceLastProcess then
    ProcessFile(fFileName, fSource);
end;

procedure TfrmCodeExplorer.FormShow(Sender: TObject);
begin
  tmrCodeExplorer.Enabled := True;
end;

procedure TfrmCodeExplorer.FocusEditor;
var
  E : TBricxCCSynEdit;
begin
  E := ActiveEditor;
  if Assigned(E) then
  begin
    SetWindowFocus(E.Parent);
    if not GetUsingMDI then
      E.SetFocus;
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
  E : TBricxCCSynEdit;
begin
  N := treCodeExplorer.Selected;
  E := ActiveEditor;
  if Assigned(N) and Assigned(N.Data) and Assigned(E) then
  begin
    i := Integer(N.Data);
    E.CaretXY := Point(1, i);
    E.EnsureCursorPosVisibleEx(True);
    FocusEditor;
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
  try
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
    for PT := Low(TProcType) to High(TProcType) do
      NodeArray[PT] := nil;
    with treCodeExplorer.Items do
    begin
      BeginUpdate;
      try
        Clear;
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
  except
    // eat exceptions which occur when rebuilding treeview
    on E : EAccessViolation do
    begin
      DebugLog(E);
    end;
    on E : Exception do
    begin
      DebugLog(E.Message);
    end;
  end;
  ReprocessFile;
end;

procedure TfrmCodeExplorer.ReprocessFile;
var
  fGetProcs : TBricxCCProcLexer;
begin
  if Processing then Exit;
  Caption := sExploring + ' ' + fFileName;
  Processing := True;
  ClearTree;
  if fSource <> '' then
  begin
    try
      fGetProcs := CreateProcLexer;
      fGetProcs.FreeOnTerminate := True;
      fGetProcs.OnTerminate := HandleGetProcsDone;
      fGetProcs.TextToParse := fSource;
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

function TfrmCodeExplorer.GetActiveEditor: TBricxccSynEdit;
begin
  Result := uMiscDefines.GetActiveEditor;
end;

function TfrmCodeExplorer.GetActiveHighlighter : TSynCustomHighlighter;
var
  E : TBricxccSynEdit;
begin
  E := ActiveEditor;
  if Assigned(E) then
    Result := E.Highlighter
  else
    Result := nil;
end;

function TfrmCodeExplorer.CreateProcLexer: TBricxCCProcLexer;
var
  H : TSynCustomHighlighter;
begin
  H := GetActiveHighlighter;
  if Assigned(H) then
  begin
    if H is TSynNBCSyn then
      Result := TNBCProcLexer.Create(True)
    else if H is TSynNXCSyn then
      Result := TNXCProcLexer.Create(True)
    else if H is TSynSPCSyn then
      Result := TSPCProcLexer.Create(True)
{$IFNDEF NXT_ONLY}
    else if H is TSynNQCSyn then
      Result := TNQCProcLexer.Create(True)
    else if H is TSynMindScriptSyn then
      Result := TMindScriptProcLexer.Create(True)
    else if H is TSynCppSyn then
      Result := TCppProcLexer.Create(True)
    else if H is TSynPasSyn then
      Result := TPasProcLexer.Create(True)
    else if H is TSynJavaSyn then
      Result := TJavaProcLexer.Create(True)
    else if H is TSynForthSyn then
      Result := TForthProcLexer.Create(True)
    else if H is TSynLASMSyn then
      Result := TLASMProcLexer.Create(True)
{$ENDIF}
    else if H is TSynROPSSyn then
      Result := TPasProcLexer.Create(True)
    else
      Result := TUnknownProcLexer.Create(True);
  end
  else
    Result := TUnknownProcLexer.Create(True);
end;

function TfrmCodeExplorer.ExploredLanguageType : TExploredLanguage;
var
  H : TSynCustomHighlighter;
begin
  H := GetActiveHighlighter;
  if Assigned(H) then
  begin
    if H is TSynNBCSyn then
      Result := elNBC
    else if H is TSynNXCSyn then
      Result := elNXC
    else if H is TSynSPCSyn then
      Result := elSPC
{$IFNDEF NXT_ONLY}
    else if H is TSynNQCSyn then
      Result := elNQC
    else if H is TSynMindScriptSyn then
      Result := elMindScript
    else if H is TSynCppSyn then
      Result := elCpp
    else if H is TSynPasSyn then
      Result := elPas
    else if H is TSynJavaSyn then
      Result := elJava
    else if H is TSynForthSyn then
      Result := elForth
    else if H is TSynLASMSyn then
      Result := elLASM
{$ENDIF}
    else if H is TSynROPSSyn then
      Result := elPas
    else
      Result := elUnknown;
  end
  else
    Result := elUnknown;
end;

procedure TfrmCodeExplorer.SetChangedSinceLastProcess(const Value: Boolean);
begin
  fChangedSinceLastProcess := Value;
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
  AddMenuItems(popCodeExplorer.Items, [mniViewEditor, mniClose, N1, mniCodeExpProp]);
//  popCodeExplorer.Items.Add([mniViewEditor, mniClose, N1, mniCodeExpProp]);
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

function TfrmCodeExplorer.GetProcResults: TStrings;
begin
  Result := fProcResults;
end;

procedure TfrmCodeExplorer.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fProcResults);
  frmCodeExplorer := nil;
end;

procedure TfrmCodeExplorer.SetSource(const Value: string);
begin
  if fSource <> Value then
  begin
    fSource := Value;
    ChangedSinceLastProcess := True;
  end;
end;

{$IFDEF FPC}
initialization
  {$i uCodeExplorer.lrs}
{$ENDIF}

end.