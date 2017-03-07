include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  errmsgio.o \
  fgeta.o \
  fgetcb.o \
  fgetcs.o \
  fgetl.o \
  fgeto.o \
  flines.o \
  fputa.o \
  fputbits.o \
  fputl.o \
  fputlstruct.o \
  ftab.o \
  getl.o \
  globinit.o \
  islelt.o \
  lblength.o \
  lcconc.o \
  lcinv.o \
  lcomp.o \
  lcomp2.o \
  lcomp3.o \
  lcomp4.o \
  lcomp5.o \
  lcomp6.o \
  lconc.o \
  lcopy.o \
  lecdel.o \
  lecins.o \
  ledel.o \
  leins.o \
  leins2.o \
  lelt.o \
  lepermg.o \
  lerot.o \
  leset.o \
  lfirstf.o \
  linv.o \
  lipairspmax.o \
  llast.o \
  llconc.o \
  llength.o \
  lmemb.o \
  lpair.o \
  lpermut.o \
  lred6.o \
  lredf.o \
  lrednext.o \
  lreduct.o \
  lsbmsort.o \
  lsbsort.o \
  lscomp.o \
  lscomps.o \
  lsins.o \
  lsixth.o \
  lsizerec.o \
  lsmaxs.o \
  lsmerge.o \
  lsmins.o \
  lsrandperm.o \
  lsrch.o \
  oequal.o \
  oextent.o \
  sdiff.o \
  settime.o \
  sgeta.o \
  sgetc.o \
  sgetcb.o \
  sgetcs.o \
  sgetl.o \
  sinter.o \
  sputl.o \
  stoptime.o \
  sunion.o \
  unsgetc.o \
  usdiff.o \
  usinter.o \
  ussdiff.o \
  xfgetc.o \
  xfgets.o \
  xfputc.o \
  xfputs.o \
  xgets.o


LIB= ../../lib/lib_list.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
