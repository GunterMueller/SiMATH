/*M
.SH NAME
piiprod - polynomial over integers, integer product (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol piiprod(r, P, A) 
single r; 
pol P; 
int A;

.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables over the integer numbers.
.PP
piiprod returns the polynomial P1, where
.IP
P1 = A * P.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE piiprod       : 890501
H*/


#include <_pol1.h>
 
pol piiprod(r,P,A)
single r;
pol P;
int A;
{
	single e;
	pol P1, k;
	bind2(P,A);
	init2(P1,k);

/* P oder A gleich 0 */

	if (P == 0  ||  A == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P1 = iprod(P,A);

/* allgemeiner Fall: r,P,A ungleich 0 */

	else {
		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P =lred(P);
			if (r) k = piiprod(r,k,A);
			else k = iprod(k,A);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
