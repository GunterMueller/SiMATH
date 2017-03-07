/*M
.SH NAME
pred - polynomial reductum

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pred(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.PP
pred returns the polynomial reductum P1 of P, i.e.
.PP
P1 = P - (monomials of highest degree in the main
          variable)
 or, for P = 0, pred returns 0. 

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pred          : 890501.941201
H*/
/*
	For the definition of pred please refer to the header file _pol1.h.
*/
