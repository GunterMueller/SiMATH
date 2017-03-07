/*M
.SH NAME
dpmsprod - dense polynomial over modular singles product, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol dpmsprod(r, m, P1, P2) 
single r, m; 
pol P1, P2;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B m
is an integer number, 0 < m < BASIS.
.TP 4
.B P1, P2
are dense polynomials in r variables over Z/mZ.           
.PP
dpmsprod returns the polynomial P3, where                                       
.IP                                                                             
P3 = P1 * P2.                                                                   
                    
M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       29.02.1988      B. Weis
			else nach erstem if eingefuehrt
   DATE dpmsprod      : 890501
H*/


#include <_pol1.h>

pol dpmsprod(r,m,P1,P2)
single r;
single m;
pol P1, P2;
{
	single e1, e2, e3;
	pol P1S, P3, P3S, P3SS, k1, k2;
	bind(P1,P2);
	init(P3,k1,k2);

/* P1 oder P2 gleich 0 */

	if (P1 == 0  ||  P2 == 0) P3 = 0;

/* r gleich 0 */

	else if (!r) P3 = msprod(m,P1,P2);

/* r,P1,P2 ungleich 0 */

	else {
		r--;
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
						if (r) {
							k1 = dpmsprod(r,m,k1,k2);
							k1 = dpmssum(r,m,k1,lfirst(P3SS));
							}
						else {
							k1 = msprod(m,k1,k2);
							k1 = mssum(m,k1,lfirst(P3SS));
							}
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
