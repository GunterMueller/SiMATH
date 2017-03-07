/*M
.SH NAME
rfmsp1quot - rational function over modular single prime quotient, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfmsp1quot(p, R1, R2) 
single p; 
rfunc R1, R2;
 
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B R1,R2
are elements in the rational function field in one variable over Z/pZ, R2 != 0.
.PP
rfmsp1quot returns a rational function, say R, where
.IP
R = R1/R2.
     
M*/
                 
/*H
	Version 1       18.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfmsp1quot    : 890501
H*/


#include <_arith3.h>

rfunc rfmsp1quot(p,R1,R2)
single p;
rfunc R1, R2;
{
	bind(R1,R2);

	R2 = rfmsp1inv(p,R2);
	R2 = rfmsp1prod(p,R1,R2);

/* Ausgabe */

	return(R2);
}
