VER = 1.0.1.b36
NBC_SRC = nxt/nbc.dpr nxt/nbc.cfg nxt/nbc.dof nxt/nbc.res nxt/nbc.lpi nxt/mkdata.dpr nxt/mkdata.cfg nxt/mkdata.dof
NXT_SRC = nxt/uNXTClasses.pas nxt/uNXTConstants.pas nxt/uPreprocess.pas nxt/Parser10.pas nxt/P10Build.pas nxt/uRIC.pas nxt/uNXCComp.pas nxt/uRPGComp.pas nxt/uRICComp.pas nxt/uNBCCommon.pas nxt/uNBCInterface.pas
CMN_SRC = uLocalizedStrings.pas uCmdLineUtils.pas uCommonUtils.pas uGenLexer.pas uNBCLexer.pas uNXCLexer.pas uVersionInfo.pas mwGenericLex.pas ParamUtils.pas
CMN_SRC2 = FastMM4.pas FastMM4Messages.pas FastMM4Options.inc FastMove.pas FastStrings.pas 
FANTOM_SRC = bricktools/FANTOM.pas bricktools/FANTOM_CONST.INC bricktools/FANTOMFPC.PAS bricktools/libusb.pas
BT_SRC = bricktools/FantomSpirit.pas bricktools/rcx_cmd.pas bricktools/rcx_constants.pas bricktools/uSpirit.pas
RIC_SRC = png/*.pas png/obj/*.obj GIFImage.pas
EXTRA_DIST = nxt/nbclinux.mak nxt/nbcmac.mak nxt/nbcfreebsd.mak nxt/nbcdelphi.mak nxt/nbcwin32.mak nxt/nbcwincearm.mak nxt/NBCCommon.h nxt/NXTDefs.h nxt/NXCDefs.h bricxcc.mak nxt/history.txt nxt/readme.txt
SAMPLES = tests/struct.nxc tests/bools.nbc tests/test.nxc tests/test.npg 
DISTFILES = $(NBC_SRC) $(NXT_SRC) $(CMN_SRC) $(SAMPLES) $(BT_SRC) $(FANTOM_SRC) $(RIC_SRC) $(EXTRA_DIST)
BINDIST = nxt/nbc nxt/history.txt nxt/readme.txt tests/struct.nxc
OSXBINDIST = nxt/nxtcom "nxt/__MACOSX/._NBC Compile And Download via USB.app" nxt/__MACOSX/._NBCCompile.app "nxt/__MACOSX/._NXT Download via USB.app" "nxt/NBC Compile And Download via USB.app" nxt/NBCCompile.app "nxt/NXT Download via USB.app" nxt/readme_nxtcom.txt
EXCLUDES = --exclude=*.exe --exclude=*.zip --exclude=*.o --exclude=*.~* --exclude=*.dll

archivenbc:: clean
	tar -czf nbc-$(VER).src.tgz $(DISTFILES) $(EXCLUDES)
	mv nbc-$(VER).src.tgz ../nbc/beta

archivenbcbin:: clean
	tar -czf nbc-$(VER).tgz $(BINDIST)
	mv nbc-$(VER).tgz ../nbc/beta

archivenbcosx::
	tar -czf nbc-$(VER).osx.tgz $(BINDIST) $(OSXBINDIST)
	mv nbc-$(VER).osx.tgz ../nbc/beta

archiveall:: clean
	tar -czf bricxcc.src.tgz *.* img/*.* nxt/*.* samplerate/*.* bricktools/*.* png/*.* png/obj/*.* $(EXCLUDES)

clean::
	rm -rf *.dcu *.o *.ppu *.rst *.compiled *.bak *.~* *.ddp nbc_preproc.inc

realclean:: clean
	rm -rf *.exe *.dll 

