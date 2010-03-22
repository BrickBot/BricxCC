unit uRICFont;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TfrmRICFont = class(TForm)
    btnGenerate: TButton;
    dlgFont: TFontDialog;
    boxScroller: TScrollBox;
    imgFont: TImage;
    mmoRICScript: TMemo;
    btnSave: TButton;
    dlgSave: TSaveDialog;
    procedure btnGenerateClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
    chWidths : array of byte;
    chHeights : array of byte;
    bFontIsTrueType : boolean;
    charWidths: array[#32..#126] of integer;
    ABCWidths: array[#32..#126] of TABC;
  public
    { Public declarations }
    procedure SaveAsRIC(const name : string);
    function CharWidth(ch : char) : integer;
  end;

var
  frmRICFont: TfrmRICFont;

implementation

{$R *.dfm}

uses
  uRICComp;

const
  FontCharacters = ' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~';

procedure TfrmRICFont.btnGenerateClick(Sender: TObject);
var
  te : TSize;
  i, y, x : integer;
  maxX, maxY, lastVal, fcLen, sumX : integer;
  line : string;
  Row : PByteArray;
  ch : Char;
begin
  if dlgFont.Execute then
  begin
    mmoRICScript.Clear;
    mmoRICScript.Lines.Add('// ' + dlgFont.Font.Name + ' ' + IntToStr(dlgFont.Font.Size) + 'pt');
    fcLen := Length(FontCharacters);
    SetLength(chWidths, fcLen);
    SetLength(chHeights, fcLen);
    maxX := 0;
    maxY := 0;
    with imgFont.Picture.Bitmap do
    begin
      sumX := 0;
      Canvas.Font := dlgFont.Font;
      bFontIsTrueType := True;
      //Get Character widths for every printable character of the given font
      if not GetCharABCWidths(Canvas.Handle, 32, 126, ABCWidths[#32]) then
      begin
        bFontIsTrueType := False;
        if not GetCharWidth32(Canvas.Handle, 32, 126, charWidths[#32]) then
          Exit;
      end;
      for i := 1 to fcLen do
      begin
        ch := FontCharacters[i];
        te := Canvas.TextExtent(ch);
        if te.cx > maxX then
          maxX := te.cx;
        if te.cy > maxY then
          maxY := te.cy;
        chWidths[i-1] := te.cx;
        chHeights[i-1] := te.cy;
        inc(sumX, te.cx);
      end;
//      Width := sumX;
//      Height := maxY;
      te := Canvas.TextExtent(FontCharacters);
      Width  := te.cx;
      Height := te.cy;
      PixelFormat := pf1bit;
{
      x := 0;
      for i := 1 to fcLen do
      begin
        Canvas.TextOut(x, 0, FontCharacters[i]);
        x := x + chWidths[i-1];
      end;
}
      Canvas.TextOut(0, 0, FontCharacters);
      // output sprite
      mmoRICScript.Lines.Add('sprite(1, ');
      //output N lines of hex digit pairs
      lastVal := 1 + (Width-1) div 8;
      for y := 0 to Height - 1 do
      begin
        line := '  0x';
        Row := PByteArray(ScanLine[y]);
        for x := 0 to lastVal - 1 do
        begin
          line := line + IntToHex(not Row[x], 2);
        end;
        if y < Height - 1 then
          line := line + ',';
        mmoRICScript.Lines.Add(line);
      end;
      mmoRICScript.Lines.Add(');');
    end;
    // output varmaps
    lastVal := 0;
    line := '  ';
    mmoRICScript.Lines.Add('varmap(2, ');
    for i := 0 to fcLen - 1 do
    begin
      ch := FontCharacters[i+1];
      line := line + Format('f(%d)=%d', [Ord(ch), lastVal]);
      inc(lastVal, CharWidth(ch));
//      inc(lastVal, chWidths[i]);
      if i <> fcLen - 1 then
        line := line + ',';
      if (i <> 0) and (i mod 6 = 0) then
      begin
        // output the line and reset it
        mmoRICScript.Lines.Add(line);
        line := '  ';
      end;
    end;
    if line <> '  ' then
      mmoRICScript.Lines.Add(line+');');
    mmoRICScript.Lines.Add('varmap(3, f(0)=0, f(255)=0);');
    lastVal := -1;
    line := '  ';
    mmoRICScript.Lines.Add('varmap(4, ');
    for i := 0 to fcLen - 1 do
    begin
      ch := FontCharacters[i+1];
      line := line + Format('f(%d)=%d', [Ord(ch), CharWidth(ch)]);
      if i <> fcLen - 1 then
        line := line + ',';
      if (i <> 0) and (i mod 6 = 0) then
      begin
        // output the line and reset it
        mmoRICScript.Lines.Add(line);
        line := '  ';
      end;
    end;
    if line <> '  ' then
      mmoRICScript.Lines.Add(line+');');
    mmoRICScript.Lines.Add(Format('varmap(5, f(0)=%d, f(255)=%d);', [maxY, maxY]));
    mmoRICScript.Lines.Add(Format('fontout(%d, %d);', [maxX, maxY]));
  end;
end;

procedure TfrmRICFont.btnSaveClick(Sender: TObject);
begin
  if dlgSave.Execute then
  begin
    if dlgSave.FilterIndex = 1 then
    begin
      // RIC
      SaveAsRIC(dlgSave.FileName);
    end
    else
    begin
      // RICScript
      mmoRICScript.Lines.SaveToFile(ChangeFileExt(dlgSave.FileName, '.rs'));
    end;
  end;
end;

function TfrmRICFont.CharWidth(ch: char): integer;
var
  abc : TABC;
begin
  Result := charWidths[ch];
  if bFontIsTrueType then
  begin
    abc := aBCWidths[ch];
    Result := abc.abcA + abc.abcB + abc.abcC;
  end;
end;

procedure TfrmRICFont.SaveAsRIC(const name: string);
var
  sIn, sOut : TMemoryStream;
  RIC : TRICComp;
begin
  sIn := TMemoryStream.Create;
  try
    mmoRICScript.Lines.SaveToStream(sIn);
    sIn.Position := 0;
    // RIC compiler
    RIC := TRICComp.Create;
    try
      RIC.CurrentFile := name;
      RIC.EnhancedFirmware := True;
      RIC.FirmwareVersion  := 128;
      RIC.MaxErrors := 0;
      RIC.Parse(sIn);
      if RIC.CompilerMessages.Count = 0 then
      begin
        sOut := TMemoryStream.Create;
        try
          RIC.SaveToStream(sOut);
          sOut.SaveToFile(ChangeFileExt(name, '.ric'));
        finally
          sOut.Free;
        end;
      end;
    finally
      RIC.Free;
    end;
  finally
    sIn.Free;
  end;
end;

end.
