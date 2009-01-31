unit CodeUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, SynEdit, Menus, uOfficeComp;

type
  TCodeForm = class(TForm)
    CodeEdit: TSynEdit;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    pmnuCodeView: TOfficePopupMenu;
    lmiEditCopy: TOfficeMenuItem;
    lmiEditSelectAll: TOfficeMenuItem;
    N1: TOfficeMenuItem;
    mniCodeFind: TOfficeMenuItem;
    mniCodeFindNext: TOfficeMenuItem;
    mniCodeFindPrev: TOfficeMenuItem;
    N2: TOfficeMenuItem;
    mniStayOnTop: TOfficeMenuItem;
    procedure lmiEditCopyClick(Sender: TObject);
    procedure lmiEditSelectAllClick(Sender: TObject);
    procedure mniStayOnTopClick(Sender: TObject);
    procedure mniCodeFindClick(Sender: TObject);
    procedure mniCodeFindNextClick(Sender: TObject);
    procedure mniCodeFindPrevClick(Sender: TObject);
    procedure CreatePopupMenu;
  public
    { Public declarations }
  end;

var
  CodeForm: TCodeForm;

implementation

{$R *.DFM}

uses
  Editor, uLocalizedStrings;

procedure TCodeForm.lmiEditCopyClick(Sender: TObject);
begin
  CodeEdit.CopyToClipboard();
end;

procedure TCodeForm.lmiEditSelectAllClick(Sender: TObject);
begin
  CodeEdit.SelectAll();
end;

procedure TCodeForm.mniStayOnTopClick(Sender: TObject);
const
  FS : array[Boolean] of TFormStyle = (fsNormal, fsStayOnTop);
begin
  mniStayOnTop.Checked := not mniStayOnTop.Checked;
  FormStyle := FS[mniStayOnTop.Checked];
end;

procedure TCodeForm.mniCodeFindClick(Sender: TObject);
begin
  ShowSearchReplaceDialog(CodeEdit, False);
end;

procedure TCodeForm.mniCodeFindNextClick(Sender: TObject);
begin
  DoSearchReplaceText(CodeEdit, False, False);
end;

procedure TCodeForm.mniCodeFindPrevClick(Sender: TObject);
begin
  DoSearchReplaceText(CodeEdit, False, True);
end;

procedure TCodeForm.FormCreate(Sender: TObject);
begin
  CreatePopupMenu;
  CodeEdit.PopupMenu := pmnuCodeView;
end;

procedure TCodeForm.CreatePopupMenu;
begin
  pmnuCodeView := TOfficePopupMenu.Create(Self);
  pmnuCodeView.Name := 'pmnuCodeView';
  lmiEditCopy := TOfficeMenuItem.Create(pmnuCodeView);
  lmiEditSelectAll := TOfficeMenuItem.Create(pmnuCodeView);
  N1 := TOfficeMenuItem.Create(pmnuCodeView);
  mniCodeFind := TOfficeMenuItem.Create(pmnuCodeView);
  mniCodeFindNext := TOfficeMenuItem.Create(pmnuCodeView);
  mniCodeFindPrev := TOfficeMenuItem.Create(pmnuCodeView);
  N2 := TOfficeMenuItem.Create(pmnuCodeView);
  mniStayOnTop := TOfficeMenuItem.Create(pmnuCodeView);
  pmnuCodeView.Items.Add([lmiEditCopy, lmiEditSelectAll, N1, mniCodeFind,
                          mniCodeFindNext, mniCodeFindPrev, N2,
                          mniStayOnTop]);
  with lmiEditCopy do
  begin
    Name := 'lmiEditCopy';
    Caption := sCopy;
    ShortCut := 16451;
    OnClick := lmiEditCopyClick;
  end;
  with lmiEditSelectAll do
  begin
    Name := 'lmiEditSelectAll';
    Caption := sSelectAll;
    ShortCut := 16449;
    OnClick := lmiEditSelectAllClick;
  end;
  with N1 do
  begin
    Name := 'N1';
    Caption := '-';
  end;
  with mniCodeFind do
  begin
    Name := 'mniCodeFind';
    Caption := sFind + '...';
    ShortCut := 16454;
    OnClick := mniCodeFindClick;
  end;
  with mniCodeFindNext do
  begin
    Name := 'mniCodeFindNext';
    Caption := sFindNext;
    ShortCut := 114;
    OnClick := mniCodeFindNextClick;
  end;
  with mniCodeFindPrev do
  begin
    Name := 'mniCodeFindPrev';
    Caption := sFindPrevious;
    ShortCut := 8306;
    OnClick := mniCodeFindPrevClick;
  end;
  with N2 do
  begin
    Name := 'N2';
    Caption := '-';
  end;
  with mniStayOnTop do
  begin
    Name := 'mniStayOnTop';
    Caption := sStayOnTop;
    RadioItem := True;
    OnClick := mniStayOnTopClick;
  end;
end;

end.
