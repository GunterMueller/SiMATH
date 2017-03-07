/*M
.SH NAME
mpmstmrfmsp1 - matrix of polynomials over modular singles to matrix of rational functions over modular single primes, transcendence degree 1

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mpmstmrfmsp1(p, M)
single p;
matrix M;

.SH DESCRIPTION
mpmstmrfmsp1() returns the matrix M of polynomials in one variable over Z/pZ
with all entries converted to rational functions in one variable over Z/pZ.
M*/





/*H
	Version 1       19.06.1989      U. Schneiders, Th. Weis
   DATE mpmstmrfmsp1  : 890801.9109__
H*/


# include <_matr3.h>

matrix mpmstmrfmsp1 (p,  M)
single p;
matrix M;

{
	list ZM, ZL;
	pol a;
	rfunc b;
	matrix L;

	bind (M);
	init (ZL, L, a, b);

	L = _0;

	while (M != _0) {
		ZL = _0;
		ZM = lfirst (M);
		while (ZM != _0) {
			a = lfirst (ZM);
			b = pmstorfmsp1 (p, a);
			ZL = lcomp (b, ZL);
			ZM = lred (ZM);
			}
		ZL = linv (ZL);
		L = lcomp (ZL, L);
		M = lred (M);
		}
	L = linv (L);

/* Ausgabe */

	return (L);
}


