PROGRAMS = nbc.exe
VER = 1.2.1.r3
DOBJECTS=uNXTClasses.o uPreprocess.o Parser10.o P10Build.o uNXCComp.o uRPGComp.o uRIC.o uRICComp.o uNBCCommon.o uNXTConstants.o uNBCInterface.o nbc.dpr
DEFAULT_INCLUDE_DIR=.

all:: $(DOBJECTS) $(PROGRAMS)

clean::
	rm -f *.o *.ppu *.rst *.compiled *.dcu nbc_preproc.inc

realclean:: clean
	rm -f $(PROGRAMS) mkdata.exe NBCCommonData.pas NXTDefsData.pas NXCDefsData.pas

#PFLAGS=-S2cdghi -dRELEASE -OG1 -gl -vewnhi -l -Fu../ -Fu.

# wince arm
PFLAGS=-S2cdghi -dRELEASE -OG1 -TWinCE -Parm -gl -Xs -WG -va -vewnhi -l -Fu..\..\..\..\lazarus\lcl\units\arm-wince\ -Fu..\..\..\..\lazarus\lcl\units\arm-wince\wince\ -Fu..\..\..\..\lazarus\packager\units\arm-wince\ -Fu../ -Fu.
PTOOLPREFIX=c:/lazarus/fpc/2.1.3/bin/i386-win32/
PPC=$(PTOOLPREFIX)fpc.exe

# Win32
#PTOOLPREFIX=C:/lazarus/fpc/2.1.3/bin/i386-win32/
#PPC=$(PTOOLPREFIX)ppc386.exe

# Linux
#PTOOLPREFIX=/usr/bin/
#PPC=$(PTOOLPREFIX)ppc386

# Mac OSX
#PTOOLPREFIX=/usr/local/bin/
#PPC=$(PTOOLPREFIX)ppcppc

# how to link executable
%.exe: %.dpr nbc_preproc.inc
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
	./mkdata $< $@ nbc_common_data

# how to create NXTDefsData.pas
NXTDefsData.pas: NXTDefs.h
	./mkdata $< $@ nxt_defs_data

# how to create NXCDefsData.pas
NXCDefsData.pas: NXCDefs.h
	./mkdata $< $@ nxc_defs_data

