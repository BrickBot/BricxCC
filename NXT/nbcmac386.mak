PROGRAMS = nbc
VER = 1.2.1.r5
DOBJECTS=uNXTClasses.o uPreprocess.o Parser10.o P10Build.o uNXCComp.o uRPGComp.o uRIC.o uRICComp.o uNBCCommon.o uNXTConstants.o uNBCInterface.o nbc.dpr
DEFAULT_INCLUDE_DIR=/usr/local/include/nbc

all:: realclean $(DOBJECTS) $(PROGRAMS)

clean::
	rm -f *.o *.ppu *.rst *.compiled *.dcu nbc_preproc.inc

realclean:: clean
	rm -rf $(PROGRAMS) mkdata NBCCommonData.pas NXTDefsData.pas NXCDefsData.pas SPCDefsData.pas SPMemData.pas ./intel

universal:: ./intel/nbc ./ppc/nbc
	lipo -create ./ppc/nbc ./intel/nbc -output ./nbc

PFLAGS=-S2cdghi -OG1 -gl -vewnhi -l -Fu../ -Fu. -Fu../bricktools -dCAN_DOWNLOAD -dNXT_ONLY -k-framework -kFantom

# Mac OSX Intel
PTOOLPREFIX=/usr/local/bin/
PPC=$(PTOOLPREFIX)ppc386

# how to link executable
nbc: nbc.dpr nbc_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@
	strip $@
	mkdir intel
	mv $@ ./intel

# how to compile pas source
%.o: %.pas mkdata NBCCommonData.pas NXTDefsData.pas NXCDefsData.pas SPCDefsData.pas SPMemData.pas
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

# how to create SPCDefsData.pas
SPCDefsData.pas: SPCDefs.h
	./mkdata $< $@ spc_defs_data

# how to create SPMemData.pas
SPMemData.pas: spmem.h
	./mkdata $< $@ spmem_data

