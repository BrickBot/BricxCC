unit ev3_vmexe;

interface

uses
  Classes;

type
  TEV3ExeWriter = class
  private
    fExeStream : TMemoryStream;
    fVersionInfo: Word;
    procedure WriteImageHeader(stream : TStream; numObjects, globalBytes, fileSize : integer);
    procedure WriteObjectHeaders(stream : TStream);
    procedure WriteObjectHeader(stream : TStream);
    procedure WriteCodeSection(stream : TStream);
    procedure WriteImage(stream : TStream);
    function GetFileSize: integer;
    function GetNumGlobalBytes: integer;
    function GetNumObjects: integer;
  public
    constructor Create;
    destructor Destroy; override;
    property VersionInfo : Word read fVersionInfo write fVersionInfo;
    property NumberOfObjects : integer read GetNumObjects;
    property NumberOfGlobalBytes : integer read GetNumGlobalBytes;
    property FileSize : integer read GetFileSize;
  end;


(*
#define   LONGToBytes(_x) (UBYTE)((_x) and $FF),(UBYTE)((_x shr 8) and $FF),(UBYTE)((_x shr 16) and $FF),(UBYTE)((_x shr 24) and $FF)
#define   WORDToBytes(_x) (UBYTE)((_x) and $FF),(UBYTE)((_x shr 8) and $FF)
#define   BYTEToBytes(_x) (UBYTE)((_x) and $FF)

#define   PROGRAMHeader(VersionInfo,NumberOfObjects,GlobalBytes) 'L','E','G','O',LONGToBytes(0),WORDToBytes((UWORD)(VersionInfo * 100.0)),WORDToBytes(NumberOfObjects),LONGToBytes(GlobalBytes)
#define   VMTHREADHeader(OffsetToInstructions,LocalBytes) LONGToBytes(OffsetToInstructions),0,0,0,0,LONGToBytes(LocalBytes)
#define   SUBCALLHeader(OffsetToInstructions,LocalBytes) LONGToBytes(OffsetToInstructions),0,0,1,0,LONGToBytes(LocalBytes)
#define   BLOCKHeader(OffsetToInstructions,OwnerObjectId,TriggerCount) LONGToBytes(OffsetToInstructions),WORDToBytes(OwnerObjectId),WORDToBytes(TriggerCount),LONGToBytes(0)

#define   HND(_x) PRIMPAR_HANDLE or _x
#define   ADR(_x) PRIMPAR_ADDR or _x

#define   LAB1(v) (PRIMPAR_LONG or PRIMPAR_LABEL),(v and $FF)

#define   LC0(v)  ((v and PRIMPAR_VALUE) or PRIMPAR_SHORT or PRIMPAR_CONST)
#define   LC1(v)  (PRIMPAR_LONG  or PRIMPAR_CONST or PRIMPAR_1_BYTE),(v and $FF)
#define   LC2(v)  (PRIMPAR_LONG  or PRIMPAR_CONST or PRIMPAR_2_BYTES),(v and $FF),((v shr 8) and $FF)
#define   LC4(v)  (PRIMPAR_LONG  or PRIMPAR_CONST or PRIMPAR_4_BYTES),((ULONG)v and $FF),(((ULONG)v shr (ULONG)8) and $FF),(((ULONG)v shr (ULONG)16) and $FF),(((ULONG)v shr (ULONG)24) and $FF)
#define   LCA(h)  (PRIMPAR_LONG  or PRIMPAR_CONST or PRIMPAR_1_BYTE or PRIMPAR_ARRAY),(i and $FF)

#define   LV0(i)  ((i and PRIMPAR_INDEX) or PRIMPAR_SHORT or PRIMPAR_VARIABEL or PRIMPAR_LOCAL)
#define   LV1(i)  (PRIMPAR_LONG  or PRIMPAR_VARIABEL or PRIMPAR_LOCAL or PRIMPAR_1_BYTE),(i and $FF)
#define   LV2(i)  (PRIMPAR_LONG  or PRIMPAR_VARIABEL or PRIMPAR_LOCAL or PRIMPAR_2_BYTES),(i and $FF),((i shr 8) and $FF)
#define   LV4(i)  (PRIMPAR_LONG  or PRIMPAR_VARIABEL or PRIMPAR_LOCAL or PRIMPAR_4_BYTES),(i and $FF),((i shr 8) and $FF),((i shr 16) and $FF),((i shr 24) and $FF)
#define   LVA(h)  (PRIMPAR_LONG  or PRIMPAR_VARIABEL or PRIMPAR_LOCAL or PRIMPAR_1_BYTE or PRIMPAR_ARRAY),(i and $FF)

#define   GV0(i)  ((i and PRIMPAR_INDEX) or PRIMPAR_SHORT or PRIMPAR_VARIABEL or PRIMPAR_GLOBAL)
#define   GV1(i)  (PRIMPAR_LONG  or PRIMPAR_VARIABEL or PRIMPAR_GLOBAL or PRIMPAR_1_BYTE),(i and $FF)
#define   GV2(i)  (PRIMPAR_LONG  or PRIMPAR_VARIABEL or PRIMPAR_GLOBAL or PRIMPAR_2_BYTES),(i and $FF),((i shr 8) and $FF)
#define   GV4(i)  (PRIMPAR_LONG  or PRIMPAR_VARIABEL or PRIMPAR_GLOBAL or PRIMPAR_4_BYTES),(i and $FF),((i shr 8) and $FF),((i shr 16) and $FF),((i shr 24) and $FF)
#define   GVA(h)  (PRIMPAR_LONG  or PRIMPAR_VARIABEL or PRIMPAR_GLOBAL or PRIMPAR_1_BYTE or PRIMPAR_ARRAY),(i and $FF)

*)

implementation

uses
  SysUtils, uStreamRW;

{ TEV3ExeWriter }

constructor TEV3ExeWriter.Create;
begin
  inherited;
  fExeStream := TMemoryStream.Create;
  fVersionInfo := 104; // 1.04 * 100
end;

destructor TEV3ExeWriter.Destroy;
begin
  FreeAndNil(fExeStream);
  inherited;
end;

function TEV3ExeWriter.GetFileSize: integer;
begin

end;

function TEV3ExeWriter.GetNumGlobalBytes: integer;
begin

end;

function TEV3ExeWriter.GetNumObjects: integer;
begin

end;

procedure TEV3ExeWriter.WriteCodeSection(stream: TStream);
begin
(*
		private void WriteCodeSection(BinaryWriter stream)
		{
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator enumerator = this._module.ViBuilders.get_Values().GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					ViBuilder current = enumerator.get_Current();
					if (current.IsSubVI)
					{
						this.WriteSubCallParamHeaderInfo(stream, current);
					}
					using (Dictionary<int, ClumpBuilder>.Enumerator enumerator2 = current.Clumps.GetEnumerator())
					{
						while (enumerator2.MoveNext())
						{
							KeyValuePair<int, ClumpBuilder> current2 = enumerator2.get_Current();
							using (List<Instruction>.Enumerator enumerator3 = current2.get_Value().CodeGenerator.Instructions.GetEnumerator())
							{
								while (enumerator3.MoveNext())
								{
									Instruction current3 = enumerator3.get_Current();
									if (current3.TargetAddress < 0)
									{
										current3.TargetAddress = (int)stream.get_BaseStream().get_Position();
									}
									else
									{
										if (current3.TargetAddress != (int)stream.get_BaseStream().get_Position())
										{
											this._uncertainOfSomeInstructionSizes = true;
											current3.TargetAddress = (int)stream.get_BaseStream().get_Position();
										}
									}
									if (current3 is ConditionalBranchInstruction)
									{
										this.WriteConditionalBranchInstruction(stream, current3 as ConditionalBranchInstruction);
									}
									else
									{
										if (current3 is BranchInstruction)
										{
											this.WriteBranchInstruction(stream, current3 as BranchInstruction);
										}
										else
										{
											if (current3 is CompareInstruction)
											{
												this.WriteCompareInstruction(stream, current3 as CompareInstruction);
											}
											else
											{
												if (current3 is CodeEndInstruction)
												{
													this.WriteCodeEndInstruction(stream, current3 as CodeEndInstruction);
												}
												else
												{
													if (current3 is CallInstruction)
													{
														this.WriteCallInstruction(stream, current3 as CallInstruction);
													}
													else
													{
														if (current3 is ClumpInstruction)
														{
															this.WriteClumpInstruction(stream, current3 as ClumpInstruction);
														}
														else
														{
															if (current3 is PBRDirectCodeInstruction)
															{
																this.WritePBRDirectCodeInstruction(stream, current3 as PBRDirectCodeInstruction);
															}
															else
															{
																this.WriteInstruction(stream, current3);
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
*)
end;

procedure TEV3ExeWriter.WriteImage(stream: TStream);
begin
  WriteImageHeader(stream, NumberOfObjects, NumberOfGlobalBytes, FileSize);
  WriteObjectHeaders(stream);
  WriteCodeSection(stream);
end;

procedure TEV3ExeWriter.WriteImageHeader(stream: TStream; numObjects,
  globalBytes, fileSize: integer);
begin
  WriteString(stream, 'LEGO');
  WriteInteger(stream, fileSize);
  WriteWord(stream, VersionInfo);
  WriteWord(stream, numObjects);
  WriteInteger(stream, globalBytes);
end;

procedure TEV3ExeWriter.WriteObjectHeader(stream: TStream);
begin
(*
		private static void WriteObjectHeader(BinaryWriter stream, ViBuilder viBuilder, int localBytes, ClumpBuilder clump)
		{
			Instruction instruction = clump.CodeGenerator.Instructions.get_Item(0);
			int num = (viBuilder.IsSubVI && clump == viBuilder.RootClump) ? (instruction.TargetAddress - (1 + viBuilder.Parameters.get_Count())) : instruction.TargetAddress;
			stream.Write(num);
			stream.Write((ushort)((clump == viBuilder.RootClump) ? 0 : viBuilder.RootClump.Index));
			stream.Write(clump.FireCount);
			stream.Write(localBytes);
		}
*)
end;

procedure TEV3ExeWriter.WriteObjectHeaders(stream: TStream);
begin
// iterate through list of "objects" (aka clumps/vis)
(*
		private void WriteObjectHeaders(BinaryWriter stream)
		{
			int num = 1;
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator enumerator = this._module.ViBuilders.get_Values().GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					ViBuilder current = enumerator.get_Current();
					int localBytes = this._viLocalByteCount.get_Item(current);
					using (Dictionary<int, ClumpBuilder>.ValueCollection.Enumerator enumerator2 = current.Clumps.get_Values().GetEnumerator())
					{
						while (enumerator2.MoveNext())
						{
							ClumpBuilder current2 = enumerator2.get_Current();
							PBrickStreamBuilder.WriteObjectHeader(stream, current, localBytes, current2);
							current2.Index = num;
							if (current2 == current.RootClump && current.IsReentrant)
							{
								for (int i = 0; i < current.ReentrantCallerAdditionalHeaderCount; i++)
								{
									PBrickStreamBuilder.WriteObjectHeader(stream, current, localBytes, current2);
									num++;
								}
							}
							num++;
						}
					}
				}
			}
		}
*)
end;

end.
