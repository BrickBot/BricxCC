unit uMIDIConversion;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, uMidi2MS, ComCtrls, uSpin;

type
  TMIDIDestination = (mdClipboard, mdFile);
  TfrmMIDIConversion = class(TForm)
    grpCode: TGroupBox;
    radGenNQC: TRadioButton;
    radGenMS: TRadioButton;
    radGenLASM: TRadioButton;
    radGenC: TRadioButton;
    dlgOpenMIDI: TOpenDialog;
    grpDestination: TGroupBox;
    radToClip: TRadioButton;
    radToFile: TRadioButton;
    radGenPascal: TRadioButton;
    grpParameters: TGroupBox;
    lblGap: TLabel;
    lblTempo: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    radGenForth: TRadioButton;
    radGenJava: TRadioButton;
    barTranspose: TTrackBar;
    lblTranspose: TLabel;
    chkUsePB: TCheckBox;
    lblPBS: TLabel;
    btnHelp: TButton;
    radGenNBC: TRadioButton;
    lblTrack: TLabel;
    radGenNXC: TRadioButton;
    radGenNXTMelody: TRadioButton;
    edtGap: TSpinEdit;
    edtTempo: TSpinEdit;
    edtPBS: TSpinEdit;
    edtTrack: TSpinEdit;
    procedure edtGapKeyPress(Sender: TObject; var Key: Char);
    procedure barTransposeChange(Sender: TObject);
    procedure chkUsePBClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure LanguageClick(Sender: TObject);
  private
    { Private declarations }
    function GetConvType: TMIDIConversionType;
    function GetGap: Integer;
    function GetTempo: Double;
    function GetPBS: Double;
    function GetDestination: TMIDIDestination;
    function GetTranspose: TTranspose;
    function GetUsePitchBend: Boolean;
    function GetTrack: Integer;
    procedure UpdateControls;
  public
    { Public declarations }
    property ConversionType : TMIDIConversionType read GetConvType;
    property Gap : Integer read GetGap;
    property Tempo : Double read GetTempo;
    property PBS : Double read GetPBS;
    property Destination : TMIDIDestination read GetDestination;
    property Transpose : TTranspose read GetTranspose;
    property UsePitchBend : Boolean read GetUsePitchBend;
    property Track : Integer read GetTrack;
    class procedure DoConversion(dlg : TSaveDialog);
  end;

implementation

{$R *.DFM}

uses
  Clipbrd;

{ TfrmMIDIConversion }

class procedure TfrmMIDIConversion.DoConversion(dlg : TSaveDialog);
var
  C : TMIDIFileToRCX;
  res : string;
begin
  with TfrmMIDIConversion.Create(nil) do
  try
    if ShowModal = mrOK then
    begin
      // perform conversion here
      if dlgOpenMIDI.Execute then
      begin
        C := TMIDIFileToRCX.Create;
        try
          C.Track          := Track;
          C.Tempo          := Tempo;
          C.Gap            := Gap;
          C.PBS            := PBS;
          C.ConversionType := ConversionType;
          C.PitchBend      := UsePitchBend;
          C.Transpose      := Transpose;
          if ConversionType = mctNXTMelody then
          begin
            if dlg.Execute then
              C.Convert(dlgOpenMIDI.FileName, dlg.FileName);
          end
          else
          begin
            res := C.Convert(dlgOpenMIDI.FileName);
            if Destination = mdFile then
            begin
              // save to file
              if dlg.Execute then begin
                with TStringList.Create do
                try
                  Text := res;
                  SaveToFile(dlg.FileName);
                finally
                  Free;
                end;
              end;
            end
            else
            begin
              // copy to clipboard
              Clipboard.AsText := res;
            end;
          end;
        finally
          C.Free;
        end;
      end;
    end;
  finally
    Free;
  end;
end;

function TfrmMIDIConversion.GetConvType: TMIDIConversionType;
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

function TfrmMIDIConversion.GetDestination: TMIDIDestination;
begin
  if radToClip.Checked then
    Result := mdClipboard
  else
    Result := mdFile;
end;

function TfrmMIDIConversion.GetGap: Integer;
begin
  Result := edtGap.Value;
end;

function TfrmMIDIConversion.GetPBS: Double;
begin
  Result := edtPBS.Value * 1.0;
end;

function TfrmMIDIConversion.GetTempo: Double;
begin
  Result := edtTempo.Value * 1.0;
end;

procedure TfrmMIDIConversion.edtGapKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #27 then Close;
end;

procedure TfrmMIDIConversion.barTransposeChange(Sender: TObject);
begin
  barTranspose.Hint := IntToStr(barTranspose.Position);
end;

function TfrmMIDIConversion.GetTranspose: TTranspose;
begin
  Result := barTranspose.Position;
end;

function TfrmMIDIConversion.GetUsePitchBend: Boolean;
begin
  Result := chkUsePB.Checked;
end;

procedure TfrmMIDIConversion.chkUsePBClick(Sender: TObject);
begin
  edtPBS.Enabled := chkUsePB.Checked;
end;

procedure TfrmMIDIConversion.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

function TfrmMIDIConversion.GetTrack: Integer;
begin
  Result := edtTrack.Value;
end;

procedure TfrmMIDIConversion.LanguageClick(Sender: TObject);
begin
  UpdateControls;
end;

procedure TfrmMIDIConversion.UpdateControls;
begin
  radToClip.Enabled := not radGenNXTMelody.Checked;
  if radToClip.Checked and not radToClip.Enabled then
    radToFile.Checked := True;  
end;

end.
