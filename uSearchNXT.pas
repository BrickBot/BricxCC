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
 * Portions created by John Hansen are Copyright (C) 2009-2012 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uSearchNXT;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

uses
{$IFDEF FPC}
  LResources,
{$ENDIF}
  Controls, Forms, ExtCtrls, StdCtrls, ComCtrls, Classes;

type
  TfrmSearchNXT = class(TForm)
    barProgress: TProgressBar;
    tmrMain: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure tmrMainTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    function GetText: string;
    procedure SetText(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    procedure Done;
    property Text : string read GetText write SetText;
  end;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ENDIF}

uses
  Math, SysUtils;

{ TfrmSearchNXT }

function TfrmSearchNXT.GetText: string;
begin
  Result := Caption;
end;

procedure TfrmSearchNXT.SetText(const Value: string);
begin
  Caption := Value;
end;

procedure TfrmSearchNXT.FormCreate(Sender: TObject);
begin
  barProgress.Position := barProgress.Min;
end;

procedure TfrmSearchNXT.tmrMainTimer(Sender: TObject);
begin
  barProgress.Position := Min(barProgress.Position + 1, barProgress.Max);
  if barProgress.Position = barProgress.Max then
    barProgress.Position := barProgress.Min;
end;

procedure TfrmSearchNXT.Done;
begin
  barProgress.Position := barProgress.Max;
  Application.ProcessMessages;
  Sleep(100);
end;

procedure TfrmSearchNXT.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  CanClose := False;
end;

{$IFDEF FPC}
initialization
  {$i uSearchNXT.lrs}
{$ENDIF}

end.