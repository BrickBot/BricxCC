unit uEEAlignConfig;

interface

uses
  Classes, Controls, StdCtrls, Forms, uSpin;

type
  TfrmAlignOptions = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    gbxTokens: TGroupBox;
    gbxOptions: TGroupBox;
    lblWhitespace: TLabel;
    mmoTokens: TMemo;
    edtWhitespace: TSpinEdit;
  end;

implementation

{$R *.dfm}

end.
