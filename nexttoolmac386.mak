PROGRAMS = NeXTTool
VER = 1.0.2.0
DOBJECTS=uCmdLineUtils.o ParamUtils.o uCommonUtils.o uVersionInfo.o NeXTTool.dpr
BINDIST = nxt/NeXTTool
FANTOM_SRC = bricktools/FANTOM.pas bricktools/FANTOM_CONST.INC bricktools/FANTOMFPC.PAS bricktools/fantomosx.pas bricktools/libusb.pas
BT_SRC = bricktools/FantomSpirit.pas bricktools/rcx_cmd.pas bricktools/rcx_constants.pas bricktools/uSpirit.pas
CMN_SRC = uCmdLineUtils.pas uCommonUtils.pas uVersionInfo.pas ParamUtils.pas
DISTFILES = uCmdLineUtils.pas
EXCLUDES = --exclude=*.exe --exclude=*.zip --exclude=*.o --exclude=*.~* --exclude=*.dll

all:: $(DOBJECTS) $(PROGRAMS)

archive_nexttool_bin:: clean
	tar -czf nexttool-$(VER).tgz $(BINDIST)
	mv nexttool-$(VER).tgz ..

archive_nexttool:: clean
	tar -czf nexttool-$(VER).src.tgz $(DISTFILES) $(EXCLUDES)
	mv nexttool-$(VER).src.tgz ..

clean::
	rm -f *.o *.ppu *.rst *.compiled nexttool_preproc.inc bricktools/*.o bricktools/*.ppu

realclean:: clean
	rm -rf $(PROGRAMS) ./intel

universal:: ./intel/nexttool ./ppc/nexttool
	lipo -create ./ppc/nexttool ./intel/nexttool -output ./nexttool

PFLAGS=-S2cdghi -OG1 -gl -vewnhi -dRELEASE -l -Fu. -Fubricktools -k-framework -kFantom

# Mac OSX Intel
PTOOLPREFIX=/usr/local/bin/
PPC=$(PTOOLPREFIX)ppc386

# how to link executable
NeXTTool: NeXTTool.dpr nexttool_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@
	strip $@
	mkdir intel
	mv $@ ./intel

# how to compile pas source
%.o: %.pas
	$(PPC) $(PFLAGS) $< -o$@

# how to create the include file
nexttool_preproc.inc:
	echo '// '$@ > $@
	echo 'const' >> $@
	echo '  COMPILATION_TIMESTAMP = '\'`date`\'';' >> $@

