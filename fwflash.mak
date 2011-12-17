PROGRAMS = fwflash
VER = 0.1.0.0
DOBJECTS=uCmdLineUtils.o ParamUtils.o uCommonUtils.o uWav2RsoCvt.o uVersionInfo.o fwflash.dpr
DEFAULT_INCLUDE_DIR=.

all:: $(DOBJECTS) $(PROGRAMS)

clean::
	rm -f *.o *.ppu *.rst *.compiled fwflash_preproc.inc

realclean:: clean
	rm -f $(PROGRAMS) 

PFLAGS=-S2cdghi -dRELEASE -vewnhi -l -Fu. -Fubricktools

# Win32
#PTOOLPREFIX=C:/lazarus/pp/bin/i386-win32/
#PPC=$(PTOOLPREFIX)ppc386.exe

# Linux
PTOOLPREFIX=/usr/bin/
PPC=$(PTOOLPREFIX)fpc

# how to link executable
fwflash: fwflash.dpr fwflash_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@

# how to compile pas source
%.o: %.pas
	$(PPC) $(PFLAGS) $< -o$@

# how to create the include file
fwflash_preproc.inc:
	echo '// '$@ > $@
	echo 'const' >> $@
	echo '  DEFAULT_INCLUDE_DIR = '\'$(DEFAULT_INCLUDE_DIR)\'';' >> $@
	echo '  COMPILATION_TIMESTAMP = '\'`date`\'';' >> $@



