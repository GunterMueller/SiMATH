/*M
.SH NAME
dpmineg - dense polynomial over modular integers negation, (recursive)
                                                                        
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol1.h>                                                               
                                                                                
pol dpmineg(r, M, P)  
single r; 
int M; 
pol P;                                                                                
.SH DESCRIPTION
.TP 4                                                                           
.B r                                                                            
is an integer number, 0 <= r < BASIS.                                           
.TP 4                                                                           
.B M                                                                            
is an integer number, M > 0.
.TP 4                                                                           
.B P                                                                            
is a dense polynomial in r variables over Z/(M*Z).
.PP
dpmineg returns the polynomial P1, where                                        
.IP                                                                             
P1 = - P.                                                                                                          
M*/                                                                             
 
/*H
	Version 1 	13.08.91	J.Schmitt
   DATE dpmineg       : 910915
H*/


#include <_pol1.h>

pol dpmineg(r,m,P)
single r;
int m;
pol P;
{
	pol P1, k;
	bind(m,P);
	init(P1,k);

/* P gleich 0 */

	if (!P) P1 = 0;

/* r gleich 0 */

	else if (!r) P1 = mineg(m,P);

/* r,P ungleich 0 */

	else {
		r--;
		k = lfirst(P);
		P = lred(P);
		P1 = list1(k);
		if (r)
			do {
				k = lfirst(P);
				P = lred(P);
				k = dpmineg(r,m,k);
				P1 = lcomp(k,P1);
			} while (P != _0);
		else
			do {
				k = lfirst(P);
				P = lred(P);
				k = mineg(m,k);
				P1 = lcomp(k,P1);
			} while (P != _0);
		P1 = linv(P1);
	}

/* Ausgabe */

	return(P1);
}
