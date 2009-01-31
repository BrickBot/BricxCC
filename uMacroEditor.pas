unit uMacroEditor;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, SynEditHighlighter, SynEdit, BricxccSynEdit, SynHighlighterNQC,
  SynCompletionProposal, SynEditEx, ExtCtrls;

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
    SynCompProp: TSynCompletionProposal;
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

{$R *.DFM}

uses
  SynEditKeyCmds;

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
  SynCompProp.ItemList.Assign(TheHighlighter.Commands);
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
    Gutter.Font.Charset := DEFAULT_CHARSET;
    Gutter.Font.Color := clWindowText;
    Gutter.Font.Height := -11;
    Gutter.Font.Name := 'Terminal';
    Gutter.Font.Style := [];
    Lines.Clear;
    Lines.Add('macro unnamed');
    Lines.Add('begin');
    Lines.Add('');
    Lines.Add('end');
    StructureLineColor := clNone;
  end;
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
end;

end.
