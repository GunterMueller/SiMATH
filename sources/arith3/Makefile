include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  fgetrfmsp1.o \
  fgetrfr.o \
  fputrfr.o \
  gf2efe.o \
  gf2ies.o \
  gfsalgenies.o \
  gfsalgiessp.o \
  isrfmsp1.o \
  isrfr.o \
  isrfrone.o \
  pirtransf.o \
  pitorfr.o \
  prrtransf.o \
  prtorfr.o \
  qffmibinary.o \
  qffmibsrpi.o \
  qffmicld.o \
  qffmiclint.o \
  qffmiclsum.o \
  qffmigsdrpi.o \
  qffmigsrpi.o \
  qffminearest.o \
  qffmipidpr.o \
  qffmipidprs.o \
  qffmipidsqu.o \
  qffmipidsqus.o \
  qffmipitest.o \
  qffmipower.o \
  qffmiregbg.o \
  qffmiregbgb.o \
  qffmirpidred.o \
  qffmirqired.o \
  qffmirspidrd.o \
  qffmispidpr.o \
  qffmispidprs.o \
  qffmispidsqs.o \
  qffmispidsqu.o \
  qffmisrqired.o \
  qffmsbinary.o \
  qffmsbsrpi.o \
  qffmscld.o \
  qffmsclint.o \
  qffmsclsum.o \
  qffmsdcn.o \
  qffmsdcns1.o \
  qffmsdcns2.o \
  qffmsdcns3.o \
  qffmsfubs.o \
  qffmsfuobs.o \
  qffmsgsdrpi.o \
  qffmsgsrpi.o \
  qffmsicggii.o \
  qffmsicggir.o \
  qffmsicgrep.o \
  qffmsicgri.o \
  qffmsicgrr.o \
  qffmsicgsti.o \
  qffmsicgstr.o \
  qffmsicn.o \
  qffmsipidred.o \
  qffmsiselic.o \
  qffmsiseqids.o \
  qffmsispidrd.o \
  qffmsmulti.o \
  qffmsmulti0.o \
  qffmsmulti1.o \
  qffmsmulti2.o \
  qffmsmulti3.o \
  qffmsmulti4.o \
  qffmsnearest.o \
  qffmsordsici.o \
  qffmsordsicr.o \
  qffmspidgenr.o \
  qffmspidpr.o \
  qffmspidprs.o \
  qffmspidsqu.o \
  qffmspidsqus.o \
  qffmspitest.o \
  qffmspower.o \
  qffmsreg.o \
  qffmsregbg.o \
  qffmsregbg0.o \
  qffmsregbg1.o \
  qffmsregbg2.o \
  qffmsregbg3.o \
  qffmsregbg4.o \
  qffmsregbgb.o \
  qffmsregbgb0.o \
  qffmsregbgb1.o \
  qffmsregbgb2.o \
  qffmsregbgb3.o \
  qffmsregbgb4.o \
  qffmsregbgv.o \
  qffmsregbs.o \
  qffmsregobg.o \
  qffmsregobs.o \
  qffmsrpidred.o \
  qffmsrqired.o \
  qffmsrspidrd.o \
  qffmsspidpr.o \
  qffmsspidprs.o \
  qffmsspidsqs.o \
  qffmsspidsqu.o \
  qffmssrqired.o \
  qffmszcgiti.o \
  qffmszcgitr.o \
  rfmsp1cons.o \
  rfmsp1dif.o \
  rfmsp1inv.o \
  rfmsp1neg.o \
  rfmsp1prod.o \
  rfmsp1quot.o \
  rfmsp1sum.o \
  rfrcons.o \
  rfrdif.o \
  rfrinv.o \
  rfrneg.o \
  rfrprod.o \
  rfrquot.o \
  rfrsum.o \
  rfrtransf.o \
  rtorfr.o


LIB= ../../lib/lib_arith3.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
