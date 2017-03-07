/*M
.SH NAME
putdippidim - put distributive polynomial over polynomials over integers dimension

.SH SYNOPSIS
.nf
#include<_pol2.h>

single putdippidim(r1, r2, DIML, VL1, VL2)  
single r1, r2;
list DIML,VL1,VL2;
  
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.PP
Let R2 be a ring of polynomials in r2 variables over the integer numbers, and
R1 be a ring of polynomials in r1 variables over R2.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing the variables names used by the polynomials in R1 resp. R2.
.TP 4
.B DIML
is a list of conditions and dimensions, created for example by dippidim, (s.dippidim). The polynomials which appear in DIML are polynomials in R2, the end of a polynomial is marked with '#'.
.PP
putdippidim writes the list DIML to stdout, and returns 0 by success and ERROR else.

.SH SEE ALSO
 fputdippidim
 dippidim
 V. Weispfenning, Comprehensive Groebner Bases, MIP 9003
 E. Schoenfeld, Diplomarbeit: Parametrische Groebnerbasen
                im Computer Algebra System ALDES/SAC2
                1991 (Passau)                        

M*/
 
/*H
	Version 1	29.06.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdippidim   : 931130.941201
H*/
/*
	For the definition of putdippidim please refer to the header file _pol2.h.
*/
