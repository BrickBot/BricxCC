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
unit uCompStatus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmCompStatus = class(TForm)
    edtMemo: TMemo;
    btnClose: TButton;
    procedure FormShow(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Clear;
    procedure AddMessage(const msg : string);
  end;

var
  frmCompStatus: TfrmCompStatus;

implementation

{$R *.dfm}

procedure TfrmCompStatus.FormShow(Sender: TObject);
begin
  Clear;
end;

procedure TfrmCompStatus.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmCompStatus.AddMessage(const msg: string);
begin
  edtMemo.Lines.Add(TimeToStr(Now) + ' ' + msg);
end;

procedure TfrmCompStatus.Clear;
begin
  edtMemo.Lines.Clear;
end;

end.
