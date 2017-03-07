include ../../Makefile.flags


all: \
	artovar.o \
	ausgabe.o \
	ausgfunc.o \
	basad.o \
	calc_ausw.o \
	calc_bprod.o \
	calc_bsum.o \
	calc_cgf2b.o \
	calc_curgf.o \
	calc_decl.o \
	calc_dowhile.o \
	calc_fclose.o \
	calc_fgets.o \
	calc_fgetsp.o \
	calc_fload.o \
	calc_fopen.o \
	calc_for.o \
	calc_forpr.o \
	calc_forstep.o \
	calc_fread.o \
	calc_if.o \
	calc_print.o \
	calc_while.o \
	ctest.o \
	einzinf.o \
	errstop.o \
	feval.o \
	fileaus.o \
	funccl1.o \
	funccl2.o \
	funccl_GF2b.o \
	funccl_btoi.o \
	funccl_cgf2b.o \
	funccl_curgf.o \
	funccl_curnf.o \
	funccl_htoi.o \
	funccl_otoi.o \
	getline.o \
	inform.o \
	invect.o \
	invectsp.o \
	invsploc.o \
	isalsc.o \
	ispolvar.o \
	issc.o \
	istyp.o \
	localback.o \
	loeaok.o \
	loee.o \
	loem.o \
	loesche.o \
	muster.o \
	osloesche.o \
	protkopf.o \
	proton.o \
	rechnung.o \
	schleiaus.o \
	schleiback.o \
	scr_page.o \
	seqbasad.o \
	sortaus.o \
	sortausloc.o \
	sortfunc.o \
	sortfuncloc.o \
	stellen.o \
	structin.o \
	structsort.o \
	subst.o \
	typprint.o \
	val.o \
	xfgetc.o \
	ranlib


clean:
	rm -f *~
	rm -f artovar.o
	rm -f ausgabe.o
	rm -f ausgfunc.o
	rm -f basad.o
	rm -f calc_ausw.o
	rm -f calc_bprod.o
	rm -f calc_bsum.o
	rm -f calc_cgf2b.o
	rm -f calc_curgf.o
	rm -f calc_decl.o
	rm -f calc_dowhile.o
	rm -f calc_fclose.o
	rm -f calc_fgets.o
	rm -f calc_fgetsp.o
	rm -f calc_fload.o
	rm -f calc_fopen.o
	rm -f calc_for.o
	rm -f calc_forpr.o
	rm -f calc_forstep.o
	rm -f calc_fread.o
	rm -f calc_if.o
	rm -f calc_print.o
	rm -f calc_while.o
	rm -f ctest.o
	rm -f einzinf.o
	rm -f errstop.o
	rm -f feval.o
	rm -f fileaus.o
	rm -f funccl1.o
	rm -f funccl2.o
	rm -f funccl_GF2b.o
	rm -f funccl_btoi.o
	rm -f funccl_cgf2b.o
	rm -f funccl_curgf.o
	rm -f funccl_curnf.o
	rm -f funccl_htoi.o
	rm -f funccl_otoi.o
	rm -f getline.o
	rm -f inform.o
	rm -f invect.o
	rm -f invectsp.o
	rm -f invsploc.o
	rm -f isalsc.o
	rm -f ispolvar.o
	rm -f issc.o
	rm -f istyp.o
	rm -f localback.o
	rm -f loeaok.o
	rm -f loee.o
	rm -f loem.o
	rm -f loesche.o
	rm -f muster.o
	rm -f osloesche.o
	rm -f protkopf.o
	rm -f proton.o
	rm -f rechnung.o
	rm -f schleiaus.o
	rm -f schleiback.o
	rm -f scr_page.o
	rm -f seqbasad.o
	rm -f sortaus.o
	rm -f sortausloc.o
	rm -f sortfunc.o
	rm -f sortfuncloc.o
	rm -f stellen.o
	rm -f structin.o
	rm -f structsort.o
	rm -f subst.o
	rm -f typprint.o
	rm -f val.o
	rm -f xfgetc.o


veryclean: clean
	rm -f ../lib/libsimov.a



artovar.o: \
	artovar.S
	../../bin/preV3_1.x artovar.S artovar.P
	../../bin/preproc.x artovar.P artovar.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o artovar.o artovar.c
	rm -f artovar.c artovar.P
	ar rv ../lib/libsimov.a artovar.o

ausgabe.o: \
	ausgabe.S
	../../bin/preV3_1.x ausgabe.S ausgabe.P
	../../bin/preproc.x ausgabe.P ausgabe.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ausgabe.o ausgabe.c
	rm -f ausgabe.c ausgabe.P
	ar rv ../lib/libsimov.a ausgabe.o

ausgfunc.o: \
	ausgfunc.S
	../../bin/preV3_1.x ausgfunc.S ausgfunc.P
	../../bin/preproc.x ausgfunc.P ausgfunc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ausgfunc.o ausgfunc.c
	rm -f ausgfunc.c ausgfunc.P
	ar rv ../lib/libsimov.a ausgfunc.o

basad.o: \
	basad.S
	../../bin/preV3_1.x basad.S basad.P
	../../bin/preproc.x basad.P basad.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o basad.o basad.c
	rm -f basad.c basad.P
	ar rv ../lib/libsimov.a basad.o

calc_ausw.o: \
	calc_ausw.S
	../../bin/preV3_1.x calc_ausw.S calc_ausw.P
	../../bin/preproc.x calc_ausw.P calc_ausw.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_ausw.o calc_ausw.c
	rm -f calc_ausw.c calc_ausw.P
	ar rv ../lib/libsimov.a calc_ausw.o

calc_bprod.o: \
	calc_bprod.S
	../../bin/preV3_1.x calc_bprod.S calc_bprod.P
	../../bin/preproc.x calc_bprod.P calc_bprod.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_bprod.o calc_bprod.c
	rm -f calc_bprod.c calc_bprod.P
	ar rv ../lib/libsimov.a calc_bprod.o

calc_bsum.o: \
	calc_bsum.S
	../../bin/preV3_1.x calc_bsum.S calc_bsum.P
	../../bin/preproc.x calc_bsum.P calc_bsum.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_bsum.o calc_bsum.c
	rm -f calc_bsum.c calc_bsum.P
	ar rv ../lib/libsimov.a calc_bsum.o

calc_cgf2b.o: \
	calc_cgf2b.S
	../../bin/preV3_1.x calc_cgf2b.S calc_cgf2b.P
	../../bin/preproc.x calc_cgf2b.P calc_cgf2b.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_cgf2b.o calc_cgf2b.c
	rm -f calc_cgf2b.c calc_cgf2b.P
	ar rv ../lib/libsimov.a calc_cgf2b.o

calc_curgf.o: \
	calc_curgf.S
	../../bin/preV3_1.x calc_curgf.S calc_curgf.P
	../../bin/preproc.x calc_curgf.P calc_curgf.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_curgf.o calc_curgf.c
	rm -f calc_curgf.c calc_curgf.P
	ar rv ../lib/libsimov.a calc_curgf.o

calc_decl.o: \
	calc_decl.S
	../../bin/preV3_1.x calc_decl.S calc_decl.P
	../../bin/preproc.x calc_decl.P calc_decl.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_decl.o calc_decl.c
	rm -f calc_decl.c calc_decl.P
	ar rv ../lib/libsimov.a calc_decl.o

calc_dowhile.o: \
	calc_dowhile.S
	../../bin/preV3_1.x calc_dowhile.S calc_dowhile.P
	../../bin/preproc.x calc_dowhile.P calc_dowhile.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_dowhile.o calc_dowhile.c
	rm -f calc_dowhile.c calc_dowhile.P
	ar rv ../lib/libsimov.a calc_dowhile.o

calc_fclose.o: \
	calc_fclose.S
	../../bin/preV3_1.x calc_fclose.S calc_fclose.P
	../../bin/preproc.x calc_fclose.P calc_fclose.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_fclose.o calc_fclose.c
	rm -f calc_fclose.c calc_fclose.P
	ar rv ../lib/libsimov.a calc_fclose.o

calc_fgets.o: \
	calc_fgets.S
	../../bin/preV3_1.x calc_fgets.S calc_fgets.P
	../../bin/preproc.x calc_fgets.P calc_fgets.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_fgets.o calc_fgets.c
	rm -f calc_fgets.c calc_fgets.P
	ar rv ../lib/libsimov.a calc_fgets.o

calc_fgetsp.o: \
	calc_fgetsp.S
	../../bin/preV3_1.x calc_fgetsp.S calc_fgetsp.P
	../../bin/preproc.x calc_fgetsp.P calc_fgetsp.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_fgetsp.o calc_fgetsp.c
	rm -f calc_fgetsp.c calc_fgetsp.P
	ar rv ../lib/libsimov.a calc_fgetsp.o

calc_fload.o: \
	calc_fload.S
	../../bin/preV3_1.x calc_fload.S calc_fload.P
	../../bin/preproc.x calc_fload.P calc_fload.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_fload.o calc_fload.c
	rm -f calc_fload.c calc_fload.P
	ar rv ../lib/libsimov.a calc_fload.o

calc_fopen.o: \
	calc_fopen.S
	../../bin/preV3_1.x calc_fopen.S calc_fopen.P
	../../bin/preproc.x calc_fopen.P calc_fopen.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_fopen.o calc_fopen.c
	rm -f calc_fopen.c calc_fopen.P
	ar rv ../lib/libsimov.a calc_fopen.o

calc_for.o: \
	calc_for.S
	../../bin/preV3_1.x calc_for.S calc_for.P
	../../bin/preproc.x calc_for.P calc_for.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_for.o calc_for.c
	rm -f calc_for.c calc_for.P
	ar rv ../lib/libsimov.a calc_for.o

calc_forpr.o: \
	calc_forpr.S
	../../bin/preV3_1.x calc_forpr.S calc_forpr.P
	../../bin/preproc.x calc_forpr.P calc_forpr.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_forpr.o calc_forpr.c
	rm -f calc_forpr.c calc_forpr.P
	ar rv ../lib/libsimov.a calc_forpr.o

calc_forstep.o: \
	calc_forstep.S
	../../bin/preV3_1.x calc_forstep.S calc_forstep.P
	../../bin/preproc.x calc_forstep.P calc_forstep.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_forstep.o calc_forstep.c
	rm -f calc_forstep.c calc_forstep.P
	ar rv ../lib/libsimov.a calc_forstep.o

calc_fread.o: \
	calc_fread.S
	../../bin/preV3_1.x calc_fread.S calc_fread.P
	../../bin/preproc.x calc_fread.P calc_fread.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_fread.o calc_fread.c
	rm -f calc_fread.c calc_fread.P
	ar rv ../lib/libsimov.a calc_fread.o

calc_if.o: \
	calc_if.S
	../../bin/preV3_1.x calc_if.S calc_if.P
	../../bin/preproc.x calc_if.P calc_if.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_if.o calc_if.c
	rm -f calc_if.c calc_if.P
	ar rv ../lib/libsimov.a calc_if.o

calc_print.o: \
	calc_print.S
	../../bin/preV3_1.x calc_print.S calc_print.P
	../../bin/preproc.x calc_print.P calc_print.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_print.o calc_print.c
	rm -f calc_print.c calc_print.P
	ar rv ../lib/libsimov.a calc_print.o

calc_while.o: \
	calc_while.S
	../../bin/preV3_1.x calc_while.S calc_while.P
	../../bin/preproc.x calc_while.P calc_while.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o calc_while.o calc_while.c
	rm -f calc_while.c calc_while.P
	ar rv ../lib/libsimov.a calc_while.o

ctest.o: \
	ctest.S
	../../bin/preV3_1.x ctest.S ctest.P
	../../bin/preproc.x ctest.P ctest.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ctest.o ctest.c
	rm -f ctest.c ctest.P
	ar rv ../lib/libsimov.a ctest.o

einzinf.o: \
	einzinf.S
	../../bin/preV3_1.x einzinf.S einzinf.P
	../../bin/preproc.x einzinf.P einzinf.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o einzinf.o einzinf.c
	rm -f einzinf.c einzinf.P
	ar rv ../lib/libsimov.a einzinf.o

errstop.o: \
	errstop.S
	../../bin/preV3_1.x errstop.S errstop.P
	../../bin/preproc.x errstop.P errstop.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o errstop.o errstop.c
	rm -f errstop.c errstop.P
	ar rv ../lib/libsimov.a errstop.o

feval.o: \
	feval.S
	../../bin/preV3_1.x feval.S feval.P
	../../bin/preproc.x feval.P feval.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o feval.o feval.c
	rm -f feval.c feval.P
	ar rv ../lib/libsimov.a feval.o

fileaus.o: \
	fileaus.S
	../../bin/preV3_1.x fileaus.S fileaus.P
	../../bin/preproc.x fileaus.P fileaus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fileaus.o fileaus.c
	rm -f fileaus.c fileaus.P
	ar rv ../lib/libsimov.a fileaus.o

funccl1.o: \
	funccl1.S
	../../bin/preV3_1.x funccl1.S funccl1.P
	../../bin/preproc.x funccl1.P funccl1.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o funccl1.o funccl1.c
	rm -f funccl1.c funccl1.P
	ar rv ../lib/libsimov.a funccl1.o

funccl2.o: \
	funccl2.S
	../../bin/preV3_1.x funccl2.S funccl2.P
	../../bin/preproc.x funccl2.P funccl2.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o funccl2.o funccl2.c
	rm -f funccl2.c funccl2.P
	ar rv ../lib/libsimov.a funccl2.o

funccl_GF2b.o: \
	funccl_GF2b.S
	../../bin/preV3_1.x funccl_GF2b.S funccl_GF2b.P
	../../bin/preproc.x funccl_GF2b.P funccl_GF2b.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o funccl_GF2b.o funccl_GF2b.c
	rm -f funccl_GF2b.c funccl_GF2b.P
	ar rv ../lib/libsimov.a funccl_GF2b.o

funccl_btoi.o: \
	funccl_btoi.S
	../../bin/preV3_1.x funccl_btoi.S funccl_btoi.P
	../../bin/preproc.x funccl_btoi.P funccl_btoi.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o funccl_btoi.o funccl_btoi.c
	rm -f funccl_btoi.c funccl_btoi.P
	ar rv ../lib/libsimov.a funccl_btoi.o

funccl_cgf2b.o: \
	funccl_cgf2b.S
	../../bin/preV3_1.x funccl_cgf2b.S funccl_cgf2b.P
	../../bin/preproc.x funccl_cgf2b.P funccl_cgf2b.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o funccl_cgf2b.o funccl_cgf2b.c
	rm -f funccl_cgf2b.c funccl_cgf2b.P
	ar rv ../lib/libsimov.a funccl_cgf2b.o

funccl_curgf.o: \
	funccl_curgf.S
	../../bin/preV3_1.x funccl_curgf.S funccl_curgf.P
	../../bin/preproc.x funccl_curgf.P funccl_curgf.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o funccl_curgf.o funccl_curgf.c
	rm -f funccl_curgf.c funccl_curgf.P
	ar rv ../lib/libsimov.a funccl_curgf.o

funccl_curnf.o: \
	funccl_curnf.S
	../../bin/preV3_1.x funccl_curnf.S funccl_curnf.P
	../../bin/preproc.x funccl_curnf.P funccl_curnf.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o funccl_curnf.o funccl_curnf.c
	rm -f funccl_curnf.c funccl_curnf.P
	ar rv ../lib/libsimov.a funccl_curnf.o

funccl_htoi.o: \
	funccl_htoi.S
	../../bin/preV3_1.x funccl_htoi.S funccl_htoi.P
	../../bin/preproc.x funccl_htoi.P funccl_htoi.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o funccl_htoi.o funccl_htoi.c
	rm -f funccl_htoi.c funccl_htoi.P
	ar rv ../lib/libsimov.a funccl_htoi.o

funccl_otoi.o: \
	funccl_otoi.S
	../../bin/preV3_1.x funccl_otoi.S funccl_otoi.P
	../../bin/preproc.x funccl_otoi.P funccl_otoi.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o funccl_otoi.o funccl_otoi.c
	rm -f funccl_otoi.c funccl_otoi.P
	ar rv ../lib/libsimov.a funccl_otoi.o

getline.o: \
	getline.S
	../../bin/preV3_1.x getline.S getline.P
	../../bin/preproc.x getline.P getline.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o getline.o getline.c
	rm -f getline.c getline.P
	ar rv ../lib/libsimov.a getline.o

inform.o: \
	inform.S
	../../bin/preV3_1.x inform.S inform.P
	../../bin/preproc.x inform.P inform.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o inform.o inform.c
	rm -f inform.c inform.P
	ar rv ../lib/libsimov.a inform.o

invect.o: \
	invect.S
	../../bin/preV3_1.x invect.S invect.P
	../../bin/preproc.x invect.P invect.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o invect.o invect.c
	rm -f invect.c invect.P
	ar rv ../lib/libsimov.a invect.o

invectsp.o: \
	invectsp.S
	../../bin/preV3_1.x invectsp.S invectsp.P
	../../bin/preproc.x invectsp.P invectsp.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o invectsp.o invectsp.c
	rm -f invectsp.c invectsp.P
	ar rv ../lib/libsimov.a invectsp.o

invsploc.o: \
	invsploc.S
	../../bin/preV3_1.x invsploc.S invsploc.P
	../../bin/preproc.x invsploc.P invsploc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o invsploc.o invsploc.c
	rm -f invsploc.c invsploc.P
	ar rv ../lib/libsimov.a invsploc.o

isalsc.o: \
	isalsc.S
	../../bin/preV3_1.x isalsc.S isalsc.P
	../../bin/preproc.x isalsc.P isalsc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o isalsc.o isalsc.c
	rm -f isalsc.c isalsc.P
	ar rv ../lib/libsimov.a isalsc.o

ispolvar.o: \
	ispolvar.S
	../../bin/preV3_1.x ispolvar.S ispolvar.P
	../../bin/preproc.x ispolvar.P ispolvar.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ispolvar.o ispolvar.c
	rm -f ispolvar.c ispolvar.P
	ar rv ../lib/libsimov.a ispolvar.o

issc.o: \
	issc.S
	../../bin/preV3_1.x issc.S issc.P
	../../bin/preproc.x issc.P issc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o issc.o issc.c
	rm -f issc.c issc.P
	ar rv ../lib/libsimov.a issc.o

istyp.o: \
	istyp.S
	../../bin/preV3_1.x istyp.S istyp.P
	../../bin/preproc.x istyp.P istyp.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o istyp.o istyp.c
	rm -f istyp.c istyp.P
	ar rv ../lib/libsimov.a istyp.o

localback.o: \
	localback.S
	../../bin/preV3_1.x localback.S localback.P
	../../bin/preproc.x localback.P localback.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o localback.o localback.c
	rm -f localback.c localback.P
	ar rv ../lib/libsimov.a localback.o

loeaok.o: \
	loeaok.S
	../../bin/preV3_1.x loeaok.S loeaok.P
	../../bin/preproc.x loeaok.P loeaok.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o loeaok.o loeaok.c
	rm -f loeaok.c loeaok.P
	ar rv ../lib/libsimov.a loeaok.o

loee.o: \
	loee.S
	../../bin/preV3_1.x loee.S loee.P
	../../bin/preproc.x loee.P loee.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o loee.o loee.c
	rm -f loee.c loee.P
	ar rv ../lib/libsimov.a loee.o

loem.o: \
	loem.S
	../../bin/preV3_1.x loem.S loem.P
	../../bin/preproc.x loem.P loem.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o loem.o loem.c
	rm -f loem.c loem.P
	ar rv ../lib/libsimov.a loem.o

loesche.o: \
	loesche.S
	../../bin/preV3_1.x loesche.S loesche.P
	../../bin/preproc.x loesche.P loesche.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o loesche.o loesche.c
	rm -f loesche.c loesche.P
	ar rv ../lib/libsimov.a loesche.o

muster.o: \
	muster.S
	../../bin/preV3_1.x muster.S muster.P
	../../bin/preproc.x muster.P muster.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o muster.o muster.c
	rm -f muster.c muster.P
	ar rv ../lib/libsimov.a muster.o

osloesche.o: \
	osloesche.S
	../../bin/preV3_1.x osloesche.S osloesche.P
	../../bin/preproc.x osloesche.P osloesche.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o osloesche.o osloesche.c
	rm -f osloesche.c osloesche.P
	ar rv ../lib/libsimov.a osloesche.o

protkopf.o: \
	protkopf.S
	../../bin/preV3_1.x protkopf.S protkopf.P
	../../bin/preproc.x protkopf.P protkopf.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o protkopf.o protkopf.c
	rm -f protkopf.c protkopf.P
	ar rv ../lib/libsimov.a protkopf.o

proton.o: \
	proton.S
	../../bin/preV3_1.x proton.S proton.P
	../../bin/preproc.x proton.P proton.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o proton.o proton.c
	rm -f proton.c proton.P
	ar rv ../lib/libsimov.a proton.o

rechnung.o: \
	rechnung.S
	../../bin/preV3_1.x rechnung.S rechnung.P
	../../bin/preproc.x rechnung.P rechnung.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o rechnung.o rechnung.c
	rm -f rechnung.c rechnung.P
	ar rv ../lib/libsimov.a rechnung.o

schleiaus.o: \
	schleiaus.S
	../../bin/preV3_1.x schleiaus.S schleiaus.P
	../../bin/preproc.x schleiaus.P schleiaus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o schleiaus.o schleiaus.c
	rm -f schleiaus.c schleiaus.P
	ar rv ../lib/libsimov.a schleiaus.o

schleiback.o: \
	schleiback.S
	../../bin/preV3_1.x schleiback.S schleiback.P
	../../bin/preproc.x schleiback.P schleiback.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o schleiback.o schleiback.c
	rm -f schleiback.c schleiback.P
	ar rv ../lib/libsimov.a schleiback.o

scr_page.o: \
	scr_page.S
	../../bin/preV3_1.x scr_page.S scr_page.P
	../../bin/preproc.x scr_page.P scr_page.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o scr_page.o scr_page.c
	rm -f scr_page.c scr_page.P
	ar rv ../lib/libsimov.a scr_page.o

seqbasad.o: \
	seqbasad.S
	../../bin/preV3_1.x seqbasad.S seqbasad.P
	../../bin/preproc.x seqbasad.P seqbasad.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o seqbasad.o seqbasad.c
	rm -f seqbasad.c seqbasad.P
	ar rv ../lib/libsimov.a seqbasad.o

sortaus.o: \
	sortaus.S
	../../bin/preV3_1.x sortaus.S sortaus.P
	../../bin/preproc.x sortaus.P sortaus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o sortaus.o sortaus.c
	rm -f sortaus.c sortaus.P
	ar rv ../lib/libsimov.a sortaus.o

sortausloc.o: \
	sortausloc.S
	../../bin/preV3_1.x sortausloc.S sortausloc.P
	../../bin/preproc.x sortausloc.P sortausloc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o sortausloc.o sortausloc.c
	rm -f sortausloc.c sortausloc.P
	ar rv ../lib/libsimov.a sortausloc.o

sortfunc.o: \
	sortfunc.S
	../../bin/preV3_1.x sortfunc.S sortfunc.P
	../../bin/preproc.x sortfunc.P sortfunc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o sortfunc.o sortfunc.c
	rm -f sortfunc.c sortfunc.P
	ar rv ../lib/libsimov.a sortfunc.o

sortfuncloc.o: \
	sortfuncloc.S
	../../bin/preV3_1.x sortfuncloc.S sortfuncloc.P
	../../bin/preproc.x sortfuncloc.P sortfuncloc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o sortfuncloc.o sortfuncloc.c
	rm -f sortfuncloc.c sortfuncloc.P
	ar rv ../lib/libsimov.a sortfuncloc.o

stellen.o: \
	stellen.S
	../../bin/preV3_1.x stellen.S stellen.P
	../../bin/preproc.x stellen.P stellen.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o stellen.o stellen.c
	rm -f stellen.c stellen.P
	ar rv ../lib/libsimov.a stellen.o

structin.o: \
	structin.S
	../../bin/preV3_1.x structin.S structin.P
	../../bin/preproc.x structin.P structin.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o structin.o structin.c
	rm -f structin.c structin.P
	ar rv ../lib/libsimov.a structin.o

structsort.o: \
	structsort.S
	../../bin/preV3_1.x structsort.S structsort.P
	../../bin/preproc.x structsort.P structsort.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o structsort.o structsort.c
	rm -f structsort.c structsort.P
	ar rv ../lib/libsimov.a structsort.o

subst.o: \
	subst.S
	../../bin/preV3_1.x subst.S subst.P
	../../bin/preproc.x subst.P subst.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o subst.o subst.c
	rm -f subst.c subst.P
	ar rv ../lib/libsimov.a subst.o

typprint.o: \
	typprint.S
	../../bin/preV3_1.x typprint.S typprint.P
	../../bin/preproc.x typprint.P typprint.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o typprint.o typprint.c
	rm -f typprint.c typprint.P
	ar rv ../lib/libsimov.a typprint.o

val.o: \
	val.S
	../../bin/preV3_1.x val.S val.P
	../../bin/preproc.x val.P val.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o val.o val.c
	rm -f val.c val.P
	ar rv ../lib/libsimov.a val.o

xfgetc.o: \
	xfgetc.S
	../../bin/preV3_1.x xfgetc.S xfgetc.P
	../../bin/preproc.x xfgetc.P xfgetc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o xfgetc.o xfgetc.c
	rm -f xfgetc.c xfgetc.P
	ar rv ../lib/libsimov.a xfgetc.o

ranlib:
	- ranlib ../lib/libsimov.a
