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
unit EditCodeTemplate;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Classes, Controls, Forms, StdCtrls;

type
  TfrmEditCodeTemplate = class(TForm)
    lblName: TLabel;
    edtName: TEdit;
    btnOK: TButton;
    btnCancel: TButton;
    lblDesc: TLabel;
    edtDesc: TEdit;
    btnHelp: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
  private
    { Private declarations }
    fIsNew : boolean;
    function GetDesc: string;
    function GetTemplateName: string;
    procedure SetDesc(const Value: string);
    procedure SetTemplateName(const Value: string);
    function GetNew: boolean;
    procedure SetNew(const Value: boolean);
    procedure RefreshCaption;
  public
    { Public declarations }
    property TemplateName : string read GetTemplateName write SetTemplateName;
    property Description : string read GetDesc write SetDesc;
    property NewTemplate : boolean read GetNew write SetNew;
  end;

implementation

uses
  uLocalizedStrings;

{$IFNDEF FPC}
{$R *.DFM}
{$ENDIF}

{ TfrmEditCodeTemplate }

function TfrmEditCodeTemplate.GetDesc: string;
begin
  Result := edtDesc.Text;
end;

function TfrmEditCodeTemplate.GetNew: boolean;
begin
  Result := fIsNew;
end;

function TfrmEditCodeTemplate.GetTemplateName: string;
begin
  Result := edtName.Text;
end;

procedure TfrmEditCodeTemplate.SetDesc(const Value: string);
begin
  edtDesc.Text := Value;
end;

procedure TfrmEditCodeTemplate.SetNew(const Value: boolean);
begin
  fIsNew := Value;
  RefreshCaption;
end;

procedure TfrmEditCodeTemplate.SetTemplateName(const Value: string);
begin
  edtName.Text := Value;
end;

procedure TfrmEditCodeTemplate.FormCreate(Sender: TObject);
begin
  fIsNew := False;
  RefreshCaption;
end;

procedure TfrmEditCodeTemplate.RefreshCaption;
begin
  if NewTemplate then
    Caption := sNewTemplate
  else
    Caption := sEditTemplate;
end;

procedure TfrmEditCodeTemplate.btnHelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

{$IFDEF FPC}
initialization
  {$i EditCodeTemplate.lrs}
{$ENDIF}

end.
