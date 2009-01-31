unit Transdlg;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Buttons;

type
  TfrmTransEdit = class(TForm)
    lblTitle: TLabel;
    lblProgram: TLabel;
    lblParameters: TLabel;
    lblMacros: TLabel;
    lblWorkingDir: TLabel;
    edTitle: TEdit;
    edProgram: TEdit;
    edWorkingDir: TEdit;
    edParameters: TEdit;
    MacroButton: TBitBtn;
    MacroList: TListBox;
    OKButton: TButton;
    CancelButton: TButton;
    InsertButton: TButton;
    BrowseButton: TButton;
    OpenDialog: TOpenDialog;
    btnHelp: TButton;
    chkWait: TCheckBox;
    chkClose: TCheckBox;
    lblExt: TLabel;
    edtExt: TEdit;
    chkRestrict: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MacroButtonClick(Sender: TObject);
    procedure BrowseButtonClick(Sender: TObject);
    procedure InsertButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edTitleChange(Sender: TObject);
    procedure MacroListClick(Sender: TObject);
    procedure OKButtonClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    bmpUp, bmpDn : TBitmap;
    fCaptionHeight : integer;
    procedure SetSize(bLarge : boolean = false);
    function SizeIsLarge : boolean;
    function GetMacroGlyph : TBitmap;
    procedure UpdateButtonState;
    procedure LoadMacros;
  public
    { Public declarations }
  end;

var
  frmTransEdit: TfrmTransEdit;
  TransferMacros : array[0..12] of String =
    ('$COL', '$ROW', '$CURTOKEN', '$PATH()', '$NAME()', '$NAMEONLY()',
     '$EXT()', '$EDNAME', '$PROMPT()', '$SAVE', '$SAVEALL', '$PORT',
     '$TARGET');

const
  M_COL       = 0;
  M_ROW       = 1;
  M_CURTOKEN  = 2;
  M_PATH      = 3;
  M_NAME      = 4;
  M_NAMEONLY  = 5;
  M_EXT       = 6;
  M_EDNAME    = 7;
  M_PROMPT    = 8;
  M_SAVE      = 9;
  M_SAVEALL   = 10;
  M_PORT      = 11;
  M_TARGET    = 12;

implementation

uses
  uLocalizedStrings;

{$R *.DFM}

const
  SMALL_SIZE = 160+28;
  LARGE_SIZE = 282+28;

procedure TfrmTransEdit.FormCreate(Sender: TObject);
begin
  LoadMacros;
  fCaptionHeight := GetSystemMetrics(SM_CYCAPTION);
  bmpUp := TBitmap.Create;
  bmpDn := TBitmap.Create;
  bmpUp.LoadFromResourceName(HInstance, 'MACROUP');
  bmpDn.LoadFromResourceName(HInstance, 'MACRODN');
  SetSize;
  UpdateButtonState;
end;

procedure TfrmTransEdit.FormDestroy(Sender: TObject);
begin
  bmpUp.Free;
  bmpDn.Free;
end;

procedure TfrmTransEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
//
end;

procedure TfrmTransEdit.MacroButtonClick(Sender: TObject);
begin
  SetSize(not SizeIsLarge);
end;

procedure TfrmTransEdit.BrowseButtonClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    edProgram.Text := OpenDialog.FileName;
    edWorkingDir.Text := ExtractFileDir(OpenDialog.FileName);
  end;
end;

procedure TfrmTransEdit.InsertButtonClick(Sender: TObject);
begin
  if MacroList.ItemIndex <> -1 then
  begin
    edParameters.SelText := TransferMacros[MacroList.ItemIndex];
  end;
end;

procedure TfrmTransEdit.SetSize(bLarge: boolean);
var
  h : integer;
begin
  if bLarge then
    h := Trunc(LARGE_SIZE * (Screen.PixelsPerInch / 96))
  else
    h := Trunc(SMALL_SIZE * (Screen.PixelsPerInch / 96));
  Height := h + fCaptionHeight;
  MacroButton.Glyph := GetMacroGlyph;
end;

function TfrmTransEdit.SizeIsLarge: boolean;
begin
  result := Height = Trunc(LARGE_SIZE * (Screen.PixelsPerInch / 96)) + fCaptionHeight;
end;

function TfrmTransEdit.GetMacroGlyph: TBitmap;
begin
  result := bmpDn;
  if SizeIsLarge then
    result := bmpUp;
end;

procedure TfrmTransEdit.edTitleChange(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TfrmTransEdit.UpdateButtonState;
begin
  OKButton.Enabled := not ((edTitle.Text = '') or (edProgram.Text = ''));
  InsertButton.Enabled := MacroList.ItemIndex <> -1;
end;

procedure TfrmTransEdit.MacroListClick(Sender: TObject);
begin
  UpdateButtonState;
end;

procedure TfrmTransEdit.LoadMacros;
begin
  MacroList.Items.Add(TransferMacros[0]+#9+sColMacro);
  MacroList.Items.Add(TransferMacros[1]+#9+sRowMacro);
  MacroList.Items.Add(TransferMacros[2]+#9+sCurTokenMacro);
  MacroList.Items.Add(TransferMacros[3]+#9+sPathMacro);
  MacroList.Items.Add(TransferMacros[4]+#9+sNameMacro);
  MacroList.Items.Add(TransferMacros[5]+#9+sNameOnlyMacro);
  MacroList.Items.Add(TransferMacros[6]+#9+sExtMacro);
  MacroList.Items.Add(TransferMacros[7]+#9+sEdNameMacro);
  MacroList.Items.Add(TransferMacros[8]+#9+sPromptMacro);
  MacroList.Items.Add(TransferMacros[9]+#9+sSaveMacro);
  MacroList.Items.Add(TransferMacros[10]+#9+sSaveAllMacro);
  MacroList.Items.Add(TransferMacros[11]+#9+sPortMacro);
  MacroList.Items.Add(TransferMacros[12]+#9+sTargetMacro);
end;

procedure TfrmTransEdit.OKButtonClick(Sender: TObject);
begin
// verify correctness of parameters
end;

procedure TfrmTransEdit.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

end.

