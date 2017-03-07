/*M
.SH NAME
udpmiprod - univariate dense polynomial over modular integers product

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmiprod(m, P1, P2)  
int m; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B m
is an integer number, m > 0.                  
.TP 4                                                                           
.B P1, P2                                                                       
are univariate dense polynomials over Z/mZ.
.PP
udpmiprod returns the polynomial P3, where                                      
.IP                                                                             
P3 = P1 * P2.                                                                   
                                                         
M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE udpmiprod     : 910915
H*/

#include <_pol1.h>

pol udpmiprod(m,P1,P2)
int m;
pol P1, P2;
{
	single e1, e2, e3;
	pol P3, P3S, P3SS, k1, k2, P1S;
	bind(m,P1,P2);
	init(P3);

/* P1 oder P2 gleich 0 */

	if (P1 == 0  ||  P2 == 0) P3 = 0;

/* allgemeiner Fall: P1,P2 ungleich 0 */

	else {
		e1 = lfirst(P1);
		P1 = lred(P1);
		e2 = lfirst(P2);
		P2 = lred(P2);
		e3 = e1 + e2;
		P3 = list1(0);
		while (e3) {
			e3--;
			P3 = lcomp(0,P3);
		}
		e3 = e1 + e2;
		P3S = P3;
		while (P2 != _0) {
			P3SS = P3S;
			P1S = P1;
			k2 = lfirst(P2);
			P2 = lred(P2);
			if (k2) {
				while (P1S != _0) {
					k1 = lfirst(P1S);
					P1S = lred(P1S);
					if (k1) {
						k1 = miprod(m,k1,k2);
						k1 = misum(m,k1,lfirst(P3SS));
						lsfirst(P3SS,k1);
					}
					P3SS = lred(P3SS);
				}
			}
			P3S = lred(P3S);
		}
		while (lfirst(P3) == 0) {
			P3 = lred(P3);
			e3--;
		}
		if (P3 == _0) P3 = 0;
		else P3 = lcomp(e3,P3);
	}

/* Ausgabe */

	return(P3);
}
