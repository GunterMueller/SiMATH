/*M
.SH NAME
ppmvprod - polynomial product by power of main variable

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol ppmvprod(r, P, n) 
single r, n; 
pol P;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 < r < BASIS.
.TP 4
.B n 
is an integer number, 0 <= n < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.PP
Let Xr be the main variable of P.          
ppmvprod returns the polynomial P1, where
.PP
P1 = Xr^n * P.
 
M*/

/*H
	Version 1       30.07.1987      B. Weis
	Version 2       25.09.1987      B. Weis
			P = 0 beruecksichtigt
   DATE ppmvprod      : 890501
H*/


#include <_pol1.h>

pol ppmvprod(r,P,n)
single r;
pol P;
single n;
{
	pol P1=0;
	bind2(P,P1);

/* P oder n gleich 0 */

	if (!P  ||  !n) P1 = P;

/* P,n ungleich 0 */

	else {
		P1 = _0;
		while (P != _0) {
			P1 = lcomp(lfirst(P)+n,P1);
			P = lred(P);
			P1 = lcomp(lfirst(P),P1);
			P = lred(P);
			}
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
