/*M
.SH NAME
udpineg - univariate dense polynomial over integers negation

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol udpineg(P)  
pol P;

.SH DESCRIPTION

.TP 4
.B P
is an univariate dense polynomial over the integer numbers.         
.PP
udpineg returns the polynomial P1, where
.IP
P1 = - P.

M*/

/*H
	Version 1       27.07.1988      Pascale Serf
   DATE udpineg       : 890501
H*/


# include <_pol1.h>

pol udpineg(P)
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
			k = ineg(k);
			P1 = lcomp(k,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
