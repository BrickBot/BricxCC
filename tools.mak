PROGRAMS = NeXTTool
VER = 1.0.2.0
DEFAULT_INCLUDE_DIR=.

bricxcc:: bricxcc.dpr bricxcc.exe
	touch $@

nexttool:: nexttool.dpr nexttool.exe
	touch $@

nextscreen:: uNXTImage.lrs uPortPrompt.lrs nextscreen.dpr nextscreen.exe
	touch $@

nextexplorer:: nextexplorer.dpr nextexplorer.exe
	touch $@

wav2rso:: uWav2RSO.lrs wav2rso.dpr wav2rso.exe
	touch $@

wavrsocvt:: wavrsocvt.dpr wavrsocvt.exe
	touch $@

midibatch:: midibatch.dpr midibatch.exe
	touch $@

clean::
	rm -f *.o *.ppu *.rst *.compiled *_preproc.inc bricktools/*.o bricktools/*.ppu nxt/*.o nxt/*.ppu samplerate/*.o samplerate/*.ppu syn/*.o syn/*.ppu

realclean:: clean
	rm -f $(PROGRAMS) 

PFLAGS=-S2cdghi -dRELEASE -vewnhi -Fu. -Fubricktools

LFLAGS=-S2cdghi -dRELEASE -vewnhi -WG -Fu. -Fubricktools -FuNXT -Fupng -Fusyn -Fusamplerate -FuC:/lazarus/components/synedit/ -FuC:/lazarus/lcl/units/i386-win32/ -FuC:/lazarus/lcl/units/i386-win32/win32/ -FuC:/lazarus/packager/units/i386-win32/ -dLCL -dLCLgtk2 -dNXT_ONLY

# Win32
LAZRESPREFIX=C:/lazarus/tools/
PTOOLPREFIX=C:/lazarus/fpc/2.2.5/bin/i386-win32/
PPC=$(PTOOLPREFIX)fpc

wavrsocvt.exe: wavrsocvt.dpr wavrsocvt_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@

nexttool.exe: nexttool.dpr nexttool_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@

# how to link executable
%.exe: %.dpr %_preproc.inc
	$(PPC) $(LFLAGS) $< -o$@

# how to compile pas source
%.o: %.pas
	$(PPC) $(LFLAGS) $< -o$@

# how to compile resource file
%.lrs: %.lfm
	$(LAZRESPREFIX)lazres $@ $<

# how to create the include file
%_preproc.inc:
	echo '// '$@ > $@
	echo 'const' >> $@
	echo '  DEFAULT_INCLUDE_DIR = '\'$(DEFAULT_INCLUDE_DIR)\'';' >> $@
	echo '  COMPILATION_TIMESTAMP = '\'`date`\'';' >> $@

