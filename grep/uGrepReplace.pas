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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uGrepReplace;

interface

uses
  Classes, Controls, StdCtrls, Forms,
  uGrepExpert, uGrepBackend;

type
  TfmGrepReplace = class(TForm)
    lblWith: TLabel;
    cbReplace: TComboBox;
    btnOK: TButton;
    btnCancel: TButton;
    btnHelp: TButton;
    lblIn: TLabel;
    lblInString: TLabel;
    lblReplace: TLabel;
    lblReplaceString: TLabel;
    procedure btnHelpClick(Sender: TObject);
  private
    FGrepExpert: TGrepExpert;
    procedure LoadFormSettings;
    procedure SaveFormSettings;
    procedure SetSearchString(const Value: string);
    procedure SetReplaceInString(const Value: string);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure RetrieveSettings(var Value: TGrepSettings);
    property GrepExpert: TGrepExpert read FGrepExpert;
    property SearchString: string write SetSearchString;
    property ReplaceInString: string write SetReplaceInString;
  end;

implementation

{$R *.dfm}

uses SysUtils,
  uGrepCommonUtils, uGrepResults;

constructor TfmGrepReplace.Create(AOwner: TComponent);
begin
  inherited;
  LoadFormSettings;
end;

destructor TfmGrepReplace.Destroy;
begin
  SaveFormSettings;
  inherited;
end;

procedure TfmGrepReplace.SaveFormSettings;
begin
  AddMRUString(cbReplace.Text, FGrepExpert.ReplaceList, False);
end;

procedure TfmGrepReplace.LoadFormSettings;
resourcestring
  SGrepResultsNotActive = 'The Grep Results window is not active';
begin
  if not Assigned(fmGrepResults) then
    raise Exception.Create(SGrepResultsNotActive);

  FGrepExpert := fmGrepResults.GrepExpert;
  cbReplace.Items.Assign(FGrepExpert.ReplaceList);

  if cbReplace.Items.Count > 0 then
  begin
    cbReplace.Text := cbReplace.Items[0];
    cbReplace.SelectAll;
  end;
end;

procedure TfmGrepReplace.RetrieveSettings(var Value: TGrepSettings);
begin
  Value.Replace := cbReplace.Text;
end;

procedure TfmGrepReplace.btnHelpClick(Sender: TObject);
begin
//  GxContextHelp(Self, 1);
end;

procedure TfmGrepReplace.SetSearchString(const Value: string);
begin
  lblReplaceString.Caption := Value;
end;

procedure TfmGrepReplace.SetReplaceInString(const Value: string);
begin
  lblInString.Caption := Value;
end;

end.