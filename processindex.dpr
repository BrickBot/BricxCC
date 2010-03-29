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
 * Portions created by John Hansen are Copyright (C) 2010 John Hansen.
 * All Rights Reserved.
 *
 *)
program processindex;

{$APPTYPE CONSOLE}

uses
  Classes, SysUtils, StrUtils, uCmdLineUtils, ParamUtils, ActiveX, MSXML2_TLB;

var
  Doc : IXMLDOMDocument;
  srcFile, destDir : string;
  NeedToUninitialize : boolean;

procedure PrintUsage;
begin
  WriteLn('Usage: ' + progName + ' sourceFile [outputdir]');
end;

function RPos(SubStr, S : string) : integer;
begin
  Result := Length(S) - Pos(SubStr, ReverseString(S)) + 1;
end;

function CreateDOMDocument : IXMLDOMDocument;
begin
  Result := CoDOMDocument.Create;
  Result.validateOnParse := False;
  Result.resolveExternals := False;
  Result.async := False;
end;

procedure CreateNXCHTMLTopicMap(const outputdir : string);
var
  nl : IXMLDOMNodeList;
  n : IXMLDOMNode;
  E : IXMLDOMElement;
  i, j, cnt : integer;
  refid, kind, name : string;
  tmpSL : TStringList;
  nameIdx : TStringList;
begin
  cnt := 0;
  nameIdx := TStringList.Create;
  tmpSL := TStringList.Create;
  try
    nameIdx.CaseSensitive := True;
    nameIdx.Sorted := True;
    tmpSL.Add('unit uNXCHTMLTopics;');
    tmpSL.Add('');
    tmpSL.Add('interface');
    tmpSL.Add('');
    tmpSL.Add('uses');
    tmpSL.Add('  uHTMLHelp;');
    tmpSL.Add('');
    tmpSL.Add('const');
    tmpSL.Add('  uNXCHTMLTopicsSize = %d;');
    tmpSL.Add('  uNXCHTMLTopicsData: array[0..uNXCHTMLTopicsSize-1] of TNameValue = (');

    // find all compounds of type struct
    nl := Doc.selectNodes('//compound[@kind="struct"]');
    for i := 0 to nl.length - 1 do
    begin
      E := nl.item[i] as IXMLDOMElement;
      n := E.selectSingleNode('name');
      name := n.text;
      if nameIdx.IndexOf(name) = -1 then
      begin
        nameIdx.Add(name);
        refid := E.getAttribute('refid');
        tmpSL.Add('    (');
        tmpSL.Add('     Name: ''' + name + ''';');
        tmpSL.Add('     Value: ''' + refid + '.html''');
        tmpSL.Add('    ),');
        inc(cnt);
      end;
    end;
    nameIdx.Clear;
    // find all members
    nl := Doc.selectNodes('//member[@kind!="variable"]');
    for i := 0 to nl.length - 1 do
    begin
      E := nl.item[i] as IXMLDOMElement;
      n := E.selectSingleNode('name');
      name := n.text;
      if nameIdx.IndexOf(name) = -1 then
      begin
        nameIdx.Add(name);
        refid := E.getAttribute('refid');
        kind := E.getAttribute('kind');
        j := RPos('_', refid);
        System.Delete(refid, j, MaxInt);
        tmpSL.Add('    (');
        tmpSL.Add('     Name: ''' + name + ''';');
        tmpSL.Add('     Value: ''' + refid + '.html''');
        tmpSL.Add('    ),');
        inc(cnt);
      end;
    end;

    inc(cnt);
    tmpSL.Add('    (');
    tmpSL.Add('     Name: ''$##@$@#$@#$@$'';');
    tmpSL.Add('     Value: ''$##@$@#$@#$@$''');
    tmpSL.Add('    )');
    tmpSL.Add('  );');
    tmpSL.Add('');
    tmpSL.Add('implementation');
    tmpSL.Add('');
    tmpSL.Add('end.');
    tmpSL.Text := Format(tmpSL.Text, [cnt]);
    ForceDirectories(outputdir);
    tmpSL.SaveToFile(ExtractFilePath(outputdir) + 'uNXCHTMLTopics.pas');
  finally
    tmpSL.Free;
    nameIdx.Free;
  end;
end;

procedure OutputMessage(msg : string);
begin
  Write(msg);
end;

procedure CreateNXCAPIFile(const outputdir : string);
var
  nl, fNL : IXMLDOMNodeList;
  n, args : IXMLDOMNode;
  E : IXMLDOMElement;
  i, j : integer;
  refid, fname, api : string;
  tmpSL, doneList : TStringList;
  fDoc : IXMLDOMDocument;
begin
  doneList := TStringList.Create;
  try
    doneList.Sorted := True;
    doneList.Duplicates := dupIgnore;
    doneList.CaseSensitive := True;
    tmpSL := TStringList.Create;
    try
      // find all members
      nl := Doc.selectNodes('//member[@kind="function"]');
      for i := 0 to nl.length - 1 do
      begin
        E := nl.item[i] as IXMLDOMElement;
        n := E.selectSingleNode('name');
        refid := E.getAttribute('refid');
        // remove the two globs at the end of the refid
        j := RPos('_', refid);
        System.Delete(refid, j, MaxInt);
        j := RPos('_', refid);
        System.Delete(refid, j, MaxInt);
        // check whether we have already processed this new file...
        if doneList.IndexOf(refid) = -1 then
        begin
          // process the new file
          fDoc := CreateDOMDocument;
          try
            fname := ExtractFilePath(srcFile)+refid+'.xml';
            if fDoc.load(fname) then
            begin
              fNL := fDoc.selectNodes('//memberdef[@kind="function"]');
              for j := 0 to fNL.length - 1 do
              begin
                E := fNL.item[j] as IXMLDOMElement;
                n := E.selectSingleNode('name');
                args := E.selectSingleNode('argsstring');
                api := n.text + args.text;
                api := StringReplace(api, '&', '& ', [rfReplaceAll]);
                tmpSL.Add(api);
              end;
            end
            else
            begin
              OutputMessage('Message: Load failed ' + #13#10 +
                            'Reason: ' + fDoc.parseError.reason + #13#10 +
                            'Src: ' + fDoc.parseError.srcText + #13#10 +
                            'line: ' + IntToStr(fDoc.parseError.line) + #13#10 +
                            'pos: ' + IntToStr(fDoc.parseError.linepos));
            end;
          finally
            fDoc := nil;
          end;
          // add it to our done list
          doneList.Add(refid);
        end;
      end;
      tmpSL.Sort;
      tmpSL.SaveToFile(ExtractFilePath(outputdir) + 'nxc_api.txt');
    finally
      tmpSL.Free;
    end;
  finally
    doneList.Free;
  end;
end;

procedure CreateNXCConstantsFile(const outputdir : string);
var
  nl : IXMLDOMNodeList;
  i : integer;
  tmpSL : TStringList;
begin
  tmpSL := TStringList.Create;
  try
    tmpSL.Sorted := True;
    tmpSL.Duplicates := dupIgnore;
    tmpSL.CaseSensitive := true;
    // find all members
    nl := Doc.selectNodes('//member[@kind="define"]');
    for i := 0 to nl.length - 1 do
      tmpSL.Add(nl.item[i].selectSingleNode('name').text);
    tmpSL.SaveToFile(ExtractFilePath(outputdir) + 'nxc_constants.txt');
  finally
    tmpSL.Free;
  end;
end;

begin
  if ParamCount < 1 then
  begin
    PrintUsage;
    Exit;
  end;
  NeedToUninitialize := CoInitialize(nil) = S_OK;
  try
    srcFile := ParamStr(1);
    if ParamCount = 2 then
      destDir := ParamStr(2)
    else
      destDir := ExtractFilePath(ParamStr(0));
    ForceDirectories(destDir);
    try
      Doc := CreateDOMDocument;
      try
        if not Doc.load(srcFile) then
        begin
          OutputMessage('Message: Load failed ' + #13#10 +
                        'Reason: ' + Doc.parseError.reason + #13#10 +
                        'Src: ' + Doc.parseError.srcText + #13#10 +
                        'line: ' + IntToStr(Doc.parseError.line) + #13#10 +
                        'pos: ' + IntToStr(Doc.parseError.linepos));
        end
        else
        begin
          // process the file
          CreateNXCHTMLTopicMap(destDir);
          CreateNXCAPIFile(destDir);
          CreateNXCConstantsFile(destDir);
        end;
      except
        on E : Exception do
        begin
          OutputMessage('Message: ' + E.Message + #13#10 +
                        'Reason: ' + Doc.parseError.reason + #13#10 +
                        'Src: ' + Doc.parseError.srcText + #13#10 +
                        'line: ' + IntToStr(Doc.parseError.line) + #13#10 +
                        'pos: ' + IntToStr(Doc.parseError.linepos));

        end;
      end;
    except
      on E : Exception do
        OutputMessage(E.Message);
    end;
  finally
    Doc := nil;
//    if NeedToUninitialize then
//      CoUninitialize;
  end;
end.
