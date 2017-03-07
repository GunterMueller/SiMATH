/*M
.SH NAME
piiquot - polynomial over integers, integer quotient (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol piiquot(r, P, A) 
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
.TP 4
.B A
is an integer number, A != 0, A divides P.
.PP
piiquot returns the polynomial P1, where
.IP
P1 = P / A.

M*/

/*H
	Version 1	31.05.1987      B. Weis
   DATE piiquot       : 890501
H*/


#include <_pol1.h>
 
pol piiquot(r,P,A)
single r;
pol P;
int A;
{
	single e;
	pol P1, k;
	bind2(P,A);
	init2(P1,k);

/* P gleich 0 */

	if (P == 0) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if (r == 0) P1 = iquot(P,A);

/* allgemeiner Fall: r,P ungleich 0 */

	else {
		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P =lred(P);
			if (r) k = piiquot(r,k,A);
			else k = iquot(k,A);
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
