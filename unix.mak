SHARE=/usr/share
nbc:
	cd nxt && make all

clean:
	cd nxt && make clean

realclean:
	cd nxt && make realclean

install:
	cd nxt && make install
	gzip -9 docs/nbc.1 && install -m 644 docs/nbc.1.gz $(DISTDIR)$(SHARE)/man/man1 && gzip -d docs/nbc.1.gz
