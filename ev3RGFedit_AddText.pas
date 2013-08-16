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
 * The Initial Developer of this code is Andreas Dreier.
 *
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit ev3RGFedit_AddText;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
   Classes, Controls, Forms, StdCtrls, ExtCtrls, Buttons, BricxccSpin;

type
  TfrmAddText = class(TForm)
    Memo_Text: TMemo;
    Label_FontSize: TLabel;
    ComboBox_FontName: TComboBox;
    Lavel_Font: TLabel;
    Label_Text: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox_Preview: TGroupBox;
    Image_Preview: TImage;
    GroupBox_TextStyle: TGroupBox;
    CheckBox_Italic: TCheckBox;
    CheckBox_Underline: TCheckBox;
    CheckBox_StrikeOut: TCheckBox;
    SpinEdit_FontSize: TBricxccSpinEdit;
    procedure Memo_TextChange(Sender: TObject);
    procedure CheckBox_BoldClick(Sender: TObject);
    procedure CheckBox_ItalicClick(Sender: TObject);
    procedure CheckBox_UnderlineClick(Sender: TObject);
    procedure CheckBox_StrikeOutClick(Sender: TObject);
    procedure SpinEdit_FontSizeChange(Sender: TObject);
    procedure ComboBox_FontNameChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
     procedure DisplayExample;
  public
    { Public declarations }
  end;

var
  frmAddText: TfrmAddText;

implementation

{$R *.dfm}

uses
  Graphics;

//------------------------------------------------------------------------------

procedure TfrmAddText.DisplayExample;
var
  i : Integer;
begin
  with Image_Preview.Canvas do
  begin
    Font.Color := clBlack;
    Font.Name := ComboBox_FontName.Text;
    Font.Size := SpinEdit_FontSize.Value;
    Font.Style := [];

    if CheckBox_Italic.Checked    then
      Font.Style := Font.Style + [ fsItalic    ];
    if CheckBox_Underline.Checked then
      Font.Style := Font.Style + [ fsUnderline ];
    if CheckBox_StrikeOut.Checked then
      Font.Style := Font.Style + [ fsStrikeOut ];

    Pen.Color := clWhite;
    Brush.Color := clWhite;
    Rectangle( 0,0,178,128 );

    for i := Memo_Text.Lines.Count-1 downto 0 do
      TextOut( 0,-i*Font.Height, Memo_Text.Lines[i] );
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmAddText.Memo_TextChange(Sender: TObject);
begin
  DisplayExample;
end;

//------------------------------------------------------------------------------

procedure TfrmAddText.CheckBox_BoldClick(Sender: TObject);
begin
  DisplayExample;
end;

//------------------------------------------------------------------------------

procedure TfrmAddText.CheckBox_ItalicClick(Sender: TObject);
begin
  DisplayExample;
end;

//------------------------------------------------------------------------------

procedure TfrmAddText.CheckBox_UnderlineClick(Sender: TObject);
begin
  DisplayExample;
end;

//------------------------------------------------------------------------------

procedure TfrmAddText.CheckBox_StrikeOutClick(Sender: TObject);
begin
  DisplayExample;
end;

//------------------------------------------------------------------------------

procedure TfrmAddText.SpinEdit_FontSizeChange(Sender: TObject);
begin
  DisplayExample;
end;

//------------------------------------------------------------------------------

procedure TfrmAddText.ComboBox_FontNameChange(Sender: TObject);
begin
  // Memo_Text.Font.Name := ComboBox_FontName.Text;
  DisplayExample;
end;

//------------------------------------------------------------------------------

procedure TfrmAddText.FormActivate(Sender: TObject);
begin
  ComboBox_FontName.Items.Assign( screen.Fonts );
end;

//------------------------------------------------------------------------------

procedure TfrmAddText.FormShow(Sender: TObject);
begin
  DisplayExample;
end;

//------------------------------------------------------------------------------

end.
