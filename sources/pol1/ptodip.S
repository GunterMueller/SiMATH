/*M
.SH NAME
ptodip - polynomial to distributive polynomial, (recursive)

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol ptodip(r, P)  
single r; 
pol P;
   
.SH DESCRIPTION
.TP 4
.B r
is an integer number, 0 <= r < BASIS.
.TP 4
.B P
is a polynomial in r variables.
.PP
ptodip returns the polynomial P in distributive representation.

M*/

/*H
	Version 1       20.11.1987      B. Weis
   DATE ptodip        : 890501.9211__
H*/


#include <_pol1.h>

pol ptodip(r,P)
single r;
pol P;
{
	single e;
	list E;
	pol P1, P1S, k;
	bind(P);
	init4(E,P1,P1S,k);

/* r oder P gleich 0 */

	if (!r  ||  !P) P1 = P;

/* r gleich 1 */

	else if (r == 1) {
		P1 = _0;
		while (P != _0) {
			e = lfirst(P);
			P = lred(P);
			P1S = lfirst(P);
			P = lred(P);
			E = list1(e);
			P1 = lcomp2(E,P1S,P1);
			}
		P1 = linv(P1);
		}

/* r groesser 1 */

	else {
		r--;
		P1 = _0;
		while (P != _0) {
			e = lfirst(P);
			P = lred(P);
			P1S = lfirst(P);
			P = lred(P);
			P1S = ptodip(r,P1S);
			while (P1S != _0) {
				k = lfirst(P1S);
				P1S = lred(P1S);
				E = lfirst(P1S);
				P1S = lred(P1S);
				E = lcomp(e,E);
				P1 = lcomp2(E,k,P1);
				}
			}
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
