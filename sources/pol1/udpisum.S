/*M
.SH NAME
udpisum - univariate dense polynomial over integers sum

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpisum(P1, P2)  
pol P1, P2;

.SH DESCRIPTION
.TP 4                                                                           
.B P1, P2                                                                       
are univariate dense polynomials over the integer numbers .    
.PP
udpisum returns the polynomial P3, where
.IP
P3 = P1 + P2.

M*/

/*H
	Version 1       27.07.1988      Pascale Serf
   DATE udpisum       : 890501
H*/


# include <_pol1.h>

pol udpisum(P1,P2)
pol P1, P2;
{
	single e1, e2, k1, k2;
	pol P3;
	bind2(P1,P2);
	init(P3);

/* P1 gleich 0 */

	if (!P1) P3 = P2;

/* P2 gleich 0 */

	else if (!P2) P3 = P1;

/* P1,P2 ungleich 0 */

	else {
		if (lfirst(P1) >= lfirst(P2)) {
			e1 = lfirst(P1);
			P1 = lred(P1);
			e2 = lfirst(P2);
			P2 = lred(P2);
			}
		else {
			e2 = P1;
			e1 = lfirst(P2);
			P1 = lred(P2);
			P2 = lred(e2);
			e2 = lfirst(e2);
			}
		P3 = _0;
		for (e2 = e1-e2; e2; e2--) {
			k1 = lfirst(P1);
			P1 = lred(P1);
			P3 = lcomp(k1,P3);
			}
		do {
			k1 = lfirst(P1);
			P1 = lred(P1);
			k2 = lfirst(P2);
			P2 = lred(P2);
			k1 = isum(k1,k2);
			P3 = lcomp(k1,P3);
			}
		while (P1 != _0);
		P3 = linv(P3);
		while (P3 != _0  &&  lfirst(P3) == 0) {
			P3 = lred(P3);
			e1--;
			}
		if (P3 == _0) P3 = 0;
		else P3 = lcomp(e1,P3);
		}

/* Ausgabe */

	return(P3);
}
