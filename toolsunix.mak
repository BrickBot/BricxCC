LAZROOT=/usr/share/lazarus/1.0.8
LAZRESPREFIX=$(LAZROOT)/tools/
#PTOOLPREFIX=/usr/local/bin/
DEFAULT_INCLUDE_DIR=.
ARCH=386
FPC_TARGET=i386-linux
WIDGETSET=gtk2
PPC=$(PTOOLPREFIX)ppc$(ARCH)
EXTRAFLAGS=
ROOT=/usr/local/share
PSROOT=~/Desktop/pascalscript
PFLAGS=-S2cdghi -dRELEASE -vewnhi -Fu. -Fubricktools $(EXTRAFLAGS)
LFLAGS=-S2cdghi -dRELEASE -vewnhi -Fu. -Fubricktools -FuNXT -Fupng -Fusyn -Fusamplerate -Fugrep \
 -Fu$(LAZROOT)/lcl/units/$(FPC_TARGET)/ -Fu$(LAZROOT)/components/synedit/units/$(FPC_TARGET)/$(WIDGETSET)/ \
 -Fu$(LAZROOT)/lcl/units/$(FPC_TARGET)/ -Fu$(LAZROOT)/lcl/units/$(FPC_TARGET)/$(WIDGETSET)/ \
 -Fu$(LAZROOT)/packager/units/$(FPC_TARGET)/ -Fu$(PSROOT)/Source/lib/$(FPC_TARGET)/ -Fu$(PSROOT)/Source \
 -Fu$(LAZROOT)/components/lazutils/lib/$(FPC_TARGET)/ -dLCL -dLCL$(WIDGETSET) -dNXT_ONLY -dCAN_DOWNLOAD $(EXTRAFLAGS)

FORMS=uToolPalette.lrs uPortPrompt.lrs Controller.lrs Diagnose.lrs JoystickUnit.lrs uJoyActions.lrs \
 MessageUnit.lrs Piano.lrs RemoteUnit.lrs uNXTImage.lrs Watch.lrs uMIDIConversion.lrs \
 uWav2RSO.lrs MemoryUnit.lrs uRemoteProgMap.lrs uNXTName.lrs Unlock.lrs uNXTExplorer.lrs \
 uportsedit.lrs uNXTImagePrefs.lrs uEEAlignConfig.lrs uEEAlignOpt.lrs ucodeedit.lrs \
 CodeTemplates.lrs CodeUnit.lrs dlgConfirmReplace.lrs dlgReplaceText.lrs dlgSearchText.lrs \
 EditCodeTemplate.lrs GotoLine.lrs GX_ProcedureList.lrs Transdlg.lrs uCompStatus.lrs \
 uExplorerOptions.lrs uMacroEditor.lrs uCodeExplorer.lrs ConstructUnit.lrs uMacroForm.lrs \
 uVTConfig.lrs
 
clean::
	rm -f *.o *.ppu *.rst *.compiled *_preproc.inc bricktools/*.o bricktools/*.ppu nxt/*.o nxt/*.ppu samplerate/*.o samplerate/*.ppu syn/*.o syn/*.ppu grep/*.o grep/*.ppu

realclean:: clean
	rm -f $(PROGRAMS)

midibatch:: MidiBatch.dpr midibatch_preproc.inc uMidiBatch.lrs
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nextexplorer:: NeXTExplorer.dpr nextexplorer_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nextscreen:: NeXTScreen.dpr nextscreen_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nxtdiagnose:: nxtdiagnose.dpr nxtdiagnose_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nxtdirect:: nxtdirect.dpr nxtdirect_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nxtjoy:: nxtjoy.dpr nxtjoy_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nxtmessage:: nxtmessage.dpr nxtmessage_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nxtpiano:: nxtpiano.dpr nxtpiano_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nxtremote:: nxtremote.dpr nxtremote_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nxtwatch:: nxtwatch.dpr nxtwatch_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

wav2rso:: wav2rso.dpr wav2rso_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nxttools:: nxttools.dpr nxttools_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

nxtcc:: nxtcc.lpr nxtcc_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

bricxcc:: bricxcc.dpr bricxcc_preproc.inc
	$(PPC) $(LFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
	mv $@ ./$(ARCH)

wavrsocvt: wavrsocvt.dpr wavrsocvt_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@
	strip $@
	mkdir -p $(ARCH)
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
