/*M
.SH NAME
pmirem - polynomial over modular integers remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pmirem(r, M, P1, P2)  
single r; 
int M; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B M
is a prime number.
.TP 4
.B P1, P2
are polynomials in r variables over Z/(M*Z).
P2 != 0.
.PP
pmirem returns the remainder on dividing P1 by P2.

M*/

/*H
	Version 1       22.10.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pmirem        : 890501.9211__.941201
H*/
/*
	For the definition of pmirem please refer to the header file _pol1.h.
*/
