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
unit uMacroEditor;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
  LCLType,
{$ELSE}
  SynCompletionProposal,
{$ENDIF}
  Classes, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  SynEditHighlighter, SynEdit, BricxccSynEdit, SynHighlighterNQC,
  SynEditEx;

type
  TfrmMacroEditor = class(TForm)
    pnlBottom: TPanel;
    pnlTop: TPanel;
    pnlBotRight: TPanel;
    pnlBotLeft: TPanel;
    btnCancel: TButton;
    btnOK: TButton;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    TheHighlighter: TSynNQCSyn;
    procedure SetMacroText(const Value: string);
    function GetMacroText: string;
    function GetMacroName: string;
    procedure AddCommand(const S: string);
  private
{$IFNDEF FPC}
    SynCompProp: TSynCompletionProposal;
{$ENDIF}
    TheEditor: TBricxccSynEdit;
    procedure CreateSynComponents;
  public
    { Public declarations }
    property MacroText : string read GetMacroText write SetMacroText;
    property MacroName : string read GetMacroName;
  end;

var
  frmMacroEditor: TfrmMacroEditor;

implementation

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

uses
  SysUtils, Graphics, SynEditKeyCmds, uCommonUtils;

{ TfrmMacroEditor }

function TfrmMacroEditor.GetMacroName: string;
var
  s : string;
  i : Integer;
begin
  Result := '';
  if TheEditor.Lines.Count > 0 then
  begin
    s := Trim(TheEditor.Lines[0]);
    i := Pos('macro', s);
    if i = 1 then
    begin
      Delete(s, 1, 6);
      Result := Trim(s);
    end;
  end;
end;

function TfrmMacroEditor.GetMacroText: string;
begin
  Result := TheEditor.Text;
end;

procedure TfrmMacroEditor.SetMacroText(const Value: string);
begin
  TheEditor.Text := Value;
end;

procedure TfrmMacroEditor.FormCreate(Sender: TObject);
begin
  CreateSynComponents;
  TheHighlighter := TSynNQCSyn.Create(Self);
  with TheHighlighter do
  begin
    Name := 'TheHighlighter';
    DetectPreprocessor := False;
    Left := 136;
    Top := 128;
    CommentAttri.Foreground := clSilver;
    CommandAttri.Foreground := clMaroon;
    PreprocessorAttri.Foreground := clNone;
    FieldAttri.Foreground := clBlue;
    FieldAttri.Style := [];
    FieldDelim := sdSingleQuote;
    KeyWords.Clear;
    Commands.Clear;
    Constants.Clear;
    KeyWords.Add('begin');
    KeyWords.Add('end');
    KeyWords.Add('macro');
  end;
  GetEditorCommandValues(AddCommand);
{$IFNDEF FPC}
  SynCompProp.ItemList.Assign(TheHighlighter.Commands);
{$ENDIF}
  TheEditor.Highlighter := TheHighlighter;
end;

procedure TfrmMacroEditor.AddCommand(const S: string);
begin
  TheHighlighter.Commands.Add(S);
end;

procedure TfrmMacroEditor.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TfrmMacroEditor.CreateSynComponents;
begin
  TheEditor := TBricxccSynEdit.Create(Self);
  with TheEditor do
  begin
    Name := 'TheEditor';
    Parent := pnlTop;
    Left := 6;
    Top := 6;
    Width := 310;
    Height := 301;
    Cursor := crIBeam;
    HelpContext := 33003;
    Align := alClient;
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'Courier New';
    Font.Style := [];
    ParentColor := False;
    ParentFont := False;
    TabOrder := 0;
{$IFNDEF FPC}
    Gutter.Font.Charset := DEFAULT_CHARSET;
    Gutter.Font.Color := clWindowText;
    Gutter.Font.Height := -11;
    Gutter.Font.Name := 'Terminal';
    Gutter.Font.Style := [];
{$ENDIF}
    Lines.Clear;
    Lines.Add('macro unnamed');
    Lines.Add('begin');
    Lines.Add('');
    Lines.Add('end');
    StructureLineColor := clNone;
  end;
{$IFNDEF FPC}
  SynCompProp := TSynCompletionProposal.Create(Self);
  with SynCompProp do
  begin
    Name := 'SynCompProp';
    Options := [scoAnsiStrings, scoCaseSensitive, scoLimitToMatchedText];
    Width := 262;
    EndOfTokenChr := '()[]. ';
    TriggerChars := '.';
    Font.Charset := DEFAULT_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -11;
    Font.Name := 'MS Sans Serif';
    Font.Style := [];
    TitleFont.Charset := DEFAULT_CHARSET;
    TitleFont.Color := clBtnText;
    TitleFont.Height := -11;
    TitleFont.Name := 'MS Sans Serif';
    TitleFont.Style := [fsBold];
    ParamSepString := ' ';
    ShortCut := 16416;
    Editor := TheEditor;
  end;
{$ENDIF}
end;

{$IFDEF FPC}
initialization
  {$i uMacroEditor.lrs}
{$ENDIF}

end.
