/*M
.SH NAME
pitorfr - polynomial over integers to rational function over the rationals

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc pitorfr(r,P) 
single r; 
pol P; 

.SH DESCRIPTION
.TP 4
.B r
is an integral number, 0<= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integral numbers.
.PP
pitorfr returns the polynomial P as a rational function over the rational numbers.

M*/
                       
/*H
	Version 1       05.02.1988      B. Weis
	version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE pitorfr       : 890501
H*/


#include <_arith3.h>

rfunc pitorfr(r,P)
single r;
pol P;
{
	pol R=0;
	bind(P);

/* P ungleich 0 */

	if (P) {

/* r gleich 0 */

		if (!r) R = itor(P);

/* allgemeiner Fall */

		else {
			R = pvinsert(0,1,r);
			R = list2(P,R);
			}
		}

/* Ausgabe */

	return(R);
}
