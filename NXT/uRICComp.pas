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
unit uRICComp;

interface

uses
  Classes, Contnrs, uNBCCommon, uRIC, Parser10;

type
  TImgPoint = IMG_PT;
  TImgRect = IMG_RECT;
  TImgCanvas = TObject;

  TRICOps = class(TObjectList)
  public
    constructor Create;
    destructor Destroy; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas);
  end;

  TRICOpBase = class
  protected
    fOwner : TRICOps;
    fOpSize : Word;
    fOpCode : Word;
    function GetOpSize : Word; virtual;
  public
    constructor Create(aOwner : TRICOps); virtual;
    destructor Destroy; override;
    procedure SaveToStream(aStream : TStream); virtual;
    procedure LoadFromStream(aStream : TStream); virtual;
    function SaveAsDataArray(const aLangName: TLangName): string; virtual;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); virtual; abstract;
    property OpSize : Word read GetOpSize write fOpSize;
    property OpCode : Word read fOpCode write fOpCode;
  end;

  TRICDescription = class(TRICOpBase)
  protected
    fOptions : Word;
    fWidth : Word;
    fHeight : Word;
  public
    constructor Create(aOwner : TRICOps); override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    property Options : Word read fOptions write fOptions;
    property Width : Word read fWidth write fWidth;
    property Height : Word read fHeight write fHeight;
  end;

  TByteObject = class
  private
    fValue: Byte;
  public
    property Value : Byte read fValue write fValue;
  end;

  TRICSprite = class(TRICOpBase)
  protected
    fDataAddr: Word;
    fRowBytes: Word;
    fRows: Word;
    fBytes : TObjectList;
    function GetByteCount: Integer;
    function GetByte(Index: Integer): Byte;
    procedure SetByte(Index: Integer; const Value: Byte);
    function GetOpSize : Word; override;
    function BytesToWrite : Integer;
    function GetByteValue(const idx : integer) : Byte;
  public
    constructor Create(aOwner : TRICOps); override;
    destructor Destroy; override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    procedure Add(aValue : Byte);
    property DataAddr : Word read fDataAddr write fDataAddr;
    property Rows : Word read fRows write fRows;
    property RowBytes : Word read fRowBytes write fRowBytes;
    property ByteCount : Integer read GetByteCount;
    property Bytes[Index : Integer] : Byte read GetByte write SetByte;
    procedure AddBytes(val : string);
    class function CountBytes(val : string) : Word;
  end;

  TMapElement = class
  private
    fRange: Word;
    fDomain: Word;
  public
    property Domain : Word read fDomain write fDomain;
    property Range : Word read fRange write fRange;
  end;

  TRICVarMap = class(TRICOpBase)
  private
  protected
    fDataAddr: Word;
    fMapElements : TObjectList;
    function GetMapCount: Word;
    function GetMapElement(Index: Integer): TMapElement;
    procedure SetMapElement(Index: Integer; const Value: TMapElement);
  public
    constructor Create(aOwner : TRICOps); override;
    destructor Destroy; override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    procedure AddMap(aMapElement : PIOV_MAPELT);
    function Add : TMapElement;
    property DataAddr : Word read fDataAddr write fDataAddr;
    property MapCount : Word read GetMapCount;
    property MapElements[Index : Integer] : TMapElement read GetMapElement write SetMapElement;
  end;

  TRICCopyBits = class(TRICOpBase)
  protected
    fCopyOptions : Word;
    fDataAddr : Word;
    fDestPoint: TImgPoint;
    fSrcRect: TImgRect;
  public
    constructor Create(aOwner : TRICOps); override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    property CopyOptions : Word read fCopyOptions write fCopyOptions;
    property DataAddr : Word read fDataAddr write fDataAddr;
    property SrcRect : TImgRect read fSrcRect write fSrcRect;
    property DestPoint : TImgPoint read fDestPoint write fDestPoint;
  end;

  TRICPixel = class(TRICOpBase)
  protected
    fCopyOptions : Word;
    fPoint: TImgPoint;
    fValue: Word;
  public
    constructor Create(aOwner : TRICOps); override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    property CopyOptions : Word read fCopyOptions write fCopyOptions;
    property Point : TImgPoint read fPoint write fPoint;
    property Value : Word read fValue write fValue;
  end;

  TRICLine = class(TRICOpBase)
  protected
    fCopyOptions : Word;
    fPoint1: TImgPoint;
    fPoint2: TImgPoint;
  public
    constructor Create(aOwner : TRICOps); override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    property CopyOptions : Word read fCopyOptions write fCopyOptions;
    property Point1 : TImgPoint read fPoint1 write fPoint1;
    property Point2 : TImgPoint read fPoint2 write fPoint2;
  end;

  TRICRect = class(TRICOpBase)
  protected
    fCopyOptions : Word;
    fPoint: TImgPoint;
    fHeight: SmallInt;
    fWidth: SmallInt;
  public
    constructor Create(aOwner : TRICOps); override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    property CopyOptions : Word read fCopyOptions write fCopyOptions;
    property Point : TImgPoint read fPoint write fPoint;
    property Width : SmallInt read fWidth write fWidth;
    property Height : SmallInt read fHeight write fHeight;
  end;

  TRICCircle = class(TRICOpBase)
  protected
    fCopyOptions : Word;
    fPoint: TImgPoint;
    fRadius: Word;
  public
    constructor Create(aOwner : TRICOps); override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    property CopyOptions : Word read fCopyOptions write fCopyOptions;
    property Point : TImgPoint read fPoint write fPoint;
    property Radius : Word read fRadius write fRadius;
  end;

  TRICNumBox = class(TRICOpBase)
  protected
    fCopyOptions : Word;
    fPoint: TImgPoint;
    fValue: Word;
  public
    constructor Create(aOwner : TRICOps); override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    property CopyOptions : Word read fCopyOptions write fCopyOptions;
    property Point : TImgPoint read fPoint write fPoint;
    property Value : Word read fValue write fValue;
  end;

  TRICEllipse = class(TRICOpBase)
  protected
    fCopyOptions : Word;
    fPoint: TImgPoint;
    fRadius1: Word;
    fRadius2: Word;
  public
    constructor Create(aOwner : TRICOps); override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    property CopyOptions : Word read fCopyOptions write fCopyOptions;
    property Point : TImgPoint read fPoint write fPoint;
    property Radius1 : Word read fRadius1 write fRadius1;
    property Radius2 : Word read fRadius2 write fRadius2;
  end;

  TPolyPoint = class
  private
    fX: SmallInt;
    fY: SmallInt;
  public
    property X : SmallInt read fX write fX;
    property Y : SmallInt read fY write fY;
  end;

  TRICPolygon = class(TRICOpBase)
  private
  protected
    fCopyOptions : Word;
    fPolyPoints : TObjectList;
    function GetCount: Word;
    function GetPolyPoint(Index: Integer): TPolyPoint;
    procedure SetPolyPoint(Index: Integer; const Value: TPolyPoint);
  public
    constructor Create(aOwner : TRICOps); override;
    destructor Destroy; override;
    procedure SaveToStream(aStream : TStream); override;
    procedure LoadFromStream(aStream : TStream); override;
    function SaveAsDataArray(const aLangName: TLangName): string; override;
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas); override;
    procedure AddPoint(aPolyPoint : PIMG_PT);
    function Add : TPolyPoint;
    property Count : Word read GetCount;
    property PolyPoints[Index : Integer] : TPolyPoint read GetPolyPoint write SetPolyPoint;
    property CopyOptions : Word read fCopyOptions write fCopyOptions;
  end;

  TRICComp = class
  private
    endofallsource : boolean;
    fBadProgram : boolean;
    fBytesRead : integer;
    fProgErrorCount : integer;
    fOptimize: boolean;
    fCurFile: string;
    fEnhancedFirmware: boolean;
    fMessages: TStrings;
    fOnCompMSg: TOnCompilerMessage;
    fCalc : TExpParser;
    fMaxErrors: word;
    fFirmwareVersion: word;
    procedure InternalParseStream;
    procedure ReportProblem(const lineNo: integer; const fName,
      msg: string; err: boolean);
    procedure Init;
    procedure GetChar;
    procedure GetCharX;
    procedure IncLineNumber;
    procedure Next;
    procedure SkipWhite;
    procedure SkipLine;
    procedure SkipCommentBlock;
    procedure GetHexNum;
    procedure GetName;
    procedure GetNum;
    procedure Expected(s: string);
    procedure AbortMsg(s: string);
    function IsAlpha(c: char): boolean;
    function IsWhite(c: char): boolean;
    function IsAlNum(c: char): boolean;
    function IsDigit(c: char): boolean;
    function IsHex(c: char): boolean;
    procedure GetOp;
    procedure ScriptCommands;
    procedure Scan;
    procedure CheckBytesRead(const oldBytesRead: integer);
    procedure MatchString(x: string);
    procedure Semi;
    procedure Statement;
    procedure DoDesc;
    procedure DoSprite;
    procedure DoCircle;
    procedure DoCopyBits;
    procedure DoLine;
    procedure DoNumBox;
    procedure DoPixel;
    procedure DoRect;
    procedure DoVarMap;
    procedure DoEllipse;
    procedure DoPolygon;
    procedure CloseParen;
    procedure CheckNumeric;
    function ProcessArg: SmallInt;
    function ProcessWordArg: Word;
    function ValueToInt: integer;
    function ValueToSmallInt: SmallInt;
    function ValueToWord: Word;
    function StringToInt(const val: string): integer;
    procedure OpenParen;
    procedure GetString;
    procedure CheckStringConst;
    procedure CheckFirmwareVersion(const MinVer : word; const msg : string);
  protected
    fMS : TMemoryStream;
    fOperations : TRICOps;
    fCurrentLine : string;
    fTempChar : Char;
    fParenDepth : integer;
    fIncludeDirs: TStrings;
    function GetOpCount: Integer;
    procedure SyncObjectListToStream;
    procedure SyncStreamToObjectList;
    function GetAsText: string;
    procedure SetAsText(const Value: string);
    function GetOperation(Index: integer): TRICOpBase;
    procedure Clear;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property  CompilerMessages : TStrings read fMessages;
    procedure LoadFromStream(aStream : TStream);
    procedure LoadFromFile(const aFilename : string);
    procedure SaveToStream(aStream : TStream);
    procedure SaveToFile(const aFilename : string);
//    procedure Draw(aPoint : TImgPoint; Vars : TRICVariables;  Options : Cardinal; aCanvas : TImgCanvas);
    procedure Parse(const aFilename : string); overload;
    procedure Parse(aStream : TStream); overload;
    procedure Parse(aStrings : TStrings); overload;
    function SaveAsDataArray(const aLangName : TLangName; varname : string) : string;
    property RICOps : TRICOps read fOperations;
    property Operations[Index : integer] : TRICOpBase read GetOperation;
    property OperationCount : Integer read GetOpCount;
    property AsText : string read GetAsText write SetAsText;
    property CurrentFile : string read fCurFile write fCurFile;
    property Optimize : boolean read fOptimize write fOptimize;
    property EnhancedFirmware : boolean read fEnhancedFirmware write fEnhancedFirmware;
    property FirmwareVersion : word read fFirmwareVersion write fFirmwareVersion;
    property MaxErrors : word read fMaxErrors write fMaxErrors;
    property OnCompilerMessage : TOnCompilerMessage read fOnCompMSg write fOnCompMsg;
    property IncludeDirs : TStrings read fIncludeDirs;
    class function RICToText(aStream : TStream; const aFilename : string = '') : string; overload;
    class function RICToText(const aFilename : string) : string; overload;
    class function RICToDataArray(const aFilename, aVarName : string; const aLangName : TLangName) : string;
  end;

implementation

uses
  SysUtils, Math, uCommonUtils, uLocalizedStrings,
  {$IFNDEF FPC}
  Graphics, JPEG, PNGImage, GIFImage
  {$ELSE}
  FPImage, FPCanvas,
  FPReadBMP, {FPReadGIF, }FPReadJpeg,
  FPReadPCX, FPReadPNG, FPReadPNM,
  FPReadTGA, {FPReadTiff, }FPReadXPM
  {$ENDIF};

type
  TRGBColor = record
    red   : Byte;
    green : Byte;
    blue  : Byte;
  end;

  THSBColor = record
    Hue        : Double;
    Saturation : Double;
    Brightness : Double;
  end;

function RGB2HSB( rgb:TRGBColor ) : THSBColor;
var
  minRGB : Double;
  maxRGB : Double;
  delta  : Double;
  h      : Double;
  s      : Double;
  b      : Double;
begin
  h      := 0.0;
  minRGB := Min( Min( rgb.Red,rgb.Green ),rgb.Blue );
  maxRGB := Max( Max( rgb.Red,rgb.Green ),rgb.Blue );
  delta  := maxRGB - minRGB;
  b      := maxRGB ;

  if maxRGB <> 0.0 then
    s := 255.0 * delta / maxRGB
  else
    s := 0.0;

  if s <> 0.0 then
  begin
    if rgb.Red = maxRGB then
      h := (rgb.Green - rgb.Blue) / delta
    else if rgb.Green = minRGB then
      h := 2.0 + (rgb.Blue - rgb.Red) / delta
    else if rgb.Blue = maxRGB then
      h := 4.0 + (rgb.Red - rgb.Green) / delta
  end
  else
    h := -1.0;

  h := h * 60;
  if h < 0.0 then
    h := h + 360.0;

  with result do
  begin
    Hue        := h;
    Saturation := s * 100 / 255;
    Brightness := b * 100 / 255;
  end;
end;

{$IFNDEF FPC}
procedure ImportImage(op : TRICSprite; const fname : string;
  threshold, width, height : integer);
var
  pic : TPicture;
  img : TBitmap;
  w, h, nw, nh, x, y, c : Integer;
  rgb : TRGBColor;
  hsb : THSBColor;
  row : string;
begin
  img := TBitmap.Create;
  try
    pic := TPicture.Create;
    try
      pic.LoadFromFile(fname);
      w := pic.Graphic.Width;
      h := pic.Graphic.Height;
      img.Width  := w;
      img.Height := h;
      img.Canvas.Draw( 0,0, pic.Graphic );
    finally
      pic.Free;
    end;
    // now generate the pixel bytes for the NXT sprite
    nw := Min(width, w);
    nh := Min(height, h);
    op.Rows := nh;
    x := nw div 8;
    if (nw mod 8) <> 0 then
      inc(x);
    op.RowBytes := x;
    for y := 0 to nh-1 do begin
      row := '';
      for x := 0 to nw-1 do begin
        c := img.Canvas.Pixels[ x,y ];
        rgb.red   := Byte( ( c and $00FF0000 ) shr 16 );
        rgb.green := Byte( ( c and $0000FF00 ) shr  8 );
        rgb.blue  := Byte(   c and $000000FF          );
        hsb := RGB2HSB( rgb );
        if ( hsb.Brightness > threshold ) then
          row := row + '0'
        else
          row := row + '1';
      end;
      op.AddBytes(row);
    end;
  finally
    img.Free;
  end;
end;
{$ELSE}
procedure ImportImage(op : TRICSprite; const fname : string;
  threshold, width, height : integer);
var
  img : TFPMemoryImage;
  w, h, nw, nh, x, y : Integer;
  c : TFPColor;
  rgb : TRGBColor;
  hsb : THSBColor;
  row : string;
begin
  img := TFPMemoryImage.Create(0, 0);
  try
    img.LoadFromFile(fname);
    w := img.Width;
    h := img.Height;
    // now generate the pixel bytes for the NXT sprite
    nw := Min(width, w);
    nh := Min(height, h);
    op.Rows := nh;
    x := nw div 8;
    if (nw mod 8) <> 0 then
      inc(x);
    op.RowBytes := x;
    for y := 0 to nh-1 do begin
      row := '';
      for x := 0 to nw-1 do begin
        c := img.Colors[ x,y ];
        rgb.red   := c.red;
        rgb.green := c.green;
        rgb.blue  := c.blue;
        hsb := RGB2HSB( rgb );
        if ( hsb.Brightness > threshold ) then
          row := row + '0'
        else
          row := row + '1';
      end;
      op.AddBytes(row);
    end;
  finally
    img.Free;
  end;
end;
{$ENDIF}

const
  MAXCMDS = 9;
  TAB = ^I;
  CR  = ^M;
  LF  = ^J;
  TOK_NUM			        = 'N';
  TOK_HEX			        = 'H';
  TOK_STRINGLIT       = 'G';
  TOK_OPENPAREN       = '(';
  TOK_CLOSEPAREN      = ')';
  TOK_COMMA           = ',';
  TOK_IDENTIFIER		  = 'x';
  TOK_DESC		        = 'd';
  TOK_SPRITE	        = 's';
  TOK_COPYBITS        = 'c';
  TOK_VARMAP          = 'v';
  TOK_IMPORT          = 'i';
  TOK_LINE            = 'l';
  TOK_RECT            = 'r';
  TOK_PIXEL		        = 'p';
  TOK_CIRCLE	        = 'C';
  TOK_NUMBOX	        = 'n';
  TOK_ARG             = 'a';
  TOK_MAPARG          = 'm';
  TOK_F               = 'f';
  TOK_ELLIPSE         = 'e';
  TOK_POLYGON         = 'P';
  TOK_BLOCK_COMMENT   = #01;
  TOK_LINE_COMMENT    = #02;

type
  SymTab = array[1..MAXCMDS] of string;
  TabPtr = ^SymTab;

var
  Look: char = LF;              { Lookahead Character }
  Token: char;             { Encoded Token       }
  Value: string;           { Unencoded Token     }

var
  slevel : integer = 1;
  linenumber : integer;	// current source line number
  totallines : integer = 0;

const
  NKW  = 15;
  NKW1 = 16;

const
  KWlist: array[1..NKW] of string =
              ('desc', 'sprite', 'varmap', 'import',
               'copybits', 'line', 'rect', 'pixel',
               'circle', 'numbox', 'maparg', 'arg', 'f', 'ellipse', 'polygon');

const                                     // 'xileweRWve'
  KWcode: array[1..NKW1+1] of Char =
    (TOK_IDENTIFIER, TOK_DESC, TOK_SPRITE,
		 TOK_VARMAP, TOK_IMPORT, TOK_COPYBITS, TOK_LINE,
     TOK_RECT, TOK_PIXEL, TOK_CIRCLE,
     TOK_NUMBOX, TOK_MAPARG, TOK_ARG, TOK_F, TOK_ELLIPSE, TOK_POLYGON,
     #0);

function PixelsToBytes(p : word) : word;
begin
  Result := Word(p div 8);
  if (p mod 8) <> 0 then
    Inc(Result);
end;

procedure WriteImgPointToStream(aStream : TStream; pt : TImgPoint; bLittleEndian : Boolean = True);
begin
  WriteSmallIntToStream(aStream, pt.X, bLittleEndian);
  WriteSmallIntToStream(aStream, pt.Y, bLittleEndian);
end;

procedure WriteImgRectToStream(aStream : TStream; R : TImgRect; bLittleEndian : Boolean = True);
begin
  WriteImgPointToStream(aStream, R.Pt, bLittleEndian);
  WriteSmallIntToStream(aStream, R.Width, bLittleEndian);
  WriteSmallIntToStream(aStream, R.Height, bLittleEndian);
end;

procedure ReadImgPointFromStream(aStream : TStream; var pt : TImgPoint; bLittleEndian : Boolean = True);
begin
  ReadSmallIntFromStream(aStream, pt.X, bLittleEndian);
  ReadSmallIntFromStream(aStream, pt.Y, bLittleEndian);
end;

procedure ReadImgRectFromStream(aStream : TStream; var R : TImgRect; bLittleEndian : Boolean = True);
begin
  ReadImgPointFromStream(aStream, R.Pt, bLittleEndian);
  ReadSmallIntFromStream(aStream, R.Width, bLittleEndian);
  ReadSmallIntFromStream(aStream, R.Height, bLittleEndian);
end;

function RICOpCodeToStr(const Op : Word) : string;
begin
  case Op of
    IMG_DESCRIPTION_ID : Result := 'desc';
    IMG_SPRITE_ID      : Result := 'sprite';
    IMG_VARMAP_ID      : Result := 'varmap';
    IMG_COPYBITS_ID    : Result := 'copybits';
    IMG_PIXEL_ID       : Result := 'pixel';
    IMG_LINE_ID        : Result := 'line';
    IMG_RECTANGLE_ID   : Result := 'rect';
    IMG_CIRCLE_ID      : Result := 'circle';
    IMG_NUMBOX_ID      : Result := 'numbox';
    IMG_ELLIPSE_ID     : Result := 'ellipse';
    IMG_POLYGON_ID     : Result := 'polygon';
  else
    Result := 'unknown';
  end;
end;

function SpriteByteToHexString(const B : Byte) : string;
begin
  Result := IntToHex(B, 2);
end;

function SpriteByteToBinaryString(const B : Byte) : string;
begin
  Result := '';
  if (B and $80) <> 0 then Result := Result + '1'
                      else Result := Result + '0';
  if (B and $40) <> 0 then Result := Result + '1'
                      else Result := Result + '0';
  if (B and $20) <> 0 then Result := Result + '1'
                      else Result := Result + '0';
  if (B and $10) <> 0 then Result := Result + '1'
                      else Result := Result + '0';
  if (B and $08) <> 0 then Result := Result + '1'
                      else Result := Result + '0';
  if (B and $04) <> 0 then Result := Result + '1'
                      else Result := Result + '0';
  if (B and $02) <> 0 then Result := Result + '1'
                      else Result := Result + '0';
  if (B and $01) <> 0 then Result := Result + '1'
                      else Result := Result + '0';
end;

function RICValueToStr(const val : integer; const aLangName : TLangName = lnRICScript) : string;
var
  fmtStr : string;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := Format('0x%2.2x, 0x%2.2x', [Lo(val), Hi(val)]);
  end
  else
  begin
    if IMG_SYMB_USEARGS(val) = 0 then
    begin
      Result := Format('%d', [val]);
    end
    else
    begin
      if IMG_SYMB_MAP(val) = 0 then
      begin
        if aLangName = lnRICSCript then
          fmtStr := 'arg(%d)'
        else
          fmtStr := 'RICArg(%d)';
        Result := Format(fmtStr, [IMG_SYMB_ARG(val)]);
      end
      else
      begin
        if aLangName = lnRICSCript then
          fmtStr := 'maparg(%d, %d)'
        else
          fmtStr := 'RICMapArg(%d, %d)';
        Result := Format(fmtStr, [IMG_SYMB_MAP(val), IMG_SYMB_ARG(val)]);
      end;
    end;
  end;
end;

function RICPointToStr(const val : TImgPoint; const aLangName : TLangName) : string;
var
  fmtStr : string;
begin
  if aLangName in [lnNBC, lnNXC, lnNXCHeader] then
  begin
    if aLangName in [lnNBC, lnNXC] then
      fmtStr := '%s, %s'
    else
      fmtStr := 'RICImgPoint(%s, %s)';
    Result := Format(fmtStr,
      [RICValueToStr(val.X, aLangName), RICValueToStr(val.Y, aLangName)]);
  end
  else
    Result := '';
end;

function RICRectToStr(const val : TImgRect; const aLangName : TLangName) : string;
var
  fmtStr : string;
begin
  if aLangName in [lnNBC, lnNXC, lnNXCHeader] then
  begin
    if aLangName in [lnNBC, lnNXC] then
      fmtStr := '%s, %s, %s'
    else
      fmtStr := 'RICImgRect(%s, %s, %s)';
    Result := Format(fmtStr,
      [RICPointToStr(val.Pt, aLangName),
       RICValueToStr(val.Width, aLangName),
       RICValueToStr(val.Height, aLangName)]);
  end
  else
    Result := '';
end;

function ImgRect(X, Y, Width, Height: SmallInt): TImgRect;
begin
  Result.Pt.X := X;
  Result.Pt.Y := Y;
  Result.Width := Width;
  Result.Height := Height;
end;

function ImgPoint(X, Y: SmallInt): TImgPoint;
begin
  Result.X := X;
  Result.Y := Y;
end;


function RICToText(aMS : TMemoryStream; ops : TRICOps; const Filename : string) : string;
var
  OpSize, i, j : integer;
  tmpCmd, tmpRow : string;
  DataSize : Cardinal;
  pImage : PIMG_OP_UNION;
  pCB : PIMG_OP_COPYBITS;
  pL : PIMG_OP_LINE;
  pR : PIMG_OP_RECT;
  pC : PIMG_OP_CIRCLE;
  pNB : PIMG_OP_NUMBOX;
  pSP : PIMG_OP_SPRITE;
  pVM : PIMG_OP_VARMAP;
  pD  : PIMG_OP_DESCRIPTION;
  pPX : PIMG_OP_PIXEL;
  pE : PIMG_OP_ELLIPSE;
  pP : PIMG_OP_POLYGON;
  pB : PByte;
  pMAP : PIOV_MAPELT;
  pImgPt : PIMG_PT;
  theText : TStringList;
  opDescr : TRICDescription;
  opSprite : TRICSprite;
  opVM : TRICVarMap;
  opCB : TRICCopyBits;
  opPixel : TRICPixel;
  opLine : TRICLine;
  opRect : TRICRect;
  opCircle : TRICCircle;
  opNumBox : TRICNumBox;
  opEllipse : TRICEllipse;
  opPolygon : TRICPolygon;
begin
  ops.Clear;
  Result := '';
  theText := TStringList.Create;
  try
    DataSize := Cardinal(aMS.Size);
    aMS.Position := 0;
    pImage := aMS.Memory;
    if Filename <> '' then
      theText.Add(Format('// %s', [ExtractFileName(Filename)]));
    // Run through the op codes.
    while DataSize >= SizeOf(IMG_OP_CORE) do
    begin
      // Setup to look at an opcode, make sure it looks reasonable.
      OpSize := pImage^.Core.OpSize + SizeOf(Word);
      if (OpSize and $01) <> 0 then
        Break; // Odd sizes not allowed.
      case pImage^.Core.OpCode of
        IMG_DESCRIPTION_ID : begin
          if OpSize >= SizeOf(IMG_OP_DESCRIPTION) then
          begin
            // write out the Description opcode
            pD := @(pImage^.Desc);
            theText.Add(Format('%s(%d, %d, %d);',
              [RICOpCodeToStr(pD^.OpCode), pD^.Options, pD^.Width, pD^.Height]));
            // add to the operations list
            opDescr := TRICDescription.Create(ops);
            with opDescr do begin
              OpCode  := pD^.OpCode;
              OpSize  := pD^.OpSize;
              Options := pD^.Options;
              Width   := pD^.Width;
              Height  := pD^.Height;
            end;
          end;
        end;
        IMG_SPRITE_ID : begin
          if OpSize >= SizeOf(IMG_OP_SPRITE) then
          begin
            // write the sprite to the file.
            pSP := @(pImage^.Sprite);
            // add to the operations list
            opSprite := TRICSprite.Create(ops);
            with opSprite do begin
              OpCode   := pSP^.OpCode;
              OpSize   := pSP^.OpSize;
              DataAddr := pSP^.DataAddr;
              Rows     := pSP^.Rows;
              RowBytes := pSP^.RowBytes;
            end;
            tmpCmd := Format('%s(%d', [RICOpCodeToStr(pSP^.OpCode), pSP^.DataAddr]);
            pB := @(pSP^.Bytes[0]);
            for j := 0 to pSP^.Rows - 1 do begin
              tmpRow := '0x';
              for i := 0 to pSP^.RowBytes - 1 do begin
                // pB points at the current byte
                tmpRow := tmpRow + SpriteByteToHexString(pB^);
                opSprite.Add(pb^);
                inc(pB);
              end;
              tmpCmd := tmpCmd + ', ' + tmpRow;
            end;
            tmpCmd := tmpCmd + ');';
            theText.Add(tmpCmd);
            // set the OpSize value last since adding bytes tries to change the OpSize value
            opSprite.OpSize := pSP^.OpSize;
          end;
        end;
        IMG_VARMAP_ID : begin
          if OpSize >= SizeOf(IMG_OP_VARMAP) then
          begin
            // write the varmap to the file.
            pVM := @(pImage^.VarMap);
            // add to the operations list
            opVM := TRICVarMap.Create(ops);
            with opVM do begin
              OpCode   := pVM^.OpCode;
              OpSize   := pVM^.OpSize;
              DataAddr := pVM^.DataAddr;
            end;
            tmpCmd := Format('%s(%d', [RICOpCodeToStr(pVM^.OpCode), pVM^.DataAddr]);
            pMAP := @(pVM^.MapElt[0]);
            for j := 0 to pVM^.MapCount - 1 do begin
              tmpCmd := tmpCmd + Format(', f(%d)=%d', [pMAP^.Domain, pMAP^.Range]);
              opVM.AddMap(pMAP);
              inc(pMAP);
            end;
            tmpCmd := tmpCmd + ');';
            theText.Add(tmpCmd);
            // set the OpSize value last since adding map elements tries to change the OpSize value
            opVM.OpSize := pVM^.OpSize;
          end;
        end;
        IMG_COPYBITS_ID : begin
          if OpSize >= SizeOf(IMG_OP_COPYBITS) then
          begin
            // write the CopyBits opcode to the file
            pCB := @(pImage^.CopyBits);
            // add to the operations list
            opCB := TRICCopyBits.Create(ops);
            with opCB do begin
              OpCode      := pCB^.OpCode;
              OpSize      := pCB^.OpSize;
              CopyOptions := pCB^.CopyOptions;
              DataAddr    := pCB^.DataAddr;
              SrcRect     := ImgRect(pCB^.Src.Pt.X, pCB^.Src.Pt.Y, pCB^.Src.Width, pCB^.Src.Height);
              DestPoint   := ImgPoint(pCB^.Dst.X, pCB^.Dst.Y);
            end;
            theText.Add(Format('%s(%s, %s, %s, %s, %s, %s, %s, %s);',
              [RICOpCodeToStr(pCB^.OpCode),
               RICValueToStr(pCB^.CopyOptions), RICValueToStr(pCB^.DataAddr),
               RICValueToStr(pCB^.Src.Pt.X), RICValueToStr(pCB^.Src.Pt.Y),
               RICValueToStr(pCB^.Src.Width), RICValueToStr(pCB^.Src.Height),
               RICValueToStr(pCB^.Dst.X), RICValueToStr(pCB^.Dst.Y)]));
          end;
        end;
        IMG_PIXEL_ID : begin
          if OpSize >= SizeOf(IMG_OP_PIXEL) then begin
            pPX := @(pImage^.Pixel);
            // add to the operations list
            opPixel := TRICPixel.Create(ops);
            with opPixel do begin
              OpCode      := pPX^.OpCode;
              OpSize      := pPX^.OpSize;
              CopyOptions := pPX^.CopyOptions;
              Point       := ImgPoint(pPX^.Pt.X, pPX^.Pt.Y);
              Value       := pPX^.Value;
            end;
            theText.Add(Format('%s(%s, %s, %s, %s);',
              [RICOpCodeToStr(pPX^.OpCode), RICValueToStr(pPX^.CopyOptions),
               RICValueToStr(pPX^.Pt.X), RICValueToStr(pPX^.Pt.Y),
               RICValueToStr(pPX^.Value)]));
          end;
        end;
        IMG_LINE_ID : begin
          if OpSize >= SizeOf(IMG_OP_LINE) then begin
            pL := @(pImage^.Line);
            // add to the operations list
            opLine := TRICLine.Create(ops);
            with opLine do begin
              OpCode      := pL^.OpCode;
              OpSize      := pL^.OpSize;
              CopyOptions := pL^.CopyOptions;
              Point1      := ImgPoint(pL^.Pt1.X, pL^.Pt1.Y);
              Point2      := ImgPoint(pL^.Pt2.X, pL^.Pt2.Y);
            end;
            theText.Add(Format('%s(%s, %s, %s, %s, %s);',
              [RICOpCodeToStr(pL^.OpCode), RICValueToStr(pL^.CopyOptions),
               RICValueToStr(pL^.Pt1.X), RICValueToStr(pL^.Pt1.Y),
               RICValueToStr(pL^.Pt2.X), RICValueToStr(pL^.Pt2.Y)]));
          end;
        end;
        IMG_RECTANGLE_ID : begin
          if OpSize >= SizeOf(IMG_OP_RECT) then begin
            pR := @(pImage^.Rect);
            // add to the operations list
            opRect := TRICRect.Create(ops);
            with opRect do begin
              OpCode      := pR^.OpCode;
              OpSize      := pR^.OpSize;
              CopyOptions := pR^.CopyOptions;
              Point       := ImgPoint(pR^.Pt.X, pR^.Pt.Y);
              Width       := pR^.Width;
              Height      := pR^.Height;
            end;
            theText.Add(Format('%s(%s, %s, %s, %s, %s);',
              [RICOpCodeToStr(pR^.OpCode), RICValueToStr(pR^.CopyOptions),
               RICValueToStr(pR^.Pt.X), RICValueToStr(pR^.Pt.Y),
               RICValueToStr(pR^.Width), RICValueToStr(pR^.Height)]));
          end;
        end;
        IMG_CIRCLE_ID : begin
          if OpSize >= SizeOf(IMG_OP_CIRCLE) then begin
            pC := @(pImage^.Circle);
            // add to the operations list
            opCircle := TRICCircle.Create(ops);
            with opCircle do begin
              OpCode      := pC^.OpCode;
              OpSize      := pC^.OpSize;
              CopyOptions := pC^.CopyOptions;
              Point       := ImgPoint(pC^.Pt.X, pC^.Pt.Y);
              Radius      := pC^.Radius;
            end;
            theText.Add(Format('%s(%s, %s, %s, %s);',
              [RICOpCodeToStr(pC^.OpCode), RICValueToStr(pC^.CopyOptions),
               RICValueToStr(pC^.Pt.X), RICValueToStr(pC^.Pt.Y),
               RICValueToStr(pC^.Radius)]));
          end;
        end;
        IMG_NUMBOX_ID : begin
          if OpSize >= SizeOf(IMG_OP_NUMBOX) then begin
            pNB := @(pImage^.NumBox);
            // add to the operations list
            opNumBox := TRICNumBox.Create(ops);
            with opNumBox do begin
              OpCode      := pNB^.OpCode;
              OpSize      := pNB^.OpSize;
              CopyOptions := pNB^.CopyOptions;
              Point       := ImgPoint(pNB^.Pt.X, pNB^.Pt.Y);
              Value       := pNB^.Value;
            end;
            theText.Add(Format('%s(%s, %s, %s, %s);',
              [RICOpCodeToStr(pNB^.OpCode), RICValueToStr(pNB^.CopyOptions),
               RICValueToStr(pNB^.Pt.X), RICValueToStr(pNB^.Pt.Y),
               RICValueToStr(pNB^.Value)]));
          end;
        end;
        IMG_ELLIPSE_ID : begin
          if OpSize >= SizeOf(IMG_OP_ELLIPSE) then begin
            pE := @(pImage^.Ellipse);
            // add to the operations list
            opEllipse := TRICEllipse.Create(ops);
            with opEllipse do begin
              OpCode      := pE^.OpCode;
              OpSize      := pE^.OpSize;
              CopyOptions := pE^.CopyOptions;
              Point       := ImgPoint(pE^.Pt.X, pE^.Pt.Y);
              Radius1     := pE^.Radius1;
              Radius2     := pE^.Radius2;
            end;
            theText.Add(Format('%s(%s, %s, %s, %s, %s);',
              [RICOpCodeToStr(pE^.OpCode), RICValueToStr(pE^.CopyOptions),
               RICValueToStr(pE^.Pt.X), RICValueToStr(pE^.Pt.Y),
               RICValueToStr(pE^.Radius1), RICValueToStr(pE^.Radius2)]));
          end;
        end;
        IMG_POLYGON_ID : begin
          if OpSize >= SizeOf(IMG_OP_POLYGON) then
          begin
            pP := @(pImage^.Polygon);
            // add to the operations list
            opPolygon := TRICPolygon.Create(ops);
            with opPolygon do begin
              OpCode   := pP^.OpCode;
              OpSize   := pP^.OpSize;
              CopyOptions := pP^.CopyOptions;
            end;
            tmpCmd := Format('%s(%s', [RICOpCodeToStr(pP^.OpCode), RICValueToStr(pP^.CopyOptions)]);
            pImgPt := @(pP^.Points[0]);
            for j := 0 to pP^.Count - 1 do begin
              tmpCmd := tmpCmd + Format(', (%d, %d)', [pImgPt^.X, pImgPt^.Y]);
              opPolygon.AddPoint(pImgPt);
              inc(pImgPt);
            end;
            tmpCmd := tmpCmd + ');';
            theText.Add(tmpCmd);
            // set the OpSize value last since adding polygon points tries to change the OpSize value
            opPolygon.OpSize := pP^.OpSize;
          end;
        end;
      else
        //Unrecognized opcode so quit
        Break;
      end;
      dec(DataSize, OpSize);
      pImage := PIMG_OP_UNION(PChar(pImage) + OpSize);
    end;
    Result := theText.Text;
  finally
    theText.Free;
  end;
end;

{ TRICComp }

constructor TRICComp.Create;
begin
  inherited;
  fIncludeDirs := TStringList.Create;
  fMessages   := TStringList.Create;
  fMS         := TMemoryStream.Create;
  fOperations := TRICOps.Create;
  fCurFile    := '';
  fOptimize   := False;
  fMaxErrors  := 0;
  fCalc := TExpParser.Create(nil);
  fCalc.CaseSensitive := True;
  fFirmwareVersion  := 105; // 1.05 NXT 1.1 firmware 
end;

destructor TRICComp.Destroy;
begin
  FreeAndNil(fIncludeDirs);
  FreeAndNil(fMessages);
  FreeAndNil(fMS);
  FreeAndNil(fOperations);
  FreeAndNil(fCalc);
  inherited;
end;

{
procedure TRICComp.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
  fOperations.Draw(aPoint, Vars, Options, aCanvas);
end;
}

function TRICComp.GetAsText: string;
begin
  // make sure the stream matches the contents of fOperations
  SyncStreamToObjectList;
  Result := uRICComp.RICToText(fMS, fOperations, fCurFile);
end;

function TRICComp.GetOperation(Index: integer): TRICOpBase;
begin
  Result := TRICOpBase(fOperations[Index]);
end;

function TRICComp.GetOpCount: Integer;
begin
  Result := fOperations.Count;
end;

procedure TRICComp.LoadFromFile(const aFilename: string);
var
  Stream: TStream;
begin
  fCurFile := aFilename;
  Stream := TFileStream.Create(aFilename, fmOpenRead or fmShareDenyWrite);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TRICComp.LoadFromStream(aStream: TStream);
begin
  fMS.LoadFromStream(aStream);
  SyncObjectListToStream;
end;

class function TRICComp.RICToText(aStream: TStream; const aFilename : string): string;
begin
  with TRICComp.Create do
  try
    fCurFile := aFilename;
    LoadFromStream(aStream);
    Result := AsText;
  finally
    Free;
  end;
end;

class function TRICComp.RICToText(const aFilename: string): string;
begin
  with TRICComp.Create do
  try
    LoadFromFile(aFilename);
    Result := AsText;
  finally
    Free;
  end;
end;

procedure TRICComp.SaveToFile(const aFilename: string);
var
  Stream: TStream;
begin
  Stream := TFileStream.Create(aFilename, fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TRICComp.SaveToStream(aStream: TStream);
begin
  SyncStreamToObjectlist;
  aStream.CopyFrom(fMS, 0);
end;

procedure TRICComp.SetAsText(const Value: string);
var
  SL : TStringList;
begin
  Clear;
  // compile text to RIC
  SL := TStringList.Create;
  try
    SL.Text := Value;
    SL.SaveToStream(fMS);
    InternalParseStream;
  finally
    SL.Free;
  end;
end;

procedure TRICComp.ReportProblem(const lineNo: integer; const fName,
  msg: string; err : boolean);
var
  tmp, tmp1, tmp2, tmp3, tmp4 : string;
  stop : boolean;
begin
  if lineNo = -1 then
  begin
    tmp := msg;
    fMessages.Add(tmp);
  end
  else
  begin
    if err then
      tmp1 := Format('# Error: %s', [msg])
    else
      tmp1 := Format('# Warning: %s', [msg]);
    fMessages.Add(tmp1);
    tmp2 := Format('File "%s" ; line %d', [fName, lineNo]);
    fMessages.Add(tmp2);
    tmp3 := Format('#   %s', [fCurrentLine]);
    fMessages.Add(tmp3);
    tmp4 := '#----------------------------------------------------------';
    fMessages.Add(tmp4);
    tmp := tmp1+#13#10+tmp2+#13#10+tmp3+#13#10+tmp4;
  end;
  fBadProgram := err;
  if err then
    inc(fProgErrorCount);
  stop := (MaxErrors > 0) and (fProgErrorCount >= MaxErrors);
//  stop := false;
  if assigned(fOnCompMsg) then
    fOnCompMsg(tmp, stop);
  if stop then
    Abort;
end;

procedure TRICComp.IncLineNumber;
begin
  linenumber := linenumber + 1;
  inc(totallines);
end;

procedure TRICComp.GetCharX;
var
  bytesread : integer;
begin
  bytesread := fMS.Read(Look, 1);
  inc(fBytesRead, bytesread);
  fCurrentLine := fCurrentLine + Look;
  if Look = LF then
  begin
    IncLineNumber;
    fCurrentLine := '';
  end;
  if bytesread < 1 then
    endofallsource := True;
  if endofallsource and (slevel > 1) then begin
    // close file pointer
    linenumber := 0;
    dec(slevel);
    Look := LF;
    endofallsource := False;
  end;
end;

procedure TRICComp.GetChar;
begin
  if fTempChar <> ' ' then begin
    Look := fTempChar;
    fCurrentLine := fCurrentLine + Look;
    fTempChar := ' ';
  end
  else begin
    GetCharX;
    if Look = '/' then begin
      fMS.Read(fTempChar, 1);
      if fTempChar = '*' then begin
        Look := TOK_BLOCK_COMMENT;
        fTempChar := ' ';
      end
      else if fTempChar = '/' then begin
        Look := TOK_LINE_COMMENT;
        fTempChar := ' ';
      end;
    end;
  end;
end;

function TRICComp.IsWhite(c: char): boolean;
begin
  Result := c in [' ', TAB, CR, LF, TOK_BLOCK_COMMENT, TOK_LINE_COMMENT];
end;

function TRICComp.IsAlpha(c: char): boolean;
begin
  Result := c in ['A'..'Z', 'a'..'z', '_'];
end;

function TRICComp.IsDigit(c: char): boolean;
begin
  Result := c in ['0'..'9'];
end;

function TRICComp.IsHex(c: char): boolean;
begin
  Result := IsDigit(c) or (c in ['a'..'f', 'A'..'F']);
end;

function TRICComp.IsAlNum(c: char): boolean;
begin
  Result := IsAlpha(c) or IsDigit(c) or (c = '.');
end;

procedure TRICComp.SkipCommentBlock;
begin
  repeat
    repeat
      GetCharX;
    until (Look = '*') or endofallsource;
    GetCharX;
  until (Look = '/') or endofallsource;
  GetChar;
end;

procedure TRICComp.SkipLine;
begin
  repeat
    GetCharX;
  until (Look = LF) or endofallsource;
  GetChar;
end;

procedure TRICComp.SkipWhite;
begin
  while IsWhite(Look) and not endofallsource do begin
    case Look of
      TOK_LINE_COMMENT : SkipLine;
      TOK_BLOCK_COMMENT : SkipCommentBlock;
    else
      GetChar;
    end;
  end;
end;

procedure TRICComp.AbortMsg(s: string);
begin
  ReportProblem(linenumber, CurrentFile, s, True);
end;

procedure TRICComp.Expected(s: string);
begin
  AbortMsg(Format(sExpectedString, [s]));
end;

procedure TRICComp.GetName;
begin
  SkipWhite;
  if not IsAlpha(Look) then Expected(sIdentifier);
  Token := TOK_IDENTIFIER;
  Value := '';
  repeat
    Value := Value + Look;
    GetChar;
  until not IsAlNum(Look);
end;

procedure TRICComp.GetNum;
var
  savedLook : char;
begin
  SkipWhite;
  if not IsDigit(Look) then Expected(sNumber);
  savedLook := Look;
  GetChar;
  if Look in ['x', 'X'] then
  begin
    GetHexNum;
  end
  else
  begin
    Token := TOK_NUM;
    Value := savedLook;
    if not IsDigit(Look) then Exit;
    repeat
      Value := Value + Look;
      GetChar;
    until not IsDigit(Look);
  end;
end;

procedure TRICComp.GetHexNum;
begin
  SkipWhite;
  GetChar(); // skip the $ (or 'x')
  if not IsHex(Look) then Expected(sHexNumber);
  Token := TOK_HEX;
  Value := '0x';
  repeat
    Value := Value + Look;
    GetChar;
  until not IsHex(Look);
end;

procedure TRICComp.GetOp;
begin
  SkipWhite;
  Token := Look;
  Value := Look;
  GetChar;
end;

procedure TRICComp.GetString;
begin
  SkipWhite;
  GetChar; // skip the "
  Token := TOK_STRINGLIT;
  if Look = '"' then
  begin
    // empty string
    Value := '''''';
    GetChar;
  end
  else
  begin
    Value := '''' + Look;
    repeat
      GetCharX;
      if (Look <> LF) and (Look <> '"') then
      begin
        if Look = '''' then
          Value := Value + '"'
        else
          Value := Value + Look;
      end;
    until (Look = '"') or (Look = LF) or endofallsource;
    Value := Value + '''';
    if Look <> '"' then Expected(sStringLiteral);
    GetChar;
  end;
end;

procedure TRICComp.Next;
begin
  SkipWhite;
  if Look = '"' then GetString
  else if IsAlpha(Look) then GetName
  else if IsDigit(Look) then GetNum
  else if Look = '$' then GetHexNum
  else GetOp;
end;


procedure TRICComp.Init;
begin
  fCurrentLine := '';
  totallines := 1;
  linenumber := 1;
  GetChar;
  Next;
  while (Token = #0) and not endofallsource do
    Next;
end;

function Lookup(T: TabPtr; s: string; n: integer): integer;
var
  i: integer;
  found: Boolean;
begin
  found := false;
  i := n;
  while (i > 0) and not found do
     if s = T^[i] then
        found := true
     else
        dec(i);
  Result := i;
end;

procedure TRICComp.Scan;
var
  idx : integer;
begin
  if Token = TOK_IDENTIFIER then
  begin
    idx := Lookup(Addr(KWlist), Value, NKW);
    if idx <> 0 then
      Token := KWcode[idx + 1];
  end;
end;

procedure TRICComp.CheckBytesRead(const oldBytesRead: integer);
begin
  if fBytesRead = oldBytesRead then
  begin
    AbortMsg(sParserError);
    SkipLine;
    Next;
  end;
end;

procedure TRICComp.MatchString(x: string);
begin
  if Value <> x then Expected('''' + x + '''');
  Next;
end;

procedure TRICComp.CheckNumeric;
begin
  if not (Token in [TOK_NUM, TOK_HEX]) then Expected(sNumber);
end;

procedure TRICComp.CheckStringConst;
begin
  if (Token <> TOK_STRINGLIT) then
    Expected(sStringLiteral);
end;

procedure TRICComp.Semi;
begin
  MatchString(';');
end;

procedure TRICComp.OpenParen;
begin
  MatchString(TOK_OPENPAREN);
  inc(fParenDepth);
end;

procedure TRICComp.CloseParen;
begin
  dec(fParenDepth);
  if fParenDepth < 0 then
    AbortMsg(sUnmatchedCloseParen);
  MatchString(TOK_CLOSEPAREN);
end;

function TRICComp.StringToInt(const val : string) : integer;
begin
  Result := 0;
  fCalc.SilentExpression := val;
  if not fCalc.ParserError then
    Result := Integer(Trunc(fCalc.Value))
  else
    AbortMsg(sInvalidConstExpr);
end;

function TRICComp.ValueToInt : integer;
begin
  Result := StringToInt(Value);
end;

function TRICComp.ValueToSmallInt : SmallInt;
begin
  Result := SmallInt(ValueToInt);
end;

function TRICComp.ValueToWord : Word;
begin
  Result := Word(ValueToInt);
end;

function TRICComp.ProcessWordArg : Word;
begin
  Result := Word(ProcessArg);
end;

function TRICComp.ProcessArg : SmallInt;
var
  mapidx : SmallInt;
begin
  Result := 0;
  {
   arg can be a simple numeric value: 0x12, 32, or $f
   or a parameterized argument: arg(0x12), arg(32), arg($f)
   or a parameterized & mapped argument: maparg(0x1, 0x12), maparg(1, 23), etc...
  }
  case Token of
    TOK_ARG : begin
      // arg(value)
      Next;
      MatchString(TOK_OPENPAREN);
      CheckNumeric;
      Result := ValueToSmallInt;
      if (Result < 0) or
         (EnhancedFirmware and (Result > $ff)) or
         (not EnhancedFirmware and (Result > $f))then
        AbortMsg(Format(sInvalidArgument, [Result]));
      Result := Result or USEARGS_MASK;
      Next;
      // leave it pointing at the close paren
    end;
    TOK_MAPARG : begin
      // maparg(value, value)
      Next;
      MatchString(TOK_OPENPAREN);
      CheckNumeric;
      mapidx := ValueToSmallInt;
      if (mapidx < 0) or (mapidx > $a) then
        AbortMsg(Format(sInvalidVarMapIndex, [mapidx]));
      Next;
      MatchString(TOK_COMMA);
      Result := ValueToSmallInt;
      if (Result < 0) or
         (EnhancedFirmware and (Result > $ff)) or
         (not EnhancedFirmware and (Result > $f))then
        AbortMsg(Format(sInvalidArgument, [Result]));
      Result := Result or SmallInt((mapidx and $f) shl 8);
      Result := Result or USEARGS_MASK;
      Next;
      // leave it pointing at the close paren
    end;
    TOK_NUM, TOK_HEX : begin
      Result := ValueToSmallInt;
    end;
  else
    AbortMsg(sInvalidCommandArgument);
  end;
end;

procedure TRICComp.DoDesc;
var
  op : TRICDescription;
begin
  // add a description opcode
  op := TRICDescription.Create(RICOps);
  // parse and set its values
  // desc(options, width, height);
  Next;
  OpenParen;
  CheckNumeric;
  op.Options := ValueToWord;
  Next;
  MatchString(TOK_COMMA);
  CheckNumeric;
  op.Width := ValueToWord;
  Next;
  MatchString(TOK_COMMA);
  CheckNumeric;
  op.Height := ValueToWord;
  Next;
  CloseParen;
end;

procedure TRICComp.DoSprite;
var
  op : TRICSprite;
  sl : TStringList;
  i : integer;
  bFileFound : boolean;
  fname, usePath : string;
  thresh, width, height : integer;
const
  DEF_SPRITE_IMPORT_THRESHOLD = 50;
  DEF_SPRITE_IMPORT_WIDTH     = 100;
  DEF_SPRITE_IMPORT_HEIGHT    = 64;
begin
  // add a sprite opcode
  op := TRICSprite.Create(RICOps);
  // parse and set its values
  // sprite(addr, row1, row2, ..., rowN);
  // sprite(addr, import("filename.ext"[, threshold]));
  // sprite(addr, import("filename.ext"[, threshold, width, height]));
  Next;
  OpenParen;
  CheckNumeric;
  op.DataAddr := ValueToWord;
  Next;
  MatchString(TOK_COMMA);
  scan;
  if Token = TOK_IMPORT then begin
    // support "import" keyword
    thresh := DEF_SPRITE_IMPORT_THRESHOLD;
    width  := DEF_SPRITE_IMPORT_WIDTH;
    height := DEF_SPRITE_IMPORT_HEIGHT;
    Next;
    OpenParen;
    CheckStringConst;
    fname := Value;
    Next;
    if Token = TOK_COMMA then begin
      MatchString(TOK_COMMA);
      // optional threshold value
      CheckNumeric;
      thresh := StrToIntDef(Value, thresh);
      Next;
      if Token = TOK_COMMA then begin
        MatchString(TOK_COMMA);
        // optional width & height
        CheckNumeric;
        width := StrToIntDef(Value, width);
        Next;
        MatchString(TOK_COMMA);
        CheckNumeric;
        height := StrToIntDef(Value, height);
        Next;
      end;
    end;
    CloseParen;
    CloseParen;
    // build sprite bytes using fname and thresh
    // find sprite file
    fName := StripQuotes(fName);
    usePath := '';
    bFileFound := FileExists(fname);
    if not bFileFound then
    begin
      for i := 0 to IncludeDirs.Count - 1 do
      begin
        usePath := IncludeTrailingPathDelimiter(IncludeDirs[i]);
        bFileFound := FileExists(usePath+fname);
        if bFileFound then Break;
      end;
    end;
    if bFileFound then
    begin
      ImportImage(op, usePath+fname, thresh, width, height);
    end
    else
      AbortMsg(Format(sUnableToFindImage, [fname]));
  end
  else
  begin
    sl := TStringList.Create;
    try
      while (Token <> TOK_CLOSEPAREN) and not endofallsource do
      begin
        sl.Add(Value + '=' + IntToStr(linenumber));
        Next;
        if Token = TOK_COMMA then
          MatchString(TOK_COMMA);
      end;
      CloseParen;
      // process strings in sl
      // calculate rows and rowbytes
      op.Rows := Word(sl.Count);
      if sl.count = 0 then
      begin
        op.RowBytes := 0;
        AbortMsg(sSpriteLengthError);
      end
      else
        op.RowBytes := op.CountBytes(sl.Names[0]);
      for i := 0 to sl.Count - 1 do
      begin
        // add bytes to Sprite for each line in sl
        try
          op.AddBytes(sl.Names[i]);
        except
          on E : Exception do
            AbortMsg(E.Message);
        end;
      end;
    finally
      sl.Free;
    end;
  end;
  if ((op.Rows*op.RowBytes) mod 2) = 1 then
    op.Add(0); // padding byte
end;

procedure TRICComp.DoVarMap;
var
  op : TRICVarMap;
  ME : TMapElement;
begin
  // add a varmap opcode
  op := TRICVarMap.Create(RICOps);
  // parse and set its values
  // varmap(addr, func1, func2, ..., funcN);
  // where funcN is f(xval)=yval
  Next;
  OpenParen;
  CheckNumeric;
  op.DataAddr := ValueToWord;
  Next;
  MatchString(TOK_COMMA);
  while (Token <> TOK_CLOSEPAREN) and not endofallsource do
  begin
    // f(x)=y
    Scan;
    if Token <> TOK_F then
      AbortMsg(sInvalidMapSyntax);
    Next; // advance to open parenthesis
    OpenParen; // advance to x value
    ME := op.Add;
    CheckNumeric;
    ME.Domain := ValueToWord;
    Next; // advance to close parenthesis
    CloseParen; // advance to equal sign
    MatchString('=');
//    Next; // advance to y value
    CheckNumeric;
    ME.Range := ValueToWord;
    Next; // advance to comma or close paren
    if Token = TOK_COMMA then
      MatchString(TOK_COMMA);
  end;
  CloseParen;
  if op.MapCount < 2 then
    AbortMsg(sVarMapCountError);
end;

procedure TRICComp.DoCopyBits;
var
  op : TRICCopyBits;
  SR : TImgRect;
  DP : TImgPoint;
begin
  // add a copybits opcode
  op := TRICCopyBits.Create(RICOps);
  // parse and set its values
  // copybits(options, dataaddr, srcx, srcy, srcw, srch, destx, desty);
  Next;
  OpenParen;
  Scan;
  op.CopyOptions := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  op.DataAddr := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  SR.Pt.X := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  SR.Pt.Y := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  SR.Width := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  SR.Height := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  op.SrcRect := SR;
  DP.X := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  DP.Y := ProcessArg;
  Next;
  CloseParen;
  op.DestPoint := DP;
end;

procedure TRICComp.DoLine;
var
  op : TRICLine;
  P1, P2 : TImgPoint;
begin
  // add a line opcode
  op := TRICLine.Create(RICOps);
  // parse and set its values
  // line(options, p1x, p1y, p2x, p2y);
  Next;
  OpenParen;
  Scan;
  op.CopyOptions := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P1.X := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P1.Y := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P2.X := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P2.Y := ProcessArg;
  Next;
  CloseParen;
  op.Point1 := P1;
  op.Point2 := P2;
end;

procedure TRICComp.DoRect;
var
  op : TRICRect;
  P : TImgPoint;
begin
  // add a rect opcode
  op := TRICRect.Create(RICOps);
  // parse and set its values
  // rect(options, x, y, w, h);
  Next;
  OpenParen;
  Scan;
  op.CopyOptions := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.X := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.Y := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  op.Point := P;
  op.Width := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  op.Height := ProcessArg;
  Next;
  CloseParen;
end;

procedure TRICComp.DoPixel;
var
  op : TRICPixel;
  P : TImgPoint;
begin
  // add a pixel opcode
  op := TRICPixel.Create(RICOps);
  // parse and set its values
  // pixel(options, x, y, value);
  Next;
  OpenParen;
  Scan;
  op.CopyOptions := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.X := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.Y := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  op.Point := P;
  op.Value := ProcessWordArg;
  Next;
  CloseParen;
end;

procedure TRICComp.DoCircle;
var
  op : TRICCircle;
  P : TImgPoint;
begin
  // add a circle opcode
  op := TRICCircle.Create(RICOps);
  // parse and set its values
  // circle(options, x, y, radius);
  Next;
  OpenParen;
  Scan;
  op.CopyOptions := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.X := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.Y := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  op.Point := P;
  op.Radius := ProcessWordArg;
  Next;
  CloseParen;
end;

procedure TRICComp.DoEllipse;
var
  op : TRICEllipse;
  P : TImgPoint;
begin
  CheckFirmwareVersion(127, sEllipseRequires127);
  // add an ellipse opcode
  op := TRICEllipse.Create(RICOps);
  // parse and set its values
  // ellipse(options, x, y, radius1, radius2);
  Next;
  OpenParen;
  Scan;
  op.CopyOptions := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.X := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.Y := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  op.Point := P;
  op.Radius1 := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  op.Radius2 := ProcessWordArg;
  Next;
  CloseParen;
end;

procedure TRICComp.DoPolygon;
var
  op : TRICPolygon;
  PP : TPolyPoint;
begin
  CheckFirmwareVersion(127, sPolygonRequires127);
  // add a polygon opcode
  op := TRICPolygon.Create(RICOps);
  // parse and set its values
  // polygon(options, coord1, coord2, ..., coordN);
  // where coordN is (xval, yval)
  Next;
  OpenParen;
  Scan;
  op.CopyOptions := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  while (Token <> TOK_CLOSEPAREN) and not endofallsource do
  begin
    // (x, y)
    OpenParen; // advance to x value
    PP := op.Add;
    Scan;
    PP.X := ProcessWordArg;
    Next; // advance to comma
    MatchString(',');
    Scan;
    PP.Y := ProcessWordArg;
    Next;
    CloseParen; // advance to close paren or comma
    if Token = TOK_COMMA then
      MatchString(TOK_COMMA);
  end;
  CloseParen;
  if op.Count < 3 then
    AbortMsg(sPolygonCountError);
end;

procedure TRICComp.DoNumBox;
var
  op : TRICNumBox;
  P : TImgPoint;
begin
  // add a numbox opcode
  op := TRICNumBox.Create(RICOps);
  // parse and set its values
  // numbox(options, x, y, value);
  Next;
  OpenParen;
  Scan;
  op.CopyOptions := ProcessWordArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.X := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  P.Y := ProcessArg;
  Next;
  MatchString(TOK_COMMA);
  Scan;
  op.Point := P;
  op.Value := ProcessWordArg;
  Next;
  CloseParen;
end;

procedure TRICComp.Statement;
begin
  case Token of
    TOK_DESC:       DoDesc;
    TOK_SPRITE:     DoSprite;
    TOK_VARMAP:     DoVarMap;
    TOK_COPYBITS:   DoCopyBits;
    TOK_LINE:       DoLine;
    TOK_RECT:       DoRect;
    TOK_PIXEL:      DoPixel;
    TOK_CIRCLE:     DoCircle;
    TOK_NUMBOX:     DoNumBox;
    TOK_ELLIPSE:    DoEllipse;
    TOK_POLYGON:    DoPolygon;
    TOK_CLOSEPAREN : CloseParen;
    ';' : ;// do nothing
  end;
end;

procedure TRICComp.ScriptCommands;
var
  oldBytesRead : integer;
begin
  Scan;
  while not endofallsource do
  begin
    oldBytesRead := fBytesRead;
    Statement;
    Semi;
    Scan;
    CheckBytesRead(oldBytesRead);
  end;
end;

procedure TRICComp.InternalParseStream;
begin
  try
    fBadProgram     := False;
    fBytesRead      := 0;
    fProgErrorCount := 0;
    fMS.Position    := 0;
    fParenDepth     := 0;
    Init;
    ScriptCommands;
  except
    on E : EAbort do
    begin
      fBadProgram := True;
      // end processing file due to Abort in ReportProblem
    end;
    on E : Exception do
    begin
      fBadProgram := True;
      ReportProblem(linenumber, CurrentFile, E.Message, true);
    end;
  end;
end;

procedure TRICComp.SyncObjectListToStream;
begin
  uRICComp.RICToText(fMS, fOperations, fCurFile);
end;

procedure TRICComp.SyncStreamToObjectList;
var
  i : integer;
begin             
  fMS.Clear;
  for i := 0 to fOperations.Count - 1 do
    TRICOpBase(fOperations[i]).SaveToStream(fMS);
end;

procedure TRICComp.Parse(aStream: TStream);
begin
  Clear;
  fMS.CopyFrom(aStream, 0);
  InternalParseStream;
end;

procedure TRICComp.Parse(aStrings: TStrings);
begin
  Clear;
  aStrings.SaveToStream(fMS);
  InternalParseStream;
end;

procedure TRICComp.Parse(const aFilename: string);
var
  Stream : TFileStream;
begin
  Clear;
  Stream := TFileStream.Create(aFilename, fmOpenRead or fmShareDenyWrite);
  try
    fMS.CopyFrom(Stream, 0);
  finally
    Stream.Free;
  end;
  InternalParseStream;
end;

procedure TRICComp.Clear;
begin
  fMS.Clear;
  fMessages.Clear;
  fTempChar := ' ';
end;

function TRICComp.SaveAsDataArray(const aLangName: TLangName; varname : string): string;
var
  tmp : string;
  i : integer;
begin
  if varname = '' then
    varname := ChangeFileExt(ExtractFileName(CurrentFile),'')
  else
    varname := Format(varname, [ChangeFileExt(ExtractFileName(CurrentFile),'')]);
  if aLangName in [lnNXC, lnNXCHeader] then
  begin
    Result := 'byte ' + varname + '[] = {'#13#10;
    for i := 0 to fOperations.Count - 1 do
    begin
      Result := Result + TRICOpBase(fOperations[i]).SaveAsDataArray(aLangName);
      if i < fOperations.Count - 1 then
        Result := Result + ', ';
      Result := Result + #13#10;
    end;
    Result := Result + '};';
  end
  else if aLangName = lnNBC then
  begin
    tmp := '';
    for i := 0 to fOperations.Count - 1 do
    begin
      tmp := tmp + TRICOpBase(fOperations[i]).SaveAsDataArray(aLangName);
      if i < fOperations.Count - 1 then
        tmp := tmp + ', ';
    end;
    Result := 'dseg segment'#13#10 +
              ' ' + varname + ' byte[] ' + tmp + #13#10 +
              'dseg ends';
  end
  else
    Result := '// unable to import "' + ExtractFileName(CurrentFile) + '"';
end;

class function TRICComp.RICToDataArray(const aFilename, aVarName : string;
  const aLangName: TLangName): string;
begin
  with TRICComp.Create do
  try
    LoadFromFile(aFilename);
    Result := SaveAsDataArray(aLangName, aVarName);
  finally
    Free;
  end;
end;

procedure TRICComp.CheckFirmwareVersion(const MinVer : word; const msg : string);
begin
  if FirmwareVersion < MinVer then
    AbortMsg(msg);
end;

{ TRICDescription }

constructor TRICDescription.Create(aOwner : TRICOps);
begin
  inherited Create(aOwner);
  fOpCode := IMG_DESCRIPTION_ID;
  fOpSize := SizeOf(IMG_OP_DESCRIPTION) - 2;
end;

{
procedure TRICDescription.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
  // The description opcode is a NO-OP when it comes to drawing
end;
}

procedure TRICDescription.LoadFromStream(aStream: TStream);
var
  w : word;
begin
  inherited;
  w := 0;
  // read options, width, height from stream
  ReadWordFromStream(aStream, w); Options := w;
  ReadWordFromStream(aStream, w); Width   := w;
  ReadWordFromStream(aStream, w); Height  := w;
end;

function TRICDescription.SaveAsDataArray(const aLangName: TLangName): string;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s',
      [RICValueToStr(Options, aLangName),
       RICValueToStr(Width, aLangName),
       RICValueToStr(Height, aLangName)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpDescription(%d, %d, %d)', [Options, Width, Height])
  else
    Result := '';
end;

procedure TRICDescription.SaveToStream(aStream: TStream);
begin
  inherited;
  // write options, width, height to stream
  WriteWordToStream(aStream, Options);
  WriteWordToStream(aStream, Width);
  WriteWordToStream(aStream, Height);
end;

{ TRICSprite }

procedure TRICSprite.Add(aValue: Byte);
var
  O : TByteObject;
begin
  O := TByteObject.Create;
  fBytes.Add(O);
  O.Value := aValue;
  inc(fOpSize, 1);
end;

function Pow(k: Integer): Integer;
var
  j, Count: Integer;
begin
  if k > 0 then j := 2
    else j := 1;
  for Count := 1 to k - 1 do
    j := j * 2;
  Result := j;
end;

function BinToDec(Str: string): Integer;
var
  Len, Res, i: Integer;
begin
  Len:=Length(Str);
  Res:=0;
  for i:=1 to Len do
    if (Str[i]='0')or(Str[i]='1') then
      Res:=Res+Pow(Len-i)*StrToInt(Str[i])
    else
      raise Exception.CreateFmt(sStringNotBinary, [Str]);
  Result := Res;
end;

function IsHexString(const val : string) : boolean;
begin
  Result := Pos('0x', val) = 1;
end;

procedure TRICSprite.AddBytes(val: string);
var
  bHex : boolean;
  b : Byte;
  tmp : string;
begin
  // parse string and add bytes as needed to sprite
  // each row must be either a hex string with an even number of hex digits
  // or a string containing only 1s and 0s where each character is a bit
  bHex := IsHexString(val);
  if bHex then
    System.Delete(val, 1, 2);
  if bHex and ((Length(val) mod 2) <> 0) then
    raise Exception.CreateFmt(sInvalidHexLength, [Length(val)]);
  while Length(val) > 0 do
  begin
    if bHex then
    begin
      tmp := Copy(val, 1, 2);
      System.Delete(val, 1, 2);
      b := Byte(StrToInt('$'+tmp));
    end
    else
    begin
      tmp := Copy(val, 1, 8);
      System.Delete(val, 1, 8);
      if Length(tmp) < 8 then
        tmp := tmp + StringOfChar('0', 8-Length(tmp));
      b := Byte(BinToDec(tmp));
    end;
    Add(b);
  end;
end;

function TRICSprite.BytesToWrite: Integer;
begin
  Result := Rows*RowBytes;
  if (Result mod 2) = 1 then
    Inc(Result);
end;

class function TRICSprite.CountBytes(val: string): Word;
var
  bHex : boolean;
  len : Word;
begin
  // we count bytes based on the length of the string and
  // whether it is hex or not.
  bHex := IsHexString(val);
  if bHex then
    System.Delete(val, 1, 2);
  len := Word(Length(val));
  if bHex then
    Result := Word(len div 2)
  else
  begin
    Result := Word(len div 8);
    if (len mod 8) <> 0 then
      inc(Result);
  end;
end;

constructor TRICSprite.Create(aOwner : TRICOps);
begin
  inherited Create(aOwner);
  fBytes := TObjectList.Create;
  fOpCode := IMG_SPRITE_ID;
  fOpSize := SizeOf(IMG_OP_SPRITE) - 4; // remove sizeof(fOpCode) + 2 bytes
end;

destructor TRICSprite.Destroy;
begin
  FreeAndNil(fBytes);
  inherited;
end;

{
procedure TRICSprite.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
  // drawing a sprite just copies the sprite into a data address
  // so that a future CopyBits opcode can access it.
end;
}

function TRICSprite.GetByte(Index: Integer): Byte;
begin
  Result := TByteObject(fBytes[Index]).Value;
end;

function TRICSprite.GetByteCount: Integer;
begin
  Result := fBytes.Count;
end;

function TRICSprite.GetByteValue(const idx: integer): Byte;
begin
  if idx < ByteCount then
    Result := Bytes[idx]
  else
    Result := 0;
end;

function TRICSprite.GetOpSize: Word;
begin
  Result := fOpSize;
  if (Result mod 2) = 1 then
    Inc(Result);
end;

procedure TRICSprite.LoadFromStream(aStream: TStream);
var
  da, r, rb : Word;
  B : Byte;
  BytesToRead, i : integer;
begin
  inherited;
  da := 0;
  r  := 0;
  rb := 0;
  B  := 0;
  ReadWordFromStream(aStream, da);
  ReadWordFromStream(aStream, r);
  ReadWordFromStream(aStream, rb);
  DataAddr := da;
  Rows     := r;
  RowBytes := rb;
  // read bytes from stream
  BytesToRead := Rows*RowBytes;
  if (BytesToRead mod 2) = 1 then
    Inc(BytesToRead);
  for i := 0 to BytesToRead - 1 do
  begin
    aStream.Read(B, 1);
    Add(B);
  end;
end;

function TRICSprite.SaveAsDataArray(const aLangName: TLangName): string;

  function OutputBytes(bIsNXCHeader : boolean) : string;
  var
    i, cnt : integer;
    B : Byte;
  begin
    if bIsNXCHeader then
      Result := 'RICSpriteData('
    else
      Result := '';
    cnt := BytesToWrite - 1;
    for i := 0 to cnt do
    begin
      B := GetByteValue(i);
      Result := Result + Format('0x%2.2x', [B]);
      if i < cnt then
      begin
        Result := Result + ', ';
        if bIsNXCHeader and ((i mod 8) = 0) and (i > 0) then
          Result := Result + #13#10'    ';
      end;
    end;
    if bIsNXCHeader then
      Result := Result + ')';
  end;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s, %s',
      [RICValueToStr(DataAddr, aLangName),
       RICValueToStr(Rows, aLangName),
       RICValueToStr(RowBytes, aLangName),
       OutputBytes(false)]);
  end
  else if aLangName = lnNXCHeader then
  begin
    Result := Format('RICOpSprite(%d, %d, %d,'#13#10'  %s)',
      [DataAddr, Rows, RowBytes, OutputBytes(true)]);
  end
  else
    Result := '';
end;

procedure TRICSprite.SaveToStream(aStream: TStream);
var
  B : Byte;
  i : integer;
begin
  inherited;
  WriteWordToStream(aStream, DataAddr);
  WriteWordToStream(aStream, Rows);
  WriteWordToStream(aStream, RowBytes);
  // now write out all the bytes in the Bytes array
  for i := 0 to BytesToWrite - 1 do
  begin
    B := GetByteValue(i);
    aStream.Write(B, 1);
  end;
end;

procedure TRICSprite.SetByte(Index: Integer; const Value: Byte);
begin
  TByteObject(fBytes[Index]).Value := Value;
end;

{ TRICOpBase }

constructor TRICOpBase.Create(aOwner : TRICOps);
begin
  inherited Create;
  fOwner := aOwner;
  fOwner.Add(Self);
  fOpCode := 0;
  fOpSize := 0;
end;

destructor TRICOpBase.Destroy;
begin
  inherited;
end;

function TRICOpBase.GetOpSize: Word;
begin
  Result := fOpSize;
end;

procedure TRICOpBase.LoadFromStream(aStream: TStream);
var
  w : word;
begin
  // read size and opcode from stream
  w := 0;
  ReadWordFromStream(aStream, w); OpSize := w;
  ReadWordFromStream(aStream, w); OpCode := w;
end;

function TRICOpBase.SaveAsDataArray(const aLangName: TLangName): string;
begin
  if aLangName in [lnNBC, lnNXC] then
    Result := Format('%s, %s',
      [RICValueToStr(OpSize, aLangName), RICValueToStr(OpCode, aLangName)])
  else
    Result := '';
end;

procedure TRICOpBase.SaveToStream(aStream: TStream);
begin
  // write size and opcode to stream
  WriteWordToStream(aStream, OpSize);
  WriteWordToStream(aStream, OpCode);
end;

{ TRICVarMap }

function TRICVarMap.Add: TMapElement;
begin
  Result := TMapElement.Create;
  fMapElements.Add(Result);
  inc(fOpSize, 4);
end;

procedure TRICVarMap.AddMap(aMapElement: PIOV_MAPELT);
var
  ME : TMapElement;
begin
  ME := TMapElement.Create;
  fMapElements.Add(ME);
  ME.Domain := aMapElement^.Domain;
  ME.Range  := aMapElement^.Range;
  inc(fOpSize, 4);
end;

constructor TRICVarMap.Create(aOwner : TRICOps);
begin
  inherited Create(aOwner);
  fMapElements := TObjectList.Create;
  fOpCode := IMG_VARMAP_ID;
  fOpSize := SizeOf(IMG_OP_VARMAP) - 10;
end;

destructor TRICVarMap.Destroy;
begin
  FreeAndNil(fMapElements);
  inherited;
end;

{
procedure TRICVarMap.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
  // copy varmap to specified address
end;
}

function TRICVarMap.GetMapCount: Word;
begin
  Result := Word(fMapElements.Count);
end;

function TRICVarMap.GetMapElement(Index: Integer): TMapElement;
begin
  Result := TMapElement(fMapElements[Index]);
end;

procedure TRICVarMap.LoadFromStream(aStream: TStream);
var
  da, mc, d, r : word;
  i : integer;
  ME : TMapElement;
begin
  inherited;
  da := 0;
  mc := 0;
  d  := 0;
  r  := 0;
  ReadWordFromStream(aStream, da);
  ReadWordFromStream(aStream, mc);
  DataAddr := da;
  for i := 0 to mc - 1 do
  begin
    // read map elements from stream
    ReadWordFromStream(aStream, d);
    ReadWordFromStream(aStream, r);
    ME := Add;
    ME.Domain := d;
    ME.Range  := r;
  end;
end;

function TRICVarMap.SaveAsDataArray(const aLangName: TLangName): string;
  function OutputBytes(bIsNXCHeader : boolean) : string;
  var
    i, cnt : integer;
    ME : TMapElement;
  begin
    if bIsNXCHeader then
      Result := 'RICMapFunction('
    else
      Result := '';
    cnt := MapCount - 1;
    for i := 0 to cnt do
    begin
      ME := Self.MapElements[i];
      if bIsNXCHeader then
        Result := Result + Format('RICMapElement(%d, %d)', [ME.Domain, ME.Range])
      else
        Result := Result + Format('%s, %s', [RICValueToStr(ME.Domain, lnNBC), RICValueToStr(ME.Range, lnNBC)]);
      if i < cnt then
      begin
        Result := Result + ', ';
        if bIsNXCHeader {and ((i mod 4) = 0) and (i > 0)} then
          Result := Result + #13#10'    ';
      end;
    end;
    if bIsNXCHeader then
      Result := Result + ')';
  end;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s',
      [RICValueToStr(DataAddr, aLangName),
       RICValueToStr(MapCount, aLangName),
       OutputBytes(false)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpVarMap(%d, %d,'#13#10'  %s)',
      [DataAddr,
       MapCount,
       OutputBytes(true)])
  else
    Result := '';
end;

procedure TRICVarMap.SaveToStream(aStream: TStream);
var
  i : integer;
  ME : TMapElement;
begin
  inherited;
  WriteWordToStream(aStream, DataAddr);
  WriteWordToStream(aStream, MapCount);
  // now write out all the elements in the MapElement array
  for i := 0 to MapCount - 1 do
  begin
    ME := Self.MapElements[i];
    WriteWordToStream(aStream, ME.Domain);
    WriteWordToStream(aStream, ME.Range);
  end;
end;

procedure TRICVarMap.SetMapElement(Index: Integer;
  const Value: TMapElement);
begin
  TMapElement(fMapElements[Index]).Domain := Value.Domain;
  TMapElement(fMapElements[Index]).Range  := Value.Range;
end;

{ TRICCopyBits }

constructor TRICCopyBits.Create(aOwner : TRICOps);
begin
  inherited Create(aOwner);
  fOpCode := IMG_COPYBITS_ID;
  fOpSize := SizeOf(IMG_OP_COPYBITS) - 2;
end;

{
procedure TRICCopyBits.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
// draw bits from specified image
end;
}

procedure TRICCopyBits.LoadFromStream(aStream: TStream);
var
  co, da : Word;
  r : TImgRect;
  p : TImgPoint;
begin
  inherited;
  // read CopyOptions, DataAddr, SrcRect, DestPoint from stream
  co := 0;
  da := 0;
  r.Pt.X := 0;
  r.Pt.Y := 0;
  r.Width := 0;
  r.Height := 0;
  p.X := 0;
  p.Y := 0;
  ReadWordFromStream(aStream, co);
  ReadWordFromStream(aStream, da);
  ReadImgRectFromStream(aStream, r);
  ReadImgPointFromStream(aStream, p);
  CopyOptions := co;
  DataAddr    := da;
  SrcRect     := r;
  DestPoint   := p;
end;

function TRICCopyBits.SaveAsDataArray(const aLangName: TLangName): string;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s, %s',
      [RICValueToStr(CopyOptions, aLangName),
       RICValueToStr(DataAddr, aLangName),
       RICRectToStr(SrcRect, aLangName),
       RICPointToStr(DestPoint, aLangName)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpCopyBits(%s, %s, %s, %s)',
      [RICValueToStr(CopyOptions, aLangName),
       RICValueToStr(DataAddr, aLangName),
       RICRectToStr(SrcRect, aLangName),
       RICPointToStr(DestPoint, aLangName)])
  else
    Result := '';
end;

procedure TRICCopyBits.SaveToStream(aStream: TStream);
begin
  inherited;
  // write CopyOptions, DataAddr, SrcRect, DestPoint to stream
  WriteWordToStream(aStream, CopyOptions);
  WriteWordToStream(aStream, DataAddr);
  WriteImgRectToStream(aStream, SrcRect);
  WriteImgPointToStream(aStream, DestPoint);
end;

{ TRICPixel }

constructor TRICPixel.Create(aOwner : TRICOps);
begin
  inherited Create(aOwner);
  fOpCode := IMG_PIXEL_ID;
  fOpSize := SizeOf(IMG_OP_PIXEL) - 2;
  // the standard NXT firmware has a bug in it which needs to be
  // worked around
end;

{
procedure TRICPixel.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
  // draw this pixel to the specified canvas
  // resolve all the values as required
end;
}

procedure TRICPixel.LoadFromStream(aStream: TStream);
var
  p : TImgPoint;
  co, v : Word;
begin
  inherited;
  // read point from stream
  co := 0;
  v  := 0;
  p.X := 0;
  p.Y := 0;
  ReadWordFromStream(aStream, co);
  ReadImgPointFromStream(aStream, p);
  ReadWordFromStream(aStream, v);
  CopyOptions := co;
  Point       := p;
  Value       := v;
end;

function TRICPixel.SaveAsDataArray(const aLangName: TLangName): string;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Value, aLangName)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpPixel(%s, %s, %s)',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Value, aLangName)])
  else
    Result := '';
end;

procedure TRICPixel.SaveToStream(aStream: TStream);
begin
  inherited;
  WriteWordToStream(aStream, CopyOptions);
  WriteImgPointToStream(aStream, Point);
  WriteWordToStream(aStream, Value);
end;

{ TRICLine }

constructor TRICLine.Create(aOwner : TRICOps);
begin
  inherited Create(aOwner);
  fOpCode := IMG_LINE_ID;
  fOpSize := SizeOf(IMG_OP_LINE) - 2;
end;

{
procedure TRICLine.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
// draw line as specified
end;
}

procedure TRICLine.LoadFromStream(aStream: TStream);
var
  p1, p2 : TImgPoint;
  co : Word;
begin
  inherited;
  co := 0;
  p1.X := 0;
  p1.Y := 0;
  p2.X := 0;
  p2.Y := 0;
  ReadWordFromStream(aStream, co);
  ReadImgPointFromStream(aStream, p1);
  ReadImgPointFromStream(aStream, p2);
  CopyOptions := co;
  Point1      := p1;
  Point2      := p2;
end;

function TRICLine.SaveAsDataArray(const aLangName: TLangName): string;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point1, aLangName),
       RICPointToStr(Point2, aLangName)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpLine(%s, %s, %s)',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point1, aLangName),
       RICPointToStr(Point2, aLangName)])
  else
    Result := '';
end;

procedure TRICLine.SaveToStream(aStream: TStream);
begin
  inherited;
  WriteWordToStream(aStream, CopyOptions);
  WriteImgPointToStream(aStream, Point1);
  WriteImgPointToStream(aStream, Point2);
end;

{ TRICRect }

constructor TRICRect.Create(aOwner : TRICOps);
begin
  inherited Create(aOwner);
  fOpCode := IMG_RECTANGLE_ID;
  fOpSize := SizeOf(IMG_OP_RECT) - 2;
end;

{
procedure TRICRect.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
// draw rectangle as specified
end;
}

procedure TRICRect.LoadFromStream(aStream: TStream);
var
  p : TImgPoint;
  w, h : SmallInt;
  co : Word;
begin
  inherited;
  co := 0;
  w  := 0;
  h  := 0;
  p.X := 0;
  p.Y := 0;
  ReadWordFromStream(aStream, co);
  ReadImgPointFromStream(aStream, p);
  ReadSmallIntFromStream(aStream, w);
  ReadSmallIntFromStream(aStream, h);
  CopyOptions := co;
  Point       := p;
  Width       := w;
  Height      := h;
end;

function TRICRect.SaveAsDataArray(const aLangName: TLangName): string;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s, %s',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Width, aLangName),
       RICValueToStr(Height, aLangName)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpRect(%s, %s, %s, %s)',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Width, aLangName),
       RICValueToStr(Height, aLangName)])
  else
    Result := '';
end;

procedure TRICRect.SaveToStream(aStream: TStream);
begin
  inherited;
  WriteWordToStream(aStream, CopyOptions);
  WriteImgPointToStream(aStream, Point);
  WriteSmallIntToStream(aStream, Width);
  WriteSmallIntToStream(aStream, Height);
end;

{ TRICCircle }

constructor TRICCircle.Create(aOwner : TRICOps);
begin
  inherited Create(aOwner);
  fOpCode := IMG_CIRCLE_ID;
  fOpSize := SizeOf(IMG_OP_CIRCLE) - 2;
end;

{
procedure TRICCircle.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
// draw circle as specified
end;
}

procedure TRICCircle.LoadFromStream(aStream: TStream);
var
  p : TImgPoint;
  r, co : Word;
begin
  inherited;
  co := 0;
  r  := 0;
  p.X := 0;
  p.Y := 0;
  ReadWordFromStream(aStream, co);
  ReadImgPointFromStream(aStream, p);
  ReadWordFromStream(aStream, r);
  CopyOptions := co;
  Point       := p;
  Radius      := r;
end;

function TRICCircle.SaveAsDataArray(const aLangName: TLangName): string;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Radius, aLangName)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpCircle(%s, %s, %s)',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Radius, aLangName)])
  else
    Result := '';
end;

procedure TRICCircle.SaveToStream(aStream: TStream);
begin
  inherited;
  WriteWordToStream(aStream, CopyOptions);
  WriteImgPointToStream(aStream, Point);
  WriteWordToStream(aStream, Radius);
end;

{ TRICNumBox }

constructor TRICNumBox.Create(aOwner : TRICOps);
begin
  inherited Create(aOwner);
  fOpCode := IMG_NUMBOX_ID;
  fOpSize := SizeOf(IMG_OP_NUMBOX) - 2;
end;

{
procedure TRICNumBox.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
// draw numbox as specified
end;
}

procedure TRICNumBox.LoadFromStream(aStream: TStream);
var
  p : TImgPoint;
  v, co : Word;
begin
  inherited;
  co := 0;
  v  := 0;
  p.X := 0;
  p.Y := 0;
  ReadWordFromStream(aStream, co);
  ReadImgPointFromStream(aStream, p);
  ReadWordFromStream(aStream, v);
  CopyOptions := co;
  Point       := p;
  Value       := v;
end;

function TRICNumBox.SaveAsDataArray(const aLangName: TLangName): string;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Value, aLangName)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpNumBox(%s, %s, %s)',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Value, aLangName)])
  else
    Result := '';
end;

procedure TRICNumBox.SaveToStream(aStream: TStream);
begin
  inherited;
  WriteWordToStream(aStream, CopyOptions);
  WriteImgPointToStream(aStream, Point);
  WriteWordToStream(aStream, Value);
end;

{ TRICEllipse }

constructor TRICEllipse.Create(aOwner: TRICOps);
begin
  inherited Create(aOwner);
  fOpCode := IMG_ELLIPSE_ID;
  fOpSize := SizeOf(IMG_OP_ELLIPSE) - 2;
end;

{
procedure TRICEllipse.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
begin
// draw ellipse as specified
end;
}

procedure TRICEllipse.LoadFromStream(aStream: TStream);
var
  p : TImgPoint;
  r1, r2, co : Word;
begin
  inherited;
  co := 0;
  r1 := 0;
  r2 := 0;
  p.X := 0;
  p.Y := 0;
  ReadWordFromStream(aStream, co);
  ReadImgPointFromStream(aStream, p);
  ReadWordFromStream(aStream, r1);
  ReadWordFromStream(aStream, r2);
  CopyOptions := co;
  Point       := p;
  Radius1     := r1;
  Radius2     := r2;
end;

function TRICEllipse.SaveAsDataArray(const aLangName: TLangName): string;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s, %s, %s',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Radius1, aLangName),
       RICValueToStr(Radius2, aLangName)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpEllipse(%s, %s, %s, %s)',
      [RICValueToStr(CopyOptions, aLangName),
       RICPointToStr(Point, aLangName),
       RICValueToStr(Radius1, aLangName),
       RICValueToStr(Radius2, aLangName)])
  else
    Result := '';
end;

procedure TRICEllipse.SaveToStream(aStream: TStream);
begin
  inherited;
  WriteWordToStream(aStream, CopyOptions);
  WriteImgPointToStream(aStream, Point);
  WriteWordToStream(aStream, Radius1);
  WriteWordToStream(aStream, Radius2);
end;

{ TRICPolygon }

function TRICPolygon.Add: TPolyPoint;
begin
  Result := TPolyPoint.Create;
  fPolyPoints.Add(Result);
  inc(fOpSize, 4);
end;

procedure TRICPolygon.AddPoint(aPolyPoint: PIMG_PT);
var
  PP : TPolyPoint;
begin
  PP := TPolyPoint.Create;
  fPolyPoints.Add(PP);
  PP.X := aPolyPoint^.X;
  PP.Y := aPolyPoint^.Y;
  inc(fOpSize, 4);
end;

constructor TRICPolygon.Create(aOwner: TRICOps);
begin
  inherited Create(aOwner);
  fPolyPoints := TObjectList.Create;
  fOpCode := IMG_POLYGON_ID;
  fOpSize := SizeOf(IMG_OP_POLYGON) - 14; // remove 2 + 3*4
end;

destructor TRICPolygon.Destroy;
begin
  FreeAndNil(fPolyPoints);
  inherited;
end;

function TRICPolygon.GetCount: Word;
begin
  Result := Word(fPolyPoints.Count);
end;

function TRICPolygon.GetPolyPoint(Index: Integer): TPolyPoint;
begin
  Result := TPolyPoint(fPolyPoints[Index]);
end;

procedure TRICPolygon.LoadFromStream(aStream: TStream);
var
  co, mc, x, y : word;
  i : integer;
  PP : TPolyPoint;
begin
  inherited;
  co := 0;
  mc := 0;
  x  := 0;
  y  := 0;
  ReadWordFromStream(aStream, co);
  ReadWordFromStream(aStream, mc);
  CopyOptions := co;
  for i := 0 to mc - 1 do
  begin
    // read polygon points from stream
    ReadWordFromStream(aStream, x);
    ReadWordFromStream(aStream, y);
    PP := Add;
    PP.X := x;
    PP.Y := y;
  end;
end;

function TRICPolygon.SaveAsDataArray(const aLangName: TLangName): string;
  function OutputBytes(bIsNXCHeader : boolean) : string;
  var
    i, cnt : integer;
    PP : TPolyPoint;
  begin
    if bIsNXCHeader then
      Result := 'RICPolygonPoints('
    else
      Result := '';
    cnt := Count - 1;
    for i := 0 to cnt do
    begin
      PP := PolyPoints[i];
      if bIsNXCHeader then
        Result := Result + Format('RICImgPoint(%s, %s)',
          [RICValueToStr(PP.X, aLangName), RICValueToStr(PP.Y, aLangName)])
      else
        Result := Result + Format('%s, %s',
          [RICValueToStr(PP.X, lnNBC), RICValueToStr(PP.Y, lnNBC)]);
      if i < cnt then
      begin
        Result := Result + ', ';
        if bIsNXCHeader {and ((i mod 4) = 0) and (i > 0)} then
          Result := Result + #13#10'    ';
      end;
    end;
    if bIsNXCHeader then
      Result := Result + ')';
  end;
begin
  if aLangName in [lnNBC, lnNXC] then
  begin
    Result := inherited SaveAsDataArray(aLangName);
    Result := Result + Format(', %s, %s',
      [RICValueToStr(Count, aLangName),
       OutputBytes(false)]);
  end
  else if aLangName = lnNXCHeader then
    Result := Format('RICOpPolygon(%d,'#13#10'  %s)',
      [Count,
       OutputBytes(true)])
  else
    Result := '';
end;

procedure TRICPolygon.SaveToStream(aStream: TStream);
var
  i : integer;
  PP : TPolyPoint;
begin
  inherited;
  WriteWordToStream(aStream, CopyOptions);
  WriteWordToStream(aStream, Count);
  // now write out all the points in the PolyPoints array
  for i := 0 to Count - 1 do
  begin
    PP := PolyPoints[i];
    WriteWordToStream(aStream, PP.X);
    WriteWordToStream(aStream, PP.Y);
  end;
end;

procedure TRICPolygon.SetPolyPoint(Index: Integer; const Value: TPolyPoint);
begin
  TPolyPoint(fPolyPoints[Index]).X := Value.X;
  TPolyPoint(fPolyPoints[Index]).Y := Value.Y;
end;

{ TRICOps }

constructor TRICOps.Create;
begin
  inherited Create;
end;

destructor TRICOps.Destroy;
begin

  inherited;
end;

{
procedure TRICOps.Draw(aPoint: TImgPoint; Vars: TRICVariables;
  Options: Cardinal; aCanvas: TImgCanvas);
var
  i : integer;
begin
  for i := 0 to Count - 1 do
    TRICOpBase(Items[i]).Draw(aPoint, Vars, Options, aCanvas);
end;
}

(*
{$IFNDEF FPC}
initialization
  TPicture.RegisterFileFormat('BMP', 'Bitmap', TBitmap);

finalization
  TPicture.UnregisterGraphicClass(TBitmap);
{$ENDIF}
*)

end.
