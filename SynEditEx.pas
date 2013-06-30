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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit SynEditEx;

interface

uses
  Classes,SysUtils,
{$IFNDEF FPC}
  Windows,Messages,
{$ENDIF}
  Controls,Graphics,SynEdit,SynEditHighlighter;

type
{$IFNDEF FPC}
TOnMouseOverToken=procedure(Sender: TObject; const Token: String; TokenType: Integer; Attri: TSynHighlighterAttributes; var Highlight: Boolean) of object;
TOnTokenClick=procedure(Sender: TObject; XY:TPoint; const Token: String; TokenType: Integer; Attri: TSynHighlighterAttributes) of object;

THighlightTokenInfo=class
  private
    FToken: String;
    FStart: Integer;
    FActive: Boolean;
    FXY: TPoint;
    FAttri: TSynHighlighterAttributes;
    FTokenType: Integer;
    procedure SetAttributes(Value: TSynHighlighterAttributes);
  public
    constructor Create;
    destructor Destroy; override;
    property Attributes: TSynHighlighterAttributes read FAttri write SetAttributes;
    property Token: String read FToken write FToken;
    property TokenType: Integer read FTokenType write FTokenType;
    property Start: Integer read FStart write FStart;
    property Active: Boolean read FActive write FActive;
    property XY: TPoint read FXY write FXY;
end;

(*
This could be optimized by making the structure a record instead of a
full fledged class. I opted for the class because I was thinking I may
add some additional features later on that would be more maintainable
with the structure as a class element. Some optimization of class versus
record was achieved by pooling the structure classes instead of creating
new objects each time.

TextRect is used to hold the start and end text positions where the structure
line should be drawn. GraphicRect is where the position should be drawn in
graphical coordinates. TextRect is only updated if the a change is made to the text
and is updated in BuildStructure. GraphicRect is updated on each paint operation
since we always need correct graphical coordinates to determine how lines
should be invalidated. For example, when InvalidateRect is called the invalidation
rectangle may need to be increased so the entire structure line can be repainted.
*)

TStructure=class
  private
    FGraphicRect: TRect;
    FTextRect: TRect;
  public
    property GraphicRect: TRect read FGraphicRect write FGraphicRect;
    property TextRect: TRect read FTextRect write FTextRect;
end;

TStructures=class
  private
    FList: TList;
    FPooled: TList;
    FEditor: TSynEdit;
    function GetCount: Integer;
    function GetStructure(Index: Integer): TStructure;
  public
    constructor Create(Editor: TSynEdit);
    destructor Destroy; override;
    function NewStructure: TStructure;
    procedure Add(Value: TStructure);
    procedure Remove(Value: TStructure);
    procedure Delete(Index: Integer);
    procedure Clear;
    property Count: Integer read GetCount;
    property Structure[Index: Integer]: TStructure read GetStructure; default;
end;
{$ENDIF}

  TSynEditEx=class(TSynEdit)
  private
    FStructureLineColor: TColor;
    procedure SetStructureLineColor(Value: TColor);
{$IFNDEF FPC}
  private
    FStructures: TStructures;
    FOnMouseEnter: TNotifyEvent;
    FOnMouseExit: TNotifyEvent;
    FOnMouseOverToken: TOnMouseOverToken;
    FOnTokenClick: TOnTokenClick;
    FTokenInfo: THighlightTokenInfo;
    FTokenIsHighlighted: Boolean;
    procedure InvalidateToken;
    procedure BuildStructure;
  protected
    procedure CMMouseEnter(var Msg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MOUSELEAVE;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure DoTokenCheck(Shift: TShiftState; X,Y: Integer); virtual;
    procedure HighlightToken(XY: TPoint; S: String; Start,TokenType: Integer; Attributes: TSynHighlighterAttributes);
    procedure Click; override;
    procedure PaintStructure;
    procedure Paint; override;
    procedure PaintTextLines(AClip: TRect; FirstLine, LastLine,
      FirstCol, LastCol: integer); override;
    procedure InvalidateRect(const aRect: TRect; aErase: boolean); override;
    procedure DoOnStatusChange(Changes: TSynStatusChanges); override;
    procedure LinesChanged(Sender: TObject); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
{$ENDIF}
  published
    property StructureLineColor: TColor read FStructureLineColor write SetStructureLineColor;
{$IFNDEF FPC}
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseExit: TNotifyEvent read FOnMouseExit write FOnMouseExit;
    property OnMouseOverToken: TOnMouseOverToken read FOnMouseOverToken write FOnMouseOverToken;
    property OnTokenClick: TOnTokenClick read FOnTokenClick write FOnTokenClick;
{$ENDIF}
  end;

implementation

{$IFDEF FPC}
procedure TSynEditEx.SetStructureLineColor(Value: TColor);
begin
  if (Value<>FStructureLineColor) then
  begin
    FStructureLineColor:=Value;
    Invalidate;
  end;
end;

{$ELSE}
uses SynTextDrawer;

//Used by call to LineDDA on Win9x systems, on WinNT4,Win2K and WinXP
//a more efficient API call is used to draw the line
procedure DottedLine(X: Integer; Y: Integer; Data : LongInt); stdcall;
begin
  if (y mod 2)=0 then
    begin
    SetPixelV(TCanvas(Data).Handle,X,Y,TCanvas(Data).Pen.Color);
    end;
end;

function RectIntersects(R1,R2: TRect): Boolean;
var R: TRect;
Begin
  Result:=IntersectRect(R,R1,R2) or UnionRect(R,R1,R2);
End;

{ TSynEditEx }
constructor TSynEditEx.Create(AOwner: TComponent);
begin
  inherited;
  FTokenInfo:=THighlightTokenInfo.Create;
  FStructures:=TStructures.Create(Self);
  FStructureLineColor:=clNone;
end;

destructor TSynEditEx.Destroy;
begin
  FreeAndNil(FTokenInfo);
  FreeAndNil(FStructures);
  inherited;
end;

procedure TSynEditEx.CMMouseEnter(var Msg: TMessage);
begin
  InvalidateToken;
  if Assigned(OnMouseEnter) then OnMouseEnter(Self);
end;

procedure TSynEditEx.CMMouseLeave(var Msg: TMessage);
begin
  InvalidateToken;
  if Assigned(OnMouseExit) then OnMouseExit(Self);
end;

procedure TSynEditEx.DoTokenCheck(Shift: TShiftState; X, Y: Integer);
var S: String;
Start,TokenType: Integer;
Attri: TSynHighlighterAttributes;
P: TPoint;
DoHighlight: Boolean;
begin
  DoHighlight:=false;
  if (not (ssCtrl in Shift)) or (FTokenInfo=nil) or (not Assigned(OnMouseOverToken)) then
    begin
    InvalidateToken;
    exit;
    end;
  P:=PixelsToRowColumn(Point(X,Y));
  GetHighlighterAttriAtRowColEx(P,S,TokenType,Start,Attri);
  if (S<>'') and (Attri<>nil) then
    begin
    OnMouseOverToken(Self,S,TokenType,Attri,DoHighlight);
    if DoHighlight and not fTokenIsHighlighted then
      begin
      HighlightToken(P,S,Start,TokenType,Attri);
      fTokenIsHighlighted := True;
      end
    else if not DoHighlight then
      fTokenIsHighlighted := False;
    end
  else
    fTokenIsHighlighted := False;
  if not DoHighlight then InvalidateToken;
end;


procedure TSynEditEx.HighlightToken(XY: TPoint; S: String; Start,TokenType: Integer; Attributes: TSynHighlighterAttributes);
var P: TPoint;
fTextDrawer: TheTextDrawer;
Rect: TRect;
i: Integer;
begin
  if (FTokenInfo.Active) and ((FTokenInfo.Token<>S) or (FTokenInfo.Start<>Start) or (FTokenInfo.XY.Y<>XY.Y)) then
    InvalidateToken;
  Canvas.Font:=Font;
  Canvas.Font.Color:=clBlue;
  Canvas.Font.Style:=Attributes.Style;
  if Attributes.Background=clNone then Canvas.Brush.Color:=Color
  else Canvas.Brush.Color:=Attributes.Background;
  Canvas.Font.Style:=Canvas.Font.Style+[fsUnderLine];
  P.X:=Start;
  P.Y:=XY.Y;
  fTextDrawer:=TheTextDrawer.Create(Canvas.Font.Style, Canvas.Font);
  try
    fTextDrawer.BeginDrawing(Canvas.Handle);
    fTextDrawer.SetForeColor(Canvas.Font.Color);
    fTextDrawer.SetBackColor(Canvas.Brush.Color);

    //Painting one character at a time because if you paint the whole token
    //it doesn't seem to match up for certain fonts like Lucida. This could
    //probably be optimized by someone who understands SynEdit painting better
    //then I do
    for i:=1 to length(S) do
      begin
      P:=RowColumnToPixels(Point(Start+(i-1),XY.Y));
      Rect.TopLeft:=P;
      Rect.Right:=Rect.Left+fTextDrawer.CharWidth;
      Rect.Bottom:=Rect.Top+fTextDrawer.CharHeight;
      // don't paint that portion of the text within the gutter
      if (Rect.Left>Gutter.RealGutterWidth(CharWidth)) then
        fTextDrawer.ExtTextOut(P.X, P.Y, ETO_OPAQUE, Rect, @S[i], 1);
      end;
    fTextDrawer.EndDrawing;
  finally
    fTextDrawer.Free;
  end;
  Canvas.Brush.Style:=bsSolid;
  FTokenInfo.XY:=XY;
  FTokenInfo.Token:=S;
  FTokenInfo.Start:=Start;
  FTokenInfo.Attributes:=Attributes;
  FTokenInfo.TokenType:=TokenType;
  FTokenInfo.Active:=true;
  Cursor:=crHandPoint;
end;

procedure TSynEditEx.InvalidateToken;
begin
  if FTokenInfo.Active then
    begin
    Cursor:=crIBeam;
    FTokenInfo.Active:=false;
    InvalidateLine(FTokenInfo.XY.Y);
    end;
end;

procedure TSynEditEx.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  fTokenIsHighlighted := False;
  DoTokenCheck(Shift,X,Y);
end;

procedure TSynEditEx.KeyDown(var Key: Word; Shift: TShiftState);
var P: TPoint;
begin
  if (ssCtrl in Shift) then
    begin
    GetCursorPos(P);
    P:=ScreenToClient(P);
    if (P.X > 0) and
       (P.Y > 0) and
       (P.X < Width) and
       (P.Y < Height) then DoTokenCheck(Shift,P.X,P.Y);
    end;
  inherited;
end;

procedure TSynEditEx.KeyUp(var Key: Word; Shift: TShiftState);
begin
  if not (ssCtrl in Shift) then
    begin
    fTokenIsHighlighted := False;
    InvalidateToken;
    end;
  inherited;
end;

procedure TSynEditEx.Click;
begin
  if FTokenInfo.Active and Assigned(OnTokenClick) then
    begin
    OnTokenClick(Self,FTokenInfo.XY,FTokenInfo.Token,FTokenInfo.TokenType,FTokenInfo.Attributes);
    InvalidateToken;
    end
  else inherited;
end;

procedure TSynEditEx.PaintStructure;
var GP: TRect;
i: Integer;
lb : TLogBrush;
begin
  if (FStructureLineColor=clNone) or (Highlighter=nil) then exit;
  if Win32Platform=VER_PLATFORM_WIN32_WINDOWS then
    begin
    Canvas.Pen.Color:=StructureLineColor;
    Canvas.Pen.Mode:=pmCopy;
    end
  else
    begin
    lb.lbStyle := BS_SOLID;
    lb.lbColor := ColorToRGB(StructureLineColor);
    lb.lbHatch := 0;
    Canvas.Pen.Handle:=ExtCreatePen(PS_COSMETIC OR PS_ALTERNATE,1,lb,0,nil);
    end;

  for i:=0 to fStructures.Count-1 do
    begin
    GP.BottomRight:=RowColumnToPixels(FStructures[i].TextRect.BottomRight);
    GP.TopLeft:=RowColumnToPixels(FStructures[i].TextRect.TopLeft);
    GP.Left:=GP.Right;
    // don't paint upside down structures
    if GP.Top > GP.Bottom then Continue;
    // don't paint on the gutter
    if GP.Left <= Gutter.RealGutterWidth(CharWidth) then Continue;
    if RectIntersects(ClientRect,GP) then
      begin
      if Win32Platform=VER_PLATFORM_WIN32_WINDOWS then
        begin
        //Canvas.Pen.Style:=psDot;
        //Canvas.MoveTo(GP.BottomRight.X,GP.BottomRight.Y);
        //Canvas.LineTo(GP.TopLeft.X,GP.TopLeft.Y);
        //Canvas.MoveTo(GP.BottomRight.X,GP.BottomRight.Y-2);
        //Canvas.LineTo(GP.TopLeft.X,GP.TopLeft.Y);

        LineDDA(GP.BottomRight.X,GP.BottomRight.Y,GP.TopLeft.X,GP.TopLeft.Y,@DottedLine,LongInt(Canvas));
        end
      else
        begin
        Canvas.MoveTo(GP.BottomRight.X,GP.BottomRight.Y);
        Canvas.LineTo(GP.TopLeft.X,GP.TopLeft.Y);
        end;
      end;
    GP.BottomRight.Y:=GP.BottomRight.Y+LineHeight; //Include brace
    FStructures[i].FGraphicRect:=GP;
    end;
  Canvas.Pen.Style:=psSolid;
end;

procedure TSynEditEx.BuildStructure;
var i,j: Integer;
S: String;
Start,TokenType: Integer;
Attri: TSynHighlighterAttributes;
Structure: TStructure;
Filo: TList;
begin
  if (FStructureLineColor=clNone) or (Highlighter=nil) then exit;
  FStructures.Clear;
  Filo:=TList.Create;
  try
  for i:=Lines.Count-1 downto 0 do
    begin
    j:=length(Lines[i]);
    while (j>0) do
      begin
      if Lines[i][j]='}' then
        begin
        GetHighlighterAttriAtRowColEx(Point(j,i+1),S,TokenType,Start,Attri);
        if (Highlighter.SymbolAttribute=Attri) then
          begin
          Structure:=FStructures.NewStructure;
          Structure.FTextRect.BottomRight:=Point(j,i+1);
          Filo.Add(Structure);
          end;
        end
      else if (Lines[i][j]='{') and (Filo.Count>0) then
        begin
        GetHighlighterAttriAtRowColEx(Point(j,i+1),S,TokenType,Start,Attri);
        if (Highlighter.SymbolAttribute=Attri) then
          begin
          Structure:=TStructure(Filo[Filo.Count-1]);
          Filo.Delete(Filo.Count-1);
          //+2 since we want to terminate at the line after the opening brace
          Structure.FTextRect.TopLeft:=Point(j,i+2);
          FStructures.Add(Structure);
          end;
        end;
      dec(j);
      end;
    end;
  finally
  while Filo.Count>0 do
    begin
    FStructures.Remove(Filo[0]);
    Filo.Delete(0);
    end;
  Filo.Free;
  end;
end;

procedure TSynEditEx.Paint;
begin
  inherited;
  PaintStructure;
end;

procedure TSynEditEx.PaintTextLines(AClip: TRect; FirstLine, LastLine,
  FirstCol, LastCol: integer);
begin
  inherited;
  PaintStructure;
end;

procedure TSynEditEx.InvalidateRect(const aRect: TRect; aErase: boolean);
var i: Integer;
Rect: TRect;
Changed: Boolean;
G: TPoint;
begin
  Rect:=aRect;
  Changed:=false;
  for i:=0 to FStructures.Count-1 do
    begin
    if RectIntersects(Rect,FStructures[i].FGraphicRect) then
      begin
      G:=FStructures[i].GraphicRect.BottomRight;
      //Do this to make sure PtInRect returns correct value and avoids boundary issues
      G.Y:=G.Y-(LineHeight div 2);
      if PtInRect(Rect,G) then
        begin
        if FStructures[i].GraphicRect.Top<Rect.Top then Rect.Top:=FStructures[i].GraphicRect.Top;
        if FStructures[i].GraphicRect.Bottom>Rect.Bottom then Rect.Bottom:=FStructures[i].GraphicRect.Bottom;
        Changed:=true;
        end;
      end;
    end;
  if not Changed then inherited InvalidateRect(aRect,aErase)
  else
    Windows.InvalidateRect(Handle, @Rect, aErase);
end;

procedure TSynEditEx.SetStructureLineColor(Value: TColor);
begin
  if (Value<>FStructureLineColor) then
    begin
    FStructureLineColor:=Value;
    BuildStructure;
    Invalidate;
    end;
end;

procedure TSynEditEx.DoOnStatusChange(Changes: TSynStatusChanges);
begin
  if FStructureLineColor<>clNone then
    begin
    if (scModified in Changes) then BuildStructure;
    end;
  inherited;
end;

procedure TSynEditEx.LinesChanged(Sender: TObject);
begin
  inherited;
  BuildStructure;
end;

{ THighlightTokenInfo }

constructor THighlightTokenInfo.Create;
begin
  FAttri:=TSynHighlighterAttributes.Create('Holder');
end;

destructor THighlightTokenInfo.Destroy;
begin
  FreeAndNil(FAttri);
  inherited;
end;

procedure THighlightTokenInfo.SetAttributes(Value: TSynHighlighterAttributes);
begin
  FAttri.Assign(Value);
end;

{ TStructures }
constructor TStructures.Create(Editor: TSynEdit);
begin
  FList:=TList.Create;
  FPooled:=TList.Create;
  FEditor:=Editor;
end;

destructor TStructures.Destroy;
begin
  Clear;
  FreeAndNil(FList);
  while FPooled.Count>0 do
    begin
    TStructure(FPooled[0]).Free;
    FPooled.Delete(0);
    end;
  FreeAndNil(FPooled);
  inherited;
end;

procedure TStructures.Delete(Index: Integer);
begin
  FPooled.Add(Structure[Index]);
  FList.Delete(Index);
end;

procedure TStructures.Add(Value: TStructure);
begin
  FList.Add(Value);
end;

function TStructures.GetCount: Integer;
begin
  Result:=FList.Count;
end;

function TStructures.GetStructure(Index: Integer): TStructure;
begin
  Result:=TStructure(FList[Index]);
end;

procedure TStructures.Remove(Value: TStructure);
begin
  FList.Remove(Value);
  FPooled.Add(Value);
end;

procedure TStructures.Clear;
begin
  while FList.Count>0 do
    Delete(0);
end;

function TStructures.NewStructure: TStructure;
begin
  if FPooled.Count>0 then
    begin
    Result:=FPooled[FPooled.Count-1];
    FPooled.Delete(FPooled.Count-1);
    end
  else Result:=TStructure.Create;
end;

{$ENDIF}
end.