PROGRAMS = nbc
VER = 1.0.1.b35
DOBJECTS=uNXTClasses.o uPreprocess.o Parser10.o P10Build.o uNXCComp.o uRPGComp.o uRIC.o uRICComp.o uNBCCommon.o uNXTConstants.o uNBCInterface.o nbc.dpr
DEFAULT_INCLUDE_DIR=/usr/local/include/nbc

all:: $(DOBJECTS) $(PROGRAMS)

clean::
	rm -f *.o *.ppu *.rst *.compiled *.dcu nbc_preproc.inc

realclean:: clean
	rm -f $(PROGRAMS) mkdata NBCCommonData.pas NXTDefsData.pas NXCDefsData.pas

PFLAGS=-S2cdghi -dRELEASE -vewnhi -l -Fu../ -Fu. -Fu../bricktools -Fu../png -Fu/usr/lib/lazarus/lcl/units/i386-linux/ -dCAN_DOWNLOAD -dLCL

#/usr/bin/ppc386  -S2cgi -OG1 -gl -WG -va -l -Fu/usr/lib/lazarus/lcl/units/i386-linux/ -Fu/usr/lib/lazarus/lcl/units/i386-linux/gtk/ -Fu/usr/lib/lazarus/packager/units/i386-linux/ -Fu. -dLCL -dLCLgtk /tmp/testcompileroptions.pas


# Linux
PTOOLPREFIX=/usr/bin/
PPC=$(PTOOLPREFIX)ppc386

# how to link executable
nbc: nbc.dpr nbc_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@

# how to compile pas source
%.o: %.pas mkdata NBCCommonData.pas NXTDefsData.pas NXCDefsData.pas
	$(PPC) $(PFLAGS) $< -o$@

# how to create the include file
nbc_preproc.inc:
	echo '// '$@ > $@
	echo 'const' >> $@
	echo '  DEFAULT_INCLUDE_DIR = '\'$(DEFAULT_INCLUDE_DIR)\'';' >> $@
	echo '  COMPILATION_TIMESTAMP = '\'`date`\'';' >> $@

# how to create the mkdata utility
mkdata: mkdata.dpr
	$(PPC) $(PFLAGS) $< -o$@

# how to create NBCCommonData.pas
NBCCommonData.pas: NBCCommon.h
	./mkdata $< $@ nbc_common_data

# how to create NXTDefsData.pas
NXTDefsData.pas: NXTDefs.h
	./mkdata $< $@ nxt_defs_data

# how to create NXCDefsData.pas
NXCDefsData.pas: NXCDefs.h
	./mkdata $< $@ nxc_defs_data
