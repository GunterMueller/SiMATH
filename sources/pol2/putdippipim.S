/*M
.SH NAME
putdippipim - put distributive polynomial over polynomials over integers parametric ideal membership test

.SH SYNOPSIS
.nf
#include<_pol2.h>

single putdippipim(r1, r2, NOUT, VL1, VL2)  
single r1, r2;
list NOUT, VL1, VL2;
                          
.SH DESCRIPTION
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.PP
Let R2 be a ring of polynomials in r2 variables over the integer numbers, and
R1 be a ring of polynomials in r1 variables over R2.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing the variables names used by the polynomials in R1 resp. R2.
.TP 4
.B NOUT
is a list, consisting of the polynomials, tested for parametric ideal membership, the conditions and normal forms, so that a  polynomial is member of the ideal, and the conditions and normal forms, so that a polynomial is not member of the
ideal (s. dippipim). The polynomials occuring are polynomials in R1.     
.PP
putdippipim writes NOUT to stdout, in the shape
.nf
.IP
tested polynomial
TP1 #
.IP
polynomial completely reduced for
the following condition(s)
.IP
condition:
{
{ cfp11 # ... cfp1m # } == 0
{ cfp21 # ... cfp2n # } != 0
}
factor
cff1 #

 .
 .
 .

polynomial not completely reduced for
the following condition(s)

condition:
{
{ cfp31 # ... cfp3l # } == 0
{ cfp41 # ... cfp4k # } != 0
}
reduced to
RTP1 #
factor
cff2 #

 .
 .
 .

quantifier free formula for
parametric ideal membership
( ( a == 0 )  and ... and  ( b == 0 )  and ( c != 0 )  and  
 ... and  ( d != 0 ) )

or
 .
 .
 .
or

( ( e == 0 )  and ... and  ( f == 0 )  and ( g != 0 )  and
 ... and  ( h != 0 ) )

tested polynomial
TP2 #

 .
 .
 .    ,
.PP
whereat
.TP
.B TP1, TP2
are the tested polynomials,
.TP 4                                  
.B cfpij
are coefficient polynomials, creating the conditions, and
.TP 4
.B a,b,c,...
are coefficient polynomials.
.PP
putdippipim returns 0 by success and ERROR else.

.SH SEE ALSO
 dippipim
 fputdippipim
                                    
M*/
                      
/*H
        Version 1	12.06.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdippipim   : 931130.941201
H*/
/*
	For the definition of putdippipim please refer to the header file _pol2.h.
*/
