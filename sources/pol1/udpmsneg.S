/*M
.SH NAME
udpmsneg - univariate dense polynomial over modular singles negation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmsneg(m, P) 
single m; 
pol P;

.SH DESCRIPTION
.TP 4
.B m 
is an integer number, 0 < m < BASIS. 
.TP 4                                                                           
.B P                                                                            
is an univariate dense polynomial over Z/mZ.  
.PP
udpmsneg returns the polynomial P1, where                                       
.IP                                                                             
P1 = - P.                                                                       
         
M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE udpmsneg      : 890501
H*/


#include <_pol1.h>

pol udpmsneg(m,P)
single m;
pol P;
{
	single k;
	pol P1;
	bind(P);
	init(P1);

/* P gleich 0 */

	if (!P) P1 = 0;

/* P ungleich 0 */

	else {
		k = lfirst(P);
		P = lred(P);
		P1 = list1(k);
		do {
			k = lfirst(P);
			P = lred(P);
			k = msneg(m,k);
			P1 = lcomp(k,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
