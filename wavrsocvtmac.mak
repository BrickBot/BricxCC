PROGRAMS = wavrsocvt.exe
VER = 1.0.2.0
DOBJECTS=uCmdLineUtils.o ParamUtils.o uCommonUtils.o uWav2RsoCvt.o uVersionInfo.o wavrsocvt.dpr

all:: $(DOBJECTS) $(PROGRAMS)

clean::
	rm -f *.o *.ppu *.rst *.compiled

realclean:: clean
	rm -f $(PROGRAMS) 

PFLAGS=-S2cdghi -OG1 -gl -vewnhi -l -Fu. -Fusamplerate

# Win32
#PTOOLPREFIX=C:/lazarus/pp/bin/i386-win32/
#PPC=$(PTOOLPREFIX)ppc386.exe

# Linux
#PTOOLPREFIX=/usr/bin/
#PPC=$(PTOOLPREFIX)ppc386

# Mac OSX
PTOOLPREFIX=/usr/local/bin/
PPC=$(PTOOLPREFIX)ppcppc

# how to link executable
%.exe: %.dpr
	$(PPC) $(PFLAGS) $< -o$@

# how to compile pas source
%.o: %.pas
	$(PPC) $(PFLAGS) $< -o$@

