VER = 1.0.1.b36
NBC_SRC = nxt/nbc.dpr nxt/nbc.cfg nxt/nbc.dof nxt/nbc.res nxt/nbc.lpi nxt/mkdata.dpr nxt/mkdata.cfg nxt/mkdata.dof
NXT_SRC = nxt/uNXTClasses.pas nxt/uNXTConstants.pas nxt/uPreprocess.pas nxt/Parser10.pas nxt/P10Build.pas nxt/uRIC.pas nxt/uNXCComp.pas nxt/uRPGComp.pas nxt/uRICComp.pas nxt/uNBCCommon.pas nxt/uNBCInterface.pas
CMN_SRC = uLocalizedStrings.pas uCmdLineUtils.pas uCommonUtils.pas uGenLexer.pas uNBCLexer.pas uNXCLexer.pas uVersionInfo.pas mwGenericLex.pas ParamUtils.pas
CMN_SRC2 = FastMM4.pas FastMM4Messages.pas FastMM4Options.inc FastMove.pas FastStrings.pas
FANTOM_SRC = bricktools/FANTOM.pas bricktools/FANTOM_CONST.INC bricktools/FANTOMFPC.PAS bricktools/libusb.pas
BT_SRC = bricktools/FantomSpirit.pas bricktools/rcx_cmd.pas bricktools/rcx_constants.pas bricktools/uSpirit.pas
RIC_SRC = png/*.pas png/obj/*.obj GIFImage.pas
EXTRA_DIST = nxt/nbcunix.mak nxt/nbcdelphi.mak nxt/nbcwin32.mak nxt/nbcwincearm.mak nxt/NBCCommon.h nxt/NXTDefs.h nxt/NXCDefs.h bricxcc.mak
SAMPLES = tests/struct.nxc tests/bools.nbc tests/test.nxc tests/test.npg
DOCS = doc/Readme doc/Changelog
MANPAGES = doc/nbc.1
DISTFILES = $(NBC_SRC) $(NXT_SRC) $(CMN_SRC) $(SAMPLES) $(BT_SRC) $(FANTOM_SRC) $(RIC_SRC) $(EXTRA_DIST) $(DOCS)
UNIXFILES = $(SAMPLES) $(DOCS) $(MANPAGES) $(NBC_SRC) $(NXT_SRC) $(FANTOM_SRC)
BINDIST = nxt/nbc tests/struct.nxc $(DOCS)
OSXBINDIST = nxt/nxtcom "nxt/__MACOSX/._NBC Compile And Download via USB.app" nxt/__MACOSX/._NBCCompile.app "nxt/__MACOSX/._NXT Download via USB.app" "nxt/NBC Compile And Download via USB.app" nxt/NBCCompile.app "nxt/NXT Download via USB.app" nxt/readme_nxtcom.txt
EXCLUDES = --exclude=*.exe --exclude=*.zip --exclude=*.o --exclude=*.~* --exclude=*.dll

archivenbc:: clean
	tar -czf nbc-$(VER).src.tgz $(DISTFILES) $(EXCLUDES)
	mv nbc-$(VER).src.tgz ../nbc/beta

archivenbcbin:: clean
	tar -czf nbc-$(VER).tgz $(BINDIST)
	mv nbc-$(VER).tgz ../nbc/beta

archivenbcunix:: clean
	mv unix.mak Makefile
	mv nxt/nbcunix.mak nxt/Makefile
	tar -czf nbc-$(VER).unix-src.tgz $(UNIXFILES) Makefile nxt/Makefile
	mv Makefile unix.mak
	mv nxt/Makefile nxt/nbcunix.mak
	mv nbc-$(VER).tgz ../nbc/beta

archivenbcosx:: clean
	cd nxt
	make -f./nbcmac.mak realclean
	make -f./nbcmac.mak
	mkdir ./ppc
	mv ./nbc ./ppc/nbc
	make -f./nbcmac386.mak realclean
	make -f./nbcmac386.mak
	mkdir ./intel
	mv ./nbc ./intel/nbc
	lipo -create ./ppc/nbc ./intel/nbc -output ./nbc
	rmdir -rf ./ppc ./intel
	cd ..
	tar -czf nbc-$(VER).osx.tgz $(BINDIST) $(OSXBINDIST)
	mv nbc-$(VER).osx.tgz ../nbc/beta

archiveall:: clean
	tar -czf bricxcc.src.tgz *.* img/*.* nxt/*.* samplerate/*.* bricktools/*.* png/*.* png/obj/*.* $(EXCLUDES)

clean::
	rm -rf *.dcu *.o *.ppu *.rst *.compiled *.bak *.~* *.ddp nbc_preproc.inc

realclean:: clean
	rm -rf *.exe *.dll 

