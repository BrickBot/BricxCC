unit uNXTWatchCommon;

interface

uses
  Classes;

type
  TWatchType = (wtCharacter, wtString, wtDecimal, wtHexadecimal, wtFloatingPoint,
    wtPointer, wtRecord, wtDefault, wtMemoryDump);

  TWatchInfo = class(TCollectionItem)
  private
    fExpression: string;
    fGroupName: string;
    fEnabled : boolean;
    fAllowFunc : boolean;
    fWatchType : TWatchType;
    fRepeatCount: integer;
    fDigits: integer;
    fValue : string;
    function GetValue: string;
  protected
    procedure AssignTo(Dest: TPersistent); override;
  public
    constructor Create(ACollection: TCollection); override;
    procedure Refresh;
    property Expression : string read fExpression write fExpression;
    property GroupName : string read fGroupName write fGroupName;
    property Enabled : boolean read fEnabled write fEnabled;
    property AllowFunctionCalls : boolean read fAllowFunc write fAllowFunc;
    property WatchType : TWatchType read fWatchType write fWatchType;
    property RepeatCount : integer read fRepeatCount write fRepeatCount;
    property Digits : integer read fDigits write fDigits;
    property Value : string read GetValue;
  end;

  TWatchList = class(TCollection)
  private
    function GetItem(Index: Integer): TWatchInfo;
    procedure SetItem(Index: Integer; const Value: TWatchInfo);
  public
    constructor Create; virtual;
    function  Add: TWatchInfo;
    function  Insert(Index: Integer): TWatchInfo;
    procedure DisableAllWatches;
    procedure EnableAllWatches;
    procedure Refresh;
    property  Items[Index: Integer]: TWatchInfo read GetItem write SetItem; default;
  end;

  function TheWatchList : TWatchList;

implementation

uses
  SysUtils;

var
  fWatchList : TWatchList;

const
  DISABLED_VALUE = '<disabled>';
  NOPROC_VALUE   = '(process not accessible)';
  DEFAULT_GROUP  = 'Watches';

function TheWatchList : TWatchList;
begin
  if not Assigned(fWatchList) then
  begin
    fWatchList := TWatchList.Create;
  end;
  Result := fWatchList;
end;

{ TWatchInfo }

procedure TWatchInfo.AssignTo(Dest: TPersistent);
var
  wi : TWatchInfo;
begin
  if Dest is TWatchInfo then
  begin
    wi := TWatchInfo(Dest);
    wi.GroupName          := GroupName;
    wi.Expression         := Expression;
    wi.Enabled            := Enabled;
    wi.AllowFunctionCalls := AllowFunctionCalls;
    wi.WatchType          := WatchType;
    wi.RepeatCount        := RepeatCount;
    wi.Digits             := Digits;
  end
  else
    inherited;
end;

constructor TWatchInfo.Create(ACollection: TCollection);
begin
  inherited;
  fExpression  := '';
  fGroupName   := DEFAULT_GROUP;
  fRepeatCount := 0;
  fDigits      := 18;
  fWatchType   := wtDefault;
  fEnabled     := False;
  fAllowFunc   := False;
  fValue       := DISABLED_VALUE;
end;

function TWatchInfo.GetValue: string;
begin
  if Enabled then
    Result := fValue
  else
    Result := DISABLED_VALUE;
end;

procedure TWatchInfo.Refresh;
begin
  if Enabled then
  begin
    // attempt to get the current watch value using the
    // watch type, expression, repeat count, and digits settings
    fValue := NOPROC_VALUE;
  end
  else
    fValue := DISABLED_VALUE;
end;

{ TWatchList }

function TWatchList.Add: TWatchInfo;
begin
  Result := TWatchInfo(inherited Add);
end;

constructor TWatchList.Create;
begin
  inherited Create(TWatchInfo);
end;

procedure TWatchList.DisableAllWatches;
var
  i : integer;
begin
  // disable all watches in our list
  for i := 0 to Count - 1 do
  begin
    Items[i].Enabled := False;
  end;
end;

procedure TWatchList.EnableAllWatches;
var
  i : integer;
begin
  // enable all watches in our list
  for i := 0 to Count - 1 do
  begin
    Items[i].Enabled := True;
  end;
end;

function TWatchList.GetItem(Index: Integer): TWatchInfo;
begin
  Result := TWatchInfo(inherited GetItem(Index));
end;

function TWatchList.Insert(Index: Integer): TWatchInfo;
begin
  result := TWatchInfo(inherited Insert(Index));
end;

procedure TWatchList.Refresh;
var
  i : integer;
begin
  // refresh all watches in our list
  for i := 0 to Count - 1 do
    Items[i].Refresh;
end;

procedure TWatchList.SetItem(Index: Integer; const Value: TWatchInfo);
begin
  inherited SetItem(Index, Value);
end;

initialization
  fWatchList := nil;

finalization
  FreeAndNil(fWatchList);

end.
