SUBDIRS= arith1 arith2 arith3 arith4 ec1 ec2 ec3 ec4 kern list \
	matr1 matr2 matr3 pol1 pol2 pol3 pol4

EXTSUBDIRS= smext

all:
	for i in $(SUBDIRS) ; do \
	  (cd $$i; make); \
	done
	for i in $(EXTSUBDIRS) ; do \
	  if test -d $$i; then \
	    (cd $$i; make); \
	  fi; \
	done

makefiles:
	for i in $(SUBDIRS) ; do \
	  (cd $$i ; awk -f ../Makemakefile.awk *.S); \
	done
	for i in $(EXTSUBDIRS) ; do \
	  if test -d $$i; then \
	    (cd $$i; awk -f ../Makemakefile.awk *.S); \
	  fi; \
	done

clean:
	for i in $(SUBDIRS) ; do \
	  (cd $$i; make clean); \
	done
	for i in $(EXTSUBDIRS) ; do \
	  if test -d $$i; then \
	    (cd $$i; make clean); \
	  fi; \
	done
	rm -f *~

veryclean:
	for i in $(SUBDIRS) ; do \
	  (cd $$i; make veryclean); \
	done
	for i in $(EXTSUBDIRS) ; do \
	  if test -d $$i; then \
	    (cd $$i; make veryclean); \
	  fi; \
	done

