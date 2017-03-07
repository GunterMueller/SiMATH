/*M
.SH NAME
pifcb - polynomial over integers factor coefficient bound

.SH SYNOPSIS
.nf
#include<_pol2.h>

single pifcb(L) 
list L;

.SH DESCRIPTION
Let P be a nonzero polynomial in the r variables X1,...,Xr over the integer numbers.
.TP 4
.B L
is a list consisting of the numbers g1,...,gr, whereat for 1 <= n <= r,
.IP
gn = deg(P) with regard to Xn.
.PP
pifcb returns the nonnegative number b, so that for any dividers P1, ..., Ps of P with P1 * ... * Ps divides P,
.PP
pimaxnorm(r,P1)*...*pimaxnorm(r,Ps) <= 2^b*pimaxnorm(r,P)
.PP
holds.

.SH NOTES
pifcb uses the Gelfond bound.
  
M*/

/*H
	Version 1	31.05.1987      B. Weis
	Version 2       29.03.1988      B. Weis
			Dokumentation korrigiert
   DATE pifcb         : 890501
H*/


#include <_pol2.h>

int pifcb(L)
list L;
{
	single a=0, e;
	int B;
	bind(L);
	init(B);

/* Berechnung von a */

	B = 1;
	do {
		e = lfirst(L);
		L = lred(L);
		if (e) {
			a += e+e-1;
			B = iprod(B,e+1);
			}
		}
	while (L != _0);
	a += ilog2(B);
	a = (a+1)/2;

/* Ausgabe */

	return(a);
}
