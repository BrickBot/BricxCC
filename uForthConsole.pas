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
unit uForthConsole;

interface

uses
  Classes, Graphics, Controls, Forms, StdCtrls, ExtCtrls, ComCtrls, ImgList,
  ToolWin, ActnList, Menus, uOfficeComp, SynEdit, SynTerm, SynEditEx,
  BricxccSynEdit;

type
  TfrmForthConsole = class(TForm)
    aclMain: TActionList;
    actConnect: TAction;
    actClose: TAction;
    actCopy: TAction;
    actCut: TAction;
    actPaste: TAction;
    actDownloadScript: TAction;
    splConsole: TSplitter;
    actClearConsole: TAction;
    actHelp: TAction;
    pnlSep: TPanel;
    edtConsoleOutput2: TMemo;
    procedure FormHide(Sender: TObject);
    procedure actConnectExecute(Sender: TObject);
    procedure actCloseExecute(Sender: TObject);
    procedure aclMainUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure FormShow(Sender: TObject);
    procedure actCutCopyPasteExecute(Sender: TObject);
    procedure TheTerminalDataSendResponse(Sender: TObject;
      var response: String; var abort, display: Boolean);
    procedure actDownloadScriptExecute(Sender: TObject);
    procedure actClearConsoleExecute(Sender: TObject);
    procedure actHelpExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    ocbMain: TOfficeControlBar;
    ogpMain: TOfficeGradientPanel;
    OfficeSpeedButton1: TOfficeSpeedButton;
    OfficeSpeedButton2: TOfficeSpeedButton;
    bvlFile: TBevel;
    OfficeSpeedButton3: TOfficeSpeedButton;
    OfficeSpeedButton4: TOfficeSpeedButton;
    Bevel1: TBevel;
    OfficeSpeedButton5: TOfficeSpeedButton;
    Bevel2: TBevel;
    OfficeSpeedButton6: TOfficeSpeedButton;
    Bevel3: TBevel;
    OfficeSpeedButton7: TOfficeSpeedButton;
    OfficeSpeedButton8: TOfficeSpeedButton;
    Bevel4: TBevel;
    fBrickCommWasOpen : Boolean;
    procedure DisconnectConsole;
    procedure ConnectConsole;
    procedure UpdateButtons;
    procedure WriteConsoleOutput(const aString : string);
    procedure CreateSynEditComponents;
    procedure CreateToolbar;
  public
    { Public declarations }
    TheTerminal: TSynTerm;
    edtConsoleOutput: TBricxccSynEdit;
    procedure UpdateSettings;
    procedure DownloadFile(const aFile : string);
    procedure DownloadScript(aStrings : TStrings);
  end;

var
  frmForthConsole: TfrmForthConsole;

implementation

uses
  SysUtils, Themes, CPDrv, MainUnit, uBasicPrefs, rcx_link, brick_common,  
  uGuiUtils, uCommonUtils;

{$R *.DFM}

function PortToPortNumber(const aPort : string) : TPortNumber;
var
  tmp : string;
begin
  Result := pnCOM1;
  tmp := aPort;
  if Pos('com', LowerCase(aPort)) = 1 then
  begin
    Delete(tmp, 1, 3); // delete COM
    Result := TPortNumber(StrToIntDef(tmp, 1));
  end
  else if LowerCase(aPort) = 'usb' then
    Result := pnUSB1;
end;

const
  IMAGE_ARRAY : array[Boolean] of Integer = (0, 1);

procedure TfrmForthConsole.ConnectConsole;
begin
  if BrickComm.IsOpen then
  begin
     fBrickCommWasOpen := True;
     BrickComm.Close;
  end;
  TheTerminal.Port := PortToPortNumber(BrickComm.Port);
  TheTerminal.Connect;
  TheTerminal.Warmup;
end;

procedure TfrmForthConsole.DisconnectConsole;
begin
  TheTerminal.Disconnect;
  if fBrickCommWasOpen then
    BrickComm.Open;
end;

procedure TfrmForthConsole.FormHide(Sender: TObject);
begin
  DisconnectConsole;
  TheTerminal.Clear;
  edtConsoleOutput.Clear;
  MainForm.SynForthCompProp.RemoveEditor(TheTerminal);
end;

procedure TfrmForthConsole.UpdateButtons;
begin
  actConnect.Checked        := TheTerminal.Connected;
  actCut.Enabled            := TheTerminal.SelAvail and not TheTerminal.ReadOnly;
  actCopy.Enabled           := TheTerminal.SelAvail;
  actPaste.Enabled          := TheTerminal.Connected and not TheTerminal.ReadOnly;
  actDownloadScript.Enabled := actPaste.Enabled;
  actClearConsole.Enabled   := True;
end;

procedure TfrmForthConsole.actConnectExecute(Sender: TObject);
begin
  actConnect.Checked := not actConnect.Checked;
  if actConnect.Checked then
    ConnectConsole
  else
    DisconnectConsole;
end;

procedure TfrmForthConsole.actCloseExecute(Sender: TObject);
begin
  Close;
end;

procedure TfrmForthConsole.aclMainUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  UpdateButtons;
end;

procedure TfrmForthConsole.FormShow(Sender: TObject);
begin
  UpdateSettings;
  if SyntaxHighlightConsole then
    TheTerminal.Highlighter := MainForm.SynForthSyn
  else
    TheTerminal.Highlighter := nil;
  if ConsoleCodeCompletion then
    MainForm.SynForthCompProp.AddEditor(TheTerminal);
end;

procedure TfrmForthConsole.actCutCopyPasteExecute(Sender: TObject);
begin
  if Sender = actCut then
    TheTerminal.CutToClipboard
  else if Sender = actCopy then
    TheTerminal.CopyToClipboard
  else if Sender = actPaste then
    TheTerminal.PasteFromClipboard;
end;

procedure TfrmForthConsole.TheTerminalDataSendResponse(Sender: TObject;
  var response: String; var abort, display: Boolean);
var
  l : Integer;
begin
  display := False;
  if not ConsoleOutputSeparate then
  begin
    l := Length(response);
    if Copy(response, l-1, 2) = #13#10 then
      Delete(response, l-1, 2);
  end;
  l := Pos('ABORTED', response);
  if StopScriptDLOnErrors then
    abort := l > 0;
  if (l > 0) or ShowAllConsoleOutput then
    display := True;
  display := display and not ConsoleOutputSeparate;
  if ConsoleOutputSeparate then
    WriteConsoleOutput(response);
end;

procedure TfrmForthConsole.actDownloadScriptExecute(Sender: TObject);
begin
  if Assigned(MainForm) then
  begin
    if MainForm.dlgOpen.Execute then
    begin
      TheTerminal.DownloadFile(MainForm.dlgOpen.FileName);
    end;
  end;
end;

procedure TfrmForthConsole.UpdateSettings;
var
  bWasConnected : Boolean;
begin
  // read settings 
  with TheTerminal do
  begin
    bWasConnected := Connected;
    if bWasConnected then Disconnect;
    InterCharacterDelay := ConsoleICDelay;
    InterLineDelay      := ConsoleILDelay;
    StripComments       := StripScriptComments;
    SkipBlankLines      := SkipBlankScriptLines;
    ReadFirstTimeout    := ConsoleUSBFirstTimeout;
    ReadICTimeout       := ConsoleUSBICTimeout;
    WriteTimeout        := ConsoleUSBWriteTimeout;
    Gutter.Visible      := ShowConsoleLineNumbers;
    Gutter.ShowLineNumbers := ShowConsoleLineNumbers;
    if bWasConnected then
    begin
      Connect;
      Warmup;
    end;
  end;
  splConsole.Visible       := ConsoleOutputSeparate;
  edtConsoleOutput.Visible := ConsoleOutputSeparate;
  splConsole.Align         := alTop;
  splConsole.Align         := alBottom;
end;

procedure TfrmForthConsole.actClearConsoleExecute(Sender: TObject);
begin
  TheTerminal.Clear;
  edtConsoleOutput.Clear;
end;

procedure TfrmForthConsole.DownloadFile(const aFile: string);
begin
  if not Visible then
    Show;
  ConnectConsole;
  UpdateButtons;
  TheTerminal.DownloadFile(aFile);
end;

procedure TfrmForthConsole.DownloadScript(aStrings: TStrings);
begin
  if not Visible then
    Show;
  ConnectConsole;
  UpdateButtons;
  TheTerminal.DownloadScript(aStrings);
end;

procedure TfrmForthConsole.WriteConsoleOutput(const aString: string);
begin
  if (Trim(aString) = '') and (aString <> ' ') then Exit;
  if Pos(#13, aString) <> 1 then
    edtConsoleOutput.SelText := #13 + TrimRight(aString)
  else
    edtConsoleOutput.SelText := TrimRight(aString);
  edtConsoleOutput.EnsureCursorPosVisible;
end;

procedure TfrmForthConsole.actHelpExecute(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TfrmForthConsole.FormCreate(Sender: TObject);
begin
  CreateSynEditComponents;
  CreateToolbar;
  if ThemeServices.ThemesEnabled then
    Self.Color := dxOffice11DockColor2
  else
    Self.Color := clBtnFace;
  ConfigBar(ogpMain);
end;

procedure TfrmForthConsole.CreateSynEditComponents;
begin
  TheTerminal := TSynTerm.Create(Self);
  with TheTerminal do
  begin
    Name := 'TheTerminal';
    Parent := Self;
    Left := 0;
    Top := 28;
    Width := 382;
    Height := 280;
    Cursor := crIBeam;
    HelpContext := 3202;
    Align := alClient;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'Courier New';
    Font.Style := [];
    ParentColor := False;
    ParentFont := False;
    TabOrder := 0;
    ReadOnly := True;
    SwFlow := sfXONXOFF;
    InterCharacterDelay := 10;
    InterLineDelay := 225;
    StripComments := False;
    SkipBlankLines := False;
    OnDataSendResponse := TheTerminalDataSendResponse;
  end;
  edtConsoleOutput := TBricxccSynEdit.Create(Self);
  CloneSynEdit(edtConsoleOutput, edtConsoleOutput2);
  with edtConsoleOutput do
  begin
    Gutter.Visible := False;
    Options := [eoShowScrollHint];
  end;
  // reset the splitter position
  splConsole.Align := alTop;
  splConsole.Align := alBottom;
end;

procedure TfrmForthConsole.CreateToolbar;
begin
  // create the toolbar container panel
  ocbMain := TOfficeControlBar.Create(Self);
  with ocbMain do
  begin
    Name := 'ocbMain';
    Parent := Self;
    Left := 0;
    Top := 0;
    Width := 382;
    Height := 26;
    Align := alTop;
    AutoSize := True;
    BevelInner := bvNone;
    BevelOuter := bvNone;
    Color := clWindow;
    ParentBackground := False;
    ParentColor := False;
    TabOrder := 1;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
  end;
  // now create the toolbar
  ogpMain := TOfficeGradientPanel.Create(Self);
  with ogpMain do
  begin
    Name := 'ogpMain';
    Parent := ocbMain;
    Left := 11;
    Top := 2;
    Width := 226;
    Height := 22;
    GradientFrom := clBtnFace;
    GradientTo := clBtnFace;
    BorderColor := clBlack;
    Horizontal := False;
    ParentShowHint := False;
    ShowHint := True;
    TabOrder := 0;
  end;
  OfficeSpeedButton1 := TOfficeSpeedButton.Create(Self);
  OfficeSpeedButton2 := TOfficeSpeedButton.Create(Self);
  bvlFile := TBevel.Create(Self);
  OfficeSpeedButton3 := TOfficeSpeedButton.Create(Self);
  OfficeSpeedButton4 := TOfficeSpeedButton.Create(Self);
  Bevel1 := TBevel.Create(Self);
  OfficeSpeedButton5 := TOfficeSpeedButton.Create(Self);
  Bevel2 := TBevel.Create(Self);
  OfficeSpeedButton6 := TOfficeSpeedButton.Create(Self);
  Bevel3 := TBevel.Create(Self);
  OfficeSpeedButton7 := TOfficeSpeedButton.Create(Self);
  OfficeSpeedButton8 := TOfficeSpeedButton.Create(Self);
  Bevel4 := TBevel.Create(Self);
  with OfficeSpeedButton1 do
  begin
    Name := 'OfficeSpeedButton1';
    Parent := ogpMain;
    Left := 77;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actPaste;
    ResourceName := 'IMG_PASTE';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with OfficeSpeedButton2 do
  begin
    Name := 'OfficeSpeedButton2';
    Parent := ogpMain;
    Left := 0;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actConnect;
    ResourceName := 'IMG_LED';
    Align := alLeft;
    AllowAllUp := True;
    GroupIndex := 1;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with bvlFile do
  begin
    Name := 'bvlFile';
    Parent := ogpMain;
    Left := 23;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with OfficeSpeedButton3 do
  begin
    Name := 'OfficeSpeedButton3';
    Parent := ogpMain;
    Left := 54;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actCopy;
    ResourceName := 'IMG_COPY';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with OfficeSpeedButton4 do
  begin
    Name := 'OfficeSpeedButton4';
    Parent := ogpMain;
    Left := 31;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actCut;
    ResourceName := 'IMG_CUT';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with Bevel1 do
  begin
    Name := 'Bevel1';
    Parent := ogpMain;
    Left := 131;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with OfficeSpeedButton5 do
  begin
    Name := 'OfficeSpeedButton5';
    Parent := ogpMain;
    Left := 108;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actDownloadScript;
    ResourceName := 'IMG_DOWNLOAD';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with Bevel2 do
  begin
    Name := 'Bevel2';
    Parent := ogpMain;
    Left := 100;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with OfficeSpeedButton6 do
  begin
    Name := 'OfficeSpeedButton6';
    Parent := ogpMain;
    Left := 139;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actClearConsole;
    ResourceName := 'IMG_CLEARMEM';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with Bevel3 do
  begin
    Name := 'Bevel3';
    Parent := ogpMain;
    Left := 162;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
  with OfficeSpeedButton7 do
  begin
    Name := 'OfficeSpeedButton7';
    Parent := ogpMain;
    Left := 170;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actClose;
    ResourceName := 'IMG_EXIT';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with OfficeSpeedButton8 do
  begin
    Name := 'OfficeSpeedButton8';
    Parent := ogpMain;
    Left := 201;
    Top := 0;
    Width := 23;
    Height := 22;
    Action := actHelp;
    ResourceName := 'IMG_HELP';
    Align := alLeft;
    Flat := True;
    ShowCaption := False;
    NumGlyphs := 4;
  end;
  with Bevel4 do
  begin
    Name := 'Bevel4';
    Parent := ogpMain;
    Left := 193;
    Top := 0;
    Width := 8;
    Height := 22;
    Align := alLeft;
    Shape := bsSpacer;
  end;
end;

end.