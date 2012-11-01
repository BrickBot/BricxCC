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
 * Portions of this code are covered under the GExperts license
 * http://www.gexperts.org/license.html
 *
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uGrepResults;

interface

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  Classes, Graphics, Controls, Forms,
  StdCtrls, ExtCtrls, uGrepBackend, uGrepExpert, ComCtrls,
  Menus, ActnList, ToolWin, ImgList;

type
  TfmGrepResults = class(TForm)
    StatusBar: TStatusBar;
    lbResults: TListBox;
    MainMenu: TMainMenu;
    mitFile: TMenuItem;
    mitFileSearch: TMenuItem;
    mitFileExit: TMenuItem;
    mitFilePrint: TMenuItem;
    mitList: TMenuItem;
    mitListContract: TMenuItem;
    mitListExpand: TMenuItem;
    mitFileAbort: TMenuItem;
    mitListGotoSelected: TMenuItem;
    mitFileRefresh: TMenuItem;
    Actions: TActionList;
    actFileSearch: TAction;
    actFileRefresh: TAction;
    actFileAbort: TAction;
    actFilePrint: TAction;
    actViewStayOnTop: TAction;
    actFileExit: TAction;
    actListGotoSelected: TAction;
    actListContract: TAction;
    actListExpand: TAction;
    ToolBar: TToolBar;
    tbnSearch: TToolButton;
    tbnRefresh: TToolButton;
    tbnAbort: TToolButton;
    tbnSep2: TToolButton;
    tbnGoto: TToolButton;
    tbnSep3: TToolButton;
    tbnPrint: TToolButton;
    tbnSep4: TToolButton;
    tbnContract: TToolButton;
    tbnExpand: TToolButton;
    tbnSep1: TToolButton;
    tbnSep5: TToolButton;
    mitListSep1: TMenuItem;
    mitFileSep1: TMenuItem;
    reContext: TRichEdit;
    Splitter: TSplitter;
    mitViewSep1: TMenuItem;
    actViewShowContext: TAction;
    miViewShowMatchContext: TMenuItem;
    actFileSave: TAction;
    actFileCopy: TAction;
    mitFileSave: TMenuItem;
    mitFileCopy: TMenuItem;
    mitFileSep3: TMenuItem;
    mitView: TMenuItem;
    actViewToolBar: TAction;
    mitViewToolBar: TMenuItem;
    mitViewOptions: TMenuItem;
    actViewOptions: TAction;
    actReplaceAll: TAction;
    actReplaceSelected: TAction;
    tbnReplaceAll: TToolButton;
    tbnReplaceSelected: TToolButton;
    mitReplace: TMenuItem;
    mitReplaceReplaceAll: TMenuItem;
    mitReplaceSelected: TMenuItem;
    mitListSep2: TMenuItem;
    pnlMain: TPanel;
    Images: TImageList;
    DisabledImages: TImageList;
    procedure FormResize(Sender: TObject);
    procedure lbResultsMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure lbResultsKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure lbResultsDrawItem(Control: TWinControl; Index: Integer; Rect: TRect; State: TOwnerDrawState);
    procedure actFileSearchExecute(Sender: TObject);
    procedure actFileRefreshExecute(Sender: TObject);
    procedure actFileAbortExecute(Sender: TObject);
    procedure actFilePrintExecute(Sender: TObject);
    procedure actFileCopyExecute(Sender: TObject);
    procedure actFileSaveExecute(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actListGotoSelectedExecute(Sender: TObject);
    procedure actListContractExecute(Sender: TObject);
    procedure actListExpandExecute(Sender: TObject);
    procedure ActionsUpdate(aAction: TBasicAction; var Handled: Boolean);
    procedure lbResultsClick(Sender: TObject);
    procedure actShowMatchContextExecute(Sender: TObject);
    procedure actViewToolBarExecute(Sender: TObject);
    procedure actViewOptionsExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actReplaceAllExecute(Sender: TObject);
    procedure actReplaceSelectedExecute(Sender: TObject);
    procedure lbResultsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    FSearchInProgress: Boolean;
    FReplaceInProgress: Boolean;
    FGrepSettings: TGrepSettings;
    FSearcher: TGrepSearchRunner;
    FShowContext: Boolean;
    FDoSearchReplace: Boolean;
    procedure RefreshContextLines;
    procedure SetShowContext(Value: Boolean);
    procedure HighlightMemo(FileMatches: TFileResult; StartLine, MatchLineNo: Integer);
    procedure StartFileSearch(Sender: TObject; const FileName: string);
    procedure SaveSettings;
    procedure LoadSettings;
    procedure ToggleFileResultExpanded(ListBoxIndex: Integer);
    procedure ExpandList;
    procedure ContractList;
    procedure ResizeListBox;
    procedure GotoHighlightedListEntry;
    procedure ClearResultsListbox;
    function ShowModalForm(Dlg: TCustomForm): TModalResult;
    function QueryUserForGrepOptions: Boolean;
    function QueryUserForReplaceOptions(const ReplaceInString: string): Boolean;
    procedure Abort;
    procedure SetStatusString(const StatusStr: string);
    procedure SetMatchString(const MatchStr: string);
    function DoingSearchOrReplace: Boolean;
    procedure ExpandOrContractList(Expand: Boolean);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure AssignSettingsToForm;
    function ConfigurationKey: string;
  public
    GrepExpert: TGrepExpert;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Execute(DoRefresh: Boolean);
    property ShowContext: Boolean read FShowContext write SetShowContext;
    property DoSearchReplace: Boolean read FDoSearchReplace write FDoSearchReplace;
  end;

var
  fmGrepResults: TfmGrepResults = nil;

implementation

{$R *.dfm}

uses
  SysUtils, Messages, Math,
  uGrepPrinting, uGrepSearch, uReplace, uGrepReplace, uGrepCommonUtils,
  uGuiUtils;

resourcestring
  SGrepReplaceStats = 'Replaced %d occurrence(s) in %.2f seconds';

procedure GoToMatchLine(MatchLine: TLineResult; SourceEditorInMiddle: Boolean);
var
  MatchFileName: string;
resourcestring
  SCouldNotOpenFile = 'Could not open file %s';
begin
  MatchFileName := TFileResult(MatchLine.Collection).FileName;

  GxOtaGoToFileLineColumn(MatchFileName, MatchLine.LineNo, MatchLine.Matches[0].SPos, MatchLine.Matches[0].EPos, SourceEditorInMiddle);
end;

{ TfmGrepResults }

procedure TfmGrepResults.StartFileSearch(Sender: TObject; const FileName: string);
resourcestring
  SProcessing = 'Processing %s';
var
  Dummy: Boolean;
begin
  SetStatusString(Format(SProcessing, [FileName]));
  ActionsUpdate(nil, Dummy);
  Application.ProcessMessages;
end;

procedure TfmGrepResults.Execute(DoRefresh: Boolean);
resourcestring
  SGrepActive = 'A Grep search is currently active; either abort it or wait until it is finished.';
  SGrepSearchStats = 'Searched %d files in %.2f seconds for "%s"';
  SMatches = '%d matches';
  SMatches1 = '%d match';
  SFiles = 'in %d files';
  SFiles1 = 'in %d file';
var
  TimeStart: TDateTime;
  FilesSearched: Cardinal;
  MatchesFound: Cardinal;
  FilesHit: Cardinal;
  MatchString: string;
  ResultFiles : TStringList;
  i : integer;
begin
  if FSearchInProgress then
    raise Exception.Create(SGrepActive);

  if not (DoRefresh and FGrepSettings.CanRefresh) then
    if not QueryUserForGrepOptions then
      Exit;

  reContext.Clear;

  ResultFiles := TStringList.Create;
  try
    ContractList;
    for i := 0 to lbResults.Items.Count - 1 do
      ResultFiles.Add(lbResults.Items[i]);
    SetStatusString('');
    SetMatchString('');
    ClearResultsListbox;
    BringToFront;
    Self.Show;
//    IdeDockManager.ShowForm(Self);
    EnsureFormVisible(Self);

    TimeStart := Now;

    FSearcher := TGrepSearchRunner.Create(FGrepSettings, lbResults.Items, ResultFiles);
    try
      FSearcher.OnSearchFile := StartFileSearch;
      FSearchInProgress := True;
      FSearcher.Execute;
      FilesSearched := FSearcher.FileSearchCount;
      MatchesFound := FSearcher.MatchCount;
    finally
      FreeAndNil(FSearcher);
      FSearchInProgress := False;
    end;
  finally
    ResultFiles.Free;
  end;

  FilesHit := lbResults.Items.Count;

  SetStatusString(Format(SGrepSearchStats, [FilesSearched, (Now - TimeStart) * 24*60*60, FGrepSettings.Pattern]));

  lbResults.Sorted := True;  // There is no Sort method
  lbResults.Sorted := False;
  if (lbResults.Items.Count = 1) or GrepExpert.GrepExpandAll then
  begin
    lbResults.ItemIndex := 0;
    ExpandList;
  end;

  lbResults.Refresh;

  if MatchesFound = 1 then
    MatchString := Format(SMatches1, [MatchesFound])
  else
    MatchString := Format(SMatches, [MatchesFound]);

  if FilesHit = 1 then
    MatchString := MatchString + ' ' + Format(SFiles1, [FilesHit])
  else
    MatchString := MatchString + ' ' + Format(SFiles, [FilesHit]);

  SetMatchString(MatchString);
end;

procedure TfmGrepResults.ClearResultsListbox;
var
  i: Integer;
  j: Integer;
begin
  for i := 0 to lbResults.Items.Count - 1 do
  begin
    if lbResults.Items.Objects[i] is TFileResult then
    begin
      j := i + 1;
      // First nil out all child item pointers before
      // freeing the parent collection
      while (j < lbResults.Items.Count) and (lbResults.Items.Objects[j] is TLineResult) do
      begin
        lbResults.Items.Objects[j] := nil;
        Inc(j);
      end;
      lbResults.Items.Objects[i].Free;
      lbResults.Items.Objects[i] := nil;
    end;
  end;
  lbResults.Items.Clear;
end;

procedure TfmGrepResults.FormResize(Sender: TObject);
begin
  StatusBar.Panels.Items[0].Width := StatusBar.Width - 175;
  lbResults.Refresh;
end;

procedure TfmGrepResults.SaveSettings;
var
  Settings: TGExpertsSettings;
begin
  // Do not localize any of the below strings.
  Settings := TGExpertsSettings.Create;
  try
    Settings.WriteInteger(ConfigurationKey, 'Left', Left);
    Settings.WriteInteger(ConfigurationKey, 'Top', Top);
    Settings.WriteInteger(ConfigurationKey, 'Width', Width);
    Settings.WriteInteger(ConfigurationKey, 'Height', Height);
    Settings.WriteInteger(ConfigurationKey, 'ResultsHeight', lbResults.Height);
    Settings.WriteBool(ConfigurationKey, 'ShowToolBar', ToolBar.Visible);
    Settings.WriteBool(ConfigurationKey, 'ShowContext', ShowContext);
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TfmGrepResults.LoadSettings;
var
  Settings: TGExpertsSettings;
begin
  // Do not localize any of the below strings.
  Settings := TGExpertsSettings.Create;
  try
    Left := Settings.ReadInteger(ConfigurationKey, 'Left', Left);
    Top := Settings.ReadInteger(ConfigurationKey, 'Top', Top);
    Width := Settings.ReadInteger(ConfigurationKey, 'Width', Width);
    Height := Settings.ReadInteger(ConfigurationKey, 'Height', Height);
    lbResults.Height := Settings.ReadInteger(ConfigurationKey, 'ResultsHeight', lbResults.Height);
    ShowContext := Settings.ReadBool(ConfigurationKey, 'ShowContext', True);
    ToolBar.Visible := Settings.ReadBool(ConfigurationKey, 'ShowToolBar', ToolBar.Visible);
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TfmGrepResults.lbResultsClick(Sender: TObject);
begin
  RefreshContextLines;
end;

procedure TfmGrepResults.actShowMatchContextExecute(Sender: TObject);
begin
  ShowContext := not ShowContext;
end;

procedure TfmGrepResults.SetShowContext(Value: Boolean);
begin
  FShowContext := Value;
  reContext.Visible := ShowContext;
  Splitter.Visible := ShowContext;
  RefreshContextLines;
end;

procedure TfmGrepResults.RefreshContextLines;
resourcestring
  SMatchContextNotAvail = 'Unable to load match context lines';
var
  CurrentLine: TLineResult;
  MatchLineNo, BeginLineNo, EndLineNo, REMatchLineNo: Integer;
  FileLines: TStringList;
  FileName: string;
  i: Integer;
begin
  if not ShowContext then
    Exit;

  reContext.Lines.BeginUpdate;
  try
    reContext.Clear;
    if (lbResults.ItemIndex < 0) then
      Exit;
    if (ShowContext) and (GrepExpert.NumContextLines > 0) then
    begin
      if (lbResults.Items.Objects[lbResults.ItemIndex] is TLineResult) then
      begin
        CurrentLine := TLineResult(lbResults.Items.Objects[lbResults.ItemIndex]);
        FileName := TFileResult(CurrentLine.Collection).FileName;
        MatchLineNo := CurrentLine.LineNo - 1;

        FileLines := TStringList.Create;
        try
          LoadDiskFileToStrings(FileName, FileLines);
          if FileLines.Count < 1 then
          begin
            reContext.Lines.Text := SMatchContextNotAvail;
            Exit;
          end;

          BeginLineNo := MatchLineNo - GrepExpert.NumContextLines;
          BeginLineNo := Max(BeginLineNo, 0);
          EndLineNo := MatchLineNo + GrepExpert.NumContextLines;
          EndLineNo := Min(EndLineNo, FileLines.Count - 1);

          REMatchLineNo := 0;
          reContext.SelStart := reContext.GetTextLen;
          for i := BeginLineNo to EndLineNo do
          begin
            reContext.SelText := FileLines[i] + sLineBreak;
            if i = MatchLineNo then
              REMatchLineNo := reContext.Lines.Count - 1;
          end;
        finally
          FreeAndNil(FileLines);
        end;
        HighlightMemo(TFileResult(CurrentLine.Collection), BeginLineNo, REMatchLineNo);
      end;
    end;
  finally
    reContext.Lines.EndUpdate;
  end;
end;

// Make any matches found in the context lines bold
// Also highlight the current match line using clHighlightText
procedure TfmGrepResults.HighlightMemo(FileMatches: TFileResult; StartLine, MatchLineNo: Integer);
var
  Matches: TMatchArray;
  i, j: Integer;
begin
  reContext.SelStart := 0;
  reContext.SelLength := Length(reContext.Lines.Text);
  reContext.SelAttributes.Name := reContext.DefAttributes.Name;
  reContext.SelAttributes.Size := reContext.DefAttributes.Size;
  reContext.SelAttributes.Style := [];

  // Highlight the matched line
  reContext.SelStart := reContext.Perform(EM_LINEINDEX, MatchLineNo, 0);
  reContext.SelLength := Length(reContext.Lines[MatchLineNo]);
  reContext.SelAttributes.Color := GrepExpert.ContextMatchColor;

  for i := StartLine + 1 to StartLine + reContext.Lines.Count + 1 do
  begin
    FileMatches.GetMatchesOnLine(i, Matches);
    for j := 0 to Length(Matches) - 1 do
    begin
      if Matches[j].ShowBold then
      begin
        reContext.SelStart := reContext.Perform(EM_LINEINDEX, i - StartLine - 1, 0) + Matches[j].SPos - 1;
        reContext.SelLength := Matches[j].EPos - Matches[j].SPos + 1;
        reContext.SelAttributes.Style := [fsBold];
      end;
    end;
  end;
  reContext.SelStart := 0;
end;

procedure TfmGrepResults.lbResultsMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ClickedEntry: Integer;
begin
  if Button = mbLeft then
  begin
    ClickedEntry := lbResults.ItemAtPos(Point(X, Y), True);
    if (ClickedEntry <> -1) and
       (lbResults.Items.Objects[ClickedEntry] is TFileResult) then
    begin
      ToggleFileResultExpanded(ClickedEntry);
    end;
  end;
end;

procedure TfmGrepResults.ToggleFileResultExpanded(ListBoxIndex: Integer);
var
  AFileResult: TFileResult;
  i: Integer;
begin
  if FSearchInProgress or
     (ListBoxIndex < 0) or (ListBoxIndex >= lbResults.Items.Count) then
  begin
    Exit;
  end;

  if lbResults.Items.Objects[ListBoxIndex] is TFileResult then
  begin
    AFileResult := TFileResult(lbResults.Items.Objects[ListBoxIndex]);

    lbResults.Items.BeginUpdate;
    try
      if AFileResult.Expanded then
      begin
        while (ListBoxIndex + 1 <= lbResults.Items.Count - 1) and
              (not (lbResults.Items.Objects[ListBoxIndex + 1] is TFileResult)) do
        begin
          lbResults.Items.Delete(ListBoxIndex + 1);
        end;
        AFileResult.Expanded := False;
      end
      else
      begin
        for i := AFileResult.Count - 1 downto 0 do
          lbResults.Items.InsertObject(ListBoxIndex + 1, AFileResult.Items[i].Line, AFileResult.Items[i]);
        AFileResult.Expanded := True;
      end
    finally
      lbResults.Items.EndUpdate;
    end;
  end;
end;

procedure TfmGrepResults.lbResultsKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  i: Integer;
begin
  lbResults.Items.BeginUpdate;
  try
    i := lbResults.ItemIndex;
    if (i < 0) then
      Exit;

    // Search for a TFileResult above the selected line
    while (i > 0) and not (lbResults.Items.Objects[i] is TFileResult) do
      Dec(i);

    if not (lbResults.Items.Objects[i] is TFileResult) then
      Exit;

    if  (Key in [VK_LEFT, VK_RIGHT])
      and (TFileResult(lbResults.Items.Objects[i]).Expanded = (Key = VK_LEFT)) then
    begin
      lbResults.ItemIndex := i;
      ToggleFileResultExpanded(i);
      Key := 0;
    end;

  finally
    lbResults.Items.EndUpdate;
  end;
end;

procedure TfmGrepResults.lbResultsKeyPress(Sender: TObject; var Key: Char);
begin
  case Key of
    '+', '-':
      ToggleFileResultExpanded(lbResults.ItemIndex);
    #13:
      GotoHighlightedListEntry;
  end;
end;

procedure TfmGrepResults.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    if FSearchInProgress then
      Self.Abort
    else
    begin
      Hide;
    end;
  end;
end;

procedure TfmGrepResults.ResizeListBox;
begin
  lbResults.Canvas.Font.Assign(lbResults.Font);
  lbResults.ItemHeight := lbResults.Canvas.TextHeight(SAllAlphaNumericChars) + 3;
  lbResults.Refresh;
end;

procedure TfmGrepResults.lbResultsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  ResultsCanvas: TCanvas;
  LineText: string;
resourcestring
  SItemMatch = '%5d matches';

  procedure PaintFileHeader;
  var
    TopColor: TColor;
    BottomColor: TColor;
    i: Integer;
    FileNameWidth: Integer;
    FileString: string;
    FileResult: TFileResult;
  begin
    TopColor := clBtnHighlight;
    BottomColor := clBtnShadow;

    FileResult := TFileResult(lbResults.Items.Objects[Index]);
    // Paint an expandable search file header (gray)
    ResultsCanvas.Brush.Color := clBtnFace;
    ResultsCanvas.Font.Color := clBtnText;
    ResultsCanvas.FillRect(Rect);

    Rect.Right := Rect.Right + 2;
    if odSelected in State then
      Frame3D(ResultsCanvas, Rect, BottomColor, TopColor, 1)
    else
      Frame3D(ResultsCanvas, Rect, TopColor, BottomColor, 1);

    i := ResultsCanvas.TextWidth('+');
    FileString := FileResult.RelativeFileName;
    ResultsCanvas.TextOut(Rect.Left + i + 8, Rect.Top, FileString);

    if FileResult.Expanded then
      ResultsCanvas.TextOut(Rect.Left + 3, Rect.Top, '-')
    else
      ResultsCanvas.TextOut(Rect.Left + 3, Rect.Top, '+');

    LineText := Format(SItemMatch, [FileResult.TotalMatches]);

    FileNameWidth := ResultsCanvas.TextWidth(LineText) + 10;
    if (ResultsCanvas.TextWidth(FileString) + i + 10) <= Rect.Right - FileNameWidth then
      ResultsCanvas.TextOut(lbResults.ClientWidth - FileNameWidth, Rect.Top, LineText);
  end;

  procedure PaintLineMatch;
  var
    i: Integer;
    ALineResult: TLineResult;
    LineNoWidth: Integer;
    PaintText: string;
    Trimmed: Integer;
    TextTop: Integer;
    sb: TColor;
    sf: TColor;
    nb: TColor;
    nf: TColor;
    Match: TMatchResult;
    NextMatchStart: Integer;
    PrevMatchEnd: Integer;
  begin
    // Paint a search match line number and highlighted match
    ALineResult := lbResults.Items.Objects[Index] as TLineResult;

    if odSelected in State then
    begin
      nb := clHighLight;
      nf := clHighLightText;
      sb := clWindow;
      sf := clWindowText;
    end
    else
    begin
      sb := clHighLight;
      sf := clHighLightText;
      nb := clWindow;
      nf := clWindowText;
    end;

    // Paint line number of match line
    TextTop := Rect.Top + 1;
    ResultsCanvas.Brush.Color := nb;
    ResultsCanvas.Font.Color := nf;
    ResultsCanvas.FillRect(Rect);
    ResultsCanvas.TextOut(Rect.Left + 10, TextTop, IntToStr(ALineResult.LineNo));

    LineNoWidth := 60;
    LineText := lbResults.Items[Index];
    Trimmed := LeftTrimChars(LineText);
    PrevMatchEnd := 0;

    // Paint first match line up to first match character
    PaintText := Copy(LineText, 0, ALineResult.Matches[0].SPos - 1 - Trimmed);
    ResultsCanvas.TextOut(Rect.Left + LineNoWidth, TextTop, PaintText);

    // For each match, paint out the match and then the text until the next match
    for i := 0 to ALineResult.Matches.Count - 1 do
    begin
      // Paint the highlighted match
      Match := ALineResult.Matches[i];
      PaintText := Copy(LineText, Max(Match.SPos, PrevMatchEnd + 1) - Trimmed, Match.Length);
      ResultsCanvas.Font.Color := sf;
      ResultsCanvas.Brush.Color := sb;
      ResultsCanvas.TextOut(ResultsCanvas.PenPos.X + 1, TextTop, PaintText);
      PrevMatchEnd := Match.EPos;

      // Paint any non-matching text after the match
      if i = ALineResult.Matches.Count - 1 then
        NextMatchStart := Length(LineText) + Trimmed
      else
        NextMatchStart := ALineResult.Matches[i + 1].SPos - Trimmed - 1;
      PaintText := Copy(LineText, Match.EPos - Trimmed + 1, NextMatchStart - Match.EPos + Trimmed);
      ResultsCanvas.Font.Color := nf;
      ResultsCanvas.Brush.Color := nb;
      ResultsCanvas.TextOut(ResultsCanvas.PenPos.X + 1, TextTop, PaintText);
    end;
  end;

begin
  ResultsCanvas := lbResults.Canvas;
  if lbResults.Items.Objects[Index] is TFileResult then
    PaintFileHeader
  else
    PaintLineMatch;
end;

procedure TfmGrepResults.actFileSearchExecute(Sender: TObject);
begin
  Execute(False);
end;

procedure TfmGrepResults.actFileRefreshExecute(Sender: TObject);
begin
  Execute(True);
  RefreshContextLines;
end;

procedure TfmGrepResults.actFileAbortExecute(Sender: TObject);
begin
  Self.Abort;
end;

procedure TfmGrepResults.actFilePrintExecute(Sender: TObject);
begin
  PrintGrepResults(Self, lbResults.Items, grPrint);
end;

procedure TfmGrepResults.actFileCopyExecute(Sender: TObject);
begin
  if (ActiveControl = reContext) and (reContext.SelLength > 0) then
    reContext.CopyToClipboard
  else
    PrintGrepResults(Self, lbResults.Items, grCopy);
end;

procedure TfmGrepResults.actFileSaveExecute(Sender: TObject);
begin
  PrintGrepResults(Self, lbResults.Items, grFile);
end;

procedure TfmGrepResults.actFileExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TfmGrepResults.actListGotoSelectedExecute(Sender: TObject);
begin
  GotoHighlightedListEntry;
end;

procedure TfmGrepResults.actListContractExecute(Sender: TObject);
begin
  ContractList;
end;

procedure TfmGrepResults.actListExpandExecute(Sender: TObject);
begin
  ExpandList;
end;

procedure TfmGrepResults.ExpandOrContractList(Expand: Boolean);

  function ExpandFileResult(ListBoxIndex: Integer): Integer;
  var
    FileResult: TFileResult;
    t: Integer;
  begin
    FileResult := lbResults.Items.Objects[ListBoxIndex] as TFileResult;

    for t := FileResult.Count - 1 downto 0 do
      lbResults.Items.InsertObject(ListBoxIndex + 1, FileResult.Items[t].Line, FileResult.Items[t]);

    FileResult.Expanded := True;
    Result := ListBoxIndex + FileResult.Count - 1;
  end;

var
  i: Integer;
begin
  lbResults.Items.BeginUpdate;
  try
    RefreshContextLines;

    i := 0;
    while i <= lbResults.Items.Count - 1 do
    begin
      if Expand then
      begin
        if lbResults.Items.Objects[i] is TFileResult then
        begin
          if not TFileResult(lbResults.Items.Objects[i]).Expanded then
            i := ExpandFileResult(i);
        end;

        Inc(i);
      end
      else // Contract
      begin
       if lbResults.Items.Objects[i] is TLineResult then
          lbResults.Items.Delete(i)
        else
        begin
          (lbResults.Items.Objects[i] as TFileResult).Expanded := False;
          Inc(i);
        end;
      end;
    end;
  finally
    lbResults.Items.EndUpdate;
  end;
end;

procedure TfmGrepResults.ExpandList;
begin
  ExpandOrContractList(True);
end;

procedure TfmGrepResults.ContractList;
begin
  ExpandOrContractList(False);
end;

procedure TfmGrepResults.GotoHighlightedListEntry;
var
  CurrentLine: TLineResult;
  ResultIndex: Integer;
begin
  ResultIndex := lbResults.ItemIndex;
  if ResultIndex < 0 then
    Exit;

  if lbResults.Items.Objects[ResultIndex] is TFileResult then
  begin
    ToggleFileResultExpanded(ResultIndex);
    Exit;
  end;

  CurrentLine := lbResults.Items.Objects[ResultIndex] as TLineResult;
  if CurrentLine = nil then
    Exit;

  GoToMatchLine(CurrentLine, GrepExpert.GrepMiddle);

end;

constructor TfmGrepResults.Create(AOwner: TComponent);
begin
  inherited;
//  SetToolbarGradient(ToolBar);

  FSearchInProgress := False;
  lbResults.DoubleBuffered := True;
  CenterForm(Self);
  LoadSettings;
  ResizeListBox;
end;

destructor TfmGrepResults.Destroy;
begin
  Self.Abort;
  SaveSettings;

  ClearResultsListbox;

  inherited Destroy;

  fmGrepResults := nil;
end;

procedure TfmGrepResults.ActionsUpdate(aAction: TBasicAction; var Handled: Boolean);
var
  HaveItems: Boolean;
  Processing: Boolean;
begin
  HaveItems := (lbResults.Items.Count > 0);
  Processing := DoingSearchOrReplace;
  actFileSearch.Enabled := not Processing;
  actFileRefresh.Enabled := not Processing;
  actViewOptions.Enabled := not Processing;
  actViewStayOnTop.Enabled := not Processing;
  actFilePrint.Enabled := not Processing and HaveItems;
  actFileSave.Enabled := not Processing and HaveItems;
  actFileCopy.Enabled := not Processing and HaveItems;
  actListGotoSelected.Enabled := not Processing and HaveItems;
  actListContract.Enabled := not Processing and HaveItems;
  actListExpand.Enabled := not Processing and HaveItems;
  actFileAbort.Enabled := Processing;
  actViewShowContext.Checked := ShowContext;
  actViewToolBar.Checked := ToolBar.Visible;
  actReplaceSelected.Enabled := not Processing and HaveItems;
  actReplaceAll.Enabled := not Processing and HaveItems;
  actViewStayOnTop.Visible := False;
end;

function TfmGrepResults.ShowModalForm(Dlg: TCustomForm): TModalResult;
begin
  Result := mrCancel;
  if Dlg.ShowModal <> mrOk then
    Exit;
  Result := mrOk;
end;

procedure TfmGrepResults.Abort;
begin
  if FSearcher <> nil then
    FSearcher.AbortSignalled := True;
end;

procedure TfmGrepResults.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TfmGrepResults.actViewToolBarExecute(Sender: TObject);
begin
  ToolBar.Visible := not ToolBar.Visible;
end;

procedure TfmGrepResults.actViewOptionsExecute(Sender: TObject);
begin
  GrepExpert.Configure;
  AssignSettingsToForm;
  ResizeListBox;
  RefreshContextLines;
end;

procedure TfmGrepResults.FormShow(Sender: TObject);
begin
  AssignSettingsToForm;
  ResizeListBox;
end;

procedure TfmGrepResults.AssignSettingsToForm;
begin
  Assert(Assigned(GrepExpert));
  reContext.Font.Assign(GrepExpert.ContextFont);
  lbResults.Font.Assign(GrepExpert.ListFont);
end;

procedure TfmGrepResults.actReplaceAllExecute(Sender: TObject);
var
  TimeStart: TDateTime;
  MatchesFound: Integer;
begin
  Assert(not DoingSearchOrReplace);

  if not QueryUserForReplaceOptions('All matched files') then
    Exit;

  FReplaceInProgress := True;
  try
    TimeStart := Now;
    SetStatusString('');
    MatchesFound := ReplaceAll(lbResults.Items, FGrepSettings);
    SetStatusString(Format(SGrepReplaceStats, [MatchesFound, (Now - TimeStart) * 24*60*60]));
  finally
    FReplaceInProgress := False;
  end;
  RefreshContextLines;
end;

resourcestring
  SReplaceLine = sLineBreak + 'On line: ';

procedure TfmGrepResults.actReplaceSelectedExecute(Sender: TObject);
var
  TimeStart: TDateTime;
  MatchesFound: Integer;
  CurrentLine: TLineResult;
  ResultIndex: Integer;
  FileResult: TFileResult;
  MatchFile: string;
  ResultObject: TObject;
begin
  Assert(not DoingSearchOrReplace);

  ResultIndex := lbResults.ItemIndex;
  if ResultIndex < 0 then
    Exit;

  ResultObject := lbResults.Items.Objects[ResultIndex];
  FReplaceInProgress := True;
  try
    SetStatusString('');
    if ResultObject is TFileResult then
    begin
      FileResult := TFileResult(ResultObject);
      if not QueryUserForReplaceOptions(FileResult.FileName) then
        Exit;
      TimeStart := Now;
      MatchesFound := ReplaceAllInFiles(FileResult, FGrepSettings);
    end
    else if ResultObject is TLineResult then
    begin
      CurrentLine := ResultObject as TLineResult;
      MatchFile := TFileResult(CurrentLine.Collection).FileName;
      if not QueryUserForReplaceOptions(MatchFile + SReplaceLine + IntToStr(CurrentLine.LineNo)) then
        Exit;
      TimeStart := Now;
      MatchesFound := ReplaceLine(CurrentLine, FGrepSettings);
    end
    else
      raise Exception.Create('Internal Error: Unknown result type');
    SetStatusString(Format(SGrepReplaceStats, [MatchesFound, (Now - TimeStart) * 24*60*60]));
  finally
    FReplaceInProgress := False;
  end;
  RefreshContextLines;
end;

function TfmGrepResults.DoingSearchOrReplace: Boolean;
begin
  Result := FSearchInProgress or FReplaceInProgress;
end;

procedure TfmGrepResults.SetStatusString(const StatusStr: string);
begin
  StatusBar.Panels.Items[0].Text := StatusStr;
end;

procedure TfmGrepResults.SetMatchString(const MatchStr: string);
begin
  StatusBar.Panels.Items[1].Text := MatchStr;
end;

function TfmGrepResults.QueryUserForGrepOptions: Boolean;
var
  Dlg: TfmGrepSearch;
begin
  Result := False;
  Dlg := TfmGrepSearch.Create(nil);
  try
    if ShowModalForm(Dlg) <> mrOk then
      Exit;
    FGrepSettings.CanRefresh := True;
    SetMatchString('');
    Dlg.RetrieveSettings(FGrepSettings);
    Dlg.GrepExpert.SaveSettings;
    Result := True;
  finally
    FreeAndNil(Dlg);
  end;
end;

function TfmGrepResults.QueryUserForReplaceOptions(const ReplaceInString: string): Boolean;
var
  Dlg: TfmGrepReplace;
begin
//  ShowGxMessageBox(TShowUnicodeReplaceMessage);

  Result := False;
  Dlg := TfmGrepReplace.Create(nil);
  try
    Dlg.ReplaceInString := ReplaceInString;
    Dlg.SearchString := FGrepSettings.Pattern;
    if ShowModalForm(Dlg) <> mrOk then
      Exit;
    SetMatchString('');
    Dlg.RetrieveSettings(FGrepSettings);
    Result := True;
  finally
    FreeAndNil(Dlg);
  end;
end;

function TfmGrepResults.ConfigurationKey: string;
begin
  Result := TGrepExpert.ConfigurationKey;
end;

end.