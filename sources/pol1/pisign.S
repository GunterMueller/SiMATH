/*M
.SH NAME
pisign - polynomial over integers sign, base variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

single pisign(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
pisign returns the sign of the leading base coefficient   ( with regard to the main variable ) of P.
 
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pisign        : 890501
H*/


#include <_pol1.h>

single pisign(r,P)
single r;
pol P;
{
	single a;
	bind(P);
	init(a);

/* Berechnung von a */

	a = plbc(r,P);
	a = isign(a);

/* Ausgabe */

	return(a);
}
