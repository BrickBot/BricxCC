unit uJavaSupport;

interface

uses Classes;

type
  TOperationType = (otConstructor, otDestructor, otProcedure, otFunction);
  TVisibility = (viPrivate, viProtected, viPublic, viPublished);

  TNeedPackageEvent = procedure(const AName: string; var AStream: TStream; OnlyLookUp: Boolean = False) of object;

  TAbstractPackage = class;

  TDocumentation = class(TObject)
  private
    FDescription : string;
    procedure SetDescription(const Value: string);
  public
    function ShortDescription : string;
    property Description : string read FDescription write SetDescription;
  end;

  TLogicPackage = class;
  TUnitPackage = class;

  TObjectModel = class(TObject)
  private
    FModelRoot: TLogicPackage;
    FUnknownPackage: TUnitPackage;
    procedure CreatePackages;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    property ModelRoot: TLogicPackage read FModelRoot;
    property UnknownPackage: TUnitPackage read FUnknownPackage;
  end;

  TModelEntity = class(TObject)
  private
    fVisibility : TVisibility;
    FName: string;
    FDocumentation: TDocumentation;
    FLocked: boolean;
    FOwner: TModelEntity;
    function GetFullName: string;
    function GetRoot: TModelEntity;
  public
    constructor Create(Owner: TModelEntity); virtual;
    destructor Destroy; override;
    property Owner: TModelEntity read FOwner write FOwner;
    property Locked: boolean read FLocked write FLocked;
    property Root : TModelEntity read GetRoot;
    property Visibility: TVisibility read FVisibility write fVisibility;
    property Name: string read FName write fName;
    property FullName: string read GetFullName;
    property Documentation : TDocumentation read FDocumentation;
  end;

  TAbstractPackage = class(TModelEntity)
  end;

  TCodeParser = class(TObject)
  private
    FNeedPackage : TNeedPackageEvent;
  protected
    FModel: TAbstractPackage;
    function StreamToMemory(AStream: TStream): TMemoryStream;
  public
    // Parse the given stream into the AOM model with AModel as a 'dump' for unresolved objects.
    procedure ParseStream(AStream: TStream; AModel: TAbstractPackage; AOM: TObjectModel); virtual; abstract;
    property NeedPackage: TNeedPackageEvent read FNeedPackage write FNeedPackage;
  end;

  TFeature = class(TModelEntity);

  TModelEntityClass = class of TModelEntity;

  TIteratorOrder = (ioNone,ioVisibility,ioAlpha{,ioType});

  //Basinterface for iterators
  IModelIterator = interface
    function HasNext : boolean;
    function Next : TModelEntity;
    procedure Reset;
    function Count : integer;
  end;

  IIteratorFilter = interface
    function Accept(M : TModelEntity) : boolean;
  end;

  TIteratorFilter = class(TInterfacedObject, IIteratorFilter)
  public
    function Accept(M : TModelEntity) : boolean; virtual; abstract;
  end;

  //Filters on a class and a minimum visibilty
  TClassAndVisibilityFilter = class(TIteratorFilter)
  private
    OneClass : TModelEntityClass;
    MinVisibility : TVisibility;
  public
    constructor Create(OneClass : TModelEntityClass; MinVisibility : TVisibility = Low(TVisibility));
    function Accept(M : TModelEntity) : boolean; override;
  end;

  TModelIterator = class(TInterfacedObject, IModelIterator)
  private
    FItems : TList;
    OwnsItems : boolean;
    NextI : integer;
    FNext : TModelEntity;
    FHasNext : boolean;
  private
    procedure Init(List : IModelIterator; Filter : IIteratorFilter; Order : TIteratorOrder);
  protected
    procedure Advance; virtual;
  public
    constructor Create(List : IModelIterator; Filter : IIteratorFilter; Order : TIteratorOrder = ioNone); overload;
    constructor Create(ObList : TList; MakeCopy : boolean = False); overload;
    constructor Create(List : IModelIterator;
      OneClass : TModelEntityClass;
      MinVisibility : TVisibility = Low(TVisibility);
      Order : TIteratorOrder = ioNone); overload;
    constructor Create(List : IModelIterator; Order : TIteratorOrder = ioNone); overload;
    constructor Create(List : IModelIterator; MinVisibility : TVisibility); overload;
    destructor Destroy; override;
    //IModelIterator
    function HasNext : boolean;
    function Next : TModelEntity;
    procedure Reset;
    function Count : integer;
  end;

  TClassifier = class(TModelEntity)
  private
    FFeatures: TList;
    FIsPlaceholder: boolean;
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    property IsPlaceholder: boolean read FIsPlaceHolder write FIsPlaceholder;
    function GetFeatures : IModelIterator;
  end;

  TParameter = class(TModelEntity)
  private
    FTypeClassifier : TClassifier;
  public
    property TypeClassifier : TClassifier read FTypeClassifier write FTypeClassifier;
  end;

  TOperation = class(TFeature)
  private
    FParameters: TList;
    FIsAbstract: boolean;
    FReturnValue: TClassifier;
    FOperationType: TOperationType;
  published
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    function AddParameter(const NewName: string): TParameter;
    property OperationType: TOperationType read FOperationType write fOperationType;
    property IsAbstract: boolean read FIsAbstract write fIsAbstract;
    property ReturnValue: TClassifier read FReturnValue write fReturnValue;
    function GetParameters : IModelIterator;
  end;

  TAttribute = class(TFeature)
  private
    FTypeClassifier: TClassifier;
  public
    property TypeClassifier : TClassifier read FTypeClassifier write FTypeClassifier;
  end;

  TProperty = class(TAttribute)
  end;

  TDataType = class(TClassifier)
  end;

  TInterface = class(TClassifier)
  private
    FAncestor: TInterface;
    procedure SetAncestor(const Value: TInterface);
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    function AddOperation(const NewName: string): TOperation;
    function AddAttribute(const NewName: string): TAttribute;
    property Ancestor: TInterface read FAncestor write SetAncestor;
    function GetOperations : IModelIterator;
    function GetAttributes : IModelIterator;
    function GetImplementingClasses : IModelIterator;
  end;

  TInterfaceImplementsFilter = class(TIteratorFilter)
  private
    Int : TInterface;
  public
    constructor Create(I : TInterface);
    function Accept(M : TModelEntity) : boolean; override;
  end;

  TClass = class(TClassifier)
  private
    FAncestor: TClass;
    FImplements: TList;
    procedure SetAncestor(const Value: TClass);
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    function AddOperation(const NewName: string): TOperation;
    function AddAttribute(const NewName: string): TAttribute;
    function AddProperty(const NewName: string): TProperty;
    function AddImplements(I: TInterface): TInterface;
    property Ancestor: TClass read FAncestor write SetAncestor;
    function GetOperations : IModelIterator;
    function GetAttributes : IModelIterator;
    function GetImplements : IModelIterator;
    function FindOperation(O : TOperation) : TOperation;
  end;

  TUnitDependency = class(TModelEntity)
  public
    Package : TUnitPackage;
  end;

  TUnitPackage = class(TAbstractPackage)
  private
    FClassifiers: TList;
    FUnitDependencies: TList;
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    function AddClass(const NewName: string): TClass;
    function AddInterface(const NewName: string): TInterface;
    function AddDatatype(const NewName: string): TDataType;
    function AddUnitDependency(U : TUnitPackage; Visibility : TVisibility): TUnitDependency;
    function FindClassifier(const CName: string; RaiseException: boolean = False; TheClass : TModelEntityClass = nil; CaseSense : boolean = False): TClassifier;
    function GetClassifiers : IModelIterator;
    function GetUnitDependencies : IModelIterator;
  end;


  TLogicPackage = class(TAbstractPackage)
  private
    FPackages: TList;
  public
    constructor Create(Owner: TModelEntity); override;
    destructor Destroy; override;
    function AddUnit(const NewUnitName: string): TUnitPackage;
    //Might need a AddLogicPackage also
    function FindUnitPackage(const PName: string; RaiseException: boolean = False; CaseSense : boolean = False): TUnitPackage;
    function GetPackages : IModelIterator;
    function GetAllUnitPackages : IModelIterator;
    function GetAllClassifiers : IModelIterator;
  end;

  TJavaParser = class(TCodeParser)
  private
    FStream: TMemoryStream;
    FCurrPos: PChar;
    Token: string;
    FOM: TObjectModel;
    FUnit: TUnitPackage;
    Comment: string; // Accumulated comment string used for documentation of entities.
    ModAbstract : boolean;
    ModVisibility: TVisibility;
    ClassImports,FullImports : TStringList;
    NameCache : TStringList;

    function SkipToken(const what: string): Boolean;
    function SkipPair(const open, close: string): Boolean;
    function GetChar: char;

    procedure EatWhiteSpace;
    function GetNextToken: string;

    procedure ParseCompilationUnit;
    procedure ParseTypeDeclaration;
    procedure ParseModifiersOpt;
    procedure ParseClassDeclaration(IsInner : boolean = False; const ParentName : string = '');
    procedure ParseInterfaceDeclaration;

    procedure DoOperation(O: TOperation; const ParentName, TypeName: string);
    procedure DoAttribute(A: TAttribute; const TypeName: string);
    function GetTypeName : string;

    procedure SetVisibility(M: TModelEntity);
    function NeedClassifier(const CName: string; Force : boolean = True; TheClass: TModelEntityClass = nil): TClassifier;
    function NeedSource(const SourceName : string) : boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure ParseStream(AStream: TStream; AModel: TAbstractPackage; AOM: TObjectModel); override;
  end;

  TJavaClassParser = class(TCodeParser)
  private
    OM : TObjectModel;
    function GetVisibility(flags : integer) : TVisibility;
    function ExtractPackageName(CName : string) : string;
    function ExtractClassName(CName : string) : string;
    function GetFieldType(const Field : string; var Index : integer) : TClassifier;
    function NeedClassifier(CName :  string; TheClass : TModelEntityClass = nil) : TClassifier;
  public
    procedure ParseStream(AStream: TStream; AModel: TAbstractPackage; AOM: TObjectModel); override;
  end;

type
  TConstBase = class
  private
    tag : integer;
  public
    procedure Read(Input : TStream); virtual; abstract;
    procedure set_ref(const objAry : array of TConstBase); virtual;
    function getString : string; virtual;
  end;

  TConstPool = class
  private
    constPoolCnt : integer;
    constPool : array of TConstBase;
  public
    constructor Create(Input : TStream);
    destructor Destroy; override;
    function ConstPoolElem(ix : integer) : TConstBase;
  private
    function allocConstEntry(tag  : integer) : TConstBase;
    procedure resolveConstPool;
    procedure readConstPool(Input : TStream);
  end;

  TConstUtf8 = class(TConstBase)
  private
    str : string;
  public
    procedure Read(Input : TStream); override;
    function GetString : string; override;
  end;

  TConstClass_or_String = class(TConstBase)
  private
    index : integer;
    Utf8 : TConstUtf8;
  public
    procedure Read(Input : TStream); override;
    procedure set_ref(const objAry : array of TConstBase); override;
    function GetString : string; override;
  end;

  TConstLongConvert = class(TConstBase)
  private
    function toLong(h,l : integer) : int64;
  protected
    function readLong(Input : TStream) : int64;
  end;

  TConstDouble = class(TConstLongConvert)
  private
    d : double;
  public
    procedure Read(Input : TStream); override;
  end;

  TConstFloat = class(TConstBase)
  private
    f : single;
  public
    procedure Read(Input : TStream); override;
  end;

  TConstInt = class(TConstBase)
  private
    val : integer;
  public
    procedure Read(Input : TStream); override;
  end;

  TConstLong = class(TConstLongConvert)
  private
    longVal : int64;
  public
    procedure Read(Input : TStream); override;
  end;

  TConstName_and_Type_info = class(TConstClass_or_String)
  private
    descriptor_index : integer;
    descriptor_Utf8 : TConstUtf8;
  public
    procedure Read(Input : TStream); override;
    procedure set_ref(const objAry : array of TConstBase); override;
  end;

  TConstRef = class(TConstBase)
  private
    index,name_and_type_index : integer;
    class_ref : TConstClass_or_String;
    name_ref : TConstName_and_Type_info;
  public
    procedure Read(Input : TStream); override;
    procedure set_ref(const objAry : array of TConstBase); override;
  end;

  TAccData = class
  public
    class function isPublic(Val : integer) : boolean;
    class function isPrivate(Val : integer) : boolean;
    class function isProtected(Val : integer) : boolean;
    class function isStatic(Val : integer) : boolean;
    class function isFinal(Val : integer) : boolean;
    class function isSync(Val : integer) : boolean;
    class function isSuper(Val : integer) : boolean;
    class function isVolatile(Val : integer) : boolean;
    class function isTransient(Val : integer) : boolean;
    class function isNative(Val : integer) : boolean;
    class function isInterface(Val : integer) : boolean;
    class function isAbstract(Val : integer) : boolean;
    class function isStrict(Val : integer) : boolean;
  end;

  TObjNameFormat = class
  public
    class function ToDotSeparator(SlashName : string) : string;
  end;

  TAttrInfo = class
  private
    AttrName : string;
    Len : integer;
  public
    constructor Create(Name : string; Length  : integer);
    function GetName : string;
  end;

  TAttrFactory = class
  private
    class procedure Skip_data(len : integer; Input : TStream);
  public
    class function AllocAttr(Input : TStream; constPoolSec : TConstPool) : TAttrInfo;
  end;

  TClassFileHeader = class
  private
    magic : longword;
    minor_version : shortint;
    major_version : shortint;
  public
    constructor Create(Input : TStream);
  end;

  TClassDeclSec = class
  public
    accessFlags : integer;
    thisClass : TConstBase;
    superClass : TConstBase;
    interfaces : array of TConstBase;
  public
    constructor Create(Input : TStream; ConstPoolSec : TConstPool);
    function GetClassName : string;
  end;

  TFieldInfo = class
  public
    access_flags : integer;
    name : TConstUtf8;
    descriptor : TConstUtf8 ;
    attributes : array of TAttrInfo;
  public
    constructor Create(Input : TStream; constPoolSec : TConstPool);
  end;

  TClassFieldSec = class
  public
    classFields : array of TFieldInfo;
  public
    constructor Create(Input : TStream; constPoolSec : TConstPool);
  end;

  TMethodInfo = class
  public
    access_flags : integer;
    name : TConstUtf8 ;
    descriptor : TConstUtf8 ;
    attributes : array of TAttrInfo;
  public
    constructor Create(Input : TStream; constPoolSec : TConstPool);
    function isConstructor : boolean;
  end;

  TClassMethodSec = class
  public
    classMethods : array of TMethodInfo;
  public
    constructor Create(Input : TStream; constPoolSec : TConstPool; className : string);
    destructor Destroy; override;
  end;

  TClassAttrSec = class
  private
    classAttrTab : array of TAttrInfo;
  public
    constructor Create(Input : TStream; constPoolSec : TConstPool);
  end;

  TClassFile = class
  public
    header : TClassFileHeader;
    classConstPool : TConstPool;
    classDecl : TClassDeclSec;
    classFields : TClassFieldSec;
    classMethods : TClassMethodSec;
    classAttrs : TClassAttrSec;
    className : string;
  public
    constructor Create(Input : TStream);
    destructor Destroy; override;
  end;

const
  UNKNOWNPACKAGE_NAME = '<<Unknown>>';

implementation

uses SysUtils;


const
  ACC_PUBLIC    : word = $0001;
  ACC_PRIVATE   : word = $0002;
  ACC_PROTECTED : word = $0004;
  ACC_STATIC    : word = $0008;
  ACC_FINAL     : word = $0010;
  ACC_SYNC      : word = $0020;
  ACC_VOLATILE  : word = $0040;
  ACC_TRANSIENT : word = $0080;
  ACC_NATIVE    : word = $0100;
  ACC_INTERFACE : word = $0200;
  ACC_ABSTRACT  : word = $0400;
  ACC_STRICT    : word = $0800;

  CONSTANT_Class = 7;
  CONSTANT_Fieldref = 9;
  CONSTANT_Methodref = 10;
  CONSTANT_InterfaceMethodref = 11;
  CONSTANT_String = 8;
  CONSTANT_Integer = 3;
  CONSTANT_Float = 4;
  CONSTANT_Long = 5;
  CONSTANT_Double = 6;
  CONSTANT_NameAndType = 12;
  CONSTANT_Utf8 = 1;


function ReadU1(Input: TStream): integer;
var
  ByteVal : byte;
begin
  Input.Read(ByteVal,1);
  Result := ByteVal;
end;

function ReadU2(Input: TStream): integer;
var
  tmp : array[0..1] of byte;
begin
  Input.Read(tmp,2);
  Result := (tmp[0] shl 8) or tmp[1];
end;

function ReadU4(Input: TStream): longword;
var
  tmp : array[0..3] of byte;
begin
  //$BEBAFECA
  Input.Read(tmp,4);
  Result := (tmp[0] shl 24) or (tmp[1] shl 16) or (tmp[2] shl 8) or tmp[3];
end;

procedure Clear(aList : TList);
var
  O : TObject;
begin
  while aList.Count > 0 do
  begin
    O := TObject(aList[0]);
    FreeAndNil(O);
    aList.Delete(0);
  end;
end;

{ TClassFileHeader }

constructor TClassFileHeader.Create(Input: TStream);
begin
  magic := readU4( Input );
  Assert(Magic=$CAFEBABE);
  minor_version := readU2( Input );
  major_version := readU2( Input );
end;

{ TClassDeclSec }

constructor TClassDeclSec.Create(Input: TStream; ConstPoolSec: TConstPool);
var
  thisClassIx, superClassIx, interfaceCnt, ix, i : integer;
begin
  accessFlags := readU2( Input );
  thisClassIx := readU2( Input );
  superClassIx := readU2( Input );

  thisClass := constPoolSec.constPoolElem( thisClassIx );
  superClass := constPoolSec.constPoolElem( superClassIx );

  interfaceCnt := readU2( Input );

  if (interfaceCnt > 0) then
  begin
    SetLength(interfaces,interfaceCnt);
    for I := 0 to interfaceCnt-1 do
    begin
      ix := readU2( Input );
      interfaces[ i ] := constPoolSec.constPoolElem( ix );
    end;
  end;
end;

function TClassDeclSec.GetClassName: string;
var
  name : string;
begin
  if Assigned(thisClass) then
    if (thisClass is TConstClass_or_String) then
      name := TObjNameFormat.toDotSeparator( thisClass.getString );
  Result := Name;
end;

{ TFieldInfo }

constructor TFieldInfo.Create(Input: TStream; constPoolSec: TConstPool);
var
  name_index,desc_index,attr_cnt,I : integer;
  obj : TConstBase;
begin
  access_flags := readU2( Input );
  name_index   := readU2( Input );
  desc_index   := readU2( Input );
  attr_cnt     := readU2( Input );

  obj := constPoolSec.constPoolElem( name_index );
  if Assigned(obj) and (obj is TConstUtf8) then
    Name := obj as TConstUtf8;

  obj := constPoolSec.constPoolElem( desc_index );
  if Assigned(obj) and (obj is TConstUtf8) then
    descriptor := obj as TConstUtf8;

  if (attr_cnt > 0) then
  begin
    SetLength(attributes,attr_cnt);
    for I := 0 to attr_cnt-1 do
      attributes[i] := TAttrFactory.allocAttr( Input, constPoolSec );
  end;
end;

{ TClassFieldSec }

constructor TClassFieldSec.Create(Input: TStream; constPoolSec: TConstPool);
var
  field_cnt,i : integer;
begin
  field_cnt := readU2( Input );
  if (field_cnt > 0) then
    SetLength(classFields,field_cnt);

  for I := 0 to field_cnt-1 do
    classFields[i] := TFieldInfo.Create( Input, constPoolSec );
end;

{ TMethodInfo }

constructor TMethodInfo.Create(Input: TStream; constPoolSec: TConstPool);
var
  name_index,desc_index,attr_cnt,I : integer;
  obj : TConstBase;
begin
  access_flags := readU2( Input );
  name_index   := readU2( Input );
  desc_index   := readU2( Input );
  attr_cnt     := readU2( Input );

  obj := constPoolSec.constPoolElem( name_index );
  if Assigned(obj) and  (obj is TConstUtf8) then
    name := obj as TConstUtf8;

  obj := constPoolSec.constPoolElem( desc_index );
  if Assigned(obj) and  (obj is TConstUtf8) then
    descriptor := obj as TConstUtf8;

  if (attr_cnt > 0) then
  begin
    SetLength(attributes,attr_cnt);
    for I := 0 to attr_cnt-1 do
      attributes[i] := TAttrFactory.allocAttr( Input, constPoolSec );
  end;
end;

function TMethodInfo.isConstructor: boolean;
begin
  Result := (name.getString()='<init>');
end;


{ TClassMethodSec }

constructor TClassMethodSec.Create(Input: TStream; constPoolSec: TConstPool; className: string);
var
  methodCnt,I : integer;
begin
  methodCnt := readU2(Input);
  if (methodCnt > 0) then
    SetLength(classMethods,methodCnt);
  for I := 0 to methodCnt-1 do
    classMethods[i] := TMethodInfo.Create( Input, constPoolSec );
end;

destructor TClassMethodSec.Destroy;
var
  I : integer;
begin
  for I := 0 to High(classMethods) do
    if Assigned(ClassMethods[I]) then FreeAndNil(ClassMethods[I]);
  inherited;
end;

{ TClassAttrSec }

constructor TClassAttrSec.Create(Input: TStream; constPoolSec: TConstPool);
var
  numAttr,I : integer;
begin
  numAttr := readU2( Input );
  if (numAttr > 0) then
  begin
    SetLength(classAttrTab,numAttr);
    for I := 0 to numAttr-1 do
      classAttrTab[i] := TAttrFactory.allocAttr( Input, constPoolSec );
  end;
end;

{ TClassFile }

constructor TClassFile.Create(Input: TStream);
begin
  try
    header := TClassFileHeader.Create( Input );
    classConstPool := TConstPool.Create( Input );
    classDecl := TClassDeclSec.Create( Input, classConstPool );
    classFields := TClassFieldSec.Create(Input, classConstPool);
    className := classDecl.getClassName;
    classMethods := TClassMethodSec.Create(Input, classConstPool, className );
    classAttrs := TClassAttrSec.Create(Input, classConstPool);
  finally
    FreeAndNil(Input);
  end;
end;


destructor TClassFile.Destroy;
begin
  if Assigned(Header) then FreeAndNil(header);
  if Assigned(classConstPool) then FreeAndNil(classConstPool);
  if Assigned(classDecl) then FreeAndNil(classDecl);
  if Assigned(classFields) then FreeAndNil(classFields);
  if Assigned(classMethods) then FreeAndNil(classMethods);
  if Assigned(classAttrs) then FreeAndNil(classAttrs);
  inherited;
end;

{ TAttrInfo }

constructor TAttrInfo.Create(Name: string; Length: integer);
begin
  attrName := Name;
  len := length;
end;

function TAttrInfo.GetName: string;
begin
  Result := attrName;
end;

{ TAttrFactory }

class function TAttrFactory.allocAttr(Input: TStream; constPoolSec: TConstPool): TAttrInfo;
var
  length : integer;
  retObj : TAttrInfo;
begin
  retObj := nil;

  ReadU2(Input);
  length := ReadU4(Input);

  //Skip all attributes
  skip_data(length,Input);

  Result := retObj;
end;

class procedure TAttrFactory.skip_data(len: integer; Input: TStream);
begin
  if (Input.Position>=Input.Size) and (Len<>0) then
    raise Exception.Create('Unexpected end of file');
  Input.Position := Input.Position + Len;
end;



{ TConstBase }


function TConstBase.getString: string;
begin
  Result := '**noname';
end;

procedure TConstBase.set_ref(const objAry: array of TConstBase);
begin
  //nothing
end;

{ TConstPool }


function TConstPool.allocConstEntry(tag: integer): TConstBase;
begin
  Result := nil;
  case Tag of
    CONSTANT_Utf8:
      Result := TConstUtf8.Create;
    CONSTANT_Integer:
      Result := TConstInt.Create;
    CONSTANT_Float:
      Result := TConstFloat.Create;
    CONSTANT_Long:
      Result := TConstLong.Create;
    CONSTANT_Double:
      Result := TConstDouble.Create;
    CONSTANT_Class,
    CONSTANT_String:
      Result := TConstClass_or_String.Create;
    CONSTANT_Fieldref,
    CONSTANT_Methodref,
    CONSTANT_InterfaceMethodref:
      Result := TConstRef.Create;
    CONSTANT_NameAndType:
      Result := TConstName_and_Type_info.Create;
  else
//    ErrorHandler.Trace('allocConstEntry: bad tag value = ' + IntToStr(tag));
  end;

  if Assigned(Result) then
    Result.Tag := Tag;
end;

function TConstPool.ConstPoolElem(ix: integer): TConstBase;
begin
  Result := nil;
  if (ix>0) and (ix<Length(constPool)) then
    Result := constPool[ix];
end;

constructor TConstPool.Create(Input: TStream);
begin
  constPoolCnt := readU2(Input);

  SetLength(constPool,constPoolCnt);

  readConstPool(Input);
  resolveConstPool;
end;

destructor TConstPool.Destroy;
var
  I : integer;
begin
  for I:=0 to High(ConstPool) do
    if Assigned(ConstPool[I]) then FreeAndNil(ConstPool[I]);
  inherited;
end;

procedure TConstPool.readConstPool(Input: TStream);
var
  i,tag : integer;
  constObj : TConstBase;
begin
  I := 1;
  while I<constPoolCnt do
  begin
    Tag := ReadU1(Input);
    if (Tag > 0) then
    begin
      constObj := allocConstEntry( tag );
      constObj.read( Input );
      constPool[i] := constObj;
      if (constObj is TConstLong) or (constObj is TConstDouble) then
      begin
        Inc(I);
        constPool[i] := nil;
      end;
    end
    else
      ; //ErrorHandler.Trace('tag == 0');
    Inc(I);
  end;
end;

procedure TConstPool.resolveConstPool;
var
  I : integer;
begin
  //Index 0 is not used
  for I:=1 to constPoolCnt-1 do
    if Assigned(constPool[I]) then
      constPool[I].set_ref(constPool);
end;


{ TConstClass_or_String }

function TConstClass_or_String.GetString: string;
begin
  Result := Utf8.GetString;
end;

procedure TConstClass_or_String.Read(Input: TStream);
begin
  index := readU2( Input );
end;

procedure TConstClass_or_String.set_ref(const objAry: array of TConstBase);
var
  tmp : TConstBase;
begin
  tmp := objAry[ index ];
  if (tmp is TConstUtf8) then
    Utf8 := tmp as TConstUtf8
  else
    ;//ErrorHandler.Trace('not utf8');
end;


{ TConstLongConvert }

function TConstLongConvert.readLong(Input: TStream): int64;
var
  h,l : integer;
begin
  h := readU4(Input);
  l := readU4(Input);
  Result := toLong(h,l);
end;

function TConstLongConvert.toLong(h, l: integer): int64;
begin
  Result := (h shl 32) or l;
end;

{ TConstDouble }

procedure TConstDouble.Read(Input: TStream);
var
  I : int64;
begin
  //Is this cast ok?
  I := ReadLong(Input);
  Move(I,D,SizeOf(D));
end;

{ TConstFloat }

procedure TConstFloat.Read(Input: TStream);
var
  L : longword;
begin
  L := ReadU4(Input);
  //Is this cast ok?
  Move(L,F,SizeOf(F));
end;

{ TConstInt }

procedure TConstInt.Read(Input: TStream);
var
  L : longword;
begin
  L := ReadU4(Input);
  Val := L;
end;

{ TConstLong }

procedure TConstLong.Read(Input: TStream);
begin
  longVal := ReadLong(Input);
end;

{ TConstName_and_Type_info }

procedure TConstName_and_Type_info.Read(Input: TStream);
begin
  inherited read(Input);
  descriptor_index := readU2(Input);
end;

procedure TConstName_and_Type_info.set_ref(const objAry: array of TConstBase);
var
  tmp : TConstBase;
begin
  inherited set_ref( objAry );
  Tmp := objAry[ descriptor_index ];
  if (tmp is TConstUtf8) then
    descriptor_Utf8 := tmp as TConstUtf8
  else
    ; //ErrorHandler.Trace('utf8');
end;

{ TConstRef }

procedure TConstRef.Read(Input: TStream);
begin
  index := readU2( Input );
  name_and_type_index := readU2( Input );
end;

procedure TConstRef.set_ref(const objAry: array of TConstBase);
var
  tmp : TConstBase;
begin
  Tmp := objAry[ index ];
  if (tmp is TConstClass_or_String) then
    class_ref := tmp as TconstClass_or_String
  else
    ; //ErrorHandler.Trace('nix');

  Tmp := objAry[ name_and_type_index ];
  if (tmp is TConstName_and_Type_info) then
    name_ref := tmp as TConstName_and_Type_info
  else
    ;//ErrorHandler.Trace('nix');
end;

{ TConstUtf8 }


procedure TConstUtf8.Read(Input: TStream);
var
  one_char : word;
  len, charCnt : integer;
  one_byte,first_byte : byte;
  tmp : word;
begin
  len := readU2( Input );

  charCnt := 0;
  while (charCnt < len) do
  begin
    one_byte := readU1( Input );
    Inc(charCnt);
    if ((one_byte shr 7) = 1) then
    begin
      tmp := (one_byte and $3f);  // Bits 5..0 (six bits)
      first_byte := one_byte;
      one_byte := readU1( Input );
      Inc(charCnt);
      tmp := (tmp or ((one_byte and $3f) shl 6));
      if ((first_byte shr 4) = 2+4+8) then
      begin
        one_byte := readU1( Input );
        Inc(charCnt);
        one_byte := (one_byte and $0F);
        tmp := (tmp or (one_byte shl 12));
      end;
      one_char := tmp;
    end
    else
      one_char := one_byte;
    Str := Str + char(Lo(One_Char));
  end;
end;

function TConstUtf8.GetString: string;
begin
  Result := str;
end;

{ TAccData }

class function TAccData.isAbstract(Val: integer): boolean;
begin
  Result := (Val and ACC_ABSTRACT) <> 0;
end;

class function TAccData.isFinal(Val: integer): boolean;
begin
  Result := (Val and ACC_FINAL) <> 0;
end;

class function TAccData.isInterface(Val: integer): boolean;
begin
  Result := (Val and ACC_INTERFACE) <> 0;
end;

class function TAccData.isNative(Val: integer): boolean;
begin
  Result := (Val and ACC_NATIVE) <> 0;
end;

class function TAccData.isPrivate(Val: integer): boolean;
begin
  Result := (Val and ACC_PRIVATE) <> 0;
end;

class function TAccData.isProtected(Val: integer): boolean;
begin
  Result := (Val and ACC_PROTECTED) <> 0;
end;

class function TAccData.isPublic(Val: integer): boolean;
begin
  Result := (Val and ACC_PUBLIC) <> 0;
end;

class function TAccData.isStatic(Val: integer): boolean;
begin
  Result := (Val and ACC_STATIC) <> 0;
end;

class function TAccData.isStrict(Val: integer): boolean;
begin
  Result := (Val and ACC_STRICT) <> 0;
end;

class function TAccData.isSuper(Val: integer): boolean;
begin
  Result := (Val and ACC_SYNC) <> 0;  //sync and super share the same bit-flag
end;

class function TAccData.isSync(Val: integer): boolean;
begin
  Result := (Val and ACC_SYNC) <> 0;
end;

class function TAccData.isTransient(Val: integer): boolean;
begin
  Result := (Val and ACC_TRANSIENT) <> 0;
end;

class function TAccData.isVolatile(Val: integer): boolean;
begin
  Result := (Val and ACC_VOLATILE) <> 0;
end;


{ TObjNameFormat }


class function TObjNameFormat.toDotSeparator(slashName: string): string;
var
  I : integer;
  Ch : char;
begin
  Result := '';
  for I:=1 to Length(SlashName) do
  begin
    ch := SlashName[I];
    if ch='/' then
      Result := Result + '.'
    else if ch<>';' then
      Result := Result + ch;
  end;
end;

{ TJavaClassParser }

procedure TJavaClassParser.ParseStream(AStream: TStream; AModel: TAbstractPackage; AOM: TObjectModel);
var
  JC : TClassFile;
  U : TUnitPackage;
  C : TClass;
  Int : TInterface;
  I : integer;
  PName,S : string;

  procedure ParseOp(Op : TOperation; Met : TMethodInfo);
  var
    Desc : string;
    I,J : integer;
  begin
    Op.Visibility := GetVisibility(Met.access_flags);
    Op.IsAbstract := TAccData.isAbstract(Met.access_flags);
    Desc := Met.descriptor.GetString;
    I := 1;
    if Desc[I]='(' then
    begin
      //parameters
      J := 0;
      Inc(I);
      while (Desc[I]<>')') and (I<Length(Desc)) do
        Op.AddParameter( char( Ord('a') + J ) ).TypeClassifier := GetFieldType(Desc,I);
      Inc(I);
    end;
    if Desc[I]<>'V' then
      Op.ReturnValue := GetFieldType(Desc,I);
    if Met.isConstructor then
    begin
      Op.OperationType := otConstructor;
      Op.Name := C.Name;
    end else if Assigned(Op.ReturnValue) then
      Op.OperationType := otFunction
    else
      Op.OperationType := otProcedure
  end;

  procedure ParseAttr(Attr : TAttribute; Fi : TFieldInfo);
  var
    I : integer;
  begin
    Attr.Visibility := GetVisibility(Fi.access_flags);
    I := 1;
    Attr.TypeClassifier := GetFieldType(Fi.descriptor.getString,I);
  end;

begin
  FModel := AModel;
  OM := AOM;

  JC := TClassFile.Create(AStream);
  try
    PName := ExtractPackageName( JC.ClassName );
    U := OM.ModelRoot.FindUnitPackage(PName);
    if not Assigned(U) then
      U := (FModel as TLogicPackage).AddUnit( PName );
    if TAccData.isInterface( JC.classDecl.accessFlags ) then
    begin
      //interface
      Int := U.AddInterface( ExtractClassName(JC.ClassName) );
      Int.Visibility := GetVisibility( JC.classDecl.accessFlags );

      for I:=0 to Length(JC.classFields.classFields)-1 do
      begin
        S := JC.classFields.classFields[I].name.GetString;
        if (Length(S)>0) and (S[1]<>'$') then
          ParseAttr( Int.AddAttribute( S ),JC.classFields.classFields[I] );
      end;

      for I:=0 to Length(JC.classMethods.classMethods)-1 do
      begin
        S := JC.classMethods.classMethods[I].name.GetString;
        if (Length(S)>0) and (not (S[1] in ['<','$'])) then
          ParseOp( Int.AddOperation( S ) ,JC.classMethods.classMethods[I]);
      end;

    end
    else
    begin
      //class
      C := U.AddClass( ExtractClassName(JC.ClassName) );
      //ancestor
      if Assigned(JC.classDecl.superClass) then
      begin
        S := TObjNameFormat.ToDotSeparator(JC.classDecl.superClass.getString);
        if S<>'java.lang.Object' then
          C.Ancestor := NeedClassifier( S , TClass) as TClass;
      end;
      //implements
      for I := 0 to Length(JC.classDecl.interfaces)-1 do
        C.AddImplements( NeedClassifier( TObjNameFormat.toDotSeparator(JC.classDecl.interfaces[I].getString), TInterface ) as TInterface);
      C.Visibility := GetVisibility( JC.classDecl.accessFlags );
      for I:=0 to Length(JC.classFields.classFields)-1 do
      begin
        S := JC.classFields.classFields[I].name.GetString;
        if (Length(S)>0) and (S[1]<>'$') then
          ParseAttr( C.AddAttribute( S ),JC.classFields.classFields[I] );
      end;
      for I:=0 to Length(JC.classMethods.classMethods)-1 do
      begin
        S := JC.classMethods.classMethods[I].name.GetString;
        if S='<init>' then  //Constructor has internal name '<init>'
          S := C.Name;
        if (Length(S)>0) and (not (S[1] in ['<','$'])) then
          ParseOp( C.AddOperation( S ) ,JC.classMethods.classMethods[I]);
      end;
    end;

  finally
    FreeAndNil(JC);
  end;
end;

//Translate java-visibility
function TJavaClassParser.GetVisibility(flags: integer): TVisibility;
begin
  Result := viPrivate;
  if TAccData.isPublic( flags ) then
    Result := viPublic
  else if TAccData.isPrivate( flags ) then
    Result := viPrivate
  else if TAccData.isProtected( flags ) then
    Result := viProtected;
end;

function TJavaClassParser.ExtractPackageName(CName: string): string;
var
  I : integer;
begin
  I := LastDelimiter('.',CName);
  if I=0 then
    Result := 'Default'
  else
    Result := Copy(CName,1,I-1);
end;

//Extract short class name
function TJavaClassParser.ExtractClassName(CName: string): string;
var
  I : integer;
begin
  I := LastDelimiter('.',CName);
  if I=0 then
    Result := CName
  else
    Result := Copy(CName,I+1,255);
end;


function TJavaClassParser.NeedClassifier(CName: string; TheClass : TModelEntityClass = nil): TClassifier;
var
  PName,ShortName : string;
  U : TUnitPackage;
  Parser : TJavaClassParser;
  Str : TStream;
begin
  Result := nil;
  PName := ExtractPackageName(CName);
  ShortName := ExtractClassName(CName);

  //First look in model
  U := OM.ModelRoot.FindUnitPackage(PName);
  if Assigned(U) then
    Result := U.FindClassifier(ShortName,False,TheClass,True);

  if not Assigned(Result) then
  begin
    //See if we can find the file that we need
    Str := nil;
    if Assigned(NeedPackage) then
      NeedPackage( ShortName ,str);
    if Assigned(Str) then
    begin
      Parser := TJavaClassParser.Create;
      try
        Parser.NeedPackage := NeedPackage;
        Parser.ParseStream(Str, OM.ModelRoot, OM);
      finally
        FreeAndNil(Parser);
      end;
      U := OM.ModelRoot.FindUnitPackage(PName);
      if Assigned(U) then
        Result := U.FindClassifier(ShortName,False,TheClass,True);
    end;
  end;

  if not Assigned(Result) then
  begin
    //Look in unknown package
    Result := OM.UnknownPackage.FindClassifier(CName,False,TheClass,True);
    if not Assigned(Result) then
    begin
      if (TheClass=nil) or (TheClass=TClass) then
        Result := OM.UnknownPackage.AddClass(CName)
      else if TheClass=TInterface then
        Result := OM.UnknownPackage.AddInterface(CName)
      else if TheClass=TDataType then
        Result := OM.UnknownPackage.AddDataType(CName)
    end;
  end;

  if not Assigned(Result) then
    raise Exception.Create(ClassName + ' failed to locate ' + Cname);
end;

function TJavaClassParser.GetFieldType(const Field: string; var Index: integer): TClassifier;
var
  DimCount,I : integer;
  S : string;
  IsPrimitive : boolean;
begin
  Result := nil;
  DimCount := 0;
  while Field[Index]='[' do
  begin
    Inc(DimCount);
    Inc(Index);
  end;
  IsPrimitive := True;
  case Field[Index] of
    'B' : S := 'byte';
    'C' : S := 'char';
    'D' : S := 'double';
    'F' : S := 'float';
    'I' : S := 'int';
    'J' : S := 'long';
    'L' :
      begin
        Inc(Index);
        I := Index;
        while (Field[I]<>';') and (I<Length(Field)) do
          Inc(I);
        S := TObjNameFormat.toDotSeparator( Copy(Field,Index,I-Index) );
        Index := I;
        IsPrimitive := False;
      end;
    'S' : S := 'short';
    'Z' : S := 'boolean';
  end;
  Inc(Index);
  for I := 0 to DimCount-1 do
    S := S + '[]';

  if S='' then
//    ErrorHandler.Trace(ClassName + ' getfieldtype: ' + Field)
  else
  begin
    if IsPrimitive then
      Result := NeedClassifier( S , TDataType)
    else
      Result := NeedClassifier( S );
  end;
end;

function ExtractPackageName(const CName: string): string;
var
  I : integer;
begin
  I := LastDelimiter('.',CName);
  if I=0 then
    Result := ''
  else
    Result := Copy(CName,1,I-1);
end;

function ExtractClassName(const CName: string): string;
var
  I : integer;
begin
  I := LastDelimiter('.',CName);
  if I=0 then
    Result := CName
  else
    Result := Copy(CName,I+1,255);
end;

{ TJavaParser }

constructor TJavaParser.Create;
begin
  inherited;
  ClassImports := TStringList.Create;
  FullImports := TStringList.Create;
  NameCache := TStringList.Create;
  NameCache.Sorted := True;
  NameCache.Duplicates := dupIgnore;
end;

destructor TJavaParser.Destroy;
begin
  if Assigned(FStream) then FreeAndNil(FStream);
  FreeAndNil(ClassImports);
  FreeAndNil(FullImports);
  FreeAndNil(NameCache);
  inherited;
end;

function TJavaParser.SkipToken(const what: string): Boolean;
begin
  Result := False;
  GetNextToken;
  if Token = what then
  begin
    GetNextToken;
    Result := True;
  end;
end;

function TJavaParser.SkipPair(const open, close: string): Boolean;

  procedure InternalSkipPair(const open, close: string);
  begin
    while (Token <> close) and (Token<>'') do
    begin
      GetNextToken;
      while Token = open do
        InternalSkipPair(open, close);
    end;
    GetNextToken;
  end;

begin
  Result := False;
  InternalSkipPair(open, close);
  if Token <> '' then Result := True;
end;


procedure TJavaParser.EatWhiteSpace;
var
  inComment, continueLastComment, State: Boolean;

  procedure EatOne;
  begin
    if inComment then
      Comment := Comment + GetChar
    else
      GetChar;
  end;

  function EatWhite: Boolean;
  begin
    Result := False;
    while not (FCurrPos^ in [#0, #33..#255]) do
    begin
      Result := True;
      EatOne;
    end;
  end;

  function EatStarComment: Boolean;
  begin
    Result := True;
    while (not ((FCurrPos^ = '*') and ((FCurrPos + 1)^ = '/'))) or (FCurrPos^=#0) do
    begin
      Result := True;
      EatOne;
    end;
    continueLastComment := False;
    inComment := False;
    EatOne; EatOne;
  end;

  function EatSlashComment: Boolean;
  begin
    Result := True;
    while (FCurrPos^ <> #13) and (FCurrPos^ <> #10) and (FCurrPos^ <> #0) do
    begin
      Result := True;
      EatOne;
    end;
    continueLastComment := True;
    inComment := False;
    while FCurrPos^ in [#13,#10] do
      EatOne;
  end;

begin
  inComment := False;
  continueLastComment := False;
  State := True;
  while State do
  begin
    State := False;
    if (FCurrPos^ = #10) or ((FCurrPos^ = #13) and ((FCurrPos + 1)^ = #10)) then continueLastComment := False;
    if not (FCurrPos^ in [#0,#33..#255]) then State := EatWhite;
    if (FCurrPos^ = '/') and ((FCurrPos + 1)^ = '*') then
    begin
      Comment := '';
      EatOne; EatOne; // Skip slash star
      inComment := True;
      State := EatStarComment;
      inComment := False;
    end;
    if (FCurrPos^ = '/') and ((FCurrPos + 1)^ = '/') then
    begin
      if not continueLastComment then
        Comment := ''
      else
        Comment := Comment + #13#10;
      EatOne; EatOne; // Skip the double slashes
      inComment := True;
      State := EatSlashComment;
      inComment := False;
    end;
  end;
end;


function TJavaParser.GetNextToken: string;

  procedure AddOne;
  begin
    Token := Token + GetChar;
  end;

begin
//Hantera qualified id som en token
//'.' är en del av ett namn
//om första tecken efter namn är [ så hitta matchande ] och returnera som en token
//raise ifall end of file
  Token := '';

  EatWhiteSpace;

  if FCurrPos^ = '"' then // Parse String
  begin
    AddOne;
    while not (FCurrPos^ in ['"',#0]) do
    begin
      if ((FCurrPos^ = '\') and ((FCurrPos + 1)^ in ['"','\'])) then AddOne;
      AddOne;
    end;
    AddOne;
  end
  else if FCurrPos^ = '''' then // Parse char
  begin
    AddOne;
    while not (FCurrPos^ in ['''',#0]) do
    begin
      if ((FCurrPos^ = '\') and ((FCurrPos + 1)^ in ['''','\'])) then AddOne;
      AddOne;
    end;
    AddOne;
  end
  else if FCurrPos^ in ['A'..'Z', 'a'..'z', '_', '$'] then
  begin //Identifier
    AddOne;
    while True do
    begin
      while FCurrPos^ in ['A'..'Z', 'a'..'z', '0'..'9', '_'] do AddOne;
      if FCurrPos^ = '.' then
      begin
        AddOne;
        Continue;
      end;
      Break;
    end;
    while FCurrPos^ in ['[', ']'] do AddOne;
  end
  else if FCurrPos^ in [';', '{', '}', '(', ')', ',', '='] then
  begin //Enskilda tecken som vi testar på
    AddOne;
  end
  else if FCurrPos^ = '[' then  //Lösa hakar
    while FCurrPos^ in ['[', ']'] do AddOne
  else //Allt annat, spola fram till whitespace eller intressant tecken
  begin
    while not (FCurrPos^ in [#0, #9, #10, #12, #13, #32, ',', '=', ';', '{', '}', '(', ')', '"', '''']) do AddOne;
    //**antagligen otillräckligt
  end;

  Result := Token;
end;

procedure TJavaParser.ParseStream(AStream: TStream; AModel: TAbstractPackage; AOM: TObjectModel);
begin
  if Assigned(FStream) then
    FreeAndNil(FStream);

  FStream := StreamToMemory(AStream);
  FCurrPos := FStream.Memory;

  FModel := AModel;
  FOM := AOM;

  ParseCompilationUnit;

//  ErrorHandler.Trace(FUnit.Name);
end;

(*
QualifiedIdentifier:
    Identifier { . Identifier }
*)

procedure TJavaParser.ParseModifiersOpt;
(*
ModifiersOpt:
    { Modifier }

Modifier:
    public
    protected
    private
    static
    abstract
    final
    native
    synchronized
    transient
    volatile
    strictfp
*)
begin
  //nollställ flaggor
  ModVisibility := viPublic;
  ModAbstract := False;
  while True do
  begin
    //Sätt flaggor baserat på visibility
    if Token = 'public' then
      ModVisibility := viPublic
    else if Token = 'protected' then
      ModVisibility := viProtected
    else if Token = 'private' then
      ModVisibility := viPrivate
    else if Token = 'abstract' then
      ModAbstract := True
    else if (Token = 'static') or (Token = 'final') or (Token = 'native') or
      (Token = 'synchronized') or (Token = 'transient') or (Token = 'volatile') or (Token = 'strictfp') then
    else
      Break;
    GetNextToken;
  end;
end;


procedure TJavaParser.ParseCompilationUnit;
(*
CompilationUnit:
 [package QualifiedIdentifier   ;  ]
        {ImportDeclaration}
        {TypeDeclaration}
*)
var
  UnitName: string;
  S : string;
begin
  GetNextToken;

  if Token = 'package' then
  begin
    UnitName := GetNextToken;
    SkipToken(';');
  end
  else
    UnitName := 'Default';

  FUnit := (FModel as TLogicPackage).FindUnitPackage(UnitName);
  if not Assigned(FUnit) then
    FUnit := (FModel as TLogicPackage).AddUnit(UnitName);

  while Token = 'import' do
  begin
    (*
     ImportDeclaration
        import Identifier {   .   Identifier } [   .     *   ] ;
    *)
    S := GetNextToken;
    if GetNextToken = '*' then
    begin
      FullImports.Add( ExtractPackageName(S) );
      GetNextToken;
    end
    else
    begin
      ClassImports.Values[ ExtractClassName(S) ] := ExtractPackageName(S);
//      NeedClassifier(S);
    end;
    GetNextToken;
  end;

  while Token<>'' do
    ParseTypeDeclaration;
end;


procedure TJavaParser.ParseTypeDeclaration;
(*
TypeDeclaration:
    ClassOrInterfaceDeclaration
    ;

ClassOrInterfaceDeclaration:
    ModifiersOpt (ClassDeclaration | InterfaceDeclaration)

InterfaceDeclaration:
    interface Identifier [extends TypeList] InterfaceBody
*)
begin
  ParseModifiersOpt;
  if Token = 'class' then
    ParseClassDeclaration
  else if Token = 'interface' then
    ParseInterfaceDeclaration
  else if Token = ';' then
    GetNextToken
  else
    //**error
//    raise Exception.Create('JavaParser error')
    GetNextToken
    ;
end;



procedure TJavaParser.ParseClassDeclaration(IsInner : boolean = False; const ParentName : string = '');
(*
ClassDeclaration:
    class Identifier [extends Type] [implements TypeList] ClassBody

ClassBody:
    { {ClassBodyDeclaration} }

ClassBodyDeclaration:
    ;
    [static] Block
    ModifiersOpt MemberDecl

MemberDecl:
    MethodOrFieldDecl
    void Identifier MethodDeclaratorRest
    Identifier ConstructorDeclaratorRest
    ClassOrInterfaceDeclaration

MethodOrFieldDecl:
    Type Identifier MethodOrFieldRest

MethodOrFieldRest:
    VariableDeclaratorRest
    MethodDeclaratorRest
*)
var
  C: TClass;
  Int: TInterface;
  TypeName, Ident: string;
begin
  GetNextToken;
  C := FUnit.AddClass(Token);
  SetVisibility(C);
  GetNextToken;

  if Token = 'extends' then
  begin
    C.Ancestor := NeedClassifier(GetNextToken, True, TClass) as TClass;
    GetNextToken;
  end;

  if Token = 'implements' then
  begin
    repeat
      Int := NeedClassifier(GetNextToken, True, TInterface) as TInterface;
      if Assigned(Int) then
        C.AddImplements(Int);
      GetNextToken;
    until Token <> ',';
  end;

  if Token = '{' then
  begin
    GetNextToken;
    while True do
    begin
      ParseModifiersOpt;
      if Token = '{' then
        //Static initializer
        SkipPair('{', '}')
      else if Token = ';' then
        //ensamt semikolon
        GetNextToken
      else if Token = 'class' then
        //Inner class
        ParseClassDeclaration(True,C.Name)
      else if Token = 'interface' then
        //Inner interface
        ParseInterfaceDeclaration
      else if (Token = '}') or (Token='') then
      begin
        //Slut på klassdeklaration
        GetNextToken;
        Break;
      end
      else
      begin
        //Måste vara typnamn för attr eller operation
        //Eller konstruktor
        TypeName := GetTypeName;
        if (TypeName = C.Name) and (Token = '(') then
        begin
          Ident := TypeName; //Konstruktor
          TypeName := '';
        end
        else
        begin
          Ident := Token;
          GetNextToken;
        end;
        if Token = '(' then
        begin
          //Operation
          DoOperation(C.AddOperation(Ident), C.Name, TypeName);
          GetNextToken; //')'
          //Skippa ev Throws
          while (Token<>';') and (Token <> '{') and (Token <> '') do
            GetNextToken;
          //Antingen ; för abstract metod eller { för body
          if Token='{' then
            SkipPair('{', '}');
        end
        else
        begin
          //Attributes
          DoAttribute(C.AddAttribute(Ident), TypeName);
          while Token = ',' do
          begin
            DoAttribute(C.AddAttribute(GetNextToken), TypeName);
            GetNextToken;
          end;
          Comment := '';
        end;
      end;
    end;
  end;

  //**Räcker detta?
  //Parent läggs till sist för att konstruktorer etc skall fungera
  if IsInner then
    C.Name := ParentName + '.' + C.Name;
end;

procedure TJavaParser.ParseInterfaceDeclaration;
(*
InterfaceDeclaration:
	interface Identifier [extends TypeList] InterfaceBody

InterfaceBody:
	{ {InterfaceBodyDeclaration} }

InterfaceBodyDeclaration:
	;
	ModifiersOpt InterfaceMemberDecl

InterfaceMemberDecl:
	InterfaceMethodOrFieldDecl
	void Identifier VoidInterfaceMethodDeclaratorRest
	ClassOrInterfaceDeclaration

InterfaceMethodOrFieldDecl:
	Type Identifier InterfaceMethodOrFieldRest

InterfaceMethodOrFieldRest:
	ConstantDeclaratorsRest ;
	InterfaceMethodDeclaratorRest

InterfaceMethodDeclaratorRest:
	FormalParameters BracketsOpt [throws QualifiedIdentifierList]   ;

VoidInterfaceMethodDeclaratorRest:
	FormalParameters [throws QualifiedIdentifierList]   ;
*)
var
  Int: TInterface;
  TypeName, Ident: string;
begin
  GetNextToken;
  Int := FUnit.AddInterface(Token);
  SetVisibility(Int);
  GetNextToken;

  if Token = 'extends' then
  begin
    Int.Ancestor := NeedClassifier(GetNextToken, True, TInterface) as TInterface;
    //**limitation: an java interface can extend several interfaces, but our model only support one ancestor
    GetNextToken;
    while Token=',' do
    begin
      GetNextToken;
      GetNextToken;
    end;
  end;

  if Token = '{' then
  begin
    GetNextToken;
    while True do
    begin
      ParseModifiersOpt;
      if Token = ';' then
        //empty
        GetNextToken
      else if Token = 'class' then
        //Inner class
        ParseClassDeclaration
      else if Token = 'interface' then
        //Inner interface
        ParseInterfaceDeclaration
      else if (Token = '}')  or (Token='') then
      begin
        //End of interfacedeclaration
        GetNextToken;
        Break;
      end
      else
      begin
        //Must be type of attr or return type of operation
        TypeName := GetTypeName;
        Ident := Token;
        if GetNextToken = '(' then
        begin
          //Operation
          DoOperation(Int.AddOperation(Ident), Int.Name, TypeName);
          GetNextToken;
          //Skip Throws if present
          while (Token<>';') and (Token <> '') do
            GetNextToken;
        end
        else
        begin
          DoAttribute(Int.AddAttribute(Ident) , TypeName);
          while Token = ',' do
          begin
            DoAttribute(Int.AddAttribute(GetNextToken), TypeName);
            GetNextToken;
          end;
          Comment := '';
        end;
      end;
    end;
  end;
end;

function TJavaParser.NeedClassifier(const CName: string; Force :  boolean = True; TheClass: TModelEntityClass = nil): TClassifier;
var
  PName,ShortName : string;
  CacheI : integer;

  function InLookInModel : TClassifier;
  var
    U : TUnitPackage;
    I : integer;
  begin
    Result := nil;
    if PName='' then
    //Inget packagenamn, kolla i aktuell unit samt imports
    begin
      //Classimports ( java.util.HashTable )
      for I := 0 to ClassImports.Count-1 do
        //Kan ej göra indexofname pga casesensetivity
        if ClassImports.Names[I]=ShortName then
        begin
          Result := NeedClassifier( ClassImports.Values[ShortName] + '.' + ShortName, False, TheClass );
          if Assigned(Result) then
            Break;
        end;
      //Fullimports ( java.util.* )
      if not Assigned(Result) then
      begin
        for I := 0 to FullImports.Count-1 do
        begin
          Result := NeedClassifier( FullImports[I] + '.' + ShortName, False, TheClass );
          if Assigned(Result) then
            Break;
        end;
      end;
      //Kolla i aktuell unit
      if not Assigned(Result) then
        Result := FUnit.FindClassifier(ShortName,False,TheClass,True);
    end
    else
    //Packagenamn angivet, leta efter package
    begin
      U := FOM.ModelRoot.FindUnitPackage(PName);
      if not Assigned(U) then
        //Försök hitta shortname.java fil i alla kända sökvägar
        //Leta sedan i model på nytt
        //**Ej tillräckligt, hittar tex List.java först i awt när det är List.java i util som behövs
        //**Borde iterera alla .java filer som har heter shortname
        if NeedSource(ShortName) then
          U := FOM.ModelRoot.FindUnitPackage(PName);
      if Assigned(U) then
        Result := U.FindClassifier(ShortName,False,TheClass,True);
    end;
  end;

begin
  //Allra först titta i cache över namn vi redan kört lookup på
  //Optimering som sparar mycket tid när man läser in stora projekt
  CacheI := NameCache.IndexOf(CName);
  if (CacheI<>-1) and (NameCache[CacheI]=CName) and ((TheClass=nil) or (NameCache.Objects[CacheI] is TheClass)) then
   //Stringlist indexof är ej casesensitive så vi måste göra det igen
  begin
    Result := TClassifier(NameCache.Objects[CacheI]);
    Exit;
  end;

  PName := ExtractPackageName(CName);
  ShortName := ExtractClassName(CName);

  //Kolla i modellen
  Result := InLookInModel;

  //Annars se om vi hittar den fil vi behöver
  if not Assigned(Result) then
    if NeedSource(ShortName) then
      Result := InLookInModel;

  if not Assigned(Result) then
  begin
    //Leta i unknown
    Result := FOM.UnknownPackage.FindClassifier(CName,False,TheClass,True);
    if Force and (not Assigned(Result)) then
    begin
      //Saknas, skapa i unknown (om Force)
      if (TheClass=nil) or (TheClass=TClass) then
        Result := FOM.UnknownPackage.AddClass(CName)
      else if TheClass=TInterface then
        Result := FOM.UnknownPackage.AddInterface(CName)
      else if TheClass=TDataType then
        Result := FOM.UnknownPackage.AddDataType(CName)
    end;
  end;

  if Assigned(Result) and (CacheI=-1) then
    NameCache.AddObject(CName,Result);

  if Force and (not Assigned(Result)) then
    raise Exception.Create(ClassName + ' failed to locate ' + Cname);
end;

//Sätt visibility baserat på flaggor som parseOptModifier tilldelat
procedure TJavaParser.SetVisibility(M: TModelEntity);
begin
  M.Visibility := ModVisibility;
  if ModAbstract and (M is TOperation) then
    (M as TOperation).IsAbstract := ModAbstract;
end;

function TJavaParser.GetChar: char;
begin
  Result := FCurrPos^;
  if Result<>#0 then
    Inc(FCurrPos);
end;

procedure TJavaParser.DoOperation(O: TOperation; const ParentName, TypeName: string);
var
  ParType: string;
begin
  SetVisibility(O);
  if (TypeName <> '') and (TypeName <> 'void') then
    O.ReturnValue := NeedClassifier(TypeName);
  if Assigned(O.ReturnValue) then
    O.OperationType := otFunction
  else if ParentName = O.Name then
    O.OperationType := otConstructor
  else
    O.OperationType := otProcedure;
  //Parametrar
  GetNextToken;
  while (Token<>'') and (Token <> ')') do
  begin
    if Token = 'final' then
      GetNextToken;
    ParType := GetTypeName;
    O.AddParameter(Token).TypeClassifier := NeedClassifier(ParType);
    GetNextToken;
    if Token=',' then
      GetNextToken;
  end;
  O.Documentation.Description := Comment;
  Comment := '';
end;

procedure TJavaParser.DoAttribute(A: TAttribute; const TypeName: string);
begin
  SetVisibility(A);
  if Token = '=' then
    while (Token <> ';') and (Token<>'') do
    begin
      GetNextToken;
      //Attribute initializer kan innehålla hela inner classdeklarationer
      if Token='{' then
        SkipPair('{','}');
    end;
  A.TypeClassifier := NeedClassifier(TypeName);
  A.Documentation.Description := Comment;
  if Token=';' then
    GetNextToken;
end;

//Hanterar att typnamn kan följas av ett [] som kommer efteråt
function TJavaParser.GetTypeName: string;
(*
Type:
	Identifier {   .   Identifier } BracketsOpt
	BasicType

*)
begin
  Result := Token;
  GetNextToken;
  if (Length(Token)>0) and (Token[1]='[') then
  begin
    Result := Result + Token;
    GetNextToken;
  end;
end;


//Anropar needpackage.
//Obs att 'package' i javaparser avser en .java-fil.
function TJavaParser.NeedSource(const SourceName: string): boolean;
var
  Str : TStream;
  Parser : TJavaParser;
begin
  Result := False;
  if Assigned(NeedPackage) then
  begin
    NeedPackage(SourceName,Str);
    if Assigned(Str) then
    begin
      Parser := TJavaParser.Create;
      try
        Parser.NeedPackage := NeedPackage;
        Parser.ParseStream(Str, FOM.ModelRoot, FOM);
      finally
        FreeAndNil(Parser);
      end;
      Result := True;
    end;
  end;
end;

constructor TOperation.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FParameters := TList.Create;
end;

destructor TOperation.Destroy;
begin
  Clear(FParameters);
  FreeAndNil(FParameters);
  inherited;
end;

function TOperation.AddParameter(const NewName: string): TParameter;
begin
  Result := TParameter.Create(Self);
  Result.FName := NewName;
  FParameters.Add(Result);
end;

{ TModelEntity }

constructor TModelEntity.Create(Owner: TModelEntity);
begin
  inherited Create;
  Self.Owner := Owner;
  FDocumentation := TDocumentation.Create;
end;

destructor TModelEntity.Destroy;
begin
  FreeAndNil(FDocumentation);
  inherited;
end;

function TModelEntity.GetFullName: string;
var
  full : string;
begin
  if Assigned(FOwner) then begin
    full := FOwner.FullName;
    if full <> '' then
      Result := full + '.' + FName
    else
      Result := FName;
  end
  else
    Result := FName;
end;

function TModelEntity.GetRoot: TModelEntity;
begin
  Result := Self;
  while Result.Owner<>nil do
    Result := Result.Owner;
end;

{ TDocumentation }

procedure TDocumentation.SetDescription(const Value: string);
var
  I : integer;
begin
  { TODO : Maybe use some kind of TCommentaryParser-class to extract javadoc style tags here }
  I := 1;
  while (I<Length(Value)+1) and (Value[I] in ['*','_','/',' ',#13,#10]) do Inc(I);
  if I>1 then
    FDescription := Copy(Value,I,MAXINT)
  else
    FDescription := Value;
end;

function TDocumentation.ShortDescription: string;
var
  I : integer;
begin
  I := Pos('.',Description);
  if (I=0) or (I>80) then
    I:=80;
  Result := Copy(Description,1,I);
end;

{ TClassifier }

constructor TClassifier.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FFeatures := TList.Create;
end;

destructor TClassifier.Destroy;
begin
  Clear(FFeatures);
  FreeAndNil(FFeatures);
  inherited;
end;

function TClassifier.GetFeatures: IModelIterator;
begin
  Result := TModelIterator.Create( FFeatures );
end;

{ TInterface }

function TInterface.AddAttribute(const NewName: string): TAttribute;
begin
  Result := TAttribute.Create(Self);
  Result.FName := NewName;
  FFeatures.Add(Result);
end;

function TInterface.AddOperation(const NewName: string): TOperation;
begin
  Result := TOperation.Create(Self);
  Result.FName := NewName;
  FFeatures.Add(Result);
end;

constructor TInterface.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
end;

destructor TInterface.Destroy;
begin
  inherited;
end;

function TInterface.GetAttributes: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TAttribute);
end;

function TInterface.GetImplementingClasses: IModelIterator;
begin
  Result := TModelIterator.Create(
    (Root as TLogicPackage).GetAllClassifiers,
    TInterfaceImplementsFilter.Create(Self) );
end;

function TInterface.GetOperations: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TOperation);
end;

procedure TInterface.SetAncestor(const Value: TInterface);
begin
  Assert(Value <> Self, 'Tried to set self to ancestor.');
  FAncestor := Value;
end;

{ TClass }

function TClass.AddAttribute(const NewName: string): TAttribute;
begin
  Result := TAttribute.Create(Self);
  Result.FName := NewName;
  FFeatures.Add(Result);
end;

function TClass.AddImplements(I: TInterface): TInterface;
begin
  Result := I;
  FImplements.Add(I);
end;

function TClass.AddOperation(const NewName: string): TOperation;
begin
  Result := TOperation.Create(Self);
  Result.FName := NewName;
  FFeatures.Add(Result);
end;

function TClass.AddProperty(const NewName: string): TProperty;
begin
  Result := TProperty.Create(Self);
  Result.FName := NewName;
  FFeatures.Add(Result);
end;

constructor TClass.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FImplements := TList.Create; //Only reference
end;

destructor TClass.Destroy;
begin
//  Clear(FImplements);
  FreeAndNil(FImplements);
  inherited;
end;

function TClass.FindOperation(O: TOperation): TOperation;
var
  Mi,Omi1,Omi2 : IModelIterator;
  O2 : TOperation;
  label Skip;
begin
  Assert(O<>nil,ClassName + '.FindOperation invalid parameter');
  Result := nil;
  Mi := GetOperations;
  while Mi.HasNext do
  begin
    O2 := Mi.Next as TOperation;
    //Compare nr of parameters
    if O.FParameters.Count<>O2.FParameters.Count then
      Continue;
    { TODO -ovk : case sensitive match? java/delphi. only delphi-parser calls this method. }
    //Compare operation name
    if CompareText(O.Name,O2.Name)<>0 then
      Continue;
    //Compare parameters
    Omi1 := O.GetParameters;
    Omi2 := O2.GetParameters;
    while Omi1.HasNext do
      if CompareText((Omi1.Next as TParameter).Name,(Omi2.Next as TParameter).Name)<>0 then
        goto Skip;
    //Ok, match
    Result := O2;
    Break;
  Skip:
  end;
end;

function TClass.GetAttributes: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TAttribute);
end;

function TClass.GetImplements: IModelIterator;
begin
  Result := TModelIterator.Create( FImplements );
end;

function TClass.GetOperations: IModelIterator;
begin
  Result := TModelIterator.Create( GetFeatures , TOperation);
end;

procedure TClass.SetAncestor(const Value: TClass);
begin
  Assert(Value <> Self, 'Tried to set self to ancestor.');
  if Value <> FAncestor then
    FAncestor := Value;
end;

{ TUnitPackage }

function TUnitPackage.AddClass(const NewName: string): TClass;
begin
  Result := TClass.Create(Self);
  Result.FName := NewName;
  FClassifiers.Add(Result);
end;

function TUnitPackage.AddDatatype(const NewName: string): TDataType;
begin
  Result := TDataType.Create(Self);
  Result.FName := NewName;
  FClassifiers.Add(Result);
end;

function TUnitPackage.AddInterface(const NewName: string): TInterface;
begin
  Result := TInterface.Create(Self);
  Result.FName := NewName;
  FClassifiers.Add(Result);
end;

function TUnitPackage.AddUnitDependency(U: TUnitPackage;
  Visibility: TVisibility): TUnitDependency;
begin
  Assert( (U<>Self) and (U<>nil) ,ClassName + '.AddUnitDependency invalid parameter');
  Result := TUnitDependency.Create( Self );
  Result.Package := U;
  Result.Visibility := Visibility;
  FUnitDependencies.Add( Result );
end;

constructor TUnitPackage.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FClassifiers := TList.Create;
  FUnitDependencies := TList.Create;
end;

destructor TUnitPackage.Destroy;
begin
  Clear(FClassifiers);
  Clear(FUnitDependencies);
  FreeAndNil(FClassifiers);
  FreeAndNil(FUnitDependencies);
  inherited;
end;

type
  TStrCompare = function(const S1, S2: string): Integer;
const
  CompareFunc : array[boolean] of TStrCompare = (CompareText, CompareStr);

function TUnitPackage.FindClassifier(const CName: string;
  RaiseException: boolean; TheClass: TModelEntityClass;
  CaseSense: boolean): TClassifier;
var
  C : TClassifier;
  Mi : IModelIterator;
  P : TUnitPackage;
  F : TStrCompare;

  function InFind(P : TUnitPackage) : TClassifier;
  var
    Mi : IModelIterator;
  begin
    Result := nil;
    //Search in this unit
    if Assigned(TheClass) then
      Mi := TModelIterator.Create( P.GetClassifiers , TheClass )
    else
      Mi := P.GetClassifiers;
    while Mi.HasNext do
    begin
      C := Mi.Next as TClassifier;
      if F(C.Name,CName)=0 then
      begin
        Result := C;
        Break;
      end;
    end;
  end;

begin
  F := CompareFunc[CaseSense];
  //Search in this unit
  Result := InFind(Self);
  //If nil search in public dependencies
  if not Assigned(Result) then
  begin
    Mi := GetUnitDependencies;
    while Mi.HasNext do
    begin
      P := (Mi.Next as TUnitDependency).Package;
      Result := InFind(P);
      if Assigned(Result) then
        Break;
    end;
  end;
  if not Assigned(Result) and RaiseException then
    raise Exception.Create(ClassName + '.FindClassifier failed: ' + CName);
end;

function TUnitPackage.GetClassifiers: IModelIterator;
begin
  Result := TModelIterator.Create( FClassifiers );
end;

function TUnitPackage.GetUnitDependencies: IModelIterator;
begin
  Result := TModelIterator.Create( FUnitDependencies );
end;

{ TLogicPackage }

function TLogicPackage.AddUnit(const NewUnitName: string): TUnitPackage;
begin
  Result := TUnitPackage.Create(Self);
  Result.FName := NewUnitName;
  FPackages.Add(Result);
end;

constructor TLogicPackage.Create(Owner: TModelEntity);
begin
  inherited Create(Owner);
  FPackages := TList.Create;
end;

destructor TLogicPackage.Destroy;
begin
  Clear(FPackages);
  FreeAndNil(FPackages);
  inherited;
end;

function TLogicPackage.FindUnitPackage(const PName: string; RaiseException,
  CaseSense: boolean): TUnitPackage;
var
  I: integer;
  P: TAbstractPackage;
  F : TStrCompare;
begin
  F := CompareFunc[CaseSense];
  Result := nil;
  for I := 0 to FPackages.Count - 1 do
  begin
    P := TObject(FPackages[I]) as TAbstractPackage;
    if (P is TLogicPackage) then
    begin
      Result := (P as TLogicPackage).FindUnitPackage(PName, RaiseException);
      if Assigned(Result) then
        Exit;
    end
    else if (P is TUnitPackage) then
    begin
      if F(P.Name,PName)=0 then
      begin
        Result := P as TUnitPackage;
        Exit;
      end;
    end;
  end;
  if not Assigned(Result) and RaiseException then
    raise Exception.Create(ClassName + '.FindUnitPackage failed: ' + PName);
end;

function TLogicPackage.GetAllClassifiers: IModelIterator;
var
  Pmi,Cmi : IModelIterator;
  List : TList;
begin
  List := TList.Create;
  try
    Pmi := GetAllUnitPackages;
    while Pmi.HasNext do
    begin
      Cmi := (Pmi.Next as TUnitPackage).GetClassifiers;
      while Cmi.HasNext do
        List.Add( Cmi.Next );
    end;
    Result := TModelIterator.Create(List,True);
  finally
    FreeAndNil(List);
  end;
end;

function TLogicPackage.GetAllUnitPackages: IModelIterator;
var
  List : TList;

  procedure InAddNested(L : TLogicPackage);
  var
    Mi : IModelIterator;
    P : TModelEntity;
  begin
    Mi := L.GetPackages;
    while Mi.HasNext do
    begin
      P := Mi.Next;
      if P is TLogicPackage then
        InAddNested(P as TLogicPackage)
      else //Not logicpackage, must be unitpackage.
        if (P.Name<>UNKNOWNPACKAGE_NAME) then List.Add( P );
    end;
  end;

begin
  List := TList.Create;
  try
    InAddNested(Self);
    Result := TModelIterator.Create(List,True);
  finally
    FreeAndNil(List);
  end;
end;

function TLogicPackage.GetPackages: IModelIterator;
begin
  Result := TModelIterator.Create(FPackages);
end;

{ TObjectModel }

procedure TObjectModel.Clear;
begin
  FreeAndNil(FModelRoot);
  CreatePackages;
end;

constructor TObjectModel.Create;
begin
  inherited;
  CreatePackages;
end;

procedure TObjectModel.CreatePackages;
begin
  FModelRoot := TLogicPackage.Create(nil);
  FUnknownPackage := FModelRoot.AddUnit(UNKNOWNPACKAGE_NAME);
end;

destructor TObjectModel.Destroy;
begin
  FreeAndNil(FModelRoot);
// FUnknownPackage will be freed by FModelRoot who owns it
  inherited;
end;

function TCodeParser.StreamToMemory(AStream: TStream): TMemoryStream;
begin
  Result := TMemoryStream.Create;
  Result.LoadFromStream(AStream);
  FreeAndNil(AStream);
  Result.SetSize(Result.Size + 1);
  PChar(Result.Memory)[Result.Size - 1] := #0;
end;


function TOperation.GetParameters: IModelIterator;
begin
  Result := TModelIterator.Create( FParameters );
end;

{ TModelIterator }

procedure TModelIterator.Advance;
begin
  FHasNext := NextI < FItems.Count;
  if FHasNext then
  begin
    FNext := TObject(FItems[NextI]) as TModelEntity;
    Inc(NextI);
  end;
end;

function TModelIterator.Count: integer;
begin
  Result := FItems.Count;
end;

constructor TModelIterator.Create(ObList: TList; MakeCopy: boolean);
var
  I : integer;
begin
  inherited Create;
  if MakeCopy then
  begin
    //Copy oblist to items
    OwnsItems := True;
    FItems := TList.Create;
    for I:=0 to ObList.Count-1 do
      FItems.Add(ObList[I]);
  end
  else
  begin
    //Reference same list instead of copy
    OwnsItems := False;
    FItems := ObList;
  end;
  Advance;
end;

constructor TModelIterator.Create(List: IModelIterator;
  MinVisibility: TVisibility);
begin
  inherited Create;
  //TModelEntity as classfilter = always true
  Init(List, TClassAndVisibilityFilter.Create(TModelEntity,MinVisibility), ioNone);
end;

constructor TModelIterator.Create(List: IModelIterator;
  Order: TIteratorOrder);
begin
  inherited Create;
  Init(List, nil, Order);
end;

constructor TModelIterator.Create(List: IModelIterator;
  OneClass: TModelEntityClass; MinVisibility: TVisibility;
  Order: TIteratorOrder);
begin
  inherited Create;
  Init(List, TClassAndVisibilityFilter.Create(OneClass,MinVisibility), Order);
end;

constructor TModelIterator.Create(List: IModelIterator;
  Filter: IIteratorFilter; Order: TIteratorOrder);
begin
  inherited Create;
  Init(List, Filter, Order);
end;

destructor TModelIterator.Destroy;
begin
  if OwnsItems then
    FreeAndNil(FItems);
  inherited;
end;

function TModelIterator.HasNext: boolean;
begin
  Result := FHasNext;
end;

function SortVisibility(Item1, Item2: Pointer): Integer;
var
  E1,E2 : TModelEntity;
begin
  //Visibility, then alpha
  E1 := TModelEntity(Item1);
  E2 := TModelEntity(Item2);
  if (E1.Visibility<E2.Visibility) then
    Result:=-1  //Lower
  else if (E1.Visibility=E2.Visibility) then
    Result := CompareText(E1.Name,E2.Name)
  else
    Result:=1; //Higher
end;

function SortAlpha(Item1, Item2: Pointer): Integer;
begin
  Result := CompareText( TModelEntity(Item1).Name , TModelEntity(Item2).Name );
end;

procedure TModelIterator.Init(List: IModelIterator; Filter: IIteratorFilter; Order : TIteratorOrder);
var
  E : TModelEntity;
begin
  OwnsItems := True;
  FItems := TList.Create;
  if Assigned(Filter) then
    while List.HasNext do
    begin
      E := List.Next;
      if Filter.Accept( E ) then
        FItems.Add( E );
    end
  else//Not filtered
    while List.HasNext do
      FItems.Add( List.Next );
  //Sort
  case Order of
    ioNone : ;
    ioVisibility : FItems.Sort( SortVisibility );
    ioAlpha      : FItems.Sort( SortAlpha );
  end;
  Advance;
end;

function TModelIterator.Next: TModelEntity;
begin
  if not FHasNext then
    raise Exception.Create(ClassName + '.Next at end');
  Result := FNext;
  Advance;
end;

procedure TModelIterator.Reset;
begin
  NextI := 0;
  Advance;
end;

{ TClassAndVisibilityFilter }

function TClassAndVisibilityFilter.Accept(M: TModelEntity): boolean;
begin
  Result := (M is OneClass) and (M.Visibility>=MinVisibility);
end;

constructor TClassAndVisibilityFilter.Create(OneClass: TModelEntityClass;
  MinVisibility: TVisibility);
begin
  inherited Create;
  Self.OneClass := OneClass;
  Self.MinVisibility := MinVisibility;
end;

{ TInterfaceImplementsFilter }

function TInterfaceImplementsFilter.Accept(M: TModelEntity): boolean;
begin
  Result := (M is TClass) and ((M as TClass).FImplements.IndexOf(Int)<>-1);
end;

constructor TInterfaceImplementsFilter.Create(I: TInterface);
begin
  inherited Create;
  Int := I;
end;

end.
