/*M
.SH NAME
putdippigbs - put distributive polynomial over polynomials over integers Groebner system

.SH SYNOPSIS
.nf
#include<_pol2.h>

single putdippigbs(r1, r2, GS, VL1, VL2, cs)  
single r1, r2, cs; 
list GS, VL1, VL2;
 
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
.B GS
is a Groebner system, created for example by dippicgb, i.e. GS is a kind of tree, with a pair of coefficient lists and the appendant Groebner basis in every edge. The coefficient lists are lists of polynomials in R2. The Groebner basis are lists of distributive polynomials in R1.  
.TP 4
.B cs
turns the output of the monomials with coefficient equal to 0 on (cs=0) or off (cs=1).
.PP
putdippigbs writes GS to stdout and returns 0 by success and ERROR else. The ends of the polynomials will be marked with '#'. 

.SH SEE ALSO
 dippicgb
 dippircgb
 fputdippigbs                                                            

M*/
 
/*H
	Version 1	10.05.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdippigbs   : 930531.9311__.941201
H*/
/*
	For the definition of putdippigbs please refer to the header file _pol2.h.
*/
