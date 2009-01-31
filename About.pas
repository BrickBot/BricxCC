unit About;

interface

uses
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls;

type
  TAboutBox = class(TForm)
    pnlMain: TPanel;
    ProgramIcon: TImage;
    ProductName: TLabel;
    Version: TLabel;
    lblOrigAuth: TLabel;
    Comments: TLabel;
    OKButton: TButton;
    lblAuthor: TLabel;
    lblBuild: TLabel;
    lblMaint: TLabel;
    lblMaintainer: TLabel;
    lblCopyright: TLabel;
    procedure ProgramIconClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure LoadVersionData;
  public
    { Public declarations }
  end;

implementation

uses
  PuzzleUnit, uVersionInfo, uLocalizedStrings;

{$R *.DFM}

procedure TAboutBox.ProgramIconClick(Sender: TObject);
begin
  with TPuzzleForm.Create(nil) do
  try
    ShowModal();
  finally
    Free;
  end;
end;

procedure TAboutBox.FormCreate(Sender: TObject);
begin
  LoadVersionData;
end;

procedure TAboutBox.LoadVersionData;
var
  S, tmpVer : String;
  TFS : TFileStream;
  V : TVersionInfo;
begin
  tmpVer := sVersion + ' ';
  // first get file date
  S := Application.ExeName;
  TFS := TFileStream.Create(S, fmOpenRead or fmShareDenyNone);
  try
    lblBuild.Caption := DateTimeToStr(FileDateToDateTime(FileGetDate(TFS.Handle)));
  finally
    TFS.Free;
  end;

  V := GetVersionInfo(S);
  Version.Caption      := tmpVer + V.ProductVersion;
  Version.Caption      := Version.Caption + ' (' + sBuild + ' ' + V.FileVersion + ')';
  ProductName.Caption  := V.ProductName;
  Comments.Caption     := V.Comments;
  lblCopyright.Caption := V.LegalCopyright;
end;

end.


