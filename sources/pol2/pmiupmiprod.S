/*M
.SH NAME
pmiupmiprod - polynomial over modular integers, univariate polynomial over modular integers product, (recursive)

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol pmiupmiprod(r, p, P1, P2)  
single r; 
int p; 
pol P1, P2;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B p
is a prime number.
.TP 4
.B P1
is a polynomial in the r variables X1,...,Xr over Z/pZ.
.TP 4
.B P2
is an univariate polynomial in the variable X1 over Z/pZ.
.PP
pmiupmiprod returns the polynomial P3, where
.IP
P3 = P1 * P2.

M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE pmiupmiprod   : 910915
H*/


#include <_pol2.h>

pol pmiupmiprod(r,m,P1,P2)
single r;
int m;
pol P1, P2;
{
	single eP1;
	pol P3, kP1;
	bind(m,P1,P2);
	init(P3,kP1);

/* P1,P2 ungleich 0 */

	if (P1  &&  P2) {
		if (r == 1) P3 = pmiprod(r,m,P1,P2);
		else {
			r--;
			P3 = _0;
			while (P1 != _0) {
				eP1 = lfirst(P1);
				P1 = lred(P1);
				kP1 = lfirst(P1);
				P1 =lred(P1);
				kP1 = pmiupmiprod(r,m,kP1,P2);
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
