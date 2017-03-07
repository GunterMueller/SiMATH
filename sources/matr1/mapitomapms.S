/*M
.SH NAME
mapitomapms - matrix of polynomials over integers to matrix of polynomials over modular singles

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapitomapms(r, M, m)
single r;
matrix M;
single m;

.SH DESCRIPTION
mapitomapms() returns the matrix M with all entries converted to
polynomials in r variables over Z/mZ.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over integers.
M*/
/*H
	Version 1       20.06.1989      U. Schneiders, Th. Weis
   DATE mapitomapms   : 890801
H*/


# include <_matr1.h>

matrix mapitomapms (r, M, m)
single r;
matrix M;
single m;

{
	list ZM, ZL;
	pol a, b;
	matrix L;

	bind (M);
	init (ZL, L, b);

	L = _0;

	while (M != _0) {
		ZL = _0;
		ZM = lfirst (M);
		while (ZM != _0) {
			a = lfirst (ZM);
			b = pitopms (r, a, m);
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
