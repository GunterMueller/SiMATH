/*M
.SH NAME
putdippigt - put distributive polynomial over polynomials over integers Groebner test

.SH SYNOPSIS
.nf
#include<_pol2.h>

single putdippigt(r1, r2, CONDS ,PP ,CGB0 ,CGB1 ,VL1 ,VL2)  
single r1, r2;
list CONDS, PP, CGB0, CGB1, VL1, VL2;
         
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.PP
Let R2 be a ring of polynomials in r2 variables over the integer numbers, and
R1 be a ring of polynomials in r1 variables over R2.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing the variables names used by the
polynomials in R1 resp. R2.
.TP 4
.B CONDS
= {} or { V1 ... Vn }
is a list, consisting of an even number (say n) of lists, say Vi, (i = 1,...,n)
,
where Vi contains
.IP
 the coefficient polynomials which are equal to zero
 (i odd), or
 the coefficient polynomials which are unequal to zero
 (i even).
 (s.dippicgb)
.PP              
.PP
The coefficient polynomials are polynomials in R2.
.TP 4
.B PP
is a list of distributive polynomials in R1.
.TP 4
.B CGB0
is a list, which arises by CONDS and contains the conditions, so that PP is a Groebner basis (s. dippicgb and dippigt).
.TP 4
.B CGB1
is a list, which arises by CONDS and contains the conditions, so that PP is not a Groebner basis (s. dippicgb and dippigt).
.PP
putdippigt writes CONDS, PP, CGB0 and CGB1 to stdout and returns 0 by success and ERROR else.

.SH SEE ALSO
 dippicgb
 dippigt
 fputdippigt

M*/        

/*H
	Version 1	28.06.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdippigt    : 931130.941201
H*/
/*
	For the definition of putdippigt please refer to the header file _pol2.h.
*/
