include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  ecgf2btco.o \
  ecgf2disc.o \
  ecgf2doubp.o \
  ecgf2fmoplam.o \
  ecgf2jinv.o \
  ecgf2lp.o \
  ecgf2mopto.o \
  ecgf2mul.o \
  ecgf2neg.o \
  ecgf2sfmuls.o \
  ecgf2sfsums.o \
  ecgf2srpp.o \
  ecgf2sum.o \
  ecgf2tavb6.o \
  ecgf2tavb8.o \
  ecgf2tavc6.o \
  ecimeqsaSip.o \
  eciminbmwg.o \
  eciminbrtmp.o \
  ecimindiv.o \
  ecimindivby2.o \
  ecimindivs.o \
  ecimingentor.o \
  eciminpcmt.o \
  eciminplu.o \
  eciminreg.o \
  eciminrt.o \
  eciminsaip.o \
  eciminsetb.o \
  ecimintate.o \
  ecimintorgr.o \
  ecisnfSiphhb.o \
  ecisnfbmwg.o \
  ecisnfgentor.o \
  ecisnfhhb.o \
  ecisnfpbwh.o \
  ecisnfsaip.o \
  ecisnfsaipub.o \
  ecisnfsetb.o \
  ecisnftorgr.o \
  ecitatealg.o \
  ecmipsnfnpsv.o \
  ecmpsnffmopl.o \
  ecmpsnffmopr.o \
  ecmpsnfmopto.o \
  ecmpsnfmsha1.o \
  ecmpsnfnpm2.o \
  ecmspsnfsha.o \
  ecnfbtco.o \
  ecnfdisc.o \
  ecnfjinv.o \
  ecnflp.o \
  ecnfmul.o \
  ecnfneg.o \
  ecnfsnfdisc.o \
  ecnfsnfjinv.o \
  ecnfsnflp.o \
  ecnfsnfmul.o \
  ecnfsnfneg.o \
  ecnfsnfsum.o \
  ecnfsrpp.o \
  ecnfsum.o \
  ecnftavb6.o \
  ecnftavb8.o \
  ecnftavc6.o \
  ecnftosnf.o \
  ecpcnflhaav.o \
  ecpcnflhnaav.o \
  ecpcnfmineqnaav.o \
  ecpcnfnetahe.o \
  ecpcnfreg.o \
  ecqnfacb2.o \
  ecqnfacb4.o \
  ecqnfacb6.o \
  ecqnfacb8.o \
  ecqnfacc4.o \
  ecqnfacc6.o \
  ecqnfacdisc.o \
  ecqnfacfnd.o \
  ecqnfacndisc.o \
  ecqnfacpifdi.o \
  ecqnfbtco.o \
  ecqnfbtcol.o \
  ecqnfbtconc.o \
  ecqnfbtinv.o \
  ecqnfbtlp.o \
  ecqnfbtp.o \
  ecqnfbtsnf.o \
  ecqnfclp.o \
  ecqnfclpp.o \
  ecqnfclser.o \
  ecqnfcond.o \
  ecqnfdwhnth.o \
  ecqnfinit.o \
  ecqnfjinv.o \
  ecqnflcond.o \
  ecqnflhaav.o \
  ecqnflhnaav.o \
  ecqnflistcP.o \
  ecqnflistrt.o \
  ecqnflserfd.o \
  ecqnflserhd.o \
  ecqnflsers.o \
  ecqnfmineqnaav.o \
  ecqnfminnaav.o \
  ecqnfminnth.o \
  ecqnfncond.o \
  ecqnfnetahe.o \
  ecqnfnetapa.o \
  ecqnfpifcond.o \
  ecqnfpnp.o \
  ecqnfpnp23.o \
  ecqnfprojtop.o \
  ecqnfptlin.o \
  ecqnfrank.o \
  ecqnfreddec.o \
  ecqnfreg.o \
  ecqnfrt.o \
  ecqnfsigns.o \
  ecqnftatealg.o \
  ecqnftoeci.o \
  ecqnfwehe.o \
  ecracbmwg.o \
  ecracgentor.o \
  ecracsaip.o \
  ecracsetb.o \
  ecractorgr.o \
  ecrcharpol.o \
  ecrclser.o \
  ecrcond.o \
  ecrexptor.o \
  ecrfcond.o \
  ecrfelser.o \
  ecrg2dhomsp.o \
  ecrlser.o \
  ecrlserfd.o \
  ecrlserfds.o \
  ecrlserhd.o \
  ecrlserhdlc.o \
  ecrlserhdsc.o \
  ecrlserrkd.o \
  ecrlserrkds.o \
  ecrlsers.o \
  ecrmaninalg.o \
  ecrordtor.o \
  ecrordtsg.o \
  ecrprodcp.o \
  ecrrank.o \
  ecrrank2d.o \
  ecrrankbsd.o \
  ecrrankg2d.o \
  ecrranks.o \
  ecrregmat.o \
  ecrregulator.o \
  ecrsetrank.o \
  ecrsetsign.o \
  ecrsevrm.o \
  ecrsign.o \
  ecrsigns.o \
  ecrsolve2c.o \
  ecrstrtor.o \
  eiqislip.o \
  eiqispbh.o \
  eqisnfa4.o \
  eqisnfa6.o \
  eqisnfb2.o \
  eqisnfb4.o \
  eqisnfb6.o \
  eqisnfb8.o \
  eqisnfbtac.o \
  eqisnfbtco.o \
  eqisnfc4.o \
  eqisnfc6.o \
  eqisnfdisc.o \
  eqisnfdouble.o \
  eqisnfminnaav.o \
  eqisnfmul.o \
  eqisnfneg.o \
  eqisnfpnp.o \
  eqisnfrt.o \
  eqisnfslip.o \
  eqisnfspbh.o \
  eqisnfsum.o \
  erqislip.o \
  erqispbh.o \
  iseciminlpld.o \
  isecimintorp.o \
  iselecgf2.o \
  iselecnf.o \
  iselecnfsnf.o \
  isineciminpl.o \
  ispeqisnf.o \
  ispeqisnfsp.o \
  isponecqnf.o \
  isppecgf2eq.o \
  isppecgf2pai.o \
  isppecnfeq.o \
  isppecnfpai.o


LIB= ../../lib/lib_ec2.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
