/*M
.SH NAME
diptop - distributive polynomial to polynomial, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol diptop(r, P)  
single r; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a distributive polynomial in r variables.
.PP
diptop returns the polynomial P in recursive representation.

M*/

/*H
	Version 1       20.11.1987      B. Weis
   DATE diptop        : 890501.9211__
H*/


#include <_pol1.h>

pol diptop(r,P)
single r;
pol P;
{
	single e, e1;
	list E;
	pol P1, P1S, k;
	bind(P);
	init4(P1,P1S,k,E);


/* r oder P gleich 0 */

	if (!r  ||  !P) P1 = P;

/* r gleich 1 */

	else if (r == 1) {
		P1 = _0;
		while (P != _0) {
			k = lfirst(P);
			P = lred(P);
			e = lfirst(P);
			P = lred(P);
			e = lfirst(e);
			P1 = lcomp2(k,e,P1);
			}
		P1 = linv(P1);
		}

/* r groesser 1 */

	else {
		r--;
		P1 = _0;
		while (P != _0) {
			e = lfirst(lsecond(P));
			P1S = _0;
			do {
				e1 = lfirst(lsecond(P));
				if (e == e1) {
					k = lfirst(P);
					P = lred(P);
					E = lfirst(P);
					P = lred(P);
					E = lred(E);
					P1S = lcomp2(E,k,P1S);
					}
				}
			while (e == e1  &&  P != _0);
			P1S = linv(P1S);
			P1S = diptop(r,P1S);
			P1 = lcomp2(P1S,e,P1);
			}
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
