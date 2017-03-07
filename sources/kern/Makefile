include ../../Makefile.flags


SMBIN = ../../bin


LO_OBJECTS = \
  


OBJECTS = \
  SIMATHinit.o \
  Sbind.o \
  Sfree.o \
  Sinit.o \
  gc.o \
  gccpr.o \
  gcfree.o \
  gcreinit.o \
  inocmp.o \
  isbound.o \
  islist.o \
  lend.o \
  ltop.o \
  setspace.o \
  setstack.o \
  setstock.o \
  xfprintf.o \
  xprintf.o


LIB= ../../lib/lib_kern.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${LO_OBJECTS} ${OBJECTS}
	${AR} rc $@ $^
	- ${RANLIB} ${LIB}
