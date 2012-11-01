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
 * Portions of this code are covered under the GExperts license
 * http://www.gexperts.org/license.html
 *
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uEditorShortcut;

interface

uses  Classes, Controls, StdCtrls, ComCtrls, Forms, uNewHotKey;

type
  TfmEditorShortcut = class(TForm)
    gbxShortCut: TGroupBox;
    lblShortCut: TLabel;
    btnCancel: TButton;
    btnOK: TButton;
    hkShortCut2: TEdit;
    procedure FormCreate(Sender: TObject);
  private
    hkShortCut: TBricxCCHotKey;
    procedure CreateHotKeyEdits;
    function GetShortCut: TShortCut;
    procedure SetShortCut(const Value: TShortCut);
  public
    property ShortCut : TShortCut read GetShortCut write SetShortCut;
  end;

implementation

{$R *.dfm}

uses
  uGuiUtils;

procedure TfmEditorShortcut.CreateHotKeyEdits;
begin
  hkShortCut  := TBricxCCHotKey.Create(Self);
  CloneHotKey(hkShortCut, hkShortCut2);
end;

procedure TfmEditorShortcut.FormCreate(Sender: TObject);
begin
  CreateHotKeyEdits;
end;

function TfmEditorShortcut.GetShortCut: TShortCut;
begin
  Result := hkShortCut.HotKey;
end;

procedure TfmEditorShortcut.SetShortCut(const Value: TShortCut);
begin
  hkShortCut.HotKey := Value;
end;

end.