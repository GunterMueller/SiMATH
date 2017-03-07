/*M
.SH NAME
pirem - polynomial over integers remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pirem(r, P1, P2) 
single r; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over the integer numbers. P2 != 0.
.PP
pirem returns the remainder on dividing P1 by P2.

M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2	18.11.94	Macro nur noch im Header definiert. MP
   DATE pirem         : 890501.941201
H*/
/*
	For the definition of pirem please refer to the header file _pol1.h.
*/
