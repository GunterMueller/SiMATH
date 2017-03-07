/*M
.SH NAME
ptodp - polynomial to dense polynomial, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol ptodp(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.PP
ptodp returns the polynomial P as a dense polynomial.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE ptodp         : 890501
H*/


#include <_pol1.h>

pol ptodp(r,P)
single r;
pol P;
{
	single eP;
	pol kP1, P1;
	bind(P);
	init2(kP1,P1);

/* P oder r gleich 0 */

	if (P == 0  ||  r == 0) P1 = P;

/* P,r ungleich 0 */

	else {
		eP = lfirst(P);
		P1 = list1(eP);
		r--;
		for ( ; eP >= 0; eP--) {
			if (P == _0  ||  lfirst(P) < eP) kP1 = 0;
			else {
				P = lred(P);
				kP1 = lfirst(P);
				P = lred(P);
				if (r) kP1 = ptodp(r,kP1);
				}
			P1 = lcomp(kP1,P1);
			}
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
