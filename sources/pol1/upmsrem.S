/*M
.SH NAME
upmsrem - univariate polynomial over modular singles remainder

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol upmsrem( m, P1, P2) 
single m; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B m
is a prime number, 0 < m <= BASIS.
.TP 4
.B P1, P2
are univariate polynomials over Z/mZ, P2 != 0.
.PP
upmsrem returns the remainder on dividing P1 by P2.

M*/

/*H
	Version 1       15.06.1987      B. Weis
   DATE upmsrem       : 890501
H*/


#include <_pol1.h>

pol upmsrem(m,P1,P2)
single m;
pol P1, P2;
{
	single e2, e2s, d, k3, k2s, fk2;
	pol P3, P3S, P2S, H;
	bind2(P1,P2);
	init(P3);

	P3 = P1;
	e2 = lfirst(P2);

/* Grad(P1) groesser gleich Grad(P2) */

	if (P3  &&  lfirst(P3) >= e2) {
		if (llength(P2) == 2) {
			do {P3 = lred2(P3);} while (P3 != _0  &&  lfirst(P3) >= e2);
			}
		else {
			P2 = lred(P2);
			fk2 = msinv(m,lfirst(P2));
			P2 = lred(P2);
			P3 = lcinv(P3);
			P3 = linv(P3);
			while (P3 != _0  &&  lfirst(P3) >= e2) {
				d = lfirst(P3)-e2;
				P3 = lred(P3);
				k3 = msprod(m,lfirst(P3),fk2);
				P3S = P3;
				P2S = P2;
				while (P2S != _0) {
					e2s = lfirst(P2S)+d;
					P2S = lred(P2S);
					k2s = lfirst(P2S);
					P2S = lred(P2S);
					while (lred(P3S) != _0  &&  lsecond(P3S) > e2s) P3S = lred2(P3S);
					if (lred(P3S) != _0  &&  lsecond(P3S) == e2s) {
						H = lthird(P3S);
						k2s = msdif(m,H,msprod(m,k2s,k3));
						if (k2s) {P3S = lred2(P3S); lsfirst(P3S,k2s);}
						else {H = lred3(P3S); lsred(P3S,H);}
						}
					else {
						H = msneg(m,msprod(m,k2s,k3));
						H = lcomp2(e2s,H,lred(P3S));
						lsred(P3S,H);
						P3S = lred2(P3S);
						}
					}
				P3 = lred(P3);
				}
			}
		if (P3 == _0) P3 = 0;
		}

/* Ausgabe */

	return(P3);
}
