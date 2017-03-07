# 
# -----------------------------------------------------------------------------
# 
# This file is part of the computer algebra system SIMATH.
# 
# SIMATH is a common software product of the SIMATH group in Saarbruecken
# and the Siemens AG. Copyright (C) 1992-1996 by the SIMATH group in
# Saarbruecken and the Siemens AG/Munich.
# 
# The computer algebra system SIMATH is free software for universities
# and scientific research institutions as long as it is used for purely
# scientific purposes only. This software is distributed in the hope that
# it will be useful, but
# 
# 			WITHOUT ANY WARRANTY.
# 
# 
# Permission is hereby granted to copy the system for any 
# 
# 			PURELY SCIENTIFIC
# 
# purposes, provided the above notices are retained on all copies.
# 
# If you intend to use SIMATH for other applications, please contact
# 	
# 	SIEMENS AG
# 	Corporate Research and Development
# 	Dept. ZFE ST SN 3
# 	D-81730 Munich
# 
# Upon reception of this software, please send e-mail messages to
# 
# 	simath@math.uni-sb.de 			and to	
# 	Pascale.Serf@zfe.siemens.de
# 
# to inform us that you got a copy of the system. 
# 
# Redistribution of this software - either in source or binary form - is
# not permitted.

# This Makefile includes ./Makefile.flags in the current working
# directory.  All modifications should be done in ./Makefile.flags and
# not in this file.


include ../../../../Makefile.flags


### Version zum Debuggen
#CFLAGS = -g -DCPP -DGPP -I$(TCLINC)

### Optimierte Version
CFLAGS = -O -DCPP -DGPP -I$(TCLINC)


OFILES = SMif.o SMifbasedef.o SMifmain.o \
         SMifpowerstring.o

SMif: $(OFILES)
	  $(CC) $(CFLAGS) -o $@ $(OFILES) $(TCLLIB)

clean:
	rm -f $(OFILES)

SMif.o: SMif.h
SMif.o: SMifbasedef.h
SMif.o: SMifpowerstring.h
SMifbasedef.o: SMifbasedef.h
SMifmain.o: SMif.h
SMifmain.o: SMifbasedef.h
SMifmain.o: SMifpowerstring.h
SMifpowerstring.o: SMifpowerstring.h
SMifpowerstring.o: SMifbasedef.h

# DO NOT DELETE THESE LINES

