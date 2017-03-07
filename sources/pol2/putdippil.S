/*M
.SH NAME
putdippil - put distributive polynomial over polynomials over integers list

.SH SYNOPSIS
.nf
#include<_pol2.h>

single putdippil( r1, r2, PL, VL1, VL2)
single r1, r2;
list PL, VL1, VL2;

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
.B PL
is a list of distributive polynomials in R1.
.PP
putdippil writes the list Pl to stdout, in the shape
.IP
{ p1, ..., pm }.
.PP
The ends of the polynomials will be marked with '#'.
.PP
putdippil returns 0 by success or ERROR else.

.SH SEE ALSO
 fputdippil
 fgetdippil
 getdippil

M*/               

/*H
	Version 1	10.05.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdippil     : 930531.9311__.941201
H*/
/*
	For the definition of putdippil please refer to the header file _pol2.h.
*/
