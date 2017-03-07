/*M
.SH NAME
prtorfr - polynomial over the rationals to rational function over the rationals

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc prtorfr(r, P) 
single r; 
pol P;
    
.SH DESCRIPTION
.TP 4
.B r
is an integral number, 0<= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the rational numbers.
.PP
prtorfr returns the polynomial P as a rational function over the rational numbers.
                                                                                                             
M*/
                     
/*H
	Version 1       08.02.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE prtorfr       : 890501
H*/


#include <_arith3.h>

rfunc prtorfr(r,P)
single r;
pol P;
{
	pol R=0;
	bind(P,R);

/* P ungleich 0 */

	if (P) {

/* r gleich 0 */

		if (!r) R = P;

/* allgemeiner Fall */

		else {
			P = prnumden(r,P,&R);
			R = pvinsert(0,R,r);
			R = list2(P,R);
			}
		}

/* Ausgabe */

	return(R);
}
