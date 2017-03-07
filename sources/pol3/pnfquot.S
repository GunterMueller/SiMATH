/*M
.SH NAME
pnfquot - polynomial over number field quotient
(MACRO)     

.SH SYNOPSIS
.nf
#include<_pol3.h>

pol pnfquot(r, F, P1, P2) 
single r; 
pol F, P1, P2;
  
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B F
is an irreducible, univariate polynomial in dense representation over Z. F generates a number field, say K.
.TP 4
.B P1, P2
are polynomials in r variables over K. P2 != 0.
.PP
pnfquot returns a polynomial over K, say P3, where
.IP                                         
P3 = P1 / P2.

M*/
              
/*H
	Version 1       16.11.1989      A.Stein
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pnfquot       : 900315.941201
H*/
/*
	For the definition of pnfquot please refer to the header file _pol3.h.
*/
