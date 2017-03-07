/*M
.SH NAME
putdippicgb - put distributive polynomial over polynomials over integers comprehensive Groebner basis

.SH SYNOPSIS
.nf
#include<_pol2.h>

single putdippicgb(r1, r2, CGBL, i, VL1, VL2)  
single r1, r2, i;
list CGBL, VL1, VL2;
                                                                  
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
.B CGBL
is a list, created by dippicgb resp. dippircgb, which contains a comprehensive r
esp. reduced comprehensive Groebner basis.
.IP
The polynomials in CGBL are polynomials in R1.
.TP 4
.B i
is the number of edges of the respective Groebner system.  
.PP
putdippicgb writes CGBL and i to stdout in the shape
.IP
 {
  p1
  ...
  pm
 }
 i condition(s)
.PP
where the pi, i=1,...,m, are the polynomials of the basis.
.PP
putdippicgb returns 0 by success, ERROR else.

.SH SEE ALSO
 dippicgb
 dippircgb
                                           
M*/
                     
/*H
        Version 1	28.06.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdippicgb   : 931130.941201
H*/
/*
	For the definition of putdippicgb please refer to the header file _pol2.h.
*/
