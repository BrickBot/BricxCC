unit uInstanceControl;

interface

uses
  Windows, Forms, SysUtils, Classes;

type
  EInstanceControl = class(Exception);

  TMaxInstancesReachedEvent = procedure(Sender :TObject; const LastInstanceHandle :THandle) of object;

  TInstanceControl = class(TComponent)
  private
    fMappingName : string;
    fMappingHandle: THandle;

    fRemoveMe : boolean;

    fEnabled: boolean;
    fMaxInstances: Cardinal;
    fOnMaxInstancesReached: TMaxInstancesReachedEvent;
  protected
    procedure Loaded; override;
    procedure MaxInstancesReached(const LastInstanceHandle : THandle);
  public
    constructor Create(AOwner :TComponent); override;
    destructor Destroy; override;
  published
    property Enabled : boolean read fEnabled write fEnabled;
    property MaxInstances : Cardinal read fMaxInstances write fMaxInstances;

    property OnMaxInstancesReached :TMaxInstancesReachedEvent read fOnMaxInstancesReached write fOnMaxInstancesReached;
  end;

implementation

type
  PInstanceInfo = ^TInstanceInfo;
  TInstanceInfo = packed record
    PreviousHandle : THandle;
    RunCounter : Cardinal;
  end;

var
  ThisOnce : TComponent = nil;
  InstanceInfo : PInstanceInfo;

{ TInstanceControl }

constructor TInstanceControl.Create(AOwner: TComponent);
begin
  if ThisOnce <> Nil then
  begin
    raise EInstanceControl.Create('Only one copy of this component can be dropped on a form!');
  end
  else
  begin
    inherited;
    ThisOnce := Self;

    fRemoveMe := True;

    fEnabled := True;
    fMaxInstances := 1;
  end;
end;(*Create*)

destructor TInstanceControl.Destroy;
begin
  ThisOnce := nil;

  if (csDesigning in ComponentState) then
  begin
    inherited;
    Exit;
  end;

  //remove this instance
  if Enabled AND fRemoveMe then
  begin
    fMappingHandle := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, PChar(fMappingName));
    if fMappingHandle <> 0 then
    begin
      InstanceInfo := MapViewOfFile(fMappingHandle,
                                  FILE_MAP_ALL_ACCESS,
                                  0,
                                  0,
                                  SizeOf(TInstanceInfo));

      InstanceInfo^.RunCounter := -1 + InstanceInfo^.RunCounter;
    end
    else
      RaiseLastOSError;
  end;

  if Assigned(InstanceInfo) then UnmapViewOfFile(InstanceInfo);
  if fMappingHandle <> 0 then CloseHandle(fMappingHandle);

  inherited;
end; (*Destroy*)

procedure TInstanceControl.MaxInstancesReached(const LastInstanceHandle: THandle);
begin
  {Tell Delphi to hide it's hidden application window to avoid}
  {a "flash" on the taskbar if we halt due to max instances reached condition}
  Application.ShowMainForm := False;
  ShowWindow(Application.Handle, SW_HIDE);

  //notify this instance 
  if Assigned(fOnMaxInstancesReached) then OnMaxInstancesReached(self, LastInstanceHandle);

  if IsIconic(LastInstanceHandle) then
    ShowWindow(LastInstanceHandle, SW_RESTORE);
  SetForegroundWindow(LastInstanceHandle);

  Application.Terminate;
end; (*InstanceFound*)

procedure TInstanceControl.Loaded;
var
  InstanceInfo: PInstanceInfo;
begin
  inherited;

  if (csDesigning in ComponentState) then Exit;

  if not Enabled then Exit;




  fMappingName :=StringReplace(ParamStr(0),'\','',[rfReplaceAll, rfIgnoreCase]);
  fMappingName :=StringReplace(fMappingName,' ','',[rfReplaceAll, rfIgnoreCase]);

  fMappingHandle := CreateFileMapping($FFFFFFFF,
                                     nil,
                                     PAGE_READWRITE,
                                     0,
                                     SizeOf(TInstanceInfo),
                                     PChar(fMappingName));

  if fMappingHandle = 0 then
    RaiseLastOSError
  else
  begin
    if GetLastError <> ERROR_ALREADY_EXISTS then
    begin
      InstanceInfo := MapViewOfFile(fMappingHandle,
                                    FILE_MAP_ALL_ACCESS,
                                    0,
                                    0,
                                    SizeOf(TInstanceInfo));

      InstanceInfo^.PreviousHandle := Application.Handle;
      InstanceInfo^.RunCounter := 1;
    end
    else //already runing
    begin
      fMappingHandle := OpenFileMapping(FILE_MAP_ALL_ACCESS, False, PChar(fMappingName));
      if fMappingHandle <> 0 then
      begin
        InstanceInfo := MapViewOfFile(fMappingHandle,
                                      FILE_MAP_ALL_ACCESS,
                                      0,
                                      0,
                                      SizeOf(TInstanceInfo));

        if InstanceInfo^.RunCounter >= MaxInstances then
        begin
          fRemoveMe:=False;
          MaxInstancesReached(InstanceInfo^.PreviousHandle);
        end
        else
        begin
          InstanceInfo^.PreviousHandle := Application.Handle;
          InstanceInfo^.RunCounter := 1 + InstanceInfo^.RunCounter;
        end
      end;
    end;
  end;

end; (*Loaded*)

initialization
finalization
   if ThisOnce <> nil then ThisOnce.Free;

end.
