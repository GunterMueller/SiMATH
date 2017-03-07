/*M
.SH NAME
rfrprod - rational function over the rationals product

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfrprod(r, R1, R2) 
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
rfrprod returns a function, say R, where
.IP
R = R1 * R2.
                               
M*/
         
/*H
	Version 1       31.01.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfrprod       : 890501
H*/


#include <_arith3.h>

rfunc rfrprod(r,R1,R2)
single r;
rfunc R1, R2;
{
	pol Z1, Z2;
	bind(R1,R2);
	init(Z1,Z2);

/* R1 oder R2 gleich 0 */

	if (!R1  || !R2) R2 = 0;

/* allgemeiner Fall */

	else {
		Z1 = lfirst(R1);
		R1 = lsecond(R1);
		Z2 = lfirst(R2);
		R2 = lsecond(R2);
		pigcdcf(r,Z1,R2,&Z1,&R2);
		pigcdcf(r,Z2,R1,&Z2,&R1);
		Z2 = piprod(r,Z1,Z2);
		R2 = piprod(r,R1,R2);
		R2 = list2(Z2,R2);
		}

/* Ausgabe */

	return(R2);
}
