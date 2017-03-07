/*M
.SH NAME
upmssfp - univariate polynomial over modular singles square-free part

.SH SYNOPSIS
.nf
#include<_pol2.h>

pol upmssfp(p, P) 
single ; 
pol P;

.SH DESCRIPTION
.TP 4                                                                           
.B p                                                                            
is a prime number, p < BASIS.                                                   
.TP 4                                                                           
.B P                                                                            
is an univariate, monic polynomial over Z/pZ,     deg(P) > 0.                   
.PP                                                                             
upmssfp returns the square-free part of P (say P1), i.e.                        
.PP                                                                             
P = P1 * P2^2,  and g.c.d.(P1, P2) = 1.                                         
                                                           
M*/

/*H
	Version 1       03.06.1987      B. Weis
	Version 2       10.12.1987      B. Weis
			Programm verbessert
   DATE upmssfp       : 890501
H*/


#include <_pol2.h>

pol upmssfp(m,P)
single m;
pol P;
{
	list L;
	pol P1;
	bind(P);
	init2(L,P1);

/* Berechnung von P1 */

	L = upmssfact(m,P);
	P1 = list2(0,1);
	while (L != _0) {
		P = lfirst(L);
		L = lred(L);
		if (sodd(lfirst(P))) P1 = pmsprod(1,m,P1,lsecond(P));
		}

/* Ausgabe */

	return(P1);
}
