/*M
.SH NAME
rfrcons - rational function over the rationals construction

.SH SYNOPSIS
.nf
#include<_arith3.h>

rfunc rfrcons(r, P1, P2) 
single r; 
pol P1, P2;
  
.SH DESCRIPTION
.TP 4
.B r 
is an integer number, 0 <= r < BASIS.
.TP 4
.B P1, P2
are polynomials in r variables over Z, P2 != 0.
.PP
rfrcons returns a rational function, say R, where R is the fraction P1/P2 in its lowest terms.

M*/
             
/*H
	Version 1       31.01.1988      B. Weis
	Version 2       07.10.1988      rfunc eingefuehrt
					J.Schmitt
   DATE rfrcons       : 890501
H*/


#include <_arith3.h>

rfunc rfrcons(r,P1,P2)
single r;
pol P1, P2;
{
	bind(P1,P2);

/* P1 ungleich 0 */

	if (P1) {

/* r gleich 0 */

		if (!r) P1 = rcons(P1,P2);

/* allgemeiner Fall */

		else {
			pigcdcf(r,P1,P2,&P1,&P2);
			if (pisign(r,P2) == -1) {
				P1 = pineg(r,P1);
				P2 = pineg(r,P2);
				}
			P1 = list2(P1,P2);
			}
		}

/* Ausgabe */

	return(P1);
}
