/*M
.SH NAME
pmspsrem - polynomial over modular singles pseudo remainder

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmspsrem(r, p, P1, P2)
single r;
int p;
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over Z/pZ, P2 != 0.    
.PP
pmspsrem returns the pseudo remainder (say P3) on dividing P1 by P2, i.e.
.PP
for deg(P1) >= deg(P2) let k be the leading coefficient of P2, then
.IP
P3 = (P1 * k^(deg(P1)-deg(P2)+1)) % P2,
.PP
for deg(P1) < deg(P2) is
.IP
P3 = P1.

M*/    
                                                          
/*H
	Version 1	31.05.1987      B. Weis
   DATE pmspsrem      : 890501
H*/


#include <_pol2.h>

pol pmspsrem(r,m,P1,P2)
single r;
single m;
pol P1, P2;
{
	single e1, e2, e3;
	pol P3, P2D, P2S, k3;
	bind(P1,P2);
	init(P3,P2D,P2S,k3);

/* Grad von P2 ist 0 */

	e2 = lfirst(P2);
	if (!e2) P3 = 0;

/* Grad von P2 ist groesser 0 */

	else {
		e1 = pdegree(r,P1);
		P3 = P1;
		P2S = lsecond(P2);
		P2 = pred(r,P2);
		P2S = list2(0,P2S);
		for ( ; e1 >= e2; e1--) {
			if (!P3) break;
			e3 = lfirst(P3);
			if (e3 == e1) {
				k3 = lsecond(P3);
				P3 = pred(r,P3);
				P3 = pmsprod(r,m,P3,P2S);
				P2D = list2(e3-e2,k3);
				P2D = pmsprod(r,m,P2,P2D);
				P3 = pmsdif(r,m,P3,P2D);
				}
			else P3 = pmsprod(r,m,P3,P2S);
			}
		}

/* Ausgabe */

	return(P3);
}
