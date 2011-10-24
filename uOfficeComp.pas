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
 * Portions created by John Hansen are Copyright (C) 2009 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uOfficeComp;

interface

uses
  {$IFNDEF FPC}Windows, ActnList, Messages, StdCtrls, {$ENDIF}
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, Buttons, Menus;

type
{$IFDEF FPC}
  TOfficeMenuItem = class(TMenuItem)
  end;

  TOfficeSpeedButton = class(TSpeedButton)
  end;
  
  TOfficeMainMenu = class(TMainMenu)
  end;
  
  TOfficePopupMenu = class(TPopupMenu)
  end;
{$ELSE}
  TOfficeSpeedButton = class;

  TOfficeNumGlyphs = 1..4;

  TOfficeMenuItem = class(TMenuItem)
  private
  protected
    fSpeedButton: TOfficeSpeedButton;
    fResName: string;
    fNumGlyphs: TOfficeNumGlyphs;
    procedure   SetResourceName(const Value: string);
    procedure 	MenuChanged(Rebuild: Boolean); override;
    function    GetNumGlyphs: TOfficeNumGlyphs;
    procedure   SetNumGlyphs(Value: TOfficeNumGlyphs);
    procedure   OfficeDrawText(ACanvas: TCanvas; const ACaption: string;
      var Rect: TRect; Selected: Boolean; Flags: Integer); virtual;
    procedure   MeasureItem(ACanvas: TCanvas; var Width, Height: Integer); override;
    procedure   AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect;
      State: TOwnerDrawState; TopLevel: Boolean); override;
    function    IsBitmapStored : boolean;
  public
    constructor	Create(AOwner: TComponent); override;
    destructor	Destroy; override;
    procedure	Loaded; override ;
    procedure	SetSpeedButton(S: TOfficeSpeedButton);
    procedure   Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure	Click; override;
  published
    property    SpeedButton: TOfficeSpeedButton read fSpeedButton write SetSpeedButton ;
    property    ResourceName: string read fResName write SetResourceName;
    property    NumGlyphs: TOfficeNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property    Bitmap stored IsBitmapStored;
  end;

  TOfficeButtonLayout = (wblGlyphLeft, wblGlyphRight, wblGlyphTop, wblGlyphBottom);
  TOfficeButtonState = (wbsUp, wbsDisabled, wbsDown, wbsExclusive);
  TOfficeButtonStyle = (wbsAutoDetect, wbsWin31, wbsNew);

  TOfficeCustomSpeedButton = class(TGraphicControl)
  private
  protected
    FState: TOfficeButtonState;
    FGroupIndex: Integer;
    FGlyph: Pointer;
    FDown: Boolean;
    FDragging: Boolean;
    FAllowAllUp: Boolean;
    FLayout: TOfficeButtonLayout;
    FSpacing: Integer;
    FTransparent: Boolean;
    FMargin: Integer;
    FFlat: Boolean;
    FMouseInControl: Boolean;
    FUseThemes: Boolean;
    fForceDefaultLook: boolean;
    fShowCaption: boolean;
    procedure SetShowCaption(const Value: boolean);
    procedure SetForceDefaultLook(const Value: boolean);
    procedure SetUseThemes(const Value: Boolean);
    procedure GlyphChanged(Sender: TObject);
    procedure UpdateExclusive;
    function GetGlyph: TBitmap;
    procedure SetGlyph(Value: TBitmap);
    function GetNumGlyphs: TOfficeNumGlyphs;
    procedure SetNumGlyphs(Value: TOfficeNumGlyphs);
    procedure SetDown(Value: Boolean);
    procedure SetFlat(Value: Boolean);
    procedure SetAllowAllUp(Value: Boolean);
    procedure SetGroupIndex(Value: Integer);
    procedure SetLayout(Value: TOfficeButtonLayout);
    procedure SetSpacing(Value: Integer);
    procedure SetTransparent(Value: Boolean);
    procedure SetMargin(Value: Integer);
    procedure UpdateTracking;
    procedure WMLButtonDblClk(var Message: TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    function GetPalette: HPALETTE; override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure Paint; override;
    property MouseInControl: Boolean read FMouseInControl;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
  public
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Down: Boolean read FDown write SetDown default False;
    property Flat: Boolean read FFlat write SetFlat default False;
    property Glyph: TBitmap read GetGlyph write SetGlyph;
    property Layout: TOfficeButtonLayout read FLayout write SetLayout default wblGlyphLeft;
    property Margin: Integer read FMargin write SetMargin default -1;
    property NumGlyphs: TOfficeNumGlyphs read GetNumGlyphs write SetNumGlyphs default 1;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property Transparent: Boolean read FTransparent write SetTransparent default True;
    property UseThemes: Boolean read fUseThemes write SetUseThemes default True;
    property ForceDefaultLook : boolean read fForceDefaultLook write SetForceDefaultLook default true;
    property ShowCaption : boolean read fShowCaption write SetShowCaption;
  end;

{ TOfficeSpeedButtonActionLink }

  TOfficeSpeedButtonActionLink = class(TControlActionLink)
  protected
    FClient: TOfficeSpeedButton;
    procedure AssignClient(AClient: TObject); override;
    function IsCheckedLinked: Boolean; override;
    procedure SetChecked(Value: Boolean); override;
  end;

  TOfficeSpeedButtonActionLinkClass = class of TOfficeSpeedButtonActionLink;

  TOfficeSpeedButton = class(TOfficeCustomSpeedButton)
  private
  protected
    fMenuItem: TOfficeMenuItem ;
    fResName: string;
    procedure ActionChange(Sender: TObject; CheckDefaults: Boolean); override;
    procedure AssignTo(Dest: TPersistent); override;
    function GetActionLinkClass: TControlActionLinkClass; override;
    procedure SetResourceName(const Value: string);
    procedure Loaded; override ;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetMenuItem(M: TOfficeMenuItem);
    procedure CMEnabledChanged(var Msg: TMessage); message cm_EnabledChanged;
    procedure CMVisibleChanged(var Msg: TMessage); message cm_VisibleChanged;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    function  IsGlyphStored : boolean;
  public
    procedure Click; override;
  published
    property Action;
    property MenuItem: TOfficeMenuItem read fMenuItem write SetMenuItem;
    property ResourceName: string read fResName write SetResourceName;
    property Align;
    property AllowAllUp;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property GroupIndex;
    property Down;
    property Caption;
    property Enabled;
    property Flat;
    property Font;
    property ForceDefaultLook;
    property ShowCaption;
    property Glyph stored IsGlyphStored;
    property Layout;
    property Margin;
    property NumGlyphs;
    property ParentFont;
    property ParentShowHint;
    property ParentBiDiMode;
    property PopupMenu;
    property ShowHint;
    property Spacing;
    property Transparent;
    property UseThemes;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
  end;

  TOfficeMainMenu = class(TMainMenu)
  protected
    fMergedMenu : TOfficeMainMenu;
    fMergedWith : TOfficeMainMenu;
  public
    constructor Create(AOwner : TComponent); override;
    procedure OfficeMerge(Menu: TOfficeMainMenu);
    procedure OfficeUnmerge(Menu: TOfficeMainMenu);
    function  IsLastChild(aMenuItem : TOfficeMenuItem) : boolean;
    function  Width : integer;
  published
    property OwnerDraw default true;
  end;

  TOfficePopupMenu = class(TPopupMenu)
  public
    constructor Create(AOwner : TComponent); override;
  published
    property OwnerDraw default true;
  end;
{$ENDIF}

  TOfficeCustomGradientPanel = class(TCustomPanel)
{$IFNDEF FPC}
  private
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
  protected
    procedure Paint; override;
    procedure AdjustClientRect(var Rect: TRect); override;
{$ENDIF}
  protected
    FGradientFrom:        TColor;
    FGradientTo:          TColor;
    FBorderColor:         TColor;
    FHorizontal:          Boolean;
    FVertMargin:          Integer;
    FHorzMargin:          Integer;
    procedure SetGradientFrom(AValue: TColor);
    procedure SetGradientTo(AValue: TColor);
    procedure SetBorderColor(AValue: TColor);
    procedure SetHorizontal(AValue: Boolean);
    procedure SetVertMargin(AValue: Integer);
    procedure SetHorzMargin(AValue: Integer);
    property GradientFrom: TColor read FGradientFrom write SetGradientFrom;
    property GradientTo: TColor read FGradientTo write SetGradientTo;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property Horizontal: Boolean read FHorizontal write SetHorizontal default True;
    property HorzMargin: Integer read FHorzMargin write SetHorzMargin default 0;
    property VertMargin: Integer read FVertMargin write SetVertMargin default 0;
  public
    constructor Create(AOwner: TComponent); override;
    property    DockManager;
  end;

  TOfficeGradientPanel = class(TOfficeCustomGradientPanel)
  published
    property GradientFrom;
    property GradientTo;
    property BorderColor;
    property BorderWidth;
    property Horizontal;
    property HorzMargin;
    property VertMargin;
    property Align;
    property Alignment;
    property Anchors;
    property BiDiMode;
    property Caption;
    property Color;
    property Constraints;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
{$IFNDEF FPC}
    property Ctl3D;
    property ParentCtl3D;
    property Locked;
{$ENDIF}
    property ParentBiDiMode;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
{$IFNDEF FPC}
    property OnCanResize;
{$ENDIF}
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

{$IFDEF FPC}
  TOfficeToolButton = class(TSpeedButton);
  TOfficeControlBar = class(TOfficeGradientPanel);
  TOfficeToolBar = class(TToolBar);
{$ELSE}
  TOfficeToolButton = class(TToolButton)
  protected
    procedure Paint; override;
  end;

  TOfficeControlBar = class(TControlBar)
  protected
    procedure Paint; override;
    procedure PaintControlFrame(Canvas: TCanvas; AControl: TControl;
      var ARect: TRect); override;
    procedure CMParentColorChanged(var Message: TMessage); message CM_PARENTCOLORCHANGED;
    procedure AdjustClientRect(var Rect: TRect); override;
  protected
    FGradientFrom:        TColor;
    FGradientTo:          TColor;
    FBorderColor:         TColor;
    FHorizontal:          Boolean;
    FVertMargin:          Integer;
    FHorzMargin:          Integer;
    procedure SetGradientFrom(AValue: TColor);
    procedure SetGradientTo(AValue: TColor);
    procedure SetBorderColor(AValue: TColor);
    procedure SetHorizontal(AValue: Boolean);
    procedure SetVertMargin(AValue: Integer);
    procedure SetHorzMargin(AValue: Integer);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property GradientFrom: TColor read FGradientFrom write SetGradientFrom;
    property GradientTo: TColor read FGradientTo write SetGradientTo;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property Horizontal: Boolean read FHorizontal write SetHorizontal default True;
    property HorzMargin: Integer read FHorzMargin write SetHorzMargin default 0;
    property VertMargin: Integer read FVertMargin write SetVertMargin default 0;
  end;

  TOfficeToolBar = class(TToolBar)
  protected
    procedure NCPaint(DC: HDC); override;
  end;


type
  TOffice11Scheme = (schUnknown, schNormalColor, schHomestead, schMetallic);
  TOffice11SchemeColor = schNormalColor .. schMetallic;

procedure FillGradientRect(DC: HDC; const ARect: TRect; AColor1, AColor2: TColor;
  AHorizontal: Boolean);

var
  dxOffice11SelectedDownColor1: COLORREF;
  dxOffice11SelectedDownColor2: COLORREF;
  dxOffice11DownedColor: COLORREF;
  dxOffice11SelectedColor1: COLORREF;
  dxOffice11SelectedColor2: COLORREF;
  dxOffice11SelectedBorderColor: COLORREF;
  dxOffice11BarSeparatorColor1: COLORREF;
  dxOffice11TextEnabledColor: COLORREF;
  dxOffice11TextDisabledColor: COLORREF;
  dxOffice11MenuIndentColor1: COLORREF;
  dxOffice11MenuIndentColor2: COLORREF;
  dxOffice11MenuColor: COLORREF;
  dxOffice11ToolbarsColor1: COLORREF;
  dxOffice11ToolbarsColor2: COLORREF;
  dxOffice11DockColor1: COLORREF;
  dxOffice11DockColor2: COLORREF;
  dxOffice11DownedSelectedColor: COLORREF;
{$ENDIF}

{$IFDEF FPC}
procedure Register;
{$ENDIF}

implementation

{$IFNDEF FPC}
uses
  Math, Themes, UxTheme, CommCtrl, ImgList;

var Processing : Boolean = False;

var
  FOffice11Scheme: TOffice11Scheme;
  FXPStandardScheme: Boolean;
  GradientPercent : Integer;
  
function OfficeEmpty(const str : string) : boolean;
begin
  Result := Trim(str) = '';
end;

function LoadBitmapFromResource(Bmp : TBitmap; ResName: String): Boolean;
begin
  {
    this function attempts to load a bitmap with the given resource name.
    if the bitmap exists the function returns true indicating the bitmap was
    loaded, otherwise it returns false
  }
  if FindResource(HInstance,PChar(ResName),RT_BITMAP) <> 0 then begin
    Bmp.LoadFromResourceName(HInstance,ResName);
    Result := True;
  end
  else begin
    Result := False;
  end;
end;

type
  TOfficeGlyphList = class(TImageList)
  private
    Used: TBits;
    FCount: Integer;
    function AllocateIndex: Integer;
  public
    constructor CreateSize(AWidth, AHeight: Integer);
    destructor Destroy; override;
    function AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
    procedure Delete(Index: Integer);
    property Count: Integer read FCount;
  end;

  TOfficeGlyphCache = class
  private
    GlyphLists: TList;
  public
    constructor Create;
    destructor Destroy; override;
    function GetList(AWidth, AHeight: Integer): TOfficeGlyphList;
    procedure ReturnList(List: TOfficeGlyphList);
    function Empty: Boolean;
  end;

  TOfficeButtonGlyph = class
  private
    FOriginal: TBitmap;
    FGlyphList: TOfficeGlyphList;
    FIndexs: array[TOfficeButtonState] of Integer;
    FTransparentColor: TColor;
    FNumGlyphs: TOfficeNumGlyphs;
    FOnChange: TNotifyEvent;
    procedure GlyphChanged(Sender: TObject);
    procedure SetGlyph(Value: TBitmap);
    procedure SetNumGlyphs(Value: TOfficeNumGlyphs);
    procedure Invalidate;
    function CreateButtonGlyph(State: TOfficeButtonState): Integer;
    procedure DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint;
      State: TOfficeButtonState; Transparent: Boolean);
    procedure DrawButtonText(Canvas: TCanvas; const Caption: string;
      TextBounds: TRect; State: TOfficeButtonState; BiDiFlags: Longint);
    procedure CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
      const Offset: TPoint; const Caption: string; Layout: TOfficeButtonLayout;
      Margin, Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect;
      BiDiFlags: Longint; bCaption : Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    { return the text rectangle }
    function Draw(Canvas: TCanvas; const Client: TRect; const Offset: TPoint;
      const Caption: string; Layout: TOfficeButtonLayout; Margin, Spacing: Integer;
      State: TOfficeButtonState; Transparent: Boolean; BiDiFlags: Longint;
      bCaption : boolean): TRect;
    property Glyph: TBitmap read FOriginal write SetGlyph;
    property NumGlyphs: TOfficeNumGlyphs read FNumGlyphs write SetNumGlyphs;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

var
  OfficeGlyphCache: TOfficeGlyphCache = nil;
  OfficeButtonCount: Integer = 0;

{ TOfficeCustomSpeedButton }

constructor TOfficeCustomSpeedButton.Create(AOwner: TComponent);
begin
  FGlyph := TOfficeButtonGlyph.Create;
  TOfficeButtonGlyph(FGlyph).OnChange := GlyphChanged;
  inherited Create(AOwner);
  fForceDefaultLook := True;
  fShowCaption      := False;
  FUseThemes := True;
  SetBounds(0, 0, 23, 22);
  ControlStyle := [csCaptureMouse, csDoubleClicks];
  ParentFont := True;
  Color := clBtnFace;
  FSpacing := 4;
  FMargin := -1;
  FLayout := wblGlyphLeft;
  FTransparent := True;
  Inc(OfficeButtonCount);
end;

destructor TOfficeCustomSpeedButton.Destroy;
begin
  Dec(OfficeButtonCount);
  inherited Destroy;
  TOfficeButtonGlyph(FGlyph).Free;
end;

procedure TOfficeCustomSpeedButton.Paint;
const
  DownStyles: array[Boolean] of Integer = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
  FillStyles: array[Boolean] of Integer = (BF_MIDDLE, 0);
var
  PaintRect: TRect;
  DrawFlags: Integer;
  Offset: TPoint;
  Button: TThemedButton;
  ToolButton: TThemedToolBar;
  Details: TThemedElementDetails;
  g1, g2 : TColor;
//  mousePos : TPoint;

  procedure PaintUsingDefaultStyle;
  begin
    PaintRect := Rect(0, 0, Width, Height);
    if not FFlat then
    begin
      DrawFlags := DFCS_BUTTONPUSH or DFCS_ADJUSTRECT;
      if FState in [wbsDown, wbsExclusive] then
        DrawFlags := DrawFlags or DFCS_PUSHED;
      DrawFrameControl(Canvas.Handle, PaintRect, DFC_BUTTON, DrawFlags);
    end
    else
    begin
      if (FState in [wbsDown, wbsExclusive]) or
        (FMouseInControl and (FState <> wbsDisabled)) or
        (csDesigning in ComponentState) then
        DrawEdge(Canvas.Handle, PaintRect, DownStyles[FState in [wbsDown, wbsExclusive]],
          FillStyles[Transparent] or BF_RECT)
      else if not Transparent then
      begin
        Canvas.Brush.Color := Color;
        Canvas.FillRect(PaintRect);
      end;
      InflateRect(PaintRect, -1, -1);
    end;
    if FState in [wbsDown, wbsExclusive] then
    begin
      if (FState = wbsExclusive) and (not FFlat or not FMouseInControl) then
      begin
        Canvas.Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
        Canvas.FillRect(PaintRect);
      end;
      Offset.X := 1;
      Offset.Y := 1;
    end
    else
    begin
      Offset.X := 0;
      Offset.Y := 0;
    end;
  end;

  procedure PaintUsingXPThemes;
  begin
    PerformEraseBackground(Self, Canvas.Handle);

    if not Enabled then
      Button := tbPushButtonDisabled
    else
      if FState in [wbsDown, wbsExclusive] then
        Button := tbPushButtonPressed
      else
        if MouseInControl then
          Button := tbPushButtonHot
        else
          Button := tbPushButtonNormal;

    ToolButton := ttbToolbarDontCare;
    if FFlat then
    begin
      case Button of
        tbPushButtonDisabled:
          Toolbutton := ttbButtonDisabled;
        tbPushButtonPressed:
          Toolbutton := ttbButtonPressed;
        tbPushButtonHot:
          Toolbutton := ttbButtonHot;
        tbPushButtonNormal:
          Toolbutton := ttbButtonNormal;
      end;
    end;

    PaintRect := ClientRect;
    if ToolButton = ttbToolbarDontCare then
    begin
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
      PaintRect := ThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
    end
    else
    begin
      Details := ThemeServices.GetElementDetails(ToolButton);
      ThemeServices.DrawElement(Canvas.Handle, Details, PaintRect);
      PaintRect := ThemeServices.ContentRect(Canvas.Handle, Details, PaintRect);
    end;

    if Button = tbPushButtonPressed then
    begin
      // A pressed speed button has a white text. This applies however only to flat buttons.
      if ToolButton <> ttbToolbarDontCare then
        Canvas.Font.Color := clHighlightText;
      Offset := Point(1, 0);
    end
    else
      Offset := Point(0, 0);
  end;

  procedure PaintUsingOffice11Style;
  begin
    PaintRect := Rect(0, 0, Width, Height);
    if (not Processing and ((FState in [wbsDown, wbsExclusive]) or
                            (FMouseInControl and (FState <> wbsDisabled)))) or
      (csDesigning in ComponentState) then
    begin
      // draw frame around button and fill background in Office11 style
      if FState = wbsExclusive then
      begin
        if FMouseInControl then
        begin
          g1 := dxOffice11SelectedDownColor2;
          g2 := dxOffice11SelectedDownColor1;
        end
        else
        begin
          g1 := dxOffice11DownedColor;
          g2 := dxOffice11DownedColor;
        end;
      end
      else if FState = wbsDown then
      begin
        g1 := dxOffice11SelectedDownColor2;
        g2 := dxOffice11SelectedDownColor1;
      end
      else
      begin
        g1 := dxOffice11SelectedColor1;
        g2 := dxOffice11SelectedColor2;
      end;
      InflateRect(PaintRect, 0, -1);
      FillGradientRect(
                    Canvas.Handle,
                    PaintRect,
                    g1,
                    g2,
                    False);
      Canvas.Brush.Color := dxOffice11SelectedBorderColor;
      Canvas.FrameRect(PaintRect);
    end;
    Offset.X := 0;
    Offset.Y := 0;
  end;
begin
{
  GetCursorPos(mousePos);
  mousePos := ScreenToClient(mousePos);
  FMouseInControl := FMouseInControl and
    InRange(mousePos.X, 0, Width) and InRange(mousePos.Y, 0, Height);
}
  if not Enabled then
  begin
    FState := wbsDisabled;
    FDragging := False;
  end
  else if FState = wbsDisabled then
    if FDown and (GroupIndex <> 0) then
      FState := wbsExclusive
    else
      FState := wbsUp;
  Canvas.Font := Self.Font;

  if ForceDefaultLook then
  begin
    if ThemeServices.ThemesEnabled then
    begin
      // use Office11 style of painting
      PaintUsingOffice11Style;
    end
    else
      PaintUsingDefaultStyle;
  end
  else if UseThemes and ThemeServices.ThemesEnabled then
  begin
    PaintUsingXPThemes;
  end
  else
    PaintUsingDefaultStyle;
  TOfficeButtonGlyph(FGlyph).Draw(Canvas, PaintRect, Offset, Caption, FLayout, FMargin,
    FSpacing, FState, Transparent, DrawTextBiDiModeFlags(0), fShowCaption);
end;

procedure TOfficeCustomSpeedButton.UpdateTracking;
var
  P: TPoint;
begin
  if FFlat then
  begin
    if Enabled then
    begin
      GetCursorPos(P);
      FMouseInControl := not (FindDragTarget(P, True) = Self);
      if FMouseInControl then
        Perform(CM_MOUSELEAVE, 0, 0)
      else
        Perform(CM_MOUSEENTER, 0, 0);
    end;
  end;
end;

procedure TOfficeCustomSpeedButton.Loaded;
var
  State: TOfficeButtonState;
begin
  inherited Loaded;
  if Enabled then
    State := wbsUp
  else
    State := wbsDisabled;
  TOfficeButtonGlyph(FGlyph).CreateButtonGlyph(State);
end;

procedure TOfficeCustomSpeedButton.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    if not FDown then
    begin
      FState := wbsDown;
      Invalidate;
    end;
    FDragging := True;
  end;
end;

procedure TOfficeCustomSpeedButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TOfficeButtonState;
begin
  inherited MouseMove(Shift, X, Y);
  if FDragging then
  begin
    if not FDown then NewState := wbsUp
    else NewState := wbsExclusive;
    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
      if FDown then NewState := wbsExclusive else NewState := wbsDown;
    if NewState <> FState then
    begin
      FState := NewState;
      Invalidate;
    end;
  end
  else if not FMouseInControl then
    UpdateTracking;
end;

procedure TOfficeCustomSpeedButton.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  DoClick: Boolean;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    if FGroupIndex = 0 then
    begin
      { Redraw face in-case mouse is captured }
      FState := wbsUp;
      FMouseInControl := False;
      if DoClick and not (FState in [wbsExclusive, wbsDown]) then
        Invalidate;
    end
    else
      if DoClick then
      begin
        SetDown(not FDown);
        if FDown then Repaint;
      end
      else
      begin
        if FDown then FState := wbsExclusive;
        Repaint;
      end;
    if DoClick then Click;
    UpdateTracking;
  end;
end;

procedure TOfficeCustomSpeedButton.Click;
begin
  inherited Click;
end;

function TOfficeCustomSpeedButton.GetPalette: HPALETTE;
begin
  Result := Glyph.Palette;
end;

function TOfficeCustomSpeedButton.GetGlyph: TBitmap;
begin
  Result := TOfficeButtonGlyph(FGlyph).Glyph;
end;

procedure TOfficeCustomSpeedButton.SetGlyph(Value: TBitmap);
begin
  TOfficeButtonGlyph(FGlyph).Glyph := Value;
  Invalidate;
end;

function TOfficeCustomSpeedButton.GetNumGlyphs: TOfficeNumGlyphs;
begin
  Result := TOfficeButtonGlyph(FGlyph).NumGlyphs;
end;

procedure TOfficeCustomSpeedButton.SetNumGlyphs(Value: TOfficeNumGlyphs);
begin
  if Value < 0 then Value := 1
  else if Value > 4 then Value := 4;
  if Value <> TOfficeButtonGlyph(FGlyph).NumGlyphs then
  begin
    TOfficeButtonGlyph(FGlyph).NumGlyphs := Value;
    Invalidate;
  end;
end;

procedure TOfficeCustomSpeedButton.GlyphChanged(Sender: TObject);
begin
  Invalidate;
end;

procedure TOfficeCustomSpeedButton.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;
end;

procedure TOfficeCustomSpeedButton.SetDown(Value: Boolean);
begin
  if FGroupIndex = 0 then Value := False;
  if Value <> FDown then
  begin
    if FDown and (not FAllowAllUp) then Exit;
    FDown := Value;
    if Value then
    begin
      if FState = wbsUp then Invalidate;
      FState := wbsExclusive
    end
    else
    begin
      FState := wbsUp;
      Repaint;
    end;
    if Value then UpdateExclusive;
  end;
end;

procedure TOfficeCustomSpeedButton.SetFlat(Value: Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TOfficeCustomSpeedButton.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TOfficeCustomSpeedButton.SetLayout(Value: TOfficeButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TOfficeCustomSpeedButton.SetMargin(Value: Integer);
begin
  if (Value <> FMargin) and (Value >= -1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TOfficeCustomSpeedButton.SetSpacing(Value: Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TOfficeCustomSpeedButton.SetTransparent(Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    if Value then
      ControlStyle := ControlStyle - [csOpaque] else
      ControlStyle := ControlStyle + [csOpaque];
    Invalidate;
  end;
end;

procedure TOfficeCustomSpeedButton.SetAllowAllUp(Value: Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TOfficeCustomSpeedButton.WMLButtonDblClk(var Message: TWMLButtonDown);
begin
  inherited;
  if FDown then DblClick;
end;

procedure TOfficeCustomSpeedButton.CMEnabledChanged(var Message: TMessage);
const
  NewState: array[Boolean] of TOfficeButtonState = (wbsDisabled, wbsUp);
begin
  TOfficeButtonGlyph(FGlyph).CreateButtonGlyph(NewState[Enabled]);
  UpdateTracking;
  Repaint;
end;

procedure TOfficeCustomSpeedButton.CMButtonPressed(var Message: TMessage);
var
  Sender: TOfficeCustomSpeedButton;
begin
  if Message.WParam = FGroupIndex then
  begin
    Sender := TOfficeCustomSpeedButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
        FState := wbsUp;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;

procedure TOfficeCustomSpeedButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Enabled and Visible and
      (Parent <> nil) and Parent.Showing then
    begin
      Click;
      Result := 1;
    end else
      inherited;
end;

procedure TOfficeCustomSpeedButton.CMFontChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TOfficeCustomSpeedButton.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TOfficeCustomSpeedButton.CMSysColorChange(var Message: TMessage);
begin
  with TOfficeButtonGlyph(FGlyph) do
  begin
    Invalidate;
    CreateButtonGlyph(FState);
  end;
end;

procedure TOfficeCustomSpeedButton.CMMouseEnter(var Message: TMessage);
var
  NeedRepaint: Boolean;
begin
  inherited;
  { Don't draw a border if DragMode <> dmAutomatic since this button is meant to
    be used as a dock client. }
  NeedRepaint := FFlat and not FMouseInControl and Enabled and (DragMode <> dmAutomatic) and (GetCapture = 0);

  { Windows XP introduced hot states also for non-flat buttons. }
  if (NeedRepaint or ThemeServices.ThemesEnabled) and not (csDesigning in ComponentState) then
  begin
    FMouseInControl := True;
    if Enabled then
      Repaint;
  end;
end;

procedure TOfficeCustomSpeedButton.CMMouseLeave(var Message: TMessage);
var
  NeedRepaint: Boolean;
begin
  inherited;
  NeedRepaint := FFlat and FMouseInControl and Enabled and not FDragging;
  { Windows XP introduced hot states also for non-flat buttons. }
  if NeedRepaint or ThemeServices.ThemesEnabled then
  begin
    FMouseInControl := False;
    if Enabled then
      Repaint;
  end;
end;

procedure TOfficeCustomSpeedButton.SetUseThemes(const Value: Boolean);
begin
  if Value <> fUseThemes then
  begin
    fUseThemes := Value;
    Invalidate;
  end;
end;

procedure TOfficeCustomSpeedButton.SetForceDefaultLook(const Value: boolean);
begin
  if Value <> fForceDefaultLook then
  begin
    fForceDefaultLook := Value;
    Invalidate;
  end;
end;

procedure TOfficeCustomSpeedButton.SetShowCaption(const Value: boolean);
begin
  fShowCaption := Value;
  Invalidate;
end;

{ TOfficeSpeedButton }

procedure TOfficeSpeedButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
end;

procedure TOfficeSpeedButton.Loaded ;
begin
  inherited ;
end ;

procedure TOfficeSpeedButton.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  { if the speedbutton has an associated menu item, and this menu item is
  being removed, then set the menu item to nil to avoid access violation}

  if (AComponent is TOfficeMenuItem) and (AComponent = MenuItem) and
  	(Operation = opRemove) then
  	fMenuItem := nil ;
end ;

procedure TOfficeSpeedButton.Click ;
var
  mi : TOfficeMenuItem;
begin
  if Processing then Exit;
  Processing := True;
  try
  	inherited;

    mi := MenuItem;
  	if not Assigned(OnClick) then
    begin
      if Assigned(mi) then
      begin
        if Assigned(mi.OnClick) then
          mi.OnClick(mi);
      end;
    end;
  finally
    Processing := False;
  end;
end ;

procedure TOfficeSpeedButton.SetMenuItem(M: TOfficeMenuItem);
begin
	fMenuItem := M ;
  if MenuItem <> nil then
    if MenuItem.SpeedButton <> Self then
    	MenuItem.SpeedButton := Self ;
    Hint := MenuItem.Hint;
end;

procedure TOfficeSpeedButton.CMEnabledChanged(var Msg: TMessage);
begin
	inherited;
  if (MenuItem <> nil) and (MenuItem.Enabled <> Self.Enabled) then
  	MenuItem.Enabled := Self.Enabled ;
end;

procedure TOfficeSpeedButton.CMVisibleChanged(var Msg: TMessage);
begin
	inherited;
  if (MenuItem <> nil) and (MenuItem.Visible <> Self.Visible) then
  	MenuItem.Visible := Self.Visible ;
end;

procedure TOfficeSpeedButton.SetResourceName(const Value: string);
begin
  if Value <> fResName then
  begin
    fResName := Value;
    LoadBitmapFromResource(Glyph, Value);
  end;
end;

function TOfficeSpeedButton.IsGlyphStored: boolean;
begin
  Result := OfficeEmpty(ResourceName);
end;

procedure TOfficeSpeedButton.ActionChange(Sender: TObject;
  CheckDefaults: Boolean);
begin
  inherited ActionChange(Sender, CheckDefaults);
  if Sender is TCustomAction then
    with TCustomAction(Sender) do
    begin
      if not CheckDefaults or not Self.Down then
        Self.Down := Checked;
    end;
end;

procedure TOfficeSpeedButton.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
  if Dest is TCustomAction then
    with TCustomAction(Dest) do
    begin
      Checked := Self.Down;
    end;
end;

function TOfficeSpeedButton.GetActionLinkClass: TControlActionLinkClass;
begin
  Result := TOfficeSpeedButtonActionLink;
end;

{ TOfficeMenuItem }

constructor	TOfficeMenuItem.Create(AOwner: TComponent);
begin
	inherited;
  fNumGlyphs := 1;
end;

destructor	TOfficeMenuItem.Destroy;
begin
  inherited;
end;

procedure 	TOfficeMenuItem.Loaded ;
begin
  inherited ;
end ;

procedure TOfficeMenuItem.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  { if the speedbutton has an associated menu item, and this menu item is
  being removed, then set the menu item to nil to avoid access violation}

  if (AComponent is TOfficeSpeedButton) and (AComponent = SpeedButton) and
  	(Operation = opRemove) then
  	fSpeedButton := nil ;
end ;

procedure		TOfficeMenuItem.SetSpeedButton(S: TOfficeSpeedButton);
begin
	fSpeedButton := S;
  if SpeedButton <> nil then
    if SpeedButton.MenuItem <> Self then
    	SpeedButton.MenuItem := Self ;
end;

procedure 	TOfficeMenuItem.MenuChanged(Rebuild: Boolean);
begin
	inherited MenuChanged(Rebuild);
  if (SpeedButton <> nil) and (SpeedButton.Enabled <> Self.Enabled) then
  	SpeedButton.Enabled := Self.Enabled ;
  if (SpeedButton <> nil) and (SpeedButton.Visible <> Self.Visible) then
  	SpeedButton.Visible := Self.Visible ;
end;

procedure TOfficeMenuItem.Click ;
var
  sb : TOfficeSpeedButton;
begin
  inherited;

  sb := SpeedButton;
  if not Assigned(OnClick) then
  begin
    if Assigned(sb) then
    begin
      if Assigned(sb.OnClick) then
      begin
        sb.OnClick(sb);
      end;
    end;
  end;
end ;

procedure TOfficeMenuItem.SetResourceName(const Value: string);
begin
  if Value <> fResName then
  begin
    fResName := Value;
    LoadBitmapFromResource(Bitmap, Value);
  end;
end;

function TOfficeMenuItem.GetNumGlyphs: TOfficeNumGlyphs;
begin
  Result := fNumGlyphs;
end;

procedure TOfficeMenuItem.SetNumGlyphs(Value: TOfficeNumGlyphs);
begin
  if Value < 0 then Value := 1
  else if Value > 4 then Value := 4;
  if Value <> fNumGlyphs then
    fNumGlyphs := Value;
end;

procedure TOfficeMenuItem.OfficeDrawText(ACanvas: TCanvas; const ACaption: string;
  var Rect: TRect; Selected: Boolean; Flags: Longint);
var
  Text: string;
  R: TRect;
  ParentMenu: TMenu;
begin
  ParentMenu := GetParentMenu;
  if (ParentMenu <> nil) and (ParentMenu.IsRightToLeft) then
  begin
    if Flags and DT_LEFT = DT_LEFT then
      Flags := Flags and (not DT_LEFT) or DT_RIGHT
    else if Flags and DT_RIGHT = DT_RIGHT then
      Flags := Flags and (not DT_RIGHT) or DT_LEFT;
    Flags := Flags or DT_RTLREADING;
  end;
  Text := ACaption;
  if (Flags and DT_CALCRECT <> 0) and ((Text = '') or
    (Text[1] = cHotkeyPrefix) and (Text[2] = #0)) then Text := Text + ' ';
  with ACanvas do
  begin
    if Text = cLineCaption then
    begin
      if Flags and DT_CALCRECT = 0 then
      begin
        R := Rect;
        Inc(R.Top, 4);
        if ThemeServices.ThemesEnabled then
        begin
          Pen.Color := dxOffice11BarSeparatorColor1;
          MoveTo(R.Left, R.Top);
          LineTo(R.Right, R.Top);
        end
        else
          DrawEdge(Handle, R, EDGE_ETCHED, BF_TOP);
      end
      else
      begin
        DrawText(Handle, PChar(Text), Length(Text), Rect, Flags);
      end;
    end
    else
    begin
      Brush.Style := bsClear;
      if Default then
        Font.Style := Font.Style + [fsBold];
      if not Enabled then
      begin
        if Selected and (ColorToRGB(clHighlight) = ColorToRGB(clBtnShadow)) then
          Font.Color := clBtnHighlight else
          Font.Color := clBtnShadow;
      end
      else
        Font.Color := dxOffice11TextEnabledColor;
      DrawText(Handle, PChar(Text), Length(Text), Rect, Flags);
    end;
  end;
end;

const
  SEP_INDENT = 22;
  BMP_WIDTH = 16;
  EXTRA_WIDTH = 31;

procedure TOfficeMenuItem.MeasureItem(ACanvas: TCanvas; var Width,
  Height: Integer);
var
  Menu : TMenu;
begin
  inherited;
  if not Assigned(OnMeasureItem) then
  begin
    Menu := GetParentMenu;
    if (Menu.Images = nil) and ((Parent.Parent <> nil) or (Menu is TPopupMenu)) then
    begin
      Width := Width + EXTRA_WIDTH;
    end;
  end;
end;

procedure FillGradientRect(DC: HDC; const ARect: TRect; AColor1, AColor2: TColor;
  AHorizontal: Boolean);
var
  FromR, ToR, FromG, ToG, FromB, ToB: Byte;
  SR: TRect;
  W, I, N: Integer;
  R, G, B: Byte;
  ABrush: HBRUSH;
begin
  AColor1 := ColorToRGB(AColor1);
  AColor2 := ColorToRGB(AColor2);
  if AColor1 = AColor2 then
  begin
    ABrush := CreateSolidBrush(AColor1);
    FillRect(DC, ARect, ABrush);
    DeleteObject(ABrush);
    Exit;
  end;
  FromR := GetRValue(AColor1);
  FromG := GetGValue(AColor1);
  FromB := GetBValue(AColor1);
  ToR := GetRValue(AColor2);
  ToG := GetGValue(AColor2);
  ToB := GetBValue(AColor2);
  SR := ARect;
  if AHorizontal then
    W := SR.Right - SR.Left
  else
    W := SR.Bottom - SR.Top;
  N := 256;
  if W < N then
    N := W;
  for I := 0 to N - 1 do
  begin
    if AHorizontal then
      SR.Right := ARect.Left + MulDiv(I + 1, W, N)
    else
      SR.Bottom := ARect.Top + MulDiv(I + 1, W, N);
    R := FromR + MulDiv(I, ToR - FromR, N - 1);
    G := FromG + MulDiv(I, ToG - FromG, N - 1);
    B := FromB + MulDiv(I, ToB - FromB, N - 1);
    if not IsRectEmpty(SR) then
    begin
      ABrush := CreateSolidBrush(RGB(R, G, B));
      FillRect(DC, SR, ABrush);
      DeleteObject(ABrush);
    end;
    if AHorizontal then
    begin
      SR.Left := SR.Right;
      if SR.Left >= ARect.Right then
        Break;
    end
    else
    begin
      SR.Top := SR.Bottom;
      if SR.Top >= ARect.Bottom then
        Break;
    end;
  end;
end;

procedure TOfficeMenuItem.AdvancedDrawItem(ACanvas: TCanvas; ARect: TRect;
  State: TOwnerDrawState; TopLevel: Boolean);
const
  Alignments: array[TPopupAlignment] of Word = (DT_LEFT, DT_RIGHT, DT_CENTER);
  EdgeStyle: array[Boolean] of Longint = (BDR_RAISEDINNER, BDR_SUNKENOUTER);
var
  ImageList: TCustomImageList;
  ParentMenu: TMenu;
  Alignment: TPopupAlignment;
  DrawImage, DrawGlyph: Boolean;
  GlyphRect, SaveRect, RectFrame: TRect;
  DrawStyle: Longint;
  Glyph, TmpBmp: TBitmap;
  OldBrushColor: TColor;
  Selected: Boolean;
  Win98Plus: Boolean;
  Win2K: Boolean;
  WinXP: Boolean;

  procedure DoFillRect;
  var
    g1, g2 : TColor;
    right : integer;
  begin
    with ACanvas do
    begin
      if not TopLevel and not Selected then
      begin
        SaveRect := ARect;
        ARect.Right := ARect.Left+BMP_WIDTH+2;
        FillGradientRect(
          ACanvas.Handle,
          ARect,
          dxOffice11MenuIndentColor1,
          dxOffice11MenuIndentColor2,
          True);
        // now do the rest of the background
        ARect := SaveRect;
        ARect.Left := ARect.Left+BMP_WIDTH+2;
        if ThemeServices.ThemesEnabled then
          Brush.Color := dxOffice11MenuColor;
        FillRect(ARect);
        ARect := SaveRect;
      end
      else if not TopLevel then
      begin
        // selected but not toplevel
        Brush.Color := dxOffice11SelectedColor1;
        FillRect(ARect);
      end
      else
      begin
        // top level menu items
        if Selected or (odHotLight in State) then
        begin
          // begin selected or hotlight state
          if Selected then
          begin
            g1 := dxOffice11ToolbarsColor1;
            g2 := dxOffice11ToolbarsColor2;
          end
          else
          begin
            g1 := dxOffice11SelectedColor1;
            g2 := dxOffice11SelectedColor2;
          end;
          InflateRect(ARect, -1, -1);
          FillGradientRect(
            ACanvas.Handle,
            ARect,
            g1,
            g2,
            False);
          if not Selected then
          begin
            Brush.Color := dxOffice11SelectedBorderColor;
            FrameRect(ARect);
          end
          else
          begin
            ARect.Right := ARect.Right - 1;
            Pen.Color := dxOffice11SelectedBorderColor;
            MoveTo(ARect.Left, ARect.Bottom);
            LineTo(ARect.Left, ARect.Top);
            LineTo(ARect.Right, ARect.Top);
            LineTo(ARect.Right, ARect.Bottom);
          end;
          // end selected or hot light state
        end
        else
        begin
          if ThemeServices.ThemesEnabled then
            Brush.Color := dxOffice11DockColor1
          else
            Brush.Color := clBtnFace;
          FillRect(ARect);
        end;
        if (ParentMenu is TOfficeMainMenu) and
           TOfficeMainMenu(ParentMenu).IsLastChild(Self) then
        begin
          if Selected or (odHotLight in State) then
            right := ARect.Right + 1
          else
            right := ARect.Right;
          if ThemeServices.ThemesEnabled then
          begin
            // if we are the last menu item on the menu bar
            FillGradientRect(
              ACanvas.Handle,
              Rect(right, ARect.Top, TOfficeMainMenu(ParentMenu).Width, ARect.Bottom),
              dxOffice11DockColor1,
              dxOffice11DockColor2,
              True);
          end;
        end;
        // end TopLevel menu items
      end;
    end;
  end;

  function BitmapWidth : integer;
  begin
    Result := 0;
    if Assigned(Bitmap) then
      Result := Bitmap.Width div NumGlyphs;
  end;

  function CalculatedSourceRect : TRect;
  begin
    Result := Rect(0, 0, 0, 0);
    if Assigned(Bitmap) then
    begin
      Result.Right  := BitmapWidth;
      Result.Bottom := Bitmap.Height;
      if (NumGlyphs > 1) and not Enabled then
        OffsetRect(Result, BitmapWidth, 0)
      else if (NumGlyphs > 2) and Selected then
        OffsetRect(Result, BitmapWidth*2, 0)
      else if (NumGlyphs > 3) and Checked then
        OffsetRect(Result, BitmapWidth*3, 0);
    end;
  end;

  procedure NormalDraw;
  var TmpRect : TRect;
  begin
    with ACanvas do
    begin
      // always fill the rect to get toplevel menus drawing correctly on W2K
      DoFillRect;
      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;
      GlyphRect.Left := ARect.Left + 1;
      GlyphRect.Top := ARect.Top + 1;
      if Caption = cLineCaption then
      begin
        DoFillRect;
        GlyphRect.Right := GlyphRect.Left - 4;
        DrawGlyph := False;
      end
      else
      begin
        DrawImage := (ImageList <> nil) and ((ImageIndex > -1) and
          (ImageIndex < ImageList.Count) or Checked and ((Bitmap = nil) or
          Bitmap.Empty));
        if DrawImage or Checked or (Assigned(Bitmap) and not Bitmap.Empty) then
        begin
          DrawGlyph := True;

          if DrawImage then
          begin
            GlyphRect.Right := GlyphRect.Left + ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            { Need to add BitmapWidth/Height properties for TMenuItem if we're to
              support them.  Right now let's hardcode them to 16x16. }
            GlyphRect.Right := GlyphRect.Left + BMP_WIDTH;
            GlyphRect.Bottom := GlyphRect.Top + BMP_WIDTH;
          end;

          { Draw background pattern brush if selected }
          if Checked and not WinXP then
          begin
            Inc(GlyphRect.Right);
            Inc(GlyphRect.Bottom);
            OldBrushColor := Brush.Color;
            if not (odSelected in State) then
            begin
              OldBrushColor := Brush.Color;
              Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
              FillRect(GlyphRect);
            end
            else
            begin
              Brush.Color := clBtnFace;
              FillRect(GlyphRect);
            end;
            Brush.Color := OldBrushColor;
            Inc(GlyphRect.Left);
            Inc(GlyphRect.Top);
          end;

          if not Assigned(Bitmap) or (Assigned(Bitmap) and Bitmap.Empty) then
          begin
            if (ImageIndex > -1) and (ImageIndex < ImageList.Count) then
              ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top, ImageIndex,
                Enabled)
            else
            begin
              // draw an orange box with a black frame behind the check image
              if Enabled then
              begin
                if Selected then
                  Brush.Color := dxOffice11DownedSelectedColor
                else
                  Brush.Color := dxOffice11DownedColor;
              end
              else
                Brush.Color := dxOffice11MenuIndentColor2;
              SaveRect := GlyphRect;
              GlyphRect.Bottom := GlyphRect.Bottom + 1;
              FillRect(GlyphRect);
              if Enabled then
                Brush.Color := dxOffice11SelectedBorderColor
              else
                Brush.Color := dxOffice11TextDisabledColor;
              // the frame around checkboxes on W2K is not sized well so adjust it
              if not WinXP then
              begin
                dec(GlyphRect.Left);
                dec(GlyphRect.Top);
                GlyphRect.Bottom := GlyphRect.Bottom - 1;
              end;
              FrameRect(GlyphRect);
              GlyphRect := SaveRect;
              { Draw a menu check }
              Glyph := TBitmap.Create;
              try
                Glyph.Transparent := True;
                Glyph.Handle := Windows.LoadBitmap(0, PChar(OBM_CHECK));
                OldBrushColor := Font.Color;
                if Enabled then
                  Font.Color := dxOffice11TextEnabledColor
                else
                  Font.Color := dxOffice11TextDisabledColor;
                Draw(GlyphRect.Left + (GlyphRect.Right - GlyphRect.Left - Glyph.Width) div 2 + 1,
                  GlyphRect.Top + (GlyphRect.Bottom - GlyphRect.Top - Glyph.Height) div 2 + 1, Glyph);
                Font.Color := OldBrushColor;
              finally
                Glyph.Free;
              end;
            end;
          end
          else
          begin
            SaveRect := GlyphRect;
            { Make sure image is within glyph bounds }
            if BitmapWidth < GlyphRect.Right - GlyphRect.Left then
              with GlyphRect do
              begin
                Left := Left + ((Right - Left) - BitmapWidth) div 2 + 1;
                Right := Left + BitmapWidth;
              end;
            if Bitmap.Height < GlyphRect.Bottom - GlyphRect.Top then
              with GlyphRect do
              begin
                Top := Top + ((Bottom - Top) - Bitmap.Height) div 2 + 1;
                Bottom := Top + Bitmap.Height;
              end;
            TmpBmp := TBitmap.Create;
            try
              TmpBmp.Transparent := True;
              TmpBmp.Height := Bitmap.Height;
              TmpBmp.Width  := BitmapWidth;
              // draw from Bitmap to TmpBmp based on the enabled and
              // checked state of the menu item
              TmpBmp.Canvas.CopyRect(Rect(0, 0, TmpBmp.Height, TmpBmp.Width),
                Bitmap.Canvas, CalculatedSourceRect);
              // now draw the temporary bitmap on the menu canvas


              if Checked then begin
                if Enabled then
                begin
                  if Selected then
                    Brush.Color := dxOffice11DownedSelectedColor
                  else
                    Brush.Color := dxOffice11DownedColor;
                end
                else
                  Brush.Color := dxOffice11MenuIndentColor2;
                TmpRect := GlyphRect;
                GlyphRect.Top := GlyphRect.Top - 1;
                GlyphRect.Bottom := GlyphRect.Bottom + 1;
                GlyphRect.Left := GlyphRect.Left - 1;
                GlyphRect.Right := GlyphRect.Right + 1;
                FillRect(GlyphRect);
                if Enabled then
                  Brush.Color := dxOffice11SelectedBorderColor
                else
                  Brush.Color := dxOffice11TextDisabledColor;
                FrameRect(GlyphRect);

                GlyphRect := TmpRect;
              end;
              StretchDraw(GlyphRect, TmpBmp);
            finally
              FreeAndNil(TmpBmp);
            end;
            GlyphRect := SaveRect;
          end;

          if Checked then
          begin
            Dec(GlyphRect.Right);
            Dec(GlyphRect.Bottom);
          end;
        end
        else
        begin
          if TopLevel then
          begin
            GlyphRect.Right := GlyphRect.Left;
            GlyphRect.Bottom := GlyphRect.Top;
          end
          else if (ImageList <> nil) then
          begin
            GlyphRect.Right := GlyphRect.Left + ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            GlyphRect.Right := GlyphRect.Left + BMP_WIDTH;
            GlyphRect.Bottom := GlyphRect.Top + BMP_WIDTH;
          end;
          DrawGlyph := False;
        end;
      end;

      with GlyphRect do
      begin
        Dec(Left);
        Dec(Top);
        Inc(Right, 2);
        Inc(Bottom, 2);
      end;

      // grab the entire menu item rectangle for later framing
      RectFrame := ARect;

      if Selected then
      begin
        if DrawGlyph then ARect.Left := GlyphRect.Right + 1;
        if not (Win98Plus and TopLevel) then
          Brush.Color := dxOffice11SelectedColor1;
        if not TopLevel then
          FillRect(ARect);
      end;

      if not (Selected and DrawGlyph) then
        ARect.Left := GlyphRect.Right + 1;

      Inc(ARect.Left, 2);
      Dec(ARect.Right, 1);

      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
      if Win2K and (odNoAccel in State) then
        DrawStyle := DrawStyle or DT_HIDEPREFIX;
      { Calculate vertical layout }
      SaveRect := ARect;
      if odDefault in State then
        Font.Style := [fsBold];
      OfficeDrawText(ACanvas, Caption, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
      OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);

      // indent the separator lines like in XP
      if Caption = cLineCaption then
      begin
        // first restore original right
        ARect.Right := SaveRect.Right;
        OffsetRect(ARect, SEP_INDENT, 0);
        ARect.Right := ARect.Right - SEP_INDENT;
      end;

      OfficeDrawText(ACanvas, Caption, ARect, Selected, DrawStyle);
      if (ShortCut <> 0) and not TopLevel then
      begin
        ARect.Left := ARect.Right;
        ARect.Right := SaveRect.Right - 10;
        OfficeDrawText(ACanvas, ShortCutToText(ShortCut), ARect, Selected, DT_RIGHT);
      end;
      if Selected and not TopLevel then
      begin
        Brush.Color := dxOffice11SelectedBorderColor;
        FrameRect(RectFrame);
      end;
    end;
  end;

  procedure BiDiDraw;
  var
    S: string;
  begin
    with ACanvas do
    begin
      if WinXP then
      begin
        if (odSelected in State) or (odHotLight in State) then
        begin
          if ThemeServices.ThemesEnabled then
            Brush.Color := clMenuHighlight
          else
            Brush.Color := clHighlight;
          Font.Color := clHighlightText;
        end
        else if TopLevel then
          Brush.Color := clMenuBar
      end;
      //ImageList := GetImageList;
      { With XP, we need to always fill in the rect, even when selected }
      if not Selected or (WinXP and not Checked) then
        FillRect(ARect);
      if ParentMenu is TMenu then
        Alignment := paLeft
      else if ParentMenu is TPopupMenu then
        Alignment := TPopupMenu(ParentMenu).Alignment
      else
        Alignment := paLeft;
      GlyphRect.Right := ARect.Right - 1;
      GlyphRect.Top := ARect.Top + 1;
      if Caption = cLineCaption then
      begin
        FillRect(ARect);
        GlyphRect.Left := GlyphRect.Right + 2;
        GlyphRect.Right := 0;
        DrawGlyph := False;
      end
      else
      begin
        DrawImage := (ImageList <> nil) and ((ImageIndex > -1) and
          (ImageIndex < ImageList.    Count) or Checked and ((Bitmap = nil) or
          Bitmap.Empty));
        if DrawImage or Assigned(Bitmap) and not Bitmap.Empty then
        begin
          DrawGlyph := True;

          if DrawImage then
          begin
            GlyphRect.Left := GlyphRect.Right - ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            { Need to add BitmapWidth/Height properties for TMenuItem if we're to
              support them.  Right now let's hardcode them to 16x16. }
            GlyphRect.Left := GlyphRect.Right - BMP_WIDTH;
            GlyphRect.Bottom := GlyphRect.Top + BMP_WIDTH;
          end;

          { Draw background pattern brush if selected }
          if Checked then
          begin
            Dec(GlyphRect.Left);
            Inc(GlyphRect.Bottom);
            OldBrushColor := Brush.Color;
            if not (odSelected in State) then
            begin
              OldBrushColor := Brush.Color;
              Brush.Bitmap := AllocPatternBitmap(clBtnFace, clBtnHighlight);
              FillRect(GlyphRect);
            end
            else
            begin
              Brush.Color := clBtnFace;
              FillRect(GlyphRect);
            end;
            Brush.Color := OldBrushColor;
            Dec(GlyphRect.Right);
            Inc(GlyphRect.Top);
          end;

          if DrawImage then
          begin
            if (ImageIndex > -1) and (ImageIndex < ImageList.Count) then
              ImageList.Draw(ACanvas, GlyphRect.Left, GlyphRect.Top, ImageIndex,
                Enabled)
            else
            begin
              { Draw a menu check }
              Glyph := TBitmap.Create;
              try
                Glyph.Transparent := True;
                Glyph.Handle := LoadBitmap(0, PChar(OBM_CHECK));
                OldBrushColor := Font.Color;
                Font.Color := dxOffice11TextEnabledColor;
                Draw(GlyphRect.Left + (GlyphRect.Right - GlyphRect.Left - Glyph.Width) div 2 + 1,
                  GlyphRect.Top + (GlyphRect.Bottom - GlyphRect.Top - Glyph.Height) div 2 + 1, Glyph);
                Font.Color := OldBrushColor;
              finally
                Glyph.Free;
              end;
            end;
          end
          else
          begin
            SaveRect := GlyphRect;
            { Make sure image is within glyph bounds }
            if BitmapWidth < GlyphRect.Right - GlyphRect.Left then
              with GlyphRect do
              begin
                Right := Right - ((Right - Left) - BitmapWidth) div 2 + 1;
                Left := Right - BitmapWidth;
              end;
            if Bitmap.Height < GlyphRect.Bottom - GlyphRect.Top then
              with GlyphRect do
              begin
                Top := Top + ((Bottom - Top) - Bitmap.Height) div 2 + 1;
                Bottom := Top + Bitmap.Height;
              end;
            TmpBmp := TBitmap.Create;
            try
              TmpBmp.Transparent := True;
              TmpBmp.Height := Bitmap.Height;
              TmpBmp.Width  := Bitmap.Height; // force it to be square
              // draw from Bitmap to TmpBmp based on the enabled and
              // checked state of the menu item
              TmpBmp.Canvas.CopyRect(Rect(0, 0, TmpBmp.Height, TmpBmp.Width),
                Bitmap.Canvas, Rect(0, 0, TmpBmp.Height, TmpBmp.Width));
              // now draw the temporary bitmap on the menu canvas
              StretchDraw(GlyphRect, TmpBmp);
            finally
              FreeAndNil(TmpBmp);
            end;
            GlyphRect := SaveRect;
          end;

          if Checked then
          begin
            Dec(GlyphRect.Right);
            Dec(GlyphRect.Bottom);
          end;
        end
        else
        begin
          if TopLevel then
          begin
            GlyphRect.Left := GlyphRect.Right;
            GlyphRect.Bottom := GlyphRect.Top;
          end
          else if (ImageList <> nil) then
          begin
            GlyphRect.Left := GlyphRect.Right - ImageList.Width;
            GlyphRect.Bottom := GlyphRect.Top + ImageList.Height;
          end
          else
          begin
            GlyphRect.Left := GlyphRect.Right - BMP_WIDTH;
            GlyphRect.Bottom := GlyphRect.Top + BMP_WIDTH;
          end;
          DrawGlyph := False;
        end;
      end;

      with GlyphRect do
      begin
        Dec(Left);
        Dec(Top);
        Inc(Right, 2);
        Inc(Bottom, 2);
      end;

      if Checked or Selected and DrawGlyph and not WinXP then
        DrawEdge(Handle, GlyphRect, EdgeStyle[Checked], BF_RECT);

      if Selected then
      begin
        if DrawGlyph then ARect.Right := GlyphRect.Left - 1;
        if not (Win98Plus and TopLevel) then
          Brush.Color := clHighlight;
        FillRect(ARect);
      end;

      if not (Selected and DrawGlyph) then
        ARect.Right := GlyphRect.Left - 1;
      Inc(ARect.Left, 2);
      Dec(ARect.Right, 1);
      DrawStyle := DT_EXPANDTABS or DT_SINGLELINE or Alignments[Alignment];
      if Win2K and (odNoAccel in State) then
        DrawStyle := DrawStyle or DT_HIDEPREFIX;
      { Calculate vertical layout }
      SaveRect := ARect;
      if odDefault in State then
        Font.Style := [fsBold];
      OfficeDrawText(ACanvas, Caption, ARect, Selected, DrawStyle or DT_CALCRECT or DT_NOCLIP);
      { the DT_CALCRECT does not take into account alignment }
      ARect.Left := SaveRect.Left;
      ARect.Right := SaveRect.Right;
      OffsetRect(ARect, 0, ((SaveRect.Bottom - SaveRect.Top) - (ARect.Bottom - ARect.Top)) div 2);
      if TopLevel and Selected and Win98Plus then
        OffsetRect(ARect, 1, 0);
      OfficeDrawText(ACanvas, Caption, ARect, Selected, DrawStyle);
      if (ShortCut <> 0) and not TopLevel then
      begin
        S := ShortCutToText(ShortCut);
        ARect.Left := 10;
        ARect.Right := ARect.Left + ACanvas.TextWidth(S);
        OfficeDrawText(ACanvas, S, ARect, Selected, DT_RIGHT);
      end;
    end;
  end;

begin
  if Assigned(SpeedButton) and not (csDesigning in ComponentState) then
  begin
    Bitmap.Assign(SpeedButton.Glyph);
    NumGlyphs := SpeedButton.NumGlyphs;
  end;
  ParentMenu := GetParentMenu;
  ImageList := GetImageList;
  Selected := odSelected in State;
  Win98Plus := (Win32MajorVersion > 4) or
    ((Win32MajorVersion = 4) and (Win32MinorVersion > 0));
  Win2K := (Win32MajorVersion > 4) and (Win32Platform = VER_PLATFORM_WIN32_NT);
  WinXP := (Win32MajorVersion >= 5) and (Win32MinorVersion >= 1);
  if (ParentMenu <> nil) and (ParentMenu.OwnerDraw or (ImageList <> nil)) and
    (Assigned(OnAdvancedDrawItem) or Assigned(OnDrawItem)) then
  begin
    DrawItem(ACanvas, ARect, Selected);
    if Assigned(OnAdvancedDrawItem) then
      OnAdvancedDrawItem(Self, ACanvas, ARect, State);
  end else
    if (ParentMenu <> nil) and (not ParentMenu.IsRightToLeft) then
      NormalDraw
    else
      BiDiDraw;
end;

function TOfficeMenuItem.IsBitmapStored: boolean;
begin
  Result := OfficeEmpty(ResourceName);
end;

{ TOfficeGlyphList }

constructor TOfficeGlyphList.CreateSize(AWidth, AHeight: Integer);
begin
  inherited CreateSize(AWidth, AHeight);
  Used := TBits.Create;
end;

destructor TOfficeGlyphList.Destroy;
begin
  Used.Free;
  inherited Destroy;
end;

function TOfficeGlyphList.AllocateIndex: Integer;
begin
  Result := Used.OpenBit;
  if Result >= Used.Size then
  begin
    Result := inherited Add(nil, nil);
    Used.Size := Result + 1;
  end;
  Used[Result] := True;
end;

function TOfficeGlyphList.AddMasked(Image: TBitmap; MaskColor: TColor): Integer;
begin
  Result := AllocateIndex;
  ReplaceMasked(Result, Image, MaskColor);
  Inc(FCount);
end;

procedure TOfficeGlyphList.Delete(Index: Integer);
begin
  if Used[Index] then
  begin
    Dec(FCount);
    Used[Index] := False;
  end;
end;

{ TOfficeGlyphCache }

constructor TOfficeGlyphCache.Create;
begin
  inherited Create;
  GlyphLists := TList.Create;
end;

destructor TOfficeGlyphCache.Destroy;
begin
  GlyphLists.Free;
  inherited Destroy;
end;

function TOfficeGlyphCache.GetList(AWidth, AHeight: Integer): TOfficeGlyphList;
var
  I: Integer;
begin
  for I := GlyphLists.Count - 1 downto 0 do
  begin
    Result := GlyphLists[I];
    with Result do
      if (AWidth = Width) and (AHeight = Height) then Exit;
  end;
  Result := TOfficeGlyphList.CreateSize(AWidth, AHeight);
  GlyphLists.Add(Result);
end;

procedure TOfficeGlyphCache.ReturnList(List: TOfficeGlyphList);
begin
  if List = nil then Exit;
  if List.Count = 0 then
  begin
    GlyphLists.Remove(List);
    List.Free;
  end;
end;

function TOfficeGlyphCache.Empty: Boolean;
begin
  Result := GlyphLists.Count = 0;
end;

{ TOfficeButtonGlyph }

constructor TOfficeButtonGlyph.Create;
var
  I: TOfficeButtonState;
begin
  inherited Create;
  FOriginal := TBitmap.Create;
  FOriginal.OnChange := GlyphChanged;
  FTransparentColor := clOlive;
  FNumGlyphs := 1;
  for I := Low(I) to High(I) do
    FIndexs[I] := -1;
  if OfficeGlyphCache = nil then OfficeGlyphCache := TOfficeGlyphCache.Create;
end;

destructor TOfficeButtonGlyph.Destroy;
begin
  FOriginal.Free;
  Invalidate;
  if Assigned(OfficeGlyphCache) and OfficeGlyphCache.Empty then
  begin
    OfficeGlyphCache.Free;
    OfficeGlyphCache := nil;
  end;
  inherited Destroy;
end;

procedure TOfficeButtonGlyph.Invalidate;
var
  I: TOfficeButtonState;
begin
  for I := Low(I) to High(I) do
  begin
    if FIndexs[I] <> -1 then FGlyphList.Delete(FIndexs[I]);
    FIndexs[I] := -1;
  end;
  OfficeGlyphCache.ReturnList(FGlyphList);
  FGlyphList := nil;
end;

procedure TOfficeButtonGlyph.GlyphChanged(Sender: TObject);
begin
  if Sender = FOriginal then
  begin
    FTransparentColor := FOriginal.TransparentColor;
    Invalidate;
    if Assigned(FOnChange) then FOnChange(Self);
  end;
end;

procedure TOfficeButtonGlyph.SetGlyph(Value: TBitmap);
var
  Glyphs: Integer;
begin
  Invalidate;
  FOriginal.Assign(Value);
  if (Value <> nil) and (Value.Height > 0) then
  begin
    FTransparentColor := Value.TransparentColor;
    if Value.Width mod Value.Height = 0 then
    begin
      Glyphs := Value.Width div Value.Height;
      if Glyphs > 4 then Glyphs := 1;
      SetNumGlyphs(Glyphs);
    end;
  end;
end;

procedure TOfficeButtonGlyph.SetNumGlyphs(Value: TOfficeNumGlyphs);
begin
  if (Value <> FNumGlyphs) and (Value > 0) then
  begin
    Invalidate;
    FNumGlyphs := Value;
    GlyphChanged(Glyph);
  end;
end;

function TOfficeButtonGlyph.CreateButtonGlyph(State: TOfficeButtonState): Integer;
const
  ROP_DSPDxax = $00E20746;
var
  TmpImage, DDB, MonoBmp: TBitmap;
  IWidth, IHeight: Integer;
  IRect, ORect: TRect;
  I: TOfficeButtonState;
  DestDC: HDC;
begin
  if (State = wbsDown) and (NumGlyphs < 3) then State := wbsUp;
  Result := FIndexs[State];
  if Result <> -1 then Exit;
  if (FOriginal.Width or FOriginal.Height) = 0 then Exit;
  IWidth := FOriginal.Width div FNumGlyphs;
  IHeight := FOriginal.Height;
  if FGlyphList = nil then
  begin
    if OfficeGlyphCache = nil then OfficeGlyphCache := TOfficeGlyphCache.Create;
    FGlyphList := OfficeGlyphCache.GetList(IWidth, IHeight);
  end;
  TmpImage := TBitmap.Create;
  try
    TmpImage.Width := IWidth;
    TmpImage.Height := IHeight;
    IRect := Rect(0, 0, IWidth, IHeight);
    TmpImage.Canvas.Brush.Color := clBtnFace;
    TmpImage.Palette := CopyPalette(FOriginal.Palette);
    I := State;
    if Ord(I) >= NumGlyphs then I := wbsUp;
    ORect := Rect(Ord(I) * IWidth, 0, (Ord(I) + 1) * IWidth, IHeight);
    case State of
      wbsUp, wbsDown,
      wbsExclusive:
        begin
          TmpImage.Canvas.CopyRect(IRect, FOriginal.Canvas, ORect);
          if FOriginal.TransparentMode = tmFixed then
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, FTransparentColor)
          else
            FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault);
        end;
      wbsDisabled:
        begin
          MonoBmp := nil;
          DDB := nil;
          try
            MonoBmp := TBitmap.Create;
            DDB := TBitmap.Create;
            DDB.Assign(FOriginal);
            DDB.HandleType := bmDDB;
            if NumGlyphs > 1 then
            with TmpImage.Canvas do
            begin    { Change white & gray to clBtnHighlight and clBtnShadow }
              CopyRect(IRect, DDB.Canvas, ORect);
              MonoBmp.Monochrome := True;
              MonoBmp.Width := IWidth;
              MonoBmp.Height := IHeight;

              { Convert white to clBtnHighlight }
              DDB.Canvas.Brush.Color := clWhite;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnHighlight;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              { Convert gray to clBtnShadow }
              DDB.Canvas.Brush.Color := clGray;
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnShadow;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);

              { Convert transparent color to clBtnFace }
              DDB.Canvas.Brush.Color := ColorToRGB(FTransparentColor);
              MonoBmp.Canvas.CopyRect(IRect, DDB.Canvas, ORect);
              Brush.Color := clBtnFace;
              DestDC := Handle;
              SetTextColor(DestDC, clBlack);
              SetBkColor(DestDC, clWhite);
              BitBlt(DestDC, 0, 0, IWidth, IHeight,
                     MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
            end
            else
            begin
              { Create a disabled version }
              with MonoBmp do
              begin
                Assign(FOriginal);
                HandleType := bmDDB;
                Canvas.Brush.Color := clBlack;
                Width := IWidth;
                if Monochrome then
                begin
                  Canvas.Font.Color := clWhite;
                  Monochrome := False;
                  Canvas.Brush.Color := clWhite;
                end;
                Monochrome := True;
              end;
              with TmpImage.Canvas do
              begin
                Brush.Color := clBtnFace;
                FillRect(IRect);
                Brush.Color := clBtnHighlight;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 1, 1, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
                Brush.Color := clBtnShadow;
                SetTextColor(Handle, clBlack);
                SetBkColor(Handle, clWhite);
                BitBlt(Handle, 0, 0, IWidth, IHeight,
                  MonoBmp.Canvas.Handle, 0, 0, ROP_DSPDxax);
              end;
            end;
          finally
            DDB.Free;
            MonoBmp.Free;
          end;
          FIndexs[State] := FGlyphList.AddMasked(TmpImage, clDefault);
        end;
    end;
  finally
    TmpImage.Free;
  end;
  Result := FIndexs[State];
  FOriginal.Dormant;
end;

procedure TOfficeButtonGlyph.DrawButtonGlyph(Canvas: TCanvas; const GlyphPos: TPoint;
  State: TOfficeButtonState; Transparent: Boolean);
var
  Index: Integer;
  Details: TThemedElementDetails;
  R: TRect;
  Button: TThemedButton;
begin
  if FOriginal = nil then Exit;
  if (FOriginal.Width = 0) or (FOriginal.Height = 0) then Exit;
  Index := CreateButtonGlyph(State);
  with GlyphPos do
  begin
    if ThemeServices.ThemesEnabled then
    begin
      R.TopLeft := GlyphPos;
      R.Right := R.Left + FOriginal.Width div FNumGlyphs;
      R.Bottom := R.Top + FOriginal.Height;
      case State of
        wbsDisabled:
          Button := tbPushButtonDisabled;
        wbsDown,
        wbsExclusive:
          Button := tbPushButtonPressed;
      else
        // wbsUp
        Button := tbPushButtonNormal;
      end;
      Details := ThemeServices.GetElementDetails(Button);
      ThemeServices.DrawIcon(Canvas.Handle, Details, R, FGlyphList.Handle, Index);
    end
    else
      if Transparent or (State = wbsExclusive) then
      begin
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
          clNone, clNone, ILD_Transparent)
      end
      else
        ImageList_DrawEx(FGlyphList.Handle, Index, Canvas.Handle, X, Y, 0, 0,
          ColorToRGB(clBtnFace), clNone, ILD_Normal);
  end;
end;

procedure TOfficeButtonGlyph.DrawButtonText(Canvas: TCanvas; const Caption: string;
  TextBounds: TRect; State: TOfficeButtonState; BiDiFlags: LongInt);
begin
  with Canvas do
  begin
    Brush.Style := bsClear;
    if State = wbsDisabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      Font.Color := clBtnHighlight;
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
    end else
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or BiDiFlags);
  end;
end;

procedure TOfficeButtonGlyph.CalcButtonLayout(Canvas: TCanvas; const Client: TRect;
  const Offset: TPoint; const Caption: string; Layout: TOfficeButtonLayout; Margin,
  Spacing: Integer; var GlyphPos: TPoint; var TextBounds: TRect;
  BiDiFlags: LongInt; bCaption : Boolean);
var
  TextPos: TPoint;
  ClientSize, GlyphSize, TextSize: TPoint;
  TotalSize: TPoint;
begin
  if (BiDiFlags and DT_RIGHT) = DT_RIGHT then
    if Layout = wblGlyphLeft then Layout := wblGlyphRight
    else
      if Layout = wblGlyphRight then Layout := wblGlyphLeft;
  { calculate the item sizes }
  ClientSize := Point(Client.Right - Client.Left, Client.Bottom -
    Client.Top);

  if FOriginal <> nil then
    GlyphSize := Point(FOriginal.Width div FNumGlyphs, FOriginal.Height) else
    GlyphSize := Point(0, 0);

  if bCaption and (Length(Caption) > 0) then
  begin
    TextBounds := Rect(0, 0, Client.Right - Client.Left, 0);
    DrawText(Canvas.Handle, PChar(Caption), Length(Caption), TextBounds,
      DT_CALCRECT or BiDiFlags);
    TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom -
      TextBounds.Top);
  end
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0,0);
  end;

  { If the layout has the glyph on the right or the left, then both the
    text and the glyph are centered vertically.  If the glyph is on the top
    or the bottom, then both the text and the glyph are centered horizontally.}
  if Layout in [wblGlyphLeft, wblGlyphRight] then
  begin
    GlyphPos.Y := (ClientSize.Y - GlyphSize.Y + 1) div 2;
    TextPos.Y := (ClientSize.Y - TextSize.Y + 1) div 2;
  end
  else
  begin
    GlyphPos.X := (ClientSize.X - GlyphSize.X + 1) div 2;
    TextPos.X := (ClientSize.X - TextSize.X + 1) div 2;
  end;

  { if there is no text or no bitmap, then Spacing is irrelevant }
  if (TextSize.X = 0) or (GlyphSize.X = 0) then
    Spacing := 0;

  { adjust Margin and Spacing }
  if Margin = -1 then
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(GlyphSize.X + TextSize.X, GlyphSize.Y + TextSize.Y);
      if Layout in [wblGlyphLeft, wblGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X) div 3
      else
        Margin := (ClientSize.Y - TotalSize.Y) div 3;
      Spacing := Margin;
    end
    else
    begin
      TotalSize := Point(GlyphSize.X + Spacing + TextSize.X, GlyphSize.Y +
        Spacing + TextSize.Y);
      if Layout in [wblGlyphLeft, wblGlyphRight] then
        Margin := (ClientSize.X - TotalSize.X + 1) div 2
      else
        Margin := (ClientSize.Y - TotalSize.Y + 1) div 2;
    end;
  end
  else
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(ClientSize.X - (Margin + GlyphSize.X), ClientSize.Y -
        (Margin + GlyphSize.Y));
      if Layout in [wblGlyphLeft, wblGlyphRight] then
        Spacing := (TotalSize.X - TextSize.X) div 2
      else
        Spacing := (TotalSize.Y - TextSize.Y) div 2;
    end;
  end;

  case Layout of
    wblGlyphLeft:
      begin
        GlyphPos.X := Margin;
        TextPos.X := GlyphPos.X + GlyphSize.X + Spacing;
      end;
    wblGlyphRight:
      begin
        GlyphPos.X := ClientSize.X - Margin - GlyphSize.X;
        TextPos.X := GlyphPos.X - Spacing - TextSize.X;
      end;
    wblGlyphTop:
      begin
        GlyphPos.Y := Margin;
        TextPos.Y := GlyphPos.Y + GlyphSize.Y + Spacing;
      end;
    wblGlyphBottom:
      begin
        GlyphPos.Y := ClientSize.Y - Margin - GlyphSize.Y;
        TextPos.Y := GlyphPos.Y - Spacing - TextSize.Y;
      end;
  end;

  { fixup the result variables }
  with GlyphPos do
  begin
    Inc(X, Client.Left + Offset.X);
    Inc(Y, Client.Top + Offset.Y);
  end;

  { Themed text is not shifted, but gets a different color. }
  if ThemeServices.ThemesEnabled then
    OffsetRect(TextBounds, TextPos.X + Client.Left, TextPos.Y + Client.Top)
  else
    OffsetRect(TextBounds, TextPos.X + Client.Left + Offset.X, TextPos.Y + Client.Top + Offset.Y);

end;

function TOfficeButtonGlyph.Draw(Canvas: TCanvas; const Client: TRect;
  const Offset: TPoint; const Caption: string; Layout: TOfficeButtonLayout;
  Margin, Spacing: Integer; State: TOfficeButtonState; Transparent: Boolean;
  BiDiFlags: LongInt; bCaption : boolean): TRect;
var
  GlyphPos: TPoint;
begin
  CalcButtonLayout(Canvas, Client, Offset, Caption, Layout, Margin, Spacing,
    GlyphPos, Result, BiDiFlags, bCaption);
  DrawButtonGlyph(Canvas, GlyphPos, State, Transparent);
  if bCaption then
    DrawButtonText(Canvas, Caption, Result, State, BiDiFlags);
end;

{ TOfficeMainMenu }

constructor TOfficeMainMenu.Create(AOwner: TComponent);
begin
  inherited;
  OwnerDraw := True;
end;

function TOfficeMainMenu.IsLastChild(aMenuItem : TOfficeMenuItem): boolean;
  function IsLastChildMenu(aMenuItem : TOfficeMenuItem; aMenu : TOfficeMainMenu) : boolean;
  var
    i : integer;
  begin
    for i := 0 to aMenu.Items.Count - 1 do
    begin
      // skip non-visible menu items
      if aMenu.Items.Items[i].Visible = False then Continue;
      // if group index is zero then use menu index instead
      if aMenuItem.GroupIndex = 0 then
      begin
        if aMenu.Items.Items[i].MenuIndex > aMenuItem.MenuIndex then
        begin
          Result := False;
          Exit;
        end;
      end
      else
      begin
        if aMenu.Items.Items[i].GroupIndex > aMenuItem.GroupIndex then
        begin
          Result := False;
          Exit;
        end;
      end;
    end;
    Result := True;
  end;
begin
  Result := IsLastChildMenu(aMenuItem, Self);
  if Assigned(fMergedWith) then
    Result := Result and IsLastChildMenu(aMenuItem, fMergedWith);
end;

procedure TOfficeMainMenu.OfficeMerge(Menu: TOfficeMainMenu);
begin
  Merge(Menu);
  fMergedMenu := Menu;
  if assigned(Menu) then
    Menu.fMergedWith := Self;
end;

procedure TOfficeMainMenu.OfficeUnmerge(Menu: TOfficeMainMenu);
begin
  Unmerge(Menu);
  fMergedMenu := nil;
  if Assigned(Menu) then
    Menu.fMergedWith := nil;
end;

function TOfficeMainMenu.Width: integer;
begin
  Result := TScrollingWinControl(Owner).ClientWidth+4;
  if (Owner is TForm) and (TForm(Owner).FormStyle = fsMDIForm) then
  begin
    if TForm(Owner).MDIChildCount > 0 then
    begin
      // are any children maximized?
      if Assigned(TForm(Owner).ActiveMDIChild) then
        if TForm(Owner).ActiveMDIChild.WindowState = wsMaximized then
          Result := Result - (3 * GetSystemMetrics(SM_CXMENUSIZE));
    end;
  end;
end;

{ TOfficePopupMenu }

constructor TOfficePopupMenu.Create(AOwner: TComponent);
begin
  inherited;
  OwnerDraw := True;
end;

function dxGetOffice11Scheme: TOffice11Scheme;
const
  SZ_MAX_CHARS = 1024;
  SStandardThemeFileName = 'LUNA.MSSTYLES';
  SNormalColor = 'NORMALCOLOR';
  SHomestead = 'HOMESTEAD';
  SMetallic = 'METALLIC';
var
  PThemeFileName, PThemeColor, PThemeSize: PWideChar;
  S: string;
begin
  Result := schUnknown;
  if ThemeServices.ThemesAvailable then
  begin
    PThemeFileName := AllocMem(2 * SZ_MAX_CHARS);
    PThemeColor := AllocMem(2 * SZ_MAX_CHARS);
    PThemeSize := AllocMem(2 * SZ_MAX_CHARS);
    try
      // TODO: XP!!!
      if FAILED(GetCurrentThemeName(PThemeFileName, SZ_MAX_CHARS, PThemeColor,
        SZ_MAX_CHARS, PThemeSize, SZ_MAX_CHARS)) then
        Exit;
      S := UpperCase(ExtractFileName(PThemeFileName));
      if S = SStandardThemeFileName then
      begin
        S := UpperCase(PThemeColor);
        if S = SNormalColor then
          Result := schNormalColor
        else
          if S = SHomestead then
            Result := schHomestead
          else
            if S = SMetallic then
              Result := schMetallic;
      end;
    finally
      FreeMem(PThemeSize);
      FreeMem(PThemeColor);
      FreeMem(PThemeFileName);
    end;
  end;
end;

function GetRealColor(AColor: COLORREF): COLORREF;
var
  DC: HDC;
begin
  DC := GetDC(0);
  Result := GetNearestColor(DC, AColor);
  ReleaseDC(0, DC);
end;

function GetMiddleRGB(AColor1, AColor2: TColor; APercent: Integer): COLORREF;

  function CalcValue(Value1, Value2: Byte): Byte;
  var
    I: Integer;
  begin
    I := MulDiv(Value1, APercent, 100) + MulDiv(Value2, 100 - APercent, 100);
    if I > 255 then I := 255;
    Result := I;
  end;

begin
  AColor1 := ColorToRGB(AColor1);
  AColor2 := ColorToRGB(AColor2);
  Result := RGB(
    CalcValue(GetRValue(AColor1), GetRValue(AColor2)),
    CalcValue(GetGValue(AColor1), GetGValue(AColor2)),
    CalcValue(GetBValue(AColor1), GetBValue(AColor2)));
  Result := GetRealColor(Result);
end;

function GetLightColor(ABtnFaceColorPart, AHighlightColorPart, AWindowColorPart: Integer): COLORREF;
var
  ABtnFaceColor, AHighlightColor, AWindowColor: COLORREF;

  function GetLightIndex(ABtnFaceValue, AHighlightValue, AWindowValue: Byte): Integer;
  begin
    Result :=
      MulDiv(ABtnFaceValue, ABtnFaceColorPart, 100) +
      MulDiv(AHighlightValue, AHighlightColorPart, 100) +
      MulDiv(AWindowValue, AWindowColorPart, 100);
    if Result < 0 then Result := 0;
    if Result > 255 then Result := 255;
  end;

begin
  ABtnFaceColor := GetSysColor(COLOR_BTNFACE);
  AHighlightColor := GetSysColor(COLOR_HIGHLIGHT);
  AWindowColor := GetSysColor(COLOR_WINDOW);
  if (ABtnFaceColor = 0) or (ABtnFaceColor = $FFFFFF) then
    Result := AHighlightColor
  else
    Result := RGB(
      GetLightIndex(GetRValue(ABtnFaceColor), GetRValue(AHighlightColor), GetRValue(AWindowColor)),
      GetLightIndex(GetGValue(ABtnFaceColor), GetGValue(AHighlightColor), GetGValue(AWindowColor)),
      GetLightIndex(GetBValue(ABtnFaceColor), GetBValue(AHighlightColor), GetBValue(AWindowColor)));
end;

procedure InitOffice11Colors;
const
  Office11Colors: array[TOffice11SchemeColor, 0..48] of COLORREF = (
    ($FEECDD, $E2A981, $F5BE9E, $F9DAC3, $913500, $F1A675, $76C1FF, $D3F8FF, $98DDFF, $5295FE,
     $9C613B, $E0A47B, $764127, $FFFFFF, $CB8C6A, $FFF9F1, $C9662A, $F9DBC4, $962D00, $F6F6F6,
     $C2EEFF, $800000, $CCF4FF, $91D0FF, $8ED3FF, $4E91FE, $FCE1CB, $6FC0FF, $3E80FE, $F0C7A9,
     $000000, $8D8D8D, $FBDABE, $94E6FB, $FADAC4, $962D00, $B96837, $962D00, $FBE5D3, $E4AE88,
     $DCFFFF, $5BC0F7, $94E6FB, $1595EE, $087FE8, $7CDAF7, $D68759, $933803, $FFFFFF),
    ($DEF7F4, $91C6B7, $A7D9D9, $E4F0F2, $6B7760, $8CC2B0, $76C1FF, $D3F8FF, $98DDFF, $5295FE,
     $588060, $8FC4B5, $335E51, $FFFFFF, $588060, $DEF7F4, $5E8674, $ADDEE1, $5E8D75, $EEF4F4,
     $C2EEFF, $385D3F, $CCF4FF, $91D0FF, $8ED3FF, $4E91FE, $B6E3D8, $6FC0FF, $3E80FE, $9FD4C5,
     $000000, $8D8D8D, $91BAAF, $94E6FB, $E4F1F2, $588060, $548973, $5E8D75, $DBF5F2, $97C9BC,
     $DCFFFF, $5BC0F7, $94E6FB, $1595EE, $087FE8, $7CDAF7, $82C0AF, $447A63, $FFFFFF),
    ($FAF4F3, $B59799, $E5D7D7, $F7F3F3, $927476, $C8B2B3, $76C1FF, $D3F8FF, $98DDFF, $5295FE,
     $947C7C, $B09193, $755454, $FFFFFF, $8F6D6E, $FFFFFF, $99797A, $E4DADB, $947C7C, $FFFAFD,
     $C2EEFF, $6F4B4B, $CCF4FF, $91D0FF, $8ED3FF, $4E91FE, $E7D3D6, $6FC0FF, $3E80FE, $D3C0C0,
     $000000, $8D8D8D, $EBE5E5, $94E6FB, $F7F3F3, $947C7C, $916F70, $947C7C, $F8F1F0, $BA9EA0,
     $DCFFFF, $5BC0F7, $94E6FB, $1595EE, $087FE8, $7CDAF7, $BFA7A8, $916F70, $FFFFFF)
  );
  Office11GradientPercents: array[TOffice11SchemeColor] of Integer = (41, 125, 40);
begin
  FOffice11Scheme := dxGetOffice11Scheme;
  FXPStandardScheme := ThemeServices.ThemesAvailable and (FOffice11Scheme <> schUnknown){luna};
  if FXPStandardScheme then
  begin
    // bk colors
    dxOffice11ToolbarsColor1 := Office11Colors[FOffice11Scheme, 0];
    dxOffice11ToolbarsColor2 := Office11Colors[FOffice11Scheme, 1];
    dxOffice11DockColor1 := Office11Colors[FOffice11Scheme, 2];
    dxOffice11DockColor2 := Office11Colors[FOffice11Scheme, 3];
    // bar: separator
    dxOffice11BarSeparatorColor1 := Office11Colors[FOffice11Scheme, 14];
    // drop downs, menus
    dxOffice11MenuColor := Office11Colors[FOffice11Scheme, 19];
    // selected
    dxOffice11SelectedBorderColor := Office11Colors[FOffice11Scheme, 21];
    dxOffice11SelectedColor1 := Office11Colors[FOffice11Scheme, 22];
    dxOffice11SelectedColor2 := Office11Colors[FOffice11Scheme, 23];
    dxOffice11SelectedDownColor1 := Office11Colors[FOffice11Scheme, 24];
    dxOffice11SelectedDownColor2 := Office11Colors[FOffice11Scheme, 25];
    dxOffice11DownedColor := Office11Colors[FOffice11Scheme, 27];
    dxOffice11DownedSelectedColor := Office11Colors[FOffice11Scheme, 28];
    // text
    dxOffice11TextEnabledColor := Office11Colors[FOffice11Scheme, 30];
    dxOffice11TextDisabledColor := Office11Colors[FOffice11Scheme, 31];
    // Gradient Tube Percent
    GradientPercent := Office11GradientPercents[FOffice11Scheme];
  end
  else
  begin
    // bk colors
    dxOffice11DockColor1 := ColorToRGB(clBtnFace);
    dxOffice11DockColor2 := GetMiddleRGB(clBtnFace, clWindow, 20);
    dxOffice11ToolbarsColor1 := GetMiddleRGB(clBtnFace, clWindow, 22);
    dxOffice11ToolbarsColor2 := GetMiddleRGB(clBtnFace, clWindow, 96);
    // bar: separator
    dxOffice11BarSeparatorColor1 := GetMiddleRGB(clBtnShadow, clWindow, 70);
    // drop down
    dxOffice11MenuColor := ColorToRGB(clWindow); // ?
    // selected
    dxOffice11SelectedBorderColor := ColorToRGB(clHighlight);
    dxOffice11SelectedColor1 := GetRealColor(GetLightColor(-2, 30, 72));
    dxOffice11SelectedColor2 := dxOffice11SelectedColor1;
    dxOffice11DownedColor := GetLightColor(41, 11, 48); // ?
    dxOffice11DownedSelectedColor := GetRealColor(GetLightColor(14, 44, 40)); // ?
    dxOffice11SelectedDownColor1 := dxOffice11DownedSelectedColor;
    dxOffice11SelectedDownColor2 := dxOffice11DownedSelectedColor;
    // text
    dxOffice11TextEnabledColor := ColorToRGB(clBtnText);
    dxOffice11TextDisabledColor := ColorToRGB(clGrayText);
    // Gradient Tube Percent
    GradientPercent := 75;
  end;
  dxOffice11MenuIndentColor1 := dxOffice11ToolbarsColor1;
  dxOffice11MenuIndentColor2 := dxOffice11ToolbarsColor2;
end;

{$ENDIF}

{ TOfficeCustomGradientPanel }

constructor TOfficeCustomGradientPanel.Create(AOwner: TComponent);
begin
  inherited;

  BevelInner := bvNone;
  BevelOuter := bvNone;

  DoubleBuffered := True;       // to eliminate flicker when resized

  ParentColor := False;
{$IFNDEF FPC}
  ParentBackground := False;
{$ENDIF}

  // default settings
  FGradientFrom := Self.Color;
  FGradientTo   := Self.Color;
  FHorizontal  := True;
end;

{$IFNDEF FPC}
procedure TOfficeCustomGradientPanel.Paint;
const
  Alignments:  array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Rect:         TRect;
  RH:           Integer;
  CalcRect:     TRect;
  CRH:          Integer;
  Flags:        Longint;
  I:            Integer;
begin
  Rect := GetClientRect;

  FillGradientRect(
    Self.Canvas.Handle,
    Self.ClientRect,
    Self.GradientFrom,
    Self.GradientTo,
    Self.Horizontal);

  if (BorderWidth > 0) and (BorderColor <> clNone) then begin
    for I := 1 to BorderWidth do begin
      Canvas.Brush.Color := BorderColor;
      Canvas.FrameRect(Rect);
      InflateRect(Rect,-1,-1);
    end;
  end;

  if Caption <> '' then begin
    InflateRect(Rect,-HorzMargin,-VertMargin);

    // paint the caption text
    with Canvas do begin
      Brush.Style := bsClear;
      Font := Self.Font;

      // calculate how big the text rectangle needs to be
      CalcRect := Rect;
      Flags := DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK;
      case Alignment of
        taCenter: 			Flags := Flags or DT_CENTER;
        taLeftJustify: 	Flags := Flags or DT_LEFT;
        taRightJustify: Flags := Flags or DT_RIGHT;
      end;
      DrawText(Handle,PChar(Caption),-1,CalcRect,Flags);

      { using the size of the current rectangle (Rect), the text's
      required rectangle (CalcRect) and the vertical alignment setting,
      determine where the text should be drawn}

      RH  := Rect.Bottom - Rect.Top;          // height of Rect
      CRH := CalcRect.Bottom - CalcRect.Top;  // height of CalcRect

      with Rect do begin
        if CRH < RH then begin
          Top := Top + (RH - CRH) div 2;
          Bottom := Top + CRH;
        end;
      end;

      Flags :=  DT_EXPANDTABS or
                DT_WORDBREAK or
                Alignments[Alignment];
      Flags := DrawTextBiDiModeFlags(Flags);
      DrawText(Handle, PChar(Caption), -1, Rect, Flags);
    end;
  end;
end;

procedure TOfficeCustomGradientPanel.CMParentColorChanged(var Message: TMessage);
begin
  inherited;
  if ParentColor then begin
    GradientFrom := Self.Color;
    GradientTo := Self.Color;
  end;
end;

procedure TOfficeCustomGradientPanel.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  InflateRect(Rect, -HorzMargin, -VertMargin);
end;

{$ENDIF}

procedure TOfficeCustomGradientPanel.SetGradientFrom(AValue: TColor);
begin
  if AValue <> GradientFrom then begin
    FGradientFrom := AValue;
    ParentColor := False;
    Invalidate;
  end;
end;

procedure TOfficeCustomGradientPanel.SetGradientTo(AValue: TColor);
begin
  if AValue <> GradientTo then begin
    FGradientTo := AValue;
    ParentColor := False;
    Invalidate;
  end;
end;

procedure TOfficeCustomGradientPanel.SetBorderColor(AValue: TColor);
begin
  if AValue <> BorderColor then begin
    FBorderColor := AValue;
    ParentColor := False;
    Invalidate;
  end;
end;

procedure TOfficeCustomGradientPanel.SetHorizontal(AValue: Boolean);
begin
  if AValue <> Horizontal then begin
    FHorizontal := AValue;
    Invalidate;
  end;
end;

procedure TOfficeCustomGradientPanel.SetHorzMargin(AValue: Integer);
begin
  if AValue <> HorzMargin then begin
    if AValue < 0 then AValue := 0;         // margin can't be negative
    FHorzMargin := AValue;
    Realign;
    Invalidate;
  end;
end;

procedure TOfficeCustomGradientPanel.SetVertMargin(AValue: Integer);
begin
  if AValue <> VertMargin then begin
    if AValue < 0 then AValue := 0;         // margin can't be negative
    FVertMargin := AValue;
    Realign;
    Invalidate;
  end;
end;

{$IFDEF FPC}
procedure Register;
begin
  RegisterComponents('Misc',[TOfficeControlBar]);
end;
{$ELSE}

{ TOfficeToolButton }

procedure TOfficeToolButton.Paint;
begin
  inherited Paint;
end;

{ TOfficeControlBar }

procedure TOfficeControlBar.AdjustClientRect(var Rect: TRect);
begin
  inherited AdjustClientRect(Rect);
  InflateRect(Rect, -HorzMargin, -VertMargin);
end;

procedure TOfficeControlBar.CMParentColorChanged(var Message: TMessage);
begin
  if ParentColor then begin
    GradientFrom := Self.Color;
    GradientTo := Self.Color;
  end;
end;

constructor TOfficeControlBar.Create(AOwner: TComponent);
begin
  inherited;
  AutoDock := False;
  BevelInner := bvNone;
  BevelOuter := bvNone;
  RowSnap := False;
  DockSite := False;
  BevelKind := bkNone;

  DoubleBuffered := True;       // to eliminate flicker when resized

  ParentColor := False;
  ParentBackground := False;

  // default settings
  FGradientFrom := Self.Color;
  FGradientTo   := Self.Color;
  FHorizontal  := True;
end;

procedure TOfficeControlBar.Paint;
var
  Rect : TRect;
  I : Integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    if ThemeServices.ThemesEnabled then
    begin
      fGradientFrom := dxOffice11DockColor1;
      fGradientTo   := dxOffice11DockColor2;
      fBorderColor  := GradientTo;
    end
    else
    begin
      fGradientFrom := clBtnFace;
      fGradientTo   := clBtnFace;
      fBorderColor  := GradientTo;
    end;
    Rect := GetClientRect;

    FillGradientRect(
      Self.Canvas.Handle,
      Self.ClientRect,
      Self.GradientFrom,
      Self.GradientTo,
      Self.Horizontal);

    if (BorderWidth > 0) and (BorderColor <> clNone) then begin
      for I := 1 to BorderWidth do begin
        Canvas.Brush.Color := BorderColor;
        Canvas.FrameRect(Rect);
        InflateRect(Rect,-1,-1);
      end;
    end;
  end;
  inherited Paint;
end;

procedure TOfficeControlBar.PaintControlFrame(Canvas: TCanvas;
  AControl: TControl; var ARect: TRect);
begin
  inherited PaintControlFrame(Canvas, AControl, ARect);
end;

procedure TOfficeControlBar.SetBorderColor(AValue: TColor);
begin
  if AValue <> BorderColor then begin
    FBorderColor := AValue;
    ParentColor := False;
    Invalidate;
  end;
end;

procedure TOfficeControlBar.SetGradientFrom(AValue: TColor);
begin
  if AValue <> GradientFrom then begin
    FGradientFrom := AValue;
    ParentColor := False;
    Invalidate;
  end;
end;

procedure TOfficeControlBar.SetGradientTo(AValue: TColor);
begin
  if AValue <> GradientTo then begin
    FGradientTo := AValue;
    ParentColor := False;
    Invalidate;
  end;
end;

procedure TOfficeControlBar.SetHorizontal(AValue: Boolean);
begin
  if AValue <> Horizontal then begin
    FHorizontal := AValue;
    Invalidate;
  end;
end;

procedure TOfficeControlBar.SetHorzMargin(AValue: Integer);
begin
  if AValue <> HorzMargin then begin
    if AValue < 0 then AValue := 0;         // margin can't be negative
    FHorzMargin := AValue;
    Realign;
    Invalidate;
  end;
end;

procedure TOfficeControlBar.SetVertMargin(AValue: Integer);
begin
  if AValue <> VertMargin then begin
    if AValue < 0 then AValue := 0;         // margin can't be negative
    FVertMargin := AValue;
    Realign;
    Invalidate;
  end;
end;

{ TOfficeToolBar }

procedure TOfficeToolBar.NCPaint(DC: HDC);
begin
  inherited;
end;

{ TOfficeSpeedButtonActionLink }

procedure TOfficeSpeedButtonActionLink.AssignClient(AClient: TObject);
begin
  inherited AssignClient(AClient);
  FClient := AClient as TOfficeSpeedButton;
end;

function TOfficeSpeedButtonActionLink.IsCheckedLinked: Boolean;
begin
  Result := inherited IsCheckedLinked and
    (FClient.Down = (Action as TCustomAction).Checked);
end;

procedure TOfficeSpeedButtonActionLink.SetChecked(Value: Boolean);
begin
  if IsCheckedLinked then FClient.Down := Value;
end;

initialization

  InitOffice11Colors;
{$ENDIF}
  
end.


