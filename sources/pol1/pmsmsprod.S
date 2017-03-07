/*M
.SH NAME  
pmsmsprod - polynomial over modular singles, modular single product                                                                      
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
                                                                                
pol pmsmsprod(r, m, P, a) 
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
is element of Z/mZ.
.PP
pmsmsprod returns the polynomial P1, where                                      
.IP                                                                             
P1 = a * P.                                                                                        
M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
   DATE pmsmsprod     : 890501
H*/


#include <_pol1.h>
 
pol pmsmsprod(r,m,P,a)
single r;
single m;
pol P;
single a;
{
	single e;
	pol P1, k;
	bind(P);
	init2(P1,k);

/* P oder a gleich 0 */

	if (P == 0  ||  a == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P1 = msprod(m,P,a);

/* allgemeiner Fall: r,P,a ungleich 0 */

	else {
		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P =lred(P);
			if (r) k = pmsmsprod(r,m,k,a);
			else k = msprod(m,k,a);
			if (k) P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		if (P1 == _0) P1 = 0;
		else P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
