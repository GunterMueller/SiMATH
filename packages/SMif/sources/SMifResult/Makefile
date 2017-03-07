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

all: lib update

lib: 
	$(CC) -c SMifResult.c SMifResult.o


update:
	- (ar rv ../../../../sources/lib_list.a *.o)
	- (cp -f _SMifRes.h ../../../../header)

clean: 
	(rm -rf *.o core)
