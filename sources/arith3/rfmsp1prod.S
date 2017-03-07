/*M
.SH NAME
rfmsp1prod - rational function over modular single prime product, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfmsp1prod(p, R1, R2) 
single p; 
rfunc R1, R2;
   
.SH DESCRIPTION
.TP 4
.B p
is a prime number, p < BASIS.
.TP 4
.B R1,R2
are elements in the rational function field in one variable over Z/pZ.
.PP
rfmsp1prod returns a rational function, say R, where
.IP
R = R1 * R2.
           
M*/
       
/*H
	Version 1       18.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfmsp1prod    : 890501
H*/


#include <_arith3.h>

rfunc rfmsp1prod(p,R1,R2)
single p;
rfunc R1, R2;
{
	pol R3, Z1, Z2;
	bind(R1,R2);
	init(R3,Z1,Z2);

/* R1 oder R2 gleich 0 */

	if (!R1  || !R2) R3 = 0;

/* allgemeiner Fall */

	else {
		Z1 = lfirst(R1);
		R1 = lsecond(R1);
		Z2 = lfirst(R2);
		R2 = lsecond(R2);
		R3 = upmsgcd(p,Z1,R2);
		Z1 = pmsquot(1,p,Z1,R3);
		R2 = pmsquot(1,p,R2,R3);
		R3 = upmsgcd(p,Z2,R1);
		Z2 = pmsquot(1,p,Z2,R3);
		R1 = pmsquot(1,p,R1,R3);
		Z2 = pmsprod(1,p,Z1,Z2);
		R2 = pmsprod(1,p,R1,R2);
		R3 = list2(Z2,R2);
		}

/* Ausgabe */

	return(R3);
}
