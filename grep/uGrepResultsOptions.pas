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
unit uGrepResultsOptions;

interface

uses
  StdCtrls, Dialogs, Controls, ExtCtrls, Classes, Forms, ComCtrls;

type
  TfmGrepResultsOptions = class(TForm)
    gbxMatchList: TGroupBox;
    pnlListFont: TPanel;
    gbxMatchContext: TGroupBox;
    pnlContextFont: TPanel;
    lblContextLines: TLabel;
    btnOK: TButton;
    btnCancel: TButton;
    dlgGrepListFont: TFontDialog;
    dlgGrepContextFont: TFontDialog;
    pnlMatchLineColor: TPanel;
    dlgContextFontColor: TColorDialog;
    chkGrepMiddle: TCheckBox;
    chkGrepExpandAll: TCheckBox;
    edtContextLines: TEdit;
    udContextLines: TUpDown;
    procedure pnlContextFontClick(Sender: TObject);
    procedure pnlMatchLineColorClick(Sender: TObject);
    procedure pnlListFontClick(Sender: TObject);
  end;

implementation

uses Graphics;

{$R *.dfm}

procedure TfmGrepResultsOptions.pnlContextFontClick(Sender: TObject);
var
  MatchCol: TColor;
begin
  dlgGrepContextFont.Font.Assign(pnlContextFont.Font);
  if dlgGrepContextFont.Execute then begin
    MatchCol := pnlMatchLineColor.Font.Color;
    pnlContextFont.Font.Assign(dlgGrepContextFont.Font);
    pnlContextFont.Refresh;
    pnlMatchLineColor.Font.Assign(dlgGrepContextFont.Font);
    pnlMatchLineColor.Font.Color := MatchCol;
    pnlMatchLineColor.Refresh;
  end;
end;

procedure TfmGrepResultsOptions.pnlMatchLineColorClick(Sender: TObject);
begin
  dlgContextFontColor.Color := pnlMatchLineColor.Font.Color;
  if dlgContextFontColor.Execute then begin
    pnlMatchLineColor.Font.Color := dlgContextFontColor.Color;
    pnlMatchLineColor.Refresh;
  end;
end;

procedure TfmGrepResultsOptions.pnlListFontClick(Sender: TObject);
begin
  dlgGrepListFont.Font.Assign(pnlListFont.Font);
  if dlgGrepListFont.Execute then begin
    pnlListFont.Font.Assign(dlgGrepListFont.Font);
    pnlListFont.Refresh;
  end;
end;

end.