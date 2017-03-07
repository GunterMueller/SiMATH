/*M
.SH NAME
dpmidif - dense polynomial over modular integers difference, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dpmidif(r, M, P1, P2)
single r;
int M;
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B M
is an integer number, M > 0.
.TP 4
.B P1, P2
are dense polynomials in r variables over Z/(M*Z).
.PP
dpmidif returns the polynomial P3, where
.IP
P3 = P1 - P2.

M*/

/*H
	Version 1 	13.08.91	J.Schmitt
   DATE dpmidif       : 910915
H*/

#include <_pol1.h>

pol dpmidif(r,m,P1,P2)
single r;
int m;
pol P1, P2;
{
	single e, e1, e2;
	pol P3, k1, k2;
	bind(m,P1,P2);
	init(P3,k1,k2);

/* P1 gleich 0 */

	if (!P1) P3 = dpmineg(r,m,P2);

/* P2 gleich 0 */

	else if (!P2) P3 = P1;

/* r gleich 0 */

	else if (!r) P3 = midif(m,P1,P2);

/* r,P1,P2 ungleich 0 */

	else {
		r--;
		P3 = _0;
		e1 = lfirst(P1);
		P1 = lred(P1);
		e2 = lfirst(P2);
		P2 = lred(P2);
		e = smax(e1,e2);
		if (e1 > e2)
			for (e1 -= e2; e1; e1--) {
				k1 = lfirst(P1);
				P1 = lred(P1);
				P3 = lcomp(k1,P3);
				}
		else if (e2 > e1)
			for (e2 -= e1; e2; e2--) {
				k2 = lfirst(P2);
				P2 =lred(P2);
				if (r) k2 = dpmineg(r,m,k2);
				else k2 = mineg(m,k2);
				P3 = lcomp(k2,P3);
				}
		do {
			k1 = lfirst(P1);
			P1 = lred(P1);
			k2 = lfirst(P2);
			P2 = lred(P2);
			if (!r) k1 = dpmidif(r,m,k1,k2);
			else k1 = midif(m,k1,k2);
			P3 = lcomp(k1,P3);
			}
		while (P1 != _0);
		P3 = linv(P3);
		while (P3 != _0  &&  lfirst(P3) == 0) {
			P3 = lred(P3);
			e--;
			}
		if (P3 == _0) P3 = 0;
		else P3 = lcomp(e,P3);
		}

/* Ausgabe */

	return(P3);
}
