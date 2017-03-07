include ../../Makefile.flags

all: SMif lib

SMif: 
	(cd sources/SMif; make)
	- (cd sources/SMif; cp SMif ../../../../proc)
lib:
	(cd sources/SMifResult; make)

doc:	
	(cd doc; latex SMif.tex)

clean:
	(cd doc; make clean)
	(cd sources/SMif; make clean)
	(cd sources/SMifResult; make clean )
	rm -f *~
