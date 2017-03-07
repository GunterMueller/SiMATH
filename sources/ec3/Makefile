include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  ecgf2fp.o \
  ecgf2msha1.o \
  ecgf2npca.o \
  ecgf2npfe.o \
  ecgf2npmp2.o \
  ecgf2pnp.o \
  ecqnfdivpol.o \
  ecqnfexptor.o \
  ecqnfgentor.o \
  ecqnfordtor.o \
  ecqnfstrtor.o \
  ecqnftorgr.o \
  ecrqnf1rank.o \
  eqisnfbasis.o \
  eqisnfbassp.o \
  eqisnfdivpol.o \
  eqisnfgentor.o \
  eqisnfpost.o \
  eqisnfpostpg.o \
  eqisnftorgr.o \
  eqisnftpn.o \
  eqisnftppos.o \
  ispteqisnfppt.o


LIB= ../../lib/lib_ec3.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
