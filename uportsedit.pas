unit uportsedit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ComCtrls, StdCtrls, ActnList, StdActns;

type

  { TfrmPortsEdit }

  TfrmPortsEdit = class(TForm)
    Save1: TAction;
    AddNXT1: TAction;
    ActionList1: TActionList;
    EditCopy1: TEditCopy;
    EditCut1: TEditCut;
    EditDelete1: TEditDelete;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    lstImages: TImageList;
    mmoPorts: TMemo;
    barMain: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    procedure AddNXT1Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Save1Execute(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end; 

implementation

uses
  brick_common, uSpirit;

function GetBrickResourceString(const bBluetooth : boolean) : string;
var
  name, addr : string;
  btsig, memfree : cardinal;
begin
  if BrickComm.NXTGetDeviceInfo(name, addr, btsig, memfree) then
  begin
    if bBluetooth then
    begin
      Result := Format('BTH::%s=BTH::%s::%s::1', [name, name, addr]);
    end
    else
    begin
      addr := StringReplace(addr, ':', '', [rfReplaceAll]);
      Result := Format('%s=USB0::0X0694::0X0002::%s::RAW', [addr, addr]);
    end;
  end;
end;

{ TfrmPortsEdit }

procedure TfrmPortsEdit.AddNXT1Execute(Sender: TObject);
begin
  if BrickComm.Open then
  begin
    mmoPorts.Lines.Add(GetBrickResourceString(False));
    mmoPorts.Lines.Add(GetBrickResourceString(True));
  end;
end;

procedure TfrmPortsEdit.FormCreate(Sender: TObject);
begin
  if FileExists(GetInitFilename) then
  begin
    mmoPorts.Lines.LoadFromFile(GetInitFilename);
  end;
end;

procedure TfrmPortsEdit.Save1Execute(Sender: TObject);
begin
  mmoPorts.Lines.SaveToFile(GetInitFilename);
end;

initialization
  {$I uportsedit.lrs}

end.
