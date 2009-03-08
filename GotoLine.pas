unit GotoLine;

interface

uses
  Classes, Controls, Forms, StdCtrls, ExtCtrls, ComCtrls, uSpin;

type
  TGotoForm = class(TForm)
    pnlGoto: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    GotoLineField: TSpinEdit;
    procedure FormShow(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure GotoLineFieldKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GotoLineFieldExit(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    function  GetMaxLine: Integer;
    procedure SetMaxLine(const Value: Integer);
    function  GetTheLine: Integer;
    procedure SetTheLine(const Value: Integer);
  public
    { Public declarations }
    property TheLine : Integer read GetTheLine write SetTheLine;
    property MaxLine : Integer read GetMaxLine write SetMaxLine;
  end;

implementation

{$R *.DFM}

uses
  Windows, SysUtils, Dialogs, MainUnit, Editor, uLocalizedStrings;

procedure TGotoForm.FormShow(Sender: TObject);
begin
  GotoLineField.SetFocus;
  GotoLineField.SelectAll;
end;

procedure TGotoForm.btnOKClick(Sender: TObject);
var
  X : Integer;
begin
  X := GotoLineField.Value;
  if (X < 1) or (X > MaxLine) then
  begin
    ShowMessage(Format(sGotoError, [MaxLine]));
    GotoLineField.SetFocus;
    GotoLineField.SelectAll;
  end
  else
    ModalResult := mrOK;
end;

function TGotoForm.GetMaxLine: Integer;
begin
  Result := GotoLineField.MaxValue;
end;

procedure TGotoForm.SetMaxLine(const Value: Integer);
begin
  GotoLineField.MaxValue := Value;
  GotoLineField.MaxLength := Length(IntToStr(Value));
end;

function TGotoForm.GetTheLine: Integer;
begin
  Result := GotoLineField.Value;
end;

procedure TGotoForm.GotoLineFieldKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    ModalResult := mrOK
  else if Key = VK_ESCAPE then
    ModalResult := mrCancel;
end;

procedure TGotoForm.SetTheLine(const Value: Integer);
begin
  GotoLineField.Value := Value;
end;

procedure TGotoForm.GotoLineFieldExit(Sender: TObject);
var
  X : Integer;
begin
  X := StrToIntDef(GotoLineField.Text, 0);
  if X > GotoLineField.MaxValue then
    GotoLineField.Value := GotoLineField.MaxValue
  else if X < GotoLineField.MinValue then
    GotoLineField.Value := GotoLineField.MinValue;
end;

procedure TGotoForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
