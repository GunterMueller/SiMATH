/*M
.SH NAME
rfrsum - rational function over the rationals sum

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfrsum(r, R1, R2) 
single r; 
rfunc R1, R2;
      
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B R1, R2
are elements in the rational function field in r variables over the rational numbers.
.PP
rfrsum returns a function, say R, where
.IP
R = R1 + R2.

M*/
                             
/*H
	Version 1       31.01.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfrsum        : 890501
H*/


#include <_arith3.h>

rfunc rfrsum(r,R1,R2)
single r;
rfunc R1, R2;
{
	pol G, R3, Z1,Z2;
	bind(R1,R2);
	init(G,R3,Z1,Z2);

/* R1 oder R2 gleich 0 */

	if (!R1) R3 = R2;
	else if (!R2) R3 = R1;

/* r gleich 0 */

	else if (!r) R3 = rsum(R1,R2);

/* allgemeiner Fall */

	else {
		Z1 = lfirst(R1);
		R1 = lsecond(R1);
		Z2 = lfirst(R2);
		R2 = lsecond(R2);
		G = pigcdcf(r,R1,R2,&R1,&R3);
		Z1 = piprod(r,Z1,R3);
		Z2 = piprod(r,Z2,R1);
		Z1 = pisum(r,Z1,Z2);
		if (!Z1) R3 = 0;
		else {
			G = pigcdcf(r,Z1,G,&Z1,&R3);
			R3 = piquot(r,R2,G);
			R3 = piprod(r,R3,R1);
			R3 = list2(Z1,R3);
			}
		}

/* Ausgabe */

	return(R3);
}
