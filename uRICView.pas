unit uRICView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmRICView = class(TForm)
    grpPreview: TGroupBox;
    grpAsText: TGroupBox;
    mmoText: TMemo;
    pnlImage: TPanel;
    imgRIC: TImage;
    pnlBottom: TPanel;
    btnCompile: TButton;
    dlgSave: TSaveDialog;
    procedure btnCompileClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRICView: TfrmRICView;

implementation

{$R *.dfm}

uses
  uRICComp;

procedure TfrmRICView.btnCompileClick(Sender: TObject);
var
  RC : TRICComp;
begin
  if dlgSave.Execute then
  begin
    RC := TRICComp.Create;
    try
      RC.AsText := mmoText.Lines.Text;
      RC.SaveToFile(dlgSave.FileName);
    finally
      RC.Free;
    end;
  end;
end;

end.
