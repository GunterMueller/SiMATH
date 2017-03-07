/*M
.SH NAME
rfmsp1sum - rational function over modular single prime sum, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfmsp1sum(p, R1, R2) 
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
rfmsp1sum returns a rational function, say R, where
.IP
R = R1 + R2.
                     
M*/
           
/*H
	Version 1       18.04.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfmsp1sum     : 890501
H*/


#include <_arith3.h>

rfunc rfmsp1sum(p,R1,R2)
single p;
rfunc R1, R2;
{
	pol G, R3, Z1, Z2;
	bind(R1,R2);
	init(G,R3,Z1,Z2);

/* R1 oder R2 gleich 0 */

	if (!R1) R3 = R2;
	else if (!R2) R3 = R1;

/* allgemeiner Fall */

	else {
		Z1 = lfirst(R1);
		R1 = lsecond(R1);
		Z2 = lfirst(R2);
		R2 = lsecond(R2);
		G = upmsgcd(p,R1,R2);
		R1 = pmsquot(1,p,R1,G);
		R3 = pmsquot(1,p,R2,G);
		Z1 = pmsprod(1,p,Z1,R3);
		Z2 = pmsprod(1,p,Z2,R1);
		Z1 = pmssum(1,p,Z1,Z2);
		if (!Z1) R3 = 0;
		else {
			G = upmsgcd(p,Z1,G);
			Z1 = pmsquot(1,p,Z1,G);
			R3 = pmsquot(1,p,R2,G);
			R3 = pmsprod(1,p,R3,R1);
			R3 = list2(Z1,R3);
			}
		}

/* Ausgabe */

	return(R3);
}
