include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  afmsp1minpol.o \
  cdprfmsp1fcl.o \
  cdprfmsp1fup.o \
  cdprfmsp1inv.o \
  cdprfmsp1lfm.o \
  cdprfmsp1mh.o \
  cdprfmsp1sum.o \
  cdprfmsp1upq.o \
  clfcdprfmsp1.o \
  diprfrdif.o \
  diprfrgb.o \
  diprfrgba.o \
  diprfrgbr.o \
  diprfrlotglo.o \
  diprfrlotlio.o \
  diprfrlottdo.o \
  diprfrmonic.o \
  diprfrneg.o \
  diprfrprod.o \
  diprfrrfprod.o \
  diprfrsp.o \
  diprfrsum.o \
  diprfrtorfr.o \
  fgetdiprfrl.o \
  fputdiprfrl.o \
  fu_pol4_gb.o \
  iafmsp1mpmpp.o \
  iafmsp1mpol.o \
  isdiprfrone.o \
  pgf2efe.o \
  pgfsres.o \
  pprmsp1ress.o \
  prfmsp1deriv.o \
  prfmsp1dif.o \
  prfmsp1neg.o \
  prfmsp1prod.o \
  prfmsp1qrem.o \
  prfmsp1rfprd.o \
  prfmsp1sum.o \
  rfrtodiprfr.o \
  sclfuprfmsp1.o \
  upprmsp1disc.o \
  upprmsp1hfa.o \
  upprmsp1hli.o \
  upprmsp1hqs.o \
  upprmsp1redd.o \
  upprmsp1ress.o \
  uprfmsp1egcd.o \
  uprfmsp1fcdp.o \
  uprfmsp1fscl.o


LIB= ../../lib/lib_pol4.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
