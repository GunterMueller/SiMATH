include ../../Makefile.flags


all: \
	alfolc.o \
	brackex.o \
	decl_error.o \
	dfolc.o \
	errm.o \
	error.o \
	ferrm.o \
	invectloc.o \
	isbracor.o \
	ismatrvec.o \
	isop.o \
	ispolsubst.o \
	matrfolc.o \
	modfolc.o \
	ofolc.o \
	ofolc_ov.o \
	prechar.o \
	print_error.o \
	sofolc.o \
	syntax.o \
	ranlib


clean:
	rm -f *~
	rm -f alfolc.o
	rm -f brackex.o
	rm -f decl_error.o
	rm -f dfolc.o
	rm -f errm.o
	rm -f error.o
	rm -f ferrm.o
	rm -f invectloc.o
	rm -f isbracor.o
	rm -f ismatrvec.o
	rm -f isop.o
	rm -f ispolsubst.o
	rm -f matrfolc.o
	rm -f modfolc.o
	rm -f ofolc.o
	rm -f ofolc_ov.o
	rm -f prechar.o
	rm -f print_error.o
	rm -f sofolc.o
	rm -f syntax.o


veryclean: clean
	rm -f ../lib/libsimer.a



alfolc.o: \
	alfolc.S
	../../bin/preV3_1.x alfolc.S alfolc.P
	../../bin/preproc.x alfolc.P alfolc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o alfolc.o alfolc.c
	rm -f alfolc.c alfolc.P
	ar rv ../lib/libsimer.a alfolc.o

brackex.o: \
	brackex.S
	../../bin/preV3_1.x brackex.S brackex.P
	../../bin/preproc.x brackex.P brackex.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o brackex.o brackex.c
	rm -f brackex.c brackex.P
	ar rv ../lib/libsimer.a brackex.o

decl_error.o: \
	decl_error.S
	../../bin/preV3_1.x decl_error.S decl_error.P
	../../bin/preproc.x decl_error.P decl_error.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o decl_error.o decl_error.c
	rm -f decl_error.c decl_error.P
	ar rv ../lib/libsimer.a decl_error.o

dfolc.o: \
	dfolc.S
	../../bin/preV3_1.x dfolc.S dfolc.P
	../../bin/preproc.x dfolc.P dfolc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o dfolc.o dfolc.c
	rm -f dfolc.c dfolc.P
	ar rv ../lib/libsimer.a dfolc.o

errm.o: \
	errm.S
	../../bin/preV3_1.x errm.S errm.P
	../../bin/preproc.x errm.P errm.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o errm.o errm.c
	rm -f errm.c errm.P
	ar rv ../lib/libsimer.a errm.o

error.o: \
	error.S
	../../bin/preV3_1.x error.S error.P
	../../bin/preproc.x error.P error.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o error.o error.c
	rm -f error.c error.P
	ar rv ../lib/libsimer.a error.o

ferrm.o: \
	ferrm.S
	../../bin/preV3_1.x ferrm.S ferrm.P
	../../bin/preproc.x ferrm.P ferrm.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ferrm.o ferrm.c
	rm -f ferrm.c ferrm.P
	ar rv ../lib/libsimer.a ferrm.o

invectloc.o: \
	invectloc.S
	../../bin/preV3_1.x invectloc.S invectloc.P
	../../bin/preproc.x invectloc.P invectloc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o invectloc.o invectloc.c
	rm -f invectloc.c invectloc.P
	ar rv ../lib/libsimer.a invectloc.o

isbracor.o: \
	isbracor.S
	../../bin/preV3_1.x isbracor.S isbracor.P
	../../bin/preproc.x isbracor.P isbracor.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o isbracor.o isbracor.c
	rm -f isbracor.c isbracor.P
	ar rv ../lib/libsimer.a isbracor.o

ismatrvec.o: \
	ismatrvec.S
	../../bin/preV3_1.x ismatrvec.S ismatrvec.P
	../../bin/preproc.x ismatrvec.P ismatrvec.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ismatrvec.o ismatrvec.c
	rm -f ismatrvec.c ismatrvec.P
	ar rv ../lib/libsimer.a ismatrvec.o

isop.o: \
	isop.S
	../../bin/preV3_1.x isop.S isop.P
	../../bin/preproc.x isop.P isop.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o isop.o isop.c
	rm -f isop.c isop.P
	ar rv ../lib/libsimer.a isop.o

ispolsubst.o: \
	ispolsubst.S
	../../bin/preV3_1.x ispolsubst.S ispolsubst.P
	../../bin/preproc.x ispolsubst.P ispolsubst.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ispolsubst.o ispolsubst.c
	rm -f ispolsubst.c ispolsubst.P
	ar rv ../lib/libsimer.a ispolsubst.o

matrfolc.o: \
	matrfolc.S
	../../bin/preV3_1.x matrfolc.S matrfolc.P
	../../bin/preproc.x matrfolc.P matrfolc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o matrfolc.o matrfolc.c
	rm -f matrfolc.c matrfolc.P
	ar rv ../lib/libsimer.a matrfolc.o

modfolc.o: \
	modfolc.S
	../../bin/preV3_1.x modfolc.S modfolc.P
	../../bin/preproc.x modfolc.P modfolc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o modfolc.o modfolc.c
	rm -f modfolc.c modfolc.P
	ar rv ../lib/libsimer.a modfolc.o

ofolc.o: \
	ofolc.S
	../../bin/preV3_1.x ofolc.S ofolc.P
	../../bin/preproc.x ofolc.P ofolc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ofolc.o ofolc.c
	rm -f ofolc.c ofolc.P
	ar rv ../lib/libsimer.a ofolc.o

ofolc_ov.o: \
	ofolc_ov.S
	../../bin/preV3_1.x ofolc_ov.S ofolc_ov.P
	../../bin/preproc.x ofolc_ov.P ofolc_ov.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o ofolc_ov.o ofolc_ov.c
	rm -f ofolc_ov.c ofolc_ov.P
	ar rv ../lib/libsimer.a ofolc_ov.o

prechar.o: \
	prechar.S
	../../bin/preV3_1.x prechar.S prechar.P
	../../bin/preproc.x prechar.P prechar.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o prechar.o prechar.c
	rm -f prechar.c prechar.P
	ar rv ../lib/libsimer.a prechar.o

print_error.o: \
	print_error.S
	../../bin/preV3_1.x print_error.S print_error.P
	../../bin/preproc.x print_error.P print_error.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o print_error.o print_error.c
	rm -f print_error.c print_error.P
	ar rv ../lib/libsimer.a print_error.o

sofolc.o: \
	sofolc.S
	../../bin/preV3_1.x sofolc.S sofolc.P
	../../bin/preproc.x sofolc.P sofolc.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o sofolc.o sofolc.c
	rm -f sofolc.c sofolc.P
	ar rv ../lib/libsimer.a sofolc.o

syntax.o: \
	syntax.S
	../../bin/preV3_1.x syntax.S syntax.P
	../../bin/preproc.x syntax.P syntax.c
	$(CC) $(CFLAGS_SIMCALC) $(CPPFLAGS_SIMCALC) -c -o syntax.o syntax.c
	rm -f syntax.c syntax.P
	ar rv ../lib/libsimer.a syntax.o

ranlib:
	- ranlib ../lib/libsimer.a
