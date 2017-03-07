include ../Makefile.flags

CPPFLAGS=	$(RL_INCLUDE) -I. -I.. -I../include -I../../include 

all:
	if test ! -d lib; then\
	  mkdir lib;\
	fi
	(cd simer; make)
	(cd simmv; make)
	(cd simov; make)
	(cd simre; make)
	(cd simuv; make)

simcalc: 
	../bin/preV3_1.x simcalc.S simcalc.P
	../bin/preproc.x simcalc.P simcalc.c
	$(CC) $(CPPFLAGS) simcalc.c $(CFLAGS) $(LDFLAGS_SIMCALC) -o simcalc

mcotest-1: mcotest-1.c 
	$(CC) $(CPPFLAGS) mcotest-1.c $(CFLAGS) $(LDFLAGS_SIMCALC) -o mcotest-1 

t3: 
	$(CC) $(CPPFLAGS) t3.c $(CFLAGS) $(LDFLAGS_SIMCALC) -o t3 

makefiles:
	(cd simer; /bin/sh ../Makemakefile)
	(cd simmv; /bin/sh ../Makemakefile)
	(cd simov; /bin/sh ../Makemakefile)
	(cd simre; /bin/sh ../Makemakefile)
	(cd simuv; /bin/sh ../Makemakefile)

clean:
	(cd simer; make clean)
	(cd simmv; make clean)
	(cd simov; make clean)
	(cd simre; make clean)
	(cd simuv; make clean)
	rm -f simcalc.P simcalc.c
	rm -f simcalc
	rm -f *~

veryclean:
	(cd simer; make veryclean)
	(cd simmv; make veryclean)
	(cd simov; make veryclean)
	(cd simre; make veryclean)
	(cd simuv; make veryclean)


