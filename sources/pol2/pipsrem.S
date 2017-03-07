/*M
.SH NAME
pipsrem - polynomial over integers pseudo remainder

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pipsrem(r, P1, P2) 
single r; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4                                                                           
.B P1, P2                                                                       
are polynomials in r variables over the integer numbers. P2 != 0.
.PP
pipsrem returns the pseudo remainder (say P3) on dividing P1 by P2, i.e.
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
   DATE pipsrem       : 890501
H*/


#include <_pol2.h>

pol pipsrem(r,P1,P2)
single r;
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
				P3 = piprod(r,P3,P2S);
				P2D = list2(e3-e2,k3);
				P2D = piprod(r,P2,P2D);
				P3 = pidif(r,P3,P2D);
				}
			else P3 = piprod(r,P3,P2S);
			}
		}

/* Ausgabe */

	return(P3);
}
