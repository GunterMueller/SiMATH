/*M
.SH NAME
pflflprod - polynomial over floating point numbers, floating point number product  

.SH SYNOPSIS
.nf
#include<_pol1.h>

pol pflflprod(r, P, f)
single r;
pol P;
floating f;

.SH DESCRIPTION
pflflprod() returns the polynomial f*P
where P is a polynomial in r variables over floating point numbers
and f is a floating point number.
M*/

/*H
	Version 1       25.01.1995      S.Schmitt
   DATE pflflprod     : 951201
H*/

#include <_pol1.h>
 
pol pflflprod(r,P,a)
single r;
pol P;
floating a;
{
	pol P1;
	bind(P,a);
	init(P1);

/* P oder a gleich 0 */

	if ( !P || !a ) P1 = 0;

/* Anzahl r der Variablen gleich 0 */

	else if ( !r ) P1 = flprod(P,a);

/* allgemeiner Fall: r,P,a ungleich 0 */

	else {
		single e;
		pol k;
		init(k);

		P1 = _0;
		r--;
		do {
			e = lfirst(P);
			P = lred(P);
			k = lfirst(P);
			P = lred(P);
			k = (r) ? (pflflprod(r,k,a)) : (flprod(k,a));
			P1 = lcomp2(k,e,P1);
			}
		while (P != _0);
		P1 = linv(P1);
		}

/* Ausgabe */

	return(P1);
}
