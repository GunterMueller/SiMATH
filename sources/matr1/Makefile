include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  cdmarhermred.o \
  cdmarid.o \
  fgetma.o \
  fgetmaspec.o \
  fgetvec.o \
  fgetvecspec.o \
  fputma.o \
  fputmaflfx.o \
  fputmas.o \
  fputmaspec.o \
  fputvec.o \
  fputvecspec.o \
  isma.o \
  isma_.o \
  ismaeqel.o \
  ismari.o \
  ismas.o \
  ismaspec_.o \
  isnullvec.o \
  isvec_.o \
  isvecspec_.o \
  maam.o \
  macconc.o \
  machpol.o \
  machpolspec.o \
  maconc.o \
  maconsdiag.o \
  maconszero.o \
  macopy.o \
  mactransp.o \
  macup.o \
  madel1rc.o \
  madelsc.o \
  madelsr.o \
  madptomap.o \
  mafldet.o \
  maicc.o \
  maicmult.o \
  maicr.o \
  maicsum.o \
  maidet.o \
  maiexp.o \
  maihermspec.o \
  maihnf.o \
  maiinv.o \
  maiproddiag.o \
  mairsum.o \
  maismul.o \
  maitomami.o \
  maitomams.o \
  maitomapi.o \
  maitomar.o \
  maitrace.o \
  mam2conszero.o \
  mam2exp.o \
  mam2gnsb.o \
  mam2inv.o \
  mam2nsb.o \
  mam2nzc.o \
  mam2prod.o \
  mam2selel.o \
  mam2setel.o \
  mam2sq.o \
  mam2ssle.o \
  mam2sum.o \
  mam2tomams.o \
  mam2toms.o \
  mam2tprod.o \
  mam2transp.o \
  mam2um.o \
  mamiclanssle.o \
  mamidet.o \
  mamiexp.o \
  mamihomsol.o \
  mamiinv.o \
  mamilanssle.o \
  mamiliftssle.o \
  maminsb.o \
  mamismul.o \
  mamitrace.o \
  mamsdet.o \
  mamsexp.o \
  mamsinv.o \
  mamssmul.o \
  mamsssle.o \
  mamstom2.o \
  mamstomam2.o \
  mamstrace.o \
  maneg.o \
  manegspec.o \
  mapidet.o \
  mapiexp.o \
  mapiinv.o \
  mapismul.o \
  mapitomapmi.o \
  mapitomapms.o \
  mapitomapr.o \
  mapitompmpi.o \
  mapitrace.o \
  mapitransf.o \
  mapmidet.o \
  mapmiexp.o \
  mapmiinv.o \
  mapmismul.o \
  mapmitomapmp.o \
  mapmitrace.o \
  mapmitransf.o \
  mapmsdet.o \
  mapmsexp.o \
  mapmsinv.o \
  mapmssmul.o \
  mapmstomapmp.o \
  mapmstrace.o \
  mapmstransf.o \
  maprdet.o \
  maprexp.o \
  maprinv.o \
  maprod.o \
  maprodspec.o \
  maprsmul.o \
  maprtomapmi.o \
  maprtompmpr.o \
  maprtrace.o \
  maprtransf.o \
  maptomadp.o \
  maptomaup.o \
  mardet.o \
  marexp.o \
  marinv.o \
  marnsb.o \
  marrk.o \
  marsmul.o \
  martomami.o \
  martomapr.o \
  martrace.o \
  masrand.o \
  masum.o \
  masumspec.o \
  matransp.o \
  mavecmul.o \
  mavmulspec.o \
  mavpermut.o \
  mudpitmudpr.o \
  mudpitudpmi.o \
  vecdptovecp.o \
  vecilc.o \
  vecismul.o \
  vecisprod.o \
  vecitovecmi.o \
  vecitovecms.o \
  vecitovecpi.o \
  vecitovecr.o \
  veciunimtr.o \
  vecmilc.o \
  vecmismul.o \
  vecmisprod.o \
  vecmslc.o \
  vecmssmul.o \
  vecmssprod.o \
  vecneg.o \
  vecnegspec.o \
  vecpilc.o \
  vecpismul.o \
  vecpisprod.o \
  vecpitovpmi.o \
  vecpitovpms.o \
  vecpitovpr.o \
  vecpitransf.o \
  vecpitvpmpi.o \
  vecpmilc.o \
  vecpmismul.o \
  vecpmisprod.o \
  vecpmitovpmp.o \
  vecpmslc.o \
  vecpmssmul.o \
  vecpmssprod.o \
  vecpmstovpmp.o \
  vecprlc.o \
  vecprsmul.o \
  vecprsprod.o \
  vecprtovpmi.o \
  vecprtransf.o \
  vecprtvpmpr.o \
  vecptovecdp.o \
  vecptovecup.o \
  vecrlc.o \
  vecrsmul.o \
  vecrsprod.o \
  vecrtovecmi.o \
  vecrtovecpr.o \
  vecsum.o \
  vecsumspec.o \
  vecvpermut.o \
  vpmitransf.o \
  vpmstransf.o \
  vudpitudpmi.o \
  vudpitvudpr.o


LIB= ../../lib/lib_matr1.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
