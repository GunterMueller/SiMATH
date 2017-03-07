/*M
.SH NAME
pmsupmsprod - polynomial over modular singles, univariate polynomial over modular singles product, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmsupmsprod(r, m, P1, P2) 
single r, m; 
pol P1, P2;
 
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.              
.TP 4
.B m
is an integer number, 0 < m < BASIS.
.TP 4
.B P1
is a polynomial in the r variables X1,...,Xr over Z/mZ.
.TP 4
.B P2
is an univariate polynomial in the variable X1 over Z/mZ.
.PP
pmsupmsprod returns the polynomial P3, where
.IP
P3 = P1 * P2.
                                                                 
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsupmsprod   : 890501.8910__.9011__
H*/


#include <_pol2.h>

pol pmsupmsprod(r,m,P1,P2)
single r;
single m;
pol P1, P2;
{
	single eP1;
	pol P3, kP1;
	bind2(P1,P2);
	init2(P3,kP1);

/* P1,P2 ungleich 0 */

	if (P1  &&  P2) {
		if (r == 1) P3 = pmsprod(r,m,P1,P2);
		else {
			r--;
			P3 = _0;
			while (P1 != _0) {
				eP1 = lfirst(P1);
				P1 = lred(P1);
				kP1 = lfirst(P1);
				P1 =lred(P1);
				kP1 = pmsupmsprod(r,m,kP1,P2);
				if (kP1) P3 = lcomp2(kP1,eP1,P3);
				}
			if (P3 == _0) P3 = 0;
			else P3 = linv(P3);
			}
		}

/* P1 oder P2 gleich 0 */

	else P3 = 0;

/* Ausgabe */

	return(P3);
}
