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

clean::
	rm -f *.o *.ppu *.rst *.compiled *_preproc.inc bricktools/*.o bricktools/*.ppu nxt/*.o nxt/*.ppu samplerate/*.o samplerate/*.ppu syn/*.o syn/*.ppu

realclean:: clean
	rm -f $(PROGRAMS)

midibatch:: %.dpr %_preproc.inc uMidiBatch.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nextexplorer:: %.dpr %_preproc.inc uNXTExplorer.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nextscreen:: %.dpr %_preproc.inc uNXTImage.lrs uNXTName.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtdiagnose:: %.dpr %_preproc.inc Diagnose.lrs uNXTName.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtdirect:: %.dpr %_preproc.inc Controller.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtjoy:: %.dpr %_preproc.inc JoystickUnit.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtmessage:: %.dpr %_preproc.inc MessageUnit.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtpiano:: %.dpr %_preproc.inc Piano.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtremote:: %.dpr %_preproc.inc RemoteUnit.lrs uRemoteProgMap.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

nxtwatch:: %.dpr %_preproc.inc Watch.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

wav2rso:: %.dpr %_preproc.inc uWav2RSO.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

bricxcc:: %.dpr %_preproc.inc
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

wavrsocvt: %.dpr %_preproc.inc
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
