unit uForthConsole;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SynEdit, SynTerm, ImgList, ComCtrls, ToolWin, ActnList, Menus,
  SynEditEx, BricxccSynEdit, ExtCtrls, uOfficeComp;

type
  TfrmForthConsole = class(TForm)
    TheTerminal: TSynTerm;
    aclMain: TActionList;
    actConnect: TAction;
    actClose: TAction;
    actCopy: TAction;
    actCut: TAction;
    actPaste: TAction;
    actDownloadScript: TAction;
    edtConsoleOutput: TBricxccSynEdit;
    splConsole: TSplitter;
    actClearConsole: TAction;
    actHelp: TAction;
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
    pnlSep: TPanel;
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
    { Private declarations }
    fBrickCommWasOpen : Boolean;
    procedure DisconnectConsole;
    procedure ConnectConsole;
    procedure UpdateButtons;
    procedure WriteConsoleOutput(const aString : string);
  public
    { Public declarations }
    procedure UpdateSettings;
    procedure DownloadFile(const aFile : string);
    procedure DownloadScript(aStrings : TStrings);
  end;

var
  frmForthConsole: TfrmForthConsole;

implementation

uses
  MainUnit, brick_common, Preferences, rcx_link, CPDrv, Themes,
  uGuiUtils;

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
  // read settings from preferences
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
  if ThemeServices.ThemesEnabled then
    Self.Color := dxOffice11DockColor2
  else
    Self.Color := clBtnFace;
  ConfigBar(ogpMain);
end;

end.
