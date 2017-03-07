/*M
.SH NAME
putdippiqff - put distributive polynomial over polynomials over integers quantifier free formula

.SH SYNOPSIS
.nf
#include<_pol2.h>

single putdippiqff(r1, r2, QFFL, VL1, VL2)  
single r1, r2;
list QFFL, VL1,i VL2;
                      
.SH DESCRIPTION
B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.PP
Let R2 be a ring of polynomials in r2 variables over the integer numbers, and
R1 be a ring of polynomials in r1 variables over R2.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing the variables names used by the polynomials in R1 resp. R2.
.TP 4
.B QFFL
is the quantifier free formula of a basis, created for example by dippiqff (s.dippiqff).
.PP
putdippiqff writes QFFL to stdout, in the shape
.PP
             ( ( a == 0 )  or
             ( b != 0 )  or ... or  ( c != 0 ) )

             and

             ( ( d == 0 )  or
             ( e != 0 )  or ... or  ( f != 0 ) )

             and
             .
             .
             .
             and

             ( ( g == 0 )  or
             ( h != 0 )  or ... or  ( k != 0 ) );
.PP
whereat
.TP
.B a,b,c,...                        
are coefficients polynomials (polynomials in R2).
.PP
putdippiqff returns 0 by success and ERROR else.

.SH SEE ALSO
 fputdippiqff
 dippiqff
 V. Weispfenning, Comprehensive Groebner Bases, MIP 9003
 E. Schoenfeld, Diplomarbeit: Parametrische Groebnerbasen
                im Computer Algebra System ALDES/SAC2
     
M*/
   
/*H
	Version 1	21.05.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE putdippiqff   : 931130.941201
H*/
/*
	For the definition of putdippiqff please refer to the header file _pol2.h.
*/
