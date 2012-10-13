PROGRAMS = wavrsocvt.exe

DEFAULT_INCLUDE_DIR=.
ARCH=x64
FPC_TARGET=x86_64-win64
WIDGETSET=win32

# Win32
LAZRESPREFIX=C:/lazarus/tools/
PTOOLPREFIX=C:/lazarus/fpc/2.6.0/bin/$(FPC_TARGET)/
PPC=$(PTOOLPREFIX)ppc$(ARCH)
PSROOT=C:/winapps/pscript
LAZROOT=C:/lazarus

EXTRAFLAGS=
PFLAGS=-S2cdghi -dRELEASE -vewnhi -Fu. -Fubricktools -FuNXT -dNXT_ONLY -dCAN_DOWNLOAD $(EXTRAFLAGS)
LFLAGS=-S2cdghi -dRELEASE -vewnhi -Fu. -Fubricktools -FuNXT -Fupng -Fusyn -Fusamplerate \
 -Fugrep -Fu$(LAZROOT)/lcl/units/$(FPC_TARGET)/ -Fu$(LAZROOT)/components/lazutils/lib/$(FPC_TARGET)/ \
 -Fu$(LAZROOT)/components/synedit/units/$(FPC_TARGET)/$(WIDGETSET)/ -Fu$(LAZROOT)/lcl/units/$(FPC_TARGET)/ \
 -Fu$(LAZROOT)/lcl/units/$(FPC_TARGET)/$(WIDGETSET)/ -Fu$(LAZROOT)/packager/units/$(FPC_TARGET)/ \
 -Fu$(PSROOT)/Source/ -dLCL -dLCL$(WIDGETSET) -dNXT_ONLY -dCAN_DOWNLOAD $(EXTRAFLAGS)

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

midibatch.exe:: MidiBatch.dpr midibatch_preproc.inc uMidiBatch.lrs
	$(PPC) $(LFLAGS) $< -o$@

nextexplorer.exe:: NeXTExplorer.dpr nextexplorer_preproc.inc uNXTExplorer.lrs
	$(PPC) $(LFLAGS) $< -o$@

nextscreen.exe:: NeXTScreen.dpr nextscreen_preproc.inc uNXTImage.lrs uNXTName.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@

nxtdiagnose.exe:: nxtdiagnose.dpr nxtdiagnose_preproc.inc Diagnose.lrs uNXTName.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@

nxtdirect.exe:: nxtdirect.dpr nxtdirect_preproc.inc Controller.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@

nxtjoy.exe:: nxtjoy.dpr nxtjoy_preproc.inc JoystickUnit.lrs uPortPrompt.lrs uJoyActions.lrs
	$(PPC) $(LFLAGS) $< -o$@

nxtmessage.exe:: nxtmessage.dpr nxtmessage_preproc.inc MessageUnit.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@

nxtpiano.exe:: nxtpiano.dpr nxtpiano_preproc.inc Piano.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@

nxtremote.exe:: nxtremote.dpr nxtremote_preproc.inc RemoteUnit.lrs uRemoteProgMap.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@

nxtwatch.exe:: nxtwatch.dpr nxtwatch_preproc.inc Watch.lrs uPortPrompt.lrs
	$(PPC) $(LFLAGS) $< -o$@

wav2rso.exe:: wav2rso.dpr wav2rso_preproc.inc uWav2RSO.lrs
	$(PPC) $(LFLAGS) $< -o$@

nxttools.exe:: nxttools.dpr nxttools_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@

nxtcc.exe:: nxtcc.lpr nxtcc_preproc.inc $(FORMS)
	$(PPC) $(LFLAGS) $< -o$@

bricxcc.exe:: bricxcc.dpr bricxcc_preproc.inc
	$(PPC) $(LFLAGS) $< -o$@

wavrsocvt.exe: wavrsocvt.dpr wavrsocvt_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@

nexttool.exe: NeXTTool.dpr nexttool_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@

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
