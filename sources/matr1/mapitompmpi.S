/*M
.SH NAME
mapitompmpi - matrix of polynomials over integers to matrix of polynomials modulo polynomial over integers

.SH SYNOPSIS
.nf
#include<_matr1.h>

matrix mapitompmpi(r, M, P)
single r;
matrix M;
pol P;

.SH DESCRIPTION
mapitompmpi() returns the matrix M with all entries
reduced modulo P.

.PP
.TP 4
.B M
is a matrix of polynomials in r variables over integers.
.TP 4
.B P
is a polynomial in r variables over integers.
M*/
/*H
	Version 1       25.10.1989      U. Schneiders/C.Hollinger
   DATE mapitompmpi   : 891101.9211__.9311__
H*/

# include <_matr1.h>

matrix mapitompmpi( r, M, P )
single r;
matrix M;
pol P;

{
	list ZM, ZL;
	pol a, b;
	matrix L;

	bind ( M,P );
	init( ZM, ZL, L, a, b);

	/*** M = ( aij ), Modulorechnung fuer aij ***/

	L = _0;
	while (M != _0)
	{       ZL = _0;
		ZM = lfirst (M);
		while (ZM != _0)
		{       a = lfirst (ZM);
			a = piqrem( r, a, P, &b );
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
