/*M
.SH NAME
ispconst - is polynomial constant ?

.SH SYNOPSIS
.nf
#include<_pol1.h>

single ispconst(r, P, pC) 
single r; 
pol P; 
obj *pC;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.PP
If the polynomial P is constant, ispconst returns 1 and writes the constant to *pC, else ispconst returns 0 and writes 0 to *pC.

M*/

/*H
	Version 1       02.03.1988      B. Weis
   DATE ispconst      : 890501
H*/


#include <_pol1.h>

single ispconst(r,P,pC)
single r;
pol P;
obj *pC;
{
	single n=1;

	if (P) {
		for ( ; r; r--) {
			if (lfirst(P)) {n = 0; *pC = 0; break;}
			P = lfirst(lred(P));
			}
		}
	if (n) *pC = P;

/* Ausgabe */

	return(n);
}
