unit uNXTWatchGroups;

interface

uses
  SysUtils, Classes, Controls, Forms, StdCtrls;

type
  TfrmNXTWatchGroups = class(TForm)
    cboGroupName: TComboBox;
    lblGroupName: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
