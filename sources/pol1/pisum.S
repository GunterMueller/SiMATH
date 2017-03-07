/*M
.SH NAME
pisum - polynomial over integers sum, (recursive)                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>

pol pisum(r, P1, P2) 
single r; 
pol P1, P2;                                                                       
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer, 0 <= r < BASIS.     
.TP 4
.B P1, P2
are polynomials in r variables over the integer numbers.
.PP
pisum returns the polynomial P3, where 
.IP
P3 = P1 + P2.
                                                                 
M*/   

/*H
	Version 1	31.05.1987      B. Weis
   DATE pisum         : 890501
H*/


#include <_pol1.h>

pol pisum(r,P1,P2)
single r;
pol P1, P2;
{
	single e1, e2;
	pol P3, k1, k2;
	bind2(P1,P2);
	init3(P3,k1,k2);

/* P1 oder P2 gleich 0 */

	if (P1 == 0) P3 = P2;
	else if (P2 == 0) P3 = P1;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P3 = isum(P1,P2);

/* allgemeiner Fall: r,P1,P2 ungleich 0 */

	else {
		P3 = _0;
		r--;
		do {
			e1 = lfirst(P1);
			e2 = lfirst(P2);
			if (e1 > e2) {
				P1 = lred(P1);
				k1 =lfirst(P1);
				P1 = lred(P1);
				P3 = lcomp2(k1,e1,P3);
				}
			else {
				if (e1 < e2) {
					P2 = lred(P2);
					k2 = lfirst(P2);
					P2 = lred(P2);
					P3 = lcomp2(k2,e2,P3);
					}
				else {
					P1 = lred(P1);
					P2 = lred(P2);
					k1 = lfirst(P1);
					k2 = lfirst(P2);
					P1 = lred(P1);
					P2 = lred(P2);
					if (r) k1 = pisum(r,k1,k2);
					else k1 = isum(k1,k2);
					if (k1) P3 = lcomp2(k1,e1,P3);
					}
				}
			}
		while (P1 != _0  &&  P2 != _0);
		if (P1 == _0) P1 = P2;
		if (P3 == _0) P3 = P1;
		else {
			P2 = P3;
			P3 = linv(P2);
			lsred(P2,P1);
			}
		if (P3 == _0) P3 = 0;
		}

/* Ausgabe */

	return(P3);
}
