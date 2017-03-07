include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  affmsp1decl.o \
  afmsp1coreal.o \
  afmsp1expsp.o \
  afmsp1idpval.o \
  afmsp1pptf.o \
  afmsp1prodsp.o \
  afmsp1regul.o \
  iafmsp1psval.o \
  modprmsp1elt.o \
  nepousppmsp1.o \
  oprmsp1basfg.o \
  ouspprmsp1bl.o \
  ouspprmsp1dl.o \
  ouspprmsp1dm.o \
  ouspprmsp1ib.o \
  upprmsp1afes.o \
  uspprmsp1apf.o \
  vepepuspmsp1.o


LIB= ../../lib/lib_arith4.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
