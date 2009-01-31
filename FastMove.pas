unit FastMove;
(*
FastMove by John O'Harrow (john@elmcrest.demon.co.uk)

Version: 1.00 - 07-SEP-2003

   10/09/03 - EG - D5 Compatibility, forces redirection (BPL compatibility)         

How to use:

  Include this unit in any uses clause - Thats It!

What is Does:

  This unit replaces all calls to system.move with calls to a faster
  move procedure (Up to 3 times faster).  The code will automatically
  detect and use MMX or SSE when available.
*)

interface

{.$DEFINE DEBUG} { by default make it lean and efficient }
{$IFNDEF DEBUG}
  {$D-} {$L-}
{$ENDIF}

implementation

{.$IFNDEF VER130}
   {$DEFINE ALLOW_SSE}
{.$ENDIF}

uses
  Windows;

var {Set by the Unit Initialisation}
  EnableMMX : Boolean = False;
  EnableSSE : Boolean = False;

{--------------------------------------------------------------------------}
procedure CheckMMMXSSE; {Called Once by Unit Initialisation}
asm
  push    ebx
  pushfd
  pop     eax
  mov     edx, eax
  xor     edx, $200000
  push    eax
  popfd
  pushfd
  pop     eax
  cmp     eax, edx
  jz      @Exit {No CPUID Support}
  mov     eax, 0 {Check for Get Fetures Support}
  db $0F,$A2               /// cpuid   // Get highest supported cpuid fuction into eax
  jz      @Exit {No support for getting CPU features}
  mov     eax, 1
  db $0F,$A2               /// cpuid   // Get feature bits into edx
  test    edx, (1 shl 23) {Test for MMX Support}
  setnz   EnableMMX
  test    edx, (1 shl 25) {Test for SSE Support}
  setnz   EnableSSE
@Exit:
  pop     ebx
end; {CheckMMMXSSE}

const
  SMALLMOVESIZE = 36;

{--------------------------------------------------------------------------}
procedure SmallForwardMove;
asm
  jmp     dword ptr [@@FwdJumpTable+ecx*4]
  nop {Align Jump Table}
@@FwdJumpTable:
  dd      @@Done {Removes need to test for zero size move}
  dd      @@Fwd01,@@Fwd02,@@Fwd03,@@Fwd04,@@Fwd05,@@Fwd06,@@Fwd07,@@Fwd08
  dd      @@Fwd09,@@Fwd10,@@Fwd11,@@Fwd12,@@Fwd13,@@Fwd14,@@Fwd15,@@Fwd16
  dd      @@Fwd17,@@Fwd18,@@Fwd19,@@Fwd20,@@Fwd21,@@Fwd22,@@Fwd23,@@Fwd24
  dd      @@Fwd25,@@Fwd26,@@Fwd27,@@Fwd28,@@Fwd29,@@Fwd30,@@Fwd31,@@Fwd32
  dd      @@Fwd33,@@Fwd34,@@Fwd35,@@Fwd36
@@Fwd36:
  mov     ecx,[eax-36]
  mov     [edx-36],ecx
@@Fwd32:
  mov     ecx,[eax-32]
  mov     [edx-32],ecx
@@Fwd28:
  mov     ecx,[eax-28]
  mov     [edx-28],ecx
@@Fwd24:
  mov     ecx,[eax-24]
  mov     [edx-24],ecx
@@Fwd20:
  mov     ecx,[eax-20]
  mov     [edx-20],ecx
@@Fwd16:
  mov     ecx,[eax-16]
  mov     [edx-16],ecx
@@Fwd12:
  mov     ecx,[eax-12]
  mov     [edx-12],ecx
@@Fwd08:
  mov     ecx,[eax-8]
  mov     [edx-8],ecx
@@Fwd04:
  mov     ecx,[eax-4]
  mov     [edx-4],ecx
  ret
@@Fwd35:
  mov     ecx,[eax-35]
  mov     [edx-35],ecx
@@Fwd31:
  mov     ecx,[eax-31]
  mov     [edx-31],ecx
@@Fwd27:
  mov     ecx,[eax-27]
  mov     [edx-27],ecx
@@Fwd23:
  mov     ecx,[eax-23]
  mov     [edx-23],ecx
@@Fwd19:
  mov     ecx,[eax-19]
  mov     [edx-19],ecx
@@Fwd15:
  mov     ecx,[eax-15]
  mov     [edx-15],ecx
@@Fwd11:
  mov     ecx,[eax-11]
  mov     [edx-11],ecx
@@Fwd07:
  mov     ecx,[eax-7]
  mov     [edx-7],ecx
@@Fwd03:
  mov     cx,[eax-3]
  mov     [edx-3],cx
  mov     cl,[eax-1]
  mov     [edx-1],cl
  ret
@@Fwd34:
  mov     ecx,[eax-34]
  mov     [edx-34],ecx
@@Fwd30:
  mov     ecx,[eax-30]
  mov     [edx-30],ecx
@@Fwd26:
  mov     ecx,[eax-26]
  mov     [edx-26],ecx
@@Fwd22:
  mov     ecx,[eax-22]
  mov     [edx-22],ecx
@@Fwd18:
  mov     ecx,[eax-18]
  mov     [edx-18],ecx
@@Fwd14:
  mov     ecx,[eax-14]
  mov     [edx-14],ecx
@@Fwd10:
  mov     ecx,[eax-10]
  mov     [edx-10],ecx
@@Fwd06:
  mov     ecx,[eax-6]
  mov     [edx-6],ecx
@@Fwd02:
  mov     cx,[eax-2]
  mov     [edx-2],cx
  ret
@@Fwd33:
  mov     ecx,[eax-33]
  mov     [edx-33],ecx
@@Fwd29:
  mov     ecx,[eax-29]
  mov     [edx-29],ecx
@@Fwd25:
  mov     ecx,[eax-25]
  mov     [edx-25],ecx
@@Fwd21:
  mov     ecx,[eax-21]
  mov     [edx-21],ecx
@@Fwd17:
  mov     ecx,[eax-17]
  mov     [edx-17],ecx
@@Fwd13:
  mov     ecx,[eax-13]
  mov     [edx-13],ecx
@@Fwd09:
  mov     ecx,[eax-9]
  mov     [edx-9],ecx
@@Fwd05:
  mov     ecx,[eax-5]
  mov     [edx-5],ecx
@@Fwd01:
  mov     cl,[eax-1]
  mov     [edx-1],cl
@@Done:
  ret
end; {SmallForwardMove}

{--------------------------------------------------------------------------}
procedure SmallBackwardMove;
asm
  jmp     dword ptr [@@BwdJumpTable+ecx*4]
  nop {Align Jump Table}
@@BwdJumpTable:
  dd      @@Done {Removes need to test for zero size move}
  dd      @@Bwd01,@@Bwd02,@@Bwd03,@@Bwd04,@@Bwd05,@@Bwd06,@@Bwd07,@@Bwd08
  dd      @@Bwd09,@@Bwd10,@@Bwd11,@@Bwd12,@@Bwd13,@@Bwd14,@@Bwd15,@@Bwd16
  dd      @@Bwd17,@@Bwd18,@@Bwd19,@@Bwd20,@@Bwd21,@@Bwd22,@@Bwd23,@@Bwd24
  dd      @@Bwd25,@@Bwd26,@@Bwd27,@@Bwd28,@@Bwd29,@@Bwd30,@@Bwd31,@@Bwd32
  dd      @@Bwd33,@@Bwd34,@@Bwd35,@@Bwd36
@@Bwd36:
  mov     ecx,[eax+32]
  mov     [edx+32],ecx
@@Bwd32:
  mov     ecx,[eax+28]
  mov     [edx+28],ecx
@@Bwd28:
  mov     ecx,[eax+24]
  mov     [edx+24],ecx
@@Bwd24:
  mov     ecx,[eax+20]
  mov     [edx+20],ecx
@@Bwd20:
  mov     ecx,[eax+16]
  mov     [edx+16],ecx
@@Bwd16:
  mov     ecx,[eax+12]
  mov     [edx+12],ecx
@@Bwd12:
  mov     ecx,[eax+8]
  mov     [edx+8],ecx
@@Bwd08:
  mov     ecx,[eax+4]
  mov     [edx+4],ecx
@@Bwd04:
  mov     ecx,[eax]
  mov     [edx],ecx
  ret
@@Bwd35:
  mov     ecx,[eax+31]
  mov     [edx+31],ecx
@@Bwd31:
  mov     ecx,[eax+27]
  mov     [edx+27],ecx
@@Bwd27:
  mov     ecx,[eax+23]
  mov     [edx+23],ecx
@@Bwd23:
  mov     ecx,[eax+19]
  mov     [edx+19],ecx
@@Bwd19:
  mov     ecx,[eax+15]
  mov     [edx+15],ecx
@@Bwd15:
  mov     ecx,[eax+11]
  mov     [edx+11],ecx
@@Bwd11:
  mov     ecx,[eax+7]
  mov     [edx+7],ecx
@@Bwd07:
  mov     ecx,[eax+3]
  mov     [edx+3],ecx
@@Bwd03:
  mov     cx,[eax+1]
  mov     [edx+1],cx
  mov     cl,[eax]
  mov     [edx],cl
  ret
@@Bwd34:
  mov     ecx,[eax+30]
  mov     [edx+30],ecx
@@Bwd30:
  mov     ecx,[eax+26]
  mov     [edx+26],ecx
@@Bwd26:
  mov     ecx,[eax+22]
  mov     [edx+22],ecx
@@Bwd22:
  mov     ecx,[eax+18]
  mov     [edx+18],ecx
@@Bwd18:
  mov     ecx,[eax+14]
  mov     [edx+14],ecx
@@Bwd14:
  mov     ecx,[eax+10]
  mov     [edx+10],ecx
@@Bwd10:
  mov     ecx,[eax+6]
  mov     [edx+6],ecx
@@Bwd06:
  mov     ecx,[eax+2]
  mov     [edx+2],ecx
@@Bwd02:
  mov     cx,[eax]
  mov     [edx],cx
  ret
@@Bwd33:
  mov     ecx,[eax+29]
  mov     [edx+29],ecx
@@Bwd29:
  mov     ecx,[eax+25]
  mov     [edx+25],ecx
@@Bwd25:
  mov     ecx,[eax+21]
  mov     [edx+21],ecx
@@Bwd21:
  mov     ecx,[eax+17]
  mov     [edx+17],ecx
@@Bwd17:
  mov     ecx,[eax+13]
  mov     [edx+13],ecx
@@Bwd13:
  mov     ecx,[eax+9]
  mov     [edx+9],ecx
@@Bwd09:
  mov     ecx,[eax+5]
  mov     [edx+5],ecx
@@Bwd05:
  mov     ecx,[eax+1]
  mov     [edx+1],ecx
@@Bwd01:
  mov     cl,[eax]
  mov     [edx],cl
@@Done:
  ret
end; {SmallBackwardMove}

{--------------------------------------------------------------------------}
{Dest MUST be 16-Byes Aligned, Count MUST be multiple of 16 }
{$ifdef ALLOW_SSE}
procedure AlignedFwdMoveSSE(const Source; var Dest; Count: Integer);
const
  Prefetch = 512;
asm
  push    esi
  push    edi
  mov     esi,eax          {ESI = Source}
  mov     edi,edx          {EDI = Dest}
  mov     eax,ecx          {EAX = Count}
  and     eax,$FFFFFF80    {EAX = No of Bytes to Blocks Moves}
  add     esi,eax
  add     edi,eax
  shr     eax,3            {EAX = No of QWORD's to Block Move}
  neg     eax
  cmp     eax, -(32*1024)  {Count > 256K}
  jl      @Large
@Small: {<256K}
  test    esi,15           {Check if Both Source/Dest Aligned}
  jnz     @SmallUnaligned
@SmallAligned:
@SmallAlignedLoop:
   db $0F,$28,$04,$C6         /// movaps  xmm0,[esi+8*eax]
   db $0F,$28,$4C,$C6,$10     /// movaps  xmm1,[esi+8*eax+16]
   db $0F,$28,$54,$C6,$20     /// movaps  xmm2,[esi+8*eax+32]
   db $0F,$28,$5C,$C6,$30     /// movaps  xmm3,[esi+8*eax+48]
   db $0F,$28,$64,$C6,$40     /// movaps  xmm4,[esi+8*eax+64]
   db $0F,$28,$6C,$C6,$50     /// movaps  xmm5,[esi+8*eax+80]
   db $0F,$28,$74,$C6,$60     /// movaps  xmm6,[esi+8*eax+96]
   db $0F,$28,$7C,$C6,$70     /// movaps  xmm7,[esi+8*eax+112]
   db $0F,$29,$04,$C7         /// movaps  [edi+8*eax],xmm0
   db $0F,$29,$4C,$C7,$10     /// movaps  [edi+8*eax+16],xmm1
   db $0F,$29,$54,$C7,$20     /// movaps  [edi+8*eax+32],xmm2
   db $0F,$29,$5C,$C7,$30     /// movaps  [edi+8*eax+48],xmm3
   db $0F,$29,$64,$C7,$40     /// movaps  [edi+8*eax+64],xmm4
   db $0F,$29,$6C,$C7,$50     /// movaps  [edi+8*eax+80],xmm5
   db $0F,$29,$74,$C7,$60     /// movaps  [edi+8*eax+96],xmm6
   db $0F,$29,$7C,$C7,$70     /// movaps  [edi+8*eax+112],xmm7
  add     eax,16
  js      @SmallAlignedLoop
  jmp     @Remainder
@SmallUnaligned:
@SmallUnalignedLoop:
   db $0F,$10,$04,$C6         /// movups  xmm0,[esi+8*eax]
   db $0F,$10,$4C,$C6,$10     /// movups  xmm1,[esi+8*eax+16]
   db $0F,$10,$54,$C6,$20     /// movups  xmm2,[esi+8*eax+32]
   db $0F,$10,$5C,$C6,$30     /// movups  xmm3,[esi+8*eax+48]
   db $0F,$10,$64,$C6,$40     /// movups  xmm4,[esi+8*eax+64]
   db $0F,$10,$6C,$C6,$50     /// movups  xmm5,[esi+8*eax+80]
   db $0F,$10,$74,$C6,$60     /// movups  xmm6,[esi+8*eax+96]
   db $0F,$10,$7C,$C6,$70     /// movups  xmm7,[esi+8*eax+112]
   db $0F,$29,$04,$C7         /// movaps  [edi+8*eax],xmm0
   db $0F,$29,$4C,$C7,$10     /// movaps  [edi+8*eax+16],xmm1
   db $0F,$29,$54,$C7,$20     /// movaps  [edi+8*eax+32],xmm2
   db $0F,$29,$5C,$C7,$30     /// movaps  [edi+8*eax+48],xmm3
   db $0F,$29,$64,$C7,$40     /// movaps  [edi+8*eax+64],xmm4
   db $0F,$29,$6C,$C7,$50     /// movaps  [edi+8*eax+80],xmm5
   db $0F,$29,$74,$C7,$60     /// movaps  [edi+8*eax+96],xmm6
   db $0F,$29,$7C,$C7,$70     /// movaps  [edi+8*eax+112],xmm7
  add     eax,16
  js      @SmallUnalignedLoop
  jmp     @Remainder
@Large: {>256K}
  test    esi,15           {Check if Both Source/Dest Aligned}
  jnz     @LargeUnaligned
@LargeAligned:
@LargeAlignedLoop:
   db $0F,$18,$84,$C6,$00,$02,$00,$00 /// prefetchnta  [esi+8*eax+Prefetch]
   db $0F,$18,$84,$C6,$40,$02,$00,$00 /// prefetchnta  [esi+8*eax+Prefetch+64]
   db $0F,$28,$04,$C6         /// movaps  xmm0,[esi+8*eax]
   db $0F,$28,$4C,$C6,$10     /// movaps  xmm1,[esi+8*eax+16]
   db $0F,$28,$54,$C6,$20     /// movaps  xmm2,[esi+8*eax+32]
   db $0F,$28,$5C,$C6,$30     /// movaps  xmm3,[esi+8*eax+48]
   db $0F,$28,$64,$C6,$40     /// movaps  xmm4,[esi+8*eax+64]
   db $0F,$28,$6C,$C6,$50     /// movaps  xmm5,[esi+8*eax+80]
   db $0F,$28,$74,$C6,$60     /// movaps  xmm6,[esi+8*eax+96]
   db $0F,$28,$7C,$C6,$70     /// movaps  xmm7,[esi+8*eax+112]
   db $0F,$2B,$04,$C7         /// movntps [edi+8*eax],xmm0
   db $0F,$2B,$4C,$C7,$10     /// movntps [edi+8*eax+16],xmm1
   db $0F,$2B,$54,$C7,$20     /// movntps [edi+8*eax+32],xmm2
   db $0F,$2B,$5C,$C7,$30     /// movntps [edi+8*eax+48],xmm3
   db $0F,$2B,$64,$C7,$40     /// movntps [edi+8*eax+64],xmm4
   db $0F,$2B,$6C,$C7,$50     /// movntps [edi+8*eax+80],xmm5
   db $0F,$2B,$74,$C7,$60     /// movntps [edi+8*eax+96],xmm6
   db $0F,$2B,$7C,$C7,$70     /// movntps [edi+8*eax+112],xmm7
  add     eax,16
  js      @LargeUnalignedLoop
   db $0F,$AE,$F8             /// sfence
  jmp     @Remainder
@LargeUnaligned:
@LargeUnalignedLoop:
   db $0F,$18,$84,$C6,$00,$02,$00,$00 /// prefetchnta  [esi+8*eax+Prefetch]
   db $0F,$18,$84,$C6,$40,$02,$00,$00 /// prefetchnta  [esi+8*eax+Prefetch+64]
   db $0F,$10,$04,$C6         /// movups  xmm0,[esi+8*eax]
   db $0F,$10,$4C,$C6,$10     /// movups  xmm1,[esi+8*eax+16]
   db $0F,$10,$54,$C6,$20     /// movups  xmm2,[esi+8*eax+32]
   db $0F,$10,$5C,$C6,$30     /// movups  xmm3,[esi+8*eax+48]
   db $0F,$10,$64,$C6,$40     /// movups  xmm4,[esi+8*eax+64]
   db $0F,$10,$6C,$C6,$50     /// movups  xmm5,[esi+8*eax+80]
   db $0F,$10,$74,$C6,$60     /// movups  xmm6,[esi+8*eax+96]
   db $0F,$10,$7C,$C6,$70     /// movups  xmm7,[esi+8*eax+112]
   db $0F,$2B,$04,$C7         /// movntps [edi+8*eax],xmm0
   db $0F,$2B,$4C,$C7,$10     /// movntps [edi+8*eax+16],xmm1
   db $0F,$2B,$54,$C7,$20     /// movntps [edi+8*eax+32],xmm2
   db $0F,$2B,$5C,$C7,$30     /// movntps [edi+8*eax+48],xmm3
   db $0F,$2B,$64,$C7,$40     /// movntps [edi+8*eax+64],xmm4
   db $0F,$2B,$6C,$C7,$50     /// movntps [edi+8*eax+80],xmm5
   db $0F,$2B,$74,$C7,$60     /// movntps [edi+8*eax+96],xmm6
   db $0F,$2B,$7C,$C7,$70     /// movntps [edi+8*eax+112],xmm7
  add     eax,16
  js      @LargeUnalignedLoop
   db $0F,$AE,$F8             /// sfence
@Remainder:
  and     ecx,$7F {ECX = Remainder (0..112 - Multiple of 16)}
  jz      @Done
  add     esi,ecx
  add     edi,ecx
  neg     ecx
@RemainderLoop:
   db $0F,$10,$04,$0E         /// movups  xmm0,[esi+ecx]
   db $0F,$29,$04,$0F         /// movaps  [edi+ecx],xmm0
  add     ecx,16
  jnz     @RemainderLoop
@Done:
  pop     edi
  pop     esi
end; {AlignedFwdMoveSSE}
{$endif}

{--------------------------------------------------------------------------}
procedure ForwardsNotSmall_IA32;
asm
  push    ebx
  mov     ebx,edx
  fild    qword ptr [eax]
  add     eax,ecx {QWORD Align Writes}
  add     ecx,edx
  add     edx,7
  and     edx,-8
  sub     ecx,edx
  add     edx,ecx {Now QWORD Aligned}
  sub     ecx,16
  neg     ecx
@FwdLoop:
  fild    qword ptr [eax+ecx-16]
  fistp   qword ptr [edx+ecx-16]
  fild    qword ptr [eax+ecx-8]
  fistp   qword ptr [edx+ecx-8]
  add     ecx,16
  jle     @FwdLoop
  fistp   qword ptr [ebx]
  neg     ecx
  add     ecx,16
  pop     ebx
  jmp     SmallForwardMove
end;

{--------------------------------------------------------------------------}
procedure BackwardsNotSmall_IA32;
asm
  push    ebx
  fild    qword ptr [eax+ecx-8]
  lea     ebx,[edx+ecx] {QWORD Align Writes}
  and     ebx,7
  sub     ecx,ebx
  add     ebx,ecx {Now QWORD Aligned, EBX = Original Length}
  sub     ecx,16
@BwdLoop:
  fild    qword ptr [eax+ecx]
  fild    qword ptr [eax+ecx+8]
  fistp   qword ptr [edx+ecx+8]
  fistp   qword ptr [edx+ecx]
  sub     ecx,16
  jge     @BwdLoop
  fistp   qword ptr [edx+ebx-8]
  add     ecx,16
  pop     ebx
  jmp     SmallBackwardMove
end;

{--------------------------------------------------------------------------}
procedure ForwardsNotSmall_MMX;
const
  LARGESIZE = 1024;
asm
  cmp     ecx,LARGESIZE
  jge     @FwdLargeMove
  cmp     ecx,72 {Size at which using MMX becomes worthwhile}
  jl      @FwdMoveNonMMX
  push    ebx
  mov     ebx,edx
  db $0F,$6F,$00           /// movq    mm0,[eax]  // First 8 Characters
  {QWORD Align Writes}
  add     eax,ecx
  add     ecx,edx
  add     edx,7
  and     edx,-8
  sub     ecx,edx
  add     edx,ecx
  {Now QWORD Aligned}
  sub     ecx,32
  neg     ecx
@FwdLoopMMX:
  db $0F,$6F,$8C,$08,$E0,$FF,$FF,$FF/// movq    mm1,[eax+ecx-32]
  db $0F,$6F,$94,$08,$E8,$FF,$FF,$FF/// movq    mm2,[eax+ecx-24]
  db $0F,$6F,$9C,$08,$F0,$FF,$FF,$FF/// movq    mm3,[eax+ecx-16]
  db $0F,$6F,$A4,$08,$F8,$FF,$FF,$FF/// movq    mm4,[eax+ecx- 8]
  db $0F,$7F,$8C,$0A,$E0,$FF,$FF,$FF/// movq    [edx+ecx-32],mm1
  db $0F,$7F,$94,$0A,$E8,$FF,$FF,$FF/// movq    [edx+ecx-24],mm2
  db $0F,$7F,$9C,$0A,$F0,$FF,$FF,$FF/// movq    [edx+ecx-16],mm3
  db $0F,$7F,$A4,$0A,$F8,$FF,$FF,$FF/// movq    [edx+ecx- 8],mm4
  add     ecx,32
  jle     @FwdLoopMMX
  db $0F,$7F,$03           /// movq    [ebx],mm0  // First 8 Characters
  db $0F,$77               /// emms
  pop     ebx
  neg     ecx
  add     ecx,32
  jmp     SmallForwardMove
@FwdMoveNonMMX:
  push    edi
  push    ebx
  push    edx
  mov     edi,[eax]
  {DWORD Align Reads}
  add     edx,ecx
  add     ecx,eax
  add     eax,3
  and     eax,-4
  sub     ecx,eax
  add     eax,ecx
  {Now DWORD Aligned}
  sub     ecx,32
  neg     ecx
@FwdLoop:
  mov     ebx,[eax+ecx-32]
  mov     [edx+ecx-32],ebx
  mov     ebx,[eax+ecx-28]
  mov     [edx+ecx-28],ebx
  mov     ebx,[eax+ecx-24]
  mov     [edx+ecx-24],ebx
  mov     ebx,[eax+ecx-20]
  mov     [edx+ecx-20],ebx
  mov     ebx,[eax+ecx-16]
  mov     [edx+ecx-16],ebx
  mov     ebx,[eax+ecx-12]
  mov     [edx+ecx-12],ebx
  mov     ebx,[eax+ecx-8]
  mov     [edx+ecx-8],ebx
  mov     ebx,[eax+ecx-4]
  mov     [edx+ecx-4],ebx
  add     ecx,32
  jle     @FwdLoop
  pop     ebx {Orig EDX}
  mov     [ebx],edi
  neg     ecx
  add     ecx,32
  pop     ebx
  pop     edi
  jmp     SmallForwardMove
@FwdLargeMove:
  push    ebx
  mov     ebx,ecx
  test    edx,15
  jz      @FwdAligned
  {16 byte Align Destination}
  mov     ecx,edx
  add     ecx,15
  and     ecx,-16
  sub     ecx,edx
  add     eax,ecx
  add     edx,ecx
  sub     ebx,ecx
  {Destination now 16 Byte Aligned}
  call    SmallForwardMove
@FwdAligned:
  mov     ecx,ebx
  and     ecx,-16
  sub     ebx,ecx {EBX = Remainder}
  push    esi
  push    edi
  mov     esi,eax          {ESI = Source}
  mov     edi,edx          {EDI = Dest}
  mov     eax,ecx          {EAX = Count}
  and     eax,$FFFFFFC0    {EAX = No of Bytes to Blocks Moves}
  and     ecx,$3F          {ECX = Remaining Bytes to Move (0..63)}
  add     esi,eax
  add     edi,eax
  shr     eax,3            {EAX = No of QWORD's to Block Move}
  neg     eax
@MMXcopyloop:
  db $0F,$6F,$04,$C6       /// movq    mm0,[esi+eax*8   ]
  db $0F,$6F,$4C,$C6,$08   /// movq    mm1,[esi+eax*8+ 8]
  db $0F,$6F,$54,$C6,$10   /// movq    mm2,[esi+eax*8+16]
  db $0F,$6F,$5C,$C6,$18   /// movq    mm3,[esi+eax*8+24]
  db $0F,$6F,$64,$C6,$20   /// movq    mm4,[esi+eax*8+32]
  db $0F,$6F,$6C,$C6,$28   /// movq    mm5,[esi+eax*8+40]
  db $0F,$6F,$74,$C6,$30   /// movq    mm6,[esi+eax*8+48]
  db $0F,$6F,$7C,$C6,$38   /// movq    mm7,[esi+eax*8+56]
  db $0F,$7F,$04,$C7       /// movq    [edi+eax*8   ],mm0
  db $0F,$7F,$4C,$C7,$08   /// movq    [edi+eax*8+ 8],mm1
  db $0F,$7F,$54,$C7,$10   /// movq    [edi+eax*8+16],mm2
  db $0F,$7F,$5C,$C7,$18   /// movq    [edi+eax*8+24],mm3
  db $0F,$7F,$64,$C7,$20   /// movq    [edi+eax*8+32],mm4
  db $0F,$7F,$6C,$C7,$28   /// movq    [edi+eax*8+40],mm5
  db $0F,$7F,$74,$C7,$30   /// movq    [edi+eax*8+48],mm6
  db $0F,$7F,$7C,$C7,$38   /// movq    [edi+eax*8+56],mm7
  add     eax,8
  jnz     @MMXcopyloop
  db $0F,$77               /// emms                   {Empty MMX State}
  add     ecx,ebx
  shr     ecx,2
  rep     movsd
  mov     ecx,ebx
  and     ecx,3
  rep     movsb
  pop     edi
  pop     esi
  pop     ebx
end;

{--------------------------------------------------------------------------}
procedure BackwardsNotSmall_MMX;
asm
  push    ebx
  cmp     ecx,72 {Size at which using MMX becomes worthwhile}
  jl      @BwdMove
  db $0F,$6F,$84,$08,$F8,$FF,$FF,$FF/// movq    mm0,[eax+ecx-8] // Get Last QWORD
  {QWORD Align Writes}
  lea     ebx,[edx+ecx]
  and     ebx,7
  sub     ecx,ebx
  add     ebx,ecx
  {Now QWORD Aligned}
  sub     ecx,32
@BwdLoopMMX:
  db $0F,$6F,$0C,$08       /// movq    mm1,[eax+ecx   ]
  db $0F,$6F,$54,$08,$08   /// movq    mm2,[eax+ecx+ 8]
  db $0F,$6F,$5C,$08,$10   /// movq    mm3,[eax+ecx+16]
  db $0F,$6F,$64,$08,$18   /// movq    mm4,[eax+ecx+24]
  db $0F,$7F,$64,$0A,$18   /// movq    [edx+ecx+24],mm4
  db $0F,$7F,$5C,$0A,$10   /// movq    [edx+ecx+16],mm3
  db $0F,$7F,$54,$0A,$08   /// movq    [edx+ecx+ 8],mm2
  db $0F,$7F,$0C,$0A       /// movq    [edx+ecx   ],mm1
  sub     ecx,32
  jge     @BwdLoopMMX
  db $0F,$7F,$84,$1A,$F8,$FF,$FF,$FF/// movq    [edx+ebx-8], mm0 // Last QWORD
  db $0F,$77               /// emms
  add     ecx,32
  pop     ebx
  jmp     SmallBackwardMove
@BwdMove:
  push    edi
  push    ecx
  mov     edi,[eax+ecx-4] {Get Last DWORD}
  {DWORD Align Writes}
  lea     ebx,[edx+ecx]
  and     ebx,3
  sub     ecx,ebx
  {Now DWORD Aligned}
  sub     ecx,32
@BwdLoop:
  mov     ebx,[eax+ecx+28]
  mov     [edx+ecx+28],ebx
  mov     ebx,[eax+ecx+24]
  mov     [edx+ecx+24],ebx
  mov     ebx,[eax+ecx+20]
  mov     [edx+ecx+20],ebx
  mov     ebx,[eax+ecx+16]
  mov     [edx+ecx+16],ebx
  mov     ebx,[eax+ecx+12]
  mov     [edx+ecx+12],ebx
  mov     ebx,[eax+ecx+8]
  mov     [edx+ecx+8],ebx
  mov     ebx,[eax+ecx+4]
  mov     [edx+ecx+4],ebx
  mov     ebx,[eax+ecx]
  mov     [edx+ecx],ebx
  sub     ecx,32
  jge     @BwdLoop
  pop     ebx
  add     ecx,32
  mov     [edx+ebx-4],edi {Last DWORD}
  pop     edi
  pop     ebx
  jmp     SmallBackwardMove
end;

{--------------------------------------------------------------------------}
{$ifdef ALLOW_SSE}
procedure ForwardsNotSmall_SSE;
const
  LARGESIZE = 1024;
asm
  cmp     ecx,LARGESIZE
  jge     @FwdLargeMove
  cmp     ecx,SMALLMOVESIZE+32
  jg      @FwdMoveSSE
   db $0F,$10,$08             /// movups  xmm1,[eax]
   db $0F,$10,$50,$10         /// movups  xmm2,[eax+16]
   db $0F,$11,$0A             /// movups  [edx],xmm1
   db $0F,$11,$52,$10         /// movups  [edx+16],xmm2
  add     eax,ecx
  add     edx,ecx
  sub     ecx,32
  jmp     SmallForwardMove
@FwdMoveSSE:
  push    ebx
  {First 16 Bytes}
   db $0F,$10,$00             /// movups  xmm0,[eax]
  mov     ebx,edx
  {Align Writes}
  add     eax,ecx
  add     ecx,edx
  add     edx,15
  and     edx,-16
  sub     ecx,edx
  add     edx,ecx
  {Now Aligned}
  sub     ecx,32
  neg     ecx
@FwdLoopSSE:
   db $0F,$10,$4C,$08,$E0     /// movups  xmm1,[eax+ecx-32]
   db $0F,$10,$54,$08,$F0     /// movups  xmm2,[eax+ecx-16]
   db $0F,$29,$4C,$0A,$E0     /// movaps  [edx+ecx-32],xmm1
   db $0F,$29,$54,$0A,$F0     /// movaps  [edx+ecx-16],xmm2
  add     ecx,32
  jle     @FwdLoopSSE
  {First 16 Bytes}
   db $0F,$11,$03             /// movups  [ebx],xmm0
  neg     ecx
  pop     ebx
  add     ecx,32
  jmp     SmallForwardMove
@FwdLargeMove:
  push    ebx
  mov     ebx,ecx
  test    edx,15
  jz      @FwdLargeAligned
  {16 byte Align Destination}
  mov     ecx,edx
  add     ecx,15
  and     ecx,-16
  sub     ecx,edx
  add     eax,ecx
  add     edx,ecx
  sub     ebx,ecx
  {Destination now 16 Byte Aligned}
  call    SmallForwardMove
  mov     ecx,ebx
@FwdLargeAligned:
  and     ecx,-16
  sub     ebx,ecx {EBX = Remainder}
  push    edx
  push    eax
  push    ecx
  call    AlignedFwdMoveSSE
  pop     ecx
  pop     eax
  pop     edx
  add     ecx,ebx
  add     eax,ecx
  add     edx,ecx
  mov     ecx,ebx
  pop     ebx
  jmp     SmallForwardMove
end;

{--------------------------------------------------------------------------}
procedure BackwardsNotSmall_SSE;
asm
  cmp     ecx,SMALLMOVESIZE+32
  jg      @BwdMoveSSE
  sub     ecx,32
   db $0F,$10,$0C,$08         /// movups  xmm1,[eax+ecx]
   db $0F,$10,$54,$08,$10     /// movups  xmm2,[eax+ecx+16]
   db $0F,$11,$0C,$0A         /// movups  [edx+ecx],xmm1
   db $0F,$11,$54,$0A,$10     /// movups  [edx+ecx+16],xmm2
  jmp     SmallBackwardMove
@BwdMoveSSE:
  push    ebx
  {Last 16 Bytes}
   db $0F,$10,$44,$08,$F0     /// movups  xmm0,[eax+ecx-16]
  {Align Writes}
  lea     ebx,[edx+ecx]
  and     ebx,15
  sub     ecx,ebx
  add     ebx,ecx
  {Now Aligned}
  sub     ecx,32
@BwdLoop:
   db $0F,$10,$0C,$08         /// movups  xmm1,[eax+ecx]
   db $0F,$10,$54,$08,$10     /// movups  xmm2,[eax+ecx+16]
   db $0F,$29,$0C,$0A         /// movaps  [edx+ecx],xmm1
   db $0F,$29,$54,$0A,$10     /// movaps  [edx+ecx+16],xmm2
  sub     ecx,32
  jge     @BwdLoop
  {Last 16 Bytes}
   db $0F,$11,$44,$1A,$F0     /// movups  [edx+ebx-16],xmm0
  add     ecx,32
  pop     ebx
  jmp     SmallBackwardMove
end;
{$endif}
{--------------------------------------------------------------------------}
procedure MoveJOH_IA32(const Source; var Dest; Count : Integer);
asm {ReplaceMove Code depends on the following not Changing}
  cmp     eax,edx
  jle     @Check
  cmp     ecx,SMALLMOVESIZE
  jg      ForwardsNotSmall_IA32
  add     eax,ecx
@ForwardSmall:
  add     edx,ecx {End Dest}
  or      ecx,ecx {For Compatibility with Delphi's move for Count <= 0}
  jg      SmallForwardMove
@Done:
  ret
@Check:
  je      @Done {For Compatibility with Delphi's move for Source = Dest}
@CheckOverlap:
  add     eax,ecx {End Source}
  cmp     eax,edx
  jg      @Backwards {Source/Dest Overlap}
  cmp     ecx,SMALLMOVESIZE
  jle     @ForwardSmall {Source already incremented by Count}
  sub     eax,ecx {Restore Original Source}
  jmp     ForwardsNotSmall_IA32
@Backwards: {Overlapping Source/Dest}
  sub     eax,ecx {Restore Original Source}
  cmp     ecx,SMALLMOVESIZE
  jle     SmallBackwardMove
  jmp     BackwardsNotSmall_IA32
end; {MoveJOH_IA32}

{--------------------------------------------------------------------------}
procedure MoveJOH_MMX(const Source; var Dest; Count : Integer);
asm {MUST be same layout as MoveJOH_IA32}
  cmp     eax,edx
  jle     @Check
  cmp     ecx,SMALLMOVESIZE
  jg      ForwardsNotSmall_MMX
  add     eax,ecx
@ForwardSmall:
  add     edx,ecx {End Dest}
  or      ecx,ecx {For Compatibility with Delphi's move for Count <= 0}
  jg      SmallForwardMove
@Done:
  ret
@Check:
  je      @Done {For Compatibility with Delphi's move for Source = Dest}
@CheckOverlap:
  add     eax,ecx {End Source}
  cmp     eax,edx
  jg      @Backwards {Source/Dest Overlap}
  cmp     ecx,SMALLMOVESIZE
  jle     @ForwardSmall {Source already incremented by Count}
  sub     eax,ecx {Restore Original Source}
  jmp     ForwardsNotSmall_MMX
@Backwards: {Overlapping Source/Dest}
  sub     eax,ecx {Restore Original Source}
  cmp     ecx,SMALLMOVESIZE
  jle     SmallBackwardMove
  jmp     BackwardsNotSmall_MMX
end; {MoveJOH_MMX}

{--------------------------------------------------------------------------}
{$ifdef ALLOW_SSE}
procedure MoveJOH_SSE(const Source; var Dest; Count : Integer);
asm {MUST be same layout as MoveJOH_IA32}
  cmp     eax,edx
  jle     @Check
  cmp     ecx,SMALLMOVESIZE
  jg      ForwardsNotSmall_SSE
  add     eax,ecx
@ForwardSmall:
  add     edx,ecx {End Dest}
  or      ecx,ecx {For Compatibility with Delphi's move for Count <= 0}
  jg      SmallForwardMove
@Done:
  ret
@Check:
  je      @Done {For Compatibility with Delphi's move for Source = Dest}
@CheckOverlap:
  add     eax,ecx {End Source}
  cmp     eax,edx
  jg      @Backwards {Source/Dest Overlap}
  cmp     ecx,SMALLMOVESIZE
  jle     @ForwardSmall {Source already incremented by Count}
  sub     eax,ecx {Restore Original Source}
  jmp     ForwardsNotSmall_SSE
@Backwards: {Overlapping Source/Dest}
  sub     eax,ecx {Restore Original Source}
  cmp     ecx,SMALLMOVESIZE
  jle     SmallBackwardMove
  jmp     BackwardsNotSmall_SSE
end; {MoveJOH_SSE}
{$endif}

procedure ReplaceMove;

   procedure Redirect(oldRoutine, newRoutine : Pointer);
   var
      oldProtect, protect : Cardinal;
   begin
      VirtualProtect(oldRoutine, 256, PAGE_READWRITE, @oldProtect);
      PByte(oldRoutine)^:=$E9;
      PInteger(Integer(oldRoutine)+1)^:=Integer(newRoutine)-Integer(oldRoutine)-5;
      VirtualProtect(oldRoutine, 2048, oldProtect, @protect);
   end;

{
type // Jump Offsets Positions in Move Prodedures Above - Horrible but Works
  NewMoveType = packed record  // Size = 62 Bytes, System.Move = 64 Bytes
    Padding1  : array[1.. 9] of Byte;
    Jump1Dest : Integer; // jg  ForwardsNotSmall_XXX
    Padding2  : array[1.. 8] of Byte;
    Jump2Dest : Integer; // jg  SmallForwardMove
    Padding3  : array[1..17] of Byte;
    Jump3Dest : Integer; // jmp ForwardsNotSmall_XXX
    Padding4  : array[1.. 7] of Byte;
    Jump4Dest : Integer; // jle SmallBackwardMove
    Padding5  : array[1.. 1] of Byte;
    Jump5Dest : Integer; // jmp BackwardsNotSmall_XXX
  end;
  PByteArray = ^TByteArray;
  TByteArray = array[0..32767] of Byte;
}
var
//  I, Offset : Integer;
  SrcProc   : Pointer;
{  Src, Dest : PByteArray;
  NewMove   : NewMoveType;
  OldProtect,
  Protect   : DWORD; }
begin
  CheckMMMXSSE;
{$ifdef ALLOW_SSE}
  if EnableSSE then
    SrcProc := @MoveJOH_SSE
  else
{$endif}
    if EnableMMX then
      SrcProc := @MoveJOH_MMX
    else
      SrcProc := @MoveJOH_IA32;

  Redirect(@System.Move, SrcProc);
{
  Move(SrcProc^, NewMove, SizeOf(NewMove));
  // Adjust Jump Destinations in Copied Procedure
  Offset := Integer(SrcProc) - Integer(@System.Move);
  Inc(NewMove.Jump1Dest, Offset);
  Inc(NewMove.Jump2Dest, Offset);
  Inc(NewMove.Jump3Dest, Offset);
  Inc(NewMove.Jump4Dest, Offset);
  Inc(NewMove.Jump5Dest, Offset);
  Src  := @NewMove;
  Dest := @System.Move;
  VirtualProtect(@System.Move, SizeOf(NewMove), PAGE_READWRITE, OldProtect);
  for I := 0 to SizeOf(NewMove) - 1 do
    Dest[I] := Src[I]; // Overwrite System.Move
  VirtualProtect(@System.Move, SizeOf(NewMove), OldProtect, Protect);
}
  FlushInstructionCache(GetCurrentProcess, @System.Move, 256);
end;

initialization

  ReplaceMove;
  
end.

