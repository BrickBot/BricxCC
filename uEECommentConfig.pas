unit uEECommentConfig;

interface

uses
  Classes, StdCtrls, Controls, Forms;

type
  TfrmCommentConfig = class(TForm)
    GroupBox1: TGroupBox;
    rbSlash: TRadioButton;
    btnOK: TButton;
    btnCancel: TButton;
    rbCpp: TRadioButton;
    chkInsertSpace: TCheckBox;
  end;

procedure CommentConfigure;

implementation

{$R *.dfm}

uses
  SysUtils, uEditorExperts;

procedure CommentConfigure;
var
  Dlg: TfrmCommentConfig;
begin
  Dlg := TfrmCommentConfig.Create(nil);
  try
    case CommentType of
      ctSlash: Dlg.rbSlash.Checked := True;
      ctCpp: Dlg.rbCpp.Checked := True;
    end;
    Dlg.chkInsertSpace.Checked := InsertRemoveSpace;

    if Dlg.ShowModal = mrOk then
    begin
      if Dlg.rbSlash.Checked then
        CommentType := ctSlash
      else
        CommentType := ctCpp;
      InsertRemoveSpace := Dlg.chkInsertSpace.Checked;
    end;
  finally
    FreeAndNil(Dlg);
  end;
end;

end.

