include ../../Makefile.flags


SMBIN = ../../bin


OBJECTS = \
  placebo.o


LIB= ../../lib/lib_ec4.a


all: ${LIB}


clean:
	rm -f *.P *.c *.o *~


veryclean: clean
	rm -f ${LIB}


${LIB}: ${OBJECTS}
	${AR} rc $@ ${OBJECTS}
	- ${RANLIB} ${LIB}
