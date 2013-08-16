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
unit ev3RGFedit_MainForm;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, Controls, Forms, Graphics, Dialogs, ExtCtrls, StdCtrls, Menus,
  Buttons, ComCtrls;

type
  TDrawMode = ( dmNone,
                dmPoint,
                dmLine,
                dmRectangle,
                dmBar,
                dmCircle,
                dmText );

  TMirror = ( mirrorHorizontal,
              mirrorVertical    );

  TScroll = ( scrollLeft,
              scrollRight,
              scrollUp,
              scrollDown );

  TStatus = ( statusModify,
              statusNew,
              statusLoaded,
              statusImported,
              statusSaved );

const
  STATUS_TEXT : array[ TStatus ] of string
              = ( 'Modified',
                  'New',
                  'Loaded',
                  'Imported',
                  'Saved'     );

type

  { TfrmEV3RGFEDIT }

  TfrmEV3RGFEDIT = class(TForm)
    Image_Display: TImage;
    Label1: TLabel;
    PanelNavigation: TPanel;
    Label2: TLabel;
    Panel2: TPanel;
    Image_Preview: TImage;
    BitBtn_ScrollUp: TBitBtn;
    BitBtn_ScrollLeft: TBitBtn;
    BitBtn_ScrollDown: TBitBtn;
    BitBtn_ScrollRight: TBitBtn;
    BitBtn_MirrorHorizontal: TBitBtn;
    BitBtn_Invert: TBitBtn;
    BitBtn_MirrorVertical: TBitBtn;
    BitBtn_Clear: TBitBtn;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    New1: TMenuItem;
    N1: TMenuItem;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Saveas1: TMenuItem;
    N7: TMenuItem;
    Impor1: TMenuItem;
    N2: TMenuItem;
    Exit1: TMenuItem;
    Edit1: TMenuItem;
    Clear1: TMenuItem;
    Invert1: TMenuItem;
    N4: TMenuItem;
    Scrollleft1: TMenuItem;
    Scrollright1: TMenuItem;
    Scrollup1: TMenuItem;
    ScrollDown1: TMenuItem;
    Draw1: TMenuItem;
    Point1: TMenuItem;
    Line1: TMenuItem;
    Box1: TMenuItem;
    Rectangle1: TMenuItem;
    Circle1: TMenuItem;
    Text: TMenuItem;
    Label_X10: TLabel;
    Label_X20: TLabel;
    Label_X30: TLabel;
    Label_X40: TLabel;
    Label_X50: TLabel;
    Label_X60: TLabel;
    Label_X70: TLabel;
    Label_X80: TLabel;
    Label_X90: TLabel;
    Label_X100: TLabel;
    Label_Y10: TLabel;
    Label_Y20: TLabel;
    Label_Y30: TLabel;
    Label_Y40: TLabel;
    Label_Y50: TLabel;
    Label_Y60: TLabel;
    StatusBar: TStatusBar;
    N5: TMenuItem;
    Mirrorhorizontal1: TMenuItem;
    Mirrorvertical1: TMenuItem;
    SpeedButton_DrawPoint: TSpeedButton;
    SpeedButton_DrawLine: TSpeedButton;
    SpeedButton_DrawRectangle: TSpeedButton;
    SpeedButton_DrawBar: TSpeedButton;
    SpeedButton_DrawCircle: TSpeedButton;
    SpeedButton_DrawText: TSpeedButton;
    BitBtn_ImageSave: TBitBtn;
    BitBtn_ImageOpen: TBitBtn;
    BitBtn_ImageImport: TBitBtn;
    N3: TMenuItem;
    barScale: TTrackBar;
    Undo1: TMenuItem;
    BitBtn_Undo: TBitBtn;
    Label_X110: TLabel;
    Label_X120: TLabel;
    Label_X130: TLabel;
    Label_X00: TLabel;
    Label_X140: TLabel;
    Label_X150: TLabel;
    Label_X160: TLabel;
    Label_X170: TLabel;
    Label_Y00: TLabel;
    Label_Y70: TLabel;
    Label_Y80: TLabel;
    Label_Y90: TLabel;
    Label_Y100: TLabel;
    Label_Y110: TLabel;
    Label_Y120: TLabel;
    chkAutotrim: TCheckBox;
    procedure Draw1Click(Sender: TObject);
    procedure Image_DisplayMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Image_DisplayMouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
    procedure Image_DisplayMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MirrorHorizontalClick(Sender: TObject);
    procedure MirrorVerticalClick(Sender: TObject);
    procedure PanelNavigationClick(Sender: TObject);
    procedure ScrollUpClick(Sender: TObject);
    procedure ScrollLeftClick(Sender: TObject);
    procedure ScrollDownClick(Sender: TObject);
    procedure ScrollRightClick(Sender: TObject);
    procedure DrawPointClick(Sender: TObject);
    procedure DrawLineClick(Sender: TObject);
    procedure DrawRectangleClick(Sender: TObject);
    procedure DrawBarClick(Sender: TObject);
    procedure DrawCircleClick(Sender: TObject);
    procedure DrawTextClick(Sender: TObject);
    procedure ImageClearClick(Sender: TObject);
    procedure ImageSaveClick(Sender: TObject);
    procedure ImageOpenClick(Sender: TObject);
    procedure ImageImportClick(Sender: TObject);
    procedure ImageNewClick(Sender: TObject);
    procedure ImageSaveAsClick(Sender: TObject);
    procedure ImageInvertClick(Sender: TObject);
    procedure ExitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure barScaleChange(Sender: TObject);
    procedure UndoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    fXLabels : array of TLabel;
    fYLabels : array of TLabel;
    procedure Exchange( var a, b : Integer );
    procedure Mirror( image : TImage; mirror : TMirror );
    procedure DrawEllipse( image : TImage; x1,y1, x2,y2 : Integer );
    procedure DrawBar( image : TImage; x1,y1, x2,y2:Integer );
    procedure DrawText( image : TImage; x,y:Integer; color:TColor );
    procedure ImagePosToPos( x,y:Integer; var posx,posy:Integer );
    procedure ImageClear( image : TImage );
    procedure ImageShow( image : TImage; modify : Boolean );
    procedure ImageScroll( image : Timage; scroll : TScroll );
    procedure SetDrawMode( dm : TDrawMode );
    procedure UndoSavePicture;
    procedure UndoRestorePicture;
    procedure AdjustScale;
    procedure AdjustLabelPositions(scale : integer);

    //--- Procedures for user interaction
    procedure ImageUndo;
    procedure ImageLoad;
    procedure ImageSave;
    procedure ImageSaveAs;
    procedure ImageImport;
    procedure ImageNew;
    procedure ImageInvert;
    procedure ImageMirrorHorizontal;
    procedure ImageMirrorVertical;
    procedure ImageScrollLeft;
    procedure ImageScrollRight;
    procedure ImageScrollUp;
    procedure ImageScrollDown;
    procedure ImageClean;
    //--- Basic routines
    function  ExitProgram : Boolean;
  public
    matrix       : TImage;
    matrix_temp  : TImage;

    posx_last    : Integer;
    posy_last    : Integer;

    posx_start   : Integer;
    posy_start   : Integer;

    posx_cur : Integer;
    posy_cur : Integer;

    modified     : Boolean;

    filename     : String;

    drawmode     : TDrawMode;
    show_temp    : Boolean;
    draw_color   : TColor;

    undolist     : TList;
  end;

var
  frmEV3RGFEDIT: TfrmEV3RGFEDIT;

implementation

uses
  Types, SysUtils, Math, ev3RGFedit_AddText, ev3RGFedit_Basis,
  ev3RGFEdit_FileOpen, ev3RGFedit_FileSave, ev3RGFedit_FileImport;

{$R *.dfm}

//------------------------------------------------------------------------------

Procedure TfrmEV3RGFEDIT.UndoSavePicture;
Var  picture : TImage;
Begin
     picture        := TImage.Create( Self );
     picture.Width  := RGFWidth;
     picture.Height := RGFHeight;
     picture.Canvas.CopyRect( Rect( 0,0,RGFWidth,RGFHeight ),
                              matrix.Canvas,
                              Rect( 0,0,RGFWidth,RGFHeight ) );

     undolist.Add( picture );

     If undolist.Count > MAX_UNDO
        Then Begin
                  picture := undolist.Items[ 0 ];
                  picture.Free;
                  undolist.Remove( undolist.Items[0] )
             End;

     BitBtn_Undo.Enabled := TRUE;
     Undo1.Enabled       := TRUE
End;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.UndoRestorePicture;
var
  picture : TImage;
begin
  if undolist.Count > 0 then
  begin
    picture := undolist.Items[ undolist.Count-1 ];

    matrix.Canvas.CopyRect( Rect( 0,0,RGFWidth,RGFHeight ),
                            picture.Canvas,
                            Rect( 0,0,RGFWidth,RGFHeight ) );

    ImageShow( matrix, TRUE );

    undolist.Remove( picture );
    picture.Free;

    BitBtn_Undo.Enabled := undolist.Count > 0;
    Undo1.Enabled       := BitBtn_Undo.Enabled;
  end;
end;

procedure TfrmEV3RGFEDIT.AdjustScale;
var
  tmpSF : integer;
begin
  tmpSF := barScale.Position;

  // first adjust form size
  self.Width  := EDT_BASE_WIDTH  + ((tmpSF - ZOOM) * RGFWidth);
  if tmpSF > ZOOM then
    self.Height := EDT_BASE_HEIGHT + ((tmpSF - ZOOM) * RGFHeight)
  else
    self.Height := EDT_BASE_HEIGHT;

  // then adjust image size
  Image_Display.Picture.Assign(nil);
  Image_Display.Width  := 1+RGFWidth*tmpSF;
  Image_Display.Height := 1+RGFHeight*tmpSF;

  // now adjust label positions
  AdjustLabelPositions(tmpSF);

  // now redraw image
  ScaleFactor := tmpSF;
  ImageShow( matrix, FALSE );
end;

procedure TfrmEV3RGFEDIT.AdjustLabelPositions(scale: integer);
var
  i, top : integer;
begin
  for i := 0 to Length(fXLabels) - 1 do
  begin
    fXLabels[i].Left := 230 + (i*10*scale);
  end;
  top := Image_Display.Height + Image_Display.Top - (fYLabels[0].Height div 2);
  for i := 0 to Length(fYLabels) - 1 do
  begin
    fYLabels[i].Top := top - (i*10*scale);
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.Exchange( var a, b : Integer );
var
  c : Integer;
begin
  c := a;
  a := b;
  b := c
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.Mirror( image : TImage; mirror : TMirror );
var
  x : Integer;
  y : Integer;
  h : Integer;
begin
  with image,image.Canvas do
  begin
    case mirror of
      mirrorHorizontal :
        for x := 0 to Width-1 do
          for y := 0 to (Height-1) div 2 do
          begin
            h := Pixels[ x,y ];
            Pixels[ x,y ] := Pixels[ x,Height-1-y ];
            Pixels[ x,Height-1-y ] := h;
          end;

      mirrorVertical :
        for y := 0 to Height-1 do
          for x := 0 to (Width-1) div 2 do
          begin
            h := Pixels[ x,y ];
            Pixels[ x,y ] := Pixels[ Width-1-x,y ];
            Pixels[ Width-1-x,y ] := h;
          end;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.DrawBar( image:TImage; x1,y1, x2,y2:Integer );
begin
  if x1 > x2 then
    Exchange( x1,x2 );
  if y1 > y2 then
    Exchange( y1,y2 );

  image.Canvas.FillRect( Rect( x1,y1, x2+1,y2+1 ) )
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.DrawEllipse( image : TImage; x1,y1, x2,y2 : Integer );
begin
  if x1 > x2 then
    Exchange( x1,x2 );
  if y1 > y2 then
    Exchange( y1,y2 );

  image.Canvas.Ellipse( x1,y1, x2+1,y2+1 );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.DrawText( image:TImage; x,y:Integer; color:TColor );
var
  w, h, i  : Integer;
begin

  with image.Canvas do
  begin
    Font.Color := color;
    Font.Name  := frmAddText.ComboBox_FontName.Text;
    Font.Size  := frmAddText.SpinEdit_FontSize.Value;
    Font.Style := [];

    if frmAddText.CheckBox_Italic.Checked then
      Font.Style := Font.Style + [ fsItalic ];
    if frmAddText.CheckBox_Underline.Checked then
      Font.Style := Font.Style + [ fsUnderline ];
    if frmAddText.CheckBox_StrikeOut.Checked then
      Font.Style := Font.Style + [ fsStrikeOut ];

    h := frmAddText.Memo_Text.Lines.Count*Font.Height;
    w := 0;
    for i := frmAddText.Memo_Text.Lines.Count-1 downto 0 do
      if TextWidth( frmAddText.Memo_Text.Lines[i] ) > w then
        w := TextWidth( frmAddText.Memo_Text.Lines[i] );

    h := h div 2;
    w := w div 2;

    Brush.Style := bsClear;
    for i := frmAddText.Memo_Text.Lines.Count-1 downto 0 do
      TextOut( x-w,y+h-i*Font.Height, frmAddText.Memo_Text.Lines[i] );
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.SetDrawMode( dm : TDrawMode );
begin
  drawmode := dm;

  case drawmode Of
    dmPoint     : SpeedButton_DrawPoint.Down     := TRUE;
    dmLine      : SpeedButton_DrawLine.Down      := TRUE;
    dmRectangle : SpeedButton_DrawRectangle.Down := TRUE;
    dmBar       : SpeedButton_DrawBar.Down       := TRUE;
    dmCircle    : SpeedButton_DrawCircle.Down    := TRUE;
    dmText      : SpeedButton_DrawText.Down      := TRUE;
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageUndo;
begin
  UndoRestorePicture;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageLoad;
var
  image_width  : Integer;
  image_height : Integer;
  F : TfrmFileOpen;
  ext : string;
begin
  F := TfrmFileOpen.Create(nil);
  try
    if F.ShowModal = mrOk then
    begin
      ImageClear( matrix );

      if LoadImage(F.FileName, matrix, image_width, image_height,
                   CL_FRONT, CL_BACKGROUND ) then
      begin
        ext := UpperCase(ExtractFileExt(F.FileName));
        if ext = '.RIC' then
        begin
          filename := base_path+ChangeFileExt( ExtractFileName( F.FileName ),'.rgf' );
          StatusBar.Panels[3].Text := STATUS_TEXT[ statusImported ];
          StatusBar.Panels[5].Text := filename;
          ImageShow( matrix, TRUE );
        end
        else
        begin
          filename := F.filename;
          ImageShow( matrix, FALSE );
          StatusBar.Panels[3].Text := STATUS_TEXT[ statusLoaded ];
          StatusBar.Panels[5].Text := filename;
          modified := false;
        end;
      end;
    end;
  finally
    F.Free;
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageSave;
var
  borders : TRect;
  ext : string;
begin
  ext := UpperCase(ExtractFileExt(filename));
  if (ext = '.RIC') or not FileExists(filename) then
    ImageSaveAs
  else
  begin
    borders := Rect(0, 0, matrix.Width-1, matrix.Height-1);
    if chkAutotrim.Checked then
      FindBorders( matrix, CL_FRONT, CL_BACKGROUND, borders );

    if SaveImageAddBorder( matrix, borders, Rect( 0,0,0,0 ),
                           frmFileSave.Fill_Dark,
                           CL_FRONT, CL_BACKGROUND,
                           filename ) then
    begin
      StatusBar.Panels[3].Text := STATUS_TEXT[ statusSaved ];
      modified := FALSE;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageSaveAs;
var
  borders   : TRect;
  addborder : TRect;
  oldname   : String;
begin
  borders := Rect(0, 0, matrix.Width-1, matrix.Height-1);
  if chkAutotrim.Checked then
    FindBorders( matrix, CL_FRONT, CL_BACKGROUND, borders );

  oldname := filename;

  frmFileSave.filename     := filename;
  frmFileSave.image_width  := borders.right  - borders.left + 1;
  frmFileSave.image_height := borders.bottom - borders.top + 1;

  if frmFileSave.ShowModal = mrOk then
  begin
    filename := frmFileSave.filename;

    addborder.left   := frmFileSave.border_left;
    addborder.right  := frmFileSave.border_right;
    addborder.top    := frmFileSave.border_top;
    addborder.Bottom := frmFileSave.border_Bottom;

    if SaveImageAddBorder( matrix, borders, addborder,
                           frmFileSave.Fill_Dark,
                           CL_FRONT, CL_BACKGROUND,
                           filename        ) then
    begin
      StatusBar.Panels[3].Text := STATUS_TEXT[ statusSaved ];
      StatusBar.Panels[5].Text := filename;
      modified := FALSE;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageImport;
var
  dest, src : TRect;
  F : TfrmImageImport;
begin
  F := TfrmImageImport.Create(nil);
  try
    if F.ShowModal = mrOk then
    begin
      dest := Rect( 0, 0, matrix.Width, matrix.Height );
  //    src  := Rect( 0, 0, matrix.Width, matrix.Height );
      src  := F.SourceRect;
      matrix.Canvas.CopyRect( dest, F.imgEV3.Canvas, src );

      filename := base_path+ChangeFileExt( ExtractFileName( F.FileName ),'.rgf' );

      StatusBar.Panels[3].Text := STATUS_TEXT[ statusImported ];
      StatusBar.Panels[5].Text := filename;
      ImageShow( matrix,TRUE );
    end;
  finally
    F.Free;
  end;
end;

//------------------------------------------------------------------------------

function TfrmEV3RGFEDIT.ExitProgram : Boolean;
var
  dlgVal : integer;
begin
  result := true;
  if modified then
  begin
    dlgVal := MessageDlg('File is modified - Save image?', mtConfirmation,
                         [mbYes, mbNo, mbCancel], 0);
    case dlgVal of
      mrYes    :
        begin
          if filename = '' then
           ImageSaveAs
          else
           ImageSave;
          Result := true;
        end;
      mrCancel : Result := false;
      mrNo     : Result := true;
    end;
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageNew;
var
  r : Integer;
begin
  if modified then
  begin
    r := MessageDlg( 'You will lose your work! Would you like to save first?',
                     mtConfirmation,
                     [ mbYes, mbNo, mbAbort ],
                     0 );
    if r = mrYes then
      ImageSave;
    if r = mrAbort then
      Exit;
  end;

  filename := base_path + 'New.rgf';
  StatusBar.Panels[5].Text := filename;

  ImageClear( matrix );
  ImageShow( matrix, FALSE );
  modified := FALSE;
  StatusBar.Panels[3].Text := STATUS_TEXT[ statusNew ];
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageInvert;
var
  x : Integer;
  y : Integer;
begin
  UndoSavePicture;

  with matrix.Canvas do
  begin
    for x := 0 to RGFWidth-1 do
      for y := 0 to RGFHeight-1 do
        if Pixels[ x,y ] = CL_FRONT then
          Pixels[ x,y ] := CL_BACKGROUND
        else
          Pixels[ x,y ] := CL_FRONT;

  end;
  ImageShow( matrix, TRUE );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageScroll( image : Timage; scroll : TScroll );
var
  i : Integer;
begin
  case scroll of

       scrollLeft   : With matrix.Canvas Do Begin
                           CopyRect( Rect( 0,0,RGFWidth-1,RGFHeight ),
                                     matrix.Canvas,
                                     Rect( 1,0,RGFWidth,RGFHeight ) );
                           For i := 0 To RGFHeight-1 DO
                               Pixels[ RGFWidth-1,i ] := CL_BACKGROUND;
                      End;

       scrollRight  : With matrix.Canvas Do Begin
                           CopyRect( Rect( 1,0,RGFWidth,RGFHeight ),
                                     matrix.Canvas,
                                     Rect( 0,0,RGFWidth-1,RGFHeight ) );
                           For i := 0 To RGFHeight-1 DO
                               Pixels[ 0,i ] := CL_BACKGROUND;
                      End;

       scrollUp     : With matrix.Canvas Do Begin
                           CopyRect( Rect( 0,0,RGFWidth,RGFHeight-1 ),
                                     matrix.Canvas,
                                     Rect( 0,1,RGFWidth,RGFHeight ) );
                           For i := 0 To RGFWidth-1 DO
                               Pixels[ i,RGFHeight-1 ] := CL_BACKGROUND
                      End;

       scrollDown   : With matrix.Canvas Do Begin
                           CopyRect( Rect( 0,1,RGFWidth,RGFHeight ),
                                     matrix.Canvas,
                                     Rect( 0,0,RGFWidth,RGFHeight-1 ) );
                           For i := 0 To RGFWidth-1 DO
                               Pixels[ i,0 ] := CL_BACKGROUND
                      End;
  end;

  ImageShow( matrix, TRUE );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageMirrorHorizontal;
begin
  UndoSavePicture;

  Mirror( matrix, mirrorHorizontal );
  ImageShow( matrix,TRUE );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageMirrorVertical;
begin
  UndoSavePicture;

  Mirror( matrix, mirrorVertical );
  ImageShow( matrix,TRUE );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageScrollLeft;
begin
  UndoSavePicture;

  ImageScroll( matrix, scrollLeft );
  ImageShow( matrix,TRUE );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageScrollRight;
begin
  UndoSavePicture;

  ImageScroll( matrix, scrollRight );
  ImageShow( matrix,TRUE );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageScrollUp;
begin
  UndoSavePicture;

  ImageScroll( matrix, scrollUp );
  ImageShow( matrix,TRUE );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageScrollDown;
begin
  UndoSavePicture;

  ImageScroll( matrix, scrollDown );
  ImageShow( matrix,TRUE );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageClean;
begin
  UndoSavePicture;

  ImageClear( matrix );
  ImageShow( matrix,TRUE );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImagePosToPos( x,y:Integer; var posx,posy:Integer );
begin
  posx := x div ScaleFactor;
  posy := y div ScaleFactor;

  if posx >= RGFWidth then
    posx := RGFWidth-1;
  if posx <  0 then
    posx := 0;

  if posy >= RGFHeight then
    posy := RGFHeight-1;
  if posy <  0 then
    posy := 0;

  StatusBar.Panels[1].Text := Format( '%3d / %3d', [ 1+posx, RGFHeight-posy ] );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageClear( image : TImage );
begin
  with image.Canvas do
  begin
    Brush.Color := CL_BACKGROUND;
    Pen.Color   := CL_BACKGROUND;
  end;
  image.Canvas.FillRect( Rect( 0,0,RGFWidth+1,RGFHeight+1 ) );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageShow( image : TImage; modify : Boolean );
var
  x  : Integer;
  y  : Integer;
  xx : Integer;
  yy : Integer;
begin
  with Image_Display.Canvas do
  begin
          Pen.Color := clGreen;
          Brush.Color := clGreen;
          Image_Display.Canvas.FillRect( Rect( 0,0,ScaleFactor*RGFWidth,ScaleFactor*RGFHeight ));

          CopyRect( Rect( 1,1, 1+ScaleFactor*(RGFWidth+1), 1+ScaleFactor*(RGFHeight+1) ),
                    image.Canvas,
                    Rect( 0,0,RGFWidth+1,RGFHeight+1 ) );

          Pen.Color := CL_RASTER_1;

          //--- Grid 1
          xx := ScaleFactor;
          yy := ScaleFactor*RGFHeight;
          for x := 1 to RGFWidth-1 do
          begin
            MoveTo( xx,0 );
            LineTo( xx,yy );
            Inc( xx,ScaleFactor );
          end;

          xx := ScaleFactor*RGFWidth;
          yy := ScaleFactor;
          for y := 1 to RGFHeight-1 do
          begin
            MoveTo( 0,yy );
            LineTo( xx,yy );
            Inc( yy,ScaleFactor );
          end;

          //--- Grid 10
          Pen.Color := CL_RASTER_10;

          xx := ScaleFactor*10;
          yy := ScaleFactor*RGFWidth;
          for x := 1 to RGFWidth div 10 do
          begin
            MoveTo( xx,0 );
            LineTo( xx,yy );
            Inc( xx,ScaleFactor*10 );
          end;

          xx := ScaleFactor*RGFWidth;
          yy := ScaleFactor*(RGFHeight-10 );
          for y := 1 to RGFHeight div 10 do
          begin
            MoveTo( 0,yy );
            LineTo( xx,yy );
            Dec( yy,ScaleFactor*10 );
          end;

          //--- Rectangle around the display

          Pen.Color := clBlack;
          MoveTo( 0,0 );
          LineTo( ScaleFactor*RGFWidth,0 );
          LineTo( ScaleFactor*RGFWidth,ScaleFactor*RGFHeight );
          LineTo( 0,ScaleFactor*RGFHeight );
          LineTo( 0,0 );
  end;

  Image_Preview.Canvas.CopyRect(Rect( 0,0, RGFWidth,RGFHeight ), image.Canvas,
    Rect( 0,0, RGFWidth,RGFHeight ) );

  modified := modified or modify;
  if modified then
    StatusBar.Panels[3].Text := STATUS_TEXT[ statusModify ];
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.Draw1Click(Sender: TObject);
begin
  Point1.Checked     := drawmode = dmPoint;
  Line1.Checked      := drawmode = dmLine;
  Rectangle1.Checked := drawmode = dmRectangle;
  Box1.Checked       := drawmode = dmBar;
  Circle1.Checked    := drawmode = dmCircle;
  Text.Checked       := drawmode = dmText;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.Image_DisplayMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
begin
  UndoSavePicture;

  ImagePosToPos( x,y, posx_start,posy_start );

  posx_last := posx_start;
  posy_last := posy_start;
  posx_cur := posx_start;
  posy_cur := posy_start;

  if [ ssLeft  ] = shift then
    draw_color := CL_FRONT;
  if [ ssRight ] = shift then
    draw_color := CL_BACKGROUND;

  case drawmode of
    dmPoint :
      with matrix.Canvas do
      begin
        Pixels[ posx_start,posy_start ] := draw_color;
        ImageShow( matrix,TRUE );
        show_temp := TRUE;
      end;
    dmLine, dmRectangle, dmBar, dmCircle : show_temp := TRUE;
    dmText :
      if show_temp then
      begin
        with matrix.Canvas do
        begin
          DrawText( matrix, posx_start, posy_start, draw_color );
          ImageShow( matrix,TRUE );
          show_temp := FALSE;
        end;
      end
      else if frmAddText.ShowModal = mrOK then
        show_temp := TRUE;
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.Image_DisplayMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  posx    : Integer;
  posy    : Integer;
  pos_new : Boolean;
  deltax : integer;
begin
  ImagePosToPos( x,y, posx,posy );

  // constrained rectangles and circles
  if (drawmode in [dmRectangle, dmBar, dmCircle]) and (ssShift in Shift) then
  begin
    deltax := abs(posx_last - posx);
    if posy < posy_last then
      posy := posy_last - deltax
    else
      posy := posy_last + deltax;
  end;

  posx_cur := posx;
  posy_cur := posy;

  pos_new := ( posx <> posx_last ) or ( posy <> posy_last );

  if pos_new and show_temp then
    case drawmode of
    dmPoint :
      with matrix.Canvas do
      begin
        Pixels[ posx,posy ] := draw_color;
        ImageShow( matrix,TRUE );
      end;
    dmLine :
      with matrix_temp.Canvas do
      begin
        CopyRect( Rect( 0,0, RGFWidth, RGFHeight ),
                  matrix.Canvas,
                  Rect( 0,0, RGFWidth, RGFHeight ) );

        Pen.Color := CL_MARKED;
        MoveTo( posx_start, posy_start );
        LineTo( posx, posy );
        LineTo( posx_start, posy_start );

        ImageShow( matrix_temp, FALSE );
      end;
    dmRectangle :
      with matrix_temp.Canvas do
      begin
        CopyRect( Rect( 0,0, RGFWidth, RGFHeight ),
                  matrix.Canvas,
                  Rect( 0,0, RGFWidth, RGFHeight ) );

        Pen.Color := CL_MARKED;
        MoveTo( posx_start, posy_start );
        LineTo( posx_start, posy );
        LineTo( posx, posy );
        LineTo( posx, posy_start );
        LineTo( posx_start, posy_start );

        ImageShow( matrix_temp,FALSE )
      end;
    dmBar :
      with matrix_temp.Canvas do
      begin
        CopyRect( Rect( 0,0, RGFWidth, RGFHeight ),
                  matrix.Canvas,
                  Rect( 0,0, RGFWidth, RGFHeight ) );

        Pen.Color   := CL_MARKED;
        Brush.Color := CL_MARKED;
        Brush.Style := bsSolid;
        DrawBar( matrix_temp, posx_start, posy_start, posx,posy );

        ImageShow( matrix_temp,FALSE )
      end;
    dmCircle :
      with matrix_temp.Canvas do
      begin
        CopyRect( Rect( 0,0, RGFWidth, RGFHeight ),
                  matrix.Canvas,
                  Rect( 0,0, RGFWidth, RGFHeight ) );

        Pen.Color := CL_MARKED;
        Brush.Style := bsClear;
        DrawEllipse( matrix_temp, posx_start, posy_start, posx, posy );

        ImageShow( matrix_temp,FALSE )
      end;
    dmText :
      with matrix_temp.Canvas do
      begin
        CopyRect( Rect( 0,0, RGFWidth, RGFHeight ),
                  matrix.Canvas,
                  Rect( 0,0, RGFWidth, RGFHeight ) );

        DrawText( matrix_temp, posx, posy, CL_MARKED );

        ImageShow( matrix_temp,FALSE );
      end;
    end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.Image_DisplayMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  posx, posy : Integer;
begin
  ImagePosToPos( x,y, posx,posy );

  // constrained rectangles and circles
  if posx <> posx_cur then
    posx := posx_cur;
  if posy <> posy_cur then
    posy := posy_cur;

  case drawmode of
    dmPoint : show_temp := FALSE;
    dmLine :
      with matrix.Canvas do
      begin
        show_temp := FALSE;

        Pen.Color := draw_color;
        MoveTo( posx_start, posy_start );
        LineTo( posx, posy );
        LineTo( posx_start, posy_start );

        ImageShow( matrix,TRUE );
      end;
    dmRectangle :
      with matrix.Canvas do
      begin
        show_temp := FALSE;

        Pen.Color := draw_color;
        MoveTo( posx_start, posy_start );
        LineTo( posx_start, posy );
        LineTo( posx, posy );
        LineTo( posx, posy_start );
        LineTo( posx_start, posy_start );

        ImageShow( matrix,TRUE );
      end;
    dmBar :
      with matrix.Canvas do
      begin
        show_temp := FALSE;

        Pen.Color := draw_color;
        Brush.Color := draw_color;
        Brush.Style := bsSolid;
        DrawBar( matrix, posx_start, posy_start, posx,posy );

        ImageShow( matrix,TRUE );
      end;
    dmCircle :
      with matrix.Canvas do
      begin
        show_temp := FALSE;

        Pen.Color := draw_color;
        Brush.Style := bsClear;
        DrawEllipse( matrix, posx_start, posy_start, posx, posy );

        ImageShow( matrix,TRUE );
      end;
    dmText :
      begin
      end;
  end;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.MirrorHorizontalClick(Sender: TObject);
begin
  ImageMirrorHorizontal;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.MirrorVerticalClick(Sender: TObject);
begin
  ImageMirrorVertical;
end;

procedure TfrmEV3RGFEDIT.PanelNavigationClick(Sender: TObject);
begin

end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageInvertClick(Sender: TObject);
begin
  ImageInvert;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageClearClick(Sender: TObject);
begin
  ImageClean;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ScrollUpClick(Sender: TObject);
begin
  ImageScrollUp;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ScrollLeftClick(Sender: TObject);
begin
  ImageScrollLeft;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ScrollDownClick(Sender: TObject);
begin
  ImageScrollDown;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ScrollRightClick(Sender: TObject);
begin
  ImageScrollRight;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.DrawPointClick(Sender: TObject);
begin
  SetDrawMode( dmPoint );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.DrawLineClick(Sender: TObject);
begin
  SetDrawMode( dmLine );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.DrawRectangleClick(Sender: TObject);
begin
  SetDrawMode( dmRectangle );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.DrawBarClick(Sender: TObject);
begin
  SetDrawMode( dmBar );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.DrawCircleClick(Sender: TObject);
begin
  SetDrawMode( dmCircle );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.DrawTextClick(Sender: TObject);
begin
  SetDrawMode( dmText );
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageSaveClick(Sender: TObject);
begin
  ImageSave;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageOpenClick(Sender: TObject);
begin
  ImageLoad;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageImportClick(Sender: TObject);
begin
  ImageImport;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageNewClick(Sender: TObject);
begin
  ImageNew;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ImageSaveAsClick(Sender: TObject);
begin
  ImageSaveAs;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.ExitClick(Sender: TObject);
begin
  Close;
end;

//------------------------------------------------------------------------------


procedure TfrmEV3RGFEDIT.UndoClick(Sender: TObject);
begin
  ImageUndo;
end;

//------------------------------------------------------------------------------

procedure TfrmEV3RGFEDIT.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := ExitProgram;
end;

procedure TfrmEV3RGFEDIT.barScaleChange(Sender: TObject);
begin
  AdjustScale;
  barScale.Hint := IntToStr(barScale.Position);
end;

procedure TfrmEV3RGFEDIT.FormCreate(Sender: TObject);
begin
  matrix               := TImage.Create( Self );
  matrix.Width         := RGFWidth;
  matrix.Height        := RGFHeight;

  matrix_temp          := TImage.Create( Self );
  matrix_temp.Width    := RGFWidth;
  matrix_temp.Height   := RGFHeight;

  undolist := TList.Create;
  SetLength(fXLabels, 18);
  fXLabels[0]  := Label_X00;
  fXLabels[1]  := Label_X10;
  fXLabels[2]  := Label_X20;
  fXLabels[3]  := Label_X30;
  fXLabels[4]  := Label_X40;
  fXLabels[5]  := Label_X50;
  fXLabels[6]  := Label_X60;
  fXLabels[7]  := Label_X70;
  fXLabels[8]  := Label_X80;
  fXLabels[9]  := Label_X90;
  fXLabels[10] := Label_X100;
  fXLabels[11] := Label_X110;
  fXLabels[12] := Label_X120;
  fXLabels[13] := Label_X130;
  fXLabels[14] := Label_X140;
  fXLabels[15] := Label_X150;
  fXLabels[16] := Label_X160;
  fXLabels[17] := Label_X170;
  SetLength(fYLabels, 13);
  fYLabels[0]  := Label_Y00;
  fYLabels[1]  := Label_Y10;
  fYLabels[2]  := Label_Y20;
  fYLabels[3]  := Label_Y30;
  fYLabels[4]  := Label_Y40;
  fYLabels[5]  := Label_Y50;
  fYLabels[6]  := Label_Y60;
  fYLabels[7]  := Label_Y70;
  fYLabels[8]  := Label_Y80;
  fYLabels[9]  := Label_Y90;
  fYLabels[10] := Label_Y100;
  fYLabels[11] := Label_Y110;
  fYLabels[12] := Label_Y120;
end;

procedure TfrmEV3RGFEDIT.FormDestroy(Sender: TObject);
begin
  FreeAndNil(matrix);
  FreeAndNil(matrix_temp);
  FreeAndNil(undolist);
  SetLength(fXLabels, 0);
  SetLength(fYLabels, 0);
end;

procedure TfrmEV3RGFEDIT.FormShow(Sender: TObject);
begin
  Image_Display.Width  := 1+ScaleFactor*RGFWidth;
  Image_Display.Height := 1+ScaleFactor*RGFHeight;

  filename             := base_path+'MyPicture1.rgf';

  SetDrawMode( dmPoint );

  StatusBar.Panels[3].Text := STATUS_TEXT[ statusNew ];
  StatusBar.Panels[5].Text := filename;

  ImageClear( matrix );
  ImageShow( matrix,FALSE );
  modified := False;
end;

end.

