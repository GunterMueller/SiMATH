/*M
.SH NAME
getdippicd - get distributive polynomial over polynomials over integers case distinction

.SH SYNOPSIS
.nf
#include<_pol2.h>

list getdippicd(r1, r2, VL1, VL2, fac)  
single r1, r2, fac;
list VL1, VL2;     
        
.SH DESCRIPTION
.TP 4
.B r1, r2
are integer numbers, 0 <= r1,r2 < BASIS.
.TP 4
.B VL1, VL2
are lists of lenght r1 resp. r2, containing variables names (s.pmakevl).
.PP
getdippicd reads a list, say CONDS (used for example by dippicgb) from stdin and returns it, where
.TP 4
.B CONDS
= {} or { V1 ... Vn }
is a list, consisting of an even number (say n) of lists, say Vi, (i = 1,...,n),
where Vi contains
.IP
 the coefficient polynomials which are equal to zero
 (i odd), or
 the coefficient polynomials which are unequal to zero
 (i even).
.PP
(s. dippicbg or dippircgb)                            
.PP
The coefficient polynomials are polynomials in r2 variables over the integer numbers.
.PP
.TP 4
.B fac 
turns the factorization of the coefficient polynomials on (fac=1) or off(fac=0).
.PP
getdippicd returns ERROR in the case of an error occurs.

.SH SEE ALSO
 dippicgb
 dippirgcb
 pmakevl

M*/
                      
/*H
	Version 1	10.05.1993	Th. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE getdippicd    : 930531.9311__.941201
H*/
/*
	For the definition of getdippicd please refer to the header file _pol2.h.
*/
