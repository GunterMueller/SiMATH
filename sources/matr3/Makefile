include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  magf2efe.o \
  magf2evifcp.o \
  magf2tomagfs.o \
  magfsefe.o \
  magfsevifcp.o \
  magfstomagf2.o \
  maitomagf2.o \
  maitomagfs.o \
  mapgf2det.o \
  mapgf2efe.o \
  mapgf2exp.o \
  mapgf2inv.o \
  mapgf2smul.o \
  mapgf2trace.o \
  mapgf2transf.o \
  mapgfsdet.o \
  mapgfsefe.o \
  mapgfsexp.o \
  mapgfsinv.o \
  mapgfssmul.o \
  mapgfstrace.o \
  mapgfstransf.o \
  mapigf2evfvs.o \
  mapigfsevfvs.o \
  mapinfevlfvs.o \
  mapitomapnf.o \
  mapitomarfr.o \
  mapnfdet.o \
  mapnfexp.o \
  mapnfinv.o \
  mapnfsmul.o \
  mapnftomapmp.o \
  mapnftomapr.o \
  mapnftrace.o \
  mapnftransf.o \
  maprnfevlfvs.o \
  maprtomapnf.o \
  maprtomarfr.o \
  marfmsp1det.o \
  marfmsp1exp.o \
  marfmsp1inv.o \
  marfmsp1nsb.o \
  marfmsp1rk.o \
  marfmsp1smul.o \
  marfmsp1ssle.o \
  marfrchpol.o \
  marfrdet.o \
  marfrexp.o \
  marfrinv.o \
  marfrnsb.o \
  marfrrk.o \
  marfrsmul.o \
  marfrssle.o \
  marfrtrace.o \
  marfrtransf.o \
  mpgf2tompgfs.o \
  mpgf2tompmp.o \
  mpgfstompgf2.o \
  mpgfstompmp.o \
  mpm2tompgf2.o \
  mpmstmrfmsp1.o \
  mpmstompgfs.o \
  vecgf2efe.o \
  vecgf2tovgfs.o \
  vecgfsefe.o \
  vecgfstovgf2.o \
  vecitovecgf2.o \
  vecitovecgfs.o \
  vecpgf2efe.o \
  vecpgf2smul.o \
  vecpgf2sprod.o \
  vecpgfsefe.o \
  vecpgfslc.o \
  vecpgfssmul.o \
  vecpigf2efvs.o \
  vecpigfsefvs.o \
  vecpitovpnf.o \
  vecpitovrfr.o \
  vecpnflc.o \
  vecpnfsmul.o \
  vecpnftovpmp.o \
  vecpnftovpr.o \
  vecprtovpnf.o \
  vecprtovrfr.o \
  vecrfmsp1lc.o \
  vecrfmsp1sm.o \
  vecrfmsp1sp.o \
  vecrfrlc.o \
  vecrfrsmul.o \
  vecrfrsprod.o \
  vecrfrtrnsf.o \
  vpgf2tovpgfs.o \
  vpgf2tovpmp.o \
  vpgf2transf.o \
  vpgfssprod.o \
  vpgfstovpgf2.o \
  vpgfstovpmp.o \
  vpgfstransf.o \
  vpinfevalfvs.o \
  vpm2tovpgf2.o \
  vpmstovpgfs.o \
  vpmstvrfmsp1.o \
  vpnfsprod.o \
  vpnftransf.o \
  vprnfevalfvs.o


LIB= ../../lib/lib_matr3.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
