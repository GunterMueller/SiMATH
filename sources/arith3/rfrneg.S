/*M
.SH NAME
rfrneg - rational function over the rationals negation

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfrneg(r, R1) 
single r; 
rfunc R1; 
    
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B R1
is an element in the rational function field in r variables over the rational numbers.
.PP
rfrneg returns a function, say R, where
.IP
R = -R1.                                      

M*/
                   
/*H
	Version 1       31.01.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfrneg        : 890501
H*/


#include <_arith3.h>

rfunc rfrneg(r,R)
single r;
rfunc R;
{
	pol H;
	bind(R);
	init(H);

/* R ungleich 0 */

	if (R) {H = pineg(r,lfirst(R)); R = list2(H,lsecond(R));}

/* Ausgabe */

	return(R);
}
