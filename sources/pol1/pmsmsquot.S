/*M
.SH NAME      
pmsmsquot - polynomial over modular singles, modular single quotient, (recursive)
                                                                  
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol pmsmsquot(r, m, P, a) 
single r, m, a; 
pol P;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B m                                                                            
is an integer number, 0 < m < BASIS.                                            
.TP 4                                                                           
.B P                                                                            
is a polynomial in r variables over Z/mZ.       
.TP 4
.B a
is an invertible element of Z/mZ.
.PP
pmsmsquot returns the polynomial P1, where                                      
.IP                                                                             
P1 = P / a.                                                                                            
M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsmsquot     : 890501
H*/


#include <_pol1.h>
 
pol pmsmsquot(r,m,P,a)
single r;
single m;
pol P;
single a;
{
	single e;
	pol P1, k, k1;
	bind(P);
	init3(P1,k,k1);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P1 = msquot(m,P,a);

/* allgemeiner Fall: r,P ungleich 0 */

	else {
		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P =lred(P);
			if (r) k = pmsmsquot(r,m,k,a);
			else k = msquot(m,k,a);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
