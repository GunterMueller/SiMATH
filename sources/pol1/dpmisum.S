/*M
.SH NAME           
dpmisum - dense polynomial over modular integers sum, (recursive)                                                             
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol dpmisum(r, M, P1, P2)  
single r; 
int M; 
pol P1, P2;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.
.TP 4                                                                           
.B M                                                                            
is an integer number, M > 0.   
.TP 4                                                                           
.B P1, P2                                                                       
are dense polynomials in r variables over Z/(M*Z).   
.PP
dpmisum returns the polynomial P3, where                                       
.IP                                                                             
P3 = P1 + P2.                                                                             
M*/                                                                             
                   
/*H
	Version 1	25.07.91	J.Schmitt
   DATE dpmisum       : 910915
H*/

#include <_pol1.h>

pol dpmisum(r,M,P1,P2)
single r;
int M;
pol P1, P2;
{
	single e1, e2;
	pol P3, k1, k2;
	bind(M,P1,P2);
	init(P3,k1,k2);

	if (!P1) P3 = P2;
	else if (!P2) P3 = P1;
	else if (!r) P3 = misum(M,P1,P2);
	else {
		r--;
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
			if (r) k1 = dpmisum(r,M,k1,k2);
			else k1 = misum(M,k1,k2);
			P3 = lcomp(k1,P3);
		} while (P1 != _0);
		P3 = linv(P3);
		while (P3 != _0  &&  lfirst(P3) == 0) {
			P3 = lred(P3);
			e1--;
		}
		if (P3 == _0) P3 = 0;
		else P3 = lcomp(e1,P3);
	}

	return(P3);
}
