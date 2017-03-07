include ../../Makefile.flags


all: \
	av_basad.o \
	av_loesche.o \
	eggtaus.o \
	expoverint.o \
	factmsg.o \
	flexpr.o \
	flreads.o \
	fputcomp.o \
	fputcompfx.o \
	fputflfx.o \
	fputgf2el.o \
	fputgfsel.o \
	fputnfel.o \
	fputpc.o \
	fputpfl.o \
	fputpgf2.o \
	fputpgfs.o \
	fputpi.o \
	fputpm.o \
	fputpnf.o \
	fputpr.o \
	fputqnfidsp.o \
	gf2etudpm2.o \
	iexpr.o \
	ifak.o \
	instring.o \
	ireads.o \
	isass.o \
	isequintrat.o \
	isequpol.o \
	isminus.o \
	isvarinvl.o \
	listaus.o \
	lkill.o \
	magf2red.o \
	magf2rem.o \
	magfsred.o \
	manfred.o \
	mapgf2red.o \
	mapgfsred.o \
	mapnfred.o \
	matrans.o \
	matraus.o \
	matrden.o \
	nfelred.o \
	peval.o \
	pfaktaus.o \
	pgf2faus.o \
	pgf2red.o \
	pgfsfaus.o \
	pgfsred.o \
	pnfred.o \
	polaus.o \
	rexpr.o \
	statistic.o \
	valcontrol.o \
	varls.o \
	varlsloc.o \
	vecaus.o \
	vecden.o \
	vecgf2red.o \
	vecgf2rem.o \
	vecgfsred.o \
	vecnfred.o \
	vecpgf2red.o \
	vecpgfsred.o \
	vecpnfred.o \
	ranlib


clean:
	rm -f *~
	rm -f av_basad.o
	rm -f av_loesche.o
	rm -f eggtaus.o
	rm -f expoverint.o
	rm -f factmsg.o
	rm -f flexpr.o
	rm -f flreads.o
	rm -f fputcomp.o
	rm -f fputcompfx.o
	rm -f fputflfx.o
	rm -f fputgf2el.o
	rm -f fputgfsel.o
	rm -f fputnfel.o
	rm -f fputpc.o
	rm -f fputpfl.o
	rm -f fputpgf2.o
	rm -f fputpgfs.o
	rm -f fputpi.o
	rm -f fputpm.o
	rm -f fputpnf.o
	rm -f fputpr.o
	rm -f fputqnfidsp.o
	rm -f gf2etudpm2.o
	rm -f iexpr.o
	rm -f ifak.o
	rm -f instring.o
	rm -f ireads.o
	rm -f isass.o
	rm -f isequintrat.o
	rm -f isequpol.o
	rm -f isminus.o
	rm -f isvarinvl.o
	rm -f listaus.o
	rm -f lkill.o
	rm -f magf2red.o
	rm -f magf2rem.o
	rm -f magfsred.o
	rm -f manfred.o
	rm -f mapgf2red.o
	rm -f mapgfsred.o
	rm -f mapnfred.o
	rm -f matrans.o
	rm -f matraus.o
	rm -f matrden.o
	rm -f nfelred.o
	rm -f peval.o
	rm -f pfaktaus.o
	rm -f pgf2faus.o
	rm -f pgf2red.o
	rm -f pgfsfaus.o
	rm -f pgfsred.o
	rm -f pnfred.o
	rm -f polaus.o
	rm -f rexpr.o
	rm -f statistic.o
	rm -f valcontrol.o
	rm -f varls.o
	rm -f varlsloc.o
	rm -f vecaus.o
	rm -f vecden.o
	rm -f vecgf2red.o
	rm -f vecgf2rem.o
	rm -f vecgfsred.o
	rm -f vecnfred.o
	rm -f vecpgf2red.o
	rm -f vecpgfsred.o
	rm -f vecpnfred.o


veryclean: clean
	rm -f ../lib/libsimmv.a



av_basad.o: \
	av_basad.S
	../../bin/preV3_1.x av_basad.S av_basad.P
	../../bin/preproc.x av_basad.P av_basad.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o av_basad.o av_basad.c
	rm -f av_basad.c av_basad.P
	ar rv ../lib/libsimmv.a av_basad.o

av_loesche.o: \
	av_loesche.S
	../../bin/preV3_1.x av_loesche.S av_loesche.P
	../../bin/preproc.x av_loesche.P av_loesche.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o av_loesche.o av_loesche.c
	rm -f av_loesche.c av_loesche.P
	ar rv ../lib/libsimmv.a av_loesche.o

eggtaus.o: \
	eggtaus.S
	../../bin/preV3_1.x eggtaus.S eggtaus.P
	../../bin/preproc.x eggtaus.P eggtaus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o eggtaus.o eggtaus.c
	rm -f eggtaus.c eggtaus.P
	ar rv ../lib/libsimmv.a eggtaus.o

expoverint.o: \
	expoverint.S
	../../bin/preV3_1.x expoverint.S expoverint.P
	../../bin/preproc.x expoverint.P expoverint.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o expoverint.o expoverint.c
	rm -f expoverint.c expoverint.P
	ar rv ../lib/libsimmv.a expoverint.o

factmsg.o: \
	factmsg.S
	../../bin/preV3_1.x factmsg.S factmsg.P
	../../bin/preproc.x factmsg.P factmsg.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o factmsg.o factmsg.c
	rm -f factmsg.c factmsg.P
	ar rv ../lib/libsimmv.a factmsg.o

flexpr.o: \
	flexpr.S
	../../bin/preV3_1.x flexpr.S flexpr.P
	../../bin/preproc.x flexpr.P flexpr.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o flexpr.o flexpr.c
	rm -f flexpr.c flexpr.P
	ar rv ../lib/libsimmv.a flexpr.o

flreads.o: \
	flreads.S
	../../bin/preV3_1.x flreads.S flreads.P
	../../bin/preproc.x flreads.P flreads.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o flreads.o flreads.c
	rm -f flreads.c flreads.P
	ar rv ../lib/libsimmv.a flreads.o

fputcomp.o: \
	fputcomp.S
	../../bin/preV3_1.x fputcomp.S fputcomp.P
	../../bin/preproc.x fputcomp.P fputcomp.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputcomp.o fputcomp.c
	rm -f fputcomp.c fputcomp.P
	ar rv ../lib/libsimmv.a fputcomp.o

fputcompfx.o: \
	fputcompfx.S
	../../bin/preV3_1.x fputcompfx.S fputcompfx.P
	../../bin/preproc.x fputcompfx.P fputcompfx.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputcompfx.o fputcompfx.c
	rm -f fputcompfx.c fputcompfx.P
	ar rv ../lib/libsimmv.a fputcompfx.o

fputflfx.o: \
	fputflfx.S
	../../bin/preV3_1.x fputflfx.S fputflfx.P
	../../bin/preproc.x fputflfx.P fputflfx.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputflfx.o fputflfx.c
	rm -f fputflfx.c fputflfx.P
	ar rv ../lib/libsimmv.a fputflfx.o

fputgf2el.o: \
	fputgf2el.S
	../../bin/preV3_1.x fputgf2el.S fputgf2el.P
	../../bin/preproc.x fputgf2el.P fputgf2el.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputgf2el.o fputgf2el.c
	rm -f fputgf2el.c fputgf2el.P
	ar rv ../lib/libsimmv.a fputgf2el.o

fputgfsel.o: \
	fputgfsel.S
	../../bin/preV3_1.x fputgfsel.S fputgfsel.P
	../../bin/preproc.x fputgfsel.P fputgfsel.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputgfsel.o fputgfsel.c
	rm -f fputgfsel.c fputgfsel.P
	ar rv ../lib/libsimmv.a fputgfsel.o

fputnfel.o: \
	fputnfel.S
	../../bin/preV3_1.x fputnfel.S fputnfel.P
	../../bin/preproc.x fputnfel.P fputnfel.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputnfel.o fputnfel.c
	rm -f fputnfel.c fputnfel.P
	ar rv ../lib/libsimmv.a fputnfel.o

fputpc.o: \
	fputpc.S
	../../bin/preV3_1.x fputpc.S fputpc.P
	../../bin/preproc.x fputpc.P fputpc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputpc.o fputpc.c
	rm -f fputpc.c fputpc.P
	ar rv ../lib/libsimmv.a fputpc.o

fputpfl.o: \
	fputpfl.S
	../../bin/preV3_1.x fputpfl.S fputpfl.P
	../../bin/preproc.x fputpfl.P fputpfl.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputpfl.o fputpfl.c
	rm -f fputpfl.c fputpfl.P
	ar rv ../lib/libsimmv.a fputpfl.o

fputpgf2.o: \
	fputpgf2.S
	../../bin/preV3_1.x fputpgf2.S fputpgf2.P
	../../bin/preproc.x fputpgf2.P fputpgf2.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputpgf2.o fputpgf2.c
	rm -f fputpgf2.c fputpgf2.P
	ar rv ../lib/libsimmv.a fputpgf2.o

fputpgfs.o: \
	fputpgfs.S
	../../bin/preV3_1.x fputpgfs.S fputpgfs.P
	../../bin/preproc.x fputpgfs.P fputpgfs.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputpgfs.o fputpgfs.c
	rm -f fputpgfs.c fputpgfs.P
	ar rv ../lib/libsimmv.a fputpgfs.o

fputpi.o: \
	fputpi.S
	../../bin/preV3_1.x fputpi.S fputpi.P
	../../bin/preproc.x fputpi.P fputpi.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputpi.o fputpi.c
	rm -f fputpi.c fputpi.P
	ar rv ../lib/libsimmv.a fputpi.o

fputpm.o: \
	fputpm.S
	../../bin/preV3_1.x fputpm.S fputpm.P
	../../bin/preproc.x fputpm.P fputpm.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputpm.o fputpm.c
	rm -f fputpm.c fputpm.P
	ar rv ../lib/libsimmv.a fputpm.o

fputpnf.o: \
	fputpnf.S
	../../bin/preV3_1.x fputpnf.S fputpnf.P
	../../bin/preproc.x fputpnf.P fputpnf.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputpnf.o fputpnf.c
	rm -f fputpnf.c fputpnf.P
	ar rv ../lib/libsimmv.a fputpnf.o

fputpr.o: \
	fputpr.S
	../../bin/preV3_1.x fputpr.S fputpr.P
	../../bin/preproc.x fputpr.P fputpr.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputpr.o fputpr.c
	rm -f fputpr.c fputpr.P
	ar rv ../lib/libsimmv.a fputpr.o

fputqnfidsp.o: \
	fputqnfidsp.S
	../../bin/preV3_1.x fputqnfidsp.S fputqnfidsp.P
	../../bin/preproc.x fputqnfidsp.P fputqnfidsp.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o fputqnfidsp.o fputqnfidsp.c
	rm -f fputqnfidsp.c fputqnfidsp.P
	ar rv ../lib/libsimmv.a fputqnfidsp.o

gf2etudpm2.o: \
	gf2etudpm2.S
	../../bin/preV3_1.x gf2etudpm2.S gf2etudpm2.P
	../../bin/preproc.x gf2etudpm2.P gf2etudpm2.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o gf2etudpm2.o gf2etudpm2.c
	rm -f gf2etudpm2.c gf2etudpm2.P
	ar rv ../lib/libsimmv.a gf2etudpm2.o

iexpr.o: \
	iexpr.S
	../../bin/preV3_1.x iexpr.S iexpr.P
	../../bin/preproc.x iexpr.P iexpr.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o iexpr.o iexpr.c
	rm -f iexpr.c iexpr.P
	ar rv ../lib/libsimmv.a iexpr.o

ifak.o: \
	ifak.S
	../../bin/preV3_1.x ifak.S ifak.P
	../../bin/preproc.x ifak.P ifak.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ifak.o ifak.c
	rm -f ifak.c ifak.P
	ar rv ../lib/libsimmv.a ifak.o

instring.o: \
	instring.S
	../../bin/preV3_1.x instring.S instring.P
	../../bin/preproc.x instring.P instring.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o instring.o instring.c
	rm -f instring.c instring.P
	ar rv ../lib/libsimmv.a instring.o

ireads.o: \
	ireads.S
	../../bin/preV3_1.x ireads.S ireads.P
	../../bin/preproc.x ireads.P ireads.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ireads.o ireads.c
	rm -f ireads.c ireads.P
	ar rv ../lib/libsimmv.a ireads.o

isass.o: \
	isass.S
	../../bin/preV3_1.x isass.S isass.P
	../../bin/preproc.x isass.P isass.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o isass.o isass.c
	rm -f isass.c isass.P
	ar rv ../lib/libsimmv.a isass.o

isequintrat.o: \
	isequintrat.S
	../../bin/preV3_1.x isequintrat.S isequintrat.P
	../../bin/preproc.x isequintrat.P isequintrat.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o isequintrat.o isequintrat.c
	rm -f isequintrat.c isequintrat.P
	ar rv ../lib/libsimmv.a isequintrat.o

isequpol.o: \
	isequpol.S
	../../bin/preV3_1.x isequpol.S isequpol.P
	../../bin/preproc.x isequpol.P isequpol.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o isequpol.o isequpol.c
	rm -f isequpol.c isequpol.P
	ar rv ../lib/libsimmv.a isequpol.o

isminus.o: \
	isminus.S
	../../bin/preV3_1.x isminus.S isminus.P
	../../bin/preproc.x isminus.P isminus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o isminus.o isminus.c
	rm -f isminus.c isminus.P
	ar rv ../lib/libsimmv.a isminus.o

isvarinvl.o: \
	isvarinvl.S
	../../bin/preV3_1.x isvarinvl.S isvarinvl.P
	../../bin/preproc.x isvarinvl.P isvarinvl.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o isvarinvl.o isvarinvl.c
	rm -f isvarinvl.c isvarinvl.P
	ar rv ../lib/libsimmv.a isvarinvl.o

listaus.o: \
	listaus.S
	../../bin/preV3_1.x listaus.S listaus.P
	../../bin/preproc.x listaus.P listaus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o listaus.o listaus.c
	rm -f listaus.c listaus.P
	ar rv ../lib/libsimmv.a listaus.o

lkill.o: \
	lkill.S
	../../bin/preV3_1.x lkill.S lkill.P
	../../bin/preproc.x lkill.P lkill.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o lkill.o lkill.c
	rm -f lkill.c lkill.P
	ar rv ../lib/libsimmv.a lkill.o

magf2red.o: \
	magf2red.S
	../../bin/preV3_1.x magf2red.S magf2red.P
	../../bin/preproc.x magf2red.P magf2red.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o magf2red.o magf2red.c
	rm -f magf2red.c magf2red.P
	ar rv ../lib/libsimmv.a magf2red.o

magf2rem.o: \
	magf2rem.S
	../../bin/preV3_1.x magf2rem.S magf2rem.P
	../../bin/preproc.x magf2rem.P magf2rem.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o magf2rem.o magf2rem.c
	rm -f magf2rem.c magf2rem.P
	ar rv ../lib/libsimmv.a magf2rem.o

magfsred.o: \
	magfsred.S
	../../bin/preV3_1.x magfsred.S magfsred.P
	../../bin/preproc.x magfsred.P magfsred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o magfsred.o magfsred.c
	rm -f magfsred.c magfsred.P
	ar rv ../lib/libsimmv.a magfsred.o

manfred.o: \
	manfred.S
	../../bin/preV3_1.x manfred.S manfred.P
	../../bin/preproc.x manfred.P manfred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o manfred.o manfred.c
	rm -f manfred.c manfred.P
	ar rv ../lib/libsimmv.a manfred.o

mapgf2red.o: \
	mapgf2red.S
	../../bin/preV3_1.x mapgf2red.S mapgf2red.P
	../../bin/preproc.x mapgf2red.P mapgf2red.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o mapgf2red.o mapgf2red.c
	rm -f mapgf2red.c mapgf2red.P
	ar rv ../lib/libsimmv.a mapgf2red.o

mapgfsred.o: \
	mapgfsred.S
	../../bin/preV3_1.x mapgfsred.S mapgfsred.P
	../../bin/preproc.x mapgfsred.P mapgfsred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o mapgfsred.o mapgfsred.c
	rm -f mapgfsred.c mapgfsred.P
	ar rv ../lib/libsimmv.a mapgfsred.o

mapnfred.o: \
	mapnfred.S
	../../bin/preV3_1.x mapnfred.S mapnfred.P
	../../bin/preproc.x mapnfred.P mapnfred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o mapnfred.o mapnfred.c
	rm -f mapnfred.c mapnfred.P
	ar rv ../lib/libsimmv.a mapnfred.o

matrans.o: \
	matrans.S
	../../bin/preV3_1.x matrans.S matrans.P
	../../bin/preproc.x matrans.P matrans.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o matrans.o matrans.c
	rm -f matrans.c matrans.P
	ar rv ../lib/libsimmv.a matrans.o

matraus.o: \
	matraus.S
	../../bin/preV3_1.x matraus.S matraus.P
	../../bin/preproc.x matraus.P matraus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o matraus.o matraus.c
	rm -f matraus.c matraus.P
	ar rv ../lib/libsimmv.a matraus.o

matrden.o: \
	matrden.S
	../../bin/preV3_1.x matrden.S matrden.P
	../../bin/preproc.x matrden.P matrden.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o matrden.o matrden.c
	rm -f matrden.c matrden.P
	ar rv ../lib/libsimmv.a matrden.o

nfelred.o: \
	nfelred.S
	../../bin/preV3_1.x nfelred.S nfelred.P
	../../bin/preproc.x nfelred.P nfelred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o nfelred.o nfelred.c
	rm -f nfelred.c nfelred.P
	ar rv ../lib/libsimmv.a nfelred.o

peval.o: \
	peval.S
	../../bin/preV3_1.x peval.S peval.P
	../../bin/preproc.x peval.P peval.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o peval.o peval.c
	rm -f peval.c peval.P
	ar rv ../lib/libsimmv.a peval.o

pfaktaus.o: \
	pfaktaus.S
	../../bin/preV3_1.x pfaktaus.S pfaktaus.P
	../../bin/preproc.x pfaktaus.P pfaktaus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pfaktaus.o pfaktaus.c
	rm -f pfaktaus.c pfaktaus.P
	ar rv ../lib/libsimmv.a pfaktaus.o

pgf2faus.o: \
	pgf2faus.S
	../../bin/preV3_1.x pgf2faus.S pgf2faus.P
	../../bin/preproc.x pgf2faus.P pgf2faus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pgf2faus.o pgf2faus.c
	rm -f pgf2faus.c pgf2faus.P
	ar rv ../lib/libsimmv.a pgf2faus.o

pgf2red.o: \
	pgf2red.S
	../../bin/preV3_1.x pgf2red.S pgf2red.P
	../../bin/preproc.x pgf2red.P pgf2red.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pgf2red.o pgf2red.c
	rm -f pgf2red.c pgf2red.P
	ar rv ../lib/libsimmv.a pgf2red.o

pgfsfaus.o: \
	pgfsfaus.S
	../../bin/preV3_1.x pgfsfaus.S pgfsfaus.P
	../../bin/preproc.x pgfsfaus.P pgfsfaus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pgfsfaus.o pgfsfaus.c
	rm -f pgfsfaus.c pgfsfaus.P
	ar rv ../lib/libsimmv.a pgfsfaus.o

pgfsred.o: \
	pgfsred.S
	../../bin/preV3_1.x pgfsred.S pgfsred.P
	../../bin/preproc.x pgfsred.P pgfsred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pgfsred.o pgfsred.c
	rm -f pgfsred.c pgfsred.P
	ar rv ../lib/libsimmv.a pgfsred.o

pnfred.o: \
	pnfred.S
	../../bin/preV3_1.x pnfred.S pnfred.P
	../../bin/preproc.x pnfred.P pnfred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o pnfred.o pnfred.c
	rm -f pnfred.c pnfred.P
	ar rv ../lib/libsimmv.a pnfred.o

polaus.o: \
	polaus.S
	../../bin/preV3_1.x polaus.S polaus.P
	../../bin/preproc.x polaus.P polaus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o polaus.o polaus.c
	rm -f polaus.c polaus.P
	ar rv ../lib/libsimmv.a polaus.o

rexpr.o: \
	rexpr.S
	../../bin/preV3_1.x rexpr.S rexpr.P
	../../bin/preproc.x rexpr.P rexpr.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o rexpr.o rexpr.c
	rm -f rexpr.c rexpr.P
	ar rv ../lib/libsimmv.a rexpr.o

statistic.o: \
	statistic.S
	../../bin/preV3_1.x statistic.S statistic.P
	../../bin/preproc.x statistic.P statistic.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o statistic.o statistic.c
	rm -f statistic.c statistic.P
	ar rv ../lib/libsimmv.a statistic.o

valcontrol.o: \
	valcontrol.S
	../../bin/preV3_1.x valcontrol.S valcontrol.P
	../../bin/preproc.x valcontrol.P valcontrol.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o valcontrol.o valcontrol.c
	rm -f valcontrol.c valcontrol.P
	ar rv ../lib/libsimmv.a valcontrol.o

varls.o: \
	varls.S
	../../bin/preV3_1.x varls.S varls.P
	../../bin/preproc.x varls.P varls.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o varls.o varls.c
	rm -f varls.c varls.P
	ar rv ../lib/libsimmv.a varls.o

varlsloc.o: \
	varlsloc.S
	../../bin/preV3_1.x varlsloc.S varlsloc.P
	../../bin/preproc.x varlsloc.P varlsloc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o varlsloc.o varlsloc.c
	rm -f varlsloc.c varlsloc.P
	ar rv ../lib/libsimmv.a varlsloc.o

vecaus.o: \
	vecaus.S
	../../bin/preV3_1.x vecaus.S vecaus.P
	../../bin/preproc.x vecaus.P vecaus.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecaus.o vecaus.c
	rm -f vecaus.c vecaus.P
	ar rv ../lib/libsimmv.a vecaus.o

vecden.o: \
	vecden.S
	../../bin/preV3_1.x vecden.S vecden.P
	../../bin/preproc.x vecden.P vecden.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecden.o vecden.c
	rm -f vecden.c vecden.P
	ar rv ../lib/libsimmv.a vecden.o

vecgf2red.o: \
	vecgf2red.S
	../../bin/preV3_1.x vecgf2red.S vecgf2red.P
	../../bin/preproc.x vecgf2red.P vecgf2red.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecgf2red.o vecgf2red.c
	rm -f vecgf2red.c vecgf2red.P
	ar rv ../lib/libsimmv.a vecgf2red.o

vecgf2rem.o: \
	vecgf2rem.S
	../../bin/preV3_1.x vecgf2rem.S vecgf2rem.P
	../../bin/preproc.x vecgf2rem.P vecgf2rem.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecgf2rem.o vecgf2rem.c
	rm -f vecgf2rem.c vecgf2rem.P
	ar rv ../lib/libsimmv.a vecgf2rem.o

vecgfsred.o: \
	vecgfsred.S
	../../bin/preV3_1.x vecgfsred.S vecgfsred.P
	../../bin/preproc.x vecgfsred.P vecgfsred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecgfsred.o vecgfsred.c
	rm -f vecgfsred.c vecgfsred.P
	ar rv ../lib/libsimmv.a vecgfsred.o

vecnfred.o: \
	vecnfred.S
	../../bin/preV3_1.x vecnfred.S vecnfred.P
	../../bin/preproc.x vecnfred.P vecnfred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecnfred.o vecnfred.c
	rm -f vecnfred.c vecnfred.P
	ar rv ../lib/libsimmv.a vecnfred.o

vecpgf2red.o: \
	vecpgf2red.S
	../../bin/preV3_1.x vecpgf2red.S vecpgf2red.P
	../../bin/preproc.x vecpgf2red.P vecpgf2red.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecpgf2red.o vecpgf2red.c
	rm -f vecpgf2red.c vecpgf2red.P
	ar rv ../lib/libsimmv.a vecpgf2red.o

vecpgfsred.o: \
	vecpgfsred.S
	../../bin/preV3_1.x vecpgfsred.S vecpgfsred.P
	../../bin/preproc.x vecpgfsred.P vecpgfsred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecpgfsred.o vecpgfsred.c
	rm -f vecpgfsred.c vecpgfsred.P
	ar rv ../lib/libsimmv.a vecpgfsred.o

vecpnfred.o: \
	vecpnfred.S
	../../bin/preV3_1.x vecpnfred.S vecpnfred.P
	../../bin/preproc.x vecpnfred.P vecpnfred.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o vecpnfred.o vecpnfred.c
	rm -f vecpnfred.c vecpnfred.P
	ar rv ../lib/libsimmv.a vecpnfred.o

ranlib:
	- ranlib ../lib/libsimmv.a
