unit uHTMLHelp;

interface

uses
  Windows;

const
  HH_DISPLAY_TOPIC       =    0;
  HH_HELP_FINDER         =    0;
  HH_DISPLAY_TOC         =    1;
  HH_DISPLAY_INDEX       =    2;
  HH_DISPLAY_SEARCH      =    3;
  HH_SET_WIN_TYPE        =    4;
  HH_GET_WIN_TYPE        =    5;
  HH_GET_WIN_HANDLE      =    6;
  HH_ENUM_INFO_TYPE      =    7;
  HH_SET_INFO_TYPE       =    8;
  HH_SYNC                =    9;
  HH_KEYWORD_LOOKUP      =   $d;
  HH_DISPLAY_TEXT_POPUP  =   $e;
  HH_HELP_CONTEXT        =   $f;
  HH_TP_HELP_CONTEXTMENU =  $10;
  HH_TP_HELP_WM_HELP     =  $11;
  HH_CLOSE_ALL           =  $12;
  HH_ALINK_LOOKUP        =  $13;
  HH_GET_LAST_ERROR      =  $14;
  HH_ENUM_CATEGORY       =  $15;
  HH_ENUM_CATEGORY_IT    =  $16;
  HH_RESET_IT_FILTER     =  $17;
  HH_SET_INCLUSIVE_FILTER = $18;
  HH_SET_EXCLUSIVE_FILTER = $19;
  HH_INITIALIZE          =  $1c;
  HH_UNINITIALIZE        =  $1d;
  HH_SET_QUERYSERVICE    =  $1e;
  HH_PRETRANSLATEMESSAGE =  $fd;
  HH_GLOBALPROPERTY      =  $fc;

procedure WinHelpToHtmlHelp(var ACommand: Word; var AData: Integer);
function HtmlHelp(hWndCaller: HWND; pszFile: PChar; uCommand: UINT; dwData: DWORD): HWND;
function HtmlHelpA(hWndCaller: HWND; pszFile: PAnsiChar; uCommand: UINT; dwData: DWORD): HWND;
function HtmlHelpW(hWndCaller: HWND; pszFile: PWideChar; uCommand: UINT; dwData: DWORD): HWND;

implementation

procedure WinHelpToHtmlHelp(var ACommand: Word; var AData: Integer);
begin
  case ACommand of
    HELP_CONTENTS:
      begin
        ACommand :=  HH_DISPLAY_TOC;
        AData := 0;
      end;
    HELP_CONTEXT:
      ACommand := HH_HELP_CONTEXT;
    HELP_CONTEXTPOPUP:
      ACommand := HH_HELP_CONTEXT;
    HELP_FINDER:
      ACommand := HH_DISPLAY_TOPIC;
    HELP_KEY:
      ACommand := HH_DISPLAY_INDEX;
    HELP_QUIT:
      begin
        ACommand :=  HH_CLOSE_ALL;
        AData := 0;
      end;
    else begin
      ACommand := HH_DISPLAY_TOPIC;
      AData := 0;
    end;
  end;
end;

type
  THtmlHelpAProc = function(hWndCaller: HWND; pszFile: PAnsiChar; uCommand: UINT; dwData: DWORD): HWnd; stdcall;
  THtmlHelpWProc = function(hWndCaller: HWND; pszFile: PWideChar; uCommand: UINT; dwData: DWORD): HWnd; stdcall;

var
  HtmlHelpModule : HModule;
  HtmlHelpAProc : THtmlHelpAProc;
  HtmlHelpWProc: THtmlHelpWPRoc;

function _HtmlHelpSetup : Boolean;
begin
  Result := false;
  if (HtmlHelpModule = 0) then
  begin
    HtmlHelpModule := LoadLibrary('hhctrl.ocx');
    if (HtmlHelpModule <> 0) then
    begin
      @HtmlHelpAProc := GetProcAddress(HtmlHelpModule, 'HtmlHelpA');
      @HtmlHelpWProc := GetProcAddress(HtmlHelpModule, 'HtmlHelpW');
    end;
  end;
  if Assigned(HtmlHelpAProc) and Assigned(HtmlHelpWProc) then Result := true;
end;

function HtmlHelp(hWndCaller: HWND; pszFile: LPCTSTR; uCommand: UINT; dwData: DWORD): HWND;
begin
  Result := HtmlHelpA(hWndCaller, pszFile, uCommand, dwData);
end;

function HtmlHelpA(hWndCaller: HWND; pszFile: PAnsiChar; uCommand: UINT; dwData:DWORD): HWND;
begin
  Result := 0;
  if _HtmlHelpSetup then
  begin
   Result := HtmlHelpAProc(hWndCaller, pszFile, uCommand, dwData);
  end;
end;

function HtmlHelpW(hWndCaller: HWND; pszFile: PWideChar; uCommand: UINT; dwData:DWORD): HWND;
begin
  Result := 0;
  if _HtmlHelpSetup then
  begin
   Result := HtmlHelpWProc(hWndCaller, pszFile, uCommand, dwData);
  end;
end;

initialization
  HtmlHelpModule := 0;

finalization
  if HtmlHelpModule <> 0 then
    FreeLibrary(HtmlHelpModule);
    
end.
