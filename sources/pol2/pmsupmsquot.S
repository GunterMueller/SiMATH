/*M
.SH NAME
pmsupmsquot - polynomial over modular singles, univariate polynomial over modular singles quotient, (recursive)
 
.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmsupmsquot(r, p, P1, P2) 
single r, p; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 1 < r < BASIS.
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B P1
is a polynomial in the r variables X1,...,Xr over Z/pZ.
.TP 4
.B P2
is an univariate polynomial in the variable X1 over Z/pZ, P2 divides P1.
.PP                                                               
pmsupmsquot returns the polynomial P3, where 
.IP
P3 = P1 / P2.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsupmsquot   : 890501.9011__
H*/


#include <_pol2.h>

pol pmsupmsquot(r,m,P1,P2)
single r;
single m;
pol P1, P2;
{
	single eP1;
	pol P3, kP1;
	bind2(P1,P2);
	init2(P3,kP1);

/* P1 ungleich 0 */

	if (P1) {
		r--;
		P3 = _0;
		while (P1 != _0) {
			eP1 = lfirst(P1);
			P1 = lred(P1);
			kP1 = lfirst(P1);
			P1 =lred(P1);
			if (r == 1) kP1 = pmsquot(r,m,kP1,P2);
			else kP1 = pmsupmsquot(r,m,kP1,P2);
			P3 = lcomp2(kP1,eP1,P3);
			}
		P3 = linv(P3);
		}

/* P1 gleich 0 */

	else P3 = 0;

/* Ausgabe */

	return(P3);
}
