/*M
.SH NAME
dptop - dense polynomial to polynomial, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dptop(r, P) 
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a dense polynomial in r variables.
.PP
dptop returns the polynomial P in recursive representation.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE dptop         : 890501
H*/


#include <_pol1.h>

pol dptop(r,P)
single r;
pol P;
{
	single e;
	pol P1=0, k;
	bind2(P,P1);
	init(k);

/* r gleich 0 */

	if (!r) P1 = P;

/* r und P ungleich 0 */

	else if (P) {
		e = lfirst(P);
		P = lred(P);
		P1 = _0;
		r--;
		do {
			k = lfirst(P);
			P = lred(P);
			if (k) {
				if (r) k = dptop(r,k);
				P1 = lcomp2(k,e,P1);
				}
			e--;
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
