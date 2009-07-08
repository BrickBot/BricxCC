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
unit CheckListState;

{$I bricxcc.inc}
{$T-,H+,X+}

interface

uses
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LCLType,
  LMessages,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls,
  StdCtrls, ImgList;

type
  TGetCheckHintEvent = procedure(Sender : TObject; State : TCheckBoxState; var Hint : string) of object;
  TGetStateHintEvent = procedure(Sender : TObject; State : Integer; var Hint : string) of object;
  TCheckStateListBox = class(TCustomListBox)
  private
    FAllowGrayed: Boolean;
    FFlat: Boolean;
    FStandardItemHeight: Integer;
    FOnClickCheck: TNotifyEvent;
    FSaveStates: TList;
    FOnClickState: TNotifyEvent;
    FStateImages: TCustomImageList;
    FStateChangeLink: TChangeLink;
    fShowState: Boolean;
    FOnGetCheckHint: TGetCheckHintEvent;
    FOnGetStateHint: TGetStateHintEvent;
    FHeaderColor: TColor;
    FHeaderBackgroundColor: TColor;
    procedure ResetItemHeight;
    procedure DrawCheck(R: TRect; AState: TCheckBoxState; AEnabled: Boolean);
    procedure DrawItemState(R: TRect; Index : Integer);
    procedure SetChecked(Index: Integer; Checked: Boolean);
    function GetChecked(Index: Integer): Boolean;
    procedure SetCheckedState(Index: Integer; AState: TCheckBoxState);
    function GetCheckedState(Index: Integer): TCheckBoxState;
    procedure ToggleClickCheck(Index: Integer);
    procedure InvalidateCheck(Index: Integer);
    procedure InvalidateState(Index: Integer);
    function CreateWrapper(Index: Integer): TObject;
    function ExtractWrapper(Index: Integer): TObject;
    function GetWrapper(Index: Integer): TObject;
    function HaveWrapper(Index: Integer): Boolean;
    procedure SetFlat(Value: Boolean);
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure WMDestroy(var Msg : TWMDestroy);message WM_DESTROY;
    function GetItemEnabled(Index: Integer): Boolean;
    procedure SetItemEnabled(Index: Integer; const Value: Boolean);
    function GetHeader(Index: Integer): Boolean;
    procedure SetHeader(Index: Integer; const Value: Boolean);
    procedure SetHeaderBackgroundColor(const Value: TColor);
    procedure SetHeaderColor(const Value: TColor);
    function GetState(Index: Integer): Integer;
    procedure SetState(Index: Integer; const Value: Integer);
    procedure SetStateImages(Value: TCustomImageList);
    procedure SetShowState(const Value: Boolean);
  protected
    fSavedHint : string;
    procedure Loaded; override;
    function GetStateWidth : Integer;
    function GetStateHeight : Integer;
    procedure DrawItem(Index: Integer; Rect: TRect;
      State: TOwnerDrawState); override;
    function InternalGetItemData(Index: Integer): Longint; override;
    procedure InternalSetItemData(Index: Integer; AData: Longint); override;
    procedure SetItemData(Index: Integer; AData: LongInt); override;
    function GetItemData(Index: Integer): LongInt; override;
    procedure KeyPress(var Key: Char); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure ResetContent; override;
    procedure DeleteString(Index: Integer); override;
    procedure ClickCheck; dynamic;
    procedure ClickState; dynamic;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure DestroyWnd; override;
    function GetCheckWidth: Integer;
    procedure ImageListChange(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoGetCheckHint(State : TCheckBoxState; var Hint : string);
    procedure DoGetStateHint(State : Integer; var Hint : string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Checked[Index: Integer]: Boolean read GetChecked write SetChecked;
    property ItemEnabled[Index: Integer]: Boolean read GetItemEnabled write SetItemEnabled;
    property CheckedState[Index: Integer]: TCheckBoxState read GetCheckedState write SetCheckedState;
    property State[Index: Integer]: Integer read GetState write SetState;
    property Header[Index: Integer]: Boolean read GetHeader write SetHeader;
  published
    property StateImages: TCustomImageList read FStateImages write SetStateImages;
    property ShowState : Boolean read fShowState write SetShowState;
    property OnClickCheck: TNotifyEvent read FOnClickCheck write FOnClickCheck;
    property OnClickState: TNotifyEvent read FOnClickState write FOnClickState;
    property OnGetCheckHint: TGetCheckHintEvent read FOnGetCheckHint write FOnGetCheckHint;
    property OnGetStateHint: TGetStateHintEvent read FOnGetStateHint write FOnGetStateHint;
    property Align;
    property AllowGrayed: Boolean read FAllowGrayed write FAllowGrayed default False;
    property Anchors;
    property BiDiMode;
    property BorderStyle;
    property Color;
    property Columns;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Flat: Boolean read FFlat write SetFlat default True;
    //property ExtendedSelect;
    property Font;
    property HeaderColor: TColor read FHeaderColor write SetHeaderColor default clInfoText;
    property HeaderBackgroundColor: TColor read FHeaderBackgroundColor write SetHeaderBackgroundColor default clInfoBk;
    property ImeMode;
    property ImeName;
    property IntegralHeight;
    property ItemHeight;
    property Items;
    //property MultiSelect;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property Style;
    property TabOrder;
    property TabStop;
    property TabWidth;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end;

procedure Register;

implementation

uses Consts, Math, Forms{$IFDEF VER_D6_UP},RTLConsts, Themes{$ENDIF};

type
  TCheckStateListBoxDataWrapper = class
  private
    FData: LongInt;
    FCheckedState: TCheckBoxState;
    FDisabled: Boolean;
    fState: Integer;
    FHeader: Boolean;
    procedure SetChecked(Check: Boolean);
    function GetChecked: Boolean;
  public
    class function GetDefaultCheckedState: TCheckBoxState;
    property Checked: Boolean read GetChecked write SetChecked;
    property CheckedState: TCheckBoxState read FCheckedState write FCheckedState;
    property Disabled: Boolean read FDisabled write FDisabled;
    property State: Integer read fState write fState;
    property Header: Boolean read FHeader write FHeader;
  end;

var
  FCheckWidth, FCheckHeight: Integer;

procedure Register;
begin
  RegisterComponents('Samples', [TCheckStateListBox]);
end;

procedure GetCheckSize;
begin
  with TBitmap.Create do
    try
      Handle := LoadBitmap(0, PChar(32759));
      FCheckWidth := Width div 4;
      FCheckHeight := Height div 3;
    finally
      Free;
    end;
end;

function MakeSaveState(CheckedState: TCheckBoxState; Disabled: Boolean): TObject;
begin
  Result := TObject((Byte(CheckedState) shl 16) or Byte(Disabled));
end;

function GetSaveState(AObject: TObject): TCheckBoxState;
begin
  Result := TCheckBoxState(Integer(AObject) shr 16);
end;

function GetSaveDisabled(AObject: TObject): Boolean;
begin
  Result := Boolean(Integer(AObject) and $FF);
end;

{ TCheckStateListBoxDataWrapper }

procedure TCheckStateListBoxDataWrapper.SetChecked(Check: Boolean);
begin
  if Check then FCheckedState := cbChecked else FCheckedState := cbUnchecked;
end;

function TCheckStateListBoxDataWrapper.GetChecked: Boolean;
begin
  Result := FCheckedState = cbChecked;
end;

class function TCheckStateListBoxDataWrapper.GetDefaultCheckedState: TCheckBoxState;
begin
  Result := cbUnchecked;
end;

{ TCheckStateListBox }

constructor TCheckStateListBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  fSavedHint := '';
  FFlat := True;
  FStateChangeLink := TChangeLink.Create;
  FStateChangeLink.OnChange := ImageListChange;
end;

destructor TCheckStateListBox.Destroy;
begin
  FStateChangeLink.Free;
  FSaveStates.Free;
  inherited;
end;

procedure TCheckStateListBox.CreateWnd;
begin
  inherited CreateWnd;
  if FSaveStates <> nil then
  begin
    FSaveStates.Free;
    FSaveStates := nil;
  end;
  ResetItemHeight;
end;
    
procedure TCheckStateListBox.DestroyWnd;
var
  I: Integer;
begin
  if Items.Count > 0 then
  begin
    FSaveStates := TList.Create;
    for I := 0 to Items.Count - 1 do
      FSaveStates.Add(MakeSaveState(CheckedState[I], not ItemEnabled[I]));
  end;
  inherited DestroyWnd;
end;

procedure TCheckStateListBox.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do
    if Style and (LBS_OWNERDRAWFIXED or LBS_OWNERDRAWVARIABLE) = 0 then
      Style := Style or LBS_OWNERDRAWFIXED;
end;
    
function TCheckStateListBox.GetCheckWidth: Integer;
begin
  Result := FCheckWidth + 2;
end;

procedure TCheckStateListBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ResetItemHeight;
end;

procedure TCheckStateListBox.ResetItemHeight;
begin
  if HandleAllocated and (Style = lbStandard) then
  begin
    Canvas.Font := Font;
    FStandardItemHeight := Canvas.TextHeight('Wg');
    Perform(LB_SETITEMHEIGHT, 0, FStandardItemHeight);
  end;
end;

const
  K_CHECK_FUDGE = 12;
      
procedure TCheckStateListBox.DrawItem(Index: Integer; Rect: TRect;
  State: TOwnerDrawState);
var
  R: TRect;
  SaveEvent: TDrawItemEvent;
  ACheckWidth: Integer;
  AStateWidth: Integer;
  Enable: Boolean;
begin
  ACheckWidth := GetCheckWidth;
  AStateWidth := GetStateWidth;
  if Index < Items.Count then
  begin
    R := Rect;
    Enable := Self.Enabled and GetItemEnabled(Index);
    if not Header[Index] then
    begin
      if not UseRightToLeftAlignment then
      begin
        R.Right := Rect.Left;
        R.Left := R.Right - ACheckWidth - AStateWidth - K_CHECK_FUDGE;
      end
      else
      begin
        R.Left := Rect.Right;
        R.Right := R.Left + ACheckWidth + AStateWidth + K_CHECK_FUDGE;
      end;
      DrawCheck(R, GetCheckedState(Index), Enable);
      if not UseRightToLeftAlignment then
      begin
        R.Right := Rect.Left;
        R.Left := R.Right - ACheckWidth - AStateWidth;
      end
      else
      begin
        R.Left := Rect.Right;
        R.Right := R.Left + ACheckWidth + AStateWidth;
      end;
      DrawItemState(R, GetState(Index));
    end
    else
    begin
      Canvas.Font.Color := HeaderColor;
      Canvas.Brush.Color := HeaderBackgroundColor;
    end;
    if not Enable then
      Canvas.Font.Color := clGrayText;
  end;

  if (Style = lbStandard) and Assigned(OnDrawItem) then
  begin
    { Force lbStandard list to ignore OnDrawItem event. }
    SaveEvent := OnDrawItem;
    OnDrawItem := nil;
    try
      inherited;
    finally
      OnDrawItem := SaveEvent;
    end;
  end
  else
    inherited;
end;

procedure TCheckStateListBox.CNDrawItem(var Message: TWMDrawItem);
begin
  with Message.DrawItemStruct^ do
    if not UseRightToLeftAlignment then begin
      rcItem.Left := rcItem.Left + GetCheckWidth + GetStateWidth;
    end
    else begin
      rcItem.Right := rcItem.Right - GetCheckWidth - GetStateWidth;
    end;
  inherited;
end;

procedure TCheckStateListBox.DrawCheck(R: TRect; AState: TCheckBoxState; AEnabled: Boolean);
var
  DrawState: Integer;
  DrawRect: TRect;
  OldBrushColor: TColor;
  OldBrushStyle: TBrushStyle;
  OldPenColor: TColor;
  Rgn, SaveRgn: HRgn;
  ElementDetails: TThemedElementDetails;
begin
  SaveRgn := 0;
  DrawRect.Left := R.Left + (R.Right - R.Left - FCheckWidth) div 2;
  DrawRect.Top := R.Top + (R.Bottom - R.Top - FCheckHeight) div 2;
  DrawRect.Right := DrawRect.Left + FCheckWidth;
  DrawRect.Bottom := DrawRect.Top + FCheckHeight;
  with Canvas do
  begin
    if Flat then
    begin
      { Remember current clipping region }
      SaveRgn := CreateRectRgn(0,0,0,0);
      GetClipRgn(Handle, SaveRgn);
      { Clip 3d-style checkbox to prevent flicker }
      with DrawRect do
        Rgn := CreateRectRgn(Left + 2, Top + 2, Right - 2, Bottom - 2);
      SelectClipRgn(Handle, Rgn);
      DeleteObject(Rgn);
    end;

   if ThemeServices.ThemesEnabled then
   begin
      case AState of
        cbChecked:
          if AEnabled then
            ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxCheckedNormal)
          else
            ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxCheckedDisabled);
        cbUnchecked:
          if AEnabled then
            ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxUncheckedNormal)
          else
            ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxUncheckedDisabled)
        else // cbGrayed
          if AEnabled then
            ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxMixedNormal)
          else
            ElementDetails := ThemeServices.GetElementDetails(tbCheckBoxMixedDisabled);
      end;
      ThemeServices.DrawElement(Handle, ElementDetails, R);
    end
    else
    begin
      case AState of
        cbChecked:
          DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
        cbUnchecked:
          DrawState := DFCS_BUTTONCHECK;
        else // cbGrayed
          DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
      end;
      if not AEnabled then
        DrawState := DrawState or DFCS_INACTIVE;
      DrawFrameControl(Handle, DrawRect, DFC_BUTTON, DrawState);
    end;

    if Flat then
    begin
      SelectClipRgn(Handle, SaveRgn);
      DeleteObject(SaveRgn);
      { Draw flat rectangle in-place of clipped 3d checkbox above }
      OldBrushStyle := Brush.Style;
      OldBrushColor := Brush.Color;
      OldPenColor := Pen.Color;
      Brush.Style := bsClear;
      Pen.Color := clBtnShadow;
      with DrawRect do
        Rectangle(Left + 1, Top + 1, Right - 1, Bottom - 1);
      Brush.Style := OldBrushStyle;
      Brush.Color := OldBrushColor;
      Pen.Color := OldPenColor;
    end;
  end;
end;
(*
procedure TCheckStateListBox.DrawCheck(R: TRect; AState: TCheckBoxState; AEnabled: Boolean);
var
  DrawState: Integer;
  DrawRect: TRect;
  OldBrushColor: TColor;
  OldBrushStyle: TBrushStyle;
  OldPenColor: TColor;
  Rgn, SaveRgn: HRgn;
begin
  SaveRgn := 0;
  DrawRect.Left := R.Left + (R.Right - R.Left - FCheckWidth - GetStateWidth) div 2;
  DrawRect.Top := R.Top + (R.Bottom - R.Top - FCheckWidth) div 2;
  DrawRect.Right := DrawRect.Left + FCheckWidth;
  DrawRect.Bottom := DrawRect.Top + FCheckHeight;
  case AState of
    cbChecked:
      DrawState := DFCS_BUTTONCHECK or DFCS_CHECKED;
    cbUnchecked:
      DrawState := DFCS_BUTTONCHECK;
    else // cbGrayed
      DrawState := DFCS_BUTTON3STATE or DFCS_CHECKED;
  end;
  if not AEnabled then
    DrawState := DrawState or DFCS_INACTIVE;
  with Canvas do
  begin
    if Flat then
    begin
      { Remember current clipping region }
      SaveRgn := CreateRectRgn(0,0,0,0);
      GetClipRgn(Handle, SaveRgn);
      { Clip 3d-style checkbox to prevent flicker }
      with DrawRect do
        Rgn := CreateRectRgn(Left + 2, Top + 2, Right - 2, Bottom - 2);
      SelectClipRgn(Handle, Rgn);
      DeleteObject(Rgn);
    end;
    DrawFrameControl(Handle, DrawRect, DFC_BUTTON, DrawState);
    if Flat then
    begin
      SelectClipRgn(Handle, SaveRgn);
      DeleteObject(SaveRgn);
      { Draw flat rectangle in-place of clipped 3d checkbox above }
      OldBrushStyle := Brush.Style;
      OldBrushColor := Brush.Color;
      OldPenColor := Pen.Color;
      Brush.Style := bsClear;
      Pen.Color := clBtnShadow;
      with DrawRect do
        Rectangle(Left + 1, Top + 1, Right - 1, Bottom - 1);
      Brush.Style := OldBrushStyle;
      Brush.Color := OldBrushColor;
      Pen.Color := OldPenColor;
    end;
  end;
end;
*)

procedure TCheckStateListBox.SetChecked(Index: Integer; Checked: Boolean);
begin
  if Checked <> GetChecked(Index) then
  begin
    TCheckStateListBoxDataWrapper(GetWrapper(Index)).SetChecked(Checked);
    InvalidateCheck(Index);
  end;
end;

procedure TCheckStateListBox.SetItemEnabled(Index: Integer; const Value: Boolean);
begin
  if Value <> GetItemEnabled(Index) then
  begin
    TCheckStateListBoxDataWrapper(GetWrapper(Index)).Disabled := not Value;
    InvalidateCheck(Index);
  end;
end;

procedure TCheckStateListBox.SetCheckedState(Index: Integer; AState: TCheckBoxState);
begin
  if AState <> GetCheckedState(Index) then
  begin
    TCheckStateListBoxDataWrapper(GetWrapper(Index)).CheckedState := AState;
    InvalidateCheck(Index);
  end;
end;
    
procedure TCheckStateListBox.InvalidateCheck(Index: Integer);
var
  R: TRect;
begin
  R := ItemRect(Index);
  if not UseRightToLeftAlignment then
    R.Right := R.Left + GetCheckWidth
  else
    R.Left := R.Right - GetCheckWidth;
  InvalidateRect(Handle, @R, not (csOpaque in ControlStyle));
  UpdateWindow(Handle);
end;
    
function TCheckStateListBox.GetChecked(Index: Integer): Boolean;
begin
  if HaveWrapper(Index) then
    Result := TCheckStateListBoxDataWrapper(GetWrapper(Index)).GetChecked
  else
    Result := False;
end;

function TCheckStateListBox.GetItemEnabled(Index: Integer): Boolean;
begin
  if HaveWrapper(Index) then
    Result := not TCheckStateListBoxDataWrapper(GetWrapper(Index)).Disabled
  else
    Result := True;
end;

function TCheckStateListBox.GetCheckedState(Index: Integer): TCheckBoxState;
begin
  if HaveWrapper(Index) then
    Result := TCheckStateListBoxDataWrapper(GetWrapper(Index)).CheckedState
  else
    Result := TCheckStateListBoxDataWrapper.GetDefaultCheckedState;
end;

procedure TCheckStateListBox.KeyPress(var Key: Char);
begin
  inherited;
  if (Key = ' ') then ToggleClickCheck(ItemIndex);
end;

procedure TCheckStateListBox.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  Index: Integer;
  W : Integer;
begin
  inherited;
  if Button = mbLeft then
  begin
    Index := ItemAtPos(Point(X,Y),True);
    if (Index <> -1) and GetItemEnabled(Index) then
      if not UseRightToLeftAlignment then
      begin
        W := X - ItemRect(Index).Left;
        if W < GetCheckWidth then
          ToggleClickCheck(Index)
        else if (GetCheckWidth < W) and (W < (GetCheckWidth + GetStateWidth)) then
          ClickState;
      end
      else
      begin
        Dec(X, ItemRect(Index).Right - GetCheckWidth - GetStateWidth);
        if (X > 0) and (X < GetCheckWidth) then
          ToggleClickCheck(Index)
      end;
  end;
end;

procedure TCheckStateListBox.ToggleClickCheck;
var
  CheckedState: TCheckBoxState;
begin
  if (Index >= 0) and (Index < Items.Count) and GetItemEnabled(Index) then
  begin
    CheckedState := Self.CheckedState[Index];
    case CheckedState of
      cbUnchecked:
        if AllowGrayed then CheckedState := cbGrayed else CheckedState := cbChecked;
      cbChecked: CheckedState := cbUnchecked;
      cbGrayed: CheckedState := cbChecked;
    end;
    Self.CheckedState[Index] := CheckedState;
    ClickCheck;
  end;
end;

procedure TCheckStateListBox.ClickCheck;
begin
  if Assigned(FOnClickCheck) then FOnClickCheck(Self);
end;

function TCheckStateListBox.GetItemData(Index: Integer): LongInt;
begin
  Result := 0;
  if HaveWrapper(Index) then
    Result := TCheckStateListBoxDataWrapper(GetWrapper(Index)).FData;
end;

function TCheckStateListBox.GetWrapper(Index: Integer): TObject;
begin
  Result := ExtractWrapper(Index);
  if Result = nil then
    Result := CreateWrapper(Index);
end;

function TCheckStateListBox.ExtractWrapper(Index: Integer): TObject;
begin
  Result := TCheckStateListBoxDataWrapper(inherited GetItemData(Index));
  if LB_ERR = Integer(Result) then
    raise EListError.CreateResFmt(@SListIndexError, [Index]);
  if (Result <> nil) and (not (Result is TCheckStateListBoxDataWrapper)) then
    Result := nil;
end;

function TCheckStateListBox.InternalGetItemData(Index: Integer): LongInt;
begin
  Result := inherited GetItemData(Index);
end;

procedure TCheckStateListBox.InternalSetItemData(Index: Integer; AData: LongInt);
begin
  inherited SetItemData(Index, AData);
end;

function TCheckStateListBox.CreateWrapper(Index: Integer): TObject;
begin
  Result := TCheckStateListBoxDataWrapper.Create;
  inherited SetItemData(Index, LongInt(Result));
end;

function TCheckStateListBox.HaveWrapper(Index: Integer): Boolean;
begin
  Result := ExtractWrapper(Index) <> nil;
end;

procedure TCheckStateListBox.SetItemData(Index: Integer; AData: LongInt);
var
  Wrapper: TCheckStateListBoxDataWrapper;
  SaveState: TObject;
begin
  Wrapper := TCheckStateListBoxDataWrapper(GetWrapper(Index));
  Wrapper.FData := AData;
  if FSaveStates <> nil then
    if FSaveStates.Count > 0 then
    begin
      SaveState := FSaveStates[0];
      Wrapper.FCheckedState := GetSaveState(SaveState);
      Wrapper.FDisabled := GetSaveDisabled(SaveState);
      FSaveStates.Delete(0);
    end;
end;

procedure TCheckStateListBox.ResetContent;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
    if HaveWrapper(I) then
      GetWrapper(I).Free;
  inherited;
end;

procedure TCheckStateListBox.DeleteString(Index: Integer);
begin
  if HaveWrapper(Index) then
    GetWrapper(Index).Free;
  inherited;
end;

procedure TCheckStateListBox.SetFlat(Value: Boolean);
begin
  if Value <> FFlat then
  begin
    FFlat := Value;
    Invalidate;
  end;
end;

procedure TCheckStateListBox.WMDestroy(var Msg: TWMDestroy);
var
  i: Integer;
begin
  for i := 0 to Items.Count -1 do
    ExtractWrapper(i).Free;
  inherited;
end;

function TCheckStateListBox.GetState(Index: Integer): Integer;
begin
  if HaveWrapper(Index) then
    Result := TCheckStateListBoxDataWrapper(GetWrapper(Index)).State
  else
    Result := -1;
end;

procedure TCheckStateListBox.SetState(Index: Integer;
  const Value: Integer);
begin
  if Value <> GetState(Index) then
  begin
    TCheckStateListBoxDataWrapper(GetWrapper(Index)).State := Value;
    InvalidateState(Index);
  end;
end;

procedure TCheckStateListBox.InvalidateState(Index: Integer);
var
  R: TRect;
begin
  R := ItemRect(Index);
  if not UseRightToLeftAlignment then
    R.Right := R.Left + GetCheckWidth + GetStateWidth
  else
    R.Left := R.Right - GetCheckWidth - GetStateWidth;
  InvalidateRect(Handle, @R, not (csOpaque in ControlStyle));
  UpdateWindow(Handle);
end;

procedure TCheckStateListBox.SetStateImages(Value: TCustomImageList);
begin
  if StateImages <> nil then
    StateImages.UnRegisterChanges(FStateChangeLink);
  FStateImages := Value;
  if StateImages <> nil then
  begin
    StateImages.RegisterChanges(FStateChangeLink);
    StateImages.FreeNotification(Self);
  end
  else
  begin
    ShowState := False;
  end;
end;

procedure TCheckStateListBox.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = StateImages then StateImages := nil;
  end;
end;

procedure TCheckStateListBox.ImageListChange(Sender: TObject);
begin
  Invalidate;
end;

procedure TCheckStateListBox.SetShowState(const Value: Boolean);
begin
  if Value <> fShowState then
  begin
    if Value and not Assigned(fStateImages) then Exit;
    fShowState := Value;
    Invalidate;
  end;
end;

function TCheckStateListBox.GetStateWidth: Integer;
begin
  Result := 0;
  if ShowState then begin
    if Assigned(fStateImages) then
      Result := FStateImages.Width
    else
      Result := 16;
    Inc(Result, 2);
    Result := Min(Result, ItemHeight);
  end;
end;

procedure TCheckStateListBox.DrawItemState(R: TRect; Index : Integer);
var
  DrawRect: TRect;
//  BMP : TBitmap;
begin
  if not ShowState then Exit;
  DrawRect.Left := R.Left + ((R.Right - R.Left - FCheckWidth - ItemHeight) div 2) + GetCheckWidth - 1;
  DrawRect.Top := R.Top + (R.Bottom - R.Top - FCheckWidth) div 2;
  DrawRect.Right := DrawRect.Left + ItemHeight;
  DrawRect.Bottom := DrawRect.Top + ItemHeight;
  Canvas.FillRect(DrawRect);
  FStateImages.Draw(Canvas, DrawRect.Left, DrawRect.Top, Index);
{
  BMP := TBitmap.Create;
  try
    BMP.Width := FStateImages.Width;
    BMP.Height := FStateImages.Height;
    BMP.Transparent := True;
    FStateImages.GetBitmap(Index, BMP);
    Canvas.StretchDraw(DrawRect, BMP);
  finally
    BMP.Free;
  end;
}
end;

function TCheckStateListBox.GetStateHeight: Integer;
begin
  Result := 0;
  if ShowState then begin
    if Assigned(fStateImages) then
      Result := FStateImages.Height
    else
      Result := 16;
    Inc(Result, 2);
    Result := Min(Result, ItemHeight);
  end;
end;

procedure TCheckStateListBox.ClickState;
begin
  if Assigned(FOnClickState) then FOnClickState(Self);
end;

procedure TCheckStateListBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  Index: Integer;
  W : Integer;
  CheckedState: TCheckBoxState;
  tmpHint : string;
begin
  inherited;
  tmpHint := fSavedHint;
  Index := ItemAtPos(Point(X,Y),True);
  if (Index <> -1) and GetItemEnabled(Index) then
    if not UseRightToLeftAlignment then
    begin
      W := X - ItemRect(Index).Left;
      if W < GetCheckWidth then
      begin
        CheckedState := Self.CheckedState[Index];
        DoGetCheckHint(CheckedState, tmpHint);
      end
      else if (GetCheckWidth < W) and (W < (GetCheckWidth + GetStateWidth)) then
      begin
        DoGetStateHint(State[Index], tmpHint);
      end;
    end
    else
    begin
      Dec(X, ItemRect(Index).Right - GetCheckWidth - GetStateWidth);
      if (X > 0) and (X < GetCheckWidth) then
      begin
        CheckedState := Self.CheckedState[Index];
        DoGetCheckHint(CheckedState, tmpHint);
      end;
    end;
  if tmpHint <> Hint then
  begin
    Hint := tmpHint;
    Application.ActivateHint(Mouse.CursorPos);
  end;
end;

procedure TCheckStateListBox.DoGetStateHint(State: Integer;
  var Hint: string);
begin
  if Assigned(FOnGetStateHint) then
    FOnGetStateHint(Self, State, Hint);
end;

procedure TCheckStateListBox.DoGetCheckHint(State: TCheckBoxState;
  var Hint: string);
begin
  if Assigned(FOnGetCheckHint) then
    FOnGetCheckHint(Self, State, Hint);
end;

procedure TCheckStateListBox.Loaded;
begin
  inherited;
  fSavedHint := Hint;
end;

function TCheckStateListBox.GetHeader(Index: Integer): Boolean;
begin
  if HaveWrapper(Index) then
    Result := TCheckStateListBoxDataWrapper(GetWrapper(Index)).Header
  else
    Result := False;
end;

procedure TCheckStateListBox.SetHeader(Index: Integer;
  const Value: Boolean);
begin
  if Value <> GetHeader(Index) then
  begin
    TCheckStateListBoxDataWrapper(GetWrapper(Index)).Header := Value;
    InvalidateCheck(Index);
  end;
end;

procedure TCheckStateListBox.SetHeaderBackgroundColor(const Value: TColor);
begin
  if Value <> HeaderBackgroundColor then
  begin
    FHeaderBackgroundColor := Value;
    Invalidate;
  end;
end;

procedure TCheckStateListBox.SetHeaderColor(const Value: TColor);
begin
  if Value <> HeaderColor then
  begin
    FHeaderColor := Value;
    Invalidate;
  end;
end;

initialization
  GetCheckSize;

end.
