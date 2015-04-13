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
unit uNXTExplorer;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LResources,
  EditBtn,
{$ENDIF}
  Messages, Classes, Controls, Forms, ShellCtrls,
  ComCtrls, FileCtrl, StdCtrls, Buttons, ExtCtrls, uOfficeComp,
  ActnList, Menus, Dialogs, ImgList;

type
{$IFNDEF FPC}
  TShellTreeViewEx = class(TShellTreeView)
  public
    property ReadOnly;
  end;

  TShellListViewEx = class(TShellListView)
  public
    function GetPathFromIndex(const idx : integer) : string;
  end;
{$ENDIF}

  { TfrmNXTExplorer }

  TfrmNXTExplorer = class(TForm)
    pnlLeft: TPanel;
    NXTFiles: TListView;
    Actions: TActionList;
    actViewToolbar: TAction;
    actNXTViewStyleLargeIcon: TAction;
    actNXTViewStyleSmallIcon: TAction;
    actNXTViewStyleList: TAction;
    actNXTViewStyleDetails: TAction;
    actFileRefresh: TAction;
    actFileDelete: TAction;
    actFileUpload: TAction;
    actFileDownload: TAction;
    actPCViewStyleLargeIcon: TAction;
    actPCViewStyleSmallIcon: TAction;
    actPCViewStyleList: TAction;
    actPCViewStyleDetails: TAction;
    actFileExecute: TAction;
    ilLarge: TImageList;
    ilSmall: TImageList;
    actFileStop: TAction;
    actFilePlay: TAction;
    actFileMute: TAction;
    actFileEraseAll: TAction;
    actEditSelectAll: TAction;
    actFileDefrag: TAction;
    actFileView: TAction;
    lblPath: TLabel;
    barProgress: TProgressBar;
{$IFNDEF FPC}
    pnlTopLeft: TPanel;
    pnlRight: TPanel;
    Splitter1: TSplitter;
    actFileCreateFolder: TAction;
{$ENDIF}
    procedure FormCreate(Sender: TObject);
    procedure actViewToolbarExecute(Sender: TObject);
    procedure actViewStyleExecute(Sender: TObject);
    procedure ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure actFileRefreshExecute(Sender: TObject);
    procedure actFileDeleteExecute(Sender: TObject);
    procedure actFileUploadExecute(Sender: TObject);
    procedure actFileDownloadExecute(Sender: TObject);
    procedure actFileExecuteExecute(Sender: TObject);
    procedure actFileStopExecute(Sender: TObject);
    procedure actFilePlayExecute(Sender: TObject);
    procedure actFileMuteExecute(Sender: TObject);
    procedure actFileEraseAllExecute(Sender: TObject);
    procedure NXTFilesEditing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure NXTFilesEdited(Sender: TObject; Item: TListItem;
      var S: String);
    procedure NXTFilesDblClick(Sender: TObject);
    procedure actEditSelectAllExecute(Sender: TObject);
    procedure actFileDefragExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure actFileViewExecute(Sender: TObject);
    procedure actPCViewStyleExecute(Sender: TObject);
    procedure lblPathDblClick(Sender: TObject);
{$IFNDEF FPC}
    procedure NXTFilesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure NXTFilesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure RefreshShellListView(Sender: TObject);
    procedure actFileCreateFolderExecute(Sender: TObject);
{$ELSE}
  published
    ilToolbar: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
{$ENDIF}
  private
    mnuMain: TOfficeMainMenu;
    File1: TOfficeMenuItem;
    Refresh1: TOfficeMenuItem;
    Delete1: TOfficeMenuItem;
    EraseAll1: TOfficeMenuItem;
    mniDefrag: TOfficeMenuItem;
    N6: TOfficeMenuItem;
    Upload1: TOfficeMenuItem;
    Download1: TOfficeMenuItem;
    View2: TOfficeMenuItem;
    N7: TOfficeMenuItem;
    Execute1: TOfficeMenuItem;
    Stop1: TOfficeMenuItem;
    N3: TOfficeMenuItem;
    Play1: TOfficeMenuItem;
    Mute1: TOfficeMenuItem;
    N2: TOfficeMenuItem;
    Exit1: TOfficeMenuItem;
    Edit2: TOfficeMenuItem;
    mniSelectAll: TOfficeMenuItem;
    View1: TOfficeMenuItem;
    NXTViewStyle2: TOfficeMenuItem;
    LargeIcons2: TOfficeMenuItem;
    SmallIcons2: TOfficeMenuItem;
    List2: TOfficeMenuItem;
    Details2: TOfficeMenuItem;
    PCViewStyle1: TOfficeMenuItem;
    LargeIcons3: TOfficeMenuItem;
    SmallIcons3: TOfficeMenuItem;
    List3: TOfficeMenuItem;
    Details3: TOfficeMenuItem;
    N5: TOfficeMenuItem;
    ShowToolbar1: TOfficeMenuItem;
    Help1: TOfficeMenuItem;
    About1: TOfficeMenuItem;
    pmuNXT: TPopupMenu;
    mniRefresh: TOfficeMenuItem;
    mniDelete: TOfficeMenuItem;
    mniPopEraseAll: TOfficeMenuItem;
    mniPopDefrag: TOfficeMenuItem;
    mniSep6: TOfficeMenuItem;
    mniUpload: TOfficeMenuItem;
    mniDownload: TOfficeMenuItem;
    mniView: TOfficeMenuItem;
    mniCreateFolder: TOfficeMenuItem;
    mniSep5: TOfficeMenuItem;
    mniExecute: TOfficeMenuItem;
    mniFileStop: TOfficeMenuItem;
    N1: TOfficeMenuItem;
    mniPlay: TOfficeMenuItem;
    mniMute: TOfficeMenuItem;
    mniSep3: TOfficeMenuItem;
    mniViewStyle: TOfficeMenuItem;
    mitLargeIcons: TOfficeMenuItem;
    mitSmallIcons: TOfficeMenuItem;
    mitList: TOfficeMenuItem;
    mitDetails: TOfficeMenuItem;
    NXTViewStyle1: TOfficeMenuItem;
    LargeIcons1: TOfficeMenuItem;
    SmallIcons1: TOfficeMenuItem;
    List1: TOfficeMenuItem;
    Details1: TOfficeMenuItem;
    mniSep4: TOfficeMenuItem;
    mniShowToolbar: TOfficeMenuItem;
    cbrExplorerTop: TOfficeControlBar;
    ogpNXTExplorer: TOfficeGradientPanel;
    osbUpload: TOfficeSpeedButton;
    osbDelete: TOfficeSpeedButton;
    osbRefresh: TOfficeSpeedButton;
    osbDownload: TOfficeSpeedButton;
    bvlFile2: TBevel;
    osbExecute: TOfficeSpeedButton;
    obsStop: TOfficeSpeedButton;
    bvlStop2: TBevel;
    osbPlay: TOfficeSpeedButton;
    bvlPlay2: TBevel;
    osbMute: TOfficeSpeedButton;
    bvlMute2: TBevel;
    osbEraseAll: TOfficeSpeedButton;
    osbDefrag: TOfficeSpeedButton;
    osbView: TOfficeSpeedButton;
    fCurrentBrickFolder : string;
    procedure CreateToolbar;
    procedure CreateMainMenu;
    procedure CreatePopupMenu;
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure SetCurrentBrickFolder(const Value: string);
    procedure SetCurrent(const Value: integer);
    procedure SetTotal(const Value: integer);
  public
{$IFNDEF FPC}
    cboMask: TFilterComboBox;
    treShell: TShellTreeViewEx;
    Splitter2: TSplitter;
    lstFiles: TShellListViewEx;
    procedure lstFilesAddFolder(Sender: TObject; AFolder: TShellFolder;
      var CanAdd: Boolean);
    procedure lstFilesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lstFilesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure treShellChange(Sender: TObject; Node: TTreeNode);
    procedure lstFilesDblClick(Sender: TObject);
{$ELSE}
    dlgDirectory : TSelectDirectoryDialog;
    dlgOpen : TOpenDialog;
    fLastLocalPath : string;
{$ENDIF}
  private
    { Private declarations }
    fTotal : integer;
    fCur : integer;
    fMasks : TStringList;
    procedure PopulateMaskList;
    procedure cboMaskChange(Sender: TObject);
{$IFNDEF FPC}
    procedure CreateShellControls;
    procedure WMDROPFILES(var Message: TWMDROPFILES); message WM_DROPFILES;
    function InNXTView(p : TPoint) : boolean;
    procedure RefreshLocalFileList;
{$ENDIF}
    procedure ConfigureForm;
    procedure RefreshNXTFiles;
    procedure SetColorScheme;
    function SelectedFileIsExecutable : boolean;
    function SelectedFileIsSound : boolean;
    function IsInMask(const ext: string): boolean;
    function DoUploadFile(const aFile : string) : boolean;
    function DoDownloadFile(const aFile : string) : boolean;
    function GetLocalFilePath : string;
    procedure ChangeFolder(aFolder : string);
    procedure HandleDownloadStart(Sender : TObject);
    procedure HandleDownloadDone(Sender : TObject);
    procedure HandleDownloadStatus(Sender : TObject; cur, total : Integer; var Abort : boolean);
    property ProgressTotal : integer read fTotal write SetTotal;
    property Current : integer read fCur write SetCurrent;
  public
    { Public declarations }
    property CurrentBrickFolder : string read fCurrentBrickFolder write SetCurrentBrickFolder;
  end;

var
  frmNXTExplorer: TfrmNXTExplorer;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  SysUtils, Graphics, Themes,
{$IFNDEF FPC}
  ShellAPI, 
  uHEXViewer,
{$ELSE}
  FileUtil,
{$ENDIF}
  brick_common, uGuiUtils, uCompCommon, uMiscDefines, uGlobals, uProgress,
  uSpirit, uNXTExplorerSettings, uLocalizedStrings, uDebugLogging,
  uTextViewer, uCommonUtils;

const
  K_FILTER =
    'All files (*.*)|*.*|' +
    'All NXT files (*.rxe; *.rtm; *.rpg; *.rso; *.ric; *.rmd; *.rdt; *.sys)|' +
      '*.rxe;*.rtm;*.rpg;*.rso;*.ric;*.rmd;*.rdt;*.sys|' +
    'NXT Executable files (*.rxe; *.rtm)|*.rxe;*.rtm|' +
    'NXT Program files (*.rpg)|*.rpg|' +
    'NXT Sound files (*.rso)|*.rso|' +
    'NXT Icon files (*.ric)|*.ric|' +
    'NXT Melody files (*.rmd)|*.rmd|' +
    'NXT Datalog files (*.rdt)|*.rdt|' +
    'NXT System files (*.sys)|*.sys|' +
    'All EV3 files (*.rbf; *.rsf; *.rgf)|' +
      '*.rbf;*.rsf;*.rgf|' +
    'EV3 Executable files (*.rbf)|*.rbf|' +
    'EV3 Sound files (*.rsf)|*.rsf|' +
    'EV3 Graphic files (*.rgf)|*.rgf|' +
    'NXT Menu files (*.rms)|*.rms';
    
  K_NXT_MAX_MEM = 128000;
  K_EV3_MAX_MEM = 1024*1024*600; // 600 mb

procedure TfrmNXTExplorer.SetColorScheme;
begin
{$IFNDEF FPC}
  if ThemeServices.ThemesEnabled then
    Self.Color := dxOffice11DockColor2
  else
    Self.Color := clBtnFace;
  ConfigBar(ogpNXTExplorer);
{$ENDIF}
end;

procedure TfrmNXTExplorer.RefreshNXTFiles;
var
  SL, maskSL : TStringList;
  i, p : integer;
  LI : TListItem;
  curMask, sizeStr : string;
  ft : TPBRFileType;
begin
  NXTFiles.Items.BeginUpdate;
  try
    NXTFiles.Items.Clear;
    SL := TStringList.Create;
    try
      SL.Sorted := True;
      SL.Duplicates := dupIgnore;
      for p := 0 to fMasks.Count - 1 do
      begin
        curMask := fMasks[p];
        maskSL := TStringList.Create;
        try
          BrickComm.ListFiles(CurrentBrickFolder + curMask, maskSL);
          SL.AddStrings(maskSL);
        finally
          maskSL.Free;
        end;
      end;
      for i := 0 to SL.Count - 1 do
      begin
        LI := NXTFiles.Items.Add;
        LI.Caption := SL.Names[i];
        ft := NXTNameToPBRFileType(LI.Caption);
        if (ft = nftOther) and IsEV3 then
          ft := EV3NameToPBRFileType(LI.Caption);
        sizeStr := SL.Values[LI.Caption];
        if sizeStr = '-1' then
        begin
          sizeStr := '';
          ft := nftFolder;
        end;
        if (ft = nftOther) and
           (LocalFirmwareType = ftLinux) and IsEV3 and 
           (ExtractFileExt(Li.Caption) = '') then
          ft := nftProgram;
        LI.SubItems.Add(sizeStr);
        LI.ImageIndex := Ord(ft);
      end;
    finally
      SL.Free;
    end;
  finally
    NXTFiles.Items.EndUpdate;
  end;
end;

procedure TfrmNXTExplorer.FormCreate(Sender: TObject);
begin
{$IFNDEF FPC}
  CreateShellControls;
{$ELSE}
  dlgOpen := TOpenDialog.Create(Self);
  dlgOpen.Filter := K_FILTER;
  dlgOpen.Options := [ofAllowMultiSelect, ofEnableSizing, ofViewDetail];
  dlgDirectory := TSelectDirectoryDialog.Create(Self);
{$ENDIF}
  fTotal := -1;
  fCur := -1;
  fMasks := TStringList.Create;
  PopulateMaskList;
  CreateMainMenu;
  CreatePopupMenu;
  Self.Menu := mnuMain;
  NXTFiles.PopupMenu := pmuNXT;
  CreateToolbar;
  {Let Windows know we accept dropped files}
{$IFNDEF FPC}
  NXTFiles.OnEdited := NXTFilesEdited;
  NXTFiles.OnEditing := NXTFilesEditing;
  NXTFiles.IconOptions.AutoArrange := True;
  DragAcceptFiles(Handle,true);
//  lstFiles.ObjectTypes := [otNonFolders];
  treShell.ReadOnly := True;
  lstFiles.ReadOnly := True;
  cboMask.OnChange := nil;
  try
    cboMask.Filter := K_FILTER;
  finally
    cboMask.OnChange := cboMaskChange;
  end;
{$ELSE}
  pnlLeft.Align := alClient;
{$ENDIF}
  SetColorScheme;
end;

procedure TfrmNXTExplorer.actViewToolbarExecute(Sender: TObject);
begin
{$IFNDEF FPC}
  cbrExplorerTop.Visible := not cbrExplorerTop.Visible;
{$ELSE}
  ToolBar1.Visible := not ToolBar1.Visible;
{$ENDIF}
end;

procedure TfrmNXTExplorer.actViewStyleExecute(Sender: TObject);
begin
  if Sender is TComponent then
  begin
    case TComponent(Sender).Tag of
      1: NXTFilesViewStyle := vsIcon;
      2: NXTFilesViewStyle := vsSmallIcon;
      3: NXTFilesViewStyle := vsList;
    else NXTFilesViewStyle := vsReport;
    end;
  end;
  NXTFiles.ViewStyle := {$IFDEF FPC}vsReport{$ELSE}NXTFilesViewStyle{$ENDIF};
end;

procedure TfrmNXTExplorer.actPCViewStyleExecute(Sender: TObject);
begin
{$IFNDEF FPC}
  if Sender is TComponent then
  begin
    case TComponent(Sender).Tag of
      1: lstFiles.ViewStyle := vsIcon;
      2: lstFiles.ViewStyle := vsSmallIcon;
      3: lstFiles.ViewStyle := vsList;
    else lstFiles.ViewStyle := vsReport;
    end;
  end;
  PCFilesViewStyle := lstFiles.ViewStyle;
{$ENDIF}
end;

procedure TfrmNXTExplorer.ActionsUpdate(Action: TBasicAction;
  var Handled: Boolean);
var
  sc : integer;
begin
  actNXTViewStyleLargeIcon.Checked := NXTFiles.ViewStyle = vsIcon;
  actNXTViewStyleSmallIcon.Checked := NXTFiles.ViewStyle = vsSmallIcon;
  actNXTViewStyleList.Checked      := NXTFiles.ViewStyle = vsList;
  actNXTViewStyleDetails.Checked   := NXTFiles.ViewStyle = vsReport;
  // nxt-side
  actFileDefrag.Enabled   := IsNXT;
  actFileEraseAll.Enabled := True;
  sc := NXTFiles.SelCount;
  actFileExecute.Enabled  := (sc = 1) and SelectedFileIsExecutable;
  actFileStop.Enabled     := True;
  actFileUpload.Enabled   := sc > 0;
  actFileView.Enabled     := sc = 1;
  actFileDelete.Enabled   := sc > 0;
  actFilePlay.Enabled     := (sc = 1) and SelectedFileIsSound;
  actFileMute.Enabled     := True;
{$IFNDEF FPC}
  actPCViewStyleLargeIcon.Checked  := lstFiles.ViewStyle = vsIcon;
  actPCViewStyleSmallIcon.Checked  := lstFiles.ViewStyle = vsSmallIcon;
  actPCViewStyleList.Checked       := lstFiles.ViewStyle = vsList;
  actPCViewStyleDetails.Checked    := lstFiles.ViewStyle = vsReport;
  // pc-side
  actFileDownload.Enabled := (lstFiles.SelCount > 0);
{$ELSE}
  actFileDownload.Enabled := True;
{$ENDIF}
end;

procedure TfrmNXTExplorer.cboMaskChange(Sender: TObject);
begin
{$IFNDEF FPC}
  NXTExplorerMaskIndex := cboMask.ItemIndex;
  RefreshLocalFileList;
{$ELSE}
  NXTExplorerMaskIndex := 0;
{$ENDIF}
  PopulateMaskList;
  RefreshNXTFiles;
end;

procedure TfrmNXTExplorer.FormShow(Sender: TObject);
begin
  lblPath.Visible := IsEV3;
  CurrentBrickFolder := BrickComm.BrickFolder;
{$IFNDEF FPC}
  treShell.OnChange := nil;
  try
    treShell.Root := 'rfMyComputer';
  finally
    treShell.OnChange := treShellChange;
  end;
{$ELSE}
  NXTFiles.ViewStyle := vsReport;
{$ENDIF}
  ConfigureForm;
//  RefreshNXTFiles;
{$IFNDEF FPC}
  RefreshLocalFileList;
{$ENDIF}
end;

procedure TfrmNXTExplorer.actFileRefreshExecute(Sender: TObject);
begin
  RefreshNXTFiles;
end;

procedure TfrmNXTExplorer.actFileDeleteExecute(Sender: TObject);
var
  i : integer;
  filename : string;
  item : TListItem;
begin
  if (MessageDlg(sConfirmDel, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    Screen.Cursor := crHourGlass;
    try
      for i := 0 to NXTFiles.Items.Count - 1 do
      begin
        item := NXTFiles.Items[i];
        if item.Selected then
        begin
          filename := CurrentBrickFolder + item.Caption;
          BrickComm.SCDeleteFile(filename, IsEV3);
        end;
      end;
      RefreshNXTFiles;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmNXTExplorer.actFileUploadExecute(Sender: TObject);
var
  i : integer;
  item : TListItem;
  oldCursor : TCursor;
begin
  Application.ProcessMessages;
  try
    oldCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
  {$IFNDEF FPC}
    for i := 0 to NXTFiles.Items.Count - 1 do
    begin
      item := NXTFiles.Items[i];
      if item.Selected then
        DoUploadFile(CurrentBrickFolder + item.Caption);
    end;
    RefreshLocalFileList;
  {$ELSE}
    dlgDirectory.InitialDir := fLastLocalPath;
    if dlgDirectory.Execute then
    begin
      fLastLocalPath := IncludeTrailingPathDelimiter(dlgDirectory.Filename);
      for i := 0 to NXTFiles.Items.Count - 1 do
      begin
        item := NXTFiles.Items[i];
        if item.Selected then
          DoUploadFile(CurrentBrickFolder + item.Caption);
      end;
    end;
  {$ENDIF}
  finally
    Screen.Cursor := oldCursor;
  end;
end;

function SizeOfFile(const filename : string) : Int64;
{$IFDEF FPC}
begin
  Result := FileSize(filename);
{$ELSE}
var
  Handle: THandle;
  FindData: TWin32FindData;
begin
  Handle := FindFirstFile(PChar(FileName), FindData);
  if Handle <> INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(Handle);
    if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      Result := (FindData.nFileSizeHigh shl 32) + FindData.nFileSizeLow
    else
      Result := -1;
  end
  else
    Result := -1;
{$ENDIF}
end;

procedure TfrmNXTExplorer.actFileDownloadExecute(Sender: TObject);
var
  i : integer;
  fname : string;
  oldCursor : TCursor;
begin
  Application.ProcessMessages;
  try
    oldCursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;
  {$IFNDEF FPC}
    for i := 0 to lstFiles.Items.Count - 1 do
    begin
      if lstFiles.Items[i].Selected then
      begin
        fname := lstFiles.GetPathFromIndex(i);
        if not DoDownloadFile(fname) then
          break;
      end;
    end;
  {$ELSE}
    // use open dialog to select PC files to download to NXT
    if dlgOpen.Execute then
    begin
      for i := 0 to dlgOpen.Files.Count - 1 do
      begin
        fname := dlgOpen.Files[i];
        if not DoDownloadFile(fname) then
          break;
      end;
    end;
  {$ENDIF}
    RefreshNXTFiles;
  finally
    Screen.Cursor := oldCursor;
  end;
end;

procedure TfrmNXTExplorer.actFileExecuteExecute(Sender: TObject);
begin
  if (NXTFiles.SelCount = 1) and SelectedFileIsExecutable then
    BrickComm.DCStartProgram(CurrentBrickFolder + NXTFiles.Selected.Caption);
end;

function TfrmNXTExplorer.SelectedFileIsExecutable: boolean;
var
  item : TListItem;
  name : string;
begin
  Result := False;
  item := NXTFiles.Selected;
  if not Assigned(item) then
    Exit;
  Result := TPBRFileType(item.ImageIndex) = nftProgram;
end;

function TfrmNXTExplorer.SelectedFileIsSound: boolean;
var
  item : TListItem;
  name : string;
begin
  Result := False;
  item := NXTFiles.Selected;
  if not Assigned(item) then
    Exit;
  Result := TPBRFileType(item.ImageIndex) = nftSound;
end;

procedure TfrmNXTExplorer.actFileStopExecute(Sender: TObject);
begin
  BrickComm.DCStopProgram;
end;

{$IFNDEF FPC}
procedure TfrmNXTExplorer.RefreshShellListView(Sender: TObject);
begin
  if lstFiles.ViewStyle <> vsReport then
    lstFiles.Refresh;
end;
{$ENDIF}

{$IFNDEF FPC}
procedure TfrmNXTExplorer.NXTFilesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = lstFiles;
end;

procedure TfrmNXTExplorer.NXTFilesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  // download files to NXT from PC
  actFileDownloadExecute(Sender);
end;

procedure TfrmNXTExplorer.lstFilesDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Source = NXTFiles;
end;

procedure TfrmNXTExplorer.lstFilesDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  // upload files to PC from NXT
  actFileUploadExecute(Sender);
end;
{$ENDIF}

procedure TfrmNXTExplorer.actFilePlayExecute(Sender: TObject);
var
  filename : string;
begin
  if (NXTFiles.SelCount = 1) and SelectedFileIsSound then
  begin
    filename := CurrentBrickFolder + NXTFiles.Selected.Caption;
    BrickComm.DCPlaySoundFile(filename, False);
  end;
end;

procedure TfrmNXTExplorer.actFileMuteExecute(Sender: TObject);
begin
  BrickComm.ClearSound;
end;

procedure TfrmNXTExplorer.Exit1Click(Sender: TObject);
begin
  Close;
end;

{$IFNDEF FPC}
procedure TfrmNXTExplorer.lstFilesDblClick(Sender: TObject);
begin
  if treShell.Selected <> nil then
    treShell.Selected.MakeVisible;
end;
{$ENDIF}

procedure TfrmNXTExplorer.About1Click(Sender: TObject);
begin
  ShowMessage('PBrick Explorer'#13#10'Copyright 2006-2013, John C. Hansen');
end;

procedure TfrmNXTExplorer.actFileEraseAllExecute(Sender: TObject);
var
  bf : string;
begin
  if (MessageDlg(sConfirmErase, mtConfirmation, [mbYes, mbNo], 0) = mrYes) then
  begin
    Screen.Cursor := crHourGlass;
    try
      bf := BrickComm.BrickFolder;
      try
        BrickComm.BrickFolder := fCurrentBrickFolder;
        BrickComm.ClearMemory;
      finally
        BrickComm.BrickFolder := bf;
      end;
      RefreshNXTFiles;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
end;

procedure TfrmNXTExplorer.NXTFilesEditing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  AllowEdit := (ExtractFileExt(Item.Caption) <> '.sys') and
               (TPBRFileType(Item.ImageIndex) <> nftFolder);
end;

procedure TfrmNXTExplorer.NXTFilesEdited(Sender: TObject; Item: TListItem;
  var S: String);
var
  old, tmp : string;
begin
  S := MakeValidNXTFilename(S);
  tmp := CurrentBrickFolder + S;
  old := CurrentBrickFolder + Item.Caption;
  BrickComm.SCRenameFile(old, tmp, True);
//  RefreshNXTFiles;
end;

procedure TfrmNXTExplorer.actEditSelectAllExecute(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to NXTFiles.Items.Count - 1 do
    NXTFiles.Items[I].Selected := True;
end;

const
  K_BATTERY_DEFRAG_MIN = 6000;

procedure TfrmNXTExplorer.actFileDefragExecute(Sender: TObject);
var
  c : Cardinal;
  bl : integer;
begin
  if MessageDlg(sConfirmDefrag, mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
{$IFNDEF FPC}
    Screen.Cursor := crHourGlass;
{$ENDIF}
    try
      // check battery level and do not proceed if it is low
      bl := BrickComm.BatteryLevel;
      if bl > K_BATTERY_DEFRAG_MIN then
      begin
        // make sure the brick stays awake
        if BrickComm.DCKeepAlive(c) then
        begin
          if not BrickComm.SCDefragmentFlash then
            MessageDlg(sDefragError, mtError, [mbOK], 0)
          else
            MessageDlg(sDefragSuccess, mtInformation, [mbOK], 0);
          RefreshNXTFiles;
        end;
      end
      else
        MessageDlg(sLowBattery, mtError, [mbOK], 0);
    finally
{$IFNDEF FPC}
      Screen.Cursor := crDefault;
{$ENDIF}
    end;
  end;
end;

function TfrmNXTExplorer.IsInMask(const ext : string) : boolean;
var
  i : integer;
begin
  Result := not Assigned(fMasks);
  if Result then Exit;
  for i := 0 to fMasks.Count - 1 do
  begin
    Result := (fMasks[i] = '*.*') or (Pos(ext, fMasks[i]) > 0);
    if Result then
      Break;
  end;
end;

{$IFNDEF FPC}
procedure TfrmNXTExplorer.lstFilesAddFolder(Sender: TObject;
  AFolder: TShellFolder; var CanAdd: Boolean);
begin
  CanAdd := AFolder.IsFolder or IsInMask(Lowercase(ExtractFileExt(AFolder.DisplayName)));
end;
{$ENDIF}

procedure TfrmNXTExplorer.PopulateMaskList;
var
  tmpMask, curMask : string;
  p : integer;
begin
  fMasks.Clear;
{$IFNDEF FPC}
  tmpMask := cboMask.Mask;
{$ELSE}
  tmpMask := 'All files (*.*)|*.*';
{$ENDIF}
  repeat
    p := Pos(';', tmpMask);
    if p > 0 then
      curMask := Copy(tmpMask, 1, p-1)
    else
      curMask := tmpMask;
    fMasks.Add(curMask);
    Delete(tmpMask, 1, Length(curMask)+1);
  until tmpMask = '';
end;

procedure TfrmNXTExplorer.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fMasks);
end;

procedure TfrmNXTExplorer.ConfigureForm;
begin
  NXTFiles.ViewStyle := {$IFDEF FPC}vsReport{$ELSE}NXTFilesViewStyle{$ENDIF};
{$IFNDEF FPC}
  lstFiles.ViewStyle := PCFilesViewStyle;
  cboMask.ItemIndex  := NXTExplorerMaskIndex;
  if DirectoryExists(NXTExplorerPath) then
  begin
    try
      treShell.Path := NXTExplorerPath;
    except
      // eat any exceptions which might occur here.
    end;
  end;
{$ENDIF}
  cboMaskChange(nil);
end;

{$IFNDEF FPC}
procedure TfrmNXTExplorer.treShellChange(Sender: TObject; Node: TTreeNode);
begin
  NXTExplorerPath := GetLocalFilePath;
end;

procedure TfrmNXTExplorer.WMDROPFILES(var Message: TWMDROPFILES);
var
  buffer : array[0..255] of char;
  cnt, i : Integer;
  p : TPoint;
begin
  DragQueryPoint(Message.Drop, p);
  if InNXTView(p) then
  begin
    cnt := DragQueryFile(Message.Drop, $FFFFFFFF, @buffer, sizeof(buffer));
    for i := 0 to cnt - 1 do
    begin
      DragQueryFile(Message.Drop,i,@buffer,sizeof(buffer));
      // buffer is the name of a file to drop
      if not DoDownloadFile(buffer) then
        break;
    end;
    DragFinish(Message.Drop);
    RefreshNXTFiles;
  end;
end;

function TfrmNXTExplorer.InNXTView(p: TPoint): boolean;
begin
  p := NXTFiles.ParentToClient(p, Self);
  if ((p.X >= 0) and (p.X <= NXTFiles.Width)) and
     ((p.Y >= 0) and (p.Y <= NXTFiles.Height)) then
    Result := True
  else
    Result := False;
end;
{$ENDIF}

function MaxFileSize : integer;
begin
  if IsNXT then
    Result := K_NXT_MAX_MEM
  else
    Result := K_EV3_MAX_MEM;
end;

function TfrmNXTExplorer.DoDownloadFile(const aFile: string) : boolean;
var
  D1 : TNotifyEvent;
  DD : TNotifyEvent;
  DS : TDownloadStatusEvent;
  fsize : Int64;
  oldBF : string;
begin
  Result := True;
  fsize := SizeOfFile(aFile);
  oldBF := BrickComm.BrickFolder;
  try
    BrickComm.BrickFolder := CurrentBrickFolder;
    if fsize < MaxFileSize then
    begin
      D1 := BrickComm.OnDownloadStart;
      DD := BrickComm.OnDownloadDone;
      DS := BrickComm.OnDownloadStatus;
      try
        BrickComm.OnDownloadStart  := HandleDownloadStart;
        BrickComm.OnDownloadDone   := HandleDownloadDone;
        BrickComm.OnDownloadStatus := HandleDownloadStatus;
        if not BrickComm.DownloadFile(aFile, NXTNameToPBRFileType(aFile)) then
        begin
          MessageDlg(sDownloadFailed, mtError, [mbOK], 0);
          Result := False;
        end;
      finally
        BrickComm.OnDownloadStart  := D1;
        BrickComm.OnDownloadDone   := DD;
        BrickComm.OnDownloadStatus := DS;
      end;
    end
    else
    begin
      MessageDlg(Format(sTooBig, [fsize, aFile]), mtError, [mbOK], 0);
      Result := False;
    end;
  finally
    BrickComm.BrickFolder := oldBF;
  end;
end;

function TfrmNXTExplorer.DoUploadFile(const aFile: string): boolean;
var
  D1 : TNotifyEvent;
  DD : TNotifyEvent;
  DS : TDownloadStatusEvent;
begin
  Result := True;
  D1 := BrickComm.OnDownloadStart;
  DD := BrickComm.OnDownloadDone;
  DS := BrickComm.OnDownloadStatus;
  try
    BrickComm.OnDownloadStart  := HandleDownloadStart;
    BrickComm.OnDownloadDone   := HandleDownloadDone;
    BrickComm.OnDownloadStatus := HandleDownloadStatus;
    Result := BrickComm.UploadFile(aFile, GetLocalFilePath);
  finally
    BrickComm.OnDownloadStart  := D1;
    BrickComm.OnDownloadDone   := DD;
    BrickComm.OnDownloadStatus := DS;
  end;
end;

function TfrmNXTExplorer.GetLocalFilePath: string;
begin
{$IFNDEF FPC}
  Result := treShell.Path;
{$ELSE}
  Result := IncludeTrailingPathDelimiter(fLastLocalPath);
{$ENDIF}
end;

function GetImageIndex(const filename : string) : integer;
begin
  Result := 0;
end;

{$IFNDEF FPC}
procedure TfrmNXTExplorer.RefreshLocalFileList;
begin
  lstFiles.Refresh;
end;
{$ENDIF}

function FileIsText(const ext : string) : boolean;
begin
  Result := (ext = '.txt') or
            (ext = '.log') or
            (ext = '.sh') or
            (ext = '.h') or
            (ext = '.c') or
            (ext = '.pas') or
            (ext = '.rs') or
            (ext = '.nbc') or
            (ext = '.nxc');
end;

procedure TfrmNXTExplorer.actFileViewExecute(Sender: TObject);
var
  MS : TMemoryStream;
  fname, ext : string;
begin
  MS := TMemoryStream.Create;
  try
    fname := CurrentBrickFolder + NXTFiles.Selected.Caption;
    if BrickComm.UploadFileToStream(fname, MS) then
    begin
      ext := Lowercase(ExtractFileExt(fname));
      if FileIsText(ext) then
        frmTextView.ShowStreamData(fname, MS)
{$IFNDEF FPC}
      else
        frmHexView.ShowStreamData(fname, MS);
{$ELSE}
      ;
{$ENDIF}
    end;
  finally
    MS.Free;
  end;
end;

procedure TfrmNXTExplorer.CreateMainMenu;
begin
  mnuMain := TOfficeMainMenu.Create(Self);
  mnuMain.Name := 'mnuMain';
  File1 := TOfficeMenuItem.Create(mnuMain);
  Refresh1 := TOfficeMenuItem.Create(File1);
  Delete1 := TOfficeMenuItem.Create(File1);
  EraseAll1 := TOfficeMenuItem.Create(File1);
  mniDefrag := TOfficeMenuItem.Create(File1);
  N6 := TOfficeMenuItem.Create(File1);
  Upload1 := TOfficeMenuItem.Create(File1);
  Download1 := TOfficeMenuItem.Create(File1);
  View2 := TOfficeMenuItem.Create(File1);
  N7 := TOfficeMenuItem.Create(File1);
  Execute1 := TOfficeMenuItem.Create(File1);
  Stop1 := TOfficeMenuItem.Create(File1);
  N3 := TOfficeMenuItem.Create(File1);
  Play1 := TOfficeMenuItem.Create(File1);
  Mute1 := TOfficeMenuItem.Create(File1);
  N2 := TOfficeMenuItem.Create(File1);
  Exit1 := TOfficeMenuItem.Create(File1);
  Edit2 := TOfficeMenuItem.Create(mnuMain);
  mniSelectAll := TOfficeMenuItem.Create(Edit2);
  View1 := TOfficeMenuItem.Create(mnuMain);
  NXTViewStyle2 := TOfficeMenuItem.Create(View1);
  LargeIcons2 := TOfficeMenuItem.Create(NXTViewStyle2);
  SmallIcons2 := TOfficeMenuItem.Create(NXTViewStyle2);
  List2 := TOfficeMenuItem.Create(NXTViewStyle2);
  Details2 := TOfficeMenuItem.Create(NXTViewStyle2);
  PCViewStyle1 := TOfficeMenuItem.Create(View1);
  LargeIcons3 := TOfficeMenuItem.Create(PCViewStyle1);
  SmallIcons3 := TOfficeMenuItem.Create(PCViewStyle1);
  List3 := TOfficeMenuItem.Create(PCViewStyle1);
  Details3 := TOfficeMenuItem.Create(PCViewStyle1);
  N5 := TOfficeMenuItem.Create(View1);
  ShowToolbar1 := TOfficeMenuItem.Create(View1);
  Help1 := TOfficeMenuItem.Create(mnuMain);
  About1 := TOfficeMenuItem.Create(Help1);
  AddMenuItems(mnuMain.Items, [File1, Edit2, View1{$IFNDEF FPC}, Help1{$ENDIF}]);
  AddMenuItems(File1,
               [Refresh1, Delete1, EraseAll1, mniDefrag, N6, Upload1, Download1,
               {$IFNDEF FPC}View2, {$ENDIF}
               N7, Execute1, Stop1, N3, Play1, Mute1{$IFNDEF FPC}, N2, Exit1{$ENDIF}]);
  AddMenuItems(Edit2, [mniSelectAll]);
  AddMenuItems(View1, [NXTViewStyle2, {$IFNDEF FPC}PCViewStyle1, {$ENDIF}N5, ShowToolbar1]);
  AddMenuItems(NXTViewStyle2, [LargeIcons2, SmallIcons2, List2, Details2]);
{$IFNDEF FPC}
  AddMenuItems(Help1, [About1]);
  AddMenuItems(PCViewStyle1, [LargeIcons3, SmallIcons3, List3, Details3]);
{$ENDIF}
  with File1 do
  begin
    Name := 'File1';
    Caption := sFileMenu;
  end;
  with Refresh1 do
  begin
    Name := 'Refresh1';
    Action := actFileRefresh;
  end;
  with Delete1 do
  begin
    Name := 'Delete1';
    Action := actFileDelete;
  end;
  with EraseAll1 do
  begin
    Name := 'EraseAll1';
    Action := actFileEraseAll;
  end;
  with mniDefrag do
  begin
    Name := 'mniDefrag';
    Action := actFileDefrag;
  end;
  with N6 do
  begin
    Name := 'N6';
    Caption := '-';
  end;
  with Upload1 do
  begin
    Name := 'Upload1';
    Action := actFileUpload;
  end;
  with Download1 do
  begin
    Name := 'Download1';
    Action := actFileDownload;
  end;
  with View2 do
  begin
    Name := 'View2';
    Action := actFileView;
  end;
  with N7 do
  begin
    Name := 'N7';
    Caption := '-';
  end;
  with Execute1 do
  begin
    Name := 'Execute1';
    Action := actFileExecute;
  end;
  with Stop1 do
  begin
    Name := 'Stop1';
    Action := actFileStop;
  end;
  with N3 do
  begin
    Name := 'N3';
    Caption := '-';
  end;
  with Play1 do
  begin
    Name := 'Play1';
    Action := actFilePlay;
  end;
  with Mute1 do
  begin
    Name := 'Mute1';
    Action := actFileMute;
  end;
  with N2 do
  begin
    Name := 'N2';
    Caption := '-';
  end;
  with Exit1 do
  begin
    Name := 'Exit1';
    Caption := sExit;
    OnClick := Exit1Click;
  end;
  with Edit2 do
  begin
    Name := 'Edit2';
    Caption := sEditMenu;
  end;
  with mniSelectAll do
  begin
    Name := 'mniSelectAll';
    Action := actEditSelectAll;
  end;
  with View1 do
  begin
    Name := 'View1';
    Caption := sViewMenu;
  end;
  with NXTViewStyle2 do
  begin
    Name := 'NXTViewStyle2';
    Caption := sNXTViewStyleMenu;
  end;
  with LargeIcons2 do
  begin
    Name := 'LargeIcons2';
    Tag := 1;
    Action := actNXTViewStyleLargeIcon;
    RadioItem := True;
  end;
  with SmallIcons2 do
  begin
    Name := 'SmallIcons2';
    Tag := 2;
    Action := actNXTViewStyleSmallIcon;
    RadioItem := True;
  end;
  with List2 do
  begin
    Name := 'List2';
    Tag := 3;
    Action := actNXTViewStyleList;
    RadioItem := True;
  end;
  with Details2 do
  begin
    Name := 'Details2';
    Tag := 4;
    Action := actNXTViewStyleDetails;
    RadioItem := True;
  end;
  with PCViewStyle1 do
  begin
    Name := 'PCViewStyle1';
    Caption := sPCViewStyleMenu;
  end;
  with LargeIcons3 do
  begin
    Name := 'LargeIcons3';
    Tag := 1;
    Action := actPCViewStyleLargeIcon;
    GroupIndex := 1;
    RadioItem := True;
  end;
  with SmallIcons3 do
  begin
    Name := 'SmallIcons3';
    Tag := 2;
    Action := actPCViewStyleSmallIcon;
    GroupIndex := 1;
    RadioItem := True;
  end;
  with List3 do
  begin
    Name := 'List3';
    Tag := 3;
    Action := actPCViewStyleList;
    GroupIndex := 1;
    RadioItem := True;
  end;
  with Details3 do
  begin
    Name := 'Details3';
    Tag := 4;
    Action := actPCViewStyleDetails;
    GroupIndex := 1;
    RadioItem := True;
  end;
  with N5 do
  begin
    Name := 'N5';
    Caption := '-';
  end;
  with ShowToolbar1 do
  begin
    Name := 'ShowToolbar1';
    Action := actViewToolbar;
  end;
  with Help1 do
  begin
    Name := 'Help1';
    Caption := sHelpMenu;
  end;
  with About1 do
  begin
    Name := 'About1';
    Caption := sAbout + '...';
    OnClick := About1Click;
  end;
end;

procedure TfrmNXTExplorer.CreatePopupMenu;
begin
  pmuNXT := TPopupMenu.Create(Self);
  mniRefresh := TOfficeMenuItem.Create(pmuNXT);
  mniDelete := TOfficeMenuItem.Create(pmuNXT);
  mniPopEraseAll := TOfficeMenuItem.Create(pmuNXT);
  mniPopDefrag := TOfficeMenuItem.Create(pmuNXT);
  mniSep6 := TOfficeMenuItem.Create(pmuNXT);
  mniUpload := TOfficeMenuItem.Create(pmuNXT);
  mniDownload := TOfficeMenuItem.Create(pmuNXT);
  mniView := TOfficeMenuItem.Create(pmuNXT);
  mniCreateFolder := TOfficeMenuItem.Create(pmuNXT);
  mniSep5 := TOfficeMenuItem.Create(pmuNXT);
  mniExecute := TOfficeMenuItem.Create(pmuNXT);
  mniFileStop := TOfficeMenuItem.Create(pmuNXT);
  N1 := TOfficeMenuItem.Create(pmuNXT);
  mniPlay := TOfficeMenuItem.Create(pmuNXT);
  mniMute := TOfficeMenuItem.Create(pmuNXT);
  mniSep3 := TOfficeMenuItem.Create(pmuNXT);
  mniViewStyle := TOfficeMenuItem.Create(pmuNXT);
  mitLargeIcons := TOfficeMenuItem.Create(mniViewStyle);
  mitSmallIcons := TOfficeMenuItem.Create(mniViewStyle);
  mitList := TOfficeMenuItem.Create(mniViewStyle);
  mitDetails := TOfficeMenuItem.Create(mniViewStyle);
  NXTViewStyle1 := TOfficeMenuItem.Create(pmuNXT);
  LargeIcons1 := TOfficeMenuItem.Create(NXTViewStyle1);
  SmallIcons1 := TOfficeMenuItem.Create(NXTViewStyle1);
  List1 := TOfficeMenuItem.Create(NXTViewStyle1);
  Details1 := TOfficeMenuItem.Create(NXTViewStyle1);
  mniSep4 := TOfficeMenuItem.Create(pmuNXT);
  mniShowToolbar := TOfficeMenuItem.Create(pmuNXT);
  AddMenuItems(pmuNXT.Items,
               [mniRefresh, mniDelete, mniPopEraseAll, mniPopDefrag,
                mniSep6, mniUpload, mniDownload,
                {$IFNDEF FPC}mniView, {$ENDIF}mniCreateFolder, mniSep5,
                mniExecute, mniFileStop, N1, mniPlay, mniMute, mniSep3,
                mniViewStyle, {$IFNDEF FPC}NXTViewStyle1, {$ENDIF}mniSep4, mniShowToolbar]);
  AddMenuItems(mniViewStyle, [mitLargeIcons, mitSmallIcons, mitList, mitDetails]);
{$IFNDEF FPC}
  AddMenuItems(NXTViewStyle1, [LargeIcons1, SmallIcons1, List1, Details1]);
{$ENDIF}
  with pmuNXT do
  begin
    Name := 'pmuNXT';
{$IFDEF FPC}
    Images := ilToolbar;
{$ELSE}
    Images := ilSmall;
{$ENDIF}
  end;
  with mniRefresh do
  begin
    Name := 'mniRefresh';
    Action := actFileRefresh;
  end;
  with mniDelete do
  begin
    Name := 'mniDelete';
    Action := actFileDelete;
  end;
  with mniPopEraseAll do
  begin
    Name := 'mniPopEraseAll';
    Action := actFileEraseAll;
  end;
  with mniPopDefrag do
  begin
    Name := 'mniPopDefrag';
    Action := actFileDefrag;
  end;
  with mniSep6 do
  begin
    Name := 'mniSep6';
    Caption := '-';
  end;
  with mniUpload do
  begin
    Name := 'mniUpload';
    Action := actFileUpload;
  end;
  with mniDownload do
  begin
    Name := 'mniDownload';
    Action := actFileDownload;
  end;
  with mniView do
  begin
    Name := 'mniView';
    Action := actFileView;
  end;
  with mniCreateFolder do
  begin
    Name := 'mniCreateFolder';
    Action := actFileCreateFolder;
  end;
  with mniSep5 do
  begin
    Name := 'mniSep5';
    Caption := '-';
  end;
  with mniExecute do
  begin
    Name := 'mniExecute';
    Action := actFileExecute;
  end;
  with mniFileStop do
  begin
    Name := 'mniFileStop';
    Action := actFileStop;
  end;
  with N1 do
  begin
    Name := 'N1';
    Caption := '-';
  end;
  with mniPlay do
  begin
    Name := 'mniPlay';
    Action := actFilePlay;
  end;
  with mniMute do
  begin
    Name := 'mniMute';
    Action := actFileMute;
  end;
  with mniSep3 do
  begin
    Name := 'mniSep3';
    Caption := '-';
  end;
  with mniViewStyle do
  begin
    Name := 'mniViewStyle';
    Caption := sNXTViewStyleMenu;
  end;
  with mitLargeIcons do
  begin
    Name := 'mitLargeIcons';
    Tag := 1;
    Action := actNXTViewStyleLargeIcon;
    RadioItem := True;
  end;
  with mitSmallIcons do
  begin
    Name := 'mitSmallIcons';
    Tag := 2;
    Action := actNXTViewStyleSmallIcon;
    RadioItem := True;
  end;
  with mitList do
  begin
    Name := 'mitList';
    Tag := 3;
    Action := actNXTViewStyleList;
    RadioItem := True;
  end;
  with mitDetails do
  begin
    Name := 'mitDetails';
    Tag := 4;
    Action := actNXTViewStyleDetails;
    RadioItem := True;
  end;
  with NXTViewStyle1 do
  begin
    Name := 'NXTViewStyle1';
    Caption := sPCViewStyleMenu;
  end;
  with LargeIcons1 do
  begin
    Name := 'LargeIcons1';
    Tag := 1;
    Action := actPCViewStyleLargeIcon;
    GroupIndex := 1;
    RadioItem := True;
  end;
  with SmallIcons1 do
  begin
    Name := 'SmallIcons1';
    Tag := 2;
    Action := actPCViewStyleSmallIcon;
    GroupIndex := 1;
    RadioItem := True;
  end;
  with List1 do
  begin
    Name := 'List1';
    Tag := 3;
    Action := actPCViewStyleList;
    GroupIndex := 1;
    RadioItem := True;
  end;
  with Details1 do
  begin
    Name := 'Details1';
    Tag := 4;
    Action := actPCViewStyleDetails;
    GroupIndex := 1;
    RadioItem := True;
  end;
  with mniSep4 do
  begin
    Name := 'mniSep4';
    Caption := '-';
  end;
  with mniShowToolbar do
  begin
    Name := 'mniShowToolbar';
    Action := actViewToolbar;
  end;
end;

procedure TfrmNXTExplorer.CreateToolbar;
begin
{$IFNDEF FPC}
  cbrExplorerTop := TOfficeControlBar.Create(Self);
  ogpNXTExplorer := TOfficeGradientPanel.Create(cbrExplorerTop);
  osbUpload := TOfficeSpeedButton.Create(ogpNXTExplorer);
  osbDelete := TOfficeSpeedButton.Create(ogpNXTExplorer);
  osbRefresh := TOfficeSpeedButton.Create(ogpNXTExplorer);
  osbDownload := TOfficeSpeedButton.Create(ogpNXTExplorer);
  bvlFile2 := TBevel.Create(ogpNXTExplorer);
  osbExecute := TOfficeSpeedButton.Create(ogpNXTExplorer);
  obsStop := TOfficeSpeedButton.Create(ogpNXTExplorer);
  bvlStop2 := TBevel.Create(ogpNXTExplorer);
  osbPlay := TOfficeSpeedButton.Create(ogpNXTExplorer);
  bvlPlay2 := TBevel.Create(ogpNXTExplorer);
  osbMute := TOfficeSpeedButton.Create(ogpNXTExplorer);
  bvlMute2 := TBevel.Create(ogpNXTExplorer);
  osbEraseAll := TOfficeSpeedButton.Create(ogpNXTExplorer);
  osbDefrag := TOfficeSpeedButton.Create(ogpNXTExplorer);
  osbView := TOfficeSpeedButton.Create(ogpNXTExplorer);
  with cbrExplorerTop do
  begin
    Name := 'cbrExplorerTop';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 572;
    Height := 26;
    Align := alTop;
    AutoSize := True;
    Color := clBtnFace;
    TabOrder := 0;
    BorderColor := clBlack;
  end;
  with ogpNXTExplorer do
  begin
    Name := 'ogpNXTExplorer';
    Parent := cbrExplorerTop;
    Caption := '';
    Left := 11;
    Top := 2;
    Width := 334;
    Height := 22;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
    Horizontal := False;
    Constraints.MinWidth := 22;
    ParentShowHint := False;
    ShowHint := True;
    TabOrder := 0;
  end;
  with osbRefresh do
  begin
    Name := 'osbRefresh';
    Parent := ogpNXTExplorer;
    Left := 0;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileRefresh;
{$IFDEF FPC}
{$ELSE}
    MenuItem := Refresh1;
    ResourceName := 'IMG_REFRESH';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbDelete do
  begin
    Name := 'osbDelete';
    Parent := ogpNXTExplorer;
    Left := 23;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileDelete;
{$IFDEF FPC}
{$ELSE}
    MenuItem := Delete1;
    ResourceName := 'IMG_DELETE';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbEraseAll do
  begin
    Name := 'osbEraseAll';
    Parent := ogpNXTExplorer;
    Left := 46;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileEraseAll;
{$IFDEF FPC}
{$ELSE}
    MenuItem := EraseAll1;
    ResourceName := 'IMG_CLEARMEM';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbDefrag do
  begin
    Name := 'osbDefrag';
    Parent := ogpNXTExplorer;
    Left := 69;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileDefrag;
{$IFDEF FPC}
{$ELSE}
    MenuItem := mniDefrag;
    ResourceName := 'IMG_DEFRAG';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlPlay2 do
  begin
    Name := 'bvlPlay2';
    Parent := ogpNXTExplorer;
    Left := 92;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsLeftLine;
  end;
  with osbUpload do
  begin
    Name := 'osbUpload';
    Parent := ogpNXTExplorer;
    Left := 100;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileUpload;
{$IFDEF FPC}
{$ELSE}
    MenuItem := Upload1;
    ResourceName := 'IMG_UPLOAD';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbDownload do
  begin
    Name := 'osbDownload';
    Parent := ogpNXTExplorer;
    Left := 123;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileDownload;
{$IFDEF FPC}
{$ELSE}
    MenuItem := Download1;
    ResourceName := 'IMG_OPEN';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlFile2 do
  begin
    Name := 'bvlFile2';
    Parent := ogpNXTExplorer;
    Left := 169;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsLeftLine;
  end;
  with osbExecute do
  begin
    Name := 'osbExecute';
    Parent := ogpNXTExplorer;
    Left := 177;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileExecute;
{$IFDEF FPC}
{$ELSE}
    MenuItem := Execute1;
    ResourceName := 'IMG_RUN';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with obsStop do
  begin
    Name := 'obsStop';
    Parent := ogpNXTExplorer;
    Left := 200;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileStop;
{$IFDEF FPC}
{$ELSE}
    MenuItem := Stop1;
    ResourceName := 'IMG_STOP';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlStop2 do
  begin
    Name := 'bvlStop2';
    Parent := ogpNXTExplorer;
    Left := 223;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsLeftLine;
  end;
  with osbPlay do
  begin
    Name := 'osbPlay';
    Parent := ogpNXTExplorer;
    Left := 231;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFilePlay;
{$IFDEF FPC}
{$ELSE}
    MenuItem := Play1;
    ResourceName := 'IMG_PLAY';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with osbMute do
  begin
    Name := 'osbMute';
    Parent := ogpNXTExplorer;
    Left := 254;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileMute;
{$IFDEF FPC}
{$ELSE}
    MenuItem := Mute1;
    ResourceName := 'IMG_MUTE';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
  with bvlMute2 do
  begin
    Name := 'bvlMute2';
    Parent := ogpNXTExplorer;
    Left := 277;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsLeftLine;
  end;
  with osbView do
  begin
    Name := 'osbView';
    Parent := ogpNXTExplorer;
    Left := 146;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actFileView;
{$IFDEF FPC}
{$ELSE}
    MenuItem := View2;
    ResourceName := 'IMG_NEWWATCH';
{$ENDIF}
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
    ParentShowHint := False;
    ShowHint := True;
  end;
{$ENDIF}
end;

{$IFNDEF FPC}
procedure TfrmNXTExplorer.CreateShellControls;
begin
  cboMask := TFilterComboBox.Create(Self);
  with cboMask do
  begin
    Name := 'cboMask';
    Parent := pnlTopLeft;
    Left := 0;
    Top := 2;
    Width := 229;
    Height := 21;
    Anchors := [akLeft, akTop, akRight];
    TabOrder := 0;
    OnChange := cboMaskChange;
  end;
  treShell := TShellTreeViewEx.Create(Self);
  Splitter2 := TSplitter.Create(Self);
  lstFiles := TShellListViewEx.Create(Self);
  treShell.Parent  := pnlRight;
  Splitter2.Parent := pnlRight;
  lstFiles.Parent  := pnlRight;
  with treShell do
  begin
    Name := 'treShell';
    Parent := pnlRight;
    Left := 2;
    Top := 2;
    Width := 332;
    Height := 120;
    ShellListView := lstFiles;
    Align := alTop;
    HideSelection := False;
    Indent := 19;
    ParentColor := False;
    RightClickSelect := True;
    ShowRoot := False;
    TabOrder := 0;
    OnChange := treShellChange;
  end;
  with Splitter2 do
  begin
    Name := 'Splitter2';
    Parent := pnlRight;
    Left := 2;
    Top := 122;
    Width := 332;
    Cursor := crVSplit;
    Align := alTop;
    Height := 3;
    OnMoved := RefreshShellListView;
  end;
  with lstFiles do
  begin
    Name := 'lstFiles';
    Left := 2;
    Top := 125;
    Width := 332;
    Height := 319;
    ShellTreeView := treShell;
    Align := alClient;
    DragMode := dmAutomatic;
    ReadOnly := False;
    HideSelection := False;
    MultiSelect := True;
    IconOptions.AutoArrange := True;
    OnAddFolder := lstFilesAddFolder;
    OnDragDrop := lstFilesDragDrop;
    OnDragOver := lstFilesDragOver;
    OnDblClick := lstFilesDblClick;
    TabOrder := 1;
    DoubleBuffered := True;
  end;
end;

{ TShellListViewEx }

function TShellListViewEx.GetPathFromIndex(const idx: integer): string;
begin
  Result := Folders[idx].PathName;
end;
{$ENDIF}

procedure TfrmNXTExplorer.ChangeFolder(aFolder: string);
var
  bRelative : boolean;
  len, i : integer;
  tmpPath, tmpCF : string;
begin
  if aFolder = '' then Exit;
  len := Length(aFolder);
  if (len > 1) and (aFolder[1] <> '/') and (aFolder[len] = '/') then
  begin
    System.Delete(aFolder, len, 1);
    dec(len);
  end;
  if aFolder = '.' then Exit;
  bRelative := aFolder[1] <> '/';
  if bRelative then
  begin
    // is is a .. ?
    if aFolder = '..' then
    begin
      // remove from path
      tmpCF := CurrentBrickFolder;
      System.Delete(tmpCF, Length(tmpCF), 1);
      tmpPath := '';
      i := Pos('/', tmpCF);
      while i > 0 do
      begin
        tmpPath := tmpPath + Copy(tmpCF, 1, i);
        System.Delete(tmpCF, 1, i);
        i := Pos('/', tmpCF);
      end;
//      if tmpPath = '' then
//        tmpPath := '/';
//      CurrentBrickFolder := tmpPath;
    end
    else if (Pos(CurrentBrickFolder, aFolder) = 1) and (Length(CurrentBrickFolder) <= Length(aFolder)) then
    begin
      // just replace the path
      tmpPath := aFolder;
    end
    else
    begin
      // add to path
      tmpPath := CurrentBrickFolder + aFolder;
    end;
  end
  else
  begin
    // replace with new absolute path
    tmpPath := aFolder;
  end;
  // if the last character is not '/' then add it at the end
  len := Length(tmpPath);
  if (len > 0) and (tmpPath[len] <> '/') then
    tmpPath := tmpPath + '/';
  if tmpPath = '' then
    tmpPath := '/';
  CurrentBrickFolder := tmpPath;
end;

procedure TfrmNXTExplorer.NXTFilesDblClick(Sender: TObject);
var
  item : TListItem;
  fType : TPBRFileType;
begin
  item := NXTFiles.Selected;
  if not Assigned(item) then
    Exit;
  fType := TPBRFileType(item.ImageIndex);
  if (fType = nftFolder) then
  begin
    ChangeFolder(item.Caption);
    RefreshNXTFiles;
  end
  else if (fType = nftSound) then
  begin
    BrickComm.DCPlaySoundFile(CurrentBrickFolder + item.Caption, False);
  end
  else if (fType = nftProgram) then
  begin
    BrickComm.DCStartProgram(CurrentBrickFolder + item.Caption);
  end;
end;

procedure TfrmNXTExplorer.SetCurrentBrickFolder(const Value: string);
begin
  fCurrentBrickFolder := Value;
  lblPath.Caption := fCurrentBrickFolder;
end;

procedure TfrmNXTExplorer.HandleDownloadStart(Sender: TObject);
begin
  barProgress.Visible := True;
end;

procedure TfrmNXTExplorer.HandleDownloadDone(Sender: TObject);
begin
  barProgress.Visible := False;
  fTotal := -1;
end;

procedure TfrmNXTExplorer.HandleDownloadStatus(Sender: TObject; cur,
  total: Integer; var Abort: boolean);
begin
  ProgressTotal := total;
  Current := cur;
  Abort := False;
end;

procedure TfrmNXTExplorer.SetCurrent(const Value: integer);
begin
  fCur := Value;
  barProgress.Position := Value;
  Application.ProcessMessages;
end;

procedure TfrmNXTExplorer.SetTotal(const Value: integer);
begin
  if fTotal = -1 then
  begin
    barProgress.Min := 0;
    barProgress.Max := Value;
    Application.ProcessMessages;
    fTotal := Value;
  end;
end;

procedure TfrmNXTExplorer.lblPathDblClick(Sender: TObject);
var
  newPath : string;
begin
  // prompt for new path
  newPath := InputBox(sSelectPath, sEnterPath, CurrentBrickFolder);
  if newPath <> CurrentBrickFolder then
  begin
    ChangeFolder(newPath);
    RefreshNXTFiles;
  end;
end;

procedure TfrmNXTExplorer.actFileCreateFolderExecute(Sender: TObject);
var
  newFolder : string;
begin
  // prompt for a folder name
  newFolder := ExtractUnixFileName(InputBox(sFolderName, sEnterFolder, ''));
  if newFolder <> '' then
  begin
    BrickComm.CreateFolder(CurrentBrickFolder + newFolder);
    RefreshNXTFiles;
 end;
end;

initialization
{$IFDEF FPC}
  {$i uNXTExplorer.lrs}
{$ENDIF}

end.