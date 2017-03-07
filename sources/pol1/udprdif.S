/*M
.SH NAME
udprdif - univariate dense polynomial over rationals difference

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udprdif(P1, P2)  
pol P1, P2;

.SH DESCRIPTION
.TP 4                                                                           
.B P1, P2                                                                       
are univariate dense polynomials over the rational numbers.         
.PP
udprdif returns the polynomial P3, where                                        
.IP                                                                             
P3 = P1 - P2.                                                                   
                 
M*/

/*H
	Version 1       27.07.1988      Pascale Serf
   DATE udprdif       : 890501
H*/



# include <_pol1.h>

pol udprdif(P1,P2)
pol P1, P2;
{
	single e, e1, e2, k1, k2;
	pol P3;
	bind2(P1,P2);
	init(P3);

/* P1 gleich 0 */

	if (!P1) P3 = udprneg(P2);

/* P2 gleich 0 */

	else if (!P2) P3 = P1;

/* P1,P2 ungleich 0 */

	else {
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
				k2 = rneg(k2);
				P3 = lcomp(k2,P3);
				}
		do {
			k1 = lfirst(P1);
			P1 = lred(P1);
			k2 = lfirst(P2);
			P2 = lred(P2);
			k1 = rdif(k1,k2);
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
