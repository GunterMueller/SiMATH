/*M
.SH NAME
udpmi - univariate dense polynomial over modular integers negation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpmineg(m, P)  
int m; 
pol P;

.SH DESCRIPTION
.TP 4
.B m
is an integer number, m > 0.                                                    
.TP 4                                                                           
.B P                                                                            
is an univariate dense polynomial over Z/mZ.            
.PP
udpmineg returns the polynomial P1, where                                       
.IP                                                                             
P1 = - P.                                                                       
                                     
M*/

/*H
	Version 1 	16.08.91	J.Schmitt
   DATE udpmineg      : 910915
H*/

#include <_pol1.h>

pol udpmineg(m,P)
int m;
pol P;
{
	int k;
	pol P1;
	bind(m,P);
	init(k,P1);

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
			k = mineg(m,k);
			P1 = lcomp(k,P1);
		} while (P != _0);
		P1 = linv(P1);
	}

/* Ausgabe */

	return(P1);
}
