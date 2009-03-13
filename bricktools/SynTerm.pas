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
unit SynTerm;

interface

uses
  Windows, Classes, Messages, SynEdit, CpDrv, SynEditKeyCmds;

type
  TScriptCommentStyle = (scsForth, scsPascal, scsCpp);
  TDataSendResponseEvent = procedure(Sender: TObject; var response : string;
    var abort : Boolean; var display : Boolean) of object;
  TSynTerm = class(TCustomSynEdit)
  private
    fDriver : TUSBPortDriver;
    FOnReceiveData: TReceiveDataEvent;
    fUseHex: Boolean;
    fReceivingData : Word;
    fOnDataSendResponse : TDataSendResponseEvent;
    FICDelay: Word;
    FILDelay: Word;
    fStripComments: Boolean;
    fSkipBlankLines: Boolean;
    fCommentStyle: TScriptCommentStyle;
    function GetBaudRate: TBaudRate;
    function GetCkLineStatus: boolean;
    function GetDataBits: TDataBits;
    function GetEnableDTROnOpen: boolean;
    function GetHwFlow: THwFlowControl;
    function GetInBufSize: DWORD;
    function GetInputTimeOut: DWORD;
    function GetOnReceivePacket: TReceivePacketEvent;
    function GetOutBufSize: DWORD;
    function GetOutputTimeOut: word;
    function GetPacketMode: TPacketMode;
    function GetPacketSize: smallint;
    function GetPacketTimeout: integer;
    function GetParity: TParity;
    function GetPollingDelay: word;
    function GetPort: TPortNumber;
    function GetStopBits: TStopBits;
    function GetSwFlow: TSwFlowControl;
    procedure SetBaudRate(const Value: TBaudRate);
    procedure SetCkLineStatus(const Value: boolean);
    procedure SetDataBits(const Value: TDataBits);
    procedure SetEnableDTROnOpen(const Value: boolean);
    procedure SetHwFlowControl(const Value: THwFlowControl);
    procedure SetInBufSize(const Value: DWORD);
    procedure SetInputTimeout(const Value: DWORD);
    procedure SetOnReceivePacket(const Value: TReceivePacketEvent);
    procedure SetOutBufSize(const Value: DWORD);
    procedure SetOutputTimeout(const Value: word);
    procedure SetPacketMode(const Value: TPacketMode);
    procedure SetPacketSize(const Value: smallint);
    procedure SetPacketTimeout(const Value: integer);
    procedure SetParity(const Value: TParity);
    procedure SetPollingDelay(const Value: word);
    procedure SetPort(const Value: TPortNumber);
    procedure SetStopBits(const Value: TStopBits);
    procedure SetSwFlowControl(const Value: TSwFlowControl);
    function GetPortName: string;
    function GetBaudRateValue: DWORD;
    function GetReadFirstTimeout: Word;
    function GetReadICTimeout: Word;
    function GetWriteTimeout: Word;
    procedure SetReadFirstTimeout(const Value: Word);
    procedure SetReadICTimeout(const Value: Word);
    procedure SetWriteTimeout(const Value: Word);
  private
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
  protected
    procedure SetSelTextExternal(const Value: string); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure HandleReceiveData(Sender: TObject; DataPtr: Pointer; DataSize: Cardinal);
    procedure SetTextHelper(const s : string);
    function ReceiveHexData(DataPtr: Pointer; DataSize: Cardinal) : string;
    procedure CtrlAlphaNumericDown(var Key : Word);
    procedure SetKeystrokes;
    procedure SendDataToTerminal(const data : string);
    procedure DoDataSendResponse(var response : string; var abort : Boolean;
      var display : Boolean);
    function DoStripComments(const line : string) : string;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Connect: boolean;
    procedure Disconnect;
    function Connected: boolean;
    function PortIsUSB : Boolean;
    procedure CommandProcessor(Command: TSynEditorCommand; AChar: char;
      Data: pointer); override;
    procedure PasteFromClipboard;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure Warmup;
    procedure DownloadFile(const aFile : string);
    procedure DownloadScript(aStrings : TStrings);
    property PortName : string read GetPortName;
    property BaudRateValue : DWORD read GetBaudRateValue;
    property ReadFirstTimeout : Word read GetReadFirstTimeout write SetReadFirstTimeout;
    property ReadICTimeout : Word read GetReadICTimeout write SetReadICTimeout;
    property WriteTimeout : Word read GetWriteTimeout write SetWriteTimeout;
    property ScriptCommentStyle : TScriptCommentStyle read fCommentStyle write fCommentStyle;
  published
    property Align;
    property Anchors;
    property Constraints;
    property Color;
    property ActiveLineColor;
    property Ctl3D;
    property ParentCtl3D;
    property Enabled;
    property Font;
    property Height;
    property Name;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop default True;
    property Tag;
    property Visible;
    property Width;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnStartDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
    // custom syn edit properties
    property BorderStyle;
    property ExtraLineSpacing;
    property HideSelection;
    property Highlighter;
    property InsertCaret;
    property InsertMode;
    property Lines;
    property MaxLeftChar;
    property MaxUndo;
    property OverwriteCaret;
    property ReadOnly;
    property RightEdge;
    property RightEdgeColor;
    property ScrollHintColor;
    property ScrollHintFormat;
    property ScrollBars;
    property SelectedColor;
    property SelectionMode;
    property TabWidth;
    property WantTabs;
    // TCustomSynEdit events
    property OnChange;
    property OnCommandProcessed;
    property OnContextHelp;
    property OnDropFiles;
    property OnLineNumber;
    property OnPaint;
    property OnPlaceBookmark;
    property OnProcessCommand;
    property OnProcessUserCommand;
    property OnReplaceText;
    property OnScroll;
    property OnSpecialLineColors;
    property OnStatusChange;
    property OnPaintTransient;
    // USBComDriver properties
    property UseHEX : Boolean read fUseHex write fUseHex default false;
    property Port: TPortNumber read GetPort write SetPort default pnCOM1;
    property BaudRate: TBaudRate read GetBaudRate write SetBaudRate default br2400;
    property DataBits: TDataBits read GetDataBits write SetDataBits default db8BITS;
    property StopBits: TStopBits read GetStopBits write SetStopBits default sb1BITS;
    property Parity: TParity read GetParity write SetParity default ptODD;
    property HwFlow: THwFlowControl read GetHwFlow write SetHwFlowControl default hfNONE;
    property SwFlow: TSwFlowControl read GetSwFlow write SetSwFlowControl default sfNONE;
    property InBufSize: DWORD read GetInBufSize write SetInBufSize default 2048;
    property OutBufSize: DWORD read GetOutBufSize write SetOutBufSize default 2048;
    property PacketSize: smallint read GetPacketSize write SetPacketSize default -1;
    property PacketTimeout: integer read GetPacketTimeout write SetPacketTimeout default -1;
    property PacketMode: TPacketMode read GetPacketMode write SetPacketMode default pmDiscard;
    property PollingDelay: word read GetPollingDelay write SetPollingDelay default 50;
    property EnableDTROnOpen: boolean read GetEnableDTROnOpen write SetEnableDTROnOpen default false;
    property OutputTimeout: word read GetOutputTimeOut write SetOutputTimeout default 500;
    property InputTimeout: DWORD read GetInputTimeOut write SetInputTimeout default 200;
    property CheckLineStatus: boolean read GetCkLineStatus write SetCkLineStatus default false;
    property InterCharacterDelay : Word read FICDelay write FICDelay;
    property InterLineDelay : Word read FILDelay write FILDelay;
    property StripComments : Boolean read fStripComments write fStripComments;
    property SkipBlankLines : Boolean read fSkipBlankLines write fSkipBlankLines;
    property OnReceiveData: TReceiveDataEvent read FOnReceiveData write FOnReceiveData;
    property OnReceivePacket: TReceivePacketEvent read GetOnReceivePacket write SetOnReceivePacket;
    property OnDataSendResponse : TDataSendResponseEvent read fOnDataSendResponse write fOnDataSendResponse;
  end;

implementation

uses
  SysUtils, Clipbrd, Forms;

{ TSynTerm }

procedure TSynTerm.CommandProcessor(Command: TSynEditorCommand;
  AChar: char; Data: pointer);
begin
  if fDriver.Connected then
  begin
    if Command = ecLineBreak then
    begin
      fDriver.SendChar(#13);
      if not PortIsUSB then
        Command := ecNone; // tower echoes the CRLF
    end
    else if Command = ecDeleteLastChar then
    begin
      fDriver.SendChar(#8);
    end;
  end;
  inherited CommandProcessor(Command, AChar, Data);
end;

function TSynTerm.Connect: boolean;
begin
  Result := fDriver.Connect;
  ReadOnly := not fDriver.Connected;
end;

function TSynTerm.Connected: boolean;
begin
  Result := fDriver.Connected;
end;

constructor TSynTerm.Create(AOwner: TComponent);
begin
  inherited;
  fDriver := TUSBPortDriver.Create(Self);
  with fDriver do
  begin
    Name             := 'cpDrv';
    Port             := pnCOM1;
    BaudRate         := br2400;
    Parity           := ptODD;
    HwFlow           := hfNONE;
    EnableDTROnOpen  := False;
    OnReceiveData    := HandleReceiveData;
    ReadFirstTimeout := 10;
    ReadICTimeout    := 0;
    WriteTimeout     := 0;
  end;
  fUseHEX         := False;
  fReceivingData  := 0;
  FILDelay        := 0;
  FICDelay        := 0;
  fStripComments  := False;
  fSkipBlankLines := False;
  Options         := [eoShowScrollHint];
  Gutter.Visible  := False;
  ReadOnly        := True;
  fCommentStyle   := scsForth;
  SetKeystrokes;
end;

procedure TSynTerm.CtrlAlphaNumericDown(var Key: Word);
begin
  Key := 0;
end;

destructor TSynTerm.Destroy;
begin
  inherited;
end;

procedure TSynTerm.Disconnect;
begin
  fDriver.Disconnect;
  ReadOnly := not fDriver.Connected;
end;

function TSynTerm.GetBaudRate: TBaudRate;
begin
  Result := fDriver.BaudRate;
end;

function TSynTerm.GetBaudRateValue: DWORD;
begin
  Result := fDriver.BaudRateValue;
end;

function TSynTerm.GetCkLineStatus: boolean;
begin
  Result := fDriver.CheckLineStatus;
end;

function TSynTerm.GetDataBits: TDataBits;
begin
  Result := fDriver.DataBits;
end;

function TSynTerm.GetEnableDTROnOpen: boolean;
begin
  Result := fDriver.EnableDTROnOpen;
end;

function TSynTerm.GetHwFlow: THwFlowControl;
begin
  Result := fDriver.HwFlow;
end;

function TSynTerm.GetInBufSize: DWORD;
begin
  Result := fDriver.InBufSize;
end;

function TSynTerm.GetInputTimeOut: DWORD;
begin
  Result := fDriver.InputTimeout;
end;

function TSynTerm.GetOnReceivePacket: TReceivePacketEvent;
begin
  Result := fDriver.OnReceivePacket;
end;

function TSynTerm.GetOutBufSize: DWORD;
begin
  Result := fDriver.OutBufSize;
end;

function TSynTerm.GetOutputTimeOut: word;
begin
  Result := fDriver.OutputTimeout;
end;

function TSynTerm.GetPacketMode: TPacketMode;
begin
  Result := fDriver.PacketMode;
end;

function TSynTerm.GetPacketSize: smallint;
begin
  Result := fDriver.PacketSize;
end;

function TSynTerm.GetPacketTimeout: integer;
begin
  Result := fDriver.PacketTimeout;
end;

function TSynTerm.GetParity: TParity;
begin
  Result := fDriver.Parity;
end;

function TSynTerm.GetPollingDelay: word;
begin
  Result := fDriver.PollingDelay;
end;

function TSynTerm.GetPort: TPortNumber;
begin
  Result := fDriver.Port;
end;

function TSynTerm.GetPortName: string;
begin
  Result := fDriver.PortName;
end;

function TSynTerm.GetStopBits: TStopBits;
begin
  Result := fDriver.StopBits;
end;

function TSynTerm.GetSwFlow: TSwFlowControl;
begin
  Result := fDriver.SwFlow;
end;

function StripGarbage(aStr : string; bUSB : Boolean) : string;
var
  i : Integer;
begin
  Result := aStr;
  for i := Length(Result) downto 1 do
  begin
    if Result[i] in [#$0..#$07, #$09, #$0B..#$0C, #$0E..#$19, #$80..#$FF] then
      Delete(Result, i, 1);
  end;
  Result := StringReplace(Result, #10, '', [rfReplaceAll]);
  Result := StringReplace(Result, #8' '#8, '', [rfReplaceAll]);
  Result := StringReplace(Result, ' '#8, '', [rfReplaceAll]);
  Result := StringReplace(Result, #8, '', [rfReplaceAll]);
  Result := StringReplace(Result, #13, #13#10, [rfReplaceAll]);
  if bUSB and ((Result = 'Q') or (Result = 'DQ') or (Result = 'DQD')) then
    Result := 'OK'#13#10;
end;

procedure TSynTerm.HandleReceiveData(Sender: TObject; DataPtr: Pointer;
  DataSize: Cardinal);
var
  s: string;
begin
  Inc(fReceivingData);
  try
    if UseHEX then
      s := ReceiveHexData(DataPtr, DataSize)
    else
    begin
      // Convert incoming data into a string
      s := StringOfChar( ' ', DataSize );
      move( DataPtr^, pchar(s)^, DataSize );

      s := StripGarbage(s, PortIsUSB);
      if s = '' then
        exit;
    end;
//    s := TrimLeft(s);
    if s = '' then s := ' ';
    SetTextHelper(s);
    if Assigned(fOnReceiveData) then
      FOnReceiveData(Sender, DataPtr, DataSize);
  finally
    Dec(fReceivingData);
  end;
end;

procedure TSynTerm.KeyDown(var Key: Word; Shift: TShiftState);
begin
  if not fDriver.Connected then
  begin
    fDriver.Connect;
    if not fDriver.Connected then
      Key := 0;
  end;
  if (Key in [$30..$5A]) and (ssCtrl in Shift) then
    CtrlAlphaNumericDown(Key);
  inherited KeyDown(Key, Shift);
end;

procedure TSynTerm.KeyPress(var Key: Char);
begin
  // Do nothing if not connected
  if fDriver.Connected then
  begin
    fDriver.SendChar(Key);
    if not fDriver.PortIsUSB then
      Key := #0;
  end;
  inherited;
end;

procedure TSynTerm.PasteFromClipboard;
begin
  if not ReadOnly and Clipboard.HasFormat(CF_TEXT) then
  begin
    SelText := Clipboard.AsText
  end;
end;

procedure TSynTerm.CopyToClipboard;
var
  SText: string;
begin
  if SelAvail then begin
    SText := SelText;
    Clipboard.AsText := SText;
  end;
end;

procedure TSynTerm.CutToClipboard;
var
  SText: string;
begin
  if not ReadOnly and SelAvail then begin                                       //jcr 2001-01-16
    SText := SelText;
    SelText := '';
    Clipboard.AsText := SText;
  end;
end;

function TSynTerm.PortIsUSB: Boolean;
begin
  Result := fDriver.PortIsUSB;
end;

function TSynTerm.ReceiveHexData(DataPtr: Pointer;
  DataSize: Cardinal): string;
var
  p : PByte;
  i : Cardinal;
begin
  Result := '';
  i := 0;
  p := DataPtr;
  while i < DataSize do
  begin
    Result := Result + Format('%2.2x', [p^]);
    Inc(p);
    Inc(i);
  end;
end;

procedure TSynTerm.SetBaudRate(const Value: TBaudRate);
begin
  fDriver.BaudRate := Value;
end;

procedure TSynTerm.SetCkLineStatus(const Value: boolean);
begin
  fDriver.CheckLineStatus := Value;
end;

procedure TSynTerm.SetDataBits(const Value: TDataBits);
begin
  fDriver.DataBits := Value;
end;

procedure TSynTerm.SetEnableDTROnOpen(const Value: boolean);
begin
  fDriver.EnableDTROnOpen := Value;
end;

procedure TSynTerm.SetHwFlowControl(const Value: THwFlowControl);
begin
  fDriver.HwFlow := Value;
end;

procedure TSynTerm.SetInBufSize(const Value: DWORD);
begin
  fDriver.InBufSize := Value;
end;

procedure TSynTerm.SetInputTimeout(const Value: DWORD);
begin
  fDriver.InputTimeout := Value;
end;

procedure TSynTerm.SetKeystrokes;
begin
  Keystrokes.Clear;
  with Keystrokes.Add do begin
    Command := ecDeleteChar;
    ShortCut := 46;
  end;
  with Keystrokes.Add do begin
    Command := ecDeleteLastChar;
    ShortCut := 8;
  end;
  with Keystrokes.Add do begin
    Command := ecLineBreak;
    ShortCut := 13;
  end;
  with Keystrokes.Add do begin
    Command := ecUp;
    ShortCut := 38;
  end;
  with Keystrokes.Add do begin
    Command := ecSelUp;
    ShortCut := 8230;
  end;
  with Keystrokes.Add do begin
    Command := ecScrollUp;
    ShortCut := 16422;
  end;
  with Keystrokes.Add do begin
    Command := ecDown;
    ShortCut := 40;
  end;
  with Keystrokes.Add do begin
    Command := ecSelDown;
    ShortCut := 8232;
  end;
  with Keystrokes.Add do begin
    Command := ecScrollDown;
    ShortCut := 16424;
  end;
  with Keystrokes.Add do begin
    Command := ecLeft;
    ShortCut := 37;
  end;
  with Keystrokes.Add do begin
    Command := ecSelLeft;
    ShortCut := 8229;
  end;
  with Keystrokes.Add do begin
    Command := ecWordLeft;
    ShortCut := 16421;
  end;
  with Keystrokes.Add do begin
    Command := ecSelWordLeft;
    ShortCut := 24613;
  end;
  with Keystrokes.Add do begin
    Command := ecRight;
    ShortCut := 39;
  end;
  with Keystrokes.Add do begin
    Command := ecSelRight;
    ShortCut := 8231;
  end;
  with Keystrokes.Add do begin
    Command := ecWordRight;
    ShortCut := 16423;
  end;
  with Keystrokes.Add do begin
    Command := ecSelWordRight;
    ShortCut := 24615;
  end;
  with Keystrokes.Add do begin
    Command := ecPageDown;
    ShortCut := 34;
  end;
  with Keystrokes.Add do begin
    Command := ecSelPageDown;
    ShortCut := 8226;
  end;
  with Keystrokes.Add do begin
    Command := ecPageBottom;
    ShortCut := 16418;
  end;
  with Keystrokes.Add do begin
    Command := ecSelPageBottom;
    ShortCut := 24610;
  end;
  with Keystrokes.Add do begin
    Command := ecPageUp;
    ShortCut := 33;
  end;
  with Keystrokes.Add do begin
    Command := ecSelPageUp;
    ShortCut := 8225;
  end;
  with Keystrokes.Add do begin
    Command := ecPageTop;
    ShortCut := 16417;
  end;
  with Keystrokes.Add do begin
    Command := ecSelPageTop;
    ShortCut := 24609;
  end;
  with Keystrokes.Add do begin
    Command := ecLineStart;
    ShortCut := 36;
  end;
  with Keystrokes.Add do begin
    Command := ecSelLineStart;
    ShortCut := 8228;
  end;
  with Keystrokes.Add do begin
    Command := ecEditorTop;
    ShortCut := 16420;
  end;
  with Keystrokes.Add do begin
    Command := ecSelEditorTop;
    ShortCut := 24612;
  end;
  with Keystrokes.Add do begin
    Command := ecLineEnd;
    ShortCut := 35;
  end;
  with Keystrokes.Add do begin
    Command := ecSelLineEnd;
    ShortCut := 8227;
  end;
  with Keystrokes.Add do begin
    Command := ecEditorBottom;
    ShortCut := 16419;
  end;
  with Keystrokes.Add do begin
    Command := ecSelEditorBottom;
    ShortCut := 24611;
  end;
  with Keystrokes.Add do begin
    Command := ecContextHelp;
    ShortCut := 112;
  end;
  with Keystrokes.Add do begin
    Command := ecSelectAll;
    ShortCut := 16449;
  end;
end;

procedure TSynTerm.SetOnReceivePacket(const Value: TReceivePacketEvent);
begin
  fDriver.OnReceivePacket := Value;
end;

procedure TSynTerm.SetOutBufSize(const Value: DWORD);
begin
  fDriver.OutBufSize := Value;
end;

procedure TSynTerm.SetOutputTimeout(const Value: word);
begin
  fDriver.OutputTimeout := Value;
end;

procedure TSynTerm.SetPacketMode(const Value: TPacketMode);
begin
  fDriver.PacketMode := Value;
end;

procedure TSynTerm.SetPacketSize(const Value: smallint);
begin
  fDriver.PacketSize := Value;
end;

procedure TSynTerm.SetPacketTimeout(const Value: integer);
begin
  fDriver.PacketTimeout := Value;
end;

procedure TSynTerm.SetParity(const Value: TParity);
begin
  fDriver.Parity := Value;
end;

procedure TSynTerm.SetPollingDelay(const Value: word);
begin
  fDriver.PollingDelay := Value;
end;

procedure TSynTerm.SetPort(const Value: TPortNumber);
begin
  fDriver.Port := Value;
end;

procedure TSynTerm.SetStopBits(const Value: TStopBits);
begin
  fDriver.StopBits := Value;
end;

procedure TSynTerm.SetSwFlowControl(const Value: TSwFlowControl);
begin
  fDriver.SwFlow := Value;
end;

procedure TSynTerm.WMPaste(var Message: TMessage);
begin
  PasteFromClipboard;
  Message.Result := ord(True);
end;

procedure TSynTerm.SetSelTextExternal(const Value: string);
begin
  if (fReceivingData > 0) then
    inherited SetSelTextExternal(Value)
  else
    inherited SetSelTextExternal('');
  if fReceivingData = 0 then
    SendDataToTerminal(Value);
end;

procedure TSynTerm.SendDataToTerminal(const data: string);
var
  i, j, dataSize, xOnPos, xOffPos : Integer;
  pData : PChar;
  buffer : array[0..256] of Char;
  SL : TStringList;
  tmp, s, s2 : string;
  abort, display : Boolean;
begin
  fDriver.PausePolling;
  try
    SL := TStringList.Create;
    try
      pData := @buffer[0];
      SL.Text := data;
      for i := 0 to SL.Count - 1 do
      begin
        abort := False;
        tmp := SL[i];
        SetTextHelper(tmp+#13#10);
        if StripComments then
          tmp := DoStripComments(tmp);
        // skip blank lines
        if SkipBlankLines and (Trim(tmp) = '') then
          Continue;
        // end each line with a CRLF
        tmp := Trim(tmp) + #13;
        if FICDelay > 0 then
        begin
          // send one character at a time
          for j := 1 to Length(tmp) do
          begin
            fDriver.SendChar(tmp[j]);
            Sleep(FICDelay);
          end;
        end
        else
          fDriver.SendString(tmp);
        // sleep for the inter-line delay time
        Sleep(FILDelay);
        dataSize := fDriver.ReadData(pData, sizeof(buffer));
        if dataSize > 0 then
        begin
          // Convert incoming data into a string
          s := StringOfChar( ' ', dataSize );
          move( pData^, pchar(s)^, DataSize );
          s2 := StripGarbage(s, PortIsUSB);
          if not PortIsUSB then
          begin
            // special handling for echoing tower (serial)
            j := Pos(tmp, s2);
            if j > 0 then
              Delete(s2, j, Length(tmp));
          end;
          // give component users a chance to abort the download
          // and control whether to show response in terminal window
          DoDataSendResponse(s2, abort, display);
          if display then
            SetTextHelper(s2);
        end;
        if SwFlow = sfXONXOFF then
        begin
          // if pData contained an XOFF character (and not a subsequent XON character)
          // then loop and read until we get an XON character
          xOnPos := Pos(#$11, s);
          xOffPos := Pos(#$13, s);
          if (xOffPos > 0) and (xOnPos < xOffPos) then
          begin
            //
            xOnPos := 0;
            while xOnPos = 0 do
            begin
              s := '';
              dataSize := fDriver.ReadData(pData, sizeof(buffer));
              if dataSize > 0 then
              begin
                // Convert incoming data into a string
                s := StringOfChar( ' ', dataSize );
                move( pData^, pchar(s)^, DataSize );
                s2 := StripGarbage(s, PortIsUSB);
                if not PortIsUSB then
                begin
                  // special handling for echoing tower (serial)
                  j := Pos(tmp, s2);
                  if j > 0 then
                    Delete(s2, j, Length(tmp));
                end;
                // give component users a chance to abort the download
                // and control whether to show response in terminal window
                DoDataSendResponse(s2, abort, display);
                if display then
                  SetTextHelper(s2);
              end;
              xOnPos := Pos(#$11, s);
            end;
          end;
        end;
        Application.ProcessMessages;
        if abort then Break;
      end;
    finally
      SL.Free;
    end;
  finally
    fDriver.ContinuePolling;
  end;
end;

procedure TSynTerm.DoDataSendResponse(var response: string; var abort,
  display: Boolean);
begin
  abort := False;
  display := True;
  if Assigned(fOnDataSendResponse) then
    fOnDataSendResponse(Self, response, abort, display);
end;

procedure TSynTerm.Warmup;
var
  pData : PChar;
  buffer : array[0..256] of Char;
  xOnPos, xOffPos, dataSize : Integer;
  s : string;
begin
  fDriver.PausePolling;
  try
    pData := @buffer[0];
    fDriver.SendString(#13#13);
    Sleep(FILDelay);
    s := '';
    dataSize := fDriver.ReadData(pData, 80);
    if dataSize > 0 then
    begin
      s := StringOfChar( ' ', dataSize );
      move( pData^, pchar(s)^, DataSize );
    end;
    if SwFlow = sfXONXOFF then
    begin
      // if pData contained an XOFF character (and not a subsequent XON character)
      // then loop and read until we get an XON character
      xOnPos := Pos(#$11, s);
      xOffPos := Pos(#$13, s);
      if (xOffPos > 0) and (xOnPos < xOffPos) then
      begin
        //
        xOnPos := 0;
        while xOnPos = 0 do
        begin
          s := '';
          dataSize := fDriver.ReadData(pData, sizeof(buffer));
          if dataSize > 0 then
          begin
            // Convert incoming data into a string
            s := StringOfChar( ' ', dataSize );
            move( pData^, pchar(s)^, DataSize );
          end;
          xOnPos := Pos(#$11, s);
        end;
      end;
    end;
  finally
    fDriver.ContinuePolling;
  end;
end;

procedure TSynTerm.SetTextHelper(const s: string);
begin
  Inc(fReceivingData);
  try
    SelText := s;
    EnsureCursorPosVisible;
  finally
    Dec(fReceivingData);
  end;
end;

procedure TSynTerm.DownloadFile(const aFile: string);
var
  SL : TStringList;
begin
  if FileExists(aFile) then
  begin
    SL := TStringList.Create;
    try
      SL.LoadFromFile(aFile);
      DownloadScript(SL);
    finally
      SL.Free;
    end;
  end;
end;

function TSynTerm.GetReadFirstTimeout: Word;
begin
  Result := fDriver.ReadFirstTimeout;
end;

function TSynTerm.GetReadICTimeout: Word;
begin
  Result := fDriver.ReadICTimeout;
end;

function TSynTerm.GetWriteTimeout: Word;
begin
  Result := fDriver.WriteTimeout;
end;

procedure TSynTerm.SetReadFirstTimeout(const Value: Word);
begin
  fDriver.ReadFirstTimeout := Value;
end;

procedure TSynTerm.SetReadICTimeout(const Value: Word);
begin
  fDriver.ReadFirstTimeout := Value;
end;

procedure TSynTerm.SetWriteTimeout(const Value: Word);
begin
  fDriver.ReadFirstTimeout := Value;
end;

procedure TSynTerm.DownloadScript(aStrings: TStrings);
begin
  if not Connected then Exit;
  SelText := aStrings.Text;
end;

function TSynTerm.DoStripComments(const line: string): string;
var
  p : Integer;
//  q : Integer;
begin
  Result := line;
  case ScriptCommentStyle of
    scsForth : begin
      p := Pos('\', Trim(Result));
      // only comments starting at the beginning of the line
      // (with only whitespace before the comment character)
      if p = 1 then
      begin
        Result := '';
        Exit; // no need to do anything else if the line is blank
      end;
// don't bother with () comments - these words could be redefined
{
      p := Pos('(', Result); // find () comments as well that are on a single line
      if p > 0 then
      begin
        q := Pos(')', Result);
        if q > p then
          Delete(Result, p, q-p+1); // strip () comments
      end;
}
    end;
  end;
end;

end.
