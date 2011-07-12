PROGRAMS = nexttool
VER = 1.2.1.r5

all:: $(PROGRAMS)

archive:: clean $(PROGRAMS)
	tar -czf nexttool-$(VER).tgz $(PROGRAMS)
	mv nexttool-$(VER).tgz ..

clean::
	rm -f *.o *.ppu *.rst *.compiled nexttool_preproc.inc bricktools/*.o bricktools/*.ppu NXT/*.o NXT/*.ppu

realclean:: clean
	rm -rf $(PROGRAMS) ./$(ARCH)

universal:: ./386/nexttool ./ppc/nexttool
	lipo -create $^ -output ./nexttool

PFLAGS=-S2cdghi -OG1 -gl -vewnhi -dRELEASE -l -Fu. -Fubricktools -FuNXT -k-framework -kFantom

#PTOOLPREFIX=/usr/local/bin/
ARCH=386
PPC=$(PTOOLPREFIX)ppc$(ARCH)

# how to link executable
nexttool: nexttool.dpr nexttool_preproc.inc
	$(PPC) $(PFLAGS) $< -o$@
	strip $@
	mkdir $(ARCH)
	mv $@ ./$(ARCH)

# how to compile pas source
%.o: %.pas
	$(PPC) $(PFLAGS) $< -o$@

# how to create the include file
%_preproc.inc:
	echo '// '$@ > $@
	echo 'const' >> $@
	echo '  COMPILATION_TIMESTAMP = '\'`date`\'';' >> $@

