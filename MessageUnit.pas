unit MessageUnit;

interface

uses
  Classes, Controls, Forms, ComCtrls, StdCtrls, ExtCtrls, uSpin;

type
  TMessageForm = class(TForm)
    btnHelp: TButton;
    grpSingleDigit: TGroupBox;
    Button2: TButton;
    Button0: TButton;
    Button1: TButton;
    Button3: TButton;
    Button6: TButton;
    Button5: TButton;
    Button4: TButton;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    grpMultiDigit: TGroupBox;
    SendButton: TButton;
    GroupBox1: TGroupBox;
    cboMailbox: TComboBox;
    lblMailbox: TLabel;
    mmoMessage: TMemo;
    lblMemo: TLabel;
    btnSendString: TButton;
    chkBoolValue: TCheckBox;
    btnSendBool: TButton;
    btnSendNum: TButton;
    chkResponse: TCheckBox;
    edtMessageNum: TSpinEdit;
    edtNum: TSpinEdit;
    procedure Button0Click(Sender: TObject);
    procedure SendButtonClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSendNXTClick(Sender: TObject);
  private
    { Private declarations }
    function GetInBox : byte;
    function GetMessage(Sender: TObject) : string;
  public
    { Public declarations }
  end;

var
  MessageForm: TMessageForm;

implementation

uses
  SysUtils, Preferences, brick_common, uSpirit, uCommonUtils;

{$R *.DFM}

procedure TMessageForm.Button0Click(Sender: TObject);
begin
  if LocalBrickType <> SU_NXT then
    BrickComm.SendMessage(TButton(Sender).Tag)
  else
    BrickComm.MessageWrite(GetInBox, GetMessage(Sender));
end;

procedure TMessageForm.SendButtonClick(Sender: TObject);
begin
  if LocalBrickType <> SU_NXT then
    BrickComm.SendMessage(edtMessageNum.Value)
  else
    BrickComm.MessageWrite(GetInBox, GetMessage(Sender));
end;

procedure TMessageForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TMessageForm.FormShow(Sender: TObject);
begin
  if LocalBrickType = SU_NXT then
  begin
    edtMessageNum.MaxLength := 0;
    edtMessageNum.MaxValue  := 0;
    Width := 304;
  end
  else
  begin
    edtMessageNum.MaxLength := 3;
    edtMessageNum.MaxValue  := 255;
    Width := 152;
  end;
end;

function TMessageForm.GetInBox: byte;
begin
  Result := cboMailbox.ItemIndex;
  if chkResponse.Checked then
    Inc(Result, 10);
end;

function TMessageForm.GetMessage(Sender: TObject): string;
var
  tag : integer;
begin
  tag := TButton(Sender).Tag;
  case tag of
    0..9 : Result := IntToStr(tag);
    100 : Result := IntToStr(edtMessageNum.Value);
    200 : Result := mmoMessage.Lines.Text;
    300 : begin
      SetLength(Result, 1);
      if chkBoolValue.Checked then
        Result := #1
      else
        Result := #0;
    end;
    400 : begin
      SetLength(Result, 4);
      tag := edtNum.Value;
      Result := Chr(Lo(Word(tag))) +
                Chr(Hi(Word(tag))) +
                Chr(Lo(HiWord(tag))) +
                Chr(Hi(HiWord(tag)));
    end;
  else
    Result := 'bad tag';
  end;
end;

procedure TMessageForm.btnSendNXTClick(Sender: TObject);
begin
  BrickComm.MessageWrite(GetInBox, GetMessage(Sender));
end;

end.
