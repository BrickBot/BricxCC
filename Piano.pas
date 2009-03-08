unit Piano;

interface

uses
  Classes, Controls, Forms, ExtCtrls, StdCtrls, Buttons, ComCtrls, uSpin,
  uMidi2MS;

type
  TPianoForm = class(TForm)
    pnlKeyboard: TPanel;
    Shape01: TShape;
    Shape03: TShape;
    Shape02: TShape;
    Shape05: TShape;
    Shape06: TShape;
    Shape04: TShape;
    Shape08: TShape;
    Shape10: TShape;
    Shape12: TShape;
    Shape07: TShape;
    Shape09: TShape;
    Shape11: TShape;
    Shape13: TShape;
    Shape15: TShape;
    Shape17: TShape;
    Shape14: TShape;
    Shape16: TShape;
    Shape007: TShape;
    Shape005: TShape;
    Shape003: TShape;
    Shape001: TShape;
    Shape006: TShape;
    Shape004: TShape;
    Shape002: TShape;
    grpLength: TGroupBox;
    radWhole: TRadioButton;
    radHalf: TRadioButton;
    radQuarter: TRadioButton;
    radEighth: TRadioButton;
    radSixteenth: TRadioButton;
    btnPlay: TButton;
    btnSave: TButton;
    TempMemo: TMemo;
    btnCopy: TButton;
    btnClear: TButton;
    btnRest: TBitBtn;
    barTranspose: TTrackBar;
    lblNoteTime: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    grpCode: TGroupBox;
    radGenNQC: TRadioButton;
    radGenMS: TRadioButton;
    radGenLASM: TRadioButton;
    radGenC: TRadioButton;
    radGenPascal: TRadioButton;
    radGenForth: TRadioButton;
    radGenJava: TRadioButton;
    btnHelp: TButton;
    radGenNBC: TRadioButton;
    radGenNXTMelody: TRadioButton;
    radGenNXC: TRadioButton;
    edtNoteTime: TSpinEdit;
    edtWaitTime: TSpinEdit;
    procedure Shape01MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure radWholeClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnPlayClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCopyClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure barTransposeChange(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    function GetNoteTime: Integer;
    function GetWaitTime: Integer;
    function GetConvType: TMIDIConversionType;
  private
    { Private declarations }
    function GetFrequency(Sender : TObject) : Integer;
    function GetIndex(Sender : TObject) : Integer;
    function GetMIDITone(index : Integer) : Integer;
    procedure FillTemp(forsave: boolean);
    property WaitTime : Integer read GetWaitTime;
    property NoteTime : Integer read GetNoteTime;
    property ConversionType : TMIDIConversionType read GetConvType;
  public
    { Public declarations }
  end;

var
  PianoForm: TPianoForm;

implementation

{$R *.DFM}

uses
  SysUtils, SearchRCX, brick_common, MainUnit;

const
  NOTE_TIME = 10;
  WAIT_TIME = 12;
  MAX_NOTE  = 1000;
  Frequencies : array[0..95] of Integer = (
// A     A#    B     C     C#    D     D#     E      F      F#     G      G#
                                                     44,    46,    49,    52,
   55,   58,   61,   65,   69,   73,   78,    82,    87,    92,    98,   104,
  110,  117,  123,  131,  139,  147,  156,   165,   175,   185,   196,   208,
  220,  233,  247,  262,  277,  294,  311,   330,   349,   370,   392,   415,
  440,  466,  494,  523,  554,  587,  622,   659,   698,   740,   784,   831,
  880,  932,  988, 1047, 1109, 1175, 1245,  1319,  1397,  1480,  1568,  1661,
 1760, 1865, 1976, 2093, 2217, 2349, 2489,  2637,  2794,  2960,  3136,  3322,
 3520, 3729, 3951, 4186, 4435, 4699, 4978,  5274,  5588,  5920,  6272,  6645,
 7040, 7459, 7902, 8372, 8870, 9397, 9956, 10548
      );

var
  lnote : integer;
  noteIndex : array of Integer;
  notes : array of integer;
  duration : array of integer;
  notenumb : integer;

{Fills the notes in the temporary memo field}
procedure TPianoForm.FillTemp(forsave:boolean);
var
  i, wt, nt : integer;
  CT : TMIDIConversionType;
begin
  CT := ConversionType;
  with TempMemo.Lines do
  begin
    Clear;
    if forsave then Add(GetComment(CT, False));
    if forsave then Add('');
    if ConversionType = mctNQC then
    begin
      Add(Format('#define __NOTETIME   %d',[NoteTime]));
      Add(Format('#define __WAITTIME   %d',[WaitTime]));
      Add('');
    end;
    if forsave then
      Text := Text + GetMusicHeader(CT);

    wt := WaitTime;
    nt := NoteTime;
    if CT = mctNQC then
    begin
      wt := 1;
      nt := 1;
    end;
    for i:=1 to notenumb do begin
      if notes[i] > 0 then
      begin
        Text := Text + GetTone(0, CT, GetMIDITone(noteIndex[i]), duration[i]*nt, True, CT = mctNQC);
        // not all languages require a wait when playing a tone
        if LanguageNeedsWaits(CT) then
          Text := Text + GetWait(CT, duration[i]*wt, True, CT = mctNQC);
      end
      else
        Text := Text + GetWait(CT, duration[i]*wt, True, CT = mctNQC);
    end;
    if forsave then
      Text := Text + GetMusicFooter(CT);
  end;
  if ConversionType = mctPascal then
    TempMemo.Lines.Text := StringReplace(TempMemo.Lines.Text,
      '%NOTE_COUNT%', IntToStr(notenumb), []);
end;

procedure TPianoForm.Shape01MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  freq : Integer;
begin
  freq := GetFrequency(Sender);
  if BrickComm.IsOpen then
    BrickComm.PlayTone(freq, lnote * NoteTime);
  notenumb := notenumb + 1;
  noteIndex[notenumb] := GetIndex(Sender);
  notes[notenumb] := freq;
  duration[notenumb] := lnote;
end;

procedure TPianoForm.radWholeClick(Sender: TObject);
begin
  lnote := TRadioButton(Sender).Tag;
end;

procedure TPianoForm.btnClearClick(Sender: TObject);
begin
  notenumb := 0;
end;

procedure TPianoForm.btnPlayClick(Sender: TObject);
var
  i : integer;
begin
  for i:=1 to notenumb do
  begin
    if notes[i] > 0 then
      BrickComm.PlayTone(notes[i],duration[i] * NoteTime);
    sleep(10*duration[i] * NoteTime);
  end;
end;

procedure TPianoForm.btnCopyClick(Sender: TObject);
begin
  FillTemp(false);
  TempMemo.SelectAll;
  TempMemo.CopyToClipboard;
end;

procedure TPianoForm.btnSaveClick(Sender: TObject);
var
  MS : TMemoryStream;
begin
  if MainForm.dlgSave.Execute then
  begin
    FillTemp(true);
    if ConversionType = mctNXTMelody then
    begin
      MS := TMemoryStream.Create;
      try
        TempMemo.Lines.SaveToStream(MS);
        SaveStreamToMelodyFile(MS, MainForm.dlgSave.FileName);
      finally
        MS.Free;
      end;
    end
    else
      TempMemo.Lines.SaveToFile(MainForm.dlgSave.FileName);
  end;
end;

procedure TPianoForm.FormShow(Sender: TObject);
begin
  notenumb := 0;
  lnote    := 4;
  radQuarter.Checked := true;
  btnPlay.Enabled := BrickComm.IsOpen;
end;

procedure TPianoForm.FormCreate(Sender: TObject);
begin
  SetLength(noteIndex, MAX_NOTE);
  SetLength(notes, MAX_NOTE);
  SetLength(duration, MAX_NOTE);
  edtNoteTime.Value := NOTE_TIME;
  edtWaitTime.Value := WAIT_TIME;
end;

function TPianoForm.GetFrequency(Sender: TObject): Integer;
begin
  if Sender = btnRest then
    Result := 0
  else
    Result := Frequencies[GetIndex(Sender)];
end;

procedure TPianoForm.barTransposeChange(Sender: TObject);
begin
  barTranspose.Hint := IntToStr(barTranspose.Position);
end;

function TPianoForm.GetNoteTime: Integer;
begin
  Result := edtNoteTime.Value;
end;

function TPianoForm.GetWaitTime: Integer;
begin
  Result := edtWaitTime.Value;
end;

function TPianoForm.GetIndex(Sender: TObject): Integer;
const
  NPO = 12;
begin
  if Sender = btnRest then
    Result := 0
  else
    Result := TControl(Sender).Tag+(barTranspose.Position*NPO);
end;

function TPianoForm.GetConvType: TMIDIConversionType;
begin
  if radGenNQC.Checked then
    Result := mctNQC
  else if radGenMS.Checked then
    Result := mctMindScript
  else if radGenLASM.Checked then
    Result := mctLASM
  else if radGenC.Checked then
    Result := mctC
  else if radGenPascal.Checked then
    Result := mctPascal
  else if radGenForth.Checked then
    Result := mctForth
  else if radGenNBC.Checked then
    Result := mctNBC
  else if radGenNXC.Checked then
    Result := mctNXC
  else if radGenNXTMelody.Checked then
    Result := mctNXTMelody
  else
    Result := mctJava;
end;

function TPianoForm.GetMIDITone(index: Integer): Integer;
const
  MIDI_OFFSET = 29;
begin
  // F0 = midi tone 29 (index = 0);
  Result := index + MIDI_OFFSET;
end;

procedure TPianoForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
