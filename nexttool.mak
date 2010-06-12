PROGRAMS = nexttool
VER = 1.2.1.r3
DOBJECTS=uCmdLineUtils.o ParamUtils.o uCommonUtils.o uVersionInfo.o NeXTTool.dpr
BINDIST = nxt/nexttool
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
	rm -f $(PROGRAMS) 

PFLAGS=-S2cdghi -dRELEASE -vewnhi -l -Fu. -Fubricktools

# Linux
PTOOLPREFIX=/usr/bin/
PPC=$(PTOOLPREFIX)fpc

# how to link executable
nexttool: NeXTTool.dpr nexttool_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@

# how to compile pas source
%.o: %.pas
	$(PPC) $(PFLAGS) $< -o$@

# how to create the include file
nexttool_preproc.inc:
	echo '// '$@ > $@
	echo 'const' >> $@
	echo '  COMPILATION_TIMESTAMP = '\'`date`\'';' >> $@

