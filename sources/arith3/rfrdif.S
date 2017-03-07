/*M
.SH NAME
rfrdif - rational function over the rationals difference

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfrdif(r, R1, R2) 
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
rfrdif returns a function, say R, where
.IP
R = R1 - R2.              

M*/
             
/*H
	Version 1       31.01.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfrdif        : 890501
H*/


#include <_arith3.h>

rfunc rfrdif(r,R1,R2)
single r;
rfunc R1, R2;
{
	bind(R1,R2);

	R2 = rfrneg(r,R2);
	R1 = rfrsum(r,R1,R2);

/* Ausgabe */

	return(R1);
}
