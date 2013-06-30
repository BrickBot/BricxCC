unit uPBrickStreamBuilder;

interface

uses
  uPBRSimpleTypes, uPBRMiscTypes;

type
  TPBrickStreamBuilder = class
  public
    constructor Create;
  end;

implementation

{ TPBrickStreamBuilder }

constructor TPBrickStreamBuilder.Create;
begin

end;

(*
	public class PBrickStreamBuilder
	{
		private enum MoveInstructionTypes
		{
			Eight,
			Sixteen,
			ThirtyTwo,
			Float
		}
		private ModuleBuilder _module;
		private bool _uncertainOfSomeInstructionSizes;
		private List<Tuple<string, IDataType>> _mailboxNames;
		private Dictionary<ViBuilder, int> _viLocalByteCount;
		private static Dictionary<string, PBrickOpCode> _opCodeMisc;
		private static Dictionary<string, PBrickOpCode> _opCodeMap8;
		private static Dictionary<string, PBrickOpCode> _opCodeMap16;
		private static Dictionary<string, PBrickOpCode> _opCodeMap32;
		private static Dictionary<string, PBrickOpCode> _opCodeMapF;
		private static Dictionary<TypeCode, Dictionary<string, PBrickOpCode>> _mapMap;
		private static Dictionary<ConditionCode, string> _conditionCodeNameMap;
		[SuppressMessage("Microsoft.Performance", "CA1814:PreferJaggedArraysOverMultidimensional", Justification = "this multidimensional array doesn't waste space")]
		private static PBrickOpCode[,] _opCodeMapMoves;
		private static readonly Dictionary<TypeCode, PBrickStreamBuilder.MoveInstructionTypes> _clsTypeToMoveInstructionType;
		private static List<PBrickOpCode> _specialSizedInstructions;
		public PBrickStreamBuilder(ModuleBuilder model, List<Tuple<string, IDataType>> mailboxNames)
		{
			this._module = model;
			this._mailboxNames = mailboxNames;
			this._viLocalByteCount = new Dictionary<ViBuilder, int>();
		}
		[SuppressMessage("Microsoft.Performance", "CA1814:PreferJaggedArraysOverMultidimensional", Justification = "thismultidimensionalarraydoesn'twastespace"), SuppressMessage("Microsoft.Performance", "CA1810:InitializeReferenceTypeStaticFieldsInline", Justification = "TODO")]
		static PBrickStreamBuilder()
		{
			Dictionary<TypeCode, PBrickStreamBuilder.MoveInstructionTypes> dictionary = new Dictionary<TypeCode, PBrickStreamBuilder.MoveInstructionTypes>();
			dictionary.Add(14, PBrickStreamBuilder.MoveInstructionTypes.Float);
			dictionary.Add(13, PBrickStreamBuilder.MoveInstructionTypes.Float);
			dictionary.Add(7, PBrickStreamBuilder.MoveInstructionTypes.Sixteen);
			dictionary.Add(8, PBrickStreamBuilder.MoveInstructionTypes.Sixteen);
			dictionary.Add(9, PBrickStreamBuilder.MoveInstructionTypes.ThirtyTwo);
			dictionary.Add(10, PBrickStreamBuilder.MoveInstructionTypes.ThirtyTwo);
			dictionary.Add(5, PBrickStreamBuilder.MoveInstructionTypes.Eight);
			dictionary.Add(6, PBrickStreamBuilder.MoveInstructionTypes.Eight);
			dictionary.Add(3, PBrickStreamBuilder.MoveInstructionTypes.Eight);
			dictionary.Add(18, PBrickStreamBuilder.MoveInstructionTypes.Sixteen);
			PBrickStreamBuilder._clsTypeToMoveInstructionType = dictionary;
			PBrickStreamBuilder._opCodeMisc = new Dictionary<string, PBrickOpCode>();
			PBrickStreamBuilder._opCodeMap8 = new Dictionary<string, PBrickOpCode>();
			PBrickStreamBuilder._opCodeMap16 = new Dictionary<string, PBrickOpCode>();
			PBrickStreamBuilder._opCodeMap32 = new Dictionary<string, PBrickOpCode>();
			PBrickStreamBuilder._opCodeMapF = new Dictionary<string, PBrickOpCode>();
			PBrickStreamBuilder._mapMap = new Dictionary<TypeCode, Dictionary<string, PBrickOpCode>>();
			PBrickStreamBuilder._conditionCodeNameMap = new Dictionary<ConditionCode, string>();
			PBrickStreamBuilder._opCodeMapMoves = new PBrickOpCode[4, 4];
			PBrickStreamBuilder._opCodeMapMoves[0, 0] = PBrickOpCode.opMOVE88;
			PBrickStreamBuilder._opCodeMapMoves[0, 1] = PBrickOpCode.opMOVE816;
			PBrickStreamBuilder._opCodeMapMoves[0, 2] = PBrickOpCode.opMOVE832;
			PBrickStreamBuilder._opCodeMapMoves[0, 3] = PBrickOpCode.opMOVE8F;
			PBrickStreamBuilder._opCodeMapMoves[1, 0] = PBrickOpCode.opMOVE168;
			PBrickStreamBuilder._opCodeMapMoves[1, 1] = PBrickOpCode.opMOVE1616;
			PBrickStreamBuilder._opCodeMapMoves[1, 2] = PBrickOpCode.opMOVE1632;
			PBrickStreamBuilder._opCodeMapMoves[1, 3] = PBrickOpCode.opMOVE16F;
			PBrickStreamBuilder._opCodeMapMoves[2, 0] = PBrickOpCode.opMOVE328;
			PBrickStreamBuilder._opCodeMapMoves[2, 1] = PBrickOpCode.opMOVE3216;
			PBrickStreamBuilder._opCodeMapMoves[2, 2] = PBrickOpCode.opMOVE3232;
			PBrickStreamBuilder._opCodeMapMoves[2, 3] = PBrickOpCode.opMOVE32F;
			PBrickStreamBuilder._opCodeMapMoves[3, 0] = PBrickOpCode.opMOVEF8;
			PBrickStreamBuilder._opCodeMapMoves[3, 1] = PBrickOpCode.opMOVEF16;
			PBrickStreamBuilder._opCodeMapMoves[3, 2] = PBrickOpCode.opMOVEF32;
			PBrickStreamBuilder._opCodeMapMoves[3, 3] = PBrickOpCode.opMOVEFF;
			PBrickStreamBuilder._specialSizedInstructions = new List<PBrickOpCode>();
			PBrickStreamBuilder._mapMap.Add(6, PBrickStreamBuilder._opCodeMap8);
			PBrickStreamBuilder._mapMap.Add(5, PBrickStreamBuilder._opCodeMap8);
			PBrickStreamBuilder._mapMap.Add(3, PBrickStreamBuilder._opCodeMap8);
			PBrickStreamBuilder._mapMap.Add(7, PBrickStreamBuilder._opCodeMap16);
			PBrickStreamBuilder._mapMap.Add(8, PBrickStreamBuilder._opCodeMap16);
			PBrickStreamBuilder._mapMap.Add(9, PBrickStreamBuilder._opCodeMap32);
			PBrickStreamBuilder._mapMap.Add(10, PBrickStreamBuilder._opCodeMap32);
			PBrickStreamBuilder._mapMap.Add(13, PBrickStreamBuilder._opCodeMapF);
			PBrickStreamBuilder._mapMap.Add(14, PBrickStreamBuilder._opCodeMapF);
			PBrickStreamBuilder._opCodeMap8.Add("Add", PBrickOpCode.opADD8);
			PBrickStreamBuilder._opCodeMap16.Add("Add", PBrickOpCode.opADD16);
			PBrickStreamBuilder._opCodeMap32.Add("Add", PBrickOpCode.opADD32);
			PBrickStreamBuilder._opCodeMapF.Add("Add", PBrickOpCode.opADDF);
			PBrickStreamBuilder._opCodeMap8.Add("Multiply", PBrickOpCode.opMUL8);
			PBrickStreamBuilder._opCodeMap16.Add("Multiply", PBrickOpCode.opMUL16);
			PBrickStreamBuilder._opCodeMap32.Add("Multiply", PBrickOpCode.opMUL32);
			PBrickStreamBuilder._opCodeMapF.Add("Multiply", PBrickOpCode.opMULF);
			PBrickStreamBuilder._opCodeMap8.Add("Subtract", PBrickOpCode.opSUB8);
			PBrickStreamBuilder._opCodeMap16.Add("Subtract", PBrickOpCode.opSUB16);
			PBrickStreamBuilder._opCodeMap32.Add("Subtract", PBrickOpCode.opSUB32);
			PBrickStreamBuilder._opCodeMapF.Add("Subtract", PBrickOpCode.opSUBF);
			PBrickStreamBuilder._opCodeMap8.Add("Divide", PBrickOpCode.opDIV8);
			PBrickStreamBuilder._opCodeMap16.Add("Divide", PBrickOpCode.opDIV16);
			PBrickStreamBuilder._opCodeMap32.Add("Divide", PBrickOpCode.opDIV32);
			PBrickStreamBuilder._opCodeMapF.Add("Divide", PBrickOpCode.opDIVF);
			PBrickStreamBuilder._opCodeMap8.Add("Modulo", PBrickOpCode.opMathMod8);
			PBrickStreamBuilder._opCodeMap16.Add("Modulo", PBrickOpCode.opMathMod16);
			PBrickStreamBuilder._opCodeMap32.Add("Modulo", PBrickOpCode.opMathMod32);
			PBrickStreamBuilder._opCodeMapF.Add("Modulo", PBrickOpCode.opMathModulo);
			PBrickStreamBuilder._opCodeMapF.Add("AbsoluteValue", PBrickOpCode.opMathAbsoluteValue);
			PBrickStreamBuilder._opCodeMapF.Add("Sqrt", PBrickOpCode.opMathSquareRoot);
			PBrickStreamBuilder._opCodeMapF.Add("Exponent", PBrickOpCode.opMathPower);
			PBrickStreamBuilder._opCodeMapF.Add("Round", PBrickOpCode.opMathRound);
			PBrickStreamBuilder._opCodeMapF.Add("RoundDown", PBrickOpCode.opMathFloor);
			PBrickStreamBuilder._opCodeMapF.Add("RoundUp", PBrickOpCode.opMathCeiling);
			PBrickStreamBuilder._opCodeMap8.Add("Or", PBrickOpCode.opOR8);
			PBrickStreamBuilder._opCodeMap16.Add("Or", PBrickOpCode.opOR16);
			PBrickStreamBuilder._opCodeMap32.Add("Or", PBrickOpCode.opOR32);
			PBrickStreamBuilder._opCodeMap8.Add("Xor", PBrickOpCode.opXOR8);
			PBrickStreamBuilder._opCodeMap16.Add("Xor", PBrickOpCode.opXOR16);
			PBrickStreamBuilder._opCodeMap32.Add("Xor", PBrickOpCode.opXOR32);
			PBrickStreamBuilder._opCodeMap8.Add("And", PBrickOpCode.opAND8);
			PBrickStreamBuilder._opCodeMap16.Add("And", PBrickOpCode.opAND16);
			PBrickStreamBuilder._opCodeMap32.Add("And", PBrickOpCode.opAND32);
			PBrickStreamBuilder._opCodeMap8.Add("Not", PBrickOpCode.opXOR8);
			PBrickStreamBuilder._opCodeMap8.Add("TestAndJump", PBrickOpCode.opJRTRUE);
			PBrickStreamBuilder._opCodeMap32.Add("TestAndJump", PBrickOpCode.opJRTRUE);
			PBrickStreamBuilder._opCodeMap8.Add("CompareAndJump", PBrickOpCode.opJREQ8);
			PBrickStreamBuilder._opCodeMap16.Add("CompareAndJump", PBrickOpCode.opJREQ16);
			PBrickStreamBuilder._opCodeMap32.Add("CompareAndJump", PBrickOpCode.opJREQ32);
			PBrickStreamBuilder._opCodeMapF.Add("CompareAndJump", PBrickOpCode.opJREQF);
			PBrickStreamBuilder._opCodeMap8.Add("EqualTo", PBrickOpCode.opCPEQ8);
			PBrickStreamBuilder._opCodeMap16.Add("EqualTo", PBrickOpCode.opCPEQ16);
			PBrickStreamBuilder._opCodeMap32.Add("EqualTo", PBrickOpCode.opCPEQ32);
			PBrickStreamBuilder._opCodeMapF.Add("EqualTo", PBrickOpCode.opCPEQF);
			PBrickStreamBuilder._opCodeMap8.Add("GreaterThan", PBrickOpCode.opCPGT8);
			PBrickStreamBuilder._opCodeMap16.Add("GreaterThan", PBrickOpCode.opCPGT16);
			PBrickStreamBuilder._opCodeMap32.Add("GreaterThan", PBrickOpCode.opCPGT32);
			PBrickStreamBuilder._opCodeMapF.Add("GreaterThan", PBrickOpCode.opCPGTF);
			PBrickStreamBuilder._opCodeMap8.Add("GreaterThanOrEqualTo", PBrickOpCode.opCPGTEQ8);
			PBrickStreamBuilder._opCodeMap16.Add("GreaterThanOrEqualTo", PBrickOpCode.opCPGTEQ16);
			PBrickStreamBuilder._opCodeMap32.Add("GreaterThanOrEqualTo", PBrickOpCode.opCPGTEQ32);
			PBrickStreamBuilder._opCodeMapF.Add("GreaterThanOrEqualTo", PBrickOpCode.opCPGTEQF);
			PBrickStreamBuilder._opCodeMap8.Add("LessThan", PBrickOpCode.opCPLT8);
			PBrickStreamBuilder._opCodeMap16.Add("LessThan", PBrickOpCode.opCPLT16);
			PBrickStreamBuilder._opCodeMap32.Add("LessThan", PBrickOpCode.opCPLT32);
			PBrickStreamBuilder._opCodeMapF.Add("LessThan", PBrickOpCode.opCPLTF);
			PBrickStreamBuilder._opCodeMap8.Add("LessThanOrEqualTo", PBrickOpCode.opCPLTEQ8);
			PBrickStreamBuilder._opCodeMap16.Add("LessThanOrEqualTo", PBrickOpCode.opCPLTEQ16);
			PBrickStreamBuilder._opCodeMap32.Add("LessThanOrEqualTo", PBrickOpCode.opCPLTEQ32);
			PBrickStreamBuilder._opCodeMapF.Add("LessThanOrEqualTo", PBrickOpCode.opCPLTEQF);
			PBrickStreamBuilder._opCodeMap8.Add("NotEqualTo", PBrickOpCode.opCPNEQ8);
			PBrickStreamBuilder._opCodeMap16.Add("NotEqualTo", PBrickOpCode.opCPNEQ16);
			PBrickStreamBuilder._opCodeMap32.Add("NotEqualTo", PBrickOpCode.opCPNEQ32);
			PBrickStreamBuilder._opCodeMapF.Add("NotEqualTo", PBrickOpCode.opCPNEQF);
			PBrickStreamBuilder._opCodeMisc.Add("CodeEnd", PBrickOpCode.opOBJECTEND);
			PBrickStreamBuilder._opCodeMisc.Add("Return", PBrickOpCode.opRETURN);
			PBrickStreamBuilder._opCodeMisc.Add("Call", PBrickOpCode.opCALL);
			PBrickStreamBuilder._opCodeMisc.Add("Jump", PBrickOpCode.opJR);
			PBrickStreamBuilder._opCodeMisc.Add("PbrInputRead", PBrickOpCode.opINPUTREAD);
			PBrickStreamBuilder._opCodeMisc.Add("PbrUIWrite", PBrickOpCode.opUIWRITE);
			PBrickStreamBuilder._opCodeMisc.Add("PbrUIFlush", PBrickOpCode.opUIFLUSH);
			PBrickStreamBuilder._opCodeMisc.Add("PbrOutput_Power", PBrickOpCode.opOUTPUTPOWER);
			PBrickStreamBuilder._opCodeMisc.Add("PbrTimerWait", PBrickOpCode.opTIMERWAIT);
			PBrickStreamBuilder._opCodeMisc.Add("PbrTimerReady", PBrickOpCode.opTIMERREADY);
			PBrickStreamBuilder._opCodeMisc.Add("Sine", PBrickOpCode.opMathSin);
			PBrickStreamBuilder._opCodeMisc.Add("Cosine", PBrickOpCode.opMathCos);
			PBrickStreamBuilder._opCodeMisc.Add("Tangent", PBrickOpCode.opMathTan);
			PBrickStreamBuilder._opCodeMisc.Add("InverseSine", PBrickOpCode.opMathASin);
			PBrickStreamBuilder._opCodeMisc.Add("InverseCosine", PBrickOpCode.opMathACos);
			PBrickStreamBuilder._opCodeMisc.Add("InverseTangent", PBrickOpCode.opMathATan);
			PBrickStreamBuilder._opCodeMisc.Add("Ln", PBrickOpCode.opMathLn);
			PBrickStreamBuilder._opCodeMisc.Add("Log", PBrickOpCode.opMathLog);
			PBrickStreamBuilder._opCodeMisc.Add("StringConcatenate", PBrickOpCode.opSTRING);
			PBrickStreamBuilder._opCodeMisc.Add("ToString", PBrickOpCode.opStringValueToString);
			PBrickStreamBuilder._opCodeMisc.Add("ArrayInsertElement", PBrickOpCode.opARRAYWRITE);
			PBrickStreamBuilder._opCodeMisc.Add("ArrayBuild", PBrickOpCode.opArrayAppend);
			PBrickStreamBuilder._opCodeMisc.Add("ArrayIndex", PBrickOpCode.opARRAYREAD);
			PBrickStreamBuilder._opCodeMisc.Add("ArraySize", PBrickOpCode.opArraySize);
			PBrickStreamBuilder._opCodeMisc.Add("ObjectTrigger", PBrickOpCode.opOBJECTTRIG);
			PBrickStreamBuilder._opCodeMisc.Add("ObjectWait", PBrickOpCode.opOBJECTWAIT);
			PBrickStreamBuilder._conditionCodeNameMap.Add(ConditionCode.EqualTo, "EqualTo");
			PBrickStreamBuilder._conditionCodeNameMap.Add(ConditionCode.GreaterThan, "GreaterThan");
			PBrickStreamBuilder._conditionCodeNameMap.Add(ConditionCode.GreaterThanOrEqualTo, "GreaterThanOrEqualTo");
			PBrickStreamBuilder._conditionCodeNameMap.Add(ConditionCode.LessThan, "LessThan");
			PBrickStreamBuilder._conditionCodeNameMap.Add(ConditionCode.LessThanOrEqualTo, "LessThanOrEqualTo");
			PBrickStreamBuilder._conditionCodeNameMap.Add(ConditionCode.NotEqualTo, "NotEqualTo");
			PBrickStreamBuilder._specialSizedInstructions.Add(PBrickOpCode.opOBJECTEND);
			PBrickStreamBuilder._specialSizedInstructions.Add(PBrickOpCode.opRETURN);
		}
		[SuppressMessage("Microsoft.Performance", "CA1822:MarkMembersAsStatic", Justification = "TODO"), SuppressMessage("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily", Justification = "TODO")]
		public PBrickOpCode NamedOpToOpCode(Instruction instruction)
		{
			if (instruction is PBRDirectCodeInstruction)
			{
				return (instruction as PBRDirectCodeInstruction).OpCode;
			}
			PBrickOpCode result;
			if (PBrickStreamBuilder._opCodeMisc.TryGetValue(instruction.OpName, ref result))
				{
				return result;
				}
					string text;
					DataBuilder dataBuilder;
					if (instruction is ConditionalBranchInstruction)
					{
						ConditionalBranchInstruction conditionalBranchInstruction = instruction as ConditionalBranchInstruction;
						text = instruction.OpName;
						dataBuilder = conditionalBranchInstruction.CompareOperand1;
						if (text == "TestAndJump")
						{
							if (conditionalBranchInstruction.ConditionCode == ConditionCode.NotEqualTo)
							{
						return PBrickOpCode.opJRTRUE;
							}
					return PBrickOpCode.opJRFALSE;
						}
					}
					else
					{
						if (instruction is CompareInstruction)
						{
							CompareInstruction compareInstruction = instruction as CompareInstruction;
					text = PBrickStreamBuilder._conditionCodeNameMap.get_Item(compareInstruction.ConditionCode);
							dataBuilder = compareInstruction.Operand2;
						}
						else
						{
							if (instruction.OpName == "Move")
							{
								object[] args = instruction.GetArgs();
								if (((DataBuilder)args[0]).IsArray)
								{
							return PBrickOpCode.opArrayCopy;
								}
								TypeCode typeCode = ((DataBuilder)args[1]).BuilderType.TypeCode;
						PBrickStreamBuilder.MoveInstructionTypes moveInstructionTypes = PBrickStreamBuilder._clsTypeToMoveInstructionType.get_Item(typeCode);
								typeCode = ((DataBuilder)args[0]).BuilderType.TypeCode;
						PBrickStreamBuilder.MoveInstructionTypes moveInstructionTypes2 = PBrickStreamBuilder._clsTypeToMoveInstructionType.get_Item(typeCode);
						return PBrickStreamBuilder._opCodeMapMoves[(int)moveInstructionTypes, (int)moveInstructionTypes2];
							}
							else
							{
								text = instruction.OpName;
								dataBuilder = (DataBuilder)instruction.GetArgs()[0];
								LogicException.Assert(dataBuilder.BuilderType == ((DataBuilder)instruction.GetArgs()[1]).BuilderType, "No Polymorphism for you!");
							}
						}
					}
					IDataType builderType = dataBuilder.BuilderType;
			Dictionary<string, PBrickOpCode> dictionary = PBrickStreamBuilder._mapMap.get_Item(builderType.TypeCode);
			result = dictionary.get_Item(text);
			return result;
		}
		[SuppressMessage("Microsoft.Reliability", "CA2000:Dispose objects before losing scope", Justification = "TODO"), SuppressMessage("Microsoft.Maintainability", "CA1505:AvoidUnmaintainableCode", Justification = "TODO"), SuppressMessage("Microsoft.Maintainability", "CA1506:AvoidExcessiveClassCoupling", Justification = "TODO"), SuppressMessage("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity", Justification = "TODO")]
		public byte[] GenerateBytes()
		{
			int num = 0;
			this._uncertainOfSomeInstructionSizes = true;
			List<Instruction> list = new List<Instruction>();
			List<Instruction> list2 = new List<Instruction>();
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator enumerator = this._module.ViBuilders.get_Values().GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					ViBuilder current = enumerator.get_Current();
					Dictionary<int, ClumpBuilder> clumps = Enumerable.ToDictionary<KeyValuePair<int, ClumpBuilder>, int, ClumpBuilder>(Enumerable.Select<IGrouping<ClumpBuilder, KeyValuePair<int, ClumpBuilder>>, KeyValuePair<int, ClumpBuilder>>(Enumerable.GroupBy<KeyValuePair<int, ClumpBuilder>, ClumpBuilder>(current.Clumps, (KeyValuePair<int, ClumpBuilder> pair) => pair.get_Value()), (IGrouping<ClumpBuilder, KeyValuePair<int, ClumpBuilder>> group) => Enumerable.First<KeyValuePair<int, ClumpBuilder>>(group)), (KeyValuePair<int, ClumpBuilder> pair) => pair.get_Key(), (KeyValuePair<int, ClumpBuilder> pair) => pair.get_Value());
					current.Clumps = clumps;
					if (current.IsReentrant)
					{
						num += current.ReentrantCallerAdditionalHeaderCount;
					}
					num += current.Clumps.get_Count();
				}
			}
			List<object> list3 = new List<object>();
			list3.Add(0);
			list3.Add(15);
			PBRDirectCodeInstruction pBRDirectCodeInstruction = new PBRDirectCodeInstruction(PBrickOpCode.opOUTPUTRESET, list3);
			list.Add(pBRDirectCodeInstruction);
			list3 = new List<object>();
			list3.Add(-1);
			PBRDirectCodeInstruction pBRDirectCodeInstruction2 = new PBRDirectCodeInstruction(PBrickOpCode.opInputDeviceClrAll, list3);
			list.Add(pBRDirectCodeInstruction2);
			int num2 = 0;
			using (List<Tuple<string, IDataType>>.Enumerator enumerator2 = this._mailboxNames.GetEnumerator())
			{
				while (enumerator2.MoveNext())
				{
					Tuple<string, IDataType> current2 = enumerator2.get_Current();
					list3 = new List<object>();
					DataBuilder dataBuilder = this._module.DefineConstant(BuiltinDataType.Byte, (double)num2);
					list3.Add(dataBuilder);
					DataBuilder dataBuilder2 = this._module.DefineGlobal(BuiltinDataType.String, current2.get_Item1());
					list3.Add(dataBuilder2);
					int num3 = 0;
					if (current2.get_Item2() == BuiltinDataType.Single)
					{
						num3 = 3;
					}
					else
					{
						if (current2.get_Item2() == BuiltinDataType.String)
						{
							num3 = 4;
						}
					}
					DataBuilder dataBuilder3 = this._module.DefineConstant(BuiltinDataType.Byte, (double)num3);
					list3.Add(dataBuilder3);
					DataBuilder dataBuilder4 = this._module.DefineConstant(BuiltinDataType.Byte, 1.0);
					list3.Add(dataBuilder4);
					DataBuilder dataBuilder5 = this._module.DefineConstant(BuiltinDataType.Byte, 1.0);
					list3.Add(dataBuilder5);
					PBRDirectCodeInstruction pBRDirectCodeInstruction3 = new PBRDirectCodeInstruction(PBrickOpCode.opMailboxOpen, list3);
					list2.Add(pBRDirectCodeInstruction3);
					num2++;
				}
			}
			int num4 = 0;
			this._module.Globals.Sort(DataBuilderExtensions.PBRDataBuilderComparer());
			using (List<DataBuilder>.Enumerator enumerator3 = this._module.Globals.GetEnumerator())
			{
				while (enumerator3.MoveNext())
				{
					DataBuilder current3 = enumerator3.get_Current();
					if (current3.BuilderType.CompiledType != typeof(RXEMutex))
					{
						if (current3.BuilderType.TypeCode == 14)
						{
							throw new NotSupportedException("PBrick does not support 64 bit floating point numbers.");
						}
						if (current3.Value == null)
						{
							current3.SetTargetOffset(num4, 0);
							num4 += current3.GetPBRStaticSizeInRam(num4);
						}
						if (current3.BuilderType.Equals(BuiltinDataType.String))
						{
							current3.SetTargetOffset(num4, 0);
							num4 += 2;
							List<object> list4 = new List<object>();
							int num5 = 1;
							if (current3.Value != null)
							{
								num5 = ((string)current3.Value).get_Length();
							}
							list4.Add(1);
							list4.Add(num5);
							list4.Add(current3);
							PBRDirectCodeInstruction pBRDirectCodeInstruction4 = new PBRDirectCodeInstruction(PBrickOpCode.opARRAY, list4);
							list.Add(pBRDirectCodeInstruction4);
							if (current3.Value != null)
							{
								list4 = new List<object>();
								list4.Add(5);
								list4.Add(current3.Value);
								list4.Add(current3);
								pBRDirectCodeInstruction4 = new PBRDirectCodeInstruction(PBrickOpCode.opSTRING, list4);
								list.Add(pBRDirectCodeInstruction4);
							}
						}
						else
						{
							if (current3.IsArray)
							{
								current3.SetTargetOffset(num4, 0);
								num4 += 2;
								List<object> list5 = new List<object>();
								ArrayCommand arrayCommand = this.ArrayCreateCommandFromType(current3.BuilderType);
								list5.Add((byte)arrayCommand);
								if (!(current3.Value is Array))
								{
									list5.Add(0);
									list5.Add(current3);
									PBRDirectCodeInstruction pBRDirectCodeInstruction5 = new PBRDirectCodeInstruction(PBrickOpCode.opARRAY, list5);
									list.Add(pBRDirectCodeInstruction5);
								}
								else
								{
									list5.Add((current3.Value as Array).get_Length());
									list5.Add(current3);
									PBRDirectCodeInstruction pBRDirectCodeInstruction6 = new PBRDirectCodeInstruction(PBrickOpCode.opARRAY, list5);
									list.Add(pBRDirectCodeInstruction6);
									list5 = new List<object>();
									arrayCommand = this.ArrayInitCommandFromType(current3.BuilderType);
									list5.Add((byte)arrayCommand);
									list5.Add(current3);
									list5.Add(0);
									list5.Add((current3.Value as Array).get_Length());
									list5.Add(current3.Value);
									pBRDirectCodeInstruction6 = new PBRDirectCodeInstruction(PBrickOpCode.opARRAY, list5);
									list.Add(pBRDirectCodeInstruction6);
								}
							}
							else
							{
								if (current3.Value != null)
								{
									if (current3.StorageClass != StorageClass.Constant && current3.BuilderType.CompiledType != typeof(RXEMutex))
									{
										throw new InvalidStateException("Invalid PBR global");
									}
									current3.SetTargetOffset(-1, 0);
								}
							}
						}
					}
				}
			}
			list = Enumerable.ToList<Instruction>(Enumerable.Concat<Instruction>(list, list2));
			ByteCodeGenerator codeGenerator = Enumerable.First<ClumpBuilder>(Enumerable.First<ViBuilder>(this._module.ViBuilders.get_Values()).Clumps.get_Values()).CodeGenerator;
			using (List<Label>.Enumerator enumerator4 = codeGenerator.Labels.GetEnumerator())
			{
				while (enumerator4.MoveNext())
				{
					Label current4 = enumerator4.get_Current();
					current4.TargetInstructionIndex += list.get_Count();
				}
			}
			codeGenerator.Instructions = Enumerable.ToList<Instruction>(Enumerable.Concat<Instruction>(list, codeGenerator.Instructions));
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator enumerator5 = this._module.ViBuilders.get_Values().GetEnumerator())
			{
				while (enumerator5.MoveNext())
				{
					ViBuilder current5 = enumerator5.get_Current();
					list = new List<Instruction>();
					List<Instruction> list6 = new List<Instruction>();
					using (IEnumerator<DataBuilder> enumerator6 = current5.GetNonParameterLocals().GetEnumerator())
					{
						while (enumerator6.MoveNext())
						{
							DataBuilder current6 = enumerator6.get_Current();
							if (current6.IsArray)
							{
								List<object> list7 = new List<object>();
								if (current6.BuilderType.Equals(BuiltinDataType.String))
								{
									list7.Add(1);
								}
								else
								{
									ArrayCommand arrayCommand2 = this.ArrayCreateCommandFromType(current6.BuilderType);
									list7.Add((byte)arrayCommand2);
								}
								list7.Add(1);
								list7.Add(current6);
								PBRDirectCodeInstruction pBRDirectCodeInstruction7 = new PBRDirectCodeInstruction(PBrickOpCode.opARRAY, list7);
								list.Add(pBRDirectCodeInstruction7);
								list7 = new List<object>();
								list7.Add(current6);
								pBRDirectCodeInstruction7 = new PBRDirectCodeInstruction(PBrickOpCode.opArrayDelete, list7);
								list6.Add(pBRDirectCodeInstruction7);
							}
						}
					}
					using (List<Label>.Enumerator enumerator7 = current5.RootClump.CodeGenerator.Labels.GetEnumerator())
					{
						while (enumerator7.MoveNext())
						{
							Label current7 = enumerator7.get_Current();
							current7.TargetInstructionIndex += list.get_Count();
						}
					}
					current5.RootClump.CodeGenerator.Instructions = Enumerable.ToList<Instruction>(Enumerable.Concat<Instruction>(list, current5.RootClump.CodeGenerator.Instructions));
					List<Instruction> instructions = current5.RootClump.CodeGenerator.Instructions;
					int num6 = instructions.get_Count() - 1;
					instructions.InsertRange(num6, list6);
				}
			}
			this.CalculateLocalOffests();
			MemoryStream memoryStream = new MemoryStream();
			BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
			while (this._uncertainOfSomeInstructionSizes)
			{
				this._uncertainOfSomeInstructionSizes = false;
				int num7 = (int)binaryWriter.get_BaseStream().get_Position();
				if (num7 <= 0)
				{
					this._uncertainOfSomeInstructionSizes = true;
				}
				memoryStream = new MemoryStream();
				binaryWriter = new BinaryWriter(memoryStream);
				this.WriteImageHeader(binaryWriter, num, num4, num7);
				this.WriteObjectHeaders(binaryWriter);
				this.WriteCodeSection(binaryWriter);
			}
			binaryWriter.Seek(0, 0);
			return memoryStream.ToArray();
		}
		[SuppressMessage("Microsoft.Performance", "CA1822:MarkMembersAsStatic", Justification = "TODO")]
		private ArrayCommand ArrayInitCommandFromType(IDataType dataType)
		{
			if (dataType == BuiltinDataType.ByteArray1D || dataType == BuiltinDataType.SByteArray1D || dataType == BuiltinDataType.BooleanArray1D)
			{
				return ArrayCommand.Init8;
			}
				if (dataType == BuiltinDataType.Int16Array1D || dataType == BuiltinDataType.UInt16Array1D)
				{
				return ArrayCommand.Init16;
				}
					if (dataType == BuiltinDataType.Int32Array1D || dataType == BuiltinDataType.UInt32Array1D)
					{
				return ArrayCommand.Init32;
					}
			if (dataType == BuiltinDataType.SingleArray1D)
					{
				return ArrayCommand.InitF;
			}
			throw new NotImplementedException("Unsupported array type: " + dataType);
		}
		[SuppressMessage("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily", Justification = "TODO"), SuppressMessage("Microsoft.Performance", "CA1822:MarkMembersAsStatic", Justification = "TODO")]
		private ArrayCommand ArrayCreateCommandFromType(IDataType dataType)
		{
			if (dataType == BuiltinDataType.ByteArray1D || dataType == BuiltinDataType.SByteArray1D || dataType == BuiltinDataType.BooleanArray1D)
			{
				return ArrayCommand.Create8;
			}
				if (dataType == BuiltinDataType.Int16Array1D || dataType == BuiltinDataType.UInt16Array1D)
				{
				return ArrayCommand.Create16;
				}
					if (dataType == BuiltinDataType.Int32Array1D || dataType == BuiltinDataType.UInt32Array1D)
					{
				return ArrayCommand.Create32;
					}
			if (dataType == BuiltinDataType.SingleArray1D)
					{
				return ArrayCommand.CreateF;
						}
			throw new NotImplementedException("Unsupported array type: " + dataType);
		}
		[SuppressMessage("Microsoft.Performance", "CA1822:MarkMembersAsStatic", Justification = "TODO")]
		private void WriteImageHeader(BinaryWriter stream, int totalClumps, int totalBytes, int fileSize)
		{
			UTF8Encoding uTF8Encoding = new UTF8Encoding();
			byte[] bytes = uTF8Encoding.GetBytes("LEGO");
			stream.Write(bytes, 0, 4);
			stream.Write(fileSize);
			stream.Write(57);
			stream.Write((short)totalClumps);
			stream.Write(totalBytes);
		}
		private void CalculateLocalOffests()
		{
			int num = 1;
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator enumerator = this._module.ViBuilders.get_Values().GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					ViBuilder current = enumerator.get_Current();
					current.Locals.Sort(DataBuilderExtensions.PBRDataBuilderComparer());
					List<DataBuilder> locals = current.Locals;
					current.Locals = new List<DataBuilder>();
					current.Parameters.Sort(Parameter.ParameterComparer(true));
					using (List<Parameter>.Enumerator enumerator2 = current.Parameters.GetEnumerator())
					{
						while (enumerator2.MoveNext())
						{
							Parameter current2 = enumerator2.get_Current();
							current.Locals.Add(current2.DataBuilder);
							locals.Remove(current2.DataBuilder);
						}
					}
					current.Locals.AddRange(locals);
					int num2 = 0;
					using (List<DataBuilder>.Enumerator enumerator3 = current.Locals.GetEnumerator())
					{
						while (enumerator3.MoveNext())
						{
							DataBuilder current3 = enumerator3.get_Current();
							LogicException.Assert(current3.BuilderType.TypeCode != 14, "Doubles should have been removed at the DefineLocal level.  Something went wrong to arrive here");
							int pBRStaticSizeInRam = current3.GetPBRStaticSizeInRam(num2);
							num2 = ((num2 % pBRStaticSizeInRam == 0) ? num2 : (num2 + (pBRStaticSizeInRam - num2 % pBRStaticSizeInRam)));
							current3.SetTargetOffset(num2, num);
							num2 += current3.GetPBRStaticSizeInRam(num2);
						}
					}
					num++;
					this._viLocalByteCount.Add(current, num2);
				}
			}
		}
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
		[SuppressMessage("Microsoft.Performance", "CA1822:MarkMembersAsStatic", Justification = "TODO")]
		private bool DoesInstructionUseHandleEncoding(Instruction instruction)
		{
			PBRDirectCodeInstruction pBRDirectCodeInstruction = instruction as PBRDirectCodeInstruction;
			bool result;
			if (pBRDirectCodeInstruction == null)
			{
				string opName;
				result = ((opName = instruction.OpName) != null && (opName == "PbrUIWrite" || opName == "ToString"));
			}
			else
			{
				PBrickOpCode opCode = pBRDirectCodeInstruction.OpCode;
				if (opCode <= PBrickOpCode.opStringValueToString)
				{
					if (opCode <= PBrickOpCode.opInputSample)
					{
						if (opCode <= PBrickOpCode.opSTRING)
						{
							if (opCode != PBrickOpCode.opNoteToFrequency && opCode != PBrickOpCode.opSTRING)
							{
								goto IL_1C4;
							}
						}
						else
						{
							if (opCode != PBrickOpCode.opUIDRAW && opCode != PBrickOpCode.opInputSample)
						{
								goto IL_1C4;
							}
						}
					}
					else
					{
						if (opCode <= PBrickOpCode.opFILE)
						{
							if (opCode != PBrickOpCode.opINPUTWRITE)
							{
								if (opCode != PBrickOpCode.opFILE)
								{
									goto IL_1C4;
								}
								throw new NotSupportedException("Do not use opFILE.  Use the specific command");
							}
						}
						else
						{
							switch (opCode)
							{
							case PBrickOpCode.opComTest:
							case PBrickOpCode.opMailboxOpen:
							case PBrickOpCode.opMailboxWrite:
							case PBrickOpCode.opMailboxRead:
								break;
							case (PBrickOpCode)214:
							case (PBrickOpCode)215:
								goto IL_1C4;
							default:
								switch (opCode)
								{
						  case PBrickOpCode.opStringGetSize:
							case PBrickOpCode.opStringConcat:
								break;
							default:
									if (opCode != PBrickOpCode.opStringValueToString)
									{
										goto IL_1C4;
									}
									break;
								}
								break;
							}
						}
					}
				}
				else
				{
					if (opCode <= PBrickOpCode.opInputDeviceGetModeName)
					{
						if (opCode <= PBrickOpCode.opSoundRepeat)
						{
							if (opCode != PBrickOpCode.opUIDrawBmpFile)
						{
								switch (opCode)
							{
								case PBrickOpCode.opSoundPlayFile:
								case PBrickOpCode.opSoundRepeat:
									break;
								default:
									goto IL_1C4;
								}
							}
						}
						else
						{
							if (opCode != PBrickOpCode.opInputDeviceSetup)
							{
							switch (opCode)
							{
							case PBrickOpCode.opInputDeviceGetName:
							case PBrickOpCode.opInputDeviceGetModeName:
								break;
							default:
									goto IL_1C4;
								}
							}
						}
					}
					else
					{
						if (opCode <= PBrickOpCode.opFileCloseLog)
						{
							switch (opCode)
							{
							case PBrickOpCode.opFileOpenAppend:
							case PBrickOpCode.opFileOpenRead:
							case PBrickOpCode.opFileOpenWrite:
							case PBrickOpCode.opFileReadText:
							case PBrickOpCode.opFileWriteText:
							case PBrickOpCode.opFileGetHandle:
								break;
							case PBrickOpCode.opFileReadValue:
							case PBrickOpCode.opFileWriteValue:
							case PBrickOpCode.opFileClose:
							case PBrickOpCode.opFileLoadImage:
								goto IL_1C4;
							default:
								switch (opCode)
								{
							case PBrickOpCode.opFileWriteLog:
									goto IL_1C4;
								case PBrickOpCode.opFileCloseLog:
									break;
							default:
									goto IL_1C4;
								}
								break;
							}
						}
						else
						{
							if (opCode != PBrickOpCode.opFileOpenLog && opCode != PBrickOpCode.opFileRemove && opCode != PBrickOpCode.opComSetConnection)
							{
								goto IL_1C4;
							}
						}
					}
				}
				result = true;
				return result;
				IL_1C4:
				result = false;
			}
			return result;
		}
		private static void WriteObjectHeader(BinaryWriter stream, ViBuilder viBuilder, int localBytes, ClumpBuilder clump)
		{
			Instruction instruction = clump.CodeGenerator.Instructions.get_Item(0);
			int num = (viBuilder.IsSubVI && clump == viBuilder.RootClump) ? (instruction.TargetAddress - (1 + viBuilder.Parameters.get_Count())) : instruction.TargetAddress;
			stream.Write(num);
			stream.Write((ushort)((clump == viBuilder.RootClump) ? 0 : viBuilder.RootClump.Index));
			stream.Write(clump.FireCount);
			stream.Write(localBytes);
		}
		[SuppressMessage("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily", Justification = "TODO"), SuppressMessage("Microsoft.Usage", "CA1801:ReviewUnusedParameters", MessageId = "totalCodeSize", Justification = "TODO")]
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
		private void WritePBRDirectCodeInstruction(BinaryWriter stream, PBRDirectCodeInstruction instruction)
		{
			object[] args = instruction.GetArgs();
			stream.WriteOpCode(instruction.OpCode);
			if (instruction.OpCode == PBrickOpCode.opFileWriteLog)
			{
				for (int i = 0; i < 4; i++)
				{
					this.WriteArgument(stream, args[i], i == 3);
				}
				return;
			}
				object[] array = args;
				for (int j = 0; j < array.Length; j++)
				{
					object argument = array[j];
					this.WriteArgument(stream, argument, this.DoesInstructionUseHandleEncoding(instruction));
				}
			}
		[SuppressMessage("Microsoft.Performance", "CA1822:MarkMembersAsStatic", Justification = "TODO")]
		private void WriteSubCallParamHeaderInfo(BinaryWriter stream, ViBuilder viBuilder)
		{
			stream.Write((byte)viBuilder.Parameters.get_Count());
			using (List<Parameter>.Enumerator enumerator = viBuilder.Parameters.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					Parameter current = enumerator.get_Current();
					byte b = 0;
					if (current.IsInput || current.DataBuilder.IsArray)
					{
						b = 128;
					}
					if (current.IsOutput)
					{
						b |= 64;
					}
					switch (current.DataBuilder.GetPBRStaticSizeInRam(0))
					{
					case 2:
						b |= 1;
						break;
					case 4:
						b |= 2;
						break;
					}
					if (current.DataBuilder.BuilderType.TypeCode == 13)
					{
						b |= 1;
					}
					stream.Write(b);
				}
			}
		}
		private void WriteClumpInstruction(BinaryWriter stream, ClumpInstruction clumpInstruction)
		{
			PBrickOpCode opCode = this.NamedOpToOpCode(clumpInstruction);
			stream.WriteOpCode(opCode);
			this.WriteArgument(stream, clumpInstruction.Clump.Index, this.DoesInstructionUseHandleEncoding(clumpInstruction));
		}
		private void WriteCodeEndInstruction(BinaryWriter stream, CodeEndInstruction codeEndInstruction)
		{
			PBrickOpCode pBrickOpCode = this.NamedOpToOpCode(codeEndInstruction);
			stream.WriteOpCode(pBrickOpCode);
			if (pBrickOpCode == PBrickOpCode.opRETURN)
			{
				stream.Write(10);
			}
		}
		private void WriteInstruction(BinaryWriter stream, Instruction instruction)
		{
			PBrickOpCode pBrickOpCode = this.NamedOpToOpCode(instruction);
			List<object> list = Enumerable.ToList<object>(instruction.GetArgs());
			object obj = Enumerable.ElementAt<object>(list, 0);
			list.RemoveAt(0);
			list.Add(obj);
			stream.WriteOpCode(pBrickOpCode);
			if (pBrickOpCode != PBrickOpCode.opRETURN)
			{
				using (List<object>.Enumerator enumerator = list.GetEnumerator())
				{
					while (enumerator.MoveNext())
					{
						object current = enumerator.get_Current();
						this.WriteArgument(stream, current, this.DoesInstructionUseHandleEncoding(instruction));
					}
				}
			}
		}
		private void WriteCompareInstruction(BinaryWriter stream, CompareInstruction instruction)
		{
			List<object> list = new List<object>();
			PBrickOpCode opCode = this.NamedOpToOpCode(instruction);
			object[] args = instruction.GetArgs();
			for (int i = 0; i < args.Length; i++)
			{
				object obj = args[i];
				if (obj is DataBuilder)
				{
					list.Add(obj);
				}
			}
			stream.WriteOpCode(opCode);
			if (list.get_Count() == 3)
			{
				object obj2 = list.get_Item(1);
				list.set_Item(1, list.get_Item(2));
				list.set_Item(2, obj2);
			}
			list.Reverse();
			using (List<object>.Enumerator enumerator = list.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					object current = enumerator.get_Current();
					this.WriteArgument(stream, current, this.DoesInstructionUseHandleEncoding(instruction));
				}
			}
		}
		private void WriteBranchInstruction(BinaryWriter stream, BranchInstruction instruction)
		{
			PBrickOpCode opCode = this.NamedOpToOpCode(instruction);
			stream.WriteOpCode(opCode);
			this.WriteArgument(stream, instruction.Label, this.DoesInstructionUseHandleEncoding(instruction));
		}
		private void WriteConditionalBranchInstruction(BinaryWriter stream, ConditionalBranchInstruction instruction)
		{
			PBrickOpCode opCode = this.NamedOpToOpCode(instruction);
			stream.WriteOpCode(opCode);
			this.WriteArgument(stream, instruction.CompareOperand1, this.DoesInstructionUseHandleEncoding(instruction));
			if (instruction.CompareOperand2 != null)
			{
				this.WriteArgument(stream, instruction.CompareOperand2, this.DoesInstructionUseHandleEncoding(instruction));
			}
			this.WriteArgument(stream, instruction.Label, this.DoesInstructionUseHandleEncoding(instruction));
		}
		private void WriteCallInstruction(BinaryWriter stream, CallInstruction instruction)
		{
			PBrickOpCode opCode = this.NamedOpToOpCode(instruction);
			stream.WriteOpCode(opCode);
			this.WriteArgument(stream, (int)((short)instruction.VI.RootClump.Index) + instruction.ReentrantIndex, this.DoesInstructionUseHandleEncoding(instruction));
			stream.Write((byte)instruction.Arguments.get_Count());
			List<Parameter> parameters = instruction.VI.Parameters;
			IEnumerator<Parameter> DestParamIter = parameters.GetEnumerator();
			while (DestParamIter.MoveNext())
			{
				Parameter parameter = Enumerable.Single<Parameter>(Enumerable.Where<Parameter>(instruction.Arguments, (Parameter p) => p.ConnectorIndex == DestParamIter.get_Current().ConnectorIndex && p.IsInput == DestParamIter.get_Current().IsInput));
				if (parameter.DataBuilder != null)
				{
					this.WriteArgument(stream, parameter.DataBuilder, this.DoesInstructionUseHandleEncoding(instruction));
				}
				else
				{
					if (DestParamIter.get_Current().DataBuilder.Value == null)
					{
						if (DestParamIter.get_Current().DBType.TypeCode == 18)
						{
							throw new NotImplementedException("Unwired string inputs with no default value are not currently supported.");
						}
						this.WriteArgument(stream, 0, false);
					}
					this.WriteArgument(stream, DestParamIter.get_Current().DataBuilder.Value, this.DoesInstructionUseHandleEncoding(instruction));
				}
			}
		}
		private void WriteDataBuilderArgument(BinaryWriter stream, DataBuilder db, bool instructionUsesHandleEncoding)
		{
			if (db.StorageClass != StorageClass.Constant)
			{
				stream.WriteIntArgument(db.TargetOffset, this._module.Globals.Contains(db) ? ArgType.GlobalOffset : ArgType.LocalOffset, db.IsArray && instructionUsesHandleEncoding);
				return;
			}
				if (db.Value is float || db.Value is float)
				{
				stream.WriteFloatArgument(Convert.ToSingle(db.Value, CultureInfo.get_InvariantCulture()));
				return;
				}
					stream.WriteIntArgument(db.IntValue, ArgType.Integer, false);
				}
		[SuppressMessage("Microsoft.Maintainability", "CA1502:AvoidExcessiveComplexity", Justification = "TODO"), SuppressMessage("Microsoft.Performance", "CA1800:DoNotCastUnnecessarily", Justification = "TODO")]
		private void WriteArgument(BinaryWriter stream, object argument, bool instructionUsesHandleEncoding)
		{
			if (argument is DataBuilder)
			{
				this.WriteDataBuilderArgument(stream, argument as DataBuilder, instructionUsesHandleEncoding);
				return;
			}
				if (argument is Label)
				{
					this.WritelabelArgument(stream, argument as Label);
				return;
				}
					if (argument is ushort || argument is int || argument is short || argument is byte || argument is sbyte)
					{
				int argument2 = Convert.ToInt32(argument, CultureInfo.get_InvariantCulture());
						stream.WriteIntArgument(argument2, ArgType.Integer, false);
				return;
					}
			if (argument == null)
						{
				return;
			}
							if (argument is float)
							{
				stream.WriteFloatArgument(Convert.ToSingle(argument, CultureInfo.get_InvariantCulture()));
				return;
							}
								if (argument is string)
								{
									stream.WriteStringArgument(argument as string);
				return;
								}
									if (argument is Array)
									{
										if (argument is bool[])
										{
											bool[] array = argument as bool[];
											for (int i = 0; i < array.Length; i++)
											{
												stream.WriteIntArgument(array[i] ? 1 : 0, ArgType.Integer);
											}
										}
										if (argument is byte[] || argument is sbyte[])
										{
											byte[] array2 = argument as byte[];
					for (int j = 0; j < array2.Length; j++)
											{
						byte argument3 = array2[j];
												stream.WriteIntArgument((int)argument3, ArgType.Integer);
											}
					return;
										}
											if (argument is short[] || argument is ushort[])
											{
												short[] array3 = argument as short[];
					for (int k = 0; k < array3.Length; k++)
												{
						short argument4 = array3[k];
													stream.WriteIntArgument((int)argument4, ArgType.Integer);
												}
					return;
											}
												if (argument is int[] || argument is uint[])
												{
													int[] array4 = argument as int[];
					for (int l = 0; l < array4.Length; l++)
													{
						int argument5 = array4[l];
														stream.WriteIntArgument(argument5, ArgType.Integer);
													}
					return;
												}
													if (argument is float[])
													{
														float[] array5 = argument as float[];
					for (int m = 0; m < array5.Length; m++)
														{
						float value = array5[m];
															stream.WriteFloatArgument(value);
														}
					return;
										}
									}
									else
									{
										LogicException.ThrowLogicException("Unsupported argument type: " + argument.GetType().ToString());
									}
								}
		private void WritelabelArgument(BinaryWriter stream, Label label)
		{
			int num = label.TargetInstruction.TargetAddress;
			if (num < 0)
			{
				this._uncertainOfSomeInstructionSizes = true;
				num = (int)stream.get_BaseStream().get_Position();
			}
			int num2 = num - (int)stream.get_BaseStream().get_Position();
			int num3 = BinaryWriterExtensions.ArgSize(num2);
			num2 -= BinaryWriterExtensions.ArgSize(num2 - num3);
			stream.WriteIntArgument(num2, ArgType.Integer);
		}
	}
*)

end.
