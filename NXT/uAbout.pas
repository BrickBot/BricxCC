unit uAbout;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TfrmAboutRXE = class(TForm)
    Panel1: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    Copyright: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAboutRXE: TfrmAboutRXE;

implementation

{$R *.dfm}

procedure TfrmAboutRXE.FormCreate(Sender: TObject);
begin
  ProductName.Caption := Application.Title;
  ProgramIcon.Picture.Assign(Application.Icon);
end;

end.
 
