VER = 1.2.1.r1
NBC_SRC = NXT/nbc.dpr NXT/nbc.cfg NXT/nbc.dof NXT/nbc.res NXT/mkdata.dpr NXT/mkdata.cfg NXT/mkdata.dof NXT/NBCCommon.h NXT/NXTDefs.h NXT/NXCDefs.h
NXT_SRC = NXT/uNXTClasses.pas NXT/uNXTConstants.pas NXT/uPreprocess.pas NXT/Parser10.pas NXT/P10Build.pas NXT/uRIC.pas NXT/uNXCComp.pas NXT/uRPGComp.pas NXT/uRICComp.pas NXT/uNBCCommon.pas NXT/uNBCInterface.pas
CMN_SRC = uLocalizedStrings.pas uCmdLineUtils.pas uCommonUtils.pas uGenLexer.pas uNBCLexer.pas uNXCLexer.pas uVersionInfo.pas mwGenericLex.pas ParamUtils.pas uGlobals.pas
CMN_SRC2 = FastMM4.pas FastMM4Messages.pas FastMM4Options.inc FastMove.pas FastStrings.pas
FANTOM_SRC = bricktools/FANTOM.pas bricktools/FANTOM_CONST.INC bricktools/fantomfpc.pas bricktools/fantomosx.pas bricktools/libusb.pas bricktools/FantomDefs.pas
BT_SRC = bricktools/FantomSpirit.pas bricktools/rcx_cmd.pas bricktools/rcx_constants.pas bricktools/uSpirit.pas
RIC_SRC = png/*.pas png/obj/*.obj GIFImage.pas
EXTRA_DIST = NXT/nbcunix.mak NXT/nbcdelphi.mak NXT/nbcwin32.mak NXT/nbcwincearm.mak bricxcc.mak
SAMPLES = tests/struct.nxc tests/bools.nbc tests/test.nxc tests/test.npg
DOCS = doc/Readme doc/Changelog
MANPAGES = doc/nbc.1
DISTFILES = $(NBC_SRC) $(NXT_SRC) $(CMN_SRC) $(SAMPLES) $(BT_SRC) $(FANTOM_SRC) $(RIC_SRC) $(EXTRA_DIST) $(DOCS)
UNIXFILES = $(SAMPLES) $(DOCS) $(MANPAGES) $(NBC_SRC) $(NXT_SRC) $(FANTOM_SRC) $(CMN_SRC) $(BT_SRC)
BINDIST = NXT/nbc tests/struct.nxc $(DOCS)
OSXBINDIST = NXT/nxtcom_scripts.zip
EXCLUDES = --exclude=*.exe --exclude=*.zip --exclude=*.o --exclude=*.~* --exclude=*.dll

archivenbc:: clean
	tar -czf nbc-$(VER).src.tgz $(DISTFILES) $(EXCLUDES)
	mv nbc-$(VER).src.tgz ../nbc/beta

archivenbcbin:: clean
	tar -czf nbc-$(VER).tgz $(BINDIST)
	mv nbc-$(VER).tgz ../nbc/beta

archivenbcunix:: clean
	mv unix.mak Makefile
	mv NXT/nbcunix.mak NXT/Makefile
	tar -czf nbc-$(VER).unix-src.tgz $(UNIXFILES) Makefile NXT/Makefile
	mv Makefile unix.mak
	mv NXT/Makefile NXT/nbcunix.mak
	mv nbc-$(VER).unix-src.tgz ../nbc/beta

archivenbcosx:: clean
	tar -czf nbc-$(VER).osx.tgz $(BINDIST) $(OSXBINDIST)
	mv nbc-$(VER).osx.tgz ../nbc/beta

archiveall:: clean
	tar -czf bricxcc.src.tgz *.* img/*.* NXT/*.* samplerate/*.* bricktools/*.* png/*.* png/obj/*.* grep/*.* $(EXCLUDES)

clean::
	rm -rf *.dcu *.o *.ppu *.rst *.compiled *.bak *.~* *.ddp nbc_preproc.inc

realclean:: clean
	rm -rf *.exe *.dll 

