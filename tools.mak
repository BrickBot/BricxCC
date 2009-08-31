FPC_TARGET=i386-win32
WIDGETSET=win32
ARCH=386
LAZRESPREFIX=c:/lazarus/tools/
PTOOLPREFIX= c:/lazarus/fpc/2.2.5/bin/$(FPC_TARGET)/
DEFAULT_INCLUDE_DIR=.
PPC=$(PTOOLPREFIX)ppc$(ARCH)
#EXTRAFLAGS=-k-framework -kFantom
ROOT=c:
PFLAGS=-S2cdghi -dRELEASE -vewnhi -Fu. -Fubricktools $(EXTRAFLAGS)
LFLAGS=-S2cdghi -dRELEASE -vewnhi -Fu. -Fubricktools -FuNXT -Fupng -Fusyn -Fusamplerate -Fu$(ROOT)/lazarus/components/synedit/units/$(FPC_TARGET)/ -Fu$(ROOT)/lazarus/lcl/units/$(FPC_TARGET)/ -Fu$(ROOT)/lazarus/lcl/units/$(FPC_TARGET)/$(WIDGETSET)/ -Fu$(ROOT)/lazarus/packager/units/$(FPC_TARGET)/ -dLCL -dLCL$(WIDGETSET) -dNXT_ONLY $(EXTRAFLAGS)

FORMS=uToolPalette.lrs uPortPrompt.lrs Controller.lrs Diagnose.lrs JoystickUnit.lrs \
 MessageUnit.lrs Piano.lrs RemoteUnit.lrs uNXTExplorer.lrs uNXTImage.lrs Watch.lrs uMIDIConversion.lrs \
 uWav2RSO.lrs MemoryUnit.lrs uRemoteProgMap.lrs uNXTName.lrs Unlock.lrs

clean::
	rm -f *.o *.ppu *.rst *.compiled *_preproc.inc bricktools/*.o bricktools/*.ppu nxt/*.o nxt/*.ppu samplerate/*.o samplerate/*.ppu syn/*.o syn/*.ppu

realclean:: clean
	rm -f $(PROGRAMS) 

wavrsocvt:: wavrsocvt.dpr wavrsocvt.exe
	touch $@

midibatch:: uMidiBatch.lrs midibatch.dpr midibatch.exe
	touch $@

nextexplorer:: uNXTExplorer.lrs nextexplorer.dpr nextexplorer.exe
	touch $@

nextscreen:: uNXTImage.lrs uNXTName.lrs uPortPrompt.lrs nextscreen.dpr nextscreen.exe
	touch $@

nxtdiagnose:: Diagnose.lrs uNXTName.lrs uPortPrompt.lrs nxtdiagnose.dpr nxtdiagnose.exe
	touch $@

nxtdirect:: Controller.lrs uPortPrompt.lrs nxtdirect.dpr nxtdirect.exe
	touch $@

nxtjoy:: JoystickUnit.lrs uPortPrompt.lrs nxtjoy.dpr nxtjoy.exe
	touch $@

nxtmessage:: MessageUnit.lrs uPortPrompt.lrs nxtmessage.dpr nxtmessage.exe
	touch $@

nxtpiano:: Piano.lrs uPortPrompt.lrs nxtpiano.dpr nxtpiano.exe
	touch $@

nxtremote:: RemoteUnit.lrs uRemoteProgMap.lrs uPortPrompt.lrs nxtremote.dpr nxtremote.exe
	touch $@

nxtwatch:: Watch.lrs uPortPrompt.lrs nxtwatch.dpr nxtwatch.exe
	touch $@

nxttools:: $(FORMS) nxttools.dpr nxttools.exe
	touch $@

wav2rso:: uWav2RSO.lrs wav2rso.dpr wav2rso.exe
	touch $@

bricxcc:: bricxcc.dpr bricxcc.exe
	touch $@

wavrsocvt.exe: wavrsocvt.dpr wavrsocvt_preproc.inc
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
