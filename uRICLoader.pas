(*
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uRICLoader;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, BricxccSpin;

type
  TfrmRICLoader = class(TForm)
    btnOpen: TButton;
    dlgOpen: TOpenDialog;
    pagMain: TPageControl;
    shtPixel: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    btnAddPixel: TButton;
    shtLine: TTabSheet;
    btnAddLine: TButton;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    shtRect: TTabSheet;
    btnAddRect: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    shtCircle: TTabSheet;
    btnAddCircle: TButton;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    btnNew: TButton;
    btnSaveAs: TButton;
    dlgSave: TSaveDialog;
    shtDescr: TTabSheet;
    Label14: TLabel;
    Label15: TLabel;
    btnAddDescr: TButton;
    shtNumBox: TTabSheet;
    btnAddNumBox: TButton;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    chkNumBoxVal: TCheckBox;
    chkNumBoxY: TCheckBox;
    chkNumBoxX: TCheckBox;
    chkCircleX: TCheckBox;
    chkCircleY: TCheckBox;
    chkCircleR: TCheckBox;
    chkRectX: TCheckBox;
    chkRectY: TCheckBox;
    chkRectW: TCheckBox;
    chkLineX1: TCheckBox;
    chkLineY1: TCheckBox;
    chkLineX2: TCheckBox;
    chkPixelX: TCheckBox;
    chkPixelY: TCheckBox;
    chkLineY2: TCheckBox;
    chkRectH: TCheckBox;
    btnTestCode: TButton;
    grpCopyOptions: TGroupBox;
    radCopy: TRadioButton;
    radCopyNot: TRadioButton;
    radOr: TRadioButton;
    radBitClear: TRadioButton;
    Label19: TLabel;
    Label20: TLabel;
    chkPixelWorkaround: TCheckBox;
    btnView: TButton;
    Label21: TLabel;
    chkPixelVal: TCheckBox;
    Label22: TLabel;
    cboPixelMapX: TComboBox;
    cboPixelMapY: TComboBox;
    cboPixelMapVal: TComboBox;
    cboLineMapX1: TComboBox;
    cboLineMapY1: TComboBox;
    cboLineMapX2: TComboBox;
    cboLineMapY2: TComboBox;
    cboRectMapX: TComboBox;
    cboRectMapY: TComboBox;
    cboRectMapW: TComboBox;
    cboRectMapH: TComboBox;
    cboCircleMapX: TComboBox;
    cboCircleMapY: TComboBox;
    cboCircleMapR: TComboBox;
    cboNumBoxMapX: TComboBox;
    cboNumBoxMapY: TComboBox;
    cboNumBoxMapVal: TComboBox;
    shtSprite: TTabSheet;
    shtVarMap: TTabSheet;
    shtCopyBits: TTabSheet;
    btnAddSprite: TButton;
    btnAddVarMap: TButton;
    btnAddCopyBits: TButton;
    Label23: TLabel;
    grpCopyBitsSource: TGroupBox;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    chkCopyBitsSrcX: TCheckBox;
    chkCopyBitsSrcY: TCheckBox;
    chkCopyBitsSrcW: TCheckBox;
    chkCopyBitsSrcH: TCheckBox;
    cboCopyBitsMapSrcX: TComboBox;
    cboCopyBitsMapSrcY: TComboBox;
    cboCopyBitsMapSrcW: TComboBox;
    cboCopyBitsMapSrcH: TComboBox;
    Label28: TLabel;
    chkCopyBitsAddr: TCheckBox;
    cboCopyBitsMapAddr: TComboBox;
    grpCopyBitsDest: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    chkCopyBitsDstX: TCheckBox;
    chkCopyBitsDstY: TCheckBox;
    cboCopyBitsMapDstX: TComboBox;
    cboCopyBitsMapDstY: TComboBox;
    edtDescrW: TBricxccSpinEdit;
    edtDescrH: TBricxccSpinEdit;
    edtDescrOpt: TBricxccSpinEdit;
    edtPixelX: TBricxccSpinEdit;
    edtPixelY: TBricxccSpinEdit;
    edtPixelVal: TBricxccSpinEdit;
    edtLineX1: TBricxccSpinEdit;
    edtLineY1: TBricxccSpinEdit;
    edtLineX2: TBricxccSpinEdit;
    edtLineY2: TBricxccSpinEdit;
    edtRectX: TBricxccSpinEdit;
    edtRectY: TBricxccSpinEdit;
    edtRectW: TBricxccSpinEdit;
    edtRectH: TBricxccSpinEdit;
    edtCircleX: TBricxccSpinEdit;
    edtCircleY: TBricxccSpinEdit;
    edtCircleR: TBricxccSpinEdit;
    edtNumBoxX: TBricxccSpinEdit;
    edtNumBoxY: TBricxccSpinEdit;
    edtNumBoxVal: TBricxccSpinEdit;
    edtSpriteAddr: TBricxccSpinEdit;
    edtCopyBitsSrcX: TBricxccSpinEdit;
    edtCopyBitsSrcY: TBricxccSpinEdit;
    edtCopyBitsSrcW: TBricxccSpinEdit;
    edtCopyBitsSrcH: TBricxccSpinEdit;
    edtCopyBitsAddr: TBricxccSpinEdit;
    edtCopyBitsDstX: TBricxccSpinEdit;
    edtCopyBitsDstY: TBricxccSpinEdit;
    procedure btnOpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveAsClick(Sender: TObject);
    procedure btnTestCodeClick(Sender: TObject);
    procedure btnAddDescrClick(Sender: TObject);
    procedure btnAddPixelClick(Sender: TObject);
    procedure btnAddLineClick(Sender: TObject);
    procedure btnAddRectClick(Sender: TObject);
    procedure btnAddCircleClick(Sender: TObject);
    procedure btnAddNumBoxClick(Sender: TObject);
    procedure btnViewClick(Sender: TObject);
    procedure btnAddSpriteClick(Sender: TObject);
    procedure btnAddVarMapClick(Sender: TObject);
    procedure btnAddCopyBitsClick(Sender: TObject);
  private
    { Private declarations }
    fMS : TMemoryStream;
    function GetCopyOptions : integer;
  public
    { Public declarations }
  end;

var
  frmRICLoader: TfrmRICLoader;

implementation

{$R *.dfm}

uses
  uRICComp, uRIC, uRICView;

procedure TfrmRICLoader.btnOpenClick(Sender: TObject);
begin
  if dlgOpen.Execute then
  begin
    dlgSave.FileName := dlgOpen.Filename;
    fMS.LoadFromFile(dlgOpen.Filename);
  end;
end;

procedure TfrmRICLoader.FormCreate(Sender: TObject);
begin
  fMS := TMemoryStream.Create;
end;

procedure TfrmRICLoader.FormDestroy(Sender: TObject);
begin
  fMS.Free;
end;

procedure TfrmRICLoader.btnNewClick(Sender: TObject);
begin
  fMS.Clear;
end;

procedure TfrmRICLoader.btnSaveAsClick(Sender: TObject);
begin
  if dlgSave.Execute then
    fMS.SaveToFile(dlgSave.Filename);
end;

procedure TfrmRICLoader.btnTestCodeClick(Sender: TObject);
var
  Status : Integer;
  TL : IMG_PT;
  Options : Cardinal;
  Vars : TRICVariables;
begin
  if dlgOpen.Execute then
  begin
    TL.X := 20;
    TL.Y := 20;
    Options := 0;
    Vars[0] := 10;
    Vars[1] := 12;
    Vars[2] := 14;
    Vars[3] := 20;
    cCmdWrapDrawPicture(Status, @TL, dlgOpen.FileName, Vars, Options);
  end;
end;

procedure TfrmRICLoader.btnAddDescrClick(Sender: TObject);
var
  X : IMG_OP_DESCRIPTION;
begin
  X.OpCode  := IMG_DESCRIPTION_ID;
  X.OpSize  := SizeOf(X)-2;
  X.Options := edtDescrOpt.Value;
  X.Width   := edtDescrW.Value;
  X.Height  := edtDescrH.Value;
  fMS.Write(X, SizeOf(X));
end;

function UsesArgs(val, map : integer; bUseArgs : boolean) : integer;
begin
  Result := val;
  if bUseArgs then
  begin
    Result := Result or USEARGS_MASK or ((map and $F) shl 8);
  end;
end;

procedure TfrmRICLoader.btnAddPixelClick(Sender: TObject);
var
  X : IMG_OP_PIXEL;
  W : Word;
begin
  X.OpCode := IMG_PIXEL_ID;
  X.OpSize := SizeOf(X)-2;
  if chkPixelWorkaround.Checked then
    X.OpSize := X.OpSize + 2;
  X.CopyOptions := GetCopyOptions;
  X.Pt.X := UsesArgs(edtPixelX.Value, cboPixelMapX.ItemIndex, chkPixelX.Checked);
  X.Pt.Y := UsesArgs(edtPixelY.Value, cboPixelMapY.ItemIndex, chkPixelY.Checked);
  X.Value := UsesArgs(edtPixelVal.Value, cboPixelMapVal.ItemIndex, chkPixelVal.Checked);
  fMS.Write(X, SizeOf(X));
  if chkPixelWorkaround.Checked then
    fMS.Write(W, 2);
end;

procedure TfrmRICLoader.btnAddLineClick(Sender: TObject);
var
  X : IMG_OP_LINE;
begin
  X.OpCode := IMG_LINE_ID;
  X.OpSize := SizeOf(X)-2;
  X.CopyOptions := GetCopyOptions;
  X.Pt1.X := UsesArgs(edtLineX1.Value, cboLineMapX1.ItemIndex, chkLineX1.Checked);
  X.Pt1.Y := UsesArgs(edtLineY1.Value, cboLineMapY1.ItemIndex, chkLineY1.Checked);
  X.Pt2.X := UsesArgs(edtLineX2.Value, cboLineMapX2.ItemIndex, chkLineX2.Checked);
  X.Pt2.Y := UsesArgs(edtLineY2.Value, cboLineMapY2.ItemIndex, chkLineY2.Checked);
  fMS.Write(X, SizeOf(X));
end;

procedure TfrmRICLoader.btnAddRectClick(Sender: TObject);
var
  X : IMG_OP_RECT;
begin
  X.OpCode := IMG_RECTANGLE_ID;
  X.OpSize := SizeOf(X)-2;
  X.CopyOptions := GetCopyOptions;
  X.Pt.X := UsesArgs(edtRectX.Value, cboRectMapX.ItemIndex, chkRectX.Checked);
  X.Pt.Y := UsesArgs(edtRectY.Value, cboRectMapY.ItemIndex, chkRectY.Checked);
  X.Width := UsesArgs(edtRectW.Value, cboRectMapW.ItemIndex, chkRectW.Checked);
  X.Height := UsesArgs(edtRectH.Value, cboRectMapH.ItemIndex, chkRectH.Checked);
  fMS.Write(X, SizeOf(X));
end;

procedure TfrmRICLoader.btnAddCircleClick(Sender: TObject);
var
  X : IMG_OP_CIRCLE;
begin
  X.OpCode := IMG_CIRCLE_ID;
  X.OpSize := SizeOf(X)-2;
  X.CopyOptions := GetCopyOptions;
  X.Pt.X := UsesArgs(edtCircleX.Value, cboCircleMapX.ItemIndex, chkCircleX.Checked);
  X.Pt.Y := UsesArgs(edtCircleY.Value, cboCircleMapY.ItemIndex, chkCircleY.Checked);
  X.Radius := UsesArgs(edtCircleR.Value, cboCircleMapR.ItemIndex, chkCircleR.Checked);
  fMS.Write(X, SizeOf(X));
end;

procedure TfrmRICLoader.btnAddNumBoxClick(Sender: TObject);
var
  X : IMG_OP_NUMBOX;
begin
  X.OpCode := IMG_NUMBOX_ID;
  X.OpSize := SizeOf(X)-2;
  X.CopyOptions := GetCopyOptions;
  X.Pt.X := UsesArgs(edtNumBoxX.Value, cboNumBoxMapX.ItemIndex, chkNumBoxX.Checked);
  X.Pt.Y := UsesArgs(edtNumBoxY.Value, cboNumBoxMapY.ItemIndex, chkNumBoxY.Checked);
  X.Value := UsesArgs(edtNumBoxVal.Value, cboNumBoxMapVal.ItemIndex, chkNumBoxVal.Checked);
  fMS.Write(X, SizeOf(X));
end;

function TfrmRICLoader.GetCopyOptions: integer;
begin
  // Copy, CopyNot, Or, BitClear
  if radCopyNot.Checked then
    Result := 1
  else if radOr.Checked then
    Result := 2
  else if radBitClear.Checked then
    Result := 3
  else
    Result := 0;
end;

procedure TfrmRICLoader.btnViewClick(Sender: TObject);
begin
  frmRICView.mmoText.Lines.Text := TRICComp.RICToText(fMS, dlgOpen.FileName);
  frmRICView.Show;
end;

procedure TfrmRICLoader.btnAddSpriteClick(Sender: TObject);
//var
//  X : IMG_OP_COPYBITS;
begin
//
{
  IMG_OP_SPRITE = record
    OpSize : Word;
    OpCode : Word;
    DataAddr : Word; //Address sprite handle will be stored in.
    Rows : Word;     //Second dimension of the array below.
    RowBytes : Word; //The actual size of the following array. Must be even.
    Bytes : array[0..1] of Byte; // Minimum of two for alignment purposes
  end;
}
end;

procedure TfrmRICLoader.btnAddVarMapClick(Sender: TObject);
begin
//
end;

procedure TfrmRICLoader.btnAddCopyBitsClick(Sender: TObject);
var
  X : IMG_OP_COPYBITS;
  SR : TImgRect;
  DP : TImgPoint;
begin
  X.OpCode := IMG_COPYBITS_ID;
  X.OpSize := SizeOf(X)-2;
  X.CopyOptions := GetCopyOptions;
  X.DataAddr := UsesArgs(edtCopyBitsAddr.Value, cboCopyBitsMapAddr.ItemIndex, chkCopyBitsAddr.Checked);
  SR.Pt.X    := UsesArgs(edtCopyBitsSrcX.Value, cboCopyBitsMapSrcX.ItemIndex, chkCopyBitsSrcX.Checked);
  SR.Pt.Y    := UsesArgs(edtCopyBitsSrcY.Value, cboCopyBitsMapSrcY.ItemIndex, chkCopyBitsSrcY.Checked);
  SR.Width   := UsesArgs(edtCopyBitsSrcW.Value, cboCopyBitsMapSrcW.ItemIndex, chkCopyBitsSrcW.Checked);
  SR.Height  := UsesArgs(edtCopyBitsSrcH.Value, cboCopyBitsMapSrcH.ItemIndex, chkCopyBitsSrcH.Checked);
  DP.X       := UsesArgs(edtCopyBitsDstX.Value, cboCopyBitsMapDstX.ItemIndex, chkCopyBitsDstX.Checked);
  DP.Y       := UsesArgs(edtCopyBitsDstY.Value, cboCopyBitsMapDstY.ItemIndex, chkCopyBitsDstY.Checked);
  X.Src      := SR;
  X.Dst      := DP;
  fMS.Write(X, SizeOf(X));
end;

end.