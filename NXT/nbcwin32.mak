PROGRAMS = nbc.exe
VER = 1.2.1.r4
DOBJECTS=uNXTClasses.o uPreprocess.o Parser10.o P10Build.o uNXCComp.o uRPGComp.o uRIC.o uRICComp.o uNBCCommon.o uNXTConstants.o uNBCInterface.o nbc.dpr
DEFAULT_INCLUDE_DIR=.

all:: $(DOBJECTS) $(PROGRAMS)

clean::
	rm -f *.o *.ppu *.rst *.compiled ../*.o ../bricktools/*.o nbc_preproc.inc

realclean:: clean
	rm -f $(PROGRAMS) mkdata.exe NBCCommonData.pas NXTDefsData.pas NXCDefsData.pas

PFLAGS=-S2cdghi -dRELEASE -OG1 -gl -vewnhi -l -Fu../ -Fu. -Fu../bricktools -dCAN_DOWNLOAD

# Win32
PTOOLPREFIX=C:/lazarus/fpc/2.2.2/bin/i386-win32/
PPC=$(PTOOLPREFIX)fpc

# how to link executable
nbc.exe: nbc.dpr nbc_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@
	strip $@

# how to compile pas source
%.o: %.pas mkdata.exe NBCCommonData.pas NXTDefsData.pas NXCDefsData.pas
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
	strip $@

# how to create NBCCommonData.pas
NBCCommonData.pas: NBCCommon.h
	./mkdata.exe $< $@ nbc_common_data

# how to create NXTDefsData.pas
NXTDefsData.pas: NXTDefs.h
	./mkdata.exe $< $@ nxt_defs_data

# how to create NXCDefsData.pas
NXCDefsData.pas: NXCDefs.h
	./mkdata.exe $< $@ nxc_defs_data

