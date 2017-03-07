/*M
.SH NAME           
pineg - polynomial over integers negation, (recursive)
                                                             
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>

pol pineg(r, P) 
single r; 
pol P;
                                                                       
.SH DESCRIPTION 
.TP 4                                                                           
.B r                                                                            
is an integer, 0 <= r < BASIS.            
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
pineg returns the polynomial P1, where 
.IP
P1 = - P.
                                                                
M*/  

/*H
	Version 1	31.05.1987      B. Weis
   DATE pineg         : 890501
H*/


#include <_pol1.h>

pol pineg(r,P)
single r;
pol P;
{
	single e;
	pol P1, k;
	bind(P);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P1 = ineg(P);

/* allgemeiner Fall: r,P ungleich 0 */

	else {
		r--;
		P1 = _0;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			if (r) k = pineg(r,k);
			else k = ineg(k);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
