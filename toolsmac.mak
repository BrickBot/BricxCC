#LAZRESPREFIX=/usr/local/bin/
#PTOOLPREFIX=/usr/local/bin/
DEFAULT_INCLUDE_DIR=.
FPC_TARGET=powerpc-darwin
WIDGETSET=carbon
ARCH=386
PPC=$(PTOOLPREFIX)ppc$(ARCH)
EXTRAFLAGS=-k-framework -kFantom
ROOT=/usr/local/share
PFLAGS=-S2cdghi -dRELEASE -vewnhi -Fu. -Fubricktools $(EXTRAFLAGS)
LFLAGS=-S2cdghi -dRELEASE -vewnhi -Fu. -Fubricktools -FuNXT -Fupng -Fusyn -Fusamplerate -Fu$(ROOT)/lazarus/components/synedit/units/$(FPC_TARGET)/ -Fu$(ROOT)/lazarus/lcl/units/$(FPC_TARGET)/ -Fu$(ROOT)/lazarus/lcl/units/$(FPC_TARGET)/$(WIDGETSET)/ -Fu$(ROOT)/lazarus/packager/units/$(FPC_TARGET)/ -dLCL -dLCL$(WIDGETSET) -dNXT_ONLY $(EXTRAFLAGS)

FORMS=uToolPalette.lrs uPortPrompt.lrs Controller.lrs Diagnose.lrs JoystickUnit.lrs \
 MessageUnit.lrs Piano.lrs RemoteUnit.lrs uNXTExplorer.lrs uNXTImage.lrs Watch.lrs uMIDIConversion.lrs \
 uWav2RSO.lrs MemoryUnit.lrs

clean::
	rm -f *.o *.ppu *.rst *.compiled *_preproc.inc bricktools/*.o bricktools/*.ppu nxt/*.o nxt/*.ppu samplerate/*.o samplerate/*.ppu syn/*.o syn/*.ppu

realclean:: clean
	rm -f $(PROGRAMS)

midibatch:: midibatch.dpr midibatch_preproc.inc uMidiBatch.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nextexplorer:: nextexplorer.dpr nextexplorer_preproc.inc uNXTExplorer.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nextscreen:: nextscreen.dpr nextscreen_preproc.inc uNXTImage.lrs uNXTName.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtdiagnose:: nxtdiagnose.dpr nxtdiagnose_preproc.inc Diagnose.lrs uNXTName.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtdirect:: nxtdirect.dpr nxtdirect_preproc.inc Controller.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtjoy:: nxtjoy.dpr nxtjoy_preproc.inc JoystickUnit.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtmessage:: nxtmessage.dpr nxtmessage_preproc.inc MessageUnit.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtpiano:: nxtpiano.dpr nxtpiano_preproc.inc Piano.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtremote:: nxtremote.dpr nxtremote_preproc.inc RemoteUnit.lrs uRemoteProgMap.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtwatch:: nxtwatch.dpr nxtwatch_preproc.inc Watch.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

wav2rso:: wav2rso.dpr wav2rso_preproc.inc uWav2RSO.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxttools:: nxttools.dpr nxttools_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

bricxcc:: bricxcc.dpr bricxcc_preproc.inc
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

wavrsocvt: wavrsocvt.dpr wavrsocvt_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

%.u: ./386/% ./ppc/%
	lipo -create $^ -output $@

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
