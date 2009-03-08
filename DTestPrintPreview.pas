unit DTestPrintPreview;

interface

uses
  Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, ComCtrls, ToolWin, ActnList, ImgList, 
  SynEditPrintPreview, Menus, Printers, uOfficeComp;

type
  TTestPrintPreviewDlg = class(TForm)
    ImageList: TImageList;
    ActionList: TActionList;
    FirstCmd: TAction;
    PrevCmd: TAction;
    NextCmd: TAction;
    LastCmd: TAction;
    ZoomCmd: TAction;
    PrintCmd: TAction;
    CloseCmd: TAction;
    ToolBar1: TToolBar;
    FirstBtn: TToolButton;
    PrevBtn: TToolButton;
    NextBtn: TToolButton;
    LastBtn: TToolButton;
    ToolButton1: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    PrintBtn: TToolButton;
    ToolButton4: TToolButton;
    CloseBtn: TToolButton;
    StatusBar: TStatusBar;
    procedure FirstCmdExecute(Sender: TObject);
    procedure PrevCmdExecute(Sender: TObject);
    procedure NextCmdExecute(Sender: TObject);
    procedure LastCmdExecute(Sender: TObject);
    procedure ZoomCmdExecute(Sender: TObject);
    procedure PrintCmdExecute(Sender: TObject);
    procedure CloseCmdExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    PopupMenu1: TOfficePopupMenu;
    Fitto1: TOfficeMenuItem;
    Pagewidth1: TOfficeMenuItem;
    N1: TOfficeMenuItem;
    N251: TOfficeMenuItem;
    N501: TOfficeMenuItem;
    N1001: TOfficeMenuItem;
    N2001: TOfficeMenuItem;
    N4001: TOfficeMenuItem;
    procedure Fitto1Click(Sender: TObject);
    procedure SynEditPrintPreviewMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure SynEditPrintPreviewPreviewPage(Sender: TObject;
      PageNumber: Integer);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure CreatePopupMenu;
    procedure CreateSynEditComponents;
  public
    { Public declarations }
    SynEditPrintPreview: TSynEditPrintPreview;
  end;

implementation

uses
  SysUtils, uLocalizedStrings;

{$R *.DFM}

procedure TTestPrintPreviewDlg.FormShow(Sender: TObject);
begin
  SynEditPrintPreview.UpdatePreview;
  SynEditPrintPreview.FirstPage;
  if Printer.PrinterIndex >= 0 then
    PrintCmd.Hint := Format(sPrintCmdHint, [Printer.Printers[Printer.PrinterIndex]]);
end;

procedure TTestPrintPreviewDlg.FirstCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.FirstPage;
end;

procedure TTestPrintPreviewDlg.PrevCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.PreviousPage;
end;

procedure TTestPrintPreviewDlg.NextCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.NextPage;
end;

procedure TTestPrintPreviewDlg.LastCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.LastPage;
end;

procedure TTestPrintPreviewDlg.ZoomCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.ScaleMode := pscWholePage;
end;

procedure TTestPrintPreviewDlg.PrintCmdExecute(Sender: TObject);
begin
  SynEditPrintPreview.Print;
end;

procedure TTestPrintPreviewDlg.CloseCmdExecute(Sender: TObject);
begin
  Close;
end;

procedure TTestPrintPreviewDlg.Fitto1Click(Sender: TObject);
begin
  case (Sender as TOfficeMenuItem).Tag of
    -1: SynEditPrintPreview.ScaleMode := pscWholePage;
    -2: SynEditPrintPreview.ScaleMode := pscPageWidth;
  else
    SynEditPrintPreview.ScalePercent := (Sender as TOfficeMenuItem).Tag;
  end;
end;

procedure TTestPrintPreviewDlg.SynEditPrintPreviewMouseDown(
  Sender: TObject; Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
var
  FScale: Integer;
begin
  FScale := SynEditPrintPreview.ScalePercent;
  if Button = mbLeft then begin
    if SynEditPrintPreview.ScaleMode = pscWholePage then
      SynEditPrintPreview.ScalePercent := 100
    else begin
      FScale := FScale * 2;
      if FScale > 400 then
        FScale := 400;
      SynEditPrintPreview.ScalePercent := FScale;
    end;
  end
  else begin
    FScale := FScale div 2;
    if FScale < 25 then
      FScale := 25;
    SynEditPrintPreview.ScalePercent := FScale;
  end;
end;

procedure TTestPrintPreviewDlg.SynEditPrintPreviewPreviewPage(
  Sender: TObject; PageNumber: Integer);
begin
  StatusBar.Panels[0].Text := sPageLabel + IntToStr(SynEditPrintPreview.PageNumber);
end;

procedure TTestPrintPreviewDlg.PopupMenu1Popup(Sender: TObject);
var
  i : integer;
begin
  for i := 0 to PopupMenu1.Items.Count - 1 do
  begin
    PopupMenu1.Items[i].Checked := False;
  end;
  // now check the right one
  if SynEditPrintPreview.ScaleMode = pscWholePage then
    PopupMenu1.Items[0].Checked := True
  else if SynEditPrintPreview.ScaleMode = pscPageWidth then
    PopupMenu1.Items[1].Checked := True
  else
  begin
    // user scale
    case SynEditPrintPreview.ScalePercent of
      25  : PopupMenu1.Items[3].Checked := True;
      50  : PopupMenu1.Items[4].Checked := True;
      100 : PopupMenu1.Items[5].Checked := True;
      200 : PopupMenu1.Items[6].Checked := True;
      400 : PopupMenu1.Items[7].Checked := True;
    end;
  end;

end;

procedure TTestPrintPreviewDlg.FormCreate(Sender: TObject);
begin
  CreateSynEditComponents;
  CreatePopupMenu;
  Toolbutton3.DropdownMenu := PopupMenu1;
end;

procedure TTestPrintPreviewDlg.CreatePopupMenu;
begin
  PopupMenu1 := TOfficePopupMenu.Create(Self);
  Fitto1 := TOfficeMenuItem.Create(PopupMenu1);
  Pagewidth1 := TOfficeMenuItem.Create(PopupMenu1);
  N1 := TOfficeMenuItem.Create(PopupMenu1);
  N251 := TOfficeMenuItem.Create(PopupMenu1);
  N501 := TOfficeMenuItem.Create(PopupMenu1);
  N1001 := TOfficeMenuItem.Create(PopupMenu1);
  N2001 := TOfficeMenuItem.Create(PopupMenu1);
  N4001 := TOfficeMenuItem.Create(PopupMenu1);
  PopupMenu1.Items.Add([Fitto1, Pagewidth1, N1, N251, N501, N1001, N2001, N4001]);
  with PopupMenu1 do
  begin
    Name := 'PopupMenu1';
    OnPopup := PopupMenu1Popup;
  end;
  with Fitto1 do
  begin
    Name := 'Fitto1';
    Tag := -1;
    Caption := sWholePage;
    GroupIndex := 1;
    OnClick := Fitto1Click;
  end;
  with Pagewidth1 do
  begin
    Name := 'Pagewidth1';
    Tag := -2;
    Caption := sPageWidth;
    GroupIndex := 1;
    OnClick := Fitto1Click;
  end;
  with N1 do
  begin
    Name := 'N1';
    Caption := '-';
    GroupIndex := 1;
    OnClick := Fitto1Click;
  end;
  with N251 do
  begin
    Name := 'N251';
    Tag := 25;
    Caption := '25%';
    GroupIndex := 1;
    OnClick := Fitto1Click;
  end;
  with N501 do
  begin
    Name := 'N501';
    Tag := 50;
    Caption := '50%';
    GroupIndex := 1;
    OnClick := Fitto1Click;
  end;
  with N1001 do
  begin
    Name := 'N1001';
    Tag := 100;
    Caption := '100%';
    GroupIndex := 1;
    OnClick := Fitto1Click;
  end;
  with N2001 do
  begin
    Name := 'N2001';
    Tag := 200;
    Caption := '200%';
    GroupIndex := 1;
    OnClick := Fitto1Click;
  end;
  with N4001 do
  begin
    Name := 'N4001';
    Tag := 400;
    Caption := '400%';
    GroupIndex := 1;
    OnClick := Fitto1Click;
  end;
end;

procedure TTestPrintPreviewDlg.CreateSynEditComponents;
begin
  SynEditPrintPreview := TSynEditPrintPreview.Create(Self);
  with SynEditPrintPreview do
  begin
    Name := 'SynEditPrintPreview';
    Parent := Self;
    Left := 0;
    Top := 23;
    Width := 508;
    Height := 344;
    ScaleMode := pscWholePage;
    OnMouseDown := SynEditPrintPreviewMouseDown;
    OnPreviewPage := SynEditPrintPreviewPreviewPage;
  end;
end;

end.

