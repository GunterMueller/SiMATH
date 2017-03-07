include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  cdmarfmsp1hr.o \
  cdmarfmsp1id.o \
  ismagf2.o \
  magf2det.o \
  magf2exp.o \
  magf2inv.o \
  magf2rk.o \
  magf2smul.o \
  magf2ssle.o \
  magf2trace.o \
  magfsdet.o \
  magfsexp.o \
  magfsinv.o \
  magfsnsb.o \
  magfsrk.o \
  magfssmul.o \
  magfsssle.o \
  magfstrace.o \
  maiedfcf.o \
  maiegsc.o \
  maiegsr.o \
  maievifcp.o \
  maiherm.o \
  maitomanf.o \
  maitomanfs.o \
  mamievifcp.o \
  mamsevifcp.o \
  manfdet.o \
  manfexp.o \
  manfinv.o \
  manfnsb.o \
  manfrk.o \
  manfsdet.o \
  manfsexp.o \
  manfsinv.o \
  manfsmul.o \
  manfsnsb.o \
  manfsrk.o \
  manfssle.o \
  manfssmul.o \
  manfsssle.o \
  manftomudpr.o \
  manftrace.o \
  marevifcp.o \
  marssle.o \
  martomanf.o \
  martomanfs.o \
  maudprtomnf.o \
  maupmipedfcf.o \
  maupmipegsc.o \
  maupmipegsr.o \
  maupmshermsp.o \
  maupmspedfcf.o \
  maupmspegsc.o \
  maupmspegsr.o \
  maupredfcf.o \
  maupregsc.o \
  maupregsr.o \
  vecgf2smul.o \
  vecgf2sprod.o \
  vecgfslc.o \
  vecgfssmul.o \
  vecgfssprod.o \
  vecitovecnf.o \
  vecitovnfs.o \
  vecnflc.o \
  vecnfslc.o \
  vecnfsmul.o \
  vecnfsprod.o \
  vecnfssmul.o \
  vecnfssprod.o \
  vecrtovecnf.o \
  vecrtovnfs.o \
  vecupmsunimt.o \
  vnftovudpr.o \
  vudprtovnf.o


LIB= ../../lib/lib_matr2.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
