/*M
.SH NAME      
upmsgcd - univariate polynomial over modular singles greatest common divisor
                                                                  
.SH SYNOPSIS                                                                    
.nf                                                                             
#include<_pol2.h>                                                               
                                                                                
pol upmsgcd(p, P1, P2) 
single p; 
pol P1, P2;                                                                                 
.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.                                                   
.TP 4                                                                           
.B P1, P2
are univariate polynomials over Z/pZ.
.PP
upmsgcd returns the greatest common divisor of P1 and P2.
                                                                               
M*/                                                                             

/*H
	Version 1	31.05.1987      B. Weis
   DATE upmsgcd       : 890501
H*/


#include <_pol2.h>

pol upmsgcd(m,P1,P2)
single m;
pol P1, P2;
{
	pol P3;
	bind2(P1,P2);
	init(P3);

/* P1 gleich 0 */

	if (P1 == 0) P3 = pmsmonic(1,m,P2);

/* P2 gleich 0 */

	else if (P2 == 0) P3 = pmsmonic(1,m,P1);

/* allgemeiner Fall: P1,P2 ungleich 0 */

	else {
		if (lfirst(P1) < lfirst(P2)) {
			P3 = P2;
			P2 = P1;
			P1 = P3;
			}
		do {
			P3 = upmsrem(m,P1,P2);
			P1 = P2;
			P2 = P3;
			}
		while (P2 != 0);
		P3 = pmsmonic(1,m,P1);
		}

/* Ausgabe */

	return(P3);
}
