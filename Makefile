# This Makefile includes ./Makefile.flags in the current working
# directory.  All modifications should be done in ./Makefile.flags and
# not in this file.

include Makefile.flags

all: paths bin_SM libraries readline csimcalc doc

paths: 
	rm -f include/smconfig.h
	cp smconfig.h ./include 
	rm -f etc/SM.cmds
	cp SM.cmds ./etc
 
bin_SM: smconfig.h 
	(cd bin; make) 
 
readline:
	/bin/sh ./compile_readline

libraries: smconfig.h
	if test ! -d lib; then\
	  mkdir lib;\
	fi
	(cd sources; make)

csimcalc: smconfig.h
	(cd simcalc; make)
	(cd simcalc; make simcalc)

doc: 
	(cd doc; make)

install:
	@echo
	@echo "Type \"make SIMATH_install\" to install the system."
	@echo "Please note that this might overwrite the former version of SIMATH."
	@echo

SIMATH_install:
	-$(INSTALLDIR) ${SM_HOME}
	-$(INSTALLDIR) ${SM_HOME}/calcul
	-$(INSTALLDIR) ${SM_HOME}/calcul/help.text
	if test -d data; then $(INSTALLDIR) ${SM_HOME}/data; fi
	if test -d data; then $(INSTALLDIR) ${SM_HOME}/data/isiprime; fi
	if test -d data; then $(INSTALLDIR) ${SM_HOME}/data/modular-relations; fi
	if test -d data; then $(INSTALLDIR) ${SM_HOME}/data/isiprime/D; fi
	if test -d data; then $(INSTALLDIR) ${SM_HOME}/data/isiprime/W_D; fi
	-$(INSTALLDIR) ${SM_HOME}/etc
	-$(INSTALLDIR) ${SM_HOME}/examples
	-$(INSTALLDIR) ${SM_HOME}/examples/advanced
	-$(INSTALLDIR) ${SM_HOME}/examples/advanced/Groebner_basis
	-$(INSTALLDIR) ${SM_HOME}/examples/advanced/function_fields
	-$(INSTALLDIR) ${SM_HOME}/examples/advanced/number_fields
	-$(INSTALLDIR) ${SM_HOME}/examples/basics
	-$(INSTALLDIR) ${SM_HOME}/include
	-$(INSTALLDIR) ${SM_HOME}/bin
	-$(INSTALLDIR) ${SM_HOME}/sources
	-$(INSTALLDIR) ${SM_HOME}/lib
	$(INSTALLFILE) errmsg ${SM_HOME}/errmsg
	./install-dir "$(INSTALLFILE)" etc/ ${SM_HOME}/etc
	if test -d data; then ./install-dir "$(INSTALLFILE)" data/isiprime/ ${SM_HOME}/data/isiprime; fi
	if test -d data; then ./install-dir "$(INSTALLFILE)" data/modular-relations/ ${SM_HOME}/data/modular-relations; fi
	-$(INSTALLDIR) ${SM_HOME}/sources/arith1
	-$(INSTALLDIR) ${SM_HOME}/sources/arith2
	-$(INSTALLDIR) ${SM_HOME}/sources/arith3
	-$(INSTALLDIR) ${SM_HOME}/sources/arith4
	-$(INSTALLDIR) ${SM_HOME}/sources/ec1
	-$(INSTALLDIR) ${SM_HOME}/sources/ec2
	-$(INSTALLDIR) ${SM_HOME}/sources/ec3
	-$(INSTALLDIR) ${SM_HOME}/sources/ec4
	-$(INSTALLDIR) ${SM_HOME}/sources/kern
	-$(INSTALLDIR) ${SM_HOME}/sources/list
	-$(INSTALLDIR) ${SM_HOME}/sources/matr1
	-$(INSTALLDIR) ${SM_HOME}/sources/matr2
	-$(INSTALLDIR) ${SM_HOME}/sources/matr3
	-$(INSTALLDIR) ${SM_HOME}/sources/pol1
	-$(INSTALLDIR) ${SM_HOME}/sources/pol2
	-$(INSTALLDIR) ${SM_HOME}/sources/pol3
	-$(INSTALLDIR) ${SM_HOME}/sources/pol4
	(cd sources/arith1; tar cf - *.S) | (cd ${SM_HOME}/sources/arith1; tar xvf - )
	(cd ${SM_HOME}/sources/arith1; chmod 644 *.S)
	(cd sources/arith2; tar cf - *.S) | (cd ${SM_HOME}/sources/arith2; tar xvf - )
	(cd ${SM_HOME}/sources/arith2; chmod 644 *.S)
	(cd sources/arith3; tar cf - *.S) | (cd ${SM_HOME}/sources/arith3; tar xvf - )
	(cd ${SM_HOME}/sources/arith3; chmod 644 *.S)
	(cd sources/arith4; tar cf - *.S) | (cd ${SM_HOME}/sources/arith4; tar xvf - )
	(cd ${SM_HOME}/sources/arith4; chmod 644 *.S)
	(cd sources/ec1; tar cf - *.S) | (cd ${SM_HOME}/sources/ec1; tar xvf - )
	(cd ${SM_HOME}/sources/ec1; chmod 644 *.S)
	(cd sources/ec2; tar cf - *.S) | (cd ${SM_HOME}/sources/ec2; tar xvf - )
	(cd ${SM_HOME}/sources/ec2; chmod 644 *.S)
	(cd sources/ec3; tar cf - *.S) | (cd ${SM_HOME}/sources/ec3; tar xvf - )
	(cd ${SM_HOME}/sources/ec3; chmod 644 *.S)
	(cd sources/ec4; tar cf - *.S) | (cd ${SM_HOME}/sources/ec4; tar xvf - )
	(cd ${SM_HOME}/sources/ec4; chmod 644 *.S)
	(cd sources/kern; tar cf - *.S) | (cd ${SM_HOME}/sources/kern; tar xvf - )
	(cd ${SM_HOME}/sources/kern; chmod 644 *.S)
	(cd sources/list; tar cf - *.S) | (cd ${SM_HOME}/sources/list; tar xvf - )
	(cd ${SM_HOME}/sources/list; chmod 644 *.S)
	(cd sources/matr1; tar cf - *.S) | (cd ${SM_HOME}/sources/matr1; tar xvf - )
	(cd ${SM_HOME}/sources/matr1; chmod 644 *.S)
	(cd sources/matr2; tar cf - *.S) | (cd ${SM_HOME}/sources/matr2; tar xvf - )
	(cd ${SM_HOME}/sources/matr2; chmod 644 *.S)
	(cd sources/matr3; tar cf - *.S) | (cd ${SM_HOME}/sources/matr3; tar xvf - )
	(cd ${SM_HOME}/sources/matr3; chmod 644 *.S)
	(cd sources/pol1; tar cf - *.S) | (cd ${SM_HOME}/sources/pol1; tar xvf - )
	(cd ${SM_HOME}/sources/pol1; chmod 644 *.S)
	(cd sources/pol2; tar cf - *.S) | (cd ${SM_HOME}/sources/pol2; tar xvf - )
	(cd ${SM_HOME}/sources/pol2; chmod 644 *.S)
	(cd sources/pol3; tar cf - *.S) | (cd ${SM_HOME}/sources/pol3; tar xvf - )
	(cd ${SM_HOME}/sources/pol3; chmod 644 *.S)
	(cd sources/pol4; tar cf - *.S) | (cd ${SM_HOME}/sources/pol4; tar xvf - )
	(cd ${SM_HOME}/sources/pol4; chmod 644 *.S)
	$(INSTALLFILE) lib/lib_arith1.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_arith2.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_arith3.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_arith4.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_ec1.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_ec2.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_ec3.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_ec4.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_kern.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_list.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_matr1.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_matr2.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_matr3.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_pol1.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_pol2.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_pol3.a ${SM_HOME}/lib
	$(INSTALLFILE) lib/lib_pol4.a ${SM_HOME}/lib
	./install-dir "$(INSTALLFILE)" simcalc/calcul/calc. ${SM_HOME}/calcul
	./install-dir "$(INSTALLFILE)" simcalc/calcul/help.text/ ${SM_HOME}/calcul/help.text
	./install-dir "$(INSTALLFILE)" include/ ${SM_HOME}/include
	$(INSTALLBIN) bin/dr ${SM_HOME}/bin
	$(INSTALLBIN) bin/SM ${SM_HOME}/bin
	$(INSTALLBIN) bin/CCC ${SM_HOME}/bin
	$(INSTALLBIN) bin/cmd ${SM_HOME}/bin
	$(INSTALLBIN) bin/ExtractKeywords ${SM_HOME}/bin
	$(INSTALLBIN) bin/FormatKeywords ${SM_HOME}/bin
	$(INSTALLBIN) bin/preV3_1.x ${SM_HOME}/bin	
	$(INSTALLBIN) bin/preproc.x ${SM_HOME}/bin
	$(INSTALLBIN) bin/cut_doc ${SM_HOME}/bin
	$(INSTALLBIN) bin/unknown-cmd ${SM_HOME}/bin
	$(INSTALLBIN) bin/smman ${SM_HOME}/bin
	$(INSTALLBIN) bin/smsrc ${SM_HOME}/bin
	$(INSTALLBIN) bin/xsrc  ${SM_HOME}/bin
	$(INSTALLBIN) simcalc/simcalc ${SM_HOME}/bin
	$(INSTALLFILE) examples/README ${SM_HOME}/examples
	$(INSTALLFILE) examples/advanced/README ${SM_HOME}/examples/advanced
	./install-dir "$(INSTALLFILE)" examples/advanced/Groebner_basis/ ${SM_HOME}/examples/advanced/Groebner_basis
	./install-dir "$(INSTALLFILE)" examples/advanced/function_fields/ ${SM_HOME}/examples/advanced/function_fields
	./install-dir "$(INSTALLFILE)" examples/advanced/number_fields/ ${SM_HOME}/examples/advanced/number_fields
	./install-dir "$(INSTALLFILE)" examples/basics/ ${SM_HOME}/examples/basics
	(cd ${SM_HOME}/lib; $(RANLIB) lib_arith1.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_arith2.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_arith3.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_arith4.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_ec1.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_ec2.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_ec3.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_ec4.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_kern.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_list.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_matr1.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_matr2.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_matr3.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_pol1.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_pol2.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_pol3.a)
	(cd ${SM_HOME}/lib; $(RANLIB) lib_pol4.a)
	(cd ${SM_HOME}; chmod 777 lib)

	-if test -d sources/smext; then $(INSTALLDIR) ${SM_HOME}/sources/smext; fi
	if test -d sources/smext; then (cd sources/smext; tar cf - *.S) | (cd ${SM_HOME}/sources/smext; tar xvf - ); fi
	if test -d sources/smext; then (cd ${SM_HOME}/sources/smext; chmod 644 *.S); fi
	if test -d sources/smext; then $(INSTALLFILE) lib/lib_smext.a ${SM_HOME}/lib; fi
	if test -d sources/smext; then (cd ${SM_HOME}/lib; $(RANLIB) lib_smext.a); fi


links:
	-$(INSTALLDIR) ${BINDIR}
	-${LN_S} ${SM_HOME}/bin/SM ${BINDIR}/SM
	-${LN_S} ${SM_HOME}/bin/CCC ${BINDIR}/CCC
	-${LN_S} ${SM_HOME}/bin/simcalc ${BINDIR}/simcalc
	-${LN_S} ${SM_HOME}/bin/srctrans ${BINDIR}/srctrans
	-${LN_S} ${SM_HOME}/bin/cmd ${BINDIR}/cmd
	-${LN_S} ${SM_HOME}/bin/dr ${BINDIR}/dr
	-${LN_S} ${SM_HOME}/bin/smman ${BINDIR}/smman
	-${LN_S} ${SM_HOME}/bin/smsrc ${BINDIR}/smsrc
	-${LN_S} ${SM_HOME}/bin/xsrc  ${BINDIR}/xsrc

clean:
	-rm -f core
	-rm -f *.bak
	-rm -f *_CC
	-rm -f *.o
	-rm -f *~
	-rm -f simcalc/lib/*.a
	-rm -f lib/*.a
	-rm -f include/smconfig.h
	-rm -rf ./readline-2.0/readline
	-(cd bin; make clean)
	-(cd doc; make clean)
	-(cd packages; make clean)
	-(cd readline-2.0; make clean)
	-(cd simcalc; make clean)
	-(cd sources; make clean)
	touch smconfig.h

veryclean: release-clean

release-clean:
	rm -f compile_readline
	rm -f SM.cmds
	rm -f bin/lex.yy.c
	rm -f config.cache
	rm -f config.log
	rm -f config.status
	rm -f etc/SM.cmds
	rm -f smconfig.h
	rm -f hosttype
	rm -f readline-2.0/Makefile
	rm -f readline-2.0/config.h
	rm -f readline-2.0/stamp-config
	rm -f readline-2.0/config.status
	rm -f bin/smman
	rm -f bin/smsrc
	rm -f bin/xsrc

uninstall:
	rm -f ${BINDIR}/SM
	rm -f ${BINDIR}/CCC
	rm -f ${BINDIR}/simcalc
	rm -f ${BINDIR}/srctrans
	rm -f ${BINDIR}/cmd
	rm -f ${BINDIR}/dr
	rm -f ${BINDIR}/smman
	rm -f ${BINDIR}/smsrc
	rm -f ${BINDIR}/xsrc
	rm -fr ${SM_HOME}

###
### targets for developers
###

check:	all
	if test -d test; then\
	  (cd test; make);\
	fi

configure: configure.in
	autoconf
