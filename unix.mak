SHARE=/usr/share
nbc:
	cd NXT && make all

clean:
	cd NXT && make clean

realclean:
	cd NXT && make realclean

install:
	cd NXT && make install
	gzip -9 doc/nbc.1 && install -m 644 doc/nbc.1.gz $(DISTDIR)$(SHARE)/man/man1 && gzip -d doc/nbc.1.gz
