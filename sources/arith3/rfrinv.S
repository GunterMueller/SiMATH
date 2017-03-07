/*M
.SH NAME
rfrinv - rational function over the rationals inverse

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfrinv(r, R1) 
single r; 
rfunc R1;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B R1
is an element in the rational function field in r variables over the rational numbers, R1 != 0.
.PP
rfrinv returns a function, say R, where
.IP                                          
R = R1^(-1).

M*/
                              
/*H
	Version 1       31.01.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfrinv        : 890501
H*/


#include <_arith3.h>

rfunc rfrinv(r,R)
single r;
rfunc R;
{
	pol R1;
	bind(R);
	init(R1);

	R1 = lfirst(R);
	R = lsecond(R);
	if (pisign(r,R1) < 0) {
		R1 = pineg(r,R1);
		R = pineg(r,R);
		}
	R1 = list2(R,R1);

/* Ausgabe */

	return(R1);
}
