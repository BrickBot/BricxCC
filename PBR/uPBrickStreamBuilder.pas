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
		private static PBrickOpCode[,] _opCodeMapMoves;
		private static readonly Dictionary<TypeCode, PBrickStreamBuilder.MoveInstructionTypes> _clsTypeToMoveInstructionType;
		private static List<PBrickOpCode> _specialSizedInstructions;

		public PBrickStreamBuilder(ModuleBuilder model, List<Tuple<string, IDataType>> mailboxNames)
		{
			this._module = model;
			this._mailboxNames = mailboxNames;
			this._viLocalByteCount = new Dictionary<ViBuilder, int>();
		}

		static PBrickStreamBuilder()
		{
			Dictionary<TypeCode, MoveInstructionTypes> dictionary = new Dictionary<TypeCode, PBrickStreamBuilder.MoveInstructionTypes>();
            dictionary.Add(TypeCode.Double, MoveInstructionTypes.Float);
            dictionary.Add(TypeCode.Single, MoveInstructionTypes.Float);
            dictionary.Add(TypeCode.Int16, MoveInstructionTypes.Sixteen);
			dictionary.Add(TypeCode.UInt16, MoveInstructionTypes.Sixteen);
			dictionary.Add(TypeCode.Int32, MoveInstructionTypes.ThirtyTwo);
			dictionary.Add(TypeCode.UInt32, MoveInstructionTypes.ThirtyTwo);
			dictionary.Add(TypeCode.SByte, MoveInstructionTypes.Eight);
			dictionary.Add(TypeCode.Byte, MoveInstructionTypes.Eight);
			dictionary.Add(TypeCode.Boolean, MoveInstructionTypes.Eight);
			dictionary.Add(TypeCode.String, MoveInstructionTypes.Sixteen);
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
			PBrickStreamBuilder._mapMap.Add(TypeCode.Byte, PBrickStreamBuilder._opCodeMap8);
			PBrickStreamBuilder._mapMap.Add(TypeCode.SByte, PBrickStreamBuilder._opCodeMap8);
			PBrickStreamBuilder._mapMap.Add(TypeCode.Boolean, PBrickStreamBuilder._opCodeMap8);
			PBrickStreamBuilder._mapMap.Add(TypeCode.Int16, PBrickStreamBuilder._opCodeMap16);
            PBrickStreamBuilder._mapMap.Add(TypeCode.UInt16, PBrickStreamBuilder._opCodeMap16);
			PBrickStreamBuilder._mapMap.Add(TypeCode.Int32, PBrickStreamBuilder._opCodeMap32);
            PBrickStreamBuilder._mapMap.Add(TypeCode.UInt32, PBrickStreamBuilder._opCodeMap32);
			PBrickStreamBuilder._mapMap.Add(TypeCode.Single, PBrickStreamBuilder._opCodeMapF);
			PBrickStreamBuilder._mapMap.Add(TypeCode.Double, PBrickStreamBuilder._opCodeMapF);
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

		public PBrickOpCode NamedOpToOpCode(Instruction instruction)
		{
			PBrickOpCode result;
			if (instruction is PBRDirectCodeInstruction)
			{
				result = (instruction as PBRDirectCodeInstruction).OpCode;
			}
			else
			{
				PBrickOpCode pBrickOpCode;
				if (PBrickStreamBuilder._opCodeMisc.TryGetValue(instruction.OpName, out pBrickOpCode))
				{
					result = pBrickOpCode;
				}
				else
				{
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
								result = PBrickOpCode.opJRTRUE;
								return result;
							}
							result = PBrickOpCode.opJRFALSE;
							return result;
						}
					}
					else
					{
						if (instruction is CompareInstruction)
						{
							CompareInstruction compareInstruction = instruction as CompareInstruction;
							text = PBrickStreamBuilder._conditionCodeNameMap[compareInstruction.ConditionCode];
							dataBuilder = compareInstruction.Operand2;
						}
						else
						{
							if (instruction.OpName == "Move")
							{
								object[] args = instruction.GetArgs();
								if (((DataBuilder)args[0]).IsArray)
								{
									result = PBrickOpCode.opArrayCopy;
									return result;
								}
								TypeCode typeCode = ((DataBuilder)args[1]).BuilderType.TypeCode;
								PBrickStreamBuilder.MoveInstructionTypes moveInstructionTypes = PBrickStreamBuilder._clsTypeToMoveInstructionType[typeCode];
								typeCode = ((DataBuilder)args[0]).BuilderType.TypeCode;
								PBrickStreamBuilder.MoveInstructionTypes moveInstructionTypes2 = PBrickStreamBuilder._clsTypeToMoveInstructionType[typeCode];
								result = PBrickStreamBuilder._opCodeMapMoves[(int)moveInstructionTypes, (int)moveInstructionTypes2];
								return result;
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
					Dictionary<string, PBrickOpCode> dictionary = PBrickStreamBuilder._mapMap[builderType.TypeCode];
					pBrickOpCode = dictionary[text];
					result = pBrickOpCode;
				}
			}
			return result;
		}

		public byte[] GenerateBytes()
		{
			int num = 0;
			this._uncertainOfSomeInstructionSizes = true;
			List<Instruction> list = new List<Instruction>();
			List<Instruction> list2 = new List<Instruction>();
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator enumerator = this._module.ViBuilders.Values.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					ViBuilder current = enumerator.Current;
					Dictionary<int, ClumpBuilder> clumps = Enumerable.ToDictionary<KeyValuePair<int, ClumpBuilder>, int, ClumpBuilder>(Enumerable.Select<IGrouping<ClumpBuilder, KeyValuePair<int, ClumpBuilder>>, KeyValuePair<int, ClumpBuilder>>(Enumerable.GroupBy<KeyValuePair<int, ClumpBuilder>, ClumpBuilder>(current.Clumps, (KeyValuePair<int, ClumpBuilder> pair) => pair.Value), (IGrouping<ClumpBuilder, KeyValuePair<int, ClumpBuilder>> group) => Enumerable.First<KeyValuePair<int, ClumpBuilder>>(group)), (KeyValuePair<int, ClumpBuilder> pair) => pair.Key, (KeyValuePair<int, ClumpBuilder> pair) => pair.Value);
					current.Clumps = clumps;
					if (current.IsReentrant)
					{
						num += current.ReentrantCallerAdditionalHeaderCount;
					}
					num += current.Clumps.Count;
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
					Tuple<string, IDataType> current2 = enumerator2.Current;
					list3 = new List<object>();
					DataBuilder dataBuilder = this._module.DefineConstant(BuiltinDataType.Byte, (double)num2);
					list3.Add(dataBuilder);
					DataBuilder dataBuilder2 = this._module.DefineGlobal(BuiltinDataType.String, current2.Item1);
					list3.Add(dataBuilder2);
					int num3 = 0;
					if (current2.Item2 == BuiltinDataType.Single)
					{
						num3 = 3;
					}
					else
					{
						if (current2.Item2 == BuiltinDataType.String)
						{
							num3 = 4;
						}
					}
					DataBuilder dataBuilder3 = this._module.DefineConstant(BuiltinDataType.Byte, (double)num3);
					list3.Add(dataBuilder3);
					DataBuilder dataBuilder4 = this._module.DefineConstant(BuiltinDataType.Byte, 0.0);
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
					DataBuilder current3 = enumerator3.Current;
					if (current3.BuilderType.CompiledType != typeof(RXEMutex))
					{
						if (current3.BuilderType.TypeCode == TypeCode.Double)
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
							int num5 = 0;
							if (current3.Value != null)
							{
								num5 = ((string)current3.Value).Length;
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
								List<object> list4 = new List<object>();
								ArrayCommand arrayCommand = this.ArrayCreateCommandFromType(current3.BuilderType);
								list4.Add((byte)arrayCommand);
								Array array = current3.Value as Array;
								if (array == null)
								{
									list4.Add(0);
									list4.Add(current3);
									PBRDirectCodeInstruction pBRDirectCodeInstruction4 = new PBRDirectCodeInstruction(PBrickOpCode.opARRAY, list4);
									list.Add(pBRDirectCodeInstruction4);
								}
								else
								{
									list4.Add((current3.Value as Array).Length);
									list4.Add(current3);
									PBRDirectCodeInstruction pBRDirectCodeInstruction4 = new PBRDirectCodeInstruction(PBrickOpCode.opARRAY, list4);
									list.Add(pBRDirectCodeInstruction4);
									list4 = new List<object>();
									arrayCommand = this.ArrayInitCommandFromType(current3.BuilderType);
									list4.Add((byte)arrayCommand);
									list4.Add(current3);
									list4.Add(0);
									list4.Add((current3.Value as Array).Length);
									list4.Add(current3.Value);
									pBRDirectCodeInstruction4 = new PBRDirectCodeInstruction(PBrickOpCode.opARRAY, list4);
									list.Add(pBRDirectCodeInstruction4);
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
			ByteCodeGenerator codeGenerator = Enumerable.First<ClumpBuilder>(Enumerable.First<ViBuilder>(this._module.ViBuilders.Values).Clumps.Values).CodeGenerator;
			using (List<Label>.Enumerator enumerator4 = codeGenerator.Labels.GetEnumerator())
			{
				while (enumerator4.MoveNext())
				{
					Label current4 = enumerator4.Current;
					current4.TargetInstructionIndex += list.Count;
				}
			}
			codeGenerator.Instructions = Enumerable.ToList<Instruction>(Enumerable.Concat<Instruction>(list, codeGenerator.Instructions));
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator enumerator = this._module.ViBuilders.Values.GetEnumerator())
			{
				while (enumerator.MoveNext())
				{
					ViBuilder current = enumerator.Current;
					list = new List<Instruction>();
					List<Instruction> list5 = new List<Instruction>();
					using (IEnumerator<DataBuilder> enumerator5 = current.GetNonParameterLocals().GetEnumerator())
					{
						while (enumerator5.MoveNext())
						{
							DataBuilder current3 = enumerator5.Current;
							if (current3.IsArray)
							{
								List<object> list4 = new List<object>();
								if (current3.BuilderType.Equals(BuiltinDataType.String))
								{
									list4.Add(1);
								}
								else
								{
									ArrayCommand arrayCommand = this.ArrayCreateCommandFromType(current3.BuilderType);
									list4.Add((byte)arrayCommand);
								}
								list4.Add(1);
								list4.Add(current3);
								PBRDirectCodeInstruction pBRDirectCodeInstruction4 = new PBRDirectCodeInstruction(PBrickOpCode.opARRAY, list4);
								list.Add(pBRDirectCodeInstruction4);
								list4 = new List<object>();
								list4.Add(current3);
								pBRDirectCodeInstruction4 = new PBRDirectCodeInstruction(PBrickOpCode.opArrayDelete, list4);
								list5.Add(pBRDirectCodeInstruction4);
							}
						}
					}
					using (List<Label>.Enumerator enumerator4 = current.RootClump.CodeGenerator.Labels.GetEnumerator())
					{
						while (enumerator4.MoveNext())
						{
							Label current4 = enumerator4.Current;
							current4.TargetInstructionIndex += list.Count;
						}
					}
					current.RootClump.CodeGenerator.Instructions = Enumerable.ToList<Instruction>(Enumerable.Concat<Instruction>(list, current.RootClump.CodeGenerator.Instructions));
					List<Instruction> instructions = current.RootClump.CodeGenerator.Instructions;
					int num6 = instructions.Count - 1;
					instructions.InsertRange(num6, list5);
				}
			}
			this.CalculateLocalOffests();
			MemoryStream memoryStream = new MemoryStream();
			BinaryWriter binaryWriter = new BinaryWriter(memoryStream);
			while (this._uncertainOfSomeInstructionSizes)
			{
				this._uncertainOfSomeInstructionSizes = false;
				int num7 = (int)binaryWriter.BaseStream.Position;
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

		private ArrayCommand ArrayInitCommandFromType(IDataType dataType)
		{
			ArrayCommand result;
			if (dataType == BuiltinDataType.ByteArray1D || dataType == BuiltinDataType.SByteArray1D || dataType == BuiltinDataType.BooleanArray1D)
			{
				result = ArrayCommand.Init8;
			}
			else
			{
				if (dataType == BuiltinDataType.Int16Array1D || dataType == BuiltinDataType.UInt16Array1D)
				{
					result = ArrayCommand.Init16;
				}
				else
				{
					if (dataType == BuiltinDataType.Int32Array1D || dataType == BuiltinDataType.UInt32Array1D)
					{
						result = ArrayCommand.Init32;
					}
					else
					{
						if (dataType != BuiltinDataType.SingleArray1D)
						{
							throw new NotImplementedException("Unsupported array type: " + dataType);
						}
						result = ArrayCommand.InitF;
					}
				}
			}
			return result;
		}

		private ArrayCommand ArrayCreateCommandFromType(IDataType dataType)
		{
			ArrayCommand result;
			if (dataType == BuiltinDataType.ByteArray1D || dataType == BuiltinDataType.SByteArray1D || dataType == BuiltinDataType.BooleanArray1D)
			{
				result = ArrayCommand.Create8;
			}
			else
			{
				if (dataType == BuiltinDataType.Int16Array1D || dataType == BuiltinDataType.UInt16Array1D)
				{
					result = ArrayCommand.Create16;
				}
				else
				{
					if (dataType == BuiltinDataType.Int32Array1D || dataType == BuiltinDataType.UInt32Array1D)
					{
						result = ArrayCommand.Create32;
					}
					else
					{
						if (dataType != BuiltinDataType.SingleArray1D)
						{
							throw new NotImplementedException("Unsupported array type: " + dataType);
						}
						result = ArrayCommand.CreateF;
					}
				}
			}
			return result;
		}

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
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator viBuilderEnum = this._module.ViBuilders.Values.GetEnumerator())
			{
				while (viBuilderEnum.MoveNext())
				{
					ViBuilder currVIB = viBuilderEnum.Current;
					currVIB.Locals.Sort(DataBuilderExtensions.PBRDataBuilderComparer());
					List<DataBuilder> locals = currVIB.Locals;
					currVIB.Locals = new List<DataBuilder>();
					List<Parameter> params = currVIB.Parameters;
					bool compareByType = true;
					params.Sort(Parameter.ParameterComparer(compareByType));
					using (List<Parameter>.Enumerator paramEnum = currVIB.Parameters.GetEnumerator())
					{
						while (paramEnum.MoveNext())
						{
							Parameter currParam = paramEnum.Current;
							currVIB.Locals.Add(currParam.DataBuilder);
							locals.Remove(currParam.DataBuilder);
						}
					}
					currVIB.Locals.AddRange(locals);
					int num2 = 0;
					using (List<DataBuilder>.Enumerator localEnum = currVIB.Locals.GetEnumerator())
					{
						while (localEnum.MoveNext())
						{
							DataBuilder currLocal = localEnum.Current;
							int pBRStaticSizeInRam = currLocal.GetPBRStaticSizeInRam(num2);
							num2 = ((num2 % pBRStaticSizeInRam == 0) ? num2 : (num2 + (pBRStaticSizeInRam - num2 % pBRStaticSizeInRam)));
							currLocal.SetTargetOffset(num2, num);
							num2 += currLocal.GetPBRStaticSizeInRam(num2);
						}
					}
					num++;
					this._viLocalByteCount.Add(currVIB, num2);
				}
			}
		}

		private void WriteObjectHeaders(BinaryWriter stream)
		{
			int num = 1;
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator viBuilderEnum = this._module.ViBuilders.Values.GetEnumerator())
			{
				while (viBuilderEnum.MoveNext())
				{
					ViBuilder currVIB = viBuilderEnum.Current;
					int localBytes = this._viLocalByteCount[currVIB];
					using (Dictionary<int, ClumpBuilder>.ValueCollection.Enumerator clumpEnum = currVIB.Clumps.Values.GetEnumerator())
					{
						while (clumpEnum.MoveNext())
						{
							ClumpBuilder currClump = clumpEnum.Current;
							PBrickStreamBuilder.WriteObjectHeader(stream, currVIB, localBytes, currClump);
							currClump.Index = num;
							if ((currClump == currVIB.RootClump) && currVIB.IsReentrant)
							{
								for (int i = 0; i < currVIB.ReentrantCallerAdditionalHeaderCount; i++)
								{
									PBrickStreamBuilder.WriteObjectHeader(stream, currVIB, localBytes, currClump);
									num++;
								}
							}
							num++;
						}
					}
				}
			}
		}
    
		private bool DoesInstructionUseHandleEncoding(Instruction instruction)
		{
			PBRDirectCodeInstruction pBRDirectCodeInstruction = instruction as PBRDirectCodeInstruction;
			if (pBRDirectCodeInstruction == null)
			{
				string opName = instruction.OpName;
				if (opName != null)
				{
					if (opName == "PbrUIWrite" || opName == "ToString")
					{
						return true;
					}
				}
			}
			else
			{
				PBrickOpCode opCode = pBRDirectCodeInstruction.OpCode;
				if (opCode <= PBrickOpCode.opStringConcat)
				{
					if (opCode <= PBrickOpCode.opInputSample)
					{
						if (opCode != PBrickOpCode.opSTRING &&
                opCode != PBrickOpCode.opUIDRAW &&
                opCode != PBrickOpCode.opInputSample)
						{
							return false;
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
									return false;
								}
								throw new NotSupportedException("Do not use opFILE.  Use the specific command");
							}
						}
						else
						{
							switch (opCode)
							{
							case PBrickOpCode.opMailboxOpen:
							case PBrickOpCode.opMailboxWrite:
						  case PBrickOpCode.opStringGetSize:
							case PBrickOpCode.opStringConcat:
								break;
							default:
								return false;
							}
						}
					}
				}
				else
				{
					if (opCode <= PBrickOpCode.opInputDeviceGetModeName)
					{
						if (opCode <= PBrickOpCode.opUIDrawBmpFile)
						{
							if (opCode != PBrickOpCode.opStringValueToString && opCode != PBrickOpCode.opUIDrawBmpFile)
							{
								return false;
							}
						}
						else
						{
							switch (opCode)
							{
							case PBrickOpCode.opSoundPlayFile:
							case PBrickOpCode.opSoundRepeat:
							case PBrickOpCode.opInputDeviceGetName:
							case PBrickOpCode.opInputDeviceGetModeName:
								break;
							default:
								return false;
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
							case PBrickOpCode.opFileCloseLog:
								break;
							case PBrickOpCode.opFileReadValue:
							case PBrickOpCode.opFileWriteValue:
							case PBrickOpCode.opFileClose:
							case PBrickOpCode.opFileLoadImage:
							case PBrickOpCode.opFileWriteLog:
								return false;
							default:
                return false;
							}
						}
						else
						{
							if (opCode != PBrickOpCode.opFileOpenLog &&
                  opCode != PBrickOpCode.opComSetConnection)
							{
								return false;
							}
						}
					}
				}
			}
			return true;
		}

		private static void WriteObjectHeader(BinaryWriter stream, ViBuilder viBuilder, int localBytes, ClumpBuilder clump)
		{
			Instruction instruction = clump.CodeGenerator.Instructions[0];
			int num = (viBuilder.IsSubVI && clump == viBuilder.RootClump) ? (instruction.TargetAddress - (1 + viBuilder.Parameters.Count)) : instruction.TargetAddress;
			stream.Write(num);
			stream.Write((ushort)((clump == viBuilder.RootClump) ? 0 : viBuilder.RootClump.Index));
			stream.Write(clump.FireCount);
			stream.Write(localBytes);
		}

		private void WriteCodeSection(BinaryWriter stream)
		{
			using (Dictionary<string, ViBuilder>.ValueCollection.Enumerator vibEnum = this._module.ViBuilders.Values.GetEnumerator())
			{
				while (vibEnum.MoveNext())
				{
					ViBuilder currVIB = vibEnum.Current;
					if (currVIB.IsSubVI)
					{
						this.WriteSubCallParamHeaderInfo(stream, currVIB);
					}
					using (Dictionary<int, ClumpBuilder>.Enumerator clumpEnum = currVIB.Clumps.GetEnumerator())
					{
						while (clumpEnum.MoveNext())
						{
							KeyValuePair<int, ClumpBuilder> currClump = clumpEnum.Current;
							using (List<Instruction>.Enumerator instrEnum = currClump.Value.CodeGenerator.Instructions.GetEnumerator())
							{
								while (instrEnum.MoveNext())
								{
									Instruction currInstr = instrEnum.Current;
									if (currInstr.TargetAddress < 0)
									{
										currInstr.TargetAddress = (int)stream.BaseStream.Position;
									}
									else
									{
										if (currInstr.TargetAddress != (int)stream.BaseStream.Position)
										{
											this._uncertainOfSomeInstructionSizes = true;
											currInstr.TargetAddress = (int)stream.BaseStream.Position;
										}
									}
									if (currInstr is ConditionalBranchInstruction)
									{
										this.WriteConditionalBranchInstruction(stream, currInstr as ConditionalBranchInstruction);
									}
									else
									{
										if (currInstr is BranchInstruction)
										{
											this.WriteBranchInstruction(stream, currInstr as BranchInstruction);
										}
										else
										{
											if (currInstr is CompareInstruction)
											{
												this.WriteCompareInstruction(stream, currInstr as CompareInstruction);
											}
											else
											{
												if (currInstr is CodeEndInstruction)
												{
													this.WriteCodeEndInstruction(stream, currInstr as CodeEndInstruction);
												}
												else
												{
													if (currInstr is CallInstruction)
													{
														this.WriteCallInstruction(stream, currInstr as CallInstruction);
													}
													else
													{
														if (currInstr is ClumpInstruction)
														{
															this.WriteClumpInstruction(stream, currInstr as ClumpInstruction);
														}
														else
														{
															if (currInstr is PBRDirectCodeInstruction)
															{
																this.WritePBRDirectCodeInstruction(stream, currInstr as PBRDirectCodeInstruction);
															}
															else
															{
																this.WriteInstruction(stream, currInstr);
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
			}
			else
			{
				object[] array = args;
				for (int j = 0; j < array.Length; j++)
				{
					object argument = array[j];
					this.WriteArgument(stream, argument, this.DoesInstructionUseHandleEncoding(instruction));
				}
			}
		}
    
		private void WriteSubCallParamHeaderInfo(BinaryWriter stream, ViBuilder viBuilder)
		{
			stream.Write((byte)viBuilder.Parameters.Count);
			using (List<Parameter>.Enumerator paramEnum = viBuilder.Parameters.GetEnumerator())
			{
				while (paramEnum.MoveNext())
				{
					Parameter currParam = paramEnum.Current;
					byte b = 0;
					if (currParam.IsInput || currParam.DataBuilder.IsArray)
					{
						b = 128;
					}
					if (currParam.IsOutput)
					{
						b |= 64;
					}
					switch (currParam.DataBuilder.GetPBRStaticSizeInRam(0))
					{
					case 2:
						b |= 1;
						break;
					case 4:
						b |= 2;
						break;
					}
					if (currParam.DataBuilder.BuilderType.TypeCode == TypeCode.Single)
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
				using (List<object>.Enumerator argEnum = list.GetEnumerator())
				{
					while (argEnum.MoveNext())
					{
						object currArg = argEnum.Current;
						this.WriteArgument(stream, currArg, this.DoesInstructionUseHandleEncoding(instruction));
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
			if (list.Count == 3)
			{
				object obj2 = list[1];
				list[1] = list[2];
				list[2] = obj2;
			}
			list.Reverse();
			using (List<object>.Enumerator argEnum = list.GetEnumerator())
			{
				while (argEnum.MoveNext())
				{
					object obj = argEnum.Current;
					this.WriteArgument(stream, obj, this.DoesInstructionUseHandleEncoding(instruction));
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
			stream.Write((byte)instruction.Arguments.Count);
			List<Parameter> parameters = instruction.VI.Parameters;
			List<Parameter> arguments = instruction.Arguments;
			IEnumerator<Parameter> enumerator = arguments.GetEnumerator();
			IEnumerator<Parameter> enumerator2 = parameters.GetEnumerator();
			while (enumerator.MoveNext() && enumerator2.MoveNext())
			{
				if (enumerator.Current.DataBuilder != null)
				{
					this.WriteArgument(stream, enumerator.Current.DataBuilder, this.DoesInstructionUseHandleEncoding(instruction));
				}
				else
				{
					if (enumerator2.Current.DataBuilder.Value == null)
					{
						if (enumerator2.Current.DBType.TypeCode == TypeCode.String)
						{
							throw new NotImplementedException("Unwired string inputs with no default value are not currently supported.");
						}
						this.WriteArgument(stream, 0, false);
					}
					this.WriteArgument(stream, enumerator2.Current.DataBuilder.Value, this.DoesInstructionUseHandleEncoding(instruction));
				}
			}
		}
    
		private void WriteDataBuilderArgument(BinaryWriter stream, DataBuilder db, bool instructionUsesHandleEncoding)
		{
			if (db.StorageClass == StorageClass.Constant)
			{
				if (db.Value is float || db.Value is float)
				{
					stream.WriteFloatArgument(Convert.ToSingle(db.Value, CultureInfo.InvariantCulture));
				}
				else
				{
					stream.WriteIntArgument(db.IntValue, ArgType.Integer, false);
				}
			}
			else
			{
				stream.WriteIntArgument(db.TargetOffset, this._module.Globals.Contains(db) ? ArgType.GlobalOffset : ArgType.LocalOffset, db.IsArray && instructionUsesHandleEncoding);
			}
		}

		private void WriteArgument(BinaryWriter stream, object argument, bool instructionUsesHandleEncoding)
		{
			if (argument is DataBuilder)
			{
				this.WriteDataBuilderArgument(stream, argument as DataBuilder, instructionUsesHandleEncoding);
			}
			else
			{
				if (argument is Label)
				{
					this.WritelabelArgument(stream, argument as Label);
				}
				else
				{
					if (argument is ushort || argument is int || argument is short || argument is byte || argument is sbyte)
					{
						int argument2 = Convert.ToInt32(argument, CultureInfo.InvariantCulture);
						stream.WriteIntArgument(argument2, ArgType.Integer, false);
					}
					else
					{
						if (null != argument)
						{
							if (argument is float)
							{
								stream.WriteFloatArgument(Convert.ToSingle(argument, CultureInfo.InvariantCulture));
							}
							else
							{
								if (argument is string)
								{
									stream.WriteStringArgument(argument as string);
								}
								else
								{
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
											for (int i = 0; i < array2.Length; i++)
											{
												byte argument3 = array2[i];
												stream.WriteIntArgument((int)argument3, ArgType.Integer);
											}
										}
										else
										{
											if (argument is short[] || argument is ushort[])
											{
												short[] array3 = argument as short[];
												for (int i = 0; i < array3.Length; i++)
												{
													short argument4 = array3[i];
													stream.WriteIntArgument((int)argument4, ArgType.Integer);
												}
											}
											else
											{
												if (argument is int[] || argument is uint[])
												{
													int[] array4 = argument as int[];
													for (int i = 0; i < array4.Length; i++)
													{
														int argument5 = array4[i];
														stream.WriteIntArgument(argument5, ArgType.Integer);
													}
												}
												else
												{
													if (argument is float[])
													{
														float[] array5 = argument as float[];
														for (int i = 0; i < array5.Length; i++)
														{
															float value = array5[i];
															stream.WriteFloatArgument(value);
														}
													}
												}
											}
										}
									}
									else
									{
										LogicException.ThrowLogicException("Unsupported argument type: " + argument.GetType().ToString());
									}
								}
							}
						}
					}
				}
			}
		}

		private void WritelabelArgument(BinaryWriter stream, Label label)
		{
			int num = label.TargetInstruction.TargetAddress;
			if (num < 0)
			{
				this._uncertainOfSomeInstructionSizes = true;
				num = (int)stream.BaseStream.Position;
			}
			int num2 = num - (int)stream.BaseStream.Position;
			int num3 = BinaryWriterExtensions.ArgSize(num2);
			num2 -= BinaryWriterExtensions.ArgSize(num2 - num3);
			stream.WriteIntArgument(num2, ArgType.Integer);
		}
    
	}
*)

end.
