unit uNQCConv;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

const
  keywordToken = '<PARAM NAME="Keyword" VALUE="';

procedure TForm1.Button1Click(Sender: TObject);
var
  tmpSL : TStringList;
  htmlSL : TStringList;
  sr : TSearchRec;
  cnt, i, p : integer;
  tmpStr, name, path : String;
begin
  cnt := 1;
  path := ExtractFilePath(ParamStr(0))+'..\nqc\';
  htmlSL := TStringList.Create;
  try
    tmpSL := TStringList.Create;
    try
      tmpSL.Add('unit uNQCHTMLTopics;');
      tmpSL.Add('');
      tmpSL.Add('interface');
      tmpSL.Add('');
      tmpSL.Add('uses');
      tmpSL.Add('  uHTMLHelp;');
      tmpSL.Add('');
      tmpSL.Add('const');
      tmpSL.Add('  uNQCHTMLTopicsSize = %d;');
      tmpSL.Add('  uNQCHTMLTopicsData: array[0..uNQCHTMLTopicsSize-1] of TNameValue = (');
      if FindFirst(path + '*.htm', faAnyFile, sr) = 0 then
      begin
        repeat
          htmlSL.LoadFromFile(path + sr.Name);
          for i := 0 to htmlSL.Count - 1 do
          begin
            tmpStr := htmlSL[i];
            p := Pos(keywordToken, tmpStr);
            if p > 0 then
            begin
              // found a keyword
              name := Copy(tmpStr, p+Length(keywordToken), MaxInt);
              p := Pos('">', name);
              if p > 0 then
                System.Delete(name, p, MaxInt);
              // now add this value to our output file and increment cnt
              inc(cnt);
              tmpSL.Add('    (');
              tmpSL.Add('     Name: ''' + name + ''';');
              tmpSL.Add('     Value: ''nqc/' + ExtractFileName(sr.Name) + '''');
              tmpSL.Add('    ),');
            end;
          end;
        until FindNext(sr) <> 0;
        FindClose(sr);
      end;
      // process HTML files from help_src\NQC
      tmpSL.Add('    (');
      tmpSL.Add('     Name: ''$##@$@#$@#$@$'';');
      tmpSL.Add('     Value: ''$##@$@#$@#$@$''');
      tmpSL.Add('    )');
      tmpSL.Add('  );');
      tmpSL.Add('');
      tmpSL.Add('implementation');
      tmpSL.Add('');
      tmpSL.Add('end.');
      tmpSL[8] := Format(tmpSL[8], [cnt]);
      tmpSL.SaveToFile('uNQCHTMLTopics.pas');
    finally
      tmpSL.Free;
    end;
  finally
    htmlSL.Free;
  end;
end;

end.
