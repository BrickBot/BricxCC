unit uRGFPreview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls;

type
  TBytes = array of Byte;
  TfrmRGFPreview = class(TForm)
    btnOpen: TButton;
    dlgOpen: TOpenDialog;
    btnImport: TButton;
    procedure btnOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
  private
    { Private declarations }
    procedure DrawImage;
    procedure PreviewRGF(filename : string);
    function GetPixelColor(b: byte; bit: integer): TColor;
  protected
    procedure WMDROPFILES(var Message: TWMDROPFILES); message WM_DROPFILES;
  public
    { Public declarations }
    imgScreen: TImage;
    fBytes : TBytes;
    fBits : TBits;
    fScreenWidth : integer;
    fScreenHeight : integer;
  end;

var
  frmRGFPreview: TfrmRGFPreview;

implementation

{$R *.dfm}

uses
  ShellApi, uImageImport;

procedure DLcdDrawBitmap(X0, Y0, scr_width, scr_height : integer; bytes : TBytes;
  bits : TBits);
var
  b : byte;
  i,
  rgf_width, rgf_height,
  row_pixel, col_pixel, num_col_pixel,
  row_byte, col_byte, num_col_byte : integer;
const
  SkipHeader = 2;
begin
  if Length(bytes) > 0 then
  begin
    rgf_width  := bytes[0]; // RGF width
    rgf_height := bytes[1]; // RGF height
    num_col_pixel := X0 + rgf_width;
    if (rgf_width >= 0) and (rgf_height >= 0) then
    begin
      row_pixel := Y0;
      num_col_byte := ((rgf_width + 7) shr 3 shl 3) div 8;
      for row_byte := 0 to rgf_height - 1 do
      begin
        col_pixel := X0;
        for col_byte := 0 to (num_col_byte - 1) do
        begin
          b := bytes[SkipHeader + (row_byte * num_col_byte) + col_byte];
          for i := 0 to 7 do
          begin
            if ((b and $01) <> 0) then
            begin
              if (col_pixel >= 0) and (col_pixel < scr_width) and
                 (row_pixel >= 0) and (row_pixel < scr_height) then
              begin
                bits[col_pixel + row_pixel * rgf_width] := true;
              end;
            end;
            b := Byte(b shr 1);
            Inc(col_pixel);
            if col_pixel >= num_col_pixel then break;
          end;
        end;
        Inc(row_pixel);
      end;
    end;
  end;
end;

procedure DrawScreenToWriteableBitmap(bits : TBits; bmp : TBitmap; colored : boolean);
var
  i, num : integer;
  color : TColor;
begin
  if colored then
    num := $DDDDDD // light grey
  else
    num := $FFFFFF; // black;
  for i := 0 to bmp.Width*bmp.Height - 1 do
  begin
    if bits[i] then
      color := $000000 // white
    else
      color := num; // white or light grey
    bmp.Canvas.Pixels[i mod bmp.Width, i div bmp.Width] := color;
  end;
end;

procedure TfrmRGFPreview.DrawImage;
var
  bmp : TBitmap;
  w, h : integer;
begin
  if Assigned(imgScreen) then
    FreeAndNil(imgScreen);
  imgScreen := TImage.Create(Self);
  with imgScreen do
  begin
    Name := 'imgScreen';
    Parent := Self;
    Left := 16;
    Top := 16;
    Width := 178;
    Height := 128;
  end;
  fBits := TBits.Create;
  try
    w := fBytes[0];
    h := fBytes[1];
    fBits.Size := w*h;

    bmp := TBitmap.Create;
    try
      bmp.Width  := w;
      bmp.Height := h; 

      DLcdDrawBitmap(0, 0, fScreenWidth, fScreenHeight, fBytes, fBits);
      DrawScreenToWriteableBitmap(fBits, bmp, false);
      imgScreen.Canvas.Draw(0, 0, bmp);
    finally
      bmp.Free;
    end;
  finally
    fBits.Free;
  end;
end;

function TfrmRGFPreview.GetPixelColor(b: byte; bit: integer): TColor;
var
  val : byte;
begin
  Result := cl3DLight;
  val := 1 shl bit;
  if (b and val) = val then
    Result := clBlack;
end;

procedure TfrmRGFPreview.btnOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    PreviewRGF(dlgOpen.FileName);
  end;
end;

procedure TfrmRGFPreview.FormCreate(Sender: TObject);
begin
  fScreenWidth  := 178;
  fScreenHeight := 128;
  {Let Windows know we accept dropped files}
  DragAcceptFiles(Handle,true);
end;

procedure TfrmRGFPreview.FormDestroy(Sender: TObject);
begin
  if Assigned(imgScreen) then
    FreeAndNil(imgScreen);
end;

procedure TfrmRGFPreview.WMDROPFILES(var Message: TWMDROPFILES);
var
  buffer:array[0..255] of char;
  cnt, i : Integer;
  f : TfrmRGFPreview;
begin
  cnt := DragQueryFile(Message.Drop, $FFFFFFFF, @buffer, sizeof(buffer));
  for i := 0 to cnt - 1 do
  begin
    DragQueryFile(Message.Drop,i,@buffer,sizeof(buffer));
    if i < cnt - 1 then
      f := TfrmRGFPreview.Create(Application)
    else
      f := Self;
    f.PreviewRGF(buffer);
    if not f.Showing then f.Show;
  end;
  DragFinish(Message.Drop);
end;

procedure TfrmRGFPreview.PreviewRGF(filename: string);
var
  ms : TMemoryStream;
begin
  ms := TMemoryStream.Create;
  try
    ms.LoadFromFile(filename);
    SetLength(fBytes, Integer(ms.Size));
    ms.Position := 0;
    ms.Read(fBytes[0], Length(fBytes));
  finally
    ms.free;
  end;
  DrawImage;
end;

procedure TfrmRGFPreview.btnImportClick(Sender: TObject);
var
  F : TfrmImageImport;
begin
  F := TfrmImageImport.Create(Application);
  F.Show;
end;

end.

