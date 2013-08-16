unit uLiveSensors;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Menus, ImgList, ComCtrls;

type
  TfrmLiveSensors = class(TForm)
    pagDevices: TPageControl;
    shtLayer1: TTabSheet;
    shtLayer2: TTabSheet;
    shtLayer3: TTabSheet;
    shtLayer4: TTabSheet;
    ImageList1: TImageList;
    popOutputs: TPopupMenu;
    popInputs: TPopupMenu;
    LargeMotor1: TMenuItem;
    MediumMotor1: TMenuItem;
    Sensor11: TMenuItem;
    Sensor21: TMenuItem;
    Sensor31: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure btnOutputClick(Sender: TObject);
    procedure btnInputClick(Sender: TObject);
    procedure btnInputDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnOutputDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    lbl1A: TLabel;
    edt1A: TEdit;
    lbl1B: TLabel;
    edt1B: TEdit;
    lbl1C: TLabel;
    edt1C: TEdit;
    lbl1D: TLabel;
    edt1D: TEdit;
    btn1A: TSpeedButton;
    btn1B: TSpeedButton;
    btn1C: TSpeedButton;
    btn1D: TSpeedButton;
    btn14: TSpeedButton;
    btn13: TSpeedButton;
    btn12: TSpeedButton;
    btn11: TSpeedButton;
    lbl11: TLabel;
    edt11: TEdit;
    lbl12: TLabel;
    edt12: TEdit;
    lbl13: TLabel;
    edt13: TEdit;
    lbl14: TLabel;
    edt14: TEdit;
    procedure CreateSheetComponents;
  public
    { Public declarations }
  end;

var
  frmLiveSensors: TfrmLiveSensors;

implementation

{$R *.dfm}

procedure TfrmLiveSensors.CreateSheetComponents;
begin
  btn1A := TSpeedButton.Create(Self);
  btn1B := TSpeedButton.Create(Self);
  btn1C := TSpeedButton.Create(Self);
  btn1D := TSpeedButton.Create(Self);

  btn11 := TSpeedButton.Create(Self);
  btn12 := TSpeedButton.Create(Self);
  btn13 := TSpeedButton.Create(Self);
  btn14 := TSpeedButton.Create(Self);

  lbl1A := TLabel.Create(Self);
  lbl1B := TLabel.Create(Self);
  lbl1C := TLabel.Create(Self);
  lbl1D := TLabel.Create(Self);

  lbl11 := TLabel.Create(Self);
  lbl12 := TLabel.Create(Self);
  lbl13 := TLabel.Create(Self);
  lbl14 := TLabel.Create(Self);

  edt1A := TEdit.Create(Self);
  edt1B := TEdit.Create(Self);
  edt1C := TEdit.Create(Self);
  edt1D := TEdit.Create(Self);

  edt11 := TEdit.Create(Self);
  edt12 := TEdit.Create(Self);
  edt13 := TEdit.Create(Self);
  edt14 := TEdit.Create(Self);

  with btn1A do
  begin
    Name := 'btn1A';
    Parent := shtLayer1;
    Left := 8;
    Top := 28;
    Width := 68;
    Height := 68;
    Flat := True;
    PopupMenu := popOutputs;
    OnClick := btnOutputClick;
    OnMouseDown := btnOutputDown;
  end;
  with btn1B do
  begin
    Name := 'btn1B';
    Parent := shtLayer1;
    Left := 82;
    Top := 28;
    Width := 68;
    Height := 68;
    Flat := True;
    PopupMenu := popOutputs;
    OnMouseDown := btnOutputDown;
  end;
  with btn1C do
  begin
    Name := 'btn1C';
    Parent := shtLayer1;
    Left := 157;
    Top := 28;
    Width := 68;
    Height := 68;
    Flat := True;
    PopupMenu := popOutputs;
    OnMouseDown := btnOutputDown;
  end;
  with btn1D do
  begin
    Name := 'btn1D';
    Parent := shtLayer1;
    Left := 232;
    Top := 28;
    Width := 68;
    Height := 68;
    Flat := True;
    PopupMenu := popOutputs;
    OnMouseDown := btnOutputDown;
  end;
  with btn11 do
  begin
    Name := 'btn11';
    Parent := shtLayer1;
    Left := 8;
    Top := 124;
    Width := 68;
    Height := 68;
    Flat := True;
    PopupMenu := popInputs;
    OnMouseDown := btnInputDown;
  end;
  with btn12 do
  begin
    Name := 'btn12';
    Parent := shtLayer1;
    Left := 82;
    Top := 124;
    Width := 68;
    Height := 68;
    Flat := True;
    PopupMenu := popInputs;
    OnMouseDown := btnInputDown;
  end;
  with btn13 do
  begin
    Name := 'btn13';
    Parent := shtLayer1;
    Left := 157;
    Top := 124;
    Width := 68;
    Height := 68;
    Flat := True;
    PopupMenu := popInputs;
    OnMouseDown := btnInputDown;
  end;
  with btn14 do
  begin
    Name := 'btn14';
    Parent := shtLayer1;
    Left := 232;
    Top := 124;
    Width := 68;
    Height := 68;
    Flat := True;
    PopupMenu := popInputs;
    OnMouseDown := btnInputDown;
  end;

  // label components
  with lbl1A do
  begin
    Name := 'lbl1A';
    Parent := shtLayer1;
    Left := 8;
    Top := 7;
    Width := 11;
    Height := 16;
    Caption := 'A';
    ParentFont := False;
  end;
  with lbl1B do
  begin
    Name := 'lbl1B';
    Parent := shtLayer1;
    Left := 82;
    Top := 7;
    Width := 11;
    Height := 16;
    Caption := 'B';
    ParentFont := False;
  end;
  with lbl1C do
  begin
    Name := 'lbl1C';
    Parent := shtLayer1;
    Left := 157;
    Top := 7;
    Width := 11;
    Height := 16;
    Caption := 'C';
    ParentFont := False;
  end;
  with lbl1D do
  begin
    Name := 'lbl1D';
    Parent := shtLayer1;
    Left := 232;
    Top := 7;
    Width := 12;
    Height := 16;
    Caption := 'D';
    ParentFont := False;
  end;
  with lbl11 do
  begin
    Name := 'lbl11';
    Parent := shtLayer1;
    Left := 8;
    Top := 103;
    Width := 9;
    Height := 16;
    Caption := '1';
    ParentFont := False;
  end;
  with lbl12 do
  begin
    Name := 'lbl12';
    Parent := shtLayer1;
    Left := 82;
    Top := 103;
    Width := 9;
    Height := 16;
    Caption := '2';
    ParentFont := False;
  end;
  with lbl13 do
  begin
    Name := 'lbl13';
    Parent := shtLayer1;
    Left := 157;
    Top := 103;
    Width := 9;
    Height := 16;
    Caption := '3';
    ParentFont := False;
  end;
  with lbl14 do
  begin
    Name := 'lbl14';
    Parent := shtLayer1;
    Left := 232;
    Top := 103;
    Width := 9;
    Height := 16;
    Caption := '4';
    ParentFont := False;
  end;
  // edit components
  with edt1A do
  begin
    Name := 'edt1A';
    Parent := shtLayer1;
    Left := 26;
    Top := 5;
    Width := 49;
    Height := 21;
    ReadOnly := True;
    Text := '';
    TabOrder := 0;
  end;
  with edt1B do
  begin
    Name := 'edt1B';
    Parent := shtLayer1;
    Left := 100;
    Top := 5;
    Width := 49;
    Height := 21;
    ReadOnly := True;
    Text := '';
    TabOrder := 1;
  end;
  with edt1C do
  begin
    Name := 'edt1C';
    Parent := shtLayer1;
    Left := 174;
    Top := 5;
    Width := 49;
    Height := 21;
    ReadOnly := True;
    Text := '';
    TabOrder := 2;
  end;
  with edt1D do
  begin
    Name := 'edt1D';
    Parent := shtLayer1;
    Left := 250;
    Top := 5;
    Width := 49;
    Height := 21;
    ReadOnly := True;
    Text := '';
    TabOrder := 3;
  end;
  with edt11 do
  begin
    Name := 'edt11';
    Parent := shtLayer1;
    Left := 26;
    Top := 101;
    Width := 49;
    Height := 21;
    ReadOnly := True;
    Text := '';
    TabOrder := 4;
  end;
  with edt12 do
  begin
    Name := 'edt12';
    Parent := shtLayer1;
    Left := 100;
    Top := 101;
    Width := 49;
    Height := 21;
    ReadOnly := True;
    Text := '';
    TabOrder := 5;
  end;
  with edt13 do
  begin
    Name := 'edt13';
    Parent := shtLayer1;
    Left := 175;
    Top := 101;
    Width := 49;
    Height := 21;
    ReadOnly := True;
    Text := '';
    TabOrder := 6;
  end;
  with edt14 do
  begin
    Name := 'edt14';
    Parent := shtLayer1;
    Left := 250;
    Top := 101;
    Width := 49;
    Height := 21;
    ReadOnly := True;
    Text := '';
    TabOrder := 7;
  end;
end;

procedure TfrmLiveSensors.FormCreate(Sender: TObject);
begin
  CreateSheetComponents;
end;

procedure TfrmLiveSensors.btnOutputClick(Sender: TObject);
var
  sb : TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  popOutputs.Popup(Left + sb.Left+32, Top + sb.Top+32);
end;

procedure TfrmLiveSensors.btnInputClick(Sender: TObject);
var
  sb : TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  popInputs.Popup(Left + sb.Left+32, Top + sb.Top+32);
end;

procedure TfrmLiveSensors.btnInputDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sb : TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  popInputs.Popup(Left + sb.Left+32, Top + sb.Top+32);
end;

procedure TfrmLiveSensors.btnOutputDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  sb : TSpeedButton;
begin
  sb := TSpeedButton(Sender);
  popOutputs.Popup(Left + sb.Left+32, Top + sb.Top+32);
end;

end.
