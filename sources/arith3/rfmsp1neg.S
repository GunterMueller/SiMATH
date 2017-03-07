/*M
.SH NAME
rfmsp1neg - rational function over modular single prime negation, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfmsp1neg(p, R1) 
single p; 
rfunc R1;

.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B R1
is an element in the rational function field in one variable over Z/pZ.
.PP
rfmsp1neg returns a rational function, say R, where
.IP
R = -R1.

M*/
          
/*H
	Version 1       18.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfmsp1neg     : 890501
H*/


#include <_arith3.h>

rfunc rfmsp1neg(p,R)
single p;
rfunc R;
{
	bind(R);

/* R ungleich 0 */

	if (R) R = lcomp(pmsneg(1,p,lfirst(R)),lred(R));

/* Ausgabe */

	return(R);
}
