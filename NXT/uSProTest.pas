unit uSProTest;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uSPCClasses, uNXTClasses;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    fDS : TDataspace;
    fSProProgram : TSProProgram;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  uSProObjUtils;

procedure TForm1.Button1Click(Sender: TObject);
var
  ext : string;
  SL : TStringList;
  FS : TFileStream;
begin
  if OpenDialog1.Execute then
  begin
    ext := UpperCase(ExtractFileExt(OpenDialog1.FileName));
    if ext = '.OBJ' then
    begin
      SL := TStringList.Create;
      try
        SL.LoadFromFile(OpenDialog1.FileName);
        Memo1.Lines.Text := SL.Text;
        FS := TFileStream.Create(ChangeFileExt(OpenDialog1.FileName, '.bin2'), fmCreate);
        try
          SProObjStrToBin(SL.Text, FS);
        finally
          FS.Free;
        end;
      finally
        SL.Free;
      end;
    end
    else if ext = '.BIN' then
    begin
      FS := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
      try
        Memo1.Lines.Text := SProBinToObjStr(FS);
      finally
        FS.Free;
      end;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fDS := TDataspace.Create;
  fSProProgram := TSProProgram.Create(fDS);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fSProProgram);
  FreeAndNil(fDS);
end;

end.
