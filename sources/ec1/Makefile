include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  ecimina1.o \
  ecimina2.o \
  ecimina3.o \
  ecimina4.o \
  ecimina6.o \
  eciminb2.o \
  eciminb4.o \
  eciminb6.o \
  eciminb8.o \
  eciminbtac.o \
  eciminbtco.o \
  eciminbtsnf.o \
  eciminc4.o \
  eciminc6.o \
  ecimindif.o \
  ecimindisc.o \
  ecimindouble.o \
  ecimindwhnth.o \
  eciminelog.o \
  eciminfdisc.o \
  eciminlhaav.o \
  eciminlhnaav.o \
  eciminmrtmp.o \
  eciminmul.o \
  eciminneg.o \
  eciminnetahe.o \
  eciminnetapa.o \
  eciminntheps.o \
  eciminplinsp.o \
  eciminsum.o \
  ecimintosnf.o \
  ecipnorm.o \
  ecisnfa4.o \
  ecisnfa6.o \
  ecisnfb2.o \
  ecisnfb4.o \
  ecisnfb6.o \
  ecisnfb8.o \
  ecisnfbtac.o \
  ecisnfbtco.o \
  ecisnfbtmin.o \
  ecisnfc4.o \
  ecisnfc6.o \
  ecisnfdif.o \
  ecisnfdisc.o \
  ecisnfdouble.o \
  ecisnfdwhnth.o \
  ecisnfelog.o \
  ecisnfelogp.o \
  ecisnffdisc.o \
  ecisnfmul.o \
  ecisnfneg.o \
  ecisnfrroots.o \
  ecisnfsum.o \
  ecitavalb.o \
  ecitavalc.o \
  ecmpbtco.o \
  ecmpdisc.o \
  ecmpdoubp.o \
  ecmpfp.o \
  ecmpjinv.o \
  ecmplp.o \
  ecmpmul.o \
  ecmpneg.o \
  ecmpsnfdisc.o \
  ecmpsnffp.o \
  ecmpsnfjinv.o \
  ecmpsnflp.o \
  ecmpsnfmontmul.o \
  ecmpsnfmul.o \
  ecmpsnfmuls.o \
  ecmpsnfneg.o \
  ecmpsnfsum.o \
  ecmpsnfsums.o \
  ecmpsrpp.o \
  ecmpsum.o \
  ecmptavb6.o \
  ecmptavb8.o \
  ecmptavc6.o \
  ecmptosnf.o \
  ecmspnp.o \
  ecmspsnfnp.o \
  ecraca1.o \
  ecraca2.o \
  ecraca3.o \
  ecraca4.o \
  ecraca6.o \
  ecracb2.o \
  ecracb4.o \
  ecracb6.o \
  ecracb8.o \
  ecracbtco.o \
  ecracbtmin.o \
  ecracbtsnf.o \
  ecracc4.o \
  ecracc6.o \
  ecracdif.o \
  ecracdisc.o \
  ecracdouble.o \
  ecracdwhnth.o \
  ecracelog.o \
  ecracfdisc.o \
  ecracmul.o \
  ecracneg.o \
  ecracsum.o \
  ecractoimin.o \
  ecracweilhe.o \
  ecrbtco.o \
  ecrbtconc.o \
  ecrbtinv.o \
  ecrbtlistp.o \
  ecrbtp.o \
  ecrcperiod.o \
  ecrfdenjinv.o \
  ecrinit.o \
  ecrjinv.o \
  ecrnpmsp.o \
  ecrpcomp.o \
  ecrpnorm.o \
  ecrptoproj.o \
  ecrquotper.o \
  ecrrl.o \
  ecrrperiod.o \
  ecrrt.o \
  ecrsnfrroots.o \
  ecrtavalb.o \
  ecrtavalc.o \
  fgetecr.o \
  fgetecrp.o \
  fputecimin.o \
  fputecisnf.o \
  fputecr.o \
  fputecrac.o \
  fputecrinv.o \
  fputecrlistp.o \
  fputecrp.o \
  getecr.o \
  getecrp.o \
  iselecmp.o \
  iselecmpsnf.o \
  ispecrpai.o \
  isponecimin.o \
  isponecisnf.o \
  isponecrac.o \
  isppecmpeq.o \
  isppecmppai.o \
  putecimin.o \
  putecisnf.o \
  putecr.o \
  putecrac.o \
  putecrinv.o \
  putecrlistp.o \
  putecrp.o


LIB= ../../lib/lib_ec1.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
