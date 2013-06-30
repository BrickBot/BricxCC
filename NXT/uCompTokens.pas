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
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uCompTokens;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

interface

const
  TOK_SEMICOLON     = ';';
  TOK_OPENPAREN     = '(';
  TOK_CLOSEPAREN    = ')';
  TOK_COMMA         = ',';
  TOK_IDENTIFIER		= 'x';
  TOK_IF			      = 'i';
  TOK_ELSE		      = 'l';
  TOK_DO            = 'd';
  TOK_ASM           = 'a';
  TOK_REPEAT        = 'r';
  TOK_SWITCH        = 's';
  TOK_DEFAULT       = 'D';
  TOK_CASE          = 'c';
  TOK_WHILE		      = 'w';
  TOK_FOR			      = 'f';
  TOK_ENUM          = 'm';
  TOK_END			      = '}';
  TOK_APISTRFUNC    = 'E';
  TOK_APIFUNC       = 'F';
  TOK_PROCEDURE		  = 'R';
  TOK_TASK          = 'K';
  TOK_BEGIN		      = '{';
  TOK_DIRECTIVE		  = '#';
  TOK_API           = 'Z';
  TOK_LABEL         = 'B';
  TOK_TYPEDEF       = 't';
  TOK_STRUCT        = 'T';
  TOK_CONST         = 'k';
  TOK_STATIC        = 'Q';
  TOK_INLINE        = 'n';
  TOK_START         = 'A';
  TOK_STOP          = 'X';
  TOK_PRIORITY      = 'p';
  TOK_NUM			      = 'N';
  TOK_HEX			      = 'H';
  TOK_BINARY        = 'y';
  TOK_UNSIGNED		  = 'U';
  TOK_CHARDEF		    = 'C';
  TOK_SHORTDEF 	    = 'I';
  TOK_LONGDEF       = 'L';
  TOK_BYTEDEF       = 'b';
  TOK_USHORTDEF     = #06;
  TOK_ULONGDEF      = #05;
  TOK_MUTEXDEF      = 'M';
  TOK_FLOATDEF      = 'O';
  TOK_STRINGDEF     = 'S';
  TOK_STRINGLIT     = 'G';
  TOK_SAFECALL        = #218;
  TOK_USERDEFINEDTYPE = #219;
  TOK_ARRAYFLOAT      = #220;
  TOK_ARRAYFLOAT4     = #223;
  TOK_ARRAYSTRING     = #224;
  TOK_ARRAYSTRING4    = #227;
  TOK_ARRAYUDT        = #228;
  TOK_ARRAYUDT4       = #231;
  TOK_ARRAYCHARDEF    = #232;
  TOK_ARRAYCHARDEF4   = #235;
  TOK_ARRAYSHORTDEF   = #236;
  TOK_ARRAYSHORTDEF4  = #239;
  TOK_ARRAYLONGDEF    = #240;
  TOK_ARRAYLONGDEF4   = #243;
  TOK_ARRAYBYTEDEF    = #244;
  TOK_ARRAYBYTEDEF4   = #247;
  TOK_ARRAYUSHORTDEF  = #248;
  TOK_ARRAYUSHORTDEF4 = #251;
  TOK_ARRAYULONGDEF   = #252;
  TOK_ARRAYULONGDEF4  = #255;
  TOK_BLOCK_COMMENT   = #01;
  TOK_LINE_COMMENT    = #02;

implementation

end.