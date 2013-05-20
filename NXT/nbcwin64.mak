PROGRAMS = nbc.exe
VER = 1.2.1.r5
DOBJECTS=uNXTClasses.o uPreprocess.o Parser10.o P10Build.o uNXCComp.o uRPGComp.o uRIC.o uRICComp.o uNBCCommon.o uNXTConstants.o uNBCInterface.o nbc.dpr
DEFAULT_INCLUDE_DIR=.

all:: $(DOBJECTS) $(PROGRAMS)

clean::
	rm -f *.o *.ppu *.rst *.compiled ../*.o ../bricktools/*.o nbc_preproc.inc
	rm -f ../*.o ../*.ppu ../*.rst ../bricktools/*.o ../bricktools/*.ppu

realclean:: clean
	rm -f $(PROGRAMS) mkdata.exe NBCCommonData.pas NXTDefsData.pas NXCDefsData.pas SPCDefsData.pas SPMemData.pas

PFLAGS=-S2cdghi -dRELEASE -OG1 -gl -vewnhi -l -Fu../ -Fu. -Fu../bricktools -dCAN_DOWNLOAD -dNXT_ONLY

# Win32
PTOOLPREFIX=C:/lazarus/fpc/2.6.0/bin/x86_64-win64/
PPC=$(PTOOLPREFIX)fpc

# how to link executable
nbc.exe: nbc.dpr nbc_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@

# how to compile pas source
%.o: %.pas mkdata.exe NBCCommonData.pas NXTDefsData.pas NXCDefsData.pas SPCDefsData.pas SPMemData.pas
	$(PPC) $(PFLAGS) $< -o$@

# how to create the include file
nbc_preproc.inc:
	echo '// '$@ > $@
	echo 'const' >> $@
	echo '  DEFAULT_INCLUDE_DIR = '\'$(DEFAULT_INCLUDE_DIR)\'';' >> $@
	echo '  COMPILATION_TIMESTAMP = '\'`date`\'';' >> $@

# how to create the mkdata utility
mkdata.exe: mkdata.dpr
	$(PPC) $(PFLAGS) $< -o$@

# how to create NBCCommonData.pas
NBCCommonData.pas: NBCCommon.h
	./mkdata.exe $< $@ nbc_common_data

# how to create NXTDefsData.pas
NXTDefsData.pas: NXTDefs.h
	./mkdata.exe $< $@ nxt_defs_data

# how to create NXCDefsData.pas
NXCDefsData.pas: NXCDefs.h
	./mkdata.exe $< $@ nxc_defs_data

# how to create SPCDefsData.pas
SPCDefsData.pas: SPCDefs.h
	./mkdata.exe $< $@ spc_defs_data

# how to create SPMemData.pas
SPMemData.pas: spmem.h
	./mkdata.exe $< $@ spmem_data

