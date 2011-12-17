PROGRAMS = libfantom.so
VER = 1.2.1.r5
DOBJECTS=fantom.dpr
FANTOM_SRC = bricktools/FANTOM.pas bricktools/FANTOM_CONST.INC bricktools/fantomfpc.pas bricktools/libusb.pas
EXCLUDES = --exclude=*.exe --exclude=*.zip --exclude=*.o --exclude=*.~* --exclude=*.dll

all:: $(DOBJECTS) $(PROGRAMS)

clean::
	rm -f *.o *.ppu *.rst *.compiled bricktools/*.o bricktools/*.ppu

realclean:: clean
	rm -f $(PROGRAMS) 

PFLAGS=-S2cdghi -dRELEASE -vewnhi -l -Fu. -Fubricktools -dNXT_ONLY

# Linux
PTOOLPREFIX=/usr/bin/
PPC=$(PTOOLPREFIX)fpc

# how to link executable
libfantom.so: fantom.dpr
	$(PPC) $(PFLAGS) $< -o$@

# how to compile pas source
%.o: %.pas
	$(PPC) $(PFLAGS) $< -o$@

