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
unit uGrepExpert;

interface

uses
  Classes, Graphics, uGrepCommonUtils;

type
  TGrepExpert = class(TObject)
  private
    FGrepMiddle: Boolean;
    FGrepExpandAll: Boolean;
    FSearchList: TStrings;
    FReplaceList: TStrings;
    FMaskList: TStrings;
    FDirList: TStrings;
    FGrepCaseSensitive: Boolean;
    FGrepCode: Boolean;
    FGrepStrings: Boolean;
    FGrepComments: Boolean;
    FGrepInterface: Boolean;
    FGrepImplementation: Boolean;
    FGrepInitialization: Boolean;
    FGrepFinalization: Boolean;
    FGrepSearch: Integer;
    FGrepSub: Boolean;
    FGrepWholeWord: Boolean;
    FGrepRegEx: Boolean;
    FGrepUseCurrentIdent: Boolean;
    FNumContextLines: Integer;
    FListFont: TFont;
    FContextFont: TFont;
    FContextMatchColor: TColor;
    fActive: boolean;
    procedure SetSearchList(New: TStrings);
    procedure SetReplaceList(New: TStrings);
    procedure SetMaskList(New: TStrings);
    procedure SetDirList(New: TStrings);
  protected
    procedure SetActive(New: Boolean); virtual;
    procedure InternalLoadSettings(Settings: TGExpertsSettings); virtual;
    procedure InternalSaveSettings(Settings: TGExpertsSettings); virtual;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ShowModal;
    function GetActionCaption: string; virtual;
    class function ConfigurationKey: string; virtual;
    class function GetName: string; virtual;
    procedure Click(Sender: TObject); virtual;
    procedure Configure; virtual;
    procedure SaveSettings;
    procedure LoadSettings;
    property Active : boolean read fActive write fActive;
    property GrepMiddle: Boolean read FGrepMiddle write FGrepMiddle;
    property GrepExpandAll: Boolean read FGrepExpandAll write FGrepExpandAll;
    property GrepCaseSensitive: Boolean read FGrepCaseSensitive write FGrepCaseSensitive;
    property GrepCode: Boolean read FGrepCode write FGrepCode;
    property GrepStrings: Boolean read FGrepStrings write FGrepStrings;
    property GrepComments: Boolean read FGrepComments write FGrepComments;
    property GrepInterface: Boolean read FGrepInterface write FGrepInterface;
    property GrepImplementation: Boolean read FGrepImplementation write FGrepImplementation;
    property GrepInitialization: Boolean read FGrepInitialization write FGrepInitialization;
    property GrepFinalization: Boolean read FGrepFinalization write FGrepFinalization;
    property GrepSearch: Integer read FGrepSearch write FGrepSearch;
    property GrepSub: Boolean read FGrepSub write FGrepSub;
    property GrepWholeWord: Boolean read FGrepWholeWord write FGrepWholeWord;
    property GrepRegEx: Boolean read FGrepRegEx write FGrepRegEx;
    property GrepUseCurrentIdent: Boolean read FGrepUseCurrentIdent write FGrepUseCurrentIdent;
    property NumContextLines: Integer read FNumContextLines write FNumContextLines;
    property ListFont: TFont read FListFont write FListFont;
    property ContextFont: TFont read FContextFont write FContextFont;
    property ContextMatchColor: TColor read FContextMatchColor write FContextMatchColor;

    property SearchList: TStrings read FSearchList write SetSearchList;
    property ReplaceList: TStrings read FReplaceList write SetReplaceList;
    property MaskList: TStrings read FMaskList write SetMaskList;
    property DirList: TStrings read FDirList write SetDirList;
  end;

var
  GrepStandAlone: TGrepExpert = nil;

procedure ShowGrep;

implementation

uses
  SysUtils, Menus, Controls, ComCtrls,
  uGrepResults, uGrepResultsOptions, uGuiUtils, uRegUtils;

{ TGrepExpert }

constructor TGrepExpert.Create;
begin
  inherited Create;
  FSearchList := TStringList.Create;
  FReplaceList := TStringList.Create;
  FMaskList := TStringList.Create;
  FDirList := TStringList.Create;
  FListFont := TFont.Create;
  FContextFont := TFont.Create;
  FContextMatchColor := clHighlight;
  FNumContextLines := 2;
  
  FGrepExpandAll := False;
  FGrepUseCurrentIdent := False;
//  ShortCut := Menus.ShortCut(Word('R'), [ssCtrl, ssAlt]);
  fmGrepResults := TfmGrepResults.Create(nil);
//  SetFormIcon(fmGrepResults);
  fmGrepResults.GrepExpert := Self;
  LoadSettings;
end;

destructor TGrepExpert.Destroy;
begin
  SaveSettings;

  FreeAndNil(fmGrepResults);
  FreeAndNil(FSearchList);
  FreeAndNil(FReplaceList);
  FreeAndNil(FMaskList);
  FreeAndNil(FDirList);
  FreeAndNil(FListFont);
  FreeAndNil(FContextFont);

  inherited Destroy;
end;

function TGrepExpert.GetActionCaption: string;
resourcestring
  SMenuCaption = 'Grep &Results';
begin
  Result := SMenuCaption;
end;

class function TGrepExpert.GetName: string;
begin
  Result := 'GrepResults';
end;

procedure TGrepExpert.Click(Sender: TObject);
begin
//  SetFormIcon(fmGrepResults);
  fmGrepResults.Show;
  EnsureFormVisible(fmGrepResults);
end;

procedure TGrepExpert.ShowModal;
begin
  fmGrepResults.ShowModal;
end;

procedure TGrepExpert.Configure;
var
  Dialog: TfmGrepResultsOptions;
begin
  Dialog := TfmGrepResultsOptions.Create(nil);
  try
    Dialog.chkGrepMiddle.Checked := GrepMiddle;
    Dialog.chkGrepExpandAll.Checked := GrepExpandAll;
    Dialog.pnlListFont.Font.Assign(ListFont);
    Dialog.pnlContextFont.Font.Assign(ContextFont);
    Dialog.pnlMatchLineColor.Font.Assign(ContextFont);
    Dialog.pnlMatchLineColor.Font.Color := ContextMatchColor;
    Dialog.udContextLines.Position := NumContextLines;
        
    if Dialog.ShowModal = mrOk then
    begin
      GrepMiddle := Dialog.chkGrepMiddle.Checked;
      GrepExpandAll := Dialog.chkGrepExpandAll.Checked;
      FListFont.Assign(Dialog.pnlListFont.Font);
      FContextFont.Assign(Dialog.pnlContextFont.Font);
      ContextMatchColor := Dialog.pnlMatchLineColor.Font.Color;
      NumContextLines := Dialog.udContextLines.Position;
      SaveSettings;
    end;
  finally
    FreeAndNil(Dialog);
  end;
end;

procedure TGrepExpert.InternalSaveSettings(Settings: TGExpertsSettings);
begin
//  inherited InternalSaveSettings(Settings);
  // do not localize any of the following lines
  Settings.WriteBool(ConfigurationKey, 'CaseSensitive', GrepCaseSensitive);
  Settings.WriteBool(ConfigurationKey, 'Code', GrepCode);
  Settings.WriteBool(ConfigurationKey, 'Strings', GrepStrings);
  Settings.WriteBool(ConfigurationKey, 'NoComments', not GrepComments);
  Settings.WriteBool(ConfigurationKey, 'Interface', GrepInterface);
  Settings.WriteBool(ConfigurationKey, 'Implementation', GrepImplementation);
  Settings.WriteBool(ConfigurationKey, 'Initialization', GrepInitialization);
  Settings.WriteBool(ConfigurationKey, 'Finalization', GrepFinalization);
  Settings.WriteInteger(ConfigurationKey, 'Search', GrepSearch);
  Settings.WriteBool(ConfigurationKey, 'SubDirectories', GrepSub);
  Settings.WriteBool(ConfigurationKey, 'ExpandAll', GrepExpandAll);
  Settings.WriteBool(ConfigurationKey, 'Whole Word', GrepWholeWord);
  Settings.WriteBool(ConfigurationKey, 'Middle', GrepMiddle);
  Settings.WriteBool(ConfigurationKey, 'RegEx', GrepRegEx);
  Settings.WriteBool(ConfigurationKey, 'UseCurrentIdent', GrepUseCurrentIdent);
  Settings.SaveFont(IncludeTrailingPathDelimiter(ConfigurationKey) + 'ListFont', ListFont);
  Settings.SaveFont(IncludeTrailingPathDelimiter(ConfigurationKey) + 'ContextFont', ContextFont);
  Settings.WriteInteger(ConfigurationKey, 'NumContextLines', NumContextLines);
  Settings.WriteInteger(ConfigurationKey, 'ContextMatchColor', ContextMatchColor);

  RegWriteStrings(Settings, DirList, ConfigurationKey + PathDelim + 'DirectoryList', 'GrepDir');
  RegWriteStrings(Settings, SearchList, ConfigurationKey + PathDelim + 'SearchList', 'GrepSearch');
  RegWriteStrings(Settings, ReplaceList, ConfigurationKey + PathDelim + 'ReplaceList', 'GrepReplace');
  RegWriteStrings(Settings, MaskList, ConfigurationKey + PathDelim + 'MaskList', 'GrepMask');
end;

procedure TGrepExpert.InternalLoadSettings(Settings: TGExpertsSettings);
begin
//  inherited InternalLoadSettings(Settings);
  // Do not localize any of the following lines
  FGrepCaseSensitive := Settings.ReadBool(ConfigurationKey, 'CaseSensitive', False);
  FGrepCode := Settings.ReadBool(ConfigurationKey, 'Code', True);
  FGrepStrings := Settings.ReadBool(ConfigurationKey, 'Strings', True);
  FGrepComments := not Settings.ReadBool(ConfigurationKey, 'NoComments', False);
  FGrepInterface := Settings.ReadBool(ConfigurationKey, 'Interface', True);
  FGrepImplementation := Settings.ReadBool(ConfigurationKey, 'Implementation', True);
  FGrepInitialization := Settings.ReadBool(ConfigurationKey, 'Initialization', True);
  FGrepFinalization := Settings.ReadBool(ConfigurationKey, 'Finalization', True);
  FGrepSearch := Settings.ReadInteger(ConfigurationKey, 'Search', 0);
  FGrepSub := Settings.ReadBool(ConfigurationKey, 'SubDirectories', True);
  FGrepExpandAll := Settings.ReadBool(ConfigurationKey, 'ExpandAll', False);
  FGrepWholeWord := Settings.ReadBool(ConfigurationKey, 'Whole Word', False);
  FGrepMiddle := Settings.ReadBool(ConfigurationKey, 'Middle', True);
  FGrepRegEx := Settings.ReadBool(ConfigurationKey, 'RegEx', False);
  FGrepUseCurrentIdent := Settings.ReadBool(ConfigurationKey, 'UseCurrentIdent', False);

  Settings.LoadFont(IncludeTrailingPathDelimiter(ConfigurationKey) + 'ListFont', ListFont);
  Settings.LoadFont(IncludeTrailingPathDelimiter(ConfigurationKey) + 'ContextFont', ContextFont);
  FNumContextLines :=  Settings.ReadInteger(ConfigurationKey, 'NumContextLines', FNumContextLines);
  FContextMatchColor :=  Settings.ReadInteger(ConfigurationKey, 'ContextMatchColor', FContextMatchColor);

  RegReadStrings(Settings, DirList, ConfigurationKey + PathDelim + 'DirectoryList', 'GrepDir');
  RegReadStrings(Settings, SearchList, ConfigurationKey + PathDelim + 'SearchList', 'GrepSearch');
  RegReadStrings(Settings, ReplaceList, ConfigurationKey + PathDelim + 'ReplaceList', 'GrepReplace');
  RegReadStrings(Settings, MaskList, ConfigurationKey + PathDelim + 'MaskList', 'GrepMask');
  if MaskList.Count = 0 then
  begin
    MaskList.Add('*.nxc;*.h');
    MaskList.Add('*.nbc;*.h');
    MaskList.Add('*.nqc;*.nqh;*.h');
    MaskList.Add('*.txt;*.html;*.htm;.rc;*.xml;*.todo;*.me');
  end;
end;

procedure TGrepExpert.SetSearchList(New: TStrings);
begin
  FSearchList.Assign(New);
end;

procedure TGrepExpert.SetReplaceList(New: TStrings);
begin
  FReplaceList.Assign(New);
end;

procedure TGrepExpert.SetMaskList(New: TStrings);
begin
  FMaskList.Assign(New);
end;

procedure TGrepExpert.SetDirList(New: TStrings);
begin
  FDirList.Assign(New);
end;

procedure TGrepExpert.SetActive(New: Boolean);
begin
  if New <> Active then
  begin
    if New then
    begin
      if fmGrepResults = nil then
        fmGrepResults := TfmGrepResults.Create(nil);
      fmGrepResults.GrepExpert := Self;
    end
    else
      FreeAndNil(fmGrepResults);
  end;
end;

class function TGrepExpert.ConfigurationKey: string;
begin
  Result := 'Grep';
end;

procedure TGrepExpert.LoadSettings;
var
  Settings: TGExpertsSettings;
begin
  Settings := TGExpertsSettings.Create;
  try
    InternalLoadSettings(Settings);
  finally
    FreeAndNil(Settings);
  end;
end;

procedure TGrepExpert.SaveSettings;
var
  Settings: TGExpertsSettings;
begin
  Settings := TGExpertsSettings.Create;
  try
    InternalSaveSettings(Settings);
  finally
    FreeAndNil(Settings);
  end;
end;

procedure ShowGrep;
begin
  GrepStandAlone := TGrepExpert.Create;
  try
    GrepStandAlone.LoadSettings;
    GrepStandAlone.ShowModal;
    GrepStandAlone.SaveSettings;
  finally
    FreeAndNil(GrepStandAlone);
  end;
end;

end.