/*M
.SH NAME
mapitomarfr - matrix of polynomials over integers to matrix of rational functions over the rational numbers

.SH SYNOPSIS
.nf
#include<_matr3.h>

matrix mapitomarfr(r,M)
single r;
matrix M;

.SH DESCRIPTION
mapitomarfr() returns the matrix M with all integer entries converted
to rational functions over the rational numbers.

M*/






/*H
	Version 1       19.06.1989      U. Schneiders, Th. Weis
   DATE mapitomarfr   : 890801.9109__
H*/


# include <_matr3.h>

matrix mapitomarfr (r,  M)
single r;
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
			b = pitorfr (r, a);
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


