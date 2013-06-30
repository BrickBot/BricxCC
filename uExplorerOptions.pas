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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uExplorerOptions;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFNDEF FPC}
  CheckListState,
{$ELSE}
  LResources,
  CheckLst,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls, ComCtrls, ImgList, ExtCtrls,
  uParseCommon;

type
{$IFDEF FPC}
  TCheckStateListBox = class(TCheckListBox);
{$ENDIF}
  TfrmExplorerOptions = class(TForm)
    ilStateImages: TImageList;
    pnlBottom: TPanel;
    pnlTop: TPanel;
    pagOptions: TPageControl;
    shtExplorer: TTabSheet;
    lblCategories: TLabel;
    grpOptions: TGroupBox;
    chkAutoExplorer: TCheckBox;
    btnOK: TButton;
    btnCancel: TButton;
    pnlCategories: TPanel;
    chkDeclarationSyntax: TCheckBox;
    grpSorting: TGroupBox;
    radAlphaSort: TRadioButton;
    radSourceSort: TRadioButton;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
{$IFNDEF FPC}
    procedure lstExpOptionsClickState(Sender: TObject);
    procedure lstExpOptionsGetCheckHint(Sender: TObject; State: TCheckBoxState; var Hint: String);
    procedure lstExpOptionsGetStateHint(Sender: TObject; State: Integer; var Hint: String);
{$ENDIF}
    procedure lstExpOptionsDragDrop(Sender, Source: TObject; X,
      Y: Integer);
    procedure lstExpOptionsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure LoadCategories;
    function GetCategorySort : string;
    procedure SetCategorySort(aStr : string);
  public
    { Public declarations }
    lstExpOptions: TCheckStateListBox;
    procedure ConfigureForm(CEP : TCodeExplorerProperties);
    procedure UpdateDefaults(var CEP : TCodeExplorerProperties);
  end;

var
  frmExplorerOptions: TfrmExplorerOptions;

implementation

uses
  Graphics, uLocalizedStrings;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

procedure TfrmExplorerOptions.FormCreate(Sender: TObject);
begin
  pnlCategories.BevelOuter := bvNone;
  lstExpOptions := TCheckStateListBox.Create(Self);
  with lstExpOptions do
  begin
    Name := 'lstExpOptions';
    Parent := pnlCategories;
    Align := alClient;
    DragMode := dmAutomatic;
    ShowHint := True;
    OnDragDrop := lstExpOptionsDragDrop;
    OnDragOver := lstExpOptionsDragOver;
    Color := clActiveBorder;
    HelpContext := 30009;
{$IFNDEF FPC}
    StateImages := ilStateImages;
    ShowState := True;
    OnClickState := lstExpOptionsClickState;
    OnGetCheckHint := lstExpOptionsGetCheckHint;
    OnGetStateHint := lstExpOptionsGetStateHint;
{$ENDIF}
  end;
  LoadCategories;
  lblCategories.FocusControl := lstExpOptions;
  chkAutoExplorer.Checked := True;
  radAlphaSort.Checked := True;
end;

procedure TfrmExplorerOptions.lstExpOptionsDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := Source = Sender;
end;

procedure TfrmExplorerOptions.lstExpOptionsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  i, s : integer;
begin
  s := lstExpOptions.ItemIndex;
  i := lstExpOptions.ItemAtPos(Point(X, Y), True);
  if i <> -1 then
  begin
    lstExpOptions.Items.Move(s, i);
    lstExpOptions.ItemIndex := i;
  end;
end;

procedure TfrmExplorerOptions.ConfigureForm(CEP: TCodeExplorerProperties);
var
  i : Integer;
  PT : TProcType;
const
  stateVals : array[boolean] of integer = (0, 1);
begin
  chkAutoExplorer.Checked := CEP.AutoShowExplorer;
  chkDeclarationSyntax.Checked := CEP.DeclarationSyntax;
  radAlphaSort.Checked := CEP.UseAlphaSort;
  radSourceSort.Checked := not CEP.UseAlphaSort;
  SetCategorySort(CEP.CategorySort);
  for PT := Low(TProcType) to High(TProcType) do
  begin
    i := lstExpOptions.Items.IndexOf(PROC_TYPES[PT]);
    if i <> -1 then
    begin
      lstExpOptions.Checked[i] := CEP.Visible[PT];
{$IFNDEF FPC}
      lstExpOptions.State[i]   := stateVals[CEP.Expand[PT]];
{$ENDIF}
    end;
  end;
end;

procedure TfrmExplorerOptions.LoadCategories;
var
  i : integer;
  PT : TProcType;
begin
  with lstExpOptions do
  begin
    Items.Clear;
    for PT := Low(TProcType) to High(TProcType) do
    begin
      Items.Add(PROC_TYPES[PT]);
    end;
    for i := 0 to Items.Count - 1 do
    begin
      Checked[i] := True;
{$IFNDEF FPC}
      State[i] := 0;
{$ENDIF}
    end;
  end;
end;

procedure TfrmExplorerOptions.UpdateDefaults(var CEP: TCodeExplorerProperties);
var
  i : integer;
  PT : TProcType;
begin
  CEP.CategorySort := GetCategorySort;
  CEP.DeclarationSyntax := chkDeclarationSyntax.Checked;
  CEP.AutoShowExplorer := chkAutoExplorer.Checked;
  CEP.UseAlphaSort := radAlphaSort.Checked;
  for PT := Low(TProcType) to High(TProcType) do
  begin
    i := lstExpOptions.Items.IndexOf(PROC_TYPES[PT]);
    if i <> -1 then
    begin
      CEP.Visible[PT] := lstExpOptions.Checked[i];
{$IFNDEF FPC}
      CEP.Expand[PT]  := lstExpOptions.State[i] = 1;
{$ELSE}
      CEP.Expand[PT]  := False;
{$ENDIF}
    end;
  end;
end;

function TfrmExplorerOptions.GetCategorySort: string;
var
  i : integer;
begin
  result := '';
  for i := 0 to lstExpOptions.Items.Count - 1 do
  begin
    result := result + lstExpOptions.Items[i];
    if i < lstExpOptions.Items.Count - 1 then
      result := result + ';'
  end;
end;

procedure TfrmExplorerOptions.SetCategorySort(aStr: string);
var
  i, p, n : integer;
  s : string;
begin
  n := 0;
  while aStr <> '' do
  begin
    p := Pos(';', aStr);
    if p = 0 then p := Length(aStr) + 1;
    s := Copy(aStr, 1, p-1);
    Delete(aStr, 1, p);
    i := lstExpOptions.Items.IndexOf(s);
    if i <> -1 then
      lstExpOptions.Items.Move(i, n);
    inc(n);
  end;
end;

{$IFNDEF FPC}
procedure TfrmExplorerOptions.lstExpOptionsClickState(Sender: TObject);
var
  s, i : Integer;
begin
  i := lstExpOptions.ItemIndex;
  if i <> -1 then
  begin
    s := lstExpOptions.State[i];
    if s = 0 then
      lstExpOptions.State[i] := 1
    else
      lstExpOptions.State[i] := 0;
  end;
end;

procedure TfrmExplorerOptions.lstExpOptionsGetCheckHint(Sender: TObject;
  State: TCheckBoxState; var Hint: String);
begin
  case State of
    cbUnchecked : Hint := sHidden;
    cbChecked : Hint := sVisible;
  end;
end;

procedure TfrmExplorerOptions.lstExpOptionsGetStateHint(Sender: TObject;
  State: Integer; var Hint: String);
begin
  case State of
    0 : Hint := sCollapsed;
    1 : Hint := sExpanded;
  end;
end;
{$ENDIF}

procedure TfrmExplorerOptions.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

{$IFDEF FPC}
initialization
  {$i uExplorerOptions.lrs}
{$ENDIF}

end.