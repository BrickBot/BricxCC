unit uExpTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Parser10, uNXTClasses;

type
  TfrmExpTester = class(TForm)
    edtExp: TEdit;
    edtResult: TEdit;
    btnCalc: TButton;
    chkUseProg: TCheckBox;
    mmoMessages: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure btnCalcClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fCalc : TExpParser;
    fRXEProgram : TRXEProgram;
    function GetCalc: TExpParser;
  public
    { Public declarations }
    property Calc : TExpParser read GetCalc;
  end;

var
  frmExpTester: TfrmExpTester;

implementation

{$R *.dfm}

procedure TfrmExpTester.FormCreate(Sender: TObject);
begin
  fRXEProgram := TRXEProgram.Create;
  fCalc := TExpParser.Create(Self);
  fCalc.CaseSensitive := True;
end;

procedure TfrmExpTester.btnCalcClick(Sender: TObject);
var
  i : integer;
  t1 : Cardinal;
  Val : Extended;
  C : TExpParser;
begin
  C := Calc;
  t1 := GetTickCount;
  for i:= 1 to 1{000} do
  begin
    C.Expression := edtExp.Text;
    Val := C.Value;
  end;
  edtResult.Text := FloatToStr(Val);
  mmoMessages.Lines.Add('Elapsed time = ' + IntToStr(GetTickCount - t1));
end;

procedure TfrmExpTester.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fRXEProgram);
end;

function TfrmExpTester.GetCalc: TExpParser;
begin
  if chkUseProg.Checked then
    Result := fRXEProgram.Calc
  else
    Result := fCalc;
end;

end.
