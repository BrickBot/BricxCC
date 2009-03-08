unit DatalogUnit;

interface

uses
  Classes, Controls, Forms, Dialogs, StdCtrls;

type
  TDatalogForm = class(TForm)
    DatalogMemo: TMemo;
    UploadBtn: TButton;
    ClearBtn: TButton;
    SizeBox: TComboBox;
    Label1: TLabel;
    SaveBtn: TButton;
    dlgSave: TSaveDialog;
    btnAnalyze: TButton;
    btnAnalyzeXY: TButton;
    btnLoad: TButton;
    dlgOpen: TOpenDialog;
    chkRelativeTime: TCheckBox;
    btnHelp: TButton;
    procedure UploadBtnClick(Sender: TObject);
    procedure ClearBtnClick(Sender: TObject);
    procedure SizeBoxChange(Sender: TObject);
    procedure SaveBtnClick(Sender: TObject);
    procedure btnAnalyzeClick(Sender: TObject);
    procedure btnAnalyzeXYClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    procedure UpdateButtonState;
    procedure LaunchAnalysis(bXY : boolean = false);
  public
    { Public declarations }
  end;

var
  DatalogForm: TDatalogForm;

implementation

{$R *.DFM}

uses
  SysUtils, brick_common, DataAnalysis, Preferences;

procedure TDatalogForm.UploadBtnClick(Sender: TObject);
var
  d : TStrings;
  c : TCursor;
begin
  DatalogMemo.Lines.Clear;
  c := Screen.Cursor;
  try
    Screen.Cursor := crHourGlass;
    d := BrickComm.UploadDatalog(True);
    DatalogMemo.Lines.Assign(d);
    SizeBox.Text := IntToStr(d.Count);
    UpdateButtonState;
  finally
    Screen.Cursor := c;
  end;
end;

procedure TDatalogForm.ClearBtnClick(Sender: TObject);
begin
  BrickComm.SetDatalog(0);
  SizeBox.Text := '0';
end;

procedure TDatalogForm.SizeBoxChange(Sender: TObject);
begin
  BrickComm.SetDatalog(StrToIntDef(SizeBox.Text, 0));
end;

procedure TDatalogForm.SaveBtnClick(Sender: TObject);
begin
  if dlgSave.Execute() then
  begin
    DatalogMemo.Lines.SaveToFile(dlgSave.FileName);
  end;
end;

procedure TDatalogForm.btnAnalyzeClick(Sender: TObject);
begin
  LaunchAnalysis;
end;

procedure TDatalogForm.UpdateButtonState;
var
  bEnable : boolean;
begin
  bEnable := DatalogMemo.Lines.Count > 0;
  btnAnalyze.Enabled   := bEnable;
  btnAnalyzeXY.Enabled := bEnable;
end;

procedure TDatalogForm.LaunchAnalysis(bXY: boolean);
var
  F : TfrmDataAnalysis;
begin
  // create and show analysis form here
  F := TfrmDataAnalysis.Create(Application);
  F.DataIsXY     := bXY;
  F.RelativeTime := chkRelativeTime.Checked;
  F.Data         := DatalogMemo.Lines;
  F.Show;
end;

procedure TDatalogForm.btnAnalyzeXYClick(Sender: TObject);
begin
  LaunchAnalysis(True);
end;

procedure TDatalogForm.btnLoadClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    DatalogMemo.Lines.LoadFromFile(dlgOpen.FileName);
    SizeBox.Text := IntToStr(DatalogMemo.Lines.Count);
    UpdateButtonState;
  end;
end;

procedure TDatalogForm.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.
