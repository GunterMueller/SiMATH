/*M
.SH NAME
mapitomapmi - matrix of polynomials over integers to matrix of polynomials over modular integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapitomapmi(r, M, m)
single r;
matrix M;
int m;

.SH DESCRIPTION
mapitomapmi() returns the matrix M with all entries converted to
polynomials in r variables over Z/mZ.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over integers.
M*/
/*H
	Version 1       25.10.1989      U. Schneiders/C.Hollinger
   DATE mapitomapmi   : 891101.9311__
H*/


# include <_matr1.h>

matrix mapitomapmi (r, M, m)
single r;
matrix M;
int m;

{
	list ZM, ZL;
	pol a, b;
	matrix L;

	bind ( M,m );
	init( ZM, ZL, L, a, b);

	L = _0;

	while (M != _0) {
		ZL = _0;
		ZM = lfirst (M);
		while (ZM != _0) {
			a = lfirst (ZM);
			b = pitopmi (r, a, m);
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
