/*M
.SH NAME
pmsprod - polynomial over modular singles product, (recursive)
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmsprod(r, m, P1, P2) 
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
are polynomials in r variables over Z/mZ.
.PP
pmsprod returns the polynomial P3, where                                        
.IP                                                                             
P3 = P1 * P2.  
                                                                  
M*/                                                                             
        
/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsprod       : 890501
H*/


#include <_pol1.h>

pol pmsprod(r,m,P1,P2)
single r;
single m;
pol P1, P2;
{
	single e1, e2, rs;
	pol P1S, P3, P3S, k1, k2;
	bind2(P1,P2);
	init4(P3,P3S,k1,k2);

/* P1 oder P2 gleich 0 */

	if (P1 == 0  ||  P2 == 0) P3 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P3 = msprod(m,P1,P2);

/* allgemeiner Fall: r,P1,P2 ungleich 0 */

	else {
		P1 = lcinv(P1);
		P2 = lcinv(P2);
		P3 = 0;
		rs = r-1;
		do {
			k2 = lfirst(P2);
			P2 = lred(P2);
			e2 = lfirst(P2);
			P2 = lred(P2);
			P1S = P1;
			P3S = _0;
			do {
				k1 = lfirst(P1S);
				P1S = lred(P1S);
				e1 = lfirst(P1S);
				P1S = lred(P1S);
				if (rs) k1 = pmsprod(rs,m,k1,k2);
				else k1 = msprod(m,k1,k2);
				if (k1) P3S = lcomp2(e1+e2,k1,P3S);
				}
			while (P1S != _0);
			if (P3S != _0) P3 = pmssum(r,m,P3,P3S);
			}
		while (P2 != _0);
		}

/* Ausgabe */

	return(P3);
}
